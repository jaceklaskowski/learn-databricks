# Databricks notebook source
# MAGIC %md
# MAGIC # Agent Skills

# COMMAND ----------

# MAGIC %md
# MAGIC
# MAGIC 1. [Agent Skills](https://agentskills.io) is an open standard for extending AI agents with specialized capabilities and expertise (e.g., domain-specific knowledge).
# MAGIC 1. Bundles prompts, tool access, permissions, and workflows that extend the agent's capabilities.
# MAGIC 1. Folders of instructions, scripts, custom commands, and resources that agents can discover and apply to do things more accurately and efficiently.
# MAGIC 1. Portable, reusable and version-controlled
# MAGIC 1. Self-contained units of functionality that you can teach to the agents.
# MAGIC 1. Invoked by either the agent or the human operator (using the slash command).
# MAGIC 1. Expert knowledge you give the agent.
# MAGIC 1. Better for dynamic context discovery and procedural "how-to" instructions. 
# MAGIC 1. Define skills in `SKILL.md` files ([Cursor](https://cursor.com/docs/skills)).

# COMMAND ----------

# MAGIC %md
# MAGIC ## What Are Skills?
# MAGIC
# MAGIC [What Are Skills?](https://docs.devin.ai/cli/extensibility/skills/overview#what-are-skills):
# MAGIC
# MAGIC Think of skills as expert knowledge you give the agent.
# MAGIC 1. Review code according to your team's standards
# MAGIC 1. Generate a specific type of component
# MAGIC 1. Run a deployment workflow
# MAGIC 1. Perform a security audit
# MAGIC 1. Set up a new service from a template
# MAGIC
# MAGIC Users can invoke skills with a slash command (`/skill-name`).
# MAGIC
# MAGIC Agents can invoke skills autonomously when relevant.
# MAGIC
# MAGIC Skills can have their own permission grants and restrictions.
# MAGIC
# MAGIC Restrict which tools a skill can use for safety.
# MAGIC
# MAGIC Skills can be executed as independent subagents with their own context window.

# COMMAND ----------

# MAGIC %md
# MAGIC
# MAGIC ## Examples
# MAGIC
# MAGIC 1. [Dash0 Agent Skills](https://github.com/dash0hq/agent-skills)
# MAGIC 1. [code review skill](https://docs.devin.ai/cli/extensibility/skills/overview#quick-example)

# COMMAND ----------

# MAGIC %md
# MAGIC ## How Skills Work
# MAGIC
# MAGIC [How Skills Work](https://docs.devin.ai/cli/extensibility/skills/overview#how-skills-work)

# COMMAND ----------

# MAGIC %md
# MAGIC
# MAGIC ## Skill Triggers
# MAGIC
# MAGIC [Skill Triggers](https://docs.devin.ai/cli/extensibility/skills/overview#skill-triggers):
# MAGIC * By users using a slash command (/skill-name).
# MAGIC * By agents autonomously when relevant.
# MAGIC * Set `triggers: [user]` to prevent the agent from invoking a skill on its own.

# COMMAND ----------

# MAGIC %md
# MAGIC ## Where Skills Live
# MAGIC
# MAGIC [Where Skills Live](https://docs.devin.ai/cli/extensibility/skills/overview#where-skills-live):
# MAGIC * Skills can be scoped to a single project or shared across all projects
# MAGIC     * `.agents/skills/<name>/SKILL.md` for a project-specific skill 
# MAGIC     * `~/.agents/skills/<name>/SKILL.md` for global skills
# MAGIC * **Project skills** are committed to version control, making them shareable with your team
# MAGIC * **Global skills** are available in every project on this machine.

# COMMAND ----------

# MAGIC %md
# MAGIC ## Learn More
# MAGIC
# MAGIC 1. [RAG vs SKILL vs MCP vs RLM](https://blog.alexewerlof.com/p/rag-vs-skill-vs-mcp-vs-rlm)
# MAGIC 1. [Skills Overview](https://docs.devin.ai/cli/extensibility/skills/overview)
# MAGIC
