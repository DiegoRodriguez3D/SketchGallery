//
//  OnboardingViewDetails.swift
//  PokeDex Classic
//
//  Created by Diego Rodriguez on 5/9/24.
//

import SwiftUI

struct OnboardingViewDetails: View {
    
    var bgColor: Color
    var headline: String
    var subHeadline: String
    var imageName: String
    var buttonTex: String
    var buttonAction: () -> Void
    
    var body: some View {
        ZStack {
            ZStack {
                ZStack(alignment: .topLeading) {
                    Color(bgColor)
                    
                    RoundedRectangle(cornerRadius: 20)
                        .foregroundStyle(.white)
                        .frame(width: 200, height: 200)
                        .offset(x: -100, y: -100)
                        .opacity(0.15)
                        .rotationEffect(.degrees(-20))
                }
            }
            
            VStack (spacing: 0) {
                
                Spacer()
                Spacer()
                
                Image(imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 350)
                    .clipShape(.rect(cornerRadius: 14))
                    .shadow(radius: 8)
                
                Text(headline)
                    .font(.title)
                    .bold()
                    .padding(.top, 32)
                
                Text(subHeadline)
                    .font(.body)
                    .padding(.horizontal)
                    .padding(.top, 4)
                
                Spacer()
                
                Button {
                    buttonAction()
                    
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 14)
                            .foregroundStyle(Color.white)
                            .frame(height: 50)
                        Text(buttonTex)
                            .bold()
                            .foregroundStyle(.black)
                    }
                }
                .padding(.horizontal)
                .padding(.bottom, 115)
                
            }
            .foregroundStyle(.white)
        }
    }
}

#Preview {
    OnboardingViewDetails(bgColor: .blue, headline: "Your best ideas!", subHeadline: "Remember your greatest sketches and spark new inspiration!", imageName: "onboarding", buttonTex: "Continue", buttonAction: {
        //action test
    })
}
