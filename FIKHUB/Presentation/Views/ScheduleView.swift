//
//  ScheduleView.swift
//  FIKHUB
//
//  Created by Rangga Biner on 06/10/24.
//

import SwiftUI

struct ScheduleView: View {
    @StateObject var viewModel: ScheduleViewModel
    @StateObject var profileViewModel: EditProfileViewModel
    @State private var isAddingSchedule = false
    @State private var editingSchedule: Schedule?
    @State private var showingDeleteAlert = false
    @State private var scheduleToDelete: Schedule?
    @State private var selectedSchedule: Schedule?
    @State private var showingCourseMeeting = false
    @State private var sheetRefreshToggle = false
    let currentStudent: Student

    var body: some View {
        NavigationView {
            ScheduleList(
                viewModel: viewModel,
                editingSchedule: $editingSchedule,
                showingDeleteAlert: $showingDeleteAlert,
                scheduleToDelete: $scheduleToDelete,
                selectedSchedule: $selectedSchedule
            )
            .navigationTitle("Jadwal")
            .navigationBarItems(trailing: addButton)
            .onAppear(perform: loadSchedules)
            .sheet(isPresented: $isAddingSchedule) {
                EditScheduleView(viewModel: viewModel, profileViewModel: profileViewModel, mode: .add)
            }
            .sheet(item: $editingSchedule) { schedule in
                EditScheduleView(viewModel: viewModel, profileViewModel: profileViewModel, mode: .edit(schedule))
            }
            .sheet(isPresented: $showingCourseMeeting, onDismiss: { selectedSchedule = nil }) {
                CourseMeetingSheet(
                    selectedSchedule: selectedSchedule,
                    currentStudent: currentStudent,  // Add this line
                    sheetRefreshToggle: $sheetRefreshToggle
                )
            }
            .alert("Hapus Jadwal", isPresented: $showingDeleteAlert, presenting: scheduleToDelete, actions: deleteAlert, message: deleteAlertMessage)
            .onChange(of: selectedSchedule) { newValue in
                if newValue != nil {
                    showingCourseMeeting = true
                    sheetRefreshToggle.toggle()
                }
            }
        }
    }

    private var addButton: some View {
        Button(action: { isAddingSchedule = true }) {
            Image(systemName: "plus")
        }
    }

    private func loadSchedules() {
        Task {
            await viewModel.loadSchedules()
        }
    }

    private func deleteAlert(_ schedule: Schedule) -> some View {
        Group {
            Button("Batal", role: .cancel) {}
            Button("Hapus", role: .destructive) {
                Task {
                    await viewModel.deleteSchedule(schedule)
                }
            }
        }
    }

    private func deleteAlertMessage(_ schedule: Schedule) -> some View {
        Text("Apakah Anda yakin ingin menghapus jadwal ini?")
    }
}

struct ScheduleList: View {
    @ObservedObject var viewModel: ScheduleViewModel
    @Binding var editingSchedule: Schedule?
    @Binding var showingDeleteAlert: Bool
    @Binding var scheduleToDelete: Schedule?
    @Binding var selectedSchedule: Schedule?

    var body: some View {
        List {
            ForEach(viewModel.sortedDays, id: \.self) { day in
                if let schedules = viewModel.schedulesByDay[day], !schedules.isEmpty {
                    Section(header: Text(day).foregroundStyle(.primaryOrange)) {
                        ForEach(schedules) { schedule in
                            ScheduleRow(schedule: schedule)
                                .contentShape(Rectangle())
                                .onTapGesture {
                                    selectedSchedule = schedule
                                }
                                .contextMenu {
                                    Button("Edit") {
                                        editingSchedule = schedule
                                    }
                                    Button("Hapus", role: .destructive) {
                                        scheduleToDelete = schedule
                                        showingDeleteAlert = true
                                    }
                                }
                        }
                    }
                }
            }
        }
    }
}

struct CourseMeetingSheet: View {
    let selectedSchedule: Schedule?
    let currentStudent: Student
    @Binding var sheetRefreshToggle: Bool

    var body: some View {
        if let schedule = selectedSchedule {
            CourseMeetingView(studentSubject: schedule.subject, currentStudent: currentStudent)
                .id(sheetRefreshToggle)
        } else {
            Text("No schedule selected")
        }
    }
}

struct ScheduleRow: View {
    let schedule: Schedule
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(schedule.subject)
                    .font(.system(size: 17))
                    .fontWeight(.semibold)
                Spacer()
                Text(formatTime(schedule.startTime))
                    .font(.system(size: 15))
            }
            HStack {
                Image(systemName: "mappin.and.ellipse")
                Text(schedule.location)
                Spacer()
                Text(formatTime(schedule.endTime))
            }
            .foregroundStyle(.secondary)
            .font(.system(size: 15))
        }
        .padding(.vertical, 4)
    }
    
    private func formatTime(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
}
