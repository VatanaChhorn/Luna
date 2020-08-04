//
//  mainController.swift
//  Luna
//
//  Created by Chhorn Vatana on 7/28/20.
//  Copyright © 2020 Chhorn Vatana. All rights reserved.
//

import SwiftUI
import AlertX
import Sliders

struct mainController: View {
    
    @State var showingPopup: Bool = false
    @ObservedObject var timerManger = TimerManager()
    @State var showingDetail = true
    @State var value3 = 60
    @State var sliderVisibility: Bool = true
    @State var showAlertX: Bool = false
    @State var showModal: Bool = false
    @State var extremeModeEnable: Bool = false
    @State var showAlertSecond: Bool = false
    let model = Model()
    let defaults = UserDefaults.standard
    let name = ["Study", "Work", "Meditate", "Other"]
    
    var body: some View {
        ZStack {
            Color(UIColor(red: 0.87, green: 0.90, blue: 0.91, alpha: 1.00))
                .edgesIgnoringSafeArea(.all)
            ZStack (alignment: .center ){
                
                if defaults.bool(forKey: model.skipOnBoarding) == false {
                    LottieView(name:  defaults.string(forKey: model.animationImage)!)
                        .frame(width: 400, height: 400, alignment: .center)
                        .offset(y: -40)
                } else {
                    LottieView(name: name[Int.random(in: 0...2)])
                        .frame(width: 400, height: 400, alignment: .center)
                        .offset(y: -40)
                    
                }
                
                VStack {
                    
                    //MARK: - Top Buttons
                    HStack {
                        
                        // First button
                        Button(action: {
                            self.extremeModeEnable ? self.showAlertSecond.toggle() : self.showAlertX.toggle()
                        }) {
                            Capsule()
                                .foregroundColor(extremeModeEnable ? .red: Color(red: 0.21, green: 0.58, blue: 0.57))
                                .frame(width: 100, height: 30, alignment: .center)
                                .overlay(Image(systemName: "flame")
                                    .foregroundColor(.white))
                        } .alertX(isPresented: $showAlertX, content: {
                            AlertX(title: Text("Enable Extreme Mode"),
                                   message: Text("The app will automatically be terminated if you exit the app with Extreme Mode On!"),
                                   primaryButton: .default(Text("Enable"), action: {
                                    self.extremeModeEnable.toggle()
                                    self.showAlertX.toggle()
                                    self.defaults.set(true, forKey: self.model.extremeMode)
                                   }),
                                   secondaryButton: .cancel(),
                                   theme: .mint(withTransparency: true, roundedCorners: true), animation: .classicEffect())})
                            .alertX(isPresented: $showAlertSecond, content: {
                                AlertX(title: Text("Disable Extreme Mode"),
                                       message: Text("Feel like giving up yet?"),
                                       primaryButton: .default(Text("Yes"), action: {
                                        self.extremeModeEnable.toggle()
                                        self.showAlertSecond.toggle()
                                        self.defaults.set(false, forKey: self.model.extremeMode)
                                       }),
                                       secondaryButton: .cancel(),
                                       theme: .mint(withTransparency: true, roundedCorners: true), animation: .classicEffect())})
                        
                        // Second Button
                        Button(action: {
                            self.showModal = true
                            
                        }) {
                            Capsule()
                                .foregroundColor(extremeModeEnable ? .red: Color(red: 0.21, green: 0.58, blue: 0.57))
                                .frame(width: 100, height: 30, alignment: .center)
                                .overlay(Image(systemName: "person")
                                    .foregroundColor(.white))
                        }
                            //MARK: - Show Modal View
                            .sheet(isPresented: $showModal) {
                                Modal()
                        }
                        
                        
                    } // End HStack
                        .padding(.top)
                    
                    //MARK: - ExtremeMode Label Check
                    if extremeModeEnable {
                        Text("You're in Extreme Mode, Goodluck!")
                            .padding(.top, 25)
                            .font(.headline)
                            .foregroundColor(.black)
                    }
                    
                    //MARK: - Slider Visibility Check
                    if sliderVisibility {
                        Text("\(value3): 00")
                            .foregroundColor(.black)
                            .bold()
                            .font(.largeTitle)
                            .padding(.top , 50)
                        
                        
                    } else {
                        Text("Stop glancing at me and do the work.")
                            .foregroundColor(.black)
                            .padding(.top, 40)
                        
                    }
                    
                    //MARK: - Spacer for Zstack
                    Spacer()
                    Spacer()
                    
                    //MARK: - Slider
                    if sliderVisibility {
                        Text("Get in to work now!")
                            .multilineTextAlignment(.center)
                        ValueSlider(value: $value3, in: 10...120)
                            .valueSliderStyle(
                                HorizontalValueSliderStyle(
                                    track: LinearGradient(
                                        gradient: Gradient( colors: [ Color(red: 0.21, green: 0.58, blue: 0.57), .blue, Color(red: 0.21, green: 0.58, blue: 0.57)]),
                                        startPoint: .leading,
                                        endPoint: .trailing
                                    )
                                        .frame(height: 10)
                                        .cornerRadius(4)
                                )
                                
                        ) .frame( height: 20, alignment: .center)
                            .padding(.horizontal, 40).padding(.bottom, 40)
                    }
                    
                    
                    if !sliderVisibility {
                        Text("\(timerManger.outputResult)")
                            .foregroundColor(.black)
                            .font(.system(size: 65))
                            .padding(.vertical)
                            .padding(.horizontal, 100)
                    }
                    //MARK: - Start Button
                    
                    Button(action: {   
                        self.sliderVisibility = !self.sliderVisibility
                        
                        !self.sliderVisibility ? self.timerManger.timerMachine(minutes: self.value3) : self.timerManger.stopTimer()
                        //Start dispatchQueue
                        self.start(second: self.value3)
                        
                    }) {
                        Capsule()
                            .frame(width: 230, height: 60, alignment: .center)
                            .foregroundColor(extremeModeEnable ? .red: Color(red: 0.21, green: 0.58, blue: 0.57))
                            .font(.system(size : 20))
                            .overlay(
                                Text(sliderVisibility ? "Start" : "Give Up")
                                    .foregroundColor(.white)
                                    .padding()
                        )
                    } .padding(.bottom)
                        //MARK: - Pop Up View
                        .popup(isPresented: $showingPopup,type: .default, position: .bottom, animation: .easeInOut) {
                            VStack {
                                
                                Text("Congratulation! 🎉")
                                    .bold()
                                    .font(.system(size: 20))
                                    .foregroundColor(.white)
                                    .padding(.top, 120)
                                    .padding(.bottom, 5)
                                Text("You're one step closer toward your goal.")
                                    .foregroundColor(.white)
                                    .padding(.bottom, 3)
                                Text("Keep up your great work. :)")
                                    .foregroundColor(.white)
                                LottieView(name: self.model.congrats)
                                    .offset(y: -50)
                                    .frame(width: 400, height: 400, alignment: .center)
                                    .padding(.horizontal)
                            }
                            .frame(width: 380, height: 400)
                            .background(Color(red: 0.21, green: 0.58, blue: 0.57))
                            .cornerRadius(10)
                            .shadow(radius: 10)
                            .padding(.horizontal, 10)
                    }
                    
                }
            }
            
        }
    }
    
    
    //MARK: - DispatchQueue Function to showing new modal
    func start(second: Int) {
        
        let work = DispatchWorkItem {
            if !self.sliderVisibility {
                self.showingPopup = true
            } else {
                self.showingPopup = false
                print("it works!")
            }
        }
        !self.sliderVisibility ? DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(second*60+1), execute: work) : work.cancel()
    }
    
}

struct mainController_Previews: PreviewProvider {
    static var previews: some View {
        mainController()
    }
}

