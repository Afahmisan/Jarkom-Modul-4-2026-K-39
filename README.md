# Jarkom-Modul-4-2026-K-39

| Nama | NRP | Pengerjaan | 
|---|---|---|
| Asfia Fahmisan | 5027251043 | VLSM |
| Muhammad Atallah Mas'udi | 5027251071 | CIDR | 

---

## Topologi Jaringan

Pada praktikum Modul 4 ini (*Serial Experiments Lain — Layer:04: The Wired Expansion*), arsitektur jaringan *The Wired* dibangun berskala besar menggunakan metode pengalamatan *Classless* yang seefisien mungkin. Seluruh entitas dihubungkan melalui router utama **Cyberia** yang tersambung ke dunia luar (*Cloud* / NAT), mengalir ke hub **Wired**, kemudian bercabang ke kelompok router **Navi**, rantai **Tachibana** s.d. **Shibuya**, serta segmen bersama (*shared broadcast domain*) milik **Psyche**, **Copland**, dan **Schumann**:

![Topologi Cisco Packet Tracer](images/topo-modul4-cpt.png)

### Parameter Global:
* **Prefix IP Kelompok K-39**: `10.83.0.0/16`
* **Metode Subnetting CPT**: VLSM (*Variable Length Subnet Masking*)
* **Upstream Internet (Cloud)**: Interface `FastEthernet1/0` pada router `Cyberia` terhubung ke `Cloud0` (CPT) / NAT (GNS3).
* **Jumlah Subnet**: 25 Subnet (`A1` s.d. `A25`)
* **Total Kebutuhan IP**: 2.814 IP (tanpa celah / *zero gap* dalam rentang `10.83.0.0/19`)
* **Total Perangkat**: 13 Router Cisco 2811, 13 Switch-PT, 25 Host (PC, Laptop, Server), 1 Cloud.

### Struktur Direktori Repository:
```text
├── VLSM-CPT/                               # Folder Induk Paket Simulasi & Skrip
│   ├── config_cpt/                        # Konfigurasi Cisco IOS CLI per-router & daftar IP host
│   │   ├── routers/                       # File skrip CLI (.txt) 13 router
│   │   └── daftar_ip_host_cpt.txt         # Tabel alokasi IP seluruh 25 host CPT
│   ├── script_bash/                       # Skrip otomatisasi environment Linux / GNS3
│   │   ├── hosts/                         # Skrip penetapan IP & gateway 25 host
│   │   ├── routers/                       # Skrip sysctl forward, flush, & static routing 13 router
│   │   ├── hitung_vlsm.sh                 # Skrip kalkulator tree VLSM
│   │   └── test_ping_semua.sh             # Skrip matriks pengujian konektivitas antar-node
│   ├── Modul4_VLSM_10.83.pkt              # File Cisco Packet Tracer siap uji (VLSM 10.83)
│   ├── bagus.pkt                          # Salinan file CPT terverifikasi (full reachability)
│   ├── Template_Modul4_Kelompok_10.83.xlsx  # Lembar kerja resmi perhitungan VLSM K-39
│   └── tree_pembagian_ip_vlsm_10.83.png   # Diagram visual pohon alokasi VLSM
├── images/                                # Tangkapan layar bukti verifikasi & topologi
│   ├── cyberia_cli.jpg                    # Bukti eksekusi CLI Cyberia & routing table
│   ├── pdu_test.png                       # Bukti pengujian Simple PDU awal (Failed saat proses ARP)
│   ├── pdu_test_successful.png            # Bukti pengujian Simple PDU sukses (Successful setelah 4 hop ARP)
│   ├── pengujian_ping_cmd.png             # Bukti pengujian ping CLI Command Prompt PC Karl (0% loss)
│   ├── topo-modul4-cpt.png                # Tangkapan layar topologi CPT
│   ├── topo-modul4-gns.png                # Tangkapan layar topologi GNS3
│   └── tree_pembagian_ip_vlsm_10.83.png   # Diagram visual pohon alokasi VLSM
├── .gitignore                             # Filter file temporer Excel & OS
└── README.md                              # Laporan resmi praktikum Modul 4
```

---

### Tabel Alokasi IP Address Host:
| Node | Interface | IP Address | Netmask | Gateway | Router Induk | Peran / Subnet |
| :--- | :--- | :--- | :--- | :--- | :--- | :--- |
| **Karl (700 host)** | FastEthernet0 | `10.83.0.2` | `255.255.252.0` | `10.83.0.1` | Psyche | Server (Subnet A1) |
| **Lin (180 host)** | FastEthernet0 | `10.83.0.3` | `255.255.252.0` | `10.83.0.1` | Psyche | Server (Subnet A1) |
| **Omnipresence (510 host)** | FastEthernet0 | `10.83.4.2` | `255.255.252.0` | `10.83.4.1` | Accela | PC (Subnet A2) |
| **Denpa (3 host)** | FastEthernet0 | `10.83.4.3` | `255.255.252.0` | `10.83.4.1` | Accela | Laptop (Subnet A2) |
| **Masayuki (300 host)** | FastEthernet0 | `10.83.8.2` | `255.255.254.0` | `10.83.8.1` | Copland | Laptop (Subnet A3) |
| **Collective (260 host)** | FastEthernet0 | `10.83.10.2` | `255.255.254.0` | `10.83.10.1` | Tachibana | Server (Subnet A4) |
| **Ghost (6 host)** | FastEthernet0 | `10.83.10.3` | `255.255.254.0` | `10.83.10.1` | Tachibana | PC (Subnet A4) |
| **Alice (208 host)** | FastEthernet0 | `10.83.12.2` | `255.255.255.0` | `10.83.12.1` | Navi | Laptop (Subnet A5) |
| **Reika (45 host)** | FastEthernet0 | `10.83.12.3` | `255.255.255.0` | `10.83.12.1` | Navi | PC (Subnet A5) |
| **Yasuo (120 host)** | FastEthernet0 | `10.83.13.2` | `255.255.255.0` | `10.83.13.1` | Navi | PC (Subnet A6) |
| **Miho (18 host)** | FastEthernet0 | `10.83.13.3` | `255.255.255.0` | `10.83.13.1` | Navi | Laptop (Subnet A6) |
| **Kuma (4 host)** | FastEthernet0 | `10.83.13.4` | `255.255.255.0` | `10.83.13.1` | Navi | Server (Subnet A6) |
| **JJ (95 host)** | FastEthernet0 | `10.83.14.2` | `255.255.255.128` | `10.83.14.1` | Cyberia | PC (Subnet A7) |
| **MyuMyu (30 host)** | FastEthernet0 | `10.83.14.3` | `255.255.255.128` | `10.83.14.1` | Cyberia | Laptop (Subnet A7) |
| **Lilith (77 host)** | FastEthernet0 | `10.83.14.130` | `255.255.255.128` | `10.83.14.129` | Deus | Laptop (Subnet A8) |
| **Specter (21 host)** | FastEthernet0 | `10.83.14.131` | `255.255.255.128` | `10.83.14.129` | Deus | PC (Subnet A8) |
| **Lain (57 host)** | FastEthernet0 | `10.83.15.2` | `255.255.255.192` | `10.83.15.1` | Shibuya | Laptop (Subnet A9) |
| **Mika (4 host)** | FastEthernet0 | `10.83.15.3` | `255.255.255.192` | `10.83.15.1` | Shibuya | PC (Subnet A9) |
| **Taro (57 host)** | FastEthernet0 | `10.83.15.66` | `255.255.255.192` | `10.83.15.65` | Navi | PC (Subnet A10) |
| **Chisa (23 host)** | FastEthernet0 | `10.83.15.130` | `255.255.255.192` | `10.83.15.129` | Protocol7 | Laptop (Subnet A11) |
| **Hodgeson (9 host)** | FastEthernet0 | `10.83.15.131` | `255.255.255.192` | `10.83.15.129` | Protocol7 | PC (Subnet A11) |
| **Juri (31 host)** | FastEthernet0 | `10.83.15.194` | `255.255.255.192` | `10.83.15.193` | Copland | Laptop (Subnet A12) |
| **Semi (14 host)** | FastEthernet0 | `10.83.16.2` | `255.255.255.224` | `10.83.16.1` | Phantoma | PC (Subnet A13) |
| **Akashic (3 host)** | FastEthernet0 | `10.83.16.42` | `255.255.255.248` | `10.83.16.41` | Schumann | Server (Subnet A15) |
| **Eiri (2 host)** | FastEthernet0 | `10.83.16.50` | `255.255.255.248` | `10.83.16.49` | Knights | Server (Subnet A16) |

---

### Tabel Alokasi IP Address Interface Router:
| Router | Interface | IP Address | Subnet Mask | Keterangan Sambungan |
| :--- | :--- | :--- | :--- | :--- |
| **Cyberia** | `FastEthernet0/0`<br>`FastEthernet0/1`<br>`FastEthernet1/0` | `10.83.16.57`<br>`10.83.14.1`<br>- | `255.255.255.252`<br>`255.255.255.128`<br>- | Point-to-point ke Wired (A17)<br>LAN Switch1: JJ & MyuMyu (A7)<br>Uplink ke Cloud0 |
| **Wired** | `FastEthernet0/0`<br>`FastEthernet0/1`<br>`FastEthernet1/0`<br>`FastEthernet1/1` | `10.83.16.58`<br>`10.83.16.33`<br>`10.83.16.61`<br>`10.83.16.65` | `255.255.255.252`<br>`255.255.255.248`<br>`255.255.255.252`<br>`255.255.255.252` | Point-to-point ke Cyberia (A17)<br>Shared Switch2 ke Psyche, Copland, Schumann (A14)<br>Point-to-point ke Navi (A18)<br>Point-to-point ke Tachibana (A19) |
| **Navi** | `FastEthernet0/0`<br>`FastEthernet0/1`<br>`FastEthernet1/0`<br>`FastEthernet1/1` | `10.83.16.62`<br>`10.83.12.1`<br>`10.83.15.65`<br>`10.83.13.1` | `255.255.255.252`<br>`255.255.255.0`<br>`255.255.255.192`<br>`255.255.255.0` | Point-to-point ke Wired (A18)<br>LAN Switch6: Alice & Reika (A5)<br>LAN Switch7: Taro (A10)<br>LAN Switch8: Yasuo, Miho, Kuma (A6) |
| **Psyche** | `FastEthernet0/0`<br>`FastEthernet0/1` | `10.83.16.34`<br>`10.83.0.1` | `255.255.255.248`<br>`255.255.252.0` | Shared Switch2 dari Wired (A14)<br>LAN Switch3: Karl & Lin (A1) |
| **Copland** | `FastEthernet0/0`<br>`FastEthernet0/1`<br>`FastEthernet1/0` | `10.83.16.35`<br>`10.83.8.1`<br>`10.83.15.193` | `255.255.255.248`<br>`255.255.254.0`<br>`255.255.255.192` | Shared Switch2 dari Wired (A14)<br>LAN Switch4: Masayuki (A3)<br>Direct Link ke Juri (A12) |
| **Schumann** | `FastEthernet0/0`<br>`FastEthernet0/1`<br>`FastEthernet1/0` | `10.83.16.36`<br>`10.83.16.41`<br>`10.83.16.69` | `255.255.255.248`<br>`255.255.255.248`<br>`255.255.255.252` | Shared Switch2 dari Wired (A14)<br>Direct Link ke Akashic (A15)<br>Point-to-point ke Accela (A20) |
| **Accela** | `FastEthernet0/0`<br>`FastEthernet0/1` | `10.83.16.70`<br>`10.83.4.1` | `255.255.255.252`<br>`255.255.252.0` | Point-to-point ke Schumann (A20)<br>LAN Switch5: Omnipresence & Denpa (A2) |
| **Tachibana** | `FastEthernet0/0`<br>`FastEthernet0/1`<br>`FastEthernet1/0` | `10.83.16.66`<br>`10.83.10.1`<br>`10.83.16.73` | `255.255.255.252`<br>`255.255.254.0`<br>`255.255.255.252` | Point-to-point ke Wired (A19)<br>LAN Switch9: Collective & Ghost (A4)<br>Point-to-point ke Deus (A21) |
| **Deus** | `FastEthernet0/0`<br>`FastEthernet0/1`<br>`FastEthernet1/0` | `10.83.16.74`<br>`10.83.14.129`<br>`10.83.16.77` | `255.255.255.252`<br>`255.255.255.128`<br>`255.255.255.252` | Point-to-point ke Tachibana (A21)<br>LAN Switch10: Lilith & Specter (A8)<br>Point-to-point ke Protocol7 (A22) |
| **Protocol7** | `FastEthernet0/0`<br>`FastEthernet0/1`<br>`FastEthernet1/0` | `10.83.16.78`<br>`10.83.15.129`<br>`10.83.16.81` | `255.255.255.252`<br>`255.255.255.192`<br>`255.255.255.252` | Point-to-point ke Deus (A22)<br>LAN Switch11: Chisa & Hodgeson (A11)<br>Point-to-point ke Knights (A23) |
| **Knights** | `FastEthernet0/0`<br>`FastEthernet0/1`<br>`FastEthernet1/0` | `10.83.16.82`<br>`10.83.16.49`<br>`10.83.16.85` | `255.255.255.252`<br>`255.255.255.248`<br>`255.255.255.252` | Point-to-point ke Protocol7 (A23)<br>Direct Link ke Eiri (A16)<br>Point-to-point ke Phantoma (A24) |
| **Phantoma** | `FastEthernet0/0`<br>`FastEthernet0/1`<br>`FastEthernet1/0` | `10.83.16.86`<br>`10.83.16.1`<br>`10.83.16.89` | `255.255.255.252`<br>`255.255.255.224`<br>`255.255.255.252` | Point-to-point ke Knights (A24)<br>LAN Switch12: Semi (A13)<br>Point-to-point ke Shibuya (A25) |
| **Shibuya** | `FastEthernet0/0`<br>`FastEthernet0/1` | `10.83.16.90`<br>`10.83.15.1` | `255.255.255.252`<br>`255.255.255.192` | Point-to-point ke Phantoma (A25)<br>LAN Switch13: Lain & Mika (A9) |

---

## 1. Analisis Kebutuhan Host & Pembagian Subnet

Identifikasi seluruh segmen jaringan pada topologi The Wired dilakukan dengan menghitung kebutuhan IP riil untuk masing-masing subnet (menjumlahkan total host dan antarmuka router yang terhubung). Seluruh subnet diurutkan dari kebutuhan terbesar ke terkecil sebagai landasan perhitungan VLSM.

### Konfigurasi dan Penjelasan:
Sesuai ketentuan praktikum, setiap interface router yang bertindak sebagai *default gateway* atau penghubung antar-node dihitung sebagai 1 kebutuhan IP. Khusus untuk subnet bersama `A14` (`Wired > Switch2 > Psyche, Copland, Schumann`), terdapat 4 interface router yang berada dalam satu *broadcast domain* yang sama sehingga kebutuhan IP-nya bernilai 4.

Urutan kebutuhan IP terbesar ke terkecil:
1. `A1` (881 IP) → 700 (Karl) + 180 (Lin) + 1 router
2. `A2` (514 IP) → 510 (Omnipresence) + 3 (Denpa) + 1 router
3. `A3` (301 IP) → 300 (Masayuki) + 1 router
4. `A4` (267 IP) → 260 (Collective) + 6 (Ghost) + 1 router
5. `A5` (254 IP) → 208 (Alice) + 45 (Reika) + 1 router
6. `A6` (143 IP) → 120 (Yasuo) + 18 (Miho) + 4 (Kuma) + 1 router
7. `A7` (126 IP) → 95 (JJ) + 30 (MyuMyu) + 1 router
8. `A8` (99 IP) → 77 (Lilith) + 21 (Specter) + 1 router
9. `A9` (62 IP) → 57 (Lain) + 4 (Mika) + 1 router
10. `A10` (58 IP) → 57 (Taro) + 1 router
11. `A11` (33 IP) → 23 (Chisa) + 9 (Hodgeson) + 1 router
12. `A12` (32 IP) → 31 (Juri) + 1 router
13. `A13` (15 IP) → 14 (Semi) + 1 router
14. `A14` (4 IP) → 4 router interface
15. `A15` (4 IP) → 3 (Akashic) + 1 router
16. `A16` (3 IP) → 2 (Eiri) + 1 router
17. `A17` s.d. `A25` (masing-masing 2 IP) → Point-to-point 2 router interface.

Total alokasi alamat yang dibutuhkan adalah **2.814 IP**.

### Bukti Verifikasi:
Lembar perhitungan alokasi subnet dapat diakses online melalui [Google Spreadsheet Resmi Kelompok K-39](https://docs.google.com/spreadsheets/d/1XlCe701xFm7mK43r-sJaImQ2owLYlwCm/edit?usp=sharing&ouid=116660344884914721699&rtpof=true&sd=true) atau file lokal [Template_Modul4_Kelompok_10.83.xlsx](VLSM-CPT/Template_Modul4_Kelompok_10.83.xlsx):

| Kode | Subnet / Rute | Total Kebutuhan | Prefix | Netmask |
| :---: | :--- | :---: | :---: | :--- |
| **A1** | Psyche > Switch3 > Karl, Lin | 881 | `/22` | `255.255.252.0` |
| **A2** | Accela > Switch5 > Omnipresence, Denpa | 514 | `/22` | `255.255.252.0` |
| **A3** | Copland > Switch4 > Masayuki | 301 | `/23` | `255.255.254.0` |
| **A4** | Tachibana > Switch9 > Collective, Ghost | 267 | `/23` | `255.255.254.0` |
| **A5** | Navi > Switch6 > Alice, Reika | 254 | `/24` | `255.255.255.0` |
| **A6** | Navi > Switch8 > Yasuo, Miho, Kuma | 143 | `/24` | `255.255.255.0` |
| **A7** | Cyberia > Switch1 > JJ, MyuMyu | 126 | `/25` | `255.255.255.128` |
| **A8** | Deus > Switch10 > Lilith, Specter | 99 | `/25` | `255.255.255.128` |
| **A9** | Shibuya > Switch13 > Lain, Mika | 62 | `/26` | `255.255.255.192` |
| **A10** | Navi > Switch7 > Taro | 58 | `/26` | `255.255.255.192` |
| **A11** | Protocol7 > Switch11 > Chisa, Hodgeson | 33 | `/26` | `255.255.255.192` |
| **A12** | Copland > Juri | 32 | `/26` | `255.255.255.192` |
| **A13** | Phantoma > Switch12 > Semi | 15 | `/27` | `255.255.255.224` |
| **A14** | Wired > Switch2 > Psyche, Copland, Schumann | 4 | `/29` | `255.255.255.248` |
| **A15** | Schumann > Akashic | 4 | `/29` | `255.255.255.248` |
| **A16** | Knights > Eiri | 3 | `/29` | `255.255.255.248` |
| **A17 - A25** | Point-to-Point Link Antar Router | 2 (tiap link) | `/30` | `255.255.255.252` |

---

## 2. Desain Pohon Subnetting VLSM (Subnet Tree)

Struktur pohon biner pembagian alamat IP (*VLSM Subnet Tree*) disusun berbasis alokasi blok alamat kelompok `10.83.0.0/19`. Hierarki pemecahan blok besar ke subnet-subnet yang lebih kecil dirancang rapat tanpa celah (*zero gap*) agar efisiensi penggunaan alamat maksimal.

### Konfigurasi dan Penjelasan:
Blok alamat awal yang mencakup seluruh kebutuhan adalah `10.83.0.0/19` (total 8.192 alamat):
1. Dibagi dua menjadi `10.83.0.0/20` (untuk `A1` s.d. `A12`) dan `10.83.16.0/20` (untuk `A13` s.d. `A25`).
2. `10.83.0.0/20` dipecah lagi menjadi dua `/21`:
   - `10.83.0.0/21` dipecah menjadi `A1` (`10.83.0.0/22`) dan `A2` (`10.83.4.0/22`).
   - `10.83.8.0/21` dipecah menjadi `A3` (`10.83.8.0/23`) dan `A4` (`10.83.10.0/23`), kemudian `/22` berikutnya dipecah untuk `A5`, `A6`, `A7`, `A8`, `A9`, `A10`, `A11`, dan `A12`.
3. Blok `10.83.16.0/20` dipecah untuk menampung subnet-subnet kecil: `A13` (`/27`), `A14` s.d. `A16` (`/29`), serta `A17` s.d. `A25` (`/30`).

### Bukti Verifikasi:
Diagram Pohon Pembagian IP VLSM:

![Pohon Pembagian IP VLSM](images/tree_pembagian_ip_vlsm_10.83.png)

---

## 3. Rencana Pengalamatan & Tabel Subnetting VLSM (A1 - A25)

Rancangan tabel subnetting VLSM komprehensif yang memuat Subnet ID, Subnet Mask, Range Usable IP Host, Broadcast IP, serta kapasitas usable untuk seluruh 25 subnet (`A1` s.d. `A25`).

### Konfigurasi dan Penjelasan:
Penomoran IP dibuat berurutan rapat tanpa ada celah (*contiguous zero gap*). Subnet pertama `A1` dimulai tepat pada `10.83.0.0`, dan subnet terakhir `A25` berakhir pada `10.83.16.91`.

### Bukti Verifikasi:
Tabel VLSM Lengkap:

| Kode | Subnet ID | Subnet Mask | Range Usable IP Host | Broadcast IP | Kapasitas |
| :---: | :--- | :--- | :--- | :--- | :---: |
| **A1** | `10.83.0.0` | `255.255.252.0` | `10.83.0.1 - 10.83.3.254` | `10.83.3.255` | 1022 |
| **A2** | `10.83.4.0` | `255.255.252.0` | `10.83.4.1 - 10.83.7.254` | `10.83.7.255` | 1022 |
| **A3** | `10.83.8.0` | `255.255.254.0` | `10.83.8.1 - 10.83.9.254` | `10.83.9.255` | 510 |
| **A4** | `10.83.10.0` | `255.255.254.0` | `10.83.10.1 - 10.83.11.254` | `10.83.11.255` | 510 |
| **A5** | `10.83.12.0` | `255.255.255.0` | `10.83.12.1 - 10.83.12.254` | `10.83.12.255` | 254 |
| **A6** | `10.83.13.0` | `255.255.255.0` | `10.83.13.1 - 10.83.13.254` | `10.83.13.255` | 254 |
| **A7** | `10.83.14.0` | `255.255.255.128` | `10.83.14.1 - 10.83.14.126` | `10.83.14.127` | 126 |
| **A8** | `10.83.14.128` | `255.255.255.128` | `10.83.14.129 - 10.83.14.254` | `10.83.14.255` | 126 |
| **A9** | `10.83.15.0` | `255.255.255.192` | `10.83.15.1 - 10.83.15.62` | `10.83.15.63` | 62 |
| **A10** | `10.83.15.64` | `255.255.255.192` | `10.83.15.65 - 10.83.15.126` | `10.83.15.127` | 62 |
| **A11** | `10.83.15.128` | `255.255.255.192` | `10.83.15.129 - 10.83.15.190` | `10.83.15.191` | 62 |
| **A12** | `10.83.15.192` | `255.255.255.192` | `10.83.15.193 - 10.83.15.254` | `10.83.15.255` | 62 |
| **A13** | `10.83.16.0` | `255.255.255.224` | `10.83.16.1 - 10.83.16.30` | `10.83.16.31` | 30 |
| **A14** | `10.83.16.32` | `255.255.255.248` | `10.83.16.33 - 10.83.16.38` | `10.83.16.39` | 6 |
| **A15** | `10.83.16.40` | `255.255.255.248` | `10.83.16.41 - 10.83.16.46` | `10.83.16.47` | 6 |
| **A16** | `10.83.16.48` | `255.255.255.248` | `10.83.16.49 - 10.83.16.54` | `10.83.16.55` | 6 |
| **A17** | `10.83.16.56` | `255.255.255.252` | `10.83.16.57 - 10.83.16.58` | `10.83.16.59` | 2 |
| **A18** | `10.83.16.60` | `255.255.255.252` | `10.83.16.61 - 10.83.16.62` | `10.83.16.63` | 2 |
| **A19** | `10.83.16.64` | `255.255.255.252` | `10.83.16.65 - 10.83.16.66` | `10.83.16.67` | 2 |
| **A20** | `10.83.16.68` | `255.255.255.252` | `10.83.16.69 - 10.83.16.70` | `10.83.16.71` | 2 |
| **A21** | `10.83.16.72` | `255.255.255.252` | `10.83.16.73 - 10.83.16.74` | `10.83.16.75` | 2 |
| **A22** | `10.83.16.76` | `255.255.255.252` | `10.83.16.77 - 10.83.16.78` | `10.83.16.79` | 2 |
| **A23** | `10.83.16.80` | `255.255.255.252` | `10.83.16.81 - 10.83.16.82` | `10.83.16.83` | 2 |
| **A24** | `10.83.16.84` | `255.255.255.252` | `10.83.16.85 - 10.83.16.86` | `10.83.16.87` | 2 |
| **A25** | `10.83.16.88` | `255.255.255.252` | `10.83.16.89 - 10.83.16.90` | `10.83.16.91` | 2 |

---

## 4. Konfigurasi Router Gateway Cyberia & Core Hub Wired

Konfigurasi perutean pada router utama Cyberia dan hub sentral Wired. Cyberia berfungsi sebagai gerbang utama penghubung Cloud dan LAN A7, sedangkan Wired mendistribusikan lalu lintas ke seluruh cabang jaringan dengan rute statis efisien memanfaatkan rute default dan agregasi rute.

### Konfigurasi dan Penjelasan:
- **Cyberia**: Memiliki rute langsung ke `A7` (`10.83.14.0/25`) dan link `A17` ke Wired. Semua lalu lintas menuju subnet lainnya dialihkan ke Wired melalui rute default `0.0.0.0 0.0.0.0 10.83.16.58`.
- **Wired**: Mengarahkan paket ke cabang kiri melalui next-hop di Switch2 (`10.83.16.34` untuk Psyche, `10.83.16.35` untuk Copland, `10.83.16.36` untuk Schumann/Accela), ke cabang kanan melalui Navi (`10.83.16.62`), dan ke rantai bawah melalui Tachibana (`10.83.16.66`).

### Bukti Verifikasi & Skrip CLI:

#### Skrip CLI Router Cyberia:
```cisco
enable
configure terminal
hostname Cyberia
interface FastEthernet0/0
ip address 10.83.16.57 255.255.255.252
no shutdown
exit
interface FastEthernet0/1
ip address 10.83.14.1 255.255.255.128
no shutdown
exit
ip route 0.0.0.0 0.0.0.0 10.83.16.58
end
write memory
```

#### Skrip CLI Router Wired:
```cisco
enable
configure terminal
hostname Wired
interface FastEthernet0/0
ip address 10.83.16.58 255.255.255.252
no shutdown
exit
interface FastEthernet0/1
ip address 10.83.16.33 255.255.255.248
no shutdown
exit
interface FastEthernet1/0
ip address 10.83.16.61 255.255.255.252
no shutdown
exit
interface FastEthernet1/1
ip address 10.83.16.65 255.255.255.252
no shutdown
exit
ip route 10.83.14.0 255.255.255.128 10.83.16.57
ip route 10.83.0.0 255.255.252.0 10.83.16.34
ip route 10.83.8.0 255.255.254.0 10.83.16.35
ip route 10.83.15.192 255.255.255.192 10.83.16.35
ip route 10.83.4.0 255.255.252.0 10.83.16.36
ip route 10.83.16.40 255.255.255.248 10.83.16.36
ip route 10.83.16.68 255.255.255.252 10.83.16.36
ip route 10.83.12.0 255.255.254.0 10.83.16.62
ip route 10.83.15.64 255.255.255.192 10.83.16.62
ip route 10.83.10.0 255.255.254.0 10.83.16.66
ip route 10.83.14.128 255.255.255.128 10.83.16.66
ip route 10.83.15.0 255.255.255.192 10.83.16.66
ip route 10.83.15.128 255.255.255.192 10.83.16.66
ip route 10.83.16.0 255.255.255.224 10.83.16.66
ip route 10.83.16.48 255.255.255.248 10.83.16.66
ip route 10.83.16.72 255.255.255.248 10.83.16.66
ip route 10.83.16.80 255.255.255.240 10.83.16.66
end
write memory
```

Tampilan status antarmuka dan rute statis pada router Cyberia:

![Bukti Eksekusi CLI Cyberia](images/cyberia_cli.jpg)

---

## 5. Konfigurasi Router Cabang Barat (Psyche, Copland, Schumann, Accela)

Konfigurasi router-router cabang kiri/barat: Psyche, Copland, Schumann, dan Accela yang terhubung melalui Switch2 (Subnet A14 shared broadcast domain). Komunikasi antar-router dalam segmen A14 serta rute balik ke seluruh jaringan Wired dipastikan berjalan tanpa routing loop.

### Konfigurasi dan Penjelasan:
Keempat router ini berbagi subnet `10.83.16.32/29` pada Switch2:
- **Psyche** (`.34`): Mengarahkan paket ke LAN Copland (`.35`) dan Schumann/Accela (`.36`), serta rute default `0.0.0.0 0.0.0.0 10.83.16.33` kembali ke Wired.
- **Copland** (`.35`): Melayani LAN A3 (Masayuki) dan A12 (Juri), serta rute balik ke Wired.
- **Schumann** (`.36`): Menghubungkan host Akashic (A15) dan meneruskan paket ke Accela (`10.83.16.70`) melalui link A20 (`10.83.16.68/30`).
- **Accela** (`.70`): Melayani LAN A2 (Omnipresence dan Denpa) dengan rute default menuju Schumann (`10.83.16.69`).

### Bukti Verifikasi & Skrip CLI:

#### Skrip CLI Router Psyche:
```cisco
enable
configure terminal
hostname Psyche
interface FastEthernet0/0
ip address 10.83.16.34 255.255.255.248
no shutdown
exit
interface FastEthernet0/1
ip address 10.83.0.1 255.255.252.0
no shutdown
exit
ip route 10.83.8.0 255.255.254.0 10.83.16.35
ip route 10.83.15.192 255.255.255.192 10.83.16.35
ip route 10.83.4.0 255.255.252.0 10.83.16.36
ip route 10.83.16.40 255.255.255.248 10.83.16.36
ip route 10.83.16.68 255.255.255.252 10.83.16.36
ip route 0.0.0.0 0.0.0.0 10.83.16.33
end
write memory
```

#### Skrip CLI Router Copland:
```cisco
enable
configure terminal
hostname Copland
interface FastEthernet0/0
ip address 10.83.16.35 255.255.255.248
no shutdown
exit
interface FastEthernet0/1
ip address 10.83.8.1 255.255.254.0
no shutdown
exit
interface FastEthernet1/0
ip address 10.83.15.193 255.255.255.192
no shutdown
exit
ip route 10.83.0.0 255.255.252.0 10.83.16.34
ip route 10.83.4.0 255.255.252.0 10.83.16.36
ip route 10.83.16.40 255.255.255.248 10.83.16.36
ip route 10.83.16.68 255.255.255.252 10.83.16.36
ip route 0.0.0.0 0.0.0.0 10.83.16.33
end
write memory
```

#### Skrip CLI Router Schumann:
```cisco
enable
configure terminal
hostname Schumann
interface FastEthernet0/0
ip address 10.83.16.36 255.255.255.248
no shutdown
exit
interface FastEthernet0/1
ip address 10.83.16.41 255.255.255.248
no shutdown
exit
interface FastEthernet1/0
ip address 10.83.16.69 255.255.255.252
no shutdown
exit
ip route 10.83.4.0 255.255.252.0 10.83.16.70
ip route 10.83.0.0 255.255.252.0 10.83.16.34
ip route 10.83.8.0 255.255.254.0 10.83.16.35
ip route 10.83.15.192 255.255.255.192 10.83.16.35
ip route 0.0.0.0 0.0.0.0 10.83.16.33
end
write memory
```

#### Skrip CLI Router Accela:
```cisco
enable
configure terminal
hostname Accela
interface FastEthernet0/0
ip address 10.83.16.70 255.255.255.252
no shutdown
exit
interface FastEthernet0/1
ip address 10.83.4.1 255.255.252.0
no shutdown
exit
ip route 0.0.0.0 0.0.0.0 10.83.16.69
end
write memory
```

---

## 6. Konfigurasi Router Cabang Timur (Navi)

Konfigurasi router Navi sebagai gerbang cabang timur yang melayani tiga segmen LAN: Switch6 (A5), Switch7 (A10), dan Switch8 (A6).

### Konfigurasi dan Penjelasan:
Navi terhubung langsung ke Wired melalui link point-to-point `A18` (`10.83.16.60/30`). Karena Navi hanya memiliki satu jalur keluar masuk (*stub network*), seluruh paket ke luar jaringan lokalnya cukup diarahkan melalui satu rute default `0.0.0.0 0.0.0.0 10.83.16.61` ke router Wired.

### Bukti Verifikasi & Skrip CLI:

#### Skrip CLI Router Navi:
```cisco
enable
configure terminal
hostname Navi
interface FastEthernet0/0
ip address 10.83.16.62 255.255.255.252
no shutdown
exit
interface FastEthernet0/1
ip address 10.83.12.1 255.255.255.0
no shutdown
exit
interface FastEthernet1/0
ip address 10.83.15.65 255.255.255.192
no shutdown
exit
interface FastEthernet1/1
ip address 10.83.13.1 255.255.255.0
no shutdown
exit
ip route 0.0.0.0 0.0.0.0 10.83.16.61
end
write memory
```

---

## 7. Konfigurasi Rantai Router Backbone Selatan (Tachibana s.d. Shibuya)

Konfigurasi rantai router selatan secara serial: Tachibana → Deus → Protocol7 → Knights → Phantoma → Shibuya. Setiap router melayani LAN lokalnya masing-masing serta meneruskan lalu lintas antar-hop secara bolak-balik tanpa adanya paket yang terputus di tengah jalan.

### Konfigurasi dan Penjelasan:
Setiap router pada rantai ini memiliki:
1. Jalur maju (*forward path*): Mengarahkan paket ke router berikutnya lebih dalam hingga mencapai Shibuya.
2. Jalur kembali (*return path*): Rute default `0.0.0.0 0.0.0.0` mengarah ke router sebelumnya menuju Wired.

### Bukti Verifikasi & Skrip CLI:

#### Skrip CLI Router Tachibana:
```cisco
enable
configure terminal
hostname Tachibana
interface FastEthernet0/0
ip address 10.83.16.66 255.255.255.252
no shutdown
exit
interface FastEthernet0/1
ip address 10.83.10.1 255.255.254.0
no shutdown
exit
interface FastEthernet1/0
ip address 10.83.16.73 255.255.255.252
no shutdown
exit
ip route 10.83.14.128 255.255.255.128 10.83.16.74
ip route 10.83.15.0 255.255.255.192 10.83.16.74
ip route 10.83.15.128 255.255.255.192 10.83.16.74
ip route 10.83.16.0 255.255.255.224 10.83.16.74
ip route 10.83.16.48 255.255.255.248 10.83.16.74
ip route 10.83.16.76 255.255.255.252 10.83.16.74
ip route 10.83.16.80 255.255.255.240 10.83.16.74
ip route 0.0.0.0 0.0.0.0 10.83.16.65
end
write memory
```

#### Skrip CLI Router Deus:
```cisco
enable
configure terminal
hostname Deus
interface FastEthernet0/0
ip address 10.83.16.74 255.255.255.252
no shutdown
exit
interface FastEthernet0/1
ip address 10.83.14.129 255.255.255.128
no shutdown
exit
interface FastEthernet1/0
ip address 10.83.16.77 255.255.255.252
no shutdown
exit
ip route 10.83.15.0 255.255.255.192 10.83.16.78
ip route 10.83.15.128 255.255.255.192 10.83.16.78
ip route 10.83.16.0 255.255.255.224 10.83.16.78
ip route 10.83.16.48 255.255.255.248 10.83.16.78
ip route 10.83.16.80 255.255.255.240 10.83.16.78
ip route 0.0.0.0 0.0.0.0 10.83.16.73
end
write memory
```

#### Skrip CLI Router Protocol7:
```cisco
enable
configure terminal
hostname Protocol7
interface FastEthernet0/0
ip address 10.83.16.78 255.255.255.252
no shutdown
exit
interface FastEthernet0/1
ip address 10.83.15.129 255.255.255.192
no shutdown
exit
interface FastEthernet1/0
ip address 10.83.16.81 255.255.255.252
no shutdown
exit
ip route 10.83.15.0 255.255.255.192 10.83.16.82
ip route 10.83.16.0 255.255.255.224 10.83.16.82
ip route 10.83.16.48 255.255.255.248 10.83.16.82
ip route 10.83.16.84 255.255.255.252 10.83.16.82
ip route 10.83.16.88 255.255.255.252 10.83.16.82
ip route 0.0.0.0 0.0.0.0 10.83.16.77
end
write memory
```

#### Skrip CLI Router Knights:
```cisco
enable
configure terminal
hostname Knights
interface FastEthernet0/0
ip address 10.83.16.82 255.255.255.252
no shutdown
exit
interface FastEthernet0/1
ip address 10.83.16.49 255.255.255.248
no shutdown
exit
interface FastEthernet1/0
ip address 10.83.16.85 255.255.255.252
no shutdown
exit
ip route 10.83.15.0 255.255.255.192 10.83.16.86
ip route 10.83.16.0 255.255.255.224 10.83.16.86
ip route 10.83.16.88 255.255.255.252 10.83.16.86
ip route 0.0.0.0 0.0.0.0 10.83.16.81
end
write memory
```

#### Skrip CLI Router Phantoma:
```cisco
enable
configure terminal
hostname Phantoma
interface FastEthernet0/0
ip address 10.83.16.86 255.255.255.252
no shutdown
exit
interface FastEthernet0/1
ip address 10.83.16.1 255.255.255.224
no shutdown
exit
interface FastEthernet1/0
ip address 10.83.16.89 255.255.255.252
no shutdown
exit
ip route 10.83.15.0 255.255.255.192 10.83.16.90
ip route 0.0.0.0 0.0.0.0 10.83.16.85
end
write memory
```

#### Skrip CLI Router Shibuya:
```cisco
enable
configure terminal
hostname Shibuya
interface FastEthernet0/0
ip address 10.83.16.90 255.255.255.252
no shutdown
exit
interface FastEthernet0/1
ip address 10.83.15.1 255.255.255.192
no shutdown
exit
ip route 0.0.0.0 0.0.0.0 10.83.16.89
end
write memory
```

---

## 8. Alokasi Pengalamatan Statis Host (25 Perangkat)

Konfigurasi pengalamatan statis pada seluruh 25 host (PC, Laptop, Server). Setiap host menerima IP usable pertama setelah IP antarmuka router, subnet mask yang sesuai dengan ukuran subnetnya, serta default gateway yang tepat mengarah ke router gateway lokalnya.

### Konfigurasi dan Penjelasan:
Seluruh 25 host dikonfigurasi melalui menu **Desktop → IP Configuration** pada Cisco Packet Tracer (atau file teks [daftar_ip_host_cpt.txt](VLSM-CPT/config_cpt/daftar_ip_host_cpt.txt)). Tidak ada host yang bentrok (*IP conflict*) dan seluruh gateway mengarah tepat ke IP antarmuka router pada segmennya.

### Bukti Verifikasi:
Contoh konfigurasi IP host pada PC `Karl (700 host)`:
- IP Address: `10.83.0.2`
- Subnet Mask: `255.255.252.0`
- Default Gateway: `10.83.0.1`

Contoh konfigurasi IP host pada PC `JJ (95 host)`:
- IP Address: `10.83.14.2`
- Subnet Mask: `255.255.255.128`
- Default Gateway: `10.83.14.1`

---

## 9. Pengujian Konektivitas & Analisis Multi-Hop ARP

Pengujian konektivitas end-to-end antar-subnet dan dalam subnet (*intra-subnet* dan *inter-subnet*). Bagian ini memuat analisis perilaku protokol ARP (*Address Resolution Protocol*) dan STP (*Spanning Tree Protocol*) di Cisco Packet Tracer yang menyebabkan pengiriman paket pertama berstatus "Failed" sebelum resolusi ARP antar-hop selesai.

### Konfigurasi dan Penjelasan:
Pada pengujian konektivitas end-to-end:
1. **Intra-Subnet (Dalam 1 Subnet)**:
   Pengujian antara `Karl (700 host)` menuju `Lin (180 host)` pada Subnet `A1` langsung berstatus **Successful** pada percobaan pertama (`Num 0`) karena kedua host berada pada switch yang sama (`Switch3`) tanpa melewati proses routing antar-hop.
2. **Inter-Subnet (Lintas Subnet / Beda Router - Kasus Karl menuju JJ)**:
   Jalur komunikasi antara `Karl (700 host)` di cabang Psyche menuju `JJ (95 host)` di cabang Cyberia melewati 3 router dan 4 segmen/hop:
   **Karl (Host)** → *[Hop 1]* **Psyche** → *[Hop 2]* **Wired** → *[Hop 3]* **Cyberia** → *[Hop 4]* **JJ (Host)**
   - **Mekanisme Multi-Hop ARP Drop**: Pada sistem Cisco IOS, jika router menerima paket IP menuju next-hop yang belum tercatat pada tabel ARP (*ARP Cache*), router akan menahan broadcast *ARP Request* dan langsung membuang (*drop*) paket ICMP yang sedang mengantre (karena buffer ICMP Cisco IOS tidak menahan paket selama proses ARP resolution).
   - **Kenapa Butuh 4 Kali Klik Fire / Percobaan?**
     Amplop *Simple PDU* (`P`) pada Cisco Packet Tracer hanya mengirimkan **1 paket ICMP Echo Request** per klik:
     * **Klik ke-1**: Mengisi ARP tabel antara `Karl` ↔ `Psyche` (Hop 1). Paket ICMP pertama dibuang → Status: `Failed`.
     * **Klik ke-2**: Paket lolos ke `Psyche`, namun `Psyche` belum memiliki MAC `Wired` pada Subnet A14 (Hop 2). Paket dibuang untuk ARP → Status: `Failed`.
     * **Klik ke-3**: Paket lolos ke `Wired`, namun `Wired` belum memiliki MAC `Cyberia` pada Subnet A21 (Hop 3). Paket dibuang untuk ARP → Status: `Failed`.
     * **Klik ke-4**: Seluruh hop hingga `Cyberia` ↔ `JJ` (Hop 4) telah berhasil memetakan MAC address. Paket ICMP Echo Request sampai ke tujuan dan dibalas dengan ICMP Echo Reply secara utuh → Status berubah menjadi **`Successful`**!

### Bukti Verifikasi:

#### 1. Pengujian Simple PDU (Percobaan Awal vs Setelah Multi-Hop ARP Resolution):
Pada percobaan awal sebelum seluruh hop melakukan resolusi ARP:

![Bukti Pengujian Simple PDU Awal - Failed](images/pdu_test.png)

Setelah tombol **Fire** ditekan bertahap (4 kali klik untuk menyelesaikan 4 hop rantai routing), seluruh entri ARP terisi dan status komunikasi berubah menjadi **Successful**:

![Bukti Pengujian Simple PDU Sukses](images/pdu_test_successful.png)

---

#### 2. Pengujian Ping CLI dari Command Prompt Host `Karl (700 host)`:
Setelah tabel ARP pada seluruh router terisi, pengujian ping dilakukan melalui antarmuka Command Prompt host `Karl (700 host)` menuju host `JJ (95 host)` pada alamat `10.83.14.2`:

![Bukti Pengujian Ping CLI PC Karl](images/pengujian_ping_cmd.png)

```cmd
Cisco Packet Tracer SERVER Command Line 1.0
C:\>ping 10.83.14.2

Pinging 10.83.14.2 with 32 bytes of data:

Reply from 10.83.14.2: bytes=32 time=1ms TTL=125
Reply from 10.83.14.2: bytes=32 time<1ms TTL=125
Reply from 10.83.14.2: bytes=32 time<1ms TTL=125
Reply from 10.83.14.2: bytes=32 time<1ms TTL=125

Ping statistics for 10.83.14.2:
    Packets: Sent = 4, Received = 4, Lost = 0 (0% loss),
Approximate round trip times in milli-seconds:
    Minimum = 0ms, Maximum = 1ms, Average = 0ms
```

**Analisis Hasil Output Ping:**
1. **Packet Loss**: `0% loss` (4 paket terkirim, 4 paket diterima sempurna tanpa timeout).
2. **Nilai TTL = 125**: Nilai Time To Live awal host adalah `128`. Paket melintasi 3 router hop (`Psyche` → `Wired` → `Cyberia`), sehingga nilai TTL berkurang 3 ($128128 - 3 = 125), membuktikan paket telah melalui proses perutean *Layer 3* yang benar.

---

## 10. Otomatisasi Lingkungan Jaringan (Skrip Linux Bash & GNS3)

Implementasi skrip otomatisasi Linux Bash yang siap dijalankan pada lingkungan virtualisasi GNS3 (Docker debinet/alpinet) untuk seluruh router dan host, serta skrip pengujian matriks ping otomatis.

### Konfigurasi dan Penjelasan:
Seluruh skrip diletakkan pada direktori `VLSM-CPT/script_bash/`:
1. `VLSM-CPT/script_bash/routers/*.sh`: Mengaktifkan `sysctl -w net.ipv4.ip_forward=1`, membilas antarmuka (`ip addr flush`), menetapkan IP subnetting, dan mendaftarkan static routing Linux (`ip route replace`).
2. `VLSM-CPT/script_bash/hosts/*.sh`: Menetapkan IP interface `eth0` dan rute default (`ip route replace default via <gateway>`).
3. `VLSM-CPT/script_bash/test_ping_semua.sh`: Menguji ping antar-node dan mencetak laporan matriks sukses konektivitas.

### Bukti Verifikasi & Skrip Bash:

#### Hasil Pengujian Skrip Matriks Ping Otomatis (`test_ping_semua.sh`):
```text
====================================================================
           UJI KONEKTIVITAS MATRIX END-TO-END (MODUL 4 K-39)
====================================================================
[SUCCESS] Karl (10.83.0.2)       -> Lin (10.83.0.3)          : 0.04 ms
[SUCCESS] Omnipresence (10.83.4.2)-> Denpa (10.83.4.3)        : 0.05 ms
[SUCCESS] Collective (10.83.10.2) -> Ghost (10.83.10.3)       : 0.04 ms
[SUCCESS] Alice (10.83.12.2)      -> Reika (10.83.12.3)       : 0.06 ms
[SUCCESS] Yasuo (10.83.13.2)      -> Miho (10.83.13.3)        : 0.05 ms
[SUCCESS] Lilith (10.83.14.130)   -> Specter (10.83.14.131)   : 0.05 ms
[SUCCESS] Lain (10.83.15.2)       -> Mika (10.83.15.3)        : 0.06 ms
[SUCCESS] Karl (10.83.0.2)       -> JJ (10.83.14.2)          : 1.82 ms (Cross-Router)
[SUCCESS] Karl (10.83.0.2)       -> Masayuki (10.83.8.2)     : 1.25 ms (Cross-Router)
[SUCCESS] Masayuki (10.83.8.2)   -> Lain (10.83.15.2)        : 2.41 ms (Cross-Router)
[SUCCESS] Collective (10.83.10.2)-> Taro (10.83.15.66)       : 2.10 ms (Cross-Router)
[SUCCESS] Alice (10.83.12.2)     -> Eiri (10.83.16.29)       : 1.95 ms (Cross-Router)
====================================================================
HASIL UJI KONEKTIVITAS: 12/12 BERHASIL (100% SUKSES - ZERO PACKET LOSS)
====================================================================
```

---

#### Skrip Router Wired (`VLSM-CPT/script_bash/routers/wired.sh`):
```bash
sysctl -w net.ipv4.ip_forward=1

ip addr flush dev eth0
ip addr add 10.83.16.58/30 dev eth0
ip link set eth0 up

ip addr flush dev eth1
ip addr add 10.83.16.33/29 dev eth1
ip link set eth1 up

ip addr flush dev eth2
ip addr add 10.83.16.61/30 dev eth2
ip link set eth2 up

ip addr flush dev eth3
ip addr add 10.83.16.65/30 dev eth3
ip link set eth3 up

ip route replace 10.83.14.0/25 via 10.83.16.57
ip route replace 10.83.0.0/22 via 10.83.16.34
ip route replace 10.83.8.0/23 via 10.83.16.35
ip route replace 10.83.15.192/26 via 10.83.16.35
ip route replace 10.83.4.0/22 via 10.83.16.36
ip route replace 10.83.16.40/29 via 10.83.16.36
ip route replace 10.83.16.68/30 via 10.83.16.36
ip route replace 10.83.12.0/23 via 10.83.16.62
ip route replace 10.83.15.64/26 via 10.83.16.62
ip route replace 10.83.10.0/23 via 10.83.16.66
ip route replace 10.83.14.128/25 via 10.83.16.66
ip route replace 10.83.15.0/26 via 10.83.16.66
ip route replace 10.83.15.128/26 via 10.83.16.66
ip route replace 10.83.16.0/27 via 10.83.16.66
ip route replace 10.83.16.48/29 via 10.83.16.66
ip route replace 10.83.16.72/29 via 10.83.16.66
ip route replace 10.83.16.80/28 via 10.83.16.66
```

#### Skrip Host Karl (`VLSM-CPT/script_bash/hosts/karl.sh`):
```bash
ip addr flush dev eth0
ip addr add 10.83.0.2/22 dev eth0
ip link set eth0 up
ip route replace default via 10.83.0.1
```

---

## Bagian 2: Penggabungan Rute & Supernetting CIDR

## Topologi Jaringan GNS3 CIDR

Pada praktikum Modul 4 ini (*Serial Experiments Lain — Layer:04: The Wired Expansion*), skenario **CIDR (*Classless Inter-Domain Routing*)** dan **Supernetting** diimplementasikan pada simulator **GNS3** menggunakan *container* Docker **`ardhptr21/debinet:latest`**. Seluruh entitas dalam jaringan *The Wired* terhubung melalui router gerbang utama **Cyberia** yang tersambung ke dunia luar melalui node **NAT1** (`eth0`), mengalir ke router pusat **Wired**, lalu bercabang menuju router **Navi** di timur, rantai **Tachibana** s.d. **Shibuya** di selatan, serta segmen bersama (*shared broadcast domain*) **Switch2** milik **Psyche**, **Copland**, dan **Schumann** di barat:

![Topologi GNS3](../images/Screenshot 2026-11-05 185719.png)

### Parameter Global GNS3 & CIDR:
- **Prefix IP Kelompok K-39**: `10.83.0.0/16` (Supernet Induk Hasil Penggabungan `H1`: `10.83.0.0/19`)
- **Metode Perhitungan GNS3**: CIDR (*Classless Inter-Domain Routing* — *Bottom-Up Supernetting / Route Aggregation*)
- **Image Container GNS3**: `ardhptr21/debinet:latest` (Debian Linux dengan `iproute2` & `iptables`)
- **Upstream Internet (NAT)**: Interface `eth0` pada router `Cyberia` terhubung ke `NAT1` (`192.168.122.0/24`) dengan translasi `iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE`.
- **Jumlah Subnet**: 25 Subnet (`A1` s.d. `A25`) yang digabungkan secara bertahap melalui 7 tahap penggabungan (`B1`–`B11`, `C1`–`C4`, `D1`–`D3`, `E1`–`E2`, `F1`–`F2`, `G1`, hingga `H1`).
- **Total Kebutuhan IP**: 2.814 IP (tanpa celah / *zero gap* dalam rentang `10.83.0.0` s.d. `10.83.16.91`).
- **Total Perangkat**: 13 Router Docker (`debinet`), 13 Ethernet Switch GNS3 (`Switch1`–`Switch13`), 25 Node Host Docker (`debinet`), dan 1 Node `NAT1`.

### Struktur Direktori Folder `CIDR/`:
```text
├── CIDR/                                    # Folder Induk Pengerjaan CIDR & GNS3 (Muhammad Atallah Mas'udi)
│   ├── script_bash/                         # Skrip otomatisasi konfigurasi Linux (/root/script.sh) di GNS3
│   │   ├── hosts/                           # Skrip penetapan IP & default gateway 25 host (.sh)
│   │   ├── routers/                         # Skrip ip_forward, iptables NAT, & static routing 13 router (.sh)
│   │   ├── hitung_cidr.sh                   # Skrip ringkasan tahapan penggabungan & supernetting CIDR
│   │   └── test_ping_semua.sh               # Skrip matriks pengujian konektivitas antar-node di GNS3
│   ├── Jarkom-Modul-4-2026-K-39.gns3project # File GNS3 Portable Project siap uji (CIDR 10.83)
│   ├── Jarkom-Modul-4-2026-K-39.xlsx        # Lembar kerja resmi perhitungan VLSM & CIDR Kelompok K-39
│   ├── tree_pembagian_ip_cidr_10.83.png     # Diagram visual pohon penggabungan & alokasi IP CIDR
│   └── README.md                            # Laporan resmi pengerjaan CIDR di GNS3
```

### Tabel Alokasi IP Address Host (25 Node Docker `debinet`):
| Node | Interface | IP Address | Netmask | Prefix | Gateway | Router Induk | Subnet |
| :--- | :--- | :--- | :--- | :---: | :--- | :--- | :--- |
| **Karl (700 host)** | `eth0` | `10.83.0.2` | `255.255.252.0` | `/22` | `10.83.0.1` | Psyche | Subnet A1 |
| **Lin (180 host)** | `eth0` | `10.83.0.3` | `255.255.252.0` | `/22` | `10.83.0.1` | Psyche | Subnet A1 |
| **Omnipresence (510 host)** | `eth0` | `10.83.4.2` | `255.255.252.0` | `/22` | `10.83.4.1` | Accela | Subnet A2 |
| **Denpa (3 host)** | `eth0` | `10.83.4.3` | `255.255.252.0` | `/22` | `10.83.4.1` | Accela | Subnet A2 |
| **Masayuki (300 host)** | `eth0` | `10.83.8.2` | `255.255.254.0` | `/23` | `10.83.8.1` | Copland | Subnet A3 |
| **Collective (260 host)** | `eth0` | `10.83.10.2` | `255.255.254.0` | `/23` | `10.83.10.1` | Tachibana | Subnet A4 |
| **Ghost (6 host)** | `eth0` | `10.83.10.3` | `255.255.254.0` | `/23` | `10.83.10.1` | Tachibana | Subnet A4 |
| **Alice (208 host)** | `eth0` | `10.83.12.2` | `255.255.255.0` | `/24` | `10.83.12.1` | Navi | Subnet A5 |
| **Reika (45 host)** | `eth0` | `10.83.12.3` | `255.255.255.0` | `/24` | `10.83.12.1` | Navi | Subnet A5 |
| **Yasuo (120 host)** | `eth0` | `10.83.13.2` | `255.255.255.0` | `/24` | `10.83.13.1` | Navi | Subnet A6 |
| **Miho (18 host)** | `eth0` | `10.83.13.3` | `255.255.255.0` | `/24` | `10.83.13.1` | Navi | Subnet A6 |
| **Kuma (4 host)** | `eth0` | `10.83.13.4` | `255.255.255.0` | `/24` | `10.83.13.1` | Navi | Subnet A6 |
| **JJ (95 host)** | `eth0` | `10.83.14.2` | `255.255.255.128` | `/25` | `10.83.14.1` | Cyberia | Subnet A7 |
| **MyuMyu (30 host)** | `eth0` | `10.83.14.3` | `255.255.255.128` | `/25` | `10.83.14.1` | Cyberia | Subnet A7 |
| **Lilith (77 host)** | `eth0` | `10.83.14.130` | `255.255.255.128` | `/25` | `10.83.14.129` | Deus | Subnet A8 |
| **Specter (21 host)** | `eth0` | `10.83.14.131` | `255.255.255.128` | `/25` | `10.83.14.129` | Deus | Subnet A8 |
| **Lain (57 host)** | `eth0` | `10.83.15.2` | `255.255.255.192` | `/26` | `10.83.15.1` | Shibuya | Subnet A9 |
| **Mika (4 host)** | `eth0` | `10.83.15.3` | `255.255.255.192` | `/26` | `10.83.15.1` | Shibuya | Subnet A9 |
| **Taro (57 host)** | `eth0` | `10.83.15.66` | `255.255.255.192` | `/26` | `10.83.15.65` | Navi | Subnet A10 |
| **Chisa (23 host)** | `eth0` | `10.83.15.130` | `255.255.255.192` | `/26` | `10.83.15.129` | Protocol7 | Subnet A11 |
| **Hodgeson (9 host)** | `eth0` | `10.83.15.131` | `255.255.255.192` | `/26` | `10.83.15.129` | Protocol7 | Subnet A11 |
| **Juri (31 host)** | `eth0` | `10.83.15.194` | `255.255.255.192` | `/26` | `10.83.15.193` | Copland | Subnet A12 |
| **Semi (14 host)** | `eth0` | `10.83.16.2` | `255.255.255.224` | `/27` | `10.83.16.1` | Phantoma | Subnet A13 |
| **Akashic (3 host)** | `eth0` | `10.83.16.42` | `255.255.255.248` | `/29` | `10.83.16.41` | Schumann | Subnet A15 |
| **Eiri (2 host)** | `eth0` | `10.83.16.50` | `255.255.255.248` | `/29` | `10.83.16.49` | Knights | Subnet A16 |

### Tabel Alokasi IP Address Interface Router (13 Router Docker `debinet`):
| Router | Interface GNS3 | IP Address | Subnet Mask | Prefix | Keterangan Sambungan |
| :--- | :--- | :--- | :--- | :---: | :--- |
| **Cyberia** | `eth0`<br>`eth1`<br>`eth2` | `DHCP / 192.168.122.2`<br>`10.83.14.1`<br>`10.83.16.57` | `255.255.255.0`<br>`255.255.255.128`<br>`255.255.255.252` | `/24`<br>`/25`<br>`/30` | Uplink ke NAT1 (Masquerade)<br>LAN Switch1: JJ & MyuMyu (A7)<br>Point-to-point ke Wired (A17) |
| **Wired** | `eth0`<br>`eth1`<br>`eth2`<br>`eth3` | `10.83.16.58`<br>`10.83.16.33`<br>`10.83.16.61`<br>`10.83.16.65` | `255.255.255.252`<br>`255.255.255.248`<br>`255.255.255.252`<br>`255.255.255.252` | `/30`<br>`/29`<br>`/30`<br>`/30` | Point-to-point ke Cyberia (A17)<br>Shared Switch2 ke Psyche, Copland, Schumann (A14)<br>Point-to-point ke Navi (A18)<br>Point-to-point ke Tachibana (A19) |
| **Navi** | `eth0`<br>`eth1`<br>`eth2`<br>`eth3` | `10.83.16.62`<br>`10.83.12.1`<br>`10.83.15.65`<br>`10.83.13.1` | `255.255.255.252`<br>`255.255.255.0`<br>`255.255.255.192`<br>`255.255.255.0` | `/30`<br>`/24`<br>`/26`<br>`/24` | Point-to-point ke Wired (A18)<br>LAN Switch6: Alice & Reika (A5)<br>LAN Switch7: Taro (A10)<br>LAN Switch8: Yasuo, Miho, Kuma (A6) |
| **Psyche** | `eth0`<br>`eth1` | `10.83.16.34`<br>`10.83.0.1` | `255.255.255.248`<br>`255.255.252.0` | `/29`<br>`/22` | Shared Switch2 dari Wired (A14)<br>LAN Switch3: Karl & Lin (A1) |
| **Copland** | `eth0`<br>`eth1`<br>`eth2` | `10.83.16.35`<br>`10.83.15.193`<br>`10.83.8.1` | `255.255.255.248`<br>`255.255.255.192`<br>`255.255.254.0` | `/29`<br>`/26`<br>`/23` | Shared Switch2 dari Wired (A14)<br>Direct Link ke Juri (A12)<br>LAN Switch4: Masayuki (A3) |
| **Schumann** | `eth0`<br>`eth1`<br>`eth2` | `10.83.16.36`<br>`10.83.16.41`<br>`10.83.16.69` | `255.255.255.248`<br>`255.255.255.248`<br>`255.255.255.252` | `/29`<br>`/29`<br>`/30` | Shared Switch2 dari Wired (A14)<br>Direct Link ke Akashic (A15)<br>Point-to-point ke Accela (A20) |
| **Accela** | `eth0`<br>`eth1` | `10.83.16.70`<br>`10.83.4.1` | `255.255.255.252`<br>`255.255.252.0` | `/30`<br>`/22` | Point-to-point ke Schumann (A20)<br>LAN Switch5: Omnipresence & Denpa (A2) |
| **Tachibana** | `eth0`<br>`eth1`<br>`eth2` | `10.83.16.66`<br>`10.83.10.1`<br>`10.83.16.73` | `255.255.255.252`<br>`255.255.254.0`<br>`255.255.255.252` | `/30`<br>`/23`<br>`/30` | Point-to-point ke Wired (A19)<br>LAN Switch9: Collective & Ghost (A4)<br>Point-to-point ke Deus (A21) |
| **Deus** | `eth0`<br>`eth1`<br>`eth2` | `10.83.16.74`<br>`10.83.14.129`<br>`10.83.16.77` | `255.255.255.252`<br>`255.255.255.128`<br>`255.255.255.252` | `/30`<br>`/25`<br>`/30` | Point-to-point ke Tachibana (A21)<br>LAN Switch10: Lilith & Specter (A8)<br>Point-to-point ke Protocol7 (A22) |
| **Protocol7** | `eth0`<br>`eth1`<br>`eth2` | `10.83.16.78`<br>`10.83.15.129`<br>`10.83.16.81` | `255.255.255.252`<br>`255.255.255.192`<br>`255.255.255.252` | `/30`<br>`/26`<br>`/30` | Point-to-point ke Deus (A22)<br>LAN Switch11: Chisa & Hodgeson (A11)<br>Point-to-point ke Knights (A23) |
| **Knights** | `eth0`<br>`eth1`<br>`eth2` | `10.83.16.82`<br>`10.83.16.49`<br>`10.83.16.85` | `255.255.255.252`<br>`255.255.255.248`<br>`255.255.255.252` | `/30`<br>`/29`<br>`/30` | Point-to-point ke Protocol7 (A23)<br>Direct Link ke Eiri (A16)<br>Point-to-point ke Phantoma (A24) |
| **Phantoma** | `eth0`<br>`eth1`<br>`eth2` | `10.83.16.86`<br>`10.83.16.1`<br>`10.83.16.89` | `255.255.255.252`<br>`255.255.255.224`<br>`255.255.255.252` | `/30`<br>`/27`<br>`/30` | Point-to-point ke Knights (A24)<br>LAN Switch12: Semi (A13)<br>Point-to-point ke Shibuya (A25) |
| **Shibuya** | `eth0`<br>`eth1` | `10.83.16.90`<br>`10.83.15.1` | `255.255.255.252`<br>`255.255.255.192` | `/30`<br>`/26` | Point-to-point ke Phantoma (A25)<br>LAN Switch13: Lain & Mika (A9) |

## 1. Analisis Kebutuhan Host & Penentuan Netmask Dasar (A1 - A25)

Langkah pertama dalam metode **CIDR (*Classless Inter-Domain Routing*)** adalah menentukan kebutuhan alamat IP pada setiap segmen rute dengan menjumlahkan seluruh host dan antarmuka router yang berada pada segmen tersebut. Ukuran blok biner tiap segmen ditentukan agar memenuhi $2^{(32 - 	ext{Prefix})} \ge 	ext{Jumlah IP} + 2$ (untuk mengakomodasi *Network Address* dan *Broadcast Address*).

| Nama Subnet | Rute | Rincian Kebutuhan (Host + Router) | Jumlah IP | Netmask | Kapasitas Blok |
| :---: | :--- | :--- | :---: | :---: | :---: |
| **A1** | `Psyche > Switch3 > Karl, Lin` | $700 + 180 + 1	ext{ router}$ | 881 | `/22` | 1.024 |
| **A2** | `Accela > Switch5 > Omnipresence, Denpa` | $510 + 3 + 1	ext{ router}$ | 514 | `/22` | 1.024 |
| **A3** | `Copland > Switch4 > Masayuki` | $300 + 1	ext{ router}$ | 301 | `/23` | 512 |
| **A4** | `Tachibana > Switch9 > Collective, Ghost` | $260 + 6 + 1	ext{ router}$ | 267 | `/23` | 512 |
| **A5** | `Navi > Switch6 > Alice, Reika` | $208 + 45 + 1	ext{ router}$ | 254 | `/24` | 256 |
| **A6** | `Navi > Switch8 > Yasuo, Miho, Kuma` | $120 + 18 + 4 + 1	ext{ router}$ | 143 | `/24` | 256 |
| **A7** | `Cyberia > Switch1 > JJ, MyuMyu` | $95 + 30 + 1	ext{ router}$ | 126 | `/25` | 128 |
| **A8** | `Deus > Switch10 > Lilith, Specter` | $77 + 21 + 1	ext{ router}$ | 99 | `/25` | 128 |
| **A9** | `Shibuya > Switch13 > Lain, Mika` | $57 + 4 + 1	ext{ router}$ | 62 | `/26` | 64 |
| **A10** | `Navi > Switch7 > Taro` | $57 + 1	ext{ router}$ | 58 | `/26` | 64 |
| **A11** | `Protocol7 > Switch11 > Chisa, Hodgeson` | $23 + 9 + 1	ext{ router}$ | 33 | `/26` | 64 |
| **A12** | `Copland > Juri` | $31 + 1	ext{ router}$ | 32 | `/26` | 64 |
| **A13** | `Phantoma > Switch12 > Semi` | $14 + 1	ext{ router}$ | 15 | `/27` | 32 |
| **A14** | `Wired > Switch2 > Psyche, Copland, Schumann` | $4	ext{ router interface}$ | 4 | `/29` | 8 |
| **A15** | `Schumann > Akashic` | $3 + 1	ext{ router}$ | 4 | `/29` | 8 |
| **A16** | `Knights > Eiri` | $2 + 1	ext{ router}$ | 3 | `/29` | 8 |
| **A17 - A25** | `Point-to-Point Antar Router (9 Segmen)` | $2	ext{ router interface per link}$ | $9 	imes 2 = 18$ | `/30` | $9 	imes 4 = 36$ |
| **Total** | **Seluruh Segmen The Wired** | **25 Subnet** | **2.814** | **`/20` (Blok Pohon `/19`)** | **4.188** |

## 2. Tabel Penggabungan Subnetting CIDR (Bottom-Up Supernetting Tahap I – VII)

Berbeda dengan VLSM yang memecah blok secara *top-down*, metode **CIDR (*Bottom-Up Supernetting*)** menggabungkan pasangan subnet dari tingkat daun (`A1` s.d. `A25`) ke atas secara bertahap menggunakan aturan agregasi biner:

$$\text{Netmask Akhir} = /\left(\min(\text{Prefix}_1, \text{Prefix}_2) - 1\right)$$

Agar tidak terjadi pemborosan ruang alamat (*zero address gap*), penggabungan dilakukan antara pasangan subnet yang memiliki ukuran prefix setara atau paling berdekatan pada setiap tahap sebagaimana tercatat pada Sheet **`Penggabungan - CIDR`** di file [Jarkom-Modul-4-2026-K-39.xlsx](Jarkom-Modul-4-2026-K-39.xlsx):

### Tahap I (Menghasilkan `B1` s.d. `B11`):
| Subnet Hasil | Gabungan 1 (Subnet) | Gabungan 1 (Netmask) | Gabungan 2 (Subnet) | Gabungan 2 (Netmask) | Netmask Akhir |
| :---: | :---: | :---: | :---: | :---: | :---: |
| **B1** | `A1` | `/22` | `A2` | `/22` | **`/21`** |
| **B2** | `A3` | `/23` | `A4` | `/23` | **`/22`** |
| **B3** | `A5` | `/24` | `A6` | `/24` | **`/23`** |
| **B4** | `A7` | `/25` | `A8` | `/25` | **`/24`** |
| **B5** | `A9` | `/26` | `A10` | `/26` | **`/25`** |
| **B6** | `A11` | `/26` | `A12` | `/26` | **`/25`** |
| **B7** | `A14` | `/29` | `A15` | `/29` | **`/28`** |
| **B8** | `A17` | `/30` | `A18` | `/30` | **`/29`** |
| **B9** | `A19` | `/30` | `A20` | `/30` | **`/29`** |
| **B10** | `A21` | `/30` | `A22` | `/30` | **`/29`** |
| **B11** | `A23` | `/30` | `A24` | `/30` | **`/29`** |

### Tahap II s.d. Tahap VII (Menghasilkan `C1` s.d. Root `H1`):
| Tahap | Subnet Hasil | Gabungan 1 (Subnet) | Gabungan 1 (Netmask) | Gabungan 2 (Subnet) | Gabungan 2 (Netmask) | Netmask Akhir |
| :---: | :---: | :---: | :---: | :---: | :---: | :---: |
| **II** | **C1** | `B5` | `/25` | `B6` | `/25` | **`/24`** |
| **II** | **C2** | `A16` | `/29` | `B8` | `/29` | **`/28`** |
| **II** | **C3** | `B9` | `/29` | `B10` | `/29` | **`/28`** |
| **II** | **C4** | `B11` | `/29` | `A25` | `/30` | **`/28`** |
| **III** | **D1** | `B4` | `/24` | `C1` | `/24` | **`/23`** |
| **III** | **D2** | `B7` | `/28` | `C2` | `/28` | **`/27`** |
| **III** | **D3** | `C3` | `/28` | `C4` | `/28` | **`/27`** |
| **IV** | **E1** | `B3` | `/23` | `D1` | `/23` | **`/22`** |
| **IV** | **E2** | `A13` | `/27` | `D2` | `/27` | **`/26`** |
| **V** | **F1** | `B2` | `/22` | `E1` | `/22` | **`/21`** |
| **V** | **F2** | `E2` | `/26` | `D3` | `/27` | **`/25`** |
| **VI** | **G1** | `B1` | `/21` | `F1` | `/21` | **`/20`** |
| **VII** | **H1 (Root)** | `G1` | `/20` | `F2` | `/25` | **`/19`** |

## 3. Desain Pohon Penggabungan & Pembagian IP CIDR (CIDR Tree)

Dari hasil penggabungan puncak **`H1` (`10.83.0.0/19`)**, blok alamat diturunkan kembali ke setiap cabang anak kiri (`Gabungan 1`) dan anak kanan (`Gabungan 2`). Karena seluruh blok mulai dari `B1 (/21)` hingga `C1 (/24)` di bawah `G1 (/20)` berukuran penuh ($4.096	ext{ IP}$), maka `F2 (/25)` langsung menempati batas awal blok `/20` kedua yaitu `10.83.16.0/25` tanpa ada satu pun alamat IP yang terbuang di antaranya:

![Pohon Pembagian IP CIDR](pohon cidr.png)

## 4. Rencana Pengalamatan & Tabel Subnetting CIDR (A1 - A25)

Tabel berikut merupakan hasil penelusuran alamat IP dari pohon CIDR pada Sheet **`Pembagian IP - CIDR`** di file [Jarkom-Modul-4-2026-K-39.xlsx](Jarkom-Modul-4-2026-K-39.xlsx):

| Subnet | Network ID | Netmask | Broadcast | Range IP |
| :---: | :--- | :--- | :--- | :--- |
| **A1** | `10.83.0.0` | `255.255.252.0` | `10.83.3.255` | `10.83.0.1 - 10.83.3.254` |
| **A2** | `10.83.4.0` | `255.255.252.0` | `10.83.7.255` | `10.83.4.1 - 10.83.7.254` |
| **A3** | `10.83.8.0` | `255.255.254.0` | `10.83.9.255` | `10.83.8.1 - 10.83.9.254` |
| **A4** | `10.83.10.0` | `255.255.254.0` | `10.83.11.255` | `10.83.10.1 - 10.83.11.254` |
| **A5** | `10.83.12.0` | `255.255.255.0` | `10.83.12.255` | `10.83.12.1 - 10.83.12.254` |
| **A6** | `10.83.13.0` | `255.255.255.0` | `10.83.13.255` | `10.83.13.1 - 10.83.13.254` |
| **A7** | `10.83.14.0` | `255.255.255.128` | `10.83.14.127` | `10.83.14.1 - 10.83.14.126` |
| **A8** | `10.83.14.128` | `255.255.255.128` | `10.83.14.255` | `10.83.14.129 - 10.83.14.254` |
| **A9** | `10.83.15.0` | `255.255.255.192` | `10.83.15.63` | `10.83.15.1 - 10.83.15.62` |
| **A10** | `10.83.15.64` | `255.255.255.192` | `10.83.15.127` | `10.83.15.65 - 10.83.15.126` |
| **A11** | `10.83.15.128` | `255.255.255.192` | `10.83.15.191` | `10.83.15.129 - 10.83.15.190` |
| **A12** | `10.83.15.192` | `255.255.255.192` | `10.83.15.255` | `10.83.15.193 - 10.83.15.254` |
| **A13** | `10.83.16.0` | `255.255.255.224` | `10.83.16.31` | `10.83.16.1 - 10.83.16.30` |
| **A14** | `10.83.16.32` | `255.255.255.248` | `10.83.16.39` | `10.83.16.33 - 10.83.16.38` |
| **A15** | `10.83.16.40` | `255.255.255.248` | `10.83.16.47` | `10.83.16.41 - 10.83.16.46` |
| **A16** | `10.83.16.48` | `255.255.255.248` | `10.83.16.55` | `10.83.16.49 - 10.83.16.54` |
| **A17** | `10.83.16.56` | `255.255.255.252` | `10.83.16.59` | `10.83.16.57 - 10.83.16.58` |
| **A18** | `10.83.16.60` | `255.255.255.252` | `10.83.16.63` | `10.83.16.61 - 10.83.16.62` |
| **A19** | `10.83.16.64` | `255.255.255.252` | `10.83.16.67` | `10.83.16.65 - 10.83.16.66` |
| **A20** | `10.83.16.68` | `255.255.255.252` | `10.83.16.71` | `10.83.16.69 - 10.83.16.70` |
| **A21** | `10.83.16.72` | `255.255.255.252` | `10.83.16.75` | `10.83.16.73 - 10.83.16.74` |
| **A22** | `10.83.16.76` | `255.255.255.252` | `10.83.16.79` | `10.83.16.77 - 10.83.16.78` |
| **A23** | `10.83.16.80` | `255.255.255.252` | `10.83.16.83` | `10.83.16.81 - 10.83.16.82` |
| **A24** | `10.83.16.84` | `255.255.255.252` | `10.83.16.87` | `10.83.16.85 - 10.83.16.86` |
| **A25** | `10.83.16.88` | `255.255.255.252` | `10.83.16.91` | `10.83.16.89 - 10.83.16.90` |

## 5. Konfigurasi Router Gateway Cyberia (NAT) & Core Hub Wired di GNS3

Sesuai aturan praktikum nomor 5, seluruh konfigurasi diletakkan pada `/root/script.sh` di masing-masing container `ardhptr21/debinet:latest`. Karena container Docker tidak menjalankan daemon `/etc/init.d/networking`, penetapan alamat IP dilakukan secara langsung menggunakan utilitas kernel `iproute2` (`ip addr`, `ip link`, `ip route`) sekaligus disimpan ke `/etc/network/interfaces`.

### Konfigurasi dan Penjelasan Supernetting CIDR:
- **Cyberia (`script_bash/routers/cyberia.sh`)**:
  - Meminta IP uplink ke `NAT1` pada `eth0` melalui `/gns3/bin/udhcpc` serta mengaktifkan translasi alamat `iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE` agar seluruh node di dalam *The Wired* dapat mengakses jaringan luar.
  - Menggunakan **1 baris *supernet route* CIDR** (`ip route replace 10.83.0.0/19 via 10.83.16.58`) yang mewakili hasil penggabungan puncak **`H1 (/19)`**. Karena kernel Linux menerapkan *Longest Prefix Match*, paket menuju `A7` (`10.83.14.0/25` di `eth1`) dan `A17` (`10.83.16.56/30` di `eth2`) tetap dikirim langsung ke antarmuka lokal, sedangkan seluruh paket menuju 23 subnet lainnya di bawah `Wired` otomatis dirutekan hanya dengan satu baris rute tersebut.
- **Wired (`script_bash/routers/wired.sh`)**:
  - Merangkum rute ke cabang **Navi** (`A5` + `A6`) menggunakan *supernet* **`B3` (`10.83.12.0/23`)** serta merangkum link rantai bawah menggunakan *supernet* **`B10` (`10.83.16.72/29`)** dan **`C4` (`10.83.16.80/28`)**.

#### Skrip Bash Router Cyberia (`script_bash/routers/cyberia.sh`):
```bash
#!/bin/bash
ip link set eth0 up
/gns3/bin/udhcpc -i eth0 -s /gns3/etc/udhcpc.script 2>/dev/null || (ip addr add 192.168.122.2/24 dev eth0 && ip route replace default via 192.168.122.1)

ip addr flush dev eth1
ip addr add 10.83.14.1/25 dev eth1
ip link set eth1 up

ip addr flush dev eth2
ip addr add 10.83.16.57/30 dev eth2
ip link set eth2 up

sysctl -w net.ipv4.ip_forward=1
iptables -t nat -F
iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE

# Supernetting CIDR H1: 1 baris mencakup seluruh 23 subnet di bawah Wired
ip route replace 10.83.0.0/19 via 10.83.16.58
```

#### Skrip Bash Router Wired (`script_bash/routers/wired.sh`):
```bash
#!/bin/bash
sysctl -w net.ipv4.ip_forward=1

ip addr flush dev eth0 && ip addr add 10.83.16.58/30 dev eth0 && ip link set eth0 up
ip addr flush dev eth1 && ip addr add 10.83.16.33/29 dev eth1 && ip link set eth1 up
ip addr flush dev eth2 && ip addr add 10.83.16.61/30 dev eth2 && ip link set eth2 up
ip addr flush dev eth3 && ip addr add 10.83.16.65/30 dev eth3 && ip link set eth3 up

ip route replace default via 10.83.16.57
ip route replace 10.83.14.0/25 via 10.83.16.57

# Rute Cabang Barat (Switch2: Psyche, Copland, Schumann, Accela)
ip route replace 10.83.0.0/22 via 10.83.16.34
ip route replace 10.83.8.0/23 via 10.83.16.35
ip route replace 10.83.15.192/26 via 10.83.16.35
ip route replace 10.83.4.0/22 via 10.83.16.36
ip route replace 10.83.16.40/29 via 10.83.16.36
ip route replace 10.83.16.68/30 via 10.83.16.36

# Rute Cabang Timur (Navi: Supernet B3 10.83.12.0/23 + A10 10.83.15.64/26)
ip route replace 10.83.12.0/23 via 10.83.16.62
ip route replace 10.83.15.64/26 via 10.83.16.62

# Rute Backbone Selatan (Tachibana s.d. Shibuya dengan Supernetting CIDR)
ip route replace 10.83.10.0/23 via 10.83.16.66
ip route replace 10.83.14.128/25 via 10.83.16.66
ip route replace 10.83.15.0/26 via 10.83.16.66
ip route replace 10.83.15.128/26 via 10.83.16.66
ip route replace 10.83.16.0/27 via 10.83.16.66
ip route replace 10.83.16.48/29 via 10.83.16.66
ip route replace 10.83.16.72/29 via 10.83.16.66
ip route replace 10.83.16.80/28 via 10.83.16.66
```

## 6. Konfigurasi Router Cabang Barat (Psyche, Copland, Schumann, Accela)

Keempat router cabang barat berbagi segmen `Switch2` pada Subnet `A14` (`10.83.16.32/29`). Masing-masing router di `Switch2` (`Psyche`, `Copland`, `Schumann`) memiliki rute langsung menuju rekan sejajarnya di `Switch2` agar lalu lintas antar-cabang barat tidak perlu memutar lewat `Wired`, ditambah rute *default* (`default via 10.83.16.33`) ke `Wired`.

#### Skrip Bash Router Psyche (`script_bash/routers/psyche.sh`):
```bash
#!/bin/bash
sysctl -w net.ipv4.ip_forward=1
ip addr flush dev eth0 && ip addr add 10.83.16.34/29 dev eth0 && ip link set eth0 up
ip addr flush dev eth1 && ip addr add 10.83.0.1/22 dev eth1 && ip link set eth1 up

ip route replace default via 10.83.16.33
ip route replace 10.83.8.0/23 via 10.83.16.35
ip route replace 10.83.15.192/26 via 10.83.16.35
ip route replace 10.83.4.0/22 via 10.83.16.36
ip route replace 10.83.16.40/29 via 10.83.16.36
ip route replace 10.83.16.68/30 via 10.83.16.36
```

#### Skrip Bash Router Copland (`script_bash/routers/copland.sh`):
```bash
#!/bin/bash
sysctl -w net.ipv4.ip_forward=1
ip addr flush dev eth0 && ip addr add 10.83.16.35/29 dev eth0 && ip link set eth0 up
ip addr flush dev eth1 && ip addr add 10.83.15.193/26 dev eth1 && ip link set eth1 up
ip addr flush dev eth2 && ip addr add 10.83.8.1/23 dev eth2 && ip link set eth2 up

ip route replace default via 10.83.16.33
ip route replace 10.83.0.0/22 via 10.83.16.34
ip route replace 10.83.4.0/22 via 10.83.16.36
ip route replace 10.83.16.40/29 via 10.83.16.36
ip route replace 10.83.16.68/30 via 10.83.16.36
```

#### Skrip Bash Router Schumann (`script_bash/routers/schumann.sh`):
```bash
#!/bin/bash
sysctl -w net.ipv4.ip_forward=1
ip addr flush dev eth0 && ip addr add 10.83.16.36/29 dev eth0 && ip link set eth0 up
ip addr flush dev eth1 && ip addr add 10.83.16.41/29 dev eth1 && ip link set eth1 up
ip addr flush dev eth2 && ip addr add 10.83.16.69/30 dev eth2 && ip link set eth2 up

ip route replace default via 10.83.16.33
ip route replace 10.83.4.0/22 via 10.83.16.70
ip route replace 10.83.0.0/22 via 10.83.16.34
ip route replace 10.83.8.0/23 via 10.83.16.35
ip route replace 10.83.15.192/26 via 10.83.16.35
```

#### Skrip Bash Router Accela (`script_bash/routers/accela.sh`):
```bash
#!/bin/bash
sysctl -w net.ipv4.ip_forward=1
ip addr flush dev eth0 && ip addr add 10.83.16.70/30 dev eth0 && ip link set eth0 up
ip addr flush dev eth1 && ip addr add 10.83.4.1/22 dev eth1 && ip link set eth1 up

ip route replace default via 10.83.16.69
```

## 7. Konfigurasi Router Cabang Timur (Navi)

Router **Navi** merupakan *stub router* yang melayani tiga segmen LAN sekaligus (`Switch6` / Subnet `A5`, `Switch7` / Subnet `A10`, dan `Switch8` / Subnet `A6`). Seluruh paket keluar cukup diarahkan melalui satu *default route* ke `Wired` (`10.83.16.61`).

#### Skrip Bash Router Navi (`script_bash/routers/navi.sh`):
```bash
#!/bin/bash
sysctl -w net.ipv4.ip_forward=1
ip addr flush dev eth0 && ip addr add 10.83.16.62/30 dev eth0 && ip link set eth0 up
ip addr flush dev eth1 && ip addr add 10.83.12.1/24 dev eth1 && ip link set eth1 up
ip addr flush dev eth2 && ip addr add 10.83.15.65/26 dev eth2 && ip link set eth2 up
ip addr flush dev eth3 && ip addr add 10.83.13.1/24 dev eth3 && ip link set eth3 up

ip route replace default via 10.83.16.61
```

## 8. Konfigurasi Rantai Router Backbone Selatan (Tachibana s.d. Shibuya)

Rantai router selatan (`Tachibana` → `Deus` → `Protocol7` → `Knights` → `Phantoma` → `Shibuya`) menggunakan kombinasi *default route* ke arah hulu (menuju `Wired`) dan rute agregasi CIDR ke arah hilir (menuju `Shibuya`).

#### Skrip Bash Router Tachibana (`script_bash/routers/tachibana.sh`):
```bash
#!/bin/bash
sysctl -w net.ipv4.ip_forward=1
ip addr flush dev eth0 && ip addr add 10.83.16.66/30 dev eth0 && ip link set eth0 up
ip addr flush dev eth1 && ip addr add 10.83.10.1/23 dev eth1 && ip link set eth1 up
ip addr flush dev eth2 && ip addr add 10.83.16.73/30 dev eth2 && ip link set eth2 up

ip route replace default via 10.83.16.65
ip route replace 10.83.14.128/25 via 10.83.16.74
ip route replace 10.83.15.0/26 via 10.83.16.74
ip route replace 10.83.15.128/26 via 10.83.16.74
ip route replace 10.83.16.0/27 via 10.83.16.74
ip route replace 10.83.16.48/29 via 10.83.16.74
ip route replace 10.83.16.76/30 via 10.83.16.74
ip route replace 10.83.16.80/28 via 10.83.16.74
```

#### Skrip Bash Router Deus (`script_bash/routers/deus.sh`):
```bash
#!/bin/bash
sysctl -w net.ipv4.ip_forward=1
ip addr flush dev eth0 && ip addr add 10.83.16.74/30 dev eth0 && ip link set eth0 up
ip addr flush dev eth1 && ip addr add 10.83.14.129/25 dev eth1 && ip link set eth1 up
ip addr flush dev eth2 && ip addr add 10.83.16.77/30 dev eth2 && ip link set eth2 up

ip route replace default via 10.83.16.73
ip route replace 10.83.15.0/26 via 10.83.16.78
ip route replace 10.83.15.128/26 via 10.83.16.78
ip route replace 10.83.16.0/27 via 10.83.16.78
ip route replace 10.83.16.48/29 via 10.83.16.78
ip route replace 10.83.16.80/28 via 10.83.16.78
```

#### Skrip Bash Router Protocol7 (`script_bash/routers/protocol7.sh`):
```bash
#!/bin/bash
sysctl -w net.ipv4.ip_forward=1
ip addr flush dev eth0 && ip addr add 10.83.16.78/30 dev eth0 && ip link set eth0 up
ip addr flush dev eth1 && ip addr add 10.83.15.129/26 dev eth1 && ip link set eth1 up
ip addr flush dev eth2 && ip addr add 10.83.16.81/30 dev eth2 && ip link set eth2 up

ip route replace default via 10.83.16.77
ip route replace 10.83.15.0/26 via 10.83.16.82
ip route replace 10.83.16.0/27 via 10.83.16.82
ip route replace 10.83.16.48/29 via 10.83.16.82
ip route replace 10.83.16.84/30 via 10.83.16.82
ip route replace 10.83.16.88/30 via 10.83.16.82
```

#### Skrip Bash Router Knights (`script_bash/routers/knights.sh`):
```bash
#!/bin/bash
sysctl -w net.ipv4.ip_forward=1
ip addr flush dev eth0 && ip addr add 10.83.16.82/30 dev eth0 && ip link set eth0 up
ip addr flush dev eth1 && ip addr add 10.83.16.49/29 dev eth1 && ip link set eth1 up
ip addr flush dev eth2 && ip addr add 10.83.16.85/30 dev eth2 && ip link set eth2 up

ip route replace default via 10.83.16.81
ip route replace 10.83.15.0/26 via 10.83.16.86
ip route replace 10.83.16.0/27 via 10.83.16.86
ip route replace 10.83.16.88/30 via 10.83.16.86
```

#### Skrip Bash Router Phantoma (`script_bash/routers/phantoma.sh`):
```bash
#!/bin/bash
sysctl -w net.ipv4.ip_forward=1
ip addr flush dev eth0 && ip addr add 10.83.16.86/30 dev eth0 && ip link set eth0 up
ip addr flush dev eth1 && ip addr add 10.83.16.1/27 dev eth1 && ip link set eth1 up
ip addr flush dev eth2 && ip addr add 10.83.16.89/30 dev eth2 && ip link set eth2 up

ip route replace default via 10.83.16.85
ip route replace 10.83.15.0/26 via 10.83.16.90
```

#### Skrip Bash Router Shibuya (`script_bash/routers/shibuya.sh`):
```bash
#!/bin/bash
sysctl -w net.ipv4.ip_forward=1
ip addr flush dev eth0 && ip addr add 10.83.16.90/30 dev eth0 && ip link set eth0 up
ip addr flush dev eth1 && ip addr add 10.83.15.1/26 dev eth1 && ip link set eth1 up

ip route replace default via 10.83.16.89
```

## 9. Konfigurasi Statis 25 Host Container & Otomatisasi GNS3 API

Seluruh 25 *node host* di GNS3 dikonfigurasi melalui file `/root/script.sh` masing-masing (tersedia lengkap pada direktori [script_bash/hosts/](script_bash/hosts/)).

#### Contoh Skrip Host Lain (`script_bash/hosts/lain.sh`):
```bash
#!/bin/bash
ip addr flush dev eth0
ip addr add 10.83.15.2/26 dev eth0
ip link set eth0 up
ip route replace default via 10.83.15.1
echo "nameserver 8.8.8.8" > /etc/resolv.conf
```

#### Contoh Skrip Host JJ (`script_bash/hosts/jj.sh`):
```bash
#!/bin/bash
ip addr flush dev eth0
ip addr add 10.83.14.2/25 dev eth0
ip link set eth0 up
ip route replace default via 10.83.14.1
echo "nameserver 8.8.8.8" > /etc/resolv.conf
```

## 10. Pengujian Konektivitas End-to-End GNS3 & Analisis TTL Kernel Linux

Verifikasi dilakukan dengan memeriksa tabel antarmuka (`ip a`), tabel routing (`ip route`), serta menjalankan skrip pengujian matriks konektivitas [script_bash/test_ping_semua.sh](script_bash/test_ping_semua.sh) dari dalam container GNS3.

### Bukti Verifikasi Antarmuka & Tabel Routing Router Cyberia di GNS3:
```text
root@Cyberia:~# ip a
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1000
    inet 127.0.0.1/8 scope host lo
121813: eth0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel state UNKNOWN group default qlen 1000
    inet 192.168.122.2/24 scope global eth0
121816: eth1: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel state UNKNOWN group default qlen 1000
    inet 10.83.14.1/25 scope global eth1
121819: eth2: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel state UNKNOWN group default qlen 1000
    inet 10.83.16.57/30 scope global eth2

root@Cyberia:~# ip route
default via 192.168.122.1 dev eth0
10.83.0.0/19 via 10.83.16.58 dev eth2
10.83.14.0/25 dev eth1 proto kernel scope link src 10.83.14.1
10.83.16.56/30 dev eth2 proto kernel scope link src 10.83.16.57
192.168.122.0/24 dev eth0 proto kernel scope link src 192.168.122.2
```

### Analisis Pengujian Ping & Perhitungan Hop TTL di GNS3 (Linux Container):
Berbeda dengan Cisco Packet Tracer yang memiliki nilai default TTL `128` dan menjatuhkan paket ICMP saat proses resolusi ARP awal, kernel Linux pada container Docker `debinet` memiliki karakteristik:
1. **Default TTL Linux = 64**: Setiap router Linux yang melakukan *IP forwarding* (`net.ipv4.ip_forward=1`) mengurangi nilai TTL sebesar `1`.
   - Saat host **Karl** (`10.83.0.2`) melakukan `ping` ke **JJ** (`10.83.14.2`), paket melewati 3 router (`Psyche` → `Wired` → `Cyberia`), sehingga penerima mencatat **`ttl=61`** ($64 - 3 = 61$).
   - Saat host **Lain** (`10.83.15.2` di `Shibuya`) melakukan `ping` ke **JJ** (`10.83.14.2` di `Cyberia`), paket melewati 8 router (`Shibuya` → `Phantoma` → `Knights` → `Protocol7` → `Deus` → `Tachibana` → `Wired` → `Cyberia`), sehingga nilai TTL yang tercatat adalah **`ttl=56`** ($64 - 8 = 56$).
2. **ARP Queue Buffering di Linux**: Kernel Linux menyimpan paket ICMP keluar di dalam *neighbour resolution queue* (`unres_qlen`) sementara *ARP Request* dikirimkan pada setiap hop, sehingga *ping* pertama langsung berhasil (**0% packet loss**) begitu balasan ARP diterima tanpa perlu mengulang pengiriman paket.

