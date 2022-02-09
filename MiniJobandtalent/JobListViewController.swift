import UIKit

class JobListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet private var tableView: UITableView!

    private var jobs: [Job]?
    private var token: NSObjectProtocol!

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Jobs"

        tableView.register(.init(nibName: "JobCell", bundle: nil), forCellReuseIdentifier: "Cell")

        token = NotificationCenter.default.addObserver(
            forName: .init("CellApplyButtonTapped"),
            object: nil,
            queue: nil
        ) { _ in
            self.tableView.reloadData()
        }

        let url = URL(string: "http://localhost:8000/jobs")!
        URLSession.shared.dataTask(with: url) { data, _, _ in
            self.jobs = try! JSONDecoder().decode([Job].self, from: data!)
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }.resume()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
        if let selectedIndexPath = tableView.indexPathForSelectedRow {
            tableView.deselectRow(at: selectedIndexPath, animated: true)
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return jobs?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! JobCell
        cell.job = jobs![indexPath.row]
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let job = jobs![indexPath.row]
        navigationController?.pushViewController(JobDetailViewController(job: job), animated: true)
    }
}
