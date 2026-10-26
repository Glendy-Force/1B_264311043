# 🎓 Sistem Informasi Akademik (`db_akademik`)

Sistem Informasi Akademik terstruktur yang dilengkapi dengan **Modul Manajemen Absensi Perkuliahan**, perancangan basis data hingga tahap 3NF, skema relasional, dan script SQL yang siap diimplementasikan.

---

## 📌 Ringkasan Proyek

Sistem ini dikembangkan untuk mengelola data akademik perguruan tinggi secara efisien, meliputi:
* **Manajemen Data Utama:** Mahasiswa, Dosen, Mata Kuliah, dan Jadwal Perkuliahan.
* **Transaksi Akademik:** Pendaftaran Kartu Rencana Studi (KRS) dan Penginputan Nilai.
* **Perluasan Bisnis (Fitur Utama):** Pencatatan dan rekapitulasi **Absensi Perkuliahan** per sesi pertemuan untuk penentuan kelayakan Ujian Akhir Semester (UAS).

---

## 📁 Struktur Repositori

```text
.
├── db_akademik.sql          # File DDL (Tabel) & Query SQL (Dummy Data)
├── README.md                # Dokumentasi utama proyek
└── assets/                  # File pendukung (Diagram ERD, Dokumentasi Word)
```

---

## 📐 Pemodelan Konseptual (Conceptual Model)

### Entity-Relationship Diagram (ERD)

![ERD Sistem Informasi Akademik](assets/erd_clean_no_title.png)

### Daftar Entitas & Atribut

| Entitas | Primary Key / Foreign Key | Atribut Lainnya |
| :--- | :--- | :--- |
| **`mahasiswa`** | `nim` (PK) | `nama`, `semester` |
| **`dosen`** | `nidn` (PK) | `nama_dosen` |
| **`matkul`** | `kode_mk` (PK), `nidn` (FK) | `nama_mk`, `sks` |
| **`jadwal`** | `id_jadwal` (PK), `kode_mk` (FK) | `hari`, `jam`, `ruang` |
| **`krs`** | `id_krs` (PK), `nim` (FK), `kode_mk` (FK) | `semester`, `tahun_akademik` |
| **`absensi`** *(Perluasan)* | `id_absensi` (PK), `id_krs` (FK), `id_jadwal` (FK) | `tgl_pertemuan`, `pertemuan_ke`, `status_hadir` |
| **`nilai`** | `id_nilai` (PK), `nim` (FK), `kode_mk` (FK) | `nilai`, `semester` |
| **`laporan`** | `id_laporan` (PK) | `periode`, `jenis_laporan`, `data_laporan` |
| **`cache`** | `cache_key` (PK) | `cache_value`, `expired_at` |

---

## 🚀 Cara Penggunaan Database

1. **Import Database:**
   * Buka **phpMyAdmin** / **MySQL Workbench** / **DBeaver**.
   * Buat database baru bernama `db_akademik` atau jalankan file SQL secara langsung.
   * Import file `db_akademik.sql`.

2. **Terminal / CLI MySQL:**
   ```bash
   mysql -u root -p < db_akademik.sql
   ```

---

## 🔄 Normalisasi (Logical Modeling)

Perancangan basis data telah memenuhi kriteria **3NF (Third Normal Form)** untuk menghindari redundansi data dan menjaga integritas referensial:
1. **1NF:** Mengeliminasi *repeating groups* dan memastikan nilai atomik pada setiap kolom.
2. **2NF:** Memisahkan entitas berdasarkan *Partial Dependency* terhadap komposit primary key.
3. **3NF:** Memisahkan entitas `dosen` dari `matkul` untuk menghilangkan *Transitive Dependency*.