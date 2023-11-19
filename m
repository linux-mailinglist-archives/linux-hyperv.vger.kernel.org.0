Return-Path: <linux-hyperv+bounces-988-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DCEA57F077F
	for <lists+linux-hyperv@lfdr.de>; Sun, 19 Nov 2023 17:24:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 882CB1F21CB9
	for <lists+linux-hyperv@lfdr.de>; Sun, 19 Nov 2023 16:24:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E81E14295;
	Sun, 19 Nov 2023 16:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="UT5Lvm3Y"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from DM6FTOPR00CU001.outbound.protection.outlook.com (mail-centralusazon11020002.outbound.protection.outlook.com [52.101.61.2])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83A401AA;
	Sun, 19 Nov 2023 08:24:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OVWZLVoCRupSuYzqmLcWbQ4TEnvPSC/9oEAfMgAuMk7zno2Lpmw6yOTBtgp7V05XPjRhPSVGvcKHtKjZVBl0kH2Un8FXwU3OyP8Q8/FLrCXhUqMkGOXflmWsmNaFMft9V+2D+O7ZI5G7bjdPevCnWTL8Fstr61UpMt+zl3v15XZSBZxw/9kS4wbA1YFItEVDYCHH8WNqXIPkUmHKVUCSXYjwaMSUN3At7dErh5ZYG+DViAE4QltF1WpMvKJWmqvexVU96NYpKkPeZUORebbg64SAF0PVySb4ZVcw8rvc02rzxmDH3WzI4W4H4BnSAQLmJ40wYdEu9oJAbHpTQMHWjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0of2UfaZwNf7YQmNkJmzWnf2upmP22cYVHyP/Kb+l7k=;
 b=mKh0Jyv1KoReIiIhLsStco3nQ2MRZzPkjVIkx3PvSU+PIA55wRR7bkn5E8qKFYdJqgy639q5ntqAf1LSA5OCXQEk8keDFxkKs7WECxJtujnwpuMLz4nRDtzP/4XGo2S25O0uswJObyjuHRoZ0sx13Svyv5ztAgOvMIVZQfpNlhwsnrsMEWtT6tPqrPSUXEB8f3YBUA7UDz1KxxlbXxJlh2mkBF27ONul/s8oo910oNNb2bDXE8P4EwDfWF5EY2TNFFJaTf79O+2W3Ax0XGLvsJYy/sNz6UyLLHiM4/SYDObFbJVhIUhqDI6zyxUGw+YLajFV1xgGQ/wL65y2qwxoKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0of2UfaZwNf7YQmNkJmzWnf2upmP22cYVHyP/Kb+l7k=;
 b=UT5Lvm3YbrP3cNKx9DBu7CNoBZYWFFv2X0tNRQYfw7LryA/uq4sUo7ajkWRXLBXNjGx6n3Ih4SAcWo2GqmTL0vpv3ZMNg6whzq46jnukVq2x5sP/AB1gzmGQd+OjnNBqVbd4XH7QBsPSY255vLleA7BxJz+vV/m0MV4rOLXAxBs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
Received: from BY5PR21MB1443.namprd21.prod.outlook.com (2603:10b6:a03:21f::18)
 by BY1PR21MB3893.namprd21.prod.outlook.com (2603:10b6:a03:52d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.8; Sun, 19 Nov
 2023 16:24:27 +0000
Received: from BY5PR21MB1443.namprd21.prod.outlook.com
 ([fe80::d819:9f58:df81:2d20]) by BY5PR21MB1443.namprd21.prod.outlook.com
 ([fe80::d819:9f58:df81:2d20%3]) with mapi id 15.20.7046.004; Sun, 19 Nov 2023
 16:24:27 +0000
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
	stephen@networkplumber.org,
	davem@davemloft.net,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net,v5, 2/3] hv_netvsc: Fix race of register_netdevice_notifier and VF register
Date: Sun, 19 Nov 2023 08:23:42 -0800
Message-Id: <1700411023-14317-3-git-send-email-haiyangz@microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1700411023-14317-1-git-send-email-haiyangz@microsoft.com>
References: <1700411023-14317-1-git-send-email-haiyangz@microsoft.com>
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0197.namprd03.prod.outlook.com
 (2603:10b6:303:b8::22) To BY5PR21MB1443.namprd21.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: BY5PR21MB1443:EE_|BY1PR21MB3893:EE_
X-MS-Office365-Filtering-Correlation-Id: 82ec2129-7407-4fbc-69d2-08dbe91c0001
X-LD-Processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
 YnGXBf5AMu3bshXq9AVeN281MSOJSnPDHpjzupTa7vw+ynJ2V2Wa0uuWVxC5Z0CyQegqXo1fOJwwD3Cgustneu+4rvt0J5USvgfIdsmJcZc0H1vGoJDi1v0F1fRpULXZXeh+dCKoTw4YSI/oWukCDgJUFk8u8taen/8pFQHmbFTlO5ig4yLeobeQ6h4FhWUbyAdYO1L+ogpgbI9NGaehgUQRU2ByJEr18r4bydrwngbxqoljxGc22wj0TIAUBBYOeTprNHEpqad3BJVL6cq8DUrKH+u3AGbqTo6X/dJDOEpTQiZURpAdOjQ3iXaU32c62Tu/kUq84hgMAzlvnoZKThh19lQY/4aFQBh4iOyOHxjq9wz0vRS4FCR1G51vhSrWuwWE2Uq3F1lmiJR896rFj2pGFLhy9mpkm5NvZ/aOexvu7RT1Q2+CHz1JshOUzn3MvCKqMdeckaBViIpCXGnIYxKLu+rYA17ydIVZ2bgwKREHJNO+uqaU6pl3EfjkpbEILF96nj4fgPBek/ArmcvX4ovHKHuAlyTEIkBT5ccI9ibmFe5I792J/I9Of/ke2XPVkz5brmh2u/Mu7xT2gndOH6NbECYAuepKWEjsg9Bl6P8nKT/13oumt0SxHK1k3oHtSLISOcbRquuSF7S47lIQAKOnMfDV3AoCr/a3rbJG+5M=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR21MB1443.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(346002)(376002)(366004)(396003)(230922051799003)(186009)(1800799012)(451199024)(64100799003)(82960400001)(82950400001)(38100700002)(36756003)(38350700005)(6512007)(7846003)(6506007)(6666004)(52116002)(478600001)(2616005)(6486002)(10290500003)(8936002)(66946007)(66556008)(66476007)(5660300002)(316002)(8676002)(7416002)(26005)(4326008)(83380400001)(41300700001)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?qg7T3LubIo5zVy3duiVfbWBDp1k4WwVcVHpLnGw83L70qu8jZpMNfDGamQQx?=
 =?us-ascii?Q?c1bfbk3LSFMUIlugpJqYtjPGEJZRscylh7N0OKVEqYt6Fq9G2Lbmus53Xbau?=
 =?us-ascii?Q?WpxV6guofpa53hQimit62sFkefEej1agcDIGmcP4bz8L2h9z6JO3YeLKsJiz?=
 =?us-ascii?Q?0K6sQisAEr4CXEOcLPY6zDsKTm/oTLeQCrCDcRVJ3whlrlRbQSI4MOVz8KzI?=
 =?us-ascii?Q?bnRIkVPJNBXv1DxydhUXt3oFKPiWvGYDEul5JsWFA6lNQE7DSasLz79CgvsU?=
 =?us-ascii?Q?58Up9lvEwjQNMTJZGbt6yJLz2xODY1rSnXpwYK/6MYEX+UUI4zSKBYWO0FDg?=
 =?us-ascii?Q?ePQ1omccSBIKIom9uBPyKfBm/Ea40miuNEjcHqe7/f32pezvAm65De8w0o4E?=
 =?us-ascii?Q?qmvyuy32VzewE1C90OrP3fpoUZJTXEuguX5MaHI1XSHGtrNE1LDyIQKFeUMV?=
 =?us-ascii?Q?VqY1D6Tyr70rxRLscxi0Aaah0WB0MjIlSDJrcKCA4+gmo8cAsGuv9ZgNu2ai?=
 =?us-ascii?Q?sgjCm+DzofzsAGSubamyCVtWrNng3ZEUCnXiso1PWgjSoyL5SegcbwygEDoU?=
 =?us-ascii?Q?nkr+/fyF/KDUHfXYp5YQ/Vxx52LfaMdMXeJByXlN9nj9HdmDewS7pUOIfgLI?=
 =?us-ascii?Q?CxSc8l4PYjVa9YiQPthQD+a2Z1RtiyfDtzS9UFzKvdvZ+7446rwiywv/04wf?=
 =?us-ascii?Q?kZqRBWFJHYVB0FmRJqb+dIjZbY3W8dqCWIziajqx/ZZlKWQjfn7BDiC2EjRA?=
 =?us-ascii?Q?oK1VwsdS4vmGzn76g8yqWgQLAK4yJ+fzGVd0FqvONKA7d1yXyuZFCZ0nazSg?=
 =?us-ascii?Q?zerMWoRSNWcQ/4MQnHJtdM1o0F64zudPEZ+saMnfvgkltskF1fNipSK1Fk3j?=
 =?us-ascii?Q?2tDe3AS3jpMf3goBDbEXCMoHLEGiMWIS9J/6bjU4eYFxWLvCCQIICpkjWpY6?=
 =?us-ascii?Q?dpLAqN14K4+rxkqns13lr4j8nfy7OhUzrgjrygR6wZg1gIV1juq1+j+zVSmL?=
 =?us-ascii?Q?tD2TwJcKulD9LDEiEACUlie6v/f5VxvEO9+RwMeqATiE95pwt+MvOivmn4MY?=
 =?us-ascii?Q?/RRA0aDdfJRaDKdv8vVGYg0CvpKFR1f0kuFC8/YR+pg+1sJTmNxXzkvdwipT?=
 =?us-ascii?Q?KFkstCB+/yplgzzxzxRzgzb+wHVE0STSsSpPDWT3vQ29KXtA6UWTvkUeDgpi?=
 =?us-ascii?Q?JJA8z+nCONUIU8WCMFSmGPdc4eu+ApXD1lTqiuQ1PzqmmUHOr7LF7hTVj5Z8?=
 =?us-ascii?Q?Rj/gvXo2YLgH634tgh3zSu/MGw6iCd75NFrLdHC9+p6vYTSLvBIE0kumYR23?=
 =?us-ascii?Q?o7HjJegSasfpnhVonfYIE9hRSsoMDdxvrHKN5Jnm/H5iXW4MPIWIjLo1BAn8?=
 =?us-ascii?Q?51QhJYR3yGb8vkcUq2D6RY1N7y/q2CqgfSaN/l72kalZvh9JNvnC/l0GXICs?=
 =?us-ascii?Q?OWX5ycc6oLg5OvyD+1Of9m/ECmNwojMp4beH2ArzI/q4y1B9H2U/1U8ULEYl?=
 =?us-ascii?Q?lFUuAdwcYc6vQszem9Bdvx3CE2gLqekMwu5j8qN5F2xPRAneD9H2jq1sU4yA?=
 =?us-ascii?Q?b5P/9MHcFhy8VFSHcteUejIbyF3SF80ZZF62r7AK?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82ec2129-7407-4fbc-69d2-08dbe91c0001
X-MS-Exchange-CrossTenant-AuthSource: BY5PR21MB1443.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2023 16:24:27.2553
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9+YC+C+7TdPMcOdkjYvbYk2xvXKCmZF3Imv+SuMawLX40VeIXI6NqEtwiAicfJW8iOems9iSOASJ07J8VNnZfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR21MB3893

If VF NIC is registered earlier, NETDEV_REGISTER event is replayed,
but NETDEV_POST_INIT is not.

Move register_netdevice_notifier() earlier, so the call back
function is set before probing.

Cc: stable@vger.kernel.org
Fixes: e04e7a7bbd4b ("hv_netvsc: Fix a deadlock by getting rtnl lock earlier in netvsc_probe()")
Reported-by: Dexuan Cui <decui@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
Reviewed-by: Dexuan Cui <decui@microsoft.com>

---
v5:
  Use a more idiomatic form for the error path, suggested by Simon Horman.
v3:
  Divide it into two patches, suggested by Jakub Kicinski.
v2:
  Fix rtnl_unlock() in error handling as found by Wojciech Drewek.
---
 drivers/net/hyperv/netvsc_drv.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/net/hyperv/netvsc_drv.c b/drivers/net/hyperv/netvsc_drv.c
index 5e528a76f5f5..b7dfd51f09e6 100644
--- a/drivers/net/hyperv/netvsc_drv.c
+++ b/drivers/net/hyperv/netvsc_drv.c
@@ -2793,12 +2793,17 @@ static int __init netvsc_drv_init(void)
 	}
 	netvsc_ring_bytes = ring_size * PAGE_SIZE;
 
+	register_netdevice_notifier(&netvsc_netdev_notifier);
+
 	ret = vmbus_driver_register(&netvsc_drv);
 	if (ret)
-		return ret;
+		goto err_vmbus_reg;
 
-	register_netdevice_notifier(&netvsc_netdev_notifier);
 	return 0;
+
+err_vmbus_reg:
+	unregister_netdevice_notifier(&netvsc_netdev_notifier);
+	return ret;
 }
 
 MODULE_LICENSE("GPL");
-- 
2.34.1


