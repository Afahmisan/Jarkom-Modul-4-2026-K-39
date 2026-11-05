#!/bin/bash
# Skrip Kalkulator Penggabungan Bottom-Up & Pembagian IP CIDR (Kelompok K-39: 10.83.0.0/19)
echo "=========================================================================="
echo "   KALKULATOR PENGGABUNGAN & PEMBAGIAN IP CIDR (KELOMPOK K-39: 10.83)     "
echo "=========================================================================="
echo "[Tahap I]   B1(A1+A2)=/21 | B2(A3+A4)=/22 | B3(A5+A6)=/23 | B4(A7+A8)=/24"
echo "            B5(A9+A10)=/25| B6(A11+A12)=/25| B7(A14+A15)=/28| B8..B11=/29"
echo "[Tahap II]  C1(B5+B6)=/24 | C2(A16+B8)=/28 | C3(B9+B10)=/28 | C4(B11+A25)=/28"
echo "[Tahap III] D1(B4+C1)=/23 | D2(B7+C2)=/27  | D3(C3+C4)=/27"
echo "[Tahap IV]  E1(B3+D1)=/22 | E2(A13+D2)=/26"
echo "[Tahap V]   F1(B2+E1)=/21 | F2(E2+D3)=/25"
echo "[Tahap VI]  G1(B1+F1)=/20"
echo "[Tahap VII] H1(G1+F2)=/19 -> ROOT SUPERNET: 10.83.0.0/19 (255.255.224.0)"
echo "=========================================================================="
