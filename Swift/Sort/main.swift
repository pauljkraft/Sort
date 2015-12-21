
//
//  main.swift
//  Sort
//
//  Created by Paul Kraft on 13.12.15.
//  Copyright © 2015 Paul Kraft. All rights reserved.
//

let              times = 1
let             rounds = 1000
let           elements = 50
let showResultsOfRound = false
let      showAllArrays = false

let sortingAlgorithms : [[Number] -> (String, [Number])] = [
    //shellSort,
    //mergeSort,
    //mergeSortThreaded,
    //selectionSort,
    //insertionSort,
    //quickSortFirst,
    //quickSortFirstThreaded,
    //quickSortInPlace,
    //quickSortInPlaceThreaded,
    //quickSortMedian,
    //quickSortMedianThreaded,
    //quickSortRandom,
    //quickSortRandomThreaded,
    //
    introSortMedianThreaded,
    //introSortMedian,
    //heapSort,
    //bubbleSort
    //
    binaryTreeSort,
    //
    avlBinaryTreeSort
]

for i in 0..<times {
    var s = Test(
        rounds:rounds,
        elements:elements,
        showResultsOfRound:showResultsOfRound,
        showAllArrays:showAllArrays,
        sortingAlgorithms: sortingAlgorithms)
}
