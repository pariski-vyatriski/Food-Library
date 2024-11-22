import SwiftUI
import MessageUI

struct Settings: View {
    @State private var isShowingMailView = false

    var body: some View {
        ZStack {
            NavigationView {
                GeometryReader { geometry in
                    ScrollView {
                        LazyVStack(spacing: 6) {
                            VStack {
                                HStack(spacing: 16) {
                                    Text("Contact Us")
                                        .headers()
                                    Spacer()

                                    Button(action: {
                                        self.isShowingMailView.toggle()
                                    }, label: {
                                        Image("arrow")
                                    })
                                    .sheet(isPresented: $isShowingMailView) {
                                        MailView(isShowing: self.$isShowingMailView)
                                    }
                                }.padding(.bottom)

                                HStack {
                                    Text("Rate Us")
                                        .headers()
                                    Spacer()
                                    NavigationLink(destination: RateUs()) {
                                        Image("arrow")
                                    }
                                }.padding(.bottom)
                                HStack {
                                    Text("Privacy Policy")
                                        .headers()
                                    Spacer()
                                    NavigationLink(destination: PrivacyPolicy()) {
                                        Image("arrow")
                                    }
                                }.padding(.bottom)
                                HStack {
                                    Text("Term of Use")
                                        .headers()
                                    Spacer()
                                    NavigationLink(destination: TermOfUse()) {
                                        Image("arrow")
                                    }
                                }.padding(.bottom)
                            }.padding(.top)
                        }
                        .navigationTitle("Settings")
                        .frame(idealWidth: geometry.size.width)
                        .padding(.horizontal, 26)
                    }
                }
            }
        }
    }
}
