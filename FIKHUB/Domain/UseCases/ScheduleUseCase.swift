//
//  ScheduleUseCase.swift
//  FIKHUB
//
//  Created by Rangga Biner on 06/10/24.
//

import Foundation

protocol ScheduleUseCase {
    func getAllSchedules() async throws -> [Schedule]
    func addSchedule(_ schedule: Schedule) async throws
    func updateSchedule(_ schedule: Schedule) async throws
    func deleteSchedule(_ schedule: Schedule) async throws
}
