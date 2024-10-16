Return-Path: <linux-hyperv+bounces-3147-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 460139A0EC3
	for <lists+linux-hyperv@lfdr.de>; Wed, 16 Oct 2024 17:44:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DBD81C2228C
	for <lists+linux-hyperv@lfdr.de>; Wed, 16 Oct 2024 15:44:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FBF820F5A7;
	Wed, 16 Oct 2024 15:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="H3jAQDNJ"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from SJ2PR03CU002.outbound.protection.outlook.com (mail-westusazon11023079.outbound.protection.outlook.com [52.101.44.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C018920C002;
	Wed, 16 Oct 2024 15:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.44.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729093474; cv=fail; b=Cv+6hpoarqOEU2/K68D9hYwsx0letJYj1Ts5aeC660/X15HFGWDqoffbg/calFT2NH1MOb1EhOovVS3Hmqzmh09gojBBzuHS+ASEU3/Z96GoRkhyVUv+OsTz1PQQPTSbKxzvI4c6dflBN/TQ8SVcqB09DegMgXnX22FMHgYwMUI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729093474; c=relaxed/simple;
	bh=smUyEFpDvHhbHIz7L6+8Yqg97+CnKsqn7wSVTZ4/vgc=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=huDb302ZC9hut/eKDuBGbUOoG417ykpF+KI6WrvIsE4yc0Fflc0N8nTqkhzO+E21W9h8q5rjQkfzzIc88eZ0k7GE0Ecj+NId5XdwnMkN4GH14Vn9xqtmjgHWnLzF6UblxV9Ho8NTrgdP3SdaZXn+NbkmRh8XjGifUH716zadryo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=H3jAQDNJ; arc=fail smtp.client-ip=52.101.44.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YwhtF7AKF+kd0X64Uu8+u9VyYuH1pyY0T/00AWswr3ejBIUjy7AVVewHsQK4AxbODnrPghXRbztzuPvejLIObJQPjNku4jt1EdvZw63pYzUm8UjueapSGGCdoMjnBO3FRFUdKicR84WULRHM0rqmUr2ohr4VkYlB8XrzgtlmwXCYYkUJiKtNgtxyt8EJbrUIYI+azfeAHaGD7MhyNhmn77WZKQjaoyWQ1pqGXXpuwTGWcXVens2IIw4Xo3X4AgTzTMaGjKtQOA2rY5xsCx6MGxsNqPzVNb/EkC3iWCm4xTi6biYpdFvSH6mCbEdKm+CFYEuSNtkQTvIyr5OLdJgDhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pv9flViILqejI/SYMFN/ZQlQcYMTAXXvlrC8QcCAnHw=;
 b=hcJTOkMlhXuhrNGVDEitjoEggOsv0Uvf5yHugl6jIJGDQZFv0HNCkf8qESHKQD+qVGy1QvNmNrRvUWu9wdjlr2D8cUc4zQnc6FwLcObmH2k/OT7IEab/vKr+2KOtrVuYj4nnzqJUgGRwuxHVQSbA3Nq0pkYG7qSTWD0ayCDM2zvHAJ2IMnpsKFvkstXfwoLDu3qeP7PEGwuSt35JWHYtDqk/yZUQyp0QaRuK39uqzdnOgA8hCqP1QtEBMhZLc00sn3PfNuZmbjyLviwkmrH3cur9WReEaVm02DRVuwc1IHk+gAQ20gYyvoiQ3ZZHPJh1pKgp2sUaS5hDZW71ACoq9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pv9flViILqejI/SYMFN/ZQlQcYMTAXXvlrC8QcCAnHw=;
 b=H3jAQDNJYh5l94tZR4vDlio5AhLbb/T9MYz9piQZitxyzrliMflRfKTX0YSOOJ/a4RjaMmrzAEuNpJ/C/ZdmTvHoAdk1i/6ufDKJEQ4/Iq34vGTy9n8+Tri0ithML3ElJYLFrh5pn3/ejzKNyGBT/JE0nGFvPFbpgmWfaEaUqsc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
Received: from BY5PR21MB1443.namprd21.prod.outlook.com (2603:10b6:a03:21f::18)
 by BY5PR21MB1396.namprd21.prod.outlook.com (2603:10b6:a03:23d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.7; Wed, 16 Oct
 2024 15:44:30 +0000
Received: from BY5PR21MB1443.namprd21.prod.outlook.com
 ([fe80::2c5a:1a34:2c8d:48ef]) by BY5PR21MB1443.namprd21.prod.outlook.com
 ([fe80::2c5a:1a34:2c8d:48ef%7]) with mapi id 15.20.8093.000; Wed, 16 Oct 2024
 15:44:30 +0000
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
Subject: [PATCH net,v2] hv_netvsc: Fix VF namespace also in synthetic NIC NETDEV_REGISTER event
Date: Wed, 16 Oct 2024 08:43:57 -0700
Message-Id: <1729093437-28674-1-git-send-email-haiyangz@microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0273.namprd03.prod.outlook.com
 (2603:10b6:303:b5::8) To BY5PR21MB1443.namprd21.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: BY5PR21MB1443:EE_|BY5PR21MB1396:EE_
X-MS-Office365-Filtering-Correlation-Id: a34dae16-3214-4934-eeb1-08dcedf96c48
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|52116014|376014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WjsFlY2TsKRlZ0aUtND57/cAPUqr3Ih4s1tFkgtLRo+NauPi56q4ZFWu3g1g?=
 =?us-ascii?Q?tIvA/ne3msaAV7yFC4bfMbHb7dG8VWyN+BK9rM65N3oeKxIhVUUE4GCJa0px?=
 =?us-ascii?Q?DJ02mwjMY+tnRvhxX/0ogGsdXtYzDk60zno38CIsbFRUU77zUizWoph2HQwT?=
 =?us-ascii?Q?hwhd63YgrwqxbNiHc4wgC2BzQbR9itIxeoLTZ2oVpPqwksQ7bmHt0XmgYxbQ?=
 =?us-ascii?Q?CotVg6wUOZeqADMoryZtritu+5plhLiwHKqP2v1dKDI5kop3ucnNRdTruj0o?=
 =?us-ascii?Q?4DjDUV+kCP1VMx1UsoXcYRsS/IanOBz1CEgJhcZSp6D0bzXSQW4AbwEbM6jt?=
 =?us-ascii?Q?7RX4mzCGVzhg3D88Ofa49Msiw/iDq6M5XgLCoK3/SA4gNsUOW2c4ay/x6j/j?=
 =?us-ascii?Q?vkKPCiRRaaxjXy+hi5LAcnPmfk47WOe8MyFzeYkLtsq66JXFzZYAqqUecaRA?=
 =?us-ascii?Q?tGYNVBU7YkGL27WfCcvYq1HAeP8SpbshDoMaC/j6EkEaHSK2QIG4SJmZbZs+?=
 =?us-ascii?Q?omuoFSPloX7/Ubjj/w937vhkKPNuUNm4Ja5mCFu4uHDCGqRTuAT5nCNyS8dO?=
 =?us-ascii?Q?qqfc4MkpoHZiXH0TWmZm4IJ6eRkPzp4jUA6zeEZSpnN81lweH2kQXlJ8Ko+0?=
 =?us-ascii?Q?I8csjGbL1kwVeY+qQDZXiAk1a9jwrZyT/hnI66aJOUdxf5N2GvL8u5YSgrcB?=
 =?us-ascii?Q?WnEIM78dF9eYEzTaeIV608jJuiSt2MSQkgc72wPWmhP28L30atl9lJX9lNG4?=
 =?us-ascii?Q?kkiC6+cmCRitOg4FPVRWA+Ko7lh+SENZktUKsIFYYAcCaKKodNjrwD12LNxD?=
 =?us-ascii?Q?kZPiDiLWm+giH769+nJOslRsSTa5JYRdbW44JqFpkCF/yRWShUgwWB5FNu2L?=
 =?us-ascii?Q?qamWDIsrKtPfelCTCdqJiOxFqjNywpctNLlt0sFTWCWB2Vp3ipX7SPf4enjt?=
 =?us-ascii?Q?CGg7mGkNmmsHO49IS89ZUHOSrJaXL8Me1p02x6c56tAe2CtMNCchDylWNDSc?=
 =?us-ascii?Q?OlKD8VlspLgDCE4bVTTtzx4jMgQSFoYPlBitIxjtFX/0qmuwWP5/KXIi1iiq?=
 =?us-ascii?Q?EkG4XpGLQ/MTTkT7Qz4ASwBYJM3n2zDQo+w6FQzQxsBCvEHvPxWFIUjFNi4h?=
 =?us-ascii?Q?9zBNvqO8YwOKUWTBDCaZ4/3jY0joy4wLOadI0P1bdfvchMOvuthxfF0eiH7z?=
 =?us-ascii?Q?fl837Mf3Bh7IZFLnM/52V9mNUK/dMJ0P3YrFaF5McdDzyabthKNJK/NEzSTS?=
 =?us-ascii?Q?ujgk1fInLvLkTKwwuiJbxiestWOga4GqqHqX1EZdN4rb9Ql/zeF6TrOU0YIo?=
 =?us-ascii?Q?rIhd9eQGqxDVxnOgj4HQohd29x90y1+bl2AQmMcDMwKNPg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR21MB1443.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(52116014)(376014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+D9WTWNxZYafXV/JwJy0cZg+u2NCOrpZWnKUjkdifr7hqRHYxnJy1AuB4Ysq?=
 =?us-ascii?Q?pkWtNOWhPdtnmJiGPoghaqB5Y2DvRmyc7otwxm8VA0d4Fp5Y/QrtFyu0nHyv?=
 =?us-ascii?Q?t88fMThg1dmOlRS4mKexoL9e8m58/tUMOIbTpwx9MZZigPXXsmc6I4kauc1A?=
 =?us-ascii?Q?UtheCvYM+r96aO45kMjXSOOJAZ0kK08Ey+kD4f32gcglqpkTakL96wKPOeh0?=
 =?us-ascii?Q?Zc7iwFunnpDTsVuvtNrEE1jyunDGZ7e2Ri0xBS2yv44VdgXzJqAGTTvt3OUv?=
 =?us-ascii?Q?ozk67kV0tF87K5Zw7n9J5D77HBwGTN70+7EWVPavPqLeBcdp0X/uOwPfbJJK?=
 =?us-ascii?Q?ZpI9ESRJ0hWVtyjH0W+d8IImVxH00MgnTcbDRcsIE7FpBd4W4uTTbRFmy3Dr?=
 =?us-ascii?Q?UmowVq8h8L+qe0C6/N1IOf+/NgMykqeNufLJrdU5SCseM5AeD/iAtJa1jW6u?=
 =?us-ascii?Q?myb5wQKS5D38+Phiy57fHZcnWuzfWJ7OWMUyX25QKut7nWY96urRlzr4M4a+?=
 =?us-ascii?Q?eArO51KOOhy5d53CU2yuvqXncnHuiYIUQWWqDMOPiYzfsyDkpwxK6cjHRGqw?=
 =?us-ascii?Q?cfQzh5g1sGaVa4v09+7zEvysgDycG5zlaKtXCv59IJlIMWiGgElM65HgNNUu?=
 =?us-ascii?Q?ZDAT4yde8wQ/G7J9mcZOfgGOpyHE6Qs19tTPIefftIrtLzp3Gb7/gFeMDK76?=
 =?us-ascii?Q?VEEm3NocbW9NcDXT8hx9DviL3t7BVaY60EQyBD4tvp18xVAbb2fNk3Egd0rp?=
 =?us-ascii?Q?QLGrUXPjGJ/OG52vZwRGdl7DVdzwiM547Di4HQcOYDPIycfUvaBRsYoXZSmF?=
 =?us-ascii?Q?NIvWZW8uAZUD+9Na9MePVcm8iC6RapjSA+07wiUPBdDOKWTo4L4bEhb1Sf+Z?=
 =?us-ascii?Q?7Tit0axWXG8BOlRUj8RRuA3gsDObIZOwNjV63zpgQ+Mi523Q+TeqMZhn/VSQ?=
 =?us-ascii?Q?va5ooHTi3W8g3om7BQrNPmvUJdRkF9iszqUFTFy2JXZIhVr+/+KfYzCTZtCm?=
 =?us-ascii?Q?U9dE6KW1qczE5W/Y5j4pRcjYMuwA8u6BA2WDozO5HDXMTYgCKmNA7Vn8qcCT?=
 =?us-ascii?Q?aM4pKPV6vLYXrkuFiodRkfDSfx770nISt4aYqjqDb+ObLY0FoZYn1jBrO2N5?=
 =?us-ascii?Q?P7HOxMbGnWK1VpDzO0Hu0Mfa6x5BdPqGDEKbwvCkmwn5/O1mVoZBS/lQ92qo?=
 =?us-ascii?Q?i9AVvjyDBvbeRInrmGZlGnaycoqTkCSCZejhMSPJ5HoWCZ2eozAeYdtb9uDu?=
 =?us-ascii?Q?Xyv85fdUy22qd7F5tqTjrcvnZq0vl1F23wthex/wbL789QCBT6skOevdz0pU?=
 =?us-ascii?Q?loM+2Zm/Tri7H0fxJK7fM8Lnq2JTHpuch6kv1tWwQDlT6STjU/hYR8xyHeHd?=
 =?us-ascii?Q?OCICYaVNcGASPYrP82tTMuzjtGbaHul9fmEFzglbM72yu9zRPxObkmP9JCYp?=
 =?us-ascii?Q?MKJzJ9oG3SgTVKVE5ILvzmDnaoxdnTrg5YYtnPjsYSM6a1q23ONkDZ1/RxRL?=
 =?us-ascii?Q?W3mJq5+K3lrzQKDYZ30QdlW9G1EoHx1hIa991oGVdie92MrjNVK1TB20/64T?=
 =?us-ascii?Q?HgXIonkC5C4853iNtwHG1SINaAnJ4Gn5SkhcvS26?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a34dae16-3214-4934-eeb1-08dcedf96c48
X-MS-Exchange-CrossTenant-AuthSource: BY5PR21MB1443.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2024 15:44:30.2479
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C5s/Mc6QYa3ZDd8GCNRC7BkUtqcRvuu0QLbgIrt0HiHGyUSqEJs0aKBSu2a723J6JGZHMxqyyL2y0Nmm8H0CLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR21MB1396

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
---
v2: Move my fix to synthetic NIC's NETDEV_REGISTER event as suggested by Stephen.

---
 drivers/net/hyperv/netvsc_drv.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/drivers/net/hyperv/netvsc_drv.c b/drivers/net/hyperv/netvsc_drv.c
index 153b97f8ec0d..54e98356ee93 100644
--- a/drivers/net/hyperv/netvsc_drv.c
+++ b/drivers/net/hyperv/netvsc_drv.c
@@ -2798,6 +2798,30 @@ static struct  hv_driver netvsc_drv = {
 	},
 };
 
+/* Set VF's namespace same as the synthetic NIC */
+static void netvsc_event_set_vf_ns(struct net_device *ndev)
+{
+	struct net_device_context *ndev_ctx = netdev_priv(ndev);
+	struct net_device *vf_netdev = rtnl_dereference(ndev_ctx->vf_netdev);
+	int ret;
+
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
@@ -2810,6 +2834,11 @@ static int netvsc_netdev_event(struct notifier_block *this,
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


