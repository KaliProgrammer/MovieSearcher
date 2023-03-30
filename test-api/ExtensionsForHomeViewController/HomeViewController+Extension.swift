

import UIKit

extension HomeViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        movies?.docs?.count ?? 0
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCell.identifier, for: indexPath) as? CollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.backgroundColor = .black
        cell.layer.cornerRadius = 22
        cell.apply(image: movies?.docs?[indexPath.row].poster?.url ?? "" )
        cell.apply(title: movies?.docs?[indexPath.row].name ?? "")
        cell.apply(summary: movies?.docs?[indexPath.row].shortDescription ?? "")
        let rating = movies?.docs?[indexPath.row].rating?.kp
        let decimalRating = Double(round(10 * rating!)/10)
        cell.apply(rating: decimalRating)
        cell.apply(year: movies?.docs?[indexPath.row].year ?? 0)
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width - 30, height: view.frame.width/2)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let viewModel = MovieViewModel()
        let viewController = MovieDescriptionViewController()
        viewController.selectedIndex = indexPath.row
        viewModel.apply(textDescription: movies?.docs?[indexPath.row].description ?? "", from: viewController.contentView)
        viewModel.loadImage(image: movies?.docs?[indexPath.row].poster?.url ?? "", from: viewController.contentView)
        viewModel.apply(movieName: movies?.docs?[indexPath.row].name ?? "", from: viewController.contentView)
        let rating = movies?.docs?[indexPath.row].rating?.kp
        let decimalRating = Double(round(10 * rating!)/10)
        viewModel.apply(movieRating: decimalRating , from: viewController.contentView)
        viewModel.apply(movieYear: movies?.docs?[indexPath.row].year ?? 0, from: viewController.contentView)

        navigationController?.present(viewController, animated: true)
    }
    
}

