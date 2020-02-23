//
//  LoadingViewModifier.swift
//  Packages
//
//  Created by Vladislav Prusakov on 24.02.2020.
//  Copyright © 2020 LiteCode. All rights reserved.
//

import SwiftUI

struct LoadingViewModifier: ViewModifier {
    
    @Binding var isLoading: Bool
    
    func body(content: _ViewModifier_Content<LoadingViewModifier>) -> some View {
        ZStack {
            content
            
            if isLoading {
                ZStack {
                    Rectangle()
                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                        .foregroundColor(Color(.secondarySystemBackground).opacity(0.3))
                    
                    ActivityIndicator(style: .medium)
                }
            }
        }
    }
}
