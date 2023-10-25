Return-Path: <linux-hyperv+bounces-580-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AFC47D7677
	for <lists+linux-hyperv@lfdr.de>; Wed, 25 Oct 2023 23:17:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2DB041C209E8
	for <lists+linux-hyperv@lfdr.de>; Wed, 25 Oct 2023 21:17:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 327D433981;
	Wed, 25 Oct 2023 21:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="jh9Gytuw"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B78C12B6D;
	Wed, 25 Oct 2023 21:17:07 +0000 (UTC)
Received: from DM6FTOPR00CU001.outbound.protection.outlook.com (mail-centralusazon11020003.outbound.protection.outlook.com [52.101.61.3])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3360012A;
	Wed, 25 Oct 2023 14:17:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cLyVX+idSIaHE8YU4gYBCuW+xDx/DdoCPCOVuknIMlU1Lp8TzyqwP857wtmF0wKrro55bBPKJKgBgwcVPiWztKjpgv8kG0CL1cztusIQK/tqUYsXqdb4RdnSqqtqIntp1HzbYq/cfVJ8P4BVhfVEf+qYYzV+55zmHqgdAV/U5bYoEUepPIEkcvYo2G4yHn7nB0X2kp3JBNot3fS7EQ6grOSeOwJYGbyoinFd6RC6U/gxRddLcJSeSvAdPrgkz0Ip1UnvFC5QWum92U83nfeBh4cuI5+NtQnh+iJqMA0ijEkME1fc9brV9oOz+qq8AOS8/V4l8dFWlHyDNOJfYYmGNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nH4MiJJ/ZgiMCLMDjIknvzzzxIedakAzBwKHVsmWbT4=;
 b=OXHciexH3oxHXn2N0gWKkd4rBvC6nb6hZd7SZNSTiYkzmYgezc8Q7ySGsIJHxHF+QLs0rs01kmhBMWdgl2N30fs1UzJQJtCx1iKC58lCFGWPmcaxEKg7z90rWd7s7ymA4vDAIRWU/8PC59+TPi6nPA5aqePbwT6r2p1j4Gt64YeUDrWgwJ4xOmiMOIrjWX66oVpqIax785+BA+2GcFFx0yJ9rl6+fKw46EsF+souzNcDCF2W2oQXO3CMFNQA2oUeO+TaHXvdD39kIfQUc95pEA41QTigYWNxGexDwaY05CZgyBPhKAclFNK3ztry2iAmHes5i2iRmI0yl2o+aFJy7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nH4MiJJ/ZgiMCLMDjIknvzzzxIedakAzBwKHVsmWbT4=;
 b=jh9Gytuw+2ZkZ9jekibbSOe1gD1kj89KWsPtmMaOJat5wRWhBA10U5QJKTKR2nPjeWvxjS9f7LweA3Cd+fC46QQWvS3wgIiWbqOKDWvmjJSs7DH1Yy/4Kd/1BPhM3yja/AXPClOlWc+eFYQBgoS/UrGvTv9tFPp8O/4DiECS4DY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
Received: from BY5PR21MB1443.namprd21.prod.outlook.com (2603:10b6:a03:21f::18)
 by CY5PR21MB3614.namprd21.prod.outlook.com (2603:10b6:930:d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.3; Wed, 25 Oct
 2023 21:17:02 +0000
Received: from BY5PR21MB1443.namprd21.prod.outlook.com
 ([fe80::c099:1450:81d3:61dd]) by BY5PR21MB1443.namprd21.prod.outlook.com
 ([fe80::c099:1450:81d3:61dd%4]) with mapi id 15.20.6954.005; Wed, 25 Oct 2023
 21:17:01 +0000
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
Subject: [PATCH net] hv_netvsc: fix race of netvsc and VF register_netdevice
Date: Wed, 25 Oct 2023 14:16:32 -0700
Message-Id: <1698268592-20373-1-git-send-email-haiyangz@microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0248.namprd03.prod.outlook.com
 (2603:10b6:303:b4::13) To BY5PR21MB1443.namprd21.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: BY5PR21MB1443:EE_|CY5PR21MB3614:EE_
X-MS-Office365-Filtering-Correlation-Id: a69aff3d-4ef3-4ed6-54d5-08dbd59fba9d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	PyeXBB6f+7IcaFJVdAYZzOVkv1PcGMXCPDwns7c2DMqY9Jmdv70Veh5lhEbIfyxsPWZ5dQvbTNIMBD8JiIifGf6s4075m2/gbLeH4Lt6p4RutpaKv+Kap5fpv9eESyztQNnQkXd6nm2750DzWAQgenJ6Rk4Lm9AYf68/j868e7DI8yBmIi0GGn2kDTp8tbBDGYIVDNUUEDMMXuIj3Dk/2zEpW1EQuV3SurHTjzWliWkNQHt5wI39Mmd41h//RXre0N0bBnIszO79MagC4PzGDupyOX7LwJl0L5t6J2jaqGsFpNNXr1GiytTROWddkz9B4T2LAm47US7ehiprM+lBNun71+XqZecLKC7k5euVOXz8+t2SOF4BxSOSyKOqq/IARDwtqQdaslVP32T37Evd5jExiFD2wQP4YlA8kccWrAv/YjNtVO8vFH01CAA12bvHfwAoZ6dmor7AT2WGKvPlGRQeqoRwDgSzVp9Yr/dYaOuJ8+VEbtNt/az7ZBmuAULVoVHI2yWbZaPIsuDwFz1oLbnSetxi0kueCDHwcCXcxAgrlbuEyGO8cl0ssJmx3G/bRy+bOpyqi+MmlXy9oFR0d0gmiMaBmAj5U/jMDGw/Xdxooyb/g3DNtidFEoBXZ5Uo166f8/+35t1SvnOzWTT0c3g38lwTxqIdwlP08l7un7k=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR21MB1443.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(396003)(136003)(39860400002)(366004)(230922051799003)(64100799003)(1800799009)(451199024)(186009)(66899024)(6512007)(7846003)(2616005)(6506007)(6486002)(52116002)(38100700002)(82950400001)(82960400001)(38350700005)(36756003)(26005)(6666004)(2906002)(41300700001)(10290500003)(478600001)(83380400001)(8936002)(8676002)(4326008)(5660300002)(66476007)(316002)(66556008)(66946007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BehMHLCTfx4KdJSrUOygJAOs3BEVfESreMG39+ddRRLxMyjqXjkIzkRuuSku?=
 =?us-ascii?Q?N/XJksQe/o2Grs3/x8kQ2s4t/v/T0aXcZmg37kx8ilgU1xyFPio87eK2k2Hx?=
 =?us-ascii?Q?JwRYi++8NmqYrWXoor/RksbGOHq4tT7MwuTQ3kU/nZ7DuAaIqhc33qnN6rBz?=
 =?us-ascii?Q?8tafcVc6I5bxk7WTBGkzFj2XkPBzKx0XFJ5Tfq+OAtjIGzOnwya3qTYFVEc6?=
 =?us-ascii?Q?IPpIrCTYMUFcY5UcaDjhAGo/F3poanhF9BWZojPSvkCrrLTr+ejsos4E8QNh?=
 =?us-ascii?Q?NtxuzQRmj3irUFPNMwEI4hjRXLm4PVnySOt6WiMZ02e4i2XYjfdW0JfAMpxS?=
 =?us-ascii?Q?R6YpuiIHa6PFU2f6h5jAGVbviVHJNzNyZlxXRYGMuguM8mYpYyumxSHA8foN?=
 =?us-ascii?Q?Je57srY42U8KVt2KHlOqZ4PNWCgaRVw3DCIeDDXVlgtmH6Q/H/4o7iRPQkA/?=
 =?us-ascii?Q?XRNt2QiJ/ExkDXFooDa20wXxxmWDJ1kmqciDZ0SJ6PGTqu6scVMhXppnOfoN?=
 =?us-ascii?Q?6h+8Rf4uSVr2yjKAKk2cyRbMJUXCHb8ATgV/b1sEiDwvpjFc9+tfKQ+5EZ5S?=
 =?us-ascii?Q?WViROR6WlvehJHPwgDx2gRnhw3WwsfEAI5Qig0hr5cNAVhqANDx9GI4bodgo?=
 =?us-ascii?Q?eGuEtp2AX4IyfSSNKsKkqSCpYlf3wfPHSU4I8KFq7/P+TsCCBF7500hnZqMg?=
 =?us-ascii?Q?XVrQcwbE/tooOquK3Dym7cHHrhuLBONhHmvBrpUwbHRXiMDA3IgKb6sQ11sr?=
 =?us-ascii?Q?CkA6c331LQojTAzW3ybfpy8OqzNWtexDxAwTKDMqdZuFgGBf9y1bj8LfOZKD?=
 =?us-ascii?Q?LNSr61HvDj/fWdMNAo9Sv3euD1N2oYyo1ND0G6pAVYMH9DozbrpgLyw2fyIF?=
 =?us-ascii?Q?+Pf8ysIUCsSY6c0keP1tzLzoddkNCeFooUDpQX0c4DF3d5JvfCcV0Y1750+a?=
 =?us-ascii?Q?CxTnq9RNhxzXWMB2Bi7YQ1rZkEIwamHswPzcpvEMq8hMimd+sBaXN6TC16Ej?=
 =?us-ascii?Q?f00kVUMA/ycu7GWrl40W0y50oQxxXeJps0R+v85ugOGBosXPFjRp0MjXGZWL?=
 =?us-ascii?Q?cH9VXLpYANwfC0yrPPXmENY6il79d4DErdAlWEDTua5LmD3NWecop7wYHsCw?=
 =?us-ascii?Q?BJ3H3gcGv+5El/mLDZRAboL2KCGLjb5FwMsg3nA0v1wL8KfsWkL3rQOZzYDI?=
 =?us-ascii?Q?F5Fe3okYPeu8I3NmANNe2tFx89W6In67CnTtst6OuSzXPLUZFoWhV1A5vHSM?=
 =?us-ascii?Q?ULV9V3bAB/VBXv0kYtuQHx/dD97S0rlTuPB2Xx6Tw2jUEROuO+O89Y0FsEQE?=
 =?us-ascii?Q?U/DDIJ5lcIh2+o+vrY7DoEMJyAbRinpVAPDGxabqw0OSXWgc+vVDuXrsiqTY?=
 =?us-ascii?Q?COoGDLBYj2yZYCXrCuBML8U4JmO2hy2F48qfEPG8UrEhNwashL7vmwk+XYko?=
 =?us-ascii?Q?eDEn/YsDbo9EpGgDXLZ3Kox2zPXwhBVgNrqEpIa+KQEXIdF5Sh2CBeIfbX3z?=
 =?us-ascii?Q?gEiedyOHnrx1ckp6WEPIG/aKBhbPTDxdRS0SbQlfIZtSgUH2BqcZtIe4VLIV?=
 =?us-ascii?Q?sW/lxRSPyM+KqR+e6B/8t2xPZaUqvyn6QqVYXeJD?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a69aff3d-4ef3-4ed6-54d5-08dbd59fba9d
X-MS-Exchange-CrossTenant-AuthSource: BY5PR21MB1443.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2023 21:17:01.3627
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LWpwU/p8V0mP1UseNq+WxA2cE3oZdNRXhcciEYDPv4u2A3a97pdGaYRkaIpTGyj82XAd2UayBnaYR+Quc0IfOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR21MB3614

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
 drivers/net/hyperv/netvsc_drv.c | 30 +++++++++++++++++++-----------
 1 file changed, 19 insertions(+), 11 deletions(-)

diff --git a/drivers/net/hyperv/netvsc_drv.c b/drivers/net/hyperv/netvsc_drv.c
index 3ba3c8fb28a5..feca1391f756 100644
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


