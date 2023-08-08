//
//  DetailViewController.swift
//  Tournament
//
//  Created by Muthusamy, Shankar (S.) on 21/06/23.
//

import Foundation
import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var viewModel: DetailViewable = DetailViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.reloadData()
    }
    
}

extension DetailViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.playerDatamodel?.playerMatchDetails.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell: DetailTableViewCell = tableView.dequeueReusableCell(withIdentifier: "detailcell") as? DetailTableViewCell,
           let dataModel = viewModel.playerDatamodel?.playerMatchDetails[indexPath.row] {
            cell.player1Name.text = dataModel.player1Name
            cell.score.text = "\(dataModel.player1score) - \(dataModel.player2Score)"
            cell.player2name.text = dataModel.player2Name
            cell.contentView.backgroundColor = dataModel.resultStatus?.getUIcolor()
            return cell
        }
        return UITableViewCell()
    }
    
}

extension DetailViewController: UITableViewDelegate {
    
}
