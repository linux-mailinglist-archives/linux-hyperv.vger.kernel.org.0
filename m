Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5D5B410350D
	for <lists+linux-hyperv@lfdr.de>; Wed, 20 Nov 2019 08:17:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727374AbfKTHRS (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 20 Nov 2019 02:17:18 -0500
Received: from mail-eopbgr720133.outbound.protection.outlook.com ([40.107.72.133]:51631
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727175AbfKTHRR (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 20 Nov 2019 02:17:17 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Aga8x2YTQyxVbX+YJ+QUeYJjWVYGoUU6Vx1qi3jrAhHnYd4A+ZZOqaZeCiIAAIapbuH4CVCnCoBUOt7K8Vl0n0NS+vbYbeOy1Tx6aaSNSswFPt5WiRhTB6JvHVIUr3vvIpyB4DWGiUiYwBbPfWRASxEtt+zEqJutt/J+4aSYyAO+7/hYLenk9q0ULQlnAQgcI748ChMlsSNwTc1wiBF9GJTszUwkjWzVW7dduEXx89sxiOdNxyb2ByTvYZ2g5oicbWJSSaNJ/FCvzJr+yqpJK2yFYOkqK+0VZ4hvb/TNBnFROr7T9hVZ7dEJhhupcrqOkP6PG8rR+H/zD1GHLQhQbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XbpupDUIw9zJsZAUR2qS+UZFB60XimzkxwJrnwaCnew=;
 b=emCe3uggFg13TXMKqqpMf9PyNPl3l63Eabjf2gtSD4g8lQpvEIGUspakMoo+aZsV5bNNMrX8f7d0X8vkbBBYoEuAtbAONses2XF8KruVx4tIaff0nr4pM9VxI4Hy6V5Gndkb/RbAjbjCh7qBIzQ6BQkpMiNJ2CPgLMM09tyM/e2G9w/jcMbFJYAJZBRgrl6rjFdVbYxFP3RXbpWxzTrJNLHyb6m21bNAWX3Mqtkq9JwxoOSmD9Q8kO/G545I5n8Sllimx7JWNXZ0xBXnIvDgdYjCMVqSp/uKqf9NAktKZrGxafyXvP9awqw73gZGdXnZpGO3n4I8J0jzQChZbeaTRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XbpupDUIw9zJsZAUR2qS+UZFB60XimzkxwJrnwaCnew=;
 b=TLnPWYg/U+cCMKWl4Y1W/ed2QvZj8OYnSuCsWY/7R/EtnI6EDLGsOvScS3Sez5j8lbqr/TY4zHn/tTTHXs+cMXZTlh+2anGJcEtHNXqN+y2Cil59Ewek7ZCzFtl28nG6XcMNcimv6GZkSI6kwMOTryakreERHC/1oOLdto3kXcU=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com; 
Received: from BN8PR21MB1137.namprd21.prod.outlook.com (20.179.72.96) by
 BN8PR21MB1251.namprd21.prod.outlook.com (20.179.74.28) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.3; Wed, 20 Nov 2019 07:17:15 +0000
Received: from BN8PR21MB1137.namprd21.prod.outlook.com
 ([fe80::c596:ecf5:7a6:734d]) by BN8PR21MB1137.namprd21.prod.outlook.com
 ([fe80::c596:ecf5:7a6:734d%2]) with mapi id 15.20.2495.006; Wed, 20 Nov 2019
 07:17:15 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        sashal@kernel.org, lorenzo.pieralisi@arm.com, bhelgaas@google.com,
        linux-hyperv@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, mikelley@microsoft.com,
        Alexander.Levin@microsoft.com
Cc:     Dexuan Cui <decui@microsoft.com>
Subject: [PATCH v2 0/4] Enhance pci-hyperv to support hibernation, and 2 misc fixes
Date:   Tue, 19 Nov 2019 23:16:54 -0800
Message-Id: <1574234218-49195-1-git-send-email-decui@microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Reply-To: decui@microsoft.com
Content-Type: text/plain
X-ClientProxiedBy: MWHPR2001CA0022.namprd20.prod.outlook.com
 (2603:10b6:301:15::32) To BN8PR21MB1137.namprd21.prod.outlook.com
 (2603:10b6:408:71::32)
MIME-Version: 1.0
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (13.77.154.182) by MWHPR2001CA0022.namprd20.prod.outlook.com (2603:10b6:301:15::32) with Microsoft SMTP Server (version=TLS1_2, cipher=) via Frontend Transport; Wed, 20 Nov 2019 07:17:14 +0000
X-Mailer: git-send-email 1.8.3.1
X-Originating-IP: [13.77.154.182]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: ba62d298-69f0-4e73-7d22-08d76d89abae
X-MS-TrafficTypeDiagnostic: BN8PR21MB1251:|BN8PR21MB1251:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN8PR21MB1251961F8914246F97EED42ABF4F0@BN8PR21MB1251.namprd21.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-Forefront-PRVS: 02272225C5
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(376002)(346002)(396003)(136003)(39860400002)(366004)(199004)(189003)(10090500001)(36756003)(8936002)(50226002)(81166006)(81156014)(8676002)(4744005)(6436002)(6486002)(1511001)(86362001)(7736002)(2906002)(5660300002)(478600001)(10290500003)(4720700003)(6636002)(3846002)(6116002)(25786009)(3450700001)(66946007)(66556008)(66476007)(305945005)(316002)(386003)(6666004)(4326008)(6506007)(22452003)(26005)(16586007)(186003)(16526019)(107886003)(51416003)(52116002)(66066001)(48376002)(47776003)(50466002)(43066004)(956004)(2616005)(476003)(486006)(6512007)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:BN8PR21MB1251;H:BN8PR21MB1137.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VFEg7VoCxBrKNNvzmzyYs6CMVfFvWMkwi6KihsxGDoV3j1GAAbLymhCyZd/Fn3rFj0GDFAi8BFpQQ5Aaw12idq7IN6VHcy0Wq4GtO/WDHjq/1iqJsZet3Z7nPnWvFo1ATI21pK9SAJl0dEn7f+e7lywfYYGxaGN916qNn3TaiNZet98OvCdZKk9SiI4dAun05WbYmZZlkEppIFbwHojlvYoIVkDXUA+35OrTo0EUH+HaDVq3Qo2Zfa8bOu7pXLVsgRTPeGe3Hr7G76BprJRcySzjY8S4yZ45IRfcySBOx43mQxPNJBEun1iUq3e1ESRzYn6cd4h73oKpbIBcOyTK4Dla2US9yrtQnRZ0xC1rvepYMKGEUzwn104T7rtg/0jK4MHh8kEQdDtnxT14zuDPwR06yJlXTvq4MDU1uubAgjV9GEW9Mr7tEreRTa8LcTt1
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba62d298-69f0-4e73-7d22-08d76d89abae
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2019 07:17:15.7733
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eWuUspgdrZTvIVRQKDBNMv3Cer30BLdiADg47u8OwMqRi0X/sjMXn/IqV5iJgrU8dThUFBCTvjxVkX/LPuj+8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR21MB1251
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

I suggest the patchset goes through the pci.git tree.

Patch #1: no functional change.
Patch #2 enhances the pci-hyperv driver to support hibernation.
Patch #3 is unrelated to hibernation.
Patch #4 is unrelated to hibernation.

Dexuan Cui (4):
  PCI: hv: Reorganize the code in preparation of hibernation
  PCI: hv: Add the support of hibernation
  PCI: hv: Change pci_protocol_version to per-hbus
  PCI: hv: kmemleak: Track the page allocations for struct
    hv_pcibus_device

 drivers/pci/controller/pci-hyperv.c | 179 ++++++++++++++++++++++++----
 1 file changed, 153 insertions(+), 26 deletions(-)

-- 
2.19.1

