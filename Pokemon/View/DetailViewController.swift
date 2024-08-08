//
//  DetailViewController.swift
//  Pokemon
//
//  Created by bloom on 8/1/24.
//

import UIKit
import SnapKit
import Kingfisher
import RxSwift ///구독과 방출의 매커니즘

final class DetailViewController: UIViewController {
  
  private var viewModel: DetailViewModel
  private let disposeBag = DisposeBag()
  

  private let backgroundview = {
    let view = UIView()
    view.clipsToBounds = true
    view.layer.cornerRadius = 10
    view.backgroundColor = UIColor.darkRed
    return view
  }()
  lazy var imageLabel = {
    let iv = UIImageView()
    iv.clipsToBounds = true
    iv.kf.setImage(with:URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/\(viewModel.pokemonID).png"))
    return iv
  }()
  lazy var stackView = {
    let sv = UIStackView(arrangedSubviews: [pokemonIdLabel,pokemonName])
    sv.axis = .horizontal
    sv.distribution = .fillProportionally
    return sv
  }()
  lazy var pokemonIdLabel = {
    let iv = UILabel()
    iv.textColor = .white
    iv.textAlignment = .right
    iv.font = UIFont.boldSystemFont(ofSize: 30)
    return iv
  }()
  lazy var pokemonName = {
    let iv = UILabel()
    iv.textColor = .white
    iv.textAlignment = .left
    iv.font = UIFont.boldSystemFont(ofSize: 30)
    return iv
  }()
  lazy var pokemonType = {
    let iv = UILabel()
    iv.textColor = .white
    iv.textAlignment = .center
    iv.font = UIFont.boldSystemFont(ofSize: 20)
    return iv
  }()
  lazy var pokemonHeight = {
    let iv = UILabel()
    iv.textColor = .white
    iv.textAlignment = .center
    iv.font = UIFont.boldSystemFont(ofSize: 20)
    return iv
  }()
  lazy var pokemonWeight = {
    let iv = UILabel()
    iv.textColor = .white
    iv.textAlignment = .center
    iv.font = UIFont.boldSystemFont(ofSize: 20)
    return iv
  }()
  
  init(pokemonID: String) {
    //정적인데이터가 아니라 동적인데이터 가
    self.viewModel = DetailViewModel(pokemonID: pokemonID)
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    viewModel.fetchPokeDetailData()
    configureUI()
    bind()
  }
  
  private func bind(){
    viewModel.pokemonDetailSubject
      .observe(on: MainScheduler.instance)
      .subscribe(onNext: {  [weak self] info in
        
        let idString = " NO." + String(info.id!)
        let nameString = "  " +
        PokemonTranslator.getKoreanName(for: info.name!)
        let typeString = (info.types?[0].type.name.displayName)! + "타입 포켓몬"
        let weightString = "키: \(String(format: "%.1f", info.weight! * 0.1))cm"
        let heightString = " 몸무게: \(String(format: "%.1f", info.height! * 0.1))kg"
        
        self?.pokemonIdLabel.text = idString
        self?.pokemonName.text = nameString
        self?.pokemonType.text =  typeString
        self?.pokemonWeight.text =  weightString
        self?.pokemonHeight.text = heightString
      },
                 onError: { error in
        print(error)
      }).disposed(by: disposeBag)
  }
  private func configureUI(){
    view.backgroundColor = UIColor.mainRed
    view.addSubview(backgroundview)
    backgroundview.snp.makeConstraints{
      $0.top.equalToSuperview().offset(100)
      $0.centerX.equalToSuperview()
      $0.width.equalTo(320)
      $0.height.equalTo(450)
    }
    [
      imageLabel,
      stackView,
      pokemonType,
      pokemonHeight,
      pokemonWeight
    ].forEach{backgroundview.addSubview($0)}
    imageLabel.snp.makeConstraints{
      $0.top.equalTo(backgroundview.snp.top).offset(10)
      $0.centerX.equalToSuperview()
      $0.width.equalTo(200)
      $0.height.equalTo(200)
    }
    stackView.snp.makeConstraints{
      $0.top.equalTo(imageLabel.snp.bottom).offset(5)
      $0.centerX.equalToSuperview()
      $0.width.equalTo(230)
      $0.height.equalTo(50)
    }
    pokemonType.snp.makeConstraints{
      $0.top.equalTo(stackView.snp.bottom).offset(5)
      $0.centerX.equalToSuperview()
      $0.width.equalTo(150)
      $0.height.equalTo(50)
    }
    pokemonWeight.snp.makeConstraints{
      $0.top.equalTo(pokemonType.snp.bottom).offset(5)
      $0.centerX.equalToSuperview()
      $0.width.equalTo(150)
      $0.height.equalTo(50)
    }
    pokemonHeight.snp.makeConstraints{
      $0.top.equalTo(pokemonWeight.snp.bottom).offset(5)
      $0.centerX.equalToSuperview()
      $0.width.equalTo(150)
      $0.height.equalTo(50)
    }
  }
}
