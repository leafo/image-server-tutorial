
local secret = "hello_world"

local function calculate_signature(str)
  return ngx.encode_base64(ngx.hmac_sha1(secret, str))
    :gsub("[+/=]", {["+"] = "-", ["/"] = "_", ["="] = ","})
    :sub(1,12)
end

local uri = ngx.var.request_uri
local path = uri:match("/gen/([^?]+)")

ngx.header["Content-type"] = "text/html"

ngx.say(calculate_signature(path) .. "/" .. path)

