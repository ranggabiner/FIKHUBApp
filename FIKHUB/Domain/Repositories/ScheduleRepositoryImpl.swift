//
//  ScheduleRepositoryImpl.swift
//  FIKHUB
//
//  Created by Rangga Biner on 06/10/24.
//

import Foundation

class ScheduleRepositoryImpl: ScheduleRepository {
    private let dataSource: ScheduleDataSource
    
    init(dataSource: ScheduleDataSource) {
        self.dataSource = dataSource
    }
    
    func getAllSchedules() async throws -> [Schedule] {
        return try await dataSource.fetchAllSchedules()
    }
    
    func addSchedule(_ schedule: Schedule) async throws {
        try await dataSource.insert(schedule)
    }
    
    func updateSchedule(_ schedule: Schedule) async throws {
        try await dataSource.update(schedule)
    }
    
    func deleteSchedule(_ schedule: Schedule) async throws {
        do {
            try await dataSource.delete(schedule)
        } catch {
            print("Error deleting student: \(error)")
            throw error
        }
    }
}
