potter = require '../potter' 
describe 'jasmine-node', ->
  
  it 'no books should not cost anything', ->
    expect(potter.price([])).toEqual(0)

  it 'one book should cost 8EUR', ->
    expect(potter.price([0])).toEqual(8)
    expect(potter.price([1])).toEqual(8)
    expect(potter.price([2])).toEqual(8)
    expect(potter.price([3])).toEqual(8)
    expect(potter.price([4])).toEqual(8)

  it 'several copies of the same shoul cost quantity x 8', ->
    expect(potter.price([4, 4])).toEqual(16)
    expect(potter.price([3, 3, 3])).toEqual(24)

  it 'two different books, should give a 5% discount', ->
    expect(potter.price([1,2])).toEqual(8 * 2 * 0.95)

  it '3 different books, should give 10% discount', ->
    expect(potter.price([0,4,2])).toEqual(8 * 3 * 0.9)
  
  it '4 different books, should give 20% discount', ->
    expect(potter.price([0,1,4,2])).toEqual(8 * 4 * 0.8)

  it 'one of each books, should give a full 25% discount', ->
    expect(8 * 5 * 0.75).toEqual(potter.price([0,1,2,3,4]))

  it '2 equal books plus one different should give a discount for set of two and normal price for third', ->
    expect(8 + (8 * 2 * 0.95)).toEqual(potter.price([0,0,1]))

  it '2 equal sets should give discount for both', ->
    expect(2 * (8 * 2 * 0.95)).toEqual(potter.price([0,0,1,1]))

  it 'several sets should give discount for both sets', ->
    expect((8 * 4 * 0.8) + (8 * 2 * 0.95)).toEqual(potter.price([0, 0, 1, 2, 2, 3]))
    expect(8 + (8 * 5 * 0.75)).toEqual(potter.price([0, 1, 1, 2, 3, 4]))

  it 'should count discount for 2 sets of 4', ->
    expect(2 * (8 * 4 * 0.8)).toEqual(potter.price([0, 0, 1, 1, 2, 2, 3, 4]))

  it 'last very complex example', ->
    expect(3 * (8 * 5 * 0.75) + 2 * (8 * 4 * 0.8)).toEqual(potter.price ([0, 0, 0, 0, 0, 
      1, 1, 1, 1, 1, 
      2, 2, 2, 2, 
      3, 3, 3, 3, 3, 
      4, 4, 4, 4]))
