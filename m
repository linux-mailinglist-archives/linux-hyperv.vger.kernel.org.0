Return-Path: <linux-hyperv+bounces-4794-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8AECA7B126
	for <lists+linux-hyperv@lfdr.de>; Thu,  3 Apr 2025 23:30:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DAF503B97F9
	for <lists+linux-hyperv@lfdr.de>; Thu,  3 Apr 2025 21:24:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0F6E1EBFF0;
	Thu,  3 Apr 2025 21:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="Ed45iG6W"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11021132.outbound.protection.outlook.com [52.101.62.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F9451AA7BF;
	Thu,  3 Apr 2025 21:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.132
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743715393; cv=fail; b=O723b/kHHgE975v69EZdx26NSlaiIEVRiCtQaIdojUwm6TTEoJpTvPtZRyVuQD4wLE658pn3+BJu3LHbXXAzHwpSUzt3ZZowd5bzbCfYT6pFVg8jr51s7+rvi8nCMB8lcF8P/DCCbI8iZexFaFpgVP7DgblltI9nyLEEOeUlnnI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743715393; c=relaxed/simple;
	bh=xHL0lsFrC3yk9QxaPvF+/cizwlkD2JO7UTQttzq4MLM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dyE84xgbdoVejm8+hNGvGisiC5fUdkTDzHkrY1r2fZ14+tpTuC72/DsheYlsbANA/zrGyxEryeS6T30O9ID5y9mntZPBW9S3FVFC3SngEFz3WXHo4hli93J9Av1nd92kwzkNDOBLy7jFMBL8c4c5cT/hU1dfCr0kvfJmX4daGbU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=Ed45iG6W; arc=fail smtp.client-ip=52.101.62.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qIu611lToOsXLh3IJAZNWlPFXudTnQkhIh7fzxVSGaQwbojwklQp1n6zO4WOfc6si4IxzUDaCq5i5ysatgh+yJvnUrNbmba4bZNS0a3Qh6jTnVCjitSQGgiay4p9lEVdN7+I0/HavBb//1EwpjBDk0nwbzcLtvIDycg6EOko5VpNewtruF+hcKiuslOmWuoc37yvt6ytDq54TkB7JCf+mmy7qPu1SUfLcrf3LsYV3PJtDS6xmbKXw1IiZeUcE92HlblHyhjoQ7O3TpIEtlUVpQvPBsCEJZpmqVVGUmiAzD4pDBcMbIMQ6wvYzf/r5UqYc80gsOp4A60eYkAghYR6Bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GeJkYBd3eZK4xeUd/Ofw9pzkdubHNvaFt1VMAVNkMFc=;
 b=cf3EGmS7ZY6KDGvOqzh7fskxFcGgxrlHqLDccu2sBvIciLBY5IPgMiucfiYxbdLyO4F2W1wjo0/U76g4VwTiRC995YmwMHMqjeagILV9AVeO4abmbgLK2nfmjW35OlgJQiYE54fSGFfSrlq6GWyzvbLpdU33KhHF4KerXxKlTB9XXoITPkQp+55RxKt9rpM7CWl8zF/KaNtHGGcEA47K1cvykHPuDw4mS1W/GucI6L4NEfAtd7sqDL59QnABW6vu40u3J98Uq5R51miWIUCABYKNXdDZOgPig+atgFpRFTuzXmMRDRqnead3Wyn//AW5xPVxUz0UN39krwU2/Z2Vnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GeJkYBd3eZK4xeUd/Ofw9pzkdubHNvaFt1VMAVNkMFc=;
 b=Ed45iG6W4QMmDTNR2ulLYTsGAKcTM0UWt8oraX6ahxII9W2MjIScVZqtRKZdBy/M7XW8iWUTezDPufQ9poEEQ7ddvERAC0bJeC+h+RS7ttZoBrPtoB9mOyvJMdCXySwOyybl9PhAmNYUkduDlRlhuXbW2qMm/FrOhFNSAYTp7+g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
Received: from DM6PR21MB1451.namprd21.prod.outlook.com (2603:10b6:5:25c::16)
 by DM4PR21MB3154.namprd21.prod.outlook.com (2603:10b6:8:66::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8632.9; Thu, 3 Apr 2025 21:23:09 +0000
Received: from DM6PR21MB1451.namprd21.prod.outlook.com
 ([fe80::7a3a:a395:66:b992]) by DM6PR21MB1451.namprd21.prod.outlook.com
 ([fe80::7a3a:a395:66:b992%4]) with mapi id 15.20.8606.022; Thu, 3 Apr 2025
 21:23:09 +0000
From: Haiyang Zhang <haiyangz@microsoft.com>
To: linux-hyperv@vger.kernel.org,
	akpm@linux-foundation.org,
	corbet@lwn.net,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org
Cc: haiyangz@microsoft.com,
	decui@microsoft.com,
	kys@microsoft.com,
	paulros@microsoft.com,
	olaf@aepfle.de,
	vkuznets@redhat.com,
	davem@davemloft.net,
	wei.liu@kernel.org,
	longli@microsoft.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] docs/mm: Specify page frag size is not bigger than PAGE_SIZE
Date: Thu,  3 Apr 2025 14:21:49 -0700
Message-Id: <1743715309-318-3-git-send-email-haiyangz@microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1743715309-318-1-git-send-email-haiyangz@microsoft.com>
References: <1743715309-318-1-git-send-email-haiyangz@microsoft.com>
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0048.namprd03.prod.outlook.com
 (2603:10b6:303:8e::23) To DM6PR21MB1451.namprd21.prod.outlook.com
 (2603:10b6:5:25c::16)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Sender: LKML haiyangz <lkmlhyz@microsoft.com>
X-MS-Exchange-MessageSentRepresentingType: 2
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR21MB1451:EE_|DM4PR21MB3154:EE_
X-MS-Office365-Filtering-Correlation-Id: 12eb7694-8344-4544-0517-08dd72f5bb34
X-LD-Processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|376014|7416014|366016|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?iGC4KEwLhLPiHcFZ8RKDZbyuAxOHxxXvdM9DnLC73ginRbIn6vEEvK7FKKwf?=
 =?us-ascii?Q?KoF0Fp8GqqcmhIyfw3mAiqT8Qjvoh0PY/dCTS1BlVdiYESn9zkg9/YGiJLhY?=
 =?us-ascii?Q?Mdjhp9WQ6cNlP6WEbmdYttc65rvNY8RsycczJQjvUkEzAlI1uaMre2f4nbsS?=
 =?us-ascii?Q?m61N6SyAGKqzsFfLwyQZLIX6mH0Db/o2bOTsBLCB1pNC3x0XNZAHJv3Z6Pde?=
 =?us-ascii?Q?/hqE0v89p8avHU2lQAboYuKVCg7S9830C9FmyqegMA3CzuumhkVhbV8Es1F1?=
 =?us-ascii?Q?Cjlpe34VRo6t9M2zgXD/mbD22AoPouP9qDsX3Ye/lXblmhiDP6lQwdlocVyh?=
 =?us-ascii?Q?CTtUHTgsQY3D4q/U7KXZVqHS5iRqD50MWR94Jg3yj2Ry/9WJbLelvt4OtzvO?=
 =?us-ascii?Q?2lC6bCUJpTiulEvSo31hhJdMPXyp3yMUYUfGt5TDV6lCVqQVuaP1UGpGTA+t?=
 =?us-ascii?Q?sQTTJXIuX/P6tuMxqfYRLz1JEhp23faZJ5Hc1ECUQ9wDr0hPB1Z7vYgVKItM?=
 =?us-ascii?Q?JoP6oTWipx+J3oNVK3vTRgj6EPK0E9GlPhLcy+nNpD0IfQ6YYGXER1OFi0d+?=
 =?us-ascii?Q?g7iui9cHftYToMzHwXqOlKZNtSbIcQ2kyrlw0z1qrBI6Qm86AmSE0Mq37UZY?=
 =?us-ascii?Q?iSdd9FS0pOLsTX1Ze9jSpCsejNNc33Z5eSeEHcZVje2tsSMuq84aNY8PzpDA?=
 =?us-ascii?Q?zllP1FDMlZDWD0/fmlonEO3ztmfiDFRn9dVayaW96aFTMdS1h57xG+j0z7/b?=
 =?us-ascii?Q?7JL9/w+BIv8RGtut05S5MfAvxhK5aYfdUqoCL9WHjEN9GPifRU9RAEfL0i0W?=
 =?us-ascii?Q?Z+Pklpi4wSciTfUO/8ksIsUSuFGInCPjfmxI6SKFmokgUk1DPO+4/xfnNUCD?=
 =?us-ascii?Q?Cj4cZv6djoSsmEVH+jEqxygA8njZMerpVH9tW9X2cn/sdinpPHF4q2zgl7TG?=
 =?us-ascii?Q?6HnGPhhKVVKVQuwOZdXWvuPB9M1ikjbBOSNCkLl61IURzWZ//H2S2k6Z75ts?=
 =?us-ascii?Q?V75IqsuLnO75CCK/M0xYhvXcFeS0EFsW77ESaw/0ShXPLI516hX92Bfw6XU3?=
 =?us-ascii?Q?aboAmJRUVhxOQsASbx1UDhUj1Ab4phFkAP0f+Bsf/WUKd6QDdm34LL5OeoZ4?=
 =?us-ascii?Q?uHyqKpgm33pgm+DRLO6/eVesJKPbPPwY58YeHjwyDXhESc6FNti4s1hBRq6p?=
 =?us-ascii?Q?MRqsOLksb7WprbDgGGYf0FjweIbiHXGMTrl44KM47gLW2rmvWBDo4VPaIdZJ?=
 =?us-ascii?Q?/nb4j3B17dvaSKw97qxVdZTatUG7uOWM+Bu9GpeqSUMHZg9PRZXEmB7UKtF6?=
 =?us-ascii?Q?Vha9636kcUiN37rkb15Z1jEodL5bx7JIM/xv1BU2Yihe5iMu/XAYTv9p0dV4?=
 =?us-ascii?Q?I666JjANjGWRNJ1IHD6Vpejf8Quf3JBm8Gn1pX86jI7YaaQm1IFLV2xDDD8N?=
 =?us-ascii?Q?h941aSe+/ZlxZaaUAwElZ3RZMKPlznlwnHdzXcDDH5NM7zRJFkpL5g=3D=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR21MB1451.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?zcjx2Qup2s1xa4IXYraSJnfQK7gMgElbkHWMT9NfZgRt2uLPDSoj8XxhPA0r?=
 =?us-ascii?Q?7okFAp38sCZzK53IEEypL6DeQvi0HOxl6zZ4nL/uUdvyJzNXpT8xU08C5xpR?=
 =?us-ascii?Q?shEPKNGJZ+1ylQ58f6l+HvQHNEYbMrpF1xldAIuKpjxpxhCWd6OwSJH4CwIg?=
 =?us-ascii?Q?0aqO4Tv+ADFDKL0Pvd+22RFkS4ISs1mnOOhGZPckenyjbNLASzf20M6P1ENs?=
 =?us-ascii?Q?Ah0xI0/EBsmYY7bgiu0XaJeCRvwhE/xCyQxXsu81P03IPHg4O/O1HQpFloHa?=
 =?us-ascii?Q?JxFLU/pl9P/oqBAxU/3whGJngVGa+W8/kKceDNRTz0hBvsaX+3r09FPtEEcT?=
 =?us-ascii?Q?zIDThptTPQYNUOj1dYV4hXeWW96dAC5ewNsJ2rBkFYZzntgvQijKbHbxIDn1?=
 =?us-ascii?Q?XtHJ9kavfcr/Dd7BJoxN2eZ826+2EyTuGWUQAyQu7AfJNAUNfWoAv/QPprST?=
 =?us-ascii?Q?RMeH1hlHyYagxrhnDxxwCw3lqYdfS6+AnK1HGPbJBgXZL2QTKou3kkEVc+gd?=
 =?us-ascii?Q?+41dmZPd/kyllNwy8zQzcuQi5I4HvFPZHXbKMSHMu+YXExCXaoRMnn3fTTlt?=
 =?us-ascii?Q?B07vjYS2UW7mzHy0q9juZtezZY6xi1I4RehHGMf3Itm6vMleXvHO1d8X71PJ?=
 =?us-ascii?Q?ftt2857+i8bMimkWRxYjzmPE41pjfWJ/ddfEedwVDPU2j5m4hHYjaqkgjjbk?=
 =?us-ascii?Q?abrR7gLA2uwNIIozY0p1f1lxnJPeOnHda11tx3+0zZg4pBuLE7HOuB7t3db0?=
 =?us-ascii?Q?hHZHmWMf6xWzwghX74/Esll/m/3wQYAlbt8YDyq+vGW0PwV9oXXkqv2CjOIY?=
 =?us-ascii?Q?x0D50JHNTAGjz8gew2UtpWuZHTRzjj1OzCqPk6tJy0BQ70NI1aGJgTutQz6x?=
 =?us-ascii?Q?WNx5hVztC2ghvoO9PD/VAQCj4x2quZYpBlg2lpEiDU99Nh59RNof5CiXJPg5?=
 =?us-ascii?Q?6SvU047gGYjm8/gk21rw+7i97YOqmtMsLEVYNG6DmQ0kLotdf3LdnACqCuej?=
 =?us-ascii?Q?a980opoCBollvMbx8fb47sAAystUpmtoowA1mBPjoM//gvb//R7m2PSM7yxS?=
 =?us-ascii?Q?zViuVvYtnva1CgifYSH3kFyTsea2xonSVe7/xBQJqFkXq1J1+7zkXxPC6kZW?=
 =?us-ascii?Q?it1QW2W6a+Ixhm77/OBWq+LjKvLi2sOgnBYndL+JhVzD3v2ts4OcHQhanXuW?=
 =?us-ascii?Q?95epNeLxt/XLQ87TaYnbOj+oNznd+mr1as3J8RHzVRGayFrlqkQjUYh+QWqg?=
 =?us-ascii?Q?lUHmUVWE6XFLwFK/hgIk+qr1qml9ZAypDURitriDr1IIsCk06dtHBLIroSsC?=
 =?us-ascii?Q?47MBXXymDVxj/8ZTPc6PBs+tGj7FTFnMed5eZK7FenRuwFpJf0CEUBiwMlLA?=
 =?us-ascii?Q?ZRudLuvDBClA5tl4QyAIk4JIuRA5e2Lzyq3njY48D6VPjFBCAwwUVFHtMN/B?=
 =?us-ascii?Q?oO0osPtqXNh47S71QpT6AmmLe39LlOJ1g+kwGgxVAt5ktvqnHe+alGS8c6Lx?=
 =?us-ascii?Q?Y7UM3yc7LmAZddmhYm+GKvNOMoIqas8SJLOpcFTzfEm2cH5uREL1otjEYpkn?=
 =?us-ascii?Q?0QtUkqRSkcAjTtl/qnzTGk4h07vGAKV4J6Ijwqw1?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12eb7694-8344-4544-0517-08dd72f5bb34
X-MS-Exchange-CrossTenant-AuthSource: DM6PR21MB1451.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2025 21:23:09.1415
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mBWaS1z07ADDckNak7v3KbL2q8nuxLxQnt6RGjjx5jNogWr8L2fF6/Qx7i6G+EwcoecgN3MraZCkJtMweg2RzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR21MB3154

The page frag allocator is not designed for fragsz > PAGE_SIZE.
Specify this in the document.

Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
---
 Documentation/mm/page_frags.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/mm/page_frags.rst b/Documentation/mm/page_frags.rst
index 503ca6cdb804..212ecc69dd74 100644
--- a/Documentation/mm/page_frags.rst
+++ b/Documentation/mm/page_frags.rst
@@ -2,7 +2,7 @@
 Page fragments
 ==============
 
-A page fragment is an arbitrary-length arbitrary-offset area of memory
+A page fragment is a len <= PAGE_SIZE, arbitrary-offset area of memory
 which resides within a 0 or higher order compound page.  Multiple
 fragments within that page are individually refcounted, in the page's
 reference counter.
-- 
2.34.1


