//
//  RegisterViewModel.swift
//  Commiserate
//
//  Created by Zeynep Toy on 23.03.2024.
//

import Foundation
import Firebase
import FirebaseDatabaseInternal

final class RegisterViewModel: ObservableObject {
    
    func handleRegister(email: String, password: String, name: String) {
        
        Auth.auth().createUser(withEmail: email, password: password) { user, error in
            if error != nil {
                print(error ?? "")
            } else {
                guard let uid = user?.user.uid else {return}
                let ref = Database.database().reference(fromURL: "https://commiserate-9213e-default-rtdb.firebaseio.com")
                let usersReference = ref.child("users").child(uid)
                let values = ["name": name, "email": email ]
                usersReference.updateChildValues(values) { error, ref in
                    if error != nil {
                        print(error)
                    } else {
                        print("saved user successfully!")
                    }
                }
            }
        }
    }
}
