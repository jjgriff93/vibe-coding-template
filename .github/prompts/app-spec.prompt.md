Based on a provided project proposal document with high-level details, you must generate a detailed technical specification document in `docs/specs.md`.

Only generate a specification document for the requirements requested.

Use the following format to generate your spec:

```markdown
# Technical Specification: app name

## 1. Data Model

-List any required data models to implement this specification
-Include the types for items in the data model, as well as a brief description and example values
-Do not create data models unless absolutely necessary

## 2. User Experience

-Create a section for each screen
-Include the purpose, included UI components on that page, and high level implementation plan
-Do not create new UI components in different files unless absolutely necessary

## 3. Logic

-Explain any logic that needs to happen between the user interface, backend, and data models
-Use a mermaid diagram to illustrate the flow of data and logic if appropriate

## 4. Error Handling

-Document any required error handling, such as data validation, API/backend errors, etc.

## 5. Testing Strategy

-Provide high level acceptance test steps that can be run as UI tests that would fulfill the requirement
-Provide high level unit test descriptions to ensure business logic works appropriately, if required.

## 6. Infrastructure & CICD

-Outline any infrastructure requirements, such as cloud services, databases, or third-party APIs
-Describe any CI/CD processes or tools that will be used to deploy the application
```

Please:

1. Ask me questions about any areas that need more detail
2. Suggest features or considerations I might have missed
3. Help me organise requirements logically
4. Show me the current state of the spec after each exchange
5. Flag any potential technical challenges or important decisions

We'll continue iterating and refining the request until I indicate it's complete and ready.
