def is_visible_from(i, j, direction, forrest)
  height, width = forrest.length, forrest[i].length;
  tree_height = forrest[i][j];

  current_y, current_x = i, j;
  current_y -= 1 if direction == "top";
  current_y += 1 if direction == "bottom";
  current_x -= 1 if direction == "left";
  current_x += 1 if direction == "right";

  while (0...height).include?(current_y) && (0...width).include?(current_x)
    return false if forrest[current_y][current_x] >= tree_height;
    return true if direction == "top" && current_y.zero?;
    return true if direction == "bottom" && current_y == height - 1;
    return true if direction == "left" && current_x.zero?;
    return true if direction == "right" && current_x == width - 1;

    current_y -= 1 if direction == "top";
    current_y += 1 if direction == "bottom";
    current_x -= 1 if direction == "left";
    current_x += 1 if direction == "right";
  end

  false;
end

def is_visible(i, j, forrest)
  return is_visible_from(i, j, "top", forrest) || is_visible_from(i, j, "right", forrest) || is_visible_from(i, j, "bottom", forrest) || is_visible_from(i, j, "left", forrest);
end

def calculate_scenic_score_from(i, j, direction, forrest)
  height, width = forrest.length, forrest[i].length;
  tree_height = forrest[i][j];

  current_y, current_x = i, j;
  current_y -= 1 if direction == "top";
  current_y += 1 if direction == "bottom";
  current_x -= 1 if direction == "left";
  current_x += 1 if direction == "right";

  while (0...height).include?(current_y) && (0...width).include?(current_x)
    if forrest[current_y][current_x] >= tree_height
      return i - current_y if direction == "top";
      return current_y - i if direction == "bottom";
      return j - current_x if direction == "left";
      return current_x - j if direction == "right";
    end

    current_y -= 1 if direction == "top";
    current_y += 1 if direction == "bottom";
    current_x -= 1 if direction == "left";
    current_x += 1 if direction == "right";
  end

  return i - current_y - 1 if direction == "top";
  return current_y - i - 1 if direction == "bottom";
  return j - current_x - 1 if direction == "left";
  return current_x - j - 1 if direction == "right";
end

def calculate_scenic_score(i, j, forrest)
  return calculate_scenic_score_from(i, j, "top", forrest) * calculate_scenic_score_from(i, j, "right", forrest) * calculate_scenic_score_from(i, j, "bottom", forrest) * calculate_scenic_score_from(i, j, "left", forrest);
end

def initialize_forrest()
  width = 0;
  height = 0;

  lines = File.readlines('input.txt');
  width = lines.first.strip.length;
  height = lines.length;

  forrest = Array.new(height){Array.new(width)};
  forrest = lines.map { |line| line.strip.chars };

  return forrest, width, height;
end

def solution_pt_1()
  forrest, width, height = initialize_forrest();

  result = 0;
  
  for i in 1 .. height - 2
    for j in 1 .. width - 2
      result += 1 if is_visible(i, j, forrest);
    end
  end

  return result + 2 * width + 2 * height - 4;
end

def solution_pt_2()
  forrest, width, height = initialize_forrest();

  result = 0;
  
  for i in 0 .. height - 1
    for j in 0 .. width - 1
      result = [result, calculate_scenic_score(i, j, forrest)].max;
    end
  end

  return result;
end


print("solution_pt_1: ", solution_pt_1(),"\n");
print("solution_pt_2: ", solution_pt_2());
