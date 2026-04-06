function ai --description 'Generate and run a shell command using OpenAI GPT'
    if test -z "$OPENAI_API_KEY"
        echo "Error: Please set OPENAI_API_KEY environment variable"
        return 1
    end

    if not command -q jq
        echo "Installing jq for JSON parsing..."
        brew install jq
    end

    set -l request (string join " " $argv)
    set -l pwd_context (pwd)
    set -l dir_context (ls -la | head -20)

    set -l json (jq -n \
        --arg request $request \
        --arg pwd $pwd_context \
        --arg dir $dir_context \
        '{
            model: "gpt-4o-mini",
            temperature: 0.3,
            max_tokens: 500,
            messages: [
                {
                    role: "system",
                    content: ("You are a command line helper. Output ONLY the exact shell command to run, no explanation, no markdown, no backticks. The user is in directory: " + $pwd + "\n\nDirectory contents:\n" + $dir)
                },
                {
                    role: "user",
                    content: ("Generate only the shell command for this request: " + $request)
                }
            ]
        }')

    set -l response (curl -s https://api.openai.com/v1/chat/completions \
        -H "Content-Type: application/json" \
        -H "Authorization: Bearer $OPENAI_API_KEY" \
        -d $json)

    if echo $response | jq -e '.error' > /dev/null 2>&1
        echo "API Error: "(echo $response | jq -r '.error.message')
        return 1
    end

    set -l command (echo $response | jq -r '.choices[0].message.content' 2>/dev/null)

    if test -z "$command" -o "$command" = null
        echo "Error: Could not parse response"
        return 1
    end

    # Strip any backticks that slip through
    set command (echo $command | sed 's/^```.*//g' | sed 's/```$//g' | tr -d '`')

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
