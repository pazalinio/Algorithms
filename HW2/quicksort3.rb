=begin
Compute the number of comparisons (as in Problem 1), using the 
"median-of-three" pivot rule. [The primary motivation behind this rule is to do 
a little bit of extra work to get much better performance on input arrays that 
are nearly sorted or reverse sorted.] 

In more detail, you should choose the pivot as follows. Consider the first, 
middle, and final elements of the given array. (If the array has odd length it 
should be clear what the "middle" element is; for an array with even length 2k, 
use the kth element as the "middle" element. So for the array 4 5 6 7, the 
"middle" element is the second one ---- 5 and not 6!)

Identify which of these three elements is the median (i.e., the one whose value 
is in between the other two), and use this as your pivot. As discussed in the 
first and second parts of this programming assignment, be sure to implement 
Partition exactly as described in the video lectures (including exchanging the 
pivot element with the first element just before the main Partition subroutine).

EXAMPLE: For the input array 8 2 4 5 7 1 you would consider the first (8), 
middle (4), and last (1) elements; since 4 is the median of the set {1,4,8}, you 
would use 4 as your pivot element.

SUBTLE POINT: A careful analysis would keep track of the comparisons made in 
identifying the median of the three candidate elements. 

You should NOT do this. That is, as in the previous two problems, you should 
simply add m−1 to your running total of comparisons every time you recurse on a 
subarray with length m. 
=end
$numOfcomparisons=0

inputArray = Array.new
f = File.open("quicksort.data") or die "Unable to open file..."
f.each_line {|line|
    inputArray.push line.to_i } #convertthe string to an int before pushing onto the array

def quicksort array
    len = array.length 
    #base case
    return array if len <= 1

    $numOfcomparisons += len - 1 
    puts "Number of Comparisons = #{$numOfcomparisons}"
    puts "Input Array --> #{array.to_s}"
    
    #set pivot value to the median of the first, middle and last array elements
    first = array[0]
    last = array[len-1]
    middleIndex = (len % 2 != 0 ? len / 2 : (len - 1) / 2)
    middle = array[middleIndex]
#    puts "----------------------------------"
    puts "First: #{first} <*> last: #{last} <*> middle: #{middle}"
#    puts "----------------------------------"
    
    if ((middle > first) && (first > last)) || ((middle < first) && (first < last)) 
        pivot = first
        #no need to swap pivots for first element
    elsif ((first < last) && (last < middle)) || ((first > last) && (last > middle))
        pivot, array[len-1], array[0] = array[len-1], array[0], pivot
    else # middlecase
        pivot, array[middleIndex], array[0] = array[middleIndex], array[0], pivot
    end
#    puts "Pivot sorted Array --> #{array.to_s}"
    puts "Pivot: #{pivot} <*> ArrayLength = #{len}"
    #initialize counters
    # i = boundary in array for which all elements are less then pivot
    # j = boundary in array for which all elements are greater than pivot
    i, j = 1, 1

    #partition the array according to the definitions of i and j
    (len-1).times do
#    puts "------------------------"
    puts "array[#{i}] -> #{array[i]} <*> array[#{j}] -> #{array[j]}"
#    puts "------------------------"
        if array[j] < pivot
            array[j], array[i], i = array[i], array[j], i+1
        end
        j += 1
    end
    
   #insert pivot into sorted position before recursing
   array[0], array[i-1] = array[i-1], pivot
   
    #recurse on the array around the pivot
    puts "Output Array --> #{array.to_s}"
    leftPivot = array[0,i-1]
    puts leftPivot.to_s
    rightPivot = array[i,len]
    puts rightPivot.to_s
    
   return (quicksort(leftPivot) << pivot << quicksort(rightPivot))
end

result = quicksort(inputArray)
puts result.to_s

puts "Number of Comparisons = #{$numOfcomparisons}"