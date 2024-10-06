import SwiftUI

struct CourseChatView: View {
    let course: String
    let detail: String
    let currentStudent: Student
    
    @StateObject private var viewModel: CourseViewModel
    @State private var newMessage: String = ""
    init(course: String, detail: String, currentStudent: Student) {
        self.course = course
        self.detail = detail
        self.currentStudent = currentStudent
        _viewModel = StateObject(wrappedValue: CourseViewModel(course: course, detail: detail, currentStudent: currentStudent))
    }

    var body: some View {
        VStack {
            ScrollView {
                ScrollViewReader { proxy in
                    LazyVStack(spacing: 10) {
                        ForEach(viewModel.messages) { message in
                            ChatBubble(message: message)
                        }
                    }
                    .onChange(of: viewModel.messages) { _ in
                        withAnimation {
                            proxy.scrollTo(viewModel.messages.last?.id, anchor: .bottom)
                        }
                    }
                }
                .padding()
            }
            
            HStack {
                TextField("Ketik pesan...", text: $newMessage)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .disabled(viewModel.isTyping)
                
                Button(action: sendMessage) {
                    Image(systemName: "paperplane.fill")
                }
                .disabled(newMessage.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || viewModel.isTyping)
            }
            .padding()
        }
        .navigationTitle(course)
        .onAppear {
            viewModel.addInitialBotMessage()
        }
        .background(Color(.systemGroupedBackground)) // Menggunakan warna default form list
    }
    
    private func sendMessage() {
        let userMessage = newMessage.trimmingCharacters(in: .whitespacesAndNewlines)
        viewModel.sendMessage(userMessage)
        newMessage = ""
    }
}
