
import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        let vc1 = UINavigationController(rootViewController: HomeViewController())
        vc1.tabBarItem.image = UIImage(systemName: "house")
        vc1.title = "Главная"
        vc1.tabBarItem.title = "Главная"
        vc1.navigationBar.prefersLargeTitles = true

        let vc2 = UINavigationController(rootViewController: SearchViewController())
        vc2.tabBarItem.image = UIImage(systemName: "magnifyingglass")
        vc2.title = "Поиск"
        vc2.tabBarItem.title = "Поиск"
        vc2.navigationBar.prefersLargeTitles = true
        setViewControllers([vc1, vc2], animated: true)
        tabBar.tintColor = .label
    }
}
