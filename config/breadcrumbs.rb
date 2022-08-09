crumb :admin_root do
  link "管理者トップページ", admin_root_path
end

crumb :admin_search do
  link "検索結果", admin_search_path
  parent :admin_root
end

crumb :admin_article_index do
  link "記事一覧", admin_articles_path
  parent :admin_root
end

crumb :admin_article_show do
  link "記事詳細", admin_article_path(@admin)
  parent :admin_article_index
end

crumb :admin_user_index do
  link "会員一覧", admin_users_path
  parent :admin_root
end

crumb :admin_user_show do
  link "会員詳細", admin_user_path(@user)
  parent :admin_users_path
end

crumb :admin_category_index do
  link "カテゴリー一覧", admin_categories_path
  parent :admin_root
end

crumb :admin_category_show do
  link "カテゴリー詳細", admin_category_path(@category)
  parent :admin_category_index
end

crumb :admin_tag_index do
  link "タグ一覧", admin_tags_path
  parent :admin_root
end

crumb :admin_tag_show do
  link "タグ詳細", admin_tag_path(@tag)
  parent :admin_tag_index
end

crumb :root do
  link "トップページ", root_path
end




# crumb : do
#   link "",
#   parent :
# end
# crumb :projects do
#   link "Projects", projects_path
# end

# crumb :project do |project|
#   link project.name, project_path(project)
#   parent :projects
# end

# crumb :project_issues do |project|
#   link "Issues", project_issues_path(project)
#   parent :project, project
# end

# crumb :issue do |issue|
#   link issue.title, issue_path(issue)
#   parent :project_issues, issue.project
# end

# If you want to split your breadcrumbs configuration over multiple files, you
# can create a folder named `config/breadcrumbs` and put your configuration
# files there. All *.rb files (e.g. `frontend.rb` or `products.rb`) in that
# folder are loaded and reloaded automatically when you change them, just like
# this file (`config/breadcrumbs.rb`).