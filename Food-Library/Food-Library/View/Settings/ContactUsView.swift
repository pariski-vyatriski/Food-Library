import SwiftUI
import MessageUI

struct ContentView: View {
    @State private var isShowingMailView = false
    @State private var isShowingMessageView = false

    var body: some View {
        VStack {
            Spacer()
        }
    }
}

struct MailView: UIViewControllerRepresentable {
    @Binding var isShowing: Bool

    func makeUIViewController(context: Context) -> MFMailComposeViewController {
        let mailComposer = MFMailComposeViewController()
        mailComposer.setToRecipients(["food-library@gmail.com"])
        mailComposer.setSubject("Subject of the email")
        mailComposer.setMessageBody("Body of the email", isHTML: false)
        mailComposer.mailComposeDelegate = context.coordinator
        return mailComposer
    }

    func updateUIViewController(_ uiViewController: MFMailComposeViewController, context: Context) {}

    func makeCoordinator() -> MailCoordinator {
        return MailCoordinator(isShowing: $isShowing)
    }
}

class MailCoordinator: NSObject, MFMailComposeViewControllerDelegate {
    @Binding var isShowing: Bool

    init(isShowing: Binding<Bool>) {
        _isShowing = isShowing
    }

    func mailComposeController(
        _ controller: MFMailComposeViewController,
        didFinishWith result: MFMailComposeResult,
        error: Error?) {
        controller.dismiss(animated: true) {
            self.isShowing = false
        }
    }
}
