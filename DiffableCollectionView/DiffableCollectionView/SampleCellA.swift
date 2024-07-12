//
//  SampleCellA.swift
//  DiffableCollectionView
//
//  Created by João Campos on 11/07/2024.
//

import UIKit

final class SampleCellA: UICollectionViewCell, ConfigurableCell {

	private let label = UILabel()
	private let icon = UIImageView()
	private let stackView = UIStackView()

	override init(frame: CGRect = .zero) {

		super.init(frame: frame)

		configureSubviews()
	}

	@available(*, unavailable)
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	func configure(with sample: Sample) {

		label.text = sample.title
		icon.image = UIImage(systemName: sample.systemNameIcon)
	}

	override func prepareForReuse() {

		super.prepareForReuse()

		label.text = nil
		icon.image = nil
	}
}

private extension SampleCellA {

	func configureSubviews() {

		backgroundColor = .quaternarySystemFill
		layer.cornerRadius = 10

		label.font = UIFont.preferredFont(forTextStyle: .headline)
		label.textColor = .label
		icon.contentMode = .scaleAspectFit

		stackView.addArrangedSubview(label)
		stackView.addArrangedSubview(icon)

		stackView.translatesAutoresizingMaskIntoConstraints = false
		stackView.axis = .vertical
		stackView.alignment = .center
		stackView.distribution = .fillEqually

		contentView.addSubview(stackView)

		configureConstraints()
	}

	func configureConstraints() {

		NSLayoutConstraint.activate([

			stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
			stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
			stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
			stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
		])
	}
}
