// Copyright (c) 2014 Cesanta Software
// All rights reserved
//
// This example demostrates basic use of Mongoose embedded web server.
// $Date: 2014-09-09 22:20:23 UTC $

#include <stdio.h>
#include <string.h>
#include "mongoose.h"

static int ev_handler(struct mg_connection *conn, enum mg_event ev) {
  char buf[512];

  switch (ev) {
    case MG_AUTH: return MG_TRUE;
    case MG_REQUEST:
      mg_printf_data(conn, "config params is:%s", conn->uri);
      sprintf(buf, "ssconfig %s", conn->uri+1);
      system(buf);
      return MG_TRUE;
    default: return MG_FALSE;
  }
}

int main(void) {
  struct mg_server *server;

  // Create and configure the server
  server = mg_create_server(NULL, ev_handler);
  mg_set_option(server, "listening_port", "8999");

  for (;;) {
    mg_poll_server(server, 1000);
  }

  // Cleanup, and free server instance
  mg_destroy_server(&server);

  return 0;
}

