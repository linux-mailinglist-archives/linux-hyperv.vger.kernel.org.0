Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B3165FC495
	for <lists+linux-hyperv@lfdr.de>; Wed, 12 Oct 2022 13:56:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229594AbiJLL4x (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 12 Oct 2022 07:56:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiJLL4x (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 12 Oct 2022 07:56:53 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 27B90BEAC8;
        Wed, 12 Oct 2022 04:56:51 -0700 (PDT)
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
        by linux.microsoft.com (Postfix) with ESMTPSA id 8C67220F0F63;
        Wed, 12 Oct 2022 04:56:50 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 8C67220F0F63
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1665575810;
        bh=z54yx0yEXP36s+bnqTfvLd+Chs2Z6Y67fbLJLoRI+sE=;
        h=From:To:Subject:Date:From;
        b=Qlv0J8V2PMR/52dxFztaFreZ/GJxt7buILpskQuou7wC01A7y6jQFD+ajPV/i6RWz
         dwef7JyzZhlMSjI+SAUEiJreSJ2lBORwu5uKD+vZtTDkSeXSwY/tUPPoBpumtBckJN
         Hc616T4Bur9TKafbNtL8b9ConBuxIXR4tsuX3krk=
From:   Saurabh Sengar <ssengar@linux.microsoft.com>
To:     ssengar@microsoft.com, kys@microsoft.com, haiyangz@microsoft.com,
        sthemmin@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
        longli@microsoft.com, gregkh@linuxfoundation.org,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        mikelley@microsoft.com
Subject: [PATCH] uio_hv_generic: Enable support for slower vmbus device channels
Date:   Wed, 12 Oct 2022 04:56:46 -0700
Message-Id: <1665575806-27990-1-git-send-email-ssengar@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

This patch enables support for slower vmbus channels, which consist
of following 3 changes :
	1. Support for hypercalls
	2. Module params for recv/send buffer sizes
	3. Module param for custom ring buffer sizes

Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
---
 drivers/uio/uio_hv_generic.c | 111 +++++++++++++++++++----------------
 1 file changed, 62 insertions(+), 49 deletions(-)

diff --git a/drivers/uio/uio_hv_generic.c b/drivers/uio/uio_hv_generic.c
index c08a6cfd119f..11a735fbb4f1 100644
--- a/drivers/uio/uio_hv_generic.c
+++ b/drivers/uio/uio_hv_generic.c
@@ -36,10 +36,21 @@
 #define DRIVER_AUTHOR	"Stephen Hemminger <sthemmin at microsoft.com>"
 #define DRIVER_DESC	"Generic UIO driver for VMBus devices"
 
-#define HV_RING_SIZE	 512	/* pages */
+#define DEFAULT_HV_RING_SIZE	VMBUS_RING_SIZE(511 * HV_HYP_PAGE_SIZE)
 #define SEND_BUFFER_SIZE (16 * 1024 * 1024)
 #define RECV_BUFFER_SIZE (31 * 1024 * 1024)
 
+static size_t recv_buf_size = RECV_BUFFER_SIZE;
+module_param(recv_buf_size, ulong, 0644);
+MODULE_PARM_DESC(recv_buf_size, "receive buffer size in bytes");
+
+static size_t send_buf_size = SEND_BUFFER_SIZE;
+module_param(send_buf_size, ulong, 0644);
+MODULE_PARM_DESC(send_buf_size, "send buffer size in bytes");
+
+static size_t ring_size = DEFAULT_HV_RING_SIZE;
+module_param(ring_size, ulong, 0644);
+MODULE_PARM_DESC(ring_size, "primary channel ring buffer size in bytes");
 /*
  * List of resources to be mapped to user space
  * can be extended up to MAX_UIO_MAPS(5) items
@@ -84,6 +95,9 @@ hv_uio_irqcontrol(struct uio_info *info, s32 irq_state)
 	dev->channel->inbound.ring_buffer->interrupt_mask = !irq_state;
 	virt_mb();
 
+	if (!dev->channel->offermsg.monitor_allocated && irq_state)
+		vmbus_setevent(dev->channel);
+
 	return 0;
 }
 
@@ -143,7 +157,7 @@ static const struct bin_attribute ring_buffer_bin_attr = {
 		.name = "ring",
 		.mode = 0600,
 	},
-	.size = 2 * HV_RING_SIZE * PAGE_SIZE,
+	.size = 2 * DEFAULT_HV_RING_SIZE,
 	.mmap = hv_uio_ring_mmap,
 };
 
@@ -153,7 +167,7 @@ hv_uio_new_channel(struct vmbus_channel *new_sc)
 {
 	struct hv_device *hv_dev = new_sc->primary_channel->device_obj;
 	struct device *device = &hv_dev->device;
-	const size_t ring_bytes = HV_RING_SIZE * PAGE_SIZE;
+	const size_t ring_bytes = DEFAULT_HV_RING_SIZE;
 	int ret;
 
 	/* Create host communication ring */
@@ -239,18 +253,13 @@ hv_uio_probe(struct hv_device *dev,
 	void *ring_buffer;
 	int ret;
 
-	/* Communicating with host has to be via shared memory not hypercall */
-	if (!channel->offermsg.monitor_allocated) {
-		dev_err(&dev->device, "vmbus channel requires hypercall\n");
-		return -ENOTSUPP;
-	}
+	dev_dbg(&dev->device, "primary channel ring size = %lx", ring_size);
 
 	pdata = devm_kzalloc(&dev->device, sizeof(*pdata), GFP_KERNEL);
 	if (!pdata)
 		return -ENOMEM;
 
-	ret = vmbus_alloc_ring(channel, HV_RING_SIZE * PAGE_SIZE,
-			       HV_RING_SIZE * PAGE_SIZE);
+	ret = vmbus_alloc_ring(channel, ring_size, ring_size);
 	if (ret)
 		return ret;
 
@@ -286,49 +295,53 @@ hv_uio_probe(struct hv_device *dev,
 	pdata->info.mem[MON_PAGE_MAP].size = PAGE_SIZE;
 	pdata->info.mem[MON_PAGE_MAP].memtype = UIO_MEM_LOGICAL;
 
-	pdata->recv_buf = vzalloc(RECV_BUFFER_SIZE);
-	if (pdata->recv_buf == NULL) {
-		ret = -ENOMEM;
-		goto fail_free_ring;
-	}
-
-	ret = vmbus_establish_gpadl(channel, pdata->recv_buf,
-				    RECV_BUFFER_SIZE, &pdata->recv_gpadl);
-	if (ret) {
-		vfree(pdata->recv_buf);
-		goto fail_close;
-	}
-
-	/* put Global Physical Address Label in name */
-	snprintf(pdata->recv_name, sizeof(pdata->recv_name),
-		 "recv:%u", pdata->recv_gpadl.gpadl_handle);
-	pdata->info.mem[RECV_BUF_MAP].name = pdata->recv_name;
-	pdata->info.mem[RECV_BUF_MAP].addr
-		= (uintptr_t)pdata->recv_buf;
-	pdata->info.mem[RECV_BUF_MAP].size = RECV_BUFFER_SIZE;
-	pdata->info.mem[RECV_BUF_MAP].memtype = UIO_MEM_VIRTUAL;
-
-	pdata->send_buf = vzalloc(SEND_BUFFER_SIZE);
-	if (pdata->send_buf == NULL) {
-		ret = -ENOMEM;
-		goto fail_close;
+	if (recv_buf_size) {
+		dev_dbg(&dev->device, "recv buffer allocation");
+		pdata->recv_buf = vzalloc(recv_buf_size);
+		if (!pdata->recv_buf) {
+			ret = -ENOMEM;
+			goto fail_free_ring;
+		}
+
+		ret = vmbus_establish_gpadl(channel, pdata->recv_buf,
+					    recv_buf_size, &pdata->recv_gpadl);
+		if (ret) {
+			vfree(pdata->recv_buf);
+			goto fail_close;
+		}
+
+		/* put Global Physical Address Label in name */
+		snprintf(pdata->recv_name, sizeof(pdata->recv_name),
+			 "recv:%u", pdata->recv_gpadl.gpadl_handle);
+		pdata->info.mem[RECV_BUF_MAP].name = pdata->recv_name;
+		pdata->info.mem[RECV_BUF_MAP].addr = (uintptr_t)pdata->recv_buf;
+		pdata->info.mem[RECV_BUF_MAP].size = recv_buf_size;
+		pdata->info.mem[RECV_BUF_MAP].memtype = UIO_MEM_VIRTUAL;
 	}
 
-	ret = vmbus_establish_gpadl(channel, pdata->send_buf,
-				    SEND_BUFFER_SIZE, &pdata->send_gpadl);
-	if (ret) {
-		vfree(pdata->send_buf);
-		goto fail_close;
+	if (send_buf_size) {
+		dev_dbg(&dev->device, "send buffer allocation");
+		pdata->send_buf = vzalloc(send_buf_size);
+		if (!pdata->send_buf) {
+			ret = -ENOMEM;
+			goto fail_close;
+		}
+
+		ret = vmbus_establish_gpadl(channel, pdata->send_buf,
+					    send_buf_size, &pdata->send_gpadl);
+		if (ret) {
+			vfree(pdata->send_buf);
+			goto fail_close;
+		}
+
+		snprintf(pdata->send_name, sizeof(pdata->send_name),
+			 "send:%u", pdata->send_gpadl.gpadl_handle);
+		pdata->info.mem[SEND_BUF_MAP].name = pdata->send_name;
+		pdata->info.mem[SEND_BUF_MAP].addr = (uintptr_t)pdata->send_buf;
+		pdata->info.mem[SEND_BUF_MAP].size = send_buf_size;
+		pdata->info.mem[SEND_BUF_MAP].memtype = UIO_MEM_VIRTUAL;
 	}
 
-	snprintf(pdata->send_name, sizeof(pdata->send_name),
-		 "send:%u", pdata->send_gpadl.gpadl_handle);
-	pdata->info.mem[SEND_BUF_MAP].name = pdata->send_name;
-	pdata->info.mem[SEND_BUF_MAP].addr
-		= (uintptr_t)pdata->send_buf;
-	pdata->info.mem[SEND_BUF_MAP].size = SEND_BUFFER_SIZE;
-	pdata->info.mem[SEND_BUF_MAP].memtype = UIO_MEM_VIRTUAL;
-
 	pdata->info.priv = pdata;
 	pdata->device = dev;
 
-- 
2.34.1

