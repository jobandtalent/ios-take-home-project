import UIKit

class JobCell: UITableViewCell {
    @IBOutlet private(set) var jobTitleLabel: UILabel!
    @IBOutlet private(set) var applyButton: UIButton!

    var job: Job! {
        didSet {
            jobTitleLabel.text = job.name
            applyButton.setTitle(
                job.applied ? "Remove application" : "Apply",
                for: .normal
            )
        }
    }

    @IBAction private func applyButtonTapped(_ sender: UIButton) {
        job.applied = !job.applied

        NotificationCenter.default.post(name: .init("CellApplyButtonTapped"), object: nil)
    }
}
