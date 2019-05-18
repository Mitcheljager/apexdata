desc "Get Apex Legends Server status."
task :get_server_status => :environment do
  data_centers = YAML.load(File.read(Rails.root.join("config/content", "data_centers.yml")))

  puts "Starting server status update"

  data_centers.each do |data_center|
    response_time = 0

    uri = URI('https://urlxray.expeditedaddons.com')

    uri.query = URI.encode_www_form({
    	api_key: "4EQ48N29FO2AHRSV86167C0IMGD3P5BJY5W0TUL179ZK3X",
    	url: data_center["host"],
    	fetch_content: false
    })

    result = JSON.parse(Net::HTTP.get_response(uri).body)
    puts result["http_status"]

    save_response_time(data_center, result["load_time"])
  end

  puts "Server status update complete"
end

def save_response_time(data_center, response_time)
  @server_status = ServerStatus.find_by_host(data_center["host"])

  if @server_status.present?
    @server_status.update(response_time: response_time)
  else
    @new_entry = ServerStatus.new(display: data_center["display"], host: data_center["host"], group: data_center["name"], response_time: response_time)
    @new_entry.save
  end
end
