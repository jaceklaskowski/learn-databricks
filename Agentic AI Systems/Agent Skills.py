# Databricks notebook source
# MAGIC %md
# MAGIC # Agent Skills

# COMMAND ----------

# MAGIC %md
# MAGIC
# MAGIC 1. [Agent Skills](https://agentskills.io) is an open standard for extending AI agents with specialized capabilities and expertise (e.g., domain-specific knowledge).
# MAGIC 1. crewaiinc/skills
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
# MAGIC ## File Format — YAML
# MAGIC
# MAGIC A skill is a folder with a `SKILL.md` with minimal frontmatter:
# MAGIC
# MAGIC <br>
# MAGIC
# MAGIC ```yaml
# MAGIC ---
# MAGIC name: my-skill
# MAGIC description: One-line description of what it does and when to use it — agentic harnesses read this to decide relevance.
# MAGIC ---
# MAGIC
# MAGIC Instructions for what the skill should do go here...
# MAGIC ```
# MAGIC
# MAGIC The whole spec is just `name` and `description`.
# MAGIC
# MAGIC The folder can also have files (e.g., scripts, references) that the skill's instructions point to.

# COMMAND ----------

# MAGIC %md
# MAGIC ## Installing Skills
# MAGIC
# MAGIC Skills can be scoped to a single project or shared across all projects.
# MAGIC
# MAGIC In Claude Code:
# MAGIC 1. **Personal / Global skills** (available across all your projects):
# MAGIC `~/.claude/skills/<skill-name>/SKILL.md`
# MAGIC 2. **Project skills** (shared with your team via git):
# MAGIC `.claude/skills/<skill-name>/SKILL.md`
# MAGIC 3. **Plugin skills** — installed automatically when you enable a plugin

# COMMAND ----------

# MAGIC %md
# MAGIC
# MAGIC <br>
# MAGIC
# MAGIC ```shell
# MAGIC pnpx skills add crewaiinc/skills
# MAGIC ```

# COMMAND ----------

# MAGIC %md
# MAGIC ## How to Check Installed Skills
# MAGIC
# MAGIC Run `/skills` to list all the discovered skills (personal, project, and plugin-provided).
# MAGIC
# MAGIC No install step or restart is needed for personal/project skills — drop the file in the right directory and it's live.

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
# MAGIC * By users using a slash command (`/[skill-name]`).
# MAGIC * By agents autonomously when relevant.
# MAGIC * Set `triggers: [user]` to prevent the agent from invoking a skill on its own.

# COMMAND ----------

# MAGIC %md
# MAGIC ## WIP Evaluating skill output quality
# MAGIC
# MAGIC Read it 👉 [Evaluating skill output quality](https://agentskills.io/skill-creation/evaluating-skills)

# COMMAND ----------

# MAGIC %md
# MAGIC ## Learn More
# MAGIC
# MAGIC 1. [RAG vs SKILL vs MCP vs RLM](https://blog.alexewerlof.com/p/rag-vs-skill-vs-mcp-vs-rlm)
# MAGIC 1. [Skills Overview](https://docs.devin.ai/cli/extensibility/skills/overview)
# MAGIC
