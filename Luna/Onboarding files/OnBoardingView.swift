//
//  OnBoardingView.swift
//  Luna
//
//  Created by Chhorn Vatana on 7/26/20.
//  Copyright © 2020 Chhorn Vatana. All rights reserved.
//

import SwiftUI

struct OnBoardingView: View {
    
    let name = ["Study", "Work", "Meditate", "Other"]
    var data: [OnboardingDataModel]
    var doneFunction: () -> ()
    
    @State var slideGesture: CGSize = CGSize.zero
    @State var curSlideIndex = 0
    var distance: CGFloat = UIScreen.main.bounds.size.width
    
    func nextButton() {
        doneFunction()
    }
    
    var body: some View {
        
        ZStack {
            Color(.white)
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                //MARK: - Header Texts
                Text("What are you trying to accomplish today?")
                    .foregroundColor(.black)
                    .font(.system(size: 19))
                    .bold()
                    .padding(.bottom).padding(.top, 50)
                Text("Choose your activity below")
                    .foregroundColor(.black)
                Spacer()
                
                //MARK: - AnimationView
                
                ZStack (alignment: .center) {
                    //MARK: - slideGesture
                    
                    ForEach(0 ..< data.count) { i in
                        OnboardingStepView(data: self.data[i])
                            .offset(x: CGFloat(i) * self.distance)
                            .offset(x: self.slideGesture.width - CGFloat(self.curSlideIndex) * self.distance)
                            //adjusting the animation
                            .animation(Animation.interpolatingSpring(stiffness: 70, damping: 6).delay(0.1))
                            .gesture(DragGesture()
                                .onChanged( { value in
                                    self.slideGesture = value.translation
                                } )
                                .onEnded{ (value) in
                                    if self.slideGesture.width < -50 {
                                        if self.curSlideIndex < self.data.count - 1 {
                                            withAnimation{
                                                self.curSlideIndex += 1
                                            }
                                        }
                                    }
                                    if self.slideGesture.width > 50 {
                                        if self.curSlideIndex > 0 {
                                            withAnimation{
                                                self.curSlideIndex -= 1
                                            }
                                        }
                                    }
                                    self.slideGesture = .zero
                            })//Guesture
                    }
                }
                
                //MARK: - Button and progressView
                self.progressView()
                    .padding(.bottom, 130).padding(.top)
                Spacer()
                Button(action: nextButton) {
                    self.arrowView()
                }
            }
            .padding(20)
        }
        
    }
    
    //MARK: - ButtonFunction
    func arrowView() -> some View {
        Group {
            Capsule()
                .frame(width: 230, height: 60, alignment: .center)
                .foregroundColor(.green)
                .overlay( Text(name[curSlideIndex])
                    .foregroundColor(.white)
                    .font(.system(size : 20))
                    .padding())
        }
    }
    
    //MARK: - progressView
    func progressView() -> some View {
        HStack {
            ForEach(0..<data.count) {
                i in
                Circle()
                    .scaledToFit()
                    .frame(width: 15, height: 10)
                    .foregroundColor(self.curSlideIndex >= i+1 ? Color(.white) : Color(.black)
                        .opacity(0.50))
            }
        }
    }
    
}

struct OnBoardingView_Previews: PreviewProvider {
    static let sample = OnboardingDataModel.data
    
    static var previews: some View {
        OnBoardingView(data: sample, doneFunction: { print("done")})
    }
}
