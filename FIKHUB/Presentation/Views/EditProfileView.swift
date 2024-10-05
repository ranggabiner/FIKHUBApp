//
//  EditProfileView.swift
//  FIKHUB
//
//  Created by Rangga Biner on 05/10/24.
//

import SwiftUI

struct EditProfileView: View {
    @ObservedObject var viewModel: EditProfileViewModel
    @State private var name: String
    @State private var major: String
    @State private var semester: Int
    @Environment(\.presentationMode) var presentationMode

    init(viewModel: EditProfileViewModel) {
        self.viewModel = viewModel
        _name = State(initialValue: viewModel.student?.name ?? "")
        _major = State(initialValue: viewModel.student?.major ?? "")
        _semester = State(initialValue: viewModel.student?.semester ?? 1)
    }

    var body: some View {
        Form {
            Section(header: Text("Edit Student Information")) {
                TextField("Name", text: $name)
                TextField("Major", text: $major)
                Stepper("Semester: \(semester)", value: $semester, in: 1...8)
            }
            
            Section {
                Button("Save Changes") {
                    saveChanges()
                }
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.blue)
                .cornerRadius(10)
            }
        }
        .navigationTitle("Edit Profile")
        .alert(isPresented: $viewModel.showAlert) {
            Alert(title: Text("Update Status"),
                  message: Text(viewModel.alertMessage),
                  dismissButton: .default(Text("OK")) {
                      if viewModel.updateSuccessful {
                          presentationMode.wrappedValue.dismiss()
                      }
                  })
        }
    }
    
    private func saveChanges() {
        guard let student = viewModel.student else { return }
        let updatedStudent = Student(name: name, major: major, semester: semester)
        Task {
            await viewModel.updateStudent(oldStudent: student, newStudent: updatedStudent)
        }
    }
}

class EditProfileViewModel: ObservableObject {
    private let studentUseCases: StudentUseCase
    @Published var student: Student?
    @Published var showAlert = false
    @Published var alertMessage = ""
    @Published var updateSuccessful = false
    
    init(studentUseCases: StudentUseCase, student: Student) {
        self.studentUseCases = studentUseCases
        self.student = student
    }
    
    @MainActor
    func updateStudent(oldStudent: Student, newStudent: Student) async {
        do {
            try await studentUseCases.updateStudent(oldStudent: oldStudent, newStudent: newStudent)
            self.student = newStudent
            self.alertMessage = "Profile updated successfully!"
            self.updateSuccessful = true
            self.showAlert = true
        } catch {
            self.alertMessage = "Error updating profile: \(error.localizedDescription)"
            self.updateSuccessful = false
            self.showAlert = true
        }
    }
}
