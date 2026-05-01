Return-Path: <linux-hyperv+bounces-10547-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MLceDmbT9GkYFQIAu9opvQ
	(envelope-from <linux-hyperv+bounces-10547-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 01 May 2026 18:23:02 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C35C84AE123
	for <lists+linux-hyperv@lfdr.de>; Fri, 01 May 2026 18:23:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 76EC7300CE76
	for <lists+linux-hyperv@lfdr.de>; Fri,  1 May 2026 16:22:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BAA33FB7EB;
	Fri,  1 May 2026 16:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fVxpm4mo"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010020.outbound.protection.outlook.com [52.101.201.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E604E3DE425;
	Fri,  1 May 2026 16:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777652570; cv=fail; b=k22MwjdkzsAgIgMUtAlF23JQyQP3cunVcZ1u5CAX6fbPF61pQ7el4S5Wm+qf6DkzlU8kv14Equ826d5xSOub4n5yeWRg5LSO3YsEKQofLRke02WmgHHe2IppM0Wx8UsokamgJO6pq1h+u6s7Ey2Sa7t6myQGAXqJ0s9f/Uuu1LA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777652570; c=relaxed/simple;
	bh=0SqPB9n3g8gGeQFI8fhqcbijGibu4NzQsLlJSoxjaeQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=E4ecpBBI6QSAaOqW37wMgli1S309lhVJAvv86ac3MaT0xA2jEl4LBAs0qYGvl6zWTAQoYyFQmRISJ7o0Q7pdduok1TcQDe+0A4bZRbt8UkRj0qKToRKaMWuUYw8MIyWb1jJateihU1cmTJPUTv8RMWRtcJdDRI4ZNy2TVyVT+xw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fVxpm4mo; arc=fail smtp.client-ip=52.101.201.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EDEzNOEAyMEwCKwypKUW0p22+aOsWRfV/jj8pg7NDvBL3R/VQhDglPxUuW+KmISRko/3LpfM5OP7tRoNBL6JbjzwYpmWpOehTCYu97x81JtsahzPvzYqm+HcQZvbYcFq8By5vcnssWXgW8QUzSzjCdDY0i/gn3hsLVmgchuHyVXyCk6hIdynRp6BNLnW758O+8vkRCghcVni5TQo5AI4zxe1Ov31WxAbK9eacGJwvTnj5KoCtUqTFjghPQzCBf9rEf1qiuU7VRonrmXg7j4Yr/o9ugOXo8yqt76wwzix1i0LtLJX/JgRoJT2ZVl8hD0qdY4qQ99c5LiyiNCh+V3QyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5nM7rKnbeCE/jBCF99+fb8u88FREICm5zg5KhPoeRhM=;
 b=Z3baeDL4O1fWLSz7nlMFDhFHzXYp14SIrQ8HyrH0VEvdWHSWwynrCt14L6BcpIzAy/vBFDylF9dIZ7l8UOkrJwpak/QkXCrfUvCjct7hWRNqxq/JsH0L9/wLgbQ4bl6MSC+QoJDrmYNJJR9KhCxuoLy95Jrh9GoByGrwuFfEXCQcENIA+3tB/6/iKydBT3eoB4U95IKtdxeUoy1lUfv6TbqcLtQOhjpW3goGfHAKJYht4KsNPNx9dfPrf0AiamBQzQMqau7R9xVe6b0k/L4212nLp6LuaavsZ6jwoVIzv5UCo4WwmW9R78CIH4oCXiTEqB3ZcqodLBDImLpM9ekqag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5nM7rKnbeCE/jBCF99+fb8u88FREICm5zg5KhPoeRhM=;
 b=fVxpm4moOdVwKwBmutNPZDeB+1ae2Rpfv24N8ryCxmYC2P1OmmEnMeONp8H9QDfXmn9hzsrIzWBjJ9ZWAnIxbKI+LMYPQclPHSvpTHLR4sBD6j7pivNil53PGdvKK9j+0dkiNZhnI3PkSiLQYCJNPVazRhlBTXelkcsxjQIpvZs2BH92hGMQ4d7Avo05UY34K9iIXwVIkZ3muIzZalgiQh9ozBHV+KBset72g6oZ3B3nXYZD44Qift5WNqJqP8lk2jIJrLPk9fy29/VYW+XB4wML0Q59ZYH+v25F/NI1CA6/AZ8idJwLbqL16Tm7LxswB4rp0yzHuvrCgcbi83nN7Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY8PR12MB8300.namprd12.prod.outlook.com (2603:10b6:930:7d::16)
 by LV5PR12MB9801.namprd12.prod.outlook.com (2603:10b6:408:2fc::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.20; Fri, 1 May
 2026 16:22:23 +0000
Received: from CY8PR12MB8300.namprd12.prod.outlook.com
 ([fe80::ce75:8187:3ac3:c5de]) by CY8PR12MB8300.namprd12.prod.outlook.com
 ([fe80::ce75:8187:3ac3:c5de%3]) with mapi id 15.20.9870.022; Fri, 1 May 2026
 16:22:22 +0000
Date: Fri, 1 May 2026 12:22:20 -0400
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
Message-ID: <afTTPLClWwIMWTOh@yury>
References: <20260429090640.1790104-1-shradhagupta@linux.microsoft.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260429090640.1790104-1-shradhagupta@linux.microsoft.com>
X-ClientProxiedBy: BN9PR03CA0189.namprd03.prod.outlook.com
 (2603:10b6:408:f9::14) To CY8PR12MB8300.namprd12.prod.outlook.com
 (2603:10b6:930:7d::16)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR12MB8300:EE_|LV5PR12MB9801:EE_
X-MS-Office365-Filtering-Correlation-Id: a35cae82-03eb-4474-0598-08dea79dd30b
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|10070799003|376014|7416014|1800799024|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	7sQLviJ7SKtR/+nkuzh2MOHop6fal5fqhd/ZKbwVJxyzIfS+jQfurEdCBGvWaNxx5ozdCFsmLKR9cyOZZCVNT3ejyqJXpHr60N4L/4w8chWgeDS6lYiOjuPaF8APpbsLc8+2CR95SdF32h1trYANntzhwItnUVDvaHSfvhoupAZedBzYUPCeuIUKQqalyFR3B+//FhhIh3uSqigyw4tozKKNva70UgxEGmYyzJQq+tbGwzBMCvJyDQDUjsP5QMI4N8NlLIIMO52fc+mgSmNDvbOGD4vkocnguUImAikSqDRMZk9F4kBl6WbjjAOfsgmGoqtd4QqtfJgB1wERgxzXkLiEn/5IrUWYaeKiexpPJ2bR5/e3RqfLkKVsTnGAeXNA1lEyJjDLzfLKlvi9/AlefFdH5uONRVbfvv9I0N1M1YAzh8g5XHwu/0rUkwly1m3nU0Z/qvYD3tx+hvvgj6QdUF292dEep43Lf60xQfJoe9/Zo+Nw8rrailRDJfsfXBtOGwnSppHLf3L9R9TZy2/Ep/5odi2cQvlbA5SRe3lb7mPJm++lbBheaDK82UJ3GgOsxuafaWrydzuaUJRFO2zNpi6GnKXbW3i0ntSZQRyY6iLXu3ErkyLcRyOaXapYucaEJohbuxCreHob10eup3TEVjVptekCT96wNNPUBTEAfi15Mb0xW6PolTv4RvfmHcvI
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB8300.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(376014)(7416014)(1800799024)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KW4yuzDDNyHwi45UV+43FyDHaXlV+DSEflaoRi3m0nrmIEyn42ehqWrGWIRh?=
 =?us-ascii?Q?7tuxqhL4/eGV0p6F/rbmsoa9TgNYSfeSIyb3nT6vwoRbY09/+r1BgHJsRGwB?=
 =?us-ascii?Q?c7eDarEvcu+CkhEOzP5wOCuBe2B4kSjh/nrm0RCB5NU1V8QGdYctRQyrE2TD?=
 =?us-ascii?Q?Oxi8/T5+Sn3D6Xb8+/C66Dmaa9GTxTkIAlR73YSVwo5N21XBLqv68vbsrEcS?=
 =?us-ascii?Q?hIsbysz0b0D6ms7l4FxOdsUWZ7d3MCDPP/O7t8hwcPkjzaJDPwYRLw313ws2?=
 =?us-ascii?Q?steVekJwVWt6Utc8VmvyBGYxSjVvGAnNQIc+4PXrl5u290VmMV/ZmQEfmrdL?=
 =?us-ascii?Q?6j4ZIkammnmfsoMWdv9cO+dPosUGgPzok9fD+/olkMdE9SNvW1+OmCOFSNdc?=
 =?us-ascii?Q?tp5GmhR5Ak5u3igbDks/+PzLQFSd7/tM3LJxMXCa0EndiSeFganSQZipbVln?=
 =?us-ascii?Q?lSoKP+ndIGv9UYGVeBsqZ+j5mq+O22grbZRKl2c72fp0dzBES0WfoOxEhj2V?=
 =?us-ascii?Q?6qwa3FMgaktsLKrdZMbmKmG7xRjac1wyHro+KRrZKpjrp1y+QNfOZ8h5DNOv?=
 =?us-ascii?Q?Pj1IoloOZqZDW242JNRA3m5nmOxU+9ESC8HPwNDF/9Xx6v3zlUEDOJDt15Ha?=
 =?us-ascii?Q?TVbxms8HvxZCZw4syhbEOqnl845CacL/qv43g6P5ZzFEZnx+u3aFbQbB8i1f?=
 =?us-ascii?Q?dGgYev61JPZRQkxWJ7c/5HdqhPBdKxJ7gWqtuh7XEusnxianHtyj/DajbPGx?=
 =?us-ascii?Q?VGQtuVaC0944Krez0yja3jCVc2rkfAVR4IYiB+CLaU6lVu16QmLo70U3Aw9E?=
 =?us-ascii?Q?j1bxoj3igtD0/gZ7ZJXZcn+VeXUPBe5vGiVLTLaAOxZoJZiMhJQ7pNw32iGR?=
 =?us-ascii?Q?fEmWe+rwEuEJxPrqUakUiE+KDjUcl62DQlTve1oTTxd5OxYcDmaGek1CWv9t?=
 =?us-ascii?Q?DviWwIJLPgoF0CHOs0s8lRhrG/UrHgtLwgzPn5b/EQuGJDof00u9xP4lhbgU?=
 =?us-ascii?Q?DAYxnEDLNd5oQ7x6rNddwDfxs2BXwaxuZ0YGKahUTZsC6w7wtJM0EjU7XpUY?=
 =?us-ascii?Q?V43LC8e2F6i0iM6uZLnnjTQmHXz5qK3HipkMplYLMcBrm/rqbh1+X/ZocJNV?=
 =?us-ascii?Q?5cdpqHLOndWEkBqk69Nq/aiI6PvCpR0OIjjwH/4KTpFMVWG24zl0Oo/gHCFQ?=
 =?us-ascii?Q?mjZp3qiFBMkbbqRI5lCjt9TR3bCLs/kSm3jn4JjNsGbS7+q4BYgub5NPPjOX?=
 =?us-ascii?Q?QKIuaDlkxuneLfN/87UPDXeDdg3vFLeT8G8Y+LYKbnYWZ7a2h/d1o6am3VN0?=
 =?us-ascii?Q?/h0/TlyfMsnyIduV8WmEN10KjWxjiSvI0wCm0otg5qKOQrS8fRyIoCkuHDuq?=
 =?us-ascii?Q?QFHAmQezQHwPEca+L1gTOPb4Dud3+NFWXU9gEJL2b5fzEgLIZ30Tah4hmch0?=
 =?us-ascii?Q?udt6YwrxMKrtQDAWe/xMtdARhP8yZVKpVCZ0PRH0ldRgAuxrvUEYMONLS1sB?=
 =?us-ascii?Q?3M1XdyVZNyJFESXlzT8yk1lCk3QA+54wIfRQkLzzDYqBzVtlvzK/vc4MjeWm?=
 =?us-ascii?Q?5lSpDxIGIyflWyQ6KmBc+oAQAocOSQCwS6Uer0jr/Zs8mfA38W3nOJ/NxBf0?=
 =?us-ascii?Q?n0S+FC6KW/gU8K3rxq5PHKNkaJMRlepj0yhRhVpDG/pAm7vTpc6iMQMEGiuy?=
 =?us-ascii?Q?2yGMJEYB/k4MdsYGwV2aktfl6E633Ym+JJZP6I4TBtEC7sKm0CZo2VOboJXD?=
 =?us-ascii?Q?eiEGLy1Tq+2FUrACCnww/eZLEx8CEmGJ/a+T4xPHeil7u8PDHUov?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a35cae82-03eb-4474-0598-08dea79dd30b
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB8300.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2026 16:22:22.8689
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q27GuLNEO2i3Qtr2CQbFjvHwUoMfyC0UAjVppuOUHxBYzf+hg9K4JSri+jM0Uz5q/PlFKZ9xGc1tzwD0bq5l6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV5PR12MB9801
X-Rspamd-Queue-Id: C35C84AE123
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
	TAGGED_FROM(0.00)[bounces-10547-lists,linux-hyperv=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,Nvidia.com:dkim]

On Wed, Apr 29, 2026 at 02:06:37AM -0700, Shradha Gupta wrote:
> In mana driver, the number of IRQs allocated is capped by the
> min(num_cpu + 1, queue count). In cases, where the IRQ count is greater
> than the vcpu count, we want to utilize all the vCPUs, irrespective of
> their NUMA/core bindings.
> 
> This is important, especially in the envs where number of vCPUs are so
> few that the softIRQ handling overhead on two IRQs on the same vCPU is
> much more than their overheads if they were spread across sibling vCPUs.
> 
> This behaviour is more evident with dynamic IRQ allocation. Since MANA
> IRQs are assigned at a later stage compared to static allocation, other
> device IRQs may already be affinitized to the vCPUs. As a result, IRQ
> weights become imbalanced, causing multiple MANA IRQs to land on the
> same vCPU, while some vCPUs have none.
> 
> In such cases when many parallel TCP connections are tested, the
> throughput drops significantly.
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
> Co-developed-by: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
> Signed-off-by: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
> Signed-off-by: Shradha Gupta <shradhagupta@linux.microsoft.com>
> Reviewed-by: Haiyang Zhang <haiyangz@microsoft.com>
> ---
> Changes in v2
>  * Removed the unused skip_first_cpu variable
>  * fixed exit condition in irq_setup_linear() with len == 0
>  * changed return type of irq_setup_linear() as it will always be 0
>  * removed the unnecessary rcu_read_lock() in irq_setup_linear()
>  * added appropriate comments to indicate expected behaviour when
>    IRQs are more than or equal to num_online_cpus()
> ---
>  .../net/ethernet/microsoft/mana/gdma_main.c   | 47 ++++++++++++++++---
>  1 file changed, 40 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/net/ethernet/microsoft/mana/gdma_main.c b/drivers/net/ethernet/microsoft/mana/gdma_main.c
> index 098fbda0d128..d740d1dc43da 100644
> --- a/drivers/net/ethernet/microsoft/mana/gdma_main.c
> +++ b/drivers/net/ethernet/microsoft/mana/gdma_main.c
> @@ -167,6 +167,8 @@ static int mana_gd_query_max_resources(struct pci_dev *pdev)
>  	} else {
>  		/* If dynamic allocation is enabled we have already allocated
>  		 * hwc msi
> +		 * Also, we make sure in this case the following is always true
> +		 * (num_msix_usable - 1 HWC) <= num_online_cpus()
>  		 */
>  		gc->num_msix_usable = min(resp.max_msix, num_online_cpus() + 1);
>  	}
> @@ -1672,11 +1674,24 @@ static int irq_setup(unsigned int *irqs, unsigned int len, int node,
>  	return 0;
>  }
>  
> +/* should be called with cpus_read_lock() held */
> +static void irq_setup_linear(unsigned int *irqs, unsigned int len)
> +{
> +	int cpu;
> +
> +	for_each_online_cpu(cpu) {
> +		if (len == 0)
> +			break;
> +
> +		irq_set_affinity_and_hint(*irqs++, cpumask_of(cpu));
> +		len--;
> +	}
> +}
> +
>  static int mana_gd_setup_dyn_irqs(struct pci_dev *pdev, int nvec)
>  {
>  	struct gdma_context *gc = pci_get_drvdata(pdev);
>  	struct gdma_irq_context *gic;
> -	bool skip_first_cpu = false;
>  	int *irqs, irq, err, i;
>  
>  	irqs = kmalloc_objs(int, nvec);

So what about WARN_ON() and nvec adjustment before kmalloc?

> @@ -1722,13 +1737,31 @@ static int mana_gd_setup_dyn_irqs(struct pci_dev *pdev, int nvec)
>  	 * first CPU sibling group since they are already affinitized to HWC IRQ
>  	 */
>  	cpus_read_lock();
> -	if (gc->num_msix_usable <= num_online_cpus())
> -		skip_first_cpu = true;
> +	if (gc->num_msix_usable <= num_online_cpus()) {
> +		err = irq_setup(irqs, nvec, gc->numa_node, true);
> +		if (err) {
> +			cpus_read_unlock();
> +			goto free_irq;

One thing puzzles me: if you skip first CPU with this 'true', and the
gc->num_msix_usable == num_online_cpus(), it's one more than you can
distribute. What do I miss?

> +		}
> +	} else {
> +		/*
> +		 * When num_msix_usable are more than num_online_cpus, we try to
> +		 * make sure we are using all vcpus. In such a case NUMA or
> +		 * CPU core affinity does not matter.

If it doesn't matter, why don't you assign each IRQ to all CPUs then?
In theory, the system would have most of flexibility to balance them.

> +		 * Note: in this case the total mana IRQ should always be
> +		 * num_online_cpus + 1. The first HWC IRQ is already handled
> +		 * in HWC setup calls
> +		 * However, if CPUs went offline since num_msix_usable was
> +		 * computed, nvec count will be more than num_online_cpus().
> +		 * In such cases remaining extra IRQs will retain their default
> +		 * affinity.
> +		 */
> +		if (nvec > num_online_cpus())
> +			dev_dbg(&pdev->dev,
> +				"IRQ count %d exceeds online CPU count %d. Some IRQs will share CPU\n",

I'd better say 'some IRQs will share the default CPU', and in the
perfect world, I'd like to see:

        'The IRQs #4-12 will share the default CPU #0'

type of message.

> +				nvec, num_online_cpus());
                
It's not that straightforward as it should be. In one case 

        nvec > num_online_cpus()

is a problem, while in another - not. It looks already suspicious. So
when you throw a warning, you should mention it, I believe.

In the

        gc->num_msix_usable <= num_online_cpus()

case, when nvec is too big, would'n 'some IRQs share some CPU' just
as well? If so, you again should throw a message.

> -	err = irq_setup(irqs, nvec, gc->numa_node, skip_first_cpu);
> -	if (err) {
> -		cpus_read_unlock();
> -		goto free_irq;
> +		irq_setup_linear(irqs, nvec);
>  	}
>  
>  	cpus_read_unlock();
> 
> base-commit: e728258debd553c95d2e70f9cd97c9fde27c7130
> -- 
> 2.34.1

