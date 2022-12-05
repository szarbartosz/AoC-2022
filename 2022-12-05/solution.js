const fs = require("fs");
const readline = require("readline");

const getData = async (lineReader) => {
  let stacksContent = [];
  let stacksNumber;
  let highestStackHeight = 0;
  let instructions = [];
  let currentInstruction = 0;

  for await (const line of lineReader) {
    if (line[0] && line[0] != "m") {
      stacksContent.push(line);
      highestStackHeight += 1;
      lineWithoutSpaces = line.replace(/\s/g, "");
      if (lineWithoutSpaces[0] == 1) {
        stacksNumber = parseInt(
          lineWithoutSpaces[lineWithoutSpaces.length - 1]
        );
        highestStackHeight--;
        stacksContent.pop();
      }
    } else if (line[0] == "m") {
      instructions.push([]);
      instructions[currentInstruction].push(
        parseInt(line.split("move ")[1].split(" ")[0])
      );
      instructions[currentInstruction].push(
        parseInt(line.split("from ")[1].split(" ")[0])
      );
      instructions[currentInstruction].push(
        parseInt(line.split("to ")[1].split(" ")[0])
      );
      currentInstruction += 1;
    }
  }

  return [stacksNumber, highestStackHeight, stacksContent, instructions];
};

const getInitializedStacks = (
  stacksNumber,
  highestStackHeight,
  stacksContent
) => {
  let stacks = [];
  stackToInsert = 0;

  for (i = 0; i < stacksNumber; i++) {
    stacks.push([]);
  }

  for (i = 0; i < highestStackHeight; i++) {
    for (j = 1; j < stacksNumber * 3 + stacksNumber - 1; j += 4) {
      if (stacksContent[i][j] != " ") {
        stacks[stackToInsert].unshift(stacksContent[i][j]);
      }
      stackToInsert += 1;
    }
    stackToInsert = 0;
  }

  return stacks;
};

const solution_pt_1 = async () => {
  const fileStream = fs.createReadStream("input.txt");
  const lineReader = readline.createInterface({
    input: fileStream,
  });

  let [stacksNumber, highestStackHeight, stacksContent, instructions] =
    await getData(lineReader);

  let stacks = getInitializedStacks(
    stacksNumber,
    highestStackHeight,
    stacksContent
  );

  for (const instruction of instructions) {
    cratesToMove = instruction[0];
    from = instruction[1] - 1;
    to = instruction[2] - 1;

    for (i = 0; i < cratesToMove; i++) {
      stacks[to].push(stacks[from].pop());
    }
  }

  let result = "";

  for (i = 0; i < stacks.length; i++) {
    result += stacks[i].pop();
  }

  return result;
};

const solution_pt_2 = async () => {
  const fileStream = fs.createReadStream("input.txt");
  const lineReader = readline.createInterface({
    input: fileStream,
  });

  let [stacksNumber, highestStackHeight, stacksContent, instructions] =
    await getData(lineReader);

  let stacks = getInitializedStacks(
    stacksNumber,
    highestStackHeight,
    stacksContent
  );

  let buffer = [];

  for (const instruction of instructions) {
    cratesToMove = instruction[0];
    from = instruction[1] - 1;
    to = instruction[2] - 1;

    for (i = 0; i < cratesToMove; i++) {
      buffer.push(stacks[from].pop());
    }
    for (i = 0; i < cratesToMove; i++) {
      stacks[to].push(buffer.pop());
    }
  }

  let result = "";

  for (i = 0; i < stacks.length; i++) {
    result += stacks[i].pop();
  }

  return result;
};

solution_pt_1().then((result) => console.log(result));
solution_pt_2().then((result) => console.log(result));
