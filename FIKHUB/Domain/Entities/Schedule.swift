//
//  Schedule.swift
//  FIKHUB
//
//  Created by Rangga Biner on 06/10/24.
//

import Foundation
import SwiftData

@Model
class Schedule {
    var id: UUID = UUID()
    var subject: String
    var location: String
    var day: String
    var startTime: Date
    var endTime: Date
    
    init(id: UUID = UUID(), subject: String, location: String, day: String, startTime: Date, endTime: Date) {
        self.id = id
        self.subject = subject
        self.location = location
        self.day = day
        self.startTime = startTime
        self.endTime = endTime
    }
}
