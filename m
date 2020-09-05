Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9688B25E528
	for <lists+linux-hyperv@lfdr.de>; Sat,  5 Sep 2020 04:56:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726597AbgIEC40 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 4 Sep 2020 22:56:26 -0400
Received: from mail-bn8nam12on2110.outbound.protection.outlook.com ([40.107.237.110]:51457
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726329AbgIEC4Z (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 4 Sep 2020 22:56:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I0f+tOB/ft1+LR5n1cFfuisZprm4qHOPciZxloKi8H5we5SE2zyRzZq0QhVsjEKWu4hkq0Wo0/ie6uRP4d1vHHpniGpXXty/gwjt84jqFTbRFHEX4iTZEmIEHezWYHJYPRpOpZ1jEz6t0QwJ6OXryIY+G2lARnsd2MIFqQ7JQSB1vqUhLblMAfdnHZ7LmmpQMVfMxLdJV7ZKmfkOqhaV50gc73d+0PnOMZ9qq6pR006brxOElR1aGuGxu5PQd7UYw+hh8u5NZQ2RVaTf9klqAybGvTdtF0RJutn230BtYZsBLa/R14C6bWgxWzzLj73a8axuYdjhXBvATyAzFvn2IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8wpymMGYpMHaQrj0Zgt9h4hGliBljBPXMpRKnbJ0rlg=;
 b=Pwp2uVBeb+S19Dg+v9abHKKzvuSjkX+ae1oFMq19LXrdt1ehGMxO09jJL5w9j5LotoTr/FUjcaucBEdF/Dfk4BgwRCfM/h/05cEpwq2BsDKFsM4Yh0Opo9SESDrarOTKT6bZUHyn+AsNpIfCqbRecekyLbqTxRbjPHMmNp9H3XlRrk/hHBcSh8kgRtj+3IfyMKZNXt7cj7Z4qdxlCi0X9pEsaKPVWzFlp36J4yfh1L614Q+MtcY0hmJ4ugINsvHUFNQtDyz5ihrsE2rsfBLOmq/7Ra+w2fV4Jzlmo52hXM3dgXJfnP4ajk2ynPZQvOYzyjsqqRjDRFg5JP9GUviQsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8wpymMGYpMHaQrj0Zgt9h4hGliBljBPXMpRKnbJ0rlg=;
 b=UGAPJ1srQHdwV0Hjgg35kUC1yw+pesROxOXWcQ92PUjho3PUmR/Hg/3SRrn7hfDg5x0z1BpKxKU5pnJosgVieCcQ4XQv/QI1o0xQwadJaJyyEJ0x71H0ulHEZ+2Lw4D2v221eMfEVyU4cmoPsZViltNjwWmqWdvnPs6ayB3S0DQ=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=microsoft.com;
Received: from BN6PR21MB0162.namprd21.prod.outlook.com (2603:10b6:404:94::8)
 by BN8PR21MB1155.namprd21.prod.outlook.com (2603:10b6:408:73::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.1; Sat, 5 Sep
 2020 02:56:22 +0000
Received: from BN6PR21MB0162.namprd21.prod.outlook.com
 ([fe80::85e9:34fc:95a2:1260]) by BN6PR21MB0162.namprd21.prod.outlook.com
 ([fe80::85e9:34fc:95a2:1260%14]) with mapi id 15.20.3370.014; Sat, 5 Sep 2020
 02:56:16 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     wei.liu@kernel.org, kys@microsoft.com, haiyangz@microsoft.com,
        sthemmin@microsoft.com, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org, mikelley@microsoft.com,
        vkuznets@redhat.com
Cc:     Dexuan Cui <decui@microsoft.com>
Subject: [PATCH] Drivers: hv: vmbus: hibernation: do not hang forever in vmbus_bus_resume()
Date:   Fri,  4 Sep 2020 19:55:55 -0700
Message-Id: <20200905025555.45614-1-decui@microsoft.com>
X-Mailer: git-send-email 2.17.1
Reply-To: decui@microsoft.com
Content-Type: text/plain
X-Originating-IP: [2001:4898:80e8:f:d8d8:275a:eb59:9dcf]
X-ClientProxiedBy: MWHPR04CA0028.namprd04.prod.outlook.com
 (2603:10b6:300:ee::14) To BN6PR21MB0162.namprd21.prod.outlook.com
 (2603:10b6:404:94::8)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from decui-u1804.corp.microsoft.com (2001:4898:80e8:f:d8d8:275a:eb59:9dcf) by MWHPR04CA0028.namprd04.prod.outlook.com (2603:10b6:300:ee::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.15 via Frontend Transport; Sat, 5 Sep 2020 02:56:15 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 9890f666-5f9b-484d-11cb-08d851474206
X-MS-TrafficTypeDiagnostic: BN8PR21MB1155:
X-MS-Exchange-Transport-Forked: True
X-LD-Processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
X-Microsoft-Antispam-PRVS: <BN8PR21MB1155E439C46AAEDF5E636A4DBF2A0@BN8PR21MB1155.namprd21.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Mk/4vHA6HUQOMlWi0ZUsQA9QGByNvN+e1fq9/neJjHiFoZCaoMnzLsE2/j1VTJy3o+VFgKeMIKrJFocHgGnK1+QNFbejlwvhocfRi/EFtDufn77/8137wpg/T8MT2yeK7cwcQPLiVIWGMf3OCbs0MtWKQazVfAx3xDcW6MEhiclBfnPg3sPZ7P9i2Cwq0kHlIQFR96WsWuJ9qZPx/mdPO2yLgmuGG8YgKjk76i0/u75ZLCvq95H5puoscmctOu2jeJIO9o7faOigR8kd62u/ipwSRH2RwApmZoNI6OBch1jSnMFe4/hB+i0pomoDAKjOuW4Tf10006lninE5svrnJqwbbLT1Q5z8mSC68oXqyzVao3egZ3EA0zV0FiPCbUB8
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR21MB0162.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(366004)(39860400002)(396003)(136003)(376002)(2616005)(82950400001)(82960400001)(186003)(52116002)(316002)(83380400001)(8676002)(36756003)(8936002)(3450700001)(107886003)(478600001)(6486002)(66476007)(7696005)(16526019)(10290500003)(2906002)(6666004)(1076003)(86362001)(66556008)(66946007)(5660300002)(4326008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: EHCJ1akTnnZ7gOpNm82/JU0nITpjckUOna0g8EiHRLR0jk3JQ/pEhpNR6pjTrzI/HE4xO5NwPBr2gfTeHOnxe6WfSKyX8YOz+A6tDQjD2cSFeDp0+Y5dhjCM0juVnxNBZexurR8KGzndYagN7VSnBbEkofrceSFmv5VCYkhzbHopZi0Si05hLKK8hOnZR9O1K1Uw0G3moBaH/ogOAmclaZ1pDaduZfzpTxIvt6jay4sJSQ/FRJkkwzGpTpEoAehCiAHMc9e1uBpvPS+vFN7IvZpElJpJjrF6XyLEzdP5HjVi/aM4+GHZju82D+HszdfDC0tM+XnH748HaHPcEpOMyB8z3/npkZgQGiPkLbmxAsJv0okgABm05g7IN8Hp2yBeV4/erKflma9znUtK4pG0fX2iu6ydO5TIk9wQB8QhGhlFWTODM+UHr/YLLRvAKXQp4BTjfK+WCKrKCr9f95VvqmCFdBvN4T0vaGE5gqtwo87CrOz+UlwRV6S4vi4YBL3NBnf/FKBVsXzmpYH0cAbUZ2njTy915e6t7OBMYHzchhYIkxsAUzOnRstk9mM1KD+a6umjSV63HGTdnQhFNlH439ryw6B2AWAV8XgdhNNMu8XPNeMtHYqknjZs/ZlEWcDtU8yUNiPlrmsRyRm2nQvQMgt4NruF8xO8gU/RMcSVv9luSc4nlQXeOkyOH54ReTzPq8glyKsugrmbl+/SrHPZVA==
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9890f666-5f9b-484d-11cb-08d851474206
X-MS-Exchange-CrossTenant-AuthSource: BN6PR21MB0162.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2020 02:56:16.7286
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LHPqvUkYZBA3LwF3eDVVILdWZqpNNANQn+ZPyLCOR4LOknTJuBokLvN+XTN87/FOC5qF2KRZcuRdKoA1AW6Ymg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR21MB1155
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

After we Stop and later Start a VM that uses Accelerated Networking (NIC
SR-IOV), currently the VF vmbus device's Instance GUID can change, so after
vmbus_bus_resume() -> vmbus_request_offers(), vmbus_onoffer() can not find
the original vmbus channel of the VF, and hence we can't complete()
vmbus_connection.ready_for_resume_event in check_ready_for_resume_event(),
and the VM hangs in vmbus_bus_resume() forever.

Fix the issue by adding a timeout, so the resuming can still succeed, and
the saved state is not lost, and according to my test, the user can disable
Accelerated Networking and then will be able to SSH into the VM for
further recovery. Also prevent the VM in question from suspending again.

The host will be fixed so in future the Instance GUID will stay the same
across hibernation.

Fixes: d8bd2d442bb2 ("Drivers: hv: vmbus: Resume after fixing up old primary channels")
Signed-off-by: Dexuan Cui <decui@microsoft.com>
---
 drivers/hv/vmbus_drv.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index 910b6e90866c..946d0aba101f 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -2382,7 +2382,10 @@ static int vmbus_bus_suspend(struct device *dev)
 	if (atomic_read(&vmbus_connection.nr_chan_close_on_suspend) > 0)
 		wait_for_completion(&vmbus_connection.ready_for_suspend_event);
 
-	WARN_ON(atomic_read(&vmbus_connection.nr_chan_fixup_on_resume) != 0);
+	if (atomic_read(&vmbus_connection.nr_chan_fixup_on_resume) != 0) {
+		pr_err("Can not suspend due to a previous failed resuming\n");
+		return -EBUSY;
+	}
 
 	mutex_lock(&vmbus_connection.channel_mutex);
 
@@ -2456,7 +2459,9 @@ static int vmbus_bus_resume(struct device *dev)
 
 	vmbus_request_offers();
 
-	wait_for_completion(&vmbus_connection.ready_for_resume_event);
+	if (wait_for_completion_timeout(
+		&vmbus_connection.ready_for_resume_event, 10 * HZ) == 0)
+		pr_err("Some vmbus device is missing after suspending?\n");
 
 	/* Reset the event for the next suspend. */
 	reinit_completion(&vmbus_connection.ready_for_suspend_event);
-- 
2.19.1

