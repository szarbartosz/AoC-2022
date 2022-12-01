def solution_pt1():
  maxCalories = 0
  currentSum = 0

  inputFile = open('input.txt', 'r')
  lines = inputFile.readlines()

  for line in lines:
    if line.strip() != "":
      currentSum += int(line)
      maxCalories = max(maxCalories, currentSum)
      continue
    currentSum = 0

  return maxCalories;


def solution_pt2():
  currentSum = 0
  summedCalories = []

  inputFile = open('input.txt', 'r')
  lines = inputFile.readlines()

  for line in lines:
    if line.strip() != "":
      currentSum += int(line)
      continue
    summedCalories.append(currentSum)
    currentSum = 0

  return sum(sorted(summedCalories)[len(summedCalories) - 3:])


if __name__ == "__main__":
  print(solution_pt1())
  print(solution_pt2())