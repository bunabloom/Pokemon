//
//  DetailViewController.swift
//  Pokemon
//
//  Created by bloom on 8/1/24.
//

import UIKit
import SnapKit
import Kingfisher
import RxSwift

class DetailViewController: UIViewController {
  

  private var viewModel: DetailViewModel
  
  init(viewModel: DetailViewModel) {

    self.viewModel = viewModel
    super.init(nibName: nil, bundle: nil)
  }
  
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  //동작
  
  private let disposeBag = DisposeBag()
  
  
  let backgroundview = {
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
    iv.textAlignment = .left
    iv.text = "NO.54"
    iv.font = UIFont.boldSystemFont(ofSize: 30)
    return iv
  }()
  lazy var pokemonName = {
    let iv = UILabel()
    iv.textColor = .white
    iv.textAlignment = .right
    iv.text = "고라파덕"
    iv.font = UIFont.boldSystemFont(ofSize: 30)
    return iv
  }()
  let pokemonType = {
    let iv = UILabel()
    iv.textColor = .white
    iv.text = "타입"
    iv.textAlignment = .center
    iv.font = UIFont.boldSystemFont(ofSize: 20)
    return iv
  }()
  let pokemonHeight = {
    let iv = UILabel()
    iv.textColor = .white
    iv.text = "키"
    iv.textAlignment = .center
    iv.font = UIFont.boldSystemFont(ofSize: 20)
    return iv
  }()
  let pokemonWeight = {
    let iv = UILabel()
    iv.textColor = .white
    iv.text = "몸무게"
    iv.textAlignment = .center
    iv.font = UIFont.boldSystemFont(ofSize: 20)
    return iv
  }()
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = UIColor.mainRed
    configureUI()
    
    bind()

  }
  

  
  
  private func bind(){
    
    viewModel.pokemonDetailSubject
     // .filter({ !$0.isEmpty })
      .observe(on: MainScheduler.instance)
      .subscribe(onNext: {[weak self] info in

        self?.pokemonIdLabel.text = " NO. " + String(info.id ?? 404)
        self?.pokemonName.text = info.name
        self?.pokemonType.text = " 타입: " + (info.types?[0].type.name)!
        self?.pokemonWeight.text = " 몸무게: " + String(info.height ?? 404 )
        self?.pokemonHeight.text = " 키: " + String(info.height ?? 404 )
        
        
      },
                 
                 onError: {error in
        print(error)
      }).disposed(by: disposeBag)
  }
  
  
  private func configureUI(){
    
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
    pokemonHeight.snp.makeConstraints{
      $0.top.equalTo(pokemonType.snp.bottom).offset(5)
      $0.centerX.equalToSuperview()
      $0.width.equalTo(150)
      $0.height.equalTo(50)
    }
    pokemonWeight.snp.makeConstraints{
      $0.top.equalTo(pokemonHeight.snp.bottom).offset(5)
      $0.centerX.equalToSuperview()
      $0.width.equalTo(150)
      $0.height.equalTo(50)
    }
    
    
  }
  
  
  
}
