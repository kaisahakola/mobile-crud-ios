//
//  ContentView.swift
//  iOSProject
//
//  Created by Kaisa Hakola on 9.5.2023.
//

import SwiftUI
import Alamofire

// MARK: - ContentView

/// The main view of the iOS app.
struct ContentView: View {
    
    // MARK: - Properties
    
    @State var users : Array<User>? = nil
    @State private var searchText = ""
    @State private var showDeletePopup = false
    @State private var showAddUserPopup = false
    @State private var newFirstName : String = ""
    @State private var newLastName : String = ""
    
    // MARK: - Body
    
    var body: some View {
        if(users != nil) {
            NavigationView {
                NavigationStack {
                    List {
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
                    .navigationTitle("Kaisa's iOS app")
                    
                    // MARK: - Add user
                    
                    Button(action: {
                        showAddUserPopup = true
                    }) {
                        Label("Add User", systemImage: "person.badge.plus")
                    }
                    .padding(15)
                }
                
                // MARK: - Search
                
                .searchable(text: $searchText)
                
                // MARK: - Alerts
                
                .alert("User deleted", isPresented: $showDeletePopup, actions: {
                    Button("OK", action: {
                        showDeletePopup = false
                    })
                })
                
                .alert("Add user", isPresented: $showAddUserPopup, actions: {
                    TextField("Fist name", text: $newFirstName)
                    TextField("Last name", text: $newLastName)
                    
                    Button("Add", action: {
                        addUser(firstName: newFirstName, lastName: newLastName)
                    })
                    Button("Cancel", role: .cancel, action: {
                        showAddUserPopup = false
                    })
                })
            }
        } else {
            
            // MARK: - Data fetching
            
            ProgressView()
                .onAppear() {
                    fetchData() {
                        self.users = $0
                    }
                }
        }
    }
}
