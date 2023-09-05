import UIKit

class PersonagemCell: UITableViewCell {
    private let horizontalStack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.spacing = 16
        return stack
    }()
    
    private let imagePersonagemView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.cornerRadius = 28
        image.layer.masksToBounds = true
        image.backgroundColor = .red
        return image
    }()
    
    private let verticalStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 8
        return stack
    }()
    
    private let nomeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    
    private let descLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17)
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupContentView()
        addViewsInHierarchy()
        setupConstraints()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        nil
    }
    func configure(personagem: Personagem) {
        nomeLabel.text = personagem.name
        descLabel.text = personagem.description
        
        imagePersonagemView.download(url: personagem.thumbnail.path)
    }
    private func setupContentView() {
        selectionStyle = .none
        backgroundColor = . clear
        
        contentView.backgroundColor = .clear
    }
    
    private func addViewsInHierarchy() {
        contentView.addSubview(horizontalStack)
        horizontalStack.addArrangedSubview(imagePersonagemView)
        horizontalStack.addArrangedSubview(verticalStack)
        verticalStack.addArrangedSubview(UIView())
        verticalStack.addArrangedSubview(nomeLabel)
        verticalStack.addArrangedSubview(descLabel)
        verticalStack.addArrangedSubview(UIView())    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            horizontalStack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 32),
            horizontalStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 32),
            horizontalStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -32),
            horizontalStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            imagePersonagemView.widthAnchor.constraint(equalToConstant: 170),
            imagePersonagemView.heightAnchor.constraint(equalToConstant: 170)
        ])
    }
}
