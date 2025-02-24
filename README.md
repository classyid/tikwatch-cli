# TikWatch CLI 🎥

Tool sederhana berbasis command line untuk menonton TikTok Live menggunakan MPV player. Dirancang untuk pengalaman menonton yang ringan dan efisien di sistem Linux/Unix.

## ✨ Fitur

- 📺 Streaming TikTok Live tanpa browser
- 🔄 Auto-reconnect saat koneksi terputus
- 🎮 Kontrol tampilan video (rotasi, ukuran)
- 🚀 Performa ringan dengan MPV player
- 💻 Interface command line yang simpel

## 📋 Persyaratan Sistem

- Linux/Unix OS
- MPV player
- curl
- jq

## 🚀 Instalasi

1. Clone repository:
```bash
git clone https://github.com/classyid/tikwatch-cli.git

2. Install dependencies:
# Debian/Ubuntu
```bash
sudo apt install mpv jq curl
# Fedora
```bash
sudo dnf install mpv jq curl
# Arch Linux
```bash
sudo pacman -S mpv jq curl

3. Berikan izin eksekusi:
```bash
chmod +x tiktok_player.sh
```
📖 Cara Penggunaan

Edit file tiktok_player.sh dan ganti URL TikTok Live:

```bash
TIKTOK_LIVE_URL="https://www.tiktok.com/@username/live"
```
Jalankan script:

```bash
./tiktok_player.sh
```
⚙️ Konfigurasi
Opsi Tampilan Video
Script menyediakan beberapa opsi tampilan yang bisa disesuaikan:

Rotasi Video:
```bash
mpv --video-rotate=270 "$live_url"

Ukuran Spesifik:
```bash
mpv --width=720 --height=480 "$live_url"

Auto-fit:
```bash
mpv --autofit=720x480 "$live_url"

Skala Persentase:
```bash
mpv --autofit=30% "$live_url"

🤝 Kontribusi
Kontribusi selalu diterima! Silakan buat pull request atau laporkan issue.

## 📝 Lisensi

Proyek ini dilisensikan di bawah MIT License - lihat file [LICENSE](LICENSE) untuk detail.

⚠️ Disclaimer
Tool ini dibuat untuk tujuan pembelajaran dan penggunaan pribadi. Gunakan dengan bijak dan patuhi Terms of Service TikTok.
