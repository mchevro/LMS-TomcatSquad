-- phpMyAdmin SQL Dump
-- version 5.0.4
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Mar 09, 2021 at 05:46 AM
-- Server version: 10.4.17-MariaDB
-- PHP Version: 7.3.27

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `tomcatsq_elearning`
--

-- --------------------------------------------------------

--
-- Table structure for table `jurnal`
--

CREATE TABLE `jurnal` (
  `id` int(11) NOT NULL,
  `nama` varchar(100) NOT NULL,
  `judul` varchar(200) NOT NULL,
  `file` varchar(255) NOT NULL,
  `tahun` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `kontributor`
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
-- Dumping data for table `kontributor`
--

INSERT INTO `kontributor` (`id`, `foto`, `nama`, `materi`, `instagram`, `whatsapp`) VALUES
(1, 'mchevro.png', 'Mahendra Chevro Susanto', 'Cisco Packet Tracer, Debian 9, Mikrotik', 'm.chevr0', '+62 81381662912'),
(2, 'no-user.png', 'Faldi Ramadhan', 'Cisco Packet Tracer', 'fadilkun45', '+62 89697404581'),
(3, 'ahnaf.jpg', 'Ahnaf Musyaffa Bisri Hendro Subagio', 'Debian 9', 'ahnafmusyafa', '+62 8191106565');

-- --------------------------------------------------------

--
-- Table structure for table `kuis`
--

CREATE TABLE `kuis` (
  `id` int(11) NOT NULL,
  `thumbnail` varchar(100) NOT NULL,
  `materi` varchar(50) NOT NULL,
  `deskripsi` varchar(100) NOT NULL,
  `embed` varchar(255) NOT NULL,
  `jumlah` int(50) NOT NULL,
  `waktu` date NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `kuis`
--

INSERT INTO `kuis` (`id`, `thumbnail`, `materi`, `deskripsi`, `embed`, `jumlah`, `waktu`) VALUES
(1, 'tlj.png', 'Teknik Layanan Dan Jaringan', 'Latihan 1', 'https://docs.google.com/forms/d/e/1FAIpQLSfnY9uEux9efZw7gb79pIHVfL8tvSIpOq9ruePu6iiwC0P-Fw/viewform?embedded=true', 10, '2020-12-14'),
(2, 'aij.png', 'Administrasi Infrastruktur Jaringan', 'Latihan 1', 'https://docs.google.com/forms/d/e/1FAIpQLScvH8hE1SeR_BG_6O78k7Cn-rPSX3ferDGJ-4p3C290o3UIxw/viewform?embedded=true', 10, '2020-12-14');

-- --------------------------------------------------------

--
-- Table structure for table `materi`
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
-- Dumping data for table `materi`
--

INSERT INTO `materi` (`id`, `thumbnail`, `judul`, `deskripsi`, `youtube`, `modul`, `waktu`) VALUES
(1, 'debian.png', 'Tutorial Debian 9', 'Cara Install Dan Konfigurasi Sistem Operasi Debian 9', 'https://www.youtube.com/embed/aE2ngxHNRzI?list=PL68UvONDEWz3oN38S9gqAzk8CUUBhAJWl', '#', '2021-03-08'),
(2, 'cisco.png', 'Tutorial Cisco Packet Tracer', 'Membuat Jaringan Menggunakan Simulasi Cisco Packet Tracer', 'https://www.youtube.com/embed/wRv7HrCNeBE?list=PL68UvONDEWz1K-jT3UdJs3USVYX9Gu_yF', 'Tutorial Cisco Packet Tracer.pdf', '2020-10-12'),
(3, 'mikrotik.png', 'Tutorial Mikrotik', 'Melakukan Basic Konfigurasi Router Mikrotik', 'https://www.youtube.com/embed/YZdKGi1VKts?list=PL68UvONDEWz2o_ZIyKvIK1-tsM5RB_SUY', '#', '2020-10-12'),
(4, 'troubleshooting.png', 'Troubleshooting Debian 9', 'Permasalahan Yang Sering Terjadi Saat Konfigurasi Sistem Operasi Debian 9', 'https://www.youtube.com/embed/gqVvrSr710A?list=PL68UvONDEWz0ruwU7vQ1Klg_lDVYKe-s3', '#', '2020-12-13'),
(5, 'TUGASXII.png', 'XII TKJ ', 'Sharing-Sharing Selesaikan Tugas-Tugas Kelas XII', 'https://www.youtube.com/embed/Q4Isth1mj9g?list=PL68UvONDEWz2RF80u1z4XLfZHvDfdNPZm', '#', '2020-10-23'),
(6, 'UKOM 2021.jpg', 'UKOM 2021', 'Membahas Soal Uji Kompentensi Dan Juga Melakukan Konfigurasi', 'https://www.youtube.com/embed/TmpDkYrO48E?list=PLi6rG0S2PuNnBp8CR79VXfl1ZX6ZWoS4m', '#', '2021-03-08');

-- --------------------------------------------------------

--
-- Table structure for table `notifikasi`
--

CREATE TABLE `notifikasi` (
  `id` int(11) NOT NULL,
  `judul` varchar(100) NOT NULL,
  `link` varchar(100) NOT NULL,
  `jam` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `notifikasi`
--

INSERT INTO `notifikasi` (`id`, `judul`, `link`, `jam`) VALUES
(1, '#11 ROUTING STATIC DI CISCO PACKET TRACER 7.3.1', '/materi/2/Cisco Packet Tracer', '2020-12-13 12:27:45');

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `id` int(11) NOT NULL,
  `nis` varchar(11) NOT NULL,
  `nama` varchar(35) NOT NULL,
  `kelas` varchar(10) NOT NULL,
  `level` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`id`, `nis`, `nama`, `kelas`, `level`) VALUES
(0, '123456', 'OPERATOR', '', 'admin'),
(1, '192010053', 'AKBAR EKA SAPUTRA', 'XI TKJ 1', 'user'),
(2, '192010054', 'ALIYAH RAMADHANTI', 'XI TKJ 1', 'user'),
(3, '192010055', 'AULIAS FIRMANSYAH ', 'XI TKJ 1', 'user'),
(4, '192010056', 'CAMILA TASYA AULIA', 'XI TKJ 1', 'user'),
(5, '192010057', 'DWI NIRIA ARIF', 'XI TKJ 1', 'user'),
(6, '192010058', 'ERWIN HERMAWAN', 'XI TKJ 1', 'user'),
(7, '192010059', 'FADIL KAUTSAR ', 'XI TKJ 1', 'user'),
(8, '192010060', 'FATUR RAHMAN ZAKI ', 'XI TKJ 1', 'user'),
(9, '192010061', 'FIKRI MOHAMMAD ALFADLY', 'XI TKJ 1', 'user'),
(10, '192010062', 'HADI KURNIA', 'XI TKJ 1', 'user'),
(11, '192010063', 'HILMANSYAH ASMADIN ', 'XI TKJ 1', 'user'),
(12, '192010064', 'JULYAN RACHMAN', 'XI TKJ 1', 'user'),
(13, '192010065', 'KRISTO SAPUTRA SIREGAR', 'XI TKJ 1', 'user'),
(14, '192010066', 'LAURENTIUS OMEGA JELANG MAHARDIKA ', 'XI TKJ 1', 'user'),
(15, '192010067', 'M. BACHTIAR DEVANSA', 'XI TKJ 1', 'user'),
(16, '192010068', 'MOHAMMAD ZULFI RAHMADIO ', 'XI TKJ 1', 'user'),
(17, '192010069', 'MUHAMMAD FARID FADLULLAH', 'XI TKJ 1', 'user'),
(18, '192010070', 'MUHAMMAD RAFII NAJMI HIBATULLAH', 'XI TKJ 1  ', 'user'),
(19, '192010072', 'NUR WAHID DILHAM  HASAN', 'XI TKJ 1', 'user'),
(20, '192010073', 'R. RAYHAN DWI VIRGIAWAN WIJAYA', 'XI TKJ 1  ', 'user'),
(21, '192010074', 'RAHMADHANTY DELYLA', 'XI TKJ 1', 'user'),
(22, '192010075', 'REKHSY OCTAVIAN PASARIBU ', 'XI TKJ 1', 'user'),
(23, '192010076', 'RISKA APRILLIA ', 'XI TKJ 1', 'user'),
(24, '192010077', 'RIZKY RAMADHAN', 'XI TKJ 1', 'user'),
(25, '192010078', 'SHAFANA NURUL AZMI', 'XI TKJ 1', 'user'),
(26, '192010079', 'SITI NURHALISA ', 'XI TKJ 1', 'user'),
(27, '192010080', 'TRIAN PERMADI ', 'XI TKJ 1', 'user'),
(28, '192010081', 'WIRAWAN ARIF KUSUMA', 'XI TKJ 1', 'user'),
(29, '192010082', 'AHMAD PARHAN ', 'XI TKJ 2', 'user'),
(30, '192010083', 'ALIFIA FITRI CAHAYA NINGRUM', 'XI TKJ 2  ', 'user'),
(31, '192010084', 'AURA NABILA', 'XI TKJ 2', 'user'),
(32, '192010085', 'CITRA MAHADEWI', 'XI TKJ 2', 'user'),
(33, '192010086', 'DWIKI NURCAHYO', 'XI TKJ 2', 'user'),
(34, '192010087', 'ERZA NAUFAL HAKIM ', 'XI TKJ 2', 'user'),
(35, '192010088', 'FAIZAL KURNIA RAMDHANA', 'XI TKJ 2', 'user'),
(36, '192010089', 'FAUZAN JAGI DANISWARA', 'XI TKJ 2', 'user'),
(37, '192010090', 'FIKRI PAYSAL', 'XI TKJ 2', 'user'),
(38, '192010091', 'HAFIZH AYYASY PRATAMA', 'XI TKJ 2', 'user'),
(39, '192010092', 'IHSAN HAFIZH FARIZI ', 'XI TKJ 2', 'user'),
(40, '192010093', 'INTAN TRI LESTARI', 'XI TKJ 2', 'user'),
(41, '192010094', 'KHOLILAH NUR HALIMAH ', 'XI TKJ 2', 'user'),
(42, '192010095', 'LEO PERMANA', 'XI TKJ 2', 'user'),
(43, '192010097', 'MUHAMMAD ARYA GUNAWAN ', 'XI TKJ 2', 'user'),
(44, '192010096', 'MUHAMAD DEDI SETIAWAN ', 'XI TKJ 2', 'user'),
(45, '192010098', 'MUHAMMAD FERDIANSYAH', 'XI TKJ 2', 'user'),
(46, '192010099', 'MUHAMMAD RAYYIS AZFA ', 'XI TKJ 2', 'user'),
(47, '192010100', 'NADHIF FAKHRI', 'XI TKJ 2', 'user'),
(48, '192010101', 'PRADIPTA AFIF PRADANA ', 'XI TKJ 2', 'user'),
(49, '192010102', 'RAFI ADNAN NAJIB', 'XI TKJ 2', 'user'),
(50, '192010103', 'RAKA PUTRA DWIATMOKO', 'XI TKJ 2', 'user'),
(51, '192010104', 'REZKI NUR VIDHIYANSYAH', 'XI TKJ 2', 'user'),
(52, '192010105', 'RISTU DANAN HIDAYAT', 'XI TKJ 2', 'user'),
(53, '192010106', 'RONI SETIYAWANTO ', 'XI TKJ 2', 'user'),
(54, '192010107', 'SHELLY EKA SRI LESTARI', 'XI TKJ 2', 'user'),
(55, '192010108', 'SUALANG JESSICA DEWI ', 'XI TKJ 2', 'user'),
(56, '192010109', 'VIQRI RAMADHANI ', 'XI TKJ 2', 'user'),
(57, '192010110', 'YOGA SAMSUL ULUM', 'XI TKJ 2', 'user'),
(58, '192010111', 'AHMAD NAWAWI ', 'XI TKJ 3', 'user'),
(59, '192010112', 'ALIF NUR ROHMAN ', 'XI TKJ 3', 'user'),
(60, '192010113', 'BAYU AJI PRADANA', 'XI TKJ 3', 'user'),
(61, '192010114', 'DAFFA RAFLIANDA GARIHASTOMO ', 'XI TKJ 3', 'user'),
(62, '192010115', 'EKA DHARMA PUTRA ', 'XI TKJ 3', 'user'),
(63, '192010116', 'FACHRUL MUTAROM', 'XI TKJ 3', 'user'),
(64, '192010117', 'FAJAR FADHILLAH PRIYANTO', 'XI TKJ 3', 'user'),
(65, '192010118', 'FARIS NAUFAL PRIATNA', 'XI TKJ 3', 'user'),
(66, '192010119', 'FERDYNAN JANIKA JAYAPERTELA', 'XI TKJ 3', 'user'),
(67, '192010120', 'FITRI SHAFIRAWATI ', 'XI TKJ 3', 'user'),
(68, '192010121', 'HAIKAL AZIZAN', 'XI TKJ 3', 'user'),
(69, '192010122', 'IKHSAN KRESNA HAKIM ', 'XI TKJ 3', 'user'),
(70, '192010123', 'IVAN RAMADHAN SUPRIANTO', 'XI TKJ 3', 'user'),
(71, '192010124', 'KIKI YAMAHIRO', 'XI TKJ 3', 'user'),
(72, '192010125', 'LINDU NURZAKARIA AUNSI ', 'XI TKJ 3', 'user'),
(73, '192010126', 'MUHAMAD IDRUS SATRIA', 'XI TKJ 3', 'user'),
(74, '192010129', 'MUHAMAD ROHUL FAZLIANSYAH', 'XI TKJ 3', 'user'),
(75, '192010127', 'MUHAMMAD FAISYAL AKBAR', 'XI TKJ 3', 'user'),
(76, '192010128', 'MUHAMMAD FIRDAUS HIDAYATULLOH ', 'XI TKJ 3', 'user'),
(77, '192010130', 'NANDYKA MAULANA DIFTIA', 'XI TKJ 3', 'user'),
(78, '192010131', 'PRANUFITRA ANJASYAH', 'XI TKJ 3', 'user'),
(79, '192010132', 'RAFI SYAWAL ALFARIZI ', 'XI TKJ 3', 'user'),
(80, '192010133', 'RANDHIKA FARHAN', 'XI TKJ 3', 'user'),
(81, '192010134', 'RIDHO RISYANTO ', 'XI TKJ 3', 'user'),
(82, '192010135', 'SATIA KIRANA PUTRI', 'XI TKJ 3', 'user'),
(83, '192010136', 'SHAFIYYAH ', 'XI TKJ 3', 'user'),
(84, '192010137', 'SYAFIQ SYAIFULLAH ', 'XI TKJ 3', 'user'),
(85, '192010138', 'WAHYU SETYA NURMANA ', 'XI TKJ 3', 'user'),
(86, '192010139', 'YOPI ANDI PRATAMA', 'XI TKJ 3', 'user'),
(87, '192010140', 'AFRIZA ABUDZAR GHIFARI ', 'XITKJ 4', 'user'),
(88, '192010141', 'AKMAL IHSAN', 'XITKJ 4', 'user'),
(89, '192010142', 'AVRILLIO GENTA PRAYOGI ', 'XITKJ 4', 'user'),
(90, '192010143', 'DIAN KARUNIA PUTRI JASMINE', 'XITKJ 4', 'user'),
(91, '192010144', 'DYLIYANA ATHA HAURA', 'XITKJ 4', 'user'),
(92, '192010145', 'FADEL PUTRA MAHENDRA', 'XITKJ 4', 'user'),
(93, '192010146', 'FERGI AR FARID AFIF ', 'XITKJ 4', 'user'),
(94, '192010147', 'GALI HIRZI FARIZI', 'XITKJ 4', 'user'),
(95, '192010148', 'HANAN ANDIKA PURWANTO ', 'XITKJ 4', 'user'),
(96, '192010149', 'IKHWAN PRATAMA HIDAYAT', 'XITKJ 4', 'user'),
(97, '192010150', 'IKRAR WIRA BUWANA', 'XITKJ 4', 'user'),
(98, '192010151', 'KHAY RONY ', 'XITKJ 4', 'user'),
(99, '192010152', 'LUH AGUSTINA ARYANI ', 'XITKJ 4', 'user'),
(100, '192010153', 'MICOANDAR JUSTINUS MARBUN', 'XITKJ 4', 'user'),
(101, '192010154', 'MUHAMMAD FARHAN NURFIQRI ', 'XITKJ 4', 'user'),
(102, '192010155', 'MUHAMMAD IHSAN MUDHOFFAR ', 'XITKJ 4', 'user'),
(103, '192010156', 'MUHAMMAD TEGAR SUBAGYO ', 'XITKJ 4', 'user'),
(104, '192010157', 'NAUFAL TIAN MAULANA ', 'XITKJ 4', 'user'),
(105, '192010158', 'QAREL IRHAM HILDRY JAVA ', 'XITKJ 4', 'user'),
(106, '192010159', 'RAFLI HILBRAM ADE DWIANSYAH ', 'XITKJ 4', 'user'),
(107, '192010160', 'RAFLY RIHZA ARROHIM', 'XITKJ 4', 'user'),
(108, '192010161', 'RANDU KALENAYA CORNELIUS ', 'XITKJ 4', 'user'),
(109, '192010162', 'RIFALDO YAHYA RAKAMULYA ', 'XITKJ 4', 'user'),
(110, '192010163', 'RIZKY ALFURKON', 'XITKJ 4', 'user'),
(111, '192010164', 'SEPTIAN HADI NUGROHO', 'XITKJ 4', 'user'),
(112, '192010165', 'SILVIA CAHYA NINGSIH ', 'XITKJ 4', 'user'),
(113, '192010166', 'SYAHBRINA TANJAK AGUNG PAMUNGKAS', 'XITKJ 4', 'user'),
(114, '192010167', 'WAHYU HIDAYATULLAH ', 'XITKJ 4', 'user'),
(115, '192010168', 'ZAKI MUBAROK ', 'XITKJ 4', 'user'),
(116, '181910127', 'ALDY SYAHPUTRA HARIANJA', 'XII TKJ 1', 'user'),
(117, '181910128', 'ARIEF HIDAYAT ', 'XII TKJ 1', 'user'),
(118, '181910164', 'BIMA MAULANA IHSAN ', 'XII TKJ 1', 'user'),
(119, '181910165', 'BONDAN FIKRI DEBALONG ', 'XII TKJ 1', 'user'),
(120, '181910067', 'DIVA ANASTASIA PUTRI', 'XII TKJ 1', 'user'),
(121, '181910167', 'DONI JULYANO RISDIANTO ', 'XII TKJ 1', 'user'),
(122, '181910102', 'FAUZAN CHOLIS AR RASYID', 'XII TKJ 1', 'user'),
(123, '181910171', 'FAUZI AFRIANSYAH ', 'XII TKJ 1', 'user'),
(124, '181910134', 'FERNANDA WISNU WARDHANA ', 'XII TKJ 1', 'user'),
(125, '181910137', 'FIRDAUS HARYUDANTO ', 'XII TKJ 1', 'user'),
(126, '181910105', 'FRANCISCUS SITANGGANG', 'XII TKJ 1', 'user'),
(127, '181910074', 'FURQON ARIAWAN SYAH', 'XII TKJ 1', 'user'),
(128, '181910138', 'GILANG RAMADHAN', 'XII TKJ 1', 'user'),
(129, '181910139', 'HANI SALSABILA', 'XII TKJ 1', 'user'),
(130, '181910174', 'KALIFAH ALIF ANDRIE', 'XII TKJ 1', 'user'),
(131, '181910144', 'MAHENDRA CHEVRO SUSANTO', 'XII TKJ 1', 'user'),
(132, '181910109', 'MAJESTY MARVELA PUTRI  ', 'XII TKJ 1', 'user'),
(133, '181910082', 'MAULANA RIZKI FADILLAH', 'XII TKJ 1', 'user'),
(134, '181910111', 'MOCHAMAD ANGGA SAPUTRA ', 'XII TKJ 1', 'user'),
(135, '181910114', 'MOHAMAD FADILAH HANAN ', 'XII TKJ 1', 'user'),
(136, '181910115', 'MUHAMMAD FADILLAH', 'XII TKJ 1', 'user'),
(137, '181910080', 'MUHAMMAD FAUZAN ADAM', 'XII TKJ 1', 'user'),
(138, '181910177', 'MUHAMMAD ILHAM JAILANI ', 'XII TKJ 1', 'user'),
(139, '181910116', 'MUHAMMAD MILHAM', 'XII TKJ 1', 'user'),
(140, '181910147', 'NABILYO NOVLIANDRA RAMADHAN', 'XII TKJ 1', 'user'),
(141, '181910088', 'NIMADE INDIRA DEWI ', 'XII TKJ 1', 'user'),
(142, '181910183', 'PRITA MUTIARA RIZKI', 'XII TKJ 1', 'user'),
(143, '181910184', 'RAFI ALFACHRI', 'XII TKJ 1', 'user'),
(144, '181910153', 'RESDANA PRAMUDIASTIRO', 'XII TKJ 1', 'user'),
(145, '181910186', 'RIDHO ALBANY', 'XII TKJ 1', 'user'),
(146, '181910190', 'VIRA YUNIYATI', 'XII TKJ 1', 'user'),
(147, '181910061', 'ADAM SETYAJI -', 'XII TKJ 2', 'user'),
(148, '181910095', 'ADHAN HUSNA FADILILAH ', 'XII TKJ 2', 'user'),
(149, '181910162', 'ANISA NURWULANDARI  ', 'XII TKJ 2', 'user'),
(150, '181910097', 'ANTONIUS DIKA PRASETYA ', 'XII TKJ 2', 'user'),
(151, '181910163', 'ARIESANDI DEFIAN NUGRAHA ', 'XII TKJ 2', 'user'),
(152, '181910098', 'ARIK ATHALLAH ', 'XII TKJ 2', 'user'),
(153, '181910166', 'DANI ANDHIKHA BUDI ', 'XII TKJ 2', 'user'),
(154, '181910099', 'DELLA ARIYANI', 'XII TKJ 2', 'user'),
(155, '181910130', 'DENY ERLANGGA PUTRA ', 'XII TKJ 2', 'user'),
(156, '181910131', 'DIESMA IVAN ARDIANTO', 'XII TKJ 2', 'user'),
(157, '181910071', 'FADHAN ALZATILLA', 'XII TKJ 2', 'user'),
(158, '181910135', 'FIKRI AULIA FIRMANSYAH', 'XII TKJ 2', 'user'),
(159, '181910136', 'FILDZAN WAHYU FAUZZANU', 'XII TKJ 2', 'user'),
(160, '181910076', 'HAICAL GIRANDA', 'XII TKJ 2', 'user'),
(161, '181910113', 'MOHAMMAD DWI ROSYANTORO', 'XII TKJ 2', 'user'),
(162, '181910086', 'MUHAMAD HANIF RAFIQ SULAEMAN  ', 'XII TKJ 2', 'user'),
(163, '181910176', 'MUHAMMAD DAFFA SYAUQI', 'XII TKJ 2', 'user'),
(164, '181910181', 'MUZNAH ALHAMID', 'XII TKJ 2', 'user'),
(165, '181910087', 'NAUFAL ARIF ARDIANSYAH ', 'XII TKJ 2', 'user'),
(166, '181910150', 'NURI AMMAR ', 'XII TKJ 2', 'user'),
(167, '181910151', 'ORIZA EMERSON PERANGIN-ANGIN', 'XII TKJ 2', 'user'),
(168, '181910090', 'PUTRI AYU RENGGANI', 'XII TKJ 2', 'user'),
(169, '181910152', 'RAJA FERNANDO ANTONI', 'XII TKJ 2', 'user'),
(170, '181910121', 'RANGGA SASMITA PADMANAGARA', 'XII TKJ 2', 'user'),
(171, '181910187', 'RIZQ FALIH RAHARDI', 'XII TKJ 2', 'user'),
(172, '181910155', 'SASYA AMANDA PUTRI', 'XII TKJ 2', 'user'),
(173, '181910188', 'SHILLA ADHA FEBRIYANA', 'XII TKJ 2', 'user'),
(174, '181910189', 'SITI NUR FADHILAH', 'XII TKJ 2', 'user'),
(175, '181910156', 'TAMBA FIRMAN HENDRO MEILANO', 'XII TKJ 2', 'user'),
(176, '181910124', 'WAHYU BHEENE MARGI HUTAMA', 'XII TKJ 2', 'user'),
(177, '181910094', 'ADE RIYANTI  ', 'XIITKJ 3', 'user'),
(178, '181910158', 'AHMAD FADILAH ', 'XIITKJ 3', 'user'),
(179, '181910159', 'AHMAD FAUZI', 'XIITKJ 3', 'user'),
(180, '192011326', 'AHCMAD GHANI MUBAROK', 'XIITKJ 3', 'user'),
(181, '181910126', 'AISYAH PUTRI NASTITI', 'XIITKJ 3', 'user'),
(182, '181910161', 'ANDHIKA MALIK', 'XIITKJ 3', 'user'),
(183, '181910129', 'ARTHARIO AKBAR BHUWANA', 'XIITKJ 3', 'user'),
(184, '181910069', 'DWI SELVIANI', 'XIITKJ 3', 'user'),
(185, '181910101', 'FACHRUL WINATA', 'XIITKJ 3', 'user'),
(186, '181910169', 'FADHIL ADNAN SHIDDIQ', 'XIITKJ 3', 'user'),
(187, '181910170', 'FADLILAH AL RASYID ', 'XIITKJ 3', 'user'),
(188, '181910132', 'FAHMI PRAYOGA', 'XIITKJ 3', 'user'),
(189, '181910133', 'FALDI RAMADHAN ', 'XIITKJ 3', 'user'),
(190, '181910172', 'FILAN RAHMAWATI ', 'XIITKJ 3', 'user'),
(191, '181910107', 'HANY  FEBRIANI ', 'XIITKJ 3', 'user'),
(192, '181910140', 'HASBI RAMADHAN ', 'XIITKJ 3', 'user'),
(193, '181910079', 'KENYA PADMAVATI', 'XIITKJ 3', 'user'),
(194, '181910110', 'MIFTAHUL FALLAH', 'XIITKJ 3', 'user'),
(195, '181910145', 'MUCH YAZID AR RIFA\'I', 'XIITKJ 3', 'user'),
(196, '181910178', 'MUHAMMAD ABDULLAH ', 'XIITKJ 3', 'user'),
(197, '181910112', 'MUHAMMAD ALFIN', 'XIITKJ 3', 'user'),
(198, '181910175', 'MUHAMMAD ARDIKA PUTRA MAULANA', 'XIITKJ 3', 'user'),
(199, '181910179', 'MUHAMMAD FARHAN ', 'XIITKJ 3', 'user'),
(200, '181910117', 'MUHAMMAD NABIL RAFA AZAKIY', 'XIITKJ 3', 'user'),
(201, '181910118', 'MUHAMMAD RAMADHAN', 'XIITKJ 3', 'user'),
(202, '181910180', 'MUHAMMAD RIDHO SUTANTRA', 'XIITKJ 3', 'user'),
(203, '181910143', 'MUHAMMAD ZINEDINE ZIDANE', 'XIITKJ 3', 'user'),
(204, '181910146', 'MUTIARA AZZAHRA  ', 'XIITKJ 3', 'user'),
(205, '181910182', 'NORAH DWI PURWANDARI ', 'XIITKJ 3', 'user'),
(206, '181910089', 'PRAMUDIKA ULFAN SULARNO', 'XIITKJ 3', 'user'),
(207, '181910122', 'RIZKY ALFAREZZY', 'XIITKJ 3', 'user'),
(208, '181910157', 'TAUFIK GAMAL ZANUAR', 'XIITKJ 3', 'user'),
(209, '181910093', 'YUSUF AUDRIAN VADRA ', 'XIITKJ 3', 'user'),
(210, '181910160', 'AHMAD HUSAIN NUR RAHMAN ', 'XII TKJ 4', 'user'),
(211, '181910096', 'ALYA KURNIA PUTRI  ', 'XII TKJ 4', 'user'),
(212, '181910062', 'ARA ABABIL RIVANO ', 'XII TKJ 4', 'user'),
(213, '181910063', 'AYUB TRISNA MUKTI', 'XII TKJ 4', 'user'),
(214, '181910064', 'BADI AZAMI', 'XII TKJ 4', 'user'),
(215, '181910065', 'BINTANG PURWA WAHYU PRATAMA', 'XII TKJ 4', 'user'),
(216, '181910066', 'CAHYA KAMILA WILUJENG  ', 'XII TKJ 4', 'user'),
(217, '181910338', 'CHOIRUL ARIFIN', 'XII TKJ 4', 'user'),
(218, '181910100', 'DEWANGGA BILAL SETIAWAN  ', 'XII TKJ 4', 'user'),
(219, '181910070', 'DIANA LINTANG PRIHATININGSIH ', 'XII TKJ 4', 'user'),
(220, '181910072', 'FADHILLAH RUDI HARTONO', 'XII TKJ 4', 'user'),
(221, '181910103', 'FERDY FEBRIAN CAHYADIANSYAH ', 'XII TKJ 4', 'user'),
(222, '181910104', 'FIRDAUS', 'XII TKJ 4', 'user'),
(223, '181910106', 'FRENTZEN RAYHANSYAH ARIFIN ', 'XII TKJ 4', 'user'),
(224, '181910075', 'HABIBULLAH AL QOMAR ', 'XII TKJ 4', 'user'),
(225, '181910108', 'IBNU SYAHBANI', 'XII TKJ 4', 'user'),
(226, '181910141', 'ILHAM FITRIANSYAH ', 'XII TKJ 4', 'user'),
(227, '181910077', 'ILHAM SAPUTRA  ', 'XII TKJ 4', 'user'),
(228, '181910078', 'ISNAENI AMBAR SARI', 'XII TKJ 4', 'user'),
(229, '181910081', 'MAHARANI NUR PAMUNGKAS', 'XII TKJ 4', 'user'),
(230, '181910083', 'MOHAMMAD AMIN TOHARI  ', 'XII TKJ 4', 'user'),
(231, '181910084', 'MUHAMMAD DZAKY ANTONIO WIBOWO ', 'XII TKJ 4', 'user'),
(232, '181910085', 'MUHAMMAD HAFIDZ AS SAJAD  ', 'XII TKJ 4', 'user'),
(233, '181910119', 'NUR IKHWAN ASY\'ARI', 'XII TKJ 4', 'user'),
(234, '181910149', 'NUR SAFITRIAH  ', 'XII TKJ 4', 'user'),
(235, '181910120', 'PINA NAPISAH SA\'BANIAH ', 'XII TKJ 4', 'user'),
(236, '181910091', 'RAFI KAHFI YUGI', 'XII TKJ 4', 'user'),
(237, '181910185', 'RAYYAN GHANI SEGARA', 'XII TKJ 4', 'user'),
(238, '181910092', 'RIFALDI FIRMANSYAH', 'XII TKJ 4', 'user'),
(239, '181910154', 'SABRINA ANGGITA DEWI ', 'XII TKJ 4', 'user'),
(240, '181910123', 'SETYOKO ALMULUDIN', 'XII TKJ 4', 'user'),
(241, '181910125', 'ZULFAHMI DEWI EFENDI', 'XII TKJ 4', 'user'),
(242, '202110053', 'ALDO RIYANTO ', 'X TKJ 1', 'user'),
(243, '202110054', 'ANISYA SEPTIANUR SUSANTO ', 'X TKJ 1', 'user'),
(244, '202110055', 'BRIZAN MAULANA', 'X TKJ 1', 'user'),
(245, '202110056', 'DEVITA APRILIIA', 'X TKJ 1', 'user'),
(246, '202110057', 'DHIKA INDRA SYAHPUTRA', 'X TKJ 1', 'user'),
(247, '202110058', 'FAHRY YAHYA QOIRAWAN', 'X TKJ 1', 'user'),
(248, '202110059', 'GABRIEL SET CHRISTOPEL', 'X TKJ 1', 'user'),
(249, '202110060', 'GHIFARY MUHAMMAD RAMADHAN', 'X TKJ 1', 'user'),
(250, '202110061', 'M. AL RIFKI', 'X TKJ 1', 'user'),
(251, '202110062', 'M. ANDRICO BIMO R.S P ', 'X TKJ 1', 'user'),
(252, '202110063', 'M. DHIMAS HAFIZH FATHUROHMAN ', 'X TKJ 1', 'user'),
(253, '202110064', 'MICHO DHANI FIRMANSYAH', 'X TKJ 1', 'user'),
(254, '202110065', 'MUHAMAD IRVAN EKA SUDRAJAT ', 'X TKJ 1', 'user'),
(255, '202110066', 'MUHAMMAD  RIFQY SAPUTRA', 'X TKJ 1', 'user'),
(256, '202110067', 'MUHAMMAD AZMI AGIL ', 'X TKJ 1', 'user'),
(257, '202110068', 'MUHAMMAD FIKRI RAHMADANI', 'X TKJ 1', 'user'),
(258, '202110069', 'MUHAMMAD HILMY AL DZAKWAN', 'X TKJ 1', 'user'),
(259, '202110070', 'MUHAMMAD IKHSAN SAEFUL ANAM ', 'X TKJ 1', 'user'),
(260, '202110071', 'MUHAMMAD IKHSAN SUBAGYO', 'X TKJ 1', 'user'),
(261, '202110072', 'MUHAMMAD NUR ROCHMAN', 'X TKJ 1', 'user'),
(262, '202110073', 'MUHAMMAD RAIHAN', 'X TKJ 1', 'user'),
(263, '202110074', 'MUHAMMAD ZAKI FAUZAN', 'X TKJ 1', 'user'),
(264, '202110075', 'NAUFAL RAFLI SUNARWIYONO ', 'X TKJ 1', 'user'),
(265, '202110076', 'RAIHAN RIFQI RIZQULLOH ', 'X TKJ 1', 'user'),
(266, '202110077', 'RIZAL BISMIMUBAROK', 'X TKJ 1', 'user'),
(267, '202110078', 'RIZKY DARMAWAN', 'X TKJ 1', 'user'),
(268, '202110262', 'SALSABIL FAUZIYYAH', 'X TKJ 1', 'user'),
(269, '202110079', 'WAHYU AFRIANSYAH ', 'X TKJ 1', 'user'),
(270, '202110080', 'WIDYA INDAH LARASATI', 'X TKJ 1', 'user'),
(271, '202110081', 'ABIL ABBAS SYIHABUDIN', 'X TKJ 2', 'user'),
(272, '202110082', 'ACHMAD RAIHAN AFIF', 'X TKJ 2', 'user'),
(273, '202110083', 'ADITYA DWI PUTRA', 'X TKJ 2', 'user'),
(274, '202110084', 'BAGAS FAJAR PRATAMA', 'X TKJ 2', 'user'),
(275, '202110085', 'DAMAR NUGRAHA', 'X TKJ 2', 'user'),
(276, '202110086', 'DESTIA ANANDA PUTRA', 'X TKJ 2', 'user'),
(277, '202110087', 'DIMAS PUTRA NUGROHO', 'X TKJ 2', 'user'),
(278, '202110088', 'DZAKY IGO TRIDANI', 'X TKJ 2', 'user'),
(279, '202110089', 'FAISHAL TAUFIK ALWAN', 'X TKJ 2', 'user'),
(280, '202110090', 'FIRDI AHMAD FAUZI', 'X TKJ 2', 'user'),
(281, '202110091', 'HAGA DALPINTO GINTING', 'X TKJ 2', 'user'),
(282, '202110092', 'IRFAN HILMI NUR HAKIM', 'X TKJ 2', 'user'),
(283, '202110093', 'M. RIFKY RAMDHANI', 'X TKJ 2', 'user'),
(284, '202110094', 'M.SYAHRUL INSAN FAUZI', 'X TKJ 2', 'user'),
(285, '202110095', 'MAUDY APRILIA SAHARI', 'X TKJ 2', 'user'),
(286, '202110096', 'MIFTAHUL FALAH SURYAWAN', 'X TKJ 2', 'user'),
(287, '202110097', 'MUHAMMAD RAKHA', 'X TKJ 2', 'user'),
(288, '202110098', 'MUHAMMAD SYAEFULLOH ', 'X TKJ 2', 'user'),
(289, '202110099', 'MUHAMMAD ZAHRAN', 'X TKJ 2', 'user'),
(290, '202110100', 'NAUFAL RIZKI RAMADHAN', 'X TKJ 2', 'user'),
(291, '202110101', 'NUR AINI RIANDHINY', 'X TKJ 2', 'user'),
(292, '202110102', 'NUR ALFIYYAH SALSABILA', 'X TKJ 2', 'user'),
(293, '202110103', 'RADITYATAMA ZUHRY ARFATH', 'X TKJ 2', 'user'),
(294, '202110104', 'RAFFI INDRA SUSANTO ', 'X TKJ 2', 'user'),
(295, '202110105', 'RAFIF RIFQIANSYAH', 'X TKJ 2', 'user'),
(296, '202110106', 'REFI FAUZAN', 'X TKJ 2', 'user'),
(297, '202110108', 'SATRIOKU GADI MAHESWORO', 'X TKJ 2', 'user'),
(298, '202110109', 'ACHMAD RYAN FADILAH', 'X TKJ 3', 'user'),
(299, '202110110', 'AHMAD FAUZI ZAIN', 'X TKJ 3', 'user'),
(300, '202110111', 'AHMAD KHANAFI IKHBAL', 'X TKJ 3', 'user'),
(301, '202110112', 'ARBY ANRA DELVAN IRYADI ', 'X TKJ 3', 'user'),
(302, '202110113', 'ATTALA NAUFAL', 'X TKJ 3', 'user'),
(303, '202110114', 'BAYU ADHI PERMANA ', 'X TKJ 3', 'user'),
(304, '202110115', 'DHISVA PUTRI DIEN HANDOYO ', 'X TKJ 3', 'user'),
(305, '202110006', 'DINI SHOFY AULIA', 'X TKJ 3', 'user'),
(306, '202110116', 'FAIZAL RAMADHAN', 'X TKJ 3', 'user'),
(307, '202110117', 'FATHUR RAHMAN', 'X TKJ 3', 'user'),
(308, '202110118', 'FEBRIAN FALIH ALWAFY', 'X TKJ 3', 'user'),
(309, '202110119', 'GILANG WYRATAMA', 'X TKJ 3', 'user'),
(310, '202110120', 'HAFIZH NAUFAL ALY', 'X TKJ 3', 'user'),
(311, '202110121', 'IKRAM IRIANSYAH', 'X TKJ 3', 'user'),
(312, '202110122', 'JONATHAN KANTOHE ', 'X TKJ 3', 'user'),
(313, '202110123', 'KHURY PASSAI', 'X TKJ 3', 'user'),
(314, '202110125', 'MAMUN SYACHFAR RANDY', 'X TKJ 3', 'user'),
(315, '202110127', 'MUHAMAD RAFI ZHAFRAN', 'X TKJ 3', 'user'),
(316, '202110126', 'MUHAMMAD RAFAEL KURRI SANJIA', 'X TKJ 3', 'user'),
(317, '202110124', 'MUHAMMAD SHABRIAN FADLY', 'X TKJ 3', 'user'),
(318, '202110128', 'MUHAMMAD ZIDAN', 'X TKJ 3', 'user'),
(319, '202110129', 'NADIATUL ADHA', 'X TKJ 3', 'user'),
(320, '202110130', 'NAJWA AULIA SAYYIDINA', 'X TKJ 3', 'user'),
(321, '202110131', 'NAUFHAL KURNIAWAN', 'X TKJ 3', 'user'),
(322, '202110132', 'NICO FEBRIAN ', 'X TKJ 3', 'user'),
(323, '202110133', 'RAIHAN ', 'X TKJ 3', 'user'),
(324, '202110134', 'RIDWAN HAFIZ', 'X TKJ 3', 'user'),
(325, '202110135', 'RIFKI RAMADHAN', 'X TKJ 3', 'user'),
(326, '202110136', 'SYARIEF MAULANA PUTRA', 'X TKJ 3', 'user');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `jurnal`
--
ALTER TABLE `jurnal`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `kontributor`
--
ALTER TABLE `kontributor`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `kuis`
--
ALTER TABLE `kuis`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `materi`
--
ALTER TABLE `materi`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `notifikasi`
--
ALTER TABLE `notifikasi`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `jurnal`
--
ALTER TABLE `jurnal`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `kontributor`
--
ALTER TABLE `kontributor`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `kuis`
--
ALTER TABLE `kuis`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `materi`
--
ALTER TABLE `materi`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `notifikasi`
--
ALTER TABLE `notifikasi`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=328;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
