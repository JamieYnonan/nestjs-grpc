import { Injectable } from '@nestjs/common';
import {SignUpRequestInterface} from "./interfaces/sign-up-request.interface";
import {SignedUpResponseInterface} from "./interfaces/signed-up-response.interface";

@Injectable()
export class UserService {
  public signUp(data: SignUpRequestInterface): SignedUpResponseInterface {
    return {token: "tokenValue", expiresIn: 60};
  }
}