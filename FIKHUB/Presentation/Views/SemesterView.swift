//
//  SemesterView.swift
//  FIKHUB
//
//  Created by Rangga Biner on 06/10/24.
//

import SwiftUI

struct SemesterView: View {
    let semesters: [Int:String] = [
        1: "Semester 1",
        2: "Semester 2",
        3: "Semester 3",
        4: "Semester 4",
        5: "Semester 5",
        6: "Semester 6",
        7: "Semester 7",
        8: "Semester 8",
    ]
    @Binding var selectedSemester: String
    @Environment(\.presentationMode) var presentationMode
    @State private var searchText = ""

    
    var filteredSemesters: [(key: Int, value: String)] {
        if searchText.isEmpty {
            return Array(semesters.sorted(by: { $0.key < $1.key }))
        } else {
            return semesters.filter { $0.value.lowercased().contains(searchText.lowercased()) }
                .sorted(by: { $0.key < $1.key })
        }
    }


    var body: some View {
        Form {
            ForEach(filteredSemesters, id: \.key) { key, value in
                Button(action: {
                    selectedSemester = value
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Text(value)
                        .foregroundColor(.primary)
                }
            }
        }
        .searchable(text: $searchText, prompt: "Cari semester")
        .navigationBarTitle("Pilih Semester", displayMode: .inline)
    }
}
