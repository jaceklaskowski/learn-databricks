# Databricks notebook source
# /// script
# [tool.databricks.environment]
# environment_version = "5"
# ///
# MAGIC %md
# MAGIC
# MAGIC # MLflow and CrewAI
# MAGIC
# MAGIC [GitHub](https://github.com/crewAIInc/crewAI)

# COMMAND ----------

# MAGIC %md
# MAGIC # 🔥 Discovery of the Day
# MAGIC
# MAGIC As of Jul 28, not only do Databricks notebooks include markdown sections in Table of contents view but also code cells (with their titles) 🔥

# COMMAND ----------

# MAGIC %md
# MAGIC
# MAGIC # What is CrewAI?
# MAGIC
# MAGIC [What is CrewAI?](https://docs.crewai.com/v1.15.7/en/introduction#what-is-crewai):
# MAGIC
# MAGIC * An open-source framework for orchestrating autonomous, role-playing AI agents and building complex workflows.
# MAGIC * Empowers developers to build production-ready multi-agent systems by combining the collaborative intelligence of **Crews** with the precise control of **Flows**.
# MAGIC     * [Flows](https://docs.crewai.com/v1.15.7/en/guides/flows/first-flow) are the backbone of your AI application.
# MAGIC     * [Crews](https://docs.crewai.com/v1.15.7/en/guides/crews/first-crew) are collaborative agentic teams. The units of work within your Flow.

# COMMAND ----------

# MAGIC %md
# MAGIC # 🛠️ Set Up Environment

# COMMAND ----------

# DBTITLE 1,Install Dependencies
# MAGIC %pip install -qU "mlflow-skinny[databricks]>=3.14.0" "databricks-agents>=1.11.0" "crewai[tools]>=1.15.9"
# MAGIC %restart_python

# COMMAND ----------

# DBTITLE 1,crewai
# MAGIC %pip show crewai

# COMMAND ----------

# DBTITLE 1,crewai-tools
# MAGIC %pip show crewai-tools

# COMMAND ----------

# MAGIC %md
# MAGIC
# MAGIC ## mlflow-skinny[databricks]
# MAGIC
# MAGIC Just FYI that `mlflow-skinny`'s [databricks](https://github.com/mlflow/mlflow/blob/v3.14.0/pyproject.toml#L89-L95) optional dependency group pulls the following dependencies:
# MAGIC
# MAGIC <br>
# MAGIC
# MAGIC ```py
# MAGIC databricks = [
# MAGIC   "azure-storage-file-datalake>12",
# MAGIC   "google-cloud-storage>=1.30.0",
# MAGIC   "boto3>1",
# MAGIC   "botocore",
# MAGIC   "databricks-agents>=1.2.0,<2.0",
# MAGIC ]
# MAGIC ```
# MAGIC
# MAGIC Among the optional dependencies is `databricks-agents` that we explicitly upgraded to the [latest version](https://pypi.org/project/databricks-agents/).

# COMMAND ----------

# DBTITLE 1,databricks-agents
# MAGIC %pip show databricks-agents

# COMMAND ----------

# DBTITLE 1,MLflow version
import mlflow

displayHTML(f"MLflow version: <b>{mlflow.__version__}</b>")

# COMMAND ----------

# MAGIC %md
# MAGIC # Databricks Integration
# MAGIC
# MAGIC [Databricks Integration](https://docs-platform.crewai.com/platform/en/integrations/databricks)
# MAGIC
# MAGIC Connect CrewAI agents to Databricks Genie, SQL, Unity Catalog Functions, and Vector Search through Databricks managed MCP servers.
# MAGIC
# MAGIC Connect your CrewAI agents directly to your Databricks workspace through Databricks managed MCP servers.
# MAGIC
# MAGIC The Databricks integration lets your crewai agents do the following:
# MAGIC
# MAGIC * Ask natural-language questions with Genie.
# MAGIC * Run governed SQL
# MAGIC * Call Unity Catalog Functions
# MAGIC * Retrieve documents with Vector Search
# MAGIC
# MAGIC All without writing or hosting any connector code, and with Unity Catalog permissions enforced on every call.

# COMMAND ----------

# MAGIC %md
# MAGIC # DatabricksQueryTool
# MAGIC
# MAGIC [DatabricksQueryTool](https://docs.crewai.com/v1.15.8/en/tools/search-research/databricks-query-tool) - a built-in tool for querying Databricks workspace tables using SQL.

# COMMAND ----------

context = dbutils.notebook.entry_point.getDbutils().notebook().getContext()

hostname = context.apiUrl().get()
token = context.apiToken().get()

import os

os.environ["DATABRICKS_HOST"] = hostname
os.environ["DATABRICKS_TOKEN"] = token

# COMMAND ----------

from crewai_tools import DatabricksQueryTool

tool = DatabricksQueryTool()
results = tool.run(query="SELECT * FROM RANGE(5) LIMIT 10", warehouse_id="6d9331f989a6418b")

print(results)

# COMMAND ----------

# MAGIC %md
# MAGIC
# MAGIC # 🧑‍💻 Demo: Tracing CrewAI using MLflow
# MAGIC
# MAGIC [Tracing CrewAI using MLflow](https://mlflow.org/docs/latest/genai/tracing/integrations/listing/crewai/)

# COMMAND ----------

# DBTITLE 1,Autolog crewAI
import mlflow

mlflow.crewai.autolog()

# COMMAND ----------

# DBTITLE 1,OPENAI_API_KEY
# MAGIC %skip
# MAGIC
# MAGIC # Store the OpenAI API key using the Databricks Secrets CLI
# MAGIC # install the secret on your laptop that is authenticated with the Databricks workspace
# MAGIC # databricks secrets create-scope openai_secrets
# MAGIC # databricks secrets put-secret openai_secrets api_key
# MAGIC
# MAGIC # Retrieve the API key from Databricks secrets
# MAGIC # It must match "databricks secrets put-secret" above
# MAGIC
# MAGIC secret_scope_name = "openai_secrets"
# MAGIC secret_key_name = "api_key"
# MAGIC
# MAGIC openai_api_key = dbutils.secrets.get(scope=secret_scope_name, key=secret_key_name)
# MAGIC
# MAGIC import os
# MAGIC os.environ["OPENAI_API_KEY"] = openai_api_key

# COMMAND ----------

# DBTITLE 1,databricks_llm
from crewai import LLM

databricks_llm = LLM(
    model="databricks/databricks-claude-opus-5",
)

# COMMAND ----------

from crewai import Agent, Crew, Task, Flow

# COMMAND ----------

# MAGIC %md
# MAGIC ## Agent
# MAGIC
# MAGIC Represents an agent in a system.
# MAGIC
# MAGIC Each agent has a role, a goal, a backstory, a knowledge, and an optional language model (llm) that will run the agent.
# MAGIC
# MAGIC The agent can also have memory, can operate in verbose mode, and can delegate tasks to other agents.
# MAGIC
# MAGIC The agent can also have `tools` at agents disposal.

# COMMAND ----------

help(Agent)

# COMMAND ----------

from crewai_tools import SerperDevTool, WebsiteSearchTool

# COMMAND ----------

# MAGIC %md
# MAGIC
# MAGIC ## WebsiteSearchTool
# MAGIC
# MAGIC Learn more in the [WebsiteSearchTool]($./WebsiteSearchTool) notebook.

# COMMAND ----------

# DBTITLE 1,string_source
from crewai.knowledge.source.string_knowledge_source import StringKnowledgeSource

content = "Users name is John. He is 30 years old and lives in San Francisco."
string_source = StringKnowledgeSource(
    content=content,
    metadata={"preference": "personal"},
)

# COMMAND ----------

import nest_asyncio

nest_asyncio.apply()

# COMMAND ----------

# DBTITLE 1,Create a crew agent
from crewai import Agent, BaseLLM
from crewai.project import agent

@agent
def my_city_selection_agent(llm: str | BaseLLM) -> Agent:
    return Agent(
        role="City Selection Expert",
        goal="Select the best city based on weather, season, and prices",
        backstory="An expert in analyzing travel data to pick ideal destinations",
        llm=llm,
        verbose=True,
        allow_delegation=False,
        # tools=[
        #     search_tool,
        # ],
    )

# COMMAND ----------

# MAGIC %md
# MAGIC ## Crew
# MAGIC
# MAGIC Represents a group of agents, defining how they should collaborate and the tasks they should perform.
# MAGIC

# COMMAND ----------

from textwrap import dedent

class TripAgents:
    def __init__(self, llm):
        self.llm = llm

    def local_expert(self):
        return Agent(
            role="Local Expert at this city",
            goal="Provide the BEST insights about the selected city",
            backstory="""A knowledgeable local guide with extensive information about the city, it's attractions and customs""",
            # tools=[
            #     search_tool,
            # ],
            llm=self.llm,   # Use Databricks LLM
            verbose=True,
            allow_delegation=False,
        )

# COMMAND ----------

from textwrap import dedent

class TripTasks:
    def identify_task(self, agent, origin, cities, interests, range):
        return Task(
            description=dedent(
                f"""
                Analyze and select the best city for the trip based
                on specific criteria such as weather patterns, seasonal
                events, and travel costs. This task involves comparing
                multiple cities, considering factors like current weather
                conditions, upcoming cultural or seasonal events, and
                overall travel expenses.
                Your final answer must be a detailed
                report on the chosen city, and everything you found out
                about it, including the actual flight costs, weather
                forecast and attractions.

                Traveling from: {origin}
                City Options: {cities}
                Trip Date: {range}
                Traveler Interests: {interests}
            """
            ),
            agent=agent,
            expected_output="Detailed report on the chosen city including flight costs, weather forecast, and attractions",
        )

    def gather_task(self, agent, origin, interests, range):
        return Task(
            description=dedent(
                f"""
                As a local expert on this city you must compile an
                in-depth guide for someone traveling there and wanting
                to have THE BEST trip ever!
                Gather information about key attractions, local customs,
                special events, and daily activity recommendations.
                Find the best spots to go to, the kind of place only a
                local would know.
                This guide should provide a thorough overview of what
                the city has to offer, including hidden gems, cultural
                hotspots, must-visit landmarks, weather forecasts, and
                high level costs.
                The final answer must be a comprehensive city guide,
                rich in cultural insights and practical tips,
                tailored to enhance the travel experience.

                Trip Date: {range}
                Traveling from: {origin}
                Traveler Interests: {interests}
            """
            ),
            agent=agent,
            expected_output="Comprehensive city guide including hidden gems, cultural hotspots, and practical travel tips",
        )

# COMMAND ----------

from crewai.rag.embeddings.providers.custom.embedding_callable import CustomEmbeddingFunction
from crewai.rag.core.types import Documents, Embeddings

class MyCustomEmbeddingFunction(CustomEmbeddingFunction):
    # Embeddings = list[Embedding]
    def __call__(self, input: Documents) -> Embeddings:
        print(f"MyCustomEmbeddingFunction({input})")
        return []

# COMMAND ----------

from crewai import Agent, Crew, Task


embedder_config = {
    # crewai.rag.embeddings.providers.custom.custom_provider.CustomProvider
    "provider": "custom",
    # Custom embedding function class
    # Converts input documents to embeddings
    # CustomEmbeddingFunction
    "embedding_callable": MyCustomEmbeddingFunction(),
}

class TripCrew:
    def __init__(self, origin, cities, date_range, interests, llm):
        self.cities = cities
        self.origin = origin
        self.interests = interests
        self.date_range = date_range
        self.llm = llm

    async def run(self):
        tasks = TripTasks()

        city_selector_agent = my_city_selection_agent(llm=databricks_llm)

        agents = TripAgents(self.llm)
        local_expert_agent = agents.local_expert()

        identify_task = tasks.identify_task(
            city_selector_agent,
            self.origin,
            self.cities,
            self.interests,
            self.date_range,
        )
        gather_task = tasks.gather_task(
            local_expert_agent, self.origin, self.interests, self.date_range
        )

        crew = Crew(
            agents=[city_selector_agent, local_expert_agent],
            tasks=[identify_task, gather_task],
            verbose=True,
            memory=False,           # Disabled to avoid OpenAI embeddings
            manager_llm=self.llm,   # Use Databricks LLM for management
            tracing=True,           # Enable tracing
            knowledge_sources=[string_source],
            embedder=embedder_config,
        )

        result = await crew.kickoff_async()
        # result = crew.kickoff()
        return result


trip_crew = TripCrew(
    origin="San Francisco, California",
    cities="Tokyo, Japan",
    date_range="Dec 12 - Dec 20, 2025",
    interests="sports, technology, and local cuisine",
    llm=databricks_llm,
)

import asyncio
asyncio.run(trip_crew.run())
