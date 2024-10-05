//
//  OnboardingInputView.swift
//  FIKHUB
//
//  Created by Rangga Biner on 05/10/24.
//

import SwiftUI

struct OnboardingInputView: View {
    @ObservedObject var viewModel: OnboardingInputViewModel
    @Binding var hasSeenOnboarding: Bool
    @State private var name: String = ""
    @State private var major: String = ""
    @State private var semester: Int = 1

    var body: some View {
        Form {
            Section(header: Text("Student Information")) {
                TextField("Name", text: $name)
                TextField("Major", text: $major)
                Stepper("Semester: \(semester)", value: $semester, in: 1...8)
            }
            
            Section {
                Button {
                    saveAndContinue()

                } label: {
                    Text("Lanjutkan")
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(.primaryOrange)
                        .cornerRadius(10)
                }
            }
        }
        .safeAreaPadding(19)
        
    }
    
    private func saveAndContinue() {
        Task {
            let newStudent = Student(name: name, major: major, semester: semester)
            await viewModel.addStudent(newStudent)
            hasSeenOnboarding = true
            print(newStudent.name, newStudent.major, newStudent.semester)
        }
    }
}
