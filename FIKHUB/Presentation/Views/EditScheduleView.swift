//
//  EditScheduleView.swift
//  FIKHUB
//
//  Created by Rangga Biner on 06/10/24.
//

import SwiftUI

struct EditScheduleView: View {
    @ObservedObject var viewModel: ScheduleViewModel
    @ObservedObject var profileViewModel: EditProfileViewModel
    @Environment(\.presentationMode) var presentationMode
    @State private var subject = ""
    @State private var location = ""
    @State private var day = ""
    @State private var startTime: Date
    @State private var endTime: Date
    @State private var isSelectingCourse = false

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
    
    init(viewModel: ScheduleViewModel, profileViewModel: EditProfileViewModel, mode: Mode) {
        self.viewModel = viewModel
        self.profileViewModel = profileViewModel
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
                Button(action: {
                    isSelectingCourse = true
                }) {
                    HStack {
                        Text("Mata Kuliah")
                        Spacer()
                        Text(subject.isEmpty ? "Pilih Mata Kuliah" : subject)
                            .foregroundColor(subject.isEmpty ? .gray : .primary)
                    }
                }
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
            .sheet(isPresented: $isSelectingCourse) {
                SubjectView(selectedCourse: $subject, studentMajor: profileViewModel.currentStudent.major)
            }
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


