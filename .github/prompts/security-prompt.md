# Security Analysis
## Objective
Perform a comprehensive security analysis of the code changes you're introducing. Identify any potential security vulnerabilities or risks, and propose or implement fixes for any issues found.
## Instructions
1. Review all code changes for common security vulnerabilities including but not limited to:
   - Input validation vulnerabilities (e.g., XSS, SQL injection, command injection)
   - Authentication and authorization flaws
   - Sensitive data exposure (API keys, tokens, credentials)
   - Insecure cryptographic implementations
   - Potential path traversal issues
   - Untrusted data deserialization
   - Cross-site request forgery vulnerabilities
   - Inadequate error handling that exposes sensitive information
   - Dependency vulnerabilities
2. Highlight any identified security concerns:
   - Describe the specific vulnerability
   - Explain the potential impact
   - Indicate the severity level (Low, Medium, High, Critical)
   - Reference relevant files and line numbers
3. Fix identified security issues:
   - Implement appropriate security controls
   - Apply the principle of least privilege
   - Ensure secure coding practices
   - Replace insecure functions with secure alternatives
   - Document your security-related changes
4. Verify that your fixes don't introduce new security problems or break existing functionality.
## Report Storage
- Save this report as a markdown file under `docs/security` with the filename format: `YYYYMMDD-<short-description>-report.md`
## Output Format
Provide your analysis in the following structure:
### Security Analysis Results
- **Issues Found**: [Yes/No]
- **Summary**: Brief overview of findings
### Detailed Findings (if any)
1. **Issue**: [Description]
   - **Severity**: [Low/Medium/High/Critical]
   - **Location**: [File path and line numbers]
   - **Recommendation**: [How to fix]
   - **Fix Implemented**: [Yes/No] + Description of fix
### Confirmation
- Confirm that the code has been reviewed for security issues
- Confirm that all identified issues have been addressed