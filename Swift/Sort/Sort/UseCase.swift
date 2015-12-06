import Cocoa

// UseCase.swift
// Created by Paul Kraft on 04.12.15.

class UseCase
{
    init(rounds: Int, elements: Int, showResultsOfRound: Bool, showAllArrays: Bool)
	{
        if (elements < 1 || rounds < 1) { return }
		var unsorted : [Number] = []
		var s : [[(name: String, array: [Number], time: Double)]] = []
        for i in 1...rounds {
            unsorted = []
            let start = Double(NSDate().timeIntervalSince1970)
            for _ in 1...elements
            {
                unsorted.append(Number())
            }
            let end : Double = Double(NSDate().timeIntervalSince1970)
            print("round \(i) of \(rounds): \(stringWithThousandsPoint(unsorted.count)) elements")
            let a = self.compareSortingAlgorithms(unsorted, (end - start)*1000, showResultsOfRound)
            s.append(a)
            self.printComparedSortingAlgorithms(a, showAllArrays)
		}
		
        print("")
		for i in 0..<Sort<Number>().sortingAlgorithms.count+2 {
			var medianTime : Double = 0
			var times : Double = 0
			for j in 0..<s.count {
				medianTime += Double(s[j][i].time)
				times++
			}
            var output = s[0][i].name + ":"
            while output.characters.count < 26 {
                output += " "
            }
            for _ in 0...(10-String(Int(medianTime/times)).characters.count) {
                output += " "
            }
            output += stringWithThousandsPoint(Int(medianTime/times))
            output += " ms for " + stringWithThousandsPoint(s[0][i].array.count) + " elements."
			print(output)
            var separator = ""
            for _ in 0..<(output.characters.count) {
                separator += "-"
            }
            print(separator)
		}
		
	}
    
    func compareSortingAlgorithms(unsorted: [Number], _ initTime: Double, _ showIndividualResults: Bool) -> [(name: String, array: [Number], time: Double)] {
		var all : [(name: String, array: [Number], time: Double)] = []
		all.append(("Start", unsorted, initTime))
        var unsortedInt : [Int] = []
        for i in 0..<unsorted.count {
            unsortedInt.append(unsorted[i].description)
        }
        let start = NSDate()
        unsortedInt.sortInPlace()
        let end = Double(NSDate().timeIntervalSinceDate(start))*1000
        var unsortedNotInt : [Number] = []
        for i in 0..<unsortedInt.count {
            unsortedNotInt.append(Number(unsortedInt[i]))
        }
        all.append(("SortInPlace", unsortedNotInt, end))
        if showIndividualResults {
            print("\t\(all[1].name): \(stringWithThousandsPoint(Int(all[1].time))) ms", terminator: "")
        }
        
		for i in 0..<Sort<Number>().sortingAlgorithms.count {
            all.append(self.testAlg(Sort<Number>().sortingAlgorithms[i], unsorted))
            if showIndividualResults {
                print("\t\(all[i+2].name): \(stringWithThousandsPoint(Int(all[i+2].time))) ms", terminator: "")
            }
		}
        if showIndividualResults { print("\n") }
		return all
	}
	
	func printComparedSortingAlgorithms(info: [(name: String, array: [Number], time: Double)], _ printAllOut: Bool) {
		for i in 0..<info.count {
			//print(info[i].name, "(", info[i].time, " ms )")
			if printAllOut {
				for j in 0..<info[i].array.count { print(info[i].array[j].description) }
			}
			else
			{
				if(i > 0 && i < info.count) {
					for j in 0..<info[i].array.count {
						if(!(info[1].array[j].description == info[i].array[j].description)) {
							print(info[i].name, info[i].array[j].description)
						}
					}
				}
			}
		}
	}
    
    func stringWithThousandsPoint(number: Int) -> String {
        var anz = number
        var s = ""
        while anz >= 1000 {
            var a = "\(Int(anz % 1000))"
            while a.characters.count < 3 {
                a = "0" + a
            }
            s = ".\(a)\(s)"
            anz = anz/1000
        }
        return String(anz % 1000) + s
    }
	
	func testAlg(sort: (([Number]) -> (name: String, array: [Number])), _ unsorted: [Number]) -> (name: String, array: [Number], time: Double) {
		let start = NSDate()
        let sort = sort(unsorted)
        let end = Double(NSDate().timeIntervalSinceDate(start))*1000
		return (sort.name, sort.array, end)
	}
}
