//
//  MainTabView.swift
//  FIKHUB
//
//  Created by Rangga Biner on 05/10/24.
//

import SwiftUI

struct MainTabView: View {
    @State private var selectedTab: Int = 0
    @ObservedObject var profileViewModel: EditProfileViewModel
    let scheduleUseCase: ScheduleUseCase
    let student: Student
    
    var body: some View {
        TabView(selection: $selectedTab) {
            ScheduleView(viewModel: scheduleViewModel, profileViewModel: profileViewModel, currentStudent: student)
                .tabItem {
                    Label("Schedule", systemImage: "calendar")
                }
                .tag(0)
            
            EditProfileView(viewModel: profileViewModel)
                .tabItem {
                    Label("Profile", systemImage: "person.crop.circle.fill")
                }
                .tag(1)
        }
    }
    
    private var scheduleViewModel: ScheduleViewModel {
        ScheduleViewModel(scheduleUseCase: scheduleUseCase, currentStudent: student)
    }
}
