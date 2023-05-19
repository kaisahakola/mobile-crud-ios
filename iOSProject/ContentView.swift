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
    @State private var showUpdatePopup = false
    @State private var newFirstName : String = ""
    @State private var newLastName : String = ""
    @State private var updateFirstName : String = ""
    @State private var updateLastName : String = ""
    @State var selectedUser : User?
    
    // MARK: - Body
    
    var body: some View {
        if(users != nil) {
            NavigationView {
                NavigationStack {
                    // MARK: - List of users
                    // Each user has first name, last name, delete button and
                    // edit button.
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
                                    .padding(5)
                                
                                Button(action: {
                                    selectedUser = user
                                    showUpdatePopup = true
                                }) {
                                    Image(systemName: "pencil")
                                }.buttonStyle(PlainButtonStyle())
                                    .foregroundColor(.blue)
                                    .padding(5)
                            }
                        }
                    }
                    .navigationTitle("Kaisa's iOS app")
                    
                    // MARK: - Add user button
                    
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
                
                // Delete user alert
                .alert("User deleted", isPresented: $showDeletePopup, actions: {
                    Button("OK", action: {
                        showDeletePopup = false
                    })
                })
                
                // Edit user alert
                .alert("Edit user", isPresented: $showUpdatePopup, actions: {
                    TextField("Fist name", text: $updateFirstName)
                    TextField("Last name", text: $updateLastName)
                        
                    Button("Update", action: {
                        if let selectedUser = selectedUser {
                            let updatedUser = User(
                                firstName: updateFirstName,
                                lastName: updateLastName,
                                id: selectedUser.id
                            )
                            updateUser(user: updatedUser)
                        }
                    })
                    Button("Cancel", role: .cancel, action: {
                        showAddUserPopup = false
                    })
                })
                .onAppear {
                    updateFirstName = selectedUser?.firstName ?? ""
                    updateLastName = selectedUser?.lastName ?? ""
                }
                .onChange(of: selectedUser) { user in
                    updateFirstName = user?.firstName ?? ""
                    updateLastName = user?.lastName ?? ""
                }
                
                // Add user alert
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
