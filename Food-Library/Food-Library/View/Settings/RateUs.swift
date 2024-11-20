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
                ScrollView {
                    LazyVStack(spacing: 6) {
                        VStack {
                            Text("Bububu")
                        }
                    }.navigationTitle("Rate Us")
                }
            }
        }
    }
}

#Preview {
    RateUs()
}
