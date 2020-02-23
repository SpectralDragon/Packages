//
//  ContentView.swift
//  Packages
//
//  Created by Vladislav Prusakov on 16.02.2020.
//  Copyright © 2020 LiteCode. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State var pickedDocument: PlaygroundDocument?
    @State var isLoading: Bool = false
    
    var body: some View {
        ZStack {
            if pickedDocument == nil {
                DocumentBrowser { document in
                    self.isLoading = true
                    
                    document.open { isOpen in
                        self.isLoading = false
                        
                        if isOpen {
                            withAnimation {
                                self.pickedDocument = document
                            }
                        }
                    }
                }
                    .accentColor(.black)
                    .edgesIgnoringSafeArea(.all)
            } else {
                self.tabView
                    .transition(.move(edge: .bottom))
            }
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
        .modifier(LoadingViewModifier(isLoading: $isLoading))
    }
    
    var tabView: some View {
        TabView {
            PackagesView(pickedDocument: self.$pickedDocument)
                .tabItem { self.tabItem("Packages", image: Image(systemName: "gear")) }
                .tag(0)
            
            SettingsView()
                .tabItem { self.tabItem("Settings", image: Image(systemName: "gear")) }
                .tag(1)
        }
    }
    
    func tabItem(_ text: String, image: Image) -> some View {
        VStack {
            image
            
            Text(text)
        }
    }
}

