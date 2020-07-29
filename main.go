package main

import (
	"github.com/gin-gonic/gin"
	"time"
)

func main() {
	// Engin
	router := gin.Default()
	//router := gin.New()

	router.GET("/hello", func(context *gin.Context) {
		context.JSON(200,gin.H{
			"code":200,
			"success":true,
			"data":"hello golang",
			"time": time.Now().Unix(),
		})
	})
	// 指定地址和端口号
	router.Run(":8005")
}
