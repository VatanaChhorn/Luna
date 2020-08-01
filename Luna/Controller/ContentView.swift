//
//  ContentView.swift
//  Luna
//
//  Created by Chhorn Vatana on 7/26/20.
//  Copyright © 2020 Chhorn Vatana. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    //MARK: - Declare onboardingOne
    let defaults = UserDefaults.standard.bool(forKey: "SkipOnBoarding")
    var data = OnboardingDataModel.data
    @State var onboardingDone = false
        
    var body: some View {
        
        //MARK: - Check whether OnBoardingDoneOrNot
        Group {
            if !onboardingDone && (defaults == false){
                OnBoardingView(data: data, doneFunction: {
                    ///Update State
                    self.onboardingDone = true
                 
                })
            } else {
                //MARK: - Main Screen
                mainController()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
