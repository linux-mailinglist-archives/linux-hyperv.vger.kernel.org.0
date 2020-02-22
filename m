Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5EBA3168CC6
	for <lists+linux-hyperv@lfdr.de>; Sat, 22 Feb 2020 07:00:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726189AbgBVGAm (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sat, 22 Feb 2020 01:00:42 -0500
Received: from mail-eopbgr680134.outbound.protection.outlook.com ([40.107.68.134]:5153
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726053AbgBVGAm (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Sat, 22 Feb 2020 01:00:42 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jZ3nD87NQKFeoI59KwNKaJonYby35Xm1b3J/UlgIwmsYvA9mwiMZfp7QT4qTCifGhizenTVzAzYwZQDWN4qnloizixdyZWJwcmvWsEHOC5rUofG8gSKPgK+TyrLtlzrlSVQsLNGKIPBOA4ivp1H18wQOF6HmLrCyZ+4N36+KvuaQe6Fy2oqrN4wGFvTW9PkjVKeBQ6dgSfDFh8/aEjIgOplDK2qypMcR2dZGI7QfzLtJLPO4RlzFAFEe0eUDWfzayAE/paWTIMrjjsMUnZqXMeV+8I3F+nyjVrp8p3+mr1aPy9igQBP1VOL4IA677hWCFEQ9WRpffhj3oK873FIreQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sVfGPXOnjJ7gkW9g2nEcBnQ3/ZOoL/YqiMF1B12XDho=;
 b=kO/pcWUcwyIHjK3I1RqRT5pzgj7DeFZcLdNl+fbucQg7iW4J58ExaQemdN9GOepuYd8n1KhgKb64tLJ9GoJwzp2hfJ/g902HLmr5VnBMzO/uhawYXD4Pr2QtfEmiLW808kY+i93PK5NEkSKJWF4fikSprf4L2dDZ6zoazDYCtldVGw71cr5Q1mlNlmA18NThotHrIkJTDqn5gbDzokSGoBYQdt/uYvQ7pATaL2ZKw+xuAYLGKRlMjapxeKctWqK+DGQ76h5eC+fX2HgNTlskVrNSazIw+Fug9EfbiSoIBlLSKdmEZ0nsy2vDdHzAc/yBFKI6oxEhQpP6Sf5R5mGlUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sVfGPXOnjJ7gkW9g2nEcBnQ3/ZOoL/YqiMF1B12XDho=;
 b=PBb0jSguSr4yTCqhMTbot5RUASGMNdFisHT5L/LxMHaIG4Yb6fqscOd6x8Z7jccNEfUVSMcvm6UXkgUZ7mkoQ9dJeCFprOjXlzHCruhoxv3GQAqST2DZjsmRWWyDeFG87T02fVgh9GvocbJecQLZ79x9AVy6TM75hI4b1gFCIMI=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com; 
Received: from BN8PR21MB1139.namprd21.prod.outlook.com (20.179.72.138) by
 BN8PR21MB1249.namprd21.prod.outlook.com (20.179.74.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.5; Sat, 22 Feb 2020 06:00:40 +0000
Received: from BN8PR21MB1139.namprd21.prod.outlook.com
 ([fe80::18c0:bfd0:9181:4c62]) by BN8PR21MB1139.namprd21.prod.outlook.com
 ([fe80::18c0:bfd0:9181:4c62%8]) with mapi id 15.20.2772.004; Sat, 22 Feb 2020
 06:00:39 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        lorenzo.pieralisi@arm.com, bhelgaas@google.com,
        linux-hyperv@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, mikelley@microsoft.com
Cc:     Dexuan Cui <decui@microsoft.com>
Subject: [PATCH v2 1/2] PCI: hv: Remove unnecessary type casting from kzalloc
Date:   Fri, 21 Feb 2020 21:59:56 -0800
Message-Id: <1582351197-12303-1-git-send-email-decui@microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Reply-To: decui@microsoft.com
Content-Type: text/plain
X-ClientProxiedBy: CO2PR04CA0117.namprd04.prod.outlook.com
 (2603:10b6:104:7::19) To BN8PR21MB1139.namprd21.prod.outlook.com
 (2603:10b6:408:72::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (13.77.154.182) by CO2PR04CA0117.namprd04.prod.outlook.com (2603:10b6:104:7::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.17 via Frontend Transport; Sat, 22 Feb 2020 06:00:38 +0000
X-Mailer: git-send-email 1.8.3.1
X-Originating-IP: [13.77.154.182]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d742a3f7-c305-4962-34a4-08d7b75c8aee
X-MS-TrafficTypeDiagnostic: BN8PR21MB1249:|BN8PR21MB1249:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN8PR21MB1249E855BCEC95AC60FA0FBABFEE0@BN8PR21MB1249.namprd21.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-Forefront-PRVS: 03218BFD9F
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(4636009)(346002)(136003)(396003)(366004)(39860400002)(376002)(189003)(199004)(26005)(8676002)(186003)(316002)(3450700001)(81156014)(5660300002)(6666004)(6512007)(16526019)(6506007)(2906002)(81166006)(8936002)(478600001)(10290500003)(4326008)(86362001)(36756003)(66556008)(2616005)(66946007)(52116002)(107886003)(6636002)(956004)(4744005)(6486002)(66476007);DIR:OUT;SFP:1102;SCL:1;SRVR:BN8PR21MB1249;H:BN8PR21MB1139.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NkmjmcfvVeahwbpeO3AeS/9XGlFLuZqZwU4avS8pKVRobRLAlkuh0Px+aJp5ldCnBew5M8FP4Hh/lUBZmqUqSrbfXykjmM2YG85CzIt3uncFWxO4IA7y+AUrQnq95AcplCslh5hsWSsxNnvAzv05vG8a5lIvEPzYklSi7hWHag8zL6THiUAvVOdbjM7QkH1rbB4An2mz4Pxb4v4LWc48PSHP60aFZHsS8xuScShDwrnB9AYzkv5Y/W2gfHhr14sK0bRZ60e9qCTieu9cxHpPo/bxCvLu3bVCdaZQtS4757wGr5QJlAs5n/hJ9d7vIpLlFcHS0o9Afbbr2kDv8yLghjdERcVIkTzyD90v+BT3iXuLBSbXPJWjpGbdTYEQljO2b6SKoJopHY68VHesOOeHrOv82A14wt8mHmtHgYtijyh1JuwcUIqvKl0JxRxlkBYP
X-MS-Exchange-AntiSpam-MessageData: z4/rMeGl9PMt7PCjhBSdzqxk+scwIMcQkFaH5q37gA8vkdZygDrRdrTA8rgptMHdwSqXG3Ls0dc+Mj0JDmSRhfQ8ScEmZU9g+1SSmL/xEjx6eeL/yzNQyABeBvYIVjljg7ORHv4I3EJNR/VDC+MraQ==
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d742a3f7-c305-4962-34a4-08d7b75c8aee
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2020 06:00:39.8581
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sUT2eLtxrOKsny9dn6VUMvPobOxHTClFsQRRFKd4Mja5bO7JBxgiE+OKUsxwnpqBN5Mtrw6zalYkhI4xunKilw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR21MB1249
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

In C, there is no need to cast a void * to any other pointer type.

Fixes: 877b911a5ba0 ("PCI: hv: Avoid a kmemleak false positive caused by the hbus buffer")
Signed-off-by: Dexuan Cui <decui@microsoft.com>
Reviewed-by: Michael Kelley <mikelley@microsoft.com>
---

Change in v2: this was part of v1.

 drivers/pci/controller/pci-hyperv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
index 9977abff92fc..0fe0283368d2 100644
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
-- 
2.19.1

