clear;
rootkey = '0000000000';
rootkey64 = '00000000';
message = 'hellolinhabcdehef';
[~,length] = size(message);
datas = encryptPresent(message,rootkey,rootkey64);
data_out = decryptPresent(datas, rootkey, rootkey64, length);