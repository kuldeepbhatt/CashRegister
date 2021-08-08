//
//  KeyCell.swift
//  yocoTest
//
//  Created by Kuldeep Bhatt on 2021/08/07.
//

import UIKit

class KeyCell: UICollectionViewCell {
    @IBOutlet private weak var keyLabel: UILabel!
    func configure(with value: String) {
        setUp(with: value)
    }
}

private extension KeyCell {
    func setUp(with value: String) {
        keyLabel.text = value
        setUpStyle()
    }

    func setUpStyle() {
        keyLabel.font = .boldSystemFont(ofSize: 15.0)
        keyLabel.textColor = UIColor(hexString: "2D3142")
        self.layer.borderWidth = 1.0
        self.layer.borderColor = UIColor(hexString: "2D3142").cgColor
    }
}
