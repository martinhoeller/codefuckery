module Codefuckery
    class Counter
        def self.count(directory, filetypes, words, recursive)
            if !File.exists?(directory)
                puts "ERROR: '#{directory}' does not exist"
                exit(-1)
            end

            if !File.directory?(directory)
                puts "ERROR: '#{directory}' is not a directory"
                exit(-1)
            end

            paths = create_paths(directory, filetypes, recursive)

            if words == nil || words.empty?
                words = Codefuckery::DEFAULT_WORDS
            end

            word_counts = {}
            words.each { |w| word_counts[w] = 0 }
            paths.each { |p| count_in_file(p, words, word_counts) }

            print_results(word_counts)
        end

        private
        def self.create_paths(directory, filetypes, recursive)
            expanded_directory = File.expand_path(directory)
            pattern = recursive ? '**/*' : '**'
            Dir["#{expanded_directory}/#{pattern}"].select { |fn| should_include(fn, filetypes) }
        end

        private
        def self.should_include(file, filetypes)
            basename = File.basename(file)
            if ['..', '.', '.git', '__MACOSX', '.DS_Store'].include? basename
                return false
            end

            if File.directory?(file)
                return false
            end

            extension = File.extname(file).strip.downcase
            should_include = true
            if !filetypes.empty?
                should_include = !extension.empty? && (filetypes.include? extension)
            end

            should_include
        end

        # shit
        private
        def self.count_in_file(file, words, word_counts)
            data = File.read(file).force_encoding("ISO-8859-1").encode("utf-8", replace: nil)
            words.each { |w| word_counts[w] += data.scan(/#{w}/).count }
        end

        private
        def self.print_results(word_counts)
            total_count = 0
            word_counts.each { |word,count|
                puts "  #{word}: #{count}"
                total_count += count
            }

            puts ""
            if total_count == 0
                puts "You have a wholesome codebase 🙏"
            else
                puts "Your code is a bit fucked up 💩"
            end
        end
    end
end
