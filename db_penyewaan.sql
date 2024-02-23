-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Feb 23, 2024 at 03:32 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `db_penyewaan`
--

-- --------------------------------------------------------

--
-- Table structure for table `tb_admin`
--

CREATE TABLE `tb_admin` (
  `id_admin` int(10) NOT NULL,
  `username` varchar(100) NOT NULL,
  `password_admin` varchar(200) NOT NULL,
  `nama_admin` varchar(100) NOT NULL,
  `email_admin` varchar(100) NOT NULL,
  `nohp_admin` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tb_admin`
--

INSERT INTO `tb_admin` (`id_admin`, `username`, `password_admin`, `nama_admin`, `email_admin`, `nohp_admin`) VALUES
(12, 'ADMIN', 'dimas', 'DIMAS', 'dimas@gmail.com', '124141231'),
(13, 'ADMIN', 'admin', 'Yon Seplin Reinardo', 'admin@gmail.com', '084321232132');

-- --------------------------------------------------------

--
-- Table structure for table `tb_bayar`
--

CREATE TABLE `tb_bayar` (
  `id_bayar` int(10) NOT NULL,
  `id_sewa` int(10) NOT NULL,
  `bukti` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `konfirmasi` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT 'Belum'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tb_bayar`
--

INSERT INTO `tb_bayar` (`id_bayar`, `id_sewa`, `bukti`, `konfirmasi`) VALUES
(11, 16, '65a8faf2c47b2.jpg', 'Terkonfirmasi'),
(12, 17, '65a95ff59d26a.jpg', 'Terkonfirmasi'),
(13, 18, '65a9664097c83.jpg', 'Terkonfirmasi'),
(14, 13, '65aae02035f4c.jpg', 'Terkonfirmasi'),
(15, 19, '65abd7bd20577.jpg', 'Sudah Bayar'),
(16, 20, '65be885c9dacb.jpg', 'Sudah Bayar');

-- --------------------------------------------------------

--
-- Table structure for table `tb_produk`
--

CREATE TABLE `tb_produk` (
  `id_produk` int(10) NOT NULL,
  `nama_produk` varchar(200) NOT NULL,
  `harga` varchar(100) NOT NULL,
  `deskripsi` varchar(800) NOT NULL,
  `foto` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tb_produk`
--

INSERT INTO `tb_produk` (`id_produk`, `nama_produk`, `harga`, `deskripsi`, `foto`) VALUES
(4, 'Studio Rekaman', '500.000', '- Mikrofon wireless- Peredam Suara- Mixer- Monitor Audio- DAW- PREAMP- Aqualizer- Alat Musik -', '65a5428b0cd4d.jpg'),
(5, 'Aula Auditorium', '400.000', '- Mixer\n- Speaker\n- Ear Monitor\n- Mikrofon Wireless\n- 2 Lantai memuat (400 orang)\n- Panggung - Kamera -', '65a8fdd2a0e2d.jpg'),
(18, 'Studio Rekaman Video Clip', '650.000', '- Mikrofon - Kamera - Mixer - Peredam Suara - Alat Musik - Lighting - Editing Video - Ear Monitor - Speaker -', '65a9180bcd6e9.jpg'),
(20, 'Panggung', '500.000', 'RRI Banjarmasin Menyediakan pangung dengan falisilitas - Lighting - Mic Wireless - Mixer - dll', '65a967879a433.jpg');

-- --------------------------------------------------------

--
-- Table structure for table `tb_sewa`
--

CREATE TABLE `tb_sewa` (
  `id_sewa` int(10) NOT NULL,
  `id_user` int(10) NOT NULL,
  `id_produk` int(10) NOT NULL,
  `tanggal_pesan` date NOT NULL,
  `harga` varchar(200) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tb_sewa`
--

INSERT INTO `tb_sewa` (`id_sewa`, `id_user`, `id_produk`, `tanggal_pesan`, `harga`) VALUES
(13, 1, 4, '2024-01-31', '500.000'),
(16, 2, 4, '2024-01-20', '500.000'),
(17, 2, 4, '2024-01-19', '500.000'),
(18, 2, 5, '2024-01-19', '400.000'),
(19, 4, 4, '2024-01-20', '500.000'),
(20, 1, 18, '2024-01-31', '650.000');

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `id_user` int(10) NOT NULL,
  `nama_user` varchar(200) NOT NULL,
  `email_user` varchar(100) NOT NULL,
  `password_user` varchar(200) NOT NULL,
  `nohp_user` varchar(100) NOT NULL,
  `foto_user` varchar(200) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`id_user`, `nama_user`, `email_user`, `password_user`, `nohp_user`, `foto_user`) VALUES
(1, 'dody', 'user@gmail.com', 'admin', '0812345678', '65a7e81319e84.jpg'),
(3, 'tama', 'tama@gmail.com', 'tama', '1234567432', '65a96c08aa760.png'),
(4, 'saipul', 'ipul@gmail.com', 'ipul', '12345678', '65aaed799c9e3.jpg');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `tb_admin`
--
ALTER TABLE `tb_admin`
  ADD PRIMARY KEY (`id_admin`);

--
-- Indexes for table `tb_bayar`
--
ALTER TABLE `tb_bayar`
  ADD PRIMARY KEY (`id_bayar`);

--
-- Indexes for table `tb_produk`
--
ALTER TABLE `tb_produk`
  ADD PRIMARY KEY (`id_produk`);

--
-- Indexes for table `tb_sewa`
--
ALTER TABLE `tb_sewa`
  ADD PRIMARY KEY (`id_sewa`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id_user`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `tb_admin`
--
ALTER TABLE `tb_admin`
  MODIFY `id_admin` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `tb_bayar`
--
ALTER TABLE `tb_bayar`
  MODIFY `id_bayar` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT for table `tb_produk`
--
ALTER TABLE `tb_produk`
  MODIFY `id_produk` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT for table `tb_sewa`
--
ALTER TABLE `tb_sewa`
  MODIFY `id_sewa` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `id_user` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
