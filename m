Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0E4781933F9
	for <lists+linux-hyperv@lfdr.de>; Wed, 25 Mar 2020 23:57:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727406AbgCYW4j (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 25 Mar 2020 18:56:39 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35403 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727697AbgCYW4i (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 25 Mar 2020 18:56:38 -0400
Received: by mail-wr1-f65.google.com with SMTP id d5so5637833wrn.2;
        Wed, 25 Mar 2020 15:56:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Jlb744j2w7u2ywLc5KHbzcT2pUNmcNIuqeG5ekKAtx8=;
        b=AUly8PIvhWjtE2l0wV1QPLQnt657O6G0eElEYwR02WnCThOwx95zp18LyfEZOsOBh5
         JGo0zWWlsBD84citXhbo+2ipbNO/LrDdIjPLU2AZpw3kDT5H/091F6Hj0ALozou5el0n
         YHQUGXejMOwBUF2CDjxdJjcBZZuVfqVDXWKmRxydxqWEjEgl4T+s6n93HwYeOrS5wxS4
         X6HtICpO+L4Z6rpo2j9abIZY8AzrKWvIdCPHx+ffYZeOj7zUBjutlDBKIcmJFdlz9PAS
         BdbKziJHRsUsQyuViypIiSwkDEPTU4AQVL1uT8QHTHDI7A6skA39+4SJFCKCTpVv8Ssa
         wJQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Jlb744j2w7u2ywLc5KHbzcT2pUNmcNIuqeG5ekKAtx8=;
        b=IeT4LpEreitfOvGIUUpmAoVTB7JWvRayLENPnnqUkM6k8BKlnJ/Z3Fvoag75KwyrIy
         5TW/lwlPM9IsGmx2Bgb6zAacdO1OTzdihNTQ8LMxMlLe12z8cf0mRZGmspi+x0WoCV8T
         Ma5pLWCiyEFG/0iwvIZ9glTax5/AcxqzRS4tUQC1h5JCgLzobuZej2yOMv68h9RVc/vr
         zloyOsCsqxHu0ZRH3VFwwZF/zCsAFxBrseGbQbCx2LHdheavlXpOWTk+4VMBhJWaLOxz
         KQcTZItNftw1PG1X3KXGfhO0UJwE1v7YL6R5QBaljd77/+89Z9wgaQyCfjykfE2QQUbo
         HOYA==
X-Gm-Message-State: ANhLgQ2x8Y2EabR9aBvhmwURuHPz7QSc8+8rJO6YqgjEauCAhfNvGeTW
        Rb9qMInwJiKlXMMqasTApFzdiOJTMBEeNfyw
X-Google-Smtp-Source: ADFU+vvCKKWp/Le9zvNpGN2UiufUZrzdbC2FjPNBMmtlK8XAAmFG+9xOImKkR5d8jjHzOiFnlW9cMA==
X-Received: by 2002:a5d:6082:: with SMTP id w2mr5862380wrt.300.1585176996120;
        Wed, 25 Mar 2020 15:56:36 -0700 (PDT)
Received: from andrea.corp.microsoft.com ([86.61.236.197])
        by smtp.gmail.com with ESMTPSA id q72sm790278wme.31.2020.03.25.15.56.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2020 15:56:35 -0700 (PDT)
From:   "Andrea Parri (Microsoft)" <parri.andrea@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     "K . Y . Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, linux-hyperv@vger.kernel.org,
        Michael Kelley <mikelley@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        "Andrea Parri (Microsoft)" <parri.andrea@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: [RFC PATCH 07/11] PCI: hv: Prepare hv_compose_msi_msg() for the VMBus-channel-interrupt-to-vCPU reassignment functionality
Date:   Wed, 25 Mar 2020 23:55:01 +0100
Message-Id: <20200325225505.23998-8-parri.andrea@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200325225505.23998-1-parri.andrea@gmail.com>
References: <20200325225505.23998-1-parri.andrea@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

The current implementation of hv_compose_msi_msg() is incompatible with
the new functionality that allows changing the vCPU a VMBus channel will
interrupt: if this function always calls hv_pci_onchannelcallback() in
the polling loop, the interrupt going to a different CPU could cause
hv_pci_onchannelcallback() to be running simultaneously in a tasklet,
which will break.  The current code also has a problem in that it is not
synchronized with vmbus_reset_channel_cb(): hv_compose_msi_msg() could
be accessing the ring buffer via the call of hv_pci_onchannelcallback()
well after the time that vmbus_reset_channel_cb() has finished.

Fix these issues as follows.  Disable the channel tasklet before
entering the polling loop in hv_compose_msi_msg() and re-enable it when
done.  This will prevent hv_pci_onchannelcallback() from running in a
tasklet on a different CPU.  Moreover, poll by always calling
hv_pci_onchannelcallback(), but check the channel callback function for
NULL and invoke the callback within a sched_lock critical section.  This
will prevent hv_compose_msi_msg() from accessing the ring buffer after
vmbus_reset_channel_cb() has acquired the sched_lock spinlock.

Suggested-by: Michael Kelley <mikelley@microsoft.com>
Signed-off-by: Andrea Parri (Microsoft) <parri.andrea@gmail.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Andrew Murray <amurray@thegoodpenguin.co.uk>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: <linux-pci@vger.kernel.org>
---
 drivers/pci/controller/pci-hyperv.c | 44 ++++++++++++++++++-----------
 1 file changed, 28 insertions(+), 16 deletions(-)

diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
index 9977abff92fc5..e6020480a28b1 100644
--- a/drivers/pci/controller/pci-hyperv.c
+++ b/drivers/pci/controller/pci-hyperv.c
@@ -1350,11 +1350,11 @@ static void hv_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
 {
 	struct irq_cfg *cfg = irqd_cfg(data);
 	struct hv_pcibus_device *hbus;
+	struct vmbus_channel *channel;
 	struct hv_pci_dev *hpdev;
 	struct pci_bus *pbus;
 	struct pci_dev *pdev;
 	struct cpumask *dest;
-	unsigned long flags;
 	struct compose_comp_ctxt comp;
 	struct tran_int_desc *int_desc;
 	struct {
@@ -1372,6 +1372,7 @@ static void hv_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
 	dest = irq_data_get_effective_affinity_mask(data);
 	pbus = pdev->bus;
 	hbus = container_of(pbus->sysdata, struct hv_pcibus_device, sysdata);
+	channel = hbus->hdev->channel;
 	hpdev = get_pcichild_wslot(hbus, devfn_to_wslot(pdev->devfn));
 	if (!hpdev)
 		goto return_null_message;
@@ -1428,43 +1429,52 @@ static void hv_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
 		goto free_int_desc;
 	}
 
+	/*
+	 * Prevents hv_pci_onchannelcallback() from running concurrently
+	 * in the tasklet.
+	 */
+	tasklet_disable(&channel->callback_event);
+
 	/*
 	 * Since this function is called with IRQ locks held, can't
 	 * do normal wait for completion; instead poll.
 	 */
 	while (!try_wait_for_completion(&comp.comp_pkt.host_event)) {
+		unsigned long flags;
+
 		/* 0xFFFF means an invalid PCI VENDOR ID. */
 		if (hv_pcifront_get_vendor_id(hpdev) == 0xFFFF) {
 			dev_err_once(&hbus->hdev->device,
 				     "the device has gone\n");
-			goto free_int_desc;
+			goto enable_tasklet;
 		}
 
 		/*
-		 * When the higher level interrupt code calls us with
-		 * interrupt disabled, we must poll the channel by calling
-		 * the channel callback directly when channel->target_cpu is
-		 * the current CPU. When the higher level interrupt code
-		 * calls us with interrupt enabled, let's add the
-		 * local_irq_save()/restore() to avoid race:
-		 * hv_pci_onchannelcallback() can also run in tasklet.
+		 * Make sure that the ring buffer data structure doesn't get
+		 * freed while we dereference the ring buffer pointer.  Test
+		 * for the channel's onchannel_callback being NULL within a
+		 * sched_lock critical section.  See also the inline comments
+		 * in vmbus_reset_channel_cb().
 		 */
-		local_irq_save(flags);
-
-		if (hbus->hdev->channel->target_cpu == smp_processor_id())
-			hv_pci_onchannelcallback(hbus);
-
-		local_irq_restore(flags);
+		spin_lock_irqsave(&channel->sched_lock, flags);
+		if (unlikely(channel->onchannel_callback == NULL)) {
+			spin_unlock_irqrestore(&channel->sched_lock, flags);
+			goto enable_tasklet;
+		}
+		hv_pci_onchannelcallback(hbus);
+		spin_unlock_irqrestore(&channel->sched_lock, flags);
 
 		if (hpdev->state == hv_pcichild_ejecting) {
 			dev_err_once(&hbus->hdev->device,
 				     "the device is being ejected\n");
-			goto free_int_desc;
+			goto enable_tasklet;
 		}
 
 		udelay(100);
 	}
 
+	tasklet_enable(&channel->callback_event);
+
 	if (comp.comp_pkt.completion_status < 0) {
 		dev_err(&hbus->hdev->device,
 			"Request for interrupt failed: 0x%x",
@@ -1488,6 +1498,8 @@ static void hv_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
 	put_pcichild(hpdev);
 	return;
 
+enable_tasklet:
+	tasklet_enable(&channel->callback_event);
 free_int_desc:
 	kfree(int_desc);
 drop_reference:
-- 
2.24.0

