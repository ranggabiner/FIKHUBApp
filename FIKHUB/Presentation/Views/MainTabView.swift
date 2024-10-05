//
//  MainTabView.swift
//  FIKHUB
//
//  Created by Rangga Biner on 05/10/24.
//

import SwiftUI

struct MainTabView: View {
    @State private var selectedTab: Int = 0
    let student: Student
    
    var body: some View {
        TabView (selection: $selectedTab) {
            VStack(alignment: .leading, spacing: 10) {
                Text("Name \(student.name)")
                Text("Major \(student.major)")
                Text("Semester\(student.semester)")
            }
        }
        
        
    }
}

