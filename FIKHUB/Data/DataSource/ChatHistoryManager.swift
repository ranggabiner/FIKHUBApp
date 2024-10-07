//
//  ChatHistoryManager.swift
//  FIKHUB
//
//  Created by Rangga Biner on 06/10/24.
//

import Foundation

class ChatHistoryManager {
    private let fileManager = FileManager.default
    private let documentsDirectory: URL
    
    init() {
        documentsDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
    
    func saveChatHistory(_ messages: [ChatMessage], for courseId: String) {
        let fileURL = documentsDirectory.appendingPathComponent("\(courseId)_chat_history.json")
        
        do {
            let data = try JSONEncoder().encode(messages)
            try data.write(to: fileURL)
        } catch {
            print("Error saving chat history: \(error)")
        }
    }
    
    func loadChatHistory(for courseId: String) -> [ChatMessage] {
        let fileURL = documentsDirectory.appendingPathComponent("\(courseId)_chat_history.json")
        
        guard fileManager.fileExists(atPath: fileURL.path) else {
            return []
        }
        
        do {
            let data = try Data(contentsOf: fileURL)
            let messages = try JSONDecoder().decode([ChatMessage].self, from: data)
            return messages
        } catch {
            print("Error loading chat history: \(error)")
            return []
        }
    }
    
    func deleteChatHistory(for courseId: String) {
        let fileURL = documentsDirectory.appendingPathComponent("\(courseId)_chat_history.json")
        
        do {
            try fileManager.removeItem(at: fileURL)
            print("Chat history deleted successfully for course: \(courseId)")
        } catch {
            print("Error deleting chat history: \(error)")
        }
    }
}
