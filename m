Return-Path: <linux-hyperv+bounces-3253-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95DBB9BBA8E
	for <lists+linux-hyperv@lfdr.de>; Mon,  4 Nov 2024 17:48:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C70541C22271
	for <lists+linux-hyperv@lfdr.de>; Mon,  4 Nov 2024 16:48:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDB6D42056;
	Mon,  4 Nov 2024 16:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FaYV3Gtf"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF6431C07FC
	for <linux-hyperv@vger.kernel.org>; Mon,  4 Nov 2024 16:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730738916; cv=none; b=VzGShgrfQJHz4tH1E/zy+sN3zHCfyQdZsLibyJoirG4OwX3IcpWSr7qB4+NRSXJuN/72kNqgAlu+vXTUf6urObG2nPpbQAXfX98MZzBf9MUUcpUnKopJT8/snMNWxnEX1Bq6xFnmpta1SiFP41MDUAskiBXQ2QdJ0CDXM84Hr4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730738916; c=relaxed/simple;
	bh=v/MMC+MY1D3NLxHPYWBM2LNjFHuJiv/ng/LeeeBXXxE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=q6cVyUWKVgWPu+ctxJOltw5Kw4bUyB53krwHAb5N41TLd7SAalAodC3KJkeRfbZW0SMbM5Oy71Vv9NrWKwXA8Zz+LFAgfeyISs9T2MtrKeUk428EiRUNPzCo1bdsgessxOTHlMtj49hob+agFu1HtVPR3WHAVSaiYKGiSDjPLGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FaYV3Gtf; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730738913;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=8aOWHX2ysbhucnKVnxTSobNkijX6IXF2FpLitaEDSio=;
	b=FaYV3GtfftxeLfcG3c3o9CO0fVzr74X4vFEb8oZzZOwNL8pGBBBPGqBGgzDul1a08l1IIE
	VK9VvFoj0mxvvtFwR1Ycihggh0nCAdVNMCcnPCi+8Kbdk76nzaxiWaH7aORNBOnqEKWXUr
	i5PP9zR89rs9sHHj3/j48TIbrpyZt/k=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-98-DZf_4-TGOEaMIodF39K5dw-1; Mon,
 04 Nov 2024 11:48:30 -0500
X-MC-Unique: DZf_4-TGOEaMIodF39K5dw-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 280D01955F40;
	Mon,  4 Nov 2024 16:48:29 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.226.36])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 395AB19560A2;
	Mon,  4 Nov 2024 16:48:26 +0000 (UTC)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: linux-hyperv@vger.kernel.org,
	linux-input@vger.kernel.org
Cc: "K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH] HID: hyperv: streamline driver probe to avoid devres issues
Date: Mon,  4 Nov 2024 17:48:24 +0100
Message-ID: <20241104164824.1213529-1-vkuznets@redhat.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

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

Fix the issue by dropping the 'hid_dev->driver' override and the
now unneeded hid_parse()/hid_hw_start() calls. One notable difference of
the change is hid_hw_start() is now called with HID_CONNECT_DEFAULT which
implies HID_CONNECT_HIDRAW. This doesn't seem to cause any immediate issues
but 'HID_CONNECT_HIDINPUT | HID_CONNECT_HIDDEV' combo was used in the
driver for a long time and it is unclear whether hidraw was excluded on
purpose or not.

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 drivers/hid/hid-hyperv.c | 17 -----------------
 1 file changed, 17 deletions(-)

diff --git a/drivers/hid/hid-hyperv.c b/drivers/hid/hid-hyperv.c
index f33485d83d24..1609a56ffa7c 100644
--- a/drivers/hid/hid-hyperv.c
+++ b/drivers/hid/hid-hyperv.c
@@ -431,8 +431,6 @@ static const struct hid_ll_driver mousevsc_ll_driver = {
 	.raw_request = mousevsc_hid_raw_request,
 };
 
-static struct hid_driver mousevsc_hid_driver;
-
 static int mousevsc_probe(struct hv_device *device,
 			const struct hv_vmbus_device_id *dev_id)
 {
@@ -473,7 +471,6 @@ static int mousevsc_probe(struct hv_device *device,
 	}
 
 	hid_dev->ll_driver = &mousevsc_ll_driver;
-	hid_dev->driver = &mousevsc_hid_driver;
 	hid_dev->bus = BUS_VIRTUAL;
 	hid_dev->vendor = input_dev->hid_dev_info.vendor;
 	hid_dev->product = input_dev->hid_dev_info.product;
@@ -488,20 +485,6 @@ static int mousevsc_probe(struct hv_device *device,
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
-- 
2.47.0


