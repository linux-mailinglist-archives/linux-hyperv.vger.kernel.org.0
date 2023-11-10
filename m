Return-Path: <linux-hyperv+bounces-841-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E64887E7D11
	for <lists+linux-hyperv@lfdr.de>; Fri, 10 Nov 2023 15:39:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D827F1C20C7E
	for <lists+linux-hyperv@lfdr.de>; Fri, 10 Nov 2023 14:39:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 242811BDDD;
	Fri, 10 Nov 2023 14:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="Nzq++K5Y"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 453711B277;
	Fri, 10 Nov 2023 14:39:33 +0000 (UTC)
Received: from BN3PR00CU001.outbound.protection.outlook.com (mail-eastus2azon11020002.outbound.protection.outlook.com [52.101.56.2])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EA8A3975F;
	Fri, 10 Nov 2023 06:39:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QwO+lHJ3PylyOuc7ihJWzMVunuFFNAjsqA38/lmVBmo9I0jrm60vZsdiMXVnDyrCJud1uhQJgKfGbQr5zv6GKLZ7FdieDjejoATLDjGHLaRseGRBM2uPukF0AJfKf4czBXP/ILQwklJFDxVDI5jB4JcWopjvai2wfFBNXzghHTTfLE4WvqvX3ee6Szh1arfrHZjE4P1olSKcQq4I18seydo3KZvDzxq4k9e0NVzBwDqnnZhoLlO0kePvaNI9VLJM//f2fIZcC9mIcnngeMkWjL8q2NA2MhzUU/SQjoCF0aJ9cj2tpUXrJhKyHpd8p9yF45IMI9LST352Jfgsf3cpow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MZ/Z+wZqXzBp0DmrZmn2klOzTh3oa47/EOBDXfmzt1Y=;
 b=EOB7v76JV3y/Ewb/02Mp6dCz/6gjTA1YZ+Eij4kpIMKjvPNh+LAF08vEiTxy84cnQaWwtJiaWQbeFVMg8XEgGF9QqCsJD7sj03sIuWIygnZs57WF/Wt84T7rZSAFIc9QdPc6nypBZVxRHiEo3HD2E9ej6kCzEbR1JmnUVr5IP5qTHV+Rky+vOw0Up9bHopVDeShHeXR351RrM3SGUzyqm6LViRS55nPr7/v3Y8rqgobEzE5rAG2ob9kdTFJ8jwisbd+1xLK/G536SHAbFfL4oyOAWaKYce7qxEU5WJKsiihBPbX2tQiL7BcjxDo/0j8l1b4zwYeFsUm0DHrzHAZL4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MZ/Z+wZqXzBp0DmrZmn2klOzTh3oa47/EOBDXfmzt1Y=;
 b=Nzq++K5Y2YmvEjsyKzZxDbKzgMedypRPx8avkomGqEoddKc+mii50qABq8lRUtmdYP/9f73jEOoVg5PJy7zt1uuE6cQ8tUX9AIClFryrHnWi6qWD3h9YTz4NG803/OTqc0SuLqFbIRYTVQ72TIU/8ynRXieKfNDhEqObzjL3Y80=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
Received: from BY5PR21MB1443.namprd21.prod.outlook.com (2603:10b6:a03:21f::18)
 by BL0PR2101MB1348.namprd21.prod.outlook.com (2603:10b6:208:92::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.10; Fri, 10 Nov
 2023 14:39:29 +0000
Received: from BY5PR21MB1443.namprd21.prod.outlook.com
 ([fe80::2f77:8844:9c3f:58c8]) by BY5PR21MB1443.namprd21.prod.outlook.com
 ([fe80::2f77:8844:9c3f:58c8%4]) with mapi id 15.20.7002.008; Fri, 10 Nov 2023
 14:39:29 +0000
From: Haiyang Zhang <haiyangz@microsoft.com>
To: linux-hyperv@vger.kernel.org,
	netdev@vger.kernel.org
Cc: haiyangz@microsoft.com,
	kys@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net,v4, 2/3] hv_netvsc: Fix race of register_netdevice_notifier and VF register
Date: Fri, 10 Nov 2023 06:38:59 -0800
Message-Id: <1699627140-28003-3-git-send-email-haiyangz@microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1699627140-28003-1-git-send-email-haiyangz@microsoft.com>
References: <1699627140-28003-1-git-send-email-haiyangz@microsoft.com>
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0052.namprd04.prod.outlook.com
 (2603:10b6:303:6a::27) To BY5PR21MB1443.namprd21.prod.outlook.com
 (2603:10b6:a03:21f::18)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Sender: LKML haiyangz <lkmlhyz@microsoft.com>
X-MS-Exchange-MessageSentRepresentingType: 2
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR21MB1443:EE_|BL0PR2101MB1348:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f2ba22a-8a5e-478e-1943-08dbe1fad8b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	IpbeJD3bZWjKPjdgeh91nOV6PqF3nXp4P4WzSLK9u7PmB4T/x1JbikSYV9grIMLQ9Hu6K76Oi/8hD5C0CDwzmIC8aH4cOvOfELXq3xxFM1JA1NaxlDJ3PFMYM/ll2C6nlvn2VnhwvOVRBvkGPE3xXzUATLH7dVaYe8tQYeyfNkbb9DxCRy/G3qZUz3BoqkPfJSZh3VlXQAeWkZzOOuOQRwrB9t6TR46aPpMVGbuYEqh0oozWftniG/R2xGlrTWb0z2rbKIe//1+n8PuvBXclag+DzRuH4p20ZB+2ks7ZahwAQE4MNRkyhWO9WOKjcm5mCqwl6v4zslENMes6HnR9+ApL5DMoP2FLr21jswjA1wV62KknqBPyHCe+7boYKh3Jf6O+oo5NqRw43QPWGkg5Ooo/Ej/LionO/gx6M3j4y0Lki8dRhJwszjNc6JFnWOMYoQ3bLOflK60jyLy28b/5f+TYJ8q5EkLFUCmCEt2Zd3kGO69Qv7kH5kOXgDUkL00m3UeUGr8CYNAWe9MQ9fnXu5kTqhIWpuMWPUYhuCqalf4W62q4meZj54ZeJHFC/z3QEmEjEaB+Ec+ZcIUWmJEcDh+6QOoR7x4qs7Hi55KwNVbgExm7LYhK/3Dy5UVPqjbyCoFjIJBgwpvHs4+Y4Vwa7JPV2fF2jUlBVotVhM+2e70=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR21MB1443.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(136003)(346002)(376002)(39860400002)(230922051799003)(64100799003)(186009)(451199024)(1800799009)(83380400001)(4326008)(38350700005)(2616005)(82960400001)(26005)(66946007)(316002)(66476007)(66556008)(41300700001)(2906002)(8676002)(8936002)(5660300002)(6666004)(6506007)(7846003)(52116002)(36756003)(6512007)(10290500003)(478600001)(6486002)(82950400001)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?E9uTL8kewewVCYNtuSL4H5rIqxKjJZ+dr9pn/aGQ0Ma+ZnAMIkjQ61Ws6EEd?=
 =?us-ascii?Q?hXTAJazAS15K3RtMw2MDsMJBmXcvlP6iJxASHKvhdUg6nUy0TvGBxJm+YGqt?=
 =?us-ascii?Q?hhw6br9FK70icWSdvY8xvjYvRrou4oNFKD3KVnGMFCvhTLltPcvZHXG/avmc?=
 =?us-ascii?Q?uhh1QLmVS8soM1CdnOrKmWlDm7JV4n0Bf/b4+ndzvnKFSoXum7N0q/dNQDkd?=
 =?us-ascii?Q?vRyZ5fmKtkaPCI9kbVmGW/WHCBipmSTVF3TjwQH9fxhm2SU1embW/gJ1Tbsn?=
 =?us-ascii?Q?mcsMqcuh02HCDl0uYRkvhSV5Yuz918VIElVt8lm0z15YvbKToTevhR51zAHe?=
 =?us-ascii?Q?7yrBfLxASL+u7wdYU3M1IF7FQQKnO6dYoW8wozPQ+QxIgk/3n8zmmvD1Zqz2?=
 =?us-ascii?Q?lXYoVg4ZOpjSeTS77Vxg+KHxQyE159Ln54www7KHO+pPgywd721JWAzuOYyu?=
 =?us-ascii?Q?dD9cDbJqK6T7/vPqpLD1LImbQ5kMmV7JINWdAVl47tyrag2dDUvCZ3iWaGy6?=
 =?us-ascii?Q?B+x0xGqFt1HWJWPm6hC70OyGff/TzYK7ij9cEyEx6QcuJUsXzJbsbvmnnpCt?=
 =?us-ascii?Q?TgFyj5rd9vAAewQC1mMyeXBDLAOLJNRWzPTW0l6yVyEy9tX7ysFD3CHLJs1m?=
 =?us-ascii?Q?JzYrE53HoO0Ntx1+g6nd+wGvpzmRGYzjLuvHLIqLlnNbP1e7pKC/Z7LUPIWS?=
 =?us-ascii?Q?49z8xUfb8gKGAcDd72Ekucglz4IdfxpMr58UvTaAB/UQRmqFUzJGrzLDCKuL?=
 =?us-ascii?Q?5zeGZHhNDhA8tn1ea+i9EmX77E420rfNu2Drs16nQGo70JDF7GZaJmVabORS?=
 =?us-ascii?Q?wcrQ93ZWoU9tcb/EntOP30J9Z34+LV48bXL+LGF/kekuzo7frnb0frI896sH?=
 =?us-ascii?Q?/2+K/Z1SPX+JxI0PqWHzUUNCwFbN+or2N+bhmEwUrt2U4Y4JTIMNrwIoeq0x?=
 =?us-ascii?Q?2E/yHovaYkGVL9QY/TWrrCtNnfwIQLZhKANL1zpicf/uYlTfKbSJVGLRsRCT?=
 =?us-ascii?Q?bKjDL5JTq+fi76KgaKLne/S0Zj0puzbOmyxCtsu9ORpH6oZqQi9OSIPdaK4N?=
 =?us-ascii?Q?N83SsD8smHn6hlm0SXjqBAgxD1n908THOFNh5td4F9sY9GMte4FQp+lcfFxr?=
 =?us-ascii?Q?dcpiOAoY/HbVdyfeaI5p13ZL4xr4QDQ7uZXR/7jP4eQomXQHzrYc7yrN9F8Y?=
 =?us-ascii?Q?Kdza5CtyLWHLvEtfY5vIoBbCPQW345uwgBkPnVa6SnBGegqSlfr1Sfb7nrAE?=
 =?us-ascii?Q?Di7RBvMv5qkQt77YoI4LPb067ZiCFtXVi6l0NgTpwdCAHXjsf1PJc6chU9An?=
 =?us-ascii?Q?ZWmEVXh0teg7UQCDEHe+hkl2B7+fQUFAosC8M64KBLHtZ4R16UuWGm+V4UuL?=
 =?us-ascii?Q?flQhtftIppv8O2hLTgFImi5qnNgM74ASFKfMj1MKhUeytq9Dx5iwWpTgBlfP?=
 =?us-ascii?Q?1jgaqBc0m8uKDyl+Y+aPENzK6dSOMVKbvAIm+1C/AzITQbdH0983dohIdjfY?=
 =?us-ascii?Q?jKxVTqKQkcVdQW1OgDKA4MoaJGsKm1fW+4hKTeigDJnF9wIlFtn2E1RfsWv/?=
 =?us-ascii?Q?rgc9ZS7+v2OQ/Y7Dm8IjLvjyA7eDFDHWYLEedpfA?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f2ba22a-8a5e-478e-1943-08dbe1fad8b8
X-MS-Exchange-CrossTenant-AuthSource: BY5PR21MB1443.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2023 14:39:29.8239
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tQyXCxpPKyTASCGI1NMSKqSmRpXN5f19NIVwxUkv+eruTLN5Qt5AOu8dJSbL0lEtkJ9J7TnLaBKkwwU46Kj13w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB1348

If VF NIC is registered earlier, NETDEV_REGISTER event is replayed,
but NETDEV_POST_INIT is not.

Move register_netdevice_notifier() earlier, so the call back
function is set before probing.

Cc: stable@vger.kernel.org
Fixes: e04e7a7bbd4b ("hv_netvsc: Fix a deadlock by getting rtnl lock earlier in netvsc_probe()")
Reported-by: Dexuan Cui <decui@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>

---
v3:
  Divide it into two patches, suggested by Jakub Kicinski.
v2:
  Fix rtnl_unlock() in error handling as found by Wojciech Drewek.
---
 drivers/net/hyperv/netvsc_drv.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/net/hyperv/netvsc_drv.c b/drivers/net/hyperv/netvsc_drv.c
index 5e528a76f5f5..1d1491da303b 100644
--- a/drivers/net/hyperv/netvsc_drv.c
+++ b/drivers/net/hyperv/netvsc_drv.c
@@ -2793,11 +2793,14 @@ static int __init netvsc_drv_init(void)
 	}
 	netvsc_ring_bytes = ring_size * PAGE_SIZE;
 
+	register_netdevice_notifier(&netvsc_netdev_notifier);
+
 	ret = vmbus_driver_register(&netvsc_drv);
-	if (ret)
+	if (ret) {
+		unregister_netdevice_notifier(&netvsc_netdev_notifier);
 		return ret;
+	}
 
-	register_netdevice_notifier(&netvsc_netdev_notifier);
 	return 0;
 }
 
-- 
2.25.1


