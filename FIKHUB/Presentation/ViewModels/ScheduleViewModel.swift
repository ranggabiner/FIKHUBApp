//
//  ScheduleViewModel.swift
//  FIKHUB
//
//  Created by Rangga Biner on 06/10/24.
//

import Foundation

@MainActor
class ScheduleViewModel: ObservableObject {
    @Published var schedulesByDay: [String: [Schedule]] = [:]
    @Published var currentStudent: Student
    private let scheduleUseCase: ScheduleUseCase
    
    let sortedDays = ["Senin", "Selasa", "Rabu", "Kamis", "Jumat", "Sabtu", "Minggu"]
    
    init(scheduleUseCase: ScheduleUseCase, currentStudent: Student) {
        self.scheduleUseCase = scheduleUseCase
        self.currentStudent = currentStudent
    }

    func loadSchedules() async {
        do {
            let schedules = try await scheduleUseCase.getAllSchedules()
            groupSchedulesByDay(schedules)
        } catch {
            print("Error loading schedules: \(error)")
        }
    }

    func groupSchedulesByDay(_ schedules: [Schedule]) {
        schedulesByDay = Dictionary(grouping: schedules, by: { $0.day })
        schedulesByDay = sortedDays.reduce(into: [:]) { result, day in
            if let schedules = schedulesByDay[day] {
                result[day] = schedules.sorted { $0.startTime < $1.startTime }
            }
        }
    }

    func addSchedule(_ schedule: Schedule) async {
        do {
            try await scheduleUseCase.addSchedule(schedule)
            await loadSchedules()
        } catch {
            print("Error adding schedule: \(error)")
        }
    }

    func updateSchedule(_ schedule: Schedule) async {
        do {
            try await scheduleUseCase.updateSchedule(schedule)
            await loadSchedules()
        } catch {
            print("Error updating schedule: \(error)")
        }
    }

    func deleteSchedule(_ schedule: Schedule) async {
        do {
            try await scheduleUseCase.deleteSchedule(schedule)
            await loadSchedules()
        } catch {
            print("Error deleting schedule: \(error)")
        }
    }
}
