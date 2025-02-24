#!/bin/bash

# File: tiktok_player.sh
# Description: Script untuk menampilkan TikTok Live dengan MPV player

###################
# Konfigurasi Dasar #
###################
TIKTOK_LIVE_URL="https://www.tiktok.com/@username/live"
TIMEOUT=30

###################
# Fungsi Utama #
###################
get_room_id() {
    local live_url="$1"
    local response
    local room_id
    
    response=$(curl -s -m "$TIMEOUT" \
        -A "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36" \
        "$live_url")
    
    room_id=$(echo "$response" | grep -oP 'roomId["\s:=]+\K[0-9]+' | head -1)
    
    if [ -z "$room_id" ]; then
        room_id=$(echo "$response" | grep -oP '"roomId":"[0-9]+"' | cut -d'"' -f4 | head -1)
    fi
    
    echo "$room_id"
}

fetch_and_play_tiktok() {
    local room_id
    room_id=$(get_room_id "$TIKTOK_LIVE_URL")
    
    if [ -z "$room_id" ]; then
        echo "ERROR: Tidak bisa mendapatkan roomId dari TikTok live link"
        return 1
    fi
    
    local api_url="https://www.tiktok.com/api/live/detail/?aid=1988&roomID=$room_id"
    local response
    response=$(curl -s -m "$TIMEOUT" \
        -A "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36" \
        "$api_url")

    local status_code
    status_code=$(echo "$response" | jq -r '.status_code')
    
    if [ "$status_code" != "0" ]; then
        echo "ERROR: Gagal mengambil data dari TikTok API"
        return 1
    fi
    
    local status
    local live_url
    
    status=$(echo "$response" | jq -r '.LiveRoomInfo.status')
    
    if [ "$status" == "2" ]; then
        live_url=$(echo "$response" | jq -r '.LiveRoomInfo.liveUrl')
        echo "Live URL ditemukan, memulai MPV..."
        # Pilih salah satu opsi di bawah sesuai kebutuhan
        # mpv --video-rotate=270 --width=720 --height=480 "$live_url"  # Opsi 1: Set ukuran spesifik
        # mpv --video-rotate=270 --autofit=720x480 "$live_url"         # Opsi 2: Autofit ke ukuran
        mpv --autofit=50% "$live_url"              # Opsi 3: Skala persentase
    else
        echo "TikTok live sedang offline"
    fi
}

# Validasi dependencies
command -v mpv >/dev/null 2>&1 || { echo "MPV tidak terinstall. Install dengan: apt install mpv"; exit 1; }
command -v jq >/dev/null 2>&1 || { echo "jq tidak terinstall. Install dengan: apt install jq"; exit 1; }
command -v curl >/dev/null 2>&1 || { echo "curl tidak terinstall. Install dengan: apt install curl"; exit 1; }

# Jalankan fetch dan play
fetch_and_play_tiktok
