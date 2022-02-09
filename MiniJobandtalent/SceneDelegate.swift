import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    private let window = UIWindow()

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        window.windowScene = scene as? UIWindowScene
        window.rootViewController = UINavigationController(
            rootViewController: JobListViewController()
        )
        window.makeKeyAndVisible()
    }
}
