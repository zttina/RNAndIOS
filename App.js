/**
 * Sample React Native App
 * https://github.com/facebook/react-native
 *
 * @format
 * @flow
 */

import React, {Component} from 'react';
import {
  Platform,
  StyleSheet,
  Text,
  View,
  NativeModules,
  NativeEventEmitter,
  TouchableOpacity,
  Button,
} from 'react-native';

// const instructions = Platform.select({
//   ios: 'Press Cmd+R to reload,\n' + 'Cmd+D or shake for dev menu',
//   android:
//     'Double tap R on your keyboard to reload,\n' +
//     'Shake or press menu button for dev menu',
// });

export default class App extends Component<Props> {
  constructor(props) {
    super(props);
    this.state = {

    }

  }

  componentDidMount() {
    //监听
    let eventEmitter = new NativeEventEmitter(NativeModules.RCExport);
    this.listener = eventEmitter.addListener("nativeToRN", (result) => {

      this.setState({
        //此处赋值
        IOSInfo:result
      })
    })
  }
  componentWillUnmount() {
    //移除监听
    this.listener && this.listener.remove();
  }
  //通知iOS
  informIOS (eventName,propertyDic) {
    NativeModules.RTModule.addEventName(eventName,propertyDic,(error,event) => {

      alert(error)
    })
  }

  render() {

    return (
      <View style={styles.container}>
        {/*接收从iOS传过来的值*/}
        <View style={{marginLeft: 15,marginRight: 15,marginTop: 120}}>
          <Text style={{textAlign: 'center',fontSize: 18}}>{this.state.IOSInfo == null?'默认值':this.state.IOSInfo.name}</Text>
        </View>
        <View style={{marginLeft: 15,marginRight: 15,marginTop: 20}}>
          <Button title={'跳iOS页面无参'} onPress={() => this.informIOS('RNToIOS',null)}/>
          <Button title={'跳iOS页面有参'} onPress={() => this.informIOS('RNToIOS',{'fromRN':'RN跳iOS传的参'})}/>
        </View>
      </View>
    );
  }
}

const styles = StyleSheet.create({
  container:{
    display: 'flex',
    flex: 1,
    backgroundColor:"white"
  }
});
