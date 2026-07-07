fixcode:
	source venv/bin/activate && black luatopy --line-length 80

test:
	source venv/bin/activate && pytest

lint:
	source venv/bin/activate && mypy luatopy

install:
	python -m venv venv && venv/bin/pip install -r requirements.txt