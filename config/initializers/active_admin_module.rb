# module ActiveAdmin

#   module Views
#     class TableFor
#       def bool_column(attribute)
#         column(attribute, {:sortable => attribute} ){ |model| model[attribute] ? '&#x2714;'.html_safe : '&#x2717;'.html_safe }
#       end
#       def thumb_column(attribute)
#         column(attribute){ |model| model.send(attribute).nil? ? nil  : image_tag(model.send(attribute).thumb('100x100').url) }
#       end
#     end
#     class AttributesTable
#       def bool_row(attribute)
#         row(attribute){ |model| model[attribute] ? '&#x2714;'.html_safe : '&#x2717;'.html_safe }
#       end
#       def thumb_row(attribute)
#         row(attribute){ |model| model.send(attribute).nil? ? nil  : image_tag(model.send(attribute).thumb('200x200').url) }
#       end
#     end
#   end

#   module Inputs

#     class ImageInput < ::Formtastic::Inputs::FileInput
#       def hint_html
#         image = @object.send @method
#         unless image.nil?
#           image_t = @template.image_tag(image.thumb('100x100').url) rescue ""
#           unless image_t.blank?
#             res = @template.content_tag(:a, image_t, {:href => image.url, :target => '_blank'})
#             name = "remove_#{@method}"
#             res << @builder.input(name, {:as => :boolean, :label => 'Удалить фото?'})
#           end
#         end
#       end
#     end

#     class CkeditorInput < ::Formtastic::Inputs::TextInput
#       def input_html_options
#         super.tap do |options|
#           options[:input_html] = { :ckeditor => default_ckeditor_params}
#         end
#       end

#       private
#         def default_ckeditor_params
#           {
#             :language => 'ru',
#             :toolbar => [
#               ['Source'], ['Bold', 'Italic', 'Underline'],
#               ['NumberedList', 'BulletedList'],
#               ['JustifyLeft','JustifyCenter','JustifyRight','JustifyBlock'],
#               ['Link', 'Unlink'],
#               ['Table', 'Image', 'Iframe', 'PageBreak'],
#               ['Format','Font', 'FontSize'], ['TextColor','BGColor' ],
#               ['Youtube']
#             ]
#           }
#         end
#     end
#   end
# end