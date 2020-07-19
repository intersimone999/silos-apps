require 'json'

template = File.read("Desktop.template")

Dir.glob("*").select { |e| FileTest.directory?(e) && !e.start_with?("_") }.each do |appname|
    info_content = JSON.parse(File.read("#{appname}/info.json"))
    Dir.glob("#{appname}/apps/*.qtws") do |qtws_app_path|
        qtws_content = JSON.parse(File.read(qtws_app_path))
        
        qtws_filename = File.basename(qtws_app_path).sub(".qtws", "")
        app_name      = qtws_content['name']
        app_desc      = info_content['desc']
        app_icon      = File.basename(qtws_content['icon']).sub(".svg", "").sub(".png", "").sub(".jpg", "")
        category      = info_content['category'] || "Internet"
        
        desktop = template.clone
        desktop.gsub!("{category}", category)
        desktop.gsub!("{qtws}", qtws_filename)
        desktop.gsub!("{name}", app_name)
        desktop.gsub!("{desc}", app_desc)
        desktop.gsub!("{icon}", app_icon)
        
        File.open("#{appname}/desktops/#{qtws_filename}.desktop", 'w') do |f|
            f.puts desktop
        end
    end
end
