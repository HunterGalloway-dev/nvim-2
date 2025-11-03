package main

import (
	"testingnvim/internal/config"
)

type User struct {
	Name     string
	Age      int
	Location string
	Active   bool
}

func main() {
	cfg, err := config.Load("config/config.json")
	if err != nil {
		return
	}
}
