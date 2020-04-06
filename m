Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E49E519EED9
	for <lists+linux-hyperv@lfdr.de>; Mon,  6 Apr 2020 02:17:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728055AbgDFARA (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sun, 5 Apr 2020 20:17:00 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:37147 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728041AbgDFAQ7 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Sun, 5 Apr 2020 20:16:59 -0400
Received: by mail-wm1-f68.google.com with SMTP id j19so13981187wmi.2;
        Sun, 05 Apr 2020 17:16:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Jlb744j2w7u2ywLc5KHbzcT2pUNmcNIuqeG5ekKAtx8=;
        b=RsR4m4y3pwEfhSOgVOHUOyEoyvX3CC2BMTXMrsGrlahdfTHNwZCT6ZYI8gaQSX4iyQ
         ezv60CIQgOnDJ1y4gslY2RnsAZWFvSs4D4i8AZwnUsg10Td+jMaRNt/IomF8T/ecIPrt
         9s7bKJdHW1aSMy/hOK++ClMM2UC3UNIyP3RuCKwkcstFP2en/qpcua7Q5rT8LGrc8XqH
         BOwa3iAbEo6qzneau4kHr/4vD/frTLkMvMBoxkiGm4o1hWW8szCm/5wOdfcM5eTcVWD3
         58mUw4kKU0eVihWp442e3MXpaasE19CeAH0S/j0nme27HUrB1ctCBn3yyGhDc6fNM7+t
         Tk1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Jlb744j2w7u2ywLc5KHbzcT2pUNmcNIuqeG5ekKAtx8=;
        b=btZJ+YnleA6Bw/FjrL9HhL+Sxdd7YTbFkRzoD0UW3O5PqziiKQZ4MbfUwvaYOy1RR1
         HVkNrg4IJqhxvbHcoHCmvOapmMsYvsz0GbW+vZeQR/dbYO9Wl/frYatMdDMtZyPk3f4p
         fujRNh8o6XT/nwynf6cTgNSVkaU/TDjeCKjRES4Ojp02BqaDvPBxufyvS53lhCSn8lCm
         xolj2BL3uO7GU4RdbHwx05HOXAcRyNpKNFi7IBfBr/sn/SIFbdJTJKKzxnNIFVoCygwe
         ZyNg4yKDzV7zqMt2mPGwqZ6vwftNoLXQpJ510gEWfCN0C+ht6Eso+UcVoceoHjGqYv8T
         DiTg==
X-Gm-Message-State: AGi0PuZhAo5nizfFqR8v7+mgdrzI1fyiEWgQ6B2NMsIzc9s75RDHEIWE
        DrZnbBQNljY7JnSXLMWywvzCMfmAWrKOCA==
X-Google-Smtp-Source: APiQypJDbNA+VkYAoBu9YBRVmVeTaCTmdxe3t5deA4xr6mKCLqYiH6GoFaonheb+Z+bdHLcLFAsfmA==
X-Received: by 2002:a05:600c:214b:: with SMTP id v11mr19986131wml.104.1586132217210;
        Sun, 05 Apr 2020 17:16:57 -0700 (PDT)
Received: from andrea.corp.microsoft.com ([86.61.236.197])
        by smtp.gmail.com with ESMTPSA id j9sm817432wrn.59.2020.04.05.17.16.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Apr 2020 17:16:56 -0700 (PDT)
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
Subject: [PATCH 07/11] PCI: hv: Prepare hv_compose_msi_msg() for the VMBus-channel-interrupt-to-vCPU reassignment functionality
Date:   Mon,  6 Apr 2020 02:15:10 +0200
Message-Id: <20200406001514.19876-8-parri.andrea@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200406001514.19876-1-parri.andrea@gmail.com>
References: <20200406001514.19876-1-parri.andrea@gmail.com>
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

