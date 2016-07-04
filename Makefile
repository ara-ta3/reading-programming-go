run: install
	env PATH=venv/bin:$$PATH jupyter notebook

install: venv/bin/jupyter

venv/bin/jupyter: venv
	env PATH=$</bin:$$PATH pip install -r requirements.txt

venv:
	virtualenv -p python3 $@
