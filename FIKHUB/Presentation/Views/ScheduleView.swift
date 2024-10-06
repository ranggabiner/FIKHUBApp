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

    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.schedules) { schedule in
                    ScheduleRow(schedule: schedule)
                        .onTapGesture {
                            editingSchedule = schedule
                        }
                }
            }
            .navigationTitle("Schedules")
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
        }
    }
}

struct ScheduleRow: View {
    let schedule: Schedule
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(schedule.subject)
                .font(.headline)
            Text(schedule.location)
                .font(.subheadline)
            HStack {
                Text(schedule.day)
                Spacer()
                Text("\(formatTime(schedule.startTime)) - \(formatTime(schedule.endTime))")
            }
            .font(.caption)
        }
        .padding(.vertical, 4)
    }
    
    private func formatTime(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
}
