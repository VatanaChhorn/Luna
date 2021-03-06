//
//  OnBoardingView.swift
//  Luna
//
//  Created by Chhorn Vatana on 7/26/20.
//  Copyright © 2020 Chhorn Vatana. All rights reserved.
//

import SwiftUI

struct OnBoardingView: View {
    
    let defaults = UserDefaults.standard
    let name = ["Study", "Work", "Meditate", "Other"]
    var data: [OnboardingDataModel]
    var model = Model()
    var doneFunction: () -> ()
    
    @State var slideGesture: CGSize = CGSize.zero
    @State var curSlideIndex = 0
    var distance: CGFloat = UIScreen.main.bounds.size.width
    
    func nextButton() {
        doneFunction()
    }
    
    var body: some View {
        
        ZStack {
            Color(UIColor(red: 0.87, green: 0.90, blue: 0.91, alpha: 1.00))
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
                            .padding(.top, 75)
                            .offset(x: CGFloat(i) * self.distance)
                            .offset(x: self.slideGesture.width - CGFloat(self.curSlideIndex) * self.distance)
                            //adjusting the animation
                            .animation(Animation.interpolatingSpring(stiffness: 50, damping: 8).delay(0.1))
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
                Button(action: {
                    self.nextButton()
                    self.defaults.set(self.name[self.curSlideIndex], forKey: self.model.animationImage)
                    self.defaults.set(false, forKey: self.model.skipOnBoarding)
                } ) {
                    self.arrowView()
                }
                
                //Always skip this page button
                Button(action: {
                    self.defaults.set(true, forKey: self.model.skipOnBoarding)
                    self.nextButton()
                }) {
                    Text("Always skip this page")
                    .foregroundColor(.black)
                        .padding(.top)
                }
            }
           
        }
        
    }
    
    //MARK: - ButtonFunction
    func arrowView() -> some View {
        Group {
            Capsule()
                .frame(width: 230, height: 60, alignment: .center)
                .foregroundColor(Color(red: 0.21, green: 0.58, blue: 0.57))
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
                    .foregroundColor(self.curSlideIndex >= i ? Color(.white) : Color(.black)
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
