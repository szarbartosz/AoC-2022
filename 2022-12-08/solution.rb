def is_visible_from_top(i, j, forrest)
  tree_height = forrest[i][j];
  current_y = i - 1;
  while current_y >= 0
    if forrest[current_y][j] >= tree_height
      return false;
    elsif current_y == 0
      return true;
    end
    current_y -= 1;
  end
  return false;
end

def is_visible_from_bottom(i, j, forrest)
  height = forrest.length;
  tree_height = forrest[i][j];
  current_y = i + 1;
  while current_y < height
    if forrest[current_y][j] >= tree_height
      return false;
    elsif current_y == height - 1
      return true;
    end
    current_y += 1;
  end
  return false;
end

def is_visible_from_left(i, j, forrest)
  tree_height = forrest[i][j];
  current_x = j - 1;
  while current_x >= 0
    if forrest[i][current_x] >= tree_height
      return false;
    elsif current_x == 0
      return true;
    end
    current_x -= 1;
  end
  return false;
end

def is_visible_from_right(i, j, forrest)
  width = forrest[i].length;
  tree_height = forrest[i][j];
  current_x = j + 1;
  while current_x < width
    if forrest[i][current_x] >= tree_height
      return false;
    elsif current_x == width - 1
      return true;
    end
    current_x += 1
  end
  return false;
end

def is_visible(i, j, forrest)
  return is_visible_from_top(i, j, forrest) || is_visible_from_right(i, j, forrest) || is_visible_from_bottom(i, j, forrest) || is_visible_from_left(i, j, forrest);
end

def calculate_scenic_score_top(i, j, forrest)
  tree_height = forrest[i][j];
  current_y = i - 1;
  while current_y >= 0
    if forrest[current_y][j] >= tree_height
      return i - current_y;
    end
    current_y -= 1;
  end
  return i - current_y - 1;
end

def calculate_scenic_score_bottom(i, j, forrest)
  height = forrest.length;
  tree_height = forrest[i][j];
  current_y = i + 1;
  while current_y < height
    if forrest[current_y][j] >= tree_height
      return current_y - i;
    end
    current_y += 1;
  end
  return current_y - i - 1;
end

def calculate_scenic_score_left(i, j, forrest)
  tree_height = forrest[i][j];
  current_x = j - 1;
  while current_x >= 0
    if forrest[i][current_x] >= tree_height
      return j - current_x;
    end
    current_x -= 1;
  end
  return j - current_x - 1;
end

def calculate_scenic_score_right(i, j, forrest)
  width = forrest[i].length;
  tree_height = forrest[i][j];
  current_x = j + 1;
  while current_x < width
    if forrest[i][current_x] >= tree_height
      return current_x - j;
    end
    current_x += 1;
  end
  return current_x - j - 1;
end

def calculate_scenic_score(i, j, forrest)
  return calculate_scenic_score_top(i, j, forrest) * calculate_scenic_score_right(i, j, forrest) * calculate_scenic_score_bottom(i, j, forrest) * calculate_scenic_score_left(i, j, forrest);
end

def initialize_forrest()
  width = 0;
  height = 0;

  File.readlines('input.txt').each do |line|
    width = line.strip.length;
    height += 1;
  end

  forrest = Array.new(height){Array.new(width)}

  currentRow = 0;

  File.readlines('input.txt').each do |line|
    for i in 0 .. width - 1
      forrest[currentRow][i] = line[i];
    end
    currentRow += 1;
  end

  return forrest, width, height;
end

def solution_pt_1()
  forrest, width, height = initialize_forrest();

  result = 0;
  
  for i in 1 .. height - 2
    for j in 1 .. width - 2
      if is_visible(i, j, forrest)
        result += 1;
      end
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
