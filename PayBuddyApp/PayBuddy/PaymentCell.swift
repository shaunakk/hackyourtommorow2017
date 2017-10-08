

import UIKit

class PaymentCell: UITableViewCell {

    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = ""
        label.numberOfLines = 2
        label.font = label.font.bold()
        label.font = UIFont(name: label.font.fontName, size: 15)
        label.textColor = .black
        return label
    }()
    
    let typeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = ""
        label.numberOfLines = 1
        label.textColor = .black
        label.font = UIFont(name: label.font.fontName, size: 15)
        return label
    }()
    
    let amount: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = ""
        label.textAlignment = .right
        label.numberOfLines = 0
        label.textColor = .black
        label.font = label.font.bold()
        label.font = UIFont(name: label.font.fontName, size: 15)
        return label
    }()

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
        setupUIComponents()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        self.addSubview(titleLabel)
        self.addSubview(typeLabel)
        self.addSubview(amount)
    }
    
     func setupUIComponents() {
        let padding: CGFloat = 10
        titleLabel.frame = CGRect(x: padding, y: (frame.height - 25) / 2 - 5, width: 250, height: 50)
        typeLabel.frame = CGRect(x: padding, y: titleLabel.frame.height - padding + 2, width: 250, height: 50)
        amount.frame = CGRect(x: frame.width - 60, y: padding, width: 100, height: frame.height - 2 * padding)
    }
}

extension UIFont {
    
    func withTraits(traits:UIFontDescriptorSymbolicTraits...) -> UIFont {
        let descriptor = self.fontDescriptor
            .withSymbolicTraits(UIFontDescriptorSymbolicTraits(traits))
        return UIFont(descriptor: descriptor!, size: 0)
    }
    
    func bold() -> UIFont {
        return withTraits(traits: .traitBold)
    }
    
}
