package com.chakra.sms

import com.chakra.notifications.Notification

class SmsController {

    def index() { }
	
	def sendSms() {
		
		def notificationList = Notification.findAllByNotifDisplayAndNotifType(true, "SMS")
		log.debug'notificationList '+notificationList
		
		notificationList.each { notification ->
			
			String data = "";
			       
					String message=java.net.URLEncoder.encode(notification.notifMsg, "UTF-8");
					data += "?user=raghu4700@gmail.com:raghu4700"; // your loginId
					data += "&senderID=chakra"
					data += "&receipientno="+notification.phoneNumber
					data += "&msgtxt="+message
					log.debug'data '+data
					URL url = new URL("http://api.mVaayoo.com/mvaayooapi/MessageCompose" + data);
					HttpURLConnection conn = (HttpURLConnection)url.openConnection();
					conn.setRequestMethod("GET");
					conn.setDoOutput(true);
					conn.setDoInput(true);
					conn.setUseCaches(false);
					conn.connect();
					BufferedReader rd = new BufferedReader(new    InputStreamReader(conn.getInputStream()));
					String line;
					StringBuffer buffer = new StringBuffer();
					while ((line = rd.readLine()) != null){
					buffer.append(line).append("\n");
					}
					System.out.println(buffer.toString());
					rd.close();
					conn.disconnect();
										
					def notificationInstance = Notification.get(notification.id)
					if (!notificationInstance.save(flush: true)) {
						notificationInstance.errors.each {
							log.error it
						}
						notificationInstance.notifDisplay = false
						println'notifDisplay '+notificationInstance.notifDisplay
					}
					
					
		}
		
	}
}
