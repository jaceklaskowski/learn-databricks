# Databricks notebook source
# MAGIC %md
# MAGIC
# MAGIC # WIP Forward-Deployed Engineer (FDE)

# COMMAND ----------

# MAGIC %md
# MAGIC
# MAGIC In May, Anthropic and OpenAI independently established forward-deployed venture firms backed by major institutional capital.
# MAGIC
# MAGIC The forward-deployed model — AI professionals embedded inside client environments, accountable for outcomes — is now the market's dominant theory of how enterprise AI adoption happens.
# MAGIC
# MAGIC The Mission: Instead of merely selling access to Claude, the venture embeds **Applied AI Engineers** and **Forward-Deployed Engineers (FDEs)** into the operations of mid-sized companies.

# COMMAND ----------

# MAGIC %md
# MAGIC
# MAGIC [Anthropic Partners with Blackstone, Hellman & Friedman, and Goldman Sachs to Launch Enterprise AI Services Firm](https://www.blackstone.com/news/press/anthropic-partners-with-blackstone-hellman-friedman-and-goldman-sachs-to-launch-enterprise-ai-services-firm/):
# MAGIC
# MAGIC _Anthropic, Blackstone, Hellman & Friedman, and Goldman Sachs today announced the formation of a new AI-native enterprise services firm that will work with companies to rapidly bring Claude into their core business operations. The new firm is a standalone entity with Anthropic engineering and partnership resources embedded directly within its team._

# COMMAND ----------

# MAGIC %md
# MAGIC
# MAGIC [Anthropic takes shot at consulting industry in joint venture with Wall Street giants](https://fortune.com/2026/05/04/anthropic-claude-consulting-industry-joint-venture-blackstone-goldman-sachs/):
# MAGIC
# MAGIC _Anthropic announced Monday that it has partnered with Blackstone, Hellman & Friedman, and Goldman Sachs to launch a new AI-native enterprise services company — one that puts the Claude maker in direct competition with the world's largest consulting firms for the lucrative business of corporate AI transformation._

# COMMAND ----------

# MAGIC %md
# MAGIC
# MAGIC The strategy bypasses traditional consulting by putting the Claude maker's engineers on-site to rapidly integrate agentic AI into mission-critical, mid-market business operations.

# COMMAND ----------

# MAGIC %md
# MAGIC ## Why the "Forward-Deployed" Model?
# MAGIC
# MAGIC _Direct Deployment: Similar to Palantir's model, FDEs conduct multi-week sprints to build AI-native workflows from the ground up inside a customer's business._

# COMMAND ----------

# MAGIC %md
# MAGIC
# MAGIC [Why Anthropic and OpenAI Are Copying Palantir's Forward-Deployed Engineer Playbook](https://www.mindstudio.ai/blog/anthropic-openai-copying-palantir-forward-deployed-engineer-model):
# MAGIC
# MAGIC 1. The standard software sales motion goes like this: build product, hand it to sales, sales sells it to the customer, customer tries to install it with maybe some help from a customer success team. Then the customer mostly figures it out alone.
# MAGIC 1. Palantir broke that model. Instead of handing off the product and walking away, they took their best engineers and embedded them directly inside the customer's organization.
# MAGIC 1. **Forward deployed**, as in: your engineers are now operating from inside the client's walls.

# COMMAND ----------

# MAGIC %md
# MAGIC
# MAGIC _The insight behind it is deceptively simple. The Palantir engineer knows everything about how the software works. The JP Morgan engineer knows everything about JP Morgan — the data structures, the compliance requirements, the internal politics, the specific problem they're actually trying to solve. Neither one can succeed alone. The FDE model forces those two knowledge sets to collide in the same room until something actually works._
# MAGIC
# MAGIC _The FDE doesn't sell a product and leave. The FDE builds the thing that works for them specifically._

# COMMAND ----------

# MAGIC %md
# MAGIC
# MAGIC ## Deployment Gap
# MAGIC
# MAGIC _The deployment story is the problem_
# MAGIC
# MAGIC _Anyone who has actually tried to implement AI agents inside a real business knows the gap between “this demo is incredible” and “this is running reliably in production.”_
# MAGIC
# MAGIC _Connecting the model to the work requires skills that are genuinely scarce right now, and that most enterprise IT teams don't have._
# MAGIC
# MAGIC _The irony is that the AI labs have spent years building increasingly capable models while the bottleneck has quietly shifted downstream._

# COMMAND ----------

# MAGIC %md
# MAGIC
# MAGIC Anthropic's joint venture is targeting the financial sector first: Blackstone is one of the largest alternative asset managers in the world. Goldman Sachs is Goldman Sachs.
# MAGIC
# MAGIC The $300 million founding commitment and the joint venture structure suggest something closer to a shared deployment operation — a machine for getting AI actually installed and running inside complex financial institutions, with Anthropic’s technical expertise combined with Blackstone’s institutional access and operational knowledge.

# COMMAND ----------

# MAGIC %md
# MAGIC
# MAGIC How do you get a genuinely capable but technically complex system actually deployed and running inside organizations that weren’t built for it?
# MAGIC
# MAGIC The FDE model is a bet that deployment expertise is the scarce resource, not model capability.

# COMMAND ----------

# MAGIC %md
# MAGIC
# MAGIC ## successful enterprise AI deployment
# MAGIC
# MAGIC _What successful enterprise AI deployment looks like from the outside: it shows up in the customer’s growth metrics, not just in the vendor’s revenue._
# MAGIC
# MAGIC _measurable impact on the customer’s own business._
# MAGIC
# MAGIC _what matters is whether the deployed system moves the needle on the institution’s actual KPIs._
# MAGIC
# MAGIC

# COMMAND ----------

# MAGIC %md
# MAGIC
# MAGIC ## Gotchas (What to Watch For)
# MAGIC
# MAGIC 1. The FDE model has a scaling problem
# MAGIC 1. You can't just hire unlimited forward deployed engineers - they're genuinely expert
# MAGIC 1. FDEs understand both the model capabilities and the customer's specific environment. That expertise takes time to develop, and it doesn't scale the way software does.

# COMMAND ----------

# MAGIC %md
# MAGIC
# MAGIC ## Working Procedure
# MAGIC
# MAGIC 1. you write a spec (**the source of truth**) — annotated markdown describing what the system needs to do
# MAGIC 1. you let AI generate the code (a derived output).
# MAGIC
# MAGIC _If FDEs can work at the spec level rather than the code level, the deployment timeline compresses significantly, and the scaling constraint on the FDE model loosens._
# MAGIC

# COMMAND ----------

# MAGIC %md
# MAGIC
# MAGIC ## Anthropic's Applied AI Engineers: The Forward-Deployed Function Behind Claude's Enterprise Strategy
# MAGIC
# MAGIC [Anthropic's Applied AI Engineers: The Forward-Deployed Function Behind Claude's Enterprise Strategy](https://getperspective.ai/blog/anthropic-applied-ai-engineers-forward-deployed-claude-enterprise)
