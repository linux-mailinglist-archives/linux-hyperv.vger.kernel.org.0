Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A203C20B809
	for <lists+linux-hyperv@lfdr.de>; Fri, 26 Jun 2020 20:21:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725275AbgFZSVg (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 26 Jun 2020 14:21:36 -0400
Received: from mail-co1nam11on2134.outbound.protection.outlook.com ([40.107.220.134]:10408
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725280AbgFZSVg (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 26 Jun 2020 14:21:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hoA19WFCpq+bA2Lx+W5VQEKKmHzzeOdBj8HwZrmGWZ/on1/juGeUL+gqTjblgNRK9ixwjsk2BCqPx7GpB9OtvB4cRiabbIgUhP+Mj4VQRgILrLaZSgGYwSpiXIhfnXk3VJkXRNoxNaXFU54rxpHHAiQe9lTaTIif58i99TfhyD+2E8IFJr5mYetVTAsUF+Bcb48Ksqwbc2P3OCQec52Dbso39VkNW+yL+q7DDvUmq2X93DYWgca+xkTCKNXh5w1mU/7jI+jecUwWi5lSLoVqdNBRqpaIbly6cNPQn+npQ7VhEfo3UPX3+bpP4Xu/a0Ihe9J93scKBeljKJM6R0ZniA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kbiOFPOmNVKfyi+d7Mwmct1M2kPEXZbW7RDEBHvPuUg=;
 b=TcsoZwrDbt8mlWdX9cSzprh0OVs9bBzbcb/tdT3u6nUg5BLyHMUmWE4Hp83M03EXa+jylIpeACW3bnyC9INPvH8cRlAGs5cMqV0tnAV60yhwEy+5dQ6qHI3E1il4tqjweUHIELaCS981iXITlAQtT2tFN9ts1us6qZCSjddQ32nZGPgSSaROqmcR/E79RJZAHEfbSt6pW++E8nIegV0k3evILh6AAlnjcTXyqc/5CZEXlzLum8eoLYNOD2iE6U7dvReycxJrf1Wbh8fl806VEG0PQcpcGRBWhSHJaCt3aoz18MrPjAuvFoJXFi98s79qoifuvOB6eR0V8Glijxm3uA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kbiOFPOmNVKfyi+d7Mwmct1M2kPEXZbW7RDEBHvPuUg=;
 b=SNSuklL2AK5tFSD7T3qpT46BaAc3FBBsLOc2KEhL3mxoc/9hFviZxF6cdK1lWZLSeCXDvonck/5Vauex4YHRTxN/NMn0x8PlGesw8AkvyTQo5TMnVHqoNB5c7y1J+oe1Prly3zwjSnun8/NX2gkDHQgvHfUGnRkllNmC1HX6Mvo=
Authentication-Results: linutronix.de; dkim=none (message not signed)
 header.d=none;linutronix.de; dmarc=none action=none
 header.from=microsoft.com;
Received: from BN7PR21MB1620.namprd21.prod.outlook.com (2603:10b6:406:b7::27)
 by BN7PR21MB1730.namprd21.prod.outlook.com (2603:10b6:406:aa::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.2; Fri, 26 Jun
 2020 18:21:31 +0000
Received: from BN7PR21MB1620.namprd21.prod.outlook.com
 ([fe80::dd79:4f67:5bc0:5ea2]) by BN7PR21MB1620.namprd21.prod.outlook.com
 ([fe80::dd79:4f67:5bc0:5ea2%4]) with mapi id 15.20.3153.014; Fri, 26 Jun 2020
 18:21:31 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     tglx@linutronix.de, mingo@redhat.com, rdunlap@infradead.org,
        bp@alien8.de, hpa@zytor.com, x86@kernel.org, peterz@infradead.org,
        allison@lohutok.net, alexios.zavras@intel.com,
        gregkh@linuxfoundation.org, decui@microsoft.com, namit@vmware.com,
        mikelley@microsoft.com, longli@microsoft.com
Cc:     linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org
Subject: [RESEND][PATCH v3] x86/apic/flat64: Add back the early_param("apic", parse_apic)
Date:   Fri, 26 Jun 2020 11:21:06 -0700
Message-Id: <20200626182106.57219-1-decui@microsoft.com>
X-Mailer: git-send-email 2.17.1
Reply-To: decui@microsoft.com
Content-Type: text/plain
X-ClientProxiedBy: MW2PR16CA0007.namprd16.prod.outlook.com (2603:10b6:907::20)
 To BN7PR21MB1620.namprd21.prod.outlook.com (2603:10b6:406:b7::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from decui-u1804.corp.microsoft.com (2001:4898:80e8:1:cc31:af92:fd70:d080) by MW2PR16CA0007.namprd16.prod.outlook.com (2603:10b6:907::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.21 via Frontend Transport; Fri, 26 Jun 2020 18:21:29 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [2001:4898:80e8:1:cc31:af92:fd70:d080]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 7afb7a5f-8d91-44e1-ccbd-08d819fdbff3
X-MS-TrafficTypeDiagnostic: BN7PR21MB1730:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN7PR21MB1730A10165CAE9909DC0F9A1BF930@BN7PR21MB1730.namprd21.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-Forefront-PRVS: 0446F0FCE1
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5If0E5iXZJe+2D0KO/CJ2Moy0dvGCzjPShdNE+o/Ek0R2s5VuS7NmrSZJATgjJ20M+0jB1P9N9+EaGCnni+0VHjaTYHwkVmPpjSUyxK5HuwPlNLAoCQYdFHfHB+z9uMX+m8d5f/EN54noq8FZJwXaWYXWyZjVMCTM7aMLpyhmbt+KKHN4cDBBXj/3NpnkSLmhCSVGsl2YWIAJ7ymqAOE6cvAmgAunJmwTOYRQ4Oc0MC1Cf1bZynpEoXL9gl+26PO+bGaisLnAgGh53iPFYp37NCXHBkaKce9HBOdTvzgZU9PfvomSW4yikdLgYVmuYe3qdSG9ap2I7dUMKB6fIGtQ+bWCIw81tynl3sRPRf4oHfxCP11svKuMOYWwPvzZWORauJWsLv8L5y7W5Pw/ZpFOC+YeYthmkvVG87o1MUjeiOZ0c5nKnAX29rC+rmlIzpn
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN7PR21MB1620.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(346002)(366004)(136003)(376002)(396003)(39860400002)(82960400001)(6636002)(86362001)(6486002)(7416002)(83380400001)(478600001)(4326008)(8936002)(3450700001)(66476007)(16526019)(66946007)(52116002)(36756003)(7696005)(66556008)(2906002)(186003)(5660300002)(316002)(82950400001)(1076003)(10290500003)(8676002)(6666004)(2616005)(921003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: 1yJVkQbYb11r2n7Felu75D5X0QbnCaOWsqf37m1dexOu+2g1b+jtL0W5TmL2VoiLbs+OMexxgrxHgFegDgyH3OT98o11v6X80iU44aMx7OKgQUjTi2WN0SdmdlD9VpOyojlVnhx6QBeuR2oZvxXM0XXfNOXYqjAE37FCxIqUgO57rP+ft0W8RbDXoyT6OhUJceOAdKJZ3JDpSd4sYRXxBJkWxaUE3NK3AZXw2BZjMP8GW/c3ZHrUeANN1eQlPwBe/dw6E+ujBwBwJ0N+8HYhjUFN2ymTei9ogX+6xfH0UY3ARzJAC/vQwPFwiySwrB4drEqlDL/qiz6ZHFYOwP/iqdtnCB9DSP4sK3XtV+dZeLauIVb/rS/pUT1l1zRUFjHhlp2czWF+f1VBqhg32u5eV474nlSy+jbTkbOIPRVNMXaDuDmDOAaoL+k8f2A7jcTbQxLHUU9/c+nkaBA4Fj2uydzEgpnmMXwRxagXqrArjKbv2q9rbnWBYxPmlTF9x2K8tBUwfDIl31xZcNRj2TESR1FaGG342sMFg+jbCx5Fo+8=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7afb7a5f-8d91-44e1-ccbd-08d819fdbff3
X-MS-Exchange-CrossTenant-AuthSource: BN7PR21MB1620.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2020 18:21:31.4529
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5aQFwd9WKniDRjhogJhBpFNcKogqSK2gofYmOcX5qIGbSAQ5ee4MCXjII+6VC2t5dg5wdUvrkrtuiDNYNG1/9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR21MB1730
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

The patch adds the __init tag for flat_acpi_madt_oem_check() and
physflat_acpi_madt_oem_check() to avoid a warning seen with "make W=1":
flat_acpi_madt_oem_check() accesses cmdline_apic, which has a __initdata
tag.

Fixes: 7b38725318f4 ("x86: remove subarchitecture support code")
Signed-off-by: Dexuan Cui <decui@microsoft.com>
---

Changes in v2 (5/28/2020):
  Updated Documentation/admin-guide/kernel-parameters.txt. [Randy Dunlap]
  Changed apic_set_verbosity().
  Enhanced the changelog.

Changes in v3 (5/31/2020):
  Added the __init tag for flat_acpi_madt_oem_check() and
physflat_acpi_madt_oem_check() to avoid a warning seen with "make W=1".
  (Thanks to kbuild test robot <lkp@intel.com>).

  Updated the changelog for the __init tag.

Today is 6/26/2020 and this is just a RESEND of v3, which was posted
on 5/31 (https://lkml.org/lkml/2020/5/31/198).

 .../admin-guide/kernel-parameters.txt         | 11 +++++--
 arch/x86/kernel/apic/apic.c                   | 11 +++----
 arch/x86/kernel/apic/apic_flat_64.c           | 31 +++++++++++++++++--
 3 files changed, 40 insertions(+), 13 deletions(-)

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
index e53dda210cd7..6f7d75b6358b 100644
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -2855,13 +2855,10 @@ static int __init apic_set_verbosity(char *arg)
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
index 7862b152a052..da8f3640453f 100644
--- a/arch/x86/kernel/apic/apic_flat_64.c
+++ b/arch/x86/kernel/apic/apic_flat_64.c
@@ -23,9 +23,34 @@ static struct apic apic_flat;
 struct apic *apic __ro_after_init = &apic_flat;
 EXPORT_SYMBOL_GPL(apic);
 
-static int flat_acpi_madt_oem_check(char *oem_id, char *oem_table_id)
+static int cmdline_apic __initdata;
+static int __init parse_apic(char *arg)
 {
-	return 1;
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
+static int __init flat_acpi_madt_oem_check(char *oem_id, char *oem_table_id)
+{
+	if (!cmdline_apic)
+		return 1;
+
+	return apic == &apic_flat;
 }
 
 /*
@@ -157,7 +182,7 @@ static struct apic apic_flat __ro_after_init = {
  * We cannot use logical delivery in this case because the mask
  * overflows, so use physical mode.
  */
-static int physflat_acpi_madt_oem_check(char *oem_id, char *oem_table_id)
+static int __init physflat_acpi_madt_oem_check(char *oem_id, char *oem_table_id)
 {
 #ifdef CONFIG_ACPI
 	/*
-- 
2.19.1

