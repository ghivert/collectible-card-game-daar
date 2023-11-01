import express from 'express';

import {collection} from './collection/routes';
import {index} from './routes';
import cors from 'cors';

class App {
  public server;

  constructor() {
    this.server = express();

    this.middlewares();
    this.routes();
  }

  middlewares() {
    this.server.use(express.json());
    this.server.use(cors());
  }

  routes() {
    this.server.use("/collection", collection);
    this.server.use("/", index);
  }
}


new App().server.listen(5657, "localhost", () => {
  console.log("Expressjs is running at {http://localhost:5657/}")
});