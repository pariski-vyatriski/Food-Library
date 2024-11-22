//
//  RateUs.swift
//  Food-Library
//
//  Created by apple on 22.11.24.
//

import SwiftUI

struct RateUs: View {
    var body: some View {
         Link("Visit SwiftyPlace",
               destination: URL(string: "https://www.apple.com/by/app-store/")!)
    }
}

#Preview {
    RateUs()
}
