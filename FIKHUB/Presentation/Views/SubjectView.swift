//
//  SubjectView.swift
//  FIKHUB
//
//  Created by Rangga Biner on 06/10/24.
//

import SwiftUI

struct SubjectView: View {
    let courses: [String: [String]] = [
        "D3 Sistem Informasi": ["Basis Data", "Pemrograman Web", "Analisis Sistem Informasi"],
        "S1 Sistem Informasi": ["Manajemen Proyek IT", "Business Intelligence", "E-Commerce"],
        "S1 Informatika": ["Algoritma dan Struktur Data", "Kecerdasan Buatan", "Jaringan Komputer"]
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
