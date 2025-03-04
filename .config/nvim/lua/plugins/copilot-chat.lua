-- Constants
local PROMPT_PATH = "/prompts/"

---Reads and validates a prompt file from the config directory
---@param filename string The name of the prompt file to read
---@return string|nil content The contents of the prompt file
---@return string|nil error Error message if reading fails
local function read_prompt_file(filename)
  if type(filename) ~= "string" then
    return nil, "Invalid filename type"
  end

  local file_path = vim.fn.stdpath("config") .. PROMPT_PATH .. filename
  local file, err = io.open(file_path, "r")

  if not file then
    vim.notify("Failed to load prompt file: " .. filename, vim.log.levels.WARN)
    return nil, err
  end

  local content = file:read("*all")
  file:close()

  if not content or content == "" then
    return nil, "Empty prompt file"
  end

  -- Trim whitespace and return
  return content:gsub("^%s+", ""):gsub("%s+$", "")
end

return {
  "CopilotC-Nvim/CopilotChat.nvim",
  lazy = false,
  opts = {
    system_prompt = read_prompt_file("core.xml"),
    model = "claude-3.7-sonnet",
    -- context = { "buffer", "buffers", "file", "files", "files:list", "files:full", "git" },
    insert_at_end = true, -- Automatically enter insert mode when opening window and on new prompt
    highlight_headers = false,
    separator = "---",
    error_header = "> [!ERROR] Error",
    -- TODO: Move prompts to a separate file?
    prompts = {
      -- NOTE: Some of the prompts seem to be too verbose
      Academic = { system_prompt = read_prompt_file("academic.xml") },
      Coding = { system_prompt = read_prompt_file("coding.xml") },
      Mentor = { system_prompt = read_prompt_file("mentor.xml") },
      Professor = { system_prompt = read_prompt_file("professor.xml") },
      Writer = { system_prompt = read_prompt_file("writer.xml") },
      -- TODO: Add context to prompts
      BetterNamings = {
        prompt = "> /Coding\n\nPlease provide better names for the following variables and functions.",
        mapping = "<leader>acb",
        description = "Better Namings",
      },
      ExplainError = {
        prompt = "> /Coding\n> /Mentor\n\nPlease explain the error and provide a solution.",
        mapping = "<leader>ach",
        description = "Get Help with Error",
      },
      Refactor = {
        prompt = "> /Coding\n\nPlease refactor the following code to improve its clarity and readability.",
        mapping = "<leader>acr",
        description = "Refactor",
      },
      MakeConscise = {
        prompt = "> /Writer\n\nRewrite the following text to make it more concise.",
        mapping = "<leader>awc",
        description = "Make Conscise",
      },
      Summarize = {
        prompt = "> /Writer\n\nSummarize the following text.",
        mapping = "<leader>aws",
        description = "Summarize",
      },
      SpellCheck = {
        prompt = "> /Writer\n\nCheck the spelling and grammar of the following text.",
        mapping = "<leader>awz",
        description = "Spell Check",
      },
      Wording = {
        prompt = "> /Writer\n\nPlease improve the grammar and wording of the following text.",
        mapping = "<leader>aww",
        description = "Wording",
      },
    },
  },
  keys = {
    -- Unset default keybinding to reset copilot chat
    { "<leader>ax", false },
    { "<leader>ax", "<cmd>CopilotChatStop<cr>", desc = "Stop Current Output (CopilotChat)", mode = { "n", "v" } },

    -- GROUP: Prompt group for writing text (not code)
    { "<leader>aw", "", desc = "+Writting Prompts (CopilotChat)", mode = { "n", "v" } },

    -- GROUP: Code related commands for the default prompts
    { "<leader>ac", "", desc = "+Code Prompts (CopilotChat)", mode = { "n", "v" } },
    { "<leader>ace", "<cmd>CopilotChatExplain<cr>", desc = "Explain code" },
    { "<leader>acr", "<cmd>CopilotChatReview<cr>", desc = "Review code" },
    { "<leader>acf", "<cmd>CopilotChatFix<cr>", desc = "Fix Code" },
    { "<leader>aco", "<cmd>CopilotChatOptimize<cr>", desc = "Optimize Performance and Readability" },
    { "<leader>acd", "<cmd>CopilotChatDocs<cr>", desc = "Add Documentation Comments" },
    { "<leader>act", "<cmd>CopilotChatTests<cr>", desc = "Generate Tests" },
    { "<leader>acm", "<cmd>CopilotChatCommit<cr>", desc = "Generate Commit Message" },

    -- GROUP: Copilot Chat Setup
    { "<leader>as", "", desc = "+Setup (CopilotChat)", mode = { "n", "v" } },
    -- Copilot Chat Models
    { "<leader>asm", "<cmd>CopilotChatModels<cr>", desc = "Select Model (CopilotChat)", mode = { "n", "v" } },
    -- Copilot Chat Agents
    { "<leader>asa", "<cmd>CopilotChatAgents<cr>", desc = "Select Agent (CopilotChat)", mode = { "n", "v" } },
    {
      "<leader>asc",
      function()
        local model = "claude-3.7-sonnet"
        require("CopilotChat").config.model = model
        vim.notify("CopilotChat model set to: " .. model, vim.log.levels.INFO)
      end,
      desc = "Use Claude (CopilotChat)",
      mode = { "n", "v" },
    },
    {
      "<leader>asg",
      function()
        local model = "gpt-4o"
        require("CopilotChat").config.model = model
        vim.notify("CopilotChat model set to: " .. model, vim.log.levels.INFO)
      end,
      desc = "Use gpt-4o (CopilotChat)",
      mode = { "n", "v" },
    },

    -- Clear buffer and chat history
    {
      "<leader>al",
      function()
        require("CopilotChat").reset()
        vim.notify("CopilotChat has been reset", vim.log.levels.INFO)
      end,
      desc = "Clear (CopilotChat)",
      mode = { "n", "v" },
    },

    -- Unset existing prompt picker keybinding
    { "<leader>ap", false },
    -- Pick a prompt
    {
      "<leader>ap",
      function()
        local actions = require("CopilotChat.actions")
        require("CopilotChat.integrations.snacks").pick(actions.prompt_actions())
      end,
      desc = "Prompt Actions (CopilotChat)",
      mode = { "n", "v" },
    },

    -- Unset existing quick chat keybinding
    { "<leader>aq", false },
    -- Quick chat with Copilot (Include content of buffer)
    {
      "<leader>aq",
      function()
        local input = vim.fn.input("Quick Chat: ")
        if input ~= "" then
          require("CopilotChat").ask(input, {})
        end
      end,
      desc = "Quick Chat (CopilotChat)",
      mode = { "n", "v" },
    },

    -- Open Copilot Chat in a floating window
    {
      "<leader>af",
      function()
        require("CopilotChat").open({
          window = {
            layout = "float",
            width = 1,
            height = 0.4,
            relative = "cursor",
            border = "rounded",
          },
        })
      end,
      desc = "Toggle - Float (CopilotChat)",
      mode = { "n", "v" },
    },

    -- GROUP: Chat History
    { "<leader>ah", "", desc = "+History (CopilotChat)", mode = { "n", "v" } },
    {
      "<leader>ahs",
      function()
        local input = vim.fn.input("Save CopilotChat History as (name): ")
        if input ~= "" then
          require("CopilotChat").save(input)
        end
      end,
      desc = "Save History (CopilotChat)",
      mode = { "n", "v" },
    },
    {
      "<leader>ahl",
      function()
        local input = vim.fn.input("Load CopilotChat History (name): ")
        if input ~= "" then
          require("CopilotChat").load(input)
        end
      end,
      desc = "Load History (CopilotChat)",
      mode = { "n", "v" },
    },

    -- Ask the Perplexity agent a quick question
    {
      "<leader>aS",
      function()
        local input = vim.fn.input("Perplexity: ")
        if input ~= "" then
          require("CopilotChat").ask(input, {
            agent = "perplexityai",
            selection = false,
          })
        end
      end,
      desc = "Perplexity Search (CopilotChat)",
      mode = { "n", "v" },
    },
  },
}
