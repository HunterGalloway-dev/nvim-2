// Package server wraps the functionality of HTTP to make an API
package server

import (
	"fmt"
	"net/http"
	"testingnvim/internal/config"
)

func New(cfg config.Config) http.Server {
	
	return http.Server{
		Addr: fmt.Sprintf(":%d", cfg.Port)
	}
}
