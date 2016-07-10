brewdependencies=zeromq
godependencies=golang.org/x/tools/cmd/goimports \
			   github.com/gophergala2016/gophernotes

jupyter: venv/bin/jupyter $(brewdependencies) $(godependencies) $$HOME/.ipython/kernels/gophernotes
	env PATH=venv/bin:$$PATH jupyter notebook

venv/bin/jupyter: venv
	env PATH=$</bin:$$PATH pip install -r requirements.txt

venv:
	virtualenv -p python3 $@

golang.org/x/tools/cmd/goimports:
	go get $@

github.com/gophergala2016/gophernotes:
	go get -tags zmq_4_x $@

$(brewdependencies):
	brew list|grep $@ || brew install $@

define KERNEL_JSON
{
"argv": [
	"$(shell echo $$GOPATH)/bin/gophernotes",
	"{connection_file}"
	],
	"display_name": "Golang",
	"language": "go",
	"name": "go"
	}
endef
export KERNEL_JSON

$$HOME/.ipython/kernels/gophernotes: github.com/gophergala2016/gophernotes
	mkdir -p $@
	cp -r $$GOPATH/src/$</kernel/* $@/
	echo "$$KERNEL_JSON" > $@/kernel.json
