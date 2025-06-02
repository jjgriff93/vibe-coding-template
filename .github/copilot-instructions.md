# Project Structure

-/.github - Files for personalising a user's GitHub Copilot experience
-/src - Source code for the project
-/docs - Documentation, including project design and implementation

# Rules

## General Rules

-Keep dependencies to a minimum
-Simpler architectures are preferred
-Modularity is good, but don't take it too far
-Make any UI beautiful and intuitive

## Code Quality

-Write clean, well-documented code
-Use appropriate error handling
-When creating new code using libraries, frameworks and APIs, use Context7 to retrieve current documentation rather than relying on training data.
-When creating code, always use the latest stable version of the library or framework available.
-Test any web UI changes using playwright.

## Domain Knowledge

Use files in the `docs/domain.md` as a source of truth when it comes to domain knowledge. These files will give you the context in which the current solution operates under. This folder will contain information like entity relationships, workflows and ubiquitous language. As the understanding of the domain grows, take the opportunity to update these files as required as well.

## Accessibility

-Always generate accessible UI code
