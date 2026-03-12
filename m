Return-Path: <linux-hyperv+bounces-9333-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eJ0aFvAHsmkCIAAAu9opvQ
	(envelope-from <linux-hyperv+bounces-9333-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 12 Mar 2026 01:25:20 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CB6CF26BA19
	for <lists+linux-hyperv@lfdr.de>; Thu, 12 Mar 2026 01:25:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B2445312243D
	for <lists+linux-hyperv@lfdr.de>; Thu, 12 Mar 2026 00:24:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F12E833291F;
	Thu, 12 Mar 2026 00:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="S3MxvToc"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012061.outbound.protection.outlook.com [40.107.200.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD6B032E75A;
	Thu, 12 Mar 2026 00:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773275078; cv=fail; b=e6dUm44HjA7tp37ad2s1/5FsewZdoy9ssQ0TtNhvdeISXXT6hOP9xyainoH+XGOwQOnrxXFsTb4cB6fOKTM7yPZrEzClvNssrRBNMmfm/E3LpgT6yh6dZSjNPOO15BVFQi0LOb6HZe0pI5Fdjj1U9s7kTtbuMbrXj8bdiK7RjT4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773275078; c=relaxed/simple;
	bh=8iQyxCmRamagS2NWQTvuOUDrPgqzSef4MZqg1QJ0l1o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UFSnfuaLKmtQ3xi/KPqtYr9ebp/+4wgJbYBGWts3e+gUQI+HHg9TcY7ri57d2/VH5zc7xm6F0mgMnLLS3px/3s/Pbtnt3kKtydb9p6ZADgE5rSqLBWb5J8p+3lUS+wtgVNpNmq49WwF5Ndx4jSltHtrW00saPCV0FEAnasAQY5M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=S3MxvToc; arc=fail smtp.client-ip=40.107.200.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bK+/0mqq3cV8GkHEatTWzdvgbiIEhv7NlT1EBWJh4RZoqYp9xtRIsrsVjsRy/Q/CoSbnVEGZfG90p2tZvpQ9S8CH8/Ux5euOrlMdLBnae21mx1h4DAS12cbas90oUDBJ+UKBaASBsotXkd1nLRpM632Z5QqXORtr5FWHAJt10ewjSlN+2XpwXCeWZlotlUbc1XnseXYRmhiOW0fL+TXKDpjXuaCHUFdvYBk7hGuF+jbifNTbc0VdWIhm9bb9AlsOVqxmYD/XDOXlzKQ6ZqLEZfJnCjTz8IIbSWzm8AaKhebSL4XRHlkRfQdbDkuWefnbg0XxD/nBttsauncExHARQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H99G2nTMPk6KccseglfqYCDDLYODMuMMV20hXWtrjGw=;
 b=vVg91/WsLxqz6HwKMm/DObIsNnALcPeN8hFO73XPr4iCUpZ6ooFH9s7Dk/lAIhOXXlF9y5rNhLZJd26j80YZptWGlUiVmwTS1j/9QJ56tzzE0F69hwMOheKAkqaohhQS1iFmK7TPfEVkip36LM6uuYqR8mRbMXHA+jUDsYYsLRCW1z4hRV8bTcBm5zk/51xe2ZkXPNUsXPI9XBUQyn4tTBcP9pd0sTBI9PXgeeNAehoO0DoKjBSfQh2XKiOp4vYuQ8J6kzcpDXzyJfDWZDgHbgeYAKkSD5BuqU2BOGeRXISp4ulljMRqhyyoygZO+/iIPUMRWzc5HffduQc5rZVsug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H99G2nTMPk6KccseglfqYCDDLYODMuMMV20hXWtrjGw=;
 b=S3MxvTocw4mWNXCL9X+gx93UAYXJhLoLzuuLwoOANIHVDRymqnrZAOodJP/4TnPMBh/+72LrVfngD0gzEkaraCSqZL0xcjBdErgneJikaeTFMb9LpnIzka5U0iUVOBb3Wxk+zaNzT6vt7r11X28ujUhVGXwH3tNGA7VgMv+AeXl9kqVUYuyNvfTo8j4pWINDlc+W9nJN9hP7tI2ReuIMHHZXjKhoG4wv3gUkib8kI6PAYTjGsK5zVoZWrQ6lc06VHb1XXTfP9foKdRts7fOr23TtVmayT6l4Q0okuyzZccj+j2Zsr6CnwdtCZLiZ2XeYFgLjN+yEO1Lcs9mvvaafMQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by DS7PR12MB9550.namprd12.prod.outlook.com (2603:10b6:8:24e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Thu, 12 Mar
 2026 00:24:26 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9654.022; Thu, 12 Mar 2026
 00:24:26 +0000
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
	Yishai Hadas <yishaih@nvidia.com>,
	Zhu Yanjun <zyjzyj2000@gmail.com>
Cc: patches@lists.linux.dev
Subject: [PATCH 08/16] RDMA/mlx4: Use ib_copy_validate_udata_in() for QP
Date: Wed, 11 Mar 2026 21:24:15 -0300
Message-ID: <8-v1-2b86f54cda42+7d-rdma_udata_req_jgg@nvidia.com>
In-Reply-To: <0-v1-2b86f54cda42+7d-rdma_udata_req_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN0PR03CA0005.namprd03.prod.outlook.com
 (2603:10b6:208:52f::12) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|DS7PR12MB9550:EE_
X-MS-Office365-Filtering-Correlation-Id: cd3b373c-b19a-4ea6-ac99-08de7fcdb705
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|921020|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	wiONcwUp4Z6Fbe3RZm3xQEAkFM5rixH5Sd2WcDdPL+sxaaU37MefLA3os9sIJdklOAeNJJtE/uEzGFSDYYLvFsS0tzt2ZMUrMnMYJmeRRek0dhlHLMkrQOJiwym8U2BK1iw/rBF2jbYg4BlCpqkwa4OBa4Pcb+EOrB5Y9ImmNovMDc1qv5ymRcFGoK+AFzlC624GPZM4aCEE0q6dUOinRWh7VC5YCxciLYZHi03dmgOYIAo9/SAj2CMtGKfr3tibNGpIi2uulM0DuPdHSbuMeu7IHP94hMg+/XbevZ9WLYHEmONJgeZym4BU27w83ClqjcXXVFJxOD6HVflSZy3p1Z0weEAYwuQrZSN+NXJsOpA/OjCPC3hur6DaJj6S6IpGcOD7as7h+NcRYuGIcoFFvN36lxd5RG+jk14aIMNdj+VZ8rl9LZVl0E45+vzHq8UUnRK+ouFV/GfNb8bBRGuf+amCl9jLXfcZuw4t8gnxY32r3XqVSBS6HIHvorkvYCVbmxvrelKz2RcURCbA4AsVsNE8zvpjiYr520pmhVSKFRSFFNiC4VNPu7DF3dprxq11XIVl8L/dxT4MY1YycTX1CnRmjrnuJbzQvbHGkvVl5yLyfMUnKDlE5PDwhoIR4PZjuMm0aYbczLBRvcmHz48aVoKK3F5e1K7uGe2IX6TYBLVdjNOaYZq2bOSBInMxbEk6Gw1RN7Q+BdqhvQJAA7M3b51cv4ZVXxPeObIKMaftN8rrtotIw7zjsnR1f0t0F//8ZpeATOo1k90Wr7IleddyCg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(921020)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zGkcEINsIgJ3IwV8FUmkKGNacE3os6n8wFGyIm0mv3zoMDI+Zf7VS87iw+Cm?=
 =?us-ascii?Q?RXo0ruGvOfwJLZt4XRdz6bI9IvWFvIjdHFHXi7l5EOKvj7dsJ6Le7t/pqu6g?=
 =?us-ascii?Q?yGuyn/S7rFZO3aKvP1p6dQEu14bgJq/4Gb/h1l7GuHAZBq8Ubkaqq5VU5KYB?=
 =?us-ascii?Q?UUglmSHhcVvIv5xFWdlyq4tLhL1yfeyEFWhtX+qA5dLXbBZi0Cc1WnsFTPQG?=
 =?us-ascii?Q?WPYrx9x4ZNg1OjKB7Ab7Lkj5Lb6gR3/T8s8FgEFTlk6NJBnRsMTPi4q+jWEf?=
 =?us-ascii?Q?v5/k0sswA33mR6zwG7AZYifdA9SdsUPE9qX2/Sz32qifeEcT8phTJwpxBoXj?=
 =?us-ascii?Q?a28a5pPXoWEHBYBY4nIRmW95sm5OgrAnLptgPrseOi8V/3GQrPuFOPLNlYOD?=
 =?us-ascii?Q?/URBhuNFEO51VnoA6LwSQcVqFPtuK0VCF3CKs/7tZhpeRDeQNLWd7nVnQJJS?=
 =?us-ascii?Q?NPiZZ9xfmKllZlcXz6khiWW6zpdnU/8TpScyaswdIbGNvlJnjbPi5HMAeeC2?=
 =?us-ascii?Q?abhalUArw3wwVsPDBrLwtJICZHXmyfKc63eRBMOIPfnltsjKNhbTLgUobBms?=
 =?us-ascii?Q?W/hiSv9bLz9tufXPgaX44E+1+zgLeZ/4YHCf5HjAbJcWPsFvGI5pS9NXtUVf?=
 =?us-ascii?Q?OkKb7QjipCEoEjUerxbFUsSzDFlkblAKkJHH9IHF7YmSHW6+8rSAuLHeIML1?=
 =?us-ascii?Q?WCxyCmgEOJNhs5QSFaR/HVIxtM+KRfdkNYlbh/+7XcbdQ+YyrDZre6HPyqq7?=
 =?us-ascii?Q?rRX/Na0OOA8mXkCglGcKcDJTnYpvKnOtpiwq5gwaVUIiX5aoPlE47BA2dSQ1?=
 =?us-ascii?Q?BCFnfjTF3tJsFnkXe2p7+wWOnxvi8S2Wy+U15eHLmHsuPAatQJ6FX/gouH6O?=
 =?us-ascii?Q?qlTa6Gy/KEJPsOUOO4HuQ7kHz+TV3g3mDgA7S2BaNwHzkiaZsvVg6Tyf0FV7?=
 =?us-ascii?Q?HozzOW03HBI3JKJsm20MjKsOdG/bZTMBJwldcJYscZVUape7YZ14Rx9w6JOn?=
 =?us-ascii?Q?sqjOkDGIUN/BnSVr5wGMTuUz4Fcp1s8c+u+62frmOZy4KQ0GDl7G65TF4lKt?=
 =?us-ascii?Q?t5v7RH/C+pzatdYtYZ9+/oBh+KIEyW0a1x/z21TfvqXj4R4ErHUbICMtmZsZ?=
 =?us-ascii?Q?8ipoVMl5H5Mu+6I+h7kJQ76qq8XhKJPT5fXVzyQYktST4tCVlAPvV89AAldP?=
 =?us-ascii?Q?UVijeAgyHv9bo4guMbo5PU+GBYgNVdseRr2wbLZ0lNSp3j80Z6o5uEqJGNRS?=
 =?us-ascii?Q?qT/rpKtedtcbYMZ+x8rfHJ4FSim/TYUk+7C6KQkzgIYSEsUjfSdeTvto5dms?=
 =?us-ascii?Q?mDNiu8E5N1aIUhwOnsCPJefsiPCIqgunWUbecvFG9zM4/8+q2ZiVu8x7Okh+?=
 =?us-ascii?Q?4CXphk7tnyarq0BXairrlX6x0ylyVEP5/GBuqPXZ9RlCqGjDe2BISqP7B3ib?=
 =?us-ascii?Q?7EFXtToYoFXr1Jle/eo90qdCu1WkFhxonOSBn5AEnnd2gMl/kDqmnBFekdho?=
 =?us-ascii?Q?vKpMSd4CBjVyJseTkq6h0K15lJmA8oLDCPSEB5VVNq+/F7iOJU1XI43ggUDU?=
 =?us-ascii?Q?ZNJGkKPlbwyoauCugW/+szhpddAVFBYy1uqqZNFvyTPq4ClZWYIQWOgS9u+H?=
 =?us-ascii?Q?jBZ0uUghcjMPogiwKhZkipPdudI/LBOmeRdrwY/GfPW86/s39nT2rZ2Wv2aX?=
 =?us-ascii?Q?YsSu2SgIyhDENGxhiHy8pvutqCj6yBj/JCT4U8Lm6LTY40aKce0WU2ffZrw2?=
 =?us-ascii?Q?bueljnL1Sw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd3b373c-b19a-4ea6-ac99-08de7fcdb705
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2026 00:24:25.0902
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oAjBvey708jFAjVDG/Tpj/7mDHuBIJI3RDHEiJI7nlEEIC0eIzsNmKvl52pu0p54
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB9550
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
	TAGGED_FROM(0.00)[bounces-9333-lists,linux-hyperv=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:email,nvidia.com:mid]
X-Rspamd-Queue-Id: CB6CF26BA19
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


