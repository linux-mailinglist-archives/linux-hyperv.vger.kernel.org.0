Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A297E244EEE
	for <lists+linux-hyperv@lfdr.de>; Fri, 14 Aug 2020 21:45:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728140AbgHNTpv (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 14 Aug 2020 15:45:51 -0400
Received: from mail-bn8nam11on2093.outbound.protection.outlook.com ([40.107.236.93]:2433
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726213AbgHNTpu (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 14 Aug 2020 15:45:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kBqz+GBUt9pfdRILzPekKd+/natZQpiNF3pYXE8XA9VeSQdOr1ihOf9cNxOE8xypUiRxMHn0UZz18as4wPj9d4jhZ1m4Vpy5PHuBo0be49jIVD8QXhS6SnNz1ZRe3F6t+c4Ayipm36Sz7RU/jIqBUolM7qghldr6FgX+0tSyuJmmeDXcwGxN5nw2vrrXnEXQLBau5YITpP78NLhRpxdu3hqyKOINNdpaTNx+QsMQAYl9vSaxRkBIoZKEzfujQQe93pl+Hb/T0l+GjsnqnXxyXJWY3qDt362LrnB0Kx/upP5+qc8rKyShcVvZDnyG2HZs5KsPRa5BNJZzRCGklcEZ2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xY0Mq4IsFyxpVz1DZiBi+ARxHsp2WUpVKN3Lb4O4SbI=;
 b=kwzDxyAYTRKzI0hBcfcTK7p9Yl89xgTZ0kfckUIxG6+xvu8M8+8S3J41TPf+i47HKjr7QRNRGkbympKDLbB51NBNW2XbM/96GugkO8LlLglzGArORGXtihw4OKKmxR0k0lZ5EVb8GxmVkLQYcmBZes6uwIe1uacb8JfFYpjWco9IqcyQGpj5TfYTHccMNCUZSUeGh2rQRhFd1SOswWU9GijeKj1yVWCh5RlGEpmDWcZnHPPSnfvg20idMUgE8oEE8AsRLmsg/5ddocJWmPVjSov4AtleALSQdlLHpsTTxqqTeaGx5YBnrBsHusw/mVMTkDSaSRoN0FXhCsrDL9aLHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xY0Mq4IsFyxpVz1DZiBi+ARxHsp2WUpVKN3Lb4O4SbI=;
 b=R76S4zBW+tZkcnz9IF7fqaWlSnrgKH985d53PBnklkBxpMYbElJG86/AUBXi43FX2QYpw8g98EogF2z8nK/h7nv+HQIcjj9xkhn46JCIgyTmBvWx+GcMRtEvNTVrYB5eIa/aHK7u5eD3Ys3zvEQRFi/+Cb19IeKjhaXdLdFY/kU=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=microsoft.com;
Received: from BN8PR21MB1281.namprd21.prod.outlook.com (2603:10b6:408:a2::19)
 by BN6PR21MB0770.namprd21.prod.outlook.com (2603:10b6:404:9c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.7; Fri, 14 Aug
 2020 19:45:47 +0000
Received: from BN8PR21MB1281.namprd21.prod.outlook.com
 ([fe80::dc81:a9b8:7413:2ff9]) by BN8PR21MB1281.namprd21.prod.outlook.com
 ([fe80::dc81:a9b8:7413:2ff9%3]) with mapi id 15.20.3305.016; Fri, 14 Aug 2020
 19:45:47 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     linux-kernel@vger.kernel.org, kys@microsoft.com,
        sthemmin@microsoft.com, wei.liu@kernel.org,
        linux-hyperv@vger.kernel.org
Cc:     mikelley@microsoft.com, tglx@linutronix.de, peterz@infradead.org,
        mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com
Subject: [PATCH v2 1/1] Drivers: hv: vmbus: Add parsing of VMbus interrupt in ACPI DSDT
Date:   Fri, 14 Aug 2020 12:45:04 -0700
Message-Id: <1597434304-40631-1-git-send-email-mikelley@microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Content-Type: text/plain
X-ClientProxiedBy: MWHPR1401CA0009.namprd14.prod.outlook.com
 (2603:10b6:301:4b::19) To BN8PR21MB1281.namprd21.prod.outlook.com
 (2603:10b6:408:a2::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by MWHPR1401CA0009.namprd14.prod.outlook.com (2603:10b6:301:4b::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.15 via Frontend Transport; Fri, 14 Aug 2020 19:45:44 +0000
X-Mailer: git-send-email 1.8.3.1
X-Originating-IP: [131.107.160.16]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: a16b5c29-76dd-46c2-d95c-08d8408aa306
X-MS-TrafficTypeDiagnostic: BN6PR21MB0770:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN6PR21MB07703552FB64014CA0C4D562D7400@BN6PR21MB0770.namprd21.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hU8dnWLDI5oK8Oedet2OIQlvIriSxYWNJaJWclIKDdUgyEvRN7eFdth0b0zlV4SNnT6UYJHu+X0prV8k5fk+bmFdYtAiLz82bVOEkG5HFXkU9SIagYkCbU9LWtCLva6T8KvZQIfo/J4t3S+kdj/XkABbsSGM/F6G+QEgEeu8QHNf9m8eWPER/MRPVDvSZLSQkoC1HaZCWQpdnKFFgWyhzC+P+LJdkeV6CT+IFvPzGUeMOlCuyAAZ4AWx69Ppx2ncqfud52qMWU1hHYt3maXddKnqR8klRqmHdyCaDjBn4ImubavhiFlljk3g1K4yfD3c1IXjtLy2VZcrHazQYasEAmq2weqGQ8En1bzJPnNCourA4U5uOx30E2iYa11QDlwU
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR21MB1281.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(376002)(366004)(136003)(39860400002)(346002)(66946007)(66476007)(66556008)(4326008)(956004)(86362001)(2616005)(5660300002)(316002)(10290500003)(16576012)(2906002)(82950400001)(82960400001)(26005)(8676002)(8936002)(478600001)(6666004)(186003)(36756003)(83380400001)(52116002)(110011004)(6486002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: J9nqrorOXCH9TE9pFdXKq8qBektfv8ocK8v1WoMP+p1rPH1jLu4b0GOML08maJ6MJmCEHSr2XAKtUt8BXHxjz1kWoriHaB0D7BtLkz5R0xAT5A3R+nN9hvnXO2fH1oaTqhZut/L1oLNmpIr4z2e7p0E44cKLeWYIUKgdIUzeLDf7kHNQeeGqo9+44/YdSaTJdxaDCvSoeMMGYNiYc3T4FG4CfrtoSNrr31aQKwFW8Lml8xBqxXm4v6VMZWVy8ZHHtsT7Okl1zWysyMnrRrNJWQGPwCvK9eCKuVF/ACL25Jk0Hi4eeQM0pnCF421RrmPi/Kh1p5mOQHzA+uVY2uRTQg9mrYQ+8yIOxzOHuUSc1wPTTsqNeF3CAEFnz/EgyREnuHZw8UgxinoYcAARIYC8L0+82ZWKpjdfNrunQEUkQIWeNWRLzKECrPBxg9HAtLJyGIkg64tvsDXQkq7I33GVO7ipOyQwzcCCkaKKMc/10QvyX26Z+wY4zOXhuDipLNUo8l1vjx/W6hon+W8NPgF2rTzmTX2oJC/U4qh4wtqpNo7B3fA4pizAtONjo6qV/szKRQ9zjQexM2adSNovXepAlcsD87aVibMio1IExPcQ2Fp2e2nvZ7vjAUvDji5cwEIG1MUIgXkkqyjWjDo4RAcShQ==
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a16b5c29-76dd-46c2-d95c-08d8408aa306
X-MS-Exchange-CrossTenant-AuthSource: BN8PR21MB1281.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2020 19:45:46.9617
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WRC9P0LYa32k6ODYPvi0218sVmHRMKUTa5IDLUGEuO2KS5sQS6dAdbS7l1qd4oUOPbwyoGrzruMusL6XBYFvGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR21MB0770
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

Changes in v2:
* Added comment to hv_setup_vmbus_irq() explaining that
  the irq argument is ignored on x86/x64. A separate patch
  set is coming soon for ARM64 where the implementation of
  hv_setup_vmbus_irq() will use the 'irq' argument. [Wei Liu]

---

 arch/x86/include/asm/mshyperv.h |  1 +
 arch/x86/kernel/cpu/mshyperv.c  |  7 ++++++-
 drivers/hv/hv.c                 |  2 +-
 drivers/hv/vmbus_drv.c          | 30 +++++++++++++++++++++++++++---
 include/asm-generic/mshyperv.h  |  4 +++-
 5 files changed, 38 insertions(+), 6 deletions(-)

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
index 3112544..9264c3f 100644
--- a/arch/x86/kernel/cpu/mshyperv.c
+++ b/arch/x86/kernel/cpu/mshyperv.c
@@ -55,9 +55,14 @@
 	set_irq_regs(old_regs);
 }
 
-void hv_setup_vmbus_irq(void (*handler)(void))
+int hv_setup_vmbus_irq(int irq, void (*handler)(void))
 {
+	/*
+	 * The 'irq' argument is ignored on x86/x64 because a hard-coded
+	 * interrupt vector is used for Hyper-V interrupts.
+	 */
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

