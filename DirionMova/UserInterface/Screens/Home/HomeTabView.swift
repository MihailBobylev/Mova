//
//  HomeView.swift
//  DirionMova
//
//  Created by Юрий Альт on 12.10.2022.
//

import SwiftUI

struct HomeTabView: View {
    var body: some View {
        GeometryReader { geo in
            let bottomAge = geo.safeAreaInsets.bottom
            
            TabBarView(bottomEdge: (bottomAge == 0 ? 15.dvs : bottomAge))
                .ignoresSafeArea(.all, edges: .bottom)
        }
        .ignoresSafeArea(.keyboard, edges: .bottom)
    }
}

struct HomeTabView_Previews: PreviewProvider {
    static var previews: some View {
        HomeTabView()
    }
}
