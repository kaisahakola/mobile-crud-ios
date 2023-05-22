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
    @State private var newEmail : String = ""
    @State private var updateFirstName : String = ""
    @State private var updateLastName : String = ""
    @State private var updateEmail : String = ""
    @State var selectedUser : User?
    
    // MARK: - Body
    
    var body: some View {
        if(users != nil) {
            NavigationView {
                NavigationStack {
                    // MARK: - List of users
                    /// A list of all the users.
                    List {
                        /// A ForEach loop going trough the array of 'User' objects.
                        ForEach(users!, id: \.firstName) { user in
                            HStack {
                                
                                /// Displaying the first name and last name with email address in
                                /// a vertical stack.
                                VStack(alignment: .leading) {
                                    Text("\(user.firstName) \(user.lastName)")
                                    Text("\(user.email)")
                                        .font(.system(size: 12))
                                        .padding(1)
                                }
                                
                                Spacer()
                                
                                /// A delete button which sets the selectedUser as user, so it can
                                /// be found and used in the delete alert, outside of the loop.
                                Button(action: {
                                    selectedUser = user
                                    showDeletePopup = true
                                }) {
                                    Image(systemName: "trash")
                                }.buttonStyle(PlainButtonStyle())
                                    .foregroundColor(.blue)
                                    .padding(5)
                                
                                /// An edit button which sets the selectedUser as user, so it can
                                /// be found and used in the update alert, outside of the loop.
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
                    /// Button to open the alert to add a new user.
                    Button(action: {
                        showAddUserPopup = true
                    }) {
                        Label("Add User", systemImage: "person.badge.plus")
                    }
                    .padding(15)
                }
                
                // MARK: - Search
                /// A Searchbar which calls the searchUsers() function when user starts typing.
                /// All users on the list are then replaced by the searchedUsers objects.
                .searchable(text: $searchText)
                .onChange(of: searchText) { _ in
                    searchUser(searchText: searchText) { searchedUsers in
                        if let searchedUsers = searchedUsers {
                            self.users = searchedUsers
                        }
                    }
                }
                
                // MARK: - Alerts
                
                /// Alert for deleting users.
                .alert("Delete user?", isPresented: $showDeletePopup, actions: {
                    /// When 'OK' button is pressed, deleteUser() function is called.
                    Button("OK", action: {
                        if let selectedUser = selectedUser {
                            deleteUser(id: selectedUser.id)
                        }
                        showDeletePopup = false
                    })
                    Button("Cancel", role: .cancel, action: {
                        showDeletePopup = false
                    })
                })
                
                /// Alert for editing users.
                .alert("Edit user", isPresented: $showUpdatePopup, actions: {
                    TextField("Fist name", text: $updateFirstName)
                    TextField("Last name", text: $updateLastName)
                    TextField("Email", text: $updateEmail)
                        
                    /// When 'Update' button is pressed, updateUser() function is called
                    /// and the new updated user object is passed to it.
                    Button("Update", action: {
                        if let selectedUser = selectedUser {
                            let updatedUser = User(
                                firstName: updateFirstName,
                                lastName: updateLastName,
                                id: selectedUser.id,
                                email: updateEmail
                            )
                            updateUser(user: updatedUser)
                        }
                    })
                    Button("Cancel", role: .cancel, action: {
                        showAddUserPopup = false
                    })
                })
                /// When the edit button gets pressed the first time,
                /// onAppear method is called and selectedUser's info is diplayed.
                .onAppear {
                    updateFirstName = selectedUser?.firstName ?? ""
                    updateLastName = selectedUser?.lastName ?? ""
                    updateEmail = selectedUser?.email ?? ""
                }
                /// When selectedUser changes, onChange method is called, and the info
                /// that appears in the TextFields changes also.
                .onChange(of: selectedUser) { user in
                    updateFirstName = user?.firstName ?? ""
                    updateLastName = user?.lastName ?? ""
                    updateEmail = user?.email ?? ""
                }
                
                /// Alert for adding users.
                .alert("Add user", isPresented: $showAddUserPopup, actions: {
                    TextField("Fist name", text: $newFirstName)
                    TextField("Last name", text: $newLastName)
                    TextField("Email", text: $newEmail)
                    
                    /// When 'add' button is pressed, addUser() function is called and the TextFields are cleared.
                    Button("Add", action: {
                        addUser(firstName: newFirstName, lastName: newLastName, email: newEmail)
                        
                        // Emptying the textfields after pressing 'add' button.
                        newFirstName = ""
                        newLastName = ""
                        newEmail = ""
                    })
                    Button("Cancel", role: .cancel, action: {
                        showAddUserPopup = false
                    })
                })
            }
        } else {
            
            // MARK: - Data fetching
            /// ProgressView() triggers the data fetching by calling the fetchData() function.
            /// The received data is the assigned to the 'users' property, which then displays
            /// the list of users.
            ProgressView()
                .onAppear() {
                    fetchData() {
                        self.users = $0
                    }
                }
        }
    }
}
