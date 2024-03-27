Return-Path: <linux-hyperv+bounces-1843-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45BD188EB58
	for <lists+linux-hyperv@lfdr.de>; Wed, 27 Mar 2024 17:32:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 89787B3420B
	for <lists+linux-hyperv@lfdr.de>; Wed, 27 Mar 2024 16:05:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B55D137C5C;
	Wed, 27 Mar 2024 16:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="hZ9tbK6a"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F512132814;
	Wed, 27 Mar 2024 16:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711555408; cv=none; b=Ak6HxIvNUSFoZoDQh9Ot+SVi6nQEVEI4Gc4ZcPnQn5Ardy2/kvdd5LHhh11tJb3XYLeOHt9Ao1OIFDSXq9LRX07NrRtQc87lDYJidRRTUKQXoGd4WXgRt8z5L5lHZxN/HbhHAbW7ZTDz1ClRfCJiTuG+0GbBeDHJPMZjh2Ae6D0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711555408; c=relaxed/simple;
	bh=1Q4EWIa5g/nNt+E6EF3kD+vIDvgX6CborVSkr1jP72A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=FdqYW92JAAMOdxXymBweMN7EsEptSHwrGltmGHd7pwsEO9pfCgKDTq9pMJ4VG1VyF7/TBphNAj+rI65qHX9aAnj2U1Qfhk02Ixev6iN1Zo7693w9cuwDH/Hfgy0K7I5OfY+EIVMmEF+FUCFQY0OuL2PBuVjDAIJtoW8EdibqzqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=hZ9tbK6a; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from apais-vm1.0synte4vioeebbvidf5q0vz2ua.xx.internal.cloudapp.net (unknown [52.183.86.224])
	by linux.microsoft.com (Postfix) with ESMTPSA id EA6502087EAD;
	Wed, 27 Mar 2024 09:03:21 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com EA6502087EAD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1711555402;
	bh=gG4HkPGUSv7UfrkIT/fLFeBn/l/I1IKATXvhPYPLyTc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hZ9tbK6alrLBbs0gi/RA/rTTHk4Szr/ALK9qb/ljV5Z39ltd2AcQcwhzALpCC1wKd
	 GIeCnfcSDRZCYwM84p9o8SFEII+jFkZGxJDmCb1a1V3QFisDxrwsPRClaYIO9y61bo
	 AS1FoX6+/lM0tmj1WVEb896g3y43UOh3+1q2HAqg=
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
Subject: [PATCH 5/9] mailbox: Convert from tasklet to BH workqueue
Date: Wed, 27 Mar 2024 16:03:10 +0000
Message-Id: <20240327160314.9982-6-apais@linux.microsoft.com>
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
 drivers/mailbox/bcm-pdc-mailbox.c | 21 +++++++++++----------
 drivers/mailbox/imx-mailbox.c     | 16 ++++++++--------
 2 files changed, 19 insertions(+), 18 deletions(-)

diff --git a/drivers/mailbox/bcm-pdc-mailbox.c b/drivers/mailbox/bcm-pdc-mailbox.c
index 1768d3d5aaa0..242e7504a628 100644
--- a/drivers/mailbox/bcm-pdc-mailbox.c
+++ b/drivers/mailbox/bcm-pdc-mailbox.c
@@ -43,6 +43,7 @@
 #include <linux/dma-direction.h>
 #include <linux/dma-mapping.h>
 #include <linux/dmapool.h>
+#include <linux/workqueue.h>
 
 #define PDC_SUCCESS  0
 
@@ -293,8 +294,8 @@ struct pdc_state {
 
 	unsigned int pdc_irq;
 
-	/* tasklet for deferred processing after DMA rx interrupt */
-	struct tasklet_struct rx_tasklet;
+	/* work for deferred processing after DMA rx interrupt */
+	struct work_struct rx_work;
 
 	/* Number of bytes of receive status prior to each rx frame */
 	u32 rx_status_len;
@@ -952,18 +953,18 @@ static irqreturn_t pdc_irq_handler(int irq, void *data)
 	iowrite32(intstatus, pdcs->pdc_reg_vbase + PDC_INTSTATUS_OFFSET);
 
 	/* Wakeup IRQ thread */
-	tasklet_schedule(&pdcs->rx_tasklet);
+	queue_work(system_bh_wq, &pdcs->rx_work);
 	return IRQ_HANDLED;
 }
 
 /**
- * pdc_tasklet_cb() - Tasklet callback that runs the deferred processing after
+ * pdc_work_cb() - Work callback that runs the deferred processing after
  * a DMA receive interrupt. Reenables the receive interrupt.
  * @t: Pointer to the Altera sSGDMA channel structure
  */
-static void pdc_tasklet_cb(struct tasklet_struct *t)
+static void pdc_work_cb(struct work_struct *t)
 {
-	struct pdc_state *pdcs = from_tasklet(pdcs, t, rx_tasklet);
+	struct pdc_state *pdcs = from_work(pdcs, t, rx_work);
 
 	pdc_receive(pdcs);
 
@@ -1577,8 +1578,8 @@ static int pdc_probe(struct platform_device *pdev)
 
 	pdc_hw_init(pdcs);
 
-	/* Init tasklet for deferred DMA rx processing */
-	tasklet_setup(&pdcs->rx_tasklet, pdc_tasklet_cb);
+	/* Init work for deferred DMA rx processing */
+	INIT_WORK(&pdcs->rx_work, pdc_work_cb);
 
 	err = pdc_interrupts_init(pdcs);
 	if (err)
@@ -1595,7 +1596,7 @@ static int pdc_probe(struct platform_device *pdev)
 	return PDC_SUCCESS;
 
 cleanup_buf_pool:
-	tasklet_kill(&pdcs->rx_tasklet);
+	cancel_work_sync(&pdcs->rx_work);
 	dma_pool_destroy(pdcs->rx_buf_pool);
 
 cleanup_ring_pool:
@@ -1611,7 +1612,7 @@ static void pdc_remove(struct platform_device *pdev)
 
 	pdc_free_debugfs();
 
-	tasklet_kill(&pdcs->rx_tasklet);
+	cancel_work_sync(&pdcs->rx_work);
 
 	pdc_hw_disable(pdcs);
 
diff --git a/drivers/mailbox/imx-mailbox.c b/drivers/mailbox/imx-mailbox.c
index 5c1d09cad761..933727f89431 100644
--- a/drivers/mailbox/imx-mailbox.c
+++ b/drivers/mailbox/imx-mailbox.c
@@ -21,6 +21,7 @@
 #include <linux/pm_runtime.h>
 #include <linux/suspend.h>
 #include <linux/slab.h>
+#include <linux/workqueue.h>
 
 #include "mailbox.h"
 
@@ -80,7 +81,7 @@ struct imx_mu_con_priv {
 	char			irq_desc[IMX_MU_CHAN_NAME_SIZE];
 	enum imx_mu_chan_type	type;
 	struct mbox_chan	*chan;
-	struct tasklet_struct	txdb_tasklet;
+	struct work_struct 	txdb_work;
 };
 
 struct imx_mu_priv {
@@ -232,7 +233,7 @@ static int imx_mu_generic_tx(struct imx_mu_priv *priv,
 		break;
 	case IMX_MU_TYPE_TXDB:
 		imx_mu_xcr_rmw(priv, IMX_MU_GCR, IMX_MU_xCR_GIRn(priv->dcfg->type, cp->idx), 0);
-		tasklet_schedule(&cp->txdb_tasklet);
+		queue_work(system_bh_wq, &cp->txdb_work);
 		break;
 	case IMX_MU_TYPE_TXDB_V2:
 		imx_mu_xcr_rmw(priv, IMX_MU_GCR, IMX_MU_xCR_GIRn(priv->dcfg->type, cp->idx), 0);
@@ -420,7 +421,7 @@ static int imx_mu_seco_tx(struct imx_mu_priv *priv, struct imx_mu_con_priv *cp,
 		}
 
 		/* Simulate hack for mbox framework */
-		tasklet_schedule(&cp->txdb_tasklet);
+		queue_work(system_bh_wq, &cp->txdb_work);
 
 		break;
 	default:
@@ -484,9 +485,9 @@ static int imx_mu_seco_rxdb(struct imx_mu_priv *priv, struct imx_mu_con_priv *cp
 	return err;
 }
 
-static void imx_mu_txdb_tasklet(unsigned long data)
+static void imx_mu_txdb_work(struct work_struct *t)
 {
-	struct imx_mu_con_priv *cp = (struct imx_mu_con_priv *)data;
+	struct imx_mu_con_priv *cp = from_work(cp, t, txdb_work);
 
 	mbox_chan_txdone(cp->chan, 0);
 }
@@ -570,8 +571,7 @@ static int imx_mu_startup(struct mbox_chan *chan)
 
 	if (cp->type == IMX_MU_TYPE_TXDB) {
 		/* Tx doorbell don't have ACK support */
-		tasklet_init(&cp->txdb_tasklet, imx_mu_txdb_tasklet,
-			     (unsigned long)cp);
+		INIT_WORK(&cp->txdb_work, imx_mu_txdb_work);
 		return 0;
 	}
 
@@ -615,7 +615,7 @@ static void imx_mu_shutdown(struct mbox_chan *chan)
 	}
 
 	if (cp->type == IMX_MU_TYPE_TXDB) {
-		tasklet_kill(&cp->txdb_tasklet);
+		cancel_work_sync(&cp->txdb_work);
 		pm_runtime_put_sync(priv->dev);
 		return;
 	}
-- 
2.17.1


