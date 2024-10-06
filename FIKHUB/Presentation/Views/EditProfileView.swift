//
//  EditProfileView.swift
//  FIKHUB
//
//  Created by Rangga Biner on 05/10/24.
//

import SwiftUI


struct EditProfileView: View {
    @StateObject var viewModel: EditProfileViewModel
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        NavigationStack {
            ZStack {
                Form {
                    Section {
                        HStack {
                            Text("Nama")
                                .frame(maxWidth: 100, alignment: .leading)
                            TextFieldClear(placeholder: "Nama Anda", text: $viewModel.name, keyboardType: .default, onClear: {
                                viewModel.name = ""
                            })
                        }
                    }
                    Section {
                        NavigationLink(destination: MajorsView(selectedMajor: $viewModel.selectedMajor)) {
                            Text(viewModel.selectedMajor)
                                .foregroundStyle(.primaryOrange)
                        }
                        
                        NavigationLink(destination: SemesterView(selectedSemester: $viewModel.selectedSemester)) {
                            Text(viewModel.selectedSemester)
                                .foregroundStyle(.primaryOrange)
                        }
                    }
                }
                VStack {
                    Spacer()
                    ButtonFill(title: "Simpan Perubahan", action: {
                        saveChanges()
                    },
                               backgroundColor: isFormValid ? .primaryOrange : .gray
                    )
                    .disabled(viewModel.isSaving)
                    .disabled(!isFormValid)
                    .padding()
                }
            }
            .navigationBarTitle("Edit Profile", displayMode: .large)
        }
        .onAppear {
            viewModel.loadCurrentProfile()
        }
    }
    
    private func saveChanges() {
        Task {
            await viewModel.updateProfile()
        }
    }
    
    private var isFormValid: Bool {
        !viewModel.name.isEmpty &&
        !viewModel.selectedMajor.contains("Pilih Program Studi") &&
        !viewModel.selectedSemester.contains("Pilih Semester") &&
        !viewModel.isSaving
    }
}
