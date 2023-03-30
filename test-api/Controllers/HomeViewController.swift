

import UIKit
import SnapKit
import Combine

protocol NetworkProtocol {
    func checkNetwork()
}

extension NetworkProtocol {
    func checkNetwork(in vc: UIViewController) {
        if !NetworkMonitor.shared.isConnected {
            let alert = UIAlertController(title: "Нет интернета", message: "Убедитесь, что вы подключены к Wi-Fi", preferredStyle: .alert)
            let action = UIAlertAction(title: "Ok", style: .cancel)
            alert.addAction(action)
            vc.present(alert, animated: true)
        }
    }
}

class HomeViewController: UIViewController {
    
    private var cancellable: AnyCancellable?

    
    
    private let networkLayer: NetworkLayer = URLSessionLayer()
    var movies: Movies?
    
    let baseAddressForMovies = "https://api.kinopoisk.dev/v1/movie?random"
    
    private lazy var navigationCollection: UICollectionView = {
        let screenSize = UIScreen.main.bounds
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 12, left: 0, bottom: 12, right: 0)
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.delegate = self
        collection.dataSource = self
        collection.showsVerticalScrollIndicator = false
        collection.backgroundColor = .systemYellow
        collection.register(CollectionViewCell.self, forCellWithReuseIdentifier: CollectionViewCell.identifier)
        return collection
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigation()
        view.addSubview(navigationCollection)
        
        
        navigationCollection.snp.makeConstraints { make in
            make.top.equalTo(self.view.snp.top)
            make.leading.equalTo(self.view).offset(15)
            make.trailing.equalTo(self.view).offset(-15)
            make.bottom.equalTo(self.view.snp.bottom)
        }
        
        if let url = URL(string: baseAddressForMovies) {
            var request = URLRequest(url: url)
            request.allHTTPHeaderFields = [
                "X-API-Key": "MFQ8GKZ-7TS4W7J-NZ1CVE9-5MKJ9MW"
            ]
            
            self.cancellable = URLSession.shared
                .dataTaskPublisher(for: request)
                .receive(on: DispatchQueue.main)
                .map({ $0.data})
                .decode(type: Movies.self, decoder: JSONDecoder())
                .eraseToAnyPublisher()
                .sink(receiveCompletion: { completion in
                    if case .failure (let error) = completion {
                        print("Retrieving data failed with error \(error)")
                    }
                }, receiveValue: { data in
                    self.movies = data
                    self.navigationCollection.reloadData()
                })
        }
    }
    
    func setupNavigation() {
        view.backgroundColor = .systemYellow
        self.navigationItem.title = "Главная"
        self.navigationItem.largeTitleDisplayMode = .always
    }
}

