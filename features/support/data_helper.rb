# Maps data to environment
end

  def big_commerce
    environment = "#{ENV['E2E']}"
    case environment
      when "Comm"
        "https://login.bigcommerce.com"
      else
    end
  end

def big_store
  environment = "#{ENV['E2E']}"
  case environment
    when "Comm"
      "http://ravi.mybigcommerce.com/"
    else
  end
end
World(DataHelpers)
