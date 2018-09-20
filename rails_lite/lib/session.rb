require 'json'

class Session
  attr_reader :session
  
  # find the cookie for this app
  # deserialize the cookie into a hash
  def initialize(req)
    my_cookie = req.cookies['_rails_lite_app']
    if my_cookie 
      @session = JSON.parse(my_cookie)
    else 
      @session = { }
    end
  end

  def [](key)
    @session[key]
  end

  def []=(key, val)
    @session[key] = val
  end

  # serialize the hash into json and save in a cookie
  # add to the responses cookies
  def store_session(res)
    res.set_cookie('_rails_lite_app', { path: '/', value: @session.to_json })
  end
end
