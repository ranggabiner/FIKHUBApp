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
