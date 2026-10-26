-- ========================================================
-- DATABASE SCHEMA & DUMMY DATA FOR DB_AKADEMIK
-- Modul: Sistem Informasi Akademik + Manajemen Absensi
-- ========================================================

CREATE DATABASE IF NOT EXISTS `db_akademik` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci;
USE `db_akademik`;

-- --------------------------------------------------------
-- 1. TABEL DOSEN
-- --------------------------------------------------------
CREATE TABLE `dosen` (
  `nidn` INT(10) NOT NULL,
  `nama_dosen` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`nidn`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------
-- 2. TABEL MAHASISWA
-- --------------------------------------------------------
CREATE TABLE `mahasiswa` (
  `nim` VARCHAR(100) NOT NULL,
  `nama` VARCHAR(100) NOT NULL,
  `semester` INT(10) NOT NULL,
  PRIMARY KEY (`nim`),
  KEY `idx_nama_mahasiswa` (`nama`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------
-- 3. TABEL MATKUL
-- --------------------------------------------------------
CREATE TABLE `matkul` (
  `kode_mk` VARCHAR(100) NOT NULL,
  `nama_mk` VARCHAR(100) NOT NULL,
  `sks` INT(10) NOT NULL,
  `nidn` INT(10) DEFAULT NULL,
  PRIMARY KEY (`kode_mk`),
  KEY `nidn` (`nidn`),
  KEY `idx_nama_matkul` (`nama_mk`),
  CONSTRAINT `matkul_ibfk_dosen` FOREIGN KEY (`nidn`) REFERENCES `dosen` (`nidn`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------
-- 4. TABEL JADWAL
-- --------------------------------------------------------
CREATE TABLE `jadwal` (
  `id_jadwal` VARCHAR(100) NOT NULL,
  `kode_mk` VARCHAR(100) DEFAULT NULL,
  `hari` VARCHAR(100) NOT NULL,
  `jam` VARCHAR(100) NOT NULL,
  `ruang` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`id_jadwal`),
  KEY `kode_mk` (`kode_mk`),
  CONSTRAINT `jadwal_ibfk_matkul` FOREIGN KEY (`kode_mk`) REFERENCES `matkul` (`kode_mk`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------
-- 5. TABEL KRS
-- --------------------------------------------------------
CREATE TABLE `krs` (
  `id_krs` VARCHAR(20) NOT NULL,
  `nim` VARCHAR(20) NOT NULL,
  `kode_mk` VARCHAR(20) NOT NULL,
  `semester` VARCHAR(20) NOT NULL,
  `tahun_akademik` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`id_krs`),
  KEY `nim` (`nim`),
  KEY `kode_mk` (`kode_mk`),
  CONSTRAINT `krs_ibfk_1` FOREIGN KEY (`nim`) REFERENCES `mahasiswa` (`nim`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `krs_ibfk_2` FOREIGN KEY (`kode_mk`) REFERENCES `matkul` (`kode_mk`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------
-- 6. TABEL ABSENSI (PERLUASAN PROSES BISNIS)
-- --------------------------------------------------------
CREATE TABLE `absensi` (
  `id_absensi` VARCHAR(20) NOT NULL,
  `id_krs` VARCHAR(20) NOT NULL,
  `id_jadwal` VARCHAR(100) NOT NULL,
  `tgl_pertemuan` DATE NOT NULL,
  `pertemuan_ke` INT(2) NOT NULL,
  `status_hadir` ENUM('Hadir', 'Izin', 'Sakit', 'Alpha') NOT NULL DEFAULT 'Hadir',
  PRIMARY KEY (`id_absensi`),
  KEY `id_krs` (`id_krs`),
  KEY `id_jadwal` (`id_jadwal`),
  CONSTRAINT `absensi_ibfk_1` FOREIGN KEY (`id_krs`) REFERENCES `krs` (`id_krs`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `absensi_ibfk_2` FOREIGN KEY (`id_jadwal`) REFERENCES `jadwal` (`id_jadwal`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------
-- 7. TABEL NILAI
-- --------------------------------------------------------
CREATE TABLE `nilai` (
  `id_nilai` VARCHAR(100) NOT NULL,
  `nim` VARCHAR(100) NOT NULL,
  `kode_mk` VARCHAR(100) NOT NULL,
  `nilai` VARCHAR(5) NOT NULL,
  `semester` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`id_nilai`),
  KEY `nim` (`nim`),
  KEY `kode_mk` (`kode_mk`),
  CONSTRAINT `nilai_ibfk_1` FOREIGN KEY (`nim`) REFERENCES `mahasiswa` (`nim`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `nilai_ibfk_2` FOREIGN KEY (`kode_mk`) REFERENCES `matkul` (`kode_mk`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------
-- 8. TABEL LAPORAN
-- --------------------------------------------------------
CREATE TABLE `laporan` (
  `id_laporan` VARCHAR(20) NOT NULL,
  `periode` VARCHAR(50) NOT NULL,
  `jenis_laporan` VARCHAR(50) NOT NULL,
  `data_laporan` TEXT NOT NULL,
  PRIMARY KEY (`id_laporan`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------
-- 9. TABEL CACHE
-- --------------------------------------------------------
CREATE TABLE `cache` (
  `cache_key` VARCHAR(50) NOT NULL,
  `cache_value` TEXT NOT NULL,
  `expired_at` DATETIME NOT NULL,
  PRIMARY KEY (`cache_key`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ========================================================
-- DUMMY DATA INSERT STATEMENTS
-- ========================================================

-- Insert Dosen
INSERT INTO `dosen` (`nidn`, `nama_dosen`) VALUES
(101201, 'Dr. Ahmad Fauzi, M.Kom.'),
(101202, 'Siti Aminah, M.T.'),
(101203, 'Dr. Budi Santoso, M.Sc.');

-- Insert Mahasiswa
INSERT INTO `mahasiswa` (`nim`, `nama`, `semester`) VALUES
('264311043', 'Glendy Devanno Ardiansyah Putra', 3),
('264311056', 'Restu Prayuga', 3),
('264311034', 'Alexsandria Cahaya Adzani', 3);

-- Insert Matkul
INSERT INTO `matkul` (`kode_mk`, `nama_mk`, `sks`, `nidn`) VALUES
('IF101', 'Pemrograman Berorientasi Objek', 4, 101201),
('IF102', 'Basis Data Terstruktur', 3, 101202),
('IF103', 'Struktur Data dan Algoritma', 3, 101203);

-- Insert Jadwal
INSERT INTO `jadwal` (`id_jadwal`, `kode_mk`, `hari`, `jam`, `ruang`) VALUES
('JD01', 'IF101', 'Senin', '08:00 - 10:30', 'Lab Komputer 1'),
('JD02', 'IF102', 'Rabu', '10:30 - 13:00', 'Ruang Teori 3.2'),
('JD03', 'IF103', 'Jumat', '13:30 - 16:00', 'Lab Komputer 2');

-- Insert KRS
INSERT INTO `krs` (`id_krs`, `nim`, `kode_mk`, `semester`, `tahun_akademik`) VALUES
('KRS01', '264311043', 'IF101', 'Ganjil', '2026/2027'),
('KRS02', '264311043', 'IF102', 'Ganjil', '2026/2027'),
('KRS03', '264311056', 'IF102', 'Ganjil', '2026/2027'),
('KRS04', '264311034', 'IF103', 'Ganjil', '2026/2027');

-- Insert Absensi (Perluasan Bisnis)
INSERT INTO `absensi` (`id_absensi`, `id_krs`, `id_jadwal`, `tgl_pertemuan`, `pertemuan_ke`, `status_hadir`) VALUES
('ABS01', 'KRS01', 'JD01', '2026-09-07', 1, 'Hadir'),
('ABS02', 'KRS01', 'JD01', '2026-09-14', 2, 'Hadir'),
('ABS03', 'KRS02', 'JD02', '2026-09-09', 1, 'Hadir'),
('ABS04', 'KRS02', 'JD02', '2026-09-16', 2, 'Izin'),
('ABS05', 'KRS03', 'JD02', '2026-09-09', 1, 'Hadir'),
('ABS06', 'KRS04', 'JD03', '2026-09-11', 1, 'Hadir');

-- Insert Nilai
INSERT INTO `nilai` (`id_nilai`, `nim`, `kode_mk`, `nilai`, `semester`) VALUES
('NIL01', '264311043', 'IF101', 'A', 'Ganjil'),
('NIL02', '264311043', 'IF102', 'AB', 'Ganjil'),
('NIL03', '264311056', 'IF102', 'B', 'Ganjil'),
('NIL04', '264311034', 'IF103', 'A', 'Ganjil');

-- Insert Laporan
INSERT INTO `laporan` (`id_laporan`, `periode`, `jenis_laporan`, `data_laporan`) VALUES
('LAP01', '2026/2027 Ganjil', 'Rekap Kehadiran dan Nilai', '{"total_mahasiswa": 3, "rata_kehadiran": "91.6%"}');

-- Insert Cache
INSERT INTO `cache` (`cache_key`, `cache_value`, `expired_at`) VALUES
('dashboard_stats', '{"active_users": 120, "active_classes": 15}', '2026-12-31 23:59:59');
