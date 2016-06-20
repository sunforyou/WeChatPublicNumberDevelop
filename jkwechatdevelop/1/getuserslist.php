<?php
/**
 * Created by PhpStorm.
 * User: sun
 * Date: 16/6/11
 * Time: 下午6:19
 */

require_once "gettoken.php";

/** 获取url */
$appid = "";
$secret = "";
/** 因为tokenurl的获取是GET请求方式，因保护隐私的需要，这里已将appid和secret给删去了 */
$tokenurl = "https://api.weixin.qq.com/cgi-bin/token?grant_type=client_credential&appid=".$appid."&secret=".$secret."";

/** 获取access_token */
$output = gettoken($tokenurl);
$token = $output['access_token'];

/** 获取用户openid */
$userurl = "https://api.weixin.qq.com/cgi-bin/user/get?access_token=".$token."";
$userouput = gettoken($userurl);
$userarr = (array)$userouput['data'];

/** 获取用户头像url */
foreach ($userarr['openid'] as $value) {
    $infourl = "https://api.weixin.qq.com/cgi-bin/user/info?access_token=".$token."&openid=".$value."&lang=zh_CN ";
    $userinfo = gettoken($infourl);
    print_r($userinfo['headimgurl']."%");
}
