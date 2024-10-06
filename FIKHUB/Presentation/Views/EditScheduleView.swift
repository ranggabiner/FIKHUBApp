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
    @State private var isSelectingLocation = false
    private let days = ["Senin", "Selasa", "Rabu", "Kamis", "Jumat", "Sabtu", "Minggu"]
    
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
            _day = State(initialValue: "Senin")
            _startTime = State(initialValue: Date())
            _endTime = State(initialValue: Date())
        case .edit(let schedule):
            _subject = State(initialValue: schedule.subject)
            _location = State(initialValue: schedule.location)
            _day = State(initialValue: schedule.day.isEmpty ? "Senin" : schedule.day)
            _startTime = State(initialValue: schedule.startTime)
            _endTime = State(initialValue: schedule.endTime)
        }
    }
    

    var body: some View {
        NavigationView {
            Form {
                Section {
                    Button(action: {
                        isSelectingCourse = true
                    }) {
                        HStack {
                            Text(subject.isEmpty ? "Pilih Mata Kuliah" : subject)
                                .foregroundColor(.primaryOrange)
                        }
                    }

                }
                Section {
                    Picker("Hari", selection: $day) {
                        ForEach(days, id: \.self) { day in
                            Text(day).tag(day)
                        }
                    }
                }
                Section {
                    DatePicker("Mulai", selection: $startTime, displayedComponents: .hourAndMinute)
                    DatePicker("Selesai", selection: $endTime, displayedComponents: .hourAndMinute)

                }
                Section {
                    Button(action: {
                        isSelectingLocation = true
                    }) {
                        HStack {
                            Text(location.isEmpty ? "Pilih Lokasi" : location)
                                .foregroundColor(.primaryOrange)
                        }
                    }
                }
            }
            .navigationBarTitle(mode == .add ? "Tambah Jadwal" : "Edit Jadwal", displayMode: .inline)
            .navigationBarItems(leading: Button("Batal") {
                presentationMode.wrappedValue.dismiss()
            }, trailing: Button("Simpan") {
                saveSchedule()
            })
            .sheet(isPresented: $isSelectingCourse) {
                SubjectView(selectedCourse: $subject, studentMajor: profileViewModel.currentStudent.major)
            }
            .sheet(isPresented: $isSelectingLocation) {
                RoomLocationView(selectedLocation: $location)
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


