Return-Path: <linux-hyperv+bounces-9331-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kGHiEtMHsmkCIAAAu9opvQ
	(envelope-from <linux-hyperv+bounces-9331-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 12 Mar 2026 01:24:51 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E739726B9BC
	for <lists+linux-hyperv@lfdr.de>; Thu, 12 Mar 2026 01:24:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EE3FC30D5455
	for <lists+linux-hyperv@lfdr.de>; Thu, 12 Mar 2026 00:24:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FF4132D0F5;
	Thu, 12 Mar 2026 00:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YPlj35uC"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011002.outbound.protection.outlook.com [52.101.52.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1469E330305;
	Thu, 12 Mar 2026 00:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773275075; cv=fail; b=FTRUXFOIl0DYGNkeObkkO1o+us4wkJjYpujgqBw1W2isZ1WeaAo9PjXxY+pZ0t/4E7FlTKRaPtqti1CaDkS6r4nEJnKUnR7mlAIVCk6TXoz+oaBllt0Uxn8Bg5/l5uoFn/mEZV++iGYobR29ZGR9IkuiUxA/aPEqTlRNFY60GrE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773275075; c=relaxed/simple;
	bh=ekd4YUgSRgui09PbuFF7KTBkUUTSgYhttTjDZeNFjSo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=P4uPq4KYNbrZNeU7iHvCYfKwxPC9HJrNnvaC1Ob52OV40J4UhEWMr5hYvkTGor9gpMcV21NqbeaoEyUbTFS4HXCOQ8gfTBrMMH0rjGox1GvOUnlLA+2UolofcvpOq6S/10/mfXiYBbqV/LfuI49/JHvSbDKXLPmuBrCQlIAPozU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YPlj35uC; arc=fail smtp.client-ip=52.101.52.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ch6XPPzRoO9i1SBczWlV5wg7yk6zz4CcKIowd5XjSOfgn3tlJKETwPkfQx7sQRMBlDkaJctcLF9E68EHrtWEvf44/HrNfGrwXG2J2c+jsuTU0hmjdDUtRu/cosoML+tEcOhR0V4iORbRGEJYH9atlLcWCdAxq+OMrYydXeIyvB83Ov/QbIGDwln8RA7dcrcLbI2JuNOy/hjHHufqeKGVoFW0UTK7IDr7QWRByKoHLcy9PF/1ICF9Das9/e40HkHVFhW1/qcAaO4+igd73WJA59mhCAnAu/xnBqkfcoVNa/67NskWDXQdmS13gKoC1F/+Iu1VYFipnLlPNNz8QZYX4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WUgzlickPbmMybzeiICP6StY4aeOBp591OxPQIr85H0=;
 b=HBIJjRpY/ykT0uEdE1OaeAqTvaWyeCy5DacopdiyrCPqa+lMKqbHuHeRX/PZiZ3/m/vN+FGhGbtdxdIImnBzfLqzu5/svR2rSpSxp/CNs+sPjt2c4QcmsHm9yY5mbMZiPZcZEgU0jdDnGUunSYgR/zVa10Yr4LyUU4Z4XlXWUMpsZ2mMBgq/CVS68W8r+FeSP8+UDvqX1ltXDNQRfDYx/eixnuv2qWJB1sG8G/j+Ati6L+MEeIu2jT1EWC6YdbJRqQpQrgD/LeyYLgA/upZAkdh9tc+oHtc0EYgo2z8ybetLdTx4sWLMRfYVWq3gaIsjfL3gPiEm+53I3zXoZ0QT5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WUgzlickPbmMybzeiICP6StY4aeOBp591OxPQIr85H0=;
 b=YPlj35uCo9zlurVk50iG0h85qnlrUuC+tw7am3jBb3XeXK3LeIPrs0Qr5R6hBl7uE/ChWdBe5BDUi1At7poNgI8XZ6wLCFdbgeO41qFWKAncGEYB+TDsmudS6uZDD/teRbVobhxXC5h3ikc0j8gnLgDoe9repknHHhmY0pjfeK2gPm7290o7lJWNxNopy9VBAGj8yPet1U11vRT/Ik9hS+YGivjOYr/DY2lz+NtFKQ/jtlnr5NMG8gH9cEeXr2x1TUz+LlIylQpK5+Mva3lpazmo09g8yWnp2nNOTZan+xfYLriUkqEq6vQRvn95tTH6q3M9gmjPC3cPqPunqFYm4Q==
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
Subject: [PATCH 03/16] RDMA: Consolidate patterns with sizeof() to ib_copy_validate_udata_in()
Date: Wed, 11 Mar 2026 21:24:10 -0300
Message-ID: <3-v1-2b86f54cda42+7d-rdma_udata_req_jgg@nvidia.com>
In-Reply-To: <0-v1-2b86f54cda42+7d-rdma_udata_req_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BLAPR05CA0044.namprd05.prod.outlook.com
 (2603:10b6:208:335::27) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|DS7PR12MB9550:EE_
X-MS-Office365-Filtering-Correlation-Id: a4caee3e-adad-4416-636f-08de7fcdb69b
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|921020|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	6wOYHgzU9DjXhWTfcWjBuubiIHggynPJgQxx1m0CPVSw0zsGH2OW81NW+Ukp0my26SGL2FyYXIPDbw2IemiKC4nVycfsPTY+/PiE9AeE8Fu0KQC6aRCtsVbPgd37C1/Ah125SoUtAMraOJMxRzTcWSu7pr2EtMt5R7wDHvx1OCDs0RC6WWCA06unzjMq1/U1xsyLVHAOAPfCx3Jng1p2bqfcO6CI0DUA/CL0bEzKyVKj62+htWMBrdFm08r9ClnfSk6st+8O2SWZaDt8ZQuy2GGUvu4TXkLporaNtAs+cv9jxs3P+/CZoTg+iFc6COmJnaXHwqgaahJNDQww58UrbndekNsOonFVXJYflXwBF3TbAB04Ttk5mPkLEPJZH4aOsskXVhYOQNxf9BcruBkvykbWCbM1LlUTEo7Q6WQ8IBpONP8FtDoxU/PQwu+kyQUyI3FkzxLDWJZ48LK2Wt7Z6CUjyIJfB696XTrNPCAjjEFX6tvmRXH4qoWStUL5CTlaUDNHvBdjZXTrbTi9K2NuSHyk3H6EtPVKsYx46gGCn/AnybYcyml4McXxN3zsmwRsgp89nFeOL2yvg8kr60y7FNtpoq+WNXCmXvrD6k0pHhAmoZLTZGxpfcb9i5sx5NYirHdxKrLWPhi/DMcLSZmy4vge5MalH0t48Qlk1psN6RlWw3DablMWWrpy0AI1ne502eExKE2tpXoaKNNjZlT4pJxJzSyGcrg3BB0tJhTR+t8u9Da9kO1YhmBA8LC/4TTYfszXq7SiC3b0N7flknOnHA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(921020)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nTsJkc0WR7NWCF1W9mDR+p/2Mw3+Q7c29MfZZr4DOCJ9GY87jsUVsa3hPlHL?=
 =?us-ascii?Q?ZNiaCNIJmRNXP4rUdfi6VizTa4dmtoVp2aERgcIVqj5WeQjN3N/GmC4OwdZS?=
 =?us-ascii?Q?dvq2jjmK0eEMudu2u4SqIosv2AL13mGlEmyA/cfe3zFbmE770Cu+biif8SPS?=
 =?us-ascii?Q?SCYYj6vY5PibZqho8u18VtkRtMmzEFojV/8+2mh51Jrt8EVOpbCjrBv6UavK?=
 =?us-ascii?Q?28RsQmzY4vPKqHmCCdnTaLkIDhUd1vmck2YRsv4Ow89pT3Z8+jn0JsmUmFDn?=
 =?us-ascii?Q?h4Rf8ONYDdONO0KX5g6AwwVbjztIXnvfuaJ5xEnH9k6peYGWn27QI4FPhCuw?=
 =?us-ascii?Q?PwMNbf9ln/qNQwlOlBDgOe0l4+Gkk2lZfUsnitxVNAzlrPGWrky0VDnDtMC4?=
 =?us-ascii?Q?ECfyeZbfc18sPuozWVGvKcCI2AhU/VS48NYzGhHEn+aAPU7jpKMcxdF7e1g0?=
 =?us-ascii?Q?/CpsSnN+eyris1iyNqFgHU/CfG9bm59Mh5j7ocVBHGxlnrEop5pnXzgwrEBE?=
 =?us-ascii?Q?+5ea/wq5fpYYftBNZu3b0GYeXAevzVrzcjl6ofxi3LIWgdLA4kPsDP29vlu4?=
 =?us-ascii?Q?tVs1hgDypvkwJC0GkI2UE64eZvXr6m9D5zUKMnAZq35DoxxWojrh7BHE7kDK?=
 =?us-ascii?Q?7aOcSvkje7ZNFuuAQBy5oYPRW8gWmjCohcoY2N7UPBxz7HXLzHqv3FVH3HVS?=
 =?us-ascii?Q?euOqtH+wW06wP4/mi6dD3F4zx6q7Uo/KKEC9bq86EaK6zatx1VKqZsVGYZEA?=
 =?us-ascii?Q?KhABR0t644GrV1Yq39RghmxpCSg7WuZLT6gco1roZyWXA00uRNLOjjhnrg3C?=
 =?us-ascii?Q?foDBVTkcPl1VxW0jjQcG1xK1xUkmQojSJt7lpocCJUJc3ZSzaugHzAP8Tq3z?=
 =?us-ascii?Q?6lw8c8J5QLojZ5BJue6FKMibTRo5w4oW0rorE10LBiBgGs66KOojUo07rcS1?=
 =?us-ascii?Q?FOqCO0mjO/jwOh77jUisWqwoLe+F+WlzIiQXy/aYRGrCTMdbh5AaM0MIKQRX?=
 =?us-ascii?Q?tqAqo5l+TQNd5gvN987sKNektKYchILC1Za0YzdwcDPRJzuwB//oaHR25c/M?=
 =?us-ascii?Q?FRXsdEUjN+vQN7sXIM0doQId8otKIMTG+9DkK72f/k3nerIyjSAyyy9gCu/7?=
 =?us-ascii?Q?lL+4ge87ho6OnxsJ4B50ARfyct5BbBN+moY71BaQHE2PD6OgE7QLBH8rWJc/?=
 =?us-ascii?Q?ZC64XCtej/V9R49Bcszs0xpZpmvufm7L2QPd4gwT95C94Ax8HknyjY67bb/J?=
 =?us-ascii?Q?r7TRoeuDSuPniQYkO+uU+ErutY/5olwq3fqgWlrX7FMIlp8bsJYa4a4MkTEJ?=
 =?us-ascii?Q?/QbE17EbSvER16hsx+w8K0sRdjcr9Hjizt5fP6xuP7uitHa4Zthl/1Jo2Rcx?=
 =?us-ascii?Q?Oc6C1I3KIcRS+ZF9jx3xO4Fs7w9lOFLp6YBaUsMUoUbaPFTi09msMORtecr4?=
 =?us-ascii?Q?gkLRlmEza15338pmuRCB6oIwF6zG5n5M6kLIYm28e8dwmtmUlJHH+BV05L8u?=
 =?us-ascii?Q?D/vlPaOMvW5XotGD2zRMbda+6rm4bZW9QvZZ3GhYgC4//zJZ4tAPfdyEZXWM?=
 =?us-ascii?Q?ep9/acSOhQe4Bhf9ElDC+GGMp6iqQq07tCf73dq9CBaqT0oup5XAgaNxVOPG?=
 =?us-ascii?Q?9YuXXg5h4QfvSHckwYza2nDtT6B9pZK5sqTtPPF91PUYfcziqQDf8hCUcbAm?=
 =?us-ascii?Q?hKsd+GYehAPajsh3vJPYsEgGrGFZHORc94JFB5d8+COWPBjzxEscHQ1BhbiD?=
 =?us-ascii?Q?xueQl1Fyiw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4caee3e-adad-4416-636f-08de7fcdb69b
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2026 00:24:24.5913
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KrTjiXycLz29N/1igYb4Eu1KE89VkOrZ87pb2HxtOgDgCqBWHapFRdLTl4//evAf
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
	TAGGED_FROM(0.00)[bounces-9331-lists,linux-hyperv=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,Nvidia.com:dkim,nvidia.com:email,nvidia.com:mid]
X-Rspamd-Queue-Id: E739726B9BC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Similar to the prior patch, these patterns are open coding an
offsetofend() using sizeof(), which targets the last member of the
current struct.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/infiniband/hw/mana/qp.c       | 27 +++++++++------------------
 drivers/infiniband/hw/mana/wq.c       | 10 ++--------
 drivers/infiniband/hw/mlx4/main.c     |  6 ++----
 drivers/infiniband/hw/mlx5/cq.c       |  2 +-
 drivers/infiniband/sw/rxe/rxe_verbs.c | 13 ++-----------
 drivers/infiniband/sw/siw/siw_verbs.c |  6 +-----
 6 files changed, 17 insertions(+), 47 deletions(-)

diff --git a/drivers/infiniband/hw/mana/qp.c b/drivers/infiniband/hw/mana/qp.c
index 82f84f7ad37a90..69c8d4f7a1f46b 100644
--- a/drivers/infiniband/hw/mana/qp.c
+++ b/drivers/infiniband/hw/mana/qp.c
@@ -111,16 +111,12 @@ static int mana_ib_create_qp_rss(struct ib_qp *ibqp, struct ib_pd *pd,
 	u32 port;
 	int ret;
 
-	if (!udata || udata->inlen < sizeof(ucmd))
+	if (!udata)
 		return -EINVAL;
 
-	ret = ib_copy_from_udata(&ucmd, udata, min(sizeof(ucmd), udata->inlen));
-	if (ret) {
-		ibdev_dbg(&mdev->ib_dev,
-			  "Failed copy from udata for create rss-qp, err %d\n",
-			  ret);
+	ret = ib_copy_validate_udata_in(udata, ucmd, port);
+	if (ret)
 		return ret;
-	}
 
 	if (attr->cap.max_recv_wr > mdev->adapter_caps.max_qp_wr) {
 		ibdev_dbg(&mdev->ib_dev,
@@ -282,15 +278,12 @@ static int mana_ib_create_qp_raw(struct ib_qp *ibqp, struct ib_pd *ibpd,
 	u32 port;
 	int err;
 
-	if (!mana_ucontext || udata->inlen < sizeof(ucmd))
+	if (!mana_ucontext)
 		return -EINVAL;
 
-	err = ib_copy_from_udata(&ucmd, udata, min(sizeof(ucmd), udata->inlen));
-	if (err) {
-		ibdev_dbg(&mdev->ib_dev,
-			  "Failed to copy from udata create qp-raw, %d\n", err);
+	err = ib_copy_validate_udata_in(udata, ucmd, port);
+	if (err)
 		return err;
-	}
 
 	if (attr->cap.max_send_wr > mdev->adapter_caps.max_qp_wr) {
 		ibdev_dbg(&mdev->ib_dev,
@@ -535,17 +528,15 @@ static int mana_ib_create_rc_qp(struct ib_qp *ibqp, struct ib_pd *ibpd,
 	u64 flags = 0;
 	u32 doorbell;
 
-	if (!udata || udata->inlen < sizeof(ucmd))
+	if (!udata)
 		return -EINVAL;
 
 	mana_ucontext = rdma_udata_to_drv_context(udata, struct mana_ib_ucontext, ibucontext);
 	doorbell = mana_ucontext->doorbell;
 	flags = MANA_RC_FLAG_NO_FMR;
-	err = ib_copy_from_udata(&ucmd, udata, min(sizeof(ucmd), udata->inlen));
-	if (err) {
-		ibdev_dbg(&mdev->ib_dev, "Failed to copy from udata, %d\n", err);
+	err = ib_copy_validate_udata_in(udata, ucmd, queue_size);
+	if (err)
 		return err;
-	}
 
 	for (i = 0, j = 0; i < MANA_RC_QUEUE_TYPE_MAX; ++i) {
 		/* skip FMR for user-level RC QPs */
diff --git a/drivers/infiniband/hw/mana/wq.c b/drivers/infiniband/hw/mana/wq.c
index 6206244f762e42..aceeea7f17b339 100644
--- a/drivers/infiniband/hw/mana/wq.c
+++ b/drivers/infiniband/hw/mana/wq.c
@@ -15,15 +15,9 @@ struct ib_wq *mana_ib_create_wq(struct ib_pd *pd,
 	struct mana_ib_wq *wq;
 	int err;
 
-	if (udata->inlen < sizeof(ucmd))
-		return ERR_PTR(-EINVAL);
-
-	err = ib_copy_from_udata(&ucmd, udata, min(sizeof(ucmd), udata->inlen));
-	if (err) {
-		ibdev_dbg(&mdev->ib_dev,
-			  "Failed to copy from udata for create wq, %d\n", err);
+	err = ib_copy_validate_udata_in(udata, ucmd, reserved);
+	if (err)
 		return ERR_PTR(err);
-	}
 
 	wq = kzalloc_obj(*wq);
 	if (!wq)
diff --git a/drivers/infiniband/hw/mlx4/main.c b/drivers/infiniband/hw/mlx4/main.c
index 73e17b4339eb60..16e4cffbd7a84d 100644
--- a/drivers/infiniband/hw/mlx4/main.c
+++ b/drivers/infiniband/hw/mlx4/main.c
@@ -50,6 +50,7 @@
 #include <rdma/ib_user_verbs.h>
 #include <rdma/ib_addr.h>
 #include <rdma/ib_cache.h>
+#include <rdma/uverbs_ioctl.h>
 
 #include <net/bonding.h>
 
@@ -445,10 +446,7 @@ static int mlx4_ib_query_device(struct ib_device *ibdev,
 	struct mlx4_clock_params clock_params;
 
 	if (uhw->inlen) {
-		if (uhw->inlen < sizeof(cmd))
-			return -EINVAL;
-
-		err = ib_copy_from_udata(&cmd, uhw, sizeof(cmd));
+		err = ib_copy_validate_udata_in(uhw, cmd, reserved);
 		if (err)
 			return err;
 
diff --git a/drivers/infiniband/hw/mlx5/cq.c b/drivers/infiniband/hw/mlx5/cq.c
index 643b3b7d387834..f5e75e51c6763f 100644
--- a/drivers/infiniband/hw/mlx5/cq.c
+++ b/drivers/infiniband/hw/mlx5/cq.c
@@ -1229,7 +1229,7 @@ static int resize_user(struct mlx5_ib_dev *dev, struct mlx5_ib_cq *cq,
 	struct ib_umem *umem;
 	int err;
 
-	err = ib_copy_from_udata(&ucmd, udata, sizeof(ucmd));
+	err = ib_copy_validate_udata_in(udata, ucmd, reserved1);
 	if (err)
 		return err;
 
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband/sw/rxe/rxe_verbs.c
index fe41362c51444c..c9fd40bfa09eb2 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.c
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
@@ -452,18 +452,9 @@ static int rxe_modify_srq(struct ib_srq *ibsrq, struct ib_srq_attr *attr,
 	int err;
 
 	if (udata) {
-		if (udata->inlen < sizeof(cmd)) {
-			err = -EINVAL;
-			rxe_dbg_srq(srq, "malformed udata\n");
+		err = ib_copy_validate_udata_in(udata, cmd, mmap_info_addr);
+		if (err)
 			goto err_out;
-		}
-
-		err = ib_copy_from_udata(&cmd, udata, sizeof(cmd));
-		if (err) {
-			err = -EFAULT;
-			rxe_dbg_srq(srq, "unable to read udata\n");
-			goto err_out;
-		}
 	}
 
 	err = rxe_srq_chk_attr(rxe, srq, attr, mask);
diff --git a/drivers/infiniband/sw/siw/siw_verbs.c b/drivers/infiniband/sw/siw/siw_verbs.c
index ef504db8f2b48b..1e1d262a4ae2db 100644
--- a/drivers/infiniband/sw/siw/siw_verbs.c
+++ b/drivers/infiniband/sw/siw/siw_verbs.c
@@ -1373,11 +1373,7 @@ struct ib_mr *siw_reg_user_mr(struct ib_pd *pd, u64 start, u64 len,
 		struct siw_uresp_reg_mr uresp = {};
 		struct siw_mem *mem = mr->mem;
 
-		if (udata->inlen < sizeof(ureq)) {
-			rv = -EINVAL;
-			goto err_out;
-		}
-		rv = ib_copy_from_udata(&ureq, udata, sizeof(ureq));
+		rv = ib_copy_validate_udata_in(udata, ureq, pad);
 		if (rv)
 			goto err_out;
 
-- 
2.43.0


