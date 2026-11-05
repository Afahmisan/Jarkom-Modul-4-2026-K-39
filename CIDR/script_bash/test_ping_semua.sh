#!/bin/bash
# Skrip Uji Konektivitas Matriks End-to-End GNS3 (Kelompok K-39: 10.83.0.0/19)
echo "===================================================================="
echo "          UJI KONEKTIVITAS MATRIX END-TO-END CIDR GNS3 (K-39)       "
echo "===================================================================="
TARGETS=(
    "Karl:10.83.0.2"
    "Lin:10.83.0.3"
    "Omnipresence:10.83.4.2"
    "Denpa:10.83.4.3"
    "Masayuki:10.83.8.2"
    "Collective:10.83.10.2"
    "Ghost:10.83.10.3"
    "Alice:10.83.12.2"
    "Reika:10.83.12.3"
    "Yasuo:10.83.13.2"
    "JJ:10.83.14.2"
    "Lilith:10.83.14.130"
    "Lain:10.83.15.2"
    "Taro:10.83.15.66"
    "Chisa:10.83.15.130"
    "Juri:10.83.15.194"
    "Semi:10.83.16.2"
    "Akashic:10.83.16.42"
    "Eiri:10.83.16.50"
)
PASS=0
TOTAL=${#TARGETS[@]}
for item in "${TARGETS[@]}"; do
    NAME="${item%%:*}"
    IP="${item##*:}"
    RES=$(ping -c 1 -W 2 "$IP" 2>/dev/null | grep 'time=' | sed -E 's/.*time=([0-9.]+ ms).*/\1/')
    if [ -n "$RES" ]; then
        printf "[SUCCESS] %-15s (%-14s) -> Reachable (%s)\n" "$NAME" "$IP" "$RES"
        PASS=$((PASS + 1))
    else
        printf "[FAILED]  %-15s (%-14s) -> Unreachable\n" "$NAME" "$IP"
    fi
done
echo "===================================================================="
echo "HASIL UJI KONEKTIVITAS: ${PASS}/${TOTAL} BERHASIL"
echo "===================================================================="
