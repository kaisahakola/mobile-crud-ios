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
    
    var body : some View {
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
        }
    }
}
