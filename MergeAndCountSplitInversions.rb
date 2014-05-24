=begin
https://class.coursera.org/algo-005/quiz/attempt?quiz_id=31

Your task is to compute the number of inversions in the file given, 
where the ith row of the file indicates the ith entry of an array.
Because of the large size of this array, you should implement the fast 
divide-and-conquer algorithm covered in the video lectures. The numeric 
answer for the given input file should be typed in the space below.

So if your answer is 1198233847, then just type 1198233847 in the space 
provided without any space / commas / any other punctuation marks. You 
can make up to 5 attempts, and we'll use the best one for grading.
=end

#Read the testdata into arrayA
arrayA = Array.new
arrayA=[]  # start with an empty array
$numOfSplintInvs=0

f = File.open("testdata") or die "Unable to open file..."
f.each_line {|line|
    arrayA.push line.to_i } #convertthe string to an int before pushing onto the array

def merge(arrayB, arrayC)
    arrayD = []
    while arrayB.length*arrayC.length > 0 
        if arrayB.first > arrayC.first
            $numOfSplintInvs = $numOfSplintInvs + arrayB.length
        end
        arrayD << (arrayB.first < arrayC.first ? arrayB : arrayC).shift 
    end
    return arrayD+arrayB+arrayC
end

def mergesort(arrayA)
    halfway = arrayA.size/2
    return arrayA if arrayA.size == 1
    arrayB = mergesort(arrayA[0, halfway])
    arrayC = mergesort(arrayA[halfway, arrayA.size])
    return merge(arrayB, arrayC)
end

arrayD = mergesort(arrayA)
puts "Number of Split Intervals is #{$numOfSplintInvs}"
