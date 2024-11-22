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
                                    Button(action: {
                                        self.isShowingMailView.toggle()
                                    }, label: {
                                       Text("Contact Us")
                                            .foregroundColor(.black)
                                            .headers()
                                        Spacer()
                                        Image("arrow")
                                    }) .sheet(isPresented: $isShowingMailView) {
                                        MailView(isShowing: self.$isShowingMailView)
                                    }
                                }.padding(.bottom)

                                HStack {
                                    Button(action: {
                                        if let url = URL(string: "https://www.apple.com/by/app-store/") {
                                            UIApplication.shared.open(url)
                                        }
                                    }, label: {
                                       Text("Rate Us")
                                            .foregroundColor(.black)
                                            .headers()
                                        Spacer()
                                        Image("arrow")
                                    })
                                }.padding(.bottom)

                                NavigationLink(destination: PrivacyPolicy()) {
                                    HStack {
                                        Text("Privacy Policy")
                                            .foregroundColor(.black)
                                            .headers()
                                        Spacer()
                                        Image("arrow")
                                    }
                                }.padding(.bottom)

                                NavigationLink(destination: TermOfUse()) {
                                    HStack {
                                        Text("Terms Of Use")
                                            .foregroundColor(.black)
                                            .headers()
                                        Spacer()
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
