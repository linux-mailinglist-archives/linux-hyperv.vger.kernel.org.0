Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBA6124CA8B
	for <lists+linux-hyperv@lfdr.de>; Fri, 21 Aug 2020 04:20:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727084AbgHUCT3 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 20 Aug 2020 22:19:29 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:52488 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727849AbgHUCRB (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 20 Aug 2020 22:17:01 -0400
Message-Id: <20200821002946.982695529@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1597976219;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=mCqKSi3fy8ExwYtATAttVbUTM8VvxHS3vlXvJsftOtw=;
        b=aKS5lAGS5ICSii2yx/d+iI9vMr1TvMV6r1bAMpnFaLBPzLpprqV5C2sjipiRq2dRuzhRiY
        Az6dslm3aVt4hPbEyKkI/D9eWyVHd27CLerF0Ton1pdq5TwNkWnNGd/kJISan8R49Ot7ZB
        sWJoFZLYcCFpjGGPo7Jcov0/WMrmV8a45snuLmRBKEneXpuNC6PulemnGlTOjvmH52PJwN
        P6J37XWmZ1FnqSkWFS4YJ5HsiRXDbni3J5QlKfWYvwc6g0xqojb7tE8NdT9asatHPJ1Rvm
        BX9whaNMTWkolxgA+W6rN9UBEQ5UGb11Zi1AOgw7iX0qzCnAt9bA7MYUBjmGDA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1597976219;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=mCqKSi3fy8ExwYtATAttVbUTM8VvxHS3vlXvJsftOtw=;
        b=WDwJDz3XYNRtoThpdQR9sTE4mZZIR7w9oJFDzo4JCrHmGb/5G0PJkUtPZlyqOmPU4yudO2
        OY/aUoq64F7uSMDw==
Date:   Fri, 21 Aug 2020 02:24:41 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, linux-pci@vger.kernel.org,
        Joerg Roedel <joro@8bytes.org>,
        iommu@lists.linux-foundation.org, linux-hyperv@vger.kernel.org,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Jon Derrick <jonathan.derrick@intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Wei Liu <wei.liu@kernel.org>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Steve Wahl <steve.wahl@hpe.com>,
        Dimitri Sivanich <sivanich@hpe.com>,
        Russ Anderson <rja@hpe.com>,
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
Subject: [patch RFC 17/38] x86/pci: Reducde #ifdeffery in PCI init code
References: <20200821002424.119492231@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline;
 filename="x86-pci--Reducde-#ifdeffery-in-PCI-init-code.patch"
Content-transfer-encoding: 8-bit
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Adding a function call before the first #ifdef in arch_pci_init() triggers
a 'mixed declarations and code' warning if PCI_DIRECT is enabled.

Use stub functions and move the #ifdeffery to the header file where it is
not in the way.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-pci@vger.kernel.org
---
 arch/x86/include/asm/pci_x86.h |   11 +++++++++++
 arch/x86/pci/init.c            |   10 +++-------
 2 files changed, 14 insertions(+), 7 deletions(-)

--- a/arch/x86/include/asm/pci_x86.h
+++ b/arch/x86/include/asm/pci_x86.h
@@ -114,9 +114,20 @@ extern const struct pci_raw_ops pci_dire
 extern bool port_cf9_safe;
 
 /* arch_initcall level */
+#ifdef CONFIG_PCI_DIRECT
 extern int pci_direct_probe(void);
 extern void pci_direct_init(int type);
+#else
+static inline int pci_direct_probe(void) { return -1; }
+static inline  void pci_direct_init(int type) { }
+#endif
+
+#ifdef CONFIG_PCI_BIOS
 extern void pci_pcbios_init(void);
+#else
+static inline void pci_pcbios_init(void) { }
+#endif
+
 extern void __init dmi_check_pciprobe(void);
 extern void __init dmi_check_skip_isa_align(void);
 
--- a/arch/x86/pci/init.c
+++ b/arch/x86/pci/init.c
@@ -8,11 +8,9 @@
    in the right sequence from here. */
 static __init int pci_arch_init(void)
 {
-#ifdef CONFIG_PCI_DIRECT
-	int type = 0;
+	int type;
 
 	type = pci_direct_probe();
-#endif
 
 	if (!(pci_probe & PCI_PROBE_NOEARLY))
 		pci_mmcfg_early_init();
@@ -20,18 +18,16 @@ static __init int pci_arch_init(void)
 	if (x86_init.pci.arch_init && !x86_init.pci.arch_init())
 		return 0;
 
-#ifdef CONFIG_PCI_BIOS
 	pci_pcbios_init();
-#endif
+
 	/*
 	 * don't check for raw_pci_ops here because we want pcbios as last
 	 * fallback, yet it's needed to run first to set pcibios_last_bus
 	 * in case legacy PCI probing is used. otherwise detecting peer busses
 	 * fails.
 	 */
-#ifdef CONFIG_PCI_DIRECT
 	pci_direct_init(type);
-#endif
+
 	if (!raw_pci_ops && !raw_pci_ext_ops)
 		printk(KERN_ERR
 		"PCI: Fatal: No config space access function found\n");

