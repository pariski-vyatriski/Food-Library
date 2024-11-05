//
//  RateUs.swift
//  Food-Library
//
//  Created by apple on 5.11.24.
//

import SwiftUI

struct RateUs: View {
    var body: some View {
        ZStack {
            NavigationView {
                GeometryReader { geometry in
                    ScrollView {
                        LazyVStack(spacing: 6) {
                            VStack {

                            }
                        }.navigationTitle("Rate Us")
                    }
                }
            }
        }
    }
}

#Preview {
    RateUs()
}
