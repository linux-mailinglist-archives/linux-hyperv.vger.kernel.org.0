Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD102268106
	for <lists+linux-hyperv@lfdr.de>; Sun, 13 Sep 2020 21:48:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725940AbgIMTsX (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sun, 13 Sep 2020 15:48:23 -0400
Received: from mail-dm6nam11on2109.outbound.protection.outlook.com ([40.107.223.109]:17377
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725938AbgIMTsU (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Sun, 13 Sep 2020 15:48:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WXqfKP1d2SE/Zllzu1F/0NK5pFq5XdYjp85Euf9yKlQ2n350A4Q60SlAD3DSTT/zqOztAbcRFvC5KtZbCZrrU9RcR/WuBfbyoPsvP7sCYkqYCrJAQsURJVxUaelfCk5ECyfgK8LO6y3gLUbGAZ1MuDGmAYayei4qMOttxSBNjvHbzA7GFEgTZvrTACqVwAI5CQxFqsucVBvSOJv68pBKJFA7huUfO+RV/bWD+AjyT/O9XoB6Vp+VwNi8Dnz5i9UdxigG/7ud2sbapJ35Qfya54RGPu7zoJtrKHVeJPKOKktidvUlHkvPqSBdxVZmzGikY/zqhLEuqPkmzfxmFXtWbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lrI2P/WhWJAk+mLTt+QKNGZZ822rmgJBpvq10C+9iv0=;
 b=n1/NFo6DEW07kg7lHVp+YM5FK6apwFHsCfzSVNglj15/FsQXxfxn5sf+Xlza6PEtpvT/KS+PQm9baur87qaDKcHChleKDE/Wqe4qrC/N7eHiuieUPVcnplVaxjkYeTmEc7oguB+6gfEWOnOKSXFpM+OUaZZ6Cdr9LJr+ec+itG7r/MgIYDtf9Utd/+YDtcZFUnfU8lux6eEluUheTQn8kMCfpUWFCNhBllJ+58ttkbNJyxP0S8WFqKRrQA2QCthGYwiFMrL2zhy4OejlmR5c14wjj42iayCqJ8bU2OGFg9f/+AGTKxiE7ym7FUrWoGODO0lXj4Ziri2ZvaqZDCBynQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lrI2P/WhWJAk+mLTt+QKNGZZ822rmgJBpvq10C+9iv0=;
 b=cNnt5t9kJauqlbapsHaTfULAi65FoekAAVzG/YunGGZkIyqo2+TTR5yMr+Y28F4JzsrmRLY6rkyaWDCG+2ZXgpvXJ0INVutZh38gwdg0BUJoGomljvP+ihbW8EowBG3sclpBufgj0AIlnB0I/66UoBARBG3X12zidGjn1wPrBMs=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=microsoft.com;
Received: from BN6PR21MB0626.namprd21.prod.outlook.com (2603:10b6:404:11a::12)
 by BN7PR21MB1620.namprd21.prod.outlook.com (2603:10b6:406:b7::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.10; Sun, 13 Sep
 2020 19:48:18 +0000
Received: from BN6PR21MB0626.namprd21.prod.outlook.com
 ([fe80::85bf:2234:e01f:948b]) by BN6PR21MB0626.namprd21.prod.outlook.com
 ([fe80::85bf:2234:e01f:948b%2]) with mapi id 15.20.3391.009; Sun, 13 Sep 2020
 19:48:18 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     linux-kernel@vger.kernel.org, vkuznets@redhat.com,
        kys@microsoft.com, sthemmin@microsoft.com, wei.liu@kernel.org,
        linux-hyperv@vger.kernel.org
Cc:     mikelley@microsoft.com
Subject: [PATCH 1/1] Drivers: hv: vmbus: Add timeout to vmbus_wait_for_unload
Date:   Sun, 13 Sep 2020 12:47:29 -0700
Message-Id: <1600026449-23651-1-git-send-email-mikelley@microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Content-Type: text/plain
X-Originating-IP: [131.107.147.144]
X-ClientProxiedBy: MWHPR21CA0031.namprd21.prod.outlook.com
 (2603:10b6:300:129::17) To BN6PR21MB0626.namprd21.prod.outlook.com
 (2603:10b6:404:11a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mhkdev.corp.microsoft.com (131.107.147.144) by MWHPR21CA0031.namprd21.prod.outlook.com (2603:10b6:300:129::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.1 via Frontend Transport; Sun, 13 Sep 2020 19:48:17 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 88cd64aa-57d7-49f3-7c9f-08d8581df600
X-MS-TrafficTypeDiagnostic: BN7PR21MB1620:
X-MS-Exchange-Transport-Forked: True
X-LD-Processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
X-Microsoft-Antispam-PRVS: <BN7PR21MB16201A0F5381F32A4FE61609D7220@BN7PR21MB1620.namprd21.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: N9QHWbUYUnjZj7diOlnc+OAndsHlvox6pXw3nHglkA0cGoS7WOZxK4CKPJnfrchHpjQaCoOJRMUiVE0oK4QUcJNv7NTOBHju/zccp4oFHNyQfcbl/M6uJUSeEabANoPtJbrT1rd1F2U9ZhmgnNkrKUDGdEJnBET645bM9gWXrRmIP4Bwss/S/R46dQW/UjrYXghSHFJkMithAgvZQa06tV6SXg/eoOx03/Sj54eJYxyY17si0wWA8ShX/m4Cw87u5Fu5KwXWM19BAGheK1k2IEnj0jatocYDVQvy/X4c09FP1QVDrSF/EgljVRoixi9aXTKbENCxYluHai5LPP3qMqxHstJD2rBiOgZeyRl/UZEulr9azHEszQbB8z2sS054
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR21MB0626.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(136003)(376002)(39860400002)(366004)(396003)(107886003)(66556008)(10290500003)(66476007)(66946007)(2906002)(36756003)(316002)(478600001)(5660300002)(86362001)(82960400001)(82950400001)(26005)(6486002)(83380400001)(956004)(16526019)(8936002)(2616005)(4326008)(6666004)(52116002)(7696005)(186003)(8676002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: 3Z/ivFtGahMjROWeWYcgjqPQ5AbRCg/Hd/i2Zxg1c9JzUrukC/7kdXBEnrQ+biiXeUglLeYKZRuKXufnuHF+OSXPi+vfiXWHFPCVzQS90HfB5evugu1s58NoDI3vXwwQwYNQNApwd88KZvEsPJtgvbFmw/HWlKbmaV+p2EW/sjKfcN/Nu9arZVXLXeX+L3Na9CrrZWcge6w6NE0Q+OLU6bG9bZ1PJL7NGoRgU9+ZhVa38nfoHt1IBziKscuwCCtJavmoCuoH343+Q6daihpGKi/qtEb3CAicexrQ+l3s1zvLhbPt3ocLUBT+QI7a7HDKhhswmObwZLJmWcMd7aj/jjANZhY9gOSQotnRr3wkRCBvFi/JUZQUrcWlLu/Z+6Vbnd7HkJvRSWRT38UCqEe1LBFNvMBnjc0haKafJ8rZEqa/JuHLu8a5lVpuelZjPaXqAwVeUJGrkCSqLUvWApUGyZKhzSFl2F6K1K3/beyMPElLlnTqighpmA5zisrv7z/Ormz7bV5kJHVSX821vFCvdMJoi3Z0tpT7bfzv5lqeiNrlYtwTKnBW7UpsvSBi8IxP1H1iM0p3AmRA+HWCtgQTn8MGW4qua2Y7NPvGozZR61L29baaFeuW/QeyhKfPRYsbPcf7pQOOyhuJ0aEzkvAtPg==
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88cd64aa-57d7-49f3-7c9f-08d8581df600
X-MS-Exchange-CrossTenant-AuthSource: BN6PR21MB0626.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2020 19:48:17.9647
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PSef4RI1DjugvhF6IieWoLz3Kyi4MFJVZMbLxVIOTVopyCzZlh2jU7vClzwmPpj4XABJSzLiIryfBkhkk5gmWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR21MB1620
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

vmbus_wait_for_unload() looks for a CHANNELMSG_UNLOAD_RESPONSE message
coming from Hyper-V.  But if the message isn't found for some reason,
the panic path gets hung forever.  Add a timeout of 10 seconds to prevent
this.

Fixes: 415719160de3 ("Drivers: hv: vmbus: avoid scheduling in interrupt context in vmbus_initiate_unload()")
Signed-off-by: Michael Kelley <mikelley@microsoft.com>
---
 drivers/hv/channel_mgmt.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/hv/channel_mgmt.c b/drivers/hv/channel_mgmt.c
index 591106c..1d44bb6 100644
--- a/drivers/hv/channel_mgmt.c
+++ b/drivers/hv/channel_mgmt.c
@@ -731,7 +731,7 @@ static void vmbus_wait_for_unload(void)
 	void *page_addr;
 	struct hv_message *msg;
 	struct vmbus_channel_message_header *hdr;
-	u32 message_type;
+	u32 message_type, i;
 
 	/*
 	 * CHANNELMSG_UNLOAD_RESPONSE is always delivered to the CPU which was
@@ -741,8 +741,11 @@ static void vmbus_wait_for_unload(void)
 	 * functional and vmbus_unload_response() will complete
 	 * vmbus_connection.unload_event. If not, the last thing we can do is
 	 * read message pages for all CPUs directly.
+	 *
+	 * Wait no more than 10 seconds so that the panic path can't get
+	 * hung forever in case the response message isn't seen.
 	 */
-	while (1) {
+	for (i = 0; i < 1000; i++) {
 		if (completion_done(&vmbus_connection.unload_event))
 			break;
 
-- 
1.8.3.1

