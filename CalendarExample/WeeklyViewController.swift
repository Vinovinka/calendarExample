import UIKit

class WeeklyViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var monthLabel: UILabel!
    
    var selectedDate = Date()
    var totalSquare = [Date]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setCellsView()
        setMonthView()
    }
    
    func setCellsView() {
        let width = (collectionView.frame.size.width - 2) / 8
        let height = (collectionView.frame.size.height - 2) / 8

        let flowLayout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        flowLayout.itemSize = CGSize(width: width, height: height)
    }
    
    func setMonthView() {
        totalSquare.removeAll()
        
        var current = CalendarHelper().sundayForDate(date: selectedDate)
        let nextSunday = CalendarHelper().addDays(date: current, days: 7)
        
        while(current < nextSunday) {
            totalSquare.append(current)
            current = CalendarHelper().addDays(date: current, days: 1)
        }
        
        monthLabel.text = CalendarHelper().monthString(date: selectedDate) + " "
        + CalendarHelper().yearString(date: selectedDate)
        collectionView.reloadData()
    }
    
    
    @IBAction func nextWeek(_ sender: Any) {
        selectedDate = CalendarHelper().addDays(date: selectedDate, days: 7)
        setMonthView()
    }
    
    @IBAction func previousWeek(_ sender: Any) {
        selectedDate = CalendarHelper().addDays(date: selectedDate, days: -7)
        setMonthView()
    }
    
    override open var shouldAutorotate: Bool {
        return false
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        totalSquare.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "calCell", for: indexPath) as! CalendarCell
        
        let data = totalSquare[indexPath.row]
        cell.dayOfMonth.text = String(CalendarHelper().dayOfMonth(date: data))
        
        if(data == selectedDate) {
            cell.backgroundColor = UIColor.systemRed
            cell.layer.cornerRadius = 30
            cell.contentMode = .scaleAspectFill
            cell.layer.masksToBounds = true
        } else {
            cell.backgroundColor = UIColor.white
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedDate = totalSquare[indexPath.item]
        collectionView.reloadData()
    }
    
}


