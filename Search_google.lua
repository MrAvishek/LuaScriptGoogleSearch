-- Metadata
-- name = "Google Search Widget"
-- description = "Searches Google for the given query"
-- type = "widget"
-- author = "Avishek"
-- version = "1.0"

function search(query)
    local url = "https://www.google.com/search?q=" .. encodeURIComponent(query)
    
    -- Perform an HTTP GET request to Google search
    http:get(url, "google_search")
    
    -- Show loading message while waiting for the response
    ui:show_text("Loading...")
end

-- Callback function to handle search results
function on_network_result_google_search(result, code)
    if code == 200 then
        -- Parse the search results and display them
        -- For simplicity, let's just show the raw HTML content
        ui:show_text(result)
    else
        ui:show_toast("Failed to perform search. Error code: " .. code)
    end
end

-- Function to encode URI component
function encodeURIComponent(uri)
    return string.gsub(uri, "[^%w]", function(c)
        return string.format("%%%02X", string.byte(c))
    end)
end

-- Main function to initialize the widget
function on_widget_create()
    -- Create a search input field
    ui:show_edit_dialog("Enter your search query", "Search", "", "search")
end

-- Callback function to handle user input
function on_edit_dialog_positive(button_text, user_input)
    -- Check if the user provided a search query
    if button_text == "Search" and user_input ~= "" then
        -- Perform the search
        search(user_input)
    else
        ui:show_toast("Please enter a search query")
    end
end
