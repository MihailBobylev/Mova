//
//  CustomTabBar.swift
//  DirionMova
//
//  Created by Михаил Бобылев on 14.11.2022.
//

import SwiftUI

struct CustomTabBar: View {
    @Binding var currentTab: String
    var bottomEdge: CGFloat
    
    var body: some View {
        
        HStack {
            TabButton(currentTab: $currentTab, type: .home)
                .padding(.leading,16)
            TabButton(currentTab: $currentTab, type: .explore)
            TabButton(currentTab: $currentTab, type: .myList)
            TabButton(currentTab: $currentTab, type: .downloads)
            TabButton(currentTab: $currentTab, type: .profile)
                .padding(.trailing, 16)
        }
        .frame(height: 30)
        .padding(.top, 25)
        .padding(.bottom, bottomEdge)
        .background(Color(Color.TabBar.background))
        .cornerRadius(18, corners: [.topLeft, .topRight])
    }
}

struct CustomTabBar_Previews: PreviewProvider {
    static var previews: some View {
        HomeTabView()
    }
}

struct TabButton: View {
    @Binding var currentTab: String
    
    enum TabViewItemType {
        case home
        case explore
        case myList
        case downloads
        case profile
        
        var tabText: String {
            switch self {
            case .home:
                return "Home"
            case .explore:
                return "Explore"
            case .myList:
                return "My List"
            case .downloads:
                return "Downloads"
            case .profile:
                return "Profile"
            }
        }
        
        var image: String {
            switch self {
            case .home:
                return "home"
            case .explore:
                return "discovery"
            case .myList:
                return "bookmark"
            case .downloads:
                return "download"
            case .profile:
                return "profile"
            }
        }
        
        var text: Text {
            Text(tabText)
        }
    }
    
    var type: TabViewItemType
    
    var body: some View {
        Button {
            withAnimation {
                currentTab = type.tabText
            }
        } label: {
            VStack {
                currentTab == type.tabText ? Image(type.image+"Selected") : Image(type.image)
                type.text
                    .font(currentTab == type.tabText ? Font.Urbanist.Bold.size(of: 10) : Font.Urbanist.Medium.size(of: 10))
            }
            .frame(width: 58)
            .frame(maxWidth: .infinity)
            .foregroundColor(currentTab == type.tabText ? Color(UIColor.MOVA.primary500) : Color(UIColor.MOVA.greyscale500))
        }
    }
}
