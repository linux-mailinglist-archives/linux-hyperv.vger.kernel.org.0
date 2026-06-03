Return-Path: <linux-hyperv+bounces-11469-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id IMIoHKdvIGrA3QAAu9opvQ
	(envelope-from <linux-hyperv+bounces-11469-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 03 Jun 2026 20:17:11 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F14F63A777
	for <lists+linux-hyperv@lfdr.de>; Wed, 03 Jun 2026 20:17:11 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b="Ui/YnjY5";
	spf=pass (mail.lfdr.de: domain of "linux-hyperv+bounces-11469-lists+linux-hyperv=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-hyperv+bounces-11469-lists+linux-hyperv=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D1492300D363
	for <lists+linux-hyperv@lfdr.de>; Wed,  3 Jun 2026 18:17:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D387B38944D;
	Wed,  3 Jun 2026 18:17:02 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010028.outbound.protection.outlook.com [52.101.56.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 714223E7BB6;
	Wed,  3 Jun 2026 18:16:58 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780510622; cv=fail; b=aP6AIJIkQoM0vYLuepHhXIYgEy8S25NzSxaMbs2IgAR8Iq5yPc1rj2YkMm0P/Cq/H2AfR6sW7dOBRldl1skd7NsREq7QHmL8qlIy6DjcYJhIlUlcCbK+iYmBP4B9X4ff4IFlS7cPJsTAbdq3ctH3xReF4BrS3/bFciZVOJtzDVY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780510622; c=relaxed/simple;
	bh=ijBLADMgOOXLecMBzVW9sKaDslkv5938+hzEBEZBaM0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=nzl51ugljb66mq70mRahCq7b9un+l55LkEHSimCBDxLCsG6wStPMlu1oEHn81UTUzdXWwDitRMJV5SvAy2MxVh1ZQvZPNuBl2S6yKIkOWpJLnoQhhPq8uO+QlWyXnxY4C9E7ypkQBw2HfaBIdqDc1STivju0/9/PRLGEXZASl3k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Ui/YnjY5; arc=fail smtp.client-ip=52.101.56.28
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X7I9tt+/n1ZQXXquJf0hG4qKyjkaJFQj8/VwGafz/E8hFzn6s/kXE8vcinntcWjXtWru8GP9Yqk+oEqW16fhLa4K3YgrZWlfmSK5lq2LjVcfIiPlEe1VVCRL5l0/XKxxgDK02SA/xtShSlkIu9P5+ZXAgkJkxRaf2iMT2oZ3Q7ldjZlfvhIoUPyrUdIMPTXG4NUSrURgFIefw7M4e93Gf93PBLTzACPbNZ3OmWngjU4Rpq6OIu9wjbGCIOnFrelDC6DuPy+c2SwY3CRO1DQ7hAiaaC1fTJDFbgJPM8B58zAn1ds6GJtpGAnufXU7Jf96mSFDUuXyqhLW80wF+nCxqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3ykSQ12H+LVCf/TWaSgyc7Rr5beSwg9oowSYL7bB250=;
 b=i7rQsP5zTGJ6txVmmT096rzzaTpMojVhQGz2Qy703n8I4kpp3qw7WtcCL7he724unFKKQmV+GrlRrF580L8wIzY3O4GXCNfF1DDgaNLWP4+D07Illw5Ym7MetX++Xf8usmOm2T3Xmb0bCmKTBKpsh0an8PrjT4kTJvsJqazcSuk5Z96MZ3IONfb+ZhzNClRawOCr32xCEvholsZQu/7C7ynUzRtzB/GRQqhGfeHZ0+Rf3fBCM2JD0g4DcJJT1zfD3w1ICEzaDvw/PCxSgV5HLvvdnZOMCyanGixn+fSXURh6PurXj3belcI+UmWTkKxrop4AoDVIdysm1f9D+UZYGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3ykSQ12H+LVCf/TWaSgyc7Rr5beSwg9oowSYL7bB250=;
 b=Ui/YnjY5+40blF9rd90NZYM6EMbxxMhMyN8PJyaRmu/ujB3MNQ+kDBQ+RQk64xi5JwycnGT61gUCb58IabXCLuabzBgzZ6z7U5VsOhVDeB4WeFKB8/3szsg0LwWHUOTWS1fz7gyJx6vQtNpAhSBPHlmWtbOrTQK6mVgRjlDuWOVEsRdgeGOn0TqrNwrXnvz8/fins3g7jViwcUtlPsn6h6nDvlMLgoS69Rj8hramP3X+jId1y4Fshd+wEUQA0xsPZcy2iAf0lM5Xq/FhmAOXhY/f+QrEXkrAWKvWq811QsDhQpYVqbDeoGoCXHSh2Vs+r/UYyWPWf0YgKUdafJyYhg==
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by SN7PR12MB8601.namprd12.prod.outlook.com (2603:10b6:806:26e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Wed, 3 Jun 2026
 18:16:53 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%4]) with mapi id 15.21.0092.006; Wed, 3 Jun 2026
 18:16:53 +0000
Date: Wed, 3 Jun 2026 15:16:52 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Abhijit Gangurde <abhijit.gangurde@amd.com>,
	Allen Hubbe <allen.hubbe@amd.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Bernard Metzler <bernard.metzler@linux.dev>,
	Potnuri Bharat Teja <bharat@chelsio.com>,
	Bryan Tan <bryan-bt.tan@broadcom.com>,
	Cheng Xu <chengyou@linux.alibaba.com>,
	Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
	Junxian Huang <huangjunxian6@hisilicon.com>,
	Kai Shen <kaishen@linux.alibaba.com>,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
	Konstantin Taranov <kotaranov@microsoft.com>,
	Krzysztof Czurylo <krzysztof.czurylo@intel.com>,
	Leon Romanovsky <leon@kernel.org>, linux-hyperv@vger.kernel.org,
	linux-rdma@vger.kernel.org, Long Li <longli@microsoft.com>,
	Michal Kalderon <mkalderon@marvell.com>,
	Nelson Escobar <neescoba@cisco.com>,
	Satish Kharat <satishkh@cisco.com>,
	Selvin Xavier <selvin.xavier@broadcom.com>,
	Chengchang Tang <tangchengchang@huawei.com>,
	Tatyana Nikolova <tatyana.e.nikolova@intel.com>,
	Vishnu Dasa <vishnu.dasa@broadcom.com>,
	Yishai Hadas <yishaih@nvidia.com>,
	Zhu Yanjun <zyjzyj2000@gmail.com>
Cc: Leon Romanovsky <leonro@nvidia.com>, patches@lists.linux.dev
Subject: Re: [PATCH 0/2] Remove stack ib_udata's
Message-ID: <20260603181652.GC1568873@nvidia.com>
References: <0-v1-922fa8e828ba+f7-ib_udata_stack_jgg@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0-v1-922fa8e828ba+f7-ib_udata_stack_jgg@nvidia.com>
X-ClientProxiedBy: BN9PR03CA0050.namprd03.prod.outlook.com
 (2603:10b6:408:fb::25) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|SN7PR12MB8601:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e376455-7a30-46bd-e944-08dec19c49f0
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|921020|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	eM8M0aNZbMlVN/6YdvRtY8/FHuaHSauLabINxtNCmBo/6CX4UbdIkvoddlZFkTKSqR1JFxMtliydjTA+etFmWYuNI8AObP/DVlrNCL8IicM5LxyAeZZ+7MeJcVBKE7LU57IMoT0OwAWC84yiOdamJcztuySHSBqBzb64oyQBEZhn18ewFF7HXPj+uEwbBjSoZfRiEftQaa4UinQaC5QfN3/o+JL3+nB9AiVXLpFgkIod87lfWCebLymg1VVqZf0+6+omLOXz60RhZpDn5VULaO3jyM3dOls2peHx3fIo2u0PpDTDTwo9U4xYikik4Noicjf7tnl7CG03yyw6PFotwmvMNsDWwTVTlPD+SVkUT2uJI1P9Eh6S7oM40sck3LUP+WHl773FWRBlwqyU7/MYro+LTYKKom+5HFE8zrDOTy17znT6XihZ2An9G5xkt3wTN5T2FrDCjf0hiIKmhNHym14OMpYVH/XpKKC1HZfJKlSt2L6YDQOC5SwYOJ8uPI8Lx0P6lGbpKQaHAb9+9tyfcxVZCHj4xkw+/1wfVFLreqf5NLq5uSktN7sFaRS5uO5npIg0kUCYfvcovN3YtfWcLEavKe9PbNXlzoMwTb/L/RVCrYH0DsAFNuNtie2xZebboSwV59k6549ACHthYl29V/bBdFCGxpkcddmRvsKdtyoXi+EVyYJKQuTjmaPcsiZjUM5MPumnwoH+2HqYfeOxgWDyemdfnHak4+CDestgud4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(921020)(18002099003)(22082099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9JTjqH7clZ821uWUgGsCaMBgKZHnXH8LHRJ+yib0M01dVHbtf6XqtgvXZ8ds?=
 =?us-ascii?Q?4k4DzNNLqMa9Es2yezjINgAESm51vhbJZcu/N0PXIiuPkUxnGPqXLyvAhGps?=
 =?us-ascii?Q?ucHkjtfCnItQImgjL/iI08BAlhvn5cgJFSBQbtAaM2Of37jJxoErTt4mGwDE?=
 =?us-ascii?Q?43TVhPDmRw5Y3i2O+if8BkxfGDw8TJd25Z/6MkGMII2Wd+GDu24D1nGEIn3+?=
 =?us-ascii?Q?hhLdkgk5b3ZWA89Cn9/e5fq2JED8dH8R09hu7oAcQChatBaNH4iZi31oynoZ?=
 =?us-ascii?Q?FbRQtQhPWdLv2xoygh0xGkvek2ggE9DzooUrQpJYyMj12R4TYSiUi3dHGMis?=
 =?us-ascii?Q?Qv2bZZ8F5oddWYYrUCU54k0ckkMy/B56U2BPc2l+osWELUtGMWIKjNEWpD0f?=
 =?us-ascii?Q?EMIQK02XkfVPfStDXctMj3u2+AHYNGn/DRP72gxa4TqrDQmNP4liE/PUycjJ?=
 =?us-ascii?Q?oEpOkXIHCkIgAEY9n0bU3ErJpsKh68vLgNMruW6JCfR1ybd3sLagPQ9aFyiZ?=
 =?us-ascii?Q?ehjcBKnwTSzMT/Jg4F90h8kX6NbjdVYn0S/qK97d8+f0pScuO9wT2+jU0JJT?=
 =?us-ascii?Q?BAmY43VptTPvqd5Z4DBeqZFwSbd6U7UzrXPtmLwxnYES9ESzjlfMUa3XKK/V?=
 =?us-ascii?Q?se4Vx0DF6Hborn1DBPTxEYBGy7Z6qOOBMLPOxwceWdZlQOkCEfhvw86C1z0+?=
 =?us-ascii?Q?vdyYex4o0mdt0T/bA/74evkVga3RtOlYDr7f1SxD6lZxxiHwGR7HHilOSpqG?=
 =?us-ascii?Q?jker79jR7yHcoUsoerBvGrsMGvt4+6A9/N3SfpBrjiJ4xKqRGwFd8kX63WeY?=
 =?us-ascii?Q?JEbjErOYqsMbKklSMWblRXxEp6vlyrSmf2wZxoYHgFLJvnDHHtSK+Pua43VI?=
 =?us-ascii?Q?Wf2e4yzEhVGIVFNxuf+9UyuSKl3RcjMvmg1iNlkcmM3ojkmsOzSVWhUmboc/?=
 =?us-ascii?Q?Vs2T/jOM96rb1ZKVsxSgEfhr2KHTlLPB76n1+sCd1pOPmpUHp+JHoe09BP0q?=
 =?us-ascii?Q?BcP9EyDUsISt0Bz/lZTnnY5XcRtQKGVmjYI4osKpNd1a1Y3FSWtQwnkQhgkg?=
 =?us-ascii?Q?9KTtKDXOoWE3L2jA5SfVUwT50AZXcKeD8MW/dtT0gbnjQ3asJjbn1tn14Vjv?=
 =?us-ascii?Q?mlhEf+9P3df4b9IWB0AWm6VqS77PXeG4R3gK0pAYk6Ov6YJBprYLx+TnxaaZ?=
 =?us-ascii?Q?oS1xkwVLE97hpVyxzQOuMCD7KKSnutmO+n5jXEXZsPhvnUIh+jvrLBwuT/R1?=
 =?us-ascii?Q?4ws4oqDL9eTxFTXYrOK4JTj/kQ3Z8Oql+nv8SZ4eX30OTRe+Rdu9v9pgVTRf?=
 =?us-ascii?Q?om/ciBXZ26fBpsEkq3OsUl0wc/p2RhY+KV4TkC5wtK+REPGcO96Vqs6i7wj/?=
 =?us-ascii?Q?CqaDc5wk1U5iHZPclY2isFv8iAfdjcW/UlP+i+7RO7ncOrlIrrJYkKTMpAci?=
 =?us-ascii?Q?0xHciPFzAEoegwNIIzm5cWWZY5rZQqrMA6eNAg1vr8o6D3RwtLauDjwMOgen?=
 =?us-ascii?Q?3DU/AgKjKnail9GulK06EM7aC3CZriB6J4x6L+uWdH1ZxYEnX96PomQgtqvb?=
 =?us-ascii?Q?d7ZjLzajSD6rtM/KQWSqPvD3sdF4Ya7o9KU+xQQcT4hqDX3lqX+Kloa0ycga?=
 =?us-ascii?Q?dQw3OcS/y9nf8YooqHMg1dOtwdJBOw2sTXoE/L7XvDTCbfHVdIEbH74fza7Y?=
 =?us-ascii?Q?T74NqRj/hioiG07l+ylcy+ftz0l/Lt0m6XbtqAJe7drTNN8V?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e376455-7a30-46bd-e944-08dec19c49f0
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2026 18:16:53.5077
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4+VckiTjY1WvVCaDfvAbVh/A3JWbQhIZU+uRvWQNIeuqVmtNp6isEy1qG9fWahYy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8601
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11469-lists,linux-hyperv=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[28];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:abhijit.gangurde@amd.com,m:allen.hubbe@amd.com,m:bcm-kernel-feedback-list@broadcom.com,m:bernard.metzler@linux.dev,m:bharat@chelsio.com,m:bryan-bt.tan@broadcom.com,m:chengyou@linux.alibaba.com,m:dennis.dalessandro@cornelisnetworks.com,m:huangjunxian6@hisilicon.com,m:kaishen@linux.alibaba.com,m:kalesh-anakkur.purayil@broadcom.com,m:kotaranov@microsoft.com,m:krzysztof.czurylo@intel.com,m:leon@kernel.org,m:linux-hyperv@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:longli@microsoft.com,m:mkalderon@marvell.com,m:neescoba@cisco.com,m:satishkh@cisco.com,m:selvin.xavier@broadcom.com,m:tangchengchang@huawei.com,m:tatyana.e.nikolova@intel.com,m:vishnu.dasa@broadcom.com,m:yishaih@nvidia.com,m:zyjzyj2000@gmail.com,m:leonro@nvidia.com,m:patches@lists.linux.dev,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[amd.com,broadcom.com,linux.dev,chelsio.com,linux.alibaba.com,cornelisnetworks.com,hisilicon.com,microsoft.com,intel.com,kernel.org,vger.kernel.org,marvell.com,cisco.com,huawei.com,nvidia.com,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[jgg@nvidia.com,linux-hyperv@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@nvidia.com,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-hyperv];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,nvidia.com:from_mime,nvidia.com:mid,Nvidia.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0F14F63A777

On Tue, May 26, 2026 at 01:15:04PM -0300, Jason Gunthorpe wrote:
> Sashiko pointed out these are dangerous, and the create_qp() one is in
> fact a bug. The query_device is just ugly old code.
> 
> Remove the stack ib_udata's from both places.
> 
> Jason Gunthorpe (2):
>   RDMA/core: Don't make a dummy ib_udata on the stack in create_qp
>   RDMA: Update the query_device() op
> 
>  drivers/infiniband/core/core_priv.h           |  2 +-
>  drivers/infiniband/core/device.c              |  3 +--
>  drivers/infiniband/core/ib_core_uverbs.c      | 12 +++++++++++
>  drivers/infiniband/core/rdma_core.h           |  7 +++++++
>  drivers/infiniband/core/uverbs_cmd.c          | 14 +------------
>  drivers/infiniband/core/uverbs_std_types_qp.c |  3 +--
>  drivers/infiniband/core/verbs.c               | 20 ++++++++++---------
>  drivers/infiniband/hw/bnxt_re/ib_verbs.c      |  5 ++++-
>  drivers/infiniband/hw/cxgb4/provider.c        |  8 +++++---
>  drivers/infiniband/hw/erdma/erdma_verbs.c     |  9 +++++++--
>  drivers/infiniband/hw/hns/hns_roce_main.c     |  7 ++++++-
>  drivers/infiniband/hw/ionic/ionic_ibdev.c     |  7 ++++++-
>  drivers/infiniband/hw/irdma/verbs.c           |  8 +++++---
>  drivers/infiniband/hw/mana/main.c             |  7 ++++++-
>  drivers/infiniband/hw/mlx4/main.c             | 13 ++++++------
>  drivers/infiniband/hw/mthca/mthca_provider.c  | 13 +++++++-----
>  drivers/infiniband/hw/ocrdma/ocrdma_verbs.c   |  8 +++++---
>  drivers/infiniband/hw/qedr/verbs.c            |  7 ++++++-
>  drivers/infiniband/hw/usnic/usnic_ib_verbs.c  |  8 +++++---
>  .../infiniband/hw/vmw_pvrdma/pvrdma_verbs.c   |  8 +++++---
>  drivers/infiniband/sw/rdmavt/vt.c             |  9 ++++++---
>  drivers/infiniband/sw/rxe/rxe_verbs.c         | 14 ++++---------
>  drivers/infiniband/sw/siw/siw_verbs.c         |  8 +++++---
>  23 files changed, 124 insertions(+), 76 deletions(-)

Applied to for-next

Jason

