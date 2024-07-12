//
//  SampleHeader.swift
//  DiffableCollectionView
//
//  Created by João Campos on 11/07/2024.
//

import UIKit

final class SampleHeader: UICollectionReusableView {

	static let identifier = String(describing: SampleHeader.self)

	private let titleLabel = UILabel()
	private let button = UIButton(type: .custom)
	private var expanded = true
	private var action: (() -> Void)?

	override init(frame: CGRect = .zero) {

		super.init(frame: frame)

		configureSubviews()
	}

	@available(*, unavailable)
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	func configure(title: String, action: (() -> Void)?) {

		let name = expanded ? "rectangle.compress.vertical" : "rectangle.expand.vertical"
		titleLabel.text = title

		self.action = action
		self.button.setImage(UIImage(systemName: name), for: .normal)
	}

	override func prepareForReuse() {

		super.prepareForReuse()

		titleLabel.text = nil
		button.setImage(nil, for: .normal)
	}
}

private extension SampleHeader {

	func configureSubviews() {

		let separator = UIView(frame: .zero)
		separator.translatesAutoresizingMaskIntoConstraints = false
		separator.backgroundColor = .quaternaryLabel

		titleLabel.font = UIFontMetrics.default.scaledFont(
			for: UIFont.systemFont(ofSize: 22, weight: .bold))
		titleLabel.textColor = .label
		titleLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)

		button.setImage(UIImage(systemName: "rectangle.compress.vertical"), for: .normal)
		button.addAction(UIAction(handler: { _ in
			
			self.action?()

			self.expanded.toggle()

			let name = self.expanded ? "rectangle.compress.vertical" : "rectangle.expand.vertical"

			UIView.transition(with: self.button,
							  duration: 0.5,
							  options: .transitionFlipFromBottom,
							  animations: {
				
				self.button.setImage(UIImage(systemName: name), for: .normal)

			}, completion: nil)

		}), for: .touchUpInside)

		let innerStackView = UIStackView(arrangedSubviews: [titleLabel,
															button])

		innerStackView.axis = .horizontal
		innerStackView.distribution = .fillProportionally

		let stackView = UIStackView(arrangedSubviews: [separator,
													   innerStackView])
		stackView.translatesAutoresizingMaskIntoConstraints = false
		stackView.axis = .vertical

		addSubview(stackView)

		NSLayoutConstraint.activate([

			separator.heightAnchor.constraint(equalToConstant: 1),

			stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
			stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
			stackView.topAnchor.constraint(equalTo: topAnchor),
			stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
		])

		stackView.setCustomSpacing(10, after: separator)
	}
}
