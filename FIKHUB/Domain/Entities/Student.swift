//
//  Student.swift
//  FIKHUB
//
//  Created by Rangga Biner on 05/10/24.
//

import Foundation
import SwiftData

@Model
final class Student {
    var name: String
    var major: String
    var semester: Int
    
    init(name: String, major: String, semester: Int) {
        self.name = name
        self.major = major
        self.semester = semester
    }
}

