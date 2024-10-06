//
//  StudentDataSource.swift
//  FIKHUB
//
//  Created by Rangga Biner on 05/10/24.
//

import Foundation

protocol StudentDataSource {
    func fetchStudent(_ student: Student) async throws -> Student
    func insert(_ student: Student) async throws
    func update(oldStudent: Student, newStudent: Student) async throws

}
