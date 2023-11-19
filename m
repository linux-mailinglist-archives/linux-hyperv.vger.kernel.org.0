Return-Path: <linux-hyperv+bounces-987-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C6987F077B
	for <lists+linux-hyperv@lfdr.de>; Sun, 19 Nov 2023 17:24:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 410A9B209E2
	for <lists+linux-hyperv@lfdr.de>; Sun, 19 Nov 2023 16:24:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ED55134D7;
	Sun, 19 Nov 2023 16:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="NdejL8Kz"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from DM6FTOPR00CU001.outbound.protection.outlook.com (mail-centralusazon11020002.outbound.protection.outlook.com [52.101.61.2])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A96D137;
	Sun, 19 Nov 2023 08:24:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IfmKj/w5pmraX5KBI5eTsyThQfFVQefuXCY9BOUiWooCQCuZwAIgC/PezKIKbJT/gmbUBnpThSWNkgttcRXOUVwq1Ej5MoQNYMVmpqYiq2pXllArQaiYNu2afJPm3Fz81/G7JaVcjXcp3AvZcfgKntxU++FGrlbFbs1/wXCOdEPUatVe2nwTYlii3RtgHnigolDqyFDasdocXsK2YmqPJLO2So+tLT3DcMvmkPtVMRIn0hubURhPnY/CO8V04YKLkCNYBbkxD5Q3m5HUyx4hlBqKU/i64s9zGL2NsEPiP5n2n4HJlyYJk0KysDvNZ9PXCfSmSLI/pXPyykjvp9QGMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0GEkjXHGC9FQG4Qf2zMbjQHGohPt660nYMttpj3dN98=;
 b=VyPt5FZVFVfOt7D88Wccr1zxYM/W0aBCuCb5ryOVRPun722TRu6SCHBvo9rLD9hKqz/5RcI3Fvloon4+BaPdcXvc++oLLqfRXC5ySXFpwnlUpmeUk+jfzPikoZhX18ZHOkl8jfK7son9ibOUAJNn3Nq7JUtP0njW5tVsX+0G9bDFAb3BMvergVaRQeu6FwdaK4ABle1vqPxFGANETA63VqC3RMIBybJRFBW1Yozyx50B/0boWaaGN4y9Q7vF0WJU8yggo2Ktup99Ku7HLSOFOrCwIQG4OjXHqa6Iba8WSuw931yPnVPaXGm78jwgGD9DLAr7aQJMtU0dTARAJz1L9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0GEkjXHGC9FQG4Qf2zMbjQHGohPt660nYMttpj3dN98=;
 b=NdejL8Kz05NYDkirjyRA3nFVCn/NUfqTIygoi5hKM1LlBEs2NvvZ1mOE2hSN3LwJ9CWvt7Am3WzExhruSY72IZXhcCei6/BemL4vlZ/0T2Q/+Qujj0vAdXAN7EyEe7D1X2pZ8VUgL/KWa9iv3lvVkCX+PTOuEAGJPUHJLhxLZ5A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
Received: from BY5PR21MB1443.namprd21.prod.outlook.com (2603:10b6:a03:21f::18)
 by BY1PR21MB3893.namprd21.prod.outlook.com (2603:10b6:a03:52d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.8; Sun, 19 Nov
 2023 16:24:24 +0000
Received: from BY5PR21MB1443.namprd21.prod.outlook.com
 ([fe80::d819:9f58:df81:2d20]) by BY5PR21MB1443.namprd21.prod.outlook.com
 ([fe80::d819:9f58:df81:2d20%3]) with mapi id 15.20.7046.004; Sun, 19 Nov 2023
 16:24:24 +0000
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
Subject: [PATCH net,v5, 1/3] hv_netvsc: fix race of netvsc and VF register_netdevice
Date: Sun, 19 Nov 2023 08:23:41 -0800
Message-Id: <1700411023-14317-2-git-send-email-haiyangz@microsoft.com>
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
X-MS-Office365-Filtering-Correlation-Id: ee0314f5-9e13-4a47-c3be-08dbe91bfe8e
X-LD-Processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
 J56npG98Q4hMp1ptrRv7d3uScEyOHMW7BH2Q9i8iBUbvMcP02dqoPZJuofM8pU8yF8TWM2E6/7o8h6BQjgmUn34Oku7f+FxNeQHSyeTmOzJ9GQh/zSf2eaGP4iLzVuDia4EZiXowxGKsmnbE7KMmiZYs7n3QkAh6sQKd3xK9tzwJyGCzLl0fXWrddWDdVQBC01d4rGtnJKoJk/xe0Z/JViHCwEA7IrMQZ2agxMYrRqpFP/H62qyILn18L1jRWa+N4hnXnsUjVWqeSMrUrd/hla1oJOwK2rS4O7MSaaSRiXwN08Ez4sqQ35VPA5yDUfufDnd5L09vimx43R4oJcOvmpXg0/Bacrv56J3ZTqQJRdBihfUN81ATMOPFtc9fRAztJmZPSv1QYaulATHS2zhfuXdJs/rg/rcyU0CfpWpakAWgEHGrCIaRG+ESYCnfHuNji95M6NUdCaEeOLydTym9lu3CoTLDe1C1xs6+dzJ/hp7IkmLzBNhykL8+ywbeXf5Z3t5PMNSP3yMmMa6cEJkey+0tbxLC0LHxXJDSB3+GYbHaai/9LB94rWHAFnTvaSVXf9Cv/PQYLaAc4jqVpSKblmCKBfzsaf+cxI66S+9il/S1VfLkCz7nCVL/N8KacnE4Gjanw3kU4HihsVIB+jG4gtEtn1iBlixDZtGrdt5Espc=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR21MB1443.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(346002)(376002)(366004)(396003)(230922051799003)(186009)(1800799012)(451199024)(64100799003)(82960400001)(82950400001)(66899024)(38100700002)(36756003)(38350700005)(6512007)(7846003)(6506007)(6666004)(52116002)(478600001)(2616005)(6486002)(10290500003)(8936002)(66946007)(66556008)(66476007)(5660300002)(316002)(8676002)(7416002)(26005)(4326008)(83380400001)(41300700001)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?pcAhOqt9VMt9YfkjHxuAz+VG6RgSDQISvRCbAU27TsCZgA3YOskUUUHLgsxo?=
 =?us-ascii?Q?fjpmS+EXT5NZSaDuX6Zu8wutktwIJykxf1h/UQTUYArHR8yfybl7+TqOB3iJ?=
 =?us-ascii?Q?gi8Ge12fb8ngLKGKH3MF/zUqqufQDSYPPX85pZU9qP0nv7wl72kZLltjaqCC?=
 =?us-ascii?Q?7zjQaaYltweb1OTBo60+p5S9drdBLdSYLa58Ffsp0CIdIMAJN0SJpVElj2W0?=
 =?us-ascii?Q?Mjr0LCfn0vQ3L/MMEdZK90jrtXAYv0h+9yhIx9J3M3zNlAQkz19nkX7GgKcG?=
 =?us-ascii?Q?Up8f9KpNCHHul54Zx+GaJ5Tv84gGHwtgVJ8izOzX+NDlR1E29p9nNRsGD8E5?=
 =?us-ascii?Q?cO4RiaXnjhc8Nk/buJLOD5KOmKUvbgdCiOiC2n3Cb2LOl+lxBOo5NnJA2iC/?=
 =?us-ascii?Q?U3DF5eb48FecWQfMbKoDEXiuRZgiUL61hDmUi3bOCI96B6iqJt1JCoq8YdS9?=
 =?us-ascii?Q?xKCSMRWVxj6FVexHt5qBjOz9uuIESDOsF405Pd5B6Rlp2uYfnsFbwKSAEbXi?=
 =?us-ascii?Q?Bk2l1dkTcPCD7Qp0Mhq47YDarVZbArEUL0tEYPgH3oS88uNTC+8ftO+z6oOJ?=
 =?us-ascii?Q?pniztFZP2iaQaZj1ktBReq/v5QJ5H16RRPSM59+YGMJDZyMbNJnVq8G8y/NF?=
 =?us-ascii?Q?A96fsoXKFuBhT0HGPe+4U/awgk3C2E0BuNfLWmVywJTGFE6yQ3Ka/3suzmzJ?=
 =?us-ascii?Q?TSoam5mgpW/iV57cDpSmx+hAEr7qVzqUXipgAQ+g79NZkocAN7BX/xvNuaFh?=
 =?us-ascii?Q?pJBDOax304shVNG+o6E2L7pWhSbtABAb5N5tnIqVH3tfk4AiD07swQ5akkkh?=
 =?us-ascii?Q?wi+1L0663rIQch860Qj3l4xEIR0e/xajIYQaqlMzpqCvhvnHm8fHajh0J1B2?=
 =?us-ascii?Q?6vhI/ZRMsH+ahNf3Rp/F+soVNGI+rdvnVhvk6wdpZf6/hEJEyk7L9LwivZNG?=
 =?us-ascii?Q?WBOcQ/vMQgBL6r8juaWgHDZlEQfdkZFdQlTCa5nLZJJsZ6dcWpA+wc+zCsCr?=
 =?us-ascii?Q?gTS7KOKoz/loRtjvxfBCW11ttIFKwd7uf1BpYgscQDmKNW2S/3IvUCHszRrw?=
 =?us-ascii?Q?tq1rkAjwbhj5767qAsTitjmUKl0f6ig6TpB4ELmi4HPpEciVSb746Ga8bHMs?=
 =?us-ascii?Q?LPnaA4c9zpFXU0547tme22J3hRKuqeAk98G+auNQct/HCjUu3pzKrYMcozeW?=
 =?us-ascii?Q?5TMiq9vVPfilncriVNqv57F5ZvFr7Xb6qvEKvLREAP+KoU6OgsjuzcAjBpgL?=
 =?us-ascii?Q?z1fjH83AoibPJQnc6yaRkdt9uegtGnnyt6siwGl39KM2u/b7PcPRIEjlMvna?=
 =?us-ascii?Q?RKdGBDgS+nlzS352C8xH5+YQ8xw28dQD+pB3AK9bKb0tia6+ZS6NboL+cnFW?=
 =?us-ascii?Q?Hdk0knRcbbrNEtjfobKWFZ4ZpYO7BtawaY966g0HIB1ZqPG67BmgwZHLiVTO?=
 =?us-ascii?Q?mqX78/+f9Hw3tdqLRIennoL4YF/j4AkVPhuNnlnM+QxDqPA+nUEdkQpgGomz?=
 =?us-ascii?Q?e6hNk+8Gotk0AiJkewEV2AB888t2Z5Nggx97o7STra5ThPu6rJXN6iv93uYz?=
 =?us-ascii?Q?7TSGQUxzW3wH9fsfHrz7kJWfj/01OY535uCD67G4?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee0314f5-9e13-4a47-c3be-08dbe91bfe8e
X-MS-Exchange-CrossTenant-AuthSource: BY5PR21MB1443.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2023 16:24:24.8585
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x2zZ71AasVqhKaTZSE6HZfjEJklZuCJZGmDgl+pUs09PzmHkSSLqb3ENxePwJiwHl0OrTDdKsXM1oabiOP/wbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR21MB3893

The rtnl lock also needs to be held before rndis_filter_device_add()
which advertises nvsp_2_vsc_capability / sriov bit, and triggers
VF NIC offering and registering. If VF NIC finished register_netdev()
earlier it may cause name based config failure.

To fix this issue, move the call to rtnl_lock() before
rndis_filter_device_add(), so VF will be registered later than netvsc
/ synthetic NIC, and gets a name numbered (ethX) after netvsc.

Cc: stable@vger.kernel.org
Fixes: e04e7a7bbd4b ("hv_netvsc: Fix a deadlock by getting rtnl lock earlier in netvsc_probe()")
Reported-by: Dexuan Cui <decui@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Reviewed-by: Dexuan Cui <decui@microsoft.com>
---
v3:
  Divide it into two patches, suggested by Jakub Kicinski.
v2:
  Fix rtnl_unlock() in error handling as found by Wojciech Drewek.

---
 drivers/net/hyperv/netvsc_drv.c | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/drivers/net/hyperv/netvsc_drv.c b/drivers/net/hyperv/netvsc_drv.c
index 3ba3c8fb28a5..5e528a76f5f5 100644
--- a/drivers/net/hyperv/netvsc_drv.c
+++ b/drivers/net/hyperv/netvsc_drv.c
@@ -2531,15 +2531,6 @@ static int netvsc_probe(struct hv_device *dev,
 		goto devinfo_failed;
 	}
 
-	nvdev = rndis_filter_device_add(dev, device_info);
-	if (IS_ERR(nvdev)) {
-		ret = PTR_ERR(nvdev);
-		netdev_err(net, "unable to add netvsc device (ret %d)\n", ret);
-		goto rndis_failed;
-	}
-
-	eth_hw_addr_set(net, device_info->mac_adr);
-
 	/* We must get rtnl lock before scheduling nvdev->subchan_work,
 	 * otherwise netvsc_subchan_work() can get rtnl lock first and wait
 	 * all subchannels to show up, but that may not happen because
@@ -2547,9 +2538,23 @@ static int netvsc_probe(struct hv_device *dev,
 	 * -> ... -> device_add() -> ... -> __device_attach() can't get
 	 * the device lock, so all the subchannels can't be processed --
 	 * finally netvsc_subchan_work() hangs forever.
+	 *
+	 * The rtnl lock also needs to be held before rndis_filter_device_add()
+	 * which advertises nvsp_2_vsc_capability / sriov bit, and triggers
+	 * VF NIC offering and registering. If VF NIC finished register_netdev()
+	 * earlier it may cause name based config failure.
 	 */
 	rtnl_lock();
 
+	nvdev = rndis_filter_device_add(dev, device_info);
+	if (IS_ERR(nvdev)) {
+		ret = PTR_ERR(nvdev);
+		netdev_err(net, "unable to add netvsc device (ret %d)\n", ret);
+		goto rndis_failed;
+	}
+
+	eth_hw_addr_set(net, device_info->mac_adr);
+
 	if (nvdev->num_chn > 1)
 		schedule_work(&nvdev->subchan_work);
 
@@ -2586,9 +2591,9 @@ static int netvsc_probe(struct hv_device *dev,
 	return 0;
 
 register_failed:
-	rtnl_unlock();
 	rndis_filter_device_remove(dev, nvdev);
 rndis_failed:
+	rtnl_unlock();
 	netvsc_devinfo_put(device_info);
 devinfo_failed:
 	free_percpu(net_device_ctx->vf_stats);
-- 
2.34.1


