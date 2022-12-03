package main

import (
	"bufio"
	"fmt"
	"log"
	"os"
	"strings"
)

func solution_pt1() int {
	file, err := os.Open("./input.txt")
	if err != nil {
			log.Fatal(err)
	}
	defer file.Close()
	scanner := bufio.NewScanner(file)

	summedPriority := 0;

	for scanner.Scan() {
		line := scanner.Text()
		firstHalf := line[0:len(line)/2]
		secondHalf := line[len(line)/2:len(line)]

		for _, letter := range firstHalf {
			if strings.Contains(secondHalf, string(letter)) {
				if letter > 96 {
					summedPriority += (int(letter) - 96)
				} else {
					summedPriority += (int(letter) - 38)
				}
				break;
			}
		}
	}

	return summedPriority;
}

var currentIndex int = 0
var firstLine, secondLine, thirdLine string

func solution_pt2() int {
	file, err := os.Open("./input.txt")
	if err != nil {
			log.Fatal(err)
	}
	defer file.Close()
	scanner := bufio.NewScanner(file)

	summedPriority := 0;

	for scanner.Scan() {
		if currentIndex % 3 == 0 {
			firstLine = scanner.Text()
		} else if currentIndex % 3 == 1 {
			secondLine = scanner.Text()
		} else {
			thirdLine = scanner.Text()
			for _, letter := range firstLine {
				if strings.Contains(secondLine, string(letter)) && strings.Contains(thirdLine, string(letter)) {
					if letter > 96 {
						summedPriority += (int(letter) - 96)
					} else {
						summedPriority += (int(letter) - 38)
					}
					break;
				}
			}
		}
		currentIndex += 1
	}

	return summedPriority;
}

func main() {
	fmt.Println(solution_pt1())
	fmt.Println(solution_pt2())
}