//
//  ViewController.swift
//  Pokemon
//
//  Created by bloom on 8/1/24.
//

import UIKit
import SnapKit

class MainViewController: UIViewController {
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

  override func viewDidLoad() {
    super.viewDidLoad()
    configureUI()
    // Do any additional setup after loading the view.
  }

  
  private func configureUI() {
    view.backgroundColor = UIColor.mainRed
    
    [
      imageView
    ].forEach{view.addSubview($0)}
    
    imageView.snp.makeConstraints{
      $0.centerX.equalToSuperview()
      $0.top.equalToSuperview().offset(90)
      $0.width.equalTo(130)
      $0.height.equalTo(130)
    }
  }

}

