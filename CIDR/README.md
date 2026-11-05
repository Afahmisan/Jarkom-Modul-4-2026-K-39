# Bagian 2: CIDR & Supernetting (Kelompok K-39)

**Penanggung Jawab:** Muhammad Atallah Mas'udi (5027251071)  
**Prefix Utama:** `10.83.0.0/16`  
**Lembar Kerja Spreadsheet:** [Google Spreadsheet Resmi K-39](https://docs.google.com/spreadsheets/d/1XlCe701xFm7mK43r-sJaImQ2owLYlwCm/edit?usp=sharing&ouid=116660344884914721699&rtpof=true&sd=true)

---

## 1. Panduan Alur Pengerjaan CIDR

Pada bagian ini, dilakukan penggabungan subnet (*Route Summarization / Supernetting*) secara bertingkat (*bottom-up*) dari subnet terkecil hingga membentuk satu rute utama.

### Langkah Kerja:
1. **Penggabungan Subnet (Sheet: `Penggabungan - CIDR`)**:
   * Pasangkan subnet-subnet awal (`A1` s.d. `A25`) yang saling bertetangga secara hierarkis.
   * **Tahap I**: Gabungkan pasangan Subnet A menjadi Subnet B (`B1`, `B2`, dst.).
   * **Tahap II**: Gabungkan pasangan Subnet B menjadi Subnet C (`C1`, `C2`, dst.).
   * **Tahap III & Lanjutan**: Teruskan hingga menghasilkan satu *Major Supernet*.
   * **Rumus Netmask Akhir**: Ambil prefix subnet terbesar (angka slash terkecil) lalu kurangi 1 ($\min(P_1, P_2) - 1$).

2. **Tabel Pengalamatan CIDR (Sheet: `Pembagian IP - CIDR`)**:
   * Masukkan Network ID, Netmask, Broadcast, dan Range IP yang valid untuk setiap blok hasil penggabungan.

3. **Implementasi Routing CIDR**:
   * Daftarkan summary route pada router-router perantara (seperti `Cyberia` dan `Wired`) menggunakan prefix hasil supernetting untuk meminimalisasi ukuran routing table.

---

## 2. Struktur Direktori CIDR

```text
CIDR/
├── config/                 # File teks konfigurasi per-node untuk skenario CIDR
├── scripts/                # Skrip bash otomatisasi routing supernetting
└── README.md               # Catatan dan panduan pengerjaan bagian CIDR
```
