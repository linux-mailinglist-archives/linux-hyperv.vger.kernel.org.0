Return-Path: <linux-hyperv+bounces-3083-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A9606988B9D
	for <lists+linux-hyperv@lfdr.de>; Fri, 27 Sep 2024 22:55:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A679282EFD
	for <lists+linux-hyperv@lfdr.de>; Fri, 27 Sep 2024 20:55:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A8511C2DC2;
	Fri, 27 Sep 2024 20:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="ZtOl/yVs"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11021111.outbound.protection.outlook.com [52.101.62.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C915B381B1;
	Fri, 27 Sep 2024 20:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.111
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727470527; cv=fail; b=AWSqjUFiFB39tffYeEepg+lfvw6zKNsLjNHvBjYaXthpWYb4apDaTkJOdXOB3G4NUQ67kqc15cUYo+jWuyphA35d+j6qonf2aiig3ju64XT8Z0I6dFFm80jIj72xdU/PaBXakrHhgn/3uSC98XFGWevR8R1nx2Qoruk0ARVAGGg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727470527; c=relaxed/simple;
	bh=eyydu4qfh4ah0jNu1Yuq+bnUJiEia7YxU7sbmyH+shg=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=tHDF3l40Xy308n1FDfeMYlbmr2/+HXqHk44zHKzr+MTZ3f1YlRhrUn4LATB/eHFpi34eOqCY/75NoDZ7NJwXkFD609nFWUp7TbNsLLz5EslL4pePQ9HPlOR6rU7d74CZnRNtFE9bw3Rt746m84+S2kM9xFAdPHhEysN8zlKcThA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=ZtOl/yVs; arc=fail smtp.client-ip=52.101.62.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K/kheIJKlir6TqD57dkwta11gHLetnfoUgyfjfhaSvbn5fKKvepk1Vw3cza8Zc88/FzkXxOrX+aaOD/Z04T4WMdOwbml9JHJGLYtGe456BhPOaBp4Q5G93s59z5uYpBi2QMFZCdzhH/XpdUeF4VjPK0CSwOciVcbQLpYWleZzMPSAEqjwk/UhgTB9Ga8xebRvkp6A9vt4rCl2R86DKEUQd9oBaZofVu2ePjODJjgk6SWGFUs0jigk8+UIiDX91QGxs5g4Mwd8/o7LiOaPogVcwA/rMJqa6eTyrS3EUCj4bx+VsKTMCYdnOvXrHz7grlA1mqr/fJkpV8141IKLto04g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vbZUh3GbMnJLc5OxuItfITPcUcBwOXH8wLiVNHPa3ww=;
 b=g3Qh1vxulsfm3W46WfXumPZgQG7tuQea+F/boB1WmfvtB0/JXR2kKmBLSY/IibmtP+S37DpRUYd3yq3KDF2TJyORZdI0uZZ0Ykk7ooMxM7ZvY/CWkxNxMsRD+CFnAXAKnqRCZ+A8WhN7QMCl/JbzBlIPoOifVhXcjIE3km+AY1IdpmICGR3TQRHNgaxnp6AOWl7nYiu342wpcDyf9wWepPHy4llyCoIe9XULB6jGz6HfetJLbUk5MA0Hq/pCBYRkpuCiLcjyek6Wey0GChcybWOfkjkyw1b9JXUaUMWStYalt0ZLmW7fVjP6ZLJNSqjqVHqxwbv35nFhBtQQlmY+wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vbZUh3GbMnJLc5OxuItfITPcUcBwOXH8wLiVNHPa3ww=;
 b=ZtOl/yVsaNTEhACoJq1x0gRLSHUBB3DB1v8r1FPq99pwKrfMD2wyxrDBdXz5NCCN2/+4HdDhMnKY5GFDGrORrmdxoJckFg4QiIRofb6ABdirx48q+++0YvrQRZaPFfRA3fKtkzTMmVoLGmw3V+uWpDeuDcII+hB5dkBOcSfKzq8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
Received: from BY5PR21MB1443.namprd21.prod.outlook.com (2603:10b6:a03:21f::18)
 by SJ0PR21MB2022.namprd21.prod.outlook.com (2603:10b6:a03:390::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.9; Fri, 27 Sep
 2024 20:55:23 +0000
Received: from BY5PR21MB1443.namprd21.prod.outlook.com
 ([fe80::2c5a:1a34:2c8d:48ef]) by BY5PR21MB1443.namprd21.prod.outlook.com
 ([fe80::2c5a:1a34:2c8d:48ef%4]) with mapi id 15.20.8026.009; Fri, 27 Sep 2024
 20:55:23 +0000
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
Subject: [PATCH net] hv_netvsc: Fix VF namespace also in netvsc_open
Date: Fri, 27 Sep 2024 13:54:24 -0700
Message-Id: <1727470464-14327-1-git-send-email-haiyangz@microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0138.namprd04.prod.outlook.com
 (2603:10b6:303:84::23) To BY5PR21MB1443.namprd21.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: BY5PR21MB1443:EE_|SJ0PR21MB2022:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a5fbb81-7a14-40c6-dd96-08dcdf36b46a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|52116014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ybR6D3LNY9sfS1fqi3EcBDi22DOB5pcLFxZ27YUcx/pz8ywcYku36fGFnPNJ?=
 =?us-ascii?Q?EhfKFa0pszU/gRctur2bwaIyy4e3gUJO1TFuhP0eB2eF6EEd99WawW0h/1Jo?=
 =?us-ascii?Q?M/6RaPh+NXc71i39tdiImmJcry/qgIctPINONEgbs55RLMZ/8QTTtsMoA7qs?=
 =?us-ascii?Q?C/1YABWLUGrNk1vpgwIaX9zL9K9n859+tRhY3exAuhnzMGPjSsdJ+wwe1fqO?=
 =?us-ascii?Q?nos+I5Ufp2jx+obKCjVQg4yITXPohanj5CEEICIWjFHw4Bhqu6UL2Bi9gAKP?=
 =?us-ascii?Q?GyHR/LKGZrBzN4AYktH6PGv8NVVMphbyWzFB0Mop0Of2hlW1tfRQ6dSQxL6e?=
 =?us-ascii?Q?p8UjEvvgrr//4cANwiQ/CmjY0a5m1RBdDt47dGIpF+V/7LKjVp5yRciFgiEj?=
 =?us-ascii?Q?UIsYORTVwxD9B16x0Ja5uMa4Hq5/noGdPnMaFgitvfnYefNmlktJxPS4Rc3M?=
 =?us-ascii?Q?gJCXX2v+pOY3J4zPNbCc1PuxCjcpwmS7mFlc+QCkmCzgteqgMIQbpz55mSC2?=
 =?us-ascii?Q?N+wuU5Qzw7f8M6W6o5jqcUK8vgV3qQSWbnIdjy8/9mvjXsiuhGk6gAyR+ZHt?=
 =?us-ascii?Q?kNt0y7t3fYXeq8nQRp3IO8fTUkh6qdV/xXjJI4sdn2xxLgSTz5i4GlTUlExV?=
 =?us-ascii?Q?cuKt6BYJXorJGVZLS+EdZJ22h1UDKUxdZibDhld4azRVUhPYyp5a9zDdh5UO?=
 =?us-ascii?Q?t4n6sMlV79ybNIQzRKyz/IlEeRtJ2rPeEBbujyxDAuMFh/ZKCvazSPj+GARE?=
 =?us-ascii?Q?7Z9isDe6V1kFz0m55V0/n85xl3eDuJoczHVyLx/s31UiuLb4eZdeT+DB+A/R?=
 =?us-ascii?Q?69gA7DE76zQSGwbS1vjZ+cOUcRD86L34by9/JJbyjNjM8gB0p2a85soefEu8?=
 =?us-ascii?Q?CrOLZhlvegUXnlRqMDT9gQkSW+R9FRWABMzIRZrobSgqrmGTs5JyIlywhbcQ?=
 =?us-ascii?Q?27T85w+wR/43+/RQ1HrjpIRB4V9LSEUIddmIgTSFjT94JMPy8HPeU5exnr+j?=
 =?us-ascii?Q?s1sbpTFQjnTu2fYocoJ5MARssasRZWCEKo4TPG8TxML0aLamWBTd2Fbzg9Ni?=
 =?us-ascii?Q?Q1AqYUFh8KmTDkimClVweb1lp4NyFbC784TAY3dbWRAFSpSpcJP94Sp8Qzso?=
 =?us-ascii?Q?Vnfxq7dwognmpowy+nIfiqG88V5HKhWrPCOGOofDcShHcWcHmrUGAGOuWNDN?=
 =?us-ascii?Q?cmmYlTMUv3Sn4JMd4gSGbjQjqJl0qFXg/LdS+VjBYDXiBLVD9AMJuI/q0VPK?=
 =?us-ascii?Q?chOmbCD4mRjaC+52IhDMXFpWiFDciW4ctqVXIY3zVdF9nw4qSEh2OerU/3jR?=
 =?us-ascii?Q?Evyx/HorBodb+NWc5HomQLT+mYf5A+pZGuWzFnuAZNcYUw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR21MB1443.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(52116014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SUmZ6lxVA6AcoTcy6c1GMwK6gDJB0xNP40xKL1AAyzOeHhl6neI+3lC0Rc1o?=
 =?us-ascii?Q?AziNEJK6Azeb7KIPS4bIV2apXOqQgQHmEl6Js1VgZ/X+T/MyL1yUaqGul3KS?=
 =?us-ascii?Q?Nuhwpg/Eqy4dAglJuFd+9mIu7FoCLhsrW8vd2v7WvH2yCqDuOW5z+eBxktXF?=
 =?us-ascii?Q?2MgLZPsVOavzb4I62mQFf9L2RNzYHidxsUTk+YRkxuu5pgRV3LzSarr2cTlF?=
 =?us-ascii?Q?xKrrVbYChxIhuN0KUtTu1FBZtSSFBMkyCUmVwopBNfVUpcdcHt6BRmAF+Y9k?=
 =?us-ascii?Q?J4vmF4iaXQD6xklOhQHDQ1JzRDeJQypK0p/3crakQxVfwpjfIkQ6ldtkcy9P?=
 =?us-ascii?Q?sbR0iUoXNBr1rXd9m6F4TX1s4Z+ZOeznxdDLTx4t+AkHeyuBrD1Y+6pzHlMz?=
 =?us-ascii?Q?sGe/C2NVkTM91/p8uWa/+2+aEO8BEIH5otNNpcuoYrMnHaK7jvrDqAVWaCT+?=
 =?us-ascii?Q?CLhAnJmpqAK20jlALuof80t1zC2Fqo3fraAslRJ2nxrEDgIceuKdi7b1Smp7?=
 =?us-ascii?Q?f0Mw+8GDiolosHGMdZ3oHLgNeaZMH4veaAuUrhjIkoBfMO0Yjmk7VUrU94gD?=
 =?us-ascii?Q?zwDVm8pWbUfsIla1chfuOGorLmhDR0J+GkPzAMiAH965s9HPU+4qaqFeUJFV?=
 =?us-ascii?Q?4Vi0MFD10nlz/fDRa7hm+zJ+slhQZd2uv3kXP0oANl0uoLQ+vQgEl/XTN/W8?=
 =?us-ascii?Q?kKpbPWLIUqJHh6wdxdnzMBR3+2VZIIkUevAKyelKBFMYjgZXuujc/rQPvKZh?=
 =?us-ascii?Q?aGGr3oBh+OJem/lS44gL7042saiwT2JoABC2v+JxJfKiyNWxcsCWwY743hl2?=
 =?us-ascii?Q?c5tUrxGwCUWYbs6TumR2Js/5nI9yR5BwWrBWnEe5KK0iOI8Uym8PQukUv1vV?=
 =?us-ascii?Q?a1FJxuI6p/4cNNBpvA6r0NXS9758ZAR0O/EI4DL2CrZQ9uia/qLXhbyTRICF?=
 =?us-ascii?Q?F9MpOI6olxQTavyu2xCUNbMbZeL6h7TGL/vg2xMmX54tjWtJqhyTIHqCpLpp?=
 =?us-ascii?Q?pxOjCpaz9ugiy6gulIBiKBEJOVNx/03sJEKnJHUKTvZZxlGOE7RJXzpzIhXw?=
 =?us-ascii?Q?XgeHJOqLhBMqrAAPZO3+9iI/K26xzEG817w3epAb76r/AI3GHLeVI8lV+4kt?=
 =?us-ascii?Q?8rK8Z7gt10EQ3YEUv+AyhO4P9OhyvZiUEV6UskhstgwpQrkccPiTdt8Veh99?=
 =?us-ascii?Q?JOi+8R3G6Y6NwTbUGhONQ6HSQfCi5Vt/uN4M4MLzerHEu3UPtwhYO+7LyrCX?=
 =?us-ascii?Q?Lz+dPkdkmOmABnVKV6r2Sy5I4iWpYoLW5nHxoCumacolv9ZOQks/tdBe0yr5?=
 =?us-ascii?Q?XpoYxhx08scsdjr5JQvk4MXRQygWwsqnXY03TQSlWo5mlSQQrN3lBhq5vmYJ?=
 =?us-ascii?Q?oWwAyX/GzrsotnDme9XrEg40KdZP7knToyYRTTUb19tf4JqS1Cuy+ZT7x2WU?=
 =?us-ascii?Q?W0uDMAsLzp0C5vzPBIN0PkuzCRmpowFtgzdu4yliVWMwNxeNCbfYx5YmtuwJ?=
 =?us-ascii?Q?4yvC8L1Z3uDTq8iU90hnDqDDFESsRfB5tXp+sjdNx2F2JuHPURDKD0u54fQ8?=
 =?us-ascii?Q?OkHXic+Xlmn1c34shY8fnfcpTmsW+ieRSYRmpFfb?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a5fbb81-7a14-40c6-dd96-08dcdf36b46a
X-MS-Exchange-CrossTenant-AuthSource: BY5PR21MB1443.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2024 20:55:23.2286
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3vy8qhEH8npwzadC1OtmlyAP4HH9B+FhHwEdylbEF3emgPJkrRrU+Ow4ri3FrVWoAkYkJD4L0PCOGw7CbGPmYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR21MB2022

The existing code moves VF to the same namespace as the synthetic device
during netvsc_register_vf(). But, if the synthetic device is moved to a
new namespace after the VF registration, the VF won't be moved together.

To make the behavior more consistent, add a namespace check to netvsc_open(),
and move the VF if it is not in the same namespace.

Cc: stable@vger.kernel.org
Fixes: c0a41b887ce6 ("hv_netvsc: move VF to same namespace as netvsc device")
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
---
 drivers/net/hyperv/netvsc_drv.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/net/hyperv/netvsc_drv.c b/drivers/net/hyperv/netvsc_drv.c
index 153b97f8ec0d..9caade092524 100644
--- a/drivers/net/hyperv/netvsc_drv.c
+++ b/drivers/net/hyperv/netvsc_drv.c
@@ -134,6 +134,19 @@ static int netvsc_open(struct net_device *net)
 	}
 
 	if (vf_netdev) {
+		if (!net_eq(dev_net(net), dev_net(vf_netdev))) {
+			ret = dev_change_net_namespace(vf_netdev, dev_net(net),
+						       "eth%d");
+			if (ret)
+				netdev_err(vf_netdev,
+					"Cannot move to same namespace as %s: %d\n",
+					net->name, ret);
+			else
+				netdev_info(vf_netdev,
+					"Moved VF to namespace with: %s\n",
+					net->name);
+		}
+
 		/* Setting synthetic device up transparently sets
 		 * slave as up. If open fails, then slave will be
 		 * still be offline (and not used).
-- 
2.34.1


