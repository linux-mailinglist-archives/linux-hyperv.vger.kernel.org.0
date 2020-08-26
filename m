Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 895A7252E83
	for <lists+linux-hyperv@lfdr.de>; Wed, 26 Aug 2020 14:14:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729402AbgHZMOh (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 26 Aug 2020 08:14:37 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:57116 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729376AbgHZMBM (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 26 Aug 2020 08:01:12 -0400
Message-Id: <20200826112331.047917603@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1598443260;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=aNA6imWCCycyDoE7I/LUogJu92HNj5sOKiAANrwrDhI=;
        b=DLCrWRXadgrQCf4qFjiJ+39EHne5FXGzCP9hiodZy6C8kQ1/WBZONwRpITcKeNKBrD1AWK
        rF/EG4OJ4JLSWL/HoTIqnPXKvoPYzGcme0j15L3eojvZ2bWAiS7Mtp6MC3bxVEb0cBOUC9
        yg4BEsBD55+FiJ8p6JF3228cFuTpo4myNllLNfJ6Fh7oNyAQy3Eqj0+p/pwh4qFx+ZTFbN
        X8rK+gsgw02K975GfmmssF7oLxWMt/bW4zGm2/v0gmC9AwwlH59Uhn5HEaoAcw83sZ1qnk
        6UwasHDKTy053t1sugGUnbd9oxc0qCPpErEWb9QDItLE7iM7JBH4ygOMbYregw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1598443260;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=aNA6imWCCycyDoE7I/LUogJu92HNj5sOKiAANrwrDhI=;
        b=d/g1akpo73oJHiKD3AFk+oXcaGgFtQKzORD6f4yN1CPu2he0HCayOxiJxkUBpk9OkfVzCq
        JLPec94nQktRTKBQ==
Date:   Wed, 26 Aug 2020 13:16:32 +0200
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
Subject: [patch V2 04/46] genirq/chip: Use the first chip in
 irq_chip_compose_msi_msg()
References: <20200826111628.794979401@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

The documentation of irq_chip_compose_msi_msg() claims that with
hierarchical irq domains the first chip in the hierarchy which has an
irq_compose_msi_msg() callback is chosen. But the code just keeps
iterating after it finds a chip with a compose callback.

The x86 HPET MSI implementation relies on that behaviour, but that does not
make it more correct.

The message should always be composed at the domain which manages the
underlying resource (e.g. APIC or remap table) because that domain knows
about the required layout of the message.

On X86 the following hierarchies exist:

1)   vector -------- PCI/MSI
2)   vector -- IR -- PCI/MSI

The vector domain has a different message format than the IR (remapping)
domain. So obviously the PCI/MSI domain can't compose the message without
having knowledge about the parent domain, which is exactly the opposite of
what hierarchical domains want to achieve.

X86 actually has two different PCI/MSI chips where #1 has a compose
callback and #2 does not. #2 delegates the composition to the remap domain
where it belongs, but #1 does it at the PCI/MSI level.

For the upcoming device MSI support it's necessary to change this and just
let the first domain which can compose the message take care of it. That
way the top level chip does not have to worry about it and the device MSI
code does not need special knowledge about topologies. It just sets the
compose callback to NULL and lets the hierarchy pick the first chip which
has one.

Due to that the attempt to move the compose callback from the direct
delivery PCI/MSI domain to the vector domain made the system fail to boot
with interrupt remapping enabled because in the remapping case
irq_chip_compose_msi_msg() keeps iterating and choses the compose callback
of the vector domain which obviously creates the wrong format for the remap
table.

Break out of the loop when the first irq chip with a compose callback is
found and fixup the HPET code temporarily. That workaround will be removed
once the direct delivery compose callback is moved to the place where it
belongs in the vector domain.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
V2: New patch. Note, that this might break other stuff which relies on the
    current behaviour, but the hierarchy composition of DT based chips is
    really hard to follow.
---
 arch/x86/kernel/apic/msi.c |    7 +++++--
 kernel/irq/chip.c          |   12 +++++++++---
 2 files changed, 14 insertions(+), 5 deletions(-)

--- a/arch/x86/kernel/apic/msi.c
+++ b/arch/x86/kernel/apic/msi.c
@@ -479,10 +479,13 @@ struct irq_domain *hpet_create_irq_domai
 	info.type = X86_IRQ_ALLOC_TYPE_HPET;
 	info.hpet_id = hpet_id;
 	parent = irq_remapping_get_ir_irq_domain(&info);
-	if (parent == NULL)
+	if (parent == NULL) {
 		parent = x86_vector_domain;
-	else
+	} else {
 		hpet_msi_controller.name = "IR-HPET-MSI";
+		/* Temporary fix: Will go away */
+		hpet_msi_controller.irq_compose_msi_msg = NULL;
+	}
 
 	fn = irq_domain_alloc_named_id_fwnode(hpet_msi_controller.name,
 					      hpet_id);
--- a/kernel/irq/chip.c
+++ b/kernel/irq/chip.c
@@ -1544,10 +1544,16 @@ int irq_chip_compose_msi_msg(struct irq_
 	struct irq_data *pos = NULL;
 
 #ifdef	CONFIG_IRQ_DOMAIN_HIERARCHY
-	for (; data; data = data->parent_data)
-#endif
-		if (data->chip && data->chip->irq_compose_msi_msg)
+	for (; data; data = data->parent_data) {
+		if (data->chip && data->chip->irq_compose_msi_msg) {
 			pos = data;
+			break;
+		}
+	}
+#else
+	if (data->chip && data->chip->irq_compose_msi_msg)
+		pos = data;
+#endif
 	if (!pos)
 		return -ENOSYS;
 

