Return-Path: <linux-hyperv+bounces-10008-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WMlgAAmj02mMjwcAu9opvQ
	(envelope-from <linux-hyperv+bounces-10008-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Mon, 06 Apr 2026 14:11:53 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BFC03A3381
	for <lists+linux-hyperv@lfdr.de>; Mon, 06 Apr 2026 14:11:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7E531301953A
	for <lists+linux-hyperv@lfdr.de>; Mon,  6 Apr 2026 12:11:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1229A3358CA;
	Mon,  6 Apr 2026 12:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="CSpCY3Vt"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010022.outbound.protection.outlook.com [52.101.193.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B280E3358B9;
	Mon,  6 Apr 2026 12:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775477498; cv=fail; b=S7td6CJKJFed04nyBjGzgU3n9V9q3cICnbk1qqTJdUDbjlhX02IvNiioRO5ryNzzcvGPjzeMk2PzOS8aVnNAjAlnKqEYoNGBDSYGfa5XeO2IjpKgnHYYjLWVncRiLt2EU5PXtfqIos2wYWeTW+YBQjKtxaffjnhnAPQ5Q9NiWbk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775477498; c=relaxed/simple;
	bh=D8V7PQC2Dv2MiF4slqAmqEZ/pXg//vueQc+eVK5V5Kk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=baCxVlCLMVd82btp3CtfQqR61TH+rq1rDhBe6v7Oi3KZuHdnszRw8Jyc/1U4gRKENvoJhGE9vyEqWc4rMTXkMW81ExJfoXy0iVUnT2vYSE6DwsOFg3w8hIcWRjhQf6KmhwbGhdnOhTi6z3+QB5PYzY9dgRNcB3+DzV5Gla7DsfE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=CSpCY3Vt; arc=fail smtp.client-ip=52.101.193.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hOPUByorV/VPuTAp5eA4MKyj/HRhrKdaRhNnmpIPqWMQKmhU0rlvW1zZ8Df4Oc8zMyOy8PJE/uvCJqNDEzKUc8QqD+X07If8qJU3LVTF8/8DoRx+L8llVYfQdfGM/of1NYY08YnqAen1EflzdO48HPRkTH75cMdRA/CycrwQOa53gHTV+crAUWvp/oXdEe5UvBrTafI9zIm/q8+x7t4keSAhxzehHnsqN2q5Pr8Ukp96Zn5yw4+hEc77W274zJvnGA6OTGE/697KMiOURKUYNfi2YGufszWEnxiNSn/P29s+S9YdB9fUXyYSn2w+yhUR2Uz672+ZnXgXvJejW4OYmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zRafQsJ83M42Xfeez4qxS5AJ5HLd4zPNdrX10IOMnuE=;
 b=o56vSiOBUrRBlC4N7Fq1f7n8onsttjatTyryYINtbWoubeVcZv8U4Y1zBJdCI5tXXZrGEYbZ4WUuySj6IirgA3uJz1468VfncBrmzAShNWLHU337f8Y4fwn7DMpic8rhXsVA8WG6Sl+FhVbNs6XAgj+AcuPuVGeDNZNzQ1zVed6EsVYhrMhVA4jTcj7+Zf/Ml4KpC6ov5xSL5av4vJtPsdY8qKR4OmbXiVr4ufyxYDwxaZ5EvTo4q6+P6TFPj8bgLF5Mh6wCuIppsKsBy0Fib4LX7uv6Sp7t8JSkaYIL57l0Ta0l5LPwY5mApMqSTp97QJHLsG65FA6IJNpio60yZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zRafQsJ83M42Xfeez4qxS5AJ5HLd4zPNdrX10IOMnuE=;
 b=CSpCY3Vtp0m9RlOhKbFlwJOVWIOXErpbGlnM5/bz0/XAWsUT/8QHDbGW+MUeONzcUkkEIi4s7MjjT+dMYqmKTpeiHv/OfeO6y9DWauWISLYHSiQbl+MPsGmcy+Xc6ZJhUN2uRzDjvj7CwzNCeeaLOvyTtP6TnVuZfCWrYAs7dfzyN/uNttivNJ3gq/PyMzA7qa7v4jzj2EdEReXmXAqDrM5bARV6d5sEaav5gNEkg+Z29XUY/a3pTzksxEEUTlMvdjKx9s8wGBTlsr2QliS1qpEPrX1mRnIqOm6Q/edXYJ7UlayaXEi8ADgrUxCKEDAYqauu5hy0Ktjfua2WaPpCHw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by SJ0PR12MB5611.namprd12.prod.outlook.com (2603:10b6:a03:426::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Mon, 6 Apr
 2026 12:11:27 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9769.017; Mon, 6 Apr 2026
 12:11:27 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: Abhijit Gangurde <abhijit.gangurde@amd.com>,
	Allen Hubbe <allen.hubbe@amd.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Bernard Metzler <bernard.metzler@linux.dev>,
	Potnuri Bharat Teja <bharat@chelsio.com>,
	Bryan Tan <bryan-bt.tan@broadcom.com>,
	Cheng Xu <chengyou@linux.alibaba.com>,
	Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
	Gal Pressman <gal.pressman@linux.dev>,
	Junxian Huang <huangjunxian6@hisilicon.com>,
	Kai Shen <kaishen@linux.alibaba.com>,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
	Konstantin Taranov <kotaranov@microsoft.com>,
	Krzysztof Czurylo <krzysztof.czurylo@intel.com>,
	Leon Romanovsky <leon@kernel.org>,
	linux-hyperv@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	Long Li <longli@microsoft.com>,
	Michal Kalderon <mkalderon@marvell.com>,
	Michael Margolin <mrgolin@amazon.com>,
	Nelson Escobar <neescoba@cisco.com>,
	Satish Kharat <satishkh@cisco.com>,
	Selvin Xavier <selvin.xavier@broadcom.com>,
	Yossi Leybovich <sleybo@amazon.com>,
	Chengchang Tang <tangchengchang@huawei.com>,
	Tatyana Nikolova <tatyana.e.nikolova@intel.com>,
	Vishnu Dasa <vishnu.dasa@broadcom.com>,
	Yishai Hadas <yishaih@nvidia.com>
Cc: patches@lists.linux.dev
Subject: [PATCH 06/10] RDMA/qedr: Replace qedr_ib_copy_to_udata() with ib_respond_udata()
Date: Mon,  6 Apr 2026 09:11:20 -0300
Message-ID: <6-v1-e911b76a94d1+65d95-rdma_udata_rep_jgg@nvidia.com>
In-Reply-To: <0-v1-e911b76a94d1+65d95-rdma_udata_rep_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN0PR02CA0025.namprd02.prod.outlook.com
 (2603:10b6:208:530::17) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|SJ0PR12MB5611:EE_
X-MS-Office365-Filtering-Correlation-Id: 59b110ac-0144-4490-79de-08de93d59fe8
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|56012099003|22082099003|18002099003|921020;
X-Microsoft-Antispam-Message-Info:
	2AfNUrTqing/ajTDeZuUj4kGR40X0nNLoeY+d1UM85ExdYR9tT0E7LBVdzNNPHRyJQn+Tbt4xLnyebcCJHo1FpjR6pgLasfhIWXXTNxzifAZwmOQkXZfWFAzzH4obh4koK8lru9P79ghVE1TA+/CltpC5hyg6izUfx45fdbke42Dhbj/D6Zp/wGxvXKXoV6EpqAWVAwGBljt4Sbd0WZrVWxTp9NUanqLFhOP3RSZDRFlC69XJ1VO45nZfJ+py1Yz2PrBKx/hdzA3Z0f6x0cyeF2KlAXfsWypbo5uZmHg/BwYA7Hoqzbj8yMIXTkMVQFwQV64b7DyqR6MC3RwF4/+lqFIOUc1QtldaE4MpdUgMMgGOm/WMWND/uEtAUDvVgEEX7y5vkT6wAjwK1y+o/oBk6FyXMZBFGiMXVyZ/yCgepaIp8KluJ8FXPJ5hivul+kiXo/5Z5XacYXKqYKzyyDgRkDGvRsRAZYIGPaY65+PRLvh2VkdVRZN+tcQ+Q4epqBVuGjPAyPssFrYJ+E0SNEHaWp5vVFMygusRarID88R+rB8SvEoOOS1MRjxUmfqXJHXucOwU3d4g8Euf+OIZ3o0umFIhDgVA1WOJIPTlVsWvKqhC8GV8JaBdnlHFmjLmpG2ccDlIcUedCXO4PeMM166W4XuQvFBod5YdZqGymz8yX3svDBSwHIrrL964k+PHvJMN0cmi30k9ShDhkV014S9S/dfSsmyQNXamQaHvO+bIVyl4yI4vnoYgp4FbG7FO8t2VE+0WsLXLOQ7KLi4Fbj21A==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(56012099003)(22082099003)(18002099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tl2qgTdltxSENYev0nciwuYTKCk/RHeS2SZjTXzWbaExmhOwov7eH3mKP1em?=
 =?us-ascii?Q?TnGHhDlHDnp+gX1RTBF8IlXFENl/kF6naYIpJ3mupfzBwFdvrM0lXoqBQhQK?=
 =?us-ascii?Q?hnbr+zAS6Pebinvj3v2INzCLbxLyNFjSkwEcnphuCpWPdh3YcTVnTq2hRHGP?=
 =?us-ascii?Q?C20xDobXTf8bkdhFGbrruWT6L4UJKSelz5Bq6MylZoDGbUp+ijyiyymOZv2a?=
 =?us-ascii?Q?zpyKtwHHMmx6W4Z6ZELN7UJjh/r1/HTFQS5UT2gPZT04qE0hYaDZ5EfuczKt?=
 =?us-ascii?Q?RwqCA4o8KINlcMpLvuSfArgIRZkjHuoI6ha873GH930CG9P3E/j0RfJofIhu?=
 =?us-ascii?Q?9B3Fvy2zR4myykz6MWllR9zElumDv4UJaJqyVVicUgvOM4pWETtrhM+0KEfp?=
 =?us-ascii?Q?f1bVPPjw1KhPgKg2QZAHwRSZhBCS18ZYLzzJgDjPOnhllSJsPEIorYpHKroj?=
 =?us-ascii?Q?ZYRiAmdNxQblDEdpUArlFlRshhL9JT3fS8r4wUynj/CLHA0L6O8vJwgxZCaT?=
 =?us-ascii?Q?99ycYGXCZmR5Mg9PZhVldqCF8J8nL25RwVUvFCSYIrUNFZPYbld1SqEnBdNy?=
 =?us-ascii?Q?4cDgomRY4EZdBpb1cexdCyF+8CTAsAidyNIWYijJkWJ9fKuoYMDUYsUy7gNN?=
 =?us-ascii?Q?r01QOJlT1F/sB4Qsj3D3XCSSXIDe21+26+WcbRcbx+jLGsm+j/WSKddBMUt3?=
 =?us-ascii?Q?04g8eq6GR0oR3DGULvqqd15lqD0sjgsmhPHQTzScXKV5KrG4G0brISuLy9OC?=
 =?us-ascii?Q?SgfGNGLe8wgjCySysZtFCFFvYRQUv3n4zPYzktqhVlk5BJrq9sDkX4JWNyVr?=
 =?us-ascii?Q?3PstbEgi8Itt2MxIoYrL4H/9NAScWaKXpFTpsHgSzgzctfPPTvXOCOiKTcoa?=
 =?us-ascii?Q?UUn/QtEq5rt7kUwCPXUnvQRhl3w6L3vWP+Ac24chu2mrJYxSSkv2q+vHdUbA?=
 =?us-ascii?Q?XuK1T70bXKhCp71+21ndTcOOAK+V79VZrV91/eM4Ao9iGzyTAo8byzCvZtW0?=
 =?us-ascii?Q?7FoiAhyMWdtdrXjTwxGLLayAUvuvapf3c2UAyF3jyKooHpUUC5qMDdEuX7si?=
 =?us-ascii?Q?mWxNmBXkulmfT74mePN5kN94C2KFTptNM0Uf7qFx8MIVjAB9bF6B9f4bgKyp?=
 =?us-ascii?Q?XswldGVEsMLSgz3zrHkOktiSSNlLDUQ8DqL07/PhQFqONGDP54qJ7XZxDVbw?=
 =?us-ascii?Q?dfBwRG/adPDl8N52ilolWGIzj1c5CxQzpHhCiZZg7APzLrymiVnZJQv1kl2n?=
 =?us-ascii?Q?II0goKPboS7uN2Mz5c0Ay++Za9C0KAQfcSajiIIByWsh8efzXGXysP0K+x4m?=
 =?us-ascii?Q?hfwjrbX3ZpV4P3mc3kmQg7GhaznXRNWNKg02ZWehFGmWjheVbR7JHW9dfhV+?=
 =?us-ascii?Q?3IYq3AdIM2dbeKEC2VWNFKMMPKdJo8MhmP42D1DsnGS0n6qGsg+xb/3m7DV3?=
 =?us-ascii?Q?Mnj/CNnFhXNZ04wa/6+hHJyceE1NaLFJnubyQeRntQaJ2xXYe3o0RwQ0glV5?=
 =?us-ascii?Q?Lfe8bd46NrDH4aiL56L37EVYwdVdziWNlVJPh+Ih0ERLZIw0P1E0BQRVvq0m?=
 =?us-ascii?Q?FmABB37quOZwGZlNuBtkjNZEYbKa/Z1KvPK1TwL1mqz+ZvGGQiiPp8u87Tgc?=
 =?us-ascii?Q?q1byIfb6dJCxTtj3UIYD99jFueiluTtQoog1eoKlngtTohzCirFYtIeLIczL?=
 =?us-ascii?Q?mglIG30zmQIYQXcicviiEkqMI596rDd+5MF9TvyEx54y0CgC?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59b110ac-0144-4490-79de-08de93d59fe8
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2026 12:11:25.8301
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QZFJaayhqbzixrKuZcP6+MNayAiYg/IuV/dOZOHVlD3ny7mlEMyuf7oxyf5gxOLD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5611
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[29];
	TAGGED_FROM(0.00)[bounces-10008-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@nvidia.com,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-hyperv];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 5BFC03A3381
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This is another instance of the min() pattern.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/infiniband/hw/qedr/verbs.c | 30 ++++--------------------------
 1 file changed, 4 insertions(+), 26 deletions(-)

diff --git a/drivers/infiniband/hw/qedr/verbs.c b/drivers/infiniband/hw/qedr/verbs.c
index 3b86ea1cf88883..72ee57dc85687e 100644
--- a/drivers/infiniband/hw/qedr/verbs.c
+++ b/drivers/infiniband/hw/qedr/verbs.c
@@ -64,14 +64,6 @@ enum {
 	QEDR_USER_MMAP_PHYS_PAGE,
 };
 
-static inline int qedr_ib_copy_to_udata(struct ib_udata *udata, void *src,
-					size_t len)
-{
-	size_t min_len = min_t(size_t, len, udata->outlen);
-
-	return ib_copy_to_udata(udata, src, min_len);
-}
-
 int qedr_query_pkey(struct ib_device *ibdev, u32 port, u16 index, u16 *pkey)
 {
 	if (index >= QEDR_ROCE_PKEY_TABLE_LEN)
@@ -340,7 +332,7 @@ int qedr_alloc_ucontext(struct ib_ucontext *uctx, struct ib_udata *udata)
 	uresp.sges_per_srq_wr = dev->attr.max_srq_sge;
 	uresp.max_cqes = QEDR_MAX_CQES;
 
-	rc = qedr_ib_copy_to_udata(udata, &uresp, sizeof(uresp));
+	rc = ib_respond_udata(udata, uresp);
 	if (rc)
 		goto err;
 
@@ -459,9 +451,8 @@ int qedr_alloc_pd(struct ib_pd *ibpd, struct ib_udata *udata)
 		struct qedr_ucontext *context = rdma_udata_to_drv_context(
 			udata, struct qedr_ucontext, ibucontext);
 
-		rc = qedr_ib_copy_to_udata(udata, &uresp, sizeof(uresp));
+		rc = ib_respond_udata(udata, uresp);
 		if (rc) {
-			DP_ERR(dev, "copy error pd_id=0x%x.\n", pd_id);
 			dev->ops->rdma_dealloc_pd(dev->rdma_ctx, pd_id);
 			return rc;
 		}
@@ -701,7 +692,6 @@ static int qedr_copy_cq_uresp(struct qedr_dev *dev,
 			      u32 db_offset)
 {
 	struct qedr_create_cq_uresp uresp;
-	int rc;
 
 	memset(&uresp, 0, sizeof(uresp));
 
@@ -711,11 +701,7 @@ static int qedr_copy_cq_uresp(struct qedr_dev *dev,
 		uresp.db_rec_addr =
 			rdma_user_mmap_get_offset(cq->q.db_mmap_entry);
 
-	rc = qedr_ib_copy_to_udata(udata, &uresp, sizeof(uresp));
-	if (rc)
-		DP_ERR(dev, "copy error cqid=0x%x.\n", cq->icid);
-
-	return rc;
+	return ib_respond_udata(udata, uresp);
 }
 
 static void consume_cqe(struct qedr_cq *cq)
@@ -1298,8 +1284,6 @@ static int qedr_copy_qp_uresp(struct qedr_dev *dev,
 			      struct qedr_qp *qp, struct ib_udata *udata,
 			      struct qedr_create_qp_uresp *uresp)
 {
-	int rc;
-
 	memset(uresp, 0, sizeof(*uresp));
 
 	if (qedr_qp_has_sq(qp))
@@ -1311,13 +1295,7 @@ static int qedr_copy_qp_uresp(struct qedr_dev *dev,
 	uresp->atomic_supported = dev->atomic_cap != IB_ATOMIC_NONE;
 	uresp->qp_id = qp->qp_id;
 
-	rc = qedr_ib_copy_to_udata(udata, uresp, sizeof(*uresp));
-	if (rc)
-		DP_ERR(dev,
-		       "create qp: failed a copy to user space with qp icid=0x%x.\n",
-		       qp->icid);
-
-	return rc;
+	return ib_respond_udata(udata, *uresp);
 }
 
 static void qedr_reset_qp_hwq_info(struct qedr_qp_hwq_info *qph)
-- 
2.43.0


