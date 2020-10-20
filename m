Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6228B283B40
	for <lists+linux-hyperv@lfdr.de>; Mon,  5 Oct 2020 17:41:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728765AbgJEPkr (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 5 Oct 2020 11:40:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727526AbgJEP3K (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 5 Oct 2020 11:29:10 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77844C0613B0;
        Mon,  5 Oct 2020 08:29:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=ZV/fjSF6pH7/wOwZLIkIDwayzPfklfK3xHDiPr3tsXE=; b=F/n2xgF71eoPpmD0cC1MVZyrFs
        c7QhheLFFmPx7bi5UCoADb8VyTFZgzLVEiMv57cdb1cTzvxz1Gs1GGpLxdw8qHJh+dFDz20N34trn
        1VaR05gqM67fz43I432j+5eoEcZv31CY/YiYyHGvW27xqFnlpGkm/aENyHQk3FcufQJPdWz5b8fyf
        8bsjjyohnQ7Yr43wdZRWIb25EkDblv/ZK+t83qMikiR6twnde1XW1D+phEnGrgq3RrhEuU3SaCecX
        JVhS9SZVTEyOU10E4ljWZ/n4Sw7TjN1+FyPftqhiymo23IciVwZvVT3gNb2wUdYI/qPUaJqOJ+686
        5Jt6/HAQ==;
Received: from i7.infradead.org ([2001:8b0:10b:1:21e:67ff:fecb:7a92])
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kPSQ4-0001mI-QF; Mon, 05 Oct 2020 15:28:57 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.93 #3 (Red Hat Linux))
        id 1kPSQ4-0045QQ-9t; Mon, 05 Oct 2020 16:28:56 +0100
From:   David Woodhouse <dwmw2@infradead.org>
To:     x86@kernel.org
Cc:     iommu <iommu@lists.linux-foundation.org>,
        kvm <kvm@vger.kernel.org>, linux-hyperv@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 04/13] x86/apic: Support 15 bits of APIC ID in IOAPIC/MSI where available
Date:   Mon,  5 Oct 2020 16:28:47 +0100
Message-Id: <20201005152856.974112-4-dwmw2@infradead.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201005152856.974112-1-dwmw2@infradead.org>
References: <77e64f977f559412f62b467fd062d051ea288f14.camel@infradead.org>
 <20201005152856.974112-1-dwmw2@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: David Woodhouse <dwmw2@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: David Woodhouse <dwmw@amazon.co.uk>

Some hypervisors can allow the guest to use the Extended Destination ID
field in the IOAPIC RTE and MSI address to address up to 32768 CPUs.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 arch/x86/include/asm/mpspec.h   |  1 +
 arch/x86/include/asm/x86_init.h |  2 ++
 arch/x86/kernel/apic/apic.c     | 15 ++++++++++++++-
 arch/x86/kernel/apic/msi.c      |  9 ++++++++-
 arch/x86/kernel/x86_init.c      |  1 +
 5 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/mpspec.h b/arch/x86/include/asm/mpspec.h
index e90ac7e9ae2c..25ee8ca0a1f2 100644
--- a/arch/x86/include/asm/mpspec.h
+++ b/arch/x86/include/asm/mpspec.h
@@ -42,6 +42,7 @@ extern DECLARE_BITMAP(mp_bus_not_pci, MAX_MP_BUSSES);
 extern unsigned int boot_cpu_physical_apicid;
 extern u8 boot_cpu_apic_version;
 extern unsigned long mp_lapic_addr;
+extern int msi_ext_dest_id;
 
 #ifdef CONFIG_X86_LOCAL_APIC
 extern int smp_found_config;
diff --git a/arch/x86/include/asm/x86_init.h b/arch/x86/include/asm/x86_init.h
index 397196fae24d..5af3fe9e38f3 100644
--- a/arch/x86/include/asm/x86_init.h
+++ b/arch/x86/include/asm/x86_init.h
@@ -114,6 +114,7 @@ struct x86_init_pci {
  * @init_platform:		platform setup
  * @guest_late_init:		guest late init
  * @x2apic_available:		X2APIC detection
+ * @msi_ext_dest_id:		MSI and IOAPIC support 15-bit APIC IDs
  * @init_mem_mapping:		setup early mappings during init_mem_mapping()
  * @init_after_bootmem:		guest init after boot allocator is finished
  */
@@ -121,6 +122,7 @@ struct x86_hyper_init {
 	void (*init_platform)(void);
 	void (*guest_late_init)(void);
 	bool (*x2apic_available)(void);
+	bool (*msi_ext_dest_id)(void);
 	void (*init_mem_mapping)(void);
 	void (*init_after_bootmem)(void);
 };
diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
index a75767052a92..459c78558f36 100644
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -1837,6 +1837,8 @@ static __init void x2apic_enable(void)
 
 static __init void try_to_enable_x2apic(int remap_mode)
 {
+	u32 apic_limit = 0;
+
 	if (x2apic_state == X2APIC_DISABLED)
 		return;
 
@@ -1858,7 +1860,15 @@ static __init void try_to_enable_x2apic(int remap_mode)
 				return;
 			}
 
-			x2apic_set_max_apicid(255);
+			/*
+			 * If the hypervisor supports extended destination ID
+			 * in IOAPIC and MSI, we can support that many CPUs.
+			 */
+			if (x86_init.hyper.msi_ext_dest_id()) {
+				msi_ext_dest_id = 1;
+				apic_limit = 32767;
+			} else
+				apic_limit = 255;
 		}
 
 		/*
@@ -1867,6 +1877,9 @@ static __init void try_to_enable_x2apic(int remap_mode)
 		 */
 		x2apic_phys = 1;
 	}
+	if (apic_limit)
+		x2apic_set_max_apicid(apic_limit);
+
 	x2apic_enable();
 }
 
diff --git a/arch/x86/kernel/apic/msi.c b/arch/x86/kernel/apic/msi.c
index 356f8acf4927..4d891967bea4 100644
--- a/arch/x86/kernel/apic/msi.c
+++ b/arch/x86/kernel/apic/msi.c
@@ -23,6 +23,8 @@
 
 struct irq_domain *x86_pci_msi_default_domain __ro_after_init;
 
+int msi_ext_dest_id __ro_after_init;
+
 static void __irq_msi_compose_msg(struct irq_cfg *cfg, struct msi_msg *msg, int dmar)
 {
 	msg->address_hi = MSI_ADDR_BASE_HI;
@@ -45,10 +47,15 @@ static void __irq_msi_compose_msg(struct irq_cfg *cfg, struct msi_msg *msg, int
 	 * Only the IOMMU itself can use the trick of putting destination
 	 * APIC ID into the high bits of the address. Anything else would
 	 * just be writing to memory if it tried that, and needs IR to
-	 * address APICs above 255.
+	 * address APICs which can't be addressed in the normal 32-bit
+	 * address range at 0xFFExxxxx. That is typically just 8 bits, but
+	 * some hypervisors allow the extended destination ID field in bits
+	 * 11-5 to be used, giving support for 15 bits of APIC IDs in total.
 	 */
 	if (dmar)
 		msg->address_hi |= MSI_ADDR_EXT_DEST_ID(cfg->dest_apicid);
+	else if (msi_ext_dest_id && cfg->dest_apicid < 0x8000)
+		msg->address_lo |= MSI_ADDR_EXT_DEST_ID(cfg->dest_apicid) >> 3;
 	else
 		WARN_ON_ONCE(MSI_ADDR_EXT_DEST_ID(cfg->dest_apicid));
 }
diff --git a/arch/x86/kernel/x86_init.c b/arch/x86/kernel/x86_init.c
index a3038d8deb6a..8b395821cb8d 100644
--- a/arch/x86/kernel/x86_init.c
+++ b/arch/x86/kernel/x86_init.c
@@ -110,6 +110,7 @@ struct x86_init_ops x86_init __initdata = {
 		.init_platform		= x86_init_noop,
 		.guest_late_init	= x86_init_noop,
 		.x2apic_available	= bool_x86_init_noop,
+		.msi_ext_dest_id	= bool_x86_init_noop,
 		.init_mem_mapping	= x86_init_noop,
 		.init_after_bootmem	= x86_init_noop,
 	},
-- 
2.26.2

