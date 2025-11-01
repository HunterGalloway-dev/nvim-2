package main

import (
	"fmt"
	"net/http"
	"time"
)

type User struct {
	Test string `json:"h"`
}

type Person struct {
	Age int
}

func greet(w http.ResponseWriter, r *http.Request) {
	fmt.Fprintf(w, "Hello World! %s", "")
	timeRenamed := time.Now()
	fmt.Printf("%s", timeRenamed)
	
	user := User{
		Test: "Hunter",	
	}

	user.Test = "hello"
}

func main() {
	http.HandleFunc("/", greet)
	http.ListenAndServe(":8080", nil)
}
