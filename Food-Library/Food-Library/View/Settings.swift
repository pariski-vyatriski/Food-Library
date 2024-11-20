//
//  Settings.swift
//  Food-Library
//
//  Created by apple on 5.11.24.
//

import SwiftUI
import MessageUI

struct Settings: View {
    @State private var showingNextScreenOnSettings = false
    var body: some View {
        ZStack {
            NavigationView {
                GeometryReader { geometry in
                    ScrollView {
                        LazyVStack(spacing: 6) {
                            VStack {
                                HStack(spacing: 16) {
                                    Text("Contact Us")
                                        .textStyle()
                                    Spacer()
                                    NavigationLink(destination: ContactUsView()) {
                                        Image("arrow")
                                    }
                                }.padding(.bottom)
                                HStack {
                                    Text("Rate Us")
                                        .textStyle()
                                    Spacer()
                                    NavigationLink(destination: RateUs()) {
                                        Image("arrow")
                                    }
                                }.padding(.bottom)
                                HStack {
                                    Text("Privacy Policy")
                                        .textStyle()
                                    Spacer()
                                    NavigationLink(destination: PrivacyPolicy()) {
                                        Image("arrow")
                                    }
                                }.padding(.bottom)
                                HStack {
                                    Text("Term of Use")
                                        .textStyle()
                                    Spacer()
                                    NavigationLink(destination: TermOfUse()) {
                                        Image("arrow")
                                    }
                                }.padding(.bottom)
                            }.padding(.top)
                        }.navigationTitle("Settings")
                        //                            .frame(minHeight: geometry.size.height)
                            .frame(idealWidth: geometry.size.width)
                            .padding(.horizontal, 26)
                    }
                }
            }
        }
    }
}
