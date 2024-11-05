//
//  PrivacyPolicy.swift
//  Food-Library
//
//  Created by apple on 5.11.24.
//

import SwiftUI

struct PrivacyPolicy: View {
    var body: some View {
        ZStack {
            NavigationView {
                GeometryReader { geometry in
                    ScrollView {
                        LazyVStack(spacing: 6) {
                            VStack {

                            }
                        }.navigationTitle("Privacy Policy")
                    }
                }
            }
        }
    }
}


#Preview {
    PrivacyPolicy()
}
