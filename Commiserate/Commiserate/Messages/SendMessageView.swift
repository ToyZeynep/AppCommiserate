//
//  SendMessageView.swift
//  Commiserate
//
//  Created by Zeynep Toy on 24.03.2024.
//

import SwiftUI
import Firebase
import FirebaseDatabaseInternal

struct SendMessageView: View {
    @StateObject var messagesViewModel: MessagesViewModel = MessagesViewModel()
    var user: User
    var body: some View {
        Button{
            let uid = Auth.auth().currentUser?.uid ?? ""
            messagesViewModel.sendMessages(userId: user.id ?? "")
        } label: {
            Text(user.name ?? "olmadı")
        }
    }
}

#Preview {
    SendMessageView(user: User(name: "", email: "", profileImageURL: "", id: ""))
}
