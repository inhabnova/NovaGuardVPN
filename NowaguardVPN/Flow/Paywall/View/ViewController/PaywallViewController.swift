import UIKit

final class PaywallViewController: UIViewController {

    // MARK: - UI Elements
    
    private let backgroundImageView = UIImageView(image: I.Paywall.background)
    private var titlelabel: PaywallTitleLabel!
    private var subTitlelabel = UILabel()
    private let restoreButton = UIButton()
    private let closeButton = UIButton()
    private let touButton = UIButton()
    private let ppButton = UIButton()
    private let subsButton = GreenButton(title: PaywallLocalization.button.localized)
    
    private var paywallButton1: PaywallButton!
    private var paywallButton2: PaywallButton!
    private var paywallButton3: PaywallButton!

    // MARK: - Public Properties
    
    var presenter: PaywallPresenter!
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layoutSetup()
        setupConstraints()
        presenter.onViewDidload()
    }
}

// MARK: - PaywallView

extension PaywallViewController: PaywallView {
    
    // MARK: - setOwnPurcshase
    
    func setOwnPurcshase(trialCount: Int, price: String, period: String) {
        titlelabel = PaywallTitleLabel(whiteText: "\(PaywallLocalization.title_1white.localized)\n",
                                              greenText: PaywallLocalization.title_1green.localized)
        titlelabel.numberOfLines = 0
        subTitlelabel.text = PaywallLocalization.subTitle1_1.localized
        
        let trialLabel = UILabel()
        trialLabel.text = "\(trialCount) \(PaywallLocalization.daysFree.localized), \(PaywallLocalization.then.localized) \(price) / \(period)"
        trialLabel.textAlignment = .center
        trialLabel.font = .systemFont(ofSize: .calc(14), weight: .medium)
        trialLabel.textColor = .appGlayLabel
        
        let infoLabel1 = SettingButton(image: I.Paywall.checkMark, title: PaywallLocalization.info1_1.localized, "")
        let infoLabel2 = SettingButton(image: I.Paywall.checkMark, title: PaywallLocalization.info2_1.localized, "")
        let infoLabel3 = SettingButton(image: I.Paywall.checkMark, title: PaywallLocalization.info3_1.localized, "")
        infoLabel3.removeSeparator()
        infoLabel1.isUserInteractionEnabled = false
        infoLabel2.isUserInteractionEnabled = false
        infoLabel3.isUserInteractionEnabled = false
        
        view.addSubviews([titlelabel, trialLabel, infoLabel1, infoLabel2, infoLabel3])
        
        titlelabel.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.centerY.equalToSuperview().multipliedBy(0.75)
        }
        
        subTitlelabel.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(40)
            $0.top.equalTo(titlelabel.snp.bottom).inset(-20)
        }
        
        trialLabel.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.bottom.equalTo(subsButton.snp.top).inset(-10)
        }
        
        infoLabel1.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.height.equalToSuperview().multipliedBy(0.075)
            $0.top.equalTo(subTitlelabel.snp.bottom).inset(-30)
        }
        infoLabel2.snp.makeConstraints {
            $0.width.height.horizontalEdges.equalTo(infoLabel1)
            $0.top.equalTo(infoLabel1.snp.bottom)
        }
        infoLabel3.snp.makeConstraints {
            $0.width.height.horizontalEdges.equalTo(infoLabel1)
            $0.top.equalTo(infoLabel2.snp.bottom)
        }
    }
    
    // MARK: - setThreePurcshase
    
    func setThreePurcshase(dataPurchase: [(Int, String)]) {
        
        if dataPurchase.count >= 1 {
            paywallButton1 = PaywallButton(period: PaywallLocalization.week.localized,
                                           priceLabelTextWhite: "\(dataPurchase[0].0) " + PaywallLocalization.daysFree.localized, priceLabelTextGreen: ", " + PaywallLocalization.then.localized + " \(dataPurchase[0].1)",
                                           isSelected: true)
            paywallButton1.addTarget(self, action: #selector(paywallButton1Action), for: .touchUpInside)
            view.addSubview(paywallButton1)
        }
        
        if dataPurchase.count >= 2 {
            paywallButton2 = PaywallButton(period: PaywallLocalization.month.localized,
                                           priceLabelTextWhite: "\(dataPurchase[1].0) " + PaywallLocalization.daysFree.localized, priceLabelTextGreen: ", " + PaywallLocalization.then.localized + " \(dataPurchase[1].1)",
                                           isSelected: false)
            paywallButton2.addTarget(self, action: #selector(paywallButton2Action), for: .touchUpInside)
            view.addSubview(paywallButton2)
        }
        
        if dataPurchase.count >= 3 {
            paywallButton3 = PaywallButton(period: PaywallLocalization.year.localized,
                                           priceLabelTextWhite: "\(dataPurchase[2].0) " + PaywallLocalization.daysFree.localized, priceLabelTextGreen: ", " + PaywallLocalization.then.localized + " \(dataPurchase[2].1)",
                                           isSelected: false)
            paywallButton3.addTarget(self, action: #selector(paywallButton3Action), for: .touchUpInside)
            view.addSubview(paywallButton3)
        }
        
        
        
        titlelabel = PaywallTitleLabel(whiteText: PaywallLocalization.title_3white.localized,
                                              greenText: PaywallLocalization.title_3green.localized)
        subTitlelabel.text = PaywallLocalization.subTitle1_3.localized
        
        view.addSubviews([titlelabel])
        
        titlelabel.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.centerY.equalToSuperview().multipliedBy(0.75)
        }
        
        subTitlelabel.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(40)
            $0.top.equalTo(titlelabel.snp.bottom).inset(-20)
        }
        
        paywallButton1.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.top.equalTo(subTitlelabel.snp.bottom).inset(-view.frame.height / 27)
        }
        paywallButton2.snp.makeConstraints {
            $0.horizontalEdges.height.equalTo(paywallButton1)
            $0.top.equalTo(paywallButton1.snp.bottom).inset(-10)
        }
        paywallButton3.snp.makeConstraints {
            $0.top.equalTo(paywallButton2.snp.bottom).inset(-10)
            $0.horizontalEdges.height.equalTo(paywallButton1)
            $0.bottom.equalTo(subsButton.snp.top).inset(-view.frame.height / 27)
        }
    }
    
    func showBackButton() {
        closeButton.isHidden = false
    }
    
    func showErrorAlert() {
        let alert = UIAlertController(title: "Nothing to Restore", message: nil, preferredStyle: .alert)
        let ok = UIAlertAction(title: "Ok", style: .default)
        alert.addAction(ok)
        DispatchQueue.main.async {
            self.present(alert, animated: true)
        }
    }
}

// MARK: - Layout Setup

private extension PaywallViewController {
    func layoutSetup() {
        view.addSubviews([backgroundImageView, subTitlelabel, restoreButton, closeButton, touButton, ppButton, subsButton])
        
        subTitlelabel.adjustsFontSizeToFitWidth = true
        
        subTitlelabel.font = .systemFont(ofSize: .calc(16), weight: .medium)
        subTitlelabel.textColor = .white
        subTitlelabel.textAlignment = .center
        subTitlelabel.numberOfLines = 0
        
        restoreButton.setImage(I.Paywall.refresh, for: .normal)
        closeButton.setImage(I.Paywall.close, for: .normal)
        touButton.setTitle(PaywallLocalization.tou.localized, for: .normal)
        ppButton.setTitle(PaywallLocalization.pp.localized, for: .normal)
        touButton.setTitleColor(.appGlayLabel, for: .normal)
        touButton.titleLabel?.font = .systemFont(ofSize: .calc(14), weight: .medium)
        ppButton.setTitleColor(.appGlayLabel, for: .normal)
        ppButton.titleLabel?.font = .systemFont(ofSize: .calc(14), weight: .medium)
        
        restoreButton.addTarget(self, action: #selector(restoreButtonAction), for: .touchUpInside)
        closeButton.addTarget(self, action: #selector(closeButtonAction), for: .touchUpInside)
        touButton.addTarget(self, action: #selector(touButtonAction), for: .touchUpInside)
        ppButton.addTarget(self, action: #selector(ppButtonAction), for: .touchUpInside)
        subsButton.addTarget(self, action: #selector(subsButtonAction), for: .touchUpInside)
        
        
        closeButton.isHidden = true
    }
}

// MARK: - Actions

private extension PaywallViewController {
    @objc func restoreButtonAction() {
        presenter.restore()
    }
    @objc func closeButtonAction() {
        presenter.close()
    }
    @objc func touButtonAction() {
        presenter.openToU()
    }
    @objc func ppButtonAction() {
        presenter.openPP()
    }
    @objc func subsButtonAction() {
        presenter.subscription()
    }
    @objc func paywallButton1Action() {
        presenter.indexSelectedPurchase = 0
        guard !paywallButton1.isSelected else { return }
        paywallButton1.isSelected = true
        paywallButton2.isSelected = false
        paywallButton3.isSelected = false
    }
    @objc func paywallButton2Action() {
        presenter.indexSelectedPurchase = 1
        guard !paywallButton2.isSelected else { return }
        paywallButton1.isSelected = false
        paywallButton2.isSelected = true
        paywallButton3.isSelected = false
    }
    @objc func paywallButton3Action() {
        presenter.indexSelectedPurchase = 2
        guard !paywallButton3.isSelected else { return }
        paywallButton1.isSelected = false
        paywallButton2.isSelected = false
        paywallButton3.isSelected = true
    }
}

// MARK: - Setup Constraints

private extension PaywallViewController {
    func setupConstraints() {
        backgroundImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        restoreButton.snp.makeConstraints {
            $0.top.equalToSuperview().inset(40)
            $0.left.equalToSuperview().inset(20)
        }
        closeButton.snp.makeConstraints {
            $0.right.equalToSuperview().inset(20)
            $0.top.equalTo(restoreButton.snp.top)
        }
        touButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(40)
            $0.left.equalToSuperview().inset(20)
        }
        ppButton.snp.makeConstraints {
            $0.right.equalToSuperview().inset(20)
            $0.top.equalTo(touButton.snp.top)
        }
        subsButton.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.bottom.equalTo(ppButton.snp.top).inset(-10)
            $0.height.equalTo(view.frame.height / 14.5)
        }
        
    }
}
