Return-Path: <linux-hyperv+bounces-2527-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AA86592559B
	for <lists+linux-hyperv@lfdr.de>; Wed,  3 Jul 2024 10:42:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC99A1C23315
	for <lists+linux-hyperv@lfdr.de>; Wed,  3 Jul 2024 08:42:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DCE613B2AC;
	Wed,  3 Jul 2024 08:42:43 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C017813AA3B;
	Wed,  3 Jul 2024 08:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719996162; cv=none; b=R2RcKR6QchxBFsYHCsg3j/GXNNzh+QB/VV6AvU7S3hsajHcIrQAxxzrf5XYGv0XXToaKJNTAtrsgAEtgt+znA3GtpUYPwcD2cTBKtvp66CBg9M0HZkQ6XN8198ZxvVGYDryVrknX9qjn7j4x90LMicei373BjItBVpYP+Ou4b+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719996162; c=relaxed/simple;
	bh=t44mCL05z2gkQcpfbrS9S8Rane1BDpPul7oNt2V6sXw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=BhmedPKQqi+9/yinVjtt+IXLAEtzuhGmiK5bRVK7xkKg9zfwYeT0ytneY02v4txcHwfw75uo9C4gxxytVb1SaHQArwUbnKIdHimukfo0boidXq848zwI9Wa+IRf8bK1Z7jdneFId+nlQKQvooLGiL8p4m+q1RW5Zm6N+cO8L70Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [36.112.3.229])
	by APP-01 (Coremail) with SMTP id qwCowAB3f8vvDoVmnndYAQ--.933S2;
	Wed, 03 Jul 2024 16:42:34 +0800 (CST)
From: Haoxiang Li <make24@iscas.ac.cn>
To: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	mikelley@microsoft.com,
	parri.andrea@gmail.com
Cc: linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Haoxiang Li <make24@iscas.ac.cn>
Subject: [PATCH v2] drivers: hv: vmbus: Add missing check for dma_set_mask in vmbus_device_register()
Date: Wed,  3 Jul 2024 16:42:21 +0800
Message-Id: <20240703084221.12057-1-make24@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowAB3f8vvDoVmnndYAQ--.933S2
X-Coremail-Antispam: 1UD129KBjvJXoWxuFyrJrW7Jr48GFWxWr4rKrg_yoW5Gr4Dpa
	yUWas0krW8WF4xZwsYva1UZFy5Kr4Syw1FvryrAwnF9Fn7Jr90q3y0yFy7A3Wjq3yxCF1U
	XFy5tw4ruFWUAr7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkG14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWUuVWrJwAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
	0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr
	1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IE
	rcIFxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14
	v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkG
	c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4U
	MIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUQZ23UUU
	UU=
X-CM-SenderInfo: ppdnvj2u6l2u1dvotugofq/

child_device_obj->device cannot perform DMA properly if dma_set_mask()
returns non-zero. Add check for dma_set_mask() and return the error if it
fails. To do the right cleanup, call dma_set_mask() after device_register()
so that we can use existent error path of vmbus_device_register().

Fixes: 3a5469582c24 ("Drivers: hv: vmbus: Fix initialization of device object in vmbus_device_register()")
Signed-off-by: Haoxiang Li <make24@iscas.ac.cn>
---
Changes in v2:
Thanks for your comments. They help a lot. It is not sufficient to do the
cleanup just with kfree(). The memory allocated by dev_set_name()
should also be freed, which is done by put_device() (finally in
kobject_cleanup() [1]). I think performing a complete cleanup within
vmbus_device_register() would be verbose and detrimental to code
maintenance. I suggest calling dma_set_mask() after device_register(),
so that proper error handling can be achieved using the existent error path
of vmbus_device_register(), i.e., err_dev_unregister [2]. Moreover,
I found a similar usage in dmapool_checks() [3], which calls
dma_set_mask_and_coherent() after device_register(). I believe the
modification is workable.

Reference link:
[1]https://github.com/torvalds/linux/blob/master/lib/kobject.c#L695
[2]https://github.com/torvalds/linux/blob/master/drivers/hv/vmbus_drv.c#L1933
[3]https://github.com/torvalds/linux/blob/master/mm/dmapool_test.c#L105
---
 drivers/hv/vmbus_drv.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index 12a707ab73f8..f3999d8afd77 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -1897,7 +1897,6 @@ int vmbus_device_register(struct hv_device *child_device_obj)
 
 	child_device_obj->device.dma_parms = &child_device_obj->dma_parms;
 	child_device_obj->device.dma_mask = &child_device_obj->dma_mask;
-	dma_set_mask(&child_device_obj->device, DMA_BIT_MASK(64));
 
 	/*
 	 * Register with the LDM. This will kick off the driver/device
@@ -1910,6 +1909,12 @@ int vmbus_device_register(struct hv_device *child_device_obj)
 		return ret;
 	}
 
+	ret = dma_set_mask(&child_device_obj->device, DMA_BIT_MASK(64));
+	if (ret) {
+		pr_err("64-bit DMA enable failed!\n");
+		goto err_dev_unregister;
+	}
+
 	child_device_obj->channels_kset = kset_create_and_add("channels",
 							      NULL, kobj);
 	if (!child_device_obj->channels_kset) {
-- 
2.25.1


