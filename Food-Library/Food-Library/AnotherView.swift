//
//  AnotherView.swift
//  Food-Library
//
//  Created by apple on 21.11.24.
//

import SwiftUI
import FirebaseCrashlytics

struct AnotherView: View {

    var body: some View {
        VStack {
            Button("Crash") {
              fatalError("Crash was triggered")
            }
        }
    }
}

struct AnotherView_Previews: PreviewProvider {
    static var previews: some View {
        AnotherView()
    }
}
