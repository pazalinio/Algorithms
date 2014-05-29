
=begin
Compute the number of comparisons (as in Problem 1), always using the final 
element of the given array as the pivot element. 

Again, be sure to implement the Partition subroutine exactly as it is described 
in the video lectures. Recall from the lectures that, just before the main 
Partition subroutine, you should exchange the pivot element (i.e., the last 
element) with the first element.
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

    #set pivot value to last element and move it to first element in the array
    pivot, array[len-1], array[0] = array[len-1], array[0], pivot
    #initialize counters
    # i = boundary in array for which all elements are less then pivot
    # j = boundary in array for which all elements are greater than pivot
    i, j = 1, 1

    #partition the array according to the definitions of i and j
    (len-1).times do
        if array[j] < pivot
#            array[j], array[i] = array[j], array[i]
            temp = array[j]
            array[j] = array[i]
            array[i] = temp
            i += 1
        end
        j += 1
    end
   
   #insert pivot into sorted position before recursing
   array[0], array[i-1] = array[i-1], pivot
   
    #recurse on the array around the pivot
   return (quicksort(array[0,i-1]) << pivot << quicksort(array[i,len]))
end

quicksort inputArray
puts "Number of Comparisons = #{$numOfcomparisons}"