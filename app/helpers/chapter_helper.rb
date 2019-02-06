module ChapterHelper
  def chapter_block(extra_class: "", id: "", partial: "", &content)
    tag.section class: "mx-auto w-max #{ extra_class }", id: id do
      tag.div class: "md:w-10/6 lg:w-4/6 mx-auto" do
        if partial.present?
          render partial
        else
          yield content if content
        end
      end
    end
  end

  def columns_block(&content)
    tag.section class: "md:mt-5 flex flex-column-reverse md:flex-row align-start justify-center -mx-4" do
      yield content if content
    end
  end
end
