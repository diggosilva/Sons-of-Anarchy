//
//  FilterCell.swift
//  SonsOfAnarchy
//
//  Created by Diggo Silva on 04/04/24.
//

import UIKit

class FilterCell: UITableViewCell {
    static let identifier = "FilterCell"
    
    lazy var labelClub: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(filter: Filter) {
        labelClub.text = filter.club
        self.accessoryType = filter.isSelected ? .checkmark : .none
    }
    
    private func setupView() {
        setHierarchy()
        setConstraints()
    }
    
    private func setHierarchy () {
        addSubview(labelClub)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            labelClub.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            labelClub.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            labelClub.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            labelClub.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
        ])
    }
}
