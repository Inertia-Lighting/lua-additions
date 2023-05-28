local Integer = {}

--------------------------------------------------------------------------------------------------------------------------------

--- Checks if a number is odd
--- @param number number
--- @returns boolean
function Integer.isOdd(number)
  return number % 2 ~= 0
end

--- Checks if a number is even
--- @param number number
--- @returns boolean
function Integer.isEven(number)
  return number % 2 == 0
end

--- Calculates the half of a number and returns the closest smaller and higher numbers if it's not a whole number
--- @param number number
--- @returns number, number or number (if it's a whole number)
function Integer.calculateHalf(number)
  local half = number / 2
  if number % 1 == 0 then
    return number
  else
    local smaller = math.floor(half)
    local higher = math.ceil(half)
    return smaller, higher
  end
end

--- Returns the absolute value of a number
--- @param number number
--- @returns number
function Integer.absoluteValue(number)
  return math.abs(number)
end

--- Returns the maximum value between two numbers
--- @param a number
--- @param b number
--- @returns number
function Integer.maximum(a, b)
  return math.max(a, b)
end

--- Returns the minimum value between two numbers
--- @param a number
--- @param b number
--- @returns number
function Integer.minimum(a, b)
  return math.min(a, b)
end

--- Rounds a number to the nearest integer
--- @param number number
--- @returns number
function Integer.round(number)
  return math.floor(number + 0.5)
end

--- Raises a number to the power of an exponent
--- @param base number
--- @param exponent number
--- @returns number
function Integer.power(base, exponent)
  return base ^ exponent
end

--- Calculates the square root of a number
--- @param number number
--- @returns number
function Integer.squareRoot(number)
  return math.sqrt(number)
end

--- Calculates the sine of an angle in radians
--- @param number number
--- @returns number
function Integer.sine(number)
  return math.sin(number)
end

--- Calculates the cosine of an angle in radians
--- @param number number
--- @returns number
function Integer.cosine(number)
  return math.cos(number)
end

--- Calculates the tangent of an angle in radians
--- @param number number
--- @returns number
function Integer.tangent(number)
  return math.tan(number)
end

--- Generates a random number within a given range
--- @param min number
--- @param max number
--- @returns number
function Integer.randomInRange(min, max)
  return math.random(min, max)
end

--------------------------------------------------------------------------------------------------------------------------------

return Integer