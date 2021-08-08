//
//  UITableView+Yoco.swift
//  YocoLab
//
//  Created by Kuldeep Bhatt on 2021/08/08.
//

import UIKit

public extension UITableView {
    func dequeueCell<CellType : UITableViewCell>(ofType cellType: CellType.Type, reuseIdentifier: String = CellType.defaultReuseIdentifier, indexPath: IndexPath, configure: ((CellType) -> Void)? = nil) -> UITableViewCell {
        let cell = self.cell(ofType: cellType, reuseIdentifier: reuseIdentifier, indexPath: indexPath)
        if let configure = configure {
            configure(cell)
        }
        return cell
    }
    
    func cell<CellType : UITableViewCell>(ofType cellType: CellType.Type, reuseIdentifier: String = CellType.defaultReuseIdentifier, indexPath: IndexPath) -> CellType {
        if let cell = dequeueReusableCell(withIdentifier: reuseIdentifier) as? CellType {
            return cell
        }
        register(nib(for: cellType), forCellReuseIdentifier: reuseIdentifier)
        guard let registeredCell = dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as? CellType else {
            register(CellType.self, forCellReuseIdentifier: reuseIdentifier)
            guard let registeredCell = dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as? CellType else {
                return CellType()
            }
            return registeredCell
        }
        return registeredCell
    }
    
    func dequeuedCell<CellType : UITableViewCell>(ofType cellType: CellType.Type, reuseIdentifier: String = CellType.defaultReuseIdentifier, indexPath: IndexPath) -> CellType {
        if let cell = dequeueReusableCell(withIdentifier: reuseIdentifier) as? CellType { return cell }
        if Bundle(for: cellType).path(forResource: cellType.className, ofType: "nib") != nil {
            let nib = UINib(nibName: cellType.className, bundle: Bundle(for: cellType))
            register(nib, forCellReuseIdentifier: reuseIdentifier)
        } else {
            register(cellType, forCellReuseIdentifier: reuseIdentifier)
        }
        guard let registeredCell = dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as? CellType else {
            register(CellType.self, forCellReuseIdentifier: reuseIdentifier)
            guard let registeredCell = dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as? CellType else {
                return CellType()
            }
            return registeredCell
        }
        return registeredCell
    }
    
    func headerFooterView<ViewType : UITableViewHeaderFooterView>(ofType viewType: ViewType.Type, reuseIdentifier: String) -> ViewType? {
        if let view = dequeueReusableHeaderFooterView(withIdentifier: reuseIdentifier) as? ViewType {
            return view
        }
        register(nib(for: viewType), forHeaderFooterViewReuseIdentifier: reuseIdentifier)
        return dequeueReusableHeaderFooterView(withIdentifier: reuseIdentifier) as? ViewType
    }
    
    private func nib<NibType : UIView>(for nibType: NibType.Type) -> UINib {
        let bundle = Bundle(for: nibType)
        if bundle.path(forResource: nibType.className, ofType: "nib") == nil {
            return UINib(nibName: String(describing: nibType), bundle: Bundle.main)
        }
        return UINib(nibName: String(describing: nibType), bundle: Bundle(for: nibType))
    }

    public func defaultTableViewCell() -> UITableViewCell {
        guard let tableViewCell = self.dequeueReusableCell(withIdentifier: "cell") else { return UITableViewCell() }
        return tableViewCell
    }
}


public extension NSObject {
    var className: String {
        return String(describing: type(of: self)).components(separatedBy: ".").last!
    }
    
    class var className: String {
        return String(describing: self).components(separatedBy: ".").last!
    }
}

public protocol ReusableView: class {}

public extension ReusableView where Self: UITableViewCell {
    static var defaultReuseIdentifier: String {
        return String(describing: self)
    }
}

extension UITableViewCell: ReusableView {}
