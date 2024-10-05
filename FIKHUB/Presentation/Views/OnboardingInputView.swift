//
//  OnboardingInputView.swift
//  FIKHUB
//
//  Created by Rangga Biner on 05/10/24.
//

import SwiftUI

struct OnboardingInputView: View {
    @Binding var hasSeenOnboarding: Bool

    var body: some View {
        VStack {
            Text("INPUT VIEW!")
            Spacer()
            Button {
                hasSeenOnboarding = true
            } label: {
                Text("Lanjutkan")
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(.primaryOrange)
                    .cornerRadius(10)
            }
        }
        .safeAreaPadding(19)
        
    }
}

#Preview {
    OnboardingInputView(hasSeenOnboarding: .constant(false))
}
