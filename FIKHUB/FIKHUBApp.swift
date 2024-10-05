//
//  FIKHUBApp.swift
//  FIKHUB
//
//  Created by Rangga Biner on 05/10/24.
//

import SwiftUI

@main
struct FIKHUBApp: App {
    @AppStorage("hasSeenOnboarding") private var hasSeenOnboarding = false

    var body: some Scene {
        WindowGroup {
            if hasSeenOnboarding {
                MainTabView()
            } else {
                OnboardingView(hasSeenOnboarding: $hasSeenOnboarding)
            }
        }
    }
}
