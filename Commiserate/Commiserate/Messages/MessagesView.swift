//
//  MessagesView.swift
//  Commiserate
//
//  Created by Zeynep Toy on 24.03.2024.
//

import SwiftUI


struct MessagesView: View {
    @ObservedObject var messagesViewModel: MessagesViewModel = MessagesViewModel()
    var body: some View {
        VStack {
            if !messagesViewModel.messages.isEmpty {
                ForEach(messagesViewModel.messages, id: \.id) { message in
                    Text(message.text ?? "Boş geldi")
                }
            }
        }
    }
}

#Preview {
    MessagesView()
}
