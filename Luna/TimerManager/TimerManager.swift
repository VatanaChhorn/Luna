//
//  TimerManager.swift
//  Luna
//
//  Created by Chhorn Vatana on 7/29/20.
//  Copyright © 2020 Chhorn Vatana. All rights reserved.
//

import Foundation

class TimerManager: ObservableObject {
    
    @Published var outputResult: String = ""
    var timer = Timer()
    let model = Model()
    //MARK: - Convert input in minute to second - prepare for input to timerMachine
    
    func minuteToSecond(minute: Int) -> Int{
        let second = minute*60
        return second
    }
    
    //MARK: - Timer Machine
    
    func timerMachine (minutes : Int) {
        
        var secondsRemaining = minuteToSecond(minute: minutes)
        
        self.timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { (Timer) in
            if secondsRemaining >= 0 {
                self.outputResult = self.convertCountToTimeString(counter: secondsRemaining) //Output
                //Set the push notification bool
                UserDefaults.standard.set( true , forKey: self.model.processingBool)
                secondsRemaining -= 1
            } else {
                self.timer.invalidate()
            }
        }
    }
    
    //MARK: - Stop Timer
    
    func stopTimer() {
        timer.invalidate()
        outputResult = ""
        UserDefaults.standard.set( false , forKey: self.model.processingBool)
    }
    
    //MARK: - Convert seconds input to time String
    func convertCountToTimeString(counter: Int) -> String {
        
        let minutes = counter / 60
        let secondremain = counter % 60
        let seconds = secondremain
        
        
        var secondsString = "\(seconds)"
        var minutesString = "\(minutes)"
        
        if seconds < 10 {
            secondsString = "0" + secondsString
        }
        
        if minutes < 10 {
            minutesString = "0" + minutesString
        }
        
        return "\(minutesString):\(secondsString)"
    }
    
}
