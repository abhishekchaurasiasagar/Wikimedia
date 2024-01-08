
import UIKit

extension UITableView {
    
    func topSpace() {
        self.contentInset = UIEdgeInsets(top: 10,left: 0,bottom: 0,right: 0)
    }
}
extension UITableView {
    
    /**
     Register nibs faster by passing the type - if for some reason the `identifier` is different then it can be passed
     - Parameter type: UITableViewCell.Type
     - Parameter identifier: String?
     */
    func registerCell(type: UITableViewCell.Type, identifier: String? = nil) {
        let cellId = String(describing: type)
        register(UINib(nibName: cellId, bundle: nil), forCellReuseIdentifier: identifier ?? cellId)
    }
    
    /**
     DequeueCell by passing the type of UITableViewCell
     - Parameter type: UITableViewCell.Type
     */
    func dequeueCell<T: UITableViewCell>(withType type: UITableViewCell.Type) -> T? {
        return dequeueReusableCell(withIdentifier: type.identifier) as? T
    }
    
    /**
     DequeueCell by passing the type of UITableViewCell and IndexPath
     - Parameter type: UITableViewCell.Type
     - Parameter indexPath: IndexPath
     */
    func dequeueCell<T: UITableViewCell>(withType type: UITableViewCell.Type, for indexPath: IndexPath) -> T? {
        return dequeueReusableCell(withIdentifier: type.identifier, for: indexPath) as? T
    }
    
}
 extension UITableViewCell {
    static var identifier: String {
        return String(describing: self)
    }
}
extension UITableView {
    
    // If we are using xcode 13 ios 15 please uncomment following line otherwsie comment this line, because its not available in .
    
    func removeExtraSpace() {
        if #available(iOS 15.0, *) {
            UITableView.appearance().sectionHeaderTopPadding = CGFloat(0)
        } else {
            // Fallback on earlier versions
        }
    }
}
extension UITableView {

    func isLast(for indexPath: IndexPath) -> Bool {

        let indexOfLastSection = numberOfSections > 0 ? numberOfSections - 1 : 0
        let indexOfLastRowInLastSection = numberOfRows(inSection: indexOfLastSection) - 1

        return indexPath.section == indexOfLastSection && indexPath.row == indexOfLastRowInLastSection
    }
    
    func setEmptyMessage(_ message: String, fontSize : Int = 18) {
        let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
        messageLabel.text = message
        messageLabel.textColor = .black
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        messageLabel.font = UIFont(name: "Poppins-Regular", size: CGFloat(fontSize))
        messageLabel.sizeToFit()
        self.backgroundView = messageLabel
    }

    func restore() {
        self.backgroundView = nil
    }
    
}
