//
//  StudentDataSourceImpl.swift
//  FIKHUB
//
//  Created by Rangga Biner on 05/10/24.
//

import Foundation
import SwiftData

class StudentDataSourceImpl: StudentDataSource {
    private let context: ModelContext
    
    init(context: ModelContext) {
        self.context = context
    }

    func fetchStudent(_ student: Student) async throws -> Student {
        return student
    }
    
    func insert(_ student: Student) async throws {
        context.insert(student)
        try context.save()
    }
    
    func update(oldStudent: Student, newStudent: Student) async throws {
        oldStudent.name = newStudent.name
        oldStudent.major = newStudent.major
        oldStudent.semester = newStudent.semester
        try context.save()
    }

}

