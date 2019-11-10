module Codefuckery
    class Counter
        def self.count(directory, filetypes, words, recursive)
            paths = create_paths(directory, filetypes, recursive)
            
            word_counts = {}
            words.each { |w| word_counts[w] = 0 }
            paths.each { |p| count_in_file(p, words, word_counts) }

            print_results(word_counts)
        end

        private
        def self.create_paths(directory, filetypes, recursive)
            expanded_directory = File.expand_path(directory)
            pattern = recursive ? '**/*' : '**'
            Dir["#{expanded_directory}/#{pattern}"].reject { |fn| 
                basename = File.basename(fn)
                if ['..', '.', '.git', '__MACOSX', '.DS_Store'].include? basename
                    return true
                end

                extension = File.extname(fn).strip.downcase
                should_reject = false
                if !filetypes.empty?
                    should_reject = extension.empty? || !(filetypes.include? extension)
                end

                should_reject
            }
        end

        # shit
        private
        def self.count_in_file(file, words, word_counts)
            data = File.read(file)            
            words.each { |w| word_counts[w] += data.scan(/#{w}/).count }
        end

        private
        def self.print_results(word_counts)
            word_counts.each { |word,count| puts "#{word}: #{count}" }
        end
    end
end
