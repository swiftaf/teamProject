//
//  KeyCell.swift
//  Plasticiti
//
//  Created by Rawan Alhindi on 11/19/22.
//

import UIKit
let fontPoppins = UIFont(name: "Poppins-Bold", size: 24)

class KeyCell: UICollectionViewCell {
    
    
    static let identifer = "KeyCell"
    
    let label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white //text color
        label.textAlignment = .center
        label.font = fontPoppins
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = #colorLiteral(red: 0.09120073169, green: 0.2949831188, blue: 0.4485020638, alpha: 1)
        contentView.addSubview(label)
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            label.topAnchor.constraint(equalTo: contentView.topAnchor),
            label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        label.text = nil
    }
    
    func configure(with letter: Character) {
        label.text = String(letter).uppercased()
    }
    
}
