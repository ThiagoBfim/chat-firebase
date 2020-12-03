import 'package:chat_online/app/domain/message.dart';
import 'package:chat_online/app/domain/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

import '../../app_controller.dart';
import '../../app_module.dart';

part 'chat_controller.g.dart';

@Injectable()
class ChatController = _ChatControllerBase with _$ChatController;

abstract class _ChatControllerBase with Store {
  AppController _appController = AppModule.to.get<AppController>();

  TextEditingController messageTextController = TextEditingController(text: '');

  @observable
  List<Message> messages = ObservableList<Message>();

  User user() => _appController.user;

  @action
  _removeMessage(Message message){
    messages.remove(message);
  }

  @action
  _addMessage(Message message){
    messages.add(message);
  }

  sendMessage(){
    if(messageTextController.text.isNotEmpty) {
      var message = Message(
          "0", user(), DateTime.now(), messageTextController.text);
      _addMessage(message);
      messageTextController.clear();
    }
  }

  removeMessage(Message message){
    _removeMessage(message);
  }
}
