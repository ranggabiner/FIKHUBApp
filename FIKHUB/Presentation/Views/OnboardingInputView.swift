//
//  OnboardingInputView.swift
//  FIKHUB
//
//  Created by Rangga Biner on 05/10/24.
//

import SwiftUI

struct OnboardingInputView: View {
    @StateObject var viewModel: OnboardingInputViewModel
    @Binding var hasSeenOnboarding: Bool
    

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
                    ButtonFill(title: "Lanjutkan", action: {
                        saveAndContinue()
                    },
                               backgroundColor: isFormValid ? .primaryOrange : .gray
                    )
                    .disabled(viewModel.isSaving)
                    .disabled(!isFormValid)
                    .padding()
                }
            }
            .navigationBarTitle("Profile", displayMode: .large)
        }
    }
    
    private func saveAndContinue() {
        Task {
            let newStudent = Student(name: viewModel.name, major: viewModel.selectedMajor, semester: viewModel.selectedSemester)
            await viewModel.addStudent(newStudent)
            hasSeenOnboarding = true
            print(newStudent.name, newStudent.major, newStudent.semester)
        }
    }
    
    private var isFormValid: Bool {
        !viewModel.name.isEmpty &&
        !viewModel.selectedMajor.contains("Pilih Program Studi") &&
        !viewModel.selectedSemester.contains("Pilih Semester") &&
        !viewModel.isSaving
    }
}
