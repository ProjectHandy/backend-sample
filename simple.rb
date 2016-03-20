require 'sinatra'
require 'json'
require 'open3'
def syscall(*cmd)
  begin
    stdout, stderr, status = Open3.capture3(*cmd)
    status.success? && stdout.slice!(0..-(1 + $/.size)) # strip trailing eol
  rescue
  end
end

set :port, 3001

post "/change" do
  request.body.rewind
  data = JSON.parse request.body.read
  syscall("./Calc " + data["amount"])
end

post "/" do 
  "Sorry, no clues here..."
end

post "/*" do
  '{"message":"404 error! try again","error":{"status":404}}'
end
