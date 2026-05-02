Return-Path: <linux-hyperv+bounces-10583-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +OPQL0Mx9mnKSwIAu9opvQ
	(envelope-from <linux-hyperv+bounces-10583-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Sat, 02 May 2026 19:15:47 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 177074B301E
	for <lists+linux-hyperv@lfdr.de>; Sat, 02 May 2026 19:15:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CD9C0300B61C
	for <lists+linux-hyperv@lfdr.de>; Sat,  2 May 2026 17:15:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 226BF3033EA;
	Sat,  2 May 2026 17:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="B4wcuILT"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012018.outbound.protection.outlook.com [40.107.209.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 634439463;
	Sat,  2 May 2026 17:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777742145; cv=fail; b=crI8gMQAF2N5Z0PSRk6j5BMquxN6yMmZw+Yzua5uAeZlhjSa9rOa5eSPo1R1AjSTrPatYnNpzcc81P+4DqRCKdb76Ct5c5vMJTZVr9ssWLXP01Ezd5dmqA5DgBkf3eUq41Jh14B3o2hAcy+JrK7zRQvZHIIiYnqy8m27eK1LDtU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777742145; c=relaxed/simple;
	bh=21LV8WcdhwRL/rhmvsU4TsUh4MnKnfX4tGwAhE68jlE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=sXH9wT2oGxlykQQYlt8EHKvDsrIiwEli5WitZycF9ljNMVqmM5aKm/i2DQ7/N8XpNMmHt4i3ypS8Mqb+IKVo/p1QwxN2Wqd1zm6IoGWAVbyCUhXzHNs5NPelPFtPP/8Csm0U1f1nI9Z1FT+uiISiZYRHpdl6x+9VamUB28I647M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=B4wcuILT; arc=fail smtp.client-ip=40.107.209.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x/fWJy6is5p+7MslD2eBAH0g8TIYYON2f4XAcXjKHV4c7LdSU0gkrdUYFZwxiRjffDKdr+EKG7odJlzjRg2d6JroTMPsY5dSNBV8WNhxgXb6roANEiIFLhygOP15E7+fy0fQ6wPs1iJY7prqu1WFZqStooCNf5HO13AFuK+PbgiyY8Bqxx0bMQLhQ3biL4Lg+3K3Vmq/g9PYmE9uFeYj9UGKq7rTxO69S0o05vmvmPIGgbmVkBpEJMUmmiZXFP4XRRbwe2lLAwwIMzlmL740Q3i8z6jueTJwnpxc22rF6b7mn5/VTbsicMucDUVUMh74lRVu/izCZFJz60v1GR/KKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nDFYuT1d65BQg2MraBPXEhkprEHEEZKtl//lFZ9psE8=;
 b=P43xZJ/AO6HgnpCSy0aBYEw/sSw5EYNzhLKlcEt9P+vaJEW2xOHbm4EEAkmXi6PUsxn6PuQL/BEmVFCY232AoO5SaewK5qwNDCc6TDDvC1J+pQu0/nwzDCVPEx7AWLDH1rGQW6gygXrEqyhyXTe1VV8Cyr6z/0TpyITVHYP4zeSOmFkpDwChtwbIm8SoZ3fCc3pFqWIZd4T7LAob/cXoN4nPLvbQNGiRWOFZh9np5wZiAk52dl6vlofIEC0Eyw5mbWESEYamStrIv8ncAFeZXXDjoxfZvqzbT1pBYBbk5eEi2x6j1ZISYFpGXFA1cP0zcSAwQWI4hSjzI/dM+ovGVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nDFYuT1d65BQg2MraBPXEhkprEHEEZKtl//lFZ9psE8=;
 b=B4wcuILTR5GIx06wD8D80DaCrV8LA8KcHcwHJtxvyhrkhU9GfY50pmM3g7ck5b6oafg9DW2ko+lN1AhepWFP7Zorl/liiU8FqSzzrevxdEsErULWU1Oz/J2PS5iVTtkzuUq5f/RP9UBwfrZCjGX9NhygfzpY1G7mrcqwhRUPu97j9hxGBFBmgMsNo3gtrp/2DsSmXnfSsLsxQKyaCXclMfSOUUKRyKSGV5QzLqM3l8oFQu8U1jb2ywNsJDse4s/lCbnGBDGsGeQDHZkpVRNentqQsboyDEGkzD4cDkrjTZrJcV4s6s56F383eKg/mkjW+9pmOHt1gGjKFkMu9KYtGw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY8PR12MB8300.namprd12.prod.outlook.com (2603:10b6:930:7d::16)
 by SJ2PR12MB9085.namprd12.prod.outlook.com (2603:10b6:a03:564::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.23; Sat, 2 May
 2026 17:15:38 +0000
Received: from CY8PR12MB8300.namprd12.prod.outlook.com
 ([fe80::ce75:8187:3ac3:c5de]) by CY8PR12MB8300.namprd12.prod.outlook.com
 ([fe80::ce75:8187:3ac3:c5de%3]) with mapi id 15.20.9870.023; Sat, 2 May 2026
 17:15:38 +0000
Date: Sat, 2 May 2026 13:15:36 -0400
From: Yury Norov <ynorov@nvidia.com>
To: Shradha Gupta <shradhagupta@linux.microsoft.com>
Cc: Dexuan Cui <decui@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Konstantin Taranov <kotaranov@microsoft.com>,
	Simon Horman <horms@kernel.org>,
	Erni Sri Satya Vennela <ernis@linux.microsoft.com>,
	Dipayaan Roy <dipayanroy@linux.microsoft.com>,
	Shiraz Saleem <shirazsaleem@microsoft.com>,
	Michael Kelley <mhklinux@outlook.com>,
	Long Li <longli@microsoft.com>, Yury Norov <yury.norov@gmail.com>,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, Paul Rosswurm <paulros@microsoft.com>,
	Shradha Gupta <shradhagupta@microsoft.com>,
	Saurabh Singh Sengar <ssengar@microsoft.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH net v2] net: mana: Optimize irq affinity for low vcpu
 configs
Message-ID: <afYxOPL4DNjXM7tL@yury>
References: <20260429090640.1790104-1-shradhagupta@linux.microsoft.com>
 <afTTPLClWwIMWTOh@yury>
 <afYMN6vbiX7Rzss+@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <afYMN6vbiX7Rzss+@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
X-ClientProxiedBy: BN9PR03CA0621.namprd03.prod.outlook.com
 (2603:10b6:408:106::26) To CY8PR12MB8300.namprd12.prod.outlook.com
 (2603:10b6:930:7d::16)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR12MB8300:EE_|SJ2PR12MB9085:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e9296ba-ee09-4599-5532-08dea86e6df3
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|10070799003|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	OvkVHbJNyDzgq04W1lUqyFJA+ymdslBgP113t9zFEIcoLdRvYeASbsgYEBfNdiV23lL67RbjRPr7tIKjnnVAbN+xvyDoNPk9cQ9H56QDm1Wm6YVD8/C1xaI50jsxIkJCvP6Ucr4ig5+Wtc31rmvbRec2799H9wLqoE8pvfnNqJvLIw/xHcWy/hEQr8HTrNni8yBEqflkG/XQyA7MIw44Fbz3BxIi1XSLXS1Lnc/a3cY9+8dLoUjvN93y/6UedGY60/o04o+dLGMaRNbPkZVmf2UHHRxioeosTKM9uuQfO1p/CecAKKOVwi1Pt1n5WpyCYJWn6EYUG2dTdozv7fA1s5z1fYI9jUmIDRzwH9nxrtC58ZBVInFvzrcgijk4tpjIduI71mivoPRfPWabbFpaNQ8eWURvrqPTYOXFAvATQtAbT52sLx9Z+qEJ2odZzx4UoF3+1xEpzDCInjLWF4EbwDvAmQ/JTIE4rC1uA5tGldoLWFxt1uacj10xZ9Lo6ir7VcoRQMjlJB3TzmDBvIFiFQHpP7iprKNx59mGFKY2MNCSNBaUNllVb1VOQ2S6L/K9aPn1lfe+/bUqDeWu/3+4IcyWn9nklcxXvpigfA4Lx2AVKuruftKgwsmek2vJ34edI2wUgxJJUg++NcIMUAQ7+JGSQ5eZBADi+un1aubDwPJZAmqbTNb+SmvxRi7ti4jb
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB8300.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(10070799003)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Pc8+Ftd0xrFVQn33qWCqBjlUhvt4B/oKjSvtM4kloexwmUyPDS3fjCjc0DVI?=
 =?us-ascii?Q?nH7INRVB466nm1+XW8Ld5vq5efnijGcgQNP3U9CYU71MxxMSha4zUFcndM7Q?=
 =?us-ascii?Q?uROCWDNBnZ68Apwa73Rq3hmsZ3CXipO0qItsEuRHKkOln0VdqVz1vtWNPena?=
 =?us-ascii?Q?l7Wjg1a7U7E2EDqfpGd9+TMv3tXQO3eHFbzdjXsOiXGqkKvcnTvuxw7DSWKZ?=
 =?us-ascii?Q?OyZuqZreNQiraKAMB0jdZiWBXkCQlHhZRTU1Ry3JFRJcijecIE9SxcI6SYkL?=
 =?us-ascii?Q?BpeMIBQH5adVnMHOAvGjP0SbZ41OGkXLBnfpg91D8W7dTHDih990y/EBGHte?=
 =?us-ascii?Q?4cVskooPpNuUVO7gxDI6F4xyJBwac6fWV/7nklEUkBoHb72bKOVbQ3g+13ej?=
 =?us-ascii?Q?IQ1jE/wuBhQTeIYWyn0/4P2ABcY+kAXbzO6y81XT0AY/J073athDV69xF3vK?=
 =?us-ascii?Q?Mf4S49qdG8IGWqD+kjBJI4h9FrXvma9wgI8rdxZtUvEA2HZSFyDrnl00SX6O?=
 =?us-ascii?Q?sWPwiDxUqJEqKvX15uvUou4XvO99A0XHVeOVNqtzHj7xyaHTtykYLnfU44u7?=
 =?us-ascii?Q?KsqWI6f+tzQ3RzhNMu7JNwn0U8/9SeWMyeRGsnf/PMxV1BG9pU7+68G/Bo/J?=
 =?us-ascii?Q?522YKV3ViRf7x2Dz5LkLYh9pPteO9yBVmrdQJvf6UiMNnhvkJ7QARW5l2DKV?=
 =?us-ascii?Q?jByJ8pzpZsjwciXRX3o51b7SrrYzI5bjnX0LY8Re0PEcf5WYUdYZGj6NYDx7?=
 =?us-ascii?Q?L6evjFxcOrwvPLvHsUCwG58voY9QgQF94n/6VAWZONaPwmagmplgPMkpfxD3?=
 =?us-ascii?Q?eKBL+tKW7dpot3H9X5BzCod+v8CtZm+noXTs33EK8ZNAA4AKOkzbNtdRzyjy?=
 =?us-ascii?Q?q5f+GCxad2/j/b3SDJYPxDsbVCS7lRxRZ5PMDOMTMeaQC+ib2QxNCUDvSXsa?=
 =?us-ascii?Q?XWKUwKTJS7wF3l34gd+MM3HrudeAPvTwiz8nEIIkUBa8tLLKnnN8Gx+pxKbB?=
 =?us-ascii?Q?rt+BT74IugJ3JKyiyacfcswALTs4V3X/xMcV6J7U3orbXk8iLIStw9ShbXVp?=
 =?us-ascii?Q?lOIZrDaR9a5YQzwksQuXB2dORaF7jT/Bq8E/TssIhVlq85GxbnGWncbQegzF?=
 =?us-ascii?Q?XVQqubFYMWVUwlh5bQ3efotR4OSrsWOfCUDYwCREt5ftoRUx92yYA0ASfoT3?=
 =?us-ascii?Q?62YMhSywnGcAnzKYE2TP9HP928smJSc/upRu+p6EMgJEqlzxTR/yjQFAMVvZ?=
 =?us-ascii?Q?y41MkOvzPk7DlhwoKX4X9876Ew4X1Hi+OtruM4QSLRj6KeVPftSnMWh22fIM?=
 =?us-ascii?Q?UWqjX+4zMU2LrUoJYb7gQvD//kdtPYGxnuhH6kZHP2EZlLcKQn577WFSp69s?=
 =?us-ascii?Q?zEIcPlh5JXAS/u4vjGcKj13cAOIIwdHdPonwi+TRkafDmwTSZ7N35t6GQlGZ?=
 =?us-ascii?Q?+NQX+22ety1fTrgfIGB3JH38IUsRpIEEtORVIn/pXz3hea362DE3GV8snQCJ?=
 =?us-ascii?Q?j3xk/q5mf2jlydOGCJGRx15+vdXAbdAoufhB7QYkb4Io6mmbCVcR5tGG70Wl?=
 =?us-ascii?Q?KnEbQTZNE0auHFQA2OTtZRKzvT2q/1e742j5RzsQfcl/EX3XF7Jzg0EcTpo0?=
 =?us-ascii?Q?kmCXIDC0ajOPEVqkg69ohwgNAHlir+6vtrwxktyOiRdCKP55KkcbSHNrv8J0?=
 =?us-ascii?Q?e5YevK/NbgiNIVcyJhXV6bJD6SmcmSHkte4KNL4Nyjsfsvh8+60A67h2YMgD?=
 =?us-ascii?Q?E2I6QfbZEYV4geT3rvs196p5OjRq6YJsjKsBi91P09K41MxXXdqu?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e9296ba-ee09-4599-5532-08dea86e6df3
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB8300.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2026 17:15:38.1244
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9vH4Km9HYvu5i16lbfp8lezC9ooZJXKdkV6EZEGYM/W1q1Y/bv6nsEvOmZHahdGfgtT3nF5QDoSwxwLUca6Eow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9085
X-Rspamd-Queue-Id: 177074B301E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10583-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[25];
	FREEMAIL_CC(0.00)[microsoft.com,kernel.org,lunn.ch,davemloft.net,google.com,redhat.com,linux.microsoft.com,outlook.com,gmail.com,vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ynorov@nvidia.com,linux-hyperv@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

On Sat, May 02, 2026 at 07:37:43AM -0700, Shradha Gupta wrote:
> On Fri, May 01, 2026 at 12:22:20PM -0400, Yury Norov wrote:
> > On Wed, Apr 29, 2026 at 02:06:37AM -0700, Shradha Gupta wrote:
> > > In mana driver, the number of IRQs allocated is capped by the
> > > min(num_cpu + 1, queue count). In cases, where the IRQ count is greater
> > > than the vcpu count, we want to utilize all the vCPUs, irrespective of
> > > their NUMA/core bindings.
> > > 
> > > This is important, especially in the envs where number of vCPUs are so
> > > few that the softIRQ handling overhead on two IRQs on the same vCPU is
> > > much more than their overheads if they were spread across sibling vCPUs.
> > > 
> > > This behaviour is more evident with dynamic IRQ allocation. Since MANA
> > > IRQs are assigned at a later stage compared to static allocation, other
> > > device IRQs may already be affinitized to the vCPUs. As a result, IRQ
> > > weights become imbalanced, causing multiple MANA IRQs to land on the
> > > same vCPU, while some vCPUs have none.
> > > 
> > > In such cases when many parallel TCP connections are tested, the
> > > throughput drops significantly.
> > > 
> > > Test envs:
> > > =======================================================
> > > Case 1: without this patch
> > > =======================================================
> > > 4 vcpu(2 cores), 5 MANA IRQs (1 HWC + 4 Queue)
> > > 
> > > 	TYPE		effective vCPU aff
> > > =======================================================
> > > IRQ0:	HWC		0
> > > IRQ1:	mana_q1		0
> > > IRQ2:	mana_q2		2
> > > IRQ3:	mana_q3		0
> > > IRQ4:	mana_q4		3
> > > 
> > > %soft on each vCPU(mpstat -P ALL 1) on receiver
> > > vCPU		0	1	2	3
> > > =======================================================
> > > pass 1:		38.85	0.03	24.89	24.65
> > > pass 2:		39.15	0.03	24.57	25.28
> > > pass 3:		40.36	0.03	23.20	23.17
> > > 
> > > =======================================================
> > > Case 2: with this patch
> > > =======================================================
> > > 4 vcpu(2 cores), 5 MANA IRQs (1 HWC + 4 Queue)
> > > 
> > >         TYPE            effective vCPU aff
> > > =======================================================
> > > IRQ0:   HWC             0
> > > IRQ1:   mana_q1         0
> > > IRQ2:   mana_q2         1
> > > IRQ3:   mana_q3         2
> > > IRQ4:   mana_q4         3
> > > 
> > > %soft on each vCPU(mpstat -P ALL 1) on receiver
> > > vCPU            0       1       2       3
> > > =======================================================
> > > pass 1:         15.42	15.85	14.99	14.51
> > > pass 2:         15.53	15.94	15.81	15.93
> > > pass 3:         16.41	16.35	16.40	16.36
> > > 
> > > =======================================================
> > > Throughput Impact(in Gbps, same env)
> > > =======================================================
> > > TCP conn	with patch	w/o patch
> > > 20480		15.65		7.73
> > > 10240		15.63		8.93
> > > 8192		15.64		9.69
> > > 6144		15.64		13.16
> > > 4096		15.69		15.75
> > > 2048		15.69		15.83
> > > 1024		15.71		15.28
> > > 
> > > Fixes: 755391121038 ("net: mana: Allocate MSI-X vectors dynamically")
> > > Cc: stable@vger.kernel.org
> > > Co-developed-by: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
> > > Signed-off-by: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
> > > Signed-off-by: Shradha Gupta <shradhagupta@linux.microsoft.com>
> > > Reviewed-by: Haiyang Zhang <haiyangz@microsoft.com>
> > > ---
> > > Changes in v2
> > >  * Removed the unused skip_first_cpu variable
> > >  * fixed exit condition in irq_setup_linear() with len == 0
> > >  * changed return type of irq_setup_linear() as it will always be 0
> > >  * removed the unnecessary rcu_read_lock() in irq_setup_linear()
> > >  * added appropriate comments to indicate expected behaviour when
> > >    IRQs are more than or equal to num_online_cpus()
> > > ---
> > >  .../net/ethernet/microsoft/mana/gdma_main.c   | 47 ++++++++++++++++---
> > >  1 file changed, 40 insertions(+), 7 deletions(-)
> > > 
> > > diff --git a/drivers/net/ethernet/microsoft/mana/gdma_main.c b/drivers/net/ethernet/microsoft/mana/gdma_main.c
> > > index 098fbda0d128..d740d1dc43da 100644
> > > --- a/drivers/net/ethernet/microsoft/mana/gdma_main.c
> > > +++ b/drivers/net/ethernet/microsoft/mana/gdma_main.c
> > > @@ -167,6 +167,8 @@ static int mana_gd_query_max_resources(struct pci_dev *pdev)
> > >  	} else {
> > >  		/* If dynamic allocation is enabled we have already allocated
> > >  		 * hwc msi
> > > +		 * Also, we make sure in this case the following is always true
> > > +		 * (num_msix_usable - 1 HWC) <= num_online_cpus()
> > >  		 */
> > >  		gc->num_msix_usable = min(resp.max_msix, num_online_cpus() + 1);
> > >  	}
> > > @@ -1672,11 +1674,24 @@ static int irq_setup(unsigned int *irqs, unsigned int len, int node,
> > >  	return 0;
> > >  }
> > >  
> > > +/* should be called with cpus_read_lock() held */
> > > +static void irq_setup_linear(unsigned int *irqs, unsigned int len)
> > > +{
> > > +	int cpu;
> > > +
> > > +	for_each_online_cpu(cpu) {
> > > +		if (len == 0)
> > > +			break;
> > > +
> > > +		irq_set_affinity_and_hint(*irqs++, cpumask_of(cpu));
> > > +		len--;
> > > +	}
> > > +}
> > > +
> > >  static int mana_gd_setup_dyn_irqs(struct pci_dev *pdev, int nvec)
> > >  {
> > >  	struct gdma_context *gc = pci_get_drvdata(pdev);
> > >  	struct gdma_irq_context *gic;
> > > -	bool skip_first_cpu = false;
> > >  	int *irqs, irq, err, i;
> > >  
> > >  	irqs = kmalloc_objs(int, nvec);
> > 
> > So what about WARN_ON() and nvec adjustment before kmalloc?
> Hey Yury,
> 
> I am still a bit unsure about the WARN_ON() before kmalloc, as after
> that also, in the same function till we take the cpus_read_lock() the
> num_online_cpus() can change(or reduce). That's why I introduced the
> dev_dbg() to capture hot-remove edge case.

OK.
 
> Do you still think it adds more value?

It's your driver, so you know better. I just wonder because you said
it's good to add WARN_ON(), and then didn't do that.

> > 
> > > @@ -1722,13 +1737,31 @@ static int mana_gd_setup_dyn_irqs(struct pci_dev *pdev, int nvec)
> > >  	 * first CPU sibling group since they are already affinitized to HWC IRQ
> > >  	 */
> > >  	cpus_read_lock();
> > > -	if (gc->num_msix_usable <= num_online_cpus())
> > > -		skip_first_cpu = true;
> > > +	if (gc->num_msix_usable <= num_online_cpus()) {
> > > +		err = irq_setup(irqs, nvec, gc->numa_node, true);
> > > +		if (err) {
> > > +			cpus_read_unlock();
> > > +			goto free_irq;
> > 
> > One thing puzzles me: if you skip first CPU with this 'true', and the
> > gc->num_msix_usable == num_online_cpus(), it's one more than you can
> > distribute. What do I miss?
> > 
> 
> Let me explain this case a bit better then,
> 
> - num_msix_usable = HWC IRQ + Queue IRQ
> - nvec in this functions is only Queue IRQ (HWC already setup)
> 
> When num_online_cpus == num_msix_usable:
> - nvec = num_online_cpus - 1
> - first CPU is already assigned to HWC IRQ, so skip it
> - Queue IRQs fit in the remaining CPUs
> 
> please let me know if I did not get your question right

Can you put that in a comment?

> > > +		}
> > > +	} else {
> > > +		/*
> > > +		 * When num_msix_usable are more than num_online_cpus, we try to
> > > +		 * make sure we are using all vcpus. In such a case NUMA or
> > > +		 * CPU core affinity does not matter.
> > 
> > If it doesn't matter, why don't you assign each IRQ to all CPUs then?
> > In theory, the system would have most of flexibility to balance them.
> > 
> 
> Okay, let me fix the comment and elaborate on this. It doesn't matter
> because in such a case we want to anyway exhaust and distribute the
> Queue IRQs to all vCPUs.
> We don't want to rely on the system's balancer in this case as it could
> be skewed by other devices' IRQ weights

I don't understand this. If I want to reserve some CPUs to solely
handle IRQs from my high-priority hardware, then I configure my system
accordingly. For example, assign all non-networking IRQs on CPU0, and
all networking IRQs to all CPUs.

In your case, you distribute IRQs evenly, which means you've no
preferred CPUs. So, assuming the system is only running your IRQ
driver, it's at max is as good as all-CPU distribution. In case of
heavy loading some particular CPU, your scheme could cause
corresponding IRQs to starve.

I recall, when we was working on irq_setup(), the original idea was to
distribute IRQs one-to-one, but than I suggested the 

        irq_set_affinity_and_hint(*irqs++, topology_sibling_cpumask(cpu));

and after experiments, you agreed on that.

Can you please run your throughput test for my suggested distribution
too? Would be also nice to see how each distribution works when some
CPUs are under stress.

Thanks,
Yury

