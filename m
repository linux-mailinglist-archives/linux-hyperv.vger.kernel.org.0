Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBB791E7603
	for <lists+linux-hyperv@lfdr.de>; Fri, 29 May 2020 08:38:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725817AbgE2GiY (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 29 May 2020 02:38:24 -0400
Received: from mail-bn8nam11on2107.outbound.protection.outlook.com ([40.107.236.107]:7246
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725601AbgE2GiX (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 29 May 2020 02:38:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MqwAKd7lUcbXOVCKpPR5josJKLlQwVrtJN7KlXkhMET8XLf0prq7rfRv5WazZONKhsxHT5GGaEgANwH3fkDdVIQkX2fz/crv0nZlCibdnxwo8hGiP41eL2fd92/N2rdnVZ10lPzUHOsH6IelXeKnijmvjfXzNbtCvzVcJ++0OpxLbRVdttp86/s33nwavTjxNEelYFiysTv/75K2VMDW9rA1Lz32owIIyf17MG1aS15D2qHCgAayfErSZGmsiOhLEHfEvmiqmOHeUxjb26W5z3xafGQ1hyDSVfZajUf5sy1TPTHIja5uD5vBkqny/KSCHGBwp57dWUZuv/QckmocHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XSekPRG5nc2E0jPvzqdfsdSyupX4bgJsipl4EX2GvAs=;
 b=FZpp45kknjDOCfgrMN2S7d/3F0vbDcJAwRT5jR3t5ozsnxX6leV/OZPTJbP0e+oYyXAnfHLBIKb5OUBORMSlCpOEZJIEBu9JDwODSq5KoGBHpdp9y5BIuyG3Vtv7D13CzwK/ZFplMIUdcMi/tDTfoc8KEi7+qmkoQXtPQ7rLqt9ASRmZ6ROIfYfEJl0wZhdM1Zunr/yBJIrw/qSKoS292WBKvgyGjNNVbZoeONvM9yfsMZB3Ddh7Os6oIXHDQZWv4PziHbdSzDcktD+V3Lx/QLtRtP7urF6mZAF1LUM8OXeObv4YVhdIZOrmcqvWQJQBcoKbiJPVW8BzSJHhIGmaJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XSekPRG5nc2E0jPvzqdfsdSyupX4bgJsipl4EX2GvAs=;
 b=L2uWAhK9gQOlZqTLnSz7vmzhLx1HLAbsv7GT0QvZGb7JZbNC8K4hO4y9up5tM2s45XsawIVdYErsrU96nrjW+cGruE6k0t32xJ7U4o68ZZGAAHeDI9yV3MmSBwOH8njK3UdBp8lWxxT47Em3kzE2tLLXfe8l+BOkQQxhw5JhGm0=
Authentication-Results: linutronix.de; dkim=none (message not signed)
 header.d=none;linutronix.de; dmarc=none action=none
 header.from=microsoft.com;
Received: from BN7PR21MB1684.namprd21.prod.outlook.com (2603:10b6:406:af::14)
 by BN6PR21MB0834.namprd21.prod.outlook.com (2603:10b6:404:9e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.3; Fri, 29 May
 2020 06:38:20 +0000
Received: from BN7PR21MB1684.namprd21.prod.outlook.com
 ([fe80::70e0:a986:9935:f045]) by BN7PR21MB1684.namprd21.prod.outlook.com
 ([fe80::70e0:a986:9935:f045%7]) with mapi id 15.20.3066.010; Fri, 29 May 2020
 06:38:20 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        x86@kernel.org, peterz@infradead.org, allison@lohutok.net,
        alexios.zavras@intel.com, gregkh@linuxfoundation.org,
        decui@microsoft.com, namit@vmware.com, mikelley@microsoft.com,
        longli@microsoft.com
Cc:     linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org
Subject: [PATCH] x86/apic/flat64: Add back the early_param("apic", parse_apic)
Date:   Thu, 28 May 2020 23:37:29 -0700
Message-Id: <20200529063729.22047-1-decui@microsoft.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: CO2PR04CA0193.namprd04.prod.outlook.com
 (2603:10b6:104:5::23) To BN7PR21MB1684.namprd21.prod.outlook.com
 (2603:10b6:406:af::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from decui-u1804.corp.microsoft.com (2001:4898:80e8:a:523:f7e2:c2e4:9720) by CO2PR04CA0193.namprd04.prod.outlook.com (2603:10b6:104:5::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.17 via Frontend Transport; Fri, 29 May 2020 06:38:18 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [2001:4898:80e8:a:523:f7e2:c2e4:9720]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d7459f5f-e4e6-4a71-e812-08d8039ae07b
X-MS-TrafficTypeDiagnostic: BN6PR21MB0834:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN6PR21MB083412410C0E6FD152F69E26BF8F0@BN6PR21MB0834.namprd21.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2803;
X-Forefront-PRVS: 04180B6720
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iNKgys3RoJAcSeuLE2Dkzjjv+cNRF0UbNytqp1KrBVbLq0qkvNSi69sjTHsB4zOLG7R5M2q+RSs69dBBrn9Y9T2h/ME7E/O6Z6fz7LFw3OXP2xDVXLYgAu73VkWYWMwO6fteZ7v3FG8DNMvuxY8HsZF7GrDxgEkohFS/FwlZPFBSMSCoOZQ6q3VUd0LoNjjRp9lzRca+uSigswufYNxTJ9QU7+LmW0lk6q19f46S7gVRH2vROVAmy4rEEoe/4X1c1QX3E52tUhhjahLT9f2Yk/u4NnOr+f8/c/JI/FUjIzaZVkwi5W5BGD1V9dbVSYS2p4Bh4RhxGq2GobAjqy125F3WOLDjOWREONevi20pqgx5qjOuGOPOg6n+CO2yrT6N
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN7PR21MB1684.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(346002)(376002)(136003)(366004)(39860400002)(2616005)(16526019)(5660300002)(478600001)(7696005)(36756003)(7416002)(8936002)(52116002)(86362001)(6486002)(186003)(10290500003)(8676002)(6666004)(66556008)(66946007)(1076003)(316002)(6636002)(82950400001)(2906002)(4326008)(82960400001)(66476007)(83380400001)(921003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: r7PhcRnht754vx/IcT1tSNV8UTMjc1lesRt06Mo6+E6GZD21oRSOwsIZCC3iTmF+ypwq0G+bhK12RD0adRFFKXHQtj7DO+jxvi0sSntPNclRoRQpyFZoOIm278TlUTxEMq70AwAsEdY9Mq8+K3+7E45GOiHu72CyEXOLUUOIMYsjUVTmr+rkDe4pvqTxhD6eeFUkUbzt+fP9TV219F0rLY5KZD0LRV9ESBlig7gxVUz3jxgJ0Wvp8xKzzL/VL5nuPLF7SeVAstuuYx94ny3Fy1ktiy4h6O3q7e37tEa5EyCAqlVC8t88HXD2x2Q6trNjnWVXKESMM/BXOnE5kS/mEuR1TiCTYhEDD2MvewdGfxrGFmyX6gVZyPwy55zylkRiWr/tkQioBJ498muB99UMn6XDzamqJLWfPlF2TATJJX0DfLv/7sXX5SmDX15xYItTt6P8dtCY+WQZ/CgjwWaZV6aND9mJx82PKT+3nUK0GXm49hwpalJMTugdSJ47ITAA+Jlt+DSK9BflUQ0r2750XhwKbwHXdWhCE/d9C8xnNRI=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7459f5f-e4e6-4a71-e812-08d8039ae07b
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2020 06:38:20.3196
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iwf9W8HaveNhS8oDloT0k7yBkaESFKSQlZtlylcbPvJqPeetJhJV8BPRNDHSeOiyPO5VjfHkEOv+nyrSmDAg7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR21MB0834
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

parse_apic() allows the user to try a different apic driver than the
default one that's automatically chosen. It works for x86_32, but
doesn't work for x86_64 becauase it was removed in 2009 for x86_64 by:
commit 7b38725318f4 ("x86: remove subarchitecture support code"),
whose changelog doesn't explicitly describe the removal for x86_64.

The patch adds back the functionality for x86_64. The intent is mainly
to work around an APIC emulation bug in Hyper-V in the case of kdump:
currently Hyper-V does not honor the disabled state of the local APICs,
and all the IOAPIC-based interrupts may not be delivered to the correct
virtual CPU, if the logical-mode APIC driver is used (the kdump
kernel usually uses the logical-mode APIC driver, since typically
only 1 CPU is active). Luckily the kdump issue can be worked around by
forcing the kdump kernel to use physical mode, before the fix to Hyper-V
becomes widely available.

IMHO the patch is safe because the current default algorithm to choose
the apic driver is unchanged; the patch makes a difference only when
the user specifies the apic= kernel parameter, e.g. "apic=physical flat".

Signed-off-by: Dexuan Cui <decui@microsoft.com>
---
 arch/x86/kernel/apic/apic_flat_64.c | 27 ++++++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

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
2.25.1

