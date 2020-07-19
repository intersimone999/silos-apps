Dir.glob("*").select { |d| FileTest.directory?(d) }.each do |dir|
    `mkdir -p "#{dir}/apps"`
    `mkdir -p "#{dir}/icons"`
    `mkdir -p "#{dir}/desktops"`
    Dir.glob("#{dir}/*").each do |f|
        base = File.basename(f)
        if f.end_with? ".svg"
            `mv "#{f}" "#{dir}/icons/#{base}"`
        elsif f.end_with? ".qtws"
            `mv "#{f}" "#{dir}/apps/#{base}"`
        elsif f.end_with? ".desktop"
            `mv "#{f}" "#{dir}/desktops/#{base}"`
        end
    end
end
