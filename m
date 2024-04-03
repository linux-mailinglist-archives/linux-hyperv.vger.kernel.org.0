Return-Path: <linux-hyperv+bounces-1913-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 40B688975AE
	for <lists+linux-hyperv@lfdr.de>; Wed,  3 Apr 2024 18:56:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D3C151F299F3
	for <lists+linux-hyperv@lfdr.de>; Wed,  3 Apr 2024 16:56:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11ECC152528;
	Wed,  3 Apr 2024 16:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="UxeZRb8Z"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A480C15219D;
	Wed,  3 Apr 2024 16:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712163352; cv=none; b=QTHvu0cyJigLK9UqjvRce6pPypQxWEnQYvt2SncQQoBn3sGIYGPjRYbN3YlE7y5m3bpfdBJxYRJU10377O+VSKw/fiqahDVccg2qsTz9RPlbB90pKvtrEL5tGZO64XZ94IO3PBg7k9ghtzk9iUJIXbskKFf7THyCIN9Zy/iUyIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712163352; c=relaxed/simple;
	bh=Mt/jdNcizSAPyHYbQE+rZ2V13UBG7PwrsIwZ5NwliAg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=AHPyUEWxJE07tEXgqsfg4wNwKCfbuMLimM0KX5D4FcHTPzwfyRN6kSiOmNwTHdntnX788m/XdQvO5pj8V+B2wpZSmcBI8Wt4A5YrY0evVdBPHONAtn8jHsIyCdVW1I5I6SxxK3GyGtHDQ++vBkUIuiRaj093docKr81R3a/DeR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=UxeZRb8Z; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from apais-vm1.0synte4vioeebbvidf5q0vz2ua.xx.internal.cloudapp.net (unknown [52.183.86.224])
	by linux.microsoft.com (Postfix) with ESMTPSA id 40FE920E8CB7;
	Wed,  3 Apr 2024 09:55:50 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 40FE920E8CB7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1712163350;
	bh=KCsFQpOryp/rvssUwJ8jG3/+Gvws5tiCogyEPIyhqN4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UxeZRb8Z0CNIAWXhIXLDGQc08F3fQcDabUoRuJjPN4WWRN0OHmr0eY4YucUwESYTY
	 GbnQN65udcAkQimhIDXmG/MKDCJaEvTE2vO89mS4rLYW0JJmhEPaX3CC4iV2HBfx6r
	 tOmXH6EJDLjWi470CE5USJnr5rU/VfRnH3v9HSS0=
From: Allen Pais <apais@linux.microsoft.com>
To: linux-kernel@vger.kernel.org
Cc: tj@kernel.org,
	keescook@chromium.org,
	kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	linux-hyperv@vger.kernel.org
Subject: [PATCH v2 2/2] PCI: hv: Convert from tasklet to BH workqueue
Date: Wed,  3 Apr 2024 16:55:42 +0000
Message-Id: <20240403165542.21738-2-apais@linux.microsoft.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240403165542.21738-1-apais@linux.microsoft.com>
References: <20240403165542.21738-1-apais@linux.microsoft.com>
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

This patch converts drivers/pci/pci-hyperv.c from tasklet to BH workqueue.

Based on the work done by Tejun Heo <tj@kernel.org>
Branch:https://git.kernel.org/pub/scm/linux/kernel/git/tj/wq.git for-6.10

Signed-off-by: Allen Pais <allen.lkml@gmail.com>
---
 drivers/pci/controller/pci-hyperv.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
index 5992280e8110..2823fd50a69c 100644
--- a/drivers/pci/controller/pci-hyperv.c
+++ b/drivers/pci/controller/pci-hyperv.c
@@ -50,6 +50,7 @@
 #include <linux/irqdomain.h>
 #include <linux/acpi.h>
 #include <linux/sizes.h>
+#include <linux/workqueue.h>
 #include <asm/mshyperv.h>
 
 /*
@@ -2000,7 +2001,7 @@ static void hv_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
 		udelay(100);
 	}
 
-	tasklet_enable(&channel->callback_event);
+	enable_and_queue_work(system_bh_wq, &channel->callback_event);
 
 	if (comp.comp_pkt.completion_status < 0) {
 		dev_err(&hbus->hdev->device,
@@ -2026,7 +2027,7 @@ static void hv_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
 	return;
 
 enable_tasklet:
-	tasklet_enable(&channel->callback_event);
+	enable_and_queue_work(system_bh_wq, &channel->callback_event);
 	/*
 	 * The completion packet on the stack becomes invalid after 'return';
 	 * remove the ID from the VMbus requestor if the identifier is still
@@ -3890,9 +3891,9 @@ static void hv_pci_remove(struct hv_device *hdev)
 
 	hbus = hv_get_drvdata(hdev);
 	if (hbus->state == hv_pcibus_installed) {
-		tasklet_disable(&hdev->channel->callback_event);
+		disable_work_sync(&hdev->channel->callback_event);
 		hbus->state = hv_pcibus_removing;
-		tasklet_enable(&hdev->channel->callback_event);
+		enable_and_queue_work(system_bh_wq, &hdev->channel->callback_event);
 		destroy_workqueue(hbus->wq);
 		hbus->wq = NULL;
 		/*
@@ -3948,14 +3949,14 @@ static int hv_pci_suspend(struct hv_device *hdev)
 	 * it knows that no new work item can be scheduled, and then it flushes
 	 * hbus->wq and safely closes the vmbus channel.
 	 */
-	tasklet_disable(&hdev->channel->callback_event);
+	disable_work_sync(&hdev->channel->callback_event);
 
 	/* Change the hbus state to prevent new work items. */
 	old_state = hbus->state;
 	if (hbus->state == hv_pcibus_installed)
 		hbus->state = hv_pcibus_removing;
 
-	tasklet_enable(&hdev->channel->callback_event);
+	enable_and_queue_work(system_bh_wq, &hdev->channel->callback_event);
 
 	if (old_state != hv_pcibus_installed)
 		return -EINVAL;
-- 
2.17.1


