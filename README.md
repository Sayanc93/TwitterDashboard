## Twitter Dashboard

**Rails version**: *5.1.3*

**Ruby version**: *2.3.1p112*

***Tools used***:

**twitter + tweetstream**: *login and streming api*

**ActionCable**: *To broadcast tweet counts in asynchronously in realtime*

**sidekiq + redis + parallel**: *To handle tracking job as background process in threads*

*Note*: You'll need to run *Sidekiq* and *Redis server* alongwith *Rails server*. Also, you'll need to replace .env.sample file with .env with twitter oauth keys for omniauth to work.
