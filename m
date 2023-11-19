Return-Path: <linux-hyperv+bounces-989-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 649657F0782
	for <lists+linux-hyperv@lfdr.de>; Sun, 19 Nov 2023 17:24:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1CF12280D1D
	for <lists+linux-hyperv@lfdr.de>; Sun, 19 Nov 2023 16:24:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DB4714001;
	Sun, 19 Nov 2023 16:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="Ussgyxys"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from DM6FTOPR00CU001.outbound.protection.outlook.com (mail-centralusazon11020003.outbound.protection.outlook.com [52.101.61.3])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 969B3D65;
	Sun, 19 Nov 2023 08:24:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CftCayIFtNMVWheRGIsF/GEXCR0NbSOBu1imJF2U5RAzxPmqguGMRbObyU5UzUhUGiO193NQFhCssv2rN9hqgARc7MMMUdA8Ey+II7Ld2Tq+yDcAk+Ha6O39knA5/p3K0xD8DAHD/Otom0NLdvH3L5se7unR7Dq4gKlvhy0Yqioo93HGU80oeBTRe7R20d2hazBIUjn/F2HBB2jBA/Ez8JX7LarYu6VCxU59csc0fVfAE6fmGakpq75Px9Qh3iHqGPUWWK9hbd92vpqwKIfd07OI+CMqA5uCXr15qUD9F/0//pcjX05RNIJfL5Pf3Q2XQSsvh7URNX6R2Zae/lrvNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H36dzqXp77Rv9GD8GbYy9bgWqPlS9/c9lrb4Eap2q6k=;
 b=Os3dcVhUfV8Lz3CLM8QMpsLkAzS2vWd4ToRt2j99/NBhnqaKQ1Axhij19qE/vdOz/b2Gpkzfcpe/tHGRTzSUWiaJ/32fs1HohY1o9XHNwIJZTAtFYbaCAgqZ4a3toIUiDozuhYQ/7rBZ082o3y+0XqBVt2Q3dfnSLsxHKvD9gLLICaZ4v1brasmnjTdwp6FiSkvOIVzoMKOBIEXSJ5bmhIvw6NZhOAXEI1Y5+PpieVRiPnC3MI40WiUn/3PRebFU8QJK7t27d3a8Q0tV4s3ldbefR+94Xna8R3yV9irr7X0yMIHBbcxE/Eu5GCcH3yqLcdtT0rO4XuI7n5rUoS0FJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H36dzqXp77Rv9GD8GbYy9bgWqPlS9/c9lrb4Eap2q6k=;
 b=UssgyxysRV2r0DB5n2/Vn4MHtZtqCmv4AtsUlGC9eYs+vqUk3Obs+qVIQ1c4npKS3UoZRBkajPR15MngKohKRFR8UAJBUnPSavlpfroXEYFS1uWJMwlxF+R+xcGEtUeF/Lci5mvkdDrmw8Ir7nLIIuFaZgDeVNbQhzsU479znko=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
Received: from BY5PR21MB1443.namprd21.prod.outlook.com (2603:10b6:a03:21f::18)
 by BY1PR21MB3893.namprd21.prod.outlook.com (2603:10b6:a03:52d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.8; Sun, 19 Nov
 2023 16:24:38 +0000
Received: from BY5PR21MB1443.namprd21.prod.outlook.com
 ([fe80::d819:9f58:df81:2d20]) by BY5PR21MB1443.namprd21.prod.outlook.com
 ([fe80::d819:9f58:df81:2d20%3]) with mapi id 15.20.7046.004; Sun, 19 Nov 2023
 16:24:38 +0000
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
	Long Li <longli@microsoft.com>,
	stable@vger.kernel.org
Subject: [PATCH net,v5, 3/3] hv_netvsc: Mark VF as slave before exposing it to user-mode
Date: Sun, 19 Nov 2023 08:23:43 -0800
Message-Id: <1700411023-14317-4-git-send-email-haiyangz@microsoft.com>
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
X-MS-Office365-Filtering-Correlation-Id: 052a199d-fd64-4268-ba8f-08dbe91c06d6
X-LD-Processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
 wn6dZBPPh+Ya/TKmAfr7XArVCTZkPLf6dGK1uQKUZ/SnzUd48C2NrYCzKqytMhfrgXV8WEdawigX9SUFuIllAYjRsI2hWV7hyQd35K/KGi3SYUM6fju4lG63JYPdgLnLgf1vzRSPKGKIIpOEupf081wwUkutCLGp2k/NcOFxhapD9kpI++TQJOt6+gBreDviRt/ECWk3NtzDv7kDCrQXMOG7q2zShmYEz0bvgcm98COegvIQLaULUgVuoVGyBd+oFnW2NpJreNvd2UxqAxj0ngub5yd7KE10bM9NCKAWmXGEReYzhYDgmDfOgQauH5IZkdX9LDVS9aRZc6GVGh0dm/nEUzEvfFYdyn7f3HAOaCBb/Ib5Y4AmOG5JAsCoIwn7hfM/TBXR0stzhT4vYmjao7s4U3jyOUlG2iE0wW72lMNzAMXACRf7JtGHW1G03wXRAew3qRdQJhGM35IRqRi+74zAdTE2FUkWMxKKJJQ75SXRgJ7IcMdf7zUg4IzFXP1t+MErdZ9Cw9EIzmJgQaM2lzGc8mvyTXWJohbtylnrOKIyqymTyX2k80v2SE8/1jR8Y0hMYLaZ6V9T+KYeBEor8EVWRUS3hmvx2lQGA/vDkI3qp3I3dgOWtFFwl5TK73GYkGtgQsNz1Ap9KftyqTQyozGySeuap+OfUxlfrpDK4nY=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR21MB1443.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(346002)(376002)(366004)(396003)(230922051799003)(186009)(1800799012)(451199024)(64100799003)(82960400001)(82950400001)(38100700002)(36756003)(38350700005)(6512007)(7846003)(6506007)(6666004)(52116002)(478600001)(2616005)(6486002)(10290500003)(8936002)(66946007)(66556008)(66476007)(5660300002)(316002)(8676002)(7416002)(26005)(4326008)(83380400001)(41300700001)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?z4XhEWS3AkrtFeiDSR/rWX+tJNwiVrFaNy4Hh2iHoY6nmPyVTJ5vV91EdlLJ?=
 =?us-ascii?Q?KVVYtkkNhlDZ+erR8aicW12G0+R45PqYixmvKpdd4pLgKk94LEfk7yIGDSwd?=
 =?us-ascii?Q?QUi5pUsawDmQ1rAj+WcAelQxw35A25ubxptR2XCbM4nuyg9ZDEv5XMJWL3Ls?=
 =?us-ascii?Q?Epnfdb2AcYI2pi96GbRs76UE9/+wmH5jDN9bD/IO9zfttnGIsr/OxWCJBr5L?=
 =?us-ascii?Q?Y3pqf9M+5bmeMO1VRW8gzZYfMmTzYo/7RrjJ9TuLnKdQl/Ih61JBofZ9L/5c?=
 =?us-ascii?Q?8dhkX1F3WqqRFV28YGXr9pt2+a40PRp1WIqBwsiYE1esVfg4y5rCMCH5cmvN?=
 =?us-ascii?Q?Ugk95dMVKWv87Pe+tXN5q9DkqAbp8y8QrsoGhpAhNzv43CIilGkOP1//jhLY?=
 =?us-ascii?Q?e8QpeGqksKK7J7mV9PkQujzxadDO2++axSCcpk+uAZOu32PipZ/xEwjvtoJl?=
 =?us-ascii?Q?lo06NaHSVKutp4ovHNSzHTnGa5qE7Pf2blDqn+lIhQ1T2B4ZYaIqDWofFze7?=
 =?us-ascii?Q?XszyLu6NYxlNDTGMNKjTO79WkL8GrlhCo9irx//PMIWaDS1/zucQjYCh6a/m?=
 =?us-ascii?Q?YOGk5jnGt4Ns4KKGw6zl3UjDPvZif605wuI/Kc+967BIZkxx9acPK+kBUbUz?=
 =?us-ascii?Q?jUm6ugkTdZexfFjg4Ixjv1HDX1IJU1B/iHEUQIHglz//fpKmp0mqT8jRSmAC?=
 =?us-ascii?Q?9xgfq7lgl2+cUVRKnKZ+9lXvjhosOZg+PfMZDGVXJmawFObJ5p5unyHAm8wZ?=
 =?us-ascii?Q?lkrIKEP8aIRcRmsT4RoLwYSyWK8XZxGo9v7jYLAzNimVrRwfSMNsFvjVB0c9?=
 =?us-ascii?Q?zgS7JWgnCBUXiO+3FSiKnd4pK9nUqrqTUVcWauAEgfFQE0CxaG2IlYTRoOy+?=
 =?us-ascii?Q?2zbrCtjrJMZSMUJfl5WFXIEF1fFQnCTfv84DjZfo0zwbO1jA4WH2BhJ50Nnm?=
 =?us-ascii?Q?ThsczOmRr6Wsa03JtorhZd5/cNDTCgHIrqKear0PZT+6Rsl3tjatI7MQD+sJ?=
 =?us-ascii?Q?L5x7Ywi5INOBkUe7UgHrU7AmZcgqx/K6dFsF7n2JV1J76WKnSQ5u4KNDGFyr?=
 =?us-ascii?Q?2vlJC8hhNfd5GIHCHQR63IMamtehzRT3yHYggtfgU6CCHeS40L7xMKctbXfz?=
 =?us-ascii?Q?I8yzi8puE81oyf9lQ2AJlLSQSP/zOGYYyRjcLBNeQMaClWRtOLA3I3KOLL9r?=
 =?us-ascii?Q?nmwGMBhC7ISzP7ndUGzz5v9tlTOZou6r5tQ47y0q+Yi85iAr70Bm8HWLrDlU?=
 =?us-ascii?Q?1QaRUZWfZ/vBSeoo7cGhWZkp4Eld24mNhrYry/OcleC+vwJkOiWSfycjfAFz?=
 =?us-ascii?Q?f1e0HUDdePMNV6LKwvrh51LX1lTVnypqefeEpAny2QS/AOp2vtngRfmjtI2i?=
 =?us-ascii?Q?Xv237S1gI3nyQdUbrD+AnZ/jspLkLRUCYrCfSw8s20loYVcDLHoI1MyLIQU3?=
 =?us-ascii?Q?QZfdV/Gn1FP3vaEhWii9hfeL0r1ci4Ayn5XQ3CeqC6yE4oqddvVOW39Psf+S?=
 =?us-ascii?Q?zNu1rrXbionwxI/wT7yupmJEaNhh1CG8KecC/jDdsfoV52lt/PMyg7SvcJry?=
 =?us-ascii?Q?MJwi2ms7yXQcglwWQuDHjGuxAWWEXoOAoiaGYfUT?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 052a199d-fd64-4268-ba8f-08dbe91c06d6
X-MS-Exchange-CrossTenant-AuthSource: BY5PR21MB1443.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2023 16:24:38.7226
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 42R7m6rlyAlBs2jBIrV4Ie3AcfjTOpEqnZ/naK1dhePvnOP32DL5+Z392+TYRj8S6qmVz3dVrC5quW/CHJnpbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR21MB3893

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
v5:
Change function name netvsc_prepare_slave() to netvsc_prepare_bonding().
v4:
Add comments in get_netvsc_byslot() explaining the need to check dev_addr
v2:
Use a new function to handle NETDEV_POST_INIT.

---
 drivers/net/hyperv/netvsc_drv.c | 32 +++++++++++++++++++++++---------
 1 file changed, 23 insertions(+), 9 deletions(-)

diff --git a/drivers/net/hyperv/netvsc_drv.c b/drivers/net/hyperv/netvsc_drv.c
index b7dfd51f09e6..706ea5263e87 100644
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
 
+static int netvsc_prepare_bonding(struct net_device *vf_netdev)
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
+		return netvsc_prepare_bonding(event_dev);
 	case NETDEV_REGISTER:
 		return netvsc_register_vf(event_dev);
 	case NETDEV_UNREGISTER:
-- 
2.34.1


