//
//  HomeView.swift
//  Commiserate
//
//  Created by Zeynep Toy on 23.03.2024.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var homeViewModel: HomeViewModel = HomeViewModel()
    var body: some View {
      
            VStack {
                let users = homeViewModel.users
                if !users.isEmpty {
                    ForEach(users, id: \.self) { user in
                        Text(user.email ?? "boş geldi")
                    }
                }
            }
    }
}

#Preview {
    HomeView()
}
