-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Waktu pembuatan: 19 Jun 2025 pada 13.45
-- Versi server: 10.4.32-MariaDB
-- Versi PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `projek_visual`
--

-- --------------------------------------------------------

--
-- Struktur dari tabel `mst_barang`
--

CREATE TABLE `mst_barang` (
  `kd_barang` varchar(10) NOT NULL,
  `nama_barang` varchar(100) NOT NULL,
  `kategori_barang` varchar(20) NOT NULL,
  `merek` varchar(50) DEFAULT NULL,
  `ukuran` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data untuk tabel `mst_barang`
--

INSERT INTO `mst_barang` (`kd_barang`, `nama_barang`, `kategori_barang`, `merek`, `ukuran`) VALUES
('EL001', 'Laptop', 'Barang Electronik', 'Asus', '14x20'),
('F001', 'Meja Kantor', 'Barang Furniture', 'Ace', '50x20');

-- --------------------------------------------------------

--
-- Struktur dari tabel `mst_lokasi`
--

CREATE TABLE `mst_lokasi` (
  `kd_lokasi` varchar(10) NOT NULL,
  `nama_lokasi` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data untuk tabel `mst_lokasi`
--

INSERT INTO `mst_lokasi` (`kd_lokasi`, `nama_lokasi`) VALUES
('G00011', 'Gudang berangkas'),
('GD001', 'Ruang Direksi'),
('GD002', 'Gudang Elektronik'),
('GD005', 'Gudang Furniture');

-- --------------------------------------------------------

--
-- Struktur dari tabel `mst_user`
--

CREATE TABLE `mst_user` (
  `id_user` varchar(10) NOT NULL,
  `username` varchar(20) NOT NULL,
  `password` varchar(20) NOT NULL,
  `nama` varchar(35) DEFAULT NULL,
  `jenis_kelamin` varchar(20) DEFAULT NULL,
  `alamat` varchar(200) DEFAULT NULL,
  `role` varchar(20) NOT NULL DEFAULT 'user'
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data untuk tabel `mst_user`
--

INSERT INTO `mst_user` (`id_user`, `username`, `password`, `nama`, `jenis_kelamin`, `alamat`, `role`) VALUES
('123', 'admin', 'admin', 'BOY', 'Laki - laki', 'Indramayu', 'admin'),
('12345', 'agus', 'agus', 'Redi', 'Perempuan', 'Jl. mangga dua', 'user');

-- --------------------------------------------------------

--
-- Struktur dari tabel `trx_inventaris_keluar`
--

CREATE TABLE `trx_inventaris_keluar` (
  `kd_inventaris_keluar` char(15) NOT NULL,
  `kd_inventaris_masuk` char(15) NOT NULL,
  `jumlah` int(11) NOT NULL,
  `tanggal_keluar` date DEFAULT NULL,
  `keterangan` varchar(20) NOT NULL,
  `id_user` char(5) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `trx_inventaris_masuk`
--

CREATE TABLE `trx_inventaris_masuk` (
  `kd_inventaris_masuk` char(15) NOT NULL,
  `kd_barang` varchar(10) NOT NULL,
  `jumlah` int(11) NOT NULL,
  `nilai_barang` float NOT NULL,
  `tanggal_masuk` date DEFAULT NULL,
  `id_user` varchar(10) NOT NULL,
  `kd_lokasi` char(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data untuk tabel `trx_inventaris_masuk`
--

INSERT INTO `trx_inventaris_masuk` (`kd_inventaris_masuk`, `kd_barang`, `jumlah`, `nilai_barang`, `tanggal_masuk`, `id_user`, `kd_lokasi`) VALUES
('IN0001', 'EL001', 20, 1000000, '2025-06-19', '123', 'GD002'),
('IN0002', 'F001', 20, 600000, '2025-06-19', '123', 'GD005');

--
-- Indexes for dumped tables
--

--
-- Indeks untuk tabel `mst_barang`
--
ALTER TABLE `mst_barang`
  ADD PRIMARY KEY (`kd_barang`);

--
-- Indeks untuk tabel `mst_lokasi`
--
ALTER TABLE `mst_lokasi`
  ADD PRIMARY KEY (`kd_lokasi`);

--
-- Indeks untuk tabel `mst_user`
--
ALTER TABLE `mst_user`
  ADD PRIMARY KEY (`id_user`);

--
-- Indeks untuk tabel `trx_inventaris_keluar`
--
ALTER TABLE `trx_inventaris_keluar`
  ADD PRIMARY KEY (`kd_inventaris_keluar`),
  ADD KEY `fk_user_keluar` (`id_user`),
  ADD KEY `fk_masuk_keluar` (`kd_inventaris_masuk`);

--
-- Indeks untuk tabel `trx_inventaris_masuk`
--
ALTER TABLE `trx_inventaris_masuk`
  ADD PRIMARY KEY (`kd_inventaris_masuk`,`kd_barang`),
  ADD KEY `fk_barang_masuk` (`kd_barang`),
  ADD KEY `fk_user_masuk` (`id_user`),
  ADD KEY `fk_lokasi_masuk` (`kd_lokasi`);

--
-- Ketidakleluasaan untuk tabel pelimpahan (Dumped Tables)
--

--
-- Ketidakleluasaan untuk tabel `trx_inventaris_keluar`
--
ALTER TABLE `trx_inventaris_keluar`
  ADD CONSTRAINT `fk_inventaris_keluar` FOREIGN KEY (`kd_inventaris_masuk`) REFERENCES `trx_inventaris_masuk` (`kd_inventaris_masuk`),
  ADD CONSTRAINT `fk_masuk_keluar` FOREIGN KEY (`kd_inventaris_masuk`) REFERENCES `trx_inventaris_masuk` (`kd_inventaris_masuk`),
  ADD CONSTRAINT `fk_user_keluar` FOREIGN KEY (`id_user`) REFERENCES `mst_user` (`id_user`);

--
-- Ketidakleluasaan untuk tabel `trx_inventaris_masuk`
--
ALTER TABLE `trx_inventaris_masuk`
  ADD CONSTRAINT `fk_barang_masuk` FOREIGN KEY (`kd_barang`) REFERENCES `mst_barang` (`kd_barang`),
  ADD CONSTRAINT `fk_lokasi_masuk` FOREIGN KEY (`kd_lokasi`) REFERENCES `mst_lokasi` (`kd_lokasi`),
  ADD CONSTRAINT `fk_user_masuk` FOREIGN KEY (`id_user`) REFERENCES `mst_user` (`id_user`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
