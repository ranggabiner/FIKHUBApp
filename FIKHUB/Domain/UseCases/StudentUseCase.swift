//
//  StudentUseCase.swift
//  FIKHUB
//
//  Created by Rangga Biner on 05/10/24.
//

import Foundation

protocol StudentUseCase {
    func addStudent(_ student: Student) async throws
    func getStudent(_ student: Student) async throws -> Student
    func updateStudent(oldStudent: Student, newStudent: Student) async throws
}

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
