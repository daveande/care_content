FactoryGirl.define do
  factory :content_file do
    title 'Terms'
    description 'Sample text of CareContent Terms'
    word_file '/content_files/terms.docx'
    preview_text 'an example document'
  end
end
