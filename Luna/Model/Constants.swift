//
//  Model.swift
//  Luna
//
//  Created by Chhorn Vatana on 7/26/20.
//  Copyright © 2020 Chhorn Vatana. All rights reserved.
//

import SwiftUI
import Foundation

struct OnboardingDataModel
{
    var image: String
}

extension OnboardingDataModel {
    static var data: [OnboardingDataModel] = [
        OnboardingDataModel(image: "Study"),
        OnboardingDataModel(image: "Work"),
        OnboardingDataModel(image: "Meditate"),
        OnboardingDataModel(image: "Other"),
    ]
}

struct Model {
    let skipOnBoarding = "SkipOnBoarding"
    let animationImage = "AnimationImage"
}
