Dir.glob("*").select { |e| FileTest.directory?(e) && !e.start_with?("_") }.each do |appname|
    Dir.chdir(appname) do
        if Dir.glob("icons/*.svg").size == 0
            warn "[W] No SVG icons for #{appname}"
        end
        
        if Dir.glob("apps/*.qtws").size == 0
            warn "[E] No QTWS app for #{appname}"
        end
        
        if Dir.glob("desktops/*.desktop").size == 0
            warn "[W] No desktop file for #{appname}"
        end
        
        unless FileTest.exist?("info.json")
            warn "[E] No info.json file for #{appname}"
        end
    end
end
