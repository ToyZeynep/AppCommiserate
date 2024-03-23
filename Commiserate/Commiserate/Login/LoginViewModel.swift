//
//  LoginViewModel.swift
//  Commiserate
//
//  Created by Zeynep Toy on 23.03.2024.
//

import Foundation
import Firebase
import FirebaseDatabaseInternal

final class LoginViewModel: ObservableObject {
    
    func handleLogin(email: String, password: String) {
        
        Auth.auth().signIn(withEmail: email, password: password) { user, error in
            if error != nil {
                print(error ?? "")
            } else {
                self.loggedIn()
            }
        }
    }
    
    func logout() {
        if Auth.auth().currentUser?.uid == nil {
            do {
                try Auth.auth().signOut()
            } catch let logOutError {
                print(logOutError)
            }
        }
    }
    
    func loggedIn() {
        if let uid = Auth.auth().currentUser?.uid {
            Database.database().reference().child("users").child(uid).observeSingleEvent(of: .value) { (snapshot) in
                print(snapshot)
                if let dictionary = snapshot.value as? [String: AnyObject] {
                    if let name = dictionary["name"] {
                        print( name)
                    }
                }
            }
        }
    }
}
