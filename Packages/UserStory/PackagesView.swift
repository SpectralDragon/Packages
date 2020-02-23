//
//  PackagesView.swift
//  Packages
//
//  Created by Vladislav Prusakov on 16.02.2020.
//  Copyright © 2020 LiteCode. All rights reserved.
//

import SwiftUI

struct PackagesView: View {
    
    @Binding var pickedDocument: PlaygroundDocument?
    @State var isAddShown: Bool = false
    @State var isHasChangedAlert: Bool = false
    
    private var modules: [String] {
        return self.pickedDocument?.modules ?? []
    }
    
    var body: some View {
        NavigationView {
            #if os(iOS)
            VStack {
                self.installedPackagesList
            }
            .sheet(isPresented: $isAddShown, content: {
                NavigationView {
                    NewPackageView()
                }
            })
            .navigationBarItems(leading: self.navigationBarLeadingItems,
                                trailing: self.navigationBarTrailingItems)
            .navigationBarTitle(self.pickedDocument?.title ?? "")
            #else
            HStack(spacing: 0) {
                self.installedPackagesList
                
                Divider()
                
                NewPackageView()
            }
            .navigationBarItems(leading: self.navigationBarLeadingItems)
            .navigationBarTitle(self.pickedDocument!.title)
            #endif
        }
        .alert(isPresented: self.$isHasChangedAlert, content: unsaveChangesAlert)
        .onAppear(perform: viewDidLoad)
    }
    
    func viewDidLoad() {
        
    }
    
    var navigationBarLeadingItems: some View {
        Button(action: onClosePressed) {
            Image(systemName: "xmark")
                .font(.system(size: 17, weight: .bold))
        }
    }
    
    var navigationBarTrailingItems: some View {
        HStack {
            #if os(iOS)
            Button(action: onAddPackagePressed) {
                Image(systemName: "plus")
                    .font(.system(size: 17, weight: .bold))
            }
            #else
            Button(action: onAddPackagePressed) {
                Image(systemName: "xmark")
                    .font(.system(size: 17, weight: .bold))
            }
            #endif
        }

    }
    
    var installedPackagesList: some View {
        List(self.modules, id: \.self) { item in
            Text(item)
        }
    }
    
    // MARK: - Actions
    
    private func onClosePressed() {
        if self.pickedDocument?.hasUnsavedChanges == true {
            self.isHasChangedAlert = true
        } else {
            self.dismiss()
        }
    }
    
    private func onAddPackagePressed() {
        self.isAddShown = true
    }
    
    // MARK: - Private
    
    private func unsaveChangesAlert() -> Alert {
        return Alert(title: Text("Несохраненные изменения"),
                     message: Text("Вы действительно хотите выйти без сохранения?"),
                     primaryButton: .default(Text("Сохранить"), action: saveAndCloseDocument),
                     secondaryButton: .destructive(Text("Продолжить"), action: dismiss))
    }
    
    private func dismiss() {
        withAnimation { self.pickedDocument = nil }
    }
    
    private func saveAndCloseDocument() {
        self.pickedDocument?.close(completionHandler: { isClosed in
            if isClosed { self.dismiss() }
        })
    }
    
}

struct NewPackageView: View {
    var body: some View {
        ZStack {
            VStack {
                Text("")
            }
        }
        .navigationBarTitle("")
    }
}

struct SearchBar: View {
    
    @Binding var text: String
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .resizable()
                .frame(width: 14, height: 14)
            
            TextField("Поиск", text: $text)
        }
    }
}
