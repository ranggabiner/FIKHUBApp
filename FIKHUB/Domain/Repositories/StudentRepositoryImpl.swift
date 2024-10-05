//
//  StudentRepositoryImpl.swift
//  FIKHUB
//
//  Created by Rangga Biner on 05/10/24.
//

import Foundation

class StudentRepositoryImpl: StudentRepository {
    private let dataSource: StudentDataSource
    
    init(dataSource: StudentDataSource) {
        self.dataSource = dataSource
    }
    
    func getStudent(_ student: Student) async throws -> Student {
        return try await dataSource.fetchStudent(student)
    }
    
    func addStudent(_ student: Student) async throws {
        try await dataSource.insert(student)
    }
    
    func updateStudent(_ student: Student) async throws {
        try await dataSource.update(student)
    }
}
