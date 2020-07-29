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

struct Titles {
    
    struct PersonalInfo {
        static    let profile = "Vatana"
        static    let phoneNumber = "+855 962 426 299"
        static    let emailAddress = "onlyvatna22@gmail.com"
        static    let phoneNumberDail = URL(string: "tel://\(+855962426299)")
    }

static    let github = "Github"
static    let facebook = "Facebook"
static    let instagram = "Instagram"
static    let githubURL = URL(string: "https://github.com/VatanaChhorn")
static    let faceBookUrl = URL(string: "fb://profile/vatan4c/")
static    let instagramURL = URL(string: "https://www.instagram.com/vatana.chhorn/")
}
