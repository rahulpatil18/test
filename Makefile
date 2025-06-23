PYTHON_VERSION := 3.11
POETRY_VERSION := 1.8.2

check-brew:
	@echo "Skipping Homebrew check (not needed in CI)"

check-pipx:
	@echo "Skipping pipx check (done in pipeline)"

check-poetry: check-pipx
	@echo "✅ Poetry is assumed to be installed"

check-python:
	@echo "✅ Python$(PYTHON_VERSION) is assumed to be installed"

setup-poetry-env: check-python check-poetry
	@echo "🔍 Setting up Poetry virtual environment..."
	poetry config virtualenvs.in-project true
	poetry env use python$(PYTHON_VERSION)
	poetry install
	@echo "✅ Poetry virtual environment is ready"

tests: setup-poetry-env
	@echo "🚀 Running all tests..."
	poetry run pytest tests/ -v
