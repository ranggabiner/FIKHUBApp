//
//  OnboardingInputViewModel.swift
//  FIKHUB
//
//  Created by Rangga Biner on 05/10/24.
//

import Foundation
import SwiftUI

@MainActor
class OnboardingInputViewModel: ObservableObject {
    private let studentUseCases: StudentUseCase
    @Published var student: Student?
    @Published var errorMessage: String?
    @Published var name: String = ""
    @Published var selectedSemester: String = "Pilih Semester"
    @Published var isSaving: Bool = false
    @Published var selectedMajor: String = "Pilih Program Studi" 

    
    init(studentUseCases: StudentUseCase) {
        self.studentUseCases = studentUseCases
    }
    
    func addStudent(_ student: Student) async {
        do {
            try await studentUseCases.addStudent(student)
            self.student = student
        } catch {
            errorMessage = "Error adding student: \(error.localizedDescription)"
        }
    }
}
