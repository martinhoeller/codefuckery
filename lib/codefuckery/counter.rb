module Codefuckery
    class Counter
        def self.count(directory, filetypes, words, recursive)
            paths = create_paths(directory, filetypes, recursive)
            puts paths

            paths.each { |p|
                count_in_file(p, words)
            }
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

        private
        def self.count_in_file(file, words)
            puts "counting in file: #{file}"
        end
    end
end
