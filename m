Return-Path: <linux-hyperv+bounces-842-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 740A57E7D13
	for <lists+linux-hyperv@lfdr.de>; Fri, 10 Nov 2023 15:39:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1EE6E1C20CBB
	for <lists+linux-hyperv@lfdr.de>; Fri, 10 Nov 2023 14:39:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E86511BDF1;
	Fri, 10 Nov 2023 14:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="gP1rma3f"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42C01199B4;
	Fri, 10 Nov 2023 14:39:38 +0000 (UTC)
Received: from BN3PR00CU001.outbound.protection.outlook.com (mail-eastus2azon11020003.outbound.protection.outlook.com [52.101.56.3])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2201F3975D;
	Fri, 10 Nov 2023 06:39:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CSyK47w5LLqSu9Gb28a/eMj0Y7mM0uHUwiqzPXpkI5W0p1MS0eGdjqZa7BgI3Pcp+2xktif1ULVVMZSITIQbujm0+6T5Yqm2QGbP+Q38AL+P59Y2RqTsOnE/4s6FkvhNWt2J4cIRWshEEslKBWCW1b/5hK9g/hU4aAT4IFeFh5/nhuqLo2d19A3gQmIF2xVgnOXXpYgkmE00FhULm0Z/Rfo6VggnpODa1jQZJriTBe3cEeL1bPCS3kdtcq28yE3DAW6xUlxM773VjRm3l+VZzRaKpvUI9U800aF7y0SQyexHH2yps8cx7eQjGzSFgUUdhV5kjVgklQhf+S8NCUtU/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JCRRg/i0SpPvQc4DkIDkZh5NQFxErxwLXb4YeAX5DIc=;
 b=Y2g9q2Rz5R5QppdAXsH+v2oKiLpb2X2oRWiErql3fSYlQlz9gVeZldE1O8GJ5ROuntvlWzA2I2SjNW4IVUl1Wdx/Dwk2Bni8CruZNMdcJ4xwGqAwDHpVkLZCotpT5WqY6AdVkzvNN8f2SM1UJFBpE48gWssH8GXVIll9UN5CYL0+f/MomKjqzMSfk0dRnehphsb3rntAvl4WToOnJEcQewbMkJa2wEfasnJRJbE44ta8OVysJ9bV34BHyN0A2CdZmvxFQzhvALTI2hTHL52uDMFf3nmuAF/QCzBm6Euq92y3MWLjqD1ZUQ7E0mecZNa2u6Ux4NM/CtHKXMAabC3N0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JCRRg/i0SpPvQc4DkIDkZh5NQFxErxwLXb4YeAX5DIc=;
 b=gP1rma3f2KNPrkcdK2ofL4qXDywxUjKvp6TpegCkUfR2auBufcF709wWWNj0LoVNhjANmj3r5SvBUphAnBqdxtcpJS2IsVFI551LwtV8McfpHRtW8A1gsFKRnn/opIU8pzKdYQIRoQstDYh6JuRT1IlaqziE2xELkRouKVq3czo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
Received: from BY5PR21MB1443.namprd21.prod.outlook.com (2603:10b6:a03:21f::18)
 by BL0PR2101MB1348.namprd21.prod.outlook.com (2603:10b6:208:92::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.10; Fri, 10 Nov
 2023 14:39:34 +0000
Received: from BY5PR21MB1443.namprd21.prod.outlook.com
 ([fe80::2f77:8844:9c3f:58c8]) by BY5PR21MB1443.namprd21.prod.outlook.com
 ([fe80::2f77:8844:9c3f:58c8%4]) with mapi id 15.20.7002.008; Fri, 10 Nov 2023
 14:39:34 +0000
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
	Long Li <longli@microsoft.com>,
	stable@vger.kernel.org
Subject: [PATCH net,v4, 3/3] hv_netvsc: Mark VF as slave before exposing it to user-mode
Date: Fri, 10 Nov 2023 06:39:00 -0800
Message-Id: <1699627140-28003-4-git-send-email-haiyangz@microsoft.com>
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
X-MS-Office365-Filtering-Correlation-Id: ff3c4eb0-d1e0-48c6-9601-08dbe1fadb8b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	mhFjun1plhrGXaw96Y0Gtjd0UpsFKQBDX5fFlUH9uy9tw3cx+mFumjCGCfN3UFM7JkE5+gmKvdx2OgFcMF1DRo1/N9diFucUfxqjcUCvenyWaiN8YbSmfLhjkuJkt2cRRlVgNK7x5VOxQaaYbQnputvMUy45qTnhW5dsMMuunHwpCVtkONCLwW0pbUyH6T3BL1YIfew8SoalsmM6K/8zMZ3A/Q/MKB157jNJaQ1PMyHlmG7XSB+0WbTy7LhIHLTv8ciKr9dXdht+xsPLNcxF8nDwy68de1gOgarEQqwwd7w2yxGeFWwSwx+7QcUzJhS7GDtib+JpOP/MuTIkivZZCsA3wKeu40now5FiAE43RKhoUsY3XlPKercn1ENbi5OobBAvuSfHNdTJHEiUBUdtqaZ9rfNT0R1XNSXwvLvfGRaDwAJDGsTMDPp99VjOCVWMTjoBUp3PVZy8sIzrRpmNNx55beA7fReIz1ldErOhEzyxnwfjmDV1AD1Fjefck20ZAkrpZiY/4Fi4O02BOEfAR3KdvQNTokCJmKwRyqBADrTQ+/ngcK4USWQ4zlWYkuGkHIitq7de70+rFzHUXMgDApwDVFnHvUbhhOXSx6FgkHTW7Az6QfSzb1bfyYCfKsx8igtIeNoI7n56a77PCK0OvpyihDqka1/pWqpmnH++V9E=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR21MB1443.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(136003)(346002)(376002)(39860400002)(230922051799003)(64100799003)(186009)(451199024)(1800799009)(83380400001)(4326008)(38350700005)(2616005)(82960400001)(26005)(66946007)(316002)(66476007)(66556008)(41300700001)(2906002)(8676002)(8936002)(5660300002)(6666004)(6506007)(7846003)(52116002)(36756003)(6512007)(10290500003)(478600001)(6486002)(82950400001)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zrdAP94ts8W3PxHQ6CWrujOxQIQ2lSiN6+6obGB/KuDQ25QRxyLnlVzBndV2?=
 =?us-ascii?Q?sQ+T1SCaumEqsRAq4mAbM2hTkI4sR4+X8skNd5YrsB50r2WspBHhC/wcZ7j8?=
 =?us-ascii?Q?hKlR7WYCtVCF5jnxSNDpRUz9NLReSc9p/mMIP8Pj8j0n9gkhd2Sx70lQO/Sk?=
 =?us-ascii?Q?ZjNJ519112iBNXDIH7RAcJG7rQsnifuKWdegVrJXd1RdUWznklUs2AU61hmU?=
 =?us-ascii?Q?x+GQH6BE026UWq4sbvw7qpAnzkkJxXuyr6T0XkdUyN/A5FkfvL1bCCY/w2As?=
 =?us-ascii?Q?qtQIdpk+desjw70FCMwJ5fI7K3LoAc8GlBBHIJ2drD3AwYPdWrNK2jGYPBKH?=
 =?us-ascii?Q?kW5B+H4cwKdttueFd5kmSCAADHX5aTVJgOOlSMuhajxvyY9y/QefEfrolpDl?=
 =?us-ascii?Q?IFDbnlDQq0EI1wJwrcnJARi/WcHckKZHZtKmBmqyHqfDpIUZD6p/nvLre0BN?=
 =?us-ascii?Q?MtM6PSa4kWAH6ytrOJRlPJ1HHfW7+KZcr5YlE26WvEjDtUgOGTrCzLBEER9/?=
 =?us-ascii?Q?CMLjLuilCLBqN2FrjQD5nL6i5ZRrNOZEwZSI5dIwabYG30k7hY8bBFPOdgQ2?=
 =?us-ascii?Q?LMGWV6LDMS/cJ7H02rR5VH7WoDDixkPu5ltiz2iaCxLAJqQ6EVd0OiYiMcWy?=
 =?us-ascii?Q?9wbTRUlKAQC5dLpAelg/yeoIydJ6NFbhJBISX63r3d4MRhYRnbvhWydKcxLf?=
 =?us-ascii?Q?2vqVzEjoPESgn7UIYQccGxqD/WtXfgXadWcoBGwPFTAvewyuniGHFTdzRfsw?=
 =?us-ascii?Q?kTwzflDYaj7Wag85jq9h/g4vxoYmUQd3/U3RaaI1NjYk5St0ilGPa83pcEvx?=
 =?us-ascii?Q?z2/YnW0h1Gg5AHfWZPlINO7YAvp02DF8xXTe2PVg29ucZqCPpUcfVY4ap1A3?=
 =?us-ascii?Q?6Sr6BZPmQRYsYwULJ6JcRAz9VcqraVV2B9o0g/Q07SF/xma/cLsi4yRcamw8?=
 =?us-ascii?Q?rgiwuitq04kmyAzOvt459I9dwfViOFpWEwDZAI4E7uqAzCRRz5avDFZl9YMK?=
 =?us-ascii?Q?uKMaQRyhkyVj+X9z9ttU/JP0cUiwLNG/5iusEFJBeTpJWxc/hdNrQTaReWJp?=
 =?us-ascii?Q?pCvhnTBiyi5X1kLj6ukNborK5WiERVW8IpQcXgTmXixLX9ZEydf0gml77vWX?=
 =?us-ascii?Q?YqI3a/MAURdXFSWsSKlZ4ENP3VSx1WdsSHfiwS6llEKe1I8gmqACPMeVwesq?=
 =?us-ascii?Q?5uFHkU681wcEdr62V6E//zYljSge5d3LfUylphcU2k8PRRFIHvb/O9Q0RvlJ?=
 =?us-ascii?Q?BBqWL6uVystNzLY9ZOEfCULiSEzxJsWBIvbWFuat67Rpsts5ToZHOC73cIkq?=
 =?us-ascii?Q?Q8SgbUhOacNhixiXlvGTZAfUhPO1o2XJYPeZWzAWU5DSDUAzf29Jf/yLn2+Y?=
 =?us-ascii?Q?PSTBAaN+/Utu/lj1RSTASp6URs9bTl0Nv+OPX3OgXTZsfQFPo4nVPdldC6fX?=
 =?us-ascii?Q?MxxyhZUcaZcKVnFMXAAlbmjGCupwobBiFKEHPznXzGbe4DUA1vNr6FE6mC8h?=
 =?us-ascii?Q?oGzS9vojaCSTeU9OXRWLrPSdJjC7mztP6nGgNEAw4n47l2liHihgYrPrlucS?=
 =?us-ascii?Q?x+NjT5GCrQfSuVsEUdJudhtMr/Y88EOlHWpkd7ew?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff3c4eb0-d1e0-48c6-9601-08dbe1fadb8b
X-MS-Exchange-CrossTenant-AuthSource: BY5PR21MB1443.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2023 14:39:34.5582
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7YG1Ou8Pdb7nNpIXYQmlcbfW3PK2co2xNTofAHI4QZcETnWqiQP3LcQ0ya/mCj+0l8q5cPOp3jRDeXUkj/kYxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB1348

From: Long Li <longli@microsoft.com>

When a VF is being exposed form the kernel, it should be marked as "slave"
before exposing to the user-mode. The VF is not usable without netvsc
running as master. The user-mode should never see a VF without the "slave"
flag.

This commit moves the code of setting the slave flag to the time before
VF is exposed to user-mode.

Cc: stable@vger.kernel.org
Fixes: 0c195567a8f6 ("netvsc: transparent VF management")
Signed-off-by: Long Li <longli@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>

---
v4:
Add comments in get_netvsc_byslot() explaining the need to check dev_addr
v2:
Use a new function to handle NETDEV_POST_INIT.
---
 drivers/net/hyperv/netvsc_drv.c | 32 +++++++++++++++++++++++---------
 1 file changed, 23 insertions(+), 9 deletions(-)

diff --git a/drivers/net/hyperv/netvsc_drv.c b/drivers/net/hyperv/netvsc_drv.c
index 1d1491da303b..52dbf1de7347 100644
--- a/drivers/net/hyperv/netvsc_drv.c
+++ b/drivers/net/hyperv/netvsc_drv.c
@@ -2206,9 +2206,6 @@ static int netvsc_vf_join(struct net_device *vf_netdev,
 		goto upper_link_failed;
 	}
 
-	/* set slave flag before open to prevent IPv6 addrconf */
-	vf_netdev->flags |= IFF_SLAVE;
-
 	schedule_delayed_work(&ndev_ctx->vf_takeover, VF_TAKEOVER_INT);
 
 	call_netdevice_notifiers(NETDEV_JOIN, vf_netdev);
@@ -2315,16 +2312,18 @@ static struct net_device *get_netvsc_byslot(const struct net_device *vf_netdev)
 
 	}
 
-	/* Fallback path to check synthetic vf with
-	 * help of mac addr
+	/* Fallback path to check synthetic vf with help of mac addr.
+	 * Because this function can be called before vf_netdev is
+	 * initialized (NETDEV_POST_INIT) when its perm_addr has not been copied
+	 * from dev_addr, also try to match to its dev_addr.
+	 * Note: On Hyper-V and Azure, it's not possible to set a MAC address
+	 * on a VF that matches to the MAC of a unrelated NETVSC device.
 	 */
 	list_for_each_entry(ndev_ctx, &netvsc_dev_list, list) {
 		ndev = hv_get_drvdata(ndev_ctx->device_ctx);
-		if (ether_addr_equal(vf_netdev->perm_addr, ndev->perm_addr)) {
-			netdev_notice(vf_netdev,
-				      "falling back to mac addr based matching\n");
+		if (ether_addr_equal(vf_netdev->perm_addr, ndev->perm_addr) ||
+		    ether_addr_equal(vf_netdev->dev_addr, ndev->perm_addr))
 			return ndev;
-		}
 	}
 
 	netdev_notice(vf_netdev,
@@ -2332,6 +2331,19 @@ static struct net_device *get_netvsc_byslot(const struct net_device *vf_netdev)
 	return NULL;
 }
 
+static int netvsc_prepare_slave(struct net_device *vf_netdev)
+{
+	struct net_device *ndev;
+
+	ndev = get_netvsc_byslot(vf_netdev);
+	if (!ndev)
+		return NOTIFY_DONE;
+
+	/* set slave flag before open to prevent IPv6 addrconf */
+	vf_netdev->flags |= IFF_SLAVE;
+	return NOTIFY_DONE;
+}
+
 static int netvsc_register_vf(struct net_device *vf_netdev)
 {
 	struct net_device_context *net_device_ctx;
@@ -2758,6 +2770,8 @@ static int netvsc_netdev_event(struct notifier_block *this,
 		return NOTIFY_DONE;
 
 	switch (event) {
+	case NETDEV_POST_INIT:
+		return netvsc_prepare_slave(event_dev);
 	case NETDEV_REGISTER:
 		return netvsc_register_vf(event_dev);
 	case NETDEV_UNREGISTER:
-- 
2.25.1


