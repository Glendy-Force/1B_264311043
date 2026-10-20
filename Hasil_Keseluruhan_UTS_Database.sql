-- SOAL 1 - DDL & RELASI

USE db_akademik;

CREATE TABLE mahasiswa (
    nim VARCHAR(100) NOT NULL PRIMARY KEY,
    nama VARCHAR(100) NOT NULL,
    semester INT(10) NOT NULL
 );
 
CREATE TABLE dosen (
     nidn INT(10) NOT NULL PRIMARY KEY,
     nama_dosen VARCHAR(100) NOT NULL
);

CREATE TABLE matkul (
    kode_mk VARCHAR(100) NOT NULL PRIMARY KEY,
    nidn INT(10) NOT NULL,
    nama_mk VARCHAR(100) NOT NULL,
    sks INT(10) NOT NULL,
    FOREIGN KEY (nidn) REFERENCES dosen(nidn) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE krs (
    id_krs VARCHAR(20) PRIMARY KEY,
    nim VARCHAR(20) NOT NULL,
    kode_mk VARCHAR(20) NOT NULL,
    semester VARCHAR(20) NOT NULL,
    tahun_akademik VARCHAR(20) NOT NULL,
    FOREIGN KEY (nim) REFERENCES mahasiswa(nim) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (kode_mk) REFERENCES matkul(kode_mk) ON DELETE CASCADE ON UPDATE CASCADE
);

-- SOAL 2 - CRUD DASAR

-- CREATE
INSERT INTO mahasiswa (nim, nama, semester) VALUES 
('264311043', 'Glendy Devanno Ardiansyah Putra', 4),
('264311048', 'M. A. Hafidz', 4),
('264311056', 'Restu Prayuga', 4),
('264311057', 'Roefando Adji', 4);

INSERT INTO dosen (nidn, nama_dosen) VALUES 
('00124783', 'Dr. Budi Santoso, M.Kom.'),
('00654408', 'Siti Rahma, M.T.'),
('00987905', 'Ahmad Fauzi, M.Cs.');

INSERT INTO matkul (kode_mk, nidn, nama_mk, sks) VALUES 
('IF101', '00124783', 'Pemrograman Basis Data', 3),
('IF102', '00654408', 'Struktur Data & Algoritma', 4),
('IF103', '00987905', 'Pemrograman Web', 3);

INSERT INTO krs (id_krs, nim, kode_mk, semester, tahun_akademik) VALUES 
('KRS01', '264311043', 'IF101', 4, '2025/2026'),
('KRS02', '264311048', 'IF102', 4, '2025/2026'),
('KRS03', '264311056', 'IF103', 4, '2025/2026');

-- READ
SELECT * FROM mahasiswa;

-- UPDATE
UPDATE krs
SET semester = '5'
WHERE id_krs = 'KRS05';

-- DELETE
DELETE FROM krs
WHERE id_krs = 'KRS04';

-- SOAL 3 - QUERY KOMPLEKS & AGREGASI

SELECT
    m.nama AS nama_mahasiswa,
    COUNT(k.id_krs) AS jumlah_matkul,
    SUM(mk.sks) AS total_sks
FROM krs k
JOIN mahasiswa m
    ON k.nim = m.nim
JOIN matkul mk
    ON k.kode_mk = mk.kode_mk
WHERE k.tahun_akademik = '2025/2026'
GROUP BY m.nim, m.nama;
