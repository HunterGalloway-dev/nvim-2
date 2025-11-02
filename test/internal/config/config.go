// Package config defines the structure of the applications config and loading it
package config

import (
	"encoding/json"
	"fmt"
	"os"
)

type Config struct {
	AppName string
	Port int
}

func Load(file string) (Config, error) {
	data, err := os.ReadFile(file)
	if err != nil {
		return Config{}, fmt.Errorf("failed load config file %s: %w", file, err)
	}

	var cfg Config
	err = json.Unmarshal(data, &cfg)
	if err != nil {
		return Config{}, fmt.Errorf("failed to unmarshal config file %s: %w", file, err)
	}


	return cfg, nil
}
