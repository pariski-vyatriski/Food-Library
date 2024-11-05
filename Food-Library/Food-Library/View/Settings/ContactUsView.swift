//
//  bvjhfb.swift
//  Food-Library
//
//  Created by apple on 5.11.24.
//

import SwiftUI

struct ContactUsView: View {
    var body: some View {
        ZStack {
            NavigationView {
                GeometryReader { geometry in
                    ScrollView {
                        LazyVStack(spacing: 6) {
                            VStack {
                                Text("Email adress: FoodLibrary@gmail.com")
                            }
                        }.navigationTitle("Contact Us")
                    }
                }
            }
        }
    }
}

#Preview {
    ContactUsView()
}
