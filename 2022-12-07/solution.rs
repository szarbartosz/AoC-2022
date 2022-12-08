use std::collections::HashSet;
use std::fs::File;
use std::io::{self, BufRead};
use std::path::Path;

fn read_lines<P>(filename: P) -> io::Result<io::Lines<io::BufReader<File>>>
where P: AsRef<Path>, {
  let file = File::open(filename)?;
  Ok(io::BufReader::new(file).lines())
}

#[derive(Clone, PartialEq, Eq, Hash)]
struct TreeNode {
  pub name: String,
  pub size: i32,
  pub is_dir: bool,
  pub children: Vec<TreeNode>,
}

impl TreeNode {
  pub fn new(name: &str) -> TreeNode {
    return TreeNode {
      name: name.to_string(),
      size: 0,
      is_dir: false,
      children: Vec::new(),
    };
  }

  fn get_path(&mut self, path: &[String]) -> &mut Self {
    let mut current = self;
    for part in path {
      current = current
        .children
        .iter_mut()
        .find(|f| f.name == *part)
        .unwrap();
    }

    return current; 
  }

  fn flatten_tree(&self) -> HashSet<Self> {
    let mut flattened_tree = HashSet::new();

    for child in &self.children {
      flattened_tree.insert(child.clone());
      flattened_tree.extend(child.flatten_tree());
    }

    flattened_tree
  }

  fn propagate_size(&mut self) -> i32 {
    for child in &mut self.children {
        self.size += child.propagate_size();
    }

    self.size
  }
}

fn process_traversal() -> TreeNode {
  let lines = read_lines("./input.txt").unwrap();
  let mut tree = TreeNode::new("/");
  let mut path = Vec::new();

  for line in lines {
    let unwrapped_line = line.unwrap();
    let parts = unwrapped_line.split_whitespace().collect::<Vec<&str>>();

    if parts[..2] == ["$", "cd"] {
      match parts[2] {
          ".." => {
              path.pop().unwrap();
              continue;
          }
          "/" => continue,
          _ => {}
      }

      let parent = tree.get_path(&path);
      path.push(parts[2].to_owned());

      if parent.children.iter().any(|child| child.name == parts[2]) {
          continue;
      }

      parent.children.push(TreeNode::new(parts[2]));
      continue;
    }

    if parts[0] == "dir" {
      let parent = tree.get_path(&path);
      let mut child = TreeNode::new(parts[1]);

      child.is_dir = true;
      parent.children.push(child);
      continue;
    }

    if let Ok(size) = parts[0].parse::<i32>() {
      let mut child = TreeNode::new(parts[1]);

      child.size = size;
      tree.get_path(&path).children.push(child);
    }
  }

  tree.propagate_size();
  return tree;
}

fn solution_pt_1() -> String {
  return process_traversal()
          .flatten_tree()
          .iter()
          .filter(|node| node.is_dir && node.size <= 100000)
          .fold(0, |global_size, node| global_size + node.size)
          .to_string();
}

fn solution_pt_2() -> String {
  let filesystem = process_traversal();
  let needed_space = 30000000 - (70000000 - filesystem.size);

  let files_or_dirs = filesystem.flatten_tree();
  let mut files_or_dirs = files_or_dirs.iter().collect::<Vec<_>>();
  files_or_dirs.sort_by(|file_or_dir_1, file_or_dir_2| file_or_dir_1.size.cmp(&file_or_dir_2.size));

  return files_or_dirs
          .iter()
          .find(|file_or_dir| file_or_dir.is_dir && file_or_dir.size > needed_space)
          .unwrap()
          .size
          .to_string()
}

fn main() {
  println!("{}", "hello advent-of-code!");
  print!("part 1 solution: ");
  println!("{:?}", solution_pt_1());
  print!("part 2 solution: ");
  println!("{:?}", solution_pt_2());
}
