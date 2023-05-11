//
//  ContentView.swift
//  iOSProject
//
//  Created by Kaisa Hakola on 9.5.2023.
//

import SwiftUI
import Alamofire

struct ContentView: View {
    
    @State var users : Array<User>? = nil
    @State private var searchText = ""
    @State private var showDeletePopup = false
    
    var body: some View {
        if(users != nil) {
            NavigationView {
                NavigationStack {
                    List {
                        // Going trough the users and adding their names and
                        // delete buttons for each user
                        ForEach(searchUser(search: searchText, users: users!),
                                id: \.firstName) { user in
                            HStack {
                                Text("\(user.firstName) \(user.lastName)")
                                
                                Spacer()
                                
                                Button(action: {
                                    deleteUser(id: user.id)
                                    showDeletePopup = true
                                }) {
                                    Image(systemName: "trash")
                                }.buttonStyle(PlainButtonStyle())
                                    .foregroundColor(.blue)
                            }
                        }
                    }
                    // Navigation link to open a new View for adding a new user
                    NavigationLink(destination: AddUserView()) {
                        Text("Add user")
                    }
                    .navigationTitle("Kaisa's iOS app")
                }
                // Search bar for searching users
                .searchable(text: $searchText)
                // Pop up alert that shows when delete user button is pressed
                .alert(isPresented: $showDeletePopup) {
                    Alert(title: Text("User deleted"),
                          dismissButton: .default(Text("OK")))
                }
                
            }
        } else {
            // When ProgressView appears, fetchData() is called which gets
            // data from dummyjson.com and sets the 'users' array to the
            // array of 'User' objects returned by the function.
            ProgressView()
                .onAppear() {
                    fetchData() {
                        self.users = $0
                    }
                }
        }
    }
}
