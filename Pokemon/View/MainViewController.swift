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
  
  private var isReloaded: Bool = false
  private let viewModel = MainViewModel()
  private let diposeBag = DisposeBag()
  private var pokemonImages = ""
  private var pokemonListSubject = [ResponseResult]()
  //여기에 append로 추가를하고
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
    let cv = UICollectionView(frame: .zero,collectionViewLayout: createCellLayout())
    cv.register(PokemonCell.self, forCellWithReuseIdentifier: PokemonCell.id)
    cv.delegate = self
    cv.dataSource = self
    cv.backgroundColor = .darkRed
    return cv
  }()
  override func viewDidLoad() {
    super.viewDidLoad()
    configureUI()
    bind()
    // Do any additional setup after loading the view.
  }
  
  private func bind() {
    viewModel.pokemonSubject
      .observe(on: MainScheduler.instance)
      .subscribe(onNext: {[weak self] lists in
        self?.pokemonListSubject.append(contentsOf: lists)
        
//        print("MainViewControllerBinding Success",lists)
      }, onError: { error in
 //       print("MainViewControllerBinding Failure",error)
        self.isReloaded = false
      }
                 
      ).disposed(by: diposeBag)
  }
///셀 사이즈와 셀 간격을 설정해주는 메서드
  private func createCellLayout() -> UICollectionViewLayout {
///각 셀간의 간격 10 설정
    let itemSpacing: CGFloat = 10
/// row당 3개의 cell을 설정
    let itemsPerRow: CGFloat = 3
///각 셀당 의 가로길이 계산법  (뷰의 넓이  빼기 (셀개수 곱하기 셀간격)) 셀 개수
    let width = (view.frame.width - (itemsPerRow - 1) * itemSpacing) / itemsPerRow
    
    let layout = {
      let lo = UICollectionViewFlowLayout()
      lo.itemSize = CGSize(width: width, height: width)
      lo.minimumLineSpacing = itemSpacing
      lo.minimumInteritemSpacing = itemSpacing
      return lo
    }()
    return layout
    
  }
/// UI설정
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
   
    
/// 여기에서 값을 전달 해줘야함 어떻게?
    /// 일단 id는 알아 근데 id로 데이터 값을 아 url 이 있으니까 

    let pokemon = pokemonListSubject[indexPath.row]
 //   detailViewController.pokemonID = pokemon.pokemonID
//    detailViewController.pokemon = nil
    print(#function,pokemon.pokemonID)
    let detailViewController = DetailViewController(viewModel: DetailViewModel(pokemonID: pokemon.pokemonID))
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
    //print(pokemon.pokemonID)
    cell.configure(with: pokemon.pokemonID)
    return cell
  }
  
  
  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    guard !isReloaded else { return }
    let offsetY = self.collectionView.contentOffset.y
    let contentHeight = self.collectionView.contentSize.height
    let height = collectionView.bounds.size.height
    
    if  offsetY > contentHeight - height{
      isReloaded = true
      //비동기 처리를 한후 완료 되면 다시 false로
      loadMoreData()
      

      
      
    }
    
    
  }
  
  
  func loadMoreData(){
    viewModel.fetchPokeData()
   
    bind()
    collectionView.reloadData()
    isReloaded = false
  }
  
}
