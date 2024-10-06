//
//  StudentUseCaseImpl.swift
//  FIKHUB
//
//  Created by Rangga Biner on 06/10/24.
//

import Foundation

class StudentUseCaseImpl: StudentUseCase {
    private let repository: StudentRepository
    
    init(repository: StudentRepository) {
        self.repository = repository
    }
    
    func addStudent(_ student: Student) async throws {
        try await repository.addStudent(student)
    }
    
    func getStudent(_ student: Student) async throws -> Student {
        return try await repository.getStudent(student)
    }
    func updateStudent(oldStudent: Student, newStudent: Student) async throws {
        try await repository.updateStudent(oldStudent: oldStudent, newStudent: newStudent)
    }
}

