//
//  ContentView.swift
//  iOSProject
//
//  Created by Kaisa Hakola on 9.5.2023.
//

import SwiftUI

struct ContentView: View {
    
    @State var users : Array<User>? = nil
    
    var body: some View {
        if(users != nil) {
            Text("Kaisa's iOS App")
                .bold()
                .font(.system(size: 30))
            
            List {
                ForEach(users!, id: \.firstName) {
                    user in Text("\(user.firstName) \(user.lastName)")
                }
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
