Return-Path: <linux-hyperv+bounces-712-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D96317E4A4F
	for <lists+linux-hyperv@lfdr.de>; Tue,  7 Nov 2023 22:07:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 164F51C20D14
	for <lists+linux-hyperv@lfdr.de>; Tue,  7 Nov 2023 21:07:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86B233C6BB;
	Tue,  7 Nov 2023 21:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="JKJ8te3k"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 018FC3C6B6;
	Tue,  7 Nov 2023 21:07:42 +0000 (UTC)
Received: from DM6FTOPR00CU001.outbound.protection.outlook.com (mail-centralusazon11020003.outbound.protection.outlook.com [52.101.61.3])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CFA310DE;
	Tue,  7 Nov 2023 13:07:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e1UzXxdHKdBPKOVGqnydvhhQlGK5Y32FihRinWrx04ZhloQfGUgZwKXgdg2Efuv2Htdm0Q8D7C2C5qngKgENp1tzJSnj6QPb4z1/37E0jQqn8GlLMoMBprljXaoIKcqAtvSYH5aZZAewR1dXYQk+XFMJdDZHlwyU6Mdv2BldrRcefh96oXydyO3U5Uz4MjwIOHfuS28allal8ifl6e74FDUFNItXro6/m5zdKTtxBT41ZMJOjuvSWDFMzXiXUqbLgF7ToDCE46ik6sFlshYCm+Fzru1BlBK3hALW0kUlI94yuwuE5Uk3fBgGUlsgDy/POKWtkC28iZh8klkH+jxtFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rb8T+Po8bMo431DH2S04+XtN3YuItIBYtM4Y4TrHDxo=;
 b=bvzrvqHdJ1mc8nhyts/3GVhCiCBfxeGpYSf3OnwnqGbv/M1s2jMi9YxGNrSTWnoAOoH8KnM2dpp6FCz16uJ/4jevuhVxCc/aw7F4dsACwtOFBtfreWOO5Y+TBt4t1sF6T63dp6K/omKklPdQpsEBxYyis0ho8xZUVvJbcqMocfsd12UvKKERePfN5wjLL/olovqKRayuQNgsneH0d7vPvxDWQbnf8SP33AKJ50E6w78M631mRNOJWrdCjKs6FcU5I2o0pClwYbkGkyzWI4/AhmiPG8FOudh9p6ZzAB7fQvmxX/YfLjF7OFG2am1Uqzzz9irWHEoWP/xBjE3XOQgKWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rb8T+Po8bMo431DH2S04+XtN3YuItIBYtM4Y4TrHDxo=;
 b=JKJ8te3kBVkJSTxrGsNFAbFR6IzeSwb5uubK8uvpvLGbOJQrE3L0/cxW5JkaFUAuMwv5NJOz3lwSwBUyEZPrU/ymYq+rU6faiT5BQydPaGA8pS7JIsENNW9vqiGJHINAXK8gQnVtu+HC4fJV6tJIV4aPIdO4CrTQj7EqlhYPzUo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
Received: from BY5PR21MB1443.namprd21.prod.outlook.com (2603:10b6:a03:21f::18)
 by DS0PR21MB3929.namprd21.prod.outlook.com (2603:10b6:8:12b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.0; Tue, 7 Nov
 2023 21:07:40 +0000
Received: from BY5PR21MB1443.namprd21.prod.outlook.com
 ([fe80::e8f3:a982:78ac:3cea]) by BY5PR21MB1443.namprd21.prod.outlook.com
 ([fe80::e8f3:a982:78ac:3cea%3]) with mapi id 15.20.7002.001; Tue, 7 Nov 2023
 21:07:39 +0000
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
Subject: [PATCH net,v3, 1/2] hv_netvsc: Fix race of netvsc and VF register_netdevice
Date: Tue,  7 Nov 2023 13:05:31 -0800
Message-Id: <1699391132-30317-2-git-send-email-haiyangz@microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1699391132-30317-1-git-send-email-haiyangz@microsoft.com>
References: <1699391132-30317-1-git-send-email-haiyangz@microsoft.com>
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0160.namprd04.prod.outlook.com
 (2603:10b6:303:85::15) To MN2PR21MB1454.namprd21.prod.outlook.com
 (2603:10b6:208:208::11)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Sender: LKML haiyangz <lkmlhyz@microsoft.com>
X-MS-Exchange-MessageSentRepresentingType: 2
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR21MB1443:EE_|DS0PR21MB3929:EE_
X-MS-Office365-Filtering-Correlation-Id: cd17448e-441c-46a6-e36b-08dbdfd59301
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	nu2y2zB2JEKxeZYNgwD409LSXXQHQGaEDHC+R9kseV3aUKV/scfPqO2pP4r0N2OmqBBDg8YgmnJEkR+jGl1rt/hFGZXH4o6yBPWgvaIM3UK9B8iZkToG3Ck9R5D3c31ezIKIbftVfW50Vk3KeXVVzA6oqFa9Xbo0OjtrI9dHWNOIBop+Nbg/kbNocOy8IIFVjdGv3jSWnPubYrSCSmIy3DO23pNsQfV0fZ6bkSGlNR/JV7I09RkYFe/8VxMEwZcSMvjXgL8aMohKSFwOFCT7g/oGdHct0M5ruBU+DKpIya7lA/iA5RdLaBXwIsBLV3HBNF4Ox5kI7FkLeQ+cXfZ5DzihPjt5PSJUfcoXHNfH58jnvdV0b2R1qh80S0BJvgfc48zibjOM8DhYNJuHFLeICM/iaVxe+qFhzhlf08UYPU6TMy4z3RJNTWcbOd25T6bnNbsKwPqgj9qTMGN+p2r/s7/lyFG8if/ThpSYXvjQ/kxP3Fzjj3GCeqAkFRELcwLdmAtd0wAqLZMkw+L9zAPbRt3E44fQyfjIUScNigb04/Bbiy7b5qu0Bi50pvix7YiXPWMHSKJCL+UXWB+uGYbnsT260mUo+pq4R3Qs8OQjzZ2wGsTWaUZbmCTMaETfxrny55cANM2/dRu/NvTfBJ+IRom2UZskEl6dZglLoGwrce8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR21MB1443.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(136003)(39860400002)(396003)(366004)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(2906002)(83380400001)(66899024)(41300700001)(38100700002)(38350700005)(36756003)(82960400001)(82950400001)(52116002)(6666004)(6506007)(7846003)(6512007)(6486002)(478600001)(66946007)(316002)(66476007)(66556008)(4326008)(8676002)(8936002)(10290500003)(5660300002)(2616005)(26005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5jD45h2OCs/P0HN+XiLvYFvZTlairgOVs2U2weC/5Zggw5YxS324Tsgws62Y?=
 =?us-ascii?Q?XS851B8wD8ohmvHpbjymov1Z4+qAZNMnvMrmQdG2XhybbEF+BfEgnHVvGQlA?=
 =?us-ascii?Q?UNEq9m24X0CYNxeBV6ATRiKTQAph9PZJGrKt0TBR1i8lpCQUzy1Jhon2I25w?=
 =?us-ascii?Q?+x0h5WRGAsQsBnP1C/jezTTRTUNY/Y2/oJBVJZXJTUj1KeiZPmE/dc0f5i41?=
 =?us-ascii?Q?6OjnSOlX1rQJ7n//O4qJivGgxOw9ArAQV2mPoM4W879klIbsrQ+FnPe5Zbkg?=
 =?us-ascii?Q?2Q0mOHO3sbAbuP8+7OvQ3aHQrubiKgxM0e70qbOdrHhXMne6IaJRW2KkPQZg?=
 =?us-ascii?Q?KHlamzLNqq2Ud8x8fzIWDpCoUAF6K9n0wfkzXN17UDRLK6G0wxrvDC6ksrsd?=
 =?us-ascii?Q?C7nn6RF5lvQte4ONafTFb7Q8YUWwOohY13o8Vs3MOMWlN5HGfEj/LQnzaDlG?=
 =?us-ascii?Q?cuvK602dYBkLJ2OFME8z5U/92EJrohxyxYPcp6tQMmoGX2NpZevK3czi/dgN?=
 =?us-ascii?Q?4XhcW1bDWl+DKhkX28VoV7kM0Q90PbZmULPpvpEk+w0Vu8UD4JPhQclUORy+?=
 =?us-ascii?Q?3cPL1o+eNYkzCuT/N7tjYKBOp/KyNQeOIx5Z2U8gW2NeZooBPrp1OaqCSZ0C?=
 =?us-ascii?Q?I8+VA7R/Lpd2pixayzU9xBaBg1uXJQS9F/IglBVwjdKauYMNEUz5iYkPt9x6?=
 =?us-ascii?Q?F5GZuakrmEpNp3nAOmPjyKxtNc7uGviRqPHiIV19N8uSwid0WDx5hiQf2UDJ?=
 =?us-ascii?Q?ap4/b5xoaLlXLaQ0jD4OoKRlf8MA4mNY7Q0CMGSjur9ZVZ4aJ+IM4NIn/uB2?=
 =?us-ascii?Q?8a7lSDGFa7JFUQ7Snz965Yn0R/kfgvDx723ey1QZK6fEfDzbkSspO3l9pGe4?=
 =?us-ascii?Q?xPczq8EnJGrwD+fJ+t89Gxw0HrwzxBD/395RXGVmoDwgqvjTr4CQO+D0V3bi?=
 =?us-ascii?Q?Mo5UhJVfu2GgXOcUEWwS14iOwKO8npqsbMf9AHurJrDH3ZkAffIp+gfRGMs2?=
 =?us-ascii?Q?8hQiwqWAIGt2R/D6LBpaYU7bWqGiXVpItiv6IMLzegRbfTezCdikP9jMVloy?=
 =?us-ascii?Q?K8hUKIh1eBIech1mSb23h3g7u+6jYodZb8s44BGBsQHJA795Be4EXdxhy66X?=
 =?us-ascii?Q?WaeEYIVHLZrnjDoLWvLYeKAXNruS7e/Eed+YDpNkBna+IZRK2NMytAeGtC1b?=
 =?us-ascii?Q?pLhQOc2CVH8BS3kBUxW/DNTkqnhBUmzw2Yx67iYoo2YRCGoxekq0UnLRKwuX?=
 =?us-ascii?Q?inRsUMFL1SYsPvHYWoyO0nD6eaDrOhiNrGefmdU3oe2Hz7w6uuhwtYhmuZEM?=
 =?us-ascii?Q?tUeY+/tS/TBblkzIzALO2OcTcmiCxjRmHgqj849gYINuImIZuC6Ib/Vu0Dru?=
 =?us-ascii?Q?KnliHmLu9YgVirb7dLjosIhrRGFp+SGG1Hbh9bwn6SRfJK4soUrd5Nux2nSI?=
 =?us-ascii?Q?N71KwDHynhCzEB2TQXIIjq4bsLQtX7vV/O+e96Lit5sZsZf/l5WrCDKPcKuL?=
 =?us-ascii?Q?HEKG6de5cwm5WYKnPPgFc7KA1HG/cPip9jqk3GTVDnB0UcgwTbOXj3BAu37W?=
 =?us-ascii?Q?2si/dToO1/CaXT9Wvki7NM5UQ4WyGO8wak941eD1?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd17448e-441c-46a6-e36b-08dbdfd59301
X-MS-Exchange-CrossTenant-AuthSource: MN2PR21MB1454.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2023 21:07:39.9305
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v9Bw28xqIDQDjaNjd6ZMVEyoUiIUu2RbT2P9eBtvmqr8bPfsv2qNJVWnPcIlh8gPAkY+XmYrOc2MQrjHB72kAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR21MB3929

The rtnl lock also needs to be held before rndis_filter_device_add()
which advertises nvsp_2_vsc_capability / sriov bit, and triggers
VF NIC offering and registering. If VF NIC finished register_netdev()
earlier it may cause name based config failure.

To fix this issue, move the call to rtnl_lock() before
rndis_filter_device_add(), so VF will be registered later than netvsc
/ synthetic NIC, and gets a name numbered (ethX) after netvsc.

Cc: stable@vger.kernel.org
Fixes: e04e7a7bbd4b ("hv_netvsc: Fix a deadlock by getting rtnl lock earlier in netvsc_probe()")
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


