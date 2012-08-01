class SimpleCover

	def initialize(welcome)
		@welcome = welcome
	end		

	def run
		puts "\n"
		puts @welcome, "\n"

		get_input
	end

	def get_input
		print "SimpleCover$ "
		input = gets.chomp
		choose_action(input)
	end

	def choose_action(input)
		exits = ["quit", "exit", "q"]
		if input == "get_covers all pwd"
			get_covers
		elsif exits.include? input
			puts "\n", "Thank you for using Simple Cover"
			exit(0)
		elsif input == "help"
			help
		else
			puts "Command not found"
			get_input
		end
	end

	def get_covers
		#@DATA_DIR = @input.split(' ')[-1]
		@DATA_DIR = `pwd`.chop
		Dir.open(@DATA_DIR).select {|x| x != "." and x != ".." }.each do |album|		
			next if action = ActionMan.new(album, @DATA_DIR).execute_download == "next"
		end
		puts "No more requests. Enjoy your covers."
		get_input
	end

	def help
		help_text = <<HELP
Change directory to the one with your music collection.
Type "get_covers all pwd" to download covers for all albums.
Type "get_covers scan pwd" to download covers for the albums that don't cover yet.
Type "q", "exit" or "quit" to exit Simple Cover 
HELP

		puts help_text, "\n"
		get_input
	end
end