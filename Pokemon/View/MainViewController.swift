//
//  ViewController.swift
//  Pokemon
//
//  Created by bloom on 8/1/24.
//

import UIKit
import SnapKit
import RxSwift

class MainViewController: UIViewController {
  private let viewModel = PokemonViewModel()
  private let diposeBag = DisposeBag()
  private var pokemonImages = ""
  
  private let imageView = {
    let iv = UIImageView()
    iv.image = UIImage(named: "pokeBallImage")
    iv.layer.borderColor = UIColor.white.cgColor
    iv.layer.borderWidth = 1.5
    iv.layer.cornerRadius = 65
    iv.contentMode = .scaleAspectFit
    iv.clipsToBounds = true
    
    return iv
  }()
  
  lazy var collectionView = {
    let cv = UICollectionView(frame: .zero,collectionViewLayout: createLayout())
    cv.register(PokemonCell.self, forCellWithReuseIdentifier: PokemonCell.id)
    cv.delegate = self
    cv.dataSource = self
    cv.backgroundColor = .black
    return cv
  }()
  


  override func viewDidLoad() {
    super.viewDidLoad()
    configureUI()
    // Do any additional setup after loading the view.
  }
  
  
  
  
  private func createLayout() -> UICollectionViewLayout {
    
    let itemSize = NSCollectionLayoutSize(
      widthDimension: .fractionalWidth(1.0),
      heightDimension: .fractionalHeight(1.0)
    )
    let item = NSCollectionLayoutItem(layoutSize: itemSize)
    
    let  groupSize = NSCollectionLayoutSize(
      widthDimension: .fractionalWidth(1.0),
      heightDimension: .fractionalHeight(1.0)
    )
    let group = NSCollectionLayoutGroup(layoutSize: groupSize)
    
    let section = NSCollectionLayoutSection(group: group)
    section.orthogonalScrollingBehavior = .continuous
    section.interGroupSpacing = 10
    section.contentInsets = .init(top: 10, leading: 10, bottom: 20, trailing: 10)
    
    
    return UICollectionViewCompositionalLayout(section: section)
    
  }

  
  private func configureUI() {
    view.backgroundColor = UIColor.mainRed
    
    [
      imageView,
    
    ].forEach{view.addSubview($0)}
    
    imageView.snp.makeConstraints{
      $0.centerX.equalToSuperview()
      $0.top.equalToSuperview().offset(90)
      $0.width.equalTo(130)
      $0.height.equalTo(130)
    }

  }
  


}

extension MainViewController: UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let detailViewController = DetailViewController()
/// 여기에서 값을 전달 해줘야함
    detailViewController.pokemon = nil
    
    self.navigationController?.pushViewController(detailViewController, animated: true)

  }
}


extension MainViewController: UICollectionViewDataSource{
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 0
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    return UICollectionViewCell()
  }
  
  
}
