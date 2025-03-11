 require "sinatra"
 require "sinatra/reloader"
 require "dotenv/load"
 require "http"
 require "json"

get("/") do
  apik = ENV.fetch("EXR")
  baseurl = "https://api.exchangerate.host/list?access_key=#{apik}"

  urlraw = HTTP.get(baseurl)
  urljson = JSON.parse(urlraw)

  r1 = urljson["currencies"]
  @r2 = r1.keys

  erb(:homepage)
end

get("/:ccode") do
  @country_code = params.fetch("ccode")
  apik = ENV.fetch("EXR")
  baseurl = "https://api.exchangerate.host/list?access_key=#{apik}"

  urlraw = HTTP.get(baseurl)
  urljson = JSON.parse(urlraw)

  r1 = urljson["currencies"]
  @r2 = r1.keys

  erb(:ccode)

end

get("/:ccode/:ccode_b") do
  @country_code = params.fetch("ccode")
  @country_code_b = params.fetch("ccode_b")
  apik = ENV.fetch("EXR")
  baseurl = "https://api.exchangerate.host/convert?from=#{@country_code}&to=#{@country_code_b}&amount=1&access_key=#{apik}"

  urlraw = HTTP.get(baseurl)
  urljson = JSON.parse(urlraw)

  @exrate = urljson["result"]

  erb(:conversion)
end
