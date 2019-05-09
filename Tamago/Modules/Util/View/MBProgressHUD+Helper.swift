//
//  MBProgressHUD+Helper.swift
//  Marathon
//
//  Created by Andy Kim on 24/2/19.
//  Copyright © 2019 Hoodles. All rights reserved.
//

import Foundation
import MBProgressHUD

// MARK: - HUD helpers
func showLoadingHUD(_ targetView: UIView) {
    let hud = MBProgressHUD.showAdded(to: targetView, animated: true)
    hud.mode = MBProgressHUDMode.indeterminate
    hud.label.text = "Loading...";
}

func showHUD(_ targetView: UIView, message: String) {
    let hud = MBProgressHUD.showAdded(to: targetView, animated: true)
    hud.mode = MBProgressHUDMode.indeterminate
    hud.label.text = message;
}

func showSavingHUD(_ targetView: UIView) {
    let hud = MBProgressHUD.showAdded(to: targetView, animated: true)
    hud.mode = MBProgressHUDMode.indeterminate
    hud.label.text = "Saving...";
}

func showErrorHUD(_ targetView: UIView, message: String, hideAfterInSecond: Double) {
    let hud = MBProgressHUD.showAdded(to: targetView, animated: true)
    hud.mode = MBProgressHUDMode.customView
    hud.customView =  UIImageView(image: UIImage(named: "icon_main"))
    hud.label.text = message
    hud.hide(animated: true, afterDelay: hideAfterInSecond)
}

func hideHUD (_ targetView: UIView) {
    MBProgressHUD.hide(for: targetView, animated: true)
}
