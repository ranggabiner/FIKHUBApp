//
//  ChatBubble.swift
//  FIKHUB
//
//  Created by Rangga Biner on 06/10/24.
//

import SwiftUI

struct ChatBubble: View {
    let message: ChatMessage

    var body: some View {
        HStack {
            if message.isUser {
                Spacer()
            }
            Text(message.content)
                .padding(10)
                .background(message.isUser ? Color.orange : Color(.white))
                .foregroundColor(message.isUser ? .black : .black)
                .cornerRadius(10)
            if !message.isUser {
                Spacer()
            }
        }
    }
}