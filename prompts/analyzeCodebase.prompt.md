---
agent: LLM AI Coding Agent
---

# Analyze Codebase

Walk through the complete codebase, do a comprehensive analysis using the following checklist, and provide suggestions for improvement.

## Checklist

### 1. Architectural Coherence

- Evaluate overall architectural consistency.
- Identify mixed architectural styles (e.g., layered, clean architecture, ad-hoc patterns).
- Detect duplicated structural patterns implemented differently.
- Verify clear separation of concerns across layers.
- Ensure architectural boundaries are consistently enforced.

### 2. Package Structure

- Detect packages organized by technical role instead of domain.
- Identify circular dependencies.
- Identify “God” packages with excessive responsibilities.
- Check for overexposed packages lacking `internal/` usage.
- Refactor toward cohesive, domain-oriented packages.

### 3. API and Interface Design

- Detect interfaces defined where implemented instead of where consumed.
- Identify single-implementation interfaces without substitution value.
- Detect premature abstraction.
- Review use of `any` and overly generic APIs.
- Validate constructor and dependency injection consistency.

### 4. Error Handling Consistency

- Identify inconsistent error wrapping.
- Detect missing contextual error information.
- Check for improper use of `%w`.
- Detect double logging of errors.
- Identify swallowed or ignored errors.
- Ensure a clear error propagation strategy.

### 5. Concurrency and Context Usage

- Detect use of `context.Background()` in business logic.
- Verify context propagation across layers.
- Identify goroutine leaks.
- Detect fire-and-forget goroutines without cancellation.
- Review synchronization correctness (mutexes, channels).
- Ensure race detection is part of CI.
- Validate proper use of timeouts and cancellation.

### 6. Data Modeling Quality

- Detect inconsistent pointer vs value semantics.
- Identify duplicated structs with minor differences.
- Review JSON tag consistency.
- Detect excessive DTO-model transformations.
- Ensure clear separation between domain and transport models.

### 7. Test Quality

- Detect tests that mirror implementation rather than behavior.
- Identify brittle tests tightly coupled to internal structure.
- Review overuse of mocks.
- Ensure presence of integration tests.
- Ensure coverage of concurrency scenarios.
- Validate table-driven test patterns where appropriate.

### 8. Logging and Observability

- Detect inconsistent logging formats.
- Identify excessive or insufficient logging.
- Ensure structured logging practices.
- Verify correlation ID propagation.
- Ensure errors are logged at appropriate layers only once.

### 9. Dependency Hygiene

- Identify unnecessary or redundant dependencies.
- Detect multiple libraries serving similar purposes.
- Review indirect dependency bloat.
- Check for outdated or unmaintained packages.
- Prefer standard library where reasonable.

### 10. Performance and Allocation Awareness

- Detect unnecessary memory allocations.
- Review repeated slice reallocations.
- Identify redundant string/byte conversions.
- Detect repeated JSON marshal/unmarshal cycles.
- Run benchmarks where critical paths exist.
- Review escape analysis results.
- Use profiling tools to detect hotspots.

### 11. Code Consistency and Linting

- Enforce consistent formatting rules.
- Ensure static analysis tools are enabled.
- Validate linting in CI pipeline.
- Detect inconsistent naming conventions.
- Remove redundant comments and generated boilerplate noise.

### 12. Strategic Refactoring Approach

- Identify systemic issues rather than isolated smells.
- Refactor vertically through complete feature flows.
- Establish architectural and coding standards.
- Document refactoring principles.
- Create templates for future development consistency.

### 13. Cultural and Process Considerations

- Assess team ownership and code familiarity.
- Identify undocumented architectural decisions.
- Establish AI usage guardrails.
- Define review standards beyond correctness.
- Encourage architectural documentation and intent clarity.

## Output

Keep it high level so that it's easy for me to read and not too complex. Add sections for high, medium and lower priority. If something doesn't need to be changed then don't change it. You don't need to change things just for the sake of changing them. Save to a markdown file in `docs/plans/`.
