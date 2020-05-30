Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 550011E944F
	for <lists+linux-hyperv@lfdr.de>; Sun, 31 May 2020 00:39:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729356AbgE3WjY (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sat, 30 May 2020 18:39:24 -0400
Received: from mail-bn7nam10on2125.outbound.protection.outlook.com ([40.107.92.125]:4448
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729183AbgE3WjX (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Sat, 30 May 2020 18:39:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D2iHEVr39+JKTG/e/YNWmsWI6+tUz4vgj1g71YhiNtcd+rmeATsx/s+Hos+8evOJmtRKLamwD8tjc45YVZ1F5CdnH46wyADo+RlLC6fwHmtpkLKlDL5e3biKan2CugXCxmlgZt97ZUMSzD5iCCFZNMOI2Q5lQe+B/S8cE3RKqTOJcHRJcZQo6m9GGYI9XbEsVGw9vcYQHb+1rvJqMtkKMWFiLXdSaNshdWyHWW9T3I3oTEVJWcdkrmcjsVoqyDygdeEZFPBdkQceOtQBZLXEO1TLTzE80o9nzqQduhl3N9pZeenO0Ti2EDGIieocWKSbD+5b5YvXpzaleeRLpNpLdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/pqDeC0QbKJ3PInOjKvIPGYBUgoxFOLGQaqKYMMpxo8=;
 b=gxOLcXiRmMOcJdYoOPywG3eLH2DussQaVVgjRSBdBTtMd3Twd8ANMT1Qa5LIh0y54O2J1E9x2atDEHzhyhsr+m1CNqCTuyM4eKOQKAIoRh42Nkws1JT0oJrDBsL08GJGsdcDC6B4ES8CTKOwxCteOmw+5Tc703g17GgIZ8B8K85dbDYCxFd2zpLuU4KEtUaDyObRXiB1QjJb4Hf3Vn7Q36IcWZHNvZD1ml4dtuMEuAkdwxfHybwQmS8izaJM5yjVEfw79k1gAEYZt5MsMaCiq9YdKcPN3ZOvlMF+okOsqYZ3QFD3X0hU7GlC4Q1ccad5S3Cr2zx9eCmaS04rlzILJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/pqDeC0QbKJ3PInOjKvIPGYBUgoxFOLGQaqKYMMpxo8=;
 b=PpGnjUA/T8J9/W7RzMC+A3MSnRLbgODejYL+1tmY4b3dvSrT01gnvvWej5kTP+VGh5q4tKODfTmGo/sIeo2mEibMl9XegoMCC6miya8D8065CwExwJcqtjch4e417BNT7gOPFV80AAYL1iHoS2vUCD7mekoSO81Dr6oAGrk/J10=
Authentication-Results: linutronix.de; dkim=none (message not signed)
 header.d=none;linutronix.de; dmarc=none action=none
 header.from=microsoft.com;
Received: from BN7PR21MB1684.namprd21.prod.outlook.com (2603:10b6:406:af::14)
 by BN8PR21MB1154.namprd21.prod.outlook.com (2603:10b6:408:72::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.6; Sat, 30 May
 2020 22:39:19 +0000
Received: from BN7PR21MB1684.namprd21.prod.outlook.com
 ([fe80::70e0:a986:9935:f045]) by BN7PR21MB1684.namprd21.prod.outlook.com
 ([fe80::70e0:a986:9935:f045%7]) with mapi id 15.20.3066.014; Sat, 30 May 2020
 22:39:19 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     tglx@linutronix.de, mingo@redhat.com, rdunlap@infradead.org,
        bp@alien8.de, hpa@zytor.com, x86@kernel.org, peterz@infradead.org,
        allison@lohutok.net, alexios.zavras@intel.com,
        gregkh@linuxfoundation.org, decui@microsoft.com, namit@vmware.com,
        mikelley@microsoft.com, longli@microsoft.com
Cc:     linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org
Subject: [PATCH v2] x86/apic/flat64: Add back the early_param("apic", parse_apic)
Date:   Sat, 30 May 2020 15:38:50 -0700
Message-Id: <20200530223850.38442-1-decui@microsoft.com>
X-Mailer: git-send-email 2.17.1
Reply-To: decui@microsoft.com
Content-Type: text/plain
X-ClientProxiedBy: CO2PR07CA0044.namprd07.prod.outlook.com (2603:10b6:100::12)
 To BN7PR21MB1684.namprd21.prod.outlook.com (2603:10b6:406:af::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from decui-u1804.corp.microsoft.com (2001:4898:80e8:1:f44b:3e50:43bd:a522) by CO2PR07CA0044.namprd07.prod.outlook.com (2603:10b6:100::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.19 via Frontend Transport; Sat, 30 May 2020 22:39:17 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [2001:4898:80e8:1:f44b:3e50:43bd:a522]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: e470762e-0d57-438a-8440-08d804ea4a21
X-MS-TrafficTypeDiagnostic: BN8PR21MB1154:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN8PR21MB115475EA27204296589BB089BF8C0@BN8PR21MB1154.namprd21.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-Forefront-PRVS: 041963B986
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uy5QBFLDDILEw8+Qx0U6Y1LanMaZxkDquUCRXHw2ZgMhsnh2RfJrkMOkTocRFeQeYfZMWykF5gTbHWogb9lxHPH/e5cl8nWocrgyipUJyMmHOEmAdtGwIXyVHq7j3qqsIxmKUQB+FQWQnOzttXL+aym3AmHvX6S7+nE7PGn8tQuqbtLpXLpOZ0VOy9b8y+myrGAygBLYdhY3eEE86WBryBBAmReBhDyDkrttnWqNWDtLycRs+Xurm3B+BofdgqouAx0/pjLG2F0EsnVx3hMZ+2KbqAWQYfCYD5KSf7JDiR6jEPI2Y4vb8S9nlwd7eFQm2rqIZqZj/t8KTGOjeFI+/DTxbprSQ00SPU1u2p7tClxlJgB+m+Si12kFNpeQnYTX
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN7PR21MB1684.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(346002)(376002)(136003)(366004)(39860400002)(396003)(4326008)(8676002)(3450700001)(82960400001)(66946007)(52116002)(7696005)(83380400001)(2616005)(66556008)(86362001)(7416002)(66476007)(186003)(6666004)(16526019)(6636002)(316002)(2906002)(8936002)(82950400001)(36756003)(478600001)(1076003)(10290500003)(6486002)(5660300002)(921003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: loF04zOwHsDAEHnafqkPr+2alDChauUyCcAi9EBpQcgt2kW0NvJyWyoFwJ4ozrx0y4HuFmVd82VO+ndIEgYj0O1J3/78h7Sawa0xtQG9RddKaHT94A0iC8qh39xcT6EM5rCVp0SM1fAcMbc/R9I98I9Z+Z13C6F9vp88qr310Wk6weS0LZ5R9cgtm5dGSTIGngKpKEnAjx3UusIHbDjcXResYFZzqG5MsFSBdldjf3sY4qTGQcsRmVCnKNgdckkUOwXF0F3Us2ysIFZzaPBXaWFTMJ6nv8GgOl2lpybZq2PgjqG9HLTusluPknALPeAqQBsuBM0RruvgtBv6fNkoECUy5GWirWJUDBQlOPcmAkdXiPVbKzVosgJtMfl3aRedrzfNljGn7IeA5mR4YLcL5T3YbKytxk6LrIXqw3vXsP9nGo8qRbmHs498l0JVpeZ/C5sWx+zq+RSbHoBygcrFqXQ9FIPN5o6xKoU3vnzvpEElVBhrIf6xi6yC8aBDmyQsowUUsoAT504ADhfKB7t8Kgt9JFM85SQdzC3Jf6puiRs=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e470762e-0d57-438a-8440-08d804ea4a21
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2020 22:39:19.0621
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Nms0TlvwFWk7/r3DWipjm5CnYUXiWG70tETQuZxmQHmWb81/sr2zd2+kfSS1bufja/uaWA2PRH6ek5jVNINWVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR21MB1154
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

parse_apic() allows the user to try a different APIC driver than the
default one that's automatically chosen. It works for X86-32, but
doesn't work for X86-64 because it was removed in 2009 for X86-64 by
commit 7b38725318f4 ("x86: remove subarchitecture support code"),
whose changelog doesn't explicitly describe the removal for X86-64.

The patch adds back the functionality for X86-64. The intent is mainly
to work around an APIC emulation bug in Hyper-V in the case of kdump:
currently Hyper-V does not honor the disabled state of the local APICs,
so all the IOAPIC-based interrupts may not be delivered to the correct
virtual CPU, if the logical-mode APIC driver is used (the kdump
kernel usually uses the logical-mode APIC driver, since typically
only 1 CPU is active). Luckily the kdump issue can be worked around by
forcing the kdump kernel to use physical mode, before the fix to Hyper-V
becomes widely available.

The current algorithm of choosing an APIC driver is:

1. The global pointer "struct apic *apic" has a default value, i.e
"apic_default" on X86-32, and "apic_flat" on X86-64.

2. If the early_param "apic=" is specified, parse_apic() is called and
the pointer "apic" is changed if a matching APIC driver is found.

3. default_acpi_madt_oem_check() calls the acpi_madt_oem_check() method
of all APIC drivers, which may override the "apic" pointer.

4. default_setup_apic_routing() may override the "apic" pointer, e.g.
by calling the probe() method of all APIC drivers. Note: refer to the
order of the APIC drivers specified in arch/x86/kernel/apic/Makefile.

The patch is safe because if the apic= early param is not specified,
the current algorithm of choosing an APIC driver is unchanged; when the
param is specified (e.g. on X86-64, "apic=physical flat"), the kernel
still tries to find a "more suitable" APIC driver in the above step 3 and
4: e.g. if the BIOS/firmware requires that apic_x2apic_phys should be used,
the above step 4 will override the APIC driver to apic_x2apic_phys, even
if an early_param "apic=physical flat" is specified.

On Hyper-V, when a Linux VM has <= 8 virtual CPUs, if we use
"apic=physical flat", sending IPIs to multiple vCPUs is still fast because
Linux VM uses the para-virtualized IPI hypercalls: see hv_apic_init().

Fixes: 7b38725318f4 ("x86: remove subarchitecture support code")
Signed-off-by: Dexuan Cui <decui@microsoft.com>
---

Changes in v2:
  Updated Documentation/admin-guide/kernel-parameters.txt. [Randy Dunlap]
  Changed apic_set_verbosity().
  Enhanced the changelog.

 .../admin-guide/kernel-parameters.txt         | 11 +++++---
 arch/x86/kernel/apic/apic.c                   | 11 +++-----
 arch/x86/kernel/apic/apic_flat_64.c           | 27 ++++++++++++++++++-
 3 files changed, 38 insertions(+), 11 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 7bc83f3d9bdf..c4503fff9348 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -341,10 +341,15 @@
 			Format: { quiet (default) | verbose | debug }
 			Change the amount of debugging information output
 			when initialising the APIC and IO-APIC components.
-			For X86-32, this can also be used to specify an APIC
-			driver name.
+			This can also be used to specify an APIC driver name.
 			Format: apic=driver_name
-			Examples: apic=bigsmp
+			Examples:
+			  On X86-32:  apic=bigsmp
+			  On X86-64: "apic=physical flat"
+			  Note: the available driver names depend on the
+			  architecture and the kernel config; the setting may
+			  be overridden by the acpi_madt_oem_check() and probe()
+			  methods of other APIC drivers.
 
 	apic_extnmi=	[APIC,X86] External NMI delivery setting
 			Format: { bsp (default) | all | none }
diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
index 81b9c63dae1b..ee2363b3c59e 100644
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -2854,13 +2854,10 @@ static int __init apic_set_verbosity(char *arg)
 		apic_verbosity = APIC_DEBUG;
 	else if (strcmp("verbose", arg) == 0)
 		apic_verbosity = APIC_VERBOSE;
-#ifdef CONFIG_X86_64
-	else {
-		pr_warn("APIC Verbosity level %s not recognised"
-			" use apic=verbose or apic=debug\n", arg);
-		return -EINVAL;
-	}
-#endif
+
+	/* Ignore unrecognized verbosity level setting. */
+
+	pr_info("APIC Verbosity level is %d\n", apic_verbosity);
 
 	return 0;
 }
diff --git a/arch/x86/kernel/apic/apic_flat_64.c b/arch/x86/kernel/apic/apic_flat_64.c
index 7862b152a052..efbec63bb01f 100644
--- a/arch/x86/kernel/apic/apic_flat_64.c
+++ b/arch/x86/kernel/apic/apic_flat_64.c
@@ -23,9 +23,34 @@ static struct apic apic_flat;
 struct apic *apic __ro_after_init = &apic_flat;
 EXPORT_SYMBOL_GPL(apic);
 
+static int cmdline_apic __initdata;
+static int __init parse_apic(char *arg)
+{
+	struct apic **drv;
+
+	if (!arg)
+		return -EINVAL;
+
+	for (drv = __apicdrivers; drv < __apicdrivers_end; drv++) {
+		if (!strcmp((*drv)->name, arg)) {
+			apic = *drv;
+			cmdline_apic = 1;
+			return 0;
+		}
+	}
+
+	/* Parsed again by __setup for debug/verbose */
+	return 0;
+}
+early_param("apic", parse_apic);
+
+
 static int flat_acpi_madt_oem_check(char *oem_id, char *oem_table_id)
 {
-	return 1;
+	if (!cmdline_apic)
+		return 1;
+
+	return apic == &apic_flat;
 }
 
 /*
-- 
2.19.1

