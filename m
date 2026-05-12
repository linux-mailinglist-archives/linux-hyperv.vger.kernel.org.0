Return-Path: <linux-hyperv+bounces-10769-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aHWNMOtvAmqZswEAu9opvQ
	(envelope-from <linux-hyperv+bounces-10769-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 12 May 2026 02:10:19 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E457517C4A
	for <lists+linux-hyperv@lfdr.de>; Tue, 12 May 2026 02:10:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B268A3033D39
	for <lists+linux-hyperv@lfdr.de>; Tue, 12 May 2026 00:09:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81AB416A956;
	Tue, 12 May 2026 00:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jn6+qrmb"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012070.outbound.protection.outlook.com [52.101.48.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 218D515E5BB;
	Tue, 12 May 2026 00:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778544595; cv=fail; b=NeScwkgS4zI7ijbMIkhPnUUmj28UwMmNiTQM/MCafOBSbNSjJHJwafSzzgNsjZJxYY8PqmH70KfkKmFVIWNKOquJWpn2iMqEkYWvQ5twzNn2U78JO8xSD6msNiH/aUoubHlE5b5OOTznOqtc3FC1qPoRvJTed5hM18Ckc+wapjA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778544595; c=relaxed/simple;
	bh=JOPmDwBzKvTICHIpjHUWCYaQt6Qasx9dliVclKos/0U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ebhaLTt1K0b/liSs3uk5NZC83HyjnCjW9OxwJS+TzRM4b3Je4HGZgKZS5KRF7eXHSY8zKZtAQE7csFT2psFZO4AC7Cs5cNNYAALvZoRWU6QI4BKLItnQ2oMIttSw1YaV4H/othGoOXIPy3Fzot4Y/GSiD/yNlZdfXDXYprdhitQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jn6+qrmb; arc=fail smtp.client-ip=52.101.48.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MCFaMT+SM/TfvIZlITL8IMPW+MpHNm601NKCEvxzNGQGqwJq2aOz42UcoZKJpYu2cyN/9B8aNRdupEIXnahPej8PAAl30i52vLFWluxTF1VZ4bT0Cp5VadTIsNYjiSAZf2n84tDWQ4rnw4fFWMTX11oiFrwK3eMRh/krDVwG5KgDRrsa7IPn1/M1/G7Z4O4GOs6G97vEh3ysbfBVSNcJkw2I5CxNp+wW8tx0tWvm1DCEynmGX1NZ5+yYfvyU3YcmATh9a4l2sQyZwqmrNhE3BMJzi2v6GXD8T9j7+RQ3bpzICrZylECicVaqLxNXtJt54At/5nGeZkr+mgrdUlz5Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JqYDwQgD0XqbzmsCzcs4P0cOSOTcM1QPPSnNwmer2UQ=;
 b=ye5vrbzQ5wySr44/91bdfkphOQSRuDJCmY3ofT0G50kTX5NVXoVUdy6CVsK41RKBtFK8pFurHqOyVo7fKK1ZnF8XmQ2lGedb/OlUTuGMxqxd4kWNOdOqhGdIeANKL/ay5j4LhZMoew6MzAI0MvAfJz7ZaKqiDcWbOUZucr338dHJvJMIKMPGZXRib1QoLeWpUMueSR9L0I1GDVXExnnnxxNu4hW4E1Ahk7UoFZea1PLVtUY539vzOT5+NjBgC0sQDAngxp8Z4CLNc9N15ukiL6dp5MQc4UVSfu1yDqxeKT8qndBf4hAhJPiQEWrmBqO+Jp2pDp1njOOf734l/jNaGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JqYDwQgD0XqbzmsCzcs4P0cOSOTcM1QPPSnNwmer2UQ=;
 b=jn6+qrmb+us0XyS5U/jRrX16taw8zN/gXq7D7CsXZolFNBcALggdmaMQ1R59jwmOK0GfRxP46yfhmRHQwtrYzYsI0QIrhtA62RRaRFK9bOo6gEh0MVED9SQiJ9EzoknXyeX19KIWP4hJY7SFe6qtMdHxJDxiw9nljfr4hz/jTFHOQZg71l7PQa55S+ooy9J3kOTztT9igchJA5nbEmg6fR2DOnMzIhZ8hvgU5JKjdVyeasHQlkgmG87BoV7Wl94Bpcmp0JKkEZmwuXa4Ir7VTlJI8BMXMVubfnw53ODFq/QPevsJFjLK5kBiUTZVgl7UUKt9P8FaV/rMsVfPYqIFDw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by CY1PR12MB9698.namprd12.prod.outlook.com (2603:10b6:930:107::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Tue, 12 May
 2026 00:09:45 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9891.021; Tue, 12 May 2026
 00:09:45 +0000
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
Subject: [PATCH v3 02/10] IB/rdmavt: Don't abuse udata and ib_respond_udata()
Date: Mon, 11 May 2026 21:09:31 -0300
Message-ID: <2-v3-4effdebad75a+e1-rdma_udata_rep_jgg@nvidia.com>
In-Reply-To: <0-v3-4effdebad75a+e1-rdma_udata_rep_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT1PR01CA0100.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2c::9) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|CY1PR12MB9698:EE_
X-MS-Office365-Filtering-Correlation-Id: bf72a54c-6c6f-4d17-503c-08deafbac4a9
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|921020|22082099003|56012099003|18002099003|11063799003;
X-Microsoft-Antispam-Message-Info:
	AmKsLgFIBOnZd8Ulkf0ypsDIwr1bNQu/iicIZZDINDTDPOECgR2WwKy0bdleqcNgyamJdHRj0jduvbjmanbiHIUv5PSo6iBX/2/e/ksPDMc9B4dQxdTUm3CLuUwtLWOikIcvioplyDmUblOhzCJUGEiFh/fo54GKhsbxzRf1wkHG9pda4JCKCJbx55SrwEHg+jRxZb0SIJpHquRXjys181/SMiD5sDL3BBxP834AQGt+EdHKdXzwPGAYniKaoEJ3F7A0b4JuxFE534Sx1MzlbC56FjSOrBmm4yyYqgr34mR7eBP2C4kUj8IsO/3AMcNumSwb7Mo1Qmw7rhpaj3/Cll2VGzQTWq4aiUzyo5OaExtvv3vAWBg8jz6pQEqefo3ua2I+cL2CuReEoOSPYv8dI6uSZVNCYcfcCwPjcHGmE2ns+qB/FD9Ek5GlNM6L773BESQBnTPeq9d0U5Rrs0aza2sDs9bPxjtQEKyBHhedZQvs8sRHfj9lzjxDd67Rc+1Q4aLIbYAreD6OanboIIB1QwiksqzmkLF38i5MsX4m9eJab921CwP1uS1mOhiObJGOsfatxlaIAXsN3UVUJtbaSC3N6rkyZYCwh0EFIdfQXB+8Fa+ZH0rea3aA2YByRHQsUgHgTdclp8h5Bt473GB99D9YTNS2/h7spEekVtTfjq3gUD3lqnJhUm2c0q4x8BaumCD1OvRPndFbpp254II6ni2F60oiIOvJd6qsoxbcqps=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(921020)(22082099003)(56012099003)(18002099003)(11063799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5b4GKsp6x5g3jltjqXZrZtm+Xi7sMCNbcvuVPtDfPSph7yJuKExoXc4JOzG0?=
 =?us-ascii?Q?D9FmwwIaLv04xRZMs+gej75pTfJhfQ8XrDAUsnbSmH1tJixKJMgTk0eQgfXh?=
 =?us-ascii?Q?p0bv2vTyXJVSIa1zgJX7DoOENQYTs8+a6FqxvG/I3UlTS6PQ3yohmolO5TDF?=
 =?us-ascii?Q?+BZKhnETcdD4lohfnrc07OR8btzCJfs9jtu1XnhOiB85/9iZa6XgDy3bkCnG?=
 =?us-ascii?Q?cZmSZYHWRM8u418s28apOpKuBzTUlVqFJDyTvYPDD+ByNVIVtJdzzosnpKdh?=
 =?us-ascii?Q?VVHpDvR/PK72V5Ls8/zkZw2a0GCuOfax0ZCnFMZIqCJA6fL9AFmPVufmul5e?=
 =?us-ascii?Q?mxYBBa0R3gCoV1zkKAqhkDW8jzbvTPlfKdNWT+68T8aLNR0LMAQX2Sze/62r?=
 =?us-ascii?Q?bmDSdflSlkDt3zC6IJpKqh5N+V36+dxXgwHxrlm6Et6jiDSiUeF7EnTIANjF?=
 =?us-ascii?Q?oywtbH+cgOByCcE4/Zgnl9UMHhVgmZ8dh0WwaH9p7i0wqh/LFqT7SqQzk04w?=
 =?us-ascii?Q?InnOlhbtbNzskNEp4R/aqLJRBlbyFwjyETVL3osqTPXoVGvVfTMa2C5VODBQ?=
 =?us-ascii?Q?nFMtG04PWDPntSZa0elzHtaJHVw/0bywWU+3O19UVp7obGcd5a8SHCWZYSi+?=
 =?us-ascii?Q?CZaK70Jqam5cO45/Ns/zo5m9d7RzlCqFfZAMVu9NPNMcaR7FNTm8oXw3aU9a?=
 =?us-ascii?Q?1k/6YKVsZ11DNt/bJYAlbTi++y0e2yTh/fgVFHMb+uwkmyDECi+Y6gR5Kw6d?=
 =?us-ascii?Q?iV+tEUhhCBMM2isBChjMs3AxIsZlL28fsFNG13g0JohwFShmfDFK7LfATKhJ?=
 =?us-ascii?Q?5AgREs/F1S9r4tyqPckRtELI6/Au3jdY8eQBjNUse/MJviQ0l0DoXQk7djmA?=
 =?us-ascii?Q?8xh5Px6CqDnnJRjIdO2O+LZLEqfDIW0g5k2jjHa3IHnOrlo/rZDkxd3qdZY8?=
 =?us-ascii?Q?N6XlEbCKjyLDmBg/I0iy99Kk6FJfU8qRlDTHXtRMn+75wldBMrVqMNjlihHH?=
 =?us-ascii?Q?RlZg0lhZoTJqRhT47IpNh/qOKLqXHghpaJhNQfLQ/lE7bQLrrPCUQq15/ln0?=
 =?us-ascii?Q?t/rgrbkLdntoLTtjXHNKaC9sc8284dq1KsYrGg8tQ/QIvJZ38BMe55/6hjmD?=
 =?us-ascii?Q?lVhZHkwfbRVHtBh+KTBbqAYFEjLLY+KcadJo/PlCu2XziLscO5kf2gwETlcC?=
 =?us-ascii?Q?eLi1Fw4vQe17ex8i9ZtRSft4ww6he6f3O4Yilgdvaode8wyvneaCl09n+sqQ?=
 =?us-ascii?Q?JOuMlwi3WLoX+4wUvir9rcP63vnxc+MYBbMR91PbCVLgOw9JUEen1sj+5QMT?=
 =?us-ascii?Q?PV7waXqOAP8oNcv5WmiRU2yypcz5pg4AgEBldV9vwFNXFR+vcuxnFRyCtZoa?=
 =?us-ascii?Q?P+YWP1utHVY2NEXUivOe3HHs/cNn+xJNtTgVDp8BDNY8TVtGDk95edVYRg0h?=
 =?us-ascii?Q?CZ0sW6HhV92+ugU2GxT8OGiuBjmXsAYWcoIbSuyFu2rWZZkRox396tXsLhCH?=
 =?us-ascii?Q?tTvXPnIXPntfe6OJ5h6Q2Xuvh1SmPjj1xmuASLb3ECw+yE5zpbwq00QjORCJ?=
 =?us-ascii?Q?hVdZ+IGIsw4uIgjo6plfWQ6CPL37vDpkHvkxiSghh1PSsaipxumxoEMeZV/T?=
 =?us-ascii?Q?dJZo5PxKiBK9bW6LGndo4tnWO4UeuaJaWeDRkrQzVzlLSrlO9xFnV5DoD6xG?=
 =?us-ascii?Q?/PX2rj2jo7BCU29YOM4v5nVkvNhtO4jT1PdMqRNQwoD1/pku?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf72a54c-6c6f-4d17-503c-08deafbac4a9
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2026 00:09:43.3567
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JFTmd+xF3RlNkv2IH34o58oiKEEzMDPrOAypuGB2EbdObpKfUKDQi/26xgSA6mjX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB9698
X-Rspamd-Queue-Id: 5E457517C4A
X-Rspamd-Server: lfdr
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
	TAGGED_FROM(0.00)[bounces-10769-lists,linux-hyperv=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[29];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@nvidia.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-hyperv];
	NEURAL_HAM(-0.00)[-0.999];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,nvidia.com:mid,Nvidia.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Use copy_to_user() directly since the data is not being placed in the
udata response memory.

It is unclear why this is trying to do two copies, but leave it alone.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/infiniband/sw/rdmavt/srq.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/drivers/infiniband/sw/rdmavt/srq.c b/drivers/infiniband/sw/rdmavt/srq.c
index fe125bf85b2726..d022aa56c5bfd5 100644
--- a/drivers/infiniband/sw/rdmavt/srq.c
+++ b/drivers/infiniband/sw/rdmavt/srq.c
@@ -128,6 +128,7 @@ int rvt_modify_srq(struct ib_srq *ibsrq, struct ib_srq_attr *attr,
 	struct rvt_srq *srq = ibsrq_to_rvtsrq(ibsrq);
 	struct rvt_dev_info *dev = ib_to_rvt(ibsrq->device);
 	struct rvt_rq tmp_rq = {};
+	__u64 offset_addr;
 	int ret = 0;
 
 	if (attr_mask & IB_SRQ_MAX_WR) {
@@ -149,19 +150,17 @@ int rvt_modify_srq(struct ib_srq *ibsrq, struct ib_srq_attr *attr,
 			return -ENOMEM;
 		/* Check that we can write the offset to mmap. */
 		if (udata && udata->inlen >= sizeof(__u64)) {
-			__u64 offset_addr;
 			__u64 offset = 0;
 
 			ret = ib_copy_from_udata(&offset_addr, udata,
 						 sizeof(offset_addr));
 			if (ret)
 				goto bail_free;
-			udata->outbuf = (void __user *)
-					(unsigned long)offset_addr;
-			ret = ib_copy_to_udata(udata, &offset,
-					       sizeof(offset));
-			if (ret)
+			if (copy_to_user(u64_to_user_ptr(offset_addr), &offset,
+					 sizeof(offset))) {
+				ret = -EFAULT;
 				goto bail_free;
+			}
 		}
 
 		spin_lock_irq(&srq->rq.kwq->c_lock);
@@ -236,10 +235,10 @@ int rvt_modify_srq(struct ib_srq *ibsrq, struct ib_srq_attr *attr,
 			 * See rvt_mmap() for details.
 			 */
 			if (udata && udata->inlen >= sizeof(__u64)) {
-				ret = ib_copy_to_udata(udata, &ip->offset,
-						       sizeof(ip->offset));
-				if (ret)
-					return ret;
+				if (copy_to_user(u64_to_user_ptr(offset_addr),
+						 &ip->offset,
+						 sizeof(ip->offset)))
+					return -EFAULT;
 			}
 
 			/*
-- 
2.43.0


