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
