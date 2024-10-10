//
//  SubjectView.swift
//  FIKHUB
//
//  Created by Rangga Biner on 06/10/24.
//

import SwiftUI

struct SubjectView: View {
    let courses: [String: [String]] = [
        "D3 Sistem Informasi": [
            "Pendidikan Agama",
            "Keamanan Sistem Informasi",
            "Pancasila",
            "Mobile Programming",
            "Pendidikan Bela Negara",
            "Praktikum Mobile Programming",
            "Dasar Pemrograman",
            "Pemrograman Berorientasi Objek",
            "Praktikum Dasar Pemrograman",
            "Praktikum Pemrograman Berorientasi Objek",
            "Konsep Basis Data",
            "Etika Profesi Sistem Informasi",
            "Praktikum Konsep Basis Data",
            "Struktur Data",
            "Intelegensia Bisnis",
            "Praktikum Struktur Data",
            "Proyek Perangkat Lunak",
            "Matematika Diskrit",
            "Pemrograman Web Lanjut",
            "Pemrograman Mobile Lanjut",
            "Analisis Proses Bisnis",
            "Visualisasi Data",
            "Sistem Informasi Manajemen",
            "Data Mining dan Data Warehouse",
            "Algoritma dan Pemrograman Berorientasi",
            "Manajemen Kualitas Bisnis",
            "Praktikum Algoritma dan Pemrograman",
            "Komunikasi Bisnis",
            "Sistem Basis Data",
            "Praktikum Sistem Basis Data",
            "Analisis Dan Perancangan Sistem Informasi",
            "Praktikum Analisis Dan Perancangan Sistem",
            "Konsep Sistem Informasi",
            "Bahasa Inggris",
            "Sistem Operasi",
            "Praktikum Sistem Operasi",
            "Interaksi Manusia Dan Komputer",
            "Praktikum Interaksi Manusia Dan Komputer",
            "Pemrograman Web",
            "Praktikum Pemrograman Web",
            "Technopreneurship",
            "Desain Arsitektur enterprise",
            "Statistik dan Probabilitas",
            "Jaringan Komputer",
            "Pengantar Teknologi Informasi",
            "Praktikum Jaringan Komputer",
            "Analisis bisnis",
            "Keamanan Sistem Dan Aplikasi",
            "Pengantar Data Science",
            "Praktikum Keamanan Sistem Dan Aplikasi",
            "Manajemen Proyek Sistem Informasi",
            "Manajemen data dan Informasi",
            "Praktikum Manajemen data dan Informasi",
            "Big Data",
            "Perancangan ui/ux",
            "Praktikum perancangan ui/ux"
          ],
        "S1 Sistem Informasi": [
            "Pendidikan Agama",
            "Pengantar Filsafat Ilmu",
            "Pancasila & Pendidikan Kewarganegaraan",
//            "Manajemen Proyek Sistem Informasi",
//            "Pengantar Teknologi Informasi",
//            "Sistem Operasi",
//            "Dasar Pemrograman",
//            "Praktikum Sistem Operasi",
//            "Praktikum Dasar Pemrograman",
//            "Web Programming",
//            "Konsep Basis Data",
//            "Praktikum Web Programming",
//            "Praktikum Konsep Basis Data",
//            "Etika Profesi Teknologi Informasi",
//            "Matematika Diskrit",
//            "Keamanan Jaringan",
//            "Konsep Sistem Informasi",
//            "Artificial Intelligence",
//            "Transformasi Digital",
//            "Manajemen Risiko Sistem Informasi",
//            "Data Engineering",
//            "Bahasa Indonesia",
//            "Ui/Ux Design",
//            "Struktur Data Dan Algoritma",
//            "Praktikum Struktur Data Dan Algoritma",
//            "Metode Penelitian",
//            "Analisis Dan Perancangan Sistem Informasi",
//            "Keamanan Sistem Informasi",
//            "Sistem Basisdata",
//            "Data Mining And Data Warehouse",
//            "Praktikum Sistem Basisdata",
//            "Internet Of Thing (IoT)",
//            "Statistika Dan Probabilitas",
//            "Interaksi Manusia Dan Komputer",
//            "Jaringan Komputer",
//            "Computational Thinking",
//            "Audit Sistem Informasi",
//            "Pemrograman Berorientasi Objek",
//            "Praktikum Pemrograman Berorientasi Objek",
//            "Tata Kelola TI",
//            "Analisis Dan Perancangan Sistem Informasi",
//            "Praktikum Analisis Dan Prancangan Sistem",
//            "Bahasa Inggris",
//            "Arsitektur Enterprise",
//            "Sistem Informasi Manajemen"
          ],
        "S1 Informatika": [
            "Dasar Pemrograman",
            "Keamanan Data dan Jaringan",
            "Praktikum Dasar Pemrograman",
//            "Praktikum Keamanan Data dan Jaringan",
//            "Statistika dan Probabilitas",
//            "Rekayasa Perangkat Lunak",
//            "Pengantar Teknologi Informasi",
//            "Internet Of Thing",
//            "Konsep Basis Data",
//            "Pratikum Internet Of Thing",
//            "Praktikum Konsep Basis Data",
//            "Kecerdasan Buatan",
//            "Kalkulus",
//            "Pemrograman Berbasis Platform",
//            "Pendidikan Agama",
//            "Praktikum Pemrograman berbasis Platform",
//            "Pancasila",
//            "Matematika Diskrit",
//            "Bahasa Indonesia",
//            "Technopreneuership",
//            "Kriptografi",
//            "Algoritma dan Pemrograman",
//            "Pembangunan Perangkat Lunak Berorientasi",
//            "Praktikum Algoritma dan Pemrograman",
//            "Komputasi Jaringan",
//            "Struktur Data",
//            "Praktikum Struktur Data",
//            "Hukum Teknologi Informasi",
//            "Aljabar Linier",
//            "Analisis dan Desain Perangkat Lunak",
//            "Logika Matematika",
//            "Komputasi Paralel dan Terdistribusi",
//            "Sistem Basis Data",
//            "Teori Bahasa dan Automata",
//            "Praktikum Sistem Basis Data",
//            "Bahasa Inggris",
//            "Etika Profesi Teknologi Informasi",
//            "Forensik Digital",
//            "Arsitektur dan Organisasi Komputer",
//            "Pengembangan Aplikasi Permainan",
//            "Wireless Network",
//            "Metode Penelitian",
//            "Magang/Studi Independen",
//            "Jaringan Komputer",
//            "Manajemen Resiko",
//            "Praktikum Jaringan Komputer",
//            "Cyber Politik dan Media Baru",
//            "Manajemen Proyek Perangkat Lunak",
//            "Pembelajaran Mesin",
//            "Sistem Operasi",
//            "Tata Kelola TI",
//            "Praktikum Sistem Operasi",
//            "Sistem Kendali",
//            "Kompleksitas Algoritma",
//            "Pemrograman Berorientasi Objek",
//            "Praktikum Pemrograman Berorientasi",
//            "Interaksi Manusia dan Komputer",
//            "Keamanan Siber",
//            "Realitas Virtual dan Realitas Augmentasi",
//            "Komputasi Awan",
//            "Proyek Capstone",
//             "Pendidikan Bela Negara",
//            "Kepemimpinan",
//            "Software Quality Assurance",
//            "Filsafat Ilmu dan Logika",
//            "Informatika Sosial",
//            "Kewarganegaraan",
//            "Big Data",
//            "Praktikum Big Data",
//            "Perangkat Sensor Jaringan tanpa kabel",
//            "Sistem Pakar",
//            "Visualisasi Data",
//            "Technology Blockchain",
//            "Ethical Hacking",
//            "Sistem Digital",
//            "Temu Kembali Informasi",
//            "Mobile Programming",
//            "Praktikum Mobile Programming",
//            "Embedded System",
//            "Data mining dan Data warehouse + Tutorial",
//            "Pratikum Data Mining dan Data Warehouse",
//            "Pengolahan Citra Digital",
//            "Praktikum Pengolahan Citra Digital",
//            "Deep Learning",
//            "Communication Skill",
//            "Problem Solving",
//            "Manajemen Organisasi",
//            "Inovasi dan Desain Thinking",
//            "Strategi Algoritma",
//            "Financial Technology",
//            "Analisis Jejaring Sosial",
//            "Sistem Media Interaktif",
//            "AI Computing Platform",
//            "Web Semantic",
//            "Robotika",
//            "Computer Vision"
          ]
    ]
    @Binding var selectedCourse: String
    let studentMajor: String
    @Environment(\.presentationMode) var presentationMode
    @State private var searchText = ""

    var filteredCourses: [String] {
        let majorCourses = courses[studentMajor] ?? []
        if searchText.isEmpty {
            return majorCourses
        } else {
            return majorCourses.filter { $0.lowercased().contains(searchText.lowercased()) }
        }
    }

    var body: some View {
        NavigationView {
            Form {
                ForEach(filteredCourses, id: \.self) { course in
                    Button(action: {
                        selectedCourse = course
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Text(course)
                            .foregroundColor(.primary)
                    }
                }
            }
            .searchable(text: $searchText, prompt: "Cari mata kuliah")
            .navigationBarTitle("Pilih Mata Kuliah", displayMode: .inline)
        }
    }
}
