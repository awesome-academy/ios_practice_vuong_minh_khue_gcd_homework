//
//  ReusableView.swift
//  GCD Homework
//
//  Created by Khue on 01/08/2023.
//

import UIKit

protocol ReusableView: AnyObject {
    static var defaultReuseIdentifier: String { get }
}

extension ReusableView where Self: UIView {
    static var defaultReuseIdentifier: String {
        return String(describing: self)
    }
    static var nibName: String {
        return String(describing: self)
    }
}

extension UserTableViewCell: ReusableView {
}
