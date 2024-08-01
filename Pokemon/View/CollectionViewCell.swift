//
//  CollectionViewCell.swift
//  Pokemon
//
//  Created by bloom on 8/1/24.
//

import UIKit
import SnapKit
import Kingfisher

class CollectionViewCell: UICollectionViewCell {
  static let id = "PokemonCell"
  
  let imageView = {
    let iv = UIImageView()
    iv.contentMode = .scaleAspectFit
    iv.backgroundColor = UIColor.cellBackground
    iv.layer.cornerRadius = 10
    iv.clipsToBounds = true
    return iv
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    contentView.addSubview(imageView)
    imageView.frame = contentView.bounds
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func prepareForReuse() {
    super.prepareForReuse()
    imageView.image = nil
  }
  
  func configure(with id: PokemonModel){
    
//    guard let pokemonId = PokemonModel().id else { return }
    
    let urlStirng = "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/54.png"
    guard let url = URL(string: urlStirng) else { return }
    
    self.imageView.kf.setImage(with: <#T##Source?#>)
  }
  
  
}
