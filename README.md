## Twitter Dashboard

**Rails version**: *5.1.3*

**Ruby version**: *2.3.1p112*

***Tools used***:

**twitter**: *authentication and data*

**ActionCable**: *To reload page when new data is available*

**sidekiq + redis**: *To handle tracking job as background process in threads*

*Note*: You'll need to run *Sidekiq* and *Redis server* alongwith *Rails server*. Also, you'll need to replace .env.sample file with .env with twitter oauth keys for omniauth to work.
