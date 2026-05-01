source("renv/activate.R")

# --- Make this R session discoverable by Claude Code via MCP ---
if (interactive() && requireNamespace("btw", quietly = TRUE)) {
  try(btw::btw_mcp_session(), silent = TRUE)
}
