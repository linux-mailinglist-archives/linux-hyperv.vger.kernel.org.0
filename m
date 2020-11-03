Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 284952A3839
	for <lists+linux-hyperv@lfdr.de>; Tue,  3 Nov 2020 02:12:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725932AbgKCBMN (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 2 Nov 2020 20:12:13 -0500
Received: from mail-bn7nam10on2107.outbound.protection.outlook.com ([40.107.92.107]:62433
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726018AbgKCBMM (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 2 Nov 2020 20:12:12 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fohqok693nG4ds9zGUDBy91O0dIsJrj02SaMdWFkr2CDRLl7XPsNbVhcae7irdPiCFIZoYgbmpwI7WiYJk4ZDP7vZLK9c6w+9Kx/giYUbRCI5/ZuUj5zQgLsL6iGx0uZduHU1M3o1qDDZSdQUx1qTTUMnzw8+uuEfMrUsgplsrkqJXL+cHdj0GoMD7+gyh6AaQE5J4xluOcohnJKxkNyznuXj6o+kqVx8PsE1b7hsyPVUqXUdSMzLhd8afkP/UK9F8tAmsBetxqHst5I8nkQlYtIe+JZNdmBoHScI47OyPivJP3pbNfmEqY6M+EGiF9GNt4krepIyGtzAhP9phAiug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TQ8AmuAhb70oxCEstXEGFETIgXD5RXXPdWs2t1GLwUE=;
 b=dJbf8V9qdQi8ONbIofvLJLxB3EM//Y5kjk0AGNkD1SFrL5BfUBOX4/CE0sdwtJWQRH0zPeUMC/Y3tjiPQkp/MIVjSbop0IGPjnDolGW35y8LwHXyPGh3Elvc/RIzeAWY/KM5rJSOhN/F1y0117oowW2vO3RtbfayVvDWu1dE4fKFfl8YfE/58EhiTXAGW/WNozx5cTXMN2wFs3v4ESIuw8VN0YpXmiLxeuSNdszMkJYGc+AZYkJrB43pRTbMdlvNoxQ0Jt1XXoUjToPdhtiLtahNeA3TGTCSuWUo4JjXSxKtOiqgqCMawJHfhqH3pQB4pEkmjN5OcZ8xtahHI9BInA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TQ8AmuAhb70oxCEstXEGFETIgXD5RXXPdWs2t1GLwUE=;
 b=GW8+20/0PxrTRExSTDOLbyqeBu+Bdyc45sx6odWheUez7qslxpJfBKtRDGq3SA4TZdwRRqYl3ZWdfsDGDb0V1rT877SusOQ3IZPccIv+C0c9npiz7NnKSvKio8edNHPo9pBUMBq/j4vm4bt5ggM55UpBEUslnG3vFtbgvpEpPIU=
Authentication-Results: linutronix.de; dkim=none (message not signed)
 header.d=none;linutronix.de; dmarc=none action=none
 header.from=microsoft.com;
Received: from BN6PR21MB0162.namprd21.prod.outlook.com (2603:10b6:404:94::8)
 by BN8PR21MB1187.namprd21.prod.outlook.com (2603:10b6:408:75::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.3; Tue, 3 Nov
 2020 01:12:09 +0000
Received: from BN6PR21MB0162.namprd21.prod.outlook.com
 ([fe80::3df3:ac80:4646:a495]) by BN6PR21MB0162.namprd21.prod.outlook.com
 ([fe80::3df3:ac80:4646:a495%9]) with mapi id 15.20.3564.006; Tue, 3 Nov 2020
 01:12:08 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     tglx@linutronix.de, dwmw2@infradead.org, x86@kernel.org,
        decui@microsoft.com, mikelley@microsoft.com,
        linux-hyperv@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Tianyu.Lan@microsoft.com,
        vkuznets@redhat.com, kys@microsoft.com, haiyangz@microsoft.com,
        sthemmin@microsoft.com, wei.liu@kernel.org, mingo@redhat.com,
        bp@alien8.de, hpa@zytor.com
Subject: [PATCH] x86/hyperv: Enable 15-bit APIC ID if the hypervisor supports it
Date:   Mon,  2 Nov 2020 17:11:36 -0800
Message-Id: <20201103011136.59108-1-decui@microsoft.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-Originating-IP: [2001:4898:80e8:3:20ae:548a:2d45:d7f2]
X-ClientProxiedBy: MWHPR19CA0059.namprd19.prod.outlook.com
 (2603:10b6:300:94::21) To BN6PR21MB0162.namprd21.prod.outlook.com
 (2603:10b6:404:94::8)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from decui-u1804.corp.microsoft.com (2001:4898:80e8:3:20ae:548a:2d45:d7f2) by MWHPR19CA0059.namprd19.prod.outlook.com (2603:10b6:300:94::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.19 via Frontend Transport; Tue, 3 Nov 2020 01:12:05 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: b871ee6e-26a2-4179-a839-08d87f957b7b
X-MS-TrafficTypeDiagnostic: BN8PR21MB1187:
X-MS-Exchange-Transport-Forked: True
X-LD-Processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
X-Microsoft-Antispam-PRVS: <BN8PR21MB1187D7A5A1521D3AC30761D4BF110@BN8PR21MB1187.namprd21.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ehloyPRzDolyvQRZjgBUonwqXRJwukYYNd2JQ05P4eWbkhBbH9GckWntY8JIfPOHNQUBFEotoaiMp7nC//BDTdKmURNPTzWWPNNwNAu0eRgSVrWye0pfKoVHa1ozMNQIgHPtCEL/5FjwDIBsE/9PDjNuno02tOWHohX5AqwDFT2ZnymKi7jbAnzlU1ekMLP89S7tBBqZA8cd0wpz+gC9zEw4wyEbBrU1qg3BwIVXKpUWKOiePuMY4gPqkXcCPYu0gPmOhnVDze145auIGsMkZibe6y6p5lTOvBVNCHqAJMQmHQkUpIhX+6RH2dksJfrVBgpnJsoPPDoIq0VVv14Cgg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR21MB0162.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(39860400002)(346002)(136003)(366004)(376002)(316002)(52116002)(8676002)(8936002)(83380400001)(7696005)(36756003)(82950400001)(5660300002)(2616005)(6666004)(2906002)(10290500003)(82960400001)(86362001)(4326008)(66556008)(6486002)(16526019)(478600001)(66946007)(7416002)(66476007)(1076003)(186003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: 75IDJq49rbEYVNZEPVOUXN3Ni3YDXOOb96mKevLGZM1Z0UlrXBVcS7AjwECMN9iHaOLNxeeHXZyDZYT7xRMalHcpbd4G8Dp4w/CKreTAcZdrekTh7rND0evVhNEQBI2L8+ymkFoszcIGH/BiC0hiXymlAqR3SA/HTR/77a3c+TXQk9c61JF6GTX9JjaQRhtIG25EcFx6o+s063XLgkyq3ETVA/wf/7IK/fkikg4OXzjXJUgePpvIY3B81gy1DJe6SNWjLOyqEmHepMOBrvNml8h7ygSy2AdUkSvk2wz/bURrULFQC8NZWb9RonkPaRZBs/sM/w4vcfDUHEBEs2egnaM/0TYGRPy1+xvRbxJOXrnzThLjvbKfr2lAebf8MpmhgGIJ0WifDmW7abloZccE/+KOHlBVkQQigfUyqOSDpo0G1E6yfHOUbRgkVslwgDjOuRxVPybq13d94dfXwLda/2V6i5zsz2T8rBI77A+Ad0g875Qf9KEyErs6Gb3jYma86Igd5YudKk7xjfU0ml1SjKXkV3Y1qlo78NtuH7MKeCecGVaHN8CoHKr7PFh+tyUwF3jSbQanHk69EForEPvskpiQdSGze6L/sQKtC2ima0PyrXqaTzb1maJBzonkYJcbcUgYrPHtSbQYDX7cK8yKpPpkTo3zMQDfo6ES2KMYclqoKnkj747B3dJp5HQRvwOnivlOyymb1BhfUIEut1IHUA==
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b871ee6e-26a2-4179-a839-08d87f957b7b
X-MS-Exchange-CrossTenant-AuthSource: BN6PR21MB0162.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2020 01:12:07.5819
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SyWf2JNkKnFM94ssN1Pe+wv/1rRp2VhWrtNPe+0P3hxIBfZnzfotmuKri7t3+3ZEaeb25WqE32+AhFm0Hvl29w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR21MB1187
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

When a Linux VM runs on Hyper-V, if the VM has CPUs with >255 APIC IDs,
the CPUs can't be the destination of IOAPIC interrupts, because the
IOAPIC RTE's Dest Field has only 8 bits. Currently the hackery driver
drivers/iommu/hyperv-iommu.c is used to ensure IOAPIC interrupts are
only routed to CPUs that don't have >255 APIC IDs. However, there is
an issue with kdump, because the kdump kernel can run on any CPU, and
hence IOAPIC interrupts can't work if the kdump kernel run on a CPU
with a >255 APIC ID.

The kdump issue can be fixed by the Extended Dest ID, which is introduced
recently by David Woodhouse (for IOAPIC, see the field virt_destid_8_14 in
struct IO_APIC_route_entry). Of course, the Extended Dest ID needs the
support of the underlying hypervisor. The latest Hyper-V has added the
support recently: with this commit, on such a Hyper-V host, Linux VM
does not use hyperv-iommu.c because hyperv_prepare_irq_remapping()
returns -ENODEV; instead, Linux kernel's generic support of Extended Dest
ID from David is used, meaning that Linux VM is able to support up to
32K CPUs, and IOAPIC interrupts can be routed to all the CPUs.

On an old Hyper-V host that doesn't support the Extended Dest ID, nothing
changes with this commit: Linux VM is still able to bring up the CPUs with
>255 APIC IDs with the help of hyperv-iommu.c, but IOAPIC interrupts still
can not go to such CPUs, and the kdump kernel still can not work properly
on such CPUs.

Signed-off-by: Dexuan Cui <decui@microsoft.com>
---
 arch/x86/include/asm/hyperv-tlfs.h |  7 +++++++
 arch/x86/kernel/cpu/mshyperv.c     | 30 ++++++++++++++++++++++++++++++
 2 files changed, 37 insertions(+)

diff --git a/arch/x86/include/asm/hyperv-tlfs.h b/arch/x86/include/asm/hyperv-tlfs.h
index 0ed20e8bba9e..6bf42aed387e 100644
--- a/arch/x86/include/asm/hyperv-tlfs.h
+++ b/arch/x86/include/asm/hyperv-tlfs.h
@@ -23,6 +23,13 @@
 #define HYPERV_CPUID_IMPLEMENT_LIMITS		0x40000005
 #define HYPERV_CPUID_NESTED_FEATURES		0x4000000A
 
+#define HYPERV_CPUID_VIRT_STACK_INTERFACE	0x40000081
+#define HYPERV_VS_INTERFACE_EAX_SIGNATURE	0x31235356  /* "VS#1" */
+
+#define HYPERV_CPUID_VIRT_STACK_PROPERTIES	0x40000082
+/* Support for the extended IOAPIC RTE format */
+#define HYPERV_VS_PROPERTIES_EAX_EXTENDED_IOAPIC_RTE	BIT(2)
+
 #define HYPERV_HYPERVISOR_PRESENT_BIT		0x80000000
 #define HYPERV_CPUID_MIN			0x40000005
 #define HYPERV_CPUID_MAX			0x4000ffff
diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
index 05ef1f4550cb..cc4037d841df 100644
--- a/arch/x86/kernel/cpu/mshyperv.c
+++ b/arch/x86/kernel/cpu/mshyperv.c
@@ -366,9 +366,39 @@ static void __init ms_hyperv_init_platform(void)
 #endif
 }
 
+static bool __init ms_hyperv_x2apic_available(void)
+{
+	return x2apic_supported();
+}
+
+/*
+ * If ms_hyperv_msi_ext_dest_id() returns true, hyperv_prepare_irq_remapping()
+ * returns -ENODEV and the Hyper-V IOMMU driver is not used; instead, the
+ * generic support of the 15-bit APIC ID is used: see __irq_msi_compose_msg().
+ *
+ * Note: For a VM on Hyper-V, no emulated legacy device supports PCI MSI/MSI-X,
+ * and PCI MSI/MSI-X only come from the assigned physical PCIe device, and the
+ * PCI MSI/MSI-X interrupts are handled by the pci-hyperv driver. Here despite
+ * the word "msi" in the name "msi_ext_dest_id", actually the callback only
+ * affects how IOAPIC interrupts are routed.
+ */
+static bool __init ms_hyperv_msi_ext_dest_id(void)
+{
+	u32 eax;
+
+	eax = cpuid_eax(HYPERV_CPUID_VIRT_STACK_INTERFACE);
+	if (eax != HYPERV_VS_INTERFACE_EAX_SIGNATURE)
+		return false;
+
+	eax = cpuid_eax(HYPERV_CPUID_VIRT_STACK_PROPERTIES);
+	return eax & HYPERV_VS_PROPERTIES_EAX_EXTENDED_IOAPIC_RTE;
+}
+
 const __initconst struct hypervisor_x86 x86_hyper_ms_hyperv = {
 	.name			= "Microsoft Hyper-V",
 	.detect			= ms_hyperv_platform,
 	.type			= X86_HYPER_MS_HYPERV,
+	.init.x2apic_available	= ms_hyperv_x2apic_available,
+	.init.msi_ext_dest_id	= ms_hyperv_msi_ext_dest_id,
 	.init.init_platform	= ms_hyperv_init_platform,
 };
-- 
2.25.1

