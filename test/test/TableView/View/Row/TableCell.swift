//
//  TableCell.swift
//  test
//
//  Created by Alina Tytarenko on 09.05.2022.
//

import SwiftUI

final class TableCell: UITableViewCell {

    // MARK: - Views

    lazy var containerView = UIView()

    lazy var titleLabel = UILabel()

    // MARK: - Stored properties

    var viewState: ViewState = .initial() {
        didSet {
            render(viewState: viewState)
        }
    }
    
    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureBody()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureBody()
    }
    
    // MARK: - Private methods
    
    private func configureBody() {
        backgroundColor = .gray
        titleLabel.textColor = .white
        layer.cornerRadius = 12
        let rootStackView = UIStackView(arrangedSubviews: [
            titleLabel
        ])
        rootStackView.isLayoutMarginsRelativeArrangement = true
        rootStackView.layoutMargins = .init(top: 10, left: 20, bottom: 10, right: 20)
        rootStackView.translatesAutoresizingMaskIntoConstraints = false
        rootStackView.axis  = .vertical
        self.addSubview(rootStackView)
    }
    
    private func render(viewState: ViewState) {
        titleLabel.text = viewState.row.title
    }
}

// MARK: - ViewState

extension TableCell {
    
    struct ViewState: Equatable {
        
        var row: TableViewController.Row
        
        static func initial() -> Self {
            .init(row: TableViewController.Row(id: 1, title: ""))
        }
    }
}

// MARK: - Previews

struct TrackingListCell_Previews: PreviewProvider {
    
    static var previews: some View {
        Group {
            UIViewPreview {
                let view = TableCell(style: .default, reuseIdentifier: "")
                return view
            }
        }
        .previewLayout(.fixed(width: 343, height: 88))
    }
}
