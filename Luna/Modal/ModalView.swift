//
//  ModalView.swift
//  Luna
//
//  Created by Chhorn Vatana on 7/29/20.
//  Copyright © 2020 Chhorn Vatana. All rights reserved.
//


import SwiftUI

struct Modal: View {
    var body: some View {
             ZStack{
                Color(red: 0.21, green: 0.58, blue: 0.57)
                        .edgesIgnoringSafeArea(.all)
                    
                    VStack {
                        Spacer()
                        Image(Titles.PersonalInfo.profile)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 250, height: 250, alignment: .center)
                            .clipShape(Circle())
                            .overlay(Circle().stroke(Color.white, lineWidth: 5)
                        )
                        
                        
                        Text("Vatana Chhorn")
                            .font(.custom("Pacifico-Regular", size: 35))
                            .foregroundColor(Color.white)
                        
                        Text("Contact me: ")
                            .font(.system(size: 25))
                            .foregroundColor(.white)
                        
                        
                        
                        Divider()
                            .padding()
                        
                        Button(action: {   UIApplication.shared.open(Titles.PersonalInfo.phoneNumberDail!)}) {
                            Rectangle()
                                .fill(Color.white)
                                .frame(width: 400, height: 50, alignment: .center)
                                .clipShape(Capsule())
                                .overlay(
                                    HStack {
                                        Image(systemName: "phone.fill")
                                        Text(Titles.PersonalInfo.phoneNumber)
                                    }    .foregroundColor(.black)
                            ).padding()
                            
                        }
                        
                        
                        Rectangle()
                            .fill(Color.white)
                            .frame(width: 400, height: 50, alignment: .center)
                            .clipShape(Capsule())
                            .overlay(
                                HStack {
                                    Image(systemName: "envelope.fill")
                                    Text(Titles.PersonalInfo.emailAddress)
                                }    .foregroundColor(.black)
                                
                        )
                        Divider()
                            .padding()
                        
                        
                        
                        Spacer()
                        
                        HStack {
                            Button(action: {
                                UIApplication.shared.open(Titles.githubURL!)
                            }) {
                                Image(Titles.github)
                                    .renderingMode(.original)
                                    .padding(.leading)
                                
                            }
                            
                            Button(action: {
                                UIApplication.shared.open(Titles.instagramURL!)
                            }) {
                                Image(Titles.instagram)
                                    .renderingMode(.original)
                                
                            }
                            
                            Button(action: {
                                UIApplication.shared.open(Titles.faceBookUrl!)
                            }) {
                                Image(Titles.facebook)
                                    .renderingMode(.original)
                                    .padding(.trailing)
                            }
                        }
                    }
                }
            }
        }
    

struct Medal_Previews: PreviewProvider {
    static var previews: some View {
        Modal()
    }
}

