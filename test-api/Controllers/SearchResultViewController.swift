
import UIKit
import SnapKit

enum SearchType {
    case name, genre, actor
}

struct CustomDataForAllMovies: Equatable {
    var image: String
}

class SearchResultViewController: UIViewController {
 
    var searchType: SearchType = .name

    private var movies = [MoviesListCellModel]()

    private let networkLayer: NetworkService = NetworkServiceImpl()

    var isFound: Bool?
    private var page: Int = 1
    private var pagesCount = 1
    private var total = 0
    private var limit = 10

    private lazy var collectionLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 12, left: 0, bottom: 12, right: 0)
        return layout
    }()

    private lazy var searchNavigationCollection: UICollectionView = {
        let collection = UICollectionView(frame: .zero, collectionViewLayout: self.collectionLayout)
        collection.delegate = self
        collection.dataSource = self
        collection.prefetchDataSource = self
        collection.showsVerticalScrollIndicator = false
        collection.backgroundColor = .systemYellow
        collection.register(MoviesListCollectionViewCell.self, forCellWithReuseIdentifier: MoviesListCollectionViewCell.reuseIdentifier)
        collection.register(LoadCollectionViewCell.self, forCellWithReuseIdentifier: LoadCollectionViewCell.reuseIdentifier)
        return collection
    }()

    private lazy var backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemYellow
        return view
    }()
    
    lazy var searchBar: UISearchBar = {
        let search = UISearchBar()
        search.delegate = self
        search.tintColor = .gray
        search.contentMode = .top
        search.isTranslucent = true
        search.autocapitalizationType = .words
        search.placeholder = "Введите название фильма"
        return search
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupBackgroundView()
        setupCollectionView()
        setupSearchBar()
        
//        AppDelegate.AppUtility.lockOrientation(.portrait, andRotateTo: .portrait)
        
    }
    
    func setupBackgroundView() {
        self.view.addSubview(backgroundView)
        
        backgroundView.snp.makeConstraints { make in
            make.top.bottom.equalTo(self.view)
            make.leading.trailing.equalTo(self.view)
        }
    }
    
    func setupSearchBar() {
        self.backgroundView.addSubview(searchBar)
        
        searchBar.snp.makeConstraints { make in
            make.top.equalTo(self.backgroundView.safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(self.searchNavigationCollection.snp.top)
            make.leading.trailing.equalTo(self.backgroundView)
        }
    }
    
    func setupCollectionView() {
        self.view.addSubview(searchNavigationCollection)
        searchNavigationCollection.snp.makeConstraints { make in
            make.top.bottom.equalTo(self.view.safeAreaLayoutGuide).offset(50)
            make.leading.trailing.equalTo(self.view.safeAreaLayoutGuide)
        }
    }

    // MARK: - Private methods

    private func fetchData() {
        let info: SearchInfo
        switch searchType {
        case .name:
            info = SearchInfo(name: searchBar.text, genre: nil, actor: nil)
        case .genre:
            info = SearchInfo(name: nil, genre: searchBar.text, actor: nil)
        case .actor:
            info = SearchInfo(name: nil, genre: nil, actor: searchBar.text)
        }
        let request = SearchRequest(page: "\(page)", info: info)
        networkLayer.getMovies(searchRequest: request) { [weak self] result in
            switch result {
            case .failure(let error):
                print(error.description)
            case .success(let result):
                if let movies = result.docs {
                    let newMovies = movies.map { MoviesListCellModel(docModel: $0) }
                    self?.movies.append(contentsOf: newMovies)
                    if let count = result.pages {
                        self?.pagesCount = count
                        self?.total = result.total ?? 0
                    }
                    DispatchQueue.main.async {
                        self?.searchNavigationCollection.reloadData()
                    }
                }
            }
        }
    }
}

extension SearchResultViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        page = 1
        pagesCount = 1
        movies = []
        fetchData()
        searchBar.endEditing(false)
    }
}

extension SearchResultViewController: UICollectionViewDataSourcePrefetching {
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        let downloaded = limit * page
        if  downloaded < (indexPaths.last?.row ?? 0) {
            page += 1
            guard pagesCount > page else {
                return
            }
            fetchData()
        }
    }
}

extension SearchResultViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        total
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let model = movies[safe: indexPath.row] {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MoviesListCollectionViewCell.reuseIdentifier,
                                                          for: indexPath)

            if let cell = cell as? CollectionViewCellProtocol {
                cell.configure(withModel: model)
            }
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LoadCollectionViewCell.reuseIdentifier,
                                                          for: indexPath)
            return cell
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if movies[safe: indexPath.row] != nil {
            return CGSize(width: view.frame.width - 30, height: view.frame.width/2)
        } else {
            return CGSize(width: view.frame.width, height: 60)
        }
    }
}
