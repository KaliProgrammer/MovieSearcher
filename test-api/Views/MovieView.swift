
import Foundation
import UIKit
import SnapKit

class MovieView: UIView {

     lazy var movieImage: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 12
        imageView.layer.masksToBounds = true
        return imageView
    }()

    lazy var movieNameLabel: UILabel = {
       let label = UILabel()
       label.numberOfLines = 0
       label.font = UIFont.systemFont(ofSize: 22, weight: .bold)
       label.backgroundColor = .white
       return label
   }()

     lazy var movieDescriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.backgroundColor = .white
        return label
    }()
    
    lazy var movieRatingLabel: UILabel = {
       let label = UILabel()
       label.numberOfLines = 0
       label.font = UIFont.systemFont(ofSize: 30, weight: .bold)
       label.textColor = .black
       label.backgroundColor = .white
       return label
   }()
    
    lazy var movieYearLabel: UILabel = {
       let label = UILabel()
       label.numberOfLines = 0
       label.font = UIFont.systemFont(ofSize: 28, weight: .bold)
       label.textColor = .black
       label.backgroundColor = .white
        label.textAlignment = .right
       return label
   }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupText()
        setupImage()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
     func setupImage() {
         self.addSubview(movieImage)
         movieImage.snp.makeConstraints { make in
             make.top.equalTo(self.safeAreaLayoutGuide.snp.top).offset(16)
             make.leading.equalTo(self.safeAreaLayoutGuide.snp.leading).offset(80)
             make.trailing.equalTo(self.safeAreaLayoutGuide.snp.trailing).offset(-80)
             make.height.equalTo(300)
         }
    }
    
     func setupText() {
         self.addSubview(movieNameLabel)
         self.addSubview(movieDescriptionLabel)
         self.addSubview(movieRatingLabel)
         self.addSubview(movieYearLabel)
         
         movieNameLabel.snp.makeConstraints { make in
             make.top.equalTo(self.snp.top).offset(340)
             make.leading.equalTo(self.snp.leading).offset(16)
             make.trailing.equalTo(self.snp.trailing).offset(-16)
             make.bottom.equalTo(movieDescriptionLabel.snp.top).offset(-16)
         }
         
         movieDescriptionLabel.snp.makeConstraints { make in
             make.top.equalTo(self.snp.top).offset(380)
             make.leading.equalTo(self.snp.leading).offset(16)
             make.trailing.equalTo(self.snp.trailing).offset(-16)
             make.bottom.equalTo(movieRatingLabel.snp.top).offset(-20)
         }
         
         movieRatingLabel.snp.makeConstraints { make in
             make.top.equalTo(movieDescriptionLabel.snp.bottom).offset(20)
             make.leading.equalTo(self.snp.leading).offset(16)
             make.trailing.equalTo(self.snp.trailing).offset(-16)
             make.bottom.equalTo(self.snp.bottom)
         }
         
         movieYearLabel.snp.makeConstraints { make in
             make.top.equalTo(movieDescriptionLabel.snp.bottom).offset(20)
             make.trailing.equalTo(self.snp.trailing).offset(-16)
             make.bottom.equalTo(self.snp.bottom)
         }
    }
}



