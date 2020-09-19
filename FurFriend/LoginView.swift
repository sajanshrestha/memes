//
//  LoginView.swift
//  Dog Images
//
//  Created by Sajan Shrestha on 9/18/20.
//  Copyright © 2020 Sajan Shrestha. All rights reserved.
//

import SwiftUI

struct LoginView: View {
    
    @State private var email = ""
    @State private var password = ""
    
    @State private var showSignUpView = false
    @State private var showMainView = false
    @State private var showAlertView = false
    
    
    var body: some View {
        
        NavigationView {

            VStack {
                
                VStack {
                    
                    TextField("Email", text: $email)
                        .roundedBorder()
                    
                    SecureField("Password", text: $password)
                        .roundedBorder()
                }
                
                Divider()
                    .padding()
                
                VStack {
                    
                    Button("Sign In") {
                        
                        signIn(email: self.email, password: self.password)
                    }
                    .rounded(activated: allFieldsFilled)
                    .disabled(email.isEmpty || password.isEmpty)
                    
                    Button("Sign Up") {
                        
                        self.showSignUpView = true
                    }
                    .rounded(activated: true)
                    
                }
                
            }
        }
        .popover(isPresented: $showSignUpView) {
            SignUpView()
        }
        .sheet(isPresented: $showMainView) {
            MainView()
        }
        .alert(isPresented: $showAlertView) {
            Alert(title: Text("Sign In Error"), message: Text("The password is invalid or the user does not have a password."), dismissButton: .default(Text("Ok")))
        }
    }
    
    
    private func signIn(email: String, password: String) {
        
        Authentication.signIn(email: self.email, password: self.password) { success in
            
            if success {
                
                self.showMainView = true
            }
            
            else {
                
                self.showAlertView = true
            }
        }
    }
    
    var allFieldsFilled: Bool {
        
        !(email.isEmpty || password.isEmpty)
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
