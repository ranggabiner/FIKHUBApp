//
//  ScheduleDataSource.swift
//  FIKHUB
//
//  Created by Rangga Biner on 06/10/24.
//

import Foundation

protocol ScheduleDataSource {
    func fetchAllSchedules() async throws -> [Schedule]
    func insert(_ schedule: Schedule) async throws
    func update(_ schedule: Schedule) async throws
    func delete(_ schedule: Schedule) async throws
}

