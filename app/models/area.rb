class Area < ApplicationRecord
    has_many :cities

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
