module ApplicationHelper
  
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

  def default_meta_tags
    {
      title: '関西、めっちゃええとこ。',
      reverse: true,
      charset: 'utf-8',
      description: '関西地域の情報共有・検索サービス',
      keywords: '関西,観光,グルメ',
      canonical: request.original_url,
      separator: '|',
      og: {
        site_name: :site,
        title: :title,
        description: :description,
        type: 'website',
        url: request.original_url,
        image: image_url('logo.png'),
        local: 'ja-JP'
      },
      twitter: {
        card: 'summary',
        site: '@huhn84u8',
        image: image_url('logo.png')
      }
    }
  end
end