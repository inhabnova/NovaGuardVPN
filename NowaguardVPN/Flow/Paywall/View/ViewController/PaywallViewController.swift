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
    
    private lazy var paywallButton1 = PaywallButton(period: PaywallLocalization.week.localized,
                                       priceLabelTextWhite: "3 " + PaywallLocalization.daysFree.localized, priceLabelTextGreen: ", " + PaywallLocalization.then.localized + " 3$",
                                       isSelected: true)
    private lazy var paywallButton2 = PaywallButton(period: PaywallLocalization.month.localized,
                                       priceLabelTextWhite: "3 " + PaywallLocalization.daysFree.localized, priceLabelTextGreen: ", " + PaywallLocalization.then.localized + " 12$",
                                       isSelected: false)
    private lazy var paywallButton3 = PaywallButton(period: PaywallLocalization.year.localized,
                                       priceLabelTextWhite: "3 " + PaywallLocalization.daysFree.localized, priceLabelTextGreen: ", " + PaywallLocalization.then.localized + " 120$",
                                      isSelected: false)

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
    
    func setOwnPurcshase() {
        titlelabel = PaywallTitleLabel(whiteText: "\(PaywallLocalization.title_1white.localized)\n",
                                              greenText: PaywallLocalization.title_1green.localized)
        titlelabel.numberOfLines = 2
        subTitlelabel.text = PaywallLocalization.subTitle1_1.localized
        
        let trialLabel = UILabel()
        trialLabel.text = "3 Day’s Free, then 12.99$ / per week"
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
    
    func setThreePurcshase() {
        titlelabel = PaywallTitleLabel(whiteText: PaywallLocalization.title_3white.localized,
                                              greenText: PaywallLocalization.title_3green.localized)
        subTitlelabel.text = PaywallLocalization.subTitle1_3.localized
        
        view.addSubviews([titlelabel, paywallButton1, paywallButton2, paywallButton3])
        
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
}

// MARK: - Layout Setup

private extension PaywallViewController {
    func layoutSetup() {
        view.addSubviews([backgroundImageView, subTitlelabel, restoreButton, closeButton, touButton, ppButton, subsButton])
        
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
        paywallButton1.addTarget(self, action: #selector(paywallButton1Action), for: .touchUpInside)
        paywallButton2.addTarget(self, action: #selector(paywallButton2Action), for: .touchUpInside)
        paywallButton3.addTarget(self, action: #selector(paywallButton3Action), for: .touchUpInside)
        
        
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
        guard !paywallButton1.isSelected else { return }
        paywallButton1.isSelected = true
        paywallButton2.isSelected = false
        paywallButton3.isSelected = false
    }
    @objc func paywallButton2Action() {
        guard !paywallButton2.isSelected else { return }
        paywallButton1.isSelected = false
        paywallButton2.isSelected = true
        paywallButton3.isSelected = false
    }
    @objc func paywallButton3Action() {
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
