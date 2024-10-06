//
//  ScheduleUseCaseImpl.swift
//  FIKHUB
//
//  Created by Rangga Biner on 06/10/24.
//

import Foundation

class ScheduleUseCaseImpl: ScheduleUseCase {
    let repository: ScheduleRepository
    
    init(repository: ScheduleRepository) {
        self.repository = repository
    }
    
    func getAllSchedules() async throws -> [Schedule] {
        return try await repository.getAllSchedules()
    }
    
    func addSchedule(_ schedule: Schedule) async throws {
        try await repository.addSchedule(schedule)
    }
    
    func updateSchedule(_ schedule: Schedule) async throws {
        print("Updating schedule in use case")
        try await repository.updateSchedule(schedule)
    }

    func deleteSchedule(_ schedule: Schedule) async throws {
        try await repository.deleteSchedule(schedule)
    }
    
    
}
