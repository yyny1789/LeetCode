//
//  main.swift
//  算法准备
//
//  Created by Yangyang on 2019/3/7.
//  Copyright © 2019 Yangyang. All rights reserved.
//

import Foundation

func paixu(arr: [Int]) -> [Int] {
    var tmpArr = [Int]()
    
    for item in arr {
        if tmpArr.isEmpty {
            tmpArr.append(item)
        } else {
            for(index, num) in tmpArr.enumerated() {
                if item < num {
                    if index == tmpArr.count - 1 {
                        tmpArr.append(item)
                        break
                    }
                } else if item >= num {
                    tmpArr.insert(item, at: index)
                    break
                }
            }
        }
    }
    return tmpArr
}

let arr = [5, 3, 5, 2, 8]

//debugPrint(paixu(arr: arr))

// MARK: - 桶排序
// 桶排序
/*
 浪费空间
 */
func tongpaixu(_ arr: [Int]) -> [Int] {
    var tmpArr = [Int]()
    let count = 10
    for _ in 0...count {
        tmpArr.append(0)
    }
    
    for item in arr {
        let num = tmpArr[item]
        tmpArr[item] = num + 1
    }
    
    var tmpArr2 = [Int]()
    for i in 0...count {
        let num = tmpArr[count - i]
        if num > 0 {
            for _ in 0..<num {
                tmpArr2.append(count - i)
            }
        }
    }
    return tmpArr2
}

//debugPrint(tongpaixu(arr))

// MARK: - 冒泡排序
// 冒泡排序的基本思想：每次比较两个相邻的元素，如果它们的顺序错误就把它们交换过来。
func maopaopaixu(_ arr: [Int]) -> [Int] {
    var tmpArr = arr
    for j in 0..<arr.count {
        for i in 0..<arr.count - j {
            if i + 1 < arr.count - j {
                if tmpArr[i] < tmpArr[i + 1] {
                    let tmp = tmpArr[i + 1]
                    tmpArr[i + 1] = tmpArr[i]
                    tmpArr[i] = tmp
                }
            }
        }
    }
    return tmpArr
}

//debugPrint(maopaopaixu(arr))

// 链表两数之和

public class ListNode {
  public var val: Int
  public var next: ListNode?
  public init(_ val: Int) {
      self.val = val
      self.next = nil
  }
}

func addTwoNumbers(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {
    func fanzhuan(_ l: ListNode?) -> ListNode? {
        var targetl: ListNode?
        var tmpl = l
        while tmpl != nil {
            if targetl == nil {
                targetl = ListNode(tmpl!.val)
            } else {
                let secondTargetl = ListNode(tmpl!.val)
                secondTargetl.next = targetl!
                targetl = secondTargetl
            }
            tmpl = tmpl!.next
        }
        return targetl
    }
    
    func getCount(_ l: ListNode?) -> Int64 {
        var tmpl = l
        var num = 0
        var s = 1
        while(tmpl != nil) {
            num += tmpl!.val * s
            tmpl = tmpl!.next
            s *= 10
        }
        return Int64(num)
    }
    
    var count = getCount(l1) + getCount(l2)
    var targetl: ListNode?
    
    while ((count / 10 + count % 10) != 0) {
        let num = count % 10
        if targetl == nil {
            targetl = ListNode(Int(num))
        } else {
            let tmpl = ListNode(Int(num))
            tmpl.next = targetl
            targetl = tmpl
        }
        count = count / 10
    }
    
    return fanzhuan(targetl)
}

// MARK: - 数组
// MARK:  977.有序数组的平方

//func sortedSquares(_ A: [Int]) -> [Int] {
//    var arr = [Int]()
//    for i in 0..<A.count {
//        arr.append(A[i] * A[i])
//    }
//    arr.sort()
//    return arr
//}

func sortedSquares(_ A: [Int]) -> [Int] {
    var arr = [Int]()
    var j = 0
    
    while j < A.count {
        if A[j] >= 0 {
            break
        }
        j += 1
    }
    var i = j - 1

    while i >= 0 && j < A.count {
        if A[i] * A[i] > A[j] * A[j] {
            arr.append(A[j] * A[j])
            j += 1
        } else {
            arr.append(A[i] * A[i])
            i -= 1
        }
    }
    
    while i >= 0 {
        arr.append(A[i] * A[i])
        i -= 1
    }
    
    while j < A.count {
        arr.append(A[j] * A[j])
        j += 1
    }
    
    return arr
}

//let a = [-3, 0, 1, 5, 10]
//debugPrint(sortedSquares(a))

// MARK: 1. 两数之和

func twoSum(_ nums: [Int], _ target: Int) -> [Int] {
    var dict = [Int: Int]()
    for i in 0..<nums.count {
        if let j = dict[target - nums[i]] {
            return [i ,j]
        }
        dict[nums[i]] = i
    }
    return [0]
}

//debugPrint(twoSum([2, 7, 11], 9))


// MARK: 832. 翻转图像

func flipAndInvertImage(_ A: [[Int]]) -> [[Int]] {
    var tmp = A
    for (index, var arr) in tmp.enumerated() {
        var i = 0, j = arr.count - 1
        while i <= j {
            let tmp = arr[j]
            arr[j] = 1 - arr[i]
            arr[i] = 1 - tmp
            i += 1
            j -= 1
        }
        tmp[index] = arr
    }
    return tmp
}

//debugPrint(flipAndInvertImage([[1,1,0],[1,0,0,1],[0,1,1,1],[1,0,1,0]]))

// MARK: 905. 按奇偶排序数组

//func sortArrayByParity(_ A: [Int]) -> [Int] {
//    var tmp = [Int]()
//    for num in A {
//        if tmp.isEmpty {
//            tmp.append(num)
//        } else {
//            if num % 2 == 0 {
//                tmp.insert(num, at: 0)
//            } else {
//                tmp.append(num)
//            }
//        }
//    }
//    return tmp
//}

func sortArrayByParity(_ A: [Int]) -> [Int] {
    var tmp = A
    var left = 0, right = tmp.count - 1
    while left < right {
        while left < right && tmp[left] % 2 == 0  {
            left += 1
        }
        while left < right && tmp[right] % 2 != 0 {
            right -= 1
        }
        if left < right {
            let num = tmp[right]
            tmp[right] = tmp[left]
            tmp[left] = num
        }
    }
    return tmp
}

//debugPrint(sortArrayByParity([3, 1, 2, 4]))

// MARK: 922. 按奇偶排序数组 II

func sortArrayByParityII(_ A: [Int]) -> [Int] {
    var arr = [Int]()
    var arr1 = [Int]()
    var arr2 = [Int]()
    for item in A {
        if item % 2 == 0 {
            arr.append(item)
        } else {
            arr1.append(item)
        }
    }
    
    for i in 0..<arr.count {
        arr2.append(arr[i])
        arr2.append(arr1[i])
    }
    return arr2
}

// MARK: 985. 查询后的偶数和

func sumEvenAfterQueries(_ A: [Int], _ queries: [[Int]]) -> [Int] {
    var tmpArr = A
    var sunArr = [Int]()
    var sum = 0
    for item in tmpArr {
        sum += item % 2 == 0 ? item : 0
    }
    
    for i in 0..<queries.count {
        let val = queries[i][0]
        let index = queries[i][1]
        if tmpArr[index] % 2 == 0 {
            sum -= tmpArr[index]
        }
        tmpArr[index] += val
        if tmpArr[index] % 2 == 0 {
            sum += tmpArr[index]
        }
        sunArr.append(sum)
    }
    
    return sunArr
}

//debugPrint(sumEvenAfterQueries([1,2,3,4], [[1,0],[-3,1],[-4,0],[2,3]]))

// MARK: 509. 斐波那契数

//func fib(_ N: Int) -> Int {
//    while N >= 2 {
//        return fib(N - 1) + fib(N - 2)
//    }
//    return N
//}

func fib(_ N: Int) -> Int {
    if N < 2 {
        return N
    }
    var start = 2
    var first = 0
    var second = 1
    var sum = 0
    while start <= N {
        sum = first + second
        first = second
        second = sum
        start += 1
    }
    return sum
}

//debugPrint(fib(4))



