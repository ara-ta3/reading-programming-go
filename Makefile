jupyter: venv/bin/jupyter
	env PATH=venv/bin:$$PATH jupyter notebook

venv/bin/jupyter: venv
	env PATH=$</bin:$$PATH pip install -r requirements.txt

venv:
	virtualenv -p python3 $@
