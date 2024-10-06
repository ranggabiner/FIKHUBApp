//
//  ScheduleViewModel.swift
//  FIKHUB
//
//  Created by Rangga Biner on 06/10/24.
//

import Foundation

class ScheduleViewModel: ObservableObject {
    @Published var schedules: [Schedule] = []
    @Published var currentStudent: Student
    private let scheduleUseCase: ScheduleUseCase
    
    init(schedules: [Schedule], scheduleUseCase: ScheduleUseCase, currentStudent: Student) {
        self.schedules = schedules
        self.scheduleUseCase = scheduleUseCase
        self.currentStudent = currentStudent
    }

    func loadSchedules() async {
        do {
            schedules = try await scheduleUseCase.getAllSchedules()
        } catch {
            print("Error loading students: \(error)")
        }
    }

    func addSchedule(_ schedule: Schedule) async {
        do {
            try await scheduleUseCase.addSchedule(schedule)
            await loadSchedules()
        } catch {
            print("Error adding student: \(error)")
        }
    }

    func updateSchedule(_ schedule: Schedule) async {
        do {
            try await scheduleUseCase.updateSchedule(schedule)
            await loadSchedules()
        } catch {
            print("Error updating student: \(error)")
        }
    }

}
