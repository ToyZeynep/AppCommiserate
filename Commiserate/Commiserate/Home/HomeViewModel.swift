//
//  HomeViewModel.swift
//  Commiserate
//
//  Created by Zeynep Toy on 23.03.2024.
//

import Foundation
import Firebase
import FirebaseDatabaseInternal

final class HomeViewModel: ObservableObject {
    @Published var users: [User] = []
    
    init() {
        fetchUsers()
    }

    func fetchUsers() {
        Database.database().reference().child("users").observe(.childAdded) { (snapshot) in
            if let dictionary = snapshot.value as? [String: AnyObject] {
              var user = User()
                user.name = dictionary["name"] as? String
                user.email = dictionary["email"] as? String
                self.users.append(user)
            }
        }
    }
}
