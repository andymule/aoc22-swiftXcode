//
//  SelectableText.swift
//  AOC22-xcode
//
//  Created by Andrew Muehlhausen on 12/1/22.
//

import Foundation
import SwiftUI
import SwiftGraph
//import TextView

struct SelectableText: UIViewRepresentable {
    public var text: String
    @Binding var isSelected: Bool

    func makeUIView(context: Context) -> SelectableLabel {
        let label = SelectableLabel()
        label.textColor = .systemYellow
        label.font = .systemFont(ofSize: 26, weight: .semibold)
        label.textAlignment = .center
        label.text = text
        return label
    }

    func updateUIView(_ uiView: SelectableLabel, context: Context) {
        uiView.text = text
        if isSelected {
            uiView.showMenu()
        } else {
            let _ = uiView.resignFirstResponder()
        }
    }
}

class SelectableLabel: UILabel {
    override var canBecomeFirstResponder: Bool {
        return true
    }

    override init(frame: CGRect) {
        super.init(frame: .zero)
        highlightedTextColor = .gray
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        switch action {
        case #selector(copy(_:)), #selector(paste(_:)), #selector(delete(_:)):
            return true
        default:
            return super.canPerformAction(action, withSender: sender)
        }
    }

    override func copy(_ sender: Any?) {
        UIPasteboard.general.string = self.text ?? ""
    }
//
//    override func paste(_ sender: Any?) {
//        guard let string = UIPasteboard.general.string else { return }
//        NotificationCenter.default.post(name: Notification.Name.Paste, object: nil, userInfo: [Keys.PastedString: string])
//    }
//
//    override func delete(_ sender: Any?) {
//        NotificationCenter.default.post(name: Notification.Name.Delete, object: nil)
//    }

    override func resignFirstResponder() -> Bool {
        isHighlighted = false
        return super.resignFirstResponder()
    }

    public func showMenu() {
        becomeFirstResponder()
        isHighlighted = true
        let menu = UIMenuController.shared
        menu.showMenu(from: self, rect: bounds)
    }
}
