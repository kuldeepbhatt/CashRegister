import UIKit

class KeysCollectionManager: NSObject {
    private var delegate: KeyPressHandler?
    init(with delegate: KeyPressHandler) {
        self.delegate = delegate
        super.init()
    }
}

// MARK: Collection View Datasource and Delegate
extension KeysCollectionManager: UICollectionViewDelegate, UICollectionViewDataSource {
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
        self.delegate?.keyDidPress(with: key)
        debugPrint(key)
    }
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {

        let totalHeight: CGFloat = (UIScreen.main.bounds.size.width / 3)
        let totalWidth: CGFloat = (UIScreen.main.bounds.size.width / 3)

        return CGSize(width: totalWidth, height: totalHeight)
    }
}
