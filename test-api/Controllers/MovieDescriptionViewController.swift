

import UIKit
import SnapKit

class MovieDescriptionViewController: UIViewController {
    
    var contentView = MovieView()
    
    var selectedIndex: Int = 0
    
    private lazy var contentSize = CGSize(width: self.view.frame.width, height: self.view.frame.height + 100)
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView(frame: .zero)
        scrollView.backgroundColor = .white
        scrollView.contentSize = contentSize
        scrollView.frame = self.view.bounds
        scrollView.autoresizingMask = .flexibleHeight
        scrollView.bounces = true
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(scrollView)
        setupContentView()
    }
    
    func setupContentView() {
        scrollView.addSubview(contentView)
        contentView.backgroundColor = .white
        //contentView.frame.size = contentSize
        contentView.snp.makeConstraints { make in
            make.leading.equalTo(view.snp.leading)
            make.trailing.equalTo(view.snp.trailing)

        }
    }
}
