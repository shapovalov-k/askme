class UsersController < ApplicationController
  def index

    @users = [
        User.new(
                id: 1,
                name: 'Koko',
                username: 'kokosha',
                avatar_url: 'https://cdn.iconscout.com/icon/free/png-256/avatar-375-456327.png'
        ),
        User.new(id: 2, name: 'Ivan', username: 'vancho')
    ]
  end

  def new
  end

  def edit
  end

  def show
    @user = User.new(
    name: 'Koko',
    username: 'kokosha',
    avatar_url: 'https://cdn.iconscout.com/icon/free/png-256/avatar-375-456327.png'
    )

    @questions = [
        Question.new(text: 'Как дела?', created_at: Date.parse('06.12.2018')),
        Question.new(text: 'Чего такой хмурый?', created_at: Date.parse('06.12.2018')),
    ]

    @new_question = Question.new
  end
end
