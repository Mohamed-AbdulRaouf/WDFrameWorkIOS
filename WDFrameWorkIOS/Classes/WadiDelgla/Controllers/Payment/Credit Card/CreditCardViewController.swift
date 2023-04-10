//
//  CreditCardViewController.swift
//  STDobites
//
//  Created by SimpleTouch on 9/15/20.
//  Copyright © 2020 SimpleTouch. All rights reserved.
//

import UIKit
//import KashierPaymentSDK
import SwifterSwift
class CreditCardViewController: STUIViewController ,IBaseController{
    
    
    // MARK: - IBOUTLETS
    @IBOutlet weak var headerTitleLabel: UILabel!
    @IBOutlet weak var headerSubTitleLabel: UILabel!
    @IBOutlet weak var cardHolderNameTextField: STErrorTextField!
    @IBOutlet weak var cardNumberTextField: STErrorTextField!
    @IBOutlet weak var cardCvvTextField: STErrorTextField!
    @IBOutlet weak var cardExpiryDateTextField: STErrorTextField!
    @IBOutlet weak var continueButton: UIButton!
    
    @IBOutlet weak var cardCvvErrorLabel: UILabel!
    @IBOutlet weak var cardExpiryDateErrorLabel: UILabel!
    @IBOutlet weak var cardHolderNameErrorLabel: UILabel!
    @IBOutlet weak var cardNumberErrorLabel: UILabel!
    // MARK: - Variables
    typealias T = ICreditCardViewModel
    var viewModel: ICreditCardViewModel?
    var previousTextFieldContent: String?
    var previousSelection: UITextRange?
    
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.setupUI()
        self.bindingData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    // MARK: - IBActions
    @IBAction func onContinueButtonTapped(_ sender: Any) {
       self.viewModel?.useCard()
    }
    @IBAction func onDismissButtonTapped(_ sender: Any) {
         self.dismiss(animated: true, completion: nil)
    }
}
// MARK: - Internal
extension CreditCardViewController {
    func setupUI(){
        
        self.viewModel?.delegate = self
        self.headerTitleLabel.text = "add_credit_card".localized()
        self.headerTitleLabel.textColor = COLOR_PRIMARY_TEXT
        self.headerTitleLabel.font = APP_FONT_BOLD14 //UIFont(resource: APP_FONT_BOLD, size: 14)
        
        self.headerSubTitleLabel.text = "add_credit_card_hint".localized()
        self.headerSubTitleLabel.textColor = COLOR_PRIMARY_TEXT
        self.headerSubTitleLabel.font = APP_FONT_REGULAR16 // UIFont(resource: APP_FONT_REGULAR, size: 16)
        [self.cardHolderNameTextField,self.cardNumberTextField,cardExpiryDateTextField,cardCvvTextField].forEach{
            $0?.underlineTextField(.lightGray)
        }
        
        self.cardHolderNameTextField.placeholder = "name_on_card".localized()
        self.cardNumberTextField.placeholder = "card_number".localized()
        self.cardExpiryDateTextField.placeholder = "expiry_date".localized()
        self.cardCvvTextField.placeholder = "cvv".localized()
        [cardNumberTextField,cardCvvTextField,cardExpiryDateTextField].forEach{
            $0?.delegate = self
        }
        // Do any additional setup after loading the view, typically from a nib
        self.cardNumberTextField.addTarget(self, action: #selector(reformatAsCardNumber), for: .editingChanged)
        self.cardCvvTextField.maxLength = 3
        self.cardCvvTextField.isSecureTextEntry = true
        
        [self.cardHolderNameErrorLabel,self.cardNumberErrorLabel,self.cardExpiryDateErrorLabel,self.cardCvvErrorLabel].forEach {
            $0?.textColor = .red
        }
        let title = self.viewModel?.sourceDelegate == nil ? "save".localized() :  "continue".localized()
        self.continueButton.setTitle(title, for: .normal)
        
    }
    func bindingData() {
        if let viewModel = viewModel , let card_data = viewModel.cardData{
            
            cardNumberTextField.reactive.text.map({$0?.arToEnDigits}).map({$0?.replacingOccurrences(of: " ", with: "")}).bind(to: card_data.cardNumber)
            
            cardHolderNameTextField.reactive.text.bind(to:card_data.cardHolderName)
            
            cardExpiryDateTextField.reactive.text.map({$0?.arToEnDigits}).map({$0?.replacingOccurrences(of: "/", with: "")}).bind(to:card_data.cardExpiryDate)
            
            cardCvvTextField.reactive.text.bind(to: card_data.cardCvv)
            
            
            cardHolderNameErrorLabel.text =  viewModel.errorModel?.msgCardHolderNameError.value
            cardExpiryDateErrorLabel.text = viewModel.errorModel?.msgCardExpiryDateError.value
            cardNumberErrorLabel.text = viewModel.errorModel?.msgCardNumberError.value
            cardCvvErrorLabel.text = viewModel.errorModel?.msgCardCVVError.value
        }
    }
}
