require 'spec_helper'

describe "articles/new" do
  before(:each) do
    assign(:article, stub_model(Article,
      :title => "MyString",
      :content => "MyString",
      :category => "MyString",
      :status => "MyString"
    ).as_new_record)
  end

  it "renders new article form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", articles_path, "post" do
      assert_select "input#article_title[name=?]", "article[title]"
      assert_select "input#article_content[name=?]", "article[content]"
      assert_select "input#article_category[name=?]", "article[category]"
      assert_select "input#article_status[name=?]", "article[status]"
    end
  end
end
