Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0712260C031
	for <lists+linux-hyperv@lfdr.de>; Tue, 25 Oct 2022 02:53:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230483AbiJYAw4 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 24 Oct 2022 20:52:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230470AbiJYAwm (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 24 Oct 2022 20:52:42 -0400
Received: from na01-obe.outbound.protection.outlook.com (mail-eastusazon11021017.outbound.protection.outlook.com [52.101.52.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A12A57F0BB;
        Mon, 24 Oct 2022 16:34:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TggHWbgrfqvHVF/WPFNyo1g3Jxo7sjqzkVAzl9lCGOzQ4LaEUU/DAZKdF/A1hjYRMN0mAhxFakj72r8V5ptp6HxAgyEor6Pff7JiNvQat+VP9lIgIyJYInwb02aJnNk3UQZPtUY/6F5n6aHv9PEvzeDFZdrs1Nc0hLsxc1mp0N+z/H8LcJoe9pq1Kz0xtp70iUz1MqKxwn1eV5PlP2fpCyWWRvahyMk453G+clSe/omV0bEQsbCu7s8P84MQt2OVtYQGQuIwSRfj/Y2YJnKtPCpl8s1CS/1TzLN8hIvANrde8F28IminDVfnp66zAVPkLAuYjcu5AE0CF1o0U775uQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JADUYvjeC0ZHyleCSWXD/S9+Oj/3Lvidr/OqMhMJYmY=;
 b=bNuAZI4yQsyFPAv5R9LggdJspWPW3EWyvNXWdAWIAkwo49a5NMrLvcIk/kmUs7/DJ9p4ttQ9O0URAvU473Z6TcDW8PapZ4v+uaGh+KQkwQEWvsdlfBcxz/2krxsJhGPN005yWHV1usO9ezwCqxzarxE/ylSNvMhAq0ksmAxPb6cIjGWkIdCVTTiqg3bUDamZHBXNLpNLFjC6IlTlX6iiDi6PydDf6RFnGznEIys5RTGfmq1YYWnTlXpLUIPsML4l0+b8OPTpfZXoN/nuPZBa5jq1bR42OWOTO0EQVkboFCmoPP3guu093IAA/Emt2zs02EhEaHfufD1ZLLNOgefgrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JADUYvjeC0ZHyleCSWXD/S9+Oj/3Lvidr/OqMhMJYmY=;
 b=RJn+IKpa4DcSbc0ei7NZJVrfRM2WIK+ESTp+D1p4zBjFoZIzHsTWu0c9Tbj1AFT/abht3YlEXdxn5sIrMPvEyNN03OCd6Tl11ejfQ02L19HHFXB4zDPQBhgrohdA0Cu2G6FrSVqPHZpENQJuk8TmBFSCrvgfzmgTu5MXiDOJp4U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
Received: from BL0PR2101MB1092.namprd21.prod.outlook.com
 (2603:10b6:207:30::23) by IA1PR21MB3642.namprd21.prod.outlook.com
 (2603:10b6:208:3e1::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.6; Mon, 24 Oct
 2022 23:34:17 +0000
Received: from BL0PR2101MB1092.namprd21.prod.outlook.com
 ([fe80::a746:e3bf:9f88:152f]) by BL0PR2101MB1092.namprd21.prod.outlook.com
 ([fe80::a746:e3bf:9f88:152f%8]) with mapi id 15.20.5746.015; Mon, 24 Oct 2022
 23:34:17 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     quic_jhugo@quicinc.com, quic_carlv@quicinc.com, wei.liu@kernel.org,
        kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        lpieralisi@kernel.org, bhelgaas@google.com,
        linux-hyperv@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, mikelley@microsoft.com,
        robh@kernel.org, kw@linux.com, helgaas@kernel.org,
        alex.williamson@redhat.com, boqun.feng@gmail.com,
        Boqun.Feng@microsoft.com
Cc:     Dexuan Cui <decui@microsoft.com>
Subject: [PATCH v2] PCI: hv: Only reuse existing IRTE allocation for Multi-MSI
Date:   Mon, 24 Oct 2022 16:33:42 -0700
Message-Id: <20221024233342.22758-1-decui@microsoft.com>
X-Mailer: git-send-email 2.17.1
Reply-To: decui@microsoft.com
Content-Type: text/plain
X-ClientProxiedBy: MW2PR16CA0017.namprd16.prod.outlook.com (2603:10b6:907::30)
 To BL0PR2101MB1092.namprd21.prod.outlook.com (2603:10b6:207:30::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR2101MB1092:EE_|IA1PR21MB3642:EE_
X-MS-Office365-Filtering-Correlation-Id: b047b204-395c-4502-5d6a-08dab6184461
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: u8KtnuStLZzS26ORAbM9/NcOKt9gS68QqnMYRz1lMVuXs+bSbT9vCAQW7oS1wV/Vnax/tu4wZBkjZ/MQohW1P9gsBfnv12+94Il0eBVN68aHb8lFTEQl3cU1hY2DkO9mGbaoXKS/d247AMi7G8EAwZlSXGJ+EcTXZDJbS3eWN/960AryY8NkdIr0IgcS2Jv+0BZwUPn4mtE5KHcK+Snu9fisSzKtU+Il0IN5K37Ep4sGvpzwqfzWI6dRo/uoIdoKxirUhV4a/eF9EVApxbabSq38whZf2Q8f5LFXAwVutYZwNq4NNIdawBeqC7UoFN+kCuXeJDNiCF2e3CfWNZjxwnJFmXX6DxN84EL9LdakHjf6lJOnTGNcZjqK8vm6n9sSSvdohdRCis2731KcrjQCb2l4RFG1rN7oh+BMXaLB5EyPLVkm59CPDntAeA1eMKTqMhesoZPoZNnWDO7N8rd0cuLPoYjOxl/GTnjtYV7ZbwbY4tICmedQj9vBQ+ZUIjOUOw+dSz70DbszxTInpLY6LUQ51J6LpCJI4P63QO8k/Cx+x3RBD5lE34nDVRPW4EEAi7icK1DI5qnt8I3bfSisv9828pEbldGAuqz2jG+xVDDVK/zQXs1yVsNSLVBsTUUmplKns7aGn3LgpaeOps213Go5qg0fYgc5fB6AkA9XCHe0ZEGV97fydWbmH1cGtTM3c+9UdpGuXvVa+HYAiRKARjIhGYRQwYemEpLffa9OHV/rEyNPMI0Qp9hZGBcE8YEPe0WgEalfkiIruLvyzdhSVTgwewtXkLagDXk07cCyTfDPabR9mnUEVbuol6WPJtBu
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR2101MB1092.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(39860400002)(396003)(136003)(366004)(346002)(451199015)(966005)(921005)(478600001)(6486002)(38100700002)(82950400001)(8936002)(10290500003)(6636002)(41300700001)(316002)(82960400001)(36756003)(66556008)(3450700001)(6666004)(83380400001)(2906002)(86362001)(8676002)(107886003)(52116002)(7416002)(1076003)(186003)(66946007)(2616005)(6506007)(4326008)(66476007)(5660300002)(6512007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Kd/HuaA7m4D6jOYrbi2c55S/7BiLNxrjC7LDarj2aeDeo+dxpH0VP7NG+WOP?=
 =?us-ascii?Q?7U4RCJpvKzWPKoOE4wMLAeygkFhRFlDetLcSLnz/kQJrZOWXjhrS/eznzX6C?=
 =?us-ascii?Q?q5QQ+E8bM1uappj7zrLukTlTpLhl6g1WGh7SVQeiG/LsUq2y8WuZu8joZ3dG?=
 =?us-ascii?Q?j4lnyIOf+bPDpPHjLnMCSf9UApOxCiS6OpmqOENXEwD2XcT3gDP/mAZJrOqn?=
 =?us-ascii?Q?E89OMBIdmvYZwMBvqolrjYUNvUzfBXUH4bCMFtor6JLeDo0Iyvfjxe5cqi7X?=
 =?us-ascii?Q?WvETsGrP/C91WPdMlk3gZMOJZAWzsMKRMPpFziGbyWtnZKwt7K1iFUXV+otn?=
 =?us-ascii?Q?ZLiNnPAGWF/ji5QHPqSN7yITukgGHxbPRAL2JCKfEt1ItQD3bNUALJMDFB9r?=
 =?us-ascii?Q?VnNpwgvSr+pPPsvK0MOnS9tJC7Zo8V9bmvzYM4M68usK4KfIObtOsdlayR8m?=
 =?us-ascii?Q?ufBU32dTvLP0Zi2+AoJSIYk1GuAIUW8MnA83L4KHL2LhFx71zDf/N0UWaOuv?=
 =?us-ascii?Q?j1qL/UlmfONX6yDnDqS9QB1ju85SSpmj5UxPVN/daBwPzzT+0CeIN7NDovZN?=
 =?us-ascii?Q?r4rONCp53s2OyF6HpOVsXqOgK3kpj6Hg7eMwO46i91Lw3BQkIK1hOncqvBQ1?=
 =?us-ascii?Q?XS0s/jwRiJc5tHrM7kCIdwQI/WJE5odqlD5xkPlIPBTJjH16VFVBcvmfgrD+?=
 =?us-ascii?Q?b+mmGDW7Lr2i4BOVBRDfTTAx/aMWHicUu2C2XiRdXmVGO5KSy/zrk3L62NhS?=
 =?us-ascii?Q?jtPUIa96KGZ1p7XFRmNPUbpvCGA6h+HpcgX0P/MOmZJW3GPo5qG5asm/tfWB?=
 =?us-ascii?Q?k+BSRydni1M1hsTM4+OHn9qpIyFf3XIU0CM0/YTWtANgjgj0pimSTrTPl0Mc?=
 =?us-ascii?Q?IkY3XRWfqON1i86YVtduP+0m7ukuAfgRHLKGkSlxw2Yhl6p7NgbzK3qyoFb0?=
 =?us-ascii?Q?+FkmtUOoKvkzlEU5fv1jpDPKdOxWjd0fva/oc2CWG4Kk5YFkthmzjb8MTt4N?=
 =?us-ascii?Q?eIHQQVxqxE5RYVh1OrP9+ruWhW9bjU46qGNCguyVYhYiqG7tvTyF2jDCLHe/?=
 =?us-ascii?Q?toiwCFXvkm1ZoyeMhvbvIR6RpxamkVT7B1Oyt8yftO6AOdGRzdQ0TXOhim3U?=
 =?us-ascii?Q?4a7MM35m+4VjOb+TWcEygMm0Rdt/biKpfjDcujPITYBB+oH+YBSHuQztmsrZ?=
 =?us-ascii?Q?6X6ar723XchdzwURQVS5xcKZpN/C/X6UQD1/5LuMuPimcWyU/hdEtwfp3Wiq?=
 =?us-ascii?Q?nWVhtc/uMHtdYJnE3j+Z347NeqmMVJvMDgluQk8B9hbewnrCUPWUZu1rUAVA?=
 =?us-ascii?Q?uISGriBRUDBBu55A8LXwlIFfSOk2swxhy4cOpff0a/uLFz0OQAh/f924+SWg?=
 =?us-ascii?Q?7e9r6l+HcFltI0X6EH1uadmF1HcaFiBQzr7KCGEonJKPBWqng0HQG90JFYe5?=
 =?us-ascii?Q?HXK+p+jiTjwqJxV3EC+3EUFGclNvasHHSnyrdQKdCITIpAwfNcN22nzuqpVF?=
 =?us-ascii?Q?OJXo0ggdUHteYb+5StCtHpUa1X6DkTuzl/k89h20F41lMGPBEmgo0BPJ4j2g?=
 =?us-ascii?Q?oZtdEPCZDqoMxixYHEsEGi1/LEPMvdafNh4ny270VrIKuJ65Q571PULspngP?=
 =?us-ascii?Q?1T2RuB8T8SvM0xiROG+p0FF26o7WwUb6tSCovm0NhZgf?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b047b204-395c-4502-5d6a-08dab6184461
X-MS-Exchange-CrossTenant-AuthSource: BL0PR2101MB1092.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2022 23:34:17.2798
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eu0oNovB2sh0zfSBXuc6p0M9U4YrNCetHRDZ17pxanPUTvJ7q1b0OSHxy/bgV70A/E5ebQHuBchwaU7/WM5/uw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR21MB3642
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Jeffrey added Multi-MSI support to the pci-hyperv driver by the 4 patches:
08e61e861a0e ("PCI: hv: Fix multi-MSI to allow more than one MSI vector")
455880dfe292 ("PCI: hv: Fix hv_arch_irq_unmask() for multi-MSI")
b4b77778ecc5 ("PCI: hv: Reuse existing IRTE allocation in compose_msi_msg()")
a2bad844a67b ("PCI: hv: Fix interrupt mapping for multi-MSI")

It turns out that the third patch (b4b77778ecc5) causes a performance
regression because all the interrupts now happen on 1 physical CPU (or two
pCPUs, if one pCPU doesn't have enough vectors). When a guest has many PCI
devices, it may suffer from soft lockups if the workload is heavy, e.g.,
see https://lwn.net/ml/linux-kernel/20220804025104.15673-1-decui@microsoft.com/

Commit b4b77778ecc5 itself is good. The real issue is that the hypercall in
hv_irq_unmask() -> hv_arch_irq_unmask() ->
hv_do_hypercall(HVCALL_RETARGET_INTERRUPT...) only changes the target
virtual CPU rather than physical CPU; with b4b77778ecc5, the pCPU is
determined only once in hv_compose_msi_msg() where only vCPU0 is specified;
consequently the hypervisor only uses 1 target pCPU for all the interrupts.

Note: before b4b77778ecc5, the pCPU is determined twice, and when the pCPU
is determinted the second time, the vCPU in the effective affinity mask is
used (i.e., it isn't always vCPU0), so the hypervisor chooses a different
pCPU for each interrupt.

The hypercall will be fixed in future to update the pCPU as well, but
that will take quite a while, so let's restore the old behavior in
hv_compose_msi_msg(), i.e., don't reuse the existing IRTE allocation for
single-MSI and MSI-X; for multi-MSI, we choose the vCPU in a round-robin
manner for each PCI device, so the interrupts of different devices can
happen on different pCPUs, though the interrupts of each device happen on
some single pCPU.

The hypercall fix may not be backported to all old versions of Hyper-V, so
we want to have this guest side change for ever (or at least till we're sure
the old affected versions of Hyper-V are no longer supported).

Fixes: b4b77778ecc5 ("PCI: hv: Reuse existing IRTE allocation in compose_msi_msg()")
Co-developed-by: Jeffrey Hugo <quic_jhugo@quicinc.com>
Signed-off-by: Jeffrey Hugo <quic_jhugo@quicinc.com>
Co-developed-by: Carl Vanderlip <quic_carlv@quicinc.com>
Signed-off-by: Carl Vanderlip <quic_carlv@quicinc.com>
Signed-off-by: Dexuan Cui <decui@microsoft.com>

---
v1 is here:
  https://lwn.net/ml/linux-kernel/20220804025104.15673-1-decui@microsoft.com/

Changes in v2:
  round-robin the vCPU for multi-MSI.
  The commit message is re-worked.
  Added Jeff and Carl's Co-developed-by and Signed-off-by.


 drivers/pci/controller/pci-hyperv.c | 61 ++++++++++++++++++++++-------
 1 file changed, 46 insertions(+), 15 deletions(-)

diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
index e7c6f6629e7c..7ac080f95259 100644
--- a/drivers/pci/controller/pci-hyperv.c
+++ b/drivers/pci/controller/pci-hyperv.c
@@ -1613,7 +1613,7 @@ static void hv_pci_compose_compl(void *context, struct pci_response *resp,
 }
 
 static u32 hv_compose_msi_req_v1(
-	struct pci_create_interrupt *int_pkt, const struct cpumask *affinity,
+	struct pci_create_interrupt *int_pkt,
 	u32 slot, u8 vector, u8 vector_count)
 {
 	int_pkt->message_type.type = PCI_CREATE_INTERRUPT_MESSAGE;
@@ -1640,18 +1640,39 @@ static int hv_compose_msi_req_get_cpu(const struct cpumask *affinity)
 	return cpumask_first_and(affinity, cpu_online_mask);
 }
 
-static u32 hv_compose_msi_req_v2(
-	struct pci_create_interrupt2 *int_pkt, const struct cpumask *affinity,
-	u32 slot, u8 vector, u8 vector_count)
+/*
+ * Make sure the dummy vCPU values for multi-MSI don't all point to vCPU0.
+ */
+static int hv_compose_multi_msi_req_get_cpu(void)
 {
+	static DEFINE_SPINLOCK(multi_msi_cpu_lock);
+
+	/* -1 means starting with CPU 0 */
+	static int cpu_next = -1;
+
+	unsigned long flags;
 	int cpu;
 
+	spin_lock_irqsave(&multi_msi_cpu_lock, flags);
+
+	cpu_next = cpumask_next_wrap(cpu_next, cpu_online_mask, nr_cpu_ids,
+				     false);
+	cpu = cpu_next;
+
+	spin_unlock_irqrestore(&multi_msi_cpu_lock, flags);
+
+	return cpu;
+}
+
+static u32 hv_compose_msi_req_v2(
+	struct pci_create_interrupt2 *int_pkt, int cpu,
+	u32 slot, u8 vector, u8 vector_count)
+{
 	int_pkt->message_type.type = PCI_CREATE_INTERRUPT_MESSAGE2;
 	int_pkt->wslot.slot = slot;
 	int_pkt->int_desc.vector = vector;
 	int_pkt->int_desc.vector_count = vector_count;
 	int_pkt->int_desc.delivery_mode = DELIVERY_MODE;
-	cpu = hv_compose_msi_req_get_cpu(affinity);
 	int_pkt->int_desc.processor_array[0] =
 		hv_cpu_number_to_vp_number(cpu);
 	int_pkt->int_desc.processor_count = 1;
@@ -1660,18 +1681,15 @@ static u32 hv_compose_msi_req_v2(
 }
 
 static u32 hv_compose_msi_req_v3(
-	struct pci_create_interrupt3 *int_pkt, const struct cpumask *affinity,
+	struct pci_create_interrupt3 *int_pkt, int cpu,
 	u32 slot, u32 vector, u8 vector_count)
 {
-	int cpu;
-
 	int_pkt->message_type.type = PCI_CREATE_INTERRUPT_MESSAGE3;
 	int_pkt->wslot.slot = slot;
 	int_pkt->int_desc.vector = vector;
 	int_pkt->int_desc.reserved = 0;
 	int_pkt->int_desc.vector_count = vector_count;
 	int_pkt->int_desc.delivery_mode = DELIVERY_MODE;
-	cpu = hv_compose_msi_req_get_cpu(affinity);
 	int_pkt->int_desc.processor_array[0] =
 		hv_cpu_number_to_vp_number(cpu);
 	int_pkt->int_desc.processor_count = 1;
@@ -1710,12 +1728,18 @@ static void hv_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
 			struct pci_create_interrupt3 v3;
 		} int_pkts;
 	} __packed ctxt;
+	bool multi_msi;
 	u64 trans_id;
 	u32 size;
 	int ret;
+	int cpu;
+
+	msi_desc  = irq_data_get_msi_desc(data);
+	multi_msi = !msi_desc->pci.msi_attrib.is_msix &&
+		    msi_desc->nvec_used > 1;
 
 	/* Reuse the previous allocation */
-	if (data->chip_data) {
+	if (data->chip_data && multi_msi) {
 		int_desc = data->chip_data;
 		msg->address_hi = int_desc->address >> 32;
 		msg->address_lo = int_desc->address & 0xffffffff;
@@ -1723,7 +1747,6 @@ static void hv_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
 		return;
 	}
 
-	msi_desc  = irq_data_get_msi_desc(data);
 	pdev = msi_desc_to_pci_dev(msi_desc);
 	dest = irq_data_get_effective_affinity_mask(data);
 	pbus = pdev->bus;
@@ -1733,11 +1756,18 @@ static void hv_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
 	if (!hpdev)
 		goto return_null_message;
 
+	/* Free any previous message that might have already been composed. */
+	if (data->chip_data && !multi_msi) {
+		int_desc = data->chip_data;
+		data->chip_data = NULL;
+		hv_int_desc_free(hpdev, int_desc);
+	}
+
 	int_desc = kzalloc(sizeof(*int_desc), GFP_ATOMIC);
 	if (!int_desc)
 		goto drop_reference;
 
-	if (!msi_desc->pci.msi_attrib.is_msix && msi_desc->nvec_used > 1) {
+	if (multi_msi) {
 		/*
 		 * If this is not the first MSI of Multi MSI, we already have
 		 * a mapping.  Can exit early.
@@ -1762,9 +1792,11 @@ static void hv_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
 		 */
 		vector = 32;
 		vector_count = msi_desc->nvec_used;
+		cpu = hv_compose_multi_msi_req_get_cpu();
 	} else {
 		vector = hv_msi_get_int_vector(data);
 		vector_count = 1;
+		cpu = hv_compose_msi_req_get_cpu(dest);
 	}
 
 	memset(&ctxt, 0, sizeof(ctxt));
@@ -1775,7 +1807,6 @@ static void hv_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
 	switch (hbus->protocol_version) {
 	case PCI_PROTOCOL_VERSION_1_1:
 		size = hv_compose_msi_req_v1(&ctxt.int_pkts.v1,
-					dest,
 					hpdev->desc.win_slot.slot,
 					vector,
 					vector_count);
@@ -1784,7 +1815,7 @@ static void hv_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
 	case PCI_PROTOCOL_VERSION_1_2:
 	case PCI_PROTOCOL_VERSION_1_3:
 		size = hv_compose_msi_req_v2(&ctxt.int_pkts.v2,
-					dest,
+					cpu,
 					hpdev->desc.win_slot.slot,
 					vector,
 					vector_count);
@@ -1792,7 +1823,7 @@ static void hv_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
 
 	case PCI_PROTOCOL_VERSION_1_4:
 		size = hv_compose_msi_req_v3(&ctxt.int_pkts.v3,
-					dest,
+					cpu,
 					hpdev->desc.win_slot.slot,
 					vector,
 					vector_count);
-- 
2.25.1

