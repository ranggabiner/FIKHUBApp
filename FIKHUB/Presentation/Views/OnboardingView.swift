//
//  OnboardingView.swift
//  FIKHUB
//
//  Created by Rangga Biner on 05/10/24.
//

import SwiftUI

struct OnboardingView: View {
    @ObservedObject var onboardingInputViewModel: OnboardingInputViewModel
    @State private var currentPage = 0
    let totalPages = 4
    @Binding var hasSeenOnboarding: Bool
    
    var body: some View {
        NavigationStack {
            GeometryReader { geometry in
                VStack {
                    TabView(selection: $currentPage) {
                        OnboardingPageView(
                            image: "graduationcap.fill",
                            title: "Selamat datang di FIK HUB",
                            description: "Asisten pintar untuk meningkatkan produktivitas dan prestasi akademikmu"
                        )                        .tag(0)
                        
                        OnboardingPageView(
                            image: "calendar.badge.clock",
                            title: "Atur Jadwal Kuliahmu",
                            description: "Buat dan kelola jadwal kuliah dengan mudah sesuai kebutuhanmu"
                        )                        .tag(1)
                        
                        OnboardingPageView(
                            image: "brain.head.profile",
                            title: "Asisten AI Pribadimu",
                            description: "Akses dan pelajari materi kuliah dengan bantuan chatbot AI yang cerdas"
                        )
                        .tag(2)
                        
                        OnboardingPageView(
                            image: "checkmark.circle.fill",
                            title: "Siap untuk Belajar Lebih Pintar?",
                            description: "Mulai perjalanan akademikmu yang efisien dan produktif bersama FIK HUB!"
                        )
                        .tag(3)
                    }
                    .tabViewStyle(PageTabViewStyle())
                    .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
                    
                    Spacer()
                    
                    if currentPage == totalPages - 1 {
                        NavigationLink(destination: OnboardingInputView(viewModel: onboardingInputViewModel, hasSeenOnboarding: $hasSeenOnboarding)) {
                            Text("Lanjutkan")
                                .foregroundColor(.white)
                                .frame(width: geometry.size.width * 0.8)
                                .padding()
                                .background(.primaryOrange)
                                .cornerRadius(10)
                        }
                        .padding(.bottom, 30)
                    } else {
                        Spacer().frame(height: 74)
                    }
                }
            }
        }
        .accentColor(.primaryOrange)
    }
}
