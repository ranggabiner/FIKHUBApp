//
//  EditProfileViewModel.swift
//  FIKHUB
//
//  Created by Rangga Biner on 06/10/24.
//

import Foundation

@MainActor
class EditProfileViewModel: ObservableObject {
    private let studentUseCases: StudentUseCase
    @Published var name: String = ""
    @Published var selectedMajor: String = "Pilih Program Studi"
    @Published var selectedSemester: String = "Pilih Semester"
    @Published var isSaving: Bool = false
    
    @Published var currentStudent: Student
    
    init(studentUseCases: StudentUseCase, student: Student) {
        self.studentUseCases = studentUseCases
        self.currentStudent = student
        self.loadCurrentProfile()
    }
    
    func loadCurrentProfile() {
        self.name = currentStudent.name
        self.selectedMajor = currentStudent.major
        self.selectedSemester = currentStudent.semester
    }
    
    func updateProfile() async {
        let newStudent = Student(name: name, major: selectedMajor, semester: selectedSemester)
        
        self.isSaving = true
        
        do {
            try await studentUseCases.updateStudent(oldStudent: currentStudent, newStudent: newStudent)
            self.currentStudent = newStudent
        } catch {
            print("error")
        }
        
        self.isSaving = false
    }
}

struct AlertItem: Identifiable {
    let id = UUID()
    let title: String
    let message: String
    let buttonTitle: String
}

