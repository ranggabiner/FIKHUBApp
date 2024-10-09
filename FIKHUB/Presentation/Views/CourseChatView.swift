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
        ScrollViewReader { proxy in
            ScrollView {
                VStack {
                    ForEach(viewModel.messages) { message in
                        ChatBubble(message: message)
                            .id(message.id)
                    }
                }
            }
            .padding()
            .onChange(of: viewModel.messages) { _ in
                if let lastMessage = viewModel.messages.last {
                    withAnimation {
                        proxy.scrollTo(lastMessage.id, anchor: .bottom)
                    }
                }
            }
            .onAppear {
                if let lastMessage = viewModel.messages.last {
                    proxy.scrollTo(lastMessage.id, anchor: .bottom)
                }
            }
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
}

