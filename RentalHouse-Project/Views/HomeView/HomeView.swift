//
//  HomeView.swift
//  RentalHouse-Project
//
//  Created by Kuan on 2022/8/30.
//

import SwiftUI

struct HomeView: View {
    @State private var searchingContext = ""
    var body: some View {
        VStack {
            HStack {
                Text("Find Your Perfect Spot")
                    .font(.title)
                    .fontWeight(.heavy)
                Spacer()
            }
            SearchBar(input: $searchingContext)
            ScrollView(.vertical, showsIndicators: false) {
                ReuseableCard(objectName: "Some item", objectPrice: "59")
            }
        }
        .modifier(ViewBackground())
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
