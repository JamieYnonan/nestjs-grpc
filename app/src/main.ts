import {NestFactory} from '@nestjs/core';

import {Logger} from "@nestjs/common";
import {Transport} from "@nestjs/common/enums/transport.enum";
import {join} from 'path';
import {UserModule} from "./user/user.module";

const logger = new Logger('Main');
async function bootstrap() {
  const app = await NestFactory.createMicroservice(UserModule, {
    transport: Transport.GRPC,
    options: {
      url: '127.0.0.1:5000',
      package: 'user',
      protoPath: [
          join(__dirname, './user/protos/services.proto')
      ]
    }
  });
  app.listen(() => {
    logger.log('Microservice is listening...');
  });
}
bootstrap();
