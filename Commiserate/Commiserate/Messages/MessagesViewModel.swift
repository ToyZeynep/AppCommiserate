//
//  MessagesViewModel.swift
//  Commiserate
//
//  Created by Zeynep Toy on 24.03.2024.
//

import Foundation
import Firebase
import FirebaseDatabaseInternal

final class MessagesViewModel: ObservableObject {
    @Published var messages: [Message] = []

    init() {
        observeMessages()
    }
    
    func sendMessages(userId: String , fromId: String) {
        let ref = Database.database().reference().child("messages")
        let childRef = ref.childByAutoId()
        let timestamp: NSNumber = Int(Date().timeIntervalSince1970) as NSNumber
        let values = ["text": "Mesaj", "toId": userId, "fromId": fromId, "timestamp": timestamp] as [String : Any]
        childRef.updateChildValues(values)
    }
    
    func observeMessages() {
        let ref = Database.database().reference().child("messages")
        ref.observe(.childAdded) { snapshot, _ in
            if let dictionary = snapshot.value as? [String: AnyObject] {
                var message = Message()
                message.fromId = dictionary["fromId"] as? String
                message.toId = dictionary["toId"] as? String
                message.timestamp = dictionary["timestamp"] as? NSNumber
                message.text = dictionary["text"] as? String
                self.messages.append(message)
            }
        }
    }
}
