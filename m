Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88BAC1E990F
	for <lists+linux-hyperv@lfdr.de>; Sun, 31 May 2020 18:49:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727815AbgEaQte (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sun, 31 May 2020 12:49:34 -0400
Received: from mail-eopbgr770127.outbound.protection.outlook.com ([40.107.77.127]:49614
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725912AbgEaQte (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Sun, 31 May 2020 12:49:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fTd9xTqlzNjK9uF2EhXKANpRXgV1taE5L0bf7uTC1wFcQ0CsUrEEfVTTZfDvPyo5PR47UxKJg+mcRQVqgGae/RiCIWKmImT9i7wV8IneaKyOUUwcW24BAa47jN9iMOml7JFwjKQSUOimAVRtZ40kR5DeA0Jcxj37+8FiWYx06eXqRu3DJ29TDWr3TqD3qUUfT6D+XmRkyVT/ESwVH32NzcGWssVcyOCkf7cw9gn+k4RNxGCRtKndz1bO9rnLq/ZTf52CBh+9jvlJfw+6cJvhdlW+XttpkSTzsRek9CPlDoygTmPruk5fxp75XWWom1yXZd3MWh6zZN5lKmBMeX7lCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3V7+FuvAc1J36JGaHwX/XIKTkGGp9Yos5BBh9gOW9kI=;
 b=mrKlI8ieI/4TMuc1CgmecDjwhH6ZZBRkQXsJLME2HIAHnc49Tr8C2hRt5AWLJpYK4Gy6HybUU3R4J6n1xYcFboynZrGmG6SAVVarzZipGQqaTry6Okf0IV5YCsHPa4ijHUtZSVw2dqNFqHpuYpS9Q4hOiN4pKs7VxqUbbs0T+6bf/mPs5Q1PniiKHycq3zm7FpXZu46kB4ooDdqBeWFArSCHvSpzTm1QIHzvoGLrCNS4qSQkevKlvxqCcVTaiU2PQu4j9X4f27CXlV1Cqfwds8Oioxz/K8fxZwUlIBpxhSYfZUG8ntPJ6Y1NOHsHMZjjDhWvj/cXIU91fcHvKPqjnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3V7+FuvAc1J36JGaHwX/XIKTkGGp9Yos5BBh9gOW9kI=;
 b=XYv1lM0SmBXWPfIrenVqei1WztYOIU8YK456u3tPbt39FSpJF0U9PncZja3M0iBCZTlybYo+VZ4+NXYe67y6nGyCEiMeSQBHPIY66HvS57BFMp/ht3yDIU7n77Q8XbXw/YFfZsxQGUy9Ri/P97BKPJ28t1oRVRNVobyH/5YWZRc=
Authentication-Results: linutronix.de; dkim=none (message not signed)
 header.d=none;linutronix.de; dmarc=none action=none
 header.from=microsoft.com;
Received: from BN7PR21MB1684.namprd21.prod.outlook.com (2603:10b6:406:af::14)
 by BN6PR21MB0129.namprd21.prod.outlook.com (2603:10b6:404:93::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.5; Sun, 31 May
 2020 16:49:29 +0000
Received: from BN7PR21MB1684.namprd21.prod.outlook.com
 ([fe80::70e0:a986:9935:f045]) by BN7PR21MB1684.namprd21.prod.outlook.com
 ([fe80::70e0:a986:9935:f045%7]) with mapi id 15.20.3088.000; Sun, 31 May 2020
 16:49:29 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     tglx@linutronix.de, mingo@redhat.com, rdunlap@infradead.org,
        bp@alien8.de, hpa@zytor.com, x86@kernel.org, peterz@infradead.org,
        allison@lohutok.net, alexios.zavras@intel.com,
        gregkh@linuxfoundation.org, decui@microsoft.com, namit@vmware.com,
        mikelley@microsoft.com, longli@microsoft.com
Cc:     linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org
Subject: [PATCH v3] x86/apic/flat64: Add back the early_param("apic", parse_apic)
Date:   Sun, 31 May 2020 09:48:59 -0700
Message-Id: <20200531164859.43903-1-decui@microsoft.com>
X-Mailer: git-send-email 2.17.1
Reply-To: decui@microsoft.com
Content-Type: text/plain
X-ClientProxiedBy: CO2PR06CA0075.namprd06.prod.outlook.com
 (2603:10b6:104:3::33) To BN7PR21MB1684.namprd21.prod.outlook.com
 (2603:10b6:406:af::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from decui-u1804.corp.microsoft.com (2001:4898:80e8:a:f442:3e50:43bd:a522) by CO2PR06CA0075.namprd06.prod.outlook.com (2603:10b6:104:3::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.19 via Frontend Transport; Sun, 31 May 2020 16:49:27 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [2001:4898:80e8:a:f442:3e50:43bd:a522]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 48842b0f-1dfd-4dcb-62c8-08d8058295dd
X-MS-TrafficTypeDiagnostic: BN6PR21MB0129:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN6PR21MB01295D702CBBD86791D8A0AFBF8D0@BN6PR21MB0129.namprd21.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-Forefront-PRVS: 0420213CCD
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +nkjU0dV1hTSCIvQO/xQ0Lyfbf0arQUB/Aupe+wOaAssPyquLp6uqlpCR5vIONQihxVoU+RzfKw5vbaLpGAvpDSMJKsZPoZ/HKWOM0qAXezLGzfc6cPlbA1SD0G6jExb3+8hSdjkJf9zdYo+mSZ0+X6fWsyYaEjIrVKdVEzlcGjK+duqxWVAi79+ZKcbtn9SRBpFPnYHfgcCI4e/4njCSce+U+1DdQRbq1/7dBhWHEcoeue1NheCxWUwT6qtEaJOXwET6DqujtvBh/70DAPu537fJHGZEOxhDgyai/0LBjQDDtyKU013miH9ZaN63GHnQhUOfZ2OaJ8+3vP876x4KiNoxQlVgWI4woFfQL1XFzjdLIY78cJQHQKABc0rgjMv
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN7PR21MB1684.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(39860400002)(136003)(376002)(396003)(346002)(5660300002)(1076003)(8676002)(66556008)(86362001)(52116002)(7696005)(82950400001)(316002)(82960400001)(66946007)(7416002)(83380400001)(6666004)(6486002)(4326008)(2906002)(6636002)(66476007)(16526019)(36756003)(2616005)(3450700001)(8936002)(478600001)(10290500003)(186003)(921003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: XoFe/67/wnBaSewIi3f6O9Y8iJVuz0JugzumCBFqEV3W1WJwCf+MAJLRXVwyba+0E/LwnS1CgKK5EgfrIiuJlH2JKBLmicHG/Ry/sFlNG7TBTcxrXbne7YWVAlZMO4qFph3tCazT/enlTqMBMU3HC5qBCzvMGtd39Qu3f+J5pjtKDsffwwTOIuLDAH+drB9+CXz3d4zAvNxZWHbpRZyQ4N5AtX+SZZDxQgMcuBvTkzxM+TKKVfzxsxjcANMiQ9q7T1IkOTibmAXZ/NVKP0lYH/JnfNtw/GiG6NSa+DUhbQ+BNxTUQddh9EucQmYVTUq6Mrnnr6TwptLknjuYMdhPOeQOu74MIbbr/s/3OUDKIERRLpWGdtrymAv+ar/9eF09W2SspwQVT539NyqOgJptQpMT6r3yMi04Vrix9n9ZIgO6/cjmdbcDqoSKwn+geY6WWE5avguW+aSk5mqie99pmjKwFv+Iopvj1VUDRSzl/I85FCVH3kjGYklzmj6WWVrVMFV78Q0EpWV9ul7xc9r81uMP9jPGTFYIqeJBHVed+ww=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48842b0f-1dfd-4dcb-62c8-08d8058295dd
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2020 16:49:29.5024
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SKWtLIbStgcsgggzK64QQ9Fh862QT19F5H0/kw4VsuajbUZgNohlg/V2ZulNMrcqsUsZxIFOtOcf3NXO8DDJJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR21MB0129
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

Changes in v2:
  Updated Documentation/admin-guide/kernel-parameters.txt. [Randy Dunlap]
  Changed apic_set_verbosity().
  Enhanced the changelog.

Changes in v3:
  Added the __init tag for flat_acpi_madt_oem_check() and
physflat_acpi_madt_oem_check() to avoid a warning seen with "make W=1".
  (Thanks to kbuild test robot <lkp@intel.com>).

  Updated the changelog for the __init tag.

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

