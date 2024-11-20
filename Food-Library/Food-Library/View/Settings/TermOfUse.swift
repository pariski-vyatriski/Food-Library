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
                ScrollView {
                    LazyVStack(spacing: 6) {
                        VStack {
                            Text("1. Introduction")
                            Spacer()
                            Text("Bla-bla-bla")
                        }
                    }.navigationTitle("Term Of Use")
                }
            }
        }
    }
}
#Preview {
    TermOfUse()
}
