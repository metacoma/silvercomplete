package main

import (
  "net/http"
  "net"
  "log"
  "fmt"
  "mime"
  "io"
  "path/filepath"
  "bytes"
  "github.com/octoblu/go-simple-etcd-client/etcdclient"
  "github.com/wneo/jlfuzzy"
  "github.com/zserge/webview"
  "github.com/go-vgo/robotgo"

)

var fuzzy = jlfuzzy.NewJLFuzzy()
var nodes []string
//var ETCD_SERVER = os.Getenv("SILVERKEY_HOST")
var ETCD_SERVER = "http://nseha.linkpc.net:22379"
var w webview.WebView

type Nodes struct {
	Value string `json:"value"`
}

func (nodes *Nodes) Search(searchkey string) {
  nodes.Value = ""
  for _, match := range fuzzy.SearchWord(searchkey, 1, -1, 0, 10) {
    nodes.Value = nodes.Value + fmt.Sprintf("<div class=divTableRow><div class=divTableCell>%s</div></div>", match)
  }
}

func (nodes *Nodes) Found(nodeName string) {
	w.Terminate();
}

func handleRPC(w webview.WebView, data string) {
	log.Printf("RCP %s\n", data)
	w.Terminate()
}

func startServer() string {
	ln, err := net.Listen("tcp", "127.0.0.1:0")
	if err != nil {
		log.Fatal(err)
	}
	go func() {
		defer ln.Close()
		http.HandleFunc("/", func(w http.ResponseWriter, r *http.Request) {
			path := r.URL.Path
			if len(path) > 0 && path[0] == '/' {
				path = path[1:]
			}
			if path == "" {
				path = "index.html"
			}
			if bs, err := Asset(path); err != nil {
				w.WriteHeader(http.StatusNotFound)
			} else {
				w.Header().Add("Content-Type", mime.TypeByExtension(filepath.Ext(path)))
				io.Copy(w, bytes.NewBuffer(bs))
			}
		})
		log.Fatal(http.Serve(ln, nil))
	}()
	return "http://" + ln.Addr().String()
}

func main() {

    client, err := etcdclient.Dial(ETCD_SERVER)

    if err != nil {
      log.Fatal(err)
    }

    nodes, err := client.LsRecursive("/")
    fuzzy.AddWords(nodes)

    if err != nil {
      log.Fatal(err)
    }

    url := startServer()
    w = webview.New(webview.Settings{
		URL: url,
		Width:  320,
		Height: 200,
		Debug: true,
		ExternalInvokeCallback: handleRPC,
    })
	w.Dispatch(func() {
		w.Bind("nodes", &Nodes{})
	})
	w.Run()

    robotgo.TypeString("Hello World")

}
