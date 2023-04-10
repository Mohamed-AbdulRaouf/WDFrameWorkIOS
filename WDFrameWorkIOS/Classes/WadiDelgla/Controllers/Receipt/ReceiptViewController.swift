//
//  ReceiptViewController.swift
//  STDobites
//
//  Created by SimpleTouch on 11/14/19.
//  Copyright © 2019 SimpleTouch. All rights reserved.
//

import UIKit
import Kingfisher
class ReceiptViewController: STUIViewController,IBaseController {
    
    // MARK: - Properties
    typealias T = IReceiptViewModel
    var viewModel: IReceiptViewModel?
    
    // MARK: - IBOutlets
    @IBOutlet weak var tableHeight: NSLayoutConstraint!
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var brandNameLabel: UILabel!
    @IBOutlet weak var brandLogoImageView: UIImageView!
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        //bind UI
        self.setupUI()
        self.bindingData()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.viewModel?.getOrderDetails()
        if let _ = self.viewModel?.isFromCart{
            self.navigationItem.setHidesBackButton(true, animated:true);
        }else{
            self.doneButton.isHidden = true
        }
    }
    override func viewWillLayoutSubviews() {
        super.updateViewConstraints()
        self.tableHeight?.constant = self.tableView.contentSize.height
    }
    
    // MARK: - IBActions
    @IBAction func onDoneTapped(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
    }
}

// MARK: - Internal
extension ReceiptViewController{
    func setupUI(){
        self.viewModel?.delegate = self
        self.setupTableView()
        self.doneButton.layer.cornerRadius = 16
        self.navigationItem.title = "order_details".localized()
        self.doneButton.setTitle("done".localized(), for: .normal)
    }
    func bindingData() {}
}

// MARK: -Table Data Source
extension ReceiptViewController: UITableViewDelegate,UITableViewDataSource,IBaseTableView{
    
    func setupTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.estimatedRowHeight = 60.0
//        tableView.rowHeight = UITableView.automaticDimension
//        tableView.sectionHeaderHeight = UITableView.automaticDimension
        tableView.estimatedSectionHeaderHeight = 60.0
//        self.tableView.isScrollEnabled = false
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
#if swift(>=5.0)
print("Running Swift 5.0 or later")
        return UITableView.automaticDimension
#else
print("Running old Swift")
        return UITableViewAutomaticDimension //60 //UITableView.automaticDimension
#endif
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        guard  (self.viewModel?.order != nil) else { return 0 }
        guard let items = self.viewModel?.order?.orderItems , items.value?.count ?? 0 > 0 else {return 0}
        return items.value!.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard (self.viewModel?.order != nil) else { return 0 }
        guard let items = self.viewModel?.order?.orderItems , items.value?.count ?? 0 > 0 else {return 0}
        return items.value?[section].itemChoices.value?.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemChoiceTableViewCell", for: indexPath) as! ItemChoiceTableViewCell
        if let model = self.viewModel?.order?.orderItems.value, let choice = model[indexPath.section].itemChoices.value{
            cell.configureCell(choice[indexPath.row])
        }
        return cell
    }
}

// MARK: - Table Header & Foooter
extension ReceiptViewController {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
#if swift(>=5.0)
print("Running Swift 5.0 or later")
        return UITableView.automaticDimension
#else
print("Running old Swift")
        return UITableViewAutomaticDimension //60 //UITableView.automaticDimension
#endif
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForFooterInSection section: Int) -> CGFloat {
#if swift(>=5.0)
print("Running Swift 5.0 or later")
        return UITableView.automaticDimension
#else
print("Running old Swift")
        return UITableViewAutomaticDimension //60 //UITableView.automaticDimension
#endif
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let sectionHeader = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 60))
        let nameLabel = UILabel()
        let priceLabel = UILabel()
        nameLabel.font = APP_FONT_BOLD12
        priceLabel.font = APP_FONT_BOLD12
        nameLabel.numberOfLines = 0
        if LocalizationSystem.sharedInstance.isCurrentLanguageArabic() {
            nameLabel.text = "\(String(describing: self.viewModel?.order?.orderItems.value?[section].itemQty.value ?? 0).enToArDigits)* \(self.viewModel?.order?.orderItems.value?[section].itemTitle.value ?? "")"
                 
             }else{
                 nameLabel.text = "\(String(describing: self.viewModel?.order?.orderItems.value?[section].itemQty.value ?? 0))x \(self.viewModel?.order?.orderItems.value?[section].itemTitle.value ?? "")"
             }
             
             let price = Float(self.viewModel?.order?.orderItems.value?[section].itemQty.value ?? 0) * (self.viewModel?.order?.orderItems.value?[section].itemPrice.value ?? 0.0)
             
             priceLabel.text = " \(String(format: "%.2f", price ) + "\(String(describing: self.viewModel?.order?.orderItems.value?[section].currencyCode.value ?? "" ))")"
             [nameLabel].forEach {
                 $0?.textAlignment = LocalizationSystem.sharedInstance.isCurrentLanguageArabic() ? .right : .left
             }
        
        let subTotalStack : UIStackView = {
            let stackView = UIStackView(arrangedSubviews: [nameLabel, priceLabel])
            stackView.axis = .horizontal
            stackView.distribution = .fill
            stackView.alignment = .leading
            stackView.spacing = 20
            stackView.translatesAutoresizingMaskIntoConstraints = false
            return stackView
        }()
        nameLabel.widthAnchor.constraint(equalToConstant: 220).isActive = true
        subTotalStack.frame = CGRect(x: 0, y: 0, width: tableView.bounds.width, height: 60)
        sectionHeader.addSubview(subTotalStack)
        
        return sectionHeader
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        guard section == (self.viewModel?.order?.orderItems.value?.count ?? 0) - 1 else { return 0}
        return 206
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        guard section == (self.viewModel?.order?.orderItems.value?.count ?? 0) - 1 else { return UIView()}
        guard let order = self.viewModel?.order?.orderDetails.value else { return UIView()}
        
        let sectionHeader = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width - 50, height: 206))
        
        let subTotalTitleLabel = UILabel()
        let subTotalLabel = UILabel()
        subTotalTitleLabel.font = APP_FONT_BOLD12
        subTotalLabel.font = APP_FONT_BOLD12
        subTotalTitleLabel.text = "sub_total".localized()
        subTotalLabel.text = String(format: "%.2f \(String(describing: order.currencyCode.value ?? ""))", order.subTotal.value ?? 0)
        let subTotalStack : UIStackView = {
            let stackView = UIStackView(arrangedSubviews: [subTotalTitleLabel, subTotalLabel])
            stackView.axis = .horizontal
            stackView.distribution = .fill
            stackView.alignment = .leading
            stackView.spacing = 20
            stackView.translatesAutoresizingMaskIntoConstraints = false
            return stackView
        }()
        subTotalTitleLabel.widthAnchor.constraint(equalToConstant: 220).isActive = true
        
        let deliveryFeesLabelTitle = UILabel()
        let deliveryFeesLabel = UILabel()
        deliveryFeesLabelTitle.font = APP_FONT_BOLD12
        deliveryFeesLabel.font = APP_FONT_BOLD12
        deliveryFeesLabelTitle.text = "delivery_fees".localized()
        deliveryFeesLabel.text = String(format: "%.2f \(order.currencyCode.value ?? "")", order.deliveryFees.value ?? 0)
        let deliveryFeesStack : UIStackView = {
            let stackView = UIStackView(arrangedSubviews: [deliveryFeesLabelTitle, deliveryFeesLabel])
            stackView.axis = .horizontal
            stackView.distribution = .fill
            stackView.alignment = .leading
            stackView.spacing = 20
            stackView.translatesAutoresizingMaskIntoConstraints = false
            return stackView
        }()
        deliveryFeesLabelTitle.widthAnchor.constraint(equalToConstant: 220).isActive = true
        
        let loyalityDiscountLabelTitle = UILabel()
        loyalityDiscountLabelTitle.font = APP_FONT_BOLD12
        let loyalityDiscountLabel = UILabel()
        loyalityDiscountLabel.font = APP_FONT_BOLD12
        loyalityDiscountLabelTitle.text = "loyalty_discount".localized()
        loyalityDiscountLabel.text = String(format: " %.2f \(order.currencyCode.value ?? "")",order.loyaltyDiscount.value ?? 0)
        let loyalityDiscountStack : UIStackView = {
            let stackView = UIStackView(arrangedSubviews: [loyalityDiscountLabelTitle, loyalityDiscountLabel])
            stackView.axis = .horizontal
            stackView.distribution = .fill
            stackView.alignment = .leading
            stackView.spacing = 20
            stackView.translatesAutoresizingMaskIntoConstraints = false
            return stackView
        }()
        loyalityDiscountLabelTitle.widthAnchor.constraint(equalToConstant: 220).isActive = true
        
        let vatTitleLabel = UILabel()
        vatTitleLabel.font = APP_FONT_BOLD12
        let vatLabel = UILabel()
        vatLabel.font = APP_FONT_BOLD12
        vatTitleLabel.text = "VAT".localized()
        vatLabel.text = String(format: "%.2f \(order.currencyCode.value ?? "")",order.totalTax.value ?? 0)
        let vatStack : UIStackView = {
            let stackView = UIStackView(arrangedSubviews: [vatTitleLabel, vatLabel])
            stackView.axis = .horizontal
            stackView.distribution = .fill
            stackView.alignment = .leading
            stackView.spacing = 20
            stackView.translatesAutoresizingMaskIntoConstraints = false
            return stackView
        }()
        vatTitleLabel.widthAnchor.constraint(equalToConstant: 220).isActive = true
        
        let totalDiscountTitleLabel = UILabel()
        let totalDiscountLabel = UILabel()
        totalDiscountLabel.font = APP_FONT_BOLD12
        totalDiscountTitleLabel.font = APP_FONT_BOLD12
        totalDiscountTitleLabel.text = "discount".localized()
        totalDiscountLabel.text = String(format: " %.2f \(order.currencyCode.value ?? "")", order.totalDiscount.value ?? 0)
        let totalDiscountStack : UIStackView = {
            let stackView = UIStackView(arrangedSubviews: [totalDiscountTitleLabel, totalDiscountLabel])
            stackView.axis = .horizontal
            stackView.distribution = .fill
            stackView.alignment = .leading
            stackView.spacing = 20
            stackView.translatesAutoresizingMaskIntoConstraints = false
            return stackView
        }()
        totalDiscountTitleLabel.widthAnchor.constraint(equalToConstant: 220).isActive = true
        
        let totalTitleLabel = UILabel()
        let totalLabel = UILabel()
        totalTitleLabel.font = APP_FONT_BOLD12
        totalLabel.font = APP_FONT_BOLD12
        totalTitleLabel.text = "total".localized()
        totalLabel.text = String(format: " %.2f \(order.currencyCode.value ?? "")", order.orderTotal.value ?? 0)
        let totalStack : UIStackView = {
            let stackView = UIStackView(arrangedSubviews: [totalTitleLabel, totalLabel])
            stackView.axis = .horizontal
            stackView.distribution = .fill
            stackView.alignment = .leading
            stackView.spacing = 20
            stackView.translatesAutoresizingMaskIntoConstraints = false
            return stackView
        }()
        totalTitleLabel.widthAnchor.constraint(equalToConstant: 220).isActive = true

        let lineView : UIView = {
            let view = UIView()
            view.backgroundColor = .gray
            view.translatesAutoresizingMaskIntoConstraints = false
            view.clipsToBounds = true
            return view
        }()
        
        let headerLineView : UIView = {
            let view = UIView()
            view.backgroundColor = .gray
            view.translatesAutoresizingMaskIntoConstraints = false
            view.clipsToBounds = true
            return view
        }()
        
        let fullStack : UIStackView = {
            let stackView = UIStackView(arrangedSubviews: [headerLineView, subTotalStack, deliveryFeesStack, loyalityDiscountStack, vatStack, totalDiscountStack, lineView, totalStack])
            stackView.axis = .vertical
            stackView.distribution = .fill
            stackView.alignment = .fill
            stackView.spacing = 10
            stackView.translatesAutoresizingMaskIntoConstraints = false
            return stackView
        }()
        lineView.heightAnchor.constraint(equalToConstant: 2).isActive = true
        headerLineView.heightAnchor.constraint(equalToConstant: 2).isActive = true
        fullStack.frame = CGRect(x: 0, y: 0, width: tableView.bounds.width - 50, height: 206)
        sectionHeader.addSubview(fullStack)
        
        [subTotalTitleLabel,subTotalLabel,deliveryFeesLabel,deliveryFeesLabelTitle,loyalityDiscountLabel,loyalityDiscountLabelTitle,vatTitleLabel,vatLabel,totalDiscountLabel,totalDiscountTitleLabel].forEach {
            $0.font = APP_FONT_REGULAR11
            $0.textColor = COLOR_PRIMARY_TEXT
        }
        
        [ totalTitleLabel,totalLabel].forEach {
            $0.font = APP_FONT_BOLD12
            $0.sizeToFit()
            $0.textColor = COLOR_PRIMARY_TEXT
        }
        
        return sectionHeader
    }
}

// MARK: - IReceiptViewController Protocol
extension ReceiptViewController : IReceiptViewController{
    func onReloadTableView() {
        self.tableView.reloadData()
    }
    func onReloadView(){
        if let imageUrl = URL(string: self.viewModel?.order?.orderDetails.value?.brandLogo.value ?? ""){
            let resource = ImageResource(downloadURL: imageUrl, cacheKey: self.viewModel?.order?.orderDetails.value?.brandLogo.value)
            self.brandLogoImageView.kf.setImage(with: resource)
        } else {
            self.brandLogoImageView.image = UIImage(named: "dobites_splash")
        }
        self.brandNameLabel.text = self.viewModel?.order?.orderDetails.value?.brandName.value ?? ""
        self.headerLabel.text = "my_items".localized()
        self.onReloadTableView()
    }
}
