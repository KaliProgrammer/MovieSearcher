
import UIKit
import SnapKit

protocol CollectionViewCellProtocol {
    func configure(withModel model: MoviesListCellModel)
}

class MoviesListCollectionViewCell: UICollectionViewCell {
    
    lazy var movieImageView: UIImageView = {
        let movieImage = UIImageView()
        movieImage.layer.cornerRadius = 22
        movieImage.layer.masksToBounds = true
        return movieImage
    }()
    
    lazy var movieTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.textColor = .yellow
        label.numberOfLines = 0
        return label
    }()
    
    lazy var summaryLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
        label.textColor = .white

        label.numberOfLines = 0
        return label
    }()
    lazy var ratingLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        label.textColor = .yellow
        return label
    }()
    lazy var yearLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        label.textColor = .yellow
        label.textAlignment = .right

        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews([movieImageView,
                     movieTitleLabel,
                     summaryLabel,
                     ratingLabel,
                     yearLabel])
        setupElements()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        movieImageView.kf.cancelDownloadTask()
        movieImageView.image = nil
        movieTitleLabel.text = ""
        summaryLabel.text = ""
        ratingLabel.text = ""
        yearLabel.text = ""
    }
    
   private func addSubviews(_ subview: [UIView]) {
        for item in subview {
            contentView.addSubview(item)
        }
    }
    
    private func setupElements() {
        contentView.backgroundColor = .black
        contentView.layer.cornerRadius = 22

        movieImageView.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top).offset(10)
            make.bottom.equalTo(contentView.snp.bottom).offset(-10)
            make.leading.equalTo(contentView.snp.leading).offset(15)
            make.width.equalTo(150)
        }
        movieTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top).offset(10)
            make.leading.equalTo(movieImageView.snp.trailing).offset(10)
            make.trailing.equalTo(contentView.snp.trailing).offset(-5)
            make.height.equalTo(30)
        }
        summaryLabel.snp.makeConstraints { make in
            make.top.equalTo(movieTitleLabel.snp.bottom)
            make.leading.equalTo(movieImageView.snp.trailing).offset(10)
            make.width.equalTo(170)
            make.height.equalTo(110)

        }
        ratingLabel.snp.makeConstraints { make in
            make.top.equalTo(summaryLabel.snp.bottom).offset(15)
            make.leading.equalTo(movieImageView.snp.trailing).offset(10)
            make.width.equalTo(90)
            make.bottom.equalTo(contentView).offset(-10)
        }
        yearLabel.snp.makeConstraints { make in
            make.bottom.equalTo(contentView).offset(-10)
            make.width.equalTo(100)
            make.trailing.equalTo(contentView.snp.trailing).offset(-20)
            make.top.equalTo(summaryLabel.snp.bottom).offset(15)

        }
    }
}
