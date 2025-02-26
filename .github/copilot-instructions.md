## Rules
Always follow the rules when planning, writing code, running code, or writing tests.

### Planning
-After generating the project/project-proposal.md, and when asked to create an implementation plan, 
-Clarify any requirements or details that are necessary for you to generate a complete project proposal or plan with the user
-Provide suggestions for improving the project proposal or plan that would result in better code generation, architecture, and user experience
-Planning documents are passed directly back to an LLM to implement
-Don't overcomplicate the planning process; keep it simple

### Documentation
-If you create a new file, update the .github/custom-instructions.md file to include the file in the file structure, along with a brief description of the file.
-Stick to the implementation plan provided to you.
-If you stray away from the implementation plan, update the corresponding document in the /project/plan directory.
-Summarize major changes in a few sentences in changelog.md.

### Code
-All code is found in /code
-Always refer to documents in /project/ before implementing anything.
-/project/project-proposal.md
-Each class should contain a few paragraph description at the top of the file.
-Every member of the class should contain a description of what it does.
-Large blocks of code should include comments on what each sub-block does.

### Style
-Assume the user is horrible at design, and implement the stated requirements with good design taste.
-Ensure any UI you generate is accessible by default using the appropriate mechanisms for this tech stack
-Ensure any strings you generate are localized by default using the appropriate mechanisms for this tech stack
-Make changes as necessary to the README for onboarding to the project

### Debugging
-Always build and run the application exclusively from the CLI after completing your code changes

### Tests
-Generate user interface tests for any UI changes
-Ensure tests can be run from a GitHub Actions CI/CD pipeline