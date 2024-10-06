//
//  FIKHUBApp.swift
//  FIKHUB
//
//  Created by Rangga Biner on 05/10/24.
//
import SwiftUI
import SwiftData

@main
struct FIKHUBApp: App {
    @AppStorage("hasSeenOnboarding") private var hasSeenOnboarding = false
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Student.self)
    }
}

struct ContentView: View {
    @AppStorage("hasSeenOnboarding") private var hasSeenOnboarding = false
    @Environment(\.modelContext) private var modelContext
    @Query private var students: [Student]
    
    var body: some View {
        if hasSeenOnboarding {
            if let student = students.first {
                MainTabView(viewModel: createProfileViewModel(for: student), student: student)
            } else {
                Text("No student data available")
            }
        } else {
            OnboardingView(
                onboardingInputViewModel: createOnboardingViewModel(),
                hasSeenOnboarding: $hasSeenOnboarding
            )
        }
    }
    
    private func createOnboardingViewModel() -> OnboardingInputViewModel {
        let studentDataSource = StudentDataSourceImpl(context: modelContext)
        let studentRepository = StudentRepositoryImpl(dataSource: studentDataSource)
        let studentUseCase = StudentUseCaseImpl(repository: studentRepository)
        return OnboardingInputViewModel(studentUseCases: studentUseCase)
    }
    
    private func createProfileViewModel(for student: Student) -> EditProfileViewModel {
        let studentDataSource = StudentDataSourceImpl(context: modelContext)
        let studentRepository = StudentRepositoryImpl(dataSource: studentDataSource)
        let studentUseCase = StudentUseCaseImpl(repository: studentRepository)
        return EditProfileViewModel(studentUseCases: studentUseCase, student: student)
    }

}
