import UIKit

class JobDetailViewController: UIViewController {
    @IBOutlet var applyButton: UIButton!

    private let job: Job

    init(job: Job) {
        self.job = job
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = job.name
        setButtonTitle()
    }

    @IBAction func applyButtonTapped(_ sender: Any) {
        job.applied = !job.applied
        setButtonTitle()
    }

    private func setButtonTitle() {
        applyButton.setTitle(
            job.applied ? "Remove application" : "Apply",
            for: .normal
        )
    }
}
