//
//  MessagesView.swift
//  Commiserate
//
//  Created by Zeynep Toy on 24.03.2024.
//

import SwiftUI


struct MessagesView: View {
    @StateObject var messagesViewModel = MessagesViewModel()
    @State var isDetailsActive = false
    @State var selectedUserId = ""
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                if !messagesViewModel.messages.isEmpty {
                    ForEach(messagesViewModel.messages, id: \.id) { message in
                        HStack {
                            ImageFromUrl(url: message.userProfileURL ?? "")
                                .frame(width: 50, height: 50)
                            VStack {
                                Text(message.fromUser ?? "")
                                    .font(.headline)
                                Text(message.text ?? "")
                                    .font(.title)
                            }
                        }
                        .onTapGesture {
                            isDetailsActive = true
                            selectedUserId = message.toId ?? ""
                        }
                        
                    }
                } else {
                    Text("Mesaj yok")
                }
            }
        }
        .frame(maxWidth: .infinity)
        
        NavigationLink(destination: MessageView( userId: selectedUserId), isActive: $isDetailsActive) {
            EmptyView()
        }
    }
}
#Preview {
    MessagesView()
}
