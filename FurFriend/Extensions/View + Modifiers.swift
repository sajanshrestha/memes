//
//  View + Modifiers.swift
//  FurFriend
//
//  Created by Sajan Shrestha on 9/19/20.
//

import SwiftUI


extension View {
    
    func roundedBorder() -> some View {
        
        self.modifier(InputField())
    }
    
    func spinning() -> some View {
        
        self.modifier(Spinning())
    }
    
    func rounded(activated: Bool) -> some View {
        
        self.modifier(RoundButton(activated: activated))
    }
    
}

struct InputField: ViewModifier {
    
    func body(content: Content) -> some View {
        content
            .padding(.horizontal)
            .textFieldStyle(RoundedBorderTextFieldStyle())
        
    }
}

struct Spinning: ViewModifier {
    @State var isVisible = false
    
    func body(content: Content) -> some View {
        content
            .rotationEffect(Angle(degrees: isVisible ? 360 : 0))
            .animation(Animation.linear(duration: 1).repeatForever(autoreverses: false))
            .onAppear { self.isVisible = true }
    }
}

struct RoundButton: ViewModifier {
    
    var activated: Bool
    
    func body(content: Content) -> some View {
        
        content
            .padding(EdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8))
            .frame(width: UIScreen.main.bounds.width * 0.9)
            .background(activated ? Color.green : Color.gray)
            .foregroundColor(.white)
            .cornerRadius(8.0)
            .animation(.easeIn)
            
    }
}

