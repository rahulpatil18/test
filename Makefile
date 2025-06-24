PYTHON_VERSION := 3.11
POETRY_VERSION := 1.8.2

# Check for pipx
check-pipx:
	@echo "🔍 Checking pipx..."
	@if ! command -v pipx >/dev/null 2>&1; then \
		echo "❌ pipx not installed. Please install it manually or via Homebrew."; \
		exit 1; \
	else \
		echo "✅ pipx is installed"; \
	fi

# Check and manage Poetry version
check-poetry: check-pipx
	@echo "🔍 Checking Poetry..."
	@if command -v poetry >/dev/null 2>&1; then \
		current_version=$$(poetry --version | cut -d' ' -f3 | sed 's/)//'); \
		if [ "$$current_version" != "$(POETRY_VERSION)" ]; then \
			echo "⚠️ Poetry version $$current_version found, switching to $(POETRY_VERSION)..."; \
			pipx uninstall poetry || true; \
			pipx install poetry==$(POETRY_VERSION); \
		else \
			echo "✅ Poetry $(POETRY_VERSION) is already installed"; \
		fi \
	else \
		echo "❌ Poetry not found. Installing version $(POETRY_VERSION)..."; \
		pipx install poetry==$(POETRY_VERSION); \
	fi

# Ensure Python version is set in pyproject.toml
check-python-version:
	@echo "🔍 Checking Python version in pyproject.toml..."
	@grep -E '^python = ' pyproject.toml > /dev/null || { \
		echo "❌ Python version not specified in pyproject.toml"; \
		exit 1; \
	}
	@echo "✅ Python version declared"

# Set up Poetry virtual environment and install dependencies
setup-poetry-env: check-python-version check-poetry
	@echo "🧪 Setting up Poetry virtual environment..."
	poetry config virtualenvs.in-project true
	poetry env use python$(PYTHON_VERSION)
	poetry install --no-interaction
	@echo "✅ Poetry virtual environment is ready"
	@echo "💡 Run 'poetry shell' to enter the environment"

# Run all tests
tests: setup-poetry-env
	@echo "🚀 Running all tests..."
	poetry run pytest tests/ -v
