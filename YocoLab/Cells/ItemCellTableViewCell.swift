//
//  ItemCellTableViewCell.swift
//  YocoLab
//
//  Created by Kuldeep Bhatt on 2021/08/07.
//

import UIKit

class ItemCellTableViewCell: UITableViewCell {

    @IBOutlet weak var totalSeparator: UIView!
    @IBOutlet weak var itemLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        separatorInset = .zero
        contentView.backgroundColor = .clear
        selectionStyle = .none
    }

    func configure(with value: Float = 0.0,
                   isTotalRow: Bool = false) {
        var format = "R %.2f"
        isTotalRow ? (format = "Total : R %.2f") : ()
        totalSeparator.isHidden = !isTotalRow
        itemLabel.text = String(format: format, value)
        setUpStyle()
    }

    private func setUpStyle() {
        itemLabel.font = .boldSystemFont(ofSize: 15.0)
        itemLabel.textColor = UIColor(hexString: "F7F9FC")
    }
}
