
import UIKit
import SnapKit

class SearchViewController: UIViewController{
    
    private lazy var searchByMoviesNameButton: ButtonWithShadow = {
        let button = ButtonWithShadow()
        
        button.addTarget(self, action: #selector(searchByName), for: .touchUpInside)
        button.setTitle("Поиск по названию фильма", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        button.setTitleColor(.white, for: .normal)
        button.setTitleColor(.init(white: 0, alpha: 0.8), for: .selected)
        button.setTitleColor(.white, for: .disabled)
        button.setTitleColor(.white, for: .highlighted)
        button.backgroundColor = .black
        button.layer.cornerRadius = 10
        button.layer.shadowOffset = CGSize(width: 4, height: 4)
        button.layer.shadowRadius = 4
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 1.7
        return button
    }()
    private lazy var searchByPersonsNameButton: ButtonWithShadow = {
        let button = ButtonWithShadow()
        
//        button.addTarget(self, action: #selector(addAsanas), for: .touchUpInside)
        button.setTitle("Поиск по актёрам и режиссёрам", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        button.setTitleColor(.white, for: .normal)
        button.setTitleColor(.init(white: 0, alpha: 0.8), for: .selected)
        button.setTitleColor(.white, for: .disabled)
        button.setTitleColor(.white, for: .highlighted)
        button.backgroundColor = .black
        button.layer.cornerRadius = 10
        button.layer.shadowOffset = CGSize(width: 4, height: 4)
        button.layer.shadowRadius = 4
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 1.7
        return button
    }()
    
    private lazy var searchByGenreButton: ButtonWithShadow = {
        let button = ButtonWithShadow()
        
//        button.addTarget(self, action: #selector(searchByGenre), for: .touchUpInside)
        button.setTitle("Поиск по жанру фильма", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        button.setTitleColor(.white, for: .normal)
        button.setTitleColor(.init(white: 0, alpha: 0.8), for: .selected)
        button.setTitleColor(.white, for: .disabled)
        button.setTitleColor(.white, for: .highlighted)
        button.backgroundColor = .black
        button.layer.cornerRadius = 10
        button.layer.shadowOffset = CGSize(width: 4, height: 4)
        button.layer.shadowRadius = 4
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 1.7
        return button
    }()
    
    @objc func searchByName() {
        let viewController = SearchResultViewController()
        self.present(UINavigationController(rootViewController: viewController), animated: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigation()
        setupElements()
    }
    
    func setupNavigation() {
        view.backgroundColor = .systemYellow
        self.navigationItem.title = "Поиск"
        self.navigationItem.largeTitleDisplayMode = .always
    }
    
    func setupElements() {
        view.addSubview(searchByMoviesNameButton)
        view.addSubview(searchByPersonsNameButton)
        view.addSubview(searchByGenreButton)
        searchByMoviesNameButton.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(200)
            make.leading.equalTo(self.view.snp.leading).offset(16)
            make.trailing.equalTo(self.view.snp.trailing).offset(-16)
            make.height.equalTo(50)
            make.centerX.equalTo(self.view.snp.centerX)
        }
        searchByPersonsNameButton.snp.makeConstraints { make in
            make.top.equalTo(searchByMoviesNameButton.snp.bottom).offset(10)
            make.leading.equalTo(self.view.snp.leading).offset(16)
            make.trailing.equalTo(self.view.snp.trailing).offset(-16)
            make.height.equalTo(50)
            make.centerX.equalTo(self.view.snp.centerX)
        }
        searchByGenreButton.snp.makeConstraints { make in
            make.top.equalTo(searchByPersonsNameButton.snp.bottom).offset(10)
            make.leading.equalTo(self.view.snp.leading).offset(16)
            make.trailing.equalTo(self.view.snp.trailing).offset(-16)
            make.height.equalTo(50)
            make.centerX.equalTo(self.view.snp.centerX)
        }
    }


}
