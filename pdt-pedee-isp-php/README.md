# Panduan Instalasi & Penggunaan PDT-Pedee ISP Portal (PHP & MySQL)

Paket ini berisi seluruh aplikasi **PDT-Pedee ISP Portal** yang telah dikompilasi ke format **PHP & Database MySQL** lengkap dengan antarmuka frontend modern (React SPA), backend REST API, integrasi MikroTik RouterOS API, dan audit trail manajemen user.

---

## 1. Persyaratan Sistem
- **Web Server**: Apache / Nginx (XAMPP, Laragon, cPanel, Docker, atau VPS Linux)
- **PHP**: Versi 7.4, 8.0, 8.1, 8.2, atau 8.3 (dengan ekstensi `pdo_mysql` dan `sockets` aktif)
- **Database**: MySQL 5.7+ atau MariaDB 10.3+

---

## 2. Struktur Berkas

```text
pdt-pedee-isp-php/
├── .htaccess                   # Rewrite engine Apache untuk API & SPA
├── index.php                   # Host Single-Page Application
├── index.html                  # Frontend compiled entry
├── assets/                     # JavaScript & CSS bundle React
├── pdt-logo.png                # Asset logo PDT-Pedee
├── manifest.json               # Manifest Android PWA
├── service-worker.js           # Cache & offline worker
├── config/
│   └── database.php            # Pengaturan host, user, password MySQL
├── api/
│   ├── index.php               # Master REST API router PHP
│   ├── helper.php              # Helper CORS, JSON response, & audit logger
│   └── mikrotik_api.php        # Client socket RouterOS API v6 & v7 native
├── database/
│   └── pdt_pedee_isp.sql       # Database dump lengkap (skema + data awal)
└── README.md                   # Panduan ini
```

---

## 3. Langkah Instalasi di Local (XAMPP / Laragon)

### Langkah 1: Ekstrak File
- Ekstrak seluruh isi arsip `pdt-pedee-isp-php.zip` ke folder web server Anda:
  - **XAMPP**: `C:\xampp\htdocs\pdt-pedee-isp\`
  - **Laragon**: `C:\laragon\www\pdt-pedee-isp\`

### Langkah 2: Import Database MySQL
1. Buka browser dan akses **phpMyAdmin** (`http://localhost/phpmyadmin`).
2. Klik tab **Import** (atau buat database baru bernama `pdt_pedee_isp`).
3. Pilih file `database/pdt_pedee_isp.sql` yang ada di dalam folder proyek.
4. Klik tombol **Go / Kirim** di bagian bawah.
5. Seluruh tabel (pelanggan, router MikroTik, paket internet, tagihan invoice, audit log) akan otomatis terbentuk dan terisi data.

### Langkah 3: Sesuaikan Konfigurasi Database (Jika Perlu)
Buka file `config/database.php`. Konfigurasi default sudah disesuaikan dengan XAMPP/Laragon standar:
```php
define('DB_HOST', '127.0.0.1');
define('DB_PORT', '3306');
define('DB_NAME', 'pdt_pedee_isp');
define('DB_USER', 'root');
define('DB_PASS', ''); // Password root MySQL Anda jika ada
```

### Langkah 4: Buka Aplikasi di Browser
- **Jika di Virtual Host / Root**: `http://localhost/` atau `http://pdt-pedee-isp.test/`
- **Jika di Subfolder XAMPP**: `http://localhost/pdt-pedee-isp/`

---

## 4. Kredensial Login Default

### A. Portal Pelanggan Mandiri (Self-Service)
- **URL**: `http://localhost/` (Halaman Depan)
- **Username / Link ID**: `test1` (atau `LNK-GS-21949`)
- **Password**: `123456`
- **Fitur Pelanggan**:
  - Cek tagihan & pembayaran instan via QRIS / VA
  - Speedtest simetris 1:1 real-time
  - Reboot router/ONT mandiri
  - Konsultasi aduan kendala jaringan (AI Helpdesk)

### B. Portal Admin NOC
- **URL**: `http://localhost/admin` (atau klik tombol **Portal Admin NOC** di pojok kanan atas)
- **Username**: `admin`
- **Password**: `admin123`
- **Fitur Admin**:
  - Manajemen Master Customer (Edit profil, ganti password, generate password acak, toggle akses portal)
  - **Audit Trail & Riwayat Log Aktivitas User**: Catatan otomatis saat user login, ubah password, dan catatan manajemen manual
  - Manajemen Router MikroTik (Grafik Traffic Real-Time 1 Detik, Simple Queue CRUD, PPPoE Secret, Hotspot)
  - Billing & Keuangan (Generate tagihan bulanan, persetujuan pembayaran)
  - Manajemen Perangkat OLT & ONT

---

## 5. Menghubungkan ke Router MikroTik Fisik

1. Masuk ke WinBox MikroTik Anda.
2. Buka **New Terminal** dan pastikan service API aktif:
   ```routeros
   /ip service enable api
   /ip service set api port=8728
   ```
3. Di Portal Admin (`/admin`), buka menu **Router MikroTik** dan pastikan IP, port API (8728), username, dan password router sesuai.
4. Klik **Test Koneksi** untuk memverifikasi koneksi API soket berhasil terhubung.
