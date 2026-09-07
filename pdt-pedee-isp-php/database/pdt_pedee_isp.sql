-- ========================================================
-- PDT-PEDEE ISP MANAGEMENT & SELF-SERVICE PORTAL
-- DATABASE EXPORT & INITIAL SEEDING
-- Target Server: MySQL 5.7+ / MariaDB 10.3+ / MySQL 8.0+
-- Generated At: 2026-09-07T14:51:42.497Z
-- ========================================================

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;
SET SQL_MODE = 'NO_AUTO_VALUE_ON_ZERO';

CREATE DATABASE IF NOT EXISTS `pdt_pedee_isp` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE `pdt_pedee_isp`;

-- --------------------------------------------------------
-- 1. Table structure for table `admin_users`
-- --------------------------------------------------------
DROP TABLE IF EXISTS `admin_users`;
CREATE TABLE `admin_users` (
  `id` varchar(50) NOT NULL,
  `username` varchar(100) NOT NULL UNIQUE,
  `password` varchar(150) NOT NULL,
  `name` varchar(150) NOT NULL,
  `phone` varchar(50) DEFAULT NULL,
  `user_group` varchar(50) DEFAULT 'NOC_ENGINEER',
  `role` varchar(50) DEFAULT 'OPERATOR',
  `department` varchar(100) DEFAULT 'NOC Core Engineering',
  `site` varchar(100) DEFAULT 'ALL',
  `privileges` text DEFAULT NULL,
  `status` varchar(50) DEFAULT 'ACTIVE',
  `last_login` varchar(50) DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table `admin_users`
INSERT INTO `admin_users` (`id`, `username`, `password`, `name`, `phone`, `user_group`, `role`, `department`, `site`, `privileges`, `status`, `last_login`) VALUES ('USR-001', 'admin@pdtpedee.id', 'admin123', 'Ady', '08119288700', 'admin', 'Manager Planning & NoC', 'NOC Management & IT Infrastructure', 'Semua Lokasi / Global', '{"add":true,"edit":true,"delete":true,"submit":true}', 'ACTIVE', '2026-09-06 07:17:31');
INSERT INTO `admin_users` (`id`, `username`, `password`, `name`, `phone`, `user_group`, `role`, `department`, `site`, `privileges`, `status`, `last_login`) VALUES ('USR-002', 'manager@pdtpedee.id', 'manager123', 'Hendra Gunawan', '08123344556', 'manager', 'Operations Manager', 'Operations & Business Management', 'Semua Lokasi / Global', '{"add":true,"edit":true,"delete":false,"submit":true}', 'ACTIVE', '2026-09-05 13:37:02');
INSERT INTO `admin_users` (`id`, `username`, `password`, `name`, `phone`, `user_group`, `role`, `department`, `site`, `privileges`, `status`, `last_login`) VALUES ('USR-003', 'supervisor@pdtpedee.id', 'supervisor123', 'Siti Rahmawati', '08137788990', 'supervisor', 'NOC Supervisor', 'Network Operations Center (NOC)', 'Cluster Gading Serpong, Tangerang', '{"add":true,"edit":true,"delete":false,"submit":true}', 'ACTIVE', '2026-09-05 13:37:02');
INSERT INTO `admin_users` (`id`, `username`, `password`, `name`, `phone`, `user_group`, `role`, `department`, `site`, `privileges`, `status`, `last_login`) VALUES ('USR-004', 'engineer@pdtpedee.id', 'engineer123', 'Rian Maulana', '08156677004', 'engineer', 'Field & NOC Engineer', 'Field Maintenance & Fiber Infrastructure', 'Cluster BSD City, Tangerang Selatan', '{"add":true,"edit":true,"delete":false,"submit":true}', 'ACTIVE', '2026-09-05 13:37:02');
INSERT INTO `admin_users` (`id`, `username`, `password`, `name`, `phone`, `user_group`, `role`, `department`, `site`, `privileges`, `status`, `last_login`) VALUES ('USR-005', 'ady', 'admin123', 'Ady', '08119288700', 'admin', 'Administrator', 'Network Operations Center (NOC)', 'Semua Lokasi / Global', '{"add":true,"edit":true,"delete":true,"submit":true}', 'ACTIVE', '2026-09-07 13:32:56');

-- --------------------------------------------------------
-- 2. Table structure for table `sites`
-- --------------------------------------------------------
DROP TABLE IF EXISTS `sites`;
CREATE TABLE `sites` (
  `id` varchar(50) NOT NULL,
  `name` varchar(150) NOT NULL,
  `code` varchar(50) NOT NULL,
  `city` varchar(100) DEFAULT NULL,
  `address` text DEFAULT NULL,
  `pic` varchar(100) DEFAULT NULL,
  `pic_phone` varchar(50) DEFAULT NULL,
  `status` varchar(50) DEFAULT 'OPERATIONAL',
  `bandwidth_capacity` varchar(50) DEFAULT NULL,
  `power_backup` varchar(100) DEFAULT NULL,
  `coverage_area` text DEFAULT NULL,
  `description` text DEFAULT NULL,
  `is_global` tinyint(1) DEFAULT 0,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table `sites`
INSERT INTO `sites` (`id`, `name`, `code`, `city`, `address`, `pic`, `pic_phone`, `status`, `bandwidth_capacity`, `power_backup`, `coverage_area`, `description`, `is_global`) VALUES ('SITE-GLOBAL', 'Semua Lokasi / Global', 'GLOBAL', 'Nasional / Multi-Site', 'Network Operations Center (NOC) Pusat PDT-Pedee', 'Bambang Wijaya (Super Admin NOC)', '081288229100', 'OPERATIONAL', '100 Gbps Core Backbone', 'Dual Grid PLN + Redundant UPS 20 kVA & Genset 50 kVA', 'Seluruh Wilayah Layanan Terintegrasi Nasional', 'Profil agregasi pusat untuk pemantauan menyeluruh dan eskalasi teknisi global.', 1);
INSERT INTO `sites` (`id`, `name`, `code`, `city`, `address`, `pic`, `pic_phone`, `status`, `bandwidth_capacity`, `power_backup`, `coverage_area`, `description`, `is_global`) VALUES ('SITE-KJ-01', 'Area Kebon Jeruk, Jakarta Barat', 'KJ', 'Jakarta Barat', 'Jl. Raya Kebon Jeruk No. 88, Jakarta Barat', 'Siti Rahmawati (NOC Supervisor)', '081577665544', 'OPERATIONAL', '10 Gbps Dark Fiber Dedicated', 'UPS 5 kVA Online', 'Kebon Jeruk, Kedoya, Tanjung Duren, Meruya, Puri Indah', 'POP Distribusi FTTH Jakarta Barat, Hub OLT ZTE C320.', 0);
INSERT INTO `sites` (`id`, `name`, `code`, `city`, `address`, `pic`, `pic_phone`, `status`, `bandwidth_capacity`, `power_backup`, `coverage_area`, `description`, `is_global`) VALUES ('SITE-QSPDT01-08', 'QSquare Cibinong', 'QSPDT01', 'Cibinong', 'Area Hub QSquare Cibinong', 'Tim NOC Area', '081288229100', 'OPERATIONAL', '10 Gbps Metro-E Ring 1', 'UPS 6 kVA Online + Backup Power', 'QSquare Cibinong', 'Point of Presence (POP) & Coverage Area QSquare Cibinong', 0);
INSERT INTO `sites` (`id`, `name`, `code`, `city`, `address`, `pic`, `pic_phone`, `status`, `bandwidth_capacity`, `power_backup`, `coverage_area`, `description`, `is_global`) VALUES ('SITE-ROPDTENTP01-09', 'Hj. Nawai PT Travelio', 'ROPDTENTP01', 'Indonesia', 'Area Hub Hj. Nawai PT Travelio', 'Tim NOC Area', '081288229100', 'OPERATIONAL', '10 Gbps Metro-E Ring 1', 'UPS 6 kVA Online + Backup Power', 'Hj. Nawai PT Travelio', 'Point of Presence (POP) & Coverage Area Hj. Nawai PT Travelio', 0);
INSERT INTO `sites` (`id`, `name`, `code`, `city`, `address`, `pic`, `pic_phone`, `status`, `bandwidth_capacity`, `power_backup`, `coverage_area`, `description`, `is_global`) VALUES ('SITE-PDTSTC01-05', 'Sukaramai Trade Center', 'PDTSTC01', 'Pekanbaru', 'Area Hub Sukaramai Trade Center', 'Tim NOC Area', '081288229100', 'OPERATIONAL', '10 Gbps Metro-E Ring 1', 'UPS 6 kVA Online + Backup Power', 'Sukaramai Trade Center', 'Point of Presence (POP) & Coverage Area Sukaramai Trade Center', 0);

-- --------------------------------------------------------
-- 3. Table structure for table `packages`
-- --------------------------------------------------------
DROP TABLE IF EXISTS `packages`;
CREATE TABLE `packages` (
  `id` varchar(50) NOT NULL,
  `name` varchar(150) NOT NULL,
  `speed` varchar(50) NOT NULL,
  `unit` varchar(20) DEFAULT 'Mbps',
  `price` decimal(15,2) NOT NULL DEFAULT 0.00,
  `description` text DEFAULT NULL,
  `ratio` varchar(50) DEFAULT '1:1',
  `fup` varchar(50) DEFAULT 'Unlimited',
  `badge` varchar(100) DEFAULT NULL,
  `features` text DEFAULT NULL,
  `use_ppn` tinyint(1) DEFAULT 1,
  `ppn_percentage` decimal(5,2) DEFAULT 11.00,
  `use_uso` tinyint(1) DEFAULT 1,
  `uso_percentage` decimal(5,2) DEFAULT 1.75,
  `promo_price` decimal(15,2) DEFAULT NULL,
  `promo_cycles` int DEFAULT 0,
  `prorate_first_invoice` tinyint(1) DEFAULT 0,
  `billing_type` varchar(50) DEFAULT 'MONTHLY',
  `duration_days` int DEFAULT 30,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table `packages`
INSERT INTO `packages` (`id`, `name`, `speed`, `unit`, `price`, `description`, `ratio`, `fup`, `badge`, `features`, `use_ppn`, `ppn_percentage`, `use_uso`, `uso_percentage`, `promo_price`, `promo_cycles`, `prorate_first_invoice`, `billing_type`, `duration_days`) VALUES ('lite-30', 'PDT-Pedee Lite', 30, 'Mbps', 199000, 'Ideal untuk browsing santai, medsos, dan 3-5 perangkat.', '1:1 Simetris', 'Unlimited Tanpa FUP', 'Ekonomis', '["Kecepatan 30 Mbps Simetris","Router Dual-Band AC1200","Unlimited Kuota Tanpa FUP","Bantuan Helpdesk 24/7"]', 1, 11, 1, 1.75, NULL, 0, 1, 'postpaid', 30);
INSERT INTO `packages` (`id`, `name`, `speed`, `unit`, `price`, `description`, `ratio`, `fup`, `badge`, `features`, `use_ppn`, `ppn_percentage`, `use_uso`, `uso_percentage`, `promo_price`, `promo_cycles`, `prorate_first_invoice`, `billing_type`, `duration_days`) VALUES ('home-50', 'PDT-Pedee Home', 50, 'Mbps', 279000, 'Cocok untuk keluarga, streaming 4K lancar dan WFH tanpa kendala.', '1:1 Simetris', 'Unlimited Tanpa FUP', 'Pilihan Keluarga', '["Kecepatan 50 Mbps Simetris","Router Dual-Band Gigabit","Unlimited Kuota Tanpa FUP","Prioritas Streaming Video","Dukungan Helpdesk AI"]', 1, 11, 1, 1.75, NULL, 0, 1, 'postpaid', 30);
INSERT INTO `packages` (`id`, `name`, `speed`, `unit`, `price`, `description`, `ratio`, `fup`, `badge`, `features`, `use_ppn`, `ppn_percentage`, `use_uso`, `uso_percentage`, `promo_price`, `promo_cycles`, `prorate_first_invoice`, `billing_type`, `duration_days`) VALUES ('prime-100', 'PDT-Pedee Prime', 100, 'Mbps', 389000, 'Paket terpopuler untuk multitasking tinggi, smart home, dan unduhan super cepat.', '1:1 Simetris', 'Unlimited Tanpa FUP', 'Paling Populer', '["Kecepatan 100 Mbps Simetris","Router WiFi 6 Gigabit","Unlimited Kuota Tanpa Batas FUP","Optimasi Game & Meeting Online","Garansi SLA 99% Uptime"]', 1, 11, 1, 1.75, 299000, 3, 1, 'postpaid', 30);
INSERT INTO `packages` (`id`, `name`, `speed`, `unit`, `price`, `description`, `ratio`, `fup`, `badge`, `features`, `use_ppn`, `ppn_percentage`, `use_uso`, `uso_percentage`, `promo_price`, `promo_cycles`, `prorate_first_invoice`, `billing_type`, `duration_days`) VALUES ('gamer-200', 'PDT-Pedee Gamer', 200, 'Mbps', 549000, 'Rute khusus gaming dengan latensi terendah (ultra-low ping) dan anti-jitter.', '1:1 Simetris', 'Unlimited Tanpa FUP', 'Pro Gamer Choice', '["Kecepatan 200 Mbps Simetris","Gaming Route Prioritas Internasional","Router Gaming WiFi 6 High-Power","Free 1 IP Publik Dinamis Berkualitas","Prioritas Tiket Gangguan Tier-1"]', 1, 11, 1, 1.75, NULL, 0, 1, 'postpaid', 30);
INSERT INTO `packages` (`id`, `name`, `speed`, `unit`, `price`, `description`, `ratio`, `fup`, `badge`, `features`, `use_ppn`, `ppn_percentage`, `use_uso`, `uso_percentage`, `promo_price`, `promo_cycles`, `prorate_first_invoice`, `billing_type`, `duration_days`) VALUES ('ultra-500', 'PDT-Pedee Ultra', 500, 'Mbps', 899000, 'Performa kelas atas untuk konten kreator, live streaming studio & rumah luas.', '1:1 Simetris', 'Unlimited Tanpa FUP', 'Ultra Performance', '["Kecepatan 500 Mbps Simetris","Mesh WiFi 6 System (2 Node)","Jalur Khusus Fiber Dedicated 1:1","Gratis Static IP Publik","Dedicated Account Manager"]', 1, 11, 1, 1.75, NULL, 0, 1, 'postpaid', 30);
INSERT INTO `packages` (`id`, `name`, `speed`, `unit`, `price`, `description`, `ratio`, `fup`, `badge`, `features`, `use_ppn`, `ppn_percentage`, `use_uso`, `uso_percentage`, `promo_price`, `promo_cycles`, `prorate_first_invoice`, `billing_type`, `duration_days`) VALUES ('prepaid-50', 'PDT-Pedee Flexi Prepaid (50 Mbps)', 50, 'Mbps', 150000, 'Paket isi ulang prabayar 30 hari tanpa kontrak, bebas bayar sesuai kebutuhan.', '1:1 Simetris', 'Unlimited Kuota', 'Prepaid Hemat', '["Masa Aktif 30 Hari Fleksibel","Kecepatan 50 Mbps Simetris 1:1","Isi Ulang Instan via Portal & WA","Bebas Kontrak Berlangganan"]', 1, 11, 1, 1.75, NULL, 0, 0, 'prepaid', 30);

-- --------------------------------------------------------
-- 4. Table structure for table `customers`
-- --------------------------------------------------------
DROP TABLE IF EXISTS `customers`;
CREATE TABLE `customers` (
  `id` varchar(50) NOT NULL,
  `link_id` varchar(50) NOT NULL UNIQUE,
  `name` varchar(150) NOT NULL,
  `username` varchar(100) NOT NULL UNIQUE,
  `password` varchar(150) NOT NULL,
  `portal_username` varchar(100) DEFAULT NULL,
  `portal_password` varchar(150) DEFAULT NULL,
  `pin` varchar(50) DEFAULT '123456',
  `email` varchar(100) DEFAULT NULL,
  `phone` varchar(50) DEFAULT NULL,
  `site_location` varchar(100) DEFAULT NULL,
  `address` text DEFAULT NULL,
  `package_id` varchar(50) DEFAULT NULL,
  `package_name` varchar(100) DEFAULT NULL,
  `speed` varchar(50) DEFAULT NULL,
  `status` varchar(50) DEFAULT 'ACTIVE',
  `portal_status` varchar(50) DEFAULT 'AKTIF',
  `asset_type` varchar(50) DEFAULT 'ONT',
  `asset_brand` varchar(50) DEFAULT 'ZTE',
  `ont_model` varchar(50) DEFAULT 'F670L',
  `asset_sn` varchar(100) DEFAULT NULL,
  `asset_status` varchar(50) DEFAULT 'ACTIVE',
  `ip_public` varchar(50) DEFAULT NULL,
  `mac_address` varchar(50) DEFAULT NULL,
  `optical_power` varchar(50) DEFAULT '-19.45 dBm',
  `optical_status` varchar(50) DEFAULT 'EXCELLENT',
  `due_day` int DEFAULT 10,
  `join_date` varchar(50) DEFAULT NULL,
  `last_reboot` varchar(50) DEFAULT NULL,
  `install_date` varchar(50) DEFAULT NULL,
  `promo_cycles_used` int DEFAULT 0,
  `expired_at` varchar(50) DEFAULT NULL,
  `isolate_day` int DEFAULT 10,
  `isolir_profile` varchar(100) DEFAULT 'profile-isolir-tagihan',
  `genieacs_tag` varchar(100) DEFAULT NULL,
  `pppoe_username` varchar(100) DEFAULT NULL,
  `connection_type` varchar(50) DEFAULT 'PPPoE',
  `static_ip` varchar(50) DEFAULT NULL,
  `router` varchar(100) DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------
-- Table structure for table `customer_activity_logs`
-- --------------------------------------------------------
DROP TABLE IF EXISTS `customer_activity_logs`;
CREATE TABLE `customer_activity_logs` (
  `id` int NOT NULL AUTO_INCREMENT,
  `customer_id` varchar(50) NOT NULL,
  `action` varchar(50) NOT NULL,
  `action_label` varchar(100) DEFAULT NULL,
  `detail` text,
  `actor` varchar(100) DEFAULT 'Sistem NOC',
  `ip` varchar(50) DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_customer_id` (`customer_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table `customers` & `customer_activity_logs`
INSERT INTO `customers` (`id`, `link_id`, `name`, `username`, `password`, `portal_username`, `portal_password`, `pin`, `email`, `phone`, `site_location`, `address`, `package_id`, `package_name`, `speed`, `status`, `portal_status`, `asset_type`, `asset_brand`, `ont_model`, `asset_sn`, `asset_status`, `ip_public`, `mac_address`, `optical_power`, `optical_status`, `due_day`, `join_date`, `last_reboot`, `install_date`, `promo_cycles_used`, `expired_at`, `isolate_day`, `isolir_profile`, `genieacs_tag`, `pppoe_username`, `connection_type`, `static_ip`, `router`) VALUES ('PDT-2026-55833', 'LNK-GS-21949', 'test1', 'test1', '123456', 'test1', '123456', '123456', 'noc@gmail.com', '085779099018', 'Area Kebon Jeruk, Jakarta Barat', 'Graha Aruna No 47', 'lite-30', 'PDT-Pedee Lite', '30 Mbps / 30 Mbps', 'ONLINE', 'NON_AKTIF', 'ONT GPON WiFi 6 Gigabit', 'ZTE', 'ZTE F670L Dual-Band Gigabit', 'ZTEGC197323', 'ONLINE (Normal)', '103.147.22.130', 'F4:8E:64:82:36:55', '-18.8 dBm', 'OPTIMAL', 10, '05 September 2026', '2026-09-07T12:29:54.745Z', '2026-09-05', 0, '2026-10-05 23:59:59', 10, 'profile-isolir-tagihan', 'LNK-GS-21949', 'lnk-gs-21949', 'PPPoE', '10.20.10.144', 'DIST-ROUTER-RB4011-KJ');
INSERT INTO `customer_activity_logs` (`customer_id`, `action`, `action_label`, `detail`, `actor`, `ip`, `created_at`) VALUES ('PDT-2026-55833', 'UPDATE_PROFILE', 'Pembaruan Data Master Customer', 'Profil pelanggan test1 diperbarui oleh Administrator', 'Admin NOC', '::1', '2026-09-07 12:31:21');
INSERT INTO `customer_activity_logs` (`customer_id`, `action`, `action_label`, `detail`, `actor`, `ip`, `created_at`) VALUES ('PDT-2026-55833', 'TOGGLE_PORTAL_STATUS', 'Perubahan Status Akses Portal', 'Akses login portal mandiri diubah menjadi NON_AKTIF (Akses Diblokir)', 'Admin NOC', '::1', '2026-09-07 12:31:21');
INSERT INTO `customer_activity_logs` (`customer_id`, `action`, `action_label`, `detail`, `actor`, `ip`, `created_at`) VALUES ('PDT-2026-55833', 'LOGIN_PORTAL', 'Login Self-Service Portal', 'Login berhasil menggunakan identifier "test1" via Web Portal', 'Pelanggan (test1)', '172.17.10.3', '2026-09-07 12:27:32');
INSERT INTO `customer_activity_logs` (`customer_id`, `action`, `action_label`, `detail`, `actor`, `ip`, `created_at`) VALUES ('PDT-2026-55833', 'LOGIN_PORTAL', 'Login Self-Service Portal', 'Login berhasil menggunakan identifier "test1" via Web Portal', 'Pelanggan (test1)', '172.17.10.3', '2026-09-07 12:25:15');
INSERT INTO `customer_activity_logs` (`customer_id`, `action`, `action_label`, `detail`, `actor`, `ip`, `created_at`) VALUES ('PDT-2026-55833', 'LOGIN_PORTAL', 'Login Self-Service Portal', 'Login berhasil menggunakan identifier "test1" via Web Portal', 'Pelanggan (test1)', '::1', '2026-09-07 07:51:53');
INSERT INTO `customer_activity_logs` (`customer_id`, `action`, `action_label`, `detail`, `actor`, `ip`, `created_at`) VALUES ('PDT-2026-55833', 'UPDATE_PROFILE', 'Pembaruan Data Master Customer', 'Profil pelanggan test1 diperbarui oleh Administrator', 'Admin NOC', '::1', '2026-09-07 07:50:05');
INSERT INTO `customer_activity_logs` (`customer_id`, `action`, `action_label`, `detail`, `actor`, `ip`, `created_at`) VALUES ('PDT-2026-55833', 'UPDATE_USERNAME', 'Perubahan Username Login Portal', 'Username login portal diubah dari "test1_pro" menjadi "test1"', 'Admin NOC', '::1', '2026-09-07 07:50:05');
INSERT INTO `customer_activity_logs` (`customer_id`, `action`, `action_label`, `detail`, `actor`, `ip`, `created_at`) VALUES ('PDT-2026-55833', 'UPDATE_PASSWORD', 'Perubahan Password Login Portal', 'Password login self-service portal pelanggan berhasil diperbarui oleh Administrator', 'Admin NOC', '::1', '2026-09-07 07:50:05');
INSERT INTO `customer_activity_logs` (`customer_id`, `action`, `action_label`, `detail`, `actor`, `ip`, `created_at`) VALUES ('PDT-2026-55833', 'LOGIN_PORTAL', 'Login Self-Service Portal', 'Login berhasil menggunakan identifier "test1_pro" via Web Portal', 'Pelanggan (test1)', '::1', '2026-09-07 07:50:05');
INSERT INTO `customer_activity_logs` (`customer_id`, `action`, `action_label`, `detail`, `actor`, `ip`, `created_at`) VALUES ('PDT-2026-55833', 'UPDATE_PROFILE', 'Pembaruan Data Master Customer', 'Profil pelanggan test1 diperbarui oleh Administrator', 'Admin NOC', '::1', '2026-09-07 07:50:05');
INSERT INTO `customer_activity_logs` (`customer_id`, `action`, `action_label`, `detail`, `actor`, `ip`, `created_at`) VALUES ('PDT-2026-55833', 'UPDATE_USERNAME', 'Perubahan Username Login Portal', 'Username login portal diubah dari "test1" menjadi "test1_pro"', 'Admin NOC', '::1', '2026-09-07 07:50:05');
INSERT INTO `customer_activity_logs` (`customer_id`, `action`, `action_label`, `detail`, `actor`, `ip`, `created_at`) VALUES ('PDT-2026-55833', 'UPDATE_PASSWORD', 'Perubahan Password Login Portal', 'Password login self-service portal pelanggan berhasil diperbarui oleh Administrator', 'Admin NOC', '::1', '2026-09-07 07:50:05');
INSERT INTO `customer_activity_logs` (`customer_id`, `action`, `action_label`, `detail`, `actor`, `ip`, `created_at`) VALUES ('PDT-2026-55833', 'MANUAL_NOTE', 'Catatan Manajemen Admin', 'Pelanggan konfirmasi verifikasi nomor WhatsApp dan request panduan login portal mandiri', 'Admin NOC Testing', '::1', '2026-09-07 07:50:05');
INSERT INTO `customer_activity_logs` (`customer_id`, `action`, `action_label`, `detail`, `actor`, `ip`, `created_at`) VALUES ('PDT-2026-55833', 'LOGIN_PORTAL', 'Login Self-Service Portal', 'Login berhasil menggunakan identifier "LNK-GS-21949" via Web Portal', 'Pelanggan (test1)', '::1', '2026-09-07 07:50:05');
INSERT INTO `customer_activity_logs` (`customer_id`, `action`, `action_label`, `detail`, `actor`, `ip`, `created_at`) VALUES ('PDT-2026-55833', 'LOGIN_PORTAL', 'Login Self-Service Portal', 'Login berhasil menggunakan identifier "test1" via Web Portal', 'Pelanggan (test1)', '::1', '2026-09-07 07:50:05');
INSERT INTO `customer_activity_logs` (`customer_id`, `action`, `action_label`, `detail`, `actor`, `ip`, `created_at`) VALUES ('PDT-2026-55833', 'CREATE_CUSTOMER', 'Pemasangan Baru & Registrasi Akun', 'Pendaftaran master customer baru test1 dengan paket PDT-Pedee Lite', 'Bambang Wijaya (NOC Lead)', '180.252.171.150', '2026-09-05 08:30:00');
INSERT INTO `customer_activity_logs` (`customer_id`, `action`, `action_label`, `detail`, `actor`, `ip`, `created_at`) VALUES ('PDT-2026-55833', 'SETUP_CREDENTIALS', 'Konfigurasi Kredensial Login Portal', 'Username portal diset ke: test1, Password login portal diaktifkan', 'Bambang Wijaya (NOC Lead)', '180.252.171.150', '2026-09-05 09:15:00');
INSERT INTO `customer_activity_logs` (`customer_id`, `action`, `action_label`, `detail`, `actor`, `ip`, `created_at`) VALUES ('PDT-2026-55833', 'LOGIN_PORTAL', 'Login Self-Service Portal', 'Login berhasil ke portal mandiri via Web Browser (Chrome/Windows)', 'Pelanggan (test1)', '180.252.171.150', '2026-09-06 10:20:00');

-- --------------------------------------------------------
-- 5. Table structure for table `invoices`
-- --------------------------------------------------------
DROP TABLE IF EXISTS `invoices`;
CREATE TABLE `invoices` (
  `id` varchar(50) NOT NULL,
  `customer_id` varchar(50) NOT NULL,
  `month` varchar(50) DEFAULT NULL,
  `period_month` int DEFAULT NULL,
  `period_year` int DEFAULT NULL,
  `issue_date` varchar(50) DEFAULT NULL,
  `due_date` varchar(50) DEFAULT NULL,
  `package_name` varchar(100) DEFAULT NULL,
  `package_price` decimal(15,2) DEFAULT 0.00,
  `base_amount` decimal(15,2) DEFAULT 0.00,
  `ont_rental` decimal(15,2) DEFAULT 0.00,
  `discount` decimal(15,2) DEFAULT 0.00,
  `use_ppn` tinyint(1) DEFAULT 1,
  `ppn_percentage` decimal(5,2) DEFAULT 11.00,
  `ppn_amount` decimal(15,2) DEFAULT 0.00,
  `use_uso` tinyint(1) DEFAULT 1,
  `uso_percentage` decimal(5,2) DEFAULT 1.75,
  `uso_amount` decimal(15,2) DEFAULT 0.00,
  `tax` decimal(15,2) DEFAULT 0.00,
  `total` decimal(15,2) DEFAULT 0.00,
  `notes` text DEFAULT NULL,
  `status` varchar(50) DEFAULT 'UNPAID',
  `paid_at` varchar(50) DEFAULT NULL,
  `payment_method` varchar(50) DEFAULT NULL,
  `payment_gateway` varchar(50) DEFAULT 'MIDTRANS_SIMULATOR',
  `payment_order_id` varchar(100) DEFAULT NULL,
  `payment_link` text DEFAULT NULL,
  `payment_reference` varchar(100) DEFAULT NULL,
  `payment_expires_at` varchar(50) DEFAULT NULL,
  `paid_by_name` varchar(100) DEFAULT NULL,
  `virtual_accounts` text DEFAULT NULL,
  `qris_code` text DEFAULT NULL,
  `payment_submitted_at` varchar(50) DEFAULT NULL,
  `approved_at` varchar(50) DEFAULT NULL,
  `approved_by` varchar(100) DEFAULT NULL,
  `approval_notes` text DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_cust_inv` (`customer_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table `invoices`
INSERT INTO `invoices` (`id`, `customer_id`, `month`, `period_month`, `period_year`, `issue_date`, `due_date`, `package_name`, `package_price`, `base_amount`, `ont_rental`, `discount`, `use_ppn`, `ppn_percentage`, `ppn_amount`, `use_uso`, `uso_percentage`, `uso_amount`, `tax`, `total`, `notes`, `status`, `paid_at`, `payment_method`, `payment_gateway`, `payment_order_id`, `payment_link`, `payment_reference`, `payment_expires_at`, `paid_by_name`, `virtual_accounts`, `qris_code`, `payment_submitted_at`, `approved_at`, `approved_by`, `approval_notes`) VALUES ('INV-202609-4595', 'PDT-2026-55833', 'Oktober 2026', 9, 2026, '05 September 2026', '10 Oktober 2026', 'PDT-Pedee Lite', 172467, 172467, 0, 0, 1, 11, 18971, 1, 1.75, 3018, 21989, 194456, 'AUTO: Prorata 26/30 hari | PPN 11% (Rp 18.971) | USO 1.75% (Rp 3.018)', 'PAID', '07 September 2026 19.27 WIB', 'Mandiri Virtual Account', 'MANDIRI_VIRTUAL_ACCOUNT', 'ORD-1788617494953', 'https://pdtpedee.id/pay/INV-202609', 'PAY-688844', '2026-09-10 23:59:59', 'Pelanggan Self-Service', '{"bca":"12890085779099018","mandiri":"88012085779099018","bri":"02081085779099018","bni":"98822085779099018"}', '00020101021226680016ID.CO.PDT-PEDEE.WWW0118936008577909901852045812', '2026-09-05T14:14:49.102Z', '2026-09-07T12:27:17.118Z', 'Ady', 'Diverifikasi & disetujui lunas oleh Ady');

-- --------------------------------------------------------
-- 6. Table structure for table `routers`
-- --------------------------------------------------------
DROP TABLE IF EXISTS `routers`;
CREATE TABLE `routers` (
  `id` varchar(50) NOT NULL,
  `name` varchar(150) NOT NULL,
  `ip_address` varchar(100) NOT NULL,
  `port` int DEFAULT 8728,
  `webfig_port` int DEFAULT 80,
  `routeros_version` varchar(20) DEFAULT 'v6',
  `management_protocol` varchar(50) DEFAULT 'RouterOS_API',
  `session_status` varchar(50) DEFAULT 'LOGGED_IN',
  `username` varchar(100) DEFAULT 'admin',
  `password` varchar(150) DEFAULT '',
  `description` text DEFAULT NULL,
  `coordinates` varchar(100) DEFAULT NULL,
  `coverage` varchar(100) DEFAULT NULL,
  `enabled` tinyint(1) DEFAULT 1,
  `site_location` varchar(100) DEFAULT NULL,
  `status` varchar(50) DEFAULT 'ONLINE',
  `model` varchar(100) DEFAULT 'MikroTik CCR1009-7G-1C-1S+',
  `uptime` varchar(50) DEFAULT '14d 06:22:15',
  `cpu_load` int DEFAULT 5,
  `memory_free` varchar(50) DEFAULT '845 MB',
  `memory_total` varchar(50) DEFAULT '1024 MB',
  `active_pppoe` int DEFAULT 350,
  `traffic_in` varchar(50) DEFAULT '24.5 Mbps',
  `traffic_out` varchar(50) DEFAULT '15.2 Mbps',
  `session_mode` varchar(50) DEFAULT 'STANDBY',
  `last_login_at` varchar(50) DEFAULT NULL,
  `last_logout_at` varchar(50) DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table `routers`
INSERT INTO `routers` (`id`, `name`, `ip_address`, `port`, `webfig_port`, `routeros_version`, `management_protocol`, `session_status`, `username`, `password`, `description`, `coordinates`, `coverage`, `enabled`, `site_location`, `status`, `model`, `uptime`, `cpu_load`, `memory_free`, `memory_total`, `active_pppoe`, `traffic_in`, `traffic_out`, `session_mode`, `last_login_at`, `last_logout_at`) VALUES ('ROUTER-MK-01', 'RO-PDT-Travelio', '103.188.177.126', 8088, 8088, 'v7', 'WebConfig REST API (8088)', 'LOGGED_OFF', 'selfnoc', 'Qwerty2026#!', 'Router Utama RO-PDT-Travelio (WebConfig REST Port 8088)', '', '5000', 1, 'Cluster Gading Serpong, Tangerang', 'ONLINE', 'MikroTik hEX S', '9w8h52m19s', 3, '2400 MB', '4096 MB', 5, '1.2 Gbps', '1.1 Gbps', 'OFFLINE', '2026-09-07T13:34:39.155Z', '2026-09-07T13:35:35.314Z');
INSERT INTO `routers` (`id`, `name`, `ip_address`, `port`, `webfig_port`, `routeros_version`, `management_protocol`, `session_status`, `username`, `password`, `description`, `coordinates`, `coverage`, `enabled`, `site_location`, `status`, `model`, `uptime`, `cpu_load`, `memory_free`, `memory_total`, `active_pppoe`, `traffic_in`, `traffic_out`, `session_mode`, `last_login_at`, `last_logout_at`) VALUES ('ROUTER-MK-02', 'CPE Sukaramai Trade Center', '85.137.29.14', 8728, 80, 'v6', 'RouterOS v6 API Socket (8728)', 'LOGGED_OFF', 'ady', 'admin123', 'Router CPE Qsquare-Cibinong (WebConfig Port 8088)', '-6.255823, 106.621945', '5000', 1, 'Cluster Gading Serpong, Tangerang', 'ONLINE', 'MikroTik x86 (x86_64)', '18w3d17h54m48s', 2, '2400 MB', '4096 MB', 0, '0 Gbps', '0 Gbps', 'OFFLINE', '2026-09-07T13:33:23.092Z', '2026-09-07T13:34:24.100Z');
INSERT INTO `routers` (`id`, `name`, `ip_address`, `port`, `webfig_port`, `routeros_version`, `management_protocol`, `session_status`, `username`, `password`, `description`, `coordinates`, `coverage`, `enabled`, `site_location`, `status`, `model`, `uptime`, `cpu_load`, `memory_free`, `memory_total`, `active_pppoe`, `traffic_in`, `traffic_out`, `session_mode`, `last_login_at`, `last_logout_at`) VALUES ('ROUTER-MK-03', 'CPE-Qsquare', '103.188.177.162', 8088, 8088, 'v7', 'WebConfig REST API (8088)', 'LOGGED_IN', 'selfnoc', 'Qwerty2026#!', 'Router CPE-Qsquare (WebConfig Port 8088)', '-6.255823, 106.621945', '5000', 1, 'QSquare Cibinong', 'ONLINE', 'MikroTik CCR2004-1G-12S+2XS', '1 hari, 04 jam', 2, '2400 MB', '4096 MB', 0, '0 Gbps', '0 Gbps', 'STANDBY', '2026-09-06T08:44:40.188Z', '2026-09-06T08:44:28.439Z');

-- --------------------------------------------------------
-- 7. Table structure for table `router_queues`
-- --------------------------------------------------------
DROP TABLE IF EXISTS `router_queues`;
CREATE TABLE `router_queues` (
  `id` varchar(100) NOT NULL,
  `router_id` varchar(50) NOT NULL,
  `name` varchar(150) NOT NULL,
  `target` varchar(100) NOT NULL,
  `max_limit` varchar(50) DEFAULT '10M/10M',
  `burst_limit` varchar(50) DEFAULT '0/0',
  `burst_threshold` varchar(50) DEFAULT '0/0',
  `burst_time` varchar(50) DEFAULT '0s/0s',
  `priority` varchar(20) DEFAULT '8/8',
  `comment` text DEFAULT NULL,
  `disabled` tinyint(1) DEFAULT 0,
  `rate` varchar(50) DEFAULT '0bps/0bps',
  `packet_rate` varchar(50) DEFAULT '0/0',
  `bytes` varchar(50) DEFAULT '0/0',
  `packets` varchar(50) DEFAULT '0/0',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_router_queue` (`router_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table `router_queues`
INSERT INTO `router_queues` (`id`, `router_id`, `name`, `target`, `max_limit`, `burst_limit`, `burst_threshold`, `burst_time`, `priority`, `comment`, `disabled`, `rate`, `packet_rate`, `bytes`, `packets`) VALUES ('*AD7', 'ROUTER-MK-02', '<pppoe-0040054200223>', '<pppoe-0040054200223>', '30000000/30000000', '0/0', '0/0', '0s/0s', '8/8', 'Simple Queue Rule', 0, NULL, NULL, '26467546414/78613390998', '55068827/80832801');
INSERT INTO `router_queues` (`id`, `router_id`, `name`, `target`, `max_limit`, `burst_limit`, `burst_threshold`, `burst_time`, `priority`, `comment`, `disabled`, `rate`, `packet_rate`, `bytes`, `packets`) VALUES ('*CA9', 'ROUTER-MK-02', '<pppoe-14002020>', '<pppoe-14002020>', '55000000/55000000', '0/0', '0/0', '0s/0s', '8/8', 'Simple Queue Rule', 0, NULL, NULL, '7958262379/115799434044', '30463753/97831542');
INSERT INTO `router_queues` (`id`, `router_id`, `name`, `target`, `max_limit`, `burst_limit`, `burst_threshold`, `burst_time`, `priority`, `comment`, `disabled`, `rate`, `packet_rate`, `bytes`, `packets`) VALUES ('*CAB', 'ROUTER-MK-02', '<pppoe-bm-stc>', '<pppoe-bm-stc>', '70000000/70000000', '0/0', '0/0', '0s/0s', '8/8', 'Simple Queue Rule', 0, NULL, NULL, '46588899/328480270', '523995/702657');
INSERT INTO `router_queues` (`id`, `router_id`, `name`, `target`, `max_limit`, `burst_limit`, `burst_threshold`, `burst_time`, `priority`, `comment`, `disabled`, `rate`, `packet_rate`, `bytes`, `packets`) VALUES ('*CAF', 'ROUTER-MK-02', '<pppoe-0040053200236>', '<pppoe-0040053200236>', '30000000/30000000', '0/0', '0/0', '0s/0s', '8/8', 'Simple Queue Rule', 0, NULL, NULL, '378104195/10259529816', '2811471/9011260');
INSERT INTO `router_queues` (`id`, `router_id`, `name`, `target`, `max_limit`, `burst_limit`, `burst_threshold`, `burst_time`, `priority`, `comment`, `disabled`, `rate`, `packet_rate`, `bytes`, `packets`) VALUES ('*CB1', 'ROUTER-MK-02', '<pppoe-14002006>', '<pppoe-14002006>', '30000000/30000000', '0/0', '0/0', '0s/0s', '8/8', 'Simple Queue Rule', 0, NULL, NULL, '4457906782/42513237850', '12489515/35902618');
INSERT INTO `router_queues` (`id`, `router_id`, `name`, `target`, `max_limit`, `burst_limit`, `burst_threshold`, `burst_time`, `priority`, `comment`, `disabled`, `rate`, `packet_rate`, `bytes`, `packets`) VALUES ('*CB3', 'ROUTER-MK-02', '<pppoe-16701262025>', '<pppoe-16701262025>', '30000000/30000000', '0/0', '0/0', '0s/0s', '8/8', 'Simple Queue Rule', 0, NULL, NULL, '7716554179/113803700315', '34094643/94874977');
INSERT INTO `router_queues` (`id`, `router_id`, `name`, `target`, `max_limit`, `burst_limit`, `burst_threshold`, `burst_time`, `priority`, `comment`, `disabled`, `rate`, `packet_rate`, `bytes`, `packets`) VALUES ('*CB5', 'ROUTER-MK-02', '<pppoe-14002004>', '<pppoe-14002004>', '30000000/30000000', '0/0', '0/0', '0s/0s', '8/8', 'Simple Queue Rule', 0, NULL, NULL, '6387083591/62878979515', '16383442/53292108');
INSERT INTO `router_queues` (`id`, `router_id`, `name`, `target`, `max_limit`, `burst_limit`, `burst_threshold`, `burst_time`, `priority`, `comment`, `disabled`, `rate`, `packet_rate`, `bytes`, `packets`) VALUES ('*CB7', 'ROUTER-MK-02', '<pppoe-14002007>', '<pppoe-14002007>', '30000000/30000000', '0/0', '0/0', '0s/0s', '8/8', 'Simple Queue Rule', 0, NULL, NULL, '1385283550/19330415640', '5328868/16554979');
INSERT INTO `router_queues` (`id`, `router_id`, `name`, `target`, `max_limit`, `burst_limit`, `burst_threshold`, `burst_time`, `priority`, `comment`, `disabled`, `rate`, `packet_rate`, `bytes`, `packets`) VALUES ('*CB8', 'ROUTER-MK-02', '<pppoe-0040054200241>', '<pppoe-0040054200241>', '30000000/30000000', '0/0', '0/0', '0s/0s', '8/8', 'Simple Queue Rule', 0, NULL, NULL, '619701987/8130933294', '2836727/7229005');
INSERT INTO `router_queues` (`id`, `router_id`, `name`, `target`, `max_limit`, `burst_limit`, `burst_threshold`, `burst_time`, `priority`, `comment`, `disabled`, `rate`, `packet_rate`, `bytes`, `packets`) VALUES ('*CB9', 'ROUTER-MK-02', '<pppoe-14002015>', '<pppoe-14002015>', '55000000/55000000', '0/0', '0/0', '0s/0s', '8/8', 'Simple Queue Rule', 0, NULL, NULL, '3298253904/60455631186', '13055031/50282026');
INSERT INTO `router_queues` (`id`, `router_id`, `name`, `target`, `max_limit`, `burst_limit`, `burst_threshold`, `burst_time`, `priority`, `comment`, `disabled`, `rate`, `packet_rate`, `bytes`, `packets`) VALUES ('*CBB', 'ROUTER-MK-02', '<pppoe-masistana>', '<pppoe-masistana>', '30000000/30000000', '0/0', '0/0', '0s/0s', '8/8', 'Simple Queue Rule', 0, NULL, NULL, '583821999/8433230833', '3485420/7856829');
INSERT INTO `router_queues` (`id`, `router_id`, `name`, `target`, `max_limit`, `burst_limit`, `burst_threshold`, `burst_time`, `priority`, `comment`, `disabled`, `rate`, `packet_rate`, `bytes`, `packets`) VALUES ('*CBC', 'ROUTER-MK-02', '<pppoe-14002011>', '<pppoe-14002011>', '30000000/30000000', '0/0', '0/0', '0s/0s', '8/8', 'Simple Queue Rule', 0, NULL, NULL, '2799306440/31574660283', '12156981/26013553');
INSERT INTO `router_queues` (`id`, `router_id`, `name`, `target`, `max_limit`, `burst_limit`, `burst_threshold`, `burst_time`, `priority`, `comment`, `disabled`, `rate`, `packet_rate`, `bytes`, `packets`) VALUES ('*CBE', 'ROUTER-MK-02', '<pppoe-tokomasdewata>', '<pppoe-tokomasdewata>', '30000000/30000000', '0/0', '0/0', '0s/0s', '8/8', 'Simple Queue Rule', 0, NULL, NULL, '4000905727/32940464944', '10411474/28549927');
INSERT INTO `router_queues` (`id`, `router_id`, `name`, `target`, `max_limit`, `burst_limit`, `burst_threshold`, `burst_time`, `priority`, `comment`, `disabled`, `rate`, `packet_rate`, `bytes`, `packets`) VALUES ('*CC0', 'ROUTER-MK-02', '<pppoe-14002014>', '<pppoe-14002014>', '30000000/30000000', '0/0', '0/0', '0s/0s', '8/8', 'Simple Queue Rule', 0, NULL, NULL, '1678425242/31868726925', '9843288/26675814');
INSERT INTO `router_queues` (`id`, `router_id`, `name`, `target`, `max_limit`, `burst_limit`, `burst_threshold`, `burst_time`, `priority`, `comment`, `disabled`, `rate`, `packet_rate`, `bytes`, `packets`) VALUES ('*CC2', 'ROUTER-MK-02', '<pppoe-14002005>', '<pppoe-14002005>', '30000000/30000000', '0/0', '0/0', '0s/0s', '8/8', 'Simple Queue Rule', 0, NULL, NULL, '2330859002/29695606653', '7597933/24192362');
INSERT INTO `router_queues` (`id`, `router_id`, `name`, `target`, `max_limit`, `burst_limit`, `burst_threshold`, `burst_time`, `priority`, `comment`, `disabled`, `rate`, `packet_rate`, `bytes`, `packets`) VALUES ('*CC4', 'ROUTER-MK-02', '<pppoe-26112024>', '<pppoe-26112024>', '30000000/30000000', '0/0', '0/0', '0s/0s', '8/8', 'Simple Queue Rule', 0, NULL, NULL, '3932641071/60899239590', '15182316/50536049');
INSERT INTO `router_queues` (`id`, `router_id`, `name`, `target`, `max_limit`, `burst_limit`, `burst_threshold`, `burst_time`, `priority`, `comment`, `disabled`, `rate`, `packet_rate`, `bytes`, `packets`) VALUES ('*CC5', 'ROUTER-MK-02', '<pppoe-mascitra>', '<pppoe-mascitra>', '30000000/30000000', '0/0', '0/0', '0s/0s', '8/8', 'Simple Queue Rule', 0, NULL, NULL, '1835802988/31571601499', '7764668/26801592');
INSERT INTO `router_queues` (`id`, `router_id`, `name`, `target`, `max_limit`, `burst_limit`, `burst_threshold`, `burst_time`, `priority`, `comment`, `disabled`, `rate`, `packet_rate`, `bytes`, `packets`) VALUES ('*CCE', 'ROUTER-MK-02', '<pppoe-A&Ystore>', '<pppoe-A&Ystore>', '30000000/30000000', '0/0', '0/0', '0s/0s', '8/8', 'Simple Queue Rule', 0, NULL, NULL, '7111143735/23351180260', '11301212/20212963');
INSERT INTO `router_queues` (`id`, `router_id`, `name`, `target`, `max_limit`, `burst_limit`, `burst_threshold`, `burst_time`, `priority`, `comment`, `disabled`, `rate`, `packet_rate`, `bytes`, `packets`) VALUES ('*CD1', 'ROUTER-MK-02', '<pppoe-0040054200238>', '<pppoe-0040054200238>', '30000000/30000000', '0/0', '0/0', '0s/0s', '8/8', 'Simple Queue Rule', 0, NULL, NULL, '1590888610/18283663320', '5230570/15919137');
INSERT INTO `router_queues` (`id`, `router_id`, `name`, `target`, `max_limit`, `burst_limit`, `burst_threshold`, `burst_time`, `priority`, `comment`, `disabled`, `rate`, `packet_rate`, `bytes`, `packets`) VALUES ('*CDC', 'ROUTER-MK-02', '<pppoe-0040052200248>', '<pppoe-0040052200248>', '65000000/65000000', '0/0', '0/0', '0s/0s', '8/8', 'Simple Queue Rule', 0, NULL, NULL, '10026029466/14783576321', '13813245/17411686');
INSERT INTO `router_queues` (`id`, `router_id`, `name`, `target`, `max_limit`, `burst_limit`, `burst_threshold`, `burst_time`, `priority`, `comment`, `disabled`, `rate`, `packet_rate`, `bytes`, `packets`) VALUES ('*CF3', 'ROUTER-MK-02', '<pppoe-PowerGold>', '<pppoe-PowerGold>', '30000000/30000000', '0/0', '0/0', '0s/0s', '8/8', 'Simple Queue Rule', 0, NULL, NULL, '468731664/6004288174', '1554452/5251723');
INSERT INTO `router_queues` (`id`, `router_id`, `name`, `target`, `max_limit`, `burst_limit`, `burst_threshold`, `burst_time`, `priority`, `comment`, `disabled`, `rate`, `packet_rate`, `bytes`, `packets`) VALUES ('*CFF', 'ROUTER-MK-02', '<pppoe-0040054200235>', '<pppoe-0040054200235>', '30000000/30000000', '0/0', '0/0', '0s/0s', '8/8', 'Simple Queue Rule', 0, NULL, NULL, '1068785714/8974652953', '3034124/7707161');
INSERT INTO `router_queues` (`id`, `router_id`, `name`, `target`, `max_limit`, `burst_limit`, `burst_threshold`, `burst_time`, `priority`, `comment`, `disabled`, `rate`, `packet_rate`, `bytes`, `packets`) VALUES ('*D02', 'ROUTER-MK-02', '<pppoe-Mubarak>', '<pppoe-Mubarak>', '70000000/70000000', '0/0', '0/0', '0s/0s', '8/8', 'Simple Queue Rule', 0, NULL, NULL, '79431299/1577927180', '360522/1310961');
INSERT INTO `router_queues` (`id`, `router_id`, `name`, `target`, `max_limit`, `burst_limit`, `burst_threshold`, `burst_time`, `priority`, `comment`, `disabled`, `rate`, `packet_rate`, `bytes`, `packets`) VALUES ('*D03', 'ROUTER-MK-02', '<pppoe-14002018>', '<pppoe-14002018>', '30000000/30000000', '0/0', '0/0', '0s/0s', '8/8', 'Simple Queue Rule', 0, NULL, NULL, '235057410/4424680941', '1028344/3720046');
INSERT INTO `router_queues` (`id`, `router_id`, `name`, `target`, `max_limit`, `burst_limit`, `burst_threshold`, `burst_time`, `priority`, `comment`, `disabled`, `rate`, `packet_rate`, `bytes`, `packets`) VALUES ('*D04', 'ROUTER-MK-02', '<pppoe-masrahmat>', '<pppoe-masrahmat>', '30000000/30000000', '0/0', '0/0', '0s/0s', '8/8', 'Simple Queue Rule', 0, NULL, NULL, '622705109/11871502994', '3514865/9865256');
INSERT INTO `router_queues` (`id`, `router_id`, `name`, `target`, `max_limit`, `burst_limit`, `burst_threshold`, `burst_time`, `priority`, `comment`, `disabled`, `rate`, `packet_rate`, `bytes`, `packets`) VALUES ('*D05', 'ROUTER-MK-02', '<pppoe-0040054200244>', '<pppoe-0040054200244>', '30000000/30000000', '0/0', '0/0', '0s/0s', '8/8', 'Simple Queue Rule', 0, NULL, NULL, '72838006/610363978', '261228/562533');
INSERT INTO `router_queues` (`id`, `router_id`, `name`, `target`, `max_limit`, `burst_limit`, `burst_threshold`, `burst_time`, `priority`, `comment`, `disabled`, `rate`, `packet_rate`, `bytes`, `packets`) VALUES ('*D06', 'ROUTER-MK-02', '<pppoe-0040054200240>', '<pppoe-0040054200240>', '30000000/30000000', '0/0', '0/0', '0s/0s', '8/8', 'Simple Queue Rule', 0, NULL, NULL, '97669531/1600053427', '339896/1369070');
INSERT INTO `router_queues` (`id`, `router_id`, `name`, `target`, `max_limit`, `burst_limit`, `burst_threshold`, `burst_time`, `priority`, `comment`, `disabled`, `rate`, `packet_rate`, `bytes`, `packets`) VALUES ('*D07', 'ROUTER-MK-02', '<pppoe-14002012>', '<pppoe-14002012>', '30000000/30000000', '0/0', '0/0', '0s/0s', '8/8', 'Simple Queue Rule', 0, NULL, NULL, '423004033/7190397802', '1864681/6218142');
INSERT INTO `router_queues` (`id`, `router_id`, `name`, `target`, `max_limit`, `burst_limit`, `burst_threshold`, `burst_time`, `priority`, `comment`, `disabled`, `rate`, `packet_rate`, `bytes`, `packets`) VALUES ('q-ROUTER-MK-02-7720', 'ROUTER-MK-02', 'test-self noc', '192.168.1000/24', '20M/50M', '30M/75M', '15M/35M', '8s/8s', '8/8', 'Bandwidth Limiter Simple Queue', 0, NULL, NULL, '0 B / 0 B', '0 / 0');
INSERT INTO `router_queues` (`id`, `router_id`, `name`, `target`, `max_limit`, `burst_limit`, `burst_threshold`, `burst_time`, `priority`, `comment`, `disabled`, `rate`, `packet_rate`, `bytes`, `packets`) VALUES ('*CBE', 'ROUTER-MK-02', '<pppoe-tenant-stc-30>', '<pppoe-tenant-stc-30>', '50M/50M', '0/0', '0/0', '0s/0s', '8/8', 'Tenant Sukaramai Trade Center PKU', 0, NULL, NULL, '260004329/14208053708', '1222667/6509411');
INSERT INTO `router_queues` (`id`, `router_id`, `name`, `target`, `max_limit`, `burst_limit`, `burst_threshold`, `burst_time`, `priority`, `comment`, `disabled`, `rate`, `packet_rate`, `bytes`, `packets`) VALUES ('*CBF', 'ROUTER-MK-02', '<pppoe-tenant-stc-31>', '<pppoe-tenant-stc-31>', '100M/100M', '0/0', '0/0', '0s/0s', '8/8', 'Tenant Sukaramai Trade Center PKU', 0, NULL, NULL, '903919047/12309596842', '1931730/8382059');
INSERT INTO `router_queues` (`id`, `router_id`, `name`, `target`, `max_limit`, `burst_limit`, `burst_threshold`, `burst_time`, `priority`, `comment`, `disabled`, `rate`, `packet_rate`, `bytes`, `packets`) VALUES ('*CC0', 'ROUTER-MK-02', '<pppoe-tenant-stc-32>', '<pppoe-tenant-stc-32>', '50M/50M', '0/0', '0/0', '0s/0s', '8/8', 'Tenant Sukaramai Trade Center PKU', 0, NULL, NULL, '3477750956/4193499532', '3387475/9880450');
INSERT INTO `router_queues` (`id`, `router_id`, `name`, `target`, `max_limit`, `burst_limit`, `burst_threshold`, `burst_time`, `priority`, `comment`, `disabled`, `rate`, `packet_rate`, `bytes`, `packets`) VALUES ('*CC1', 'ROUTER-MK-02', '<pppoe-tenant-stc-33>', '<pppoe-tenant-stc-33>', '100M/100M', '0/0', '0/0', '0s/0s', '8/8', 'Tenant Sukaramai Trade Center PKU', 0, NULL, NULL, '612684496/7821142621', '4789505/8866898');
INSERT INTO `router_queues` (`id`, `router_id`, `name`, `target`, `max_limit`, `burst_limit`, `burst_threshold`, `burst_time`, `priority`, `comment`, `disabled`, `rate`, `packet_rate`, `bytes`, `packets`) VALUES ('*CC2', 'ROUTER-MK-02', '<pppoe-tenant-stc-34>', '<pppoe-tenant-stc-34>', '50M/50M', '0/0', '0/0', '0s/0s', '8/8', 'Tenant Sukaramai Trade Center PKU', 0, NULL, NULL, '3261400650/13192797014', '2019688/6271669');
INSERT INTO `router_queues` (`id`, `router_id`, `name`, `target`, `max_limit`, `burst_limit`, `burst_threshold`, `burst_time`, `priority`, `comment`, `disabled`, `rate`, `packet_rate`, `bytes`, `packets`) VALUES ('*CC3', 'ROUTER-MK-02', '<pppoe-tenant-stc-35>', '<pppoe-tenant-stc-35>', '100M/100M', '0/0', '0/0', '0s/0s', '8/8', 'Tenant Sukaramai Trade Center PKU', 0, NULL, NULL, '2103900736/13154048338', '3419539/4071729');
INSERT INTO `router_queues` (`id`, `router_id`, `name`, `target`, `max_limit`, `burst_limit`, `burst_threshold`, `burst_time`, `priority`, `comment`, `disabled`, `rate`, `packet_rate`, `bytes`, `packets`) VALUES ('*CC4', 'ROUTER-MK-02', '<pppoe-tenant-stc-36>', '<pppoe-tenant-stc-36>', '50M/50M', '0/0', '0/0', '0s/0s', '8/8', 'Tenant Sukaramai Trade Center PKU', 0, NULL, NULL, '3950046645/782355406', '1643309/10157571');
INSERT INTO `router_queues` (`id`, `router_id`, `name`, `target`, `max_limit`, `burst_limit`, `burst_threshold`, `burst_time`, `priority`, `comment`, `disabled`, `rate`, `packet_rate`, `bytes`, `packets`) VALUES ('*CC5', 'ROUTER-MK-02', '<pppoe-tenant-stc-37>', '<pppoe-tenant-stc-37>', '100M/100M', '0/0', '0/0', '0s/0s', '8/8', 'Tenant Sukaramai Trade Center PKU', 0, NULL, NULL, '2427372630/10675918747', '951521/1291865');
INSERT INTO `router_queues` (`id`, `router_id`, `name`, `target`, `max_limit`, `burst_limit`, `burst_threshold`, `burst_time`, `priority`, `comment`, `disabled`, `rate`, `packet_rate`, `bytes`, `packets`) VALUES ('*CC6', 'ROUTER-MK-02', '<pppoe-tenant-stc-38>', '<pppoe-tenant-stc-38>', '50M/50M', '0/0', '0/0', '0s/0s', '8/8', 'Tenant Sukaramai Trade Center PKU', 0, NULL, NULL, '2523691726/1604805508', '1894847/8202781');
INSERT INTO `router_queues` (`id`, `router_id`, `name`, `target`, `max_limit`, `burst_limit`, `burst_threshold`, `burst_time`, `priority`, `comment`, `disabled`, `rate`, `packet_rate`, `bytes`, `packets`) VALUES ('*CC7', 'ROUTER-MK-02', '<pppoe-tenant-stc-39>', '<pppoe-tenant-stc-39>', '100M/100M', '0/0', '0/0', '0s/0s', '8/8', 'Tenant Sukaramai Trade Center PKU', 0, NULL, NULL, '3564895304/14148127241', '349277/3279960');
INSERT INTO `router_queues` (`id`, `router_id`, `name`, `target`, `max_limit`, `burst_limit`, `burst_threshold`, `burst_time`, `priority`, `comment`, `disabled`, `rate`, `packet_rate`, `bytes`, `packets`) VALUES ('*CC8', 'ROUTER-MK-02', '<pppoe-tenant-stc-40>', '<pppoe-tenant-stc-40>', '50M/50M', '0/0', '0/0', '0s/0s', '8/8', 'Tenant Sukaramai Trade Center PKU', 0, NULL, NULL, '3585462076/3612345905', '453956/13659423');
INSERT INTO `router_queues` (`id`, `router_id`, `name`, `target`, `max_limit`, `burst_limit`, `burst_threshold`, `burst_time`, `priority`, `comment`, `disabled`, `rate`, `packet_rate`, `bytes`, `packets`) VALUES ('q-ROUTER-MK-02-5364', 'ROUTER-MK-02', 'test self nox', '10.20.10.76/32', '20M/50M', '30M/75M', '15M/35M', '8s/8s', '8/8', 'Bandwidth Limiter Simple Queue', 0, NULL, NULL, '0 B / 0 B', '0 / 0');
INSERT INTO `router_queues` (`id`, `router_id`, `name`, `target`, `max_limit`, `burst_limit`, `burst_threshold`, `burst_time`, `priority`, `comment`, `disabled`, `rate`, `packet_rate`, `bytes`, `packets`) VALUES ('q-ROUTER-MK-02-2194', 'ROUTER-MK-02', 'self_noc', '192.168.100.0/24', '20M/50M', '30M/75M', '15M/35M', '8s/8s', '8/8', 'Bandwidth Limiter Simple Queue', 0, NULL, NULL, '0 B / 0 B', '0 / 0');
INSERT INTO `router_queues` (`id`, `router_id`, `name`, `target`, `max_limit`, `burst_limit`, `burst_threshold`, `burst_time`, `priority`, `comment`, `disabled`, `rate`, `packet_rate`, `bytes`, `packets`) VALUES ('q-qs-1', 'ROUTER-MK-03', 'queue-tenant-a1', '10.20.10.21/32', '100M/100M', '150M/150M', '80M/80M', '16/16', '3/3', 'Bandwidth QoS Tenant A1 Ground Floor', 0, NULL, NULL, '6.06 GB', 4891020);
INSERT INTO `router_queues` (`id`, `router_id`, `name`, `target`, `max_limit`, `burst_limit`, `burst_threshold`, `burst_time`, `priority`, `comment`, `disabled`, `rate`, `packet_rate`, `bytes`, `packets`) VALUES ('q-qs-2', 'ROUTER-MK-03', 'queue-office-pdt', '10.20.10.23/32', '200M/200M', '250M/250M', '180M/180M', '16/16', '1/1', 'Priority QoS Kantor Operasional PDT Cibinong', 0, NULL, NULL, '23.31 GB', 19810200);
INSERT INTO `router_queues` (`id`, `router_id`, `name`, `target`, `max_limit`, `burst_limit`, `burst_threshold`, `burst_time`, `priority`, `comment`, `disabled`, `rate`, `packet_rate`, `bytes`, `packets`) VALUES ('q-qs-3', 'ROUTER-MK-03', 'queue-hotspot-mall', '172.16.10.0/24', '50M/100M', '80M/120M', '40M/80M', '10/10', '5/5', 'Aggregate Limit Hotspot Publik QSquare', 0, NULL, NULL, '45.12 GB', 38910200);
INSERT INTO `router_queues` (`id`, `router_id`, `name`, `target`, `max_limit`, `burst_limit`, `burst_threshold`, `burst_time`, `priority`, `comment`, `disabled`, `rate`, `packet_rate`, `bytes`, `packets`) VALUES ('*8', 'ROUTER-MK-01', 'self noc', '192.168.100.0/24', '20000000/50000000', '30000000/75000000', '15000000/35000000', '8s/8s', '8/8', 'Bandwidth Limiter Simple Queue', 0, NULL, NULL, '0/0', '0/0');

-- --------------------------------------------------------
-- 8. Additional Application Tables
-- --------------------------------------------------------
DROP TABLE IF EXISTS `announcements`;
CREATE TABLE `announcements` (
  `id` varchar(50) NOT NULL,
  `title` varchar(200) NOT NULL,
  `message` text NOT NULL,
  `target_location` varchar(100) DEFAULT 'ALL',
  `level` varchar(50) DEFAULT 'INFO',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `tickets`;
CREATE TABLE `tickets` (
  `id` varchar(50) NOT NULL,
  `customer_id` varchar(50) NOT NULL,
  `customer_name` varchar(150) DEFAULT NULL,
  `site_location` varchar(100) DEFAULT NULL,
  `category` varchar(100) DEFAULT 'INTERNET_SLOW',
  `description` text NOT NULL,
  `status` varchar(50) DEFAULT 'OPEN',
  `priority` varchar(50) DEFAULT 'MEDIUM',
  `technician` varchar(100) DEFAULT NULL,
  `sla` varchar(50) DEFAULT '4h',
  `solution` text DEFAULT NULL,
  `created_at` varchar(50) DEFAULT NULL,
  `resolved_at` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `upgrade_requests`;
CREATE TABLE `upgrade_requests` (
  `id` varchar(50) NOT NULL,
  `customer_id` varchar(50) NOT NULL,
  `customer_name` varchar(150) DEFAULT NULL,
  `from_package` varchar(100) DEFAULT NULL,
  `to_package` varchar(100) DEFAULT NULL,
  `target_package_id` varchar(50) DEFAULT NULL,
  `type` varchar(50) DEFAULT 'UPGRADE',
  `request_date` varchar(50) DEFAULT NULL,
  `effective_date` varchar(50) DEFAULT NULL,
  `status` varchar(50) DEFAULT 'PENDING',
  `note` text DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `speedtest_history`;
CREATE TABLE `speedtest_history` (
  `id` varchar(50) NOT NULL,
  `customer_id` varchar(50) NOT NULL,
  `timestamp` varchar(50) DEFAULT NULL,
  `server` varchar(100) DEFAULT 'PDT Jakarta Core',
  `ping` decimal(10,2) DEFAULT 0.00,
  `jitter` decimal(10,2) DEFAULT 0.00,
  `download` decimal(10,2) DEFAULT 0.00,
  `upload` decimal(10,2) DEFAULT 0.00,
  `rating` varchar(50) DEFAULT 'EXCELLENT',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `technicians`;
CREATE TABLE `technicians` (
  `id` varchar(50) NOT NULL,
  `name` varchar(150) NOT NULL,
  `role` varchar(100) DEFAULT 'Field Technician',
  `site` varchar(100) DEFAULT 'ALL',
  `phone` varchar(50) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `status` varchar(50) DEFAULT 'AVAILABLE',
  `completed_today` int DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `devices`;
CREATE TABLE `devices` (
  `id` varchar(50) NOT NULL,
  `name` varchar(150) NOT NULL,
  `device_type` varchar(50) DEFAULT 'OLT',
  `merek` varchar(100) DEFAULT 'ZTE',
  `model` varchar(100) DEFAULT 'C320',
  `host` varchar(100) DEFAULT NULL,
  `ip` varchar(100) DEFAULT NULL,
  `port` int DEFAULT 23,
  `username` varchar(100) DEFAULT 'admin',
  `password` varchar(150) DEFAULT '',
  `coordinates` varchar(100) DEFAULT NULL,
  `coverage` varchar(100) DEFAULT NULL,
  `enabled` tinyint(1) DEFAULT 1,
  `site_location` varchar(100) DEFAULT NULL,
  `status` varchar(50) DEFAULT 'ONLINE',
  `uptime` varchar(50) DEFAULT '30d 12h',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `olt_pon_ports`;
CREATE TABLE `olt_pon_ports` (
  `id` varchar(50) NOT NULL,
  `olt_id` varchar(50) NOT NULL,
  `port_name` varchar(100) NOT NULL,
  `description` varchar(150) DEFAULT NULL,
  `status` varchar(50) DEFAULT 'UP',
  `total_onu` int DEFAULT 0,
  `online_onu` int DEFAULT 0,
  `offline_onu` int DEFAULT 0,
  `los_onu` int DEFAULT 0,
  `rx_power_avg` varchar(50) DEFAULT '-18.5 dBm',
  `tx_power` varchar(50) DEFAULT '+2.5 dBm',
  `traffic_rx_mbps` decimal(10,2) DEFAULT 0.00,
  `traffic_tx_mbps` decimal(10,2) DEFAULT 0.00,
  `sfp_temperature` varchar(50) DEFAULT '42°C',
  `sfp_voltage` varchar(50) DEFAULT '3.3V',
  `bias_current` varchar(50) DEFAULT '15mA',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `whatsapp_gateway`;
CREATE TABLE `whatsapp_gateway` (
  `id` int NOT NULL AUTO_INCREMENT,
  `instance_name` varchar(100) DEFAULT 'PDT-Pedee WA Center',
  `status` varchar(50) DEFAULT 'CONNECTED',
  `sender_phone` varchar(50) DEFAULT '081288229100',
  `profile_name` varchar(100) DEFAULT 'PDT-Pedee NOC',
  `battery_level` varchar(20) DEFAULT '98%',
  `last_connected` varchar(50) DEFAULT NULL,
  `total_sent_today` int DEFAULT 0,
  `webhook_status` varchar(50) DEFAULT 'ACTIVE',
  `wa_gateway_type` varchar(50) DEFAULT 'FONNTE',
  `fonnte_token` varchar(255) DEFAULT '',
  `fonnte_api_url` varchar(255) DEFAULT 'https://api.fonnte.com/send',
  `fonnte_country_code` varchar(10) DEFAULT '62',
  `meta_phone_number_id` varchar(100) DEFAULT '',
  `meta_access_token` text DEFAULT NULL,
  `meta_verify_token` varchar(100) DEFAULT 'pedee_isp_token_2026',
  `meta_business_phone` varchar(50) DEFAULT '',
  `whatsapp_enabled` tinyint(1) DEFAULT 1,
  `whatsapp_admin_numbers` text DEFAULT NULL,
  `company_header` varchar(150) DEFAULT 'PT Prasetia Dwidharma Teknologi (PDT-Pedee)',
  `company_phone` varchar(50) DEFAULT '081288229100',
  `footer_info` text DEFAULT NULL,
  `payment_success_template` text DEFAULT NULL,
  `rate_limiting` varchar(100) DEFAULT '5 msg/sec',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `whatsapp_logs`;
CREATE TABLE `whatsapp_logs` (
  `id` varchar(50) NOT NULL,
  `timestamp` varchar(50) DEFAULT NULL,
  `recipient_phone` varchar(50) DEFAULT NULL,
  `recipient_name` varchar(150) DEFAULT NULL,
  `link_id` varchar(50) DEFAULT NULL,
  `invoice_id` varchar(50) DEFAULT NULL,
  `type` varchar(50) DEFAULT 'INVOICE_NOTIFICATION',
  `amount` decimal(15,2) DEFAULT 0.00,
  `month` varchar(50) DEFAULT NULL,
  `status` varchar(50) DEFAULT 'SENT',
  `message_snippet` text DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `announcements` (`id`, `title`, `message`, `target_location`, `level`, `created_at`) VALUES ('ANN-202609-01', 'Pemeliharaan Rutin OLT Serpong & Re-splicing Fiber', 'Pemberitahuan pekerjaan maintenance core switch OLT ZTE Gading Serpong pada 12 Sept 2026 pkl 01:00-03:00 WIB. Pelanggan area Gading Serpong mungkin mengalami penurunan sinyal sesaat.', 'Cluster Gading Serpong, Tangerang', 'WARNING', '04 September 2026');
INSERT INTO `announcements` (`id`, `title`, `message`, `target_location`, `level`, `created_at`) VALUES ('ANN-202609-02', 'Optimasi Latensi Jalur Internasional BSD City Selesai', 'Jalur routing fiber optik bawah tanah ke IDC DCI Indonesia di BSD City telah aktif 100% dengan rata-rata ping gaming 6ms.', 'Cluster BSD City, Tangerang Selatan', 'INFO', '03 September 2026');
INSERT INTO `announcements` (`id`, `title`, `message`, `target_location`, `level`, `created_at`) VALUES ('ANN-202609-03', 'Perbaikan Kabel Feeder Udara Kebon Jeruk', 'Tim teknisi lapangan sedang melakukan perapihan kabel fiber optik tiang ODP pasca perantingan pohon di Jl. Surya Utama.', 'Area Kebon Jeruk, Jakarta Barat', 'WARNING', '02 September 2026');
INSERT INTO `announcements` (`id`, `title`, `message`, `target_location`, `level`, `created_at`) VALUES ('ANN-202609-04', 'Layanan Pelanggan & Payment Gateway Nasional Aktif 24 Jam', 'Kini verifikasi pembayaran instan via QRIS dan Virtual Account Bank berjalan 24 jam otomatis tanpa jeda proses perbankan.', 'Semua Lokasi / Global', 'INFO', '01 September 2026');
INSERT INTO `tickets` (`id`, `customer_id`, `customer_name`, `site_location`, `category`, `description`, `status`, `priority`, `technician`, `sla`, `solution`, `created_at`, `resolved_at`) VALUES ('PDT-TK-5377', 'PDT-2024-88910', 'Ahmad Rizky Pratama', 'Cluster Gading Serpong, Tangerang', 'Gangguan Koneksi Putus / LOS', 'Tolong dibantu chek', 'RESOLVED', 'HIGH', 'Tim Reaksi Cepat (Cluster Gading Serpong)', 'Maksimal 3 Jam Kerja', 'Kabel fiber telah disambung ulang oleh teknisi.', '05 September 2026 20.03 WIB', '05 September 2026 20.04 WIB');
INSERT INTO `tickets` (`id`, `customer_id`, `customer_name`, `site_location`, `category`, `description`, `status`, `priority`, `technician`, `sla`, `solution`, `created_at`, `resolved_at`) VALUES ('PDT-TK-8021', 'PDT-2024-88910', 'Ahmad Rizky Pratama', 'Cluster Gading Serpong, Tangerang', 'Jaringan Lambat / Fluktuatif', 'Tes kecepatan di malam hari sempat turun ke 45 Mbps saat hujan deras.', 'RESOLVED', 'MEDIUM', 'Rendra Saputra (Teknisi Area Gading Serpong)', NULL, 'Optimasi redaman ODP terdekat dan re-balancing jalur fiber optik distribution.', '15 Agustus 2026 19:30 WIB', '15 Agustus 2026 21:10 WIB');
INSERT INTO `upgrade_requests` (`id`, `customer_id`, `customer_name`, `from_package`, `to_package`, `target_package_id`, `type`, `request_date`, `effective_date`, `status`, `note`) VALUES ('REQ-202605-0012', 'PDT-2024-88910', 'Ahmad Rizky Pratama', 'PDT-Pedee Home (50 Mbps)', 'PDT-Pedee Prime (100 Mbps)', 'prime-100', 'UPGRADE', '10 Mei 2026', '12 Mei 2026', 'APPROVED', 'Migrasi berhasil secara otomatis tanpa penggantian modem.');
INSERT INTO `speedtest_history` (`id`, `customer_id`, `timestamp`, `server`, `ping`, `jitter`, `download`, `upload`, `rating`) VALUES ('SP-8738', 'PDT-2026-55833', '07 September 2026 19.29 WIB', 'PDT-Pedee Core Datacenter Cyber 1, Jakarta', 106.8, 23.8, 30.3, 30.2, 'Cukup Baik');
INSERT INTO `speedtest_history` (`id`, `customer_id`, `timestamp`, `server`, `ping`, `jitter`, `download`, `upload`, `rating`) VALUES ('SP-2784', 'PDT-2026-55833', '07 September 2026 19.26 WIB', 'PDT-Pedee Core Datacenter Cyber 1, Jakarta', 28.7, 63.3, 29.6, 30, 'Cukup Baik');
INSERT INTO `speedtest_history` (`id`, `customer_id`, `timestamp`, `server`, `ping`, `jitter`, `download`, `upload`, `rating`) VALUES ('SP-101', 'PDT-2024-88910', '04 September 2026 10:15 WIB', 'PDT-Pedee Cyber Datacenter Jakarta', 8.2, 1.4, 102.4, 98.7, 'Sempurna (100% SLA)');
INSERT INTO `technicians` (`id`, `name`, `role`, `site`, `phone`, `email`, `status`, `completed_today`) VALUES ('TKT-01', 'Joko Susilo', 'Lead Optical Splicer', 'Cluster Gading Serpong, Tangerang', '08128822001', 'joko.susilo@pdtpedee.id', 'ON_DUTY', 4);
INSERT INTO `technicians` (`id`, `name`, `role`, `site`, `phone`, `email`, `status`, `completed_today`) VALUES ('TKT-02', 'Dani Pratama', 'OLT ZTE & GPON Specialist', 'Cluster BSD City, Tangerang Selatan', '08139988002', 'dani.pratama@pdtpedee.id', 'STANDBY', 2);
INSERT INTO `technicians` (`id`, `name`, `role`, `site`, `phone`, `email`, `status`, `completed_today`) VALUES ('TKT-03', 'Ilham Saputra', 'FTTH Drop Core Technician', 'Area Kebon Jeruk, Jakarta Barat', '08117766003', 'ilham.saputra@pdtpedee.id', 'ON_DUTY', 5);
INSERT INTO `technicians` (`id`, `name`, `role`, `site`, `phone`, `email`, `status`, `completed_today`) VALUES ('TKT-04', 'Rian Maulana', 'Backbone Fiber & OTDR Engineer', 'Semua Lokasi / Global', '08156677004', 'rian.maulana@pdtpedee.id', 'STANDBY', 1);
INSERT INTO `devices` (`id`, `name`, `device_type`, `merek`, `model`, `host`, `ip`, `port`, `username`, `password`, `coordinates`, `coverage`, `enabled`, `site_location`, `status`, `uptime`) VALUES ('ROUTER-MK-02', 'CPE Sukaramai Trade Center', 'ROUTER_MIKROTIK', 'MikroTik', 'MikroTik CCR1036-8G-2S+', '85.137.29.14', '85.137.29.14', 161, 'selfnoc', 'Qwerty2026#!', '-6.255823, 106.621945', '5000', 1, 'Cluster Gading Serpong, Tangerang', 'ONLINE', '1 hari, 04 jam');
INSERT INTO `devices` (`id`, `name`, `device_type`, `merek`, `model`, `host`, `ip`, `port`, `username`, `password`, `coordinates`, `coverage`, `enabled`, `site_location`, `status`, `uptime`) VALUES ('ROUTER-MK-03', 'CPE-Qsquare', 'ROUTER_MIKROTIK', 'MikroTik', 'MikroTik CCR2004-1G-12S+2XS', '103.188.177.162', NULL, 161, 'selfnoc', 'Qwerty2026#!', '-6.255823, 106.621945', '5000', 1, 'QSquare Cibinong', 'ONLINE', '1 hari, 04 jam');
INSERT INTO `olt_pon_ports` (`id`, `olt_id`, `port_name`, `description`, `status`, `total_onu`, `online_onu`, `offline_onu`, `los_onu`, `rx_power_avg`, `tx_power`, `traffic_rx_mbps`, `traffic_tx_mbps`, `sfp_temperature`, `sfp_voltage`, `bias_current`) VALUES ('PORT-01', 'OLT-ZTE-01', 'gpon-olt_1/1/1', 'Feeder Cluster Gading Serpong Sektor Barat', 'UP', 33, 30, 3, 1, '-20.4 dBm', '+2.8 dBm', 184.2, 452.8, '43.5°C', '3.31 V', '14.2 mA');
INSERT INTO `olt_pon_ports` (`id`, `olt_id`, `port_name`, `description`, `status`, `total_onu`, `online_onu`, `offline_onu`, `los_onu`, `rx_power_avg`, `tx_power`, `traffic_rx_mbps`, `traffic_tx_mbps`, `sfp_temperature`, `sfp_voltage`, `bias_current`) VALUES ('PORT-02', 'OLT-ZTE-01', 'gpon-olt_1/1/2', 'Feeder Cluster Gading Serpong Sektor Timur', 'UP', 31, 29, 2, 0, '-19.1 dBm', '+3.0 dBm', 142.6, 388.1, '42.8°C', '3.32 V', '13.9 mA');
INSERT INTO `olt_pon_ports` (`id`, `olt_id`, `port_name`, `description`, `status`, `total_onu`, `online_onu`, `offline_onu`, `los_onu`, `rx_power_avg`, `tx_power`, `traffic_rx_mbps`, `traffic_tx_mbps`, `sfp_temperature`, `sfp_voltage`, `bias_current`) VALUES ('PORT-03', 'OLT-HW-01', 'gpon-olt_1/1/1', 'Feeder BSD City The Icon & Green Cove', 'UP', 28, 26, 2, 1, '-21.2 dBm', '+2.6 dBm', 210.5, 520.4, '44.1°C', '3.30 V', '14.8 mA');
INSERT INTO `olt_pon_ports` (`id`, `olt_id`, `port_name`, `description`, `status`, `total_onu`, `online_onu`, `offline_onu`, `los_onu`, `rx_power_avg`, `tx_power`, `traffic_rx_mbps`, `traffic_tx_mbps`, `sfp_temperature`, `sfp_voltage`, `bias_current`) VALUES ('PORT-04', 'OLT-FH-01', 'gpon-olt_1/1/1', 'Feeder Kebon Jeruk & Meruya Residen', 'UP', 25, 21, 4, 2, '-22.8 dBm', '+2.4 dBm', 115, 310.2, '45.0°C', '3.29 V', '15.1 mA');
INSERT INTO `whatsapp_gateway` (`id`, `instance_name`, `status`, `sender_phone`, `profile_name`, `battery_level`, `last_connected`, `total_sent_today`, `webhook_status`, `wa_gateway_type`, `fonnte_token`, `fonnte_api_url`, `fonnte_country_code`, `meta_phone_number_id`, `meta_access_token`, `meta_verify_token`, `meta_business_phone`, `whatsapp_enabled`, `whatsapp_admin_numbers`, `company_header`, `company_phone`, `footer_info`, `payment_success_template`, `rate_limiting`) VALUES (1, 'PDT-PEDEE-BILLING-BOT', 'CONNECTED', '+62 811-9288-700', 'PDT-Pedee Official Care & Billing', 98, '2026-09-05T12:15:00.000Z', 160, 'ACTIVE', 'baileys', 'FONNTE-PDTPEDEE-SEC-99182', 'https://api.fonnte.com/send', '62', '109283749102834', 'EAABwz9821098492817290184712903', 'antigravity_meta_wa_secret', '+62 811-9288-700', 1, '["08119288700","081288229100"]', 'PDT-PEDEE WEBPORTAL', '+62 811-9288-700', 'PT Prasetia Dwidharma Teknologi', '🧾 *BUKTI PEMBAYARAN RESMI (LUNAS)*
🏢 *{{company}}*
────────────────────────────
Yth. Pelanggan *{{nama}}*,

Terima kasih, pembayaran tagihan internet Anda telah kami terima dan diverifikasi.

📋 *Rincian Pembayaran:*
• *No. Invoice:* #INV-{{no_invoice}}
• *ID Pelanggan:* {{username}}
• *Paket Layanan:* {{paket}}
• *Periode:* {{periode}}
• *Waktu Bayar:* {{waktu}}
• *Metode Bayar:* {{metode}}
• *Total Bayar:* *Rp {{total}}*
• *Status:* *LUNAS ✅*

🌐 *Status Layanan:*
Layanan internet Anda saat ini dalam status *AKTIF* dan dapat digunakan dengan nyaman.

────────────────────────────
🔗 *Cek Tagihan / Riwayat:*
{{link_portal}}

📞 *Bantuan & Layanan Pelanggan:*
WhatsApp: {{company_phone}}

_Simpan pesan ini sebagai bukti pembayaran yang sah dari {{company}}._', '{"max_commands_per_minute":10,"cooldown_ms":2000}');
INSERT INTO `whatsapp_logs` (`id`, `timestamp`, `recipient_phone`, `recipient_name`, `link_id`, `invoice_id`, `type`, `amount`, `month`, `status`, `message_snippet`) VALUES ('WAL-1788784037140-530', '07 September 2026 19.27 WIB', '085779099018', 'test1', 'LNK-GS-21949', 'INV-202609-4595', 'PAYMENT_RECEIPT_SUCCESS', 194456, 'Oktober 2026', 'DELIVERED', '🧾 *BUKTI PEMBAYARAN RESMI (LUNAS)*
🏢 *PT Prasetia Dwidharma Teknologi*
────────────────────────────
Yth. Pelanggan *test1*,

Terima kasih, pembayaran tagihan ...');
INSERT INTO `whatsapp_logs` (`id`, `timestamp`, `recipient_phone`, `recipient_name`, `link_id`, `invoice_id`, `type`, `amount`, `month`, `status`, `message_snippet`) VALUES ('WAL-1788617689103-146', '05 September 2026 21.14 WIB', '085779099018', 'test1', 'LNK-GS-21949', 'INV-202609-4595', 'PAYMENT_WAITING_CONFIRMATION', 194456, 'Oktober 2026', 'DELIVERED', 'Konfirmasi bayar invoice #INV-202609-4595 diajukan pelanggan via Mandiri Virtual Account (Menunggu Approval Admin).');
INSERT INTO `whatsapp_logs` (`id`, `timestamp`, `recipient_phone`, `recipient_name`, `link_id`, `invoice_id`, `type`, `amount`, `month`, `status`, `message_snippet`) VALUES ('WAL-1788617510333-166', '5/9/2026, 21.11.50 WIB', '6285779099018', 'test1', 'LNK-GS-21949', 'INV-202609-4595', 'DIRECT_INVOICE_REMINDER', 194456, 'Oktober 2026', 'DELIVERED', 'Yth. Bpk/Ibu test1 (LNK-GS-21949),

Pemberitahuan Tagihan Layanan Internet PDT-Pedee Fiber:
• No Invoice: INV-202609-4595
• Periode: Oktober 2026
• Total Tagiha...');
INSERT INTO `whatsapp_logs` (`id`, `timestamp`, `recipient_phone`, `recipient_name`, `link_id`, `invoice_id`, `type`, `amount`, `month`, `status`, `message_snippet`) VALUES ('WAL-1788617411740-452', '05 September 2026 21.10 WIB', '081399881122', 'Siti Nurhaliza', 'LNK-BSD-55421', 'INV-202610-7466', 'PAYMENT_RECEIPT_SUCCESS', 618998, 'Oktober 2026', 'DELIVERED', '🧾 *BUKTI PEMBAYARAN RESMI (LUNAS)*
🏢 *PT Prasetia Dwidharma Teknologi*
────────────────────────────
Yth. Pelanggan *Siti Nurhaliza*,

Terima kasih, pembayaran...');
INSERT INTO `whatsapp_logs` (`id`, `timestamp`, `recipient_phone`, `recipient_name`, `link_id`, `invoice_id`, `type`, `amount`, `month`, `status`, `message_snippet`) VALUES ('WAL-1788617411726-242', '05 September 2026 21.10 WIB', '081399881122', 'Siti Nurhaliza', 'LNK-BSD-55421', 'INV-202610-7466', 'PAYMENT_WAITING_CONFIRMATION', 618998, 'Oktober 2026', 'DELIVERED', 'Konfirmasi bayar invoice #INV-202610-7466 diajukan pelanggan via QRIS Dinamis (Menunggu Approval Admin).');
INSERT INTO `whatsapp_logs` (`id`, `timestamp`, `recipient_phone`, `recipient_name`, `link_id`, `invoice_id`, `type`, `amount`, `month`, `status`, `message_snippet`) VALUES ('WAL-1788616508322-235', '05 September 2026 20.55 WIB', '085779099018', 'test1', 'LNK-GS-21949', 'INV-202609-7468', 'PAYMENT_RECEIPT_SUCCESS', 194456, 'September 2026', 'DELIVERED', '🧾 *BUKTI PEMBAYARAN RESMI (LUNAS)*
🏢 *PT Prasetia Dwidharma Teknologi*
────────────────────────────
Yth. Pelanggan *test1*,

Terima kasih, pembayaran tagihan ...');
INSERT INTO `whatsapp_logs` (`id`, `timestamp`, `recipient_phone`, `recipient_name`, `link_id`, `invoice_id`, `type`, `amount`, `month`, `status`, `message_snippet`) VALUES ('WAL-1788614204097-173', '5/9/2026, 20.16.44 WIB', '6281399881122', 'Siti Nurhaliza', 'LNK-BSD-55421', 'INV-202610-7466', 'DIRECT_INVOICE_REMINDER', 618998, 'Oktober 2026', 'DELIVERED', 'Yth. Bpk/Ibu Siti Nurhaliza (LNK-BSD-55421),

Pemberitahuan Tagihan Layanan Internet PDT-Pedee Fiber:
• No Invoice: INV-202610-7466
• Periode: Oktober 2026
• To...');
INSERT INTO `whatsapp_logs` (`id`, `timestamp`, `recipient_phone`, `recipient_name`, `link_id`, `invoice_id`, `type`, `amount`, `month`, `status`, `message_snippet`) VALUES ('WAL-1788613208593-731', '5/9/2026 20.00.08 WIB', '081177665544', 'Budi Hartono', 'LNK-KJ-11209', 'INV-202610-6668', 'PAYMENT_RECEIPT_SUCCESS', 314573, 'Oktober 2026', 'DELIVERED', '🧾 *BUKTI PEMBAYARAN RESMI (LUNAS)*
🏢 *PT Prasetia Dwidharma Teknologi*
────────────────────────────
Yth. Pelanggan *Budi Hartono*,

Terima kasih, pembayaran t...');
INSERT INTO `whatsapp_logs` (`id`, `timestamp`, `recipient_phone`, `recipient_name`, `link_id`, `invoice_id`, `type`, `amount`, `month`, `status`, `message_snippet`) VALUES ('WAL-1788612509289-226', '5/9/2026 19.48.29 WIB', '081299887766', 'Hendra Gunawan', 'LNK-GLX-37256', 'INV-202610-6549', 'PAYMENT_RECEIPT_SUCCESS', 337123, 'Oktober 2026', 'DELIVERED', '🧾 *BUKTI PEMBAYARAN RESMI (LUNAS)*
🏢 *PT Prasetia Dwidharma Teknologi*
────────────────────────────
Yth. Pelanggan *Hendra Gunawan*,

Terima kasih, pembayaran...');
INSERT INTO `whatsapp_logs` (`id`, `timestamp`, `recipient_phone`, `recipient_name`, `link_id`, `invoice_id`, `type`, `amount`, `month`, `status`, `message_snippet`) VALUES ('WAL-1788611059779-792', '5/9/2026, 19.24.19 WIB', '6281299887766', 'Hendra Gunawan', 'LNK-GLX-37256', 'INV-202609-7695', 'BILLING_REMINDER_BROADCAST', 453990, 'September 2026', 'DELIVERED', 'Yth. Bpk/Ibu Hendra Gunawan (LNK-GLX-37256),

Pemberitahuan Tagihan Layanan Internet PDT-Pedee Fiber:
• No Invoice: INV-202609-7695
• Periode: September 2026
• ...');
INSERT INTO `whatsapp_logs` (`id`, `timestamp`, `recipient_phone`, `recipient_name`, `link_id`, `invoice_id`, `type`, `amount`, `month`, `status`, `message_snippet`) VALUES ('WAL-1788611059779-220', '5/9/2026, 19.24.19 WIB', '6281399881122', 'Siti Nurhaliza', 'LNK-BSD-55421', 'INV-202609-005519', 'BILLING_REMINDER_BROADCAST', 637140, 'September 2026', 'DELIVERED', 'Yth. Bpk/Ibu Siti Nurhaliza (LNK-BSD-55421),

Pemberitahuan Tagihan Layanan Internet PDT-Pedee Fiber:
• No Invoice: INV-202609-005519
• Periode: September 2026
...');
INSERT INTO `whatsapp_logs` (`id`, `timestamp`, `recipient_phone`, `recipient_name`, `link_id`, `invoice_id`, `type`, `amount`, `month`, `status`, `message_snippet`) VALUES ('WAL-1788611059779-252', '5/9/2026, 19.24.19 WIB', '6281288229100', 'Ahmad Rizky Pratama', 'LNK-GS-88910', 'INV-202609-004821', 'BILLING_REMINDER_BROADCAST', 432900, 'September 2026', 'DELIVERED', 'Yth. Bpk/Ibu Ahmad Rizky Pratama (LNK-GS-88910),

Pemberitahuan Tagihan Layanan Internet PDT-Pedee Fiber:
• No Invoice: INV-202609-004821
• Periode: September 2...');
INSERT INTO `whatsapp_logs` (`id`, `timestamp`, `recipient_phone`, `recipient_name`, `link_id`, `invoice_id`, `type`, `amount`, `month`, `status`, `message_snippet`) VALUES ('WAL-1788610975882-811', '5/9/2026, 19.22.55 WIB', '6281288229100', 'Ahmad Rizky Pratama', 'LNK-GS-88910', 'INV-202609-004821', 'DIRECT_INVOICE_REMINDER', 432900, 'September 2026', 'DELIVERED', 'Yth. Bpk/Ibu Ahmad Rizky Pratama (LNK-GS-88910),

Pemberitahuan Tagihan Layanan Internet PDT-Pedee Fiber:
• No Invoice: INV-202609-004821
• Periode: September 2...');
INSERT INTO `whatsapp_logs` (`id`, `timestamp`, `recipient_phone`, `recipient_name`, `link_id`, `invoice_id`, `type`, `amount`, `month`, `status`, `message_snippet`) VALUES ('WAL-1788610975877-324', '5/9/2026, 19.22.55 WIB', '6281299887766', 'Hendra Gunawan', 'LNK-GLX-37256', 'INV-202609-7695', 'BILLING_REMINDER_BROADCAST', 453990, 'September 2026', 'DELIVERED', 'Yth. Bpk/Ibu Hendra Gunawan (LNK-GLX-37256),

Kami informasikan tagihan internet PDT-Pedee Fiber Anda untuk periode September 2026 sebesar Rp 453.990 akan/telah...');
INSERT INTO `whatsapp_logs` (`id`, `timestamp`, `recipient_phone`, `recipient_name`, `link_id`, `invoice_id`, `type`, `amount`, `month`, `status`, `message_snippet`) VALUES ('WAL-1788610975877-911', '5/9/2026, 19.22.55 WIB', '6281399881122', 'Siti Nurhaliza', 'LNK-BSD-55421', 'INV-202609-005519', 'BILLING_REMINDER_BROADCAST', 637140, 'September 2026', 'DELIVERED', 'Yth. Bpk/Ibu Siti Nurhaliza (LNK-BSD-55421),

Kami informasikan tagihan internet PDT-Pedee Fiber Anda untuk periode September 2026 sebesar Rp 637.140 akan/telah...');
INSERT INTO `whatsapp_logs` (`id`, `timestamp`, `recipient_phone`, `recipient_name`, `link_id`, `invoice_id`, `type`, `amount`, `month`, `status`, `message_snippet`) VALUES ('WAL-1788610975877-662', '5/9/2026, 19.22.55 WIB', '6281288229100', 'Ahmad Rizky Pratama', 'LNK-GS-88910', 'INV-202609-004821', 'BILLING_REMINDER_BROADCAST', 432900, 'September 2026', 'DELIVERED', 'Yth. Bpk/Ibu Ahmad Rizky Pratama (LNK-GS-88910),

Kami informasikan tagihan internet PDT-Pedee Fiber Anda untuk periode September 2026 sebesar Rp 432.900 akan/t...');
INSERT INTO `whatsapp_logs` (`id`, `timestamp`, `recipient_phone`, `recipient_name`, `link_id`, `invoice_id`, `type`, `amount`, `month`, `status`, `message_snippet`) VALUES ('WAL-202609-001', '05 September 2026 10:15 WIB', '6281288229100', 'Ahmad Rizky Pratama', 'LNK-GS-88910', 'INV-202609-004821', 'BILLING_REMINDER', 432900, 'September 2026', 'DELIVERED', 'Yth. Bpk/Ibu Ahmad Rizky Pratama (LNK-GS-88910), tagihan internet PDT-Pedee periode September 2026 sebesar Rp 432.900 telah terbit...');

SET FOREIGN_KEY_CHECKS = 1;
-- ================= END OF SQL DUMP =================
