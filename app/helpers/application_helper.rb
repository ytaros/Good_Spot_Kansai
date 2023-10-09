module ApplicationHelper

  def flash_class(type)
    case type
    when "notice" then "bg-blue-500 text-white p-3 rounded"
    when "success" then "bg-green-500 text-white p-3 rounded"
    when "danger" then "bg-red-500 text-white p-3 rounded"
    else "bg-gray-400 text-white p-3 rounded"
    end
  end
end
