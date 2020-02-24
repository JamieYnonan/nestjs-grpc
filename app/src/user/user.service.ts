import {Injectable, Logger} from '@nestjs/common';
import {SignUpRequestInterface} from "./interfaces/sign-up-request.interface";
import {SignedUpResponseInterface} from "./interfaces/signed-up-response.interface";

const logger = new Logger('UserService');
@Injectable()
export class UserService {
  public signUp(data: SignUpRequestInterface): SignedUpResponseInterface {
    logger.log("SignUpRequestInterface Service");
    logger.log(data);
    return {token: "tokenValue", expiresIn: 60};
  }
}