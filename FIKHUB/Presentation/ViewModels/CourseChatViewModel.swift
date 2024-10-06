//
//  CourseChatViewModel.swift
//  FIKHUB
//
//  Created by Rangga Biner on 06/10/24.
//
import Foundation
import OpenAI

class CourseViewModel: ObservableObject {
    @Published var messages: [ChatMessage] = []
    @Published var isTyping: Bool = false
    
    private let openAI = OpenAI(apiToken: "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")
    private let course: String
    private let detail: String
    private let currentStudent: Student
    private let chatHistoryManager = ChatHistoryManager()

    init(course: String, detail: String, currentStudent: Student) {
        self.course = course
        self.detail = detail
        self.currentStudent = currentStudent
        loadChatHistory()
    }

    private func loadChatHistory() {
        messages = chatHistoryManager.loadChatHistory(for: course)
        if messages.isEmpty {
            addInitialBotMessage()
        }
    }
    
    func sendMessage(_ userMessage: String) {
        let message = ChatMessage(content: userMessage, isUser: true)
        messages.append(message)
        
        isTyping = true
        getAIReply(userMessage: userMessage)
        
        saveChatHistory()
    }

    private func getAIReply(userMessage: String) {
        let systemPrompt = """
        Anda adalah chatbot edukasi yang menjelaskan materi \(course) secara ringkas dan bertahap kepada \(currentStudent.name). Berikan penjelasan singkat (maksimal 2-3 kalimat) untuk setiap topik. Setelah setiap penjelasan, tanyakan apakah \(currentStudent.name) sudah paham atau perlu penjelasan lebih lanjut. Jika paham, lanjutkan ke topik berikutnya. Jika tidak, berikan penjelasan tambahan yang singkat atau contoh sederhana. Berikan nada chat terkesan ekspresif dan asik.

        Mulailah dengan menjelaskan secara singkat kepada \(currentStudent.name): \(detail)
        """
        var combinedMessages = [ChatMessage(content: systemPrompt, isUser: false)] + messages
        
        let query = ChatQuery(
            messages: combinedMessages.map({ .init(role: $0.isUser ? .user : .system, content: $0.content)! }),
            model: .gpt4_o_mini
        )
        
        openAI.chats(query: query) { [weak self] result in
            DispatchQueue.main.async {
                self?.isTyping = false
                
                switch result {
                case .success(let success):
                    guard let choice = success.choices.first,
                          let message = choice.message.content?.string else { return }
                    let botMessage = ChatMessage(content: message, isUser: false)
                    self?.messages.append(botMessage)
                    self?.saveChatHistory()
                case .failure(let failure):
                    print("AI Reply Error: \(failure)")
                    let errorMessage = ChatMessage(content: "Sorry, I couldn't process your request. Please try again.", isUser: false)
                    self?.messages.append(errorMessage)
                    self?.saveChatHistory()
                }
            }
        }

    }
    
    func addInitialBotMessage() {
        let initialMessage = """
        Halo \(currentStudent.name)! Selamat datang di kelas \(course)! 🎉

        Hari ini kita akan menjelajahi dunia \(course) bersama. Saya akan memandu Anda melalui konsep-konsep penting.

        Siap untuk memulai? Katakan 'Ayo mulai!'
        """
        messages.append(ChatMessage(content: initialMessage, isUser: false))
    }
    
    private func saveChatHistory() {
        chatHistoryManager.saveChatHistory(messages, for: course)
    }
    
    func clearChatHistory() {
        messages.removeAll()
        chatHistoryManager.deleteChatHistory(for: course)
        addInitialBotMessage()
    }


}
