Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A87AE24CA8F
	for <lists+linux-hyperv@lfdr.de>; Fri, 21 Aug 2020 04:20:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727905AbgHUCTj (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 20 Aug 2020 22:19:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727113AbgHUCQz (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 20 Aug 2020 22:16:55 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C122C061386;
        Thu, 20 Aug 2020 19:16:55 -0700 (PDT)
Message-Id: <20200821002946.500438544@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1597976213;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=yYVYsGIC1JN3QDzHJK9SuOYIPe5JO6p6NbW5fm8Jlzc=;
        b=3Jzoygdsjx0fIGRNdM1ePUhTi24PE4EV/PGVMS1ezdy27BoMA+xbIyyXO2uodCxEr9aves
        fdYpw1bs5rVsrgP7AzLM8VaaCXEyC8i2Zr1wpADi8xU69lwniResKlv7g7oG5aHC1Fr8HE
        MtpzX8wYGt47BBbrgvWg11m9R1mmsqh3HIurWdDPM3yx3DeXrT77uOgsk8pzdGJw81uvPA
        phYlOCS/IH9H5LQ0CraxSW2f02IkFbdRgyY8aAt6/Fr/DubfNsygAAnSMThNSyaErpwnWf
        5tLuEswY3ROAjQOn17n/LEmT1mFyMC6m0ejSEVTWjyOjHqvukv0F3HIyr6ZBhQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1597976213;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=yYVYsGIC1JN3QDzHJK9SuOYIPe5JO6p6NbW5fm8Jlzc=;
        b=JRFyeoXjz8LdEzy20vpxzfwC4fdt3ZEVXh7UmgCH3f+U5Vn496TJ+YrPyDBzBms8MW+CzY
        f0A7NXs3cE+IE1Bg==
Date:   Fri, 21 Aug 2020 02:24:36 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Steve Wahl <steve.wahl@hpe.com>,
        Dimitri Sivanich <sivanich@hpe.com>,
        Russ Anderson <rja@hpe.com>, Joerg Roedel <joro@8bytes.org>,
        iommu@lists.linux-foundation.org, linux-hyperv@vger.kernel.org,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Jon Derrick <jonathan.derrick@intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Wei Liu <wei.liu@kernel.org>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jonathan Derrick <jonathan.derrick@intel.com>,
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
Subject: [patch RFC 12/38] x86/irq: Consolidate UV domain allocation
References: <20200821002424.119492231@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline;
 filename="x86-irq--Consolidate-UV-domain-allocation.patch"
Content-transfer-encoding: 8-bit
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Move the UV specific fields into their own struct for readability sake. Get
rid of the #ifdeffery as it does not matter at all whether the alloc info
is a couple of bytes longer or not.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Steve Wahl <steve.wahl@hpe.com>
Cc:  Dimitri Sivanich <sivanich@hpe.com>
Cc: Russ Anderson <rja@hpe.com>
---
 arch/x86/include/asm/hw_irq.h |   21 ++++++++++++---------
 arch/x86/platform/uv/uv_irq.c |   16 ++++++++--------
 2 files changed, 20 insertions(+), 17 deletions(-)

--- a/arch/x86/include/asm/hw_irq.h
+++ b/arch/x86/include/asm/hw_irq.h
@@ -53,6 +53,14 @@ struct ioapic_alloc_info {
 	struct IO_APIC_route_entry	*entry;
 };
 
+struct uv_alloc_info {
+	int		limit;
+	int		blade;
+	unsigned long	offset;
+	char		*name;
+
+};
+
 /**
  * irq_alloc_info - X86 specific interrupt allocation info
  * @type:	X86 specific allocation type
@@ -64,7 +72,8 @@ struct ioapic_alloc_info {
  * @data:	Allocation specific data
  *
  * @ioapic:	IOAPIC specific allocation data
- */
+ * @uv:		UV specific allocation data
+*/
 struct irq_alloc_info {
 	enum irq_alloc_type	type;
 	u32			flags;
@@ -76,6 +85,8 @@ struct irq_alloc_info {
 
 	union {
 		struct ioapic_alloc_info	ioapic;
+		struct uv_alloc_info		uv;
+
 		int		unused;
 #ifdef	CONFIG_PCI_MSI
 		struct {
@@ -83,14 +94,6 @@ struct irq_alloc_info {
 			irq_hw_number_t	msi_hwirq;
 		};
 #endif
-#ifdef	CONFIG_X86_UV
-		struct {
-			int		uv_limit;
-			int		uv_blade;
-			unsigned long	uv_offset;
-			char		*uv_name;
-		};
-#endif
 	};
 };
 
--- a/arch/x86/platform/uv/uv_irq.c
+++ b/arch/x86/platform/uv/uv_irq.c
@@ -90,15 +90,15 @@ static int uv_domain_alloc(struct irq_do
 
 	ret = irq_domain_alloc_irqs_parent(domain, virq, nr_irqs, arg);
 	if (ret >= 0) {
-		if (info->uv_limit == UV_AFFINITY_CPU)
+		if (info->uv.limit == UV_AFFINITY_CPU)
 			irq_set_status_flags(virq, IRQ_NO_BALANCING);
 		else
 			irq_set_status_flags(virq, IRQ_MOVE_PCNTXT);
 
-		chip_data->pnode = uv_blade_to_pnode(info->uv_blade);
-		chip_data->offset = info->uv_offset;
+		chip_data->pnode = uv_blade_to_pnode(info->uv.blade);
+		chip_data->offset = info->uv.offset;
 		irq_domain_set_info(domain, virq, virq, &uv_irq_chip, chip_data,
-				    handle_percpu_irq, NULL, info->uv_name);
+				    handle_percpu_irq, NULL, info->uv.name);
 	} else {
 		kfree(chip_data);
 	}
@@ -193,10 +193,10 @@ int uv_setup_irq(char *irq_name, int cpu
 
 	init_irq_alloc_info(&info, cpumask_of(cpu));
 	info.type = X86_IRQ_ALLOC_TYPE_UV;
-	info.uv_limit = limit;
-	info.uv_blade = mmr_blade;
-	info.uv_offset = mmr_offset;
-	info.uv_name = irq_name;
+	info.uv.limit = limit;
+	info.uv.blade = mmr_blade;
+	info.uv.offset = mmr_offset;
+	info.uv.name = irq_name;
 
 	return irq_domain_alloc_irqs(domain, 1,
 				     uv_blade_to_memory_nid(mmr_blade), &info);

