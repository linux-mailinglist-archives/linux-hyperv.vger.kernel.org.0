Return-Path: <linux-hyperv+bounces-607-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 67DA57D8A31
	for <lists+linux-hyperv@lfdr.de>; Thu, 26 Oct 2023 23:23:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C0011C20E9B
	for <lists+linux-hyperv@lfdr.de>; Thu, 26 Oct 2023 21:23:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBEB03D972;
	Thu, 26 Oct 2023 21:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="R2l85sxx"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12A1E4426;
	Thu, 26 Oct 2023 21:23:30 +0000 (UTC)
Received: from BN6PR00CU002.outbound.protection.outlook.com (mail-eastus2azon11021007.outbound.protection.outlook.com [52.101.56.7])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 419B31B1;
	Thu, 26 Oct 2023 14:23:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XFBsTZF4C64DUehKcCYEEq38dL43G0UUokeIJUJzJ0eM1CvP2AajKO61YFzANuNiCobNQPyKwoUGMeDQ58wEV955B2pv8Fw4royKyBF1VJ1O1ZqvZUaxMmQdNWN9CgzCZUl/BPZOxXiuurIdIIbA+GzSayEq+s0vR1JSyFDMwDuQk7Jqzv7k5K38Is2Nd+QF7gNQhrYvzusicAIPsB2qZTQraE88cYtKrwDsBQEu7/ZFCD0yqHK/JfrNmwik7EF4dBAIH7azV2d6aH3/Q0qJZsnDqh2qjy6XjKv8G3M+6kIhxKXpJThaW2EdNWJzhUm0zOinNL6Qurg7l3ixF0p1mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ScO9MHjqFx9KLg4rtvI3RJfJbEafGC9U9HwhniT/Uro=;
 b=oKJoqu+m6R+duPSZAEEfn3PoQyIvHZNdsggRw66/brXDrVwuHuWjDVgpC+v7z+a8HQJEsrtluDfE8+1L8b5GDUzl7MvwBzs5BEYqnSrfy/oieh/LA4XdoDLJXWOjdeIacM+orDhRunz4LzgpKBiXRv7gQ1jsPf7/lHKBegklbOEhNkMktQIcVW82VtjBqWHYu8xHbrAv/yRAD+m7kItn4wAcqHiM6v515vyVAR/fLW3nYClqnB2oqlfX/Gb0E1nSNUU/dkNwEufZv95+W0cE4mnUjwvmby2Roq57Z1kJbC790+rZwlI8z3urI5lb/TQ3wwovcv3OZlqEUANaZnWqnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ScO9MHjqFx9KLg4rtvI3RJfJbEafGC9U9HwhniT/Uro=;
 b=R2l85sxx83pvGUOB+Mm8TqZgnNvfhUKxeBCcGlVHndlDYJdGv9i2TMgafmctnLf9tOc2qaizNwMTJFa6xVaOMXIcNY+NFar8RCctE8+tDHXsEUjySjOsSG27hIE0KzCZX90z1hkmCH+LtlthPaKaOMZ4ULsER6weZHreDAKMFrQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
Received: from BY5PR21MB1443.namprd21.prod.outlook.com (2603:10b6:a03:21f::18)
 by CY5PR21MB3711.namprd21.prod.outlook.com (2603:10b6:930:2f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.9; Thu, 26 Oct
 2023 21:23:26 +0000
Received: from BY5PR21MB1443.namprd21.prod.outlook.com
 ([fe80::c099:1450:81d3:61dd]) by BY5PR21MB1443.namprd21.prod.outlook.com
 ([fe80::c099:1450:81d3:61dd%4]) with mapi id 15.20.6954.008; Thu, 26 Oct 2023
 21:23:26 +0000
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
Subject: [PATCH net,v2] hv_netvsc: fix race of netvsc and VF register_netdevice
Date: Thu, 26 Oct 2023 14:22:34 -0700
Message-Id: <1698355354-12869-1-git-send-email-haiyangz@microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0161.namprd03.prod.outlook.com
 (2603:10b6:303:8d::16) To BY5PR21MB1443.namprd21.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: BY5PR21MB1443:EE_|CY5PR21MB3711:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b76fab6-bfb3-446f-f7d2-08dbd669ca72
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	uaAgxGsRluUNdB4dywq5SLON3jO4Dx8q9M68/zQXbMpHs53jBxMECMbkBX5Us0NWQR4/zhlyc35hDsWeGXTwUvt29hK7yzGiNloh7NOnZ7McvAkC8Kn/Okeh7D85cQXVBFHIMrOcFraDUQ0SiLHazj2UXgUub3aOBBO8S0A3Kf0fGniOwWI+d9Mzv7IEHzcYvBHHgRei6flYVecBEvZ6xUDshHcKSImLAWvgmmBjfpkEhgdWjciIy04dd7jhCvk6uNi9oyTK4e83K/BKV13Drmvq58X8pmlz/a3+lR1boPim9oOKPEFgSyk2ZV6XYf/zbSNZUKmJHFHYGtJw/xxKW/gi4/PRQWgxRwgWtK/lrykdmYS7n/HCYmXluy92LuXAmqTL2YWwxKZJjpv2IVHWja3jYnBqpc872yXsVAJfnRm0nMwX0NW3djCZUcG/NS1UKtPt0oADAorhsMMPYIn/yHfr2YvrRJDUL00+9WdWHMX/g4svpY+jSK0xeVCbjCXgeFPcIQjVgbz1iP6T+oBMe2k4+uuhBTaoFMheZ+3wfhZhgP+qM7yNQQq4ekYCJD+vCxlhZK5my+AE2eJNlAdTjg+w9DBfpr4tonXcdSkKZSqScPBiQllugEt3SCay0pM3ZPmCm7XBNqoPnvI0et9ciBMp+rrbl0fKQq+dSxxKEBA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR21MB1443.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(366004)(396003)(39860400002)(346002)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(478600001)(6666004)(7846003)(6506007)(6512007)(2906002)(316002)(6486002)(38100700002)(5660300002)(10290500003)(82950400001)(82960400001)(52116002)(41300700001)(26005)(66899024)(66476007)(66556008)(66946007)(36756003)(83380400001)(2616005)(8676002)(38350700005)(4326008)(8936002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Rsy03WKDh8FBUZDSoJg1MyyleRKf0A5rwL+u7QBPPzOV3Ad6SlBPTVKc1s6Q?=
 =?us-ascii?Q?7Ew27jDxs/6VaIEMyLiIm3nhgQ/5zpYvh1LZQuEfsuk38Hf0/UKf4wTvIMN7?=
 =?us-ascii?Q?50vCCxALrO7WnTsZnfllOhV6xlHjjFDRaSEcUtVvTllF4e+HbLPe82zbwVl3?=
 =?us-ascii?Q?Q/OsO/U+yTuAx3yGAcZpsXYvfEvHGyMjHG9/GwiRFomE/lAtGgST2VqhQmNJ?=
 =?us-ascii?Q?WNx2tkiMOzw+yhn+Hk2AtY3NnbcGfOdq/2md91peRRY6d2hUDG0aCEbFlpCF?=
 =?us-ascii?Q?HdAh+Jeoto6A0yPzRtNSK2ieyo8V1uCOspOLBGCapZtXYolavgGIbg0o0S5M?=
 =?us-ascii?Q?GHZNT4/HCW152gmJEttxdgCBYNTHu+Of1f4BfnflRPnmo8evgEDY4o+/MoAu?=
 =?us-ascii?Q?oaIE7+m4smsZu8JmfLrQoxHeAwarn3q4Hi1mt6zN50njuDdAZhn88hlwNXxY?=
 =?us-ascii?Q?U2o3fb2NcVDTjBf/6yUMCgtX23/A25TDE7BsfbQmdATbJz5mNA7ffXBWkC4/?=
 =?us-ascii?Q?hfpdE7kGKp/L2OGO6pc9/v88nYqX+aW+8cNtfXbCbU+2MSl3+Tr2YvF1cVPa?=
 =?us-ascii?Q?RO+wFi4sGIM7OnVJZWRmGosmxMESoDfvnpyCqatbsPx0CUQXDElofZyReIU6?=
 =?us-ascii?Q?Evv2rnPf+Qa17Qa+UtHb3pQJkLR9yccAsrahd2FY4fvtf0ffK+wM07KZQv00?=
 =?us-ascii?Q?4rxmPKgSwMJEO/Au22jtNzPlaIcPsRI1LdFHP7scOtuFCAwRT39sSZYE3Kwn?=
 =?us-ascii?Q?emRwSuHgbuA33hKjntw2jl2HZrtZ6Huwwtr2B7gZ3E5IMoQrt+ludp76ubuP?=
 =?us-ascii?Q?zKiZYPSv+WZb5SrpKI7gC/y2+jBdiZuoTaWv+X+1Yu/2c8ukOvTO85dz4Xg5?=
 =?us-ascii?Q?gvtfscTPgB0N2O9CqZmLYxlmL6U6YVUSLGXh65OFZLumslBw+cxFl8S/QxDE?=
 =?us-ascii?Q?hN73aZmxMjABI0gPs0jeVr/fO5jRIDb4b+ZU/UB+h5mkcnme3+WGKXq6Qykc?=
 =?us-ascii?Q?7KEgfGT0I7zFOVvlbFscefNQDDsHjtHiPXUfsdM6RX7jFeopZBekDPbrfb5j?=
 =?us-ascii?Q?CI8ynlxtSDEK8bhQBwdbPnT6/djz+2wsQbcjN7uuSfpNXNdlnljYmh2kYWLS?=
 =?us-ascii?Q?M5Pyw+ubfWlGpI5Qt/kHpd68INlnbtN2q5jnjTLKJpgG1Bklkfr58uDnNmAr?=
 =?us-ascii?Q?Tfwnj2A25nTR9BT5FkrbFvbgYGd+hChG7MpnlIWLSjK/N4mk1L0I/hY36tlx?=
 =?us-ascii?Q?U0x0ptlG6niJS1aRMzeDknK89sBgHvmcaYV1+9Kp4bqgCHUTCDzjxtHFhw5p?=
 =?us-ascii?Q?OmRVkKRc5cSAd0q0BdKWF1SOg91HB+xkuL1CuR4MC68Rf9LeC7aw6Eu0/5F+?=
 =?us-ascii?Q?u47STrrQ+xdiY7d7f5n5yq9PlaCfoRYPeRwGV+5oy3WvEJgO5e9AVgVRGMnS?=
 =?us-ascii?Q?poZRZTMEkh8ZXBRR2zOHS2nwGL72Wwkd5xtf0rK4/YYhpzdIyW27stvtb4CG?=
 =?us-ascii?Q?fJCy5r/mmFryFnjduOYEu86mdjwqIZxbQkDOeX1e3amJRfrUz9M6JRj9uy0Y?=
 =?us-ascii?Q?F5N8Agk+T7ujYb6k7XXiFN/EHwJwaCaQgtjPEfQb?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b76fab6-bfb3-446f-f7d2-08dbd669ca72
X-MS-Exchange-CrossTenant-AuthSource: BY5PR21MB1443.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2023 21:23:26.3377
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wzKEIOiGlK6aa2sA2LWR3gAyXbiIFXMR8Wm+Mw6EMC69xh8TN9sQy1b9kG441P6YGID4mMcw5tWikFsJLboRPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR21MB3711

The rtnl lock also needs to be held before rndis_filter_device_add()
which advertises nvsp_2_vsc_capability / sriov bit, and triggers
VF NIC offering and registering. If VF NIC finished register_netdev()
earlier it may cause name based config failure.

To fix this issue, move the call to rtnl_lock() before
rndis_filter_device_add(), so VF will be registered later than netvsc
/ synthetic NIC, and gets a name numbered (ethX) after netvsc.

And, move register_netdevice_notifier() earlier, so the call back
function is set before probing.

Cc: stable@vger.kernel.org
Fixes: e04e7a7bbd4b ("hv_netvsc: Fix a deadlock by getting rtnl lock earlier in netvsc_probe()")
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>

---
v2:
  Fix rtnl_unlock() in error handling as found by Wojciech Drewek.
---
 drivers/net/hyperv/netvsc_drv.c | 32 ++++++++++++++++++++------------
 1 file changed, 20 insertions(+), 12 deletions(-)

diff --git a/drivers/net/hyperv/netvsc_drv.c b/drivers/net/hyperv/netvsc_drv.c
index 3ba3c8fb28a5..1d1491da303b 100644
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
@@ -2788,11 +2793,14 @@ static int __init netvsc_drv_init(void)
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


