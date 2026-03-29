.PHONY: push

# Pushes the current branch and tags to the gitlab remote
push:
	@echo "--> Pushing to origin..."
	git push origin --all
	git push origin --tags
