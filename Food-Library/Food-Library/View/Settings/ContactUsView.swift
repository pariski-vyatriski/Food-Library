//
//  bvjhfb.swift
//  Food-Library
//
//  Created by apple on 5.11.24.
//

import SwiftUI
import MessageUI

struct ContactUsView: View {
    @State private var isShowingMailView = false
    @State private var mailErrorMessage = ""
    let emailAddress = "a.dzmitranok@dreamteam-apps.com"

    var body: some View {
        NavigationView {
            VStack {
                Button(action: {
                    if MFMailComposeViewController.canSendMail() {
                        self.isShowingMailView = true
                    } else {
                        mailErrorMessage = "Mail services are not available. Please configure your email account."
                    }
                }, label: {
                    Text("Send Email")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                })
                .padding()
                if !mailErrorMessage.isEmpty {
                    Text(mailErrorMessage)
                        .foregroundColor(.red)
                        .padding()
                }
            }
            .navigationTitle("Mail App Example")
            .sheet(isPresented: $isShowingMailView) {
                MailView(isShowing: $isShowingMailView, email: emailAddress)
            }
        }
    }
}

struct MailView: UIViewControllerRepresentable {
    @Binding var isShowing: Bool
    let email: String

    func makeUIViewController(context: Context) -> MFMailComposeViewController {
        // Проверяем, что почтовое приложение доступно
        guard MFMailComposeViewController.canSendMail() else {
            return MFMailComposeViewController() // Возвращаем пустой контроллер, если почта недоступна
        }

        let mailComposer = MFMailComposeViewController()
        mailComposer.setToRecipients([email])  // Указываем email получателя
        mailComposer.setSubject("Your Subject Here")  // Указываем тему письма
        mailComposer.setMessageBody("Your email body here", isHTML: false)  // Текст письма

        mailComposer.mailComposeDelegate = context.coordinator
        return mailComposer
    }

    func updateUIViewController(_ uiViewController: MFMailComposeViewController, context: Context) {
        // Не нужно ничего обновлять здесь, так как нам не нужно обновлять UI
    }

    func makeCoordinator() -> Coordinator {
        return Coordinator(isShowing: $isShowing)
    }

    class Coordinator: NSObject, MFMailComposeViewControllerDelegate {
        @Binding var isShowing: Bool

        init(isShowing: Binding<Bool>) {
            _isShowing = isShowing
        }

        func mailComposeController(
            _ controller: MFMailComposeViewController,
            didFinishWith result: MFMailComposeResult,
            error: Error?
        ) {
            // Закрываем почтовое приложение, когда письмо отправлено или отменено
            if let error = error {
                print("Error sending mail: \(error.localizedDescription)")
            }

            // Проверяем, какой результат был получен
            switch result {
            case .sent:
                print("Email sent successfully!")
            case .saved:
                print("Email saved as draft.")
            case .cancelled:
                print("Email sending cancelled.")
            case .failed:
                print("Email sending failed.")
            @unknown default:
                print("Unknown mail result.")
            }
            self.isShowing = false
        }
    }
}
