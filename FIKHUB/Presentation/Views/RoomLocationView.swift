//
//  RoomLocationView.swift
//  FIKHUB
//
//  Created by Rangga Biner on 06/10/24.
//

import SwiftUI

struct RoomLocationView: View {
    let subjects: [Int:String] = [
        1: "FIK-201",
        2: "FIKLAB-201",
        3: "FIKLAB-202",
        4: "FIKLAB-203",
        5: "FIKLAB-301",
        6: "FIKLAB-302",
        7: "FIKLAB-303",
        8: "FIKLAB-401",
        9: "FIKLAB-402",
        10: "FIKLAB-403",
    ]
    @State private var searchText = ""
    @Binding var selectedLocation: String
    @Environment(\.presentationMode) var presentationMode


    var filteredSubjects: [(key: Int, value: String)] {
        if searchText.isEmpty {
            return Array(subjects.sorted(by: { $0.key < $1.key }))
        } else {
            return subjects.filter { $0.value.lowercased().contains(searchText.lowercased()) }
                .sorted(by: { $0.key < $1.key })
        }
    }

    var body: some View {
        NavigationStack {
            List {
                ForEach(filteredSubjects, id: \.key) { key, value in
                    Button(action: {
                        selectedLocation = value
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Text(value)
                            .foregroundColor(.black)
                    }
                }
            }
            .navigationBarTitle("Ruang", displayMode: .inline)
            .searchable(text: $searchText, prompt: "Cari")
        }
    }
}
