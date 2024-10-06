//
//  MainTabView.swift
//  FIKHUB
//
//  Created by Rangga Biner on 05/10/24.
//

import SwiftUI

struct MainTabView: View {
    @State private var selectedTab: Int = 0
    @ObservedObject var viewModel: EditProfileViewModel
    let student: Student
    
    var body: some View {
        TabView (selection: $selectedTab) {
            ScheduleView()
                .tabItem {
                    Label("Schedule", systemImage: "calendar")
                }
                .tag(0)
            
            EditProfileView(viewModel: viewModel)
                .tabItem {
                    Label("Profile", systemImage: "person.crop.circle.fill")
                }
                .tag(1)
        }
    }
}

