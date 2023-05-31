//
//  DeviderView.swift
//  DirionMova
//
//  Created by Юрий Альт on 07.11.2022.
//

import SwiftUI

struct HDeviderView: View {
    var body: some View {
        Rectangle()
            .frame(height: 1.dvs)
            .foregroundColor(.RatingBottomSheet.horizontalDevider)
    }
}

struct DeviderView_Previews: PreviewProvider {
    static var previews: some View {
        HDeviderView()
    }
}
