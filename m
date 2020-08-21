Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39EF124CA9B
	for <lists+linux-hyperv@lfdr.de>; Fri, 21 Aug 2020 04:21:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727797AbgHUCUA (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 20 Aug 2020 22:20:00 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:52550 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727793AbgHUCQu (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 20 Aug 2020 22:16:50 -0400
Message-Id: <20200821002946.102072199@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1597976208;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=HdiRwW0QBP1llYsOxuGajmw0gw4oc9eOOdN5Md9NR5A=;
        b=MMHS08LkfnEgTXsVoialrqCW9fRJ6AONkb+dykHl1E7z1jSVBMT+2LpAFmpo+8NVarXnD6
        UGbswtCAiv/cqLT2k/YprokRSvKx3qLWDhOCFaqaFqX6sO3O0F49AJVxBSrDd3E/PDWU0r
        iab+jR/ARt1/IQ7gQZ6d76rp5xop1LRLA6f5Hj8nC5kV7Hxj66YnGeCP1AW6zntjn0Ypro
        4nnTRpnlLenDCD6/DvC0Gd/8jlpZyJIEk7ZKrEuvlHlUkC1mQgeS8nyAHPnc1M7H+Vgew6
        NRR6tC+qYhzyo1jGzNFwhpjMG+JvGP6o56Nrnna4/AGsTd4yK/HI6Xi7vJpUcA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1597976208;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=HdiRwW0QBP1llYsOxuGajmw0gw4oc9eOOdN5Md9NR5A=;
        b=5yc8X5Q+KF1CbR4X6zA2pQbmGSA2jQgF397Z0fl0uy9EapMQQ5Mpzjqwtw2DtAfEb0sjFt
        qqRq0A6Mw+TS/cCQ==
Date:   Fri, 21 Aug 2020 02:24:32 +0200
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
Subject: [patch RFC 08/38] x86/irq: Prepare consolidation of irq_alloc_info
References: <20200821002424.119492231@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline;
 filename="x86-irq--Prepare-consolidation-of-irq_alloc_info.patch"
Content-transfer-encoding: 8-bit
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

struct irq_alloc_info is a horrible zoo of unnamed structs in a union. Many
of the struct fields can be generic and don't have to be type specific like
hpet_id, ioapic_id...

Provide a generic set of members to prepare for the consolidation. The goal
is to make irq_alloc_info have the same basic member as the generic
msi_alloc_info so generic MSI domain ops can be reused and yet more mess
can be avoided when (non-PCI) device MSI support comes along.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/include/asm/hw_irq.h |   22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

--- a/arch/x86/include/asm/hw_irq.h
+++ b/arch/x86/include/asm/hw_irq.h
@@ -44,10 +44,25 @@ enum irq_alloc_type {
 	X86_IRQ_ALLOC_TYPE_HPET_GET_PARENT,
 };
 
+/**
+ * irq_alloc_info - X86 specific interrupt allocation info
+ * @type:	X86 specific allocation type
+ * @flags:	Flags for allocation tweaks
+ * @devid:	Device ID for allocations
+ * @hwirq:	Associated hw interrupt number in the domain
+ * @mask:	CPU mask for vector allocation
+ * @desc:	Pointer to msi descriptor
+ * @data:	Allocation specific data
+ */
 struct irq_alloc_info {
 	enum irq_alloc_type	type;
 	u32			flags;
-	const struct cpumask	*mask;	/* CPU mask for vector allocation */
+	u32			devid;
+	irq_hw_number_t		hwirq;
+	const struct cpumask	*mask;
+	struct msi_desc		*desc;
+	void			*data;
+
 	union {
 		int		unused;
 #ifdef	CONFIG_HPET_TIMER
@@ -88,11 +103,6 @@ struct irq_alloc_info {
 			char		*uv_name;
 		};
 #endif
-#if IS_ENABLED(CONFIG_VMD)
-		struct {
-			struct msi_desc *desc;
-		};
-#endif
 	};
 };
 

