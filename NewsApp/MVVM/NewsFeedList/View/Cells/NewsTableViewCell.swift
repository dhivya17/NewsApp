//
//  NewsTableViewCell.swift
//  NewsApp
//
//  Created by d.c.venkatachalam on 06/08/22.
//

import UIKit

final class NewsTableViewCell: UITableViewCell {
    public static let cellId = "NewsTableViewCell"
    public let titleLabel = UILabel()
    public let descriptionLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        backgroundColor = .white
        selectionStyle = .none
        
        configureView()
        constrainView()
    }

    public func updateCell(data: Article) {
        titleLabel.text = data.title
        descriptionLabel.text = data.summary
    }

    private func configureView() {
        titleLabel.font = UIFont.systemFont(ofSize: 14.0, weight: .regular)
        titleLabel.textColor = .darkText
        titleLabel.numberOfLines = 3

        descriptionLabel.font = UIFont.systemFont(ofSize: 12.0, weight: .regular)
        descriptionLabel.textColor = .darkGray
        descriptionLabel.numberOfLines = 5

        contentView.addSubview(titleLabel)
        contentView.addSubview(descriptionLabel)
    }

    private func constrainView() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            titleLabel.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor, constant: -15.0),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: 15.0),
            titleLabel.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 15),
            titleLabel.bottomAnchor.constraint(equalTo: descriptionLabel.topAnchor, constant: -15.0),
            
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor, constant: -15.0),
            descriptionLabel.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: 15.0),
            descriptionLabel.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor , constant: -15.0)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
