//
//  MajorsView.swift
//  FIKHUB
//
//  Created by Rangga Biner on 06/10/24.
//

import SwiftUI

struct MajorsView: View {
    let majors: [Int:String] = [
        1: "D3 Sistem Informasi",
        2: "S1 Sistem Informasi",
        3: "S1 Informatika",
    ]
    @Binding var selectedMajor: String
    @Environment(\.presentationMode) var presentationMode
    @State private var searchText = ""


    var body: some View {
        Form {
            ForEach(searchResults, id: \.key) { key, value in
                Button(action: {
                    selectedMajor = value
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Text(value)
                        .foregroundColor(.primary)
                }
            }
        }
        .navigationBarTitle("Pilih Program Studi", displayMode: .inline)
        .searchable(text: $searchText, prompt: "Cari program studi")

    }
    var searchResults: [(key: Int, value: String)] {
        if searchText.isEmpty {
            return majors.sorted { $0.key < $1.key }
        } else {
            return majors.filter { $0.value.lowercased().contains(searchText.lowercased()) }
                .sorted { $0.key < $1.key }
        }
    }

}
