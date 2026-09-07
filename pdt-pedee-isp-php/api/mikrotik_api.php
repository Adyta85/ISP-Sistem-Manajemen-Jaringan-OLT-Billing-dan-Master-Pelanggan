<?php
/**
 * PDT-Pedee ISP Portal - MikroTik RouterOS API Client
 * Compatible with RouterOS v6.x and v7.x
 */

class RouterosAPI {
    public $debug = false;
    public $connected = false;
    public $port = 8728;
    public $ssl = false;
    public $timeout = 3;
    public $attempts = 1;
    public $delay = 1;
    public $socket;
    public $error_no;
    public $error_str;

    public function connect($ip, $login, $password) {
        for ($a = 1; $a <= $this->attempts; $a++) {
            $this->connected = false;
            $protocol = $this->ssl ? 'ssl://' : '';
            $context = stream_context_create(['ssl' => ['verify_peer' => false, 'verify_peer_name' => false]]);
            $this->socket = @stream_socket_client($protocol . $ip . ':' . $this->port, $this->error_no, $this->error_str, $this->timeout, STREAM_CLIENT_CONNECT, $context);
            
            if ($this->socket) {
                socket_set_timeout($this->socket, $this->timeout);
                $this->write('/login', false);
                $this->write('=name=' . $login, false);
                $this->write('=response=00' . md5(chr(0) . $password . hex2bin('00'))); // dummy probe for v6.43+
                $res = $this->read(false);

                if (isset($res[0]) && $res[0] === '!done') {
                    if (isset($res[1]) && strpos($res[1], '=ret=') === 0) {
                        // v6 challenge MD5
                        $challenge = substr($res[1], 5);
                        $this->write('/login', false);
                        $this->write('=name=' . $login, false);
                        $this->write('=response=00' . md5(chr(0) . $password . hex2bin($challenge)));
                        $res = $this->read(false);
                    }
                    if (isset($res[0]) && $res[0] === '!done') {
                        $this->connected = true;
                        return true;
                    }
                }

                // Try post-v6.43 plain login
                $this->write('/login', false);
                $this->write('=name=' . $login, false);
                $this->write('=password=' . $password);
                $res = $this->read(false);
                if (isset($res[0]) && $res[0] === '!done') {
                    $this->connected = true;
                    return true;
                }
                @fclose($this->socket);
            }
            sleep($this->delay);
        }
        return false;
    }

    public function disconnect() {
        if ($this->socket) {
            @fclose($this->socket);
        }
        $this->connected = false;
    }

    public function write($param, $last = true) {
        if (!$this->socket) return false;
        $len = strlen($param);
        if ($len < 0x80) {
            $l = chr($len);
        } elseif ($len < 0x4000) {
            $l = chr(($len >> 8) | 0x80) . chr($len & 0xFF);
        } elseif ($len < 0x200000) {
            $l = chr(($len >> 16) | 0xC0) . chr(($len >> 8) & 0xFF) . chr($len & 0xFF);
        } else {
            $l = chr(($len >> 24) | 0xE0) . chr(($len >> 16) & 0xFF) . chr(($len >> 8) & 0xFF) . chr($len & 0xFF);
        }
        @fwrite($this->socket, $l . $param);
        if ($last) {
            @fwrite($this->socket, chr(0));
        }
        return true;
    }

    public function read($parse = true) {
        $response = [];
        while (true) {
            $len = $this->readLen();
            if ($len === 0) {
                if (empty($line)) break;
            }
            if ($len === false) break;
            $line = '';
            while (strlen($line) < $len) {
                $buf = @fread($this->socket, $len - strlen($line));
                if ($buf === false || $buf === '') break;
                $line .= $buf;
            }
            if ($line === '!done' || $line === '!trap' || $line === '!fatal') {
                $response[] = $line;
                break;
            }
            if ($line !== '') {
                $response[] = $line;
            }
        }
        return $response;
    }

    private function readLen() {
        if (!$this->socket) return false;
        $c = @fgetc($this->socket);
        if ($c === false) return false;
        $b = ord($c);
        if (($b & 0x80) == 0x00) return $b;
        if (($b & 0xC0) == 0x80) {
            $c2 = @fgetc($this->socket);
            return (($b & 0x3F) << 8) | ord($c2);
        }
        if (($b & 0xE0) == 0xC0) {
            $c2 = @fgetc($this->socket);
            $c3 = @fgetc($this->socket);
            return (($b & 0x1F) << 16) | (ord($c2) << 8) | ord($c3);
        }
        return 0;
    }

    public function comm($cmd, $params = []) {
        if (!$this->connected) return false;
        $this->write($cmd, empty($params));
        $i = 0;
        $total = count($params);
        foreach ($params as $k => $v) {
            $i++;
            $this->write('=' . $k . '=' . $v, $i === $total);
        }
        return $this->read();
    }
}
