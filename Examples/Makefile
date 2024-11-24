.PHONY: gen project fetch feature format

OPEN?=false
USER_NAME = $(shell python3 Scripts/author_name.py)
CURRENT_DATE = $(shell python3 Scripts/current_date.py)

gen:
ifeq ($(OPEN), false)
	tuist generate --no-open
else
	tuist generate
endif
	
fetch:
	tuist clean
	tuist install
	
feature:
	tuist scaffold Feature \
	--name ${name} \
	--current-date $(CURRENT_DATE) \
	--author $(USER_NAME)

project: fetch gen

format:
	swiftformat .

MISE = $(shell which ~/.local/bin/mise)
TUIST = $(shell which tuist)
SWIFTFORMAT = $(shell which swiftformat)

install:
ifeq ($(MISE), $(HOME)/.local/bin/mise)
	@echo "mise is already installed"
else
	@echo "Installing mise..."
	curl https://mise.run | sh
endif
	
ifeq ($(TUIST), $(HOME)/.local/share/mise/installs/tuist/latest/bin/tuist)
	@echo "tuist is already installed"
else
	@echo "Installing tuist..."
	~/.local/bin/mise install tuist
	~/.local/bin/mise use tuist
endif

ifeq ($(SWIFTFORMAT), /opt/homebrew/bin/swiftformat)
	@echo "swiftformat is already installed"
else
	@echo "Installing swiftformat..."
	brew install swiftformat
endif
