//
//  ViewController.swift
//  Tournament
//
//  Created by Muthusamy, Shankar (S.) on 21/06/23.
//

import Combine
import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tabelview: UITableView!
    var sortStatus = true
    @IBOutlet weak var sortButton: UIButton!
    var homeViewModel: HomeViewable = HomeViewModel(networkClient: NetworkClientImp())
    var playerDatamodel: [PlayerDataModel] = []
    var cancellables: Set<AnyCancellable> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        title = "Star Wars Blaster Tournament"
//        Task {
//            await homeViewModel.getHomeData()
//            await MainActor.run(body: {
//                sortAndReloadtableView()
//            })
//        }
        do {
            try homeViewModel.getHomeData()
                .receive(on: DispatchQueue.main)
                .sink { completion in
                    switch completion {
                    case .finished: break
                    case .failure(_): break
                    }
                } receiveValue: { [weak self] playerData in
                    self?.playerDatamodel = playerData
                    self?.sortAndReloadtableView()
                }.store(in: &cancellables)
        } catch {
            print(error)
        }
    }
    
    private func sortAndReloadtableView() {
        playerDatamodel = playerDatamodel.sorted(by: { sortStatus ? $0.score > $1.score : $0.score < $1.score })
        sortButton.setTitle("Sort \(sortStatus ? "Dsc" : "Asc")", for: .normal)
        tabelview.reloadData()
    }
    
    @IBAction func sort(_ sender: Any) {
        sortStatus = !sortStatus
        sortAndReloadtableView()
    }
}

extension ViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        playerDatamodel.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Points table"
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell: HomeTableViewCell = tableView.dequeueReusableCell(withIdentifier: "homecell") as? HomeTableViewCell {
            let viewModel = HomeTableViewCellViewModel(playerDataModel: playerDatamodel[indexPath.row])
            cell.configureCell(homeTableViewCellViewModel: viewModel)
            return cell
        }
        return UITableViewCell()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let viewController: DetailViewController = segue.destination as? DetailViewController,
           let playerDataModel = sender as? PlayerDataModel {
            viewController.viewModel.playerDatamodel = playerDataModel
            viewController.title = playerDataModel.name
        }
    }
    
}

extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? HomeTableViewCell {
//            cell.viewModel.name = "shankar"
//            print(cell.nameLabel.text)
            performSegue(withIdentifier: "detail", sender: playerDatamodel[indexPath.row])
        }
    }
}
