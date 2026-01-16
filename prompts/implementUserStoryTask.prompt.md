---
agent: Plan
model: GPT-5.2 (copilot)
tools: ['search']
---

# Implement user story task

Read all documents, instructions, and documentation. Then create a plan for implementing ${input:userStoryTask}. I will review your plan and provide feedback. Make the plan as detailed as possible, outline concrete implementation steps, and provide as much context as you can. After I approve the plan, a less capable LLM AI coding agent will implement it. The more context, details and steps you provide the better the less capable LLM AI coding agent will perform. If anything is unclear then ask for clarification. If you have further considerations then provide recommendations. I will test and review the implementation when both of you are done. Do not proceed with the next task until I have validated the implementation and approved the reviewed code.
