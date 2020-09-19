//
//  SignUpView.swift
//  FurFriend
//
//  Created by Sajan Shrestha on 9/19/20.
//

import SwiftUI


struct SignUpView: View {
    
    @State private var email = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    
    @Environment(\.presentationMode) var presentation
    
    var body: some View {
        
        VStack(spacing: spacing) {
            
            TextField("Email", text: $email).roundedBorder()
            SecureField("Password", text: $password).roundedBorder()
            SecureField("Confirm Password", text: $confirmPassword).roundedBorder()
            
            Divider().padding()
            
            Button("Sign Up") {
                
                if password == confirmPassword {
                    
                    signUpWith(email: email, password: password)
                }
                
            }
            .rounded(activated: allFieldsFilled)
            .disabled(!allFieldsFilled)
            
            Button("Cancel") {
                self.presentation.wrappedValue.dismiss()
                
            }
            .rounded(activated: true)
            
        }
        
    }
    
    private func signUpWith(email: String, password: String) {
        
        Authentication.signUp(email: email, password: password) { success in
            
            if success {
                
                self.presentation.wrappedValue.dismiss()
                
            }
        }
    }
    
    var allFieldsFilled: Bool {
        
        !(email.isEmpty || password.isEmpty || confirmPassword.isEmpty)
    }
    
    private let spacing: CGFloat = 8
}




struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
