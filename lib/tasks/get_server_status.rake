desc "Get Apex Legends Server status."
task :get_server_status => :environment do
  data_centers = YAML.load(File.read(Rails.root.join("config/content", "data_centers.yml")))

  puts "Starting server status update"

  data_centers.each do |data_center|
    response_time = 0

    begin
      Timeout.timeout(5) do
        start_time = Time.now

        check = Net::Ping::External.new(data_center["host"])

        if check.ping?
          end_time = Time.now
          response_time = Time.now - start_time
        else
          response_time = 0
        end
      end
    rescue => error
      puts "Server status check: #{ error }"
      response_time = 0
    end

    puts "#{ data_center["display"] }: #{ response_time }"

    @server_status = ServerStatus.find_by_host(data_center["host"])

    if @server_status.present?
      @server_status.update(response_time: response_time)
    else
      @new_entry = ServerStatus.new(display: data_center["display"], host: data_center["host"], group: data_center["name"], response_time: response_time)
      @new_entry.save
    end
  end

  puts "Server status update complete"
end
