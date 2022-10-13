Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E9D95FE153
	for <lists+linux-hyperv@lfdr.de>; Thu, 13 Oct 2022 20:34:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232031AbiJMSe1 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 13 Oct 2022 14:34:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232033AbiJMSeL (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 13 Oct 2022 14:34:11 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 805A418D444;
        Thu, 13 Oct 2022 11:30:39 -0700 (PDT)
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
        by linux.microsoft.com (Postfix) with ESMTPSA id C70CC20F9E34;
        Thu, 13 Oct 2022 11:29:18 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C70CC20F9E34
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1665685758;
        bh=LEICLpqkAHA55SgqSRkWd7Q239A6x6Ah2FjEDgwjgI4=;
        h=From:To:Subject:Date:From;
        b=mTgLYdKdGykhbNSoo5PIyT6nrzCY02AjSwwWN1D+AJWEqOVyWGaSNkSIdS/O1q2QC
         gcuBfWEL0sd93Q2+qKoJ7Zar+bWhnV1lLfQ7VQn8QvclUX/QrWEj2w6WbQCtVCD+9F
         guGi4CgEcqPMHiJ17RHKT2JW415rIHwbiYmis5g4=
From:   Saurabh Sengar <ssengar@linux.microsoft.com>
To:     ssengar@microsoft.com, kys@microsoft.com, haiyangz@microsoft.com,
        sthemmin@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
        longli@microsoft.com, gregkh@linuxfoundation.org,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        mikelley@microsoft.com
Subject: [PATCH] uio_hv_generic: Enable interrupt for low speed VMBus devices
Date:   Thu, 13 Oct 2022 11:29:14 -0700
Message-Id: <1665685754-13971-1-git-send-email-ssengar@linux.microsoft.com>
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

Hyper-V is adding some "specialty" synthetic devices. Instead of writing
new kernel-level VMBus drivers for these devices, the devices will be
presented to user space via this existing Hyper-V generic UIO driver, so
that a user space driver can handle the device. Since these new synthetic
devices are low speed devices, they don't support monitor bits and we must
use vmbus_setevent() to enable interrupts from the host.

Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
---
 drivers/uio/uio_hv_generic.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/uio/uio_hv_generic.c b/drivers/uio/uio_hv_generic.c
index c08a6cfd119f..8e5aa4a1247f 100644
--- a/drivers/uio/uio_hv_generic.c
+++ b/drivers/uio/uio_hv_generic.c
@@ -84,6 +84,9 @@ hv_uio_irqcontrol(struct uio_info *info, s32 irq_state)
 	dev->channel->inbound.ring_buffer->interrupt_mask = !irq_state;
 	virt_mb();
 
+	if (!dev->channel->offermsg.monitor_allocated && irq_state)
+		vmbus_setevent(dev->channel);
+
 	return 0;
 }
 
@@ -239,12 +242,6 @@ hv_uio_probe(struct hv_device *dev,
 	void *ring_buffer;
 	int ret;
 
-	/* Communicating with host has to be via shared memory not hypercall */
-	if (!channel->offermsg.monitor_allocated) {
-		dev_err(&dev->device, "vmbus channel requires hypercall\n");
-		return -ENOTSUPP;
-	}
-
 	pdata = devm_kzalloc(&dev->device, sizeof(*pdata), GFP_KERNEL);
 	if (!pdata)
 		return -ENOMEM;
-- 
2.34.1

