//
//  ViewController.swift
//  DiffableCollectionView
//
//  Created by João Campos on 11/07/2024.
//

import UIKit

class ViewController: UIViewController {

	typealias DataSource = UICollectionViewDiffableDataSource<Section, Sample>
	typealias Snapshot = NSDiffableDataSourceSnapshot<Section, Sample>

	private let sections: [Section] = [.mock(.A), .mock(.B), .mock(.C)]
	private var colapsedSections = [Section.SectionType]()
	
	private lazy var dataSource = createDataSource()
	private lazy var collectionView = UICollectionView(frame: .zero,
											   collectionViewLayout: createCompositionLayout())

	override func viewDidLoad() {
		
		super.viewDidLoad()

		configureView()
	}
}

private extension ViewController {

	func configureView() {

		title = "Diffable Collection View"
		view.backgroundColor = .systemBackground
		view.addSubview(collectionView)

		collectionView.translatesAutoresizingMaskIntoConstraints = false
		
		collectionView.register(SampleCellA.self,
								forCellWithReuseIdentifier: SampleCellA.reuseIdentifier)
		
		collectionView.register(SampleCellB.self,
								forCellWithReuseIdentifier: SampleCellB.reuseIdentifier)

		collectionView.register(SampleCellC.self,
								forCellWithReuseIdentifier: SampleCellC.reuseIdentifier)

		collectionView.register(SampleHeader.self,
								forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
								withReuseIdentifier: SampleHeader.identifier)

		configureConstraints()

		reloadData()
	}

	func configureConstraints() {

		NSLayoutConstraint.activate([

			collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
			collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
			collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
			collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
		])
	}

	func configureCell(reuseIdentifier: String,
					   with sample: Sample,
					   for indexPath: IndexPath) -> UICollectionViewCell {

		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier,
													  for: indexPath)

		guard let configurableCell = cell as? ConfigurableCell else {
			return cell
		}

		configurableCell.configure(with: sample)
		return cell
	}

	func createDataSource() -> DataSource {

		let dataSource: DataSource = UICollectionViewDiffableDataSource(collectionView: collectionView) { collectionView, indexPath, sample in

			let reuseIdentifier: String

			switch self.sections[indexPath.section].type {

				case .A: reuseIdentifier = SampleCellA.reuseIdentifier
				case .B: reuseIdentifier = SampleCellB.reuseIdentifier
				case .C: reuseIdentifier = SampleCellC.reuseIdentifier
			}

			return self.configureCell(reuseIdentifier: reuseIdentifier, with: sample, for: indexPath)
		}

		dataSource.supplementaryViewProvider = { [weak self] collectionView, kind, indexPath in

			guard let sectionHeader = collectionView
				.dequeueReusableSupplementaryView(ofKind: kind,
												  withReuseIdentifier: SampleHeader.identifier,
												  for: indexPath) as? SampleHeader else {
				
				assertionFailure("Unable to dequeue \(kind)")
				return UICollectionReusableView()
			}

			guard let section = self?.dataSource.sectionIdentifier(for: indexPath.section) else {
				
				assertionFailure("Unable to find section at \(indexPath)")
				return UICollectionReusableView()
			}

			sectionHeader.configure(title: section.title) { [weak self] in

				self?.headerButtonAction(for: section)
			}

			return sectionHeader
		}

		return dataSource
	}

	func reloadData() {

		var snapshot = Snapshot()
		snapshot.appendSections(sections)

		for section in sections {
			
			if colapsedSections.contains(section.type) == false {
				snapshot.appendItems(section.items, toSection: section)
			}
		}

		dataSource.apply(snapshot)
	}

	func createCompositionLayout() -> UICollectionViewLayout {

		let layout = UICollectionViewCompositionalLayout { sectionIndex, layoutEnvironment in

			let section = self.sections[sectionIndex]

			switch section.type {
				
				case .A: return self.createSectionA()
				case .B: return self.createSectionB()
				case .C: return self.createSectionC()
			}
		}

		let configuration = UICollectionViewCompositionalLayoutConfiguration()
		configuration.interSectionSpacing = 20

		layout.configuration = configuration

		return layout
	}

	func createSectionA() -> NSCollectionLayoutSection {

		let itemSize = NSCollectionLayoutSize(
			widthDimension: .fractionalWidth(1.0),
			heightDimension: .fractionalHeight(1.0)
		)

		let layoutItem = NSCollectionLayoutItem(layoutSize: itemSize)
		layoutItem.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 5)

		let layoutGroupSize = NSCollectionLayoutSize(
			widthDimension: .fractionalWidth(0.93),
			heightDimension: .fractionalHeight(1/5)
		)

		let layoutGroup = NSCollectionLayoutGroup
			.horizontal(
				layoutSize: layoutGroupSize,
				subitems: [layoutItem]
			)

		let layoutSection = NSCollectionLayoutSection(group: layoutGroup)
		layoutSection.orthogonalScrollingBehavior = .groupPagingCentered

		let layoutSectionHeader = createSectionHeader()
		layoutSection.boundarySupplementaryItems = [layoutSectionHeader]

		return layoutSection
	}

	func createSectionB() -> NSCollectionLayoutSection {

		let itemSize = NSCollectionLayoutSize(
			widthDimension: .fractionalWidth(1.0),
			heightDimension: .fractionalHeight(1/3)
		)

		let layoutItem = NSCollectionLayoutItem(layoutSize: itemSize)
		layoutItem.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)

		let layoutGroupSize = NSCollectionLayoutSize(
			widthDimension: .fractionalWidth(0.93),
			heightDimension: .fractionalHeight(1/3)
		)

		let layoutGroup = NSCollectionLayoutGroup
			.vertical(
				layoutSize: layoutGroupSize,
				subitems: [layoutItem]
			)

		let layoutSection = NSCollectionLayoutSection(group: layoutGroup)
		layoutSection.orthogonalScrollingBehavior = .groupPagingCentered

		let layoutSectionHeader = createSectionHeader()
		layoutSection.boundarySupplementaryItems = [layoutSectionHeader]

		return layoutSection
	}

	func createSectionC() -> NSCollectionLayoutSection {

		let itemSize = NSCollectionLayoutSize(
			widthDimension: .fractionalWidth(1),
			heightDimension: .fractionalHeight(1/5)
		)

		let layoutItem = NSCollectionLayoutItem(layoutSize: itemSize)
		layoutItem.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 20, bottom: 5, trailing: 20)

		let layoutGroupSize = NSCollectionLayoutSize(
			widthDimension: .fractionalWidth(1),
			heightDimension: .estimated(200)
		)

		let layoutGroup = NSCollectionLayoutGroup.horizontal(
			layoutSize: layoutGroupSize, subitems: [layoutItem])

		let layoutSection = NSCollectionLayoutSection(group: layoutGroup)

		let layoutSectionHeader = createSectionHeader()
		layoutSection.boundarySupplementaryItems = [layoutSectionHeader]

		return layoutSection
	}

	func createSectionHeader() -> NSCollectionLayoutBoundarySupplementaryItem {

		let layoutSectionHeaderSize = NSCollectionLayoutSize(
			widthDimension: .fractionalWidth(0.93),
			heightDimension: .estimated(80)
		)

		let layoutSectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
			layoutSize: layoutSectionHeaderSize,
			elementKind: UICollectionView.elementKindSectionHeader,
			alignment: .top)

		return layoutSectionHeader
	}

	func headerButtonAction(for section: Section) {

		if colapsedSections.contains(section.type) {
			
			colapsedSections = colapsedSections.filter { $0 != section.type }

		} else {

			colapsedSections.append(section.type)
		}

		reloadData()
	}
}
