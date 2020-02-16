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
    
    var body: some View {
        ZStack {
            if pickedDocument == nil {
                DocumentBrowser(selectedDocument: self.$pickedDocument)
                    .accentColor(.black)
                    .edgesIgnoringSafeArea(.all)
            } else {
                PackagesView(pickedDocument: self.$pickedDocument)
            }
        }
    }
}
