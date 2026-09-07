<?php
/**
 * PDT-Pedee ISP Portal - Frontend SPA Host
 * PT Prasetia Dwidharma Teknologi
 */

// Route API requests directly if accessed without rewrite
$requestUri = $_SERVER['REQUEST_URI'];
if (strpos($requestUri, '/api/') !== false) {
    require_once __DIR__ . '/api/index.php';
    exit;
}

// Serve single-page application
$htmlPath = __DIR__ . '/index.html';
if (file_exists($htmlPath)) {
    header('Content-Type: text/html; charset=utf-8');
    header('X-Frame-Options: SAMEORIGIN');
    header('X-Content-Type-Options: nosniff');
    readfile($htmlPath);
    exit;
} else {
    echo "<h1>PDT-Pedee ISP Portal</h1><p>index.html tidak ditemukan. Pastikan seluruh berkas telah diekstrak dengan lengkap.</p>";
    exit;
}
