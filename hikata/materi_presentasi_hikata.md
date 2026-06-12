# 🖥️ Slide Deck Presentasi: Pengembangan Aplikasi "Hi Kata"
*Media Pembelajaran Aksara Jepang (Hiragana & Katakana) Berbasis Mobile dengan Flutter*

---

## Slide 1: Cover Utama
* **Judul Slide**: Hi Kata (ひかた) — Revolusi Belajar Aksara Jepang yang Interaktif & Menyenangkan
* **Sub-judul**: Aplikasi Mobile Berbasis Flutter untuk Penguasaan Hiragana & Katakana
* **Presenter**: [Nama Anda]
* **Instansi**: [Nama Kampus / Universitas]
* **Catatan Presenter**:
  > *"Selamat pagi/siang bapak/ibu dosen penguji dan rekan-rekan. Hari ini saya akan mempresentasikan proyek pengembangan aplikasi mobile bernama Hi Kata, sebuah media inovatif untuk mempercepat penguasaan Hiragana dan Katakana bagi pemula."*

---

## Slide 2: Latar Belakang Masalah
* **Poin Utama (Pain Points)**:
  * **Kurva Belajar yang Curam**: Bentuk visual aksara Jepang (terutama Katakana yang bersudut tajam) sering kali membingungkan pemula.
  * **Media Pasif**: Buku teks konvensional tidak menyediakan feedback pelafalan instan (audio) dan evaluasi interaktif.
  * **Kehilangan Motivasi**: Tanpa adanya gamifikasi, pelajar mandiri sering kali berhenti belajar di tengah jalan.
* **Solusi Kami**: Aplikasi **Hi Kata** menyatukan metode asosiasi visual, audio native, dan sistem leveling kuis untuk menjaga motivasi belajar secara berkelanjutan.

---

## Slide 3: Tujuan Pengembangan Aplikasi
* **Poin Utama**:
  * **Asosiasi Memori**: Membantu pengguna mengenali bentuk Hiragana & Katakana melalui kartu belajar digital (*flashcards*).
  * **Pelatihan Fonetik**: Melatih pengucapan yang benar dengan audio berkualitas tinggi dari penutur asli (*native speaker*).
  * **Pengukuran Hasil**: Menguji kecepatan membaca dan mendengarkan pengguna secara real-time lewat kuis interaktif.

---

## Slide 4: Analisis Kebutuhan Sistem
* **Kebutuhan Pengguna (User Needs)**:
  * Akses cepat tanpa internet (offline first).
  * Tampilan yang nyaman di mata untuk sesi belajar berdurasi lama.
* **Kebutuhan Aplikasi (Software Requirements)**:
  * Engine Text-to-Speech (TTS) / Pemutar Audio responsif.
  * Database lokal ringan untuk menyimpan progres level kuis.
* **Kebutuhan Perangkat (Hardware)**:
  * Smartphone dengan sistem operasi Android (min. Android 5.0) atau iOS (min. iOS 12).

---

## Slide 5: Perancangan Sistem
* **Gambaran Umum Arsitektur**:
  * Menggunakan pola arsitektur terstruktur (Model-View-Service-Database).
* **Alur Penggunaan Aplikasi (User Journey)**:
  1. Pengguna membuka aplikasi (Splash Screen) -> Autentikasi/Login.
  2. Memilih kategori aksara di halaman Beranda (Hiragana / Katakana).
  3. Mempelajari huruf di Tab Belajar & berlatih menggunakan Flashcard.
  4. Mengerjakan kuis level -> Jika nilai $\ge 60\%$, level berikutnya otomatis terbuka.

---

## Slide 6: Teknologi yang Digunakan
* **Flutter & Dart**: Framework lintas platform buatan Google untuk membangun UI native super cepat 60 FPS dari satu basis kode.
* **SharedPreferences**: Menyimpan preferensi pengguna seperti username, status login, skor tertinggi, dan pilihan tema.
* **Audio Service**: Library pemutar audio bawaan untuk menjalankan sampel pengucapan huruf jepang tanpa lag.
* **Material Design**: Kerangka acuan tata letak UI yang ergonomis, modern, dan ramah pengguna.

---

## Slide 7: Proses Implementasi (Bagaimana Aplikasi Dibangun?)
* **Pengembangan UI**: Menggunakan Widget Flutter (Scaffold, Column, GridView) untuk menyusun komponen antarmuka yang dinamis.
* **Manajemen Data**: Menyusun database statis huruf Hiragana dan Katakana dalam format list objek Dart (`JapaneseCharacter`).
* **Sistem Navigasi**: Menggunakan `Navigator` untuk mengarahkan pengguna berpindah dari dasbor belajar menuju layar kuis.
* **Sistem Kuis & Leveling**:
  * Integrasi SQLite (`DatabaseHelper`) untuk mencatat status kunci level.
  * Implementasi pengacak pilihan ganda agar pilihan jawaban selalu bervariasi setiap kuis diulang.

---

## Slide 8: Fitur-Fitur Unggulan (Bagian 1)
* **Fitur Belajar Hiragana & Katakana**: Tabel interaktif terstruktur per baris huruf (Gojūon, Dakuten, Handakuten, Yōon).
* **Flashcard Huruf Jepang**: Mode hafalan interaktif bolak-balik (Depan: Huruf, Belakang: Romaji dan cara baca).
* **Audio Pelafalan**: Tombol suara di setiap huruf untuk memperdengarkan audio asli bahasa Jepang secara langsung.

---

## Slide 9: Fitur-Fitur Unggulan (Bagian 2)
* **Kuis Pilihan Ganda**: Evaluasi membaca romaji berdasarkan huruf Jepang yang muncul.
* **Kuis Pendengaran (Listening Quiz)**: Kuis tingkat lanjut di mana pengguna mendengar pengucapan audio, lalu memilih huruf Jepang yang tepat.
* **Dynamic Theme & Dark Mode**:
  * Aplikasi otomatis menyesuaikan warna (Hijau Emerald untuk Hiragana, Emas/Kuning untuk Katakana) agar menciptakan impresi psikologis yang selaras dengan jenis huruf yang dipelajari.

---

## Slide 10: Hasil Implementasi & Desain Aplikasi
* **Identitas Visual**:
  * **Hijau Emerald**: Digunakan sebagai warna utama aplikasi karena memiliki efek psikologis menenangkan dan meningkatkan fokus belajar.
  * **Gold/Emas**: Digunakan khusus untuk modul Katakana untuk menegaskan perbedaan konten dan memberikan atmosfer visual yang premium.
* **User Friendly**: Navigasi menggunakan sistem Tab Bar bawah yang mudah dijangkau oleh jempol tangan.

---

## Slide 11: Kelebihan Aplikasi Hi Kata
* **Offline First**: Seluruh materi audio, kamus data, kuis, dan penyimpanan progres dapat berjalan 100% tanpa koneksi internet.
* **Sistem Gamifikasi**: Pengguna merasa tertantang menyelesaikan kuis karena ingin membuka level selanjutnya (*Level Unlock*) dan memecahkan rekor skor tertinggi (*High Score*).
* **Dukungan Audio-Visual**: Sangat cocok untuk berbagai tipe pelajar (pelajar visual maupun auditori).

---

## Slide 12: Rencana Pengembangan Selanjutnya (Future Works)
* **Penambahan Kanji**: Memperluas cakupan materi belajar ke aksara Kanji dasar (N5).
* **Kurikulum JLPT**: Pengelompokan kosakata berdasarkan level ujian resmi Japanese Language Proficiency Test.
* **Sinkronisasi Cloud**: Integrasi Firebase Auth dan Firestore agar progres belajar dapat dicadangkan dan diakses dari berbagai perangkat.
* **Statistik Belajar Analitik**: Grafik mingguan untuk memantau durasi belajar dan persentase peningkatan akurasi kuis.

---

## Slide 13: Kesimpulan
* **Kesimpulan Akhir**:
  * Aplikasi **Hi Kata** berhasil dikembangkan sebagai solusi media pembelajaran aksara Jepang yang praktis, modern, dan interaktif.
  * Integrasi kuis, audio native, dan gamifikasi terbukti menciptakan alur belajar mandiri yang terstruktur bagi pemula.
  * Dengan basis kode Flutter, aplikasi ini siap didistribusikan ke platform Android maupun iOS dengan kinerja optimal.
* **Penutup**: Terima kasih. Ada pertanyaan? (Q&A Session)
