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
