//
//  ScheduleDataSourceImpl.swift
//  FIKHUB
//
//  Created by Rangga Biner on 06/10/24.
//

import Foundation
import SwiftData

class ScheduleDataSourceImpl: ScheduleDataSource {
    private let context: ModelContext
    
    init(context: ModelContext) {
        self.context = context
    }

    func fetchAllSchedules() async throws -> [Schedule] {
        let descriptor = FetchDescriptor<Schedule>(sortBy: [SortDescriptor(\.day, order: .reverse)])
        let students = try context.fetch(descriptor)
        return students
    }
    
    func insert(_ schedule: Schedule) async throws {
        context.insert(schedule)
        try context.save()
    }
    
    func update(_ schedule: Schedule) async throws {
        try context.save()
    }
    
    func delete(_ schedule: Schedule) async throws {
        context.delete(schedule)
        try context.save()
    }
}
