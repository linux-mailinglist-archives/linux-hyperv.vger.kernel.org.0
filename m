Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9A704131B9E
	for <lists+linux-hyperv@lfdr.de>; Mon,  6 Jan 2020 23:39:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726735AbgAFWjk (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 6 Jan 2020 17:39:40 -0500
Received: from mail-eopbgr750109.outbound.protection.outlook.com ([40.107.75.109]:26411
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726721AbgAFWjj (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 6 Jan 2020 17:39:39 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lf6gLMhJshSwl8qSKfMZnoaQ8b8mTW88RjRspuczU314kpcjGVYyZ9hRb/d+N8Jvx6dSZKrxUKkdqS9hgM7XxIHV2b9p5QahXUM6EIhoE8Ivha0qoK6WNqN+Fb+Vj46YaVfLqgeWoYf95dOtEhuqe8Oc0aYo38mi+i5q9MBHx93rQQSOjzS0zc6HzQW/PguZQ/0qiMNDsOBGRlL0FVO1jt8+wdX9Lf5m/CYBiE/V5e7MWP7b5opockdXFIMAsmWNMYWB4TwVNOJ0KRVvLC35JPwlWA1q2DfuRVe0L5M8vR5xj4nsVxnSxjYJdS26jaa2CqdP9pci3CFbKGfhE7xnxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7uANN529b+8BSGabR1XCQGDktRdLyhuFdOC++g3rsLw=;
 b=eNVEp75EB1c6HNHile4q5Bizs1KLvXelJLCOytEY41JV15ZCJAi+kg+9D9MT+TAPzYtRv4oevw0IwMSoDHvdSz/7MTPwmV7n9kpH788hMXsRP8EcGtf8GCSzibCv3Ty2lwyoizIkm/PGxtPR2fCfIT1C5uI8fxkpEvNldVwXVwiFS6iQJf+l9yVuegJ4EClqWK2wXHLCStD839s/JPbxR6mGeO01M/8Jh0o/4kjGlfw26fW2OM9At5LKpJMHNEj5nWSII1dNBseqcdEJCD3bAFFDOKeBB0Q7S7tFE4aHS2b/VFB71zLXs9b4+jZGvnjcPa7nLhT3PlBIVHz4fVHC/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7uANN529b+8BSGabR1XCQGDktRdLyhuFdOC++g3rsLw=;
 b=EtPDPVRAeoC9KeZS99sDsCnpeCQdve5ClG6xExZozC0kwQ5p1yKsoItocKiR44qzHrE2cvNzcJ2T9Bm8VzrWgHQc99bNTnOUWrENv1q8KFYsG1NITWd5MAc8FYKvzkFVSnORTsUWaXc89za0zomZ8jVBE5msUOq2Iuhyx24lhUg=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com; 
Received: from CY4PR21MB0775.namprd21.prod.outlook.com (10.173.192.21) by
 CY4PR21MB0471.namprd21.prod.outlook.com (10.172.121.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.3; Mon, 6 Jan 2020 22:39:36 +0000
Received: from CY4PR21MB0775.namprd21.prod.outlook.com
 ([fe80::6155:bc1d:1d39:977b]) by CY4PR21MB0775.namprd21.prod.outlook.com
 ([fe80::6155:bc1d:1d39:977b%8]) with mapi id 15.20.2644.002; Mon, 6 Jan 2020
 22:39:35 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        sashal@kernel.org, lorenzo.pieralisi@arm.com, bhelgaas@google.com,
        linux-hyperv@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, mikelley@microsoft.com,
        Alexander.Levin@microsoft.com
Cc:     Dexuan Cui <decui@microsoft.com>
Subject: [PATCH] PCI: hv: Use kfree(hbus) in hv_pci_probe()'s error handling path
Date:   Mon,  6 Jan 2020 14:39:11 -0800
Message-Id: <1578350351-129783-1-git-send-email-decui@microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Reply-To: decui@microsoft.com
Content-Type: text/plain
X-ClientProxiedBy: MWHPR2001CA0007.namprd20.prod.outlook.com
 (2603:10b6:301:15::17) To CY4PR21MB0775.namprd21.prod.outlook.com
 (2603:10b6:903:b8::21)
MIME-Version: 1.0
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (13.77.154.182) by MWHPR2001CA0007.namprd20.prod.outlook.com (2603:10b6:301:15::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2602.12 via Frontend Transport; Mon, 6 Jan 2020 22:39:34 +0000
X-Mailer: git-send-email 1.8.3.1
X-Originating-IP: [13.77.154.182]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 49ed48a6-8ae2-4115-a9f4-08d792f94e28
X-MS-TrafficTypeDiagnostic: CY4PR21MB0471:|CY4PR21MB0471:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR21MB0471E51DDBEA4C10A48569CEBF3C0@CY4PR21MB0471.namprd21.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-Forefront-PRVS: 0274272F87
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(136003)(396003)(376002)(346002)(39860400002)(366004)(199004)(189003)(6506007)(6486002)(2906002)(66946007)(66476007)(66556008)(26005)(3450700001)(2616005)(36756003)(6512007)(956004)(5660300002)(4326008)(86362001)(10290500003)(8936002)(52116002)(316002)(16526019)(107886003)(8676002)(81156014)(6666004)(186003)(478600001)(6636002)(81166006)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0471;H:CY4PR21MB0775.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xwQktqa9VqCBfX6qxcXfv39ocAzuVcNnMcwqaEYMOmbLybPxfeIN3mPkE2JmibJz9rzJUYj6cIZOqC9XEzPIA9Ci0CpK+xXNwIFHMKrxII3OLiOwyGmfd6BIW0sxEhI9VW+8LZFYtKtVNVoT98R9QwzuRd3zcBH5pAsYuUyL4ZhKG+Ndn6aECGEuZitLYFivndefWl9M98G7W68uePESKSjar5qDglEXVUrVpHm83CuuqIhoXmkoyGsPW6ESnnQ1htLlzPEqtCQ6F6pK2r2nGc6C6PVI9ytyIr0U88eGeSqmMFuwfacflMxffYOaH3LyA4C+VymTWCD/iVcXDq1pkg7WYuKtWqzheLi5hRGgxJL8tsgYGMYJwsppgdg08Tjk7UWyAiBnBPNutWsrRxh2KqdWfddpNomY7sr5StDeUCiSWvmkE6eTdGVoLDppf4FbM8N0Bsd2DY34Nds35AVKIIQNZbZooIBWSW9BCiL02LX4Zv7r8EDpgMSwus8e8W2p
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49ed48a6-8ae2-4115-a9f4-08d792f94e28
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2020 22:39:35.7471
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0xvEspa+pPzk0R1c+Vm62uWutXleUEOOKpCqoFUUtz2yv6s/uoUdEOWoRF6I7o96hhEECwvZYs9O8Uzdpb2jAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0471
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Now that we use kzalloc() to allocate the hbus buffer, we should use
kfree() in the error path as well.

Also remove the type casting, since it's unnecessary in C.

Fixes: 877b911a5ba0 ("PCI: hv: Avoid a kmemleak false positive caused by the hbus buffer")
Signed-off-by: Dexuan Cui <decui@microsoft.com>
---

Sorry for missing the error handling path.

 drivers/pci/controller/pci-hyperv.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
index 9977abff92fc..15011a349520 100644
--- a/drivers/pci/controller/pci-hyperv.c
+++ b/drivers/pci/controller/pci-hyperv.c
@@ -2922,7 +2922,7 @@ static int hv_pci_probe(struct hv_device *hdev,
 	 * positive by using kmemleak_alloc() and kmemleak_free() to ask
 	 * kmemleak to track and scan the hbus buffer.
 	 */
-	hbus = (struct hv_pcibus_device *)kzalloc(HV_HYP_PAGE_SIZE, GFP_KERNEL);
+	hbus = kzalloc(HV_HYP_PAGE_SIZE, GFP_KERNEL);
 	if (!hbus)
 		return -ENOMEM;
 	hbus->state = hv_pcibus_init;
@@ -3058,7 +3058,7 @@ static int hv_pci_probe(struct hv_device *hdev,
 free_dom:
 	hv_put_dom_num(hbus->sysdata.domain);
 free_bus:
-	free_page((unsigned long)hbus);
+	kfree(hbus);
 	return ret;
 }
 
-- 
2.19.1

