<?php
/**
 * PDT-Pedee ISP Portal - API Helper Functions
 */

function handleCors() {
    $origin = isset($_SERVER['HTTP_ORIGIN']) ? $_SERVER['HTTP_ORIGIN'] : '*';
    header("Access-Control-Allow-Origin: {$origin}");
    header("Access-Control-Allow-Methods: GET, POST, PUT, DELETE, PATCH, OPTIONS");
    header("Access-Control-Allow-Headers: Content-Type, Authorization, X-Requested-With, Cache-Control");
    header("Access-Control-Allow-Credentials: true");
    header("Access-Control-Max-Age: 86400");

    if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
        http_response_code(200);
        exit;
    }
}

function jsonResponse($data, $statusCode = 200) {
    http_response_code($statusCode);
    header('Content-Type: application/json; charset=utf-8');
    echo json_encode($data, JSON_PRETTY_PRINT | JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES);
    exit;
}

function getJsonBody() {
    $raw = file_get_contents('php://input');
    if (!empty($raw)) {
        $data = json_decode($raw, true);
        if (json_last_error() === JSON_ERROR_NONE) {
            return $data;
        }
    }
    return !empty($_POST) ? $_POST : [];
}

function getClientIp() {
    if (!empty($_SERVER['HTTP_X_FORWARDED_FOR'])) {
        $ips = explode(',', $_SERVER['HTTP_X_FORWARDED_FOR']);
        return trim($ips[0]);
    }
    if (!empty($_SERVER['HTTP_CLIENT_IP'])) {
        return $_SERVER['HTTP_CLIENT_IP'];
    }
    return isset($_SERVER['REMOTE_ADDR']) ? $_SERVER['REMOTE_ADDR'] : '127.0.0.1';
}

function logAudit($pdo, $customerId, $action, $actionLabel, $detail, $actor = 'Sistem NOC', $ip = null) {
    if (!$pdo || empty($customerId)) return false;
    if (!$ip) $ip = getClientIp();
    
    try {
        $stmt = $pdo->prepare("INSERT INTO customer_activity_logs (customer_id, action, action_label, detail, actor, ip, created_at) VALUES (?, ?, ?, ?, ?, ?, NOW())");
        return $stmt->execute([$customerId, $action, $actionLabel, $detail, $actor, $ip]);
    } catch (Exception $e) {
        error_log("Failed to log audit: " . $e->getMessage());
        return false;
    }
}

function getCustomerActivityLogs($pdo, $customerId, $limit = 50) {
    if (!$pdo || empty($customerId)) return [];
    try {
        $stmt = $pdo->prepare("SELECT id, customer_id, action, action_label, detail, actor, ip, created_at as timestamp FROM customer_activity_logs WHERE customer_id = ? ORDER BY id DESC LIMIT ?");
        $stmt->bindValue(1, $customerId, PDO::PARAM_STR);
        $stmt->bindValue(2, (int)$limit, PDO::PARAM_INT);
        $stmt->execute();
        return $stmt->fetchAll();
    } catch (Exception $e) {
        error_log("Failed to get activity logs: " . $e->getMessage());
        return [];
    }
}
