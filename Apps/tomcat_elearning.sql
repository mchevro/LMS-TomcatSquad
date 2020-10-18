-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Waktu pembuatan: 16 Okt 2020 pada 13.29
-- Versi server: 10.4.14-MariaDB
-- Versi PHP: 7.3.21

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `tomcat_flask_elearning`
--

-- --------------------------------------------------------

--
-- Struktur dari tabel `admin`
--

CREATE TABLE `admin` (
  `id` int(11) NOT NULL,
  `nama` varchar(35) NOT NULL,
  `username` varchar(10) NOT NULL,
  `password` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `admin`
--

INSERT INTO `admin` (`id`, `nama`, `username`, `password`) VALUES
(1, 'Tomcat Squad', 'admin', 'admin');

-- --------------------------------------------------------

--
-- Struktur dari tabel `kontributor`
--

CREATE TABLE `kontributor` (
  `id` int(11) NOT NULL,
  `foto` varchar(100) CHARACTER SET latin1 NOT NULL,
  `nama` varchar(35) NOT NULL,
  `materi` varchar(100) NOT NULL,
  `instagram` varchar(30) NOT NULL,
  `whatsapp` varchar(16) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `kontributor`
--

INSERT INTO `kontributor` (`id`, `foto`, `nama`, `materi`, `instagram`, `whatsapp`) VALUES
(1, 'mchevro.png', 'Mahendra Chevro Susanto', 'Cisco Packet Tracer', 'm.chevr0', '+62 81281662912');

-- --------------------------------------------------------

--
-- Struktur dari tabel `kuis`
--

CREATE TABLE `kuis` (
  `id` int(11) NOT NULL,
  `thumbnail` varchar(100) CHARACTER SET latin1 NOT NULL,
  `materi` varchar(50) NOT NULL,
  `deskripsi` varchar(100) NOT NULL,
  `embed` varchar(255) NOT NULL,
  `jumlah` int(50) NOT NULL,
  `waktu` date NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `kuis`
--

INSERT INTO `kuis` (`id`, `thumbnail`, `materi`, `deskripsi`, `embed`, `jumlah`, `waktu`) VALUES
(1, 'asj.jpg', 'Administrasi Sistem Jaringan', 'Latihan Linux', 'https://docs.google.com/forms/d/e/1FAIpQLSffrtKot8SJZ72IW4G8YTCjcSjktsZW9D6oNBZ1QnvYb5VSIg/viewform?embedded=true', 10, '2020-10-16');

-- --------------------------------------------------------

--
-- Struktur dari tabel `materi`
--

CREATE TABLE `materi` (
  `id` int(11) NOT NULL,
  `thumbnail` varchar(100) NOT NULL,
  `judul` varchar(50) NOT NULL,
  `deskripsi` varchar(100) NOT NULL,
  `youtube` varchar(255) NOT NULL,
  `modul` varchar(100) NOT NULL,
  `waktu` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `materi`
--

INSERT INTO `materi` (`id`, `thumbnail`, `judul`, `deskripsi`, `youtube`, `modul`, `waktu`) VALUES
(4, 'cisco.png', 'Tutorial Cisco Packet Tracer', 'Membuat Jaringan Menggunakan Simulasi Cisco Packet Tracer', 'https://www.youtube.com/embed/wRv7HrCNeBE?list=PL68UvONDEWz1K-jT3UdJs3USVYX9Gu_yF', '#', '2020-10-16');

-- --------------------------------------------------------

--
-- Struktur dari tabel `notifikasi`
--

CREATE TABLE `notifikasi` (
  `id` int(11) NOT NULL,
  `judul` varchar(100) NOT NULL,
  `link` varchar(255) NOT NULL,
  `jam` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `notifikasi`
--

INSERT INTO `notifikasi` (`id`, `judul`, `link`, `jam`) VALUES
(1, 'Tutorial Mkrotik', '/tutorial/1/Tutorial Mikrotik', '2020-10-15 04:57:23');

-- --------------------------------------------------------

--
-- Struktur dari tabel `user`
--

CREATE TABLE `user` (
  `id` int(11) NOT NULL,
  `nama` varchar(35) NOT NULL,
  `email` varchar(50) NOT NULL,
  `username` varchar(35) NOT NULL,
  `password` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `user`
--

INSERT INTO `user` (`id`, `nama`, `email`, `username`, `password`) VALUES
(1, 'Mahendra Chevro Susanto', 'mchevro19@gmail.com', 'mchevro', '$2b$12$R3LKjfjvCr2kEqG5iRCZ2.0skpSbmCHRmJcZ.79AwvCGKBJPQiK6e');

--
-- Indexes for dumped tables
--

--
-- Indeks untuk tabel `admin`
--
ALTER TABLE `admin`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `kontributor`
--
ALTER TABLE `kontributor`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `kuis`
--
ALTER TABLE `kuis`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `materi`
--
ALTER TABLE `materi`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `notifikasi`
--
ALTER TABLE `notifikasi`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT untuk tabel yang dibuang
--

--
-- AUTO_INCREMENT untuk tabel `admin`
--
ALTER TABLE `admin`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT untuk tabel `kontributor`
--
ALTER TABLE `kontributor`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT untuk tabel `kuis`
--
ALTER TABLE `kuis`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT untuk tabel `materi`
--
ALTER TABLE `materi`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT untuk tabel `notifikasi`
--
ALTER TABLE `notifikasi`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT untuk tabel `user`
--
ALTER TABLE `user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
