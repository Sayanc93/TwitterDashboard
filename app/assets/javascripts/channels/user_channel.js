if (App.cable) {
  App.user_channel = App.cable.subscriptions.create({
    channel: "UserChannel",
    user: gon.current_user
  }, {
    connected: function() {
      console.log('connected');
      // Called when the subscription is ready for use on the server
    },

    disconnected: function() {
      // Called when the subscription has been terminated by the server
    },

    received: function(data) {
      console.log(data);
      if (data) {
        console.log('asa');
        window.location.reload();
      }
    }
  });
}
