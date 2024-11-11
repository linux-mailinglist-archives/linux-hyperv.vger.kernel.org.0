Return-Path: <linux-hyperv+bounces-3308-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B7D3E9C3F67
	for <lists+linux-hyperv@lfdr.de>; Mon, 11 Nov 2024 14:13:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48F7F1F213D6
	for <lists+linux-hyperv@lfdr.de>; Mon, 11 Nov 2024 13:13:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 764D119CCEC;
	Mon, 11 Nov 2024 13:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="akMBHJXZ"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA466158DC8
	for <linux-hyperv@vger.kernel.org>; Mon, 11 Nov 2024 13:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731330774; cv=none; b=bKCEhR85YsRAK7ITP4ryro4qTt0Qp5rzcT8XP7oOGBcBzyRigtwa+RphGXzMkpk1iOFHG738bpHEhs21CynnpooGNNhI6l0gd1vb4M8o0dwZcqo7lawEb/ju4hOhregPgElmHqdMgdvQmLhDZuJuyEiltEKJ+6j1KU4yQXq76CA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731330774; c=relaxed/simple;
	bh=hlCgYj4KqFoNje7LPqbjN114QT5GqWux5iHnY488pNA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=l5lw9c8rNe6Y/qg3Uw5PkZWiuz7x8vMWEabRpW7gt2Xq3meOtxJzSbf5qUnsxkpd9H40vxcZMtoATLLzpQzTvwECOu4GqrPWeLhsMilQj7nj59nP+h7Z/w+MWOekMSjzQ4t/MkLrEVzuKkH7miOgNiKz52BzR/+5B0tzkW8lPwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=akMBHJXZ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731330771;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=FyfkMBNSykWaaIeAogOFuYzRo8X+mQaFAtl/EmHfBwc=;
	b=akMBHJXZVQH4FPioIsvVDNWerEiDKcjur+W0ozDXFlVY2YFuLl4SPWKS1ddyZ+ea8SA9sF
	8jNP7i0uJclsPe1NzRIlh+BeFlfpt5D0p9p18FS8ZeErkaV4VJ1Ithsuk/hhVUNp0CBSta
	JKk253Chc8Ut2wgzowWpTyPaUMmoZHI=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-216-7XekgXwUNGWoRRtlMyqelg-1; Mon,
 11 Nov 2024 08:12:47 -0500
X-MC-Unique: 7XekgXwUNGWoRRtlMyqelg-1
X-Mimecast-MFC-AGG-ID: 7XekgXwUNGWoRRtlMyqelg
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 81DEA1953940;
	Mon, 11 Nov 2024 13:12:45 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.225.127])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A03D21956086;
	Mon, 11 Nov 2024 13:12:41 +0000 (UTC)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: linux-hyperv@vger.kernel.org,
	linux-input@vger.kernel.org
Cc: Saurabh Singh Sengar <ssengar@linux.microsoft.com>,
	mhklinux@outlook.com,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] HID: hyperv: streamline driver probe to avoid devres issues
Date: Mon, 11 Nov 2024 14:12:40 +0100
Message-ID: <20241111131240.35158-1-vkuznets@redhat.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

It was found that unloading 'hid_hyperv' module results in a devres
complaint:

 ...
 hv_vmbus: unregistering driver hid_hyperv
 ------------[ cut here ]------------
 WARNING: CPU: 2 PID: 3983 at drivers/base/devres.c:691 devres_release_group+0x1f2/0x2c0
 ...
 Call Trace:
  <TASK>
  ? devres_release_group+0x1f2/0x2c0
  ? __warn+0xd1/0x1c0
  ? devres_release_group+0x1f2/0x2c0
  ? report_bug+0x32a/0x3c0
  ? handle_bug+0x53/0xa0
  ? exc_invalid_op+0x18/0x50
  ? asm_exc_invalid_op+0x1a/0x20
  ? devres_release_group+0x1f2/0x2c0
  ? devres_release_group+0x90/0x2c0
  ? rcu_is_watching+0x15/0xb0
  ? __pfx_devres_release_group+0x10/0x10
  hid_device_remove+0xf5/0x220
  device_release_driver_internal+0x371/0x540
  ? klist_put+0xf3/0x170
  bus_remove_device+0x1f1/0x3f0
  device_del+0x33f/0x8c0
  ? __pfx_device_del+0x10/0x10
  ? cleanup_srcu_struct+0x337/0x500
  hid_destroy_device+0xc8/0x130
  mousevsc_remove+0xd2/0x1d0 [hid_hyperv]
  device_release_driver_internal+0x371/0x540
  driver_detach+0xc5/0x180
  bus_remove_driver+0x11e/0x2a0
  ? __mutex_unlock_slowpath+0x160/0x5e0
  vmbus_driver_unregister+0x62/0x2b0 [hv_vmbus]
  ...

And the issue seems to be that the corresponding devres group is not
allocated. Normally, devres_open_group() is called from
__hid_device_probe() but Hyper-V HID driver overrides 'hid_dev->driver'
with 'mousevsc_hid_driver' stub and basically re-implements
__hid_device_probe() by calling hid_parse() and hid_hw_start() but not
devres_open_group(). hid_device_probe() does not call __hid_device_probe()
for it. Later, when the driver is removed, hid_device_remove() calls
devres_release_group() as it doesn't check whether hdev->driver was
initially overridden or not.

The issue seems to be related to the commit 62c68e7cee33 ("HID: ensure
timely release of driver-allocated resources") but the commit itself seems
to be correct.

Fix the issue by dropping the 'hid_dev->driver' override and using
hid_register_driver()/hid_unregister_driver() instead. Alternatively, it
would have been possible to rely on the default handling but
HID_CONNECT_DEFAULT implies HID_CONNECT_HIDRAW and it doesn't seem to work
for mousevsc as-is.

Fixes: 62c68e7cee33 ("HID: ensure timely release of driver-allocated resources")
Suggested-by: Michael Kelley <mhklinux@outlook.com>
Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
Changes since v1:
- Keep custom HID driver for mousevsc but do it properly
[Michael Kelley].
- Add 'Fixes:' tag [Saurabh Singh Sengar].
---
 drivers/hid/hid-hyperv.c | 58 ++++++++++++++++++++++++++++------------
 1 file changed, 41 insertions(+), 17 deletions(-)

diff --git a/drivers/hid/hid-hyperv.c b/drivers/hid/hid-hyperv.c
index f33485d83d24..0fb210e40a41 100644
--- a/drivers/hid/hid-hyperv.c
+++ b/drivers/hid/hid-hyperv.c
@@ -422,6 +422,25 @@ static int mousevsc_hid_raw_request(struct hid_device *hid,
 	return 0;
 }
 
+static int mousevsc_hid_probe(struct hid_device *hid_dev, const struct hid_device_id *id)
+{
+	int ret;
+
+	ret = hid_parse(hid_dev);
+	if (ret) {
+		hid_err(hid_dev, "parse failed\n");
+		return ret;
+	}
+
+	ret = hid_hw_start(hid_dev, HID_CONNECT_HIDINPUT | HID_CONNECT_HIDDEV);
+	if (ret) {
+		hid_err(hid_dev, "hw start failed\n");
+		return ret;
+	}
+
+	return 0;
+}
+
 static const struct hid_ll_driver mousevsc_ll_driver = {
 	.parse = mousevsc_hid_parse,
 	.open = mousevsc_hid_open,
@@ -431,7 +450,16 @@ static const struct hid_ll_driver mousevsc_ll_driver = {
 	.raw_request = mousevsc_hid_raw_request,
 };
 
-static struct hid_driver mousevsc_hid_driver;
+static const struct hid_device_id mousevsc_devices[] = {
+	{ HID_DEVICE(BUS_VIRTUAL, HID_GROUP_ANY, 0x045E, 0x0621) },
+	{ }
+};
+
+static struct hid_driver mousevsc_hid_driver = {
+	.name = "hid-hyperv",
+	.id_table = mousevsc_devices,
+	.probe = mousevsc_hid_probe,
+};
 
 static int mousevsc_probe(struct hv_device *device,
 			const struct hv_vmbus_device_id *dev_id)
@@ -473,7 +501,6 @@ static int mousevsc_probe(struct hv_device *device,
 	}
 
 	hid_dev->ll_driver = &mousevsc_ll_driver;
-	hid_dev->driver = &mousevsc_hid_driver;
 	hid_dev->bus = BUS_VIRTUAL;
 	hid_dev->vendor = input_dev->hid_dev_info.vendor;
 	hid_dev->product = input_dev->hid_dev_info.product;
@@ -488,20 +515,6 @@ static int mousevsc_probe(struct hv_device *device,
 	if (ret)
 		goto probe_err2;
 
-
-	ret = hid_parse(hid_dev);
-	if (ret) {
-		hid_err(hid_dev, "parse failed\n");
-		goto probe_err2;
-	}
-
-	ret = hid_hw_start(hid_dev, HID_CONNECT_HIDINPUT | HID_CONNECT_HIDDEV);
-
-	if (ret) {
-		hid_err(hid_dev, "hw start failed\n");
-		goto probe_err2;
-	}
-
 	device_init_wakeup(&device->device, true);
 
 	input_dev->connected = true;
@@ -579,12 +592,23 @@ static struct  hv_driver mousevsc_drv = {
 
 static int __init mousevsc_init(void)
 {
-	return vmbus_driver_register(&mousevsc_drv);
+	int ret;
+
+	ret = hid_register_driver(&mousevsc_hid_driver);
+	if (ret)
+		return ret;
+
+	ret = vmbus_driver_register(&mousevsc_drv);
+	if (ret)
+		hid_unregister_driver(&mousevsc_hid_driver);
+
+	return ret;
 }
 
 static void __exit mousevsc_exit(void)
 {
 	vmbus_driver_unregister(&mousevsc_drv);
+	hid_unregister_driver(&mousevsc_hid_driver);
 }
 
 MODULE_LICENSE("GPL");
-- 
2.47.0


