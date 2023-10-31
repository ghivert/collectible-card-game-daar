import express from 'express';

import routes from './routes';

class App {
  public server;

  constructor() {
    this.server = express();

    this.middlewares();
    this.routes();
  }

  middlewares() {
    this.server.use(express.json());
  }

  routes() {
    this.server.use(routes);
  }
}

console.log("Expressjs is running at {http://localhost:5657/}")
new App().server.listen(5657);