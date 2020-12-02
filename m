Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8675B2CB1AB
	for <lists+linux-hyperv@lfdr.de>; Wed,  2 Dec 2020 01:48:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727075AbgLBAqe (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 1 Dec 2020 19:46:34 -0500
Received: from mail-dm6nam11on2122.outbound.protection.outlook.com ([40.107.223.122]:20512
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726166AbgLBAqe (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 1 Dec 2020 19:46:34 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cpMieP8siIZ7t3Wr4ZK4bdgHS+vQ74/gIddsEOERS2VEywYAjQ9rRmy2AN6BQheC1mPzHYUQpIGxjm8W15+ZAXlmua6AwNinGlDo7FGmbv3WtVfwBC9wlU4OB62BYvXVvIxhtYQXJbzYqUC0iicPWDMnWtikdePDN0npusXd5oIbqrIlG/idpXAVa/SMxwWdZ+yIFyTlEZAn1qv3J0TloL3BSc4B943YtZieJfoEWRsrDsGxqQF1c799koqwwR6LrqB9OpZ7W7xB+L7sbi6IiUGa40I1OG7JQOTWWM6w3/trNvp8GO/cRqIdAWc0nygdPxwI9IFCjwlutQq3UcRlkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G1lUvbVFd4EDgnL303NeS42m1FG9ugZoed0DgZiGWhY=;
 b=ZuI1WikAC6coHQDTGqENuqiS0YkLLbiZT87QKcQy8ZTwnZ8AEffCfP2r6Ttk2k/yqp27sHGF3OWW99cp2ZXurHEydHR+kwRbe4h7W4xhjpUeS8V/AqqaNp7TgpLKvRNqnLa5QhPR9RoI2kCiynwESikpdpkRqhY+r7MUuQJGc/+D6FPqUjNKa64kiDM2uanGqCQW56URng47814tAOEnpApP0il/9XMnrgjge35+gBf0G2C1IpO/w4G3qwi9oUir68odB4kJ15jrDdHcwK+GLvYQ+ogkcPRHaxhsd8sa6pWs00AKE5RQ26PhwGt9nMG33v3C2PXgjcV0IeNlrV9E1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G1lUvbVFd4EDgnL303NeS42m1FG9ugZoed0DgZiGWhY=;
 b=HSXYOkQNbSVzBvOSt2/lqS3X1v1e/fY4lCnHTGrAk+zbpwdHkAb1/BXmEUGt2D8RGwNF+Oz7T+Etz3QS4PKZeajJVaQ424AhcaExHS0plZb9kljvPlTXjmHAIJwxaYrRGgzfbixA0GtEmSVGQcA1ACcD3g0TsNDOtFPNq3SSpSU=
Authentication-Results: linutronix.de; dkim=none (message not signed)
 header.d=none;linutronix.de; dmarc=none action=none
 header.from=microsoft.com;
Received: from (2603:10b6:404:94::8) by
 BN7PR21MB1650.namprd21.prod.outlook.com (2603:10b6:406:aa::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3654.2; Wed, 2 Dec 2020 00:45:45 +0000
Received: from BN6PR21MB0162.namprd21.prod.outlook.com
 ([fe80::1557:a785:28fe:ea8e]) by BN6PR21MB0162.namprd21.prod.outlook.com
 ([fe80::1557:a785:28fe:ea8e%10]) with mapi id 15.20.3654.003; Wed, 2 Dec 2020
 00:45:45 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     tglx@linutronix.de, dwmw@amazon.co.uk, x86@kernel.org,
        decui@microsoft.com, mikelley@microsoft.com,
        linux-hyperv@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Tianyu.Lan@microsoft.com,
        vkuznets@redhat.com, kys@microsoft.com, haiyangz@microsoft.com,
        sthemmin@microsoft.com, wei.liu@kernel.org
Subject: [PATCH] iommu/hyper-v: Fix panic on a host without the 15-bit APIC ID support
Date:   Tue,  1 Dec 2020 16:45:10 -0800
Message-Id: <20201202004510.1818-1-decui@microsoft.com>
X-Mailer: git-send-email 2.17.1
Reply-To: decui@microsoft.com
Content-Type: text/plain
X-Originating-IP: [2001:4898:80e8:f:4c3e:c9f9:faf8:28fb]
X-ClientProxiedBy: MWHPR18CA0029.namprd18.prod.outlook.com
 (2603:10b6:320:31::15) To BN6PR21MB0162.namprd21.prod.outlook.com
 (2603:10b6:404:94::8)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from decui-u1804.corp.microsoft.com (2001:4898:80e8:f:4c3e:c9f9:faf8:28fb) by MWHPR18CA0029.namprd18.prod.outlook.com (2603:10b6:320:31::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.17 via Frontend Transport; Wed, 2 Dec 2020 00:45:43 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 848db6bf-d3fb-4c60-fec7-08d8965b9aab
X-MS-TrafficTypeDiagnostic: BN7PR21MB1650:
X-MS-Exchange-Transport-Forked: True
X-LD-Processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
X-Microsoft-Antispam-PRVS: <BN7PR21MB1650A927DD24C4E70C1E6739BFF31@BN7PR21MB1650.namprd21.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1360;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9eLIu1pSXQs2GSZeac696oib8qezu6mcvn0+J+PTQqysotJmaFGMQyQy/8VN3IYF3lfUtAQLdfObbisjIYrNTFTYz8zSU4/2xGb4l1FSZwm9Qt/AjHgjJvG5rpMB5eiPPREybVGXdZw8ZhgFwvdrISR6A3UdTIwKMCYgKZEijflX1MUYE1Y5Nan/lsz96ZDmVqI4HHTSnjE3Pu44KyoqUyBQ3ONkXE1ZTYpdTHH6L/EifxY/EWxhH3IL/KzEx4gdl6xwWnCDTrs2T+Inqgxde4DH4bjLU2wymKXP5grpCqCeevia4eMmAtBXMF9XX1ScFL0g9eUiQSvJ9/jiWYQtDg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR21MB0162.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(136003)(366004)(39860400002)(396003)(478600001)(10290500003)(6486002)(2616005)(316002)(8936002)(2906002)(8676002)(4326008)(1076003)(36756003)(7696005)(5660300002)(3450700001)(52116002)(83380400001)(6666004)(82960400001)(16526019)(66556008)(66476007)(82950400001)(186003)(66946007)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?urFaNB3VRrkl1pcnaMWFjpZQfRQhp7nA243LrnDEckf+Ss49mEz9hV/GGsao?=
 =?us-ascii?Q?ePIaGvIZthiGSJlCwUCiS5399k1HuLduOGPwXiy8f0ZLykHwBuLYKuHoA4pc?=
 =?us-ascii?Q?wthUol4XAI7GPqv3PpJO7nr1Gt3E1B5xiVE6YCpRYh8yTaxApO4zubgTw5Yq?=
 =?us-ascii?Q?pMOptlGufXZZY84D0LBKBWsjeiOR/P/K9PZE9t9tCzZVwmKZaevexfm/B/UD?=
 =?us-ascii?Q?XcSG4pegAjYwalGitNtZq2J6o6BjRBDrlRPQydXv2NWCWttqdRsIFtgXzTkh?=
 =?us-ascii?Q?zNvnfshrPo+ZD8Tt3lSaf1z6tfeBgPszwskWJ0vT7xg1Wdox6gbdlxBvXcqE?=
 =?us-ascii?Q?zs2obIr5bdZpJQhk1trHqUmxF7SimnhJ4LWct397F9bKQQtviVH7eI8CXzht?=
 =?us-ascii?Q?Qm5aJ0VCmOEgtqXcv9ho/3xqoZdmWDRSIXng+zMGAYFf3GJE6irMgMqWE4x+?=
 =?us-ascii?Q?dXYmSmKT5xDDVnkMSIzpH8ZWSMCjgz11CqEZv2rMOi09bWBIsLmSiSHqTSUt?=
 =?us-ascii?Q?IzGMF8vm2kb1ApQtQI7Wgz+UxfAyDH0dMKG33UL9RQC+82TKVD4wuv746Ku6?=
 =?us-ascii?Q?mgsyP4sxKfwhXEEkKEHclxf6sSxVejtf0s958V/urnon7Tz7l6EWBu1bmwMf?=
 =?us-ascii?Q?NHwFSYVaLKQYFxa+tlNCL+yxfA5/Jt1fswfmXWjWBkrQyFbK8WvQ69Bywf2i?=
 =?us-ascii?Q?vovm+mWT5RQxUakTTGSvqyEwb9FDE7qWFgnPcRSv87IW/6GycbcqiaMJWlt+?=
 =?us-ascii?Q?EvttCkAXfcjujkbYD9uSoDjykH721S8jnF154zalk7wCTI2QDhbpSUw/dd0z?=
 =?us-ascii?Q?EO/N07/frLzrlgOOFlSfvNaWpujPdnpb2GsKWZpbRJs6OWw+L/sUPjRkP9Fw?=
 =?us-ascii?Q?xImCbSf6gqHQoINYehQwoWIWt54vImv8KLokAoNBzN72NVjiyc+KzCwnPElO?=
 =?us-ascii?Q?jLRp47z2xYFz+cF8DJsm9Lm9Gzgcb1tUfiyDPqp673YIyYgly7ZKzFWXTlNy?=
 =?us-ascii?Q?BW1SSFRokCPV1MReYOTXCKKKMi4vmrUVFeXAPZBh39kryD+LRhvKXBOygis1?=
 =?us-ascii?Q?/fOESoGh?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthSource: BN6PR21MB0162.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2020 00:45:45.1159
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-Network-Message-Id: 848db6bf-d3fb-4c60-fec7-08d8965b9aab
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5cIYQOxWh9SK88IpRFemX6japHUq1hDVFiJAAR0mijBO0WNh2O9+dYjFyoa7UM7tM/VYkHeH2uWmoN8iv9315Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR21MB1650
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

The commit f36a74b9345a itself is good, but it causes a panic in a
Linux VM that runs on a Hyper-V host that doesn't have the 15-bit
Extended APIC ID support:
    kernel BUG at arch/x86/kernel/apic/io_apic.c:2408!

This happens because the Hyper-V ioapic_ir_domain (which is defined in
drivers/iommu/hyperv-iommu.c) can not be found. Fix the panic by
properly claiming the only I/O APIC emulated by Hyper-V.

Cc: David Woodhouse <dwmw@amazon.co.uk>
Cc: Vitaly Kuznetsov <vkuznets@redhat.com>
Fixes: f36a74b9345a ("x86/ioapic: Use I/O-APIC ID for finding irqdomain, not index")
Signed-off-by: Dexuan Cui <decui@microsoft.com>
---
 drivers/iommu/hyperv-iommu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)


This patch is for the tip.git tree's x86/apic branch.

diff --git a/drivers/iommu/hyperv-iommu.c b/drivers/iommu/hyperv-iommu.c
index 9438daa24fdb..1d21a0b5f724 100644
--- a/drivers/iommu/hyperv-iommu.c
+++ b/drivers/iommu/hyperv-iommu.c
@@ -105,8 +105,8 @@ static int hyperv_irq_remapping_select(struct irq_domain *d,
 				       struct irq_fwspec *fwspec,
 				       enum irq_domain_bus_token bus_token)
 {
-	/* Claim only the first (and only) I/OAPIC */
-	return x86_fwspec_is_ioapic(fwspec) && fwspec->param[0] == 0;
+	/* Claim the only I/O APIC emulated by Hyper-V */
+	return x86_fwspec_is_ioapic(fwspec);
 }
 
 static const struct irq_domain_ops hyperv_ir_domain_ops = {

base-commit: d1adcfbb520c43c10fc22fcdccdd4204e014fb53
-- 
2.27.0

