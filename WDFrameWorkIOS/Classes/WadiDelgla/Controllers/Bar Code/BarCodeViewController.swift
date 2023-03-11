//
//  BarCodeViewController.swift
//  STDobites
//
//  Created by Nermeen Mohamed on 11/4/19.
//  Copyright © 2019 SimpleTouch. All rights reserved.
//

import UIKit
import Bond
class BarCodeViewController: UIViewController ,IBaseController{
    
    // MARK: - Properties
    typealias T = IBarCodeViewModel
    var viewModel: IBarCodeViewModel?

    // MARK: - IBOutlets
    @IBOutlet weak var barCodeImageView: UIImageView!
    @IBOutlet weak var userInfoLabel: UILabel!
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        //bind UI
        self.setupUI()
        self.bindingData()
        
        //initialize data
        self.viewModel?.viewDidload()
    }
}

// MARK: - Internal
extension BarCodeViewController{
    func setupUI(){
        self.navigationItem.title = R.string.localizable.bar_code()
    }
    
    func bindingData() {
        if let viewModel = viewModel {
            //            viewModel.userInfo
            //                .map {_ in "\(viewModel.userFirstName.value) \(viewModel.userLastName.value)" }
            //                .bind(to: userInfoLabel)
            viewModel.userInfo
                .bind(to: userInfoLabel)
            viewModel.barCodeImage.bind(to: barCodeImageView.reactive.image)
        }
    }
}
 
