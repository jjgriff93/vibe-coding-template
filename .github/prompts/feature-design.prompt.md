Before starting implementation for any feature, you MUST first analyze the current solution and then propose multiple approaches to implement the feature.
It is important to consider the pros and cons of each approach and how they align with the project's design principles.
All of your approaches should be documented in a single design document as described below.

## Guidelines for creating or updating design documents

- First you must analyse the current solutions structure, design patterns, abstractions, and style of the codebase.
- Then you must propose multiple approaches to implement the feature.
- For each approach, you should include the following sections:

- You should also include a summary of the current solution's structure, design patterns, abstractions, and style of the codebase.
- The design document should be in markdown format and located in the `docs/adr` directory.
- The document should be named using the format `YYYYMMDD-<short-description>.md`.
- The document should include the following sections:
  - **Title**: A short, descriptive title for the design.
  - **Proposed Feature**: A brief description of the feature being proposed.
  - **Approaches**: A detailed description of the proposed approach, including diagrams if necessary as per below format.
    - **Pros and Cons**: A list of the advantages and disadvantages of the proposed approach.
    - **Design Principles**: How this approach aligns with the project's design principles.
  - **Recommended Approach**: A summary of the recommended approach based on the analysis of the pros and cons.
- Please only create one document per feature request containing all the approaches

After creating the design document, stop and let user review it. DO NOT start implementation for any feature until the design document is approved by the team.
