class FavoriteMailer < ApplicationMailer
  default from: "sabrown84@gmail.com"

  def new_comment(user, post, comment)

    headers["Message-ID"] = "<comments/#{comment.id}@guarded-river-51347.example>"
    headers["In-Reply-To"] = "<post/#{post.id}@guarded-river-51347.example>"
    headers["References"] = "<post/#{post.id}@guarded-river-51347.example>"

    @user = user
    @post = post
    @comment = comment

    mail(to: user.email, subject: "New comment on #{post.title}")
  end
end
