import math

class Monkey:
  def __init__(self, items, operation, operation_parameter, divisible_by, throw_to, else_throw_to):
    self.items = items
    self.operation = operation
    self.operation_parameter = operation_parameter
    self.divisible_by = divisible_by
    self.throw_to = throw_to
    self.else_throw_to = else_throw_to
    self.inspections = 0

  def update_worry_level(self, item):
    match self.operation:
      case "*":
        if self.operation_parameter == 'old':
          # return (item * item) // 3
          return (item * item)
        else:
          # return (item * int(self.operation_parameter)) // 3
          return (item * int(self.operation_parameter))
      case "+":
        if self.operation_parameter == 'old':
          # return (item + item) // 3
          return (item + item)
        else:
          # return (item + int(self.operation_parameter)) // 3
          return (item + int(self.operation_parameter))

  def is_divisible_by(self, worry_level):
    return worry_level % self.divisible_by == 0

  def __str__(self):
    return """
    Items: {items}
    Operation: {operation}
    Operation parameter: {operation_parameter}
    Divisible by: {divisible_by}
    Throw to: {throw_to}
    Else throw to: {else_throw_to}
    Inspections: {inspections}
    """.format(items=self.items, 
    operation=self.operation, 
    operation_parameter=self.operation_parameter,
    divisible_by=self.divisible_by,
    throw_to=self.throw_to,
    else_throw_to=self.else_throw_to,
    inspections=self.inspections)
    
def solution_pt_1():
  inputFile = open('input.txt', 'r')
  lines = inputFile.readlines()

  monkeys_number = len(lines) // 7
  monkeys = []
  starting_items = [[] for _ in range(monkeys_number)]
  operations = [None for _ in range(monkeys_number)]
  operations_parameter = [None for _ in range(monkeys_number)]
  divisible_by = [None for _ in range(monkeys_number)]
  throw_to = [None for _ in range(monkeys_number)]
  else_throw_to = [None for _ in range(monkeys_number)]

  for i, line in enumerate(lines):
    line = line.strip().split(" ")

    if i % 7 == 1:
      for j in range(2, len(line)):
        if line[j].replace(",", "") == "old":
          starting_items[i // 7].append(line[j].replace(",", ""))
        else:  
          starting_items[i // 7].append(int(line[j].replace(",", "")))
    elif i % 7 == 2:
      operations[i // 7] = line[4]
      operations_parameter[i // 7] = (line[5])
    elif i % 7 == 3:
      divisible_by[i // 7] = int(line[3])
    elif i % 7 == 4:
      throw_to[i // 7] = int(line[5])
    elif i % 7 == 5:
      else_throw_to[i // 7] = int(line[5])

  for i in range(monkeys_number):
    monkeys.append(Monkey(
      starting_items[i],
      operations[i],
      operations_parameter[i],
      divisible_by[i],
      throw_to[i],
      else_throw_to[i]
    ))

  for i in range(20):
    for monkey in monkeys:
      for j, item in enumerate(monkey.items):
        monkey.inspections += 1

        updated_worry_level = monkey.update_worry_level(item)
        
        if monkey.is_divisible_by(updated_worry_level):
          # print(monkey.update_worry_level(item), "should be thrown to", monkey.throw_to)
          monkeys[monkey.throw_to].items.append(updated_worry_level)
        else:
          # print(monkey.update_worry_level(item), "should be thrown to", monkey.else_throw_to)
          monkeys[monkey.else_throw_to].items.append(updated_worry_level)
      monkey.items = []

  inspections = []

  for monkey in monkeys:
    inspections.append(monkey.inspections)
  
  return sorted(inspections, reverse=True)[0] * sorted(inspections, reverse=True)[1]


def solution_pt_2():
  inputFile = open('input.txt', 'r')
  lines = inputFile.readlines()

  monkeys_number = len(lines) // 7
  monkeys = []
  starting_items = [[] for _ in range(monkeys_number)]
  operations = [None for _ in range(monkeys_number)]
  operations_parameter = [None for _ in range(monkeys_number)]
  divisible_by = [None for _ in range(monkeys_number)]
  throw_to = [None for _ in range(monkeys_number)]
  else_throw_to = [None for _ in range(monkeys_number)]

  for i, line in enumerate(lines):
    line = line.strip().split(" ")

    if i % 7 == 1:
      for j in range(2, len(line)):
        if line[j].replace(",", "") == "old":
          starting_items[i // 7].append(line[j].replace(",", ""))
        else:  
          starting_items[i // 7].append(int(line[j].replace(",", "")))
    elif i % 7 == 2:
      operations[i // 7] = line[4]
      operations_parameter[i // 7] = (line[5])
    elif i % 7 == 3:
      divisible_by[i // 7] = int(line[3])
    elif i % 7 == 4:
      throw_to[i // 7] = int(line[5])
    elif i % 7 == 5:
      else_throw_to[i // 7] = int(line[5])

  lcm = math.lcm(*divisible_by)

  for i in range(monkeys_number):
    monkeys.append(Monkey(
      starting_items[i],
      operations[i],
      operations_parameter[i],
      divisible_by[i],
      throw_to[i],
      else_throw_to[i]
    ))

  for i in range(10000):
    for monkey in monkeys:
      for j, item in enumerate(monkey.items):
        monkey.inspections += 1

        updated_worry_level = monkey.update_worry_level(item)

        if updated_worry_level > lcm: 
          updated_worry_level = lcm + updated_worry_level % lcm
        
        if monkey.is_divisible_by(updated_worry_level):
          # print(monkey.update_worry_level(item), "should be thrown to", monkey.throw_to)
          monkeys[monkey.throw_to].items.append(updated_worry_level)
        else:
          # print(monkey.update_worry_level(item), "should be thrown to", monkey.else_throw_to)
          monkeys[monkey.else_throw_to].items.append(updated_worry_level)
      monkey.items = []

  inspections = []

  for monkey in monkeys:
    inspections.append(monkey.inspections)
  
  return sorted(inspections, reverse=True)[0] * sorted(inspections, reverse=True)[1]

if __name__ == "__main__":
  print(solution_pt_1())
  print(solution_pt_2())
