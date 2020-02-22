Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1836B168CCB
	for <lists+linux-hyperv@lfdr.de>; Sat, 22 Feb 2020 07:00:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726908AbgBVGAr (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sat, 22 Feb 2020 01:00:47 -0500
Received: from mail-dm6nam10on2092.outbound.protection.outlook.com ([40.107.93.92]:7935
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726892AbgBVGAr (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Sat, 22 Feb 2020 01:00:47 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kvKL1FACf9bvnRnQIdz0CD6+y7XbPn48UQ5rdPRkwNVyGV17mcblWpuKWTMxGfil9HAosXZ3N4ev5gZSKy3JMlHaTHQIZ8iXdFsxSRV6LGILjvmNBF5hMetgMwNWxglbXjEpMS/U/qVzw1fDQxOg8L6vlQ2O7Bc7GbykW2UQkS2ixsKSHz+/XAaqPrENzVL4IL1HqAs9BLFeH9Ov0nVJGW4wlPUJJdkRGkGyI1bOHjeGg1IJzdmQu8K2V+eHTtzVWHRTGSw7gevJ8fmeBGoAqMhI78bMMK0yUqjzFjFue5zmstB4J5zzKUeoprH4RDC4mC3tUg5fRICCyFJ5gwklQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nnk/aPUxC+GGxB30HOxEVgj2VHoKv7y1lL/Co1ZgWXg=;
 b=B1U3hKpjWfSktPH9Cx9Em3AiXRpIlY+3HMZkdzkTxKwNB5uDOfkDoEmybepZfBld21fLaYeMLmCZP5P+tXIaXyiUZDtjRtUwZe9zYYLPIZKnvqm+ph01MKx5UwXimerhiUoSM8O0zNPte+7uSQYM/M5lPchpCb0ulsMK5Rzm1CDVdnHAnzuUJ4UhVbHrOExICOxuK9fS8pBxkDby4l5Kun91/lVodPpqXIOrdASCXf6SSh/rLYiS37Mp8fd/JpC9YJ2voCebn1306CCjUIeg+RgPRrOBkHRHFyEVVoe3LdgK1Ch3XUOQoEz2SOwYrfK5Gof9EuvhrZ+ZxDujuJrz2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nnk/aPUxC+GGxB30HOxEVgj2VHoKv7y1lL/Co1ZgWXg=;
 b=YHRDTg6rxIhUAJdvGCb1eHwYMU+EBeV1mHylBIph+x/UDx+1xr8kw+/v2/k7TUflg8C6WlosZntHs6ArkBISlk7PJJbixhubk4s3W8x0lCLP38urLt/LpRN8vg3BROkzevhzcx1GWb8GbIbX6UvIvOhboQcsxCAYOGFkj2lEWu4=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com; 
Received: from BN8PR21MB1139.namprd21.prod.outlook.com (20.179.72.138) by
 BN8PR21MB1154.namprd21.prod.outlook.com (20.179.72.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.5; Sat, 22 Feb 2020 06:00:44 +0000
Received: from BN8PR21MB1139.namprd21.prod.outlook.com
 ([fe80::18c0:bfd0:9181:4c62]) by BN8PR21MB1139.namprd21.prod.outlook.com
 ([fe80::18c0:bfd0:9181:4c62%8]) with mapi id 15.20.2772.004; Sat, 22 Feb 2020
 06:00:43 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        lorenzo.pieralisi@arm.com, bhelgaas@google.com,
        linux-hyperv@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, mikelley@microsoft.com
Cc:     Dexuan Cui <decui@microsoft.com>
Subject: [PATCH v2 2/2] PCI: hv: Use kfree(hbus) in hv_pci_probe()'s error handling path
Date:   Fri, 21 Feb 2020 21:59:57 -0800
Message-Id: <1582351197-12303-2-git-send-email-decui@microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1582351197-12303-1-git-send-email-decui@microsoft.com>
References: <1582351197-12303-1-git-send-email-decui@microsoft.com>
Reply-To: decui@microsoft.com
Content-Type: text/plain
X-ClientProxiedBy: CO2PR04CA0117.namprd04.prod.outlook.com
 (2603:10b6:104:7::19) To BN8PR21MB1139.namprd21.prod.outlook.com
 (2603:10b6:408:72::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (13.77.154.182) by CO2PR04CA0117.namprd04.prod.outlook.com (2603:10b6:104:7::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.17 via Frontend Transport; Sat, 22 Feb 2020 06:00:41 +0000
X-Mailer: git-send-email 1.8.3.1
X-Originating-IP: [13.77.154.182]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 782a057e-53bd-4125-9784-08d7b75c8d02
X-MS-TrafficTypeDiagnostic: BN8PR21MB1154:|BN8PR21MB1154:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN8PR21MB1154A26F6560215303333A11BFEE0@BN8PR21MB1154.namprd21.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-Forefront-PRVS: 03218BFD9F
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(4636009)(366004)(346002)(39860400002)(376002)(396003)(136003)(189003)(199004)(8936002)(66556008)(8676002)(66476007)(36756003)(66946007)(10290500003)(81156014)(478600001)(107886003)(6636002)(81166006)(2906002)(16526019)(186003)(2616005)(6512007)(956004)(5660300002)(86362001)(4326008)(52116002)(4744005)(316002)(3450700001)(26005)(6506007)(6666004)(6486002);DIR:OUT;SFP:1102;SCL:1;SRVR:BN8PR21MB1154;H:BN8PR21MB1139.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PkD/a0fCCy+UARzIKCbZC+/JAsI/2E4alaUHNr4UwplMaXwq9PqYXxssg/lubqrrgjKWjAV0GPTQ71Np7SqPqdImuPgJ6RzA/YifS8vNmPmIRymLDeuXq8Fh/3IslLevYCKPvaNjwJsYbTE2nICBcU7fJGQGlwq7MIznLhnuy4+IftIwwowcC1vbKJg5/9+ZpqSl+ml38mr2xRvUAWR7TaOOBHxXp14qPmelbeDXqq8YIlVE+gFUuUq4oTqCMozABTwLMVL7U/XFs8Y/QwNpNpDycIilAKcKIyyLltTTsIqDDtaKSud9PhytnCY9mel+w4wBP+XeIgQKnM68yRTRn6dCUni3f5t3TXBntdC4dAWC+ZYEMLPph3qx73cxSBYfmRu0J8pGEG/ruO0L37rGtEXoUHDUTFq9Jqq7KYFCm0IPvfUKrp6MaEWlLCrPu0tJ
X-MS-Exchange-AntiSpam-MessageData: k3dfGmysRSeA8dvNgt1gLW8qdy3ql45kIBjKROXhrHKp6nYHtZxnjBDZd+ngo3q+qGjaEGf8yQUh3BJRJCppMx4CeDRy/PazkLfRjKSbFVEhlVloRTg3oct40Tj/6kbzf2FedNJTxYL+JV75Bv4X1g==
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 782a057e-53bd-4125-9784-08d7b75c8d02
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2020 06:00:43.5821
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BFkeo/DL+ck3sMeVqNW+G3TADfnf4H79+PcGaN6abGsaE23vRr02S4XiK5xxZUz1budEDGwajuONtadKIGraPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR21MB1154
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Now that we use kzalloc() to allocate the hbus buffer, we should use
kfree() in the error path as well.

Fixes: 877b911a5ba0 ("PCI: hv: Avoid a kmemleak false positive caused by the hbus buffer")
Signed-off-by: Dexuan Cui <decui@microsoft.com>
Reviewed-by: Michael Kelley <mikelley@microsoft.com>
---
 drivers/pci/controller/pci-hyperv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Change in v2: this was part of v1.

diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
index 0fe0283368d2..15011a349520 100644
--- a/drivers/pci/controller/pci-hyperv.c
+++ b/drivers/pci/controller/pci-hyperv.c
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

