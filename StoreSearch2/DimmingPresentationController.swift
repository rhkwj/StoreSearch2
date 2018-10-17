//
//  DimmingPresentationController.swift
//  StoreSearch2
//
//  Created by Kim Yeon Jeong on 2018/10/15.
//  Copyright © 2018 Kim Yeon Jeong. All rights reserved.
//

import Foundation
import UIKit

class DimmingPresentationController: UIPresentationController {
    override var shouldRemovePresentersView: Bool {
        return false
    }
    
    lazy var dimmingView = GradientView(frame: CGRect.zero)
    override func presentationTransitionWillBegin() {
        dimmingView.frame = containerView!.bounds
        containerView!.insertSubview(dimmingView, at: 0)
    }
}


