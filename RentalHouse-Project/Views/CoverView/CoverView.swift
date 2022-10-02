//
//  CoverView.swift
//  RentalHouse-Project
//
//  Created by Kuan on 2022/10/2.
//

import SwiftUI

struct CoverView: View {
    var body: some View {
        ZStack {
            Color.black.opacity(0.95)
            VStack {
                Text("Uploading...")
                    .foregroundColor(.white)
                    .font(.title2)
                ProgressView()
                    .tint(.white)
            }
            .frame(width: AppVM.uiScreenWidth * 0.4, height: AppVM.uiScreenHeight * 0.15)
            .modifier(FlatGlass())
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .edgesIgnoringSafeArea([.top, .bottom])
    }
}

struct CoverView_Previews: PreviewProvider {
    static var previews: some View {
        CoverView()
    }
}
