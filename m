Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E5CE23DBFF
	for <lists+linux-hyperv@lfdr.de>; Thu,  6 Aug 2020 18:42:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728730AbgHFQmq (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 6 Aug 2020 12:42:46 -0400
Received: from mail-mw2nam10on2126.outbound.protection.outlook.com ([40.107.94.126]:11233
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728044AbgHFQkn (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 6 Aug 2020 12:40:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jKIA9J4TN9RQrhpqfkJ7r6JWLkHeUuOpaePkjUbRYTH1OtWs3WyelZk/2/DAv4963RqyxZ6GEo0gN8L9ZTm1+o97b61z0PwCSY5P+Z8wbj+OCLeu4FtcMONWvz8B3vZN86T5r6uTG3wXCqwGnhONOMmsbADF3FgO0tlOU5kI/HqKuTcM3wuCDKUIgRH83K2cxLYaaxmu3htejJZgIYPCBIdqaPT4ztXJf3pN95gXm1fzrG4sB9WbFHfz+Ymucx5eBVwAAljQqk2XvhK+JTtUhLJMs+WLdT3Qqj/hWTXiwMfGcko3S0GtH9AFUue3ddVfLmS4HjfJ11xi9LPWToSWQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9caEBipuwoyCFtQi9NjVhEVyfpl1tRyUcYEau2Yz4Bc=;
 b=b5GSZxPU5ZNuUQJDhbQP18Ig0IAtoIZcO16o0KwIp2Sp2ryM3w9+Q+cjdU9p8Ho6imXLA5/lyEJmJL+k+GrHL7oHaqnNnNoGcF/rVh29ogfh+aXK7lTtCffLuyR1XKTsrd3KlPGs38k43u480Iof7ItMzgugdAHzLJ1NBqsPzQkO0hEXfGJ0YnMoNHIPBMaSP5kYDtAOOaglm/y5yw8a1W8aoVLDNe6AH15Ke+1C/WmG49L5k7NqhYfnthdb4iEVCiKsWHEEcoYWRAc3vrroSbG1CzU6fLg8T4e1IkI8bM8EAZjcpkLRHhKmtkdkyk5CU3a+wsa8gcw0KbbyDfwW7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9caEBipuwoyCFtQi9NjVhEVyfpl1tRyUcYEau2Yz4Bc=;
 b=Hq3nuT2zL2KmnnjEbmAAvwRQ9mrbC4jNrhxSAuNFLh6InihcXIxUaiuxhg0x6K4Y9PFvOJ3mIbCGmO2La99axuq6HY56JlwPo4s4BN45SYZIKDwUD/wZlXrcC1CB514dLJ10hlrKex3Z4AnL84O0Kto5EKsa2vLLrfcd8ORT/38=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=microsoft.com;
Received: from BN7PR21MB1636.namprd21.prod.outlook.com (2603:10b6:406:b8::32)
 by BN6PR21MB0788.namprd21.prod.outlook.com (2603:10b6:404:11c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.2; Thu, 6 Aug
 2020 16:23:07 +0000
Received: from BN7PR21MB1636.namprd21.prod.outlook.com
 ([fe80::60bd:f5dc:fdc4:1600]) by BN7PR21MB1636.namprd21.prod.outlook.com
 ([fe80::60bd:f5dc:fdc4:1600%2]) with mapi id 15.20.3283.004; Thu, 6 Aug 2020
 16:23:07 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     linux-kernel@vger.kernel.org, vkuznets@redhat.com,
        kys@microsoft.com, sthemmin@microsoft.com, wei.liu@kernel.org,
        linux-hyperv@vger.kernel.org
Cc:     mikelley@microsoft.com
Subject: [PATCH 1/1] Drivers: hv: vmbus: Only notify Hyper-V for die events that are oops
Date:   Thu,  6 Aug 2020 09:22:15 -0700
Message-Id: <1596730935-11564-1-git-send-email-mikelley@microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Content-Type: text/plain
X-ClientProxiedBy: CO2PR05CA0063.namprd05.prod.outlook.com
 (2603:10b6:102:2::31) To BN7PR21MB1636.namprd21.prod.outlook.com
 (2603:10b6:406:b8::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mhkdev.corp.microsoft.com (131.107.147.16) by CO2PR05CA0063.namprd05.prod.outlook.com (2603:10b6:102:2::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.5 via Frontend Transport; Thu, 6 Aug 2020 16:23:06 +0000
X-Mailer: git-send-email 1.8.3.1
X-Originating-IP: [131.107.147.16]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 50243b20-6b60-4873-b696-08d83a250091
X-MS-TrafficTypeDiagnostic: BN6PR21MB0788:
X-MS-Exchange-Transport-Forked: True
X-LD-Processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
X-Microsoft-Antispam-PRVS: <BN6PR21MB0788498FB3D3EAA7A292BC9BD7480@BN6PR21MB0788.namprd21.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1107;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2+1C8TbiIYJOhxxl1wDqcqC6wjt4HwwHk6Rf6kBLLn3M0ojNcRk/fJtxmn+9URCgV63Gh+m91O89FKmITyWOG/BC/d0MV7eibcCZqE8WeQvJkFMJV52Q6Or4mg0jwo+Nh0Xwus9x8AO6TicClSGleZf6aAWkzOtz5JrNTvi7YLnbjULBbqG1+LdNkLprrAq/FrI/wvJPm14lurAaDOcIfxQm7aKzwv4rPjLogBIjpnvCRz8GUt4NSCTAOUh2m0z76jPWRL16BeQHoAzJKVuygkSc6dOd4v+BFzB1PjI/5l510bHBlNrJT4yY0iOGwGXd1UA0p+np8k16Mv6qDMXP3Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN7PR21MB1636.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(136003)(376002)(366004)(39860400002)(346002)(8936002)(66946007)(2906002)(956004)(4326008)(8676002)(16526019)(107886003)(2616005)(186003)(6486002)(36756003)(82950400001)(82960400001)(26005)(6666004)(66476007)(66556008)(478600001)(10290500003)(52116002)(5660300002)(316002)(83380400001)(86362001)(7696005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: VztDI+aT8cM/UakYM+pcE8qqHkU2q2BtASE2djfmlrh1VpU2kaLsiGNE5HolOXk6so+rPX0Y1STSQ7suIBi0FRkFjVDrMckIz4sehwn4Ve284I9Suo+5p4hWtogx6mAUkOrUr+hEIIpqMnhXOX0Nrklp81HgTPA9QcR5R5Mp+67ASCMSe481HLsRAK8fU3MJTiyE5dqueaidh+z7cu5+p37U7OPMw5h03BYi7q89ONgHfaClgArcy93k8QcF6FnpHUFwJR9V81kgJk1Mu9yNHVIAq4I+wuTNi07JWhITEYuwrqX2920HwPO/9GageLMX1kJsCmbQbWkX2vh4mbAqsMTCMGa6zGJQf9OHLtG1VFCwVeJbWOhZHDu6jEOO3YygDApnf9w8yAa5mQLZtm9JiaKxzffAv8UEhm3bZQieIlr7QFoH2l/tYvN+8+dWrrG+drYgJePv9cnf8sES25BPyUVNyPmGDXqCksrefDDJVkz80E6hF59qq6wa+pCWki8gOkLXk6/AUdEvwpi1yvoL6gzH24IfYqbipIxux88c3vNNhrlAj1eGUQzYLamIBMfdCvBcG+FUm+OZPmEXI+7MyJz9KgPnkCES5yR3x6Jql9AhRaO9suwxqdX3esH26fUtfnlxup2z57xe9KYDC0+K4w==
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50243b20-6b60-4873-b696-08d83a250091
X-MS-Exchange-CrossTenant-AuthSource: BN7PR21MB1636.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2020 16:23:07.3593
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RmaPLuYA3puAhUQJIZnJUM86kri7p+9BYSWG5kP086naQVcVeWejEVMxQWV9VznLtS0DjeJAT4jwYi3lqpWnvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR21MB0788
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Hyper-V currently may be notified of a panic for any die event. But
this results in false panic notifications for various user space traps
that are die events. Fix this by ignoring die events that aren't oops.

Fixes: 510f7aef65bb ("Drivers: hv: vmbus: prefer 'die' notification chain to 'panic'")
Signed-off-by: Michael Kelley <mikelley@microsoft.com>
---
 drivers/hv/vmbus_drv.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index b50081c..910b6e9 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -86,6 +86,10 @@ static int hyperv_die_event(struct notifier_block *nb, unsigned long val,
 	struct die_args *die = (struct die_args *)args;
 	struct pt_regs *regs = die->regs;
 
+	/* Don't notify Hyper-V if the die event is other than oops */
+	if (val != DIE_OOPS)
+		return NOTIFY_DONE;
+
 	/*
 	 * Hyper-V should be notified only once about a panic.  If we will be
 	 * doing hyperv_report_panic_msg() later with kmsg data, don't do
-- 
1.8.3.1

