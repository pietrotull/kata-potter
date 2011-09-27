discounts = [0, 1, 0.95, 0.9, 0.8, 0.75]

exports.price = price = (books) ->
  calculatePrice(transformBooks(books))

transformBooks = (books) ->
  count = [0,0,0,0,0]
  for book in books 
    count[book]++
  count

# recursive calcutaion logic
calculatePrice = (bookCounts) ->
  setSize = calculateSetSize(bookCounts)
  discount = discounts[setSize]
  return 0 if setSize is 0
  8 * setSize * discount + calculatePrice(reduceBookCount(setSize, bookCounts))

# calculate how many different books are left and return it unless border condition is met
calculateSetSize = (bookCounts) ->
  setSize = 0
  nextSetSize = 0
  for bc in bookCounts
    setSize++ if bc > 0
    nextSetSize++ if bc > 1
  return 4 if nextSetSize is 3 and setSize is 5 #border condition
  setSize

# reduce total book count with those calculated in this round
reduceBookCount = (removeCounter, bookCounts) ->
  nextRoundBookCounts = [0,0,0,0,0]
  i = 0
  for bc in bookCounts
    nextRoundBookCounts[i] = bc
    if bc > 0 and removeCounter > 0
      --removeCounter
      nextRoundBookCounts[i] = bc - 1
    i++
  nextRoundBookCounts
