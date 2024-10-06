import SwiftUI

struct CourseChatView: View {
    let course: String
    let detail: String
    let currentStudent: Student
    
    @StateObject private var viewModel: CourseViewModel
    @State private var newMessage: String = ""
    @State private var showingDeleteAlert = false
    
    init(course: String, detail: String, currentStudent: Student) {
        self.course = course
        self.detail = detail
        self.currentStudent = currentStudent
        _viewModel = StateObject(wrappedValue: CourseViewModel(course: course, detail: detail, currentStudent: currentStudent))
    }

    var body: some View {
        VStack {
            chatScrollView
            messageInputView
        }
        .navigationTitle(course)
        .background(Color(.systemGroupedBackground))
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                deleteButton
            }
        }
        .alert("Hapus Riwayat", isPresented: $showingDeleteAlert, actions: deleteAlert, message: deleteAlertMessage)
    }
    
    private var chatScrollView: some View {
        ScrollView {
            ScrollViewReader { proxy in
                LazyVStack(spacing: 10) {
                    ForEach(viewModel.messages) { message in
                        ChatBubble(message: message)
                    }
                }
                .onChange(of: viewModel.messages) { _ in
                    scrollToBottom(proxy: proxy)
                }
            }
            .padding()
        }
    }
    
    private var messageInputView: some View {
        HStack {
            TextField("Ketik pesan...", text: $newMessage)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .disabled(viewModel.isTyping)
            
            Button(action: sendMessage) {
                Image(systemName: "paperplane.fill")
            }
            .disabled(isMessageEmpty || viewModel.isTyping)
        }
        .padding()
    }
    
    private var deleteButton: some View {
        Button {
            showingDeleteAlert = true
        } label: {
            Image(systemName: "trash")
        }
    }
    
    private var isMessageEmpty: Bool {
        newMessage.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
    
    private func deleteAlert() -> some View {
        Group {
            Button("Batal", role: .cancel) {}
            Button("Hapus", role: .destructive) {
                viewModel.clearChatHistory()
            }
        }
    }

    private func deleteAlertMessage() -> some View {
        Text("Apakah Anda yakin ingin menghapus riwayat chat ini?")
    }

    private func sendMessage() {
        let userMessage = newMessage.trimmingCharacters(in: .whitespacesAndNewlines)
        viewModel.sendMessage(userMessage)
        newMessage = ""
    }
    
    private func scrollToBottom(proxy: ScrollViewProxy) {
        withAnimation {
            proxy.scrollTo(viewModel.messages.last?.id, anchor: .bottom)
        }
    }
}
