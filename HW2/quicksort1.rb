=begin
The testdatafile contains all of the integers between 1 and 10,000 (inclusive, 
with no repeats) in unsorted order. The integer in the ith row of the file gives
you the ith entry of an input array.

Your task is to compute the total number of comparisons used to sort the given 
input file by QuickSort. As you know, the number of comparisons depends on which 
elements are chosen as pivots, so we'll ask you to explore three different 
pivoting rules.

You should not count comparisons one-by-one. Rather, when there is a recursive 
call on a subarray of length m, you should simply add m−1 to your running total 
of comparisons. (This is because the pivot element is compared 
to each of the other m−1 elements in the subarray in this recursive call.)

WARNING: The Partition subroutine can be implemented in several different ways, 
and different implementations can give you differing numbers of comparisons. 
For this problem, you should implement the Partition subroutine exactly as it 
is described in the video lectures (otherwise you might get the wrong answer).

DIRECTIONS FOR THIS PROBLEM:

For the first part of the programming assignment, you should always use the 
first element of the array as the pivot element. 
=end
$numOfcomparisons=0

inputArray = Array.new
f = File.open("quicksort.data") or die "Unable to open file..."
f.each_line {|line|
    inputArray.push line.to_i } #convertthe string to an int before pushing onto the array

#puts "calling quicksort with array #{inputArray}"

def quicksort array
    len = array.length 
    #base case
    return array if len <= 1
    $numOfcomparisons += len - 1 

    #set pivot to first element
    pivot = array[0]

    #initialize counters
    # i = boundary in array for which all elements are less then pivot
    # j = boundary in array for which all elements are greater than pivot
    i, j = 1, 1

    #partition the array according to the definitions of i and j
    (len-1).times do
        if array[j] < pivot
            temp = array[j]
            array[j] = array[i]
            array[i] = temp
            i += 1
        end
        j += 1
    end
   
   #insert pivot into sorted position before recursing
   array[0] = array[i-1]
   array[i-1] = pivot
   
    #recurse on the array around the pivot
   return (quicksort(array[0,i-1]) << pivot << quicksort(array[i,len]))
end

quicksort inputArray
puts "Number of Comparisons = #{$numOfcomparisons}"