Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B43892441CC
	for <lists+linux-hyperv@lfdr.de>; Fri, 14 Aug 2020 01:52:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726531AbgHMXw2 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 13 Aug 2020 19:52:28 -0400
Received: from mail-co1nam11on2094.outbound.protection.outlook.com ([40.107.220.94]:16481
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726526AbgHMXw2 (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 13 Aug 2020 19:52:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DgKt4nv2IWkt3qiyHfWghdO/QKj8gmzDeUqyJVUsdgtEGg1EC+UJZpgOZOCRXnpd2/RQMRX7MNvdd7ahhBZSD7N8mvdPjZRAE+a1NnZJg5GsOvOK4S+8LZsruo1QO+x2JGf++I5Iljy0I1NI9ECGiUYaqF2kESVJRZyPiucir8b6Im2SSq9pb+ETtMFEbo99GQyfLfXHBySNPZ6GQQpwgEO0MW/ME45/UYrfxpZvDgDIK9zYUWD2bUgIOxcaZu6EoqwlboBeqqCWo31F2r3IvYWjhpiHYzH2WKtKCMQbR+ZgGDjqJJrpZW8KiOnJDl+5Wl2RqhbH6i+AP7iyKT6V+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lgl0cnxEHYWOg9ueojKdQrrlaygdOEXckqjQsB6zuKo=;
 b=PY3ITpSLjVg4rOdqXq7g6cbgcxSQRX49OKdbvPLZ6/QPleXt6rFz5X9MIrRDJM0coKcuwFA6RGt3R8yBHIIFSz7Bawr0Dy4nd3KDXrqyc+vDnV9DnCuMPk3vWw9SDFjqebGEI1am7F9RUO5GLAr8wPr3/9ANS+jUtXAqf/u21c8bXbFmKheA6EvT7W/XewmNrteLifUDgcZ5KbOFZ66bY4CvCQP7JeMD/uL1rwaW7J4hLentuGJHunhrSdcCoGN6em5stbeESDaFDRowBmwWJmGIK0HdbIYoYT6r0GU+aUV7ZnlV25ZXJ42JCgCHMaArHYjkZMZfOhlUCmTmkW176Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lgl0cnxEHYWOg9ueojKdQrrlaygdOEXckqjQsB6zuKo=;
 b=YgQdDgBQX/TDW8ZFalF1i+xkqZ/AuABO0wPDpYiM35Gv5wi9RF9zm5B8ruxd8GTYvd+3koPagUHTYGVHySMfCLbeZlhPYQWjbR+zc6d2M+yOnLl2OlV0hRbgdkEoKaLE4+JYvJEhBTDV2AYcNMqAuFOBQdt1q002emiVVOPveeM=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=microsoft.com;
Received: from BN8PR21MB1281.namprd21.prod.outlook.com (2603:10b6:408:a2::19)
 by BN6PR21MB0467.namprd21.prod.outlook.com (2603:10b6:404:b2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.2; Thu, 13 Aug
 2020 23:52:23 +0000
Received: from BN8PR21MB1281.namprd21.prod.outlook.com
 ([fe80::dc81:a9b8:7413:2ff9]) by BN8PR21MB1281.namprd21.prod.outlook.com
 ([fe80::dc81:a9b8:7413:2ff9%3]) with mapi id 15.20.3305.016; Thu, 13 Aug 2020
 23:52:23 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     linux-kernel@vger.kernel.org, kys@microsoft.com,
        sthemmin@microsoft.com, wei.liu@kernel.org,
        linux-hyperv@vger.kernel.org
Cc:     mikelley@microsoft.com, tglx@linutronix.de, peterz@infradead.org,
        mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com
Subject: [PATCH 1/1] Drivers: hv: vmbus: Add parsing of VMbus interrupt in ACPI DSDT
Date:   Thu, 13 Aug 2020 16:51:19 -0700
Message-Id: <1597362679-37965-1-git-send-email-mikelley@microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Content-Type: text/plain
X-ClientProxiedBy: MWHPR22CA0060.namprd22.prod.outlook.com
 (2603:10b6:300:12a::22) To BN8PR21MB1281.namprd21.prod.outlook.com
 (2603:10b6:408:a2::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by MWHPR22CA0060.namprd22.prod.outlook.com (2603:10b6:300:12a::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.15 via Frontend Transport; Thu, 13 Aug 2020 23:52:21 +0000
X-Mailer: git-send-email 1.8.3.1
X-Originating-IP: [131.107.159.16]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 656c520d-db46-414d-add9-08d83fe3ec5d
X-MS-TrafficTypeDiagnostic: BN6PR21MB0467:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN6PR21MB046750FC3AE7555C38BCCBC0D7430@BN6PR21MB0467.namprd21.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vbEX4UfvUGfpwziuAR8wiLONtxo3R91lDpkj619q4clSmKK3WBj27z3+l/8aDs1MhtBYwrdkni8nF8sCFk/Z0mTTU4GjqP5FWaJa4psJ8k19qLT3lGDNPesYmonygKr6sfxnbODzcwbnBZOK82S+mqZ7L6njIt52FwCdGpjC2oTzST8hufT3cR8/S3UdnpNmjeNqokGny4LDHfjS1MRDqlxfELin2S/kZhE7/pZwDpnGVHqGvoNMJ5GZs22gae5cW+9WCrXoIqcHs0ogHphPHnbpYx4nOESvUqpaTi/hofd3cnUgiGtO2OOKIffSoqUVa6L8zfzXKADuR/Vg+Wo2mk2Vc32/KqWUhbzQHXO2syKdfOlhg0ET5lqAAUkmKS20
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR21MB1281.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(376002)(346002)(136003)(39860400002)(396003)(2616005)(956004)(66556008)(66476007)(5660300002)(66946007)(8676002)(6486002)(8936002)(36756003)(86362001)(2906002)(83380400001)(16576012)(316002)(110011004)(478600001)(52116002)(186003)(10290500003)(4326008)(82950400001)(82960400001)(26005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: 6biTiXUD3Hsf7ex9LeXfJeT8r42iTijdDxik5cdbPqMUyOF3qRzgVuM0GycaEDzAmsQj7gxN5zv6G4mQTl7kYX7bXTq8sDULCrknx9mcMtwlM0LvcsvKvMCZUPCwKbfX4BtluJ8yGN06GzSjzpw1xHspny6EPUi/gJ18PhCJusLz+2MIW65/hOsDQQOIsl9JgGe6XNaY+rCc/qa41vrk4NVMFagmepabu3FtxgJpa96cKoZOimhV1Wt6XXzOZ3hjxkoMnPxQUn7yG+NfPW7mq9s2dLZEDJXDvPZCP+8stQ5gRN8bS5s5QYOiIhe/g6oLzbKPc7amAX0/dua8IRU8D1sW6MS3U7SXoURliTrr7Pmk7B0kb3my3Ra1HdMU2+tkyQPHkhHMrHbTU8ZbrfDeY/7vTLjDdtySUqKKYd52Jxt5aAB+QS8LJqeMJuIiOTp6MKPduq7Z3Oz5SaVS0hMCsOnuDio84Rbc7so/FZxEpR3iwsWhBlc7dr9FsXyi7UPeyj6a+l85a72CQMs+1gZnochyRPeLx0K7bUmb9+CqIKiNT7n1W16CJRwr8pGviV9qNSwfc6C3K4lYwt3641sQSgWnwugyV022nrRRONxnQOHIQzKy4M0+n5tm0uvZeVmk0ROyIa8LCjqx17iVh4iJBg==
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 656c520d-db46-414d-add9-08d83fe3ec5d
X-MS-Exchange-CrossTenant-AuthSource: BN8PR21MB1281.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2020 23:52:22.9982
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Cz4OI+0lcuxzGj019KYocnRnwiiwPdlBL6PkWpQc3BCxfbfW8EG8eSVrYBlJGZkwBoiU3oDiMtdkUULOHMj0fw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR21MB0467
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On ARM64, Hyper-V now specifies the interrupt to be used by VMbus
in the ACPI DSDT.  This information is not used on x86 because the
interrupt vector must be hardcoded.  But update the generic
VMbus driver to do the parsing and pass the information to the
architecture specific code that sets up the Linux IRQ.  Update
consumers of the interrupt to get it from an architecture specific
function.

Signed-off-by: Michael Kelley <mikelley@microsoft.com>
---
 arch/x86/include/asm/mshyperv.h |  1 +
 arch/x86/kernel/cpu/mshyperv.c  |  3 ++-
 drivers/hv/hv.c                 |  2 +-
 drivers/hv/vmbus_drv.c          | 30 +++++++++++++++++++++++++++---
 include/asm-generic/mshyperv.h  |  4 +++-
 5 files changed, 34 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
index 4f77b8f..ffc2899 100644
--- a/arch/x86/include/asm/mshyperv.h
+++ b/arch/x86/include/asm/mshyperv.h
@@ -54,6 +54,7 @@ typedef int (*hyperv_fill_flush_list_func)(
 #define hv_enable_vdso_clocksource() \
 	vclocks_set_used(VDSO_CLOCKMODE_HVCLOCK);
 #define hv_get_raw_timer() rdtsc_ordered()
+#define hv_get_vector() HYPERVISOR_CALLBACK_VECTOR
 
 /*
  * Reference to pv_ops must be inline so objtool
diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
index 3112544..538aa87 100644
--- a/arch/x86/kernel/cpu/mshyperv.c
+++ b/arch/x86/kernel/cpu/mshyperv.c
@@ -55,9 +55,10 @@
 	set_irq_regs(old_regs);
 }
 
-void hv_setup_vmbus_irq(void (*handler)(void))
+int hv_setup_vmbus_irq(int irq, void (*handler)(void))
 {
 	vmbus_handler = handler;
+	return 0;
 }
 
 void hv_remove_vmbus_irq(void)
diff --git a/drivers/hv/hv.c b/drivers/hv/hv.c
index da69338..2bd44fd 100644
--- a/drivers/hv/hv.c
+++ b/drivers/hv/hv.c
@@ -180,7 +180,7 @@ void hv_synic_enable_regs(unsigned int cpu)
 	/* Setup the shared SINT. */
 	hv_get_synint_state(VMBUS_MESSAGE_SINT, shared_sint.as_uint64);
 
-	shared_sint.vector = HYPERVISOR_CALLBACK_VECTOR;
+	shared_sint.vector = hv_get_vector();
 	shared_sint.masked = false;
 	shared_sint.auto_eoi = hv_recommend_using_aeoi();
 	hv_set_synint_state(VMBUS_MESSAGE_SINT, shared_sint.as_uint64);
diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index 910b6e9..3f6a42a 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -48,6 +48,10 @@ struct vmbus_dynid {
 
 static void *hv_panic_page;
 
+/* Values parsed from ACPI DSDT */
+static int vmbus_irq;
+int vmbus_interrupt;
+
 /*
  * Boolean to control whether to report panic messages over Hyper-V.
  *
@@ -1347,7 +1351,7 @@ static void vmbus_isr(void)
 			tasklet_schedule(&hv_cpu->msg_dpc);
 	}
 
-	add_interrupt_randomness(HYPERVISOR_CALLBACK_VECTOR, 0);
+	add_interrupt_randomness(hv_get_vector(), 0);
 }
 
 /*
@@ -1430,7 +1434,9 @@ static int vmbus_bus_init(void)
 	if (ret)
 		return ret;
 
-	hv_setup_vmbus_irq(vmbus_isr);
+	ret = hv_setup_vmbus_irq(vmbus_irq, vmbus_isr);
+	if (ret)
+		goto err_setup;
 
 	ret = hv_synic_alloc();
 	if (ret)
@@ -1505,7 +1511,7 @@ static int vmbus_bus_init(void)
 	hv_synic_free();
 err_alloc:
 	hv_remove_vmbus_irq();
-
+err_setup:
 	bus_unregister(&hv_bus);
 	unregister_sysctl_table(hv_ctl_table_hdr);
 	hv_ctl_table_hdr = NULL;
@@ -2070,6 +2076,7 @@ static acpi_status vmbus_walk_resources(struct acpi_resource *res, void *ctx)
 	struct resource *new_res;
 	struct resource **old_res = &hyperv_mmio;
 	struct resource **prev_res = NULL;
+	struct resource r;
 
 	switch (res->type) {
 
@@ -2088,6 +2095,23 @@ static acpi_status vmbus_walk_resources(struct acpi_resource *res, void *ctx)
 		end = res->data.address64.address.maximum;
 		break;
 
+	/*
+	 * The IRQ information is needed only on ARM64, which Hyper-V
+	 * sets up in the extended format. IRQ information is present
+	 * on x86/x64 in the non-extended format but it is not used by
+	 * Linux. So don't bother checking for the non-extended format.
+	 */
+	case ACPI_RESOURCE_TYPE_EXTENDED_IRQ:
+		if (!acpi_dev_resource_interrupt(res, 0, &r)) {
+			pr_err("Unable to parse Hyper-V ACPI interrupt\n");
+			return AE_ERROR;
+		}
+		/* ARM64 INTID for VMbus */
+		vmbus_interrupt = res->data.extended_irq.interrupts[0];
+		/* Linux IRQ number */
+		vmbus_irq = r.start;
+		return AE_OK;
+
 	default:
 		/* Unused resource type */
 		return AE_OK;
diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyperv.h
index c5edc5e..c577996 100644
--- a/include/asm-generic/mshyperv.h
+++ b/include/asm-generic/mshyperv.h
@@ -89,7 +89,7 @@ static inline void vmbus_signal_eom(struct hv_message *msg, u32 old_msg_type)
 	}
 }
 
-void hv_setup_vmbus_irq(void (*handler)(void));
+int hv_setup_vmbus_irq(int irq, void (*handler)(void));
 void hv_remove_vmbus_irq(void);
 void hv_enable_vmbus_irq(void);
 void hv_disable_vmbus_irq(void);
@@ -99,6 +99,8 @@ static inline void vmbus_signal_eom(struct hv_message *msg, u32 old_msg_type)
 void hv_setup_crash_handler(void (*handler)(struct pt_regs *regs));
 void hv_remove_crash_handler(void);
 
+extern int vmbus_interrupt;
+
 #if IS_ENABLED(CONFIG_HYPERV)
 /*
  * Hypervisor's notion of virtual processor ID is different from
-- 
1.8.3.1

