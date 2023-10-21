module ApplicationHelper

  def flash_class(type)
    case type
    when "notice" then "bg-blue-500 text-white p-3 rounded"
    when "success" then "bg-green-500 text-white p-3 rounded"
    when "danger" then "bg-red-500 text-white p-3 rounded"
    else "bg-gray-400 text-white p-3 rounded"
    end
  end
  
  def area_image_name(area_name)
    mapping = {
      "滋賀県" => "shiga",
      "京都府" => "kyoto",
      "大阪府" => "osaka",
      "兵庫県" => "hyogo",
      "奈良県" => "nara",
      "和歌山県" => "wakayama",
    }
    mapping[area_name]
  end
end
