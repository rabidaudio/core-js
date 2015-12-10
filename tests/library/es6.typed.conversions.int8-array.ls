{module, test} = QUnit
module \ES6
{Uint8Array, Int8Array} = core
DESCRIPTORS and test 'Int8Array conversions', !(assert)~>
  data = [
    [0,0,[0]]
    [-0,0,[0]]
    [1,1,[1]]
    [-1,-1,[255]]
    [1.1,1,[1]]
    [-1.1,-1,[255]]
    [1.9,1,[1]]
    [-1.9,-1,[255]]
    [127,127,[127]]
    [-127,-127,[129]]
    [128,-128,[128]]
    [-128,-128,[128]]
    [255,-1,[255]]
    [-255,1,[1]]
    [255.1,-1,[255]]
    [255.9,-1,[255]]
    [256,0,[0]]
    [32767,-1,[255]]
    [-32767,1,[1]]
    [32768,0,[0]]
    [-32768,0,[0]]
    [65535,-1,[255]]
    [65536,0,[0]]
    [65537,1,[1]]
    [65536.54321,0,[0]]
    [-65536.54321,0,[0]]
    [2147483647,-1,[255]]
    [-2147483647,1,[1]]
    [2147483648,0,[0]]
    [-2147483648,0,[0]]
    [4294967296,0,[0]]
    [Infinity,0,[0]]
    [-Infinity,0,[0]]
    [-1.7976931348623157e+308,0,[0]]
    [1.7976931348623157e+308,0,[0]]
    [5e-324,0,[0]]
    [-5e-324,0,[0]]
    [NaN,0,[0]]
  ]

  # Android 4.3- bug
  if NATIVE or !/Android [2-4]/.test navigator?userAgent
    data = data.concat [
      [2147483649,1,[1]]
      [-2147483649,-1,[255]]
      [4294967295,-1,[255]]
      [4294967297,1,[1]]
    ]

  typed = new Int8Array 1
  z = -> if it is 0 and 1 / it is -Infinity => '-0' else it
  for it in data
    typed[0] = it[0]
    assert.same typed[0], it[1], "#{z it[0]} -> #{z it[1]}"
    assert.arrayEqual new Uint8Array(typed.buffer), (if LITTLE_ENDIAN => it[2] else it[2]reverse!), "#{z it[0]} -> #{it[2]}"