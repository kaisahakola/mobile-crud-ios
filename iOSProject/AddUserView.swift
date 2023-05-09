//
//  AddUserView.swift
//  iOSProject
//
//  Created by Kaisa Hakola on 9.5.2023.
//

import Foundation
import SwiftUI

struct AddUserView: View {
    @State var firstName : String = ""
    @State var lastName : String = ""
    @State private var showPopup = false
    
    var body : some View {
        // Creating a vertical stack for the elements
        // and horizontal stacks for setting the TextFields
        // next to their labels.
        VStack {
            Text("Add new user")
                .bold()
                .font(.system(size: 20))
            
            HStack {
                Text("First name:")
                TextField("fist name", text: $firstName)
                    .textFieldStyle(.roundedBorder)
            }.padding(20)
            
            HStack {
                Text("Last name:")
                TextField("last name", text: $lastName)
                    .textFieldStyle(.roundedBorder)
            }.padding(20)
            
            Button("Add") {
                addUser(firstName: firstName, lastName: lastName)
                
                // Showing the Alert when the button is pressed
                showPopup = true
                
                // Clearing the TextFields after new user is added
                self.firstName = ""
                self.lastName = ""
            }
            .padding(10)
            .alert(isPresented: $showPopup) {
                Alert(title: Text("New user added"),
                      dismissButton: .default(Text("OK")))
            }
        }
    }
}
