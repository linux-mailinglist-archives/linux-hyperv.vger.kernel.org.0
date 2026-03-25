Return-Path: <linux-hyperv+bounces-9786-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IPPyHKVTxGljyAQAu9opvQ
	(envelope-from <linux-hyperv+bounces-9786-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 25 Mar 2026 22:29:09 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D716332C780
	for <lists+linux-hyperv@lfdr.de>; Wed, 25 Mar 2026 22:29:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9C7AA30715DF
	for <lists+linux-hyperv@lfdr.de>; Wed, 25 Mar 2026 21:27:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 110B738F95D;
	Wed, 25 Mar 2026 21:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="s4bwPXkc"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010066.outbound.protection.outlook.com [52.101.193.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CEB93909AC;
	Wed, 25 Mar 2026 21:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774474040; cv=fail; b=FY3dSIgkvAXAL+e9fuGvLgcrsshwB/bAA2nw7eRdyOVpQN2Qlp8CxHvR/zh7s79sTj3MGvlv+a4gTTA6udX+2Wf2Qg0yMu588iVyS8vsz7Ut9/Zz/wnY+0ppnqgZRQgaMMSWAfjOHcq2Kfcxo+Bh/X0l/3vuo5pmBM9y/mmCwvE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774474040; c=relaxed/simple;
	bh=4Ys3LHBfjvrdIE6IXfUMeUD3hXzt5T/+HChpe0/L1P4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nh3TU0A+C7/9TmFf5Lg9Lt7I960JQKcJI1tO9Rtsg1PSeOkYTKw1twXxkx0Xz8VqIbL9NhsprgefAufJnPEdtbqiiwZeXi3ma6wrCEwCT3VMVmWArqQu291FRJntgIHzvzI8NLTnQUNo3PkzEt5vQ0qjmD62CeMgWwFSCK9PuAg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=s4bwPXkc; arc=fail smtp.client-ip=52.101.193.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XJ9NbT+SSLsASY6JDzx3QSv1H/FzFo08ci0aCe+p7muBPL6ZVHcM5NWiIirAj1k1QSE/Y/5vxEM3L9rUYer4VqwEz+YTw263tdbFRGxpgDyXsfoUXTBnbw7egBs7u5mRFmBVCXRD5iyHkUd24JvJdgsCNRoYFu05G6zjAqiuuxEJ9vU+KYUhNaIrerb5+muRsLYjxOG/37tgdf6WdqIJNXSZMpNxPrmg7NfZZ4unPnFymZMKwXeBG0vZ7NKJxw94cVMDQHrRxVpyXCgRe7Pz5Td+wW8ZTptOTUB2SgNpvEvFShuu6UNE8myn/0KaXjURCYkVA4Wk9nGXF4ntbco9NQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9/eYpyT76X5Fm4J9jFv+CQVPWZbj5wWrMQL3BtYuAfw=;
 b=WnY4a2VH3zldK1n7ORdAoK36Vrz187izuGuG9c9KlfxNLuXTTQ9mbvv2qk6ZIEm6e23YEdt2z01sYsf80zm+bOgm/4PyCFtz8zy2AGwYkjzh1PETesFFxpyhMF8SmEdJms4MUWCtsiZ+/j6kmm/X3Dcb9N9DjW/e5B98QgoXjbMAdXVyM1Ne0or8i4sVQl0jDmEedhF1F3c7dO/JNRn3FRXqraFUeP8QeyivTN2kfmHdsiaDYvCeBh9IDAoTmoIHrJRHFpHhPogCY8Qy9P6aK9K9txVizveRuTS9UQgTw2wRTabCL5bP4Szti33bLjuQ4L22mhVQ5/tqRrv8uKgadg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9/eYpyT76X5Fm4J9jFv+CQVPWZbj5wWrMQL3BtYuAfw=;
 b=s4bwPXkcZaIZZVwi0PdnBdJAiTGdbnHRuhTM7nXI45R1pAhvB3skmbOdfIYg5oBRSMKpPmexBm9w0/Em5eE6mOqxdA4y5QR1MKwEPY/xL046RjYiQWgBjwjnIdby1ymxMybbyxe5+/hw8oh5MoBRWUMbykg6coDZZAj6XLVMjNS9LyeaDZ6IhnX/A/ywsY/Z1zZ/vvV2FP2m+sZV4s9VJx3Hdv3WiMHezuYuH2xzTJNz6GxoCig1/Zd9TUolZMtf2B1RMgqzLeXP6s3EJMJGDkf0abk41OZlSaoHNLdt0AGlJX05ZrnT4w+aF5T01KGiBl7ZZ58fYrYyKU59RT7BiQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by MN2PR12MB4224.namprd12.prod.outlook.com (2603:10b6:208:1dd::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Wed, 25 Mar
 2026 21:27:08 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9745.019; Wed, 25 Mar 2026
 21:27:08 +0000
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
Subject: [PATCH v2 13/16] RDMA/hns: Add missing comp_mask check in create_qp
Date: Wed, 25 Mar 2026 18:26:59 -0300
Message-ID: <13-v2-f4ac6f418bd6+12c5-rdma_udata_req_jgg@nvidia.com>
In-Reply-To: <0-v2-f4ac6f418bd6+12c5-rdma_udata_req_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BLAPR03CA0157.namprd03.prod.outlook.com
 (2603:10b6:208:32f::27) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|MN2PR12MB4224:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e6899b3-f3f4-43ca-2ada-08de8ab542e8
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|366016|921020|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
 pHqriqYuZbyLEK6W4maUgtsVI7D2TrlGEHtmtrF3AAhTJoCG5n3XXmaSJac5K9V1kfgWSefqGx7og1UmqO15lgrwiBuPr8Kgtrz79uwfert5tGS/2PpP8BEgeYfPsJMBoyFZCxr9dmQVvzEh75W5W03GCYo6zTmqTXBATarW5BHQWR2OeD5Xl81x2OKJOtVHjRbFTWKI2mAziJcBmQh8MKJr9qhktYhet8EzQHXnQGKFU3i4ZhDdMaJu9OB+Ta0jteMZm1kvd27THOt5JzXpMADjbWCjvD8fC5Kwxt5hVCLozrR6Hhqo5uMv4ZKD29NIjpwGk6Ua0hDoo8w25+iCl+Lrzp9+0huun3XEiaUN3hVXQMBUB2dpzvuLWS2avBqxcx8/Jlgmv7qBabb/R4OOF5rAB6eKHciPPXzPjoe2QNd832gJXeOrJ70EGamRXp/QJE7NRQULRvFz7esAQHxvydVhABP0uRmzMS/PR++ndOrSxOsfT70qt5y/MuuZA+4GU0WSRbzfCFV0XfcXqKkEBC2aR17psa9wbuRuUqE7KGpGaJFso2AkWZX1WxRDwjxkoQ58eGnJ1Ib8i0pT+J5C0SuZwvQuJpbCnmR40/g0SwMKNQIBc1A9oLNlzTj+T7975coD4SgzJwPsFaiUOhn1VNMSJhAev6jolfJl3qjnpATwFJSifNpjnaiknydNED8neMNVD+onLHHSczLaEPPKzQymtk/dMboIKFvb7oyrsztk/oY9yA8rpTFa0haIZeaPM4xZdaDCfCtkvY+ef+Df4A==
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(921020)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?di/furOc/hpBboX8Hmn4Kg7UnfJZI53xZ+Ff9Q25dI6JHRp1QDRvhcvtM3DR?=
 =?us-ascii?Q?EhGm+joS6KTW9orllNFxRaGqvw+wt2lZp/PPMqRpvN29STZDQ/tYAancvfcf?=
 =?us-ascii?Q?dcbXpF9lB1SPsvfFLu3IHyx1UzDMNysVBnVW3Dg0ZCAvxGZcjftSIX1iGMe4?=
 =?us-ascii?Q?yP8j263utgne685arpH9n+o4nej9MB3HPR+uVYrPVLNPG3eWr43H6U3xgu9z?=
 =?us-ascii?Q?DzlzEd/P0/4CzRhglYMhW5fDtfpcqrnLYibgdgT/IqBx9uU62gbS1+Bx3DFo?=
 =?us-ascii?Q?gq1XZzEYTxsCNuynvfP3D5egom+iMKNB+BpROSi1fnO8K5Fl0rt32RtVcIbw?=
 =?us-ascii?Q?nfKmjemiQsltpyLef5g/Hz8TD4aNQabQcNAJDEU6W1nKDRetoHzTvAPBMygY?=
 =?us-ascii?Q?DmaIPl68hFt2GKXTdv9krE7IGHrRl9tBBPGVGjIwu+Fl/AE/1elOJNCC/E/E?=
 =?us-ascii?Q?3BNu8bo0VPJEoX//losm8juUrmoOow5YGsq49EGecl6dW1mmPh0n2dCpGKpQ?=
 =?us-ascii?Q?4NlJvZUTPJj1RvpLwkyXF1LHLmkBzvgV0pl5BRZN5oVCueK73xxQOHoeKjqp?=
 =?us-ascii?Q?VHq2caydgODwczPoE+ABtU+TmrIlpL3zGWf849/VwahC4uodxaXokOh9ZFtv?=
 =?us-ascii?Q?w69I5mcEGNSJxZTOL8fedSTGww7Dg1PtD7G8tM8tVlsyPjT4TLv9kO7t146u?=
 =?us-ascii?Q?8luoWSEweRUhDzfvkhnHt+0VMf9pMWHpe+jyD0zFrMhQRUNEwPLgewyKvozX?=
 =?us-ascii?Q?xhdIsInPeSG9Mj7/yEqZcc34v4tETQbh4Fb7FP0fviFEaMQfjDk1req7yD7o?=
 =?us-ascii?Q?FTnY6CRPvL/6CWEg1FO38acTyF4A0qeFBXX7g6gbklo5rkwsomBduh43l7YU?=
 =?us-ascii?Q?weNAon2cAmcIC2COwgy9HFHbJGejz229fhKzUv/6DrPdireAfNoKEHa0InV7?=
 =?us-ascii?Q?ZVl05x5TxNm1LuPzmbO8gEV6HxsLAs5lVime5c5/9HTbuYWa70OdpxTtKm0b?=
 =?us-ascii?Q?/idIfd4vltXJ1KM0sW5iwBMlDEOs9YwsMz2lYBq/S78smcQTKOG7pm1QZqOR?=
 =?us-ascii?Q?TcMGMjxjKKsbOq6o/Q6FueW+qKt5BDNp1Q4ReFeI35AzNybu0HcSjg7wWU7L?=
 =?us-ascii?Q?1mkngZ+MgbRTXHIP0Gic+uskeptYWN91OzT2cUi9Qnhf/V9pO5XE37E1yr2Q?=
 =?us-ascii?Q?K0ztQzcNLx+anjZJAbGKxGs0X0UB9qNJP1G+lOwCcYzs8KZj/vD+iRBZHzxq?=
 =?us-ascii?Q?Whx7NNdkL/hu+/9ZScY1LFruLXT5YcJqaBwurq2CDBj1JCfUY0a12cetSvBI?=
 =?us-ascii?Q?WJsjXN+1lanrf/0Qvuk8yQ5xJKMvwSBxExt59h6tgOxdbbgxbanvnNgRwd50?=
 =?us-ascii?Q?VCcgeVEB8WGaGfP3/kQ769WMa5ikT246q9lMgOukJxXhJmI1XYAl2n6JWQfx?=
 =?us-ascii?Q?yvicDXDO5PKk8GFOMPUij/l0eVC6qBUvWIf2JE1z5Y9SbvcX9kgU/apT2uRB?=
 =?us-ascii?Q?Ggz7SmczsvhItABLbp1XZ+P9Fk2D5GAHJqhACGDxFjKKUSVfQhXq8G3ZCU3G?=
 =?us-ascii?Q?+YL7XSII1VgLxOD1apsqZ6EGSmLSSr2mwGkUWUn9utKRoxE3w3f1iNTsYgSg?=
 =?us-ascii?Q?SLeuw4seOlCZJQQ/Wez/fBl+/oVHUtBx2TcUsOMEWEACvYUqMBpT9sj5heD/?=
 =?us-ascii?Q?WCRaMqkLCHpSNi4qDXTPWJUkqoj43NgskbVhHtPpDHjHgh4h?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e6899b3-f3f4-43ca-2ada-08de8ab542e8
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2026 21:27:05.1384
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nKpoGggc8LdT5hRIboOwkBwvumafXDfOxqfP/BCEesUsrSPy8xkHZVEY7+8R1/LC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4224
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9786-lists,linux-hyperv=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,nvidia.com:email,nvidia.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D716332C780
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

hns has a comp_mask field that was never checked for validity, check
it.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/infiniband/hw/hns/hns_roce_qp.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_qp.c b/drivers/infiniband/hw/hns/hns_roce_qp.c
index 3d6eb22cbcd940..a27ea85bb06323 100644
--- a/drivers/infiniband/hw/hns/hns_roce_qp.c
+++ b/drivers/infiniband/hw/hns/hns_roce_qp.c
@@ -1130,7 +1130,9 @@ static int set_qp_param(struct hns_roce_dev *hr_dev, struct hns_roce_qp *hr_qp,
 	}
 
 	if (udata) {
-		ret = ib_copy_validate_udata_in(udata, *ucmd, reserved);
+		ret = ib_copy_validate_udata_in_cm(
+			udata, *ucmd, reserved,
+			HNS_ROCE_CREATE_QP_MASK_CONGEST_TYPE);
 		if (ret)
 			return ret;
 
-- 
2.43.0


