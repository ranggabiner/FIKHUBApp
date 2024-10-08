//
//  CourseMeetingView.swift
//  FIKHUB
//
//  Created by Rangga Biner on 06/10/24.
//

import SwiftUI

struct CourseMeetingView: View {
    let courseMeeting: [String: [String: String]] = [
        "Basis Data": [
            "Pengenalan Basis Data": "Detail tentang pengenalan basis data...",
            "Model Relasional": "Penjelasan tentang model relasional...",
            "SQL Dasar": "Dasar-dasar SQL..."
        ],
        "Pemrograman Web": [
            "HTML dan CSS Dasar": "Pengenalan HTML dan CSS...",
            "JavaScript Fundamental": "Dasar-dasar JavaScript...",
            "Pengenalan Framework": "Berbagai framework web populer..."
        ],
        "Analisis Sistem Informasi": [
            "Konsep Dasar Sistem Informasi": "Penjelasan konsep dasar sistem informasi...",
            "Analisis Kebutuhan": "Metode analisis kebutuhan sistem...",
            "Pemodelan Proses": "Teknik pemodelan proses dalam analisis sistem..."
        ],
        "Manajemen Proyek IT": [
            "Perencanaan Proyek": "Langkah-langkah perencanaan proyek IT...",
            "Pengelolaan Sumber Daya": "Cara mengelola sumber daya dalam proyek IT...",
            "Pengawasan dan Kontrol": "Teknik pengawasan dan kontrol proyek..."
        ],
        "Business Intelligence": [
            "Konsep Dasar BI": "Penjelasan konsep dasar Business Intelligence...",
            "Alat dan Teknologi BI": "Alat dan teknologi yang digunakan dalam BI...",
            "Implementasi BI": "Langkah-langkah implementasi BI dalam organisasi..."
        ],
        "E-Commerce": [
            "Dasar-dasar E-Commerce": "Pengenalan dasar-dasar e-commerce...",
            "Model Bisnis E-Commerce": "Berbagai model bisnis e-commerce...",
            "Teknologi E-Commerce": "Teknologi yang digunakan dalam e-commerce..."
        ],
        "Algoritma dan Struktur Data": [
            "Konsep Dasar Algoritma": "Penjelasan konsep dasar algoritma...",
            "Struktur Data Dasar": "Pengenalan struktur data dasar seperti array, linked list, stack, queue...",
            "Algoritma Pencarian dan Pengurutan": "Algoritma pencarian dan pengurutan data..."
        ],
        "Kecerdasan Buatan": [
            "Konsep Dasar AI": "Penjelasan konsep dasar kecerdasan buatan...",
            "Machine Learning": "Dasar-dasar machine learning...",
            "Aplikasi AI": "Aplikasi kecerdasan buatan dalam berbagai bidang..."
        ],
        "Jaringan Komputer": [
            "Dasar-dasar Jaringan": "Pengenalan dasar-dasar jaringan komputer...",
            "Protokol Jaringan": "Penjelasan tentang protokol jaringan seperti TCP/IP...",
            "Keamanan Jaringan": "Teknik keamanan jaringan komputer..."
        ]
    ]
    
    let studentSubject: String
    @State private var searchText = ""
    @State private var selectedCourse: (title: String, detail: String)?
    let currentStudent: Student

    var filteredCourses: [(String, String)] {
        let majorCourses = courseMeeting[studentSubject] ?? [:]
        if searchText.isEmpty {
            return majorCourses.map { ($0.key, $0.value) }
        } else {
            return majorCourses.filter { $0.key.lowercased().contains(searchText.lowercased()) }
                .map { ($0.key, $0.value) }
        }
    }

    var body: some View {
        NavigationView {
            List {
                ForEach(filteredCourses, id: \.0) { course, detail in
                    NavigationLink(destination: CourseChatView(course: course, detail: detail, currentStudent: currentStudent)) {
                        Text(course)
                    }
                }
            }
            .searchable(text: $searchText, prompt: "Cari materi")
            .navigationBarTitle(studentSubject, displayMode: .inline)
        }
    }
}
