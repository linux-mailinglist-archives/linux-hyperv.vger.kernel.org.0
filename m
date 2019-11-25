Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7C803108861
	for <lists+linux-hyperv@lfdr.de>; Mon, 25 Nov 2019 06:34:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727130AbfKYFev (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 25 Nov 2019 00:34:51 -0500
Received: from mail-eopbgr680091.outbound.protection.outlook.com ([40.107.68.91]:28903
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725882AbfKYFev (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 25 Nov 2019 00:34:51 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TUrcWutSwUTfSdcplrhCBefqR7ghxP1DajOcRMH0sLFZhGx8jtC5oRdmHaIjMrK5TWpqmrT1ITNfaaDMzQfGJQVd9NVcAPlmfKFOq/hmF+uEBZyc6GrbYvEqkgcrlZ/+ViApK0gKrtbfSdHsqLpn7/16FIapfC6Su+uE5zqHjfrEtD5GyLgtnZq3H7k3N9vnoOnbNrHPkAT6n1070mQH7ZquPXUpIMlfqBYH1JykHbVptBbnFoGGneU/K21W0jY2uG9xuiC1hgmD9UVC0ddaTOadQohQShgLHRnR53g6+Sat0z2eFVCLMedJHkOE7gRqKQsYAzePu0j0NFU1Egl57w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gEgzxQKdiYlMJ9oSRnvz5UH5uj0AWm6gNaaS12cBPMI=;
 b=KYarBpSPMspjj7bcO4r3rnUjtT5V3QQfGPVk9ZwUX0VJwyF3089y0djyv4EkcAAoKb411YwvLq0WmtVUomk9RRE7yEp4M0b8PPzbKedmhSZdjKPy8OJb3P+6TNAA4orte0fvdJZHd4cRxxJWTgG7AfzFWYTXGZFQ+JZsP+LdtvLMW8ZmKwnIabyIJsWL36F9IDkHHFZBRjWv4W0H/68V/5+KlNqspmpvtUDPwMUrn7g6vFZuM5bc7ZXK66TVB+NDMFg450a6gDj6e/dyRp6PiLzfftMfU+ZVlMK3RBv30el7eBOalK45E4lRQ5irq2nT8v+2d3OirZr270UGXwajcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gEgzxQKdiYlMJ9oSRnvz5UH5uj0AWm6gNaaS12cBPMI=;
 b=dsqimAJcL9YB0ro4KPpiBej3XUHestPSdIl0+m3i+w+OQ1EJOlxlrh0yCKf2CTpNN9SUdVY2L0XdIu8mFEKzatolpL3nM5qrZhEFEF2ObU7m5j+yLCOkc0UrIIkk1I05wuo6UrCmMkL1BvBbbfZ5GKSTKumDipV8FQJkDHXwUAQ=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com; 
Received: from BYAPR21MB1141.namprd21.prod.outlook.com (20.179.57.138) by
 BYAPR21MB1189.namprd21.prod.outlook.com (20.179.57.218) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2516.1; Mon, 25 Nov 2019 05:34:10 +0000
Received: from BYAPR21MB1141.namprd21.prod.outlook.com
 ([fe80::5d0f:2e49:3464:7c89]) by BYAPR21MB1141.namprd21.prod.outlook.com
 ([fe80::5d0f:2e49:3464:7c89%3]) with mapi id 15.20.2495.014; Mon, 25 Nov 2019
 05:34:10 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        sashal@kernel.org, lorenzo.pieralisi@arm.com, bhelgaas@google.com,
        linux-hyperv@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, mikelley@microsoft.com,
        Alexander.Levin@microsoft.com
Cc:     Dexuan Cui <decui@microsoft.com>
Subject: [PATCH v3 4/4] PCI: hv: Avoid a kmemleak false positive caused by the hbus buffer
Date:   Sun, 24 Nov 2019 21:33:54 -0800
Message-Id: <1574660034-98780-5-git-send-email-decui@microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1574660034-98780-1-git-send-email-decui@microsoft.com>
References: <1574660034-98780-1-git-send-email-decui@microsoft.com>
Reply-To: decui@microsoft.com
Content-Type: text/plain
X-ClientProxiedBy: MWHPR20CA0011.namprd20.prod.outlook.com
 (2603:10b6:300:13d::21) To BYAPR21MB1141.namprd21.prod.outlook.com
 (2603:10b6:a03:108::10)
MIME-Version: 1.0
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (13.77.154.182) by MWHPR20CA0011.namprd20.prod.outlook.com (2603:10b6:300:13d::21) with Microsoft SMTP Server (version=TLS1_2, cipher=) via Frontend Transport; Mon, 25 Nov 2019 05:34:09 +0000
X-Mailer: git-send-email 1.8.3.1
X-Originating-IP: [13.77.154.182]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 8f33cce4-a402-4df3-52fe-08d771691918
X-MS-TrafficTypeDiagnostic: BYAPR21MB1189:|BYAPR21MB1189:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR21MB118971FBB7BB74DEF92D9A79BF4A0@BYAPR21MB1189.namprd21.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 0232B30BBC
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(396003)(39860400002)(376002)(366004)(136003)(346002)(189003)(199004)(6116002)(3846002)(4326008)(107886003)(6486002)(6436002)(10090500001)(3450700001)(2906002)(14444005)(50466002)(48376002)(25786009)(6512007)(76176011)(26005)(6506007)(386003)(51416003)(52116002)(66946007)(66556008)(66476007)(6636002)(4720700003)(86362001)(7736002)(186003)(2616005)(956004)(16526019)(36756003)(11346002)(446003)(66066001)(8936002)(8676002)(5660300002)(81156014)(47776003)(81166006)(1511001)(50226002)(10290500003)(478600001)(316002)(305945005)(6666004)(16586007)(43066004)(22452003)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR21MB1189;H:BYAPR21MB1141.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rIk66HaTeCVEQuD1U+y2tg4s2XP1YMhUK0XBfpDsjDUAqhJlISKHQ10gNxE149aUiLc9mXFyBdSbnkzDlmbYlSby/Dh+SsVLNXLsgaMGYGr40tq3nuBhvjM+w6dYF+339dcDoBPa5cTXVFQVNIwBTkuPzjQe+51Ai7PnPfp0ZCiP9Ba+L6O0F6A2YRYu1MYtjO3GEiUWXH8WNDQkDaN0P8aZzAZi7xE//WCbBKOdYD9jYdOppbR1WgvqHFSHQyCQY7JXbKLwIbM8oq4BlZq+FRGwVUl3LRwofPvR6VXX4+MOVXMTOnYvONvd48EFa4g9r8cTmGdFreCs6NEnGzyWzUmxk/VcAHvzDkw7jZncMqyHyMO71nZWoRKj6VLoWNVw9zzxRwZ8quTD9YfLpWw6I8WQN2i03VLsr9omnq96XiZdPojdQipor1uPKkeRJGzw
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f33cce4-a402-4df3-52fe-08d771691918
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2019 05:34:10.4915
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 52KrRUuUFFr0VFw66M/kF9uP28S3L4rs0tzQbXhjYBDieuN/xfZa1mo3ssUMBBap/BgTM3fclP0u9l3MbVRfaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR21MB1189
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

With the recent 59bb47985c1d ("mm, sl[aou]b: guarantee natural
alignment for kmalloc(power-of-two)"), kzalloc() is able to allocate
a 4KB buffer that is guaranteed to be 4KB-aligned. Here the size and
alignment of hbus is important because hbus's field
retarget_msi_interrupt_params must not cross a 4KB page boundary.

Here we prefer kzalloc to get_zeroed_page(), because a buffer
allocated by the latter is not tracked and scanned by kmemleak, and
hence kmemleak reports the pointer contained in the hbus buffer
(i.e. the hpdev struct, which is created in new_pcichild_device() and
is tracked by hbus->children) as memory leak (false positive).

If the kernel doesn't have 59bb47985c1d, get_zeroed_page() *must* be
used to allocate the hbus buffer and we can avoid the kmemleak false
positive by using kmemleak_alloc() and kmemleak_free() to ask
kmemleak to track and scan the hbus buffer.

Reported-by: Lili Deng <v-lide@microsoft.com>
Signed-off-by: Dexuan Cui <decui@microsoft.com>
---
 drivers/pci/controller/pci-hyperv.c | 24 +++++++++++++++++++++---
 1 file changed, 21 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
index 910fa016d095..be99862166d0 100644
--- a/drivers/pci/controller/pci-hyperv.c
+++ b/drivers/pci/controller/pci-hyperv.c
@@ -2902,9 +2902,27 @@ static int hv_pci_probe(struct hv_device *hdev,
 	 * hv_pcibus_device contains the hypercall arguments for retargeting in
 	 * hv_irq_unmask(). Those must not cross a page boundary.
 	 */
-	BUILD_BUG_ON(sizeof(*hbus) > PAGE_SIZE);
+	BUILD_BUG_ON(sizeof(*hbus) > HV_HYP_PAGE_SIZE);
 
-	hbus = (struct hv_pcibus_device *)get_zeroed_page(GFP_KERNEL);
+	/*
+	 * With the recent 59bb47985c1d ("mm, sl[aou]b: guarantee natural
+	 * alignment for kmalloc(power-of-two)"), kzalloc() is able to allocate
+	 * a 4KB buffer that is guaranteed to be 4KB-aligned. Here the size and
+	 * alignment of hbus is important because hbus's field
+	 * retarget_msi_interrupt_params must not cross a 4KB page boundary.
+	 *
+	 * Here we prefer kzalloc to get_zeroed_page(), because a buffer
+	 * allocated by the latter is not tracked and scanned by kmemleak, and
+	 * hence kmemleak reports the pointer contained in the hbus buffer
+	 * (i.e. the hpdev struct, which is created in new_pcichild_device() and
+	 * is tracked by hbus->children) as memory leak (false positive).
+	 *
+	 * If the kernel doesn't have 59bb47985c1d, get_zeroed_page() *must* be
+	 * used to allocate the hbus buffer and we can avoid the kmemleak false
+	 * positive by using kmemleak_alloc() and kmemleak_free() to ask
+	 * kmemleak to track and scan the hbus buffer.
+	 */
+	hbus = (struct hv_pcibus_device *)kzalloc(HV_HYP_PAGE_SIZE, GFP_KERNEL);
 	if (!hbus)
 		return -ENOMEM;
 	hbus->state = hv_pcibus_init;
@@ -3133,7 +3151,7 @@ static int hv_pci_remove(struct hv_device *hdev)
 
 	hv_put_dom_num(hbus->sysdata.domain);
 
-	free_page((unsigned long)hbus);
+	kfree(hbus);
 	return ret;
 }
 
-- 
2.19.1

