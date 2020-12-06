require 'json'

FORCE = ARGV.delete("-f")
APPS = ARGV

def bump(appname)
    info_file = "#{appname}/info.json"
    infos = JSON.parse(File.read(info_file))
    
    previous_version = infos['version']
    major, minor = previous_version.split(".")
    minor = (minor.to_i + 1).to_s
    
    infos['version'] = "#{major}.#{minor}"
    
    save = false
    
    if FORCE
        save = true
    else
        puts "Bump #{appname} version (#{previous_version} -> #{infos['version']})? (y/N)"
        save = STDIN.gets.chomp.downcase.start_with?('y')
    end
    
    if save
        File.open(info_file, 'w') do |f|
            f.puts(JSON.pretty_generate(infos))
        end
        puts "Updated #{appname} version (#{previous_version} -> #{infos['version']})"
    else
        puts "Skipped #{appname}"
    end
end

apps = APPS
apps = Dir.glob("*").sort.select { |e| FileTest.directory?(e) && !e.start_with?("_") } if apps.size == 0

apps.each do |appname|
    bump(appname)
end
