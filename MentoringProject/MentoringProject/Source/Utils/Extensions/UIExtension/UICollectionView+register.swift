//
//  UICollectionView+register.swift
//  YDUI
//
//  Created by 류연수 on 12/14/24.
//

import UIKit

public extension UICollectionView {
    
    func registerCell(
        ofType cellType: UICollectionViewCell.Type,
        withReuseIdentifier identifier: String? = nil
    ) {
        let reuseIdentifier = identifier ?? String(describing: cellType.self)
        self.register(cellType, forCellWithReuseIdentifier: reuseIdentifier)
    }
    
    func dequeueCell<T: UICollectionViewCell>(
        _ type: T.Type,
        for indexPath: IndexPath
    ) -> T {
        let reuseIdentifier = String(describing: type)
        
        guard let cell = dequeueReusableCell(
            withReuseIdentifier: reuseIdentifier,
            for: indexPath
        ) as? T
        else {
            fatalError("dequeueReusableCell(identifier:) can not dequeue \(reuseIdentifier)")
        }
        
        return cell
    }
    
    func registerSupplementaryView(
        ofType viewType: UICollectionReusableView.Type,
        ofKind elementKind: String = UICollectionView.elementKindSectionHeader,
        withReuseIdentifier identifier: String? = nil
    ) {
        let reuseIdentifier = identifier ?? String(describing: viewType.self)
        self.register(
            viewType,
            forSupplementaryViewOfKind: elementKind,
            withReuseIdentifier: reuseIdentifier
        )
    }
    
    func dequeueSupplementaryView<T: UICollectionReusableView>(
        ofKind elementKind: String = UICollectionView.elementKindSectionHeader,
        withReuseIdentifier identifier: String?,
        for indexPath: IndexPath
    ) -> T {
        let reuseIdentifier = identifier ?? String(describing: T.self)
        
        guard let view = dequeueReusableSupplementaryView(
            ofKind: elementKind,
            withReuseIdentifier: reuseIdentifier,
            for: indexPath
        ) as? T
        else {
            fatalError("dequeueReusableSupplementaryView(identifier:) can not dequeue \(reuseIdentifier)")
        }
        
        return view
    }
}
