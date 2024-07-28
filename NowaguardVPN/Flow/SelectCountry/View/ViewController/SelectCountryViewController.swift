import UIKit

final class SelectCountryViewController: UIViewController {

    // MARK: - UI Elements
    
    private let tableView = UITableView()
    private let backButton = UIButton()
    private let titleLabel = TitleLabel(whiteText: SelectCountryLocalization.select.localized,
                                        greenText: SelectCountryLocalization.country.localized)

    // MARK: - Public Properties
    
    var presenter: SelectCountryPresenter!
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTable()
        layoutSetup()
        setupConstraints()
    }
}

// MARK: - SelectCountryView

extension SelectCountryViewController: SelectCountryView {

}

// MARK: - Layout Setup

private extension SelectCountryViewController {
    func layoutSetup() {
        view.backgroundColor = .appGray
        view.addSubviews([tableView, titleLabel, backButton])
        
        backButton.setImage(I.SelectCountry.backButton, for: .normal)
        backButton.addTarget(self, action: #selector(backButtonAction), for: .touchUpInside)
    }
    
    @objc func backButtonAction() {
        presenter.close()
    }
}

// MARK: - Setup Constraints

private extension SelectCountryViewController {
    func setupConstraints() {
        tableView.snp.makeConstraints {
            $0.horizontalEdges.bottom.equalToSuperview().inset(20)
            $0.top.equalTo(backButton.snp.bottom).inset(-20)
        }
        
        backButton.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.width.height.equalTo(24)
            $0.left.equalToSuperview().inset(20)
        }
        
        titleLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalTo(backButton.snp.centerY)
        }
    }
}

// MARK: - Table view

private extension SelectCountryViewController {
    func setupTable() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(SelectCountryTableViewCell.self, forCellReuseIdentifier: SelectCountryTableViewCell.identifier)
        tableView.backgroundColor = .appGray
        tableView.separatorStyle = .none
    }
}

extension SelectCountryViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        SelectCountryTableViewCell.flugImageViewSize * 1.5
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.servers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SelectCountryTableViewCell.identifier, for: indexPath) as? SelectCountryTableViewCell else {
            return UITableViewCell()
        }
        cell.configure(with: presenter.servers[indexPath.row], isSelected: presenter.servers[indexPath.row] == presenter.selectedServer)
        return cell
    }
    
    
}
