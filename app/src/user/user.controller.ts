import { Controller, Logger } from '@nestjs/common';
import { GrpcMethod } from '@nestjs/microservices';
import { SignUpRequestInterface } from './interfaces/sign-up-request.interface';
import { SignedUpResponseInterface } from "./interfaces/signed-up-response.interface";
import {UserService} from "./user.service";

const logger = new Logger('UserController');
@Controller()
export class UserController {

  constructor(private userService: UserService) {}

  @GrpcMethod('UserService')
  signUp(data: SignUpRequestInterface): SignedUpResponseInterface {
    logger.log("SignUpRequestInterface Controller");
    logger.log(data);
    return this.userService.signUp(data);
  }
}