Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3336D45F816
	for <lists+linux-hyperv@lfdr.de>; Sat, 27 Nov 2021 02:20:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344993AbhK0BXz (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 26 Nov 2021 20:23:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344471AbhK0BVy (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 26 Nov 2021 20:21:54 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40B7CC06173E;
        Fri, 26 Nov 2021 17:18:41 -0800 (PST)
Message-ID: <20211126223824.263656943@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1637975919;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=7H7+YC/Q3X3DUjW7OFUmpmZxFX8YbEmXXunUPCxWTOo=;
        b=Q/BWnFgpqlk/Xfzvk8Enumd9Tv9t7JEEp0DHi4rSBSx9/fQFTFOMhfhrRh+HvFyTryJZg6
        2H6cR7D0a+EEDQ8oQg0OU7d/nbqiZhQyNFyo4bhXjmQLINx5jNITNbKUROyMi6k5AylsFk
        GuHYww9m3gcDcaQkDt89XO76miQ2YMD954fX/YwE6Q6bHL3HhsHaFps2ULrwJQWThfnBPG
        3yUvPsmNh5MonSc8cW1Dzr6keAHLf3o1bfK6y28a4Y/W5AQZNjHBs9tfcg+nJDTYJSjRF0
        mmE0bpwDggg4+Lb75ngYAkUXqkaFYQLfA0sUdXi6vjtaa9R6ZCz5sQ03QYCLSg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1637975919;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=7H7+YC/Q3X3DUjW7OFUmpmZxFX8YbEmXXunUPCxWTOo=;
        b=lOPEaRrjbm3G3ojV4Pxdg64aaahnAv+fh0zcGZd7hniH2wr2smlEjYaa9TlnTbAnZ42z1s
        Y9bOJ0tKC/T204Cg==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, Marc Zygnier <maz@kernel.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Megha Dey <megha.dey@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, linux-pci@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        linuxppc-dev@lists.ozlabs.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        sparclinux@vger.kernel.org, x86@kernel.org,
        xen-devel@lists.xenproject.org, ath11k@lists.infradead.org,
        Wei Liu <wei.liu@kernel.org>, linux-hyperv@vger.kernel.org,
        Juergen Gross <jgross@suse.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>
Subject: [patch 03/22] genirq/msi: Guard sysfs code
References: <20211126222700.862407977@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Sat, 27 Nov 2021 02:18:39 +0100 (CET)
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

No point in building unused code when CONFIG_SYSFS=n.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/msi.h |   10 ++++++++++
 kernel/irq/msi.c    |    2 ++
 2 files changed, 12 insertions(+)

--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -239,9 +239,19 @@ void __pci_write_msi_msg(struct msi_desc
 void pci_msi_mask_irq(struct irq_data *data);
 void pci_msi_unmask_irq(struct irq_data *data);
 
+#ifdef CONFIG_SYSFS
 const struct attribute_group **msi_populate_sysfs(struct device *dev);
 void msi_destroy_sysfs(struct device *dev,
 		       const struct attribute_group **msi_irq_groups);
+#else
+static inline const struct attribute_group **msi_populate_sysfs(struct device *dev)
+{
+	return NULL;
+}
+static inline void msi_destroy_sysfs(struct device *dev, const struct attribute_group **msi_irq_groups)
+{
+}
+#endif
 
 /*
  * The arch hooks to setup up msi irqs. Default functions are implemented
--- a/kernel/irq/msi.c
+++ b/kernel/irq/msi.c
@@ -72,6 +72,7 @@ void get_cached_msi_msg(unsigned int irq
 }
 EXPORT_SYMBOL_GPL(get_cached_msi_msg);
 
+#ifdef CONFIG_SYSFS
 static ssize_t msi_mode_show(struct device *dev, struct device_attribute *attr,
 			     char *buf)
 {
@@ -204,6 +205,7 @@ void msi_destroy_sysfs(struct device *de
 		kfree(msi_irq_groups);
 	}
 }
+#endif
 
 #ifdef CONFIG_GENERIC_MSI_IRQ_DOMAIN
 static inline void irq_chip_write_msi_msg(struct irq_data *data,

