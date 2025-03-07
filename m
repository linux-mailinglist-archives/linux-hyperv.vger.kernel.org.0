Return-Path: <linux-hyperv+bounces-4264-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B5E6A55FBC
	for <lists+linux-hyperv@lfdr.de>; Fri,  7 Mar 2025 06:02:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2FE25172823
	for <lists+linux-hyperv@lfdr.de>; Fri,  7 Mar 2025 05:02:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADF6B12EBE7;
	Fri,  7 Mar 2025 05:02:32 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from cosmicgizmosystems.com (cosmicgizmosystems.com [63.249.102.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B58981C27;
	Fri,  7 Mar 2025 05:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=63.249.102.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741323752; cv=none; b=Kn/Ennbvl+D2aZvj23sXSro2bjP6yFT2JKLiYuuXmey8GWN3mOC0QNHoGDSwrwYpT9rnnogxfqFDk8fdKg7aBgxeZgNnmv/G0sMVqYMg3u1nFLxBSAsT/yl7Uk8QvOC497y4vreCACaMdGVfqLsAR1UOouhhzui+D5ukMhjq7G4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741323752; c=relaxed/simple;
	bh=Zo3xPSerTkoI1tokLWdOrJC6QxrtBXMex6Fy9lgq5xk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SXclrp6WVSuECHlimpSq9Md6s9KkwwPlqa7g94bNaFxc9dLn4zwSpWTjxsMyJeAo5dks5Z4qRkjof6wIqwO9iVvgwlNSau1gpirB3VYWuptCjrqvyf1HOJat5ikUmIXv3ysCxS3IjrPA9HKQ4e/zqVXb1pnsBM+Adw4q7Sh8KQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cosmicgizmosystems.com; spf=pass smtp.mailfrom=cosmicgizmosystems.com; arc=none smtp.client-ip=63.249.102.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cosmicgizmosystems.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cosmicgizmosystems.com
Received: from terrys-Precision-M4600.hsd1.wa.comcast.net (c-71-63-147-217.hsd1.wa.comcast.net [71.63.147.217])
	by host11.cruzio.com (Postfix) with ESMTPSA id 8A4B2274BD23;
	Thu,  6 Mar 2025 20:56:06 -0800 (PST)
From: Terry Junge <linuxhid@cosmicgizmosystems.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Terry Junge <linuxhid@cosmicgizmosystems.com>,
	Nikita Zhandarovich <n.zhandarovich@fintech.ru>,
	Alan Stern <stern@rowland.harvard.edu>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-input@vger.kernel.org,
	linux-usb@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	syzkaller-bugs@googlegroups.com,
	lvc-project@linuxtesting.org,
	syzbot+c52569baf0c843f35495@syzkaller.appspotmail.com,
	stable@vger.kernel.org
Subject: [PATCH v1] HID: usbhid: Eliminate recurrent out-of-bounds bug in usbhid_parse()
Date: Thu,  6 Mar 2025 20:54:43 -0800
Message-ID: <20250307045449.745634-1-linuxhid@cosmicgizmosystems.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update struct hid_descriptor to better reflect the mandatory and
optional parts of the HID Descriptor as per USB HID 1.11 specification.
Note: the kernel currently does not parse any optional HID class
descriptors, only the mandatory report descriptor.

Update all references to member element desc[0] to rpt_desc.

Add test to verify bLength and bNumDescriptors values are valid.

Replace the for loop with direct access to the mandatory HID class
descriptor member for the report descriptor. This eliminates the
possibility of getting an out-of-bounds fault.

Add a warning message if the HID descriptor contains any unsupported
optional HID class descriptors.

Reported-by: syzbot+c52569baf0c843f35495@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=c52569baf0c843f35495
Fixes: f043bfc98c19 ("HID: usbhid: fix out-of-bounds bug")
Cc: stable@vger.kernel.org
Signed-off-by: Terry Junge <linuxhid@cosmicgizmosystems.com>
---
v1: Remove unnecessary for loop searching for the report descriptor size.
base-commit: 58c9bf3363e596d744f56616d407278ef5f97f5a

P.S. This is an alternative to the solution proposed by Nikita Zhandarovich <n.zhandarovich@fintech.ru>
Link: https://lore.kernel.org/all/20250131151600.410242-1-n.zhandarovich@fintech.ru/

 include/linux/hid.h                 |  3 ++-
 drivers/usb/gadget/function/f_hid.c | 12 ++++++------
 drivers/hid/hid-hyperv.c            |  4 ++--
 drivers/hid/usbhid/hid-core.c       | 25 ++++++++++++++-----------
 4 files changed, 24 insertions(+), 20 deletions(-)

diff --git a/include/linux/hid.h b/include/linux/hid.h
index cdc0dc13c87f..7abc8c74bdd5 100644
--- a/include/linux/hid.h
+++ b/include/linux/hid.h
@@ -738,8 +738,9 @@ struct hid_descriptor {
 	__le16 bcdHID;
 	__u8  bCountryCode;
 	__u8  bNumDescriptors;
+	struct hid_class_descriptor rpt_desc;
 
-	struct hid_class_descriptor desc[1];
+	struct hid_class_descriptor opt_descs[];
 } __attribute__ ((packed));
 
 #define HID_DEVICE(b, g, ven, prod)					\
diff --git a/drivers/usb/gadget/function/f_hid.c b/drivers/usb/gadget/function/f_hid.c
index 740311c4fa24..c7a05f842745 100644
--- a/drivers/usb/gadget/function/f_hid.c
+++ b/drivers/usb/gadget/function/f_hid.c
@@ -144,8 +144,8 @@ static struct hid_descriptor hidg_desc = {
 	.bcdHID				= cpu_to_le16(0x0101),
 	.bCountryCode			= 0x00,
 	.bNumDescriptors		= 0x1,
-	/*.desc[0].bDescriptorType	= DYNAMIC */
-	/*.desc[0].wDescriptorLenght	= DYNAMIC */
+	/*.rpt_desc.bDescriptorType	= DYNAMIC */
+	/*.rpt_desc.wDescriptorLength	= DYNAMIC */
 };
 
 /* Super-Speed Support */
@@ -939,8 +939,8 @@ static int hidg_setup(struct usb_function *f,
 			struct hid_descriptor hidg_desc_copy = hidg_desc;
 
 			VDBG(cdev, "USB_REQ_GET_DESCRIPTOR: HID\n");
-			hidg_desc_copy.desc[0].bDescriptorType = HID_DT_REPORT;
-			hidg_desc_copy.desc[0].wDescriptorLength =
+			hidg_desc_copy.rpt_desc.bDescriptorType = HID_DT_REPORT;
+			hidg_desc_copy.rpt_desc.wDescriptorLength =
 				cpu_to_le16(hidg->report_desc_length);
 
 			length = min_t(unsigned short, length,
@@ -1210,8 +1210,8 @@ static int hidg_bind(struct usb_configuration *c, struct usb_function *f)
 	 * We can use hidg_desc struct here but we should not relay
 	 * that its content won't change after returning from this function.
 	 */
-	hidg_desc.desc[0].bDescriptorType = HID_DT_REPORT;
-	hidg_desc.desc[0].wDescriptorLength =
+	hidg_desc.rpt_desc.bDescriptorType = HID_DT_REPORT;
+	hidg_desc.rpt_desc.wDescriptorLength =
 		cpu_to_le16(hidg->report_desc_length);
 
 	hidg_hs_in_ep_desc.bEndpointAddress =
diff --git a/drivers/hid/hid-hyperv.c b/drivers/hid/hid-hyperv.c
index 0fb210e40a41..9eafff0b6ea4 100644
--- a/drivers/hid/hid-hyperv.c
+++ b/drivers/hid/hid-hyperv.c
@@ -192,7 +192,7 @@ static void mousevsc_on_receive_device_info(struct mousevsc_dev *input_device,
 		goto cleanup;
 
 	input_device->report_desc_size = le16_to_cpu(
-					desc->desc[0].wDescriptorLength);
+					desc->rpt_desc.wDescriptorLength);
 	if (input_device->report_desc_size == 0) {
 		input_device->dev_info_status = -EINVAL;
 		goto cleanup;
@@ -210,7 +210,7 @@ static void mousevsc_on_receive_device_info(struct mousevsc_dev *input_device,
 
 	memcpy(input_device->report_desc,
 	       ((unsigned char *)desc) + desc->bLength,
-	       le16_to_cpu(desc->desc[0].wDescriptorLength));
+	       le16_to_cpu(desc->rpt_desc.wDescriptorLength));
 
 	/* Send the ack */
 	memset(&ack, 0, sizeof(struct mousevsc_prt_msg));
diff --git a/drivers/hid/usbhid/hid-core.c b/drivers/hid/usbhid/hid-core.c
index a6eb6fe6130d..e668143b559d 100644
--- a/drivers/hid/usbhid/hid-core.c
+++ b/drivers/hid/usbhid/hid-core.c
@@ -983,12 +983,11 @@ static int usbhid_parse(struct hid_device *hid)
 	struct usb_host_interface *interface = intf->cur_altsetting;
 	struct usb_device *dev = interface_to_usbdev (intf);
 	struct hid_descriptor *hdesc;
+	struct hid_class_descriptor *hcdesc;
 	u32 quirks = 0;
 	unsigned int rsize = 0;
 	char *rdesc;
-	int ret, n;
-	int num_descriptors;
-	size_t offset = offsetof(struct hid_descriptor, desc);
+	int ret;
 
 	quirks = hid_lookup_quirk(hid);
 
@@ -1010,20 +1009,19 @@ static int usbhid_parse(struct hid_device *hid)
 		return -ENODEV;
 	}
 
-	if (hdesc->bLength < sizeof(struct hid_descriptor)) {
-		dbg_hid("hid descriptor is too short\n");
+	if (!hdesc->bNumDescriptors ||
+	    hdesc->bLength != sizeof(*hdesc) +
+			      (hdesc->bNumDescriptors - 1) * sizeof(*hcdesc)) {
+		dbg_hid("hid descriptor invalid, bLen=%hhu bNum=%hhu\n",
+			hdesc->bLength, hdesc->bNumDescriptors);
 		return -EINVAL;
 	}
 
 	hid->version = le16_to_cpu(hdesc->bcdHID);
 	hid->country = hdesc->bCountryCode;
 
-	num_descriptors = min_t(int, hdesc->bNumDescriptors,
-	       (hdesc->bLength - offset) / sizeof(struct hid_class_descriptor));
-
-	for (n = 0; n < num_descriptors; n++)
-		if (hdesc->desc[n].bDescriptorType == HID_DT_REPORT)
-			rsize = le16_to_cpu(hdesc->desc[n].wDescriptorLength);
+	if (hdesc->rpt_desc.bDescriptorType == HID_DT_REPORT)
+		rsize = le16_to_cpu(hdesc->rpt_desc.wDescriptorLength);
 
 	if (!rsize || rsize > HID_MAX_DESCRIPTOR_SIZE) {
 		dbg_hid("weird size of report descriptor (%u)\n", rsize);
@@ -1051,6 +1049,11 @@ static int usbhid_parse(struct hid_device *hid)
 		goto err;
 	}
 
+	if (hdesc->bNumDescriptors > 1)
+		hid_warn(intf,
+			"%hhu unsupported optional hid class descriptors\n",
+			hdesc->bNumDescriptors - 1);
+
 	hid->quirks |= quirks;
 
 	return 0;
-- 
2.43.0


