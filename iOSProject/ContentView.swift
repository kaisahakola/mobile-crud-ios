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
    
    var body: some View {
        if(users != nil) {
            NavigationView {
                NavigationStack {
                    List {
                        ForEach(searchUser(search: searchText, users: users!),
                                id: \.firstName) { user in
                            Text("\(user.firstName) \(user.lastName)")
                        }
                    }
                    NavigationLink(destination: AddUserView()) {
                        Text("Add user")
                    }
                    .navigationTitle("Kaisa's iOS app")
                }
                .searchable(text: $searchText)
            }
        } else {
            ProgressView()
                .onAppear() {
                    fetchData() {
                        self.users = $0
                    }
                }
        }
    }
}
