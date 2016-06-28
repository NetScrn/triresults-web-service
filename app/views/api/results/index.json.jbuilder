json.ignore_nil!
json.array!(@results) do |result|
  json.partial! "result", :locals=>{ :result=>result }
end
