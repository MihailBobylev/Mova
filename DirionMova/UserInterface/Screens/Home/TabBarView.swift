//
//  TabBarView.swift
//  DirionMova
//
//  Created by Михаил Бобылев on 14.11.2022.
//

import SwiftUI

struct TabBarView: View {
    @State private var currentTab = "Home"
    @State private var hideTabBar = false
    var bottomEdge: CGFloat
    
    init(bottomEdge: CGFloat) {
        UITabBar.appearance().isHidden = true
        self.bottomEdge = bottomEdge
    }
    
    var body: some View {
        TabView(selection: $currentTab) {
            HomeView(tabSelection: $currentTab)
                .tag("Home")
            
            ExploreView(hideTabBar: $hideTabBar, bottomEdge: bottomEdge)
                .tag("Explore")
            
            MyListView(hideTabBar: $hideTabBar)
                .tag("My List")
            
            DownloadsView(hideTabBar: $hideTabBar, bottomEdge: bottomEdge)
                .tag("Downloads")
            
            ProfileAndSettingsView(hideTabBar: $hideTabBar)
                .tag("Profile")
        }
        .overlay(
            CustomTabBar(currentTab: $currentTab, bottomEdge: bottomEdge)
                .offset(y: hideTabBar ? (15 + 50 + bottomEdge) : 0)
            ,
            alignment: .bottom
        )
    }
}

struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        HomeTabView()
    }
}
