Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1D80252E17
	for <lists+linux-hyperv@lfdr.de>; Wed, 26 Aug 2020 14:09:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729413AbgHZMBn (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 26 Aug 2020 08:01:43 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:57670 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729382AbgHZMBZ (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 26 Aug 2020 08:01:25 -0400
Message-Id: <20200826112332.163462706@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1598443273;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=mqnIcRU+8mJ14Mkki/W6mS6K78Mp2NlN7l+CkgxD+8o=;
        b=Y/9S15/F+/l+sIoxpjKT+lKY2eH9kcch+ZUeDE0/p5MBKA41C4FbGZzCr2P40FwJs+b8kH
        aP3m68Yo7e9VGLYMb7lowUb7k4nT04PUU39uphOc/8R8Aroe90mmvDy6wgiMmRn7bASjLj
        kNwm9CILE9qJXAfoDjG9Q2H9mS8mfofKpj+omGNLDF/Ti6AOkRqT/z2/s8EQRcdADxh1h4
        mNzYep3t8S6A1xmp8v0RaTVEMGCHbEw/AALmCjZ94qb8nGr7UmRmi4pUhhIECgm8RNKE7a
        zkbZRkbuTyEq14qthAKtwgAl8JKfXNRycTxUwM1LW8QwiL7iP4/GzuGSd0ywOw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1598443273;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=mqnIcRU+8mJ14Mkki/W6mS6K78Mp2NlN7l+CkgxD+8o=;
        b=DFd6NyEpm6qkQ9xT3f5z9cx+wU0ADabSVM33TuNvaWV/8ZV1/ExDQnOGUkzJskUPW+kXTJ
        lBCvwjVIBiOvpBBQ==
Date:   Wed, 26 Aug 2020 13:16:43 +0200
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
Subject: [patch V2 15/46] x86/irq: Consolidate DMAR irq allocation
References: <20200826111628.794979401@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

None of the DMAR specific fields are required.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

---
 arch/x86/include/asm/hw_irq.h |    6 ------
 arch/x86/kernel/apic/msi.c    |   10 +++++-----
 2 files changed, 5 insertions(+), 11 deletions(-)

--- a/arch/x86/include/asm/hw_irq.h
+++ b/arch/x86/include/asm/hw_irq.h
@@ -83,12 +83,6 @@ struct irq_alloc_info {
 			irq_hw_number_t	msi_hwirq;
 		};
 #endif
-#ifdef	CONFIG_DMAR_TABLE
-		struct {
-			int		dmar_id;
-			void		*dmar_data;
-		};
-#endif
 #ifdef	CONFIG_X86_UV
 		struct {
 			int		uv_limit;
--- a/arch/x86/kernel/apic/msi.c
+++ b/arch/x86/kernel/apic/msi.c
@@ -329,15 +329,15 @@ static struct irq_chip dmar_msi_controll
 static irq_hw_number_t dmar_msi_get_hwirq(struct msi_domain_info *info,
 					  msi_alloc_info_t *arg)
 {
-	return arg->dmar_id;
+	return arg->hwirq;
 }
 
 static int dmar_msi_init(struct irq_domain *domain,
 			 struct msi_domain_info *info, unsigned int virq,
 			 irq_hw_number_t hwirq, msi_alloc_info_t *arg)
 {
-	irq_domain_set_info(domain, virq, arg->dmar_id, info->chip, NULL,
-			    handle_edge_irq, arg->dmar_data, "edge");
+	irq_domain_set_info(domain, virq, arg->devid, info->chip, NULL,
+			    handle_edge_irq, arg->data, "edge");
 
 	return 0;
 }
@@ -384,8 +384,8 @@ int dmar_alloc_hwirq(int id, int node, v
 
 	init_irq_alloc_info(&info, NULL);
 	info.type = X86_IRQ_ALLOC_TYPE_DMAR;
-	info.dmar_id = id;
-	info.dmar_data = arg;
+	info.devid = id;
+	info.data = arg;
 
 	return irq_domain_alloc_irqs(domain, 1, node, &info);
 }


