import SwiftUI
import WebKit

struct TermOfUse: View {
    var body: some View {
        WebView(fileName: "TermOfUse")
            .edgesIgnoringSafeArea(.all)
            .navigationTitle("Privacy Policy")
    }
}

struct WebViewAnother: UIViewRepresentable {
    let fileName: String

    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {

        if let url = Bundle.main.url(forResource: fileName, withExtension: "html") {
            print("URL найден: \(url)")  // Отладочное сообщение для проверки пути
            let request = URLRequest(url: url)  // Создаем запрос для загрузки файла
            uiView.load(request)  // Загружаем файл в WebView
        } else {
            print("Ошибка: Не удалось найти файл \(fileName).html в основном бандле")  // Сообщение об ошибке
        }
    }
}
