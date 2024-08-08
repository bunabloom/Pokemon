//
//  ViewController.swift
//  Pokemon
//
//  Created by bloom on 8/1/24.
//

import UIKit
import SnapKit
import RxSwift

final class MainViewController: UIViewController {
  
  private var isReloaded: Bool = false
  private let viewModel = MainViewModel()
  private let diposeBag = DisposeBag()
  private var pokemonListSubject = [ResponseResult]()
  
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
    let x = UICollectionView(frame: .zero,collectionViewLayout: createCellLayout())
    x.register(PokemonCell.self, forCellWithReuseIdentifier: PokemonCell.id)
    x.delegate = self
    x.dataSource = self
    x.backgroundColor = .darkRed
    return x
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configureUI()
    bind()
  }
  
  private func bind() {
    viewModel.pokemonSubject
      .observe(on: MainScheduler.instance)
      .subscribe(onNext: {[weak self] lists in
        self?.pokemonListSubject.append(contentsOf: lists)
      }, 
                 onError: { error in
        self.isReloaded = false
      }).disposed(by: diposeBag)
  }

  private func createCellLayout() -> UICollectionViewLayout {
    let itemSpacing: CGFloat = 10
    let itemsPerRow: CGFloat = 3
    let sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    let paddingSpace = sectionInset.left + sectionInset.right +
    (itemsPerRow - 1) * itemSpacing
    let availableCellWidth = view.frame.width - paddingSpace
    let cellWidth = availableCellWidth / itemsPerRow
    let layout = {
      let lo = UICollectionViewFlowLayout()
      lo.itemSize = CGSize(width: cellWidth, height: cellWidth)
      lo.minimumLineSpacing = itemSpacing
      lo.minimumInteritemSpacing = itemSpacing
      lo.sectionInset = sectionInset
      return lo
    }()

    return layout
    
  }
  private func configureUI() {
    view.backgroundColor = UIColor.mainRed
    [
      imageView,
      collectionView
    ].forEach{view.addSubview($0)}
    imageView.snp.makeConstraints{
      $0.centerX.equalToSuperview()
      $0.top.equalToSuperview().offset(100)
      $0.width.equalTo(130)
      $0.height.equalTo(130)
    }
    collectionView.snp.makeConstraints{
      $0.top.equalTo(imageView.snp.bottom).offset(20)
      $0.centerX.equalToSuperview()
      $0.width.equalToSuperview()
      $0.bottom.equalToSuperview().offset(-50)
    }
  }
  
}

extension MainViewController: UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let pokemon = pokemonListSubject[indexPath.row]
    let detailViewController = DetailViewController(pokemonID: pokemon.pokemonID)
    self.navigationController?.pushViewController(detailViewController, animated: true)

  }
}

extension MainViewController: UICollectionViewDataSource{
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return pokemonListSubject.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PokemonCell.id, for: indexPath) as? PokemonCell 
    else { return UICollectionViewCell()}
    let pokemon = pokemonListSubject[indexPath.row]
    cell.configure(with: pokemon.pokemonID)

    return cell
  }

  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    let offsetY = scrollView.contentOffset.y
    let contentHeight = scrollView.contentSize.height
    let height = scrollView.bounds.height

    if  offsetY  > contentHeight - height * 2 {
      viewModel.fetchPokeData()
      collectionView.reloadData()

    }
  }
  
}
