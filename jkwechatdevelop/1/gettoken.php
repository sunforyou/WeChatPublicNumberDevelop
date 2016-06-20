<?php
/**
 * Created by PhpStorm.
 * User: sun
 * Date: 16/6/11
 * Time: 下午5:30
 */

/** 从指定的url中下载json数据并解码成数组 */
function gettoken($url)
{
    /** 从url中下载token */
    $ch = curl_init();
    curl_setopt($ch, CURLOPT_URL, $url);
    curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
    curl_setopt($ch, CURLOPT_HEADER, 0);
    curl_setopt($ch, CURLOPT_USERAGENT, "Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:47.0) Gecko/20100101 Firefox/47.0");
    curl_setopt($ch, CURLOPT_ENCODING, 'gzip');
    curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);
    $output = curl_exec($ch);
    curl_close($ch);
    $token = (array)json_decode($output);
    return $token;
}
