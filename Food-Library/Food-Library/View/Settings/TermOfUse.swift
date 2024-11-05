//
//  TermOfUse.swift
//  Food-Library
//
//  Created by apple on 5.11.24.
//

import SwiftUI

struct TermOfUse: View {
    var body: some View {
        ZStack {
            NavigationView {
                GeometryReader { geometry in
                    ScrollView {
                        LazyVStack(spacing: 6) {
                            VStack {

                            }
                        }.navigationTitle("Term Of Use")
                    }
                }
            }
        }
    }
}
#Preview {
    TermOfUse()
}
