package main

import "fmt"

type User struct {
	Age  int
	Name string
}

func main() {
	user := User{
		Name: "hunter",
	}

	fmt.Println(user.Name)
}

func testFunc() {
}
