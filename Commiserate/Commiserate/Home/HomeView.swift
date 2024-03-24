//
//  HomeView.swift
//  Commiserate
//
//  Created by Zeynep Toy on 23.03.2024.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var homeViewModel: HomeViewModel = HomeViewModel()
    @State var isMessagesActive = false
    @State var selectedUser: User
    
    var body: some View {
        NavigationView {
            VStack {
                if !homeViewModel.users.isEmpty {
                    ForEach(homeViewModel.users, id: \.id) { user in
                        Text(user.email ?? "Boş geldi")
                            .onTapGesture {
                                selectedUser = user
                                isMessagesActive = true
                            }
                    }
                }
            }
            .navigationTitle("Home")
            .background(
                NavigationLink(destination: SendMessageView(user: selectedUser), isActive: $isMessagesActive) {
                    EmptyView()
                }
            )
        }
    }
}


#Preview {
    HomeView(selectedUser: User(name: "", email: "", profileImageURL: "", id: ""))
}
