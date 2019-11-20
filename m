Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 94F211034FE
	for <lists+linux-hyperv@lfdr.de>; Wed, 20 Nov 2019 08:17:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727175AbfKTHRa (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 20 Nov 2019 02:17:30 -0500
Received: from mail-eopbgr720133.outbound.protection.outlook.com ([40.107.72.133]:51631
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727670AbfKTHR0 (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 20 Nov 2019 02:17:26 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GmDVQiFH8lBmcq9rVdmSRlglTrGgI3IQf7rfK9RArJjXRhBgCp53lspqH1SlcQGTsPI7cScS/Vy5+j/cIKufzw0xzG/N0Xrto0j4nwn81P55ydiHGkkT5wrURyqcmdydHi+SCpZdW4OZn0geR26gUm7ZlwHy5bl0OgvyjUUaxSI7GkWxd6AKfP3Q+ssshFETBCr+Q14R5Pt4qpm8GeoVAcrYKCWm5Ri3+1IwJq1EiucMixcc4ciQnVKjBF7K7RNT2Of1iHuSbwRDBDicMqTSBQxNRY/2b5ea6W4dayyxsNGew8GXHanz8BEdDFpOu/maP68G+zaLl8/FJkUzt1Z25g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a11YkNayM24x6XpnzvUOyD0iIziEh/6Kr4UhFQAGMaQ=;
 b=OuNyvJpqJSMunhTp4Z+xwCNCQ7LtqsH+z+AsDF9tZOPfe9nntBESPAaP9wShXbkEJayOZkQr2Ce98kJ8tFh85VT1Pig/Qs/7G0nPHkLJ7hVyPWAV7ALteIMdGrr0RpiVLyvbS8cvCR2E5wpDpjIRcojK5+lO+yLHlV2UT9d6AUgl6zETwmfLt7QmtX64WZxdqilhICx40UAGBJpMJPpyTWSDSXEWLa+LNNVn99rDtwrcANGmJtOcG5z6dYPbFaRphy6ljJQLGFAsEIW/2SUL7v1Of4+k/vAsl4Y2GORjV9W0DYWTWpzFupzdZRyKqsiVzgfZ8Ncc5TOOP6uNlywkVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a11YkNayM24x6XpnzvUOyD0iIziEh/6Kr4UhFQAGMaQ=;
 b=JtWbtlEv0H4XIj7YzrXNxlcRdZ4Uc0R4TCPN8SgVRA0AR9N39mODWd5JZ6TT6GhD69P/RmPoEFPd+7lSz2/6VDgzhRqTxsb6iewsGAzz+bFy5dPGyfMe1Wo8URUyo81GyaBXMNumkw/yaJRuqH0XrujXMDeEEiYkL7pH2UxUte4=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com; 
Received: from BN8PR21MB1137.namprd21.prod.outlook.com (20.179.72.96) by
 BN8PR21MB1251.namprd21.prod.outlook.com (20.179.74.28) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.3; Wed, 20 Nov 2019 07:17:21 +0000
Received: from BN8PR21MB1137.namprd21.prod.outlook.com
 ([fe80::c596:ecf5:7a6:734d]) by BN8PR21MB1137.namprd21.prod.outlook.com
 ([fe80::c596:ecf5:7a6:734d%2]) with mapi id 15.20.2495.006; Wed, 20 Nov 2019
 07:17:21 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        sashal@kernel.org, lorenzo.pieralisi@arm.com, bhelgaas@google.com,
        linux-hyperv@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, mikelley@microsoft.com,
        Alexander.Levin@microsoft.com
Cc:     Dexuan Cui <decui@microsoft.com>
Subject: [PATCH v2 4/4] PCI: hv: kmemleak: Track the page allocations for struct hv_pcibus_device
Date:   Tue, 19 Nov 2019 23:16:58 -0800
Message-Id: <1574234218-49195-5-git-send-email-decui@microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1574234218-49195-1-git-send-email-decui@microsoft.com>
References: <1574234218-49195-1-git-send-email-decui@microsoft.com>
Reply-To: decui@microsoft.com
Content-Type: text/plain
X-ClientProxiedBy: MWHPR2001CA0022.namprd20.prod.outlook.com
 (2603:10b6:301:15::32) To BN8PR21MB1137.namprd21.prod.outlook.com
 (2603:10b6:408:71::32)
MIME-Version: 1.0
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (13.77.154.182) by MWHPR2001CA0022.namprd20.prod.outlook.com (2603:10b6:301:15::32) with Microsoft SMTP Server (version=TLS1_2, cipher=) via Frontend Transport; Wed, 20 Nov 2019 07:17:20 +0000
X-Mailer: git-send-email 1.8.3.1
X-Originating-IP: [13.77.154.182]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: b0164f2a-1ed1-4430-5a85-08d76d89af2e
X-MS-TrafficTypeDiagnostic: BN8PR21MB1251:|BN8PR21MB1251:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN8PR21MB12516A73BEE4B9D5222D7957BF4F0@BN8PR21MB1251.namprd21.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 02272225C5
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(376002)(346002)(396003)(136003)(39860400002)(366004)(199004)(189003)(10090500001)(36756003)(8936002)(50226002)(81166006)(81156014)(8676002)(14444005)(6436002)(6486002)(1511001)(86362001)(7736002)(2906002)(5660300002)(478600001)(10290500003)(4720700003)(6636002)(3846002)(6116002)(25786009)(3450700001)(66946007)(66556008)(66476007)(305945005)(316002)(386003)(6666004)(4326008)(6506007)(22452003)(26005)(16586007)(186003)(16526019)(107886003)(76176011)(51416003)(52116002)(66066001)(48376002)(47776003)(50466002)(446003)(11346002)(43066004)(956004)(2616005)(476003)(486006)(6512007)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:BN8PR21MB1251;H:BN8PR21MB1137.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1FZnyVBcMO4HC6UtvXGX3yDrXung2km9PPa+K9QeXtv2gpU5GbjMHWk8SSPx31nDdyuC6UyQLnWKheDh3eNk2Ev8qjg1NtuX68/ArjszxwXx2wLlpVJs9qK54Gq2fVZLcUmezq6yzlCVbQO8bgvQHDn/ckoMvHrA7OrJZD6wvH23uIB0IeGfqaG4iPwdihWu721J0JQiz9f5XXD59xSQ1oMclVWEL8eWkKLWyJ7kYOtNR2mZO2mMjHEKjAc4H7Ji8cYUAYNqW+DOQW5fQPjSxx2ssy6FRgLQBm/vEkvjLQVzoXJn/xmOYpDHPntnlSCeUenM36S2vpSQ6OSt19xBC30DiEBxFEIOa8i8plHdL9YYob7/4WbDppEpiw9QQs8OZTB91eqXbkAXRqlwd2soUwZS+O6bZ4gt2TfiXCIGPsD5drRENP41Uk2Xz1W6PhDT
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0164f2a-1ed1-4430-5a85-08d76d89af2e
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2019 07:17:21.6174
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0hWydk/5vj+nKRMdpzMgrCu3E0xDLrMUz5Sr62lB0m1WnEEjoVt4zTwBTUWgbId0HT+NBqW6MNldcw6Quv6Qwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR21MB1251
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

The page allocated for struct hv_pcibus_device contains pointers to other
slab allocations in new_pcichild_device(). Since kmemleak does not track
and scan page allocations, the slab objects will be reported as leaks
(false positives). Use the kmemleak APIs to allow tracking of such pages.

Reported-by: Lili Deng <v-lide@microsoft.com>
Signed-off-by: Dexuan Cui <decui@microsoft.com>
---

This is actually v1. I use "v2" in the Subject just to be consistent with
the other patches in the patchset.

Without the patch, we can see the below warning in dmesg, if kmemleak is
enabled: 

kmemleak: 1 new suspected memory leaks (see /sys/kernel/debug/kmemleak)

and "cat /sys/kernel/debug/kmemleak" shows:

unreferenced object 0xffff9217d1f2bec0 (size 192):
  comm "kworker/u256:7", pid 100821, jiffies 4501481057 (age 61409.997s)
  hex dump (first 32 bytes):
    a8 60 b1 63 17 92 ff ff a8 60 b1 63 17 92 ff ff  .`.c.....`.c....
    02 00 00 00 00 00 00 00 80 92 cd 61 17 92 ff ff  ...........a....
  backtrace:
    [<0000000006f7ae93>] pci_devices_present_work+0x326/0x5e0 [pci_hyperv]
    [<00000000278eb88a>] process_one_work+0x15f/0x360
    [<00000000c59501e6>] worker_thread+0x49/0x3c0
    [<000000000a0a7a94>] kthread+0xf8/0x130
[<000000007075c2e7>] ret_from_fork+0x35/0x40

 drivers/pci/controller/pci-hyperv.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
index d7e05d436b5e..cc73f49c9e03 100644
--- a/drivers/pci/controller/pci-hyperv.c
+++ b/drivers/pci/controller/pci-hyperv.c
@@ -46,6 +46,7 @@
 #include <asm/irqdomain.h>
 #include <asm/apic.h>
 #include <linux/irq.h>
+#include <linux/kmemleak.h>
 #include <linux/msi.h>
 #include <linux/hyperv.h>
 #include <linux/refcount.h>
@@ -2907,6 +2908,16 @@ static int hv_pci_probe(struct hv_device *hdev,
 	hbus = (struct hv_pcibus_device *)get_zeroed_page(GFP_KERNEL);
 	if (!hbus)
 		return -ENOMEM;
+
+	/*
+	 * kmemleak doesn't track page allocations as they are not commonly
+	 * used for kernel data structures, but here hbus->children indeed
+	 * contains pointers to hv_pci_dev structs, which are dynamically
+	 * created in new_pcichild_device(). Allow kmemleak to scan the page
+	 * so we don't get a false warning of memory leak.
+	 */
+	kmemleak_alloc(hbus, PAGE_SIZE, 1, GFP_KERNEL);
+
 	hbus->state = hv_pcibus_init;
 
 	/*
@@ -3133,6 +3144,8 @@ static int hv_pci_remove(struct hv_device *hdev)
 
 	hv_put_dom_num(hbus->sysdata.domain);
 
+	/* Remove kmemleak object previously allocated in hv_pci_probe() */
+	kmemleak_free(hbus);
 	free_page((unsigned long)hbus);
 	return ret;
 }
-- 
2.19.1

