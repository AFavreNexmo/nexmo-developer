module BuildingBlockRenderer
    class Php
        def self.dependencies(deps)
            {'code' => "$ composer require #{deps.join(' ')}"}
        end

        def self.run_command(command, filename)
            <<~HEREDOC
        ## Run your code

        Save this file to your machine and run it:

        <pre class="highlight bash"><code>$ #{command}</code></pre>

            HEREDOC

        end
    end
end
