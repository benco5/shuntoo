params = {
          "utf8"=>"✓",
          "authenticity_token"=>"gzrQQN301ElAiD3bvAsByHurZ2vsXCgLRbZL14zaSBY=",
          "response"=>{
            "responses"=>[
              {"pip"=>"0"},
              {"pip"=>"1", "response"=>"#<Response:0x0000010936aa60>", "choice_id"=>"42"},
              {"pip"=>"0", "response"=>"#<Response:0x000001026e2488>", "choice_id"=>"43"},
              {"pip"=>"0", "response"=>"#<Response:0x000001026e01b0>", "choice_id"=>"44"},
              {"pip"=>"0"},
              {"pip"=>"1", "response"=>"#<Response:0x00000106e95ed8>", "choice_id"=>"45"}
            ]
          }, 
          "commit"=>"Submit"
        }


params_box = []

if params["response"]["responses"]
  p = params
  h = params["response"]["responses"]
  h.each do |response|
    p["response"] = response
    unless params["response"]["choice_id"].nil?
      params_box << params
    end
  end
end

puts params_box