//
//  main.swift
//  算法准备
//
//  Created by Yangyang on 2019/3/7.
//  Copyright © 2019 Yangyang. All rights reserved.
//

import Foundation

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

// MARK: 桶排序
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

// MARK: 冒泡排序
// 冒泡排序的基本思想：每次比较两个相邻的元素，如果它们的顺序错误就把它们交换过来。
func maopaopaixu(_ arr: [Int]) -> [Int] {
    var resultArr = arr
    
    for i in 1..<resultArr.count {
        for j in 0..<resultArr.count - i {
            if resultArr[j] > resultArr[j + 1] {
                let tmp = resultArr[j]
                resultArr[j] = resultArr[j + 1]
                resultArr[j + 1] = tmp
            }
        }
    }
    return resultArr
}

// MARK: 选择排序
/*
 首先在未排序序列中找到最小（大）元素，存放到排序序列的起始位置

 再从剩余未排序元素中继续寻找最小（大）元素，然后放到已排序序列的末尾。

 重复第二步，直到所有元素均排序完毕。
 */
func xuanzepaixu(_ arr: [Int]) -> [Int] {
    var resultArr = arr
    
    for i in 0..<resultArr.count - 1 {
        var min = i
        for j in i..<resultArr.count {
            if resultArr[j] < resultArr[min] {
                min = j
            }
        }
        let tmp = resultArr[i]
        resultArr[i] = resultArr[min]
        resultArr[min] = tmp
    }
    return resultArr
}

// MARK: 插入排序
/*
 将第一待排序序列第一个元素看做一个有序序列，把第二个元素到最后一个元素当成是未排序序列。
 从头到尾依次扫描未排序序列，将扫描到的每个元素插入有序序列的适当位置。（如果待插入的元素与有序序列中的某个元素相等，则将待插入元素插入到相等元素的后面。）
 */
func charupaixu(_ arr: [Int]) -> [Int] {
    var resultArr = arr
    
    for i in 1..<resultArr.count {
        var j = i
        
        while j > 0 {
            if resultArr[j] < resultArr[j - 1] {
                let tmp = resultArr[j - 1]
                resultArr[j - 1] = resultArr[j]
                resultArr[j] = tmp
                j -= 1
            } else {
                break
            }
        }
    }
    return resultArr
}

debugPrint(charupaixu(arr))

// MARK:  977.有序数组的平方
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

// MARK: ❤️ 509. 斐波那契数

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

// MARK: 561. 数组拆分 I
func arrayPairSum(_ nums: [Int]) -> Int {
    let tmpArr = nums.sorted()
    var sum = 0
    var i = 0
    while i < nums.count {
        sum += tmpArr[i]
        i += 2
    }
    return sum
}

//debugPrint(arrayPairSum([1,4,3,2]))

// MARK: ❤️ 15. 三数之和

func threeSum(_ nums: [Int]) -> [[Int]] {
    var set = Set<[Int]>()
    var array = [[Int]]()
    
    if nums.count < 3 { return array }
    
    for i in 0..<nums.count - 2 {
        for j in (i + 1)..<nums.count - 1 {
            for k in (i + 2)..<nums.count {
                if nums[i] + nums[j] + nums[k] == 0 {
                    set.insert([nums[i], nums[j], nums[k]])
                }
            }
        }
    }
    set.forEach { (item) in
        array.append(item)
    }
    return array
}

//debugPrint(threeSum([-1, 0, 1, 2, -1, -4]))

// MARK: 至少是其他数字两倍的最大数

func dominantIndex(_ nums: [Int]) -> Int {
    if nums.count == 1 { return 0 }
    var dic = [Int: Int]()
    for i in 0..<nums.count {
        dic[nums[i]] = i
    }
    var array = nums.sorted()
    
    let last = array[nums.count - 1]
    let second = array[nums.count - 2]
    if second == 0 {
        return dic[last] ?? -1
    } else {
        if last / second >= 2 {
            return dic[last] ?? -1
        } else {
            return -1
        }
    }
}

// MARK: 加一

func plusOne(_ digits: [Int]) -> [Int] {
    var arr = digits
    var index = arr.count - 1
    var next = 0
    while index >= 0 {
        var num = arr[index]
        if index == arr.count - 1 {
            num += 1
        } else {
            num += next
            next = 0
        }
        if num >= 10 {
            num -= 10
            next = 1
        }
        arr[index] = num
        index -= 1
    }
    if next == 1 {
        arr.insert(1, at: 0)
    }
    return arr
}

//debugPrint(plusOne([9, 9, 9]))

// MARK: ❤️ 498. 对角线遍历

//func findDiagonalOrder(_ matrix: [[Int]]) -> [Int] {
//    var array = [Int]()
//    if matrix.count == 0 {
//        return array
//    }
//    let M = matrix.count
//    let N = matrix[0].count
//    let maxCount = M + N - 2
//    var i = 0
//
//    while i <= maxCount {
//        if i % 2 == 0 {
//            for j in 0..<N {
//                if i - j >= 0 && i - j < M {
//                    array.append(matrix[i - j][j])
//                }
//            }
//        } else {
//            for j in 0..<M {
//                if i - j >= 0 && i - j < N {
//                    array.append(matrix[j][i - j])
//                }
//            }
//        }
//        i += 1
//    }
//
//    return array
//}

func findDiagonalOrder(_ matrix: [[Int]]) -> [Int] {
    var array = [Int]()
    if matrix.count == 0 {
        return array
    }
    let row = matrix.count
    let col = matrix[0].count
    var r = 0
    var c = 0
    
    for i in 0..<row*col {
        array.append(matrix[r][c])
        if (r + c) % 2 == 0 {
            if c == col - 1 {
                // 往右移动一格准备向下遍历
                r += 1
            } else if r == 0 {
                // 往下移动一格准备向下遍历
                c += 1
            } else {
                // 往上移动
                r -= 1
                c += 1
            }
        } else {
            if r == row - 1 {
                // 往右移动一格准备向上遍历
                c += 1
            } else if c == 0 {
                // 往上移动一格准备向上遍历
                r += 1
            } else {
                // 往下移动
                r += 1
                c -= 1
            }
        }
    }
    
    return array
}

//debugPrint(findDiagonalOrder([[1, 2, 3], [4, 5, 6], [7, 8, 9]]))

// MARK: 54. 螺旋矩阵
func spiralOrder(_ matrix: [[Int]]) -> [Int] {
    var array = [Int]()
    if matrix.count == 0 {
        return array
    }
    let row = matrix.count
    let col = matrix[0].count
    var r = 0
    var c = 0
    var x = 1
    
    for i in 0..<row*col {
//        array.append(matrix[r][c])
        debugPrint(r,c)
        //0,0  0,col-1 row-1,col-1, row-1,0
        if r == x - 1 && c <= col - x {
            c += 1
        } else if r > x - 1 && c == col - x {
            r += 1
        } else if r == row - x && c < col - x {
            c -= 1
        } else if r < row - x && c == x - 1 {
            r -= 1
        }
        
        if c > col - x {
            c -= 1
            r += 1
        }
        if r > row - x {
            r -= 1
            c -= 1
        }
        if c < x - 1 {
            c += 1
            r -= 1
        }
        
        if r == c && r == x - 1 {
            c += 1
            r += 1
            x += 1
        }
    }
    return array
}

//debugPrint(spiralOrder([[2,5],[8,4],[0,-1]]))

// MARK: 118. 杨辉三角

func generate(_ numRows: Int) -> [[Int]] {
    var arr = [[Int]]()
    var lastArr = [Int]()

    for i in 0..<numRows {
        var tmpArr = [Int]()
        for j in 0..<i + 1{
            if lastArr.count == 0 {
                tmpArr.append(1)
            } else {
                var x = 0
                if j - 1 >= 0 {
                    x += lastArr[j - 1]
                }
                if j < lastArr.count {
                    x += lastArr[j]
                }
                if x == 0 {
                    x = 1
                }
                tmpArr.append(x)
            }
        }
        lastArr = tmpArr
        arr.append(lastArr)
    }
    
    return arr
}

//debugPrint(generate(4))

// MARK: 67. 二进制求和
func addBinary(_ a: String, _ b: String) -> String {
    let count = max(a.count, b.count)
    var tmpStr = ""
    var last = 0
    
    for i in 0..<count {
        var sum = last
        if a.count - 1 - i >= 0 {
            let index = a.index(a.startIndex, offsetBy: a.count - 1 - i)
            if let subA = Int(String(a[index])) {
                sum += subA
            }
        }
        if b.count - 1 - i >= 0 {
            let index = b.index(b.startIndex, offsetBy: b.count - 1 - i)
            if let subB = Int(String(b[index])) {
                sum += subB
            }
        }
        last = sum / 2
        if let char = "\(sum % 2)".first {
            tmpStr.insert(char, at: tmpStr.startIndex)
        }
    }
    if last > 0 {
        if let char = "\(last)".first {
            tmpStr.insert(char, at: tmpStr.startIndex)
        }
    }
    
    return tmpStr
}

//debugPrint(addBinary("1010", "1011"))

// MARK: 14. 最长公共前缀
func longestCommonPrefix(_ strs: [String]) -> String {
    var prefix = ""
    var flag = true
    var index = 0
    while flag {
        if let firstStr = strs.first, firstStr.count > 0 && index < firstStr.count {
            let tmpPrefix = prefix + String(firstStr[firstStr.index(firstStr.startIndex, offsetBy: index)])
            for i in 1..<strs.count {
                if !strs[i].hasPrefix(tmpPrefix) {
                    flag = false
                    break
                }
            }
            if flag {
                index += 1
                prefix = tmpPrefix
            }
        } else {
            flag = false
        }
    }
    
    return prefix
}

//debugPrint(longestCommonPrefix(["flower","flow","floght"]))

// MARK: 344. 反转字符串

func reverseString(_ s: inout [Character]) {
    if s.isEmpty { return }
    var i = 0
    while i < s.count / 2 {
        let pre = s[i]
        s[i] = s[s.count - 1 - i]
        s[s.count - 1 - i] = pre
        i += 1
    }
}

//var characterArr: [Character] = ["A","P", "a", "n", "a", "m"]
//reverseString(&characterArr)
//
//debugPrint(characterArr)

// MARK: 167. 两数之和 II - 输入有序数组

func twoSum2(_ numbers: [Int], _ target: Int) -> [Int] {
    var dic = [Int: Int]()
    var arr = [Int]()
    for i in 0..<numbers.count {
        if let index = dic[target - numbers[i]] {
            arr = i > index ? [index + 1, i + 1] : [i + 1, index + 1]
            break
        }
        dic[numbers[i]] = i
    }
    return arr
}

//debugPrint(twoSum2([2, 7, 11, 15], 13))

// MARK: 27. 移除元素

func removeElement(_ nums: inout [Int], _ val: Int) -> Int {
    var k = 0
    for i in 0..<nums.count {
        if nums[i] != val {
            nums[k] = nums[i]
            k += 1
        }
    }
    return k
}

//var nums = [3,2,2,3]
//
//debugPrint(removeElement(&nums, 3), nums)

// MARK: ❤️ 485. 最大连续1的个数

//func findMaxConsecutiveOnes(_ nums: [Int]) -> Int {
//    let length = nums.count
//    var maxCount = 0
//    var index = 0
//
//    while index < length {
//        if nums[index] == 1 {
//            var nextIndex = index
//            for i in (index + 1)..<length {
//                if nums[i] == 1 {
//                    nextIndex = i
//                } else {
//                    break
//                }
//            }
//            maxCount = max(maxCount, nextIndex - index + 1)
//            index = nextIndex + 1
//        } else {
//            index += 1
//        }
//    }
//
//    return maxCount
//}

func findMaxConsecutiveOnes(_ nums: [Int]) -> Int {
    var count = 0
    var max = 0
    for i in 0..<nums.count {
        if nums[i] == 1 {
            count += 1
        } else {
            count = 0
        }
        
        if count > max {
            max = count
        }
    }
    return max
}

//debugPrint(findMaxConsecutiveOnes([1,0]))

// MARK: ❤️ 209. 长度最小的子数组

//func minSubArrayLen(_ s: Int, _ nums: [Int]) -> Int {
//    var minLength = 0
//
//    for i in 0..<nums.count {
//        var sum = nums[i]
//        var count = 1
//        var j = i + 1
//        while j < nums.count && sum < s {
//            sum += nums[j]
//            j += 1
//            count += 1
//        }
//        if sum >= s {
//            minLength = minLength == 0 ? count : min(count, minLength)
//        }
//    }
//    return minLength
//}

// 滑块做法
func minSubArrayLen(_ s: Int, _ nums: [Int]) -> Int {
    if nums.count == 0 { return 0 }
    
    var l = 0
    var r = 0
    var sum = nums[0]
    var res = -1
    
    while l < nums.count {
        if sum < s {
            if r + 1 >= nums.count {
                break
            }
            r += 1
            sum += nums[r]
        } else {
            res = min(res, r - l + 1)
            sum -= nums[l]
            l += 1
        }
    }
    return res == -1 ? 0 : res
}

//debugPrint(minSubArrayLen(7, [1,1,1,1,1,2]))

// MARK: 189. 旋转数组

func rotate(_ nums: inout [Int], _ k: Int) {
    if nums.count == 0 { return }
    var j = k > nums.count ? k - nums.count : k
    while j > 0 {
        nums.insert(nums.last ?? nums[0], at: 0)
        nums.removeLast()
        j -= 1
    }
}

//var nums = [-1,-100,3,99]
//debugPrint(rotate(&nums, 5), nums)

// MARK: 119. 杨辉三角 II

func getRow(_ rowIndex: Int) -> [Int] {
    var lastArr = [Int]()
    
    for i in 0..<rowIndex + 1 {
        var tmpArr = [Int]()
        for j in 0..<i + 1{
            if lastArr.count == 0 {
                tmpArr.append(1)
            } else {
                var x = 0
                if j - 1 >= 0 {
                    x += lastArr[j - 1]
                }
                if j < lastArr.count {
                    x += lastArr[j]
                }
                if x == 0 {
                    x = 1
                }
                tmpArr.append(x)
            }
        }
        lastArr = tmpArr
    }
    
    return lastArr
}

//debugPrint(getRow(3))

// MARK: 151. 翻转字符串里的单词

func reverseWords(_ s: String) -> String {
    var arr = s.split(separator: " ")
    var tmpStr = ""
    while !arr.isEmpty {
        if let str = arr.last {
            if tmpStr != "" {
                tmpStr += " "
            }
            tmpStr += str
            arr.removeLast()
        }
    }
    return tmpStr
}

//debugPrint(reverseWords("a good   example"))

// MARK: 557. 反转字符串中的单词 III

func reverseWords2(_ s: String) -> String {
    let tmpS = s as NSString
    var arr = tmpS.components(separatedBy: " ")
    for (index, var subS) in arr.enumerated() {
        var count = subS.count
        var newS = ""
        while count > 0 {
            newS.append(subS.removeLast())
            count -= 1
        }
        arr[index] = newS
    }
    return arr.joined(separator: " ")
}

//debugPrint(reverseWords2(""))

// MARK: 26. 删除排序数组中的重复项

func removeDuplicates(_ nums: inout [Int]) -> Int {
    var tmpN: Int? = nil
    var k = 0
    for i in 0..<nums.count {
        if let n = tmpN, nums[i] == n {
            
        } else {
            tmpN = nums[i]
            nums[k] = nums[i]
            k += 1
        }
    }
    return k
}

//var nums = [0,0,1,1,1,2,2,3,3,4]
//
//debugPrint(removeDuplicates(&nums), nums)

// MARK: 283. 移动零

func moveZeroes(_ nums: inout [Int]) {
    var k = nums.count
    var j = 0
    while k > 0 {
        if nums[j] == 0 {
            nums.append(nums[j])
            nums.remove(at: j)
            k -= 1
        } else {
            j += 1
            k -= 1
        }
    }
}

//var nums = [1,1,0,0,12]
//moveZeroes(&nums)
//debugPrint(nums)

// MARK: - 链表

// MARK: ❤️ 707. 设计链表

class MyLinkedList {
    
    var val: Int?
    var next: MyLinkedList?
    
    /** Initialize your data structure here. */
    init() {
        
    }
    
    /** Get the value of the index-th node in the linked list. If the index is invalid, return -1. */
    func get(_ index: Int) -> Int {
        var tmpIndex = index
        var res: MyLinkedList? = self
        
        while tmpIndex > 0 {
            res = res?.next
            tmpIndex -= 1
        }
        return res?.val ?? -1
    }
    
    /** Add a node of value val before the first element of the linked list. After the insertion, the new node will be the first node of the linked list. */
    func addAtHead(_ val: Int) {
        if let v = self.val {
            let head = MyLinkedList() // 此处是指针引用，不能用 head = self
            head.val = v
            head.next = self.next
            
            self.val = val
            self.next = head
        } else {
            self.val = val
        }
    }
    
    /** Append a node of value val to the last element of the linked list. */
    func addAtTail(_ val: Int) {
        if let _ = self.val {
            var next: MyLinkedList? = self
            while next?.next != nil {
                next = next?.next
            }
            let tail = MyLinkedList()
            tail.val = val
            
            next?.next = tail
        } else {
            self.val = val
        }
    }
    
    /** Add a node of value val before the index-th node in the linked list. If index equals to the length of linked list, the node will be appended to the end of linked list. If index is greater than the length, the node will not be inserted. */
    func addAtIndex(_ index: Int, _ val: Int) {
        if index == 0 { // 需要判断 index == 0 的情况
            addAtHead(val)
            return
        }
        var tmpIndex = index - 1
        var res: MyLinkedList? = self
        
        while tmpIndex > 0 {
            res = res?.next
            tmpIndex -= 1
        }
        let tail = MyLinkedList()
        tail.val = val
        tail.next = res?.next
        
        if let _ = res?.val {
            res?.next = tail
        }
    }
    
    /** Delete the index-th node in the linked list, if the index is valid. */
    func deleteAtIndex(_ index: Int) {
        var tmpIndex = index
        var pre: MyLinkedList?
        var res: MyLinkedList? = self
        
        while tmpIndex > 0 {
            if tmpIndex == 1 {
                pre = res
            }
            res = res?.next
            tmpIndex -= 1
        }
        
        pre?.next = res?.next
    }
}

//let obj = MyLinkedList()
//obj.addAtHead(0)
//obj.addAtIndex(1, 9)
//obj.addAtIndex(1, 5)
//obj.addAtTail(7)
//obj.addAtHead(1)
//obj.addAtIndex(5, 8)
//obj.addAtIndex(5, 2)
//obj.addAtIndex(3, 0)
//obj.addAtTail(1)
//obj.addAtTail(0)
//obj.deleteAtIndex(6)


// MARK: 19. 删除链表的倒数第N个节点
//func removeNthFromEnd(_ head: ListNode?, _ n: Int) -> ListNode? {
//    var count = 0
//    var newHead = head
//    while newHead != nil {
//        count += 1
//        newHead = newHead!.next
//    }
//    var index = count - n
//    if index == 0 {
//        return head?.next
//    }
//    var pre = head
//    var cur = head
//
//    while index > 0  {
//        pre = cur
//        cur = cur?.next
//        index -= 1
//    }
//
//    pre?.next = cur?.next
//    return head
//}

// 使用双指针方法
func removeNthFromEnd(_ head: ListNode?, _ n: Int) -> ListNode? {
    var fast = 0
    var fastNode = head
    var slowNode = head
    while fast < n {
        fastNode = fastNode?.next
        fast += 1
    }
    while fastNode != nil && fastNode?.next != nil {
        fastNode = fastNode?.next
        slowNode = slowNode?.next
    }
    if fastNode == nil {
        return head?.next
    } else {
        slowNode?.next = slowNode?.next?.next
        return head
    }
}

//var head = ListNode(1)
//var head1 = ListNode(2)
//var head2 = ListNode(3)
//var head3 = ListNode(4)
//var head4 = ListNode(5)
//head.next = head1
//head1.next = head2
//head2.next = head3
//head3.next = head4
//
//let newHead = removeNthFromEnd(head, 2)
//debugPrint(newHead)

// MARK: 206. 反转链表

func reverseList(_ head: ListNode?) -> ListNode? {
    var newHead = head
    let first = head
    var next = first?.next
    while next != nil {
        first?.next = next?.next
        next?.next = newHead
        newHead = next
        next = first?.next
    }
    return newHead
}

//let newHead = reverseList(head)
//debugPrint(newHead)

// MARK: 203. 移除链表元素

func removeElements(_ head: ListNode?, _ val: Int) -> ListNode? {
    var newHead = head
    var pre: ListNode?
    var cur = newHead
    while cur != nil {
        if cur!.val == val {
            cur = cur?.next
            if pre == nil {
                newHead = cur
            } else {
                pre?.next = cur
            }
        } else {
            pre = cur
            cur = cur?.next
        }
    }
    return newHead
}

//let newHead = removeElements(head, 5)
//debugPrint(newHead)

// MARK: 328. 奇偶链表

func oddEvenList(_ head: ListNode?) -> ListNode? {
    var cur = head
    var evenHead: ListNode?
    var evenLast: ListNode?
    var oddHead: ListNode?
    var oddLast: ListNode?
    var i = 1
    
    while cur != nil {
        if i % 2 == 0 {
            if oddHead == nil {
                oddHead = cur
                oddLast = cur
            } else {
                oddLast?.next = cur
                oddLast = cur
            }
        } else {
            if evenHead == nil {
                evenHead = cur
                evenLast = cur
            } else {
                evenLast?.next = cur
                evenLast = cur
            }
        }
        cur = cur?.next
        i += 1
    }
    evenLast?.next = nil
    oddLast?.next = nil
    evenLast?.next = oddHead
    return evenHead
}

//let newHead = oddEvenList(head)
//debugPrint(newHead)


// MARK: ❤️ 234. 回文链表

func isPalindrome(_ head: ListNode?) -> Bool {
    var arr = [Int]()
    var cur = head
    while cur != nil {
        arr.append(cur!.val)
        cur = cur?.next
    }
    var left = 0
    var right = arr.count - 1

    while left < right {
        if arr[left] == arr[right] {
            left += 1
            right -= 1
        } else {
            return false
        }
    }
    return true
}

// 你能否用 O(n) 时间复杂度和 O(1) 空间复杂度解决此题？
// 要实现 O(n) 的时间复杂度和 O(1) 的空间复杂度，需要翻转后半部分
// 根据快慢指针，找到链表的中点
//func isPalindrome(_ head: ListNode?) -> Bool {
//    // todo
//    return true
//}

// 1   true
// 1 2 false
// 1 0 1 true
// 1 1 1 true
// 1 1 0 false
// 1 1 1 1 true
// 1 2 2 2 2 1 true

//var head = ListNode(1)
//var head2 = ListNode(1)
//var head3 = ListNode(0)
//head.next = head2
//head2.next = head3
//
//debugPrint(isPalindrome(head))

// MARK: 21. 合并两个有序链表

func mergeTwoLists(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {
    var newL: ListNode?
    var newCur: ListNode?
    var tmpL1 = l1
    var tmpL2 = l2
    
    while tmpL1 != nil && tmpL2 != nil {
        if tmpL1!.val < tmpL2!.val {
            if newL != nil {
                newCur?.next = tmpL1
                newCur = tmpL1
            } else {
                newL = tmpL1
                newCur = tmpL1
            }
            tmpL1 = tmpL1?.next
        } else {
            if newL != nil {
                newCur?.next = tmpL2
                newCur = tmpL2
            } else {
                newL = tmpL2
                newCur = tmpL2
            }
            tmpL2 = tmpL2?.next
        }
    }
    newCur?.next = nil
    
    if let _ = tmpL1 {
        if newL != nil {
            newCur?.next = tmpL1
            newCur = tmpL1
        } else {
            newL = tmpL1
            newCur = tmpL1
        }
    }
    if let _ = tmpL2 {
        if newL != nil {
            newCur?.next = tmpL2
            newCur = tmpL2
        } else {
            newL = tmpL2
            newCur = tmpL2
        }
    }
    return newL
}

// 1->2->4, 1->3->4

//var head = ListNode(1)
//var head2 = ListNode(2)
//var head4 = ListNode(4)
//head.next = head2
//head2.next = head4
//
//var headL = ListNode(1)
//var headL2 = ListNode(3)
//var headL4 = ListNode(4)
//headL.next = headL2
//headL2.next = headL4
//
//let newHead = mergeTwoLists(nil, headL)
//debugPrint(newHead)

// MARK: 61. 旋转链表

func rotateRight(_ head: ListNode?, _ k: Int) -> ListNode? {
    if head == nil { return nil }
    
    var count = 0
    var tmpHead = head
    while tmpHead != nil {
        tmpHead = tmpHead?.next
        count += 1
    }
    
    var fast = head
    var fastIndex = 0
    var slow = head
    
    while fastIndex < k % count {
        fast = fast?.next
        if fast == nil {
            fast = head
        }
        fastIndex += 1
    }
    
    while fast?.next != nil {
        fast = fast?.next
        slow = slow?.next
    }
    
    let newHead = slow?.next
    if newHead == nil {
        return head
    }
    var newHeadLast = newHead
    while newHeadLast?.next != nil {
        newHeadLast = newHeadLast?.next
    }
    
    slow?.next = nil
    newHeadLast?.next = head
    
    return newHead
}

//var head = ListNode(1)
//var head2 = ListNode(2)
//var head3 = ListNode(3)
//var head4 = ListNode(4)
//var head5 = ListNode(5)
//
//head.next = head2
//head2.next = head3
//head3.next = head4
//head4.next = head5

//var headL = ListNode(1)
//var headL2 = ListNode(3)
//var headL4 = ListNode(4)
//headL.next = headL2
//headL2.next = headL4

//let newHead = rotateRight(head, 7)
//debugPrint(newHead)

// MARK: - 哈希表

// MARK: 705. 设计哈希集合

class MyHashSet {
    
    /** Initialize your data structure here. */
    
    var storeArr = [[Int]]()

    init() {
        for _ in 0...1000 {
            let arr = [Int]()
            self.storeArr.append(arr)
        }
    }
    
    func add(_ key: Int) {
        let lastKey = key % 1000
        var arr = storeArr[lastKey]
        if !arr.contains(key) {
            arr.append(key)
        }
        storeArr[lastKey] = arr
    }
    
    func remove(_ key: Int) {
        let lastKey = key % 1000
        var arr = storeArr[lastKey]
        
        let index = arr.firstIndex(of: key)
        if index != nil {
            arr.remove(at: index!)
            storeArr[lastKey] = arr
        }
    }
    
    /** Returns true if this set contains the specified element */
    func contains(_ key: Int) -> Bool {
        let lastKey = key % 1000
        let arr = storeArr[lastKey]
        
        let index = arr.firstIndex(of: key)
        return index != nil
    }
    
}

//let hashSet = MyHashSet()
//hashSet.add(1)
//hashSet.add(2)
//debugPrint(hashSet.contains(1))     // 返回 true
//debugPrint(hashSet.contains(3))      // 返回 false (未找到)
//hashSet.add(2)
//debugPrint(hashSet.contains(2))   // 返回 true
//hashSet.remove(2)
//debugPrint(hashSet.contains(2))     // 返回  false (已经被删除)

// MARK: 706. 设计哈希映射

class MyHashMap {
    
    /** Initialize your data structure here. */
    
    var storeArr = [([Int], [Int])]()
    
    init() {
        for _ in 0...1000 {
            let arr = [Int]()
            let arr2 = [Int]()
            storeArr.append((arr, arr2))
        }
    }
    
    /** value will always be non-negative. */
    func put(_ key: Int, _ value: Int) {
        let lastKey = key % 1000
        let arrs = storeArr[lastKey]
        var keyArr = arrs.0
        var valueArr = arrs.1
        
        if let index = keyArr.firstIndex(of: key) {
            valueArr[index] = value
        } else {
            keyArr.append(key)
            valueArr.append(value)
        }
        storeArr[lastKey] = (keyArr, valueArr)
    }
    
    /** Returns the value to which the specified key is mapped, or -1 if this map contains no mapping for the key */
    func get(_ key: Int) -> Int {
        let lastKey = key % 1000
        let arrs = storeArr[lastKey]
        let keyArr = arrs.0
        let valueArr = arrs.1
        
        if let index = keyArr.firstIndex(of: key) {
            return valueArr[index]
        } else {
            return -1
        }
    }
    
    /** Removes the mapping of the specified value key if this map contains a mapping for the key */
    func remove(_ key: Int) {
        let lastKey = key % 1000
        let arrs = storeArr[lastKey]
        var keyArr = arrs.0
        var valueArr = arrs.1
        
        if let index = keyArr.firstIndex(of: key) {
            keyArr.remove(at: index)
            valueArr.remove(at: index)
            storeArr[lastKey] = (keyArr, valueArr)
        }
    }
}

/*
 MyHashMap hashMap = new MyHashMap();
 hashMap.put(1, 1);
 hashMap.put(2, 2);
 hashMap.get(1);            // 返回 1
 hashMap.get(3);            // 返回 -1 (未找到)
 hashMap.put(2, 1);         // 更新已有的值
 hashMap.get(2);            // 返回 1
 hashMap.remove(2);         // 删除键为2的数据
 hashMap.get(2);            // 返回 -1 (未找到)
 */

//let hashMap = MyHashMap()
//hashMap.put(1, 1)
//hashMap.put(2, 2)
//debugPrint(hashMap.get(1)) // 1
//debugPrint(hashMap.get(3)) // -1
//hashMap.put(2, 1)
//debugPrint(hashMap.get(2)) // 1
//hashMap.remove(2)
//debugPrint(hashMap.get(2)) // -1

// MARK: 217. 存在重复元素

func containsDuplicate(_ nums: [Int]) -> Bool {
    var set = Set<Int>()
    
    for num in nums {
        if !set.insert(num).inserted {
            return true
        }
    }
    return false
}

//debugPrint(containsDuplicate([1, 2, 3, 1]))

// MARK: 136. 只出现一次的数字

func singleNumber(_ nums: [Int]) -> Int {
    var set = Set<Int>()
    
    for num in nums {
        if set.contains(num) {
            set.remove(num)
        } else {
            set.insert(num)
        }
    }
    
    return set.first ?? -1
}

//debugPrint(singleNumber([2,2,1]))

// MARK: 349. 两个数组的交集

func intersection(_ nums1: [Int], _ nums2: [Int]) -> [Int] {
    var set = Set<Int>()
    var arr = [Int]()
    for num in nums1 {
        set.insert(num)
    }
    for num in Set(nums2) {
        if set.contains(num) {
            arr.append(num)
        }
    }
    return arr
}

//debugPrint(intersection([4,9,5], [9,4,9,8,4]))

// MARK: ❤️ 202. 快乐数

func isHappy(_ n: Int) -> Bool {
    func calculateSum(_ n: Int) -> Int {
        var sum = 0
        for char in "\(n)" {
            let value = (String(char) as NSString).integerValue
            sum += value * value
        }
        return sum
    }
    var sum = n
    var set = Set<Int>()
    while true {
        let next = calculateSum(sum)
        if next == 1 {
            return true
        }
        if set.contains(next) {
            return false
        }
        set.insert(next)
        sum = next
    }
}

//debugPrint(isHappy(19))

// MARK: ❤️ 205. 同构字符串

// 对比下坐标
func isIsomorphic(_ s: String, _ t: String) -> Bool {
    guard s.count > 0, t.count > 0 else { return true }
    var dicS = [Character: Int]()
    var dicT = [Character: Int]()
    
    for i in 0..<s.count {
        let charS = s[String.Index.init(encodedOffset: i)]
        let charT = t[String.Index.init(encodedOffset: i)]
        if dicS[charS] != dicT[charT] {
            return false
        }
        dicS[charS] = i
        dicT[charT] = i
    }
    return true
}

//debugPrint(isIsomorphic("ab", "aa"))

// MARK: 599. 两个列表的最小索引总和

func findRestaurant(_ list1: [String], _ list2: [String]) -> [String] {
    var dic = [String: Int]()
    var dic2 = [String: Int]()
    for (index, str) in list2.enumerated() {
        dic2[str] = index
    }
    var minCount = list1.count + list2.count
    for (index, str1) in list1.enumerated() {
        if let index2 = dic2[str1] {
            let count = index + index2
            dic[str1] = count
            minCount = min(minCount, count)
        }
    }
    
    var array = [String]()
    for (key, value) in dic {
        if value == minCount {
            array.append(key)
        }
    }
    return array
}

//debugPrint(findRestaurant(["Shogun", "Tapioca Express", "Burger King", "KFC"], ["KFC", "Shogun", "Burger King"]))

// MARK: 387. 字符串中的第一个唯一字符

func firstUniqChar(_ s: String) -> Int {
    var dic = [Character: Int]()
    for char in s {
        dic[char] = (dic[char] ?? 0) + 1
    }
    for (index, char) in s.enumerated() {
        if let count = dic[char], count == 1 {
            return index
        }
    }
    return -1
}

//debugPrint(firstUniqChar("loveleetcode"))

// MARK: 350. 两个数组的交集 II

func intersect(_ nums1: [Int], _ nums2: [Int]) -> [Int] {
    var dic = [Int: Int]()
    for num in nums1 {
        dic[num] = (dic[num] ?? 0) + 1
    }
    var array = [Int]()
    for num in nums2 {
        if var count = dic[num] {
            array.append(num)
            count -= 1
            dic[num] = count > 0 ? count : nil
        }
    }
    return array
}

//debugPrint(intersect([], [9,4,9,8,4]))

// MARK: 219. 存在重复元素 II

func containsNearbyDuplicate(_ nums: [Int], _ k: Int) -> Bool {
    var dic = [Int: [Int]]()
    var i = k + 1
    for (index, num) in nums.enumerated() {
        if var arr = dic[num], !arr.isEmpty {
            i = min(index - arr.last!, i)
            arr.append(index)
            dic[num] = arr
        } else {
            dic[num] = [index]
        }
    }
    if i <= k {
        return true
    }
    return false
}

//debugPrint(containsNearbyDuplicate([1,2,3,4,5,6,7,8,9,10], 15))

// MARK: 49. 字母异位词分组

func groupAnagrams(_ strs: [String]) -> [[String]] {
    func changeToKeyString(_ str: String) -> String {
        var tmp = ""
        for char in str.sorted() {
            tmp.append(char)
        }
        return tmp
    }
    
    var dic = [String: [String]]()
    for str in strs {
        let keyStr = changeToKeyString(str)
        if var arr = dic[keyStr] {
            arr.append(str)
            dic[keyStr] = arr
        } else {
            dic[keyStr] = [str]
        }
    }
    var array = [[String]]()
    for arr in dic.values {
        array.append(arr)
    }
    return array
}

// MARK: 36. 有效的数独

func isValidSudoku(_ board: [[Character]]) -> Bool {

    func isValid(_ x: Int, _ y: Int, _ set: inout Set<Character>) -> Bool {
        let char = board[x][y]
        if char != "." {
            if set.contains(char) {
                return false
            }
            set.insert(char)
        }
        return true
    }
    for y in 0..<9 {
        var set = Set<Character>()
        for x in 0..<9 {
            if !isValid(x, y, &set) {
                return false
            }
        }
    }
    for x in 0..<9 {
        var set = Set<Character>()
        for y in 0..<9 {
            if !isValid(x, y, &set) {
                return false
            }
        }
    }

    let arrayX = [(0, 3), (3, 6), (6, 9)]
    let arrayY = [(0, 3), (3, 6), (6, 9)]
    for itemX in arrayX {
        for itemY in arrayY {
            var set = Set<Character>()
            for x in itemX.0..<itemX.1 {
                for y in itemY.0..<itemY.1 {
                    if !isValid(x, y, &set) {
                        return false
                    }
                }
            }
        }
    }
    return true
}

//debugPrint(isValidSudoku([
//    ["9","3",".",".","7",".",".",".","."],
//    ["6",".",".","1","9","5",".",".","."],
//    [".","9","8",".",".",".",".","6","."],
//    ["8",".",".",".","6",".",".",".","3"],
//    ["4",".",".","8",".","3",".",".","1"],
//    ["7",".",".",".","2",".",".",".","6"],
//    [".","6",".",".",".",".","2","8","."],
//    [".",".",".","4","1","9",".",".","5"],
//    [".",".",".",".","8",".",".","7","9"]
//    ]))

// MARK: 771. 宝石与石头

func numJewelsInStones(_ J: String, _ S: String) -> Int {
    var dic = [Character: Int]()
    for char in S {
        dic[char] = (dic[char] ?? 0) + 1
    }
    var count = 0
    for char in J {
        if let num = dic[char] {
            count += num
        }
    }
    return count
}

//debugPrint(numJewelsInStones("z", "ZZ"))

// MARK: 3. 无重复字符的最长子串

func lengthOfLongestSubstring(_ s: String) -> Int {
    let array = Array(s)
    var count = 0
    var left = 0
    var right = 0
    var set = Set<Character>()
    
    while right < array.count {
        if !set.contains(array[right]) {
            set.insert(array[right])
            right += 1
            count = max(count, set.count)
        } else {
            set.remove(array[left])
            left += 1
        }
    }
    return count
}

//debugPrint(lengthOfLongestSubstring("abcabcbb"))

// MARK: 454. 四数相加 II

func fourSumCount(_ A: [Int], _ B: [Int], _ C: [Int], _ D: [Int]) -> Int {
    var dic = [Int: Int]()
    for i in 0..<C.count {
        for j in 0..<D.count {
            let sum = C[i] + D[j]
            dic[sum] = (dic[sum] ?? 0) + 1
        }
    }
    var count = 0
    for i in 0..<A.count {
        for j in 0..<B.count {
            let sum = A[i] + B[j]
            if let c = dic[0 - sum] {
                count += c
            }
        }
    }
    return count
}

//debugPrint(fourSumCount([0,1,-1], [-1,1,0], [0,0,1], [-1,1,1]))

// MARK: ❤️ 347. 前K个高频元素

func topKFrequent(_ nums: [Int], _ k: Int) -> [Int] {
    var dic = [Int: Int]()
    for num in nums {
        dic[num] = (dic[num] ?? 0) + 1
    }
    var dic2 = [Int: [Int]]()
    for (num, count) in dic {
        if var array = dic2[count] {
            array.append(num)
            dic2[count] = array
        } else {
            dic2[count] = [num]
        }
    }
    
    var set = Set<Int>()
    let keys = dic2.keys.sorted().reversed()
    for key in keys {
        if let array = dic2[key] {
            for num in array {
                if set.count < k {
                    set.insert(num)
                } else {
                    break
                }
            }
        }
    }
    return Array(set)
}

// 解法2: 优先队列

//debugPrint(topKFrequent([1], 1))

// MARK: 380. 常数时间插入、删除和获取随机元素

class RandomizedSet {
    
    /** Initialize your data structure here. */
    
    var array = [Int]()
    var dic = [Int: Int]()
    
    init() {
        
    }
    
    /** Inserts a value to the set. Returns true if the set did not already contain the specified element. */
    func insert(_ val: Int) -> Bool {
        if let _ = dic[val] {
            return false
        }
        array.append(val)
        dic[val] = array.count - 1
        return true
    }
    
    /** Removes a value from the set. Returns true if the set contained the specified element. */
    func remove(_ val: Int) -> Bool {
        if let index = dic[val] {
            array.remove(at: index)
            dic.removeValue(forKey: val)
            return true
        }
        return false
    }
    
    /** Get a random element from the set. */
    func getRandom() -> Int {
        let index = Int(arc4random()) % array.count
        return array[index]
    }
}

//var set = RandomizedSet()
//debugPrint(set.insert(1))
//debugPrint(set.remove(2))
//debugPrint(set.insert(2))
//debugPrint(set.getRandom())
//debugPrint(set.remove(1))
//debugPrint(set.insert(2))
//debugPrint(set.getRandom())
