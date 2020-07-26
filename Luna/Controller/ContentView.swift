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
    @State private var onboardingDone = false
    var data = OnboardingDataModel.data
    
    
    var body: some View {
        
        //MARK: - Check whether OnBoardingDoneOrNot
        Group {
            if !onboardingDone {
                OnBoardingView(data: data, doneFunction: {
                    ///Update State
                    self.onboardingDone = true
                    print("Done Onboarding")
                })
            } else {
                //MARK: - Main Screen
                Text("Hello")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
