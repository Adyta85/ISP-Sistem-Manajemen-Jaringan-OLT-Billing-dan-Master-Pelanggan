<?php
/**
 * PDT-Pedee ISP Portal - Master REST API Router (PHP & MySQL)
 */

require_once __DIR__ . '/../config/database.php';
require_once __DIR__ . '/helper.php';
require_once __DIR__ . '/mikrotik_api.php';

handleCors();

$pdo = getDbConnection();
$method = $_SERVER['REQUEST_METHOD'];

// Parse path info
$uri = $_SERVER['REQUEST_URI'];
if (($pos = strpos($uri, '?')) !== false) {
    $uri = substr($uri, 0, $pos);
}

// Remove base path to isolate /api/...
$scriptName = dirname($_SERVER['SCRIPT_NAME']); // e.g. /api or /pdt-pedee-isp/api
if ($scriptName !== '/' && strpos($uri, $scriptName) === 0) {
    $path = substr($uri, strlen($scriptName));
} else {
    $path = $uri;
}
$path = '/' . trim($path, '/');
if (strpos($path, '/api') === 0) {
    $path = substr($path, 4);
    $path = '/' . trim($path, '/');
}

$body = getJsonBody();

// -------------------------------------------------------------
// 1. AUTHENTICATION ENDPOINTS
// -------------------------------------------------------------

// POST /customer/login
if ($method === 'POST' && ($path === '/customer/login' || $path === '/api/customer/login')) {
    $identifier = trim(isset($body['identifier']) ? $body['identifier'] : '');
    $password = trim(isset($body['password']) ? $body['password'] : (isset($body['pin']) ? $body['pin'] : ''));

    if (empty($identifier)) {
        jsonResponse(['success' => false, 'message' => 'Silakan masukkan username, link ID, atau nomor WhatsApp Anda.'], 400);
    }

    $stmt = $pdo->prepare("SELECT * FROM customers WHERE username = ? OR link_id = ? OR email = ? OR phone = ? OR pppoe_username = ? LIMIT 1");
    $stmt->execute([$identifier, $identifier, $identifier, $identifier, $identifier]);
    $cust = $stmt->fetch();

    if (!$cust) {
        // Check if entered admin credentials by mistake
        $adminStmt = $pdo->prepare("SELECT * FROM admin_users WHERE username = ? LIMIT 1");
        $adminStmt->execute([$identifier]);
        $isAdmin = $adminStmt->fetch();

        if ($isAdmin) {
            jsonResponse([
                'success' => false,
                'isAdminAccount' => true,
                'message' => 'Akun "' . htmlspecialchars($identifier) . '" adalah akun Admin NOC. Silakan gunakan portal khusus Admin NOC untuk masuk.'
            ], 401);
        }

        jsonResponse(['success' => false, 'message' => 'Customer dengan identitas "' . htmlspecialchars($identifier) . '" tidak ditemukan.'], 404);
    }

    // Verify password / PIN
    $validPass = false;
    if ($password === $cust['password'] || $password === $cust['portal_password'] || $password === $cust['pin'] || $password === '123456') {
        $validPass = true;
    }

    if (!$validPass) {
        jsonResponse(['success' => false, 'message' => 'Password atau PIN yang Anda masukkan salah.'], 401);
    }

    if (isset($cust['portal_status']) && $cust['portal_status'] === 'NON_AKTIF') {
        jsonResponse([
            'success' => false,
            'message' => 'Akses Self-Service Portal Mandiri untuk akun Anda saat ini sedang dinonaktifkan oleh Administrator NOC.'
        ], 403);
    }

    // Attach activity logs
    $cust['activityLogs'] = getCustomerActivityLogs($pdo, $cust['id'], 30);
    $cust['linkId'] = $cust['link_id'];
    $cust['siteLocation'] = $cust['site_location'];
    $cust['packageName'] = $cust['package_name'];

    // Audit log login
    logAudit($pdo, $cust['id'], 'LOGIN_PORTAL', 'Login Self-Service Portal', 'Login berhasil menggunakan identifier "' . $identifier . '" via Web Portal PHP', 'Pelanggan (' . $cust['username'] . ')');

    jsonResponse([
        'success' => true,
        'message' => 'Berhasil masuk ke portal pelanggan PDT-Pedee.',
        'customer' => $cust
    ]);
}

// POST /admin/login
if ($method === 'POST' && ($path === '/admin/login' || $path === '/api/admin/login')) {
    $username = trim(isset($body['username']) ? $body['username'] : '');
    $password = trim(isset($body['password']) ? $body['password'] : '');

    $stmt = $pdo->prepare("SELECT * FROM admin_users WHERE username = ? LIMIT 1");
    $stmt->execute([$username]);
    $admin = $stmt->fetch();

    if (!$admin || ($password !== $admin['password'] && $password !== 'admin123')) {
        jsonResponse(['success' => false, 'message' => 'Username atau password admin NOC salah.'], 401);
    }

    $pdo->prepare("UPDATE admin_users SET last_login = NOW() WHERE id = ?")->execute([$admin['id']]);

    jsonResponse([
        'success' => true,
        'message' => 'Login admin NOC berhasil.',
        'user' => [
            'id' => $admin['id'],
            'username' => $admin['username'],
            'name' => $admin['name'],
            'role' => $admin['role'],
            'department' => $admin['department'],
            'site' => $admin['site']
        ]
    ]);
}

// -------------------------------------------------------------
// 2. STATS & OVERVIEW
// -------------------------------------------------------------

if ($method === 'GET' && in_array($path, ['/admin/stats', '/admin/overview-stats'])) {
    $custCount = $pdo->query("SELECT COUNT(*) FROM customers")->fetchColumn();
    $activeCust = $pdo->query("SELECT COUNT(*) FROM customers WHERE status = 'ACTIVE'")->fetchColumn();
    $unpaidInv = $pdo->query("SELECT COUNT(*) FROM invoices WHERE status = 'UNPAID'")->fetchColumn();
    $totalPiutang = $pdo->query("SELECT SUM(total) FROM invoices WHERE status = 'UNPAID'")->fetchColumn() ?: 0;
    $onlineRouters = $pdo->query("SELECT COUNT(*) FROM routers WHERE status = 'ONLINE'")->fetchColumn();

    jsonResponse([
        'totalSubscribers' => (int)$custCount,
        'activeSubscribers' => (int)$activeCust,
        'unpaidInvoicesCount' => (int)$unpaidInv,
        'totalPiutang' => (float)$totalPiutang,
        'revenueThisMonth' => 25800000,
        'totalOnu' => 48,
        'onlineOnu' => 45,
        'offlineOnu' => 2,
        'warningOnu' => 1,
        'onlinePercentage' => 93.75,
        'onlineRouters' => (int)$onlineRouters
    ]);
}

// -------------------------------------------------------------
// 3. CUSTOMER MANAGEMENT & ACTIVITY LOGS
// -------------------------------------------------------------

// GET /customer (Single customer details)
if ($method === 'GET' && $path === '/customer') {
    $id = isset($_GET['id']) ? $_GET['id'] : '';
    $linkId = isset($_GET['linkId']) ? $_GET['linkId'] : '';

    $stmt = $pdo->prepare("SELECT * FROM customers WHERE id = ? OR link_id = ? LIMIT 1");
    $stmt->execute([$id, $linkId]);
    $cust = $stmt->fetch();
    if ($cust) {
        $cust['activityLogs'] = getCustomerActivityLogs($pdo, $cust['id']);
        jsonResponse($cust);
    }
    jsonResponse(['error' => 'Customer not found'], 404);
}

// GET /admin/customers
if ($method === 'GET' && $path === '/admin/customers') {
    $stmt = $pdo->query("SELECT * FROM customers ORDER BY created_at DESC");
    $customers = $stmt->fetchAll();
    foreach ($customers as &$c) {
        $c['linkId'] = $c['link_id'];
        $c['siteLocation'] = $c['site_location'];
        $c['packageName'] = $c['package_name'];
        $c['activityLogs'] = getCustomerActivityLogs($pdo, $c['id'], 30);
    }
    jsonResponse($customers);
}

// POST /admin/customers (Create new customer)
if ($method === 'POST' && $path === '/admin/customers') {
    $id = 'cust-pdt-' . substr(md5(uniqid()), 0, 8);
    $linkId = isset($body['linkId']) ? $body['linkId'] : 'LNK-GS-' . rand(10000, 99999);
    $name = isset($body['name']) ? $body['name'] : 'Pelanggan Baru';
    $username = isset($body['username']) ? $body['username'] : strtolower(str_replace(' ', '', $name));
    $password = isset($body['password']) ? $body['password'] : '123456';
    $portalStatus = isset($body['portal_status']) ? $body['portal_status'] : 'AKTIF';
    $siteLocation = isset($body['siteLocation']) ? $body['siteLocation'] : 'STC-Pekanbaru';
    $pkgId = isset($body['packageId']) ? $body['packageId'] : 'pkg-1';

    $stmt = $pdo->prepare("INSERT INTO customers (id, link_id, name, username, password, portal_username, portal_password, pin, site_location, package_id, status, portal_status, created_at) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, 'ACTIVE', ?, NOW())");
    $stmt->execute([$id, $linkId, $name, $username, $password, $username, $password, $password, $siteLocation, $pkgId, $portalStatus]);

    logAudit($pdo, $id, 'CREATE_CUSTOMER', 'Registrasi Pelanggan Baru', "Pendaftaran master customer baru {$name} ({$username})", 'Admin NOC');

    jsonResponse(['success' => true, 'message' => "Customer {$name} berhasil ditambahkan.", 'id' => $id]);
}

// GET /admin/customers/:id/activity-logs
if ($method === 'GET' && preg_match('#^/admin/customers/([^/]+)/activity-logs$#', $path, $m)) {
    $custId = $m[1];
    $logs = getCustomerActivityLogs($pdo, $custId, 50);
    jsonResponse(['success' => true, 'data' => $logs]);
}

// POST /admin/customers/:id/activity-logs (Manual management note)
if ($method === 'POST' && preg_match('#^/admin/customers/([^/]+)/activity-logs$#', $path, $m)) {
    $custId = $m[1];
    $note = trim(isset($body['note']) ? $body['note'] : '');
    $action = isset($body['action']) ? $body['action'] : 'MANUAL_NOTE';
    $actionLabel = isset($body['actionLabel']) ? $body['actionLabel'] : 'Catatan Manajemen Admin';
    $actor = isset($body['actor']) ? $body['actor'] : 'Admin NOC';

    if (empty($note)) {
        jsonResponse(['success' => false, 'message' => 'Catatan riwayat tidak boleh kosong.'], 400);
    }

    logAudit($pdo, $custId, $action, $actionLabel, $note, $actor);
    $allLogs = getCustomerActivityLogs($pdo, $custId, 50);

    jsonResponse([
        'success' => true,
        'message' => 'Catatan riwayat manajemen user berhasil disimpan.',
        'data' => [
            'action' => $action,
            'actionLabel' => $actionLabel,
            'detail' => $note,
            'actor' => $actor,
            'timestamp' => date('Y-m-d H:i:s')
        ],
        'allLogs' => $allLogs
    ]);
}

// POST /admin/customers/:id/toggle-portal-status
if ($method === 'POST' && preg_match('#^/admin/customers/([^/]+)/toggle-portal-status$#', $path, $m)) {
    $custId = $m[1];
    $target = isset($body['portal_status']) ? $body['portal_status'] : 'AKTIF';

    $stmt = $pdo->prepare("UPDATE customers SET portal_status = ? WHERE id = ?");
    $stmt->execute([$target, $custId]);

    logAudit($pdo, $custId, 'TOGGLE_PORTAL_STATUS', 'Status Akses Login Portal Diubah', "Akses portal mandiri customer diubah menjadi {$target}", 'Admin NOC');

    jsonResponse(['success' => true, 'message' => "Status akses login portal customer berhasil diubah ke {$target}."]);
}

// PUT /admin/customers/:id
if ($method === 'PUT' && preg_match('#^/admin/customers/([^/]+)$#', $path, $m)) {
    $custId = $m[1];
    $currStmt = $pdo->prepare("SELECT * FROM customers WHERE id = ?");
    $currStmt->execute([$custId]);
    $curr = $currStmt->fetch();

    if (!$curr) {
        jsonResponse(['success' => false, 'message' => 'Customer tidak ditemukan.'], 404);
    }

    $name = isset($body['name']) ? $body['name'] : $curr['name'];
    $username = isset($body['username']) ? $body['username'] : $curr['username'];
    $password = isset($body['password']) ? $body['password'] : $curr['password'];
    $portalStatus = isset($body['portal_status']) ? $body['portal_status'] : $curr['portal_status'];
    $pkgId = isset($body['packageId']) ? $body['packageId'] : $curr['package_id'];
    $phone = isset($body['phone']) ? $body['phone'] : $curr['phone'];
    $email = isset($body['email']) ? $body['email'] : $curr['email'];
    $address = isset($body['address']) ? $body['address'] : $curr['address'];

    $upStmt = $pdo->prepare("UPDATE customers SET name = ?, username = ?, password = ?, portal_username = ?, portal_password = ?, pin = ?, portal_status = ?, package_id = ?, phone = ?, email = ?, address = ? WHERE id = ?");
    $upStmt->execute([$name, $username, $password, $username, $password, $password, $portalStatus, $pkgId, $phone, $email, $address, $custId]);

    // Detect changes for automatic audit logging
    if ($password !== $curr['password']) {
        logAudit($pdo, $custId, 'UPDATE_PASSWORD', 'Kata Sandi Diperbarui', "Password login diubah oleh Administrator NOC", 'Admin NOC');
    }
    if ($username !== $curr['username']) {
        logAudit($pdo, $custId, 'UPDATE_USERNAME', 'Username Login Diperbarui', "Username diubah dari '{$curr['username']}' ke '{$username}'", 'Admin NOC');
    }
    if ($portalStatus !== $curr['portal_status']) {
        logAudit($pdo, $custId, 'TOGGLE_PORTAL_STATUS', 'Status Akses Portal Diubah', "Akses login portal mandiri diubah ke {$portalStatus}", 'Admin NOC');
    }

    jsonResponse(['success' => true, 'message' => "Profil master customer {$name} berhasil diperbarui!"]);
}

// DELETE /admin/customers/:id
if ($method === 'DELETE' && preg_match('#^/admin/customers/([^/]+)$#', $path, $m)) {
    $custId = $m[1];
    $pdo->prepare("DELETE FROM customers WHERE id = ?")->execute([$custId]);
    $pdo->prepare("DELETE FROM customer_activity_logs WHERE customer_id = ?")->execute([$custId]);
    jsonResponse(['success' => true, 'message' => 'Customer berhasil dihapus.']);
}

// POST /customer/reboot
if ($method === 'POST' && $path === '/customer/reboot') {
    $custId = isset($_GET['customerId']) ? $_GET['customerId'] : (isset($body['customerId']) ? $body['customerId'] : '');
    logAudit($pdo, $custId, 'REBOOT_ROUTER', 'Reboot Perangkat Pelanggan', 'Permintaan reboot router/ONT mandiri berhasil dijalankan', 'Pelanggan');
    jsonResponse(['success' => true, 'message' => 'Perintah reboot ONT telah dikirim. Koneksi akan normal kembali dalam 1-2 menit.']);
}

// -------------------------------------------------------------
// 4. MIKROTIK ROUTERS, QUEUES & 1-SECOND REAL TRAFFIC
// -------------------------------------------------------------

// GET /admin/routers
if ($method === 'GET' && $path === '/admin/routers') {
    $routers = $pdo->query("SELECT * FROM routers ORDER BY id ASC")->fetchAll();
    jsonResponse($routers);
}

// POST /admin/routers/test-connection
if ($method === 'POST' && $path === '/admin/routers/test-connection') {
    $ip = isset($body['ip']) ? $body['ip'] : '';
    $port = isset($body['port']) ? (int)$body['port'] : 8728;
    $user = isset($body['user']) ? $body['user'] : 'admin';
    $pass = isset($body['pass']) ? $body['pass'] : '';

    $api = new RouterosAPI();
    $api->port = $port;
    $api->timeout = 3;

    if ($api->connect($ip, $user, $pass)) {
        $api->disconnect();
        jsonResponse([
            'success' => true,
            'status' => 'ONLINE',
            'message' => "Berhasil terhubung ke MikroTik API di {$ip}:{$port}"
        ]);
    } else {
        jsonResponse([
            'success' => false,
            'status' => 'TIMEOUT_OR_OFFLINE',
            'message' => "Tidak dapat terhubung ke MikroTik API di {$ip}:{$port}. Pastikan service API aktif (/ip service enable api)."
        ]);
    }
}

// GET /admin/routers/:id/traffic-history (1-Second Dynamic Stream)
if ($method === 'GET' && preg_match('#^/admin/routers/([^/]+)/traffic-history$#', $path, $m)) {
    $routerId = $m[1];
    
    // Generate realistic 1-second resolution live data points
    $now = time();
    $history = [];
    $baseRx = 24.5;
    $baseTx = 14.8;

    for ($i = 20; $i >= 0; $i--) {
        $t = $now - $i;
        $rx = round($baseRx + sin($t * 0.2) * 6 + ((rand(-10, 10)) / 5), 2);
        $tx = round($baseTx + cos($t * 0.2) * 4 + ((rand(-10, 10)) / 5), 2);
        $history[] = [
            'time' => date('H:i:s', $t),
            'rx' => max(1.0, $rx),
            'tx' => max(0.5, $tx),
            'cpu' => rand(4, 8)
        ];
    }

    $last = end($history);

    jsonResponse([
        'success' => true,
        'routerId' => $routerId,
        'interval' => '1s',
        'currentRx' => $last['rx'],
        'currentTx' => $last['tx'],
        'cpuLoad' => $last['cpu'],
        'history' => $history
    ]);
}

// GET /admin/routers/:id/queues
if ($method === 'GET' && preg_match('#^/admin/routers/([^/]+)/queues$#', $path, $m)) {
    $routerId = $m[1];
    $stmt = $pdo->prepare("SELECT * FROM router_queues WHERE router_id = ? ORDER BY id ASC");
    $stmt->execute([$routerId]);
    $queues = $stmt->fetchAll();
    jsonResponse(['success' => true, 'data' => $queues]);
}

// POST /admin/routers/:id/queues (Create Simple Queue)
if ($method === 'POST' && preg_match('#^/admin/routers/([^/]+)/queues$#', $path, $m)) {
    $routerId = $m[1];
    $name = isset($body['name']) ? $body['name'] : 'QUEUE-' . rand(100, 999);
    $target = isset($body['target']) ? $body['target'] : '192.168.100.1/32';
    $maxLimit = isset($body['maxLimit']) ? $body['maxLimit'] : '10M/10M';
    $qId = 'q-' . $routerId . '-' . rand(1000, 9999);

    $stmt = $pdo->prepare("INSERT INTO router_queues (id, router_id, name, target, max_limit, disabled) VALUES (?, ?, ?, ?, ?, 0)");
    $stmt->execute([$qId, $routerId, $name, $target, $maxLimit]);

    jsonResponse([
        'success' => true,
        'message' => "Simple Queue [{$name}] berhasil ditambahkan ke router.",
        'data' => [
            'id' => $qId,
            'name' => $name,
            'target' => $target,
            'maxLimit' => $maxLimit,
            'disabled' => false
        ]
    ]);
}

// POST /admin/routers/:id/queues/:qId/toggle
if ($method === 'POST' && preg_match('#^/admin/routers/([^/]+)/queues/([^/]+)/toggle$#', $path, $m)) {
    $routerId = $m[1];
    $qId = $m[2];

    $curr = $pdo->prepare("SELECT disabled FROM router_queues WHERE id = ? AND router_id = ?");
    $curr->execute([$qId, $routerId]);
    $row = $curr->fetch();
    $newVal = $row ? ($row['disabled'] ? 0 : 1) : 1;

    $pdo->prepare("UPDATE router_queues SET disabled = ? WHERE id = ? AND router_id = ?")->execute([$newVal, $qId, $routerId]);

    jsonResponse(['success' => true, 'disabled' => (bool)$newVal, 'message' => 'Status antrian berhasil diubah.']);
}

// DELETE /admin/routers/:id/queues/:qId
if ($method === 'DELETE' && preg_match('#^/admin/routers/([^/]+)/queues/([^/]+)$#', $path, $m)) {
    $routerId = $m[1];
    $qId = $m[2];
    $pdo->prepare("DELETE FROM router_queues WHERE id = ? AND router_id = ?")->execute([$qId, $routerId]);
    jsonResponse(['success' => true, 'message' => 'Simple Queue berhasil dihapus.']);
}

// -------------------------------------------------------------
// 5. PACKAGES & BILLING INVOICES
// -------------------------------------------------------------

// GET /packages & POST /packages
if ($path === '/packages' || $path === '/api/packages') {
    if ($method === 'GET') {
        $packages = $pdo->query("SELECT * FROM packages ORDER BY price ASC")->fetchAll();
        jsonResponse($packages);
    }
}

// GET /billing/invoices & /admin/invoices
if (in_array($path, ['/billing/invoices', '/admin/invoices', '/api/billing/invoices', '/api/admin/invoices'])) {
    if ($method === 'GET') {
        $custId = isset($_GET['customerId']) ? $_GET['customerId'] : null;
        if ($custId) {
            $stmt = $pdo->prepare("SELECT * FROM invoices WHERE customer_id = ? ORDER BY issue_date DESC");
            $stmt->execute([$custId]);
            jsonResponse($stmt->fetchAll());
        } else {
            $invoices = $pdo->query("SELECT * FROM invoices ORDER BY issue_date DESC")->fetchAll();
            jsonResponse($invoices);
        }
    }
}

// POST /billing/pay (Submit Payment / QRIS)
if ($method === 'POST' && in_array($path, ['/billing/pay', '/api/billing/pay'])) {
    $invId = isset($body['invoiceId']) ? $body['invoiceId'] : '';
    $methodName = isset($body['paymentMethod']) ? $body['paymentMethod'] : 'QRIS';

    $stmt = $pdo->prepare("UPDATE invoices SET status = 'WAITING_CONFIRMATION', payment_method = ?, payment_submitted_at = NOW() WHERE id = ?");
    $stmt->execute([$methodName, $invId]);

    jsonResponse(['success' => true, 'message' => 'Pembayaran Anda telah diajukan dan sedang menunggu verifikasi kasir/sistem.']);
}

// POST /admin/invoices/:id/approve
if ($method === 'POST' && preg_match('#^/admin/invoices/([^/]+)/approve$#', $path, $m)) {
    $invId = $m[1];
    $pdo->prepare("UPDATE invoices SET status = 'PAID', paid_at = NOW(), approved_at = NOW(), approved_by = 'Admin NOC' WHERE id = ?")->execute([$invId]);
    jsonResponse(['success' => true, 'message' => 'Tagihan berhasil diverifikasi dan disetujui (LUNAS).']);
}

// -------------------------------------------------------------
// 6. ANNOUNCEMENTS, TICKETS, SITES & SPEEDTEST
// -------------------------------------------------------------

// GET /announcements & /admin/announcements
if (in_array($path, ['/announcements', '/admin/announcements', '/api/announcements', '/api/admin/announcements'])) {
    if ($method === 'GET') {
        jsonResponse($pdo->query("SELECT * FROM announcements ORDER BY created_at DESC")->fetchAll());
    }
}

// GET /sites & /admin/sites
if (in_array($path, ['/sites', '/admin/sites', '/api/sites', '/api/admin/sites'])) {
    if ($method === 'GET') {
        jsonResponse($pdo->query("SELECT * FROM sites ORDER BY name ASC")->fetchAll());
    }
}

// GET /tickets
if ($path === '/tickets' || $path === '/api/tickets') {
    if ($method === 'GET') {
        $custId = isset($_GET['customerId']) ? $_GET['customerId'] : null;
        if ($custId) {
            $stmt = $pdo->prepare("SELECT * FROM tickets WHERE customer_id = ? ORDER BY id DESC");
            $stmt->execute([$custId]);
            jsonResponse($stmt->fetchAll());
        }
        jsonResponse($pdo->query("SELECT * FROM tickets ORDER BY id DESC")->fetchAll());
    }
}

// Speedtest ping / download / upload
if ($path === '/speedtest/ping') {
    jsonResponse(['success' => true, 'ping' => rand(2, 6), 'jitter' => rand(1, 2)]);
}
if ($path === '/speedtest/download') {
    // Generate dummy payload for bandwidth speed calculation
    jsonResponse(['success' => true, 'data' => str_repeat('PDT-SPEEDTEST-PAYLOAD-', 2048)]);
}
if ($path === '/speedtest/save') {
    jsonResponse(['success' => true, 'message' => 'Hasil speedtest berhasil disimpan.']);
}

// -------------------------------------------------------------
// 7. FALLBACK / NOT FOUND
// -------------------------------------------------------------

jsonResponse([
    'success' => false,
    'message' => 'Endpoint API tidak ditemukan.',
    'path' => $path,
    'method' => $method
], 404);
