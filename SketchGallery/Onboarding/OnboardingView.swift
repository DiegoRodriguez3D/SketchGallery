//
//  OnboardingView.swift
//  PokeDex Classic
//
//  Created by Diego Rodriguez on 5/9/24.
//

import SwiftUI

struct OnboardingView: View {
    
    @Environment(\.dismiss) var dismiss
    @State var selectedViewIndex = 0
    
    var body: some View {
        
        ZStack {
            
            if selectedViewIndex == 0 {
                Color(red: 111/255, green: 154/255, blue: 189/255)
            }
            else {
                Color(red: 139/255, green: 166/255, blue: 65/255)
            }
            
            TabView (selection: $selectedViewIndex) {
                
                OnboardingViewDetails(bgColor: .blue,
                                      headline: "Your best ideas!",
                                      subHeadline: "Remember your greatest sketches and spark new inspiration!", imageName: "onboarding", buttonTex: "Continue") {
                    withAnimation {
                        selectedViewIndex = 1
                    }
                }
                                      .tag(0)
                                      .ignoresSafeArea()
                
                OnboardingViewDetails(bgColor: .blue,
                                      headline: "Your Masterpieces",
                                      subHeadline: "See each of your sketches up close, with its title and description. Let your creativity shine!", imageName: "onboarding2", buttonTex: "Continue") {
                    withAnimation {
                        selectedViewIndex = 2
                    }
                }
                                      .tag(1)
                                      .ignoresSafeArea()
                
                
                OnboardingViewDetails(bgColor: .blue,
                                      headline: "Got a brilliant idea?",
                                      subHeadline: "Add it to your collection! Just pick an image, give it a title, and add a description.", imageName: "onboarding3", buttonTex: "Let's Go!") {
                    dismiss()
                }
                                      .tag(2)
                                      .ignoresSafeArea()
                
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            
            VStack {
                Spacer()
                HStack (spacing: 16) {
                    Spacer()
                    Circle()
                        .frame(width: 10)
                        .foregroundStyle(selectedViewIndex == 0 ? .white : .gray)
                    
                    Circle()
                        .frame(width: 10)
                        .foregroundStyle(selectedViewIndex == 1 ? .white : .gray)
                    
                    Circle()
                        .frame(width: 10)
                        .foregroundStyle(selectedViewIndex == 2 ? .white : .gray)
                    Spacer()
                }
                .padding(.bottom, 200)
            }
            
        }
        .ignoresSafeArea()
    }
}

#Preview {
    OnboardingView()
}
