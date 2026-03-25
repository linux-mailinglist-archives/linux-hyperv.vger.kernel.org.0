Return-Path: <linux-hyperv+bounces-9792-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yDPfAdNTxGljyAQAu9opvQ
	(envelope-from <linux-hyperv+bounces-9792-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 25 Mar 2026 22:29:55 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 62F8332C79E
	for <lists+linux-hyperv@lfdr.de>; Wed, 25 Mar 2026 22:29:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1120D30935AC
	for <lists+linux-hyperv@lfdr.de>; Wed, 25 Mar 2026 21:27:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A1B539022C;
	Wed, 25 Mar 2026 21:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dp1a5ZID"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012068.outbound.protection.outlook.com [40.107.209.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50A8E39020C;
	Wed, 25 Mar 2026 21:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774474048; cv=fail; b=H1zLUMGQxrixH2PWjSHRx2mZrdi93g8Zb9POwA+yf9WNSgEzyWIAt/G0mGSABwBSnDyRXxukgeJwlgPnvNipcwZahuQ9+8DI1Oe28OObA7NnotqUSZEVTuYUW0dlKSyQlrqPHfFq6Uv+47uBSaoIZRPsb6bK6zYMP5eic0kyCew=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774474048; c=relaxed/simple;
	bh=8iQyxCmRamagS2NWQTvuOUDrPgqzSef4MZqg1QJ0l1o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nNx+2dS+T6M3PFcaC+RbfGHa5OV6pKQFYLNEyXsgsSFjj/VUNaz8kn2natpMtJEJUcC0Z7VMNjPHIPJX1CaAruVK37/gUAqyUnE6hhah5q8haglxzcNhSh4RjrGmKskpAXQ1cHMwbcKeFCTp965X5j5GGLbIqWn3gjYfm3VYPDU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=dp1a5ZID; arc=fail smtp.client-ip=40.107.209.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PMgEJpHdeX5jm2LRryivsYngH3isjrPWFYXbAEA+HRYpAGJDfLjwLWXQv9DntpkKiel0xISWc8wVVLx6OpLySIF+QWdkwwEkNnUE+j0jquFbjZC8OOHmFCr+qZwCESl0vimfC9Zrth8l8ELBSZWA4VAFJFuPEKq9MPVaDk0wqbJghL58cIpntc/GHo0Jhxs/iwlcPhYG20tb8xXx7YDBm8Tm5N8zS2DbeIE9k8zqcH9wqEpNrI+PocrriG7Ckf8evexX5TT6x4ngf/VfD4jku9WCUEAyMNNUCfiA9Vu4adnoCpyzMy7Yg363D1oUpdtQV+fgD6pJYKUrIvXzaHI8AQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H99G2nTMPk6KccseglfqYCDDLYODMuMMV20hXWtrjGw=;
 b=cDTrCOp4spRxb4JH2Aamhzh9Oew2uc6VFlvz4FADwKQLR1WUBk3kVIr9LhgOe83Ww02a9Su3Vv0zpfPPP4WAnYpTWtnz6uAFtXR/9Rz0Jl1GY+M6VcZVTc5iz+Wk58GCE0kUrXyqRhJD/6xvBUUNGUJAmdue6OBQRGmysCSc2cvGWoJQ4Hw2AsyX9YrkXPGz6YoTSJvwbyd4BRr3PaIDhRt1BS4ojZkJCfRIqnHcztVLxyMav4vrkhX7aamwmggUgb9ZlMpXKCCVugiWFv3F411BHWdoUSjFoi7CFCSFeaY9LPG/+jK3fnXNOQ/4DZMeod1fe9OlsCNB1OrDEeS5dA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H99G2nTMPk6KccseglfqYCDDLYODMuMMV20hXWtrjGw=;
 b=dp1a5ZID5JJhkz/neEfvwVpFZGDUfYFCdwiRlPeT2+bLdEqg6emfKeaOKZtofUogjb0jWF8N/WK5yd3WoiI7k2QEwIZ9HNxg1WpN57dpia8ihIu/yqw7rpS4IszJXwYzhvlwThjCZeLHKFZx0fQv+td3HUHQTC5oqYhi8NZo9rLXssFl/AUu5KP2tZghzU8uXogz4AbnmeTWRwIJP/uT0I6kLYJJBIUS1xZjaHiZxl4VtSmC7zs2h+kEkxDLHgHrzuvNepYdlMcc/SQpGjT9MmIihz8Mlxio1ZjDIrp+ma1pIw+2hQ38eg4Odos9nvDveyG5EbQqSEeZIu7H94eYZw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by MN2PR12MB4224.namprd12.prod.outlook.com (2603:10b6:208:1dd::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Wed, 25 Mar
 2026 21:27:10 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9745.019; Wed, 25 Mar 2026
 21:27:10 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: Abhijit Gangurde <abhijit.gangurde@amd.com>,
	Allen Hubbe <allen.hubbe@amd.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Bernard Metzler <bernard.metzler@linux.dev>,
	Bryan Tan <bryan-bt.tan@broadcom.com>,
	Cheng Xu <chengyou@linux.alibaba.com>,
	Gal Pressman <gal.pressman@linux.dev>,
	Junxian Huang <huangjunxian6@hisilicon.com>,
	Kai Shen <kaishen@linux.alibaba.com>,
	Konstantin Taranov <kotaranov@microsoft.com>,
	Krzysztof Czurylo <krzysztof.czurylo@intel.com>,
	Leon Romanovsky <leon@kernel.org>,
	linux-hyperv@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	Michal Kalderon <mkalderon@marvell.com>,
	Michael Margolin <mrgolin@amazon.com>,
	Nelson Escobar <neescoba@cisco.com>,
	Satish Kharat <satishkh@cisco.com>,
	Selvin Xavier <selvin.xavier@broadcom.com>,
	Yossi Leybovich <sleybo@amazon.com>,
	Chengchang Tang <tangchengchang@huawei.com>,
	Tatyana Nikolova <tatyana.e.nikolova@intel.com>,
	Vishnu Dasa <vishnu.dasa@broadcom.com>,
	Yishai Hadas <yishaih@nvidia.com>,
	Zhu Yanjun <zyjzyj2000@gmail.com>
Cc: Long Li <longli@microsoft.com>,
	patches@lists.linux.dev
Subject: [PATCH v2 09/16] RDMA/mlx4: Use ib_copy_validate_udata_in() for QP
Date: Wed, 25 Mar 2026 18:26:55 -0300
Message-ID: <9-v2-f4ac6f418bd6+12c5-rdma_udata_req_jgg@nvidia.com>
In-Reply-To: <0-v2-f4ac6f418bd6+12c5-rdma_udata_req_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0179.namprd13.prod.outlook.com
 (2603:10b6:208:2bd::34) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|MN2PR12MB4224:EE_
X-MS-Office365-Filtering-Correlation-Id: dcdd6e74-de40-42f1-eb88-08de8ab543f5
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|921020|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	m2COny0C2ud2Vo/rYaggB9sTTQoNeQKxJLsMRbJOaVwYnjJbqtcddy8tOipDVOblufsxHF4VjxqvoflCVMn2PQyv/zM9vC9HG2qBemaNirhvjV+1H2rVwXZTrp8HAR1P/MVR2gkgW+HRhVl5Tl5qf+Fx/IDv9knt2JF8wtPNRTD7B2J/wyp1GeMIbbG9nyCmkGNq0+01TVNFqhEuyzB1VR3JKfFfSnM5rshut+ud7fAay3j0u8TaPGl3G/0SC1lm/QyB9XIGHlQc6X19GXDMg92Vhd3v6AZKb11260rnNymnQkY7pa73b+qv49j3OdJh6U3PXo8MuZEfYo3dBsrWWzbW0xP79kj7Nr+LhHWquOv95wsY13cyfh+JhqEIBYlQeNauFmpcwq21DP7+tQWlXQciCk5+CrbA5XejIt+V+o9oL7vWeoSU1Eomjv4rW5ILViDOU9m61jkjobfafpj52NTe/c0k9qxRaBMWkzICYQn+cEt2ZYsgTVEELQDROv+WlucHxYbZr8jrVjrvAyfEOh4DbgaHK/sh1M1S3WLkeThXdcnpxy0IKUAgaKXzyv1hHC3lta0cT8/LqvjWvmqJbRXqrRKVNB9y66/Utm6vBO58UgogO19aR9yBnGACD1L/DgYpo/Bic/syr+HT2iFyYchpyVJDUHq0ckkfg/PwEF5kU5FhTO0dqY+Tf0/JGGvz8WBmJvuEZxqjFWWhaQmkyLccMyzcAranfOKV/GCF0XFGC9/FaLY44HfFpuh/aahEj4mrJwqezzKp00piYAyHeA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(921020)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PZ0Vx5h2CVTooez4xdch9TzYwMMyPHqsjEAsyho5IwbcWlvJFoVbRaOzflnk?=
 =?us-ascii?Q?lIPwVnpykV1YSZvBhZ96CKTitU4cXezUlPeoXLSushcT70HyUOSVi6vnbBju?=
 =?us-ascii?Q?qx9A5F5FzioeUJ0HANa3ayL4bI1OQfI+uceFM1Uu6HW5tskc70nWwj5SDJ7w?=
 =?us-ascii?Q?QW6iyc3+3KQ6y8yvOIq04xEnkHBiqVezwk8TGJGwBpD0ZWSkSxee7tDi3bPE?=
 =?us-ascii?Q?+f7dLFmv0QVuSCvrffPfpSdaFerorBHC3trx+d33fn5FqZCIUTQUB96oqSGv?=
 =?us-ascii?Q?4mxeNKXTa/JUCg6J+lWe3gynVESLQHgCYagaiGH1I2Gt4AkOhUV6iI8xuwPc?=
 =?us-ascii?Q?k7ybPfOxhxbVY0fVrGjg6jUhIhTQ9ovbUcfDjW70iHXVWPpZZv/afkCQxumu?=
 =?us-ascii?Q?Y2w3g23360zUlkpkKNvelGpS7uI33gB47axh+EsYwn8RfHPoPmPPmFoXh6K3?=
 =?us-ascii?Q?5BW0eh/8EJSUrrIdftQ1aKGO1pHO8dE+7XTFXemHhzmcbBmi83BVdEDqQN3m?=
 =?us-ascii?Q?sjPLcXD4mH/jyLofMh2ZD1KuRnKWk02tC478ah6C9IYkOWYCUILykcx4QT59?=
 =?us-ascii?Q?F+c8taaCj3iERvgObYohP6LivV2gLSr9jwCVzB4iUXB5rvcGJ00r3Cvd6lYJ?=
 =?us-ascii?Q?IxKskpFJBiSCWx9H7cTSGkNVmYTyh+4vove5PIuMSDrELZpoX4bm+Z77TD/Y?=
 =?us-ascii?Q?HCJfm7LF4nemCckDtTYUG/ax/J06Ds3AzfLn72x2CeXl9E444jAwQHqW9vuU?=
 =?us-ascii?Q?jBjgbyyrlVe4LomfM2eXO6e6u71Te22losks8fhsqCqO8I9R9yocXoGTADMm?=
 =?us-ascii?Q?kLxKGQYVzE3WjHXBfd8NJZIkps4dGNiXKCQiV7ia6dg6cXOJfj4dcwXPr9MM?=
 =?us-ascii?Q?4PsFpOAlflkZh5qYydTgGaPmrq9x0r6MbNIXB0ysu2szldK+brNHHSyTfxOL?=
 =?us-ascii?Q?xLAojwpJswlS1IWh/+kvDBBXHzhxZneH/pQ9PF6hNzstfYhv62XgshcJ+JyF?=
 =?us-ascii?Q?yH8TmPymKwyVBlxR+IYuKpz7UdZxPBuq3npTHAktBKlmKvc/xk0xqd2MGX86?=
 =?us-ascii?Q?QuVHizjXgYP+C0XNx/ijPXJD+4p36Ru5AFkS625uQhX8n9daok4VzLt9ARtV?=
 =?us-ascii?Q?AmAu+iQTSVSLqJi8f//yUtQHBv1d3vGAjU16+8v/YQy2G5UbF7/PADsl30bT?=
 =?us-ascii?Q?LJsgCss3JkdtMYM174ZxptGFslZ5NOVGO+tXIJjcgGyQCQYK5SrF82Aei4at?=
 =?us-ascii?Q?birz1rtI3HAo46Ir1XCZsPfoLB3ijWUT9BMFIAusy9f2lR8mE21WZ/o+0ur2?=
 =?us-ascii?Q?NPWovu3sdQ8cckDUCm4+qc/OXCUE5mkb9DBrCF+xbCJw+YGeSZw3spKz3616?=
 =?us-ascii?Q?pbziEX/1DHAmE5GiDIpxE9s6EeN8L4YYdn5Ct1TTUmWkrIQ45gRlPwjVW1te?=
 =?us-ascii?Q?n28YDAZKqGYACa72tzVK22aYi/5VaNsAL5GV8luUnuITrYFGisojZQFpSqWU?=
 =?us-ascii?Q?BZ1FAZET+FX59S3FSz3zfKar5sqzmwqQyBLMTcWkfQpZC2/awYtcqcDb7miy?=
 =?us-ascii?Q?08weqLSMBskdwjEv+2gXtHuiF4lqnUcmw/8aUP+sU9iQMHaVH5ghIVAOYwVt?=
 =?us-ascii?Q?iPAdu/Sgmq1cLtJfzR3COXbkLR0N3JkA7SP60xPfXXUN3rOgRpoNVHkFzruh?=
 =?us-ascii?Q?VRYQc/J5k4NW4a0fKMcVkmrpqLSfaEcYqdYNuXQquLYlHSaZ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dcdd6e74-de40-42f1-eb88-08de8ab543f5
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2026 21:27:06.9648
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: byAKFKaVzckybpQXbuiMAO6LyK+YHbLuehm76ugm4Wi2jh1792sihNcl4iduPCVh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4224
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9792-lists,linux-hyperv=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[27];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[amd.com,broadcom.com,linux.dev,linux.alibaba.com,hisilicon.com,microsoft.com,intel.com,kernel.org,vger.kernel.org,marvell.com,amazon.com,cisco.com,huawei.com,nvidia.com,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@nvidia.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-hyperv];
	NEURAL_HAM(-0.00)[-1.000];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,nvidia.com:email,nvidia.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 62F8332C79E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Move the validation of the udata to the same function that copies it.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/infiniband/hw/mlx4/qp.c | 25 +++----------------------
 1 file changed, 3 insertions(+), 22 deletions(-)

diff --git a/drivers/infiniband/hw/mlx4/qp.c b/drivers/infiniband/hw/mlx4/qp.c
index deb1b0306aa7a1..40ddd723d7b549 100644
--- a/drivers/infiniband/hw/mlx4/qp.c
+++ b/drivers/infiniband/hw/mlx4/qp.c
@@ -854,7 +854,6 @@ static int create_rq(struct ib_pd *pd, struct ib_qp_init_attr *init_attr,
 	unsigned long flags;
 	int range_size;
 	struct mlx4_ib_create_wq wq;
-	size_t copy_len;
 	int shift;
 	int n;
 
@@ -867,12 +866,9 @@ static int create_rq(struct ib_pd *pd, struct ib_qp_init_attr *init_attr,
 
 	qp->state = IB_QPS_RESET;
 
-	copy_len = min(sizeof(struct mlx4_ib_create_wq), udata->inlen);
-
-	if (ib_copy_from_udata(&wq, udata, copy_len)) {
-		err = -EFAULT;
+	err = ib_copy_validate_udata_in(udata, wq, comp_mask);
+	if (err)
 		goto err;
-	}
 
 	if (wq.comp_mask || wq.reserved[0] || wq.reserved[1] ||
 	    wq.reserved[2]) {
@@ -4112,26 +4108,11 @@ struct ib_wq *mlx4_ib_create_wq(struct ib_pd *pd,
 	struct mlx4_dev *dev = to_mdev(pd->device)->dev;
 	struct ib_qp_init_attr ib_qp_init_attr = {};
 	struct mlx4_ib_qp *qp;
-	struct mlx4_ib_create_wq ucmd;
-	int err, required_cmd_sz;
+	int err;
 
 	if (!udata)
 		return ERR_PTR(-EINVAL);
 
-	required_cmd_sz = offsetof(typeof(ucmd), comp_mask) +
-			  sizeof(ucmd.comp_mask);
-	if (udata->inlen < required_cmd_sz) {
-		pr_debug("invalid inlen\n");
-		return ERR_PTR(-EINVAL);
-	}
-
-	if (udata->inlen > sizeof(ucmd) &&
-	    !ib_is_udata_cleared(udata, sizeof(ucmd),
-				 udata->inlen - sizeof(ucmd))) {
-		pr_debug("inlen is not supported\n");
-		return ERR_PTR(-EOPNOTSUPP);
-	}
-
 	if (udata->outlen)
 		return ERR_PTR(-EOPNOTSUPP);
 
-- 
2.43.0


