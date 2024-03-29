
import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var monthLabel: UILabel!
    
    var selectedDate = Date()
    var totalSquare = [String]()
    var totalSquareDates = [Date]()
    var currentMonth = String()
    
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
        
        let daysInMonth = CalendarHelper().daysInMonth(date: selectedDate)
        let firstDayOfMonth = CalendarHelper().firstOfMonth(date: selectedDate)
        let startingSpaces = CalendarHelper().weekDay(date: firstDayOfMonth)
        
        var count: Int = 1
        
        while(count <= 42) {
            
            if (count <= startingSpaces || count - startingSpaces > daysInMonth) {
                
                totalSquare.append("")
            } else {
                
                totalSquare.append(String(count - startingSpaces))
            }
            
            count += 1
        }
        
        monthLabel.text = CalendarHelper().monthString(date: selectedDate) + " "
        + CalendarHelper().yearString(date: selectedDate)
        collectionView.reloadData()
    }
    
//    func setMonthDateView() {
//        totalSquareDates.removeAll()
//        
//        var current = CalendarHelper().sundayForDate(date: selectedDate)
//
//    }
    
    
    @IBAction func nextMonth(_ sender: Any) {
        selectedDate = CalendarHelper().plusMonth(date: selectedDate)
        setMonthView()
    }
    
    @IBAction func previousMonth(_ sender: Any) {
        selectedDate = CalendarHelper().minusMonth(date: selectedDate)
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
        cell.dayOfMonth.text = totalSquare[indexPath.item]
        
        let data = totalSquare[indexPath.row]

        let todayDate = CalendarHelper().dayOfMonthString(date: selectedDate)
        
        if(data.hasPrefix(todayDate)) {
            cell.backgroundColor = UIColor.systemRed
            cell.layer.cornerRadius = cell.frame.size.width / 2
            cell.clipsToBounds = true
            cell.dayOfMonth.textColor = UIColor.white
        } else {
            cell.backgroundColor = UIColor.white
        }
        
//        if currentMonth == months[calendar.component(.month, from: date) - 1] && year == calendar.component(.year, from: date) && indexPath.row + 1 == day {
//            cell.backgroundColor = UIColor.red
//        }
        
        
        return cell
    }
    
}

