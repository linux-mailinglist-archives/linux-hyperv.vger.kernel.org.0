Return-Path: <linux-hyperv+bounces-840-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95CB67E7D10
	for <lists+linux-hyperv@lfdr.de>; Fri, 10 Nov 2023 15:39:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D1A31C20B4E
	for <lists+linux-hyperv@lfdr.de>; Fri, 10 Nov 2023 14:39:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C473219440;
	Fri, 10 Nov 2023 14:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="LLvhFbRy"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D11A31BDDD;
	Fri, 10 Nov 2023 14:39:30 +0000 (UTC)
Received: from BN3PR00CU001.outbound.protection.outlook.com (mail-eastus2azon11020002.outbound.protection.outlook.com [52.101.56.2])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D31873975E;
	Fri, 10 Nov 2023 06:39:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iaR1d/k18CYtw7/fzuk6Zi1Y+t4bOuqikXHo77aRlck437lXtOCTyk6G8CdUz70esR+mjagV3IU0qGC9aCsJ7IgCXVW/fZK/RADzBat52HaBvOnposHUDYZnoUs33P6gmjwylPxp1YsT5hE+QcrlHYWnc2fZY5OZPgImXsX/6121QKZ9VVQTW2sN2JLLNRRC/9XJgwJ3lDOw5y6ldN1hZxqfYmiuZN2KJTGTCLhl0Cz/hl+p1CBLghu+m52EwrtVIzjdM4QwbGnQAf6CR0GJ2xZMmbVEpTQvTi5v1A4U4e8MmGvtTEW4DHx0leT6broR9cpJYzUQuYl/VVGXvDGWHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xe++ibFiuQQjO/itnQrjqTAOEXIHZT5Eg//BH+X0DzY=;
 b=G2uerAFzQ7baH335lYj92cZdbbmazvbniV5eXzvZW/C05vPWpJ0ShVmzPKLvvC09QtjdmNsUb7t6H5VeJNu4k4CrSHGT6YyzqVZeoX0nvKHuo+IT+5P4ld2JgUT2jpDmvARBtwaKIyAyq+sxlLH/4oxtftmSRMJe7KDWsvewB+dlpy25nNq2wYex5Zao6x+ibqBbRlhQPazEvwvAsG+ogz5zXR/D8c5+FY9zYQKFg+zeIrt9NxHmwPQl/v5Dd/VptcIk0MqQTv/WQHRDufRorAnXxo5zI/cqwKuz61zB0nFEsDegnj7iyD6TIhvdHB2OG4LVo3bemK+lqg9o1O6sGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xe++ibFiuQQjO/itnQrjqTAOEXIHZT5Eg//BH+X0DzY=;
 b=LLvhFbRyC99Va82NcJjLQLc4OSEvaI52QSt6QB+P2ZQfSIvIy0OywmBNzyLm73M+BktX9/R6eLR0W2A3e+enW6G7m6VTGYZ0U57V1KqkcRHX0Y01p0X9F6PEIS/L04d5Zw2Vwy0SktjEcNT79L3bPfNrk5pZ5LAXy4v14Aw+mA0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
Received: from BY5PR21MB1443.namprd21.prod.outlook.com (2603:10b6:a03:21f::18)
 by BL0PR2101MB1348.namprd21.prod.outlook.com (2603:10b6:208:92::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.10; Fri, 10 Nov
 2023 14:39:26 +0000
Received: from BY5PR21MB1443.namprd21.prod.outlook.com
 ([fe80::2f77:8844:9c3f:58c8]) by BY5PR21MB1443.namprd21.prod.outlook.com
 ([fe80::2f77:8844:9c3f:58c8%4]) with mapi id 15.20.7002.008; Fri, 10 Nov 2023
 14:39:26 +0000
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
Subject: [PATCH net,v4, 1/3] hv_netvsc: fix race of netvsc and VF register_netdevice
Date: Fri, 10 Nov 2023 06:38:58 -0800
Message-Id: <1699627140-28003-2-git-send-email-haiyangz@microsoft.com>
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
X-MS-Office365-Filtering-Correlation-Id: cc3a8098-358f-4815-f2ac-08dbe1fad6f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	gM9Lv75ycNlE0AHGA+NP026F6XO0F2Vmkl6BbFDutYT2PThfHE5los3GRF+cNFZySHV6BYvrD7dIZnesvG7q9p0x2paSm9w8mWyCaMz+4FKxgOVs0q9+lIngedsm7xTenl1fxD3hHi5xcV3Y0+x4Al1lZQaT78WDRuGlB5b5t9ZVQ82jI0YX0nSjLeMomfDicobjuEjybhw21xw4/oOP03QprtHeaSCOxDHZIjjvKZjZ1Bhsz+3HsnyFFU+llX5FUKnWzChzjZSF0PgFs2mzffy3xTf5c4ZLKe7EbtSg9AvmISzyeYtCaCeOKhAg0KbvTz36UOJ9hjPez+3XO7HO74GYOelXPva8Tu2/Z/Gs2GJ8VqJuvJbuKitVYCF+5wmCNoUYNIFLiZFiUDFGTDvy08S+19PInhCW/NYTi1QjfoCuxfZq5STArGbhcMxlE+3VOqF9ztfD1d8J8DEAoq/RI6LLSNgUqgOcMf/DMSAOM3ifT0orH0DplytCZVheFycY6C+lMnnN09cIbZRolVWE8IBZFPI8BpeJe4xvrl7nvyk12e3SeHXAh48sPLGmlg1oPxA1Y3L2cr8t9Hc/iCt4borW+hDED2G0JLoJLedrluEelGrAtoqlmHJn+20y3HJP6pxylbTQ5bdmSeXA6nAwL78VLfcWzIqob2HSBfSCjaQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR21MB1443.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(136003)(346002)(376002)(39860400002)(230922051799003)(64100799003)(186009)(451199024)(1800799009)(66899024)(83380400001)(4326008)(38350700005)(2616005)(82960400001)(26005)(66946007)(316002)(66476007)(66556008)(41300700001)(2906002)(8676002)(8936002)(5660300002)(6666004)(6506007)(7846003)(52116002)(36756003)(6512007)(10290500003)(478600001)(6486002)(82950400001)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yu2nayHS3qLZuatBNP8jAb7Q1gFLrZz1Gwz4JjsD5QBB0JNMvp4a2R7pgh0P?=
 =?us-ascii?Q?y6WPzpwcNIMIn46IRpylg6gje8xgQtZW7q4VQjc8mIfiTDsFDHEoCd7Q6Sbj?=
 =?us-ascii?Q?KwRdYbp7vVXKxFAXashygBe7I3EGArA0HZEUayNsRxSiC2yyOY1dRv1PC3JT?=
 =?us-ascii?Q?gRsMSyAm7b5/mf3oMvZaHg8M+5DidCuAwk3bFSvqokxg+nBg5GCnLNxGscqo?=
 =?us-ascii?Q?XY5qeZJob2dKkdaJJCauzc/ETsATyTHr0Rkm3odxaWY9GyHgQQnf1rc8cq0x?=
 =?us-ascii?Q?+Fb72rl+jmMFC/DD6x9YCbmcPUT2AldmfDpyx7S77q34vyD9wgxkzcBUUb6r?=
 =?us-ascii?Q?usduItXbxJ4ppFE30DIk12BB3EIkoCVHSIszREjPvm8P3D+163pAdQA4iECE?=
 =?us-ascii?Q?2rIcYANnSMGWVudPFYQJQ/cELP6RCsfZlPUib1evDmzDfjY3veqrLSHPE8t3?=
 =?us-ascii?Q?QFq1dnLJPboLgSH+MIcjfkdy4K5Zp2yXKYlQICDSqVKCi7xa5TX3uRTcbOpV?=
 =?us-ascii?Q?QK1A3qsoINrtYsZSwGQEBJV1j5tPJ5/BgwVtqFNoa/2h2v/SQ9ClJwbzj+Tj?=
 =?us-ascii?Q?rxd9sIgo6VlA9gRZjckxWU1tfmTmRZSlLG7gKFZgf7GQz8033L+Jrt1LCEwr?=
 =?us-ascii?Q?J6q5oNAD629N7ATZUH3J+YtkzUtj1PVprQef3EZeKIBKlMBF4+f41zzWv4J5?=
 =?us-ascii?Q?+27AATIPuDqZ3CjAksBbv5DBR7NF+b7vnnLFie12osYMBZmdZOMHugWF8Q4H?=
 =?us-ascii?Q?CnV6k7OWmZj/AtBRGNXC7wnZXmShfUqUwZVEal/Yq0o8YQ1+uAZiSU+JlXPy?=
 =?us-ascii?Q?yZRKVkZiLQhExwuiTEfj7Ug01SnwLlQqz30xNSZ6RsOVmAeL5gcbK6a42qTe?=
 =?us-ascii?Q?lOElkoz0GSiT7Q+oi2E4KWRTSwwM/58UbXOtUNrGheVJU7i1QXEGh0ZbcqZA?=
 =?us-ascii?Q?SKhgvJ9DsmuXFV7a+HhVwN9lm/VsA5zPV6EPNHHmpfG7mct78mXTyAKC++Y0?=
 =?us-ascii?Q?EnKnjSEZBPb7QNdEDFdSYNgN1H6jjIPbonwfwS81o1DYScsZ29PFRC2XOXi+?=
 =?us-ascii?Q?E4st5LHsYq8cWxuTfWvfdqRPT29/ZAsBD54ely3l3tpYgZzCKsNxkPuvRFp2?=
 =?us-ascii?Q?GtSKoDItlQ0+Hy31GnoQeejzRyFs88Ijz0CklC3GpZ3i/NgH+/PMD/eNquOd?=
 =?us-ascii?Q?OHpCLRVTKKQ2z01Quo0UHa/Y3smhjX/6kzxPfWBzlY0OZ5dZjbziaigwuzei?=
 =?us-ascii?Q?F5eFdeZ9SGbWzcNhDi09fghiCeqWhh67vHgjNkbDx3m56ou1n2QEM0ks5xUR?=
 =?us-ascii?Q?Ejv5uzQgMull7nD2/fKKHKNwCgFflaJCyI6eP/ynpd96C1UYjD18ivQr1/9k?=
 =?us-ascii?Q?WSbyQaa+6HebRHUJL6VfjEsu0eL9lgASbfImj833mtJ5bOkEan8zbnJ5hNco?=
 =?us-ascii?Q?Hd6ds6x3yZAu39Yc2XJQdFl/0W/+WepAxW4qnglXQOpIj2EH1Vc4damG7R7X?=
 =?us-ascii?Q?veVZ9BzJ1/HyNyiq0jiv7GGx/QtxfMjBcNkj+Ogg/y2XkWpyvPmNGpgTPwGh?=
 =?us-ascii?Q?ArKGomhucuxKJt+7WtWW4Qh28DeUhjKNwHg2xImj?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc3a8098-358f-4815-f2ac-08dbe1fad6f2
X-MS-Exchange-CrossTenant-AuthSource: BY5PR21MB1443.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2023 14:39:26.8487
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UpFkPYvzkwMQ1N6iSAzibbClMWa+3TgOwDGczEhxBZ6Pr1JYoRJwdLpbQNHi2Ov43FDO+X7bTui/lD1CXpMm6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB1348

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
2.25.1


