//
//  MainTabView.swift
//  FIKHUB
//
//  Created by Rangga Biner on 05/10/24.
//

import SwiftUI

struct MainTabView: View {
    @State private var selectedTab: Int = 0
    
    var body: some View {
        TabView (selection: $selectedTab) {
            Text("dhsaf")
        }
    }
}

#Preview {
    MainTabView()
}
