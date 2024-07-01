Return-Path: <linux-hyperv+bounces-2507-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3225A91D617
	for <lists+linux-hyperv@lfdr.de>; Mon,  1 Jul 2024 04:31:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 633F21C20C27
	for <lists+linux-hyperv@lfdr.de>; Mon,  1 Jul 2024 02:31:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88E58748E;
	Mon,  1 Jul 2024 02:31:29 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from cstnet.cn (smtp84.cstnet.cn [159.226.251.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FE966FBF;
	Mon,  1 Jul 2024 02:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719801089; cv=none; b=FCWidlCyVtbkEddLu0y375BS7MOIP4WmyRc4M6fz1uoFQTDWfGYtmtNzpq5mydJgWhUKvdQvgtAVRNTzgXykCSAGA+T5pXEuN23jbwrtawhjElzOguxlLQnWgnWr99oXpBcawP8qjxBBtL135YUO2TGNFVacuRC1X2VFLwzFvV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719801089; c=relaxed/simple;
	bh=8X8hKbb3AuxsYLCRu/oA3pHY02jmCm+F2eWEQaIntDc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=L7IQwazDy1Coj2giRVaxft4WFpdyLm2J+S0P2vcgrIQU4SxalRYImXL6uIZXh87R+duod6ckDbsB7/4GQCC/TGK82qw3CRfupxhfzuovVrlp4vYvcpgfQGj2c2GluHgA7TAh4TuUp4X9D7FZs5oqpmzro41sDRG7P+Xu97rHPRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [36.112.3.229])
	by APP-05 (Coremail) with SMTP id zQCowADX37flFIJmCcnkAA--.55721S2;
	Mon, 01 Jul 2024 10:31:12 +0800 (CST)
From: Haoxiang Li <make24@iscas.ac.cn>
To: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	parri.andrea@gmail.com,
	mikelley@microsoft.com
Cc: linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Haoxiang Li <make24@iscas.ac.cn>
Subject: [PATCH] Drivers: hv: vmbus: Add missing check for dma_set_mask in vmbus_device_register()
Date: Mon,  1 Jul 2024 10:30:59 +0800
Message-Id: <20240701023059.83616-1-make24@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowADX37flFIJmCcnkAA--.55721S2
X-Coremail-Antispam: 1UD129KBjvJXoW7AF48KrW8GF1UAw4xZF18Zrb_yoW8JF4Dpa
	4UXFZ8trW0gw1xCw1vva1UJFy5CF4Iyw1F9r1rCwnrKF1xJFyYq3y0yFyUC3WDt3yfJF1U
	XFyUJ3WF9r4DJr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvj14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWUuVWrJwAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r
	4UJVWxJr1lnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG
	64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r
	4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAq
	YI8I648v4I1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWU
	JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfU5v
	tCUUUUU
X-CM-SenderInfo: ppdnvj2u6l2u1dvotugofq/

child_device_obj->device cannot perform DMA properly if dma_set_mask()
returns non-zero. Add check for dma_set_mask() and return the error if it
fails. child_device_obj->device is not initialized here, so use kfree() to
free child_device_obj->device.

Fixes: 3a5469582c24 ("Drivers: hv: vmbus: Fix initialization of device object in vmbus_device_register()")
Signed-off-by: Haoxiang Li <make24@iscas.ac.cn>
---
 drivers/hv/vmbus_drv.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index 12a707ab73f8..daa584eaa2af 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -1897,7 +1897,13 @@ int vmbus_device_register(struct hv_device *child_device_obj)
 
 	child_device_obj->device.dma_parms = &child_device_obj->dma_parms;
 	child_device_obj->device.dma_mask = &child_device_obj->dma_mask;
-	dma_set_mask(&child_device_obj->device, DMA_BIT_MASK(64));
+	ret = dma_set_mask(&child_device_obj->device, DMA_BIT_MASK(64));
+
+	if (ret) {
+		pr_err("64-bit DMA enable failed\n");
+		kfree(&child_device_obj->device);
+		return ret;
+	}
 
 	/*
 	 * Register with the LDM. This will kick off the driver/device
-- 
2.25.1


