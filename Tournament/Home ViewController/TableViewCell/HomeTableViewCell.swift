//
//  HomeTableViewCell.swift
//  Tournament
//
//  Created by Muthusamy, Shankar (S.) on 21/06/23.
//

import Combine
import UIKit

class HomeTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var avatarImageView: UIImageView!
    
    var viewModel: HomeTableViewCellViewModel!
    
    var cancellables: Set<AnyCancellable> = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code

    }
    
    func configureCell(homeTableViewCellViewModel: HomeTableViewCellViewModel) {
        self.viewModel = homeTableViewCellViewModel
        cancellables = [
            viewModel.$name.assign(to: \.text, on: nameLabel),
            viewModel.$score.assign(to: \.text, on: scoreLabel)
        ]
        viewModel.$avatarImage
            .sink { [weak self] imageUrl in
                guard let imageUrl = imageUrl else { return }
                self?.fetchAndUpdateImageView(imageUrl: imageUrl)
            }.store(in: &cancellables)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func fetchAndUpdateImageView(imageUrl: String) {
        guard let url = URL(string: imageUrl) else { return }
        URLSession.shared.dataTask(with: URLRequest(url: url)) { [weak self] data, response, error in
            if let response: HTTPURLResponse = response as? HTTPURLResponse,
               (200...299).contains(response.statusCode),
               error == nil,
               let data, let self = self {
                DispatchQueue.main.async {
                    self.avatarImageView.image = UIImage(data: data)
                }
            }
        }.resume()
    }

}
