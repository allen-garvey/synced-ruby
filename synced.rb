APP_NAME = 'Synced'
APP_VERSION = '1.0.0'

# removes trailing whitespace
# and escaped spaces
def clean_dir_input(dir_input)
	return dir_input.gsub(/[\n\s\t]*$/, '').gsub(/\\\s/, ' ')
end


introduction = <<EOF
##########################
#{APP_NAME} #{APP_VERSION}

#{APP_NAME} is a thin wrapper around rsync that allows you to keep the contents of two folders in sync.

EOF

puts introduction

puts "\nEnter source directory for backup"
source_dir = clean_dir_input(gets)

puts "\nEnter destination directory for backup"
destination_dir = clean_dir_input(gets)

# trailing slash on source directory used by rync so that folder with source
# not created in destination folder
if !(source_dir =~ /\/$/)
	source_dir += '/'
end

rsync_command = "rsync -a -p -u -v -v '#{source_dir}' '#{destination_dir}'"
puts "\n#{rsync_command} will be run."
puts "Are you sure you want to do this? (Y/N)"
confirm = gets.chomp
if !(confirm =~ /^y(es)?$/i)
	abort('Backup aborted')
else
	puts "\nStarting rsync ...\n\n"
	exec(rsync_command)
end


