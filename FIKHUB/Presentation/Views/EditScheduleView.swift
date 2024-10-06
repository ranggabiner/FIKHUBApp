//
//  EditScheduleView.swift
//  FIKHUB
//
//  Created by Rangga Biner on 06/10/24.
//

import SwiftUI

struct EditScheduleView: View {
    @ObservedObject var viewModel: ScheduleViewModel
    @Environment(\.presentationMode) var presentationMode
    @State var subject = ""
    @State var location = ""
    @State var day = ""
    @State var startTime: Date
    @State var endTime: Date

    enum Mode: Equatable {
        case add
        case edit(Schedule)
        
        static func == (lhs: Mode, rhs: Mode) -> Bool {
            switch (lhs, rhs) {
            case (.add, .add):
                return true
            case let (.edit(schedule1), .edit(schedule2)):
                return schedule1.id == schedule2.id
            default:
                return false
            }
        }
    }
    
    let mode: Mode
    
    init(viewModel: ScheduleViewModel, mode: Mode) {
        self.viewModel = viewModel
        self.mode = mode
        
        switch mode {
        case .add:
            _subject = State(initialValue: "")
            _location = State(initialValue: "")
            _day = State(initialValue: "")
            _startTime = State(initialValue: Date())
            _endTime = State(initialValue: Date())
        case .edit(let schedule):
            _subject = State(initialValue: schedule.subject)
            _location = State(initialValue: schedule.location)
            _day = State(initialValue: schedule.day)
            _startTime = State(initialValue: schedule.startTime)
            _endTime = State(initialValue: schedule.endTime)
        }
    }
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Subject", text: $subject)
                TextField("Location", text: $location)
                TextField("Day", text: $day)
                DatePicker("Start Time", selection: $startTime, displayedComponents: .hourAndMinute)
                DatePicker("End Time", selection: $endTime, displayedComponents: .hourAndMinute)
            }
            .navigationTitle(mode == .add ? "Tambah Jadwal" : "Edit Jadwal")
            .navigationBarItems(leading: Button("Cancel") {
                presentationMode.wrappedValue.dismiss()
            }, trailing: Button("Save") {
                saveSchedule()
            })
        }
    }
    
    private func saveSchedule() {
        Task {
            switch mode {
            case .add:
                let newSchedule = Schedule(subject: subject, location: location, day: day, startTime: startTime, endTime: endTime)
                await viewModel.addSchedule(newSchedule)
            case .edit(let schedule):
                schedule.subject = subject
                schedule.location = location
                schedule.day = day
                schedule.startTime = startTime
                schedule.endTime = endTime
                await viewModel.updateSchedule(schedule)
            }
            presentationMode.wrappedValue.dismiss()
        }
    }
}


