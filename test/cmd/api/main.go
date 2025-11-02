package main

import "fmt"

type User struct {
	Name     string
	Age      int
	Location string
	Active   bool
}

func main() {
	user := User{
		Name:     "Hunter",
		Age:      20,
		Location: "testing",
		Active:   true,
	}

	if user.Active {
		fmt.Println("This user is active")
	}

	err := sampleError()
	if err != nil {
		fmt.Printf("handling error: %s", err)
	}

	fmt.Println("hello world")
	val := doStuff()

	fmt.Printf("%d", val)
}

func doStuff() int {
	x := 5
	y := 15

	z := x + y
	return z
}

func sampleError() error {
	return fmt.Errorf("i am example error")
}
