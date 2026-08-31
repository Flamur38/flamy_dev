package main

import (
	"encoding/json"
	"fmt"
	"github.com/elastic/go-grok"
	"github.com/elastic/go-grok/patterns"
)


func main(){
	g := grok.New()
	basePatterns := map[string]string{
		"LOG_PREFIX": `%{SYSLOGBASE2} %{DATA:logSrc} %{WORD:program}\[%{BASE10NUM:pid}\]\: %{WORD:result} %{WORD:loginType} for (invalid user )?%{WORD:username} from %{IP:scr_ip} port %{BASE10NUM:clientPort} %{WORD:protocol}`, 
	}
	g.AddPatterns(patterns.Syslog)
	g.AddPatterns(basePatterns)
	err := g.Compile("%{LOG_PREFIX}", true)
	if err != nil {
		panic(err)
	}
	res, err := g.ParseString("Mar  6 06:31:41 ip-172-31-35-28 sshd[2399]: Failed password for root from 65.2.161.68 port 46852 ssh2")
	if err != nil {
		panic(err)
	}

	jsonData, err := json.Marshal(res)
	if err != nil {
		panic(err)
	}

	fmt.Println(string(jsonData))

	// fmt.Println(res)
}
