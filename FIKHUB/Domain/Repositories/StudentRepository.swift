//
//  StudentRepository.swift
//  FIKHUB
//
//  Created by Rangga Biner on 05/10/24.
//

import Foundation

protocol StudentRepository {
    func getStudent(_ student: Student) async throws -> Student
    func addStudent(_ student: Student) async throws
    func updateStudent(_ student: Student) async throws
}
