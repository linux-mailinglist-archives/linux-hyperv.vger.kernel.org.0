Return-Path: <linux-hyperv+bounces-3157-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 267E59A45DA
	for <lists+linux-hyperv@lfdr.de>; Fri, 18 Oct 2024 20:26:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B1A51F24EBD
	for <lists+linux-hyperv@lfdr.de>; Fri, 18 Oct 2024 18:26:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 996342040BE;
	Fri, 18 Oct 2024 18:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="WsDnDGek"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11020082.outbound.protection.outlook.com [52.101.56.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86CC42040B2;
	Fri, 18 Oct 2024 18:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729275939; cv=fail; b=YGUEW9z5U/Iotw8UoFmPKwV+767XdfOUetuzPxuXtjyf846M1g4WR6r0xVMd5umICvkpvQTjy+ykKH+HFoGFxuFeuOTQCYJJ5Pop/Dc0drC12RKBfipSAcygzPtAYhMTfwWEUt1RGDqtZhbKUMzTx6YW09HX4BgrPGtt/sfqo5o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729275939; c=relaxed/simple;
	bh=c6DB9xS7MRcLqZIxINVRaAbmf/GxDb/O6l8n5lOkfvs=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=QIm7xlb8zhlSvYFkfECHoVdwEtkuk/WE3hVUOpyG0S8upcDrabYusYHgBJrT6UPk3nTa08cwzrI9vCn29opaejZTH/SFvh4dd8Xoj3qhoswF3HwNwO6pbp7kMpXyVOk1nvIGRQOtsEYo3FQQ4KVEYSgZx79HmvANXj2TYwT7Cws=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=WsDnDGek; arc=fail smtp.client-ip=52.101.56.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wsGag66tGwIXGB286rLt0roU58QOXagXAd5RrC182FiFqV0T4MFu/DFM68hQ4XwLueGjgKs89ScVMtQHPoj0abESNxco0VEBkkCzLBXQ2Bbvsm+/CJ0FBsJGfA8fLfN/ieGcgD0OjUwVj6oUw5Z7cEaevLEGSeQGFgXLkgUu2wUUfuBX2JzuOV1pNaQZor2XAf9/JozmBX6omPzebG+Ls4uhD88WuHKjg2udXomWfxjNremHodPaYHQRYXaEE2clc8pO9uaR55JNszSs6EfOtTrfB0iJgZxcqPZFK8T9IyyLCWBzzkvF/ckDZHTTqBHJBF+EYMFWhYvSgOCk4c0Lmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=il99dkPd0kNT29Ru6xUAHWsS81Z3wRoyekGNbgkUCWc=;
 b=u8zzQ7n40ZWOhB9nLLvYWC/ooNeNi1/NIE7FjPnDhsJGPZI4DR7Mp91n944fA41yoBLZS0+3+2ttGNgMtWb86kwwjBHQ+svaXMjfX3tAG4mHWIGDlIeJfcR4fLXbdHwdTQfA+kZPW9kR4YY2xxE+k8tB29jbtq9aCKgMUHzVMpVX7bOuh9q4j65U+m3MXGG4harz4z6LSmtKdpZys8vg0NB7ZxjUWWdFToMoSwp8R9Bp2Urf2Gq2ABq9tulgDAPUtKaar+35FpGR+ti+ufQFa+hzekC2DPRNW/DWjCY7MlxrkY9x8FM82bu1OTVSV/TDUdpHJXGno0D6mGeVuMJGTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=il99dkPd0kNT29Ru6xUAHWsS81Z3wRoyekGNbgkUCWc=;
 b=WsDnDGekYYjrFMIxi9baWx04X0YjlQf+pg0vLbqSSRWrk6lTmQsUR1PyFKzKFcukhSTHB579NGmtbw88nvIZzIawtjIWusS099c03af8SIGbSLk7MXlgNqqRbhG6KFwNorNCgW3MJGAV0pgz9GVtNZfLOwsWp9etluFxszfbU5o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
Received: from BY5PR21MB1443.namprd21.prod.outlook.com (2603:10b6:a03:21f::18)
 by BY1PR21MB3893.namprd21.prod.outlook.com (2603:10b6:a03:52d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.11; Fri, 18 Oct
 2024 18:25:35 +0000
Received: from BY5PR21MB1443.namprd21.prod.outlook.com
 ([fe80::2c5a:1a34:2c8d:48ef]) by BY5PR21MB1443.namprd21.prod.outlook.com
 ([fe80::2c5a:1a34:2c8d:48ef%7]) with mapi id 15.20.8093.011; Fri, 18 Oct 2024
 18:25:35 +0000
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
Subject: [PATCH net,v3] hv_netvsc: Fix VF namespace also in synthetic NIC NETDEV_REGISTER event
Date: Fri, 18 Oct 2024 11:25:22 -0700
Message-Id: <1729275922-17595-1-git-send-email-haiyangz@microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Content-Type: text/plain
X-ClientProxiedBy: MW4P223CA0022.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:303:80::27) To BY5PR21MB1443.namprd21.prod.outlook.com
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
X-MS-Office365-Filtering-Correlation-Id: 2b31f0b3-9d6a-4a26-92e9-08dcefa241ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|7416014|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?T8ZoJBogi0YT4pkDrQmgxdebHVgXw5E72Y42jO4adUDWWizAFIBuEMyVKmmX?=
 =?us-ascii?Q?+JmFQ9WcNsm3OVieS9qsQTapT0FANYjmxUo1yXge7JqYjpB9KWobCxTk/I76?=
 =?us-ascii?Q?QgygDlCLPGHhcN2Eaoi/uYQNPNnuNi8ZfJ2Skg0wUWqwJ15Wox0OANdCwL07?=
 =?us-ascii?Q?VX/pIuUsReiArsU7lOibZd3hS4JwZfCRkVZJeT0s9q8NKeQuQlCx/Z1F/1Pq?=
 =?us-ascii?Q?XqUgi1v1jVLjuh8BMoWmul7iO0Sn1ZsfYJbv2DQ7/vgR4PWTPnno/0MBWLRu?=
 =?us-ascii?Q?/5Ql6bd5BBVED3+CgPSW5E2IykGbhX9cYy6Rbt3ABX71uFNgSv7CDmA7GG9q?=
 =?us-ascii?Q?W7TQFaZ2D1YCPbvQQNrqr2v1mzuDs2S2JDjTdXNtQ+1vmHqDC6Z3frVVN7Ks?=
 =?us-ascii?Q?we8niXC8b8Zg6UZxghFsfygpMJ0JQeLqtLwDFrk2vG6fP9G7pN7eV1u6SjdY?=
 =?us-ascii?Q?ds0RJAolYGpcO9eq2/XSXx06Ss64P2flXsUM3NZzghTLlCn2D4TVyfIFEkfQ?=
 =?us-ascii?Q?fH1NHO1+RTKLZ/z+NZfFEJ5maqRkkfTD/5rIBCtr4spho7FI/mIoLYFbUVcH?=
 =?us-ascii?Q?eLx8gQRT1TO7L4QAyozlfQLW+waCz2erNkvmC3rBXpcMOvgZTkNkWX50JeC0?=
 =?us-ascii?Q?KBQVL8sOXYX9VN+ZOOYrquRivR1zSqzqwEa7na5AO3RdswyYq9I/4Wi9CBx8?=
 =?us-ascii?Q?Pa5ttjEpDc4mA9IQ/gjxccPFHFwEYghmq2bnEbSnFi55H1+AXLMfBlLfTBt+?=
 =?us-ascii?Q?PGJ+X3WqYiJ8KF8blfkeQcabpM/kYqWPJwjD1A7rHWETspmBDCwtpXkt9fTQ?=
 =?us-ascii?Q?B6+4G0L21kKkWVyHxcljwC771XV0PHAxb3LDP4Hhmty+tpNSpDSj/J2rkfi0?=
 =?us-ascii?Q?4CUso3q1FNhY7hE5xe2ubt6dsHsw0DF/STMGA73yd58tYWUrFgyoFachHucV?=
 =?us-ascii?Q?oviZxlJRLRviNFW0HcBGhMmYmU43AMoVIV/wXqLnuRlP/dJYM6MQnFg+5mW1?=
 =?us-ascii?Q?G6BBnsxZ7xJp9fiKA39fguxx6yYvDFFIxBkHmyOlZ7z08l938qLmb8E386gB?=
 =?us-ascii?Q?E4pjfU6xuD5X14vMuKwViBHsmadsCfFlep6HjhDwHumUpb9qyqqorpz3nBcc?=
 =?us-ascii?Q?MP0gUW8CsqZn526a2oVmhhf55mSWXNYkkgXrzV7awHr25Y9n5VqiL2iDwwke?=
 =?us-ascii?Q?PMRZ85m1YAaL1uc+CW7nU4kBsGd9Co+oTqrpBh9NBrGFTn9mJSzQ55XnV9Ga?=
 =?us-ascii?Q?N13RqaruXEbvlsKw0odGcLHgklef1lQ1ZZJRBzxm/G0vd9M3ZVF+hrHB0WiQ?=
 =?us-ascii?Q?4WmDglKV6eCKaqz9sWPAsQkpLENS5MFVJCXG4lf1T8URieAIPZq7a6Hv1mov?=
 =?us-ascii?Q?U6zkzuk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR21MB1443.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(7416014)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?43BPD4eORsNx6/e/C9acdBOX0nEqxwn7RaJfuMfUeiI5SDcnUD9yWECoNFH1?=
 =?us-ascii?Q?kpMn+mN45PDxZ12nD+RvUa7OCodiUEYOcmWvmbpW6ZVXaQQr1e+WIm0olHRz?=
 =?us-ascii?Q?CXaAmT471LvLZvN+Z9mO37LdD/5NmUlor9NijP/Pon7OucbId3pj8pkXzqHh?=
 =?us-ascii?Q?IRMfitdbOaktKeFVAMIYmRCC0UBerKeQi1PhIFCV4igjRj1tNMuCwenIc4dr?=
 =?us-ascii?Q?etdLUViTPWAH7YzEnnX3B04aK5y3QzLOhoch3Cf69PmFzsR1NZCrm/rBzeW1?=
 =?us-ascii?Q?fnZDpYlHG5NqZlnSw9EFXScZZLrevXuvkn9y5u6nOlfQHHCMB/Ffo37khV1P?=
 =?us-ascii?Q?csY/evUv2o04QmF6qNkOKO7629CDKgaf6POu3Ucn58isKVvbnI3oeh2fw0Wn?=
 =?us-ascii?Q?llOFCHa1U57LpDAR04YzRFDiYeeyw6kKdL3Ic/8LGIfnfqy/ElY1HCyKvUcr?=
 =?us-ascii?Q?V0+3Urx+muIEw3WNSFNby/kVjp+OQ1sETjY13wglupqt/346qcqkkXjx7KCD?=
 =?us-ascii?Q?d9h7g0gbVvHJBqAQavGdgpU1tbcgIjdsczp2U3WFRjIIeuES7CcKvMNRd2+3?=
 =?us-ascii?Q?rDxkoNkPBiPKeOeyRH7ZCZu4d9729iFNAXCTo15Iyl+/rhxqTgM01Owz1SXz?=
 =?us-ascii?Q?lwSM5hF4vXMjbPFak10eZSOwxylvUYzfrGlKtXYaLx9ofCUIt+A2g1klpDIR?=
 =?us-ascii?Q?vJJPHQVLL9KhVbS2lxkzwPBqJkbE4iczjmv4wd6P2ytkNXcvkQAblQH2k/AJ?=
 =?us-ascii?Q?NfFq3nedwYxYmA5BoPdnrxPVB5NjDL6cc0QTnXBkpNRV1aUlH77tZuzGMt97?=
 =?us-ascii?Q?VnaSCY+r+T2mKufIlsKY68yDKWScMBnr+NL+TK6pbYLYUOkblDfD3AKiG5NW?=
 =?us-ascii?Q?W71LXaG4hWAHZ0TZxss71Nz8kiP7CxU8d8DC3tKb+uqOoOWMKT28p9SvvAYT?=
 =?us-ascii?Q?25tBH9aWYG3fEi10wKJtP2GbRRrhZXt7EH5t4omZd31asc6Y47uaHmlc9rr3?=
 =?us-ascii?Q?YdF8JqIjPG4PdFpZAtcwz97S/mR6Vre/PBoDkbM2OnZyA9lLpQdzJ/1vceZe?=
 =?us-ascii?Q?Kwtewbk6CCv6mJsoeNqfXOZUueC7xCbUIbDgA9VLOMkSZVUTUa7fBtVfy7u1?=
 =?us-ascii?Q?wYljWJOs2DD2ocy1R3hf6nVwTJtwrAiVpK6Wnk1dSajbMab78MwRzgDTiYzm?=
 =?us-ascii?Q?wegKzuSHZP7gMxO2ePsW8XshWOKKpdukC3DZv2P+hzuHc4N4lEjXlKbu3/8K?=
 =?us-ascii?Q?rNSUCRQ9ygFVJPMywal4NB2HKA1mimEhbE3UDmb9F6YV1FYDAGWHBHkvKjv3?=
 =?us-ascii?Q?OU70E0JDLE9OBQG9Rcg4NpeSuN1NAPgnp8HQ/6Tir6tvyKnKRKpKO4L5Ap+8?=
 =?us-ascii?Q?DYT+DzEso/1aoTOJnDZlPwyFmb5LaCLIlWCGW9n7gdqvwZ/JF/zX9Tghchj3?=
 =?us-ascii?Q?jDDOTmaLjNSb68ZQPE8J7VbchsS+vvDGtNr7hQSs+XClSQq0S/abmcnnPeGf?=
 =?us-ascii?Q?GTtSw4+lQxrVg98dnlTRF6+ZFfuhXMthfIwAPiAn14m8joDNd9l2wiX+N43v?=
 =?us-ascii?Q?GvyoCGsGRV0lh5DAJuVKMBvtBTtJuRT894dsuOpo?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b31f0b3-9d6a-4a26-92e9-08dcefa241ce
X-MS-Exchange-CrossTenant-AuthSource: BY5PR21MB1443.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2024 18:25:35.0270
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eSYngAH+iEb54bJoN6FAtVJgKvntaNtWkPRsiDHVZfB13l88y2JB9q6iU2o2jjs1DsE1TUGVaaQMOCwk0vjZfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR21MB3893

The existing code moves VF to the same namespace as the synthetic NIC
during netvsc_register_vf(). But, if the synthetic device is moved to a
new namespace after the VF registration, the VF won't be moved together.

To make the behavior more consistent, add a namespace check for synthetic
NIC's NETDEV_REGISTER event (generated during its move), and move the VF
if it is not in the same namespace.

Cc: stable@vger.kernel.org
Fixes: c0a41b887ce6 ("hv_netvsc: move VF to same namespace as netvsc device")
Suggested-by: Stephen Hemminger <stephen@networkplumber.org>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
Reviewed-by: Simon Horman <horms@kernel.org>
---
v3: Use RCT order as suggested by Simon.
v2: Move my fix to synthetic NIC's NETDEV_REGISTER event as suggested by Stephen.

---
 drivers/net/hyperv/netvsc_drv.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/drivers/net/hyperv/netvsc_drv.c b/drivers/net/hyperv/netvsc_drv.c
index 153b97f8ec0d..23180f7b67b6 100644
--- a/drivers/net/hyperv/netvsc_drv.c
+++ b/drivers/net/hyperv/netvsc_drv.c
@@ -2798,6 +2798,31 @@ static struct  hv_driver netvsc_drv = {
 	},
 };
 
+/* Set VF's namespace same as the synthetic NIC */
+static void netvsc_event_set_vf_ns(struct net_device *ndev)
+{
+	struct net_device_context *ndev_ctx = netdev_priv(ndev);
+	struct net_device *vf_netdev;
+	int ret;
+
+	vf_netdev = rtnl_dereference(ndev_ctx->vf_netdev);
+	if (!vf_netdev)
+		return;
+
+	if (!net_eq(dev_net(ndev), dev_net(vf_netdev))) {
+		ret = dev_change_net_namespace(vf_netdev, dev_net(ndev),
+					       "eth%d");
+		if (ret)
+			netdev_err(vf_netdev,
+				   "Cannot move to same namespace as %s: %d\n",
+				   ndev->name, ret);
+		else
+			netdev_info(vf_netdev,
+				    "Moved VF to namespace with: %s\n",
+				    ndev->name);
+	}
+}
+
 /*
  * On Hyper-V, every VF interface is matched with a corresponding
  * synthetic interface. The synthetic interface is presented first
@@ -2810,6 +2835,11 @@ static int netvsc_netdev_event(struct notifier_block *this,
 	struct net_device *event_dev = netdev_notifier_info_to_dev(ptr);
 	int ret = 0;
 
+	if (event_dev->netdev_ops == &device_ops && event == NETDEV_REGISTER) {
+		netvsc_event_set_vf_ns(event_dev);
+		return NOTIFY_DONE;
+	}
+
 	ret = check_dev_is_matching_vf(event_dev);
 	if (ret != 0)
 		return NOTIFY_DONE;
-- 
2.34.1


