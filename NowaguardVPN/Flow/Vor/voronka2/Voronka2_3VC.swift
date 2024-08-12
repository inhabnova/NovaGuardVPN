import UIKit

final class Voronka2_3VC: UIViewController, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        contents.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = contents[indexPath.row]
        cell.textLabel?.textColor = .red
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.textAlignment = .center
        cell.textLabel?.font = .systemFont(ofSize: .calc(15), weight: .regular)
        cell.backgroundColor = .clear
        return cell
    }
    
    
    var presenter: VorPresenter
    
    private let textTitle: String
    private let subtitle: String
    private let buttonTGitle: String
    private let subtitles: [String]
    
    private let image = UIImageView(image: I.Vor.v2_2)
    private let foregroundImageView = UIImageView(image: I.Vor.v2_21)
    private let titleLabel = UILabel()
    private let subtitleLabel = UILabel()
    private lazy var button = Vor2_btn(leftColor: UIColor(hex: "#009EFD"), rightColor: UIColor(hex: "#2AF598"), title: buttonTGitle)
    private let table = UITableView()
    
    private var contents: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        
        view.addSubviews([image, foregroundImageView, titleLabel, subtitleLabel, button, table])
        
        image.contentMode = .scaleToFill
        image.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.centerX.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.123)
            make.width.equalToSuperview().multipliedBy(0.133)
        }
        foregroundImageView.contentMode = .scaleToFill
        
        titleLabel.textColor = .white
        titleLabel.font = .systemFont(ofSize: .calc(24), weight: .regular)
        titleLabel.text = textTitle
        titleLabel.numberOfLines = 0
        titleLabel.textAlignment = .center
        titleLabel.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.top.equalTo(image.snp.bottom).inset(-20)
        }
        
        subtitleLabel.textColor = .appGrayVor
        subtitleLabel.font = .systemFont(ofSize: .calc(18), weight: .regular)
        subtitleLabel.text = subtitle
        subtitleLabel.numberOfLines = 0
        subtitleLabel.textAlignment = .center
        subtitleLabel.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.top.equalTo(titleLabel.snp.bottom).inset(-40)
        }
        
        button.isUserInteractionEnabled = false
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        button.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(15)
            $0.bottom.equalToSuperview().inset(30)
            $0.height.equalTo(view.frame.height / 14.5)
        }
        
        table.dataSource = self
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        table.separatorStyle = .none
        table.isUserInteractionEnabled = false
        table.backgroundColor = .clear
        table.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.top.equalTo(subtitleLabel.snp.bottom).inset(-40)
            $0.bottom.equalTo(button.snp.top).inset(-40)
        }
        
        for i in 0...subtitles.count - 1 {
            let period = Int.random(in: 500...4000)
            DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(period)) { [weak self] in
                self?.contents.append(self!.subtitles[i])
                self?.table.reloadData()
                self?.table.scrollToRow(at: IndexPath(row: self!.contents.count - 1, section: 0), at: .bottom, animated: true)
                if i == self!.subtitles.count - 1 {
                    self?.foregroundImageView.removeFromSuperview()
                    self?.button.isUserInteractionEnabled = true
                }
            }
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        foregroundImageView.frame = .init(x: image.frame.minX,
                                          y: image.frame.minY,
                                          width: 20,
                                          height: image.frame.size.height)
        moveImage()
    }
    
    // MARK: - moveImage
    func moveImage () {
        UIView.animate(withDuration: 1, delay: 0, options: [.repeat, .autoreverse]) { [weak self] in
            guard let self else { return }
            foregroundImageView.frame = .init(x: image.frame.maxX - 20,
                                              y: image.frame.minY,
                                              width: 20,
                                              height: image.frame.size.height)
        }
        
    }
    
    @objc func buttonAction() {
        let vc = Voronka2_4VC(presenter: presenter)
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: false)
    }
    
    init(presenter: VorPresenter) {
        self.presenter = presenter
        self.textTitle = presenter.textTitleV2_3
        self.subtitle = presenter.subtitleV2_3
        self.buttonTGitle = presenter.buttonTGitleV2_3
        self.subtitles = presenter.subtitles
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
