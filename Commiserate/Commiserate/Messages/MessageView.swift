//
//  MessageView.swift
//  Commiserate
//
//  Created by Zeynep Toy on 24.03.2024.
//

import SwiftUI

struct MessageView: View {
    @StateObject var messagesViewModel = MessagesViewModel()
    @State private var newMessage: String = ""
    @State var messages: [Message] = []
    var userId: String
    var body: some View {
        VStack {
            List(messages) { message in
                MessageRow(message: message)
            }
            
            HStack {
                TextField("Mesajınızı yazın", text: $newMessage)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)
                
                Button(action: sendMessage) {
                    Text("Gönder")
                }
                .padding(.trailing)
            }
            .padding(.bottom)
        }
        .navigationTitle("Sohbet")
    }
    
    func sendMessage() {
        guard !newMessage.isEmpty else { return }
        messagesViewModel.sendMessages(userId: userId)
        newMessage = ""
    }
}

struct MessageRow: View {
    let message: Message
    
    var body: some View {
        HStack {
            if message.fromId == "skQ95l36sLfElcTpEEonEXXAS2W2" {
                Spacer()
                Text(message.text ?? "")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            } else {
                Text(message.text ?? "")
                    .padding()
                    .background(Color.gray)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                Spacer()
            }
        }
    }
}

#Preview {
    MessageView(messages: [], userId: "")
}
