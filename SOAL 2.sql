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
WHERE id_krs = 'KRS03';

-- DELETE
DELETE FROM krs
WHERE id_krs = 'KRS03';
