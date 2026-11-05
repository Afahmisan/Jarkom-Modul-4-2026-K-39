#!/bin/bash

PREFIX_UTAMA="10.83"

DATA_SUBNET=(
    "A1|Psyche > Switch3 > Karl, Lin|881"
    "A2|Accela > Switch5 > Omnipresence, Denpa|514"
    "A3|Copland > Switch4 > Masayuki|301"
    "A4|Tachibana > Switch9 > Collective, Ghost|267"
    "A5|Navi > Switch6 > Alice, Reika|254"
    "A6|Navi > Switch8 > Yasuo, Miho, Kuma|143"
    "A7|Cyberia > Switch1 > JJ, MyuMyu|126"
    "A8|Deus > Switch10 > Lilith, Specter|99"
    "A9|Shibuya > Switch13 > Lain, Mika|62"
    "A10|Navi > Switch7 > Taro|58"
    "A11|Protocol7 > Switch11 > Chisa, Hodgeson|33"
    "A12|Copland > Juri|32"
    "A13|Phantoma > Switch12 > Semi|15"
    "A14|Wired > Switch2 > Psyche, Copland, Schumann|4"
    "A15|Schumann > Akashic|4"
    "A16|Knights > Eiri|3"
    "A17|Cyberia > Wired|2"
    "A18|Wired > Navi|2"
    "A19|Wired > Tachibana|2"
    "A20|Schumann > Accela|2"
    "A21|Tachibana > Deus|2"
    "A22|Deus > Protocol7|2"
    "A23|Protocol7 > Knights|2"
    "A24|Knights > Phantoma|2"
    "A25|Phantoma > Shibuya|2"
)

int_to_ip() {
    local val=$1
    local o3=$(( (val >> 8) & 255 ))
    local o4=$(( val & 255 ))
    echo "${PREFIX_UTAMA}.${o3}.${o4}"
}

prefix_to_mask() {
    local p=$1
    local host_bits=$(( 32 - p ))
    local mask_val=$(( (0xFFFFFFFF << host_bits) & 0xFFFFFFFF ))
    printf "%d.%d.%d.%d" \
        $(( (mask_val >> 24) & 255 )) \
        $(( (mask_val >> 16) & 255 )) \
        $(( (mask_val >> 8) & 255 )) \
        $(( mask_val & 255 ))
}

printf "%-4s %-4s %-4s %-15s %-14s %-29s %-14s %s\n" \
    "Kode" "IP" "Pref" "Netmask" "Network" "Range IP" "Broadcast" "Rute"

OFFSET=0
TOTAL_IP=0

for row in "${DATA_SUBNET[@]}"; do
    IFS='|' read -r KODE RUTE NEEDED <<< "$row"
    TOTAL_IP=$(( TOTAL_IP + NEEDED ))

    HOST_BITS=2
    while [ $(( (1 << HOST_BITS) - 2 )) -lt "$NEEDED" ]; do
        HOST_BITS=$(( HOST_BITS + 1 ))
    done

    PREFIX=$(( 32 - HOST_BITS ))
    BLOCK_SIZE=$(( 1 << HOST_BITS ))

    NET_IP=$(int_to_ip $OFFSET)
    FIRST_IP=$(int_to_ip $(( OFFSET + 1 )))
    LAST_IP=$(int_to_ip $(( OFFSET + BLOCK_SIZE - 2 )))
    BC_IP=$(int_to_ip $(( OFFSET + BLOCK_SIZE - 1 )))
    NETMASK=$(prefix_to_mask $PREFIX)

    printf "%-4s %-4d /%-3d %-15s %-14s %-29s %-14s %s\n" \
        "$KODE" "$NEEDED" "$PREFIX" "$NETMASK" "$NET_IP" "${FIRST_IP} - ${LAST_IP}" "$BC_IP" "$RUTE"

    OFFSET=$(( OFFSET + BLOCK_SIZE ))
done

echo "Total IP: ${TOTAL_IP}"
