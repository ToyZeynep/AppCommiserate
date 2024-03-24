//
//  RegisterViewModel.swift
//  Commiserate
//
//  Created by Zeynep Toy on 23.03.2024.
//

import Foundation
import Firebase
import FirebaseDatabaseInternal
import FirebaseStorage

final class RegisterViewModel: ObservableObject {
    
    func handleRegister(email: String, password: String, name: String) {
        
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] user, error in
            guard let self = self else { return }
            
            if let error = error {
                print("Kullanıcı oluşturma hatası: \(error.localizedDescription)")
                return
            }
            
            guard let uid = user?.user.uid else {
                print("Kullanıcı UID alınamadı.")
                return
            }
            
            let imageName = UUID().uuidString
            let storageRef = Storage.storage().reference().child("images/\(imageName).png")
            
            if let url = URL(string: "https://i.pinimg.com/236x/17/f8/1e/17f81ec7203b785f31414948a451e731.jpg") {
                DispatchQueue.global().async {
                    if let imageData = try? Data(contentsOf: url) {
                        storageRef.putData(imageData, metadata: nil) { metadata, error in
                            if let error = error {
                                print("Resim yüklenirken hata oluştu: \(error.localizedDescription)")
                                return
                            }
                            
                            storageRef.downloadURL { (url, error) in
                                guard let downloadURL = url else {
                                    if let error = error {
                                        print("Dosyanın indirme URL'sini alma hatası: \(error.localizedDescription)")
                                    }
                                    return
                                }
                                
                                let values: [String: AnyObject] = [
                                    "name": name as AnyObject,
                                    "email": email as AnyObject,
                                    "profileImageURL": downloadURL.absoluteString as AnyObject
                                ]
                                
                                self.handleRegisterDatabase(uid: uid, values: values)
                            }
                        }
                    }
                }
            }
        }
    }
    
    func handleRegisterDatabase(uid: String, values: [String: AnyObject]) {
        let ref = Database.database().reference(fromURL: "https://commiserate-9213e-default-rtdb.firebaseio.com")
        let usersReference = ref.child("users").child(uid)
        usersReference.updateChildValues(values) { error, ref in
            if let error = error {
                print("Veritabanına yazma hatası: \(error.localizedDescription)")
            } else {
                print("Kullanıcı başarıyla kaydedildi.")
            }
        }
    }
}

