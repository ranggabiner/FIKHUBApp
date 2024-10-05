//
//  OnboardingPageView.swift
//  FIKHUB
//
//  Created by Rangga Biner on 05/10/24.
//

import SwiftUI

struct OnboardingPageView: View {
    let image: String
    let title: String
    let description: String
    
    var body: some View {
        VStack {
            Image(systemName: image)
                .font(.system(size: 69))
                .foregroundStyle(.primaryOrange)
                .padding(.bottom, 28)
            Text(title)
                .fontWeight(.semibold)
                .font(.system(size: 27))
                .multilineTextAlignment(.center)
                .padding(.bottom, 8)
            Text(description)
                .font(.system(size: 19))
                .multilineTextAlignment(.center)
        }
        .padding(.horizontal, 19)
    }
}

#Preview {
    OnboardingPageView(image: "text.bubble.fill", title: "Selamat datang di FIK HUB", description: "Solusi cerdas, efisien, dan andal bagi mahasiswa untuk meraih prestasi akademik")
}

