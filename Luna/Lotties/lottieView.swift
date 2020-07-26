//
//  lottieView.swift
//  BussinesCard
//
//  Created by Chhorn Vatana on 7/22/20.
//  Copyright © 2020 Chhorn Vatana. All rights reserved.
//

import SwiftUI
import Lottie

struct LottieView: UIViewRepresentable {
    
     typealias UIViewType = UIView
          let name: String
    func makeUIView(context: UIViewRepresentableContext<LottieView>) -> UIView {
     
  
        
        let view = UIView(frame: .zero)
        
        let animationView = AnimationView()
        let animation = Animation.named(name)
        animationView.animation = animation
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .loop
        animationView.play()
        
        
        animationView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(animationView)
        
        NSLayoutConstraint.activate([
            animationView.widthAnchor.constraint(equalTo: view.widthAnchor),
            animationView.heightAnchor.constraint(equalTo: view.heightAnchor)
        ])
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<LottieView>) {
    }
    
   
    
}

struct lottieView_Previews: PreviewProvider {
    static var previews: some View {
        LottieView(name: "1")
    }
}
