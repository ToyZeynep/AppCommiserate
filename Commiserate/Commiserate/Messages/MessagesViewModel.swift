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
    @Published var user: User?
    init() {
        observeMessages()
    }
    
    func sendMessages(userId: String) {
        let uid = Auth.auth().currentUser?.uid ?? ""
        let ref = Database.database().reference().child("messages")
        let childRef = ref.childByAutoId()
        let timestamp: NSNumber = Int(Date().timeIntervalSince1970) as NSNumber
        let values = ["text": "Mesaj", "toId": userId, "fromId": uid, "timestamp": timestamp] as [String : Any]
        childRef.updateChildValues(values)
    }
    
    // bütün mesajları çektik
    func observeMessages() {
        let ref = Database.database().reference().child("messages")
        ref.observe(.childAdded) { snapshot, _ in
            if let dictionary = snapshot.value as? [String: AnyObject] {
                var message = Message()
                message.fromId = dictionary["fromId"] as? String
                message.toId = dictionary["toId"] as? String
                message.timestamp = dictionary["timestamp"] as? NSNumber
                message.text = dictionary["text"] as? String
                
                print(dictionary["toId"] as? String)
                self.getUserMessage(toId: dictionary["toId"] as! String ?? "") { result in
                    switch result {
                    case .success(let user):
                        message.userProfileURL = user.profileImageURL
                        message.fromUser = user.name
                        self.messages.append(message)
                    case .failure(let error):
                        print("Hata: \(error)")
                    }
                }
            }
        }
    }

    // listede isim altında mesaj göstermek için kullanılabilir
    func getUserMessage(toId: String?, completionHandler: @escaping (Result<User,Error>) -> Void){
        var user = User()
        if let toId = toId {
            print(toId)
            let ref = Database.database().reference().child("users").child(toId)
            ref.observeSingleEvent(of: .value) { snapshot in
                if let dictionary = snapshot.value as? [String: AnyObject] {
                    user.name = dictionary["name"] as? String
                    user.profileImageURL = dictionary["profileImageURL"] as? String
                    completionHandler(.success(user))
                } else {
                    let error = NSError(domain: "MyApp", code: 100, userInfo: [NSLocalizedDescriptionKey: "Kullanıcı bilgileri alınamadı"])
                    completionHandler(.failure(error))
                }
            }
        }
    }
}
