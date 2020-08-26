Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57CDF252E15
	for <lists+linux-hyperv@lfdr.de>; Wed, 26 Aug 2020 14:09:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729681AbgHZMIp (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 26 Aug 2020 08:08:45 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:57828 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729422AbgHZMBu (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 26 Aug 2020 08:01:50 -0400
Message-Id: <20200826112334.889315931@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1598443308;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=cykkSf24RUQJOTwuG0VyPRnlzcI597ZZ2erY9w7Z858=;
        b=zIN8rRtDstwLjSbYqoe/Wc9kD7YWmQX95g6LuqqnKZeIXL7ixEiCyQPMyyYmpK7bLDOv6a
        CgkPN1a/yxGmVb6l7wya9/+xgLgs1ILCFlVdtx/TWRP1eJHmEdFFwWDl5XqTm9f0TPMfRZ
        tw8tcz3fZEbqTuhbOutbbgGiDfdG+gMiYSlxV0vFanbSDowqFpFS1LKNWSOOr43T6mHN2Y
        hpSKYgnX+YKs5f0emn4766Na/CrJdM4iI/cGUnqVztLRfOEpSQoYP0sA+DAKMe3ykn/i6E
        aNRDbWt9tyHlJrG8TMXJ3ambkrVnYLMrF+BJ+OMDFwOJ+K+PO3VbOMIlC6vvrg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1598443308;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=cykkSf24RUQJOTwuG0VyPRnlzcI597ZZ2erY9w7Z858=;
        b=ICrYp1XTC5U4lIY5xh2joAmFwqxVGQeU3Yoo/fhXIC7eLLf62NUoErEyKCXtf8lK82iEDf
        xbeyrCK376q7yiDg==
Date:   Wed, 26 Aug 2020 13:17:11 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Joerg Roedel <joro@8bytes.org>,
        iommu@lists.linux-foundation.org, linux-hyperv@vger.kernel.org,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Jon Derrick <jonathan.derrick@intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Wei Liu <wei.liu@kernel.org>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Steve Wahl <steve.wahl@hpe.com>,
        Dimitri Sivanich <sivanich@hpe.com>,
        Russ Anderson <rja@hpe.com>, linux-pci@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        xen-devel@lists.xenproject.org, Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Megha Dey <megha.dey@intel.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Jacob Pan <jacob.jun.pan@intel.com>,
        Baolu Lu <baolu.lu@intel.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Dan Williams <dan.j.williams@intel.com>
Subject: [patch V2 43/46] genirq/msi: Provide and use
 msi_domain_set_default_info_flags()
References: <20200826111628.794979401@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

MSI interrupts have some common flags which should be set not only for
PCI/MSI interrupts.

Move the PCI/MSI flag setting into a common function so it can be reused.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
V2: New patch
---
 drivers/pci/msi.c   |    7 +------
 include/linux/msi.h |    1 +
 kernel/irq/msi.c    |   24 ++++++++++++++++++++++++
 3 files changed, 26 insertions(+), 6 deletions(-)

--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -1469,12 +1469,7 @@ struct irq_domain *pci_msi_create_irq_do
 	if (info->flags & MSI_FLAG_USE_DEF_CHIP_OPS)
 		pci_msi_domain_update_chip_ops(info);
 
-	info->flags |= MSI_FLAG_ACTIVATE_EARLY;
-	if (IS_ENABLED(CONFIG_GENERIC_IRQ_RESERVATION_MODE))
-		info->flags |= MSI_FLAG_MUST_REACTIVATE;
-
-	/* PCI-MSI is oneshot-safe */
-	info->chip->flags |= IRQCHIP_ONESHOT_SAFE;
+	msi_domain_set_default_info_flags(info);
 
 	domain = msi_create_irq_domain(fwnode, info, parent);
 	if (!domain)
--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -410,6 +410,7 @@ int platform_msi_domain_alloc(struct irq
 void platform_msi_domain_free(struct irq_domain *domain, unsigned int virq,
 			      unsigned int nvec);
 void *platform_msi_get_host_data(struct irq_domain *domain);
+void msi_domain_set_default_info_flags(struct msi_domain_info *info);
 #endif /* CONFIG_GENERIC_MSI_IRQ_DOMAIN */
 
 #ifdef CONFIG_PCI_MSI_IRQ_DOMAIN
--- a/kernel/irq/msi.c
+++ b/kernel/irq/msi.c
@@ -70,6 +70,30 @@ void get_cached_msi_msg(unsigned int irq
 EXPORT_SYMBOL_GPL(get_cached_msi_msg);
 
 #ifdef CONFIG_GENERIC_MSI_IRQ_DOMAIN
+void msi_domain_set_default_info_flags(struct msi_domain_info *info)
+{
+	/* Required so that a device latches a valid MSI message on startup */
+	info->flags |= MSI_FLAG_ACTIVATE_EARLY;
+
+	/*
+	 * Interrupt reservation mode allows to stear the MSI message of an
+	 * inactive device to a special (usually spurious interrupt) target.
+	 * This allows to prevent interrupt vector exhaustion e.g. on x86.
+	 * But (PCI)MSI interrupts are activated early - see above - so the
+	 * interrupt request/startup sequence would not try to allocate a
+	 * usable vector which means that the device interupts would end
+	 * up on the special vector and issue spurious interrupt messages.
+	 * Setting the reactivation flag ensures that when the interrupt
+	 * is requested the activation is invoked again so that a real
+	 * vector can be allocated.
+	 */
+	if (IS_ENABLED(CONFIG_GENERIC_IRQ_RESERVATION_MODE))
+		info->flags |= MSI_FLAG_MUST_REACTIVATE;
+
+	/* MSI is oneshot-safe at least in theory */
+	info->chip->flags |= IRQCHIP_ONESHOT_SAFE;
+}
+
 static inline void irq_chip_write_msi_msg(struct irq_data *data,
 					  struct msi_msg *msg)
 {

