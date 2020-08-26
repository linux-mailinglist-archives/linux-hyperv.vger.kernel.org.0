Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DBBD252E86
	for <lists+linux-hyperv@lfdr.de>; Wed, 26 Aug 2020 14:14:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729784AbgHZMOt (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 26 Aug 2020 08:14:49 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:57052 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729372AbgHZMBC (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 26 Aug 2020 08:01:02 -0400
Message-Id: <20200826112330.806095671@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1598443257;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=TWm8LKwbxOdbljCkicslqQNPr7yXxn0950j4VKvFXNo=;
        b=UoGPFS/7WkvtfI0hX3punHqhBhP/UK4S88ikGD8RW/yf+AurFKJjX4P4EC3wMRQEo3XlUZ
        LtujGPYmgVYq+2AdnyFhaPffxQeMmZLY5riQhmLkbyaNqb5/Tl2/vF8P4/flzxfoNve7Gd
        HvMq+AchBIH/zXZpuCw50Xyw8kZUbXsTBX1z6AM0cPb4XUIN3ZT296ZxwMS9Ftls90RKIx
        QYPHptNSZLVoIKxXnLJuhge/uZrOimnl1Bbl+174HzrumKwK3TJyXxS/LA+CUj9RLLCDum
        tDilxjDbgeG8VP1uAjLlsZFPbkEndfzcYttDAx/NS1vPFTXjsmKgSZgpI1+3tQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1598443257;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=TWm8LKwbxOdbljCkicslqQNPr7yXxn0950j4VKvFXNo=;
        b=sUrBzRDj7jLvhAKHO3Jo5Tdws9M7K35CNKNa2DKprDj7HLmFAHquotUL5w484KVxZFblZx
        8bAUtdxFXrHkzvDg==
Date:   Wed, 26 Aug 2020 13:16:30 +0200
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
Subject: [patch V2 02/46] x86/init: Remove unused init ops
References: <20200826111628.794979401@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

Some past platform removal forgot to get rid of this unused ballast.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

---
 arch/x86/include/asm/mpspec.h   |   10 ----------
 arch/x86/include/asm/x86_init.h |   10 ----------
 arch/x86/kernel/mpparse.c       |   26 ++++----------------------
 arch/x86/kernel/x86_init.c      |    4 ----
 4 files changed, 4 insertions(+), 46 deletions(-)

--- a/arch/x86/include/asm/mpspec.h
+++ b/arch/x86/include/asm/mpspec.h
@@ -67,21 +67,11 @@ static inline void find_smp_config(void)
 #ifdef CONFIG_X86_MPPARSE
 extern void e820__memblock_alloc_reserved_mpc_new(void);
 extern int enable_update_mptable;
-extern int default_mpc_apic_id(struct mpc_cpu *m);
-extern void default_smp_read_mpc_oem(struct mpc_table *mpc);
-# ifdef CONFIG_X86_IO_APIC
-extern void default_mpc_oem_bus_info(struct mpc_bus *m, char *str);
-# else
-#  define default_mpc_oem_bus_info NULL
-# endif
 extern void default_find_smp_config(void);
 extern void default_get_smp_config(unsigned int early);
 #else
 static inline void e820__memblock_alloc_reserved_mpc_new(void) { }
 #define enable_update_mptable 0
-#define default_mpc_apic_id NULL
-#define default_smp_read_mpc_oem NULL
-#define default_mpc_oem_bus_info NULL
 #define default_find_smp_config x86_init_noop
 #define default_get_smp_config x86_init_uint_noop
 #endif
--- a/arch/x86/include/asm/x86_init.h
+++ b/arch/x86/include/asm/x86_init.h
@@ -11,22 +11,12 @@ struct cpuinfo_x86;
 
 /**
  * struct x86_init_mpparse - platform specific mpparse ops
- * @mpc_record:			platform specific mpc record accounting
  * @setup_ioapic_ids:		platform specific ioapic id override
- * @mpc_apic_id:		platform specific mpc apic id assignment
- * @smp_read_mpc_oem:		platform specific oem mpc table setup
- * @mpc_oem_pci_bus:		platform specific pci bus setup (default NULL)
- * @mpc_oem_bus_info:		platform specific mpc bus info
  * @find_smp_config:		find the smp configuration
  * @get_smp_config:		get the smp configuration
  */
 struct x86_init_mpparse {
-	void (*mpc_record)(unsigned int mode);
 	void (*setup_ioapic_ids)(void);
-	int (*mpc_apic_id)(struct mpc_cpu *m);
-	void (*smp_read_mpc_oem)(struct mpc_table *mpc);
-	void (*mpc_oem_pci_bus)(struct mpc_bus *m);
-	void (*mpc_oem_bus_info)(struct mpc_bus *m, char *name);
 	void (*find_smp_config)(void);
 	void (*get_smp_config)(unsigned int early);
 };
--- a/arch/x86/kernel/mpparse.c
+++ b/arch/x86/kernel/mpparse.c
@@ -46,11 +46,6 @@ static int __init mpf_checksum(unsigned
 	return sum & 0xFF;
 }
 
-int __init default_mpc_apic_id(struct mpc_cpu *m)
-{
-	return m->apicid;
-}
-
 static void __init MP_processor_info(struct mpc_cpu *m)
 {
 	int apicid;
@@ -61,7 +56,7 @@ static void __init MP_processor_info(str
 		return;
 	}
 
-	apicid = x86_init.mpparse.mpc_apic_id(m);
+	apicid = m->apicid;
 
 	if (m->cpuflag & CPU_BOOTPROCESSOR) {
 		bootup_cpu = " (Bootup-CPU)";
@@ -73,7 +68,7 @@ static void __init MP_processor_info(str
 }
 
 #ifdef CONFIG_X86_IO_APIC
-void __init default_mpc_oem_bus_info(struct mpc_bus *m, char *str)
+static void __init mpc_oem_bus_info(struct mpc_bus *m, char *str)
 {
 	memcpy(str, m->bustype, 6);
 	str[6] = 0;
@@ -84,7 +79,7 @@ static void __init MP_bus_info(struct mp
 {
 	char str[7];
 
-	x86_init.mpparse.mpc_oem_bus_info(m, str);
+	mpc_oem_bus_info(m, str);
 
 #if MAX_MP_BUSSES < 256
 	if (m->busid >= MAX_MP_BUSSES) {
@@ -100,9 +95,6 @@ static void __init MP_bus_info(struct mp
 		mp_bus_id_to_type[m->busid] = MP_BUS_ISA;
 #endif
 	} else if (strncmp(str, BUSTYPE_PCI, sizeof(BUSTYPE_PCI) - 1) == 0) {
-		if (x86_init.mpparse.mpc_oem_pci_bus)
-			x86_init.mpparse.mpc_oem_pci_bus(m);
-
 		clear_bit(m->busid, mp_bus_not_pci);
 #ifdef CONFIG_EISA
 		mp_bus_id_to_type[m->busid] = MP_BUS_PCI;
@@ -198,8 +190,6 @@ static void __init smp_dump_mptable(stru
 			1, mpc, mpc->length, 1);
 }
 
-void __init default_smp_read_mpc_oem(struct mpc_table *mpc) { }
-
 static int __init smp_read_mpc(struct mpc_table *mpc, unsigned early)
 {
 	char str[16];
@@ -218,14 +208,7 @@ static int __init smp_read_mpc(struct mp
 	if (early)
 		return 1;
 
-	if (mpc->oemptr)
-		x86_init.mpparse.smp_read_mpc_oem(mpc);
-
-	/*
-	 *      Now process the configuration blocks.
-	 */
-	x86_init.mpparse.mpc_record(0);
-
+	/* Now process the configuration blocks. */
 	while (count < mpc->length) {
 		switch (*mpt) {
 		case MP_PROCESSOR:
@@ -256,7 +239,6 @@ static int __init smp_read_mpc(struct mp
 			count = mpc->length;
 			break;
 		}
-		x86_init.mpparse.mpc_record(1);
 	}
 
 	if (!num_processors)
--- a/arch/x86/kernel/x86_init.c
+++ b/arch/x86/kernel/x86_init.c
@@ -67,11 +67,7 @@ struct x86_init_ops x86_init __initdata
 	},
 
 	.mpparse = {
-		.mpc_record		= x86_init_uint_noop,
 		.setup_ioapic_ids	= x86_init_noop,
-		.mpc_apic_id		= default_mpc_apic_id,
-		.smp_read_mpc_oem	= default_smp_read_mpc_oem,
-		.mpc_oem_bus_info	= default_mpc_oem_bus_info,
 		.find_smp_config	= default_find_smp_config,
 		.get_smp_config		= default_get_smp_config,
 	},


