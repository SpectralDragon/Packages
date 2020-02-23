//
//  ActivityIndicator.swift
//  Packages
//
//  Created by Vladislav Prusakov on 24.02.2020.
//  Copyright © 2020 LiteCode. All rights reserved.
//

import SwiftUI

struct ActivityIndicator: UIViewRepresentable {
    
    private let style: UIActivityIndicatorView.Style
    private let color: UIColor
    
    init(style: UIActivityIndicatorView.Style, color: UIColor = .white) {
        self.style = style
        self.color = color
    }
    
    func makeUIView(context: UIViewRepresentableContext<ActivityIndicator>) -> UIActivityIndicatorView {
        let view = UIActivityIndicatorView(style: self.style)
        view.color = self.color
        return view
    }
    
    func updateUIView(_ uiView: UIActivityIndicatorView, context: UIViewRepresentableContext<ActivityIndicator>) {
        
    }
    
}
