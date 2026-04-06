function konkat --description 'Concatenate all source files in a directory into one text file'
    if test -z "$argv"
        echo "Usage: konkat <path>"
        return 1
    end

    set -l input_path $argv[1]

    # Make absolute path
    if not string match -q "/*" $input_path
        set input_path (pwd)/$input_path
    end

    echo "Absolute input path: $input_path"

    set -l dir_name (basename $input_path)
    echo "DIR_NAME: $dir_name"

    set -l output_file {$dir_name}_concatenated_files.txt

    truncate -s 0 $output_file

    echo "Finding all files recursively in the specified directory..."

    find $input_path -type f \( \
        -name "*.ts" -o -name "*.properties" -o -name "*.xml" -o \
        -name "*.js" -o -name "*.json" -o -name "*.yaml" -o \
        -name "*.go" -o -name "dockerfile" -o -name "*.yml" -o \
        -name "*.html" -o -name "*.txt" -o -name "*.py" -o -name "*.sh" \
    \) | while read -l file
        echo "### File: $file" >> $output_file
        echo "" >> $output_file
        cat $file >> $output_file
        echo "" >> $output_file
    end

    echo "Concatenation completed. Output saved to $output_file."
end
