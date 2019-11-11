require 'minitest/autorun'
require 'codefuckery'

describe Codefuckery::Counter do
    describe "when directory does not exist" do
        it "must return nil" do
            File.stub :exists?, false do
                assert_nil Codefuckery::Counter.count('dir', [], [], false)
            end
        end
    end

    describe "when directory is not a directory" do
        it "must return nil" do
            File.stub :directory?, false do
                assert_nil Codefuckery::Counter.count('dir', [], [], false)
            end
        end
    end

    describe "given a list of file types" do
        it "should only count the matching files" do
            Dir.stub :glob, ['file1.x', 'file2.y', 'file3.z'] do
                assert_equal ['file1.x', 'file2.y'],
                    Codefuckery::Counter.create_paths('dir', ['.x', '.y'], false)
            end
        end
    end

    describe "given a file with two occurences of poop" do
        it "should return a count of 2 for the word poop" do
            word_counts = {'poop' => 0}

            File.stub :read, "this test is poop poop" do
                Codefuckery::Counter.count_in_file('file', ['poop'], word_counts)
                assert_equal 2, word_counts['poop']
            end
        end
    end

    describe "given an existing word count" do
        it "should increase the count" do
            word_counts = {'poop' => 1}

            File.stub :read, "this test is poop poop" do
                Codefuckery::Counter.count_in_file('file', ['poop'], word_counts)
                assert_equal 3, word_counts['poop']
            end
        end
    end

    describe "given a word is a regex" do
        it "should find all matching occurences" do
            word_counts = {'poo+p' => 0}

            File.stub :read, "this test is poop poooop" do
                Codefuckery::Counter.count_in_file('file', ['poo+p'], word_counts)
                assert_equal 2, word_counts['poo+p']
            end
        end
    end
end