use std::cell::RefCell;
use std::rc::Rc;
use std::fs::File;
use std::io::{self, BufRead};
use std::path::Path;

#[derive(PartialEq)]
struct TreeNode {
  pub name: String,
  pub value: i32,
  pub children: Vec<Rc<RefCell<TreeNode>>>,
  pub parent: Option<Rc<RefCell<TreeNode>>>,
}

impl TreeNode {
  pub fn new() -> TreeNode {
    return TreeNode {
      name: String::from(""),
      value: 0,
      children: vec![],
      parent: None,
    };
  }
}

fn read_lines<P>(filename: P) -> io::Result<io::Lines<io::BufReader<File>>>
where P: AsRef<Path>, {
  let file = File::open(filename)?;
  Ok(io::BufReader::new(file).lines())
}

fn main() {
  if let Ok(lines) = read_lines("./input.txt") {
    let mut current = Rc::new(RefCell::new(TreeNode::new()));
    current.borrow_mut().name = String::from("/");
    current.borrow_mut().value += 10;

    let mut prev = Rc::new(RefCell::new(TreeNode::new()));
    let mut tmp = Rc::new(RefCell::new(TreeNode::new()));
    
    println!("{:?}", current.borrow().name);
    println!("{:?}", current.borrow().value);

    for line in lines {
      if let Ok(ok_line) = line {
        let v = ok_line.split_whitespace().take(3).collect::<Vec<&str>>();

        if let [_, command] = &v[..] {
          if &command[..] == String::from("ls") {
            println!("LS: {}", command);
          }
        }
        if let [dir_or_size, name] = &v[..] {
            if &dir_or_size[..] == String::from("dir") {
              println!("DIR: {} {}", dir_or_size, name);
            } else if &dir_or_size[..] != String::from("$") {
              println!("FILE: {} {}", dir_or_size, name);
              current.borrow_mut().value += dir_or_size.parse::<i32>().unwrap();
              println!("{:?}", current.borrow().value);
            }
        }
        if let [_, command, argument] = &v[..] {
          if &command[..] == String::from("cd") {
            if &argument[..] == String::from("..") {
              println!("CD ..: {} {}", command, argument)
            } else {
              let child = Rc::new(RefCell::new(TreeNode::new()));
              current.borrow_mut().children.push(Rc::clone(&child));
              println!("CD: {} {}", command, argument);
            }
          }
        }
      }
    }
  }
}
