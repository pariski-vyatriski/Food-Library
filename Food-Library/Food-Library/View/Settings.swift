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
                                        self.isShowingMailView.toggle()  // Открываем почтовый композитор
                                    }, label: {
                                        Image("arrow")
                                    })
                                    .sheet(isPresented: $isShowingMailView) {  // Открываем модальное окно для письма
                                        MailComposeViewControllerWrapper(isShowing: self.$isShowingMailView)
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

struct MailComposeViewControllerWrapper: UIViewControllerRepresentable {
    @Binding var isShowing: Bool  // Связь с состоянием отображения почтового окна

    func makeUIViewController(context: Context) -> MFMailComposeViewController {
        let composeVC = MFMailComposeViewController()
        composeVC.setSubject("Subject of the email")
        composeVC.setMessageBody("Body of the email", isHTML: false)
        composeVC.mailComposeDelegate = context.coordinator
        return composeVC
    }

    // Обновление состояния компонента (здесь не требуется)
    func updateUIViewController(_ uiViewController: MFMailComposeViewController, context: Context) {}

    // Делегат для обработки результата отправки письма
    func makeCoordinator() -> MailCoordinator {
        return MailCoordinator(isShowing: $isShowing)
    }
}

class MailCoordinator: NSObject, MFMailComposeViewControllerDelegate {
    @Binding var isShowing: Bool

    init(isShowing: Binding<Bool>) {
        _isShowing = isShowing
    }

    func mailComposeController(_ controller: MFMailComposeViewController,
                               didFinishWith result: MFMailComposeResult,
                               error: Error?) {
        controller.dismiss(animated: true) {
            self.isShowing = false
        }
    }
}
