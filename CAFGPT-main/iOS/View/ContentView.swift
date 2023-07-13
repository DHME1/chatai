//
//  ContentView.swift
//  Shared
//
//  Created by CAF , twitter @ivd_2 dhme 2023/2/17.
//

import SwiftUI

struct ContentView: View {
        
    @EnvironmentObject var vm: ViewModel
    
    var body: some View {
        NavigationView {
            MainView()
                .navigationBarTitleDisplayMode(.inline)
                .navigationTitle("ChatGPT")
                .toolbar {
                    trailNavitationBar
                }
        }
    }
    
    var trailNavitationBar: some ToolbarContent {
        ToolbarItem(placement: .navigationBarTrailing) {
            NavigationLink {
                SettingView()
            } label: {
                Image(systemName: "gearshape")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(ViewModel())
    }
}
