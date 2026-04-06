function ai-anthropic --description 'Generate and run a shell command using Anthropic Claude'
    if test -z "$ANTHROPIC_API_KEY"
        echo "Error: Please set ANTHROPIC_API_KEY environment variable"
        return 1
    end

    if not command -q jq
        echo "Installing jq for JSON parsing..."
        brew install jq
    end

    set -l request (string join " " $argv)

    set -l json (jq -n \
        --arg req $request \
        '{
            model: "claude-3-5-sonnet-20241022",
            max_tokens: 500,
            system: "You are a command line helper. Output ONLY the exact command to run, no explanation, no markdown, no backticks. If multiple commands are needed, separate with && or semicolons.",
            messages: [{
                role: "user",
                content: ("Generate only the shell command for this request, no explanation: " + $req)
            }]
        }')

    set -l response (curl -s https://api.anthropic.com/v1/messages \
        -H "content-type: application/json" \
        -H "x-api-key: $ANTHROPIC_API_KEY" \
        -H "anthropic-version: 2023-06-01" \
        -d $json)

    if echo $response | jq -e '.error' > /dev/null 2>&1
        echo "API Error: "(echo $response | jq -r '.error.message')
        return 1
    end

    set -l command (echo $response | jq -r '.content[0].text' 2>/dev/null)

    if test -z "$command" -o "$command" = null
        echo "Error: Could not parse response"
        return 1
    end

    echo ""
    echo (set_color cyan)"→ Command:"(set_color normal) $command
    echo ""

    read -n1 -l key -P "Run this command? (y/n/e to edit): "
    echo ""

    switch $key
        case y Y
            eval $command
        case e E
            read -l edited -P "Edit command: " -c $command
            eval $edited
        case '*'
            echo "Cancelled"
    end
end
