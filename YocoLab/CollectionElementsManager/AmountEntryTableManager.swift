import UIKit

class AmountEntryTableManager: NSObject {
    static let shared = AmountEntryTableManager()
    override init() {
        super.init()
    }
}

// MARK: Table View Datasource and Delegate

extension AmountEntryTableManager: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}
