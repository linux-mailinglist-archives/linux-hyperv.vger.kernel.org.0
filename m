Return-Path: <linux-hyperv+bounces-3486-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 139B29F41A3
	for <lists+linux-hyperv@lfdr.de>; Tue, 17 Dec 2024 05:18:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8BD3169F0C
	for <lists+linux-hyperv@lfdr.de>; Tue, 17 Dec 2024 04:18:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6690E14B955;
	Tue, 17 Dec 2024 04:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="l4+ut4HI"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E491C14AD3D;
	Tue, 17 Dec 2024 04:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734409055; cv=none; b=aFDpGi4ZIX9VZ5EBQdUO2wQO9IFhDEX2+0Ox1GIn7kl7Zy1bR318L9hpee1X76qea1wRS8ILdmmmLWQQ+DI5kXhwl43X6JedZWxNf8sMfd2GHEZBzayLLPWr7j+jru+kHg6PEGPkC5mgQOG9YaTGUQaC5y1+GVv9f2m+YMb6wws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734409055; c=relaxed/simple;
	bh=iVw5SMSq1NnWd4cIbhU6o+1lcS5G5m/Bqf3klkFU5f0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=dGF7DXBhgGYTnIZN1QagmdIHLEx75UrzPjYqRYhE7J5Ec9TfkUvPn0EjD5TCMXwpGPCMZ6GhBzbg032j/8zgpMkwNXQu51S3M6nkPwcPtYBsNXCl1EmbnkEvOvx12Z5SiMqVH8oHkc1fvcCYd3SequegOOz/N4UdP3RLoDzj4w0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=l4+ut4HI; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1173)
	id 91153204720E; Mon, 16 Dec 2024 20:17:33 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 91153204720E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1734409053;
	bh=HaIOnEhQhv1FKYbJuCbPN8zIaM65OendeLE6+LccWGo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=l4+ut4HI44HF6eigzGyh9Mosvf4gvsztgMysVyNYgANc2KDXOw5Z2r9Z3FOxetcAc
	 Vq/YmqQdPIqmYw1WARscUwKVBQWy3WP7KYWJzLBE1qo1uCp/nZqIIO96W44oOh7yt4
	 a2H8KIxun1Ysy9IpFQMdF6FfT+ZpzNByoMTv/Q0I=
From: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
To: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	jikos@kernel.org,
	bentiss@kernel.org,
	dmitry.torokhov@gmail.com,
	linux-hyperv@vger.kernel.org,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
Subject: [PATCH v4 3/3] HID: hyperv: disable as wakeup source
Date: Mon, 16 Dec 2024 20:17:09 -0800
Message-Id: <1734409029-10419-4-git-send-email-ernis@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1734409029-10419-1-git-send-email-ernis@linux.microsoft.com>
References: <1734409029-10419-1-git-send-email-ernis@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Do not enable mouse as wakeup device since
Suspend-to-Idle feature is no longer supported.

Calling device_init_wakeup in the remove function
is unnecessary since the device is going away, and
thus won't be able to cause any wakeups under any
circumstances. Besides, the driver cleanup code
already handles the necessary cleanup.

Signed-off-by: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
---
Changes in v4:
* Replace device_init_wakeup() with device_set_wakeup_capable
  without reverting "HID: hyperv: register as a wakeup source".
* Remove device_init_wakeup() in mousevsc_remove().
ref: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=f20b161f59b73d40043199b3bff362e656a9c673

Changes in v3, v2:
* No change
---
 drivers/hid/hid-hyperv.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/hid/hid-hyperv.c b/drivers/hid/hid-hyperv.c
index 0fb210e40a41..05215e79eac8 100644
--- a/drivers/hid/hid-hyperv.c
+++ b/drivers/hid/hid-hyperv.c
@@ -515,7 +515,7 @@ static int mousevsc_probe(struct hv_device *device,
 	if (ret)
 		goto probe_err2;
 
-	device_init_wakeup(&device->device, true);
+	device_set_wakeup_capable(&device->device, true);
 
 	input_dev->connected = true;
 	input_dev->init_complete = true;
@@ -539,7 +539,6 @@ static void mousevsc_remove(struct hv_device *dev)
 {
 	struct mousevsc_dev *input_dev = hv_get_drvdata(dev);
 
-	device_init_wakeup(&dev->device, false);
 	vmbus_close(dev->channel);
 	hid_hw_stop(input_dev->hid_device);
 	hid_destroy_device(input_dev->hid_device);
-- 
2.34.1


