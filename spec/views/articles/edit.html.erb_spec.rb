require 'spec_helper'

describe "articles/edit" do
  before(:each) do
    @article = assign(:article, stub_model(Article,
      :title => "MyString",
      :content => "MyString",
      :category => "MyString",
      :status => "MyString"
    ))
  end

  it "renders the edit article form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", article_path(@article), "post" do
      assert_select "input#article_title[name=?]", "article[title]"
      assert_select "input#article_content[name=?]", "article[content]"
      assert_select "input#article_category[name=?]", "article[category]"
      assert_select "input#article_status[name=?]", "article[status]"
    end
  end
end
