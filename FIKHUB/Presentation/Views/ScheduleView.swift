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

    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.sortedDays, id: \.self) { day in
                    if let schedules = viewModel.schedulesByDay[day], !schedules.isEmpty {
                        Section(header: Text(day).foregroundStyle(.primaryOrange)) {
                            ForEach(schedules) { schedule in
                                ScheduleRow(schedule: schedule)
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
            .navigationTitle("Jadwal")
            .navigationBarItems(trailing: Button(action: {
                isAddingSchedule = true
            }) {
                Image(systemName: "plus")
            })
            .onAppear {
                Task {
                    await viewModel.loadSchedules()
                }
            }
            .sheet(isPresented: $isAddingSchedule) {
                EditScheduleView(viewModel: viewModel, profileViewModel: profileViewModel, mode: .add)
            }
            .sheet(item: $editingSchedule) { schedule in
                EditScheduleView(viewModel: viewModel, profileViewModel: profileViewModel, mode: .edit(schedule))
            }
            .alert("Hapus Jadwal", isPresented: $showingDeleteAlert, presenting: scheduleToDelete) { schedule in
                Button("Batal", role: .cancel) {}
                Button("Hapus", role: .destructive) {
                    Task {
                        await viewModel.deleteSchedule(schedule)
                    }
                }
            } message: { schedule in
                Text("Apakah Anda yakin ingin menghapus jadwal ini?")
            }
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
                Text(formatTime(schedule.startTime))
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
