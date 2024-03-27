Return-Path: <linux-hyperv+bounces-1844-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E1B388EA77
	for <lists+linux-hyperv@lfdr.de>; Wed, 27 Mar 2024 17:06:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C93EE1F29A79
	for <lists+linux-hyperv@lfdr.de>; Wed, 27 Mar 2024 16:06:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB23C13AA32;
	Wed, 27 Mar 2024 16:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Eq00WyCo"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 255381350C0;
	Wed, 27 Mar 2024 16:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711555409; cv=none; b=foq1m74QW7dfpdNfW3CWxyqFe+qtN/FEIXkoAEmQYY3V/xBxooPr3ZF2t7JaoylT+V2NmrrvEjwnhEqT5A1A+ulmEH3ubJn2ktDGPfzhRgBiHQBmnVkXiX/MqrLmZjwHxshaL0FubgQAjOFwmc9eHXjSGhzomcOIUE1UICOHalA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711555409; c=relaxed/simple;
	bh=PV2UY3/c0kcvI9K7Nj67Wkz6PGLVP70JYChw6LM0MbU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=IFBDhzCo1Q3Hv83IaMEskswIok2yzeuoyWKzNW8mQ7LPZkqQQRUi6QZ+XqD1ehlQA3q4LRu3BivROrsgd1w51AqvGImeohAqOPVMxchpqhy9zy/AX7kHkHxHj2xpWGGdlnr5b5IG7LEZDm5N0NQp1P4n9OgfN2wtn50I2vBcZVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Eq00WyCo; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from apais-vm1.0synte4vioeebbvidf5q0vz2ua.xx.internal.cloudapp.net (unknown [52.183.86.224])
	by linux.microsoft.com (Postfix) with ESMTPSA id 24E00208B324;
	Wed, 27 Mar 2024 09:03:22 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 24E00208B324
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1711555402;
	bh=41Ale5uO1PTnfIKryTKC5pcjHNLS2gULLDrqEidl/kI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Eq00WyCo6hcxiDCDUMRPmi0qrbBDFeudu7D2o12HCiVhgx5hyPk09CSdrCwkmdexm
	 e1eYeDyIRpXMIVLQCm12FB4zn/X5Ye3TrTP4crCGnn6auu/kqknM2AUPJSVgHko5Fw
	 HOHNjfcli5SdkOKdXhCQu+gocWohTCdQFuGGhSG4=
From: Allen Pais <apais@linux.microsoft.com>
To: linux-kernel@vger.kernel.org
Cc: tj@kernel.org,
	keescook@chromium.org,
	vkoul@kernel.org,
	marcan@marcan.st,
	sven@svenpeter.dev,
	florian.fainelli@broadcom.com,
	rjui@broadcom.com,
	sbranden@broadcom.com,
	paul@crapouillou.net,
	Eugeniy.Paltsev@synopsys.com,
	manivannan.sadhasivam@linaro.org,
	vireshk@kernel.org,
	Frank.Li@nxp.com,
	leoyang.li@nxp.com,
	zw@zh-kernel.org,
	wangzhou1@hisilicon.com,
	haijie1@huawei.com,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	sean.wang@mediatek.com,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	afaerber@suse.de,
	logang@deltatee.com,
	daniel@zonque.org,
	haojian.zhuang@gmail.com,
	robert.jarzmik@free.fr,
	andersson@kernel.org,
	konrad.dybcio@linaro.org,
	orsonzhai@gmail.com,
	baolin.wang@linux.alibaba.com,
	zhang.lyra@gmail.com,
	patrice.chotard@foss.st.com,
	linus.walleij@linaro.org,
	wens@csie.org,
	jernej.skrabec@gmail.com,
	peter.ujfalusi@gmail.com,
	kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	jassisinghbrar@gmail.com,
	mchehab@kernel.org,
	maintainers@bluecherrydvr.com,
	aubin.constans@microchip.com,
	ulf.hansson@linaro.org,
	manuel.lauss@gmail.com,
	mirq-linux@rere.qmqm.pl,
	jh80.chung@samsung.com,
	oakad@yahoo.com,
	hayashi.kunihiko@socionext.com,
	mhiramat@kernel.org,
	brucechang@via.com.tw,
	HaraldWelte@viatech.com,
	pierre@ossman.eu,
	duncan.sands@free.fr,
	stern@rowland.harvard.edu,
	oneukum@suse.com,
	openipmi-developer@lists.sourceforge.net,
	dmaengine@vger.kernel.org,
	asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-rpi-kernel@lists.infradead.org,
	linux-mips@vger.kernel.org,
	imx@lists.linux.dev,
	linuxppc-dev@lists.ozlabs.org,
	linux-mediatek@lists.infradead.org,
	linux-actions@lists.infradead.org,
	linux-arm-msm@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-tegra@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-media@vger.kernel.org,
	linux-mmc@vger.kernel.org,
	linux-omap@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-s390@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-usb@vger.kernel.org
Subject: [PATCH 6/9] ipmi: Convert from tasklet to BH workqueue
Date: Wed, 27 Mar 2024 16:03:11 +0000
Message-Id: <20240327160314.9982-7-apais@linux.microsoft.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240327160314.9982-1-apais@linux.microsoft.com>
References: <20240327160314.9982-1-apais@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

The only generic interface to execute asynchronously in the BH context is
tasklet; however, it's marked deprecated and has some design flaws. To
replace tasklets, BH workqueue support was recently added. A BH workqueue
behaves similarly to regular workqueues except that the queued work items
are executed in the BH context.

This patch converts drivers/infiniband/* from tasklet to BH workqueue.

Based on the work done by Tejun Heo <tj@kernel.org>
Branch: https://git.kernel.org/pub/scm/linux/kernel/git/tj/wq.git for-6.10

Signed-off-by: Allen Pais <allen.lkml@gmail.com>
---
 drivers/char/ipmi/ipmi_msghandler.c | 30 ++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/char/ipmi/ipmi_msghandler.c b/drivers/char/ipmi/ipmi_msghandler.c
index b0eedc4595b3..fce2a2dbdc82 100644
--- a/drivers/char/ipmi/ipmi_msghandler.c
+++ b/drivers/char/ipmi/ipmi_msghandler.c
@@ -36,12 +36,13 @@
 #include <linux/nospec.h>
 #include <linux/vmalloc.h>
 #include <linux/delay.h>
+#include <linux/workqueue.h>
 
 #define IPMI_DRIVER_VERSION "39.2"
 
 static struct ipmi_recv_msg *ipmi_alloc_recv_msg(void);
 static int ipmi_init_msghandler(void);
-static void smi_recv_tasklet(struct tasklet_struct *t);
+static void smi_recv_work(struct work_struct *t);
 static void handle_new_recv_msgs(struct ipmi_smi *intf);
 static void need_waiter(struct ipmi_smi *intf);
 static int handle_one_recv_msg(struct ipmi_smi *intf,
@@ -498,13 +499,13 @@ struct ipmi_smi {
 	/*
 	 * Messages queued for delivery.  If delivery fails (out of memory
 	 * for instance), They will stay in here to be processed later in a
-	 * periodic timer interrupt.  The tasklet is for handling received
+	 * periodic timer interrupt.  The work is for handling received
 	 * messages directly from the handler.
 	 */
 	spinlock_t       waiting_rcv_msgs_lock;
 	struct list_head waiting_rcv_msgs;
 	atomic_t	 watchdog_pretimeouts_to_deliver;
-	struct tasklet_struct recv_tasklet;
+	struct work_struct recv_work;
 
 	spinlock_t             xmit_msgs_lock;
 	struct list_head       xmit_msgs;
@@ -704,7 +705,7 @@ static void clean_up_interface_data(struct ipmi_smi *intf)
 	struct cmd_rcvr  *rcvr, *rcvr2;
 	struct list_head list;
 
-	tasklet_kill(&intf->recv_tasklet);
+	cancel_work_sync(&intf->recv_work);
 
 	free_smi_msg_list(&intf->waiting_rcv_msgs);
 	free_recv_msg_list(&intf->waiting_events);
@@ -1319,7 +1320,7 @@ static void free_user(struct kref *ref)
 {
 	struct ipmi_user *user = container_of(ref, struct ipmi_user, refcount);
 
-	/* SRCU cleanup must happen in task context. */
+	/* SRCU cleanup must happen in work context. */
 	queue_work(remove_work_wq, &user->remove_work);
 }
 
@@ -3605,8 +3606,7 @@ int ipmi_add_smi(struct module         *owner,
 	intf->curr_seq = 0;
 	spin_lock_init(&intf->waiting_rcv_msgs_lock);
 	INIT_LIST_HEAD(&intf->waiting_rcv_msgs);
-	tasklet_setup(&intf->recv_tasklet,
-		     smi_recv_tasklet);
+	INIT_WORK(&intf->recv_work, smi_recv_work);
 	atomic_set(&intf->watchdog_pretimeouts_to_deliver, 0);
 	spin_lock_init(&intf->xmit_msgs_lock);
 	INIT_LIST_HEAD(&intf->xmit_msgs);
@@ -4779,7 +4779,7 @@ static void handle_new_recv_msgs(struct ipmi_smi *intf)
 			 * To preserve message order, quit if we
 			 * can't handle a message.  Add the message
 			 * back at the head, this is safe because this
-			 * tasklet is the only thing that pulls the
+			 * work is the only thing that pulls the
 			 * messages.
 			 */
 			list_add(&smi_msg->link, &intf->waiting_rcv_msgs);
@@ -4812,10 +4812,10 @@ static void handle_new_recv_msgs(struct ipmi_smi *intf)
 	}
 }
 
-static void smi_recv_tasklet(struct tasklet_struct *t)
+static void smi_recv_work(struct work_struct *t)
 {
 	unsigned long flags = 0; /* keep us warning-free. */
-	struct ipmi_smi *intf = from_tasklet(intf, t, recv_tasklet);
+	struct ipmi_smi *intf = from_work(intf, t, recv_work);
 	int run_to_completion = intf->run_to_completion;
 	struct ipmi_smi_msg *newmsg = NULL;
 
@@ -4866,7 +4866,7 @@ void ipmi_smi_msg_received(struct ipmi_smi *intf,
 
 	/*
 	 * To preserve message order, we keep a queue and deliver from
-	 * a tasklet.
+	 * a work.
 	 */
 	if (!run_to_completion)
 		spin_lock_irqsave(&intf->waiting_rcv_msgs_lock, flags);
@@ -4887,9 +4887,9 @@ void ipmi_smi_msg_received(struct ipmi_smi *intf,
 		spin_unlock_irqrestore(&intf->xmit_msgs_lock, flags);
 
 	if (run_to_completion)
-		smi_recv_tasklet(&intf->recv_tasklet);
+		smi_recv_work(&intf->recv_work);
 	else
-		tasklet_schedule(&intf->recv_tasklet);
+		queue_work(system_bh_wq, &intf->recv_work);
 }
 EXPORT_SYMBOL(ipmi_smi_msg_received);
 
@@ -4899,7 +4899,7 @@ void ipmi_smi_watchdog_pretimeout(struct ipmi_smi *intf)
 		return;
 
 	atomic_set(&intf->watchdog_pretimeouts_to_deliver, 1);
-	tasklet_schedule(&intf->recv_tasklet);
+	queue_work(system_bh_wq, &intf->recv_work);
 }
 EXPORT_SYMBOL(ipmi_smi_watchdog_pretimeout);
 
@@ -5068,7 +5068,7 @@ static bool ipmi_timeout_handler(struct ipmi_smi *intf,
 				       flags);
 	}
 
-	tasklet_schedule(&intf->recv_tasklet);
+	queue_work(system_bh_wq, &intf->recv_work);
 
 	return need_timer;
 }
-- 
2.17.1


