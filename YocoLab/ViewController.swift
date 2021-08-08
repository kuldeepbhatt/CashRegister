//
//  ViewController.swift
//  YocoLab
//
//  Created by Kuldeep Bhatt on 2021/08/07.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet private weak var amountLabel: UILabel!
    @IBOutlet private weak var keysCollection: UICollectionView!
    @IBOutlet private weak var amountRegisterTable: UITableView!
    @IBOutlet private weak var tableContainer: UIView!
    private var arrDigits: [Int] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
    }
}

private extension ViewController {
    func setUpView() {
        setUpTableStyle()
    }
    func setUpTableStyle() {
        amountRegisterTable.backgroundColor = .clear
        tableContainer.backgroundColor = UIColor(hexString: "545E75")
        amountRegisterTable.separatorStyle = .none
    }
}


// MARK: Collection View Datasource and Delegate
extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return CashRegisterViewModel.shared.visibleKeys
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: KeyCell.self), for: indexPath) as! KeyCell
        guard let value = CashRegisterViewModel.shared.keys[safe: indexPath.item] else { return UICollectionViewCell() }
        cell.configure(with: value)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let key = CashRegisterViewModel.shared.keys[safe: indexPath.item] else { return }
        switch key {
        case "ADD":
            let value = getDecimal()
            CashRegisterViewModel.shared.appendCharges(charge: value)
            amountRegisterTable.reloadData()
            resetToDefaults()
        case "DEL": if arrDigits.count > 0 { arrDigits.removeLast() }
        default: arrDigits.append(Int(key) ?? 0)
        }
        processCashValueNSetToAmountLabel()
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        let yourWidth = collectionView.bounds.width/3.0
        let yourHeight = collectionView.bounds.height/4.0

        return CGSize(width: yourWidth, height: yourHeight)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
}

// MARK: Table View Datasource and Delegate

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return CashRegisterViewModel.shared.visibleSections.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let section = CashRegisterViewModel.shared.visibleSections[safe: section] else { return 0 }
        switch section {
        case .entries: return CashRegisterViewModel.shared.visibleRows?.count ?? 0
        case .total: return 1
        }
        
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueCell(ofType: ItemCellTableViewCell.self, indexPath: indexPath) as? ItemCellTableViewCell else { return tableView.defaultTableViewCell() }
        guard let section = CashRegisterViewModel.shared.visibleSections[safe: indexPath.section] else { return tableView.defaultTableViewCell() }
        switch section {
        case .entries:
            guard let value = CashRegisterViewModel.shared.visibleRows?[safe: indexPath.row] else { return tableView.defaultTableViewCell() }
            cell.configure(with: value)
        case .total:
            tableView.separatorColor = .white
            guard let total = CashRegisterViewModel.shared.totalOfEntries else { return tableView.defaultTableViewCell() }
            cell.configure(with: total, isTotalRow: true)
        }
        return cell
    }
}

// MARK: Business
private extension ViewController {
    func processCashValueNSetToAmountLabel() {
        let decimal = getDecimal()
        decimal < cashValueLimit ? (amountLabel.text = String(format: "R %.2f", decimal as CVarArg)) : ()
    }
    func getDecimal() -> Float {
        let initialValue: Float = 0.0
        if !(arrDigits.count > 0) { return initialValue }
        let value = arrDigits.reduce(0, {$0&*10 + $1 }).addingReportingOverflow(1)
        if !value.overflow {
            let decimalValue = Float(value.partialValue)/Float(100)
            return decimalValue
        }
        return initialValue
    }

    func resetToDefaults() {
        arrDigits = []
        amountLabel.text = ""
    }
}
