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
