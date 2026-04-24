Return-Path: <linux-hyperv+bounces-10369-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yLgvLPjf62mdSQAAu9opvQ
	(envelope-from <linux-hyperv+bounces-10369-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 24 Apr 2026 23:26:16 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C2E34637C8
	for <lists+linux-hyperv@lfdr.de>; Fri, 24 Apr 2026 23:26:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1A36D3014C1A
	for <lists+linux-hyperv@lfdr.de>; Fri, 24 Apr 2026 21:25:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40B1436E48C;
	Fri, 24 Apr 2026 21:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="KMfKzKXx"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011035.outbound.protection.outlook.com [52.101.52.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 985CC32E134;
	Fri, 24 Apr 2026 21:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777065956; cv=fail; b=r1mtsNAqKGiY/yNLIM1umUznz4V/B467KBscNmQgzqLqSl+cE6jR8zn4Ha+GOW61aYvJezFKxTSC5PZuOHIanjkMIUHGq+aiYGJXAqIU065DZGB5ws1LJX6qWEY4Ds9OtYBeaWv4oI1hBfAOFjPvuX1PkeQYsoQ0TOMNwLLAOTY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777065956; c=relaxed/simple;
	bh=sMlcqt+ijkkZ89ZfoIZhtukXJDzKL3O+Y38Zbu7craE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=lpNns7zZQxoli769o9EpybfZjpQ1RBEAwNlNUjnf8wNOb1dnPVPu+rnCFGz0qQJwTs5Q4s5hnKLHzynGJznw2qBSMcUUScEgYM33UX7p9iPWJuIl3U4fXq2cRKhmfNewcmsWPw0fNS8SATwNQ1YZvck/jVkjgShs9FgpHndkDrs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=KMfKzKXx; arc=fail smtp.client-ip=52.101.52.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VGUNPFgN3bIE6Ne4SDZzCNgTmxQiK6ybxX+HE8cg8GMiAL8Ngi5mUquwP2sPcSetQ6z9g35fwLuazlr6Qkk3KB6nUTcMIKyATbTd4ih8yihxZAWQIiUHgu+AjZje6WkVA4NizQiKPxg70xldFc9OIk1XU2/54EVdc+/9WkECkgZfdS4luHWVffTyOU3mKU3jvHxzsFutrRIS8gxiC31fWdJdmzUEfOxSaLG9A29lTHWTdlidnjMJfDS0jCH2s71V+mIfeLxkBygLNohLbVCDQKAbpFGLGMxrFMe5s6ZvONlz7kp/DteAc6i9MfN/2ZhXA4jY19thPX/0tjUYskQX7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a0kiJYO7rd0So9Re95XSE9YfnYrsHTF7+gzb8MMY3Y4=;
 b=YafAUg7hhheOgUlATR/ucbf6wrVg4UzyH1l8IuCQl4yhRXruoWCLTI94wcMHtg2USSOiUAU+gnBAvriukdeJkm0dQ80VspYmUspYTTVgX/OKcB8ezr3EgHmvVLs8T/CGLIxk/uhWwxhQZi3ql0mUL5bUicdBKBJXuDwHfGJBKKiRwonWoH6nS6sn4dzuNDwsqVSvAX3cznfeSNo2mo3yCaqso0uGbizDtvD40Xj93frLq6E6BhglLLJrhFlioiy1px34cZ3kOpFXPGHA+ULBtjCSZtC9gLIoNHiioXYwYs0yBc816/B1yqLQZJUb33FDeguarrRLZvFEEsw4L0xExA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a0kiJYO7rd0So9Re95XSE9YfnYrsHTF7+gzb8MMY3Y4=;
 b=KMfKzKXxHVTLGbg9cW6qln8a3CkV4vmu2qMziY2YOo3lds5We/y052/sKybuERBrqq3IiUxxGYLPTjOHJpYMYrp9bsQf4DJ2YPulT72hSjhNnE+L8BI2J66Sd4/XZr252pczMUHzZ7yPL/GDLn2sCqHFCpP//SYygKBhJTZUl1OjTIWruBv9aE2IRn1dy7if1lEFS/0+c4IQxJps41N3qFpStb6SSK2cSRmMekSW4KXfLn31IdLdb+ah7rk24eWA2NJuRE9JwQ0KVjjpJYA103296M/QiO/VMtt8E6xf8FdvYMGRYSV87kDMLlApU+VNkhUuxFatulEg6sUwayFoUg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY8PR12MB8300.namprd12.prod.outlook.com (2603:10b6:930:7d::16)
 by CH2PR12MB4118.namprd12.prod.outlook.com (2603:10b6:610:a4::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.22; Fri, 24 Apr
 2026 21:25:47 +0000
Received: from CY8PR12MB8300.namprd12.prod.outlook.com
 ([fe80::ce75:8187:3ac3:c5de]) by CY8PR12MB8300.namprd12.prod.outlook.com
 ([fe80::ce75:8187:3ac3:c5de%3]) with mapi id 15.20.9846.021; Fri, 24 Apr 2026
 21:25:47 +0000
Date: Fri, 24 Apr 2026 17:25:45 -0400
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
Subject: Re: [PATCH net] net: mana: Optimize irq affinity for low vcpu configs
Message-ID: <aevf2bPLBiAzX7UC@yury>
References: <20260424061702.1442618-1-shradhagupta@linux.microsoft.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260424061702.1442618-1-shradhagupta@linux.microsoft.com>
X-ClientProxiedBy: SJ0PR13CA0031.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::6) To CY8PR12MB8300.namprd12.prod.outlook.com
 (2603:10b6:930:7d::16)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR12MB8300:EE_|CH2PR12MB4118:EE_
X-MS-Office365-Filtering-Correlation-Id: f71dcf54-8e38-4487-a4c6-08dea2480cf9
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|1800799024|366016|376014|7416014|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	vykBGr5oHTgdpnqKgXllgRFlrwm+FjWXjeYU/wWFHv09/qnCJNsG355P2+HyqdPy0QRpBmg28HfhN0OtYVRHjzKrcYU6Ps5HtUUcIJ7WpYuBswOI3rZNITpkDzcZh8UAmTMDNd3EIw5rEWrdscOqXVYW8cfQr96v1HBZwoiNtJu3Vh7E6bawEB235zCp4NBnUVPSRJxibRj3zwapNVvXcTYe/EUQ6f95Fi1tMmoEm4XxYOPlGmAZx/ELsFuTNHjNa9JxkRN2RnQla6aeN6OQaYN/kB/Q6mwsT7+AA06CDE0lOsZi1Cas5kGmyqJSYeUADyX7sIm/dK3cdzU8hbTWsV+M6v03u79709XciqKKftumTUpfPSAKMYu0qrs2nj4valVeDXtoxVaCYbY/wJzkAkqTTprEyuRf5R0V2wOZaGoWJJx6nXU7sxc5B1TCtYUS20GfqczioYaiVYYAFpa3mARC+onZ+SsZFHWpyrUbLMzRyDbhGjqOx7CWRQf6twCu8O5IEyTQ3dtzuBNK4d0p1unieJJWfGNrYBxD5vMNmtwRkelYpMoD+BsrwcY8/tChgBOuCBuBRdRhKil5uegYLjcGnWbS/43h9U6LD4VCYiNJ2eRcdIo5jPVEQAEjqcwu/GcxBOA3tqNWzNlWAZBa1K6vraFXl2ZcMzYmVWWS0AiXhYQNC3X1mOY5yGMyoPxwh04UlDagc5vKORrU0Q92k0FiG9L7DoA3gF+JFDCR/7U=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB8300.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(366016)(376014)(7416014)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HQF3eTRJuDfNyQ2ZKnV5AGoH26m2heWkXFqwDuHVI/Y/bW4QCX7OgkHvRNCK?=
 =?us-ascii?Q?GxBZ5iz69INntMZaHyVDcWRMm+AyQw6DHJeX+T184cCAClZE9sFELGLzZ9Zn?=
 =?us-ascii?Q?XO64MA+v15Y8UPa7iD65/P0CgaYceyXy7lchPcXJqYzDZvAbDPTOih0a1ZdC?=
 =?us-ascii?Q?5cr5ypIAX7Gl8/giX5bdujiP9/+A45TM5y9L82nEggHvdMwMVVTHMLERV+g1?=
 =?us-ascii?Q?V0IdG3ovfPZK8DmF9cwdJp4ENgHr0xrsJBgfbQsFXNVNSgcKvx7TTeXe5kTF?=
 =?us-ascii?Q?NI3bJQvv56xbsgTUks+9L9O/LWyuxxaMLNETvYDzgwDYpWf2l3a6kzSat1Hq?=
 =?us-ascii?Q?g8amusnF7Xye0r9Owx59gV0CBFQG3wu4P7N6IzM47QCKLlPtny+Rdk6WLizI?=
 =?us-ascii?Q?xEncuYutD1SH4ErxIvwlzv28CYU55PClGiUTVknacpKmpbMme1vCAZaKk3Nn?=
 =?us-ascii?Q?8PiRMZTE0tBxSj10VzbyPTMyN8zhEtklzzynWPm4tP+JLggzliADak5SIkK7?=
 =?us-ascii?Q?t9L32xZEa1izbVjoeuvpdS/AG/Af/rNxS4+LWlQe90fQ/kki86PKlFazsfsv?=
 =?us-ascii?Q?tEJfiAZ9FMX79c+F8WlTyndU2fxXZWlDPVtvXnobiaeWmABxRv0qc8kuDld3?=
 =?us-ascii?Q?XW0raUQhsM3GLkF6rW/inuSz3J26cX65+0C9sfwAcAdMoGNULkKi42fMIA6s?=
 =?us-ascii?Q?MQVP0MqrI+45yd4hfLj+P5de7g7C6Iq+70fIWwSr2ub909Qo+ichvKR69dkI?=
 =?us-ascii?Q?8lRCTKjiYErnC7hGBrXSwj/CkNWOPP+2rMx5rpMp5K+bSAXb9smD/Rr70662?=
 =?us-ascii?Q?LUCBf4uyR9Niua6SFreLBexu/Ezr7FrhYXuRs9IwN9j2XfeFhi285dOO+KLG?=
 =?us-ascii?Q?1fpJSZYgm0GaVok98bTUe8BWtPAzDzYMoqYJiouQa3XeVDWfIoY/y5i1PI3C?=
 =?us-ascii?Q?FDsV3+ZkiSA+ri70aLCPsXiG4EntiAjnSXgIOrFI7Y40ORO4tG831AP1IZt7?=
 =?us-ascii?Q?euozVLNfYQpEQKcVWBG4T0dVU6VKq76NlaDaQjoKGz1NhJYdLPk2fcGA7Qy+?=
 =?us-ascii?Q?Di+EZ8/6KWjiyW03umxf7EOHrrih4koDSRJoPVfbBW7CpVqXYFL7XJe53bJi?=
 =?us-ascii?Q?HRyH/1YvQizFKzI37JP2nBEXwbi8JWcu0LEjauzMDf0Vy5LPJHQwpb577vMy?=
 =?us-ascii?Q?m6TkCczQf91ei0Mrfu2GKDxLd7Aa2rTk6PXKeAW8bCDIhiHXE2xeq8NXm+Ab?=
 =?us-ascii?Q?KyK4lMEPshWHHHhjKBe/6nxnZaL5dzmF9ZwRyCptv0mf+nhqgKmOaxE1z6yz?=
 =?us-ascii?Q?2vDaTGoPk+hOSSJYGuqWVCFDKedg3tW5HpoHezvGArj1Raf+cyVAS6/JcYSE?=
 =?us-ascii?Q?Rde/FZFVW620AkfvnwBqZrMx4/NV7DJuD7K98Cky3W3hmw4IoqAjWTlIdiQ3?=
 =?us-ascii?Q?q/R74pBw+qiKSPvw5sI7FuI0xSKLQwmtzcIWO7U022hk7go/678BVPLqQBNM?=
 =?us-ascii?Q?2nuw28j0Gmk0LadBcwqYMUheL/SQxcXp63wdYBTYGRsuYmmpLBbggX8t1mGd?=
 =?us-ascii?Q?ClM55iqotA6tvU7RqgY/eLV4WUYMidn+S28MDSt8BJVEI5qH2e7HyqkQ0ynN?=
 =?us-ascii?Q?EJ6S/QK4o6WyjUlF+f4MxY7H08gFTP5q4Gnrx9xHUjGBAyg4Mdz6LX0XAX8W?=
 =?us-ascii?Q?rFSV8NPDLBe3xdlhJEUOeCBMk8AKIin9V5iqNwcvz0p6dv8zSTXGGVlcV8ER?=
 =?us-ascii?Q?hd2Bzx4Z8c1xpk4yiklL4n3YlpDiUtD1+d37G3/pqsYJbL6uX7Fm?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f71dcf54-8e38-4487-a4c6-08dea2480cf9
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB8300.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2026 21:25:47.5041
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LYd0MzphzApUsvod1D7MNxla5XFL7AYw7zOnWRNj+sPmTc4ujr4MIc009pOfdm7DLMsSpwOgro5hzY3ysStq8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4118
X-Rspamd-Queue-Id: 5C2E34637C8
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
	TAGGED_FROM(0.00)[bounces-10369-lists,linux-hyperv=lfdr.de];
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

On Thu, Apr 23, 2026 at 11:17:00PM -0700, Shradha Gupta wrote:
> In mana driver, the number of IRQs allocated are capped by the
> min(num_cpu + 1, queue count). In cases, where the IRQ count is greater
> than the vcpu count, we want to utilize all the vcpus, irrespective of
> their NUMA/core bindings.
> 
> This is important, especially in the envs where number of vcpus are so
> few that the softIRQ handling overhead on two IRQs on the same vcpu is
> much more than their overheads if they were spread across sibling vcpus
> 
> This behaviour is more evident with dynamic IRQ allocation. Since MANA
> IRQs are assigned at a later stage compared to static allocation, other
> device IRQs may already be affinitized to the vCPUs. As a result, IRQ
> weights become imbalanced, causing multiple MANA IRQs to land on the
> same vCPU.
> 
> In such cases when many parallel TCP connections are tested, the
> throughput drops significantly
> 
> Test envs:
> =======================================================
> Case 1: without this patch
> =======================================================
> 4 vcpu(2 cores), 5 MANA IRQs (1 HWC + 4 Queue)
> 
> 	TYPE		effective vCPU aff
> =======================================================
> IRQ0:	HWC		0
> IRQ1:	mana_q1		0
> IRQ2:	mana_q2		2
> IRQ3:	mana_q3		0
> IRQ4:	mana_q4		3
> 
> %soft on each vCPU(mpstat -P ALL 1) on receiver
> vCPU		0	1	2	3
> =======================================================
> pass 1:		38.85	0.03	24.89	24.65
> pass 2:		39.15	0.03	24.57	25.28
> pass 3:		40.36	0.03	23.20	23.17
> 
> =======================================================
> Case 2: with this patch
> =======================================================
> 4 vcpu(2 cores), 5 MANA IRQs (1 HWC + 4 Queue)
> 
>         TYPE            effective vCPU aff
> =======================================================
> IRQ0:   HWC             0
> IRQ1:   mana_q1         0
> IRQ2:   mana_q2         1
> IRQ3:   mana_q3         2
> IRQ4:   mana_q4         3
> 
> %soft on each vCPU(mpstat -P ALL 1) on receiver
> vCPU            0       1       2       3
> =======================================================
> pass 1:         15.42	15.85	14.99	14.51
> pass 2:         15.53	15.94	15.81	15.93
> pass 3:         16.41	16.35	16.40	16.36
> 
> =======================================================
> Throughput Impact(in Gbps, same env)
> =======================================================
> TCP conn	with patch	w/o patch
> 20480		15.65		7.73
> 10240		15.63		8.93
> 8192		15.64		9.69
> 6144		15.64		13.16
> 4096		15.69		15.75
> 2048		15.69		15.83
> 1024		15.71		15.28
> 
> Fixes: 755391121038 ("net: mana: Allocate MSI-X vectors dynamically")
> Cc: stable@vger.kernel.org
> Signed-off-by: Shradha Gupta <shradhagupta@linux.microsoft.com>
> Signed-off-by: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
> Reviewed-by: Haiyang Zhang <haiyangz@microsoft.com>
> ---
>  .../net/ethernet/microsoft/mana/gdma_main.c   | 35 +++++++++++++++++--
>  1 file changed, 33 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/microsoft/mana/gdma_main.c b/drivers/net/ethernet/microsoft/mana/gdma_main.c
> index 098fbda0d128..433c044d53c6 100644
> --- a/drivers/net/ethernet/microsoft/mana/gdma_main.c
> +++ b/drivers/net/ethernet/microsoft/mana/gdma_main.c
> @@ -1672,6 +1672,23 @@ static int irq_setup(unsigned int *irqs, unsigned int len, int node,
>  	return 0;
>  }
>  
> +static int irq_setup_linear(unsigned int *irqs, unsigned int len)
> +{
> +	int cpu;
> +
> +	rcu_read_lock();
> +	for_each_online_cpu(cpu) {
> +		if (len <= 0)
> +			break;
> +
> +		irq_set_affinity_and_hint(*irqs++, cpumask_of(cpu));
> +		len--;
> +	}
> +	rcu_read_unlock();
> +
> +	return 0;
> +}
> +
>  static int mana_gd_setup_dyn_irqs(struct pci_dev *pdev, int nvec)
>  {
>  	struct gdma_context *gc = pci_get_drvdata(pdev);
> @@ -1722,10 +1739,24 @@ static int mana_gd_setup_dyn_irqs(struct pci_dev *pdev, int nvec)
>  	 * first CPU sibling group since they are already affinitized to HWC IRQ
>  	 */
>  	cpus_read_lock();
> -	if (gc->num_msix_usable <= num_online_cpus())
> +	if (gc->num_msix_usable <= num_online_cpus()) {
>  		skip_first_cpu = true;
> +		err = irq_setup(irqs, nvec, gc->numa_node, skip_first_cpu);

Then you don't need the 'skip_first_cpu' variable.

> +	} else {
> +		/*
> +		 * In case our IRQs are more than num_online_cpus, we try to
> +		 * make sure we are using all vcpus. In such a case NUMA or
> +		 * CPU core affinity does not matter.
> +		 * Note that in this case the total mana IRQ should always be
> +		 * num_online_cpu + 1. The first HWC IRQ is already handled
> +		 * in HWC setup calls
> +		 * So, the nvec value in this path should always be equal to
> +		 * num_online_cpu
> +		 */
> +		WARN_ON(nvec > num_online_cpus());

That sounds weird. If you don't support IRQs more than CPUs , and want to
warn about it, you'd do that earlier in the function, and align the other
logic accordingly. For example:

        if (WARN_ON(nvec > num_online_cpus()))
                nvec = num_online_cpus();

        irqs = kmalloc_objs(int, nvec);
        if (!irqs)
                return -ENOMEM;

        ...

So you'll decrease pressure on allocator.

What would happen with those IRQs beyond num_online_cpus()? Can you explain
it in the comment? I'm not an expert in your driver, but usually if you pass
a vector to function, and the function is able to handle only a part of it,
it returns the number of processed elements.

Thanks,
Yury

> +		err = irq_setup_linear(irqs, nvec);
> +	}
>  
> -	err = irq_setup(irqs, nvec, gc->numa_node, skip_first_cpu);
>  	if (err) {
>  		cpus_read_unlock();
>  		goto free_irq;
> 
> base-commit: e728258debd553c95d2e70f9cd97c9fde27c7130
> -- 
> 2.34.1

