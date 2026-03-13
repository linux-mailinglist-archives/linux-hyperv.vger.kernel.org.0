Return-Path: <linux-hyperv+bounces-9407-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sNNYKAZItGk4kAAAu9opvQ
	(envelope-from <linux-hyperv+bounces-9407-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 13 Mar 2026 18:23:18 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 051292880D6
	for <lists+linux-hyperv@lfdr.de>; Fri, 13 Mar 2026 18:23:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 215EA32864FB
	for <lists+linux-hyperv@lfdr.de>; Fri, 13 Mar 2026 17:19:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B32AA3CBE87;
	Fri, 13 Mar 2026 17:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YgQL7hBl"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012026.outbound.protection.outlook.com [52.101.53.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A9CF33F8D6;
	Fri, 13 Mar 2026 17:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773422341; cv=fail; b=ui6nmm8yJZRo9DXvA4vwt4Yy5NCqFOcj+rN6mKLrxSh4Cg/a1Ds6yPPaTb5qlkq+ZhnJjubnLXhLTIg8mblh5lOcm1aeboeF7NHizStQG8U1PZKI3RgZ/eZrPVuvxIY5Yz7VIlDjdIiG9N4BL1wepZrqjSGPuf9UaGMKa6Z0GtM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773422341; c=relaxed/simple;
	bh=xX/8RS8Wyh3/idlenxIHx/OPFy81+wCednOnzaPqihs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=WGUjPM+TtMjv7MKRK8A84T1s5uKNXgW3HwQcnMXHP94z3r9IWbMV3kUw8mOI7RhGIoj1cDjlozCoyKYx8nd2SHEZsqti5C/oc4c78Eq8l4vUQXzPQmy/rlnT1q6avNNHBNfnvkSVg8tV313F2ypLJVrBQ3DC7Z8FWlacY31p6to=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YgQL7hBl; arc=fail smtp.client-ip=52.101.53.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BklGaS6W29pfAgMSk7+jDap+WGmPEW71dX4/54SXzqjoQCHYII7TCIHGpfMwcKFQCwE58B3bF3O8AOuA1+PHSuHmsblfOgLTxdtLXHeDDm8Y0/4+Xvfa4KWP6DtZwWiPspK+TAEKXFBIvrugXw2oDaCyOjCLDBMnhErwXwSG2AagW1HAyd7K1jHeXlio9a5QD232Ii6uojLsHrioRVHzUMugDFlxBs+Ubx7c5H1WGRps1QfldFBG5MQ/A0XuOVeJJtVm+PVq98wBj+fnHDbmA1ehKO8A49y0Gy7elQG5if5SxcA7qeqNSA80chIG6B8I9FKvYEISdCGqwMasaAbcMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qpqzFr6pBPXJ1gCCcGYqjkEUpGDoWBe7p+r7X9RzxGg=;
 b=i6MNiNEJVms0upOqQ2bCpnNF9ioZRxJjcQp5nox0F1ZKtRdt+X2yZp1gnuk9/ebOiWssQQmk1UYi4j6LICSHWlIHW1LP+tb4+6D4c5jfUrofYsu7IkU+qHN9SyhU3J3UZECn4cNgSGIlp8gf0XN82V3Fr6mNDJZWAPNVGZJNaCsorEgjj1UqN06AjJBKWHJXiboL4aejd6T5YvU+mI3sKE0YxXpl6ij8oSyfzrr5ztLxk4kIThmD13QSAwukY2Br64SHtHVL+2WXWqp/P8VxbYABfXex4wVWdxgQhM2xDHvTfwjT1EZbIj6WpUaaXAcAADA6+QZJIqpC9RXpyCxr5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qpqzFr6pBPXJ1gCCcGYqjkEUpGDoWBe7p+r7X9RzxGg=;
 b=YgQL7hBlWwkDj6lxTP76dLO6eveJe83vGRS0BRAAaufHrhOqA1H0rQFxddw74TTUlQA7aMPwX8mL5W/uuoIqWi4kdlyYpZ3BFm2jzfRc1wsZPgtxSfIURGRDYQh9+5fnEarDQAsjRW7J9EW2n5J+6Ecpt3ps9tuVpERexU4XUDA+PjMwSrPzjTEyZDTNKylxZXDn1uLeFQXtC3X0FAH7FDFAp//CWCmtZRxXp8IgZrxcbkvSolMZ58/RUq4magQA8rdzX9N7Vg5n8aguozSjbVxQ5PBUw34cWuLX1yGscujlfwP7Yek5FCEPNbMqWH1LVsCCSlimRh20hDor+n7bxg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by SA1PR12MB8721.namprd12.prod.outlook.com (2603:10b6:806:38d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.8; Fri, 13 Mar
 2026 17:18:56 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9654.022; Fri, 13 Mar 2026
 17:18:56 +0000
Date: Fri, 13 Mar 2026 14:18:55 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Yury Norov <ynorov@nvidia.com>
Cc: Yury Norov <yury.norov@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Eric Biggers <ebiggers@kernel.org>,
	"Jason A. Donenfeld" <Jason@zx2c4.com>,
	Ard Biesheuvel <ardb@kernel.org>, linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org, linux-cifs@vger.kernel.org,
	linux-spi@vger.kernel.org, linux-hyperv@vger.kernel.org,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Leon Romanovsky <leon@kernel.org>, Mark Brown <broonie@kernel.org>,
	Steve French <sfrench@samba.org>, Alexander Graf <graf@amazon.com>,
	Mike Rapoport <rppt@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>
Subject: Re: [PATCH] lib: count_zeros: fix 32/64-bit inconsistency in
 count_trailing_zeros()
Message-ID: <20260313171855.GA1744604@nvidia.com>
References: <20260312230817.372878-1-ynorov@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260312230817.372878-1-ynorov@nvidia.com>
X-ClientProxiedBy: BLAPR03CA0027.namprd03.prod.outlook.com
 (2603:10b6:208:32b::32) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|SA1PR12MB8721:EE_
X-MS-Office365-Filtering-Correlation-Id: 7fd6ee7e-8cdf-4f1e-afd3-08de81249b73
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	pe8N8tX1jGPd47+xxVaZmay6G6lv2Y0EG243Fze4JrfG7IRco91jRaiS5fqaxLAOSQNQSXykXYqgIXp8t0Cv/1Pn54b7SI+GsbF8ut3NNTqQ3vyAWt1KKPGjvWT+cGtkHwnNJ8j858MlFxQiW7O2xdFp4x99sJSizSDIS/lzjeOMuTpPz+t4q3xptjtE3xKwn/f/1dZj28LstKb0JfHMtmRGWPy0Jh7s7pjYfbbsYLpOBZxLrEGXjrgSZD0NUjhE4zJV3OvmoedeSyHiD3GbiH/iijD2nmYn9UfOrGGpznT3X95ppGjjNI0gE80i+Tmr5DLuywWNofv+ul/NcUHXv615HGuTLvVGCqHLsUCMZHiYLS0jg+Ro8Ioib7vDMZdZLvxNBbtbpy+Hg+vwjLSn4ugc3Z2NT9kHabtJoOWc/5UKtySskoNqx0Cqtv6jxQz3XAc3LXA4xQfoaRQkU/VmNJF8bassg8iGtWL2M7csqVzo9IUGlyPxIC9uvHQcyQT80bxNsq/ePt5VoR+AoW6Z7ajwWak45OfxN4E6NYzV0aWkwdMs/37JDpHyrTNkt04QjdzUg2Zkx992eO6yT/inIQrjE/J6KqWVZy9r8+diV7vK/5P9e2ZIDPGcw5VfuVOV27rwluTH+nXwDzYRbJ4WGP5RrfI20E+WmUVY0t+wbTFgoNJ7uJkPTphqBEsbPoqFL4jeFK3PMpLyLD2qp2VkXdn+6GCiMFr3YjV51Fb1jr0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hV5L5mWHfAqTBL0EFMGKlXddXmH3spbxcnhydP1DBbr4R5Ei9pgn+dy9gZVL?=
 =?us-ascii?Q?vUYVkNqTO1k58paYotu+IvzLYHHYdoycF5LESx2o/+qQEWsO3sB+i0rxDZTU?=
 =?us-ascii?Q?83ucvctXwZuME3khNbW2ySWzoqYuiWGwqXAllYjEO1qeG4fLsitiQLIj2iTy?=
 =?us-ascii?Q?DYOfxT92LugeFTDsxG0o1DW52XCTDwQF6fKZPqScEmuZBpyvm6Ob/jf7JLRt?=
 =?us-ascii?Q?5eTjV0TksASMdt9GhcsS2GKQHaObI310n3V/aCxwB2gj1AqczPCCTjnpHggY?=
 =?us-ascii?Q?4p+5DyDRZlVxf8VsETxK/+3dpTel1TXOOrY4hXRuU/Smg0YqcE8CS2IMQmlA?=
 =?us-ascii?Q?oqfOwV/mIFkj+VV/QSBX/DacZn93s1uiu19rMjEu37Uc3aa9U6FT1/cgDJnJ?=
 =?us-ascii?Q?XxSqYP6nXg6/L1ebhe+Lki/PSNLosNe4QJt4GwMDTqySKA9s9Q/0/sTDRKK2?=
 =?us-ascii?Q?rHLUERejTMP/aWES+H9oOfyafMQ8Cw8BbdQxKDd+M0k3NdvcI4XVkfFpjrYR?=
 =?us-ascii?Q?QUFADnNaMJEPLyaLdHwBfEXcZX0GGLL4QBtwvQhF7GrHDCHpGqm68icBMeRy?=
 =?us-ascii?Q?AaX4zCzGC51jppnqqTPGFMwD1TZLdBDi3o6SINFunEPbbeOlpoHoo6bjlr+x?=
 =?us-ascii?Q?nbPfBeNZKlexYQhk4L4rIRooUORuYGHuFWUGcJ9HAXnqj8WC++tEkl6cBaDo?=
 =?us-ascii?Q?w5upX+ps0dIyxSdw7LI4S1wj2i7Kbf/yE2ISwWkYeS4z0UTRNmdmHXxLn+VF?=
 =?us-ascii?Q?Hc8GoUnN1olzk7tBxSUSuywiegoiuF7ssNAU18jBQfU0eTJtWuNkWPxuD2Qm?=
 =?us-ascii?Q?A8LNBL326Ze3aM0/Qwfq5Xz7hNxz+ezxQhaUQHOG+j9hrV8DkpZmm0Ikq/sq?=
 =?us-ascii?Q?fuy55fPopW5GGFMixvfhW0olMfUDxchJ1615TEjb8Klwm8ng+d08VfSysc+u?=
 =?us-ascii?Q?8s0SOD6L4wIQxr1lJUS+1aZDxlbldmRQZXWcMb8KvNTLbPV/YOG5lw5Hpcux?=
 =?us-ascii?Q?xbJD3SkX9AC0ibCgBjqlNw7IDodkc085TMmCeL6cgTnENAhkc8QVwoTKrbWM?=
 =?us-ascii?Q?7BNtNdBnh/NY2zh7PAod53IOkRZji6BDkfMLiCuaLw7hG7s0sIaIY+xfsqEl?=
 =?us-ascii?Q?EDTDVWh5IzNcDlGRHJKUTtJHWc+54jFgARYgJzBhaKabnvKyBxO9tiloYKz/?=
 =?us-ascii?Q?Y0r/kHfeXW3KewheA1bQbffuhEa1smzAGyFtJH57cLtRSSe0JC3lBx7UNAa2?=
 =?us-ascii?Q?sv5zqezZHlCOs3LabH41fECZMFU66PWUPZ4tf5RXJYB0syzVFieHzh0kHSgW?=
 =?us-ascii?Q?AVH5clvWLdSedh09D8xwzjknKEdhEuFXDX5/31sUe2kSJJEWrhp12+VKaL/E?=
 =?us-ascii?Q?PWQz63nY2uewtLI6KpIESUWTBkLErtPOQ0famdT59peX/S3G00AGqsXR/sLL?=
 =?us-ascii?Q?q9D2UofyFt0YQmUbmOOeUjCqHlrB/FzuKoHrNoU4B7pBHvyWXl3pTO1hDMLV?=
 =?us-ascii?Q?JAWaKm9m4ZdwUIerzV3LaZ1oLNoY/Wqp0wzZdHU6if2F9/vu+HrVbO0ve4IV?=
 =?us-ascii?Q?rjRP0GjYhGiG2cwOTO+5mIGAgMsxRDWYANL9gmnxHph8PLl8XhdubM9Q8xW7?=
 =?us-ascii?Q?2YMDbybk+341QKgALLd4ubgOKOSqpPHfMsUM/J8EKqENkSFFkCLDhYvEAyn8?=
 =?us-ascii?Q?kEBZRlg+ZGxWV+BMbi8aUi6NICenfF2RBUAoNNrkSTv38Dwq3gDv8aUYJoqA?=
 =?us-ascii?Q?7EBeImUiBw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fd6ee7e-8cdf-4f1e-afd3-08de81249b73
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2026 17:18:56.2310
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zUo9tIVZAM686e5xdbfJ5TaQ9NMWooElACSMXeYMlCkkvqb1aej5wkB0CZ3uYobG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8721
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[20];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9407-lists,linux-hyperv=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,linux.intel.com,rasmusvillemoes.dk,kernel.org,zx2c4.com,vger.kernel.org,lists.infradead.org,microsoft.com,samba.org,amazon.com,soleen.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@nvidia.com,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-hyperv];
	MID_RHS_MATCH_FROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:mid]
X-Rspamd-Queue-Id: 051292880D6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Mar 12, 2026 at 07:08:16PM -0400, Yury Norov wrote:
> Based on 'sizeof(x) == 4' condition, in 32-bit case the function is wired
> to ffs(), while in 64-bit case to __ffs(). The difference is substantial:
> ffs(x) == __ffs(x) + 1. Also, ffs(0) == 0, while __ffs(0) is undefined.
> 
> The 32-bit behaviour is inconsistent with the function description, so it
> needs to get fixed.
> 
> There are 9 individual users for the function in 6 different subsystems.
> Some arches and drivers are 64-bit only:
>  - arch/loongarch/kvm/intc/eiointc.c;
>  - drivers/hv/mshv_vtl_main.c;
>  - kernel/liveupdate/kexec_handover.c;
> 
> The others are:
>  - ib_umem_find_best_pgsz(): as per comment, __ffs() should be correct;

So long as 32 bit works the same as 64 bit it is correct for ib

Jason

