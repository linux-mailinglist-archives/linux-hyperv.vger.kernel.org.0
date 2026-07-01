Return-Path: <linux-hyperv+bounces-11719-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id hfxlL8QpRWpO8AoAu9opvQ
	(envelope-from <linux-hyperv+bounces-11719-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 01 Jul 2026 16:52:52 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 219AE6EF010
	for <lists+linux-hyperv@lfdr.de>; Wed, 01 Jul 2026 16:52:52 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=ibz9++zT;
	spf=pass (mail.lfdr.de: domain of "linux-hyperv+bounces-11719-lists+linux-hyperv=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-hyperv+bounces-11719-lists+linux-hyperv=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 08F60303103E
	for <lists+linux-hyperv@lfdr.de>; Wed,  1 Jul 2026 14:45:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0E923546F4;
	Wed,  1 Jul 2026 14:45:30 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E7C934678C;
	Wed,  1 Jul 2026 14:45:29 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782917130; cv=fail; b=AVVYdA9bAurCT1+TxKXWNArsRs45DTB4ZbJWT+Y4lk8pKlFKb61b53j5iWCuuyeaIA4kblp3AlhenLxsjiHxbunSpYt2Gcm/KiLOdP6dLKK9QwxCcUHQTNXgLAzTTVKRau2reEWeetXIURjzI4fsVlagI8+74VHuJEwKeEGjkWg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782917130; c=relaxed/simple;
	bh=QoYwwFOpeBMcJoVk9jzvr83+MUdeMKfpv/E0d2ef6w4=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Vlhy5Ivb4XRGJ5zvYvMMvd/hKHVDBtYGcN4JY708989+NY8sFdLp4sTPQGwxzl+7+uP21q8HMOiFsJOcT63kT4yc32rmaK8v4IVWn6VaS4O3GzEvDg63FxrPLex7uUaSDAWuiqNa/UQbdzs1cUTGQO9peDY8t2u44vNFMsKEMhg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ibz9++zT; arc=fail smtp.client-ip=198.175.65.9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782917130; x=1814453130;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=QoYwwFOpeBMcJoVk9jzvr83+MUdeMKfpv/E0d2ef6w4=;
  b=ibz9++zT7mPDdXTH+ok97pYi8tq/54pLEfYQeOfFPMYg6zz+WAbTamog
   KhCYRqGShn4UzVOCWRhVenBEskQjPWAX71jr6XN+0UYx1PME6y0UFj99K
   m9UF53xzzbVX0SGOT1ji9gNSRp8I+nbk+neBi6tmTEFonXL3zXq1yNayR
   ffhLXoYJxvGSbFSCZJa1Y1U5HC06ZFaVESiXXLfSSUk469H6x+AomNAMs
   dw7DMIaacgZ+xrz9sTCqTLaaPfSEDn9HxUBU/RwM/Rr26K73RKaYBWK+b
   vmRQiVkPLgGCJXov0zp9AxWtVHvJjWg302CRBgbOCdkX47YfP8edURwku
   Q==;
X-CSE-ConnectionGUID: zvE6MTZ2QQeaO7i4Q+m80g==
X-CSE-MsgGUID: TNYexbEGQkitWIlwi9ByTQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11834"; a="106448672"
X-IronPort-AV: E=Sophos;i="6.25,141,1779174000"; 
   d="scan'208";a="106448672"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2026 07:45:29 -0700
X-CSE-ConnectionGUID: xxSj8P+MQJW58I3/sREmJQ==
X-CSE-MsgGUID: lMbioFUXR92KHDlSQBHTnw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,141,1779174000"; 
   d="scan'208";a="256503230"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2026 07:45:29 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 1 Jul 2026 07:45:27 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Wed, 1 Jul 2026 07:45:27 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.60) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 1 Jul 2026 07:45:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qk6QQU3QMcmXbbcS3WyJczpiMZciYeaTBm504v4wuYl51A5Cw2rae90tiS3hsl047uyJXRPwIlHa3XFCRphVXtf1ZDIwLqZ4er6pIlyPk9+oWetn9p7F/zGaqNJ3gGMh+pkELjuE0jx2PKFSJq6q7DJfTjJ0XS3YVTnlV9wFP4uETR+FPRDLQHjfsgQW3vn9yBc2pndaXwFucxCdXyiZIZJ9YSnLReQJ3YFLBWQn0PYSJ+pnhWNcPdJWvEsaZH2fDwgMRnRWI7ofcimKEAc1ntZTiDcBPkN3mMnnLl4RDCqygZgicQ+UURt+83BgCpNxHGc2S7mwQfzCOkhH2IQrsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UdLHZHhm0sn2nD/ekoEqFAYbGDhWU4PWHq7tuViFppk=;
 b=gxpkrrrNGJ1OQTzIAau/EKs3CylOkNW5AxylI9sdDd6VNKRDzOl2AR7TM4C99JQqkv+sw++JFyjEzYxFLbTrTweUNZeX2W6U7bX/xezD4KYJkoHTrVoy6rN4AAmujJg/bOdkcHPtaO7zyZnaKASu3szd7BkOaJhKFwWpdchDCuI5Ar+RkphX570n6fGQC1PXZ9U/W14Tk+sUnLt8UuLM6mWIIC6ilXD4K2nBZyHFjXDwWG3Vv1Jh4G1lQeOM3Rq1YPOS/6gXKeAN18lRWLeXBzCuhwri0ZkmgCzFt9tplHYVDu7AOWHJu/2oycOtBaIylYVoaDqG5qb3XksqG5DEwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM4SPRMB0045.namprd11.prod.outlook.com (2603:10b6:8:6e::21) by
 DM4PR11MB7279.namprd11.prod.outlook.com (2603:10b6:8:109::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.16; Wed, 1 Jul 2026 14:45:24 +0000
Received: from DM4SPRMB0045.namprd11.prod.outlook.com
 ([fe80::b630:ca9c:20e1:f485]) by DM4SPRMB0045.namprd11.prod.outlook.com
 ([fe80::b630:ca9c:20e1:f485%6]) with mapi id 15.21.0181.008; Wed, 1 Jul 2026
 14:45:24 +0000
Date: Wed, 1 Jul 2026 16:45:14 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Dipayaan Roy <dipayanroy@linux.microsoft.com>
CC: <kys@microsoft.com>, <haiyangz@microsoft.com>, <wei.liu@kernel.org>,
	<decui@microsoft.com>, <andrew+netdev@lunn.ch>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<leon@kernel.org>, <longli@microsoft.com>, <kotaranov@microsoft.com>,
	<horms@kernel.org>, <shradhagupta@linux.microsoft.com>,
	<ssengar@linux.microsoft.com>, <ernis@linux.microsoft.com>,
	<shirazsaleem@microsoft.com>, <linux-hyperv@vger.kernel.org>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <stephen@networkplumber.org>,
	<jacob.e.keller@intel.com>, <dipayanroy@microsoft.com>, <leitao@debian.org>,
	<kees@kernel.org>, <john.fastabend@gmail.com>, <hawk@kernel.org>,
	<bpf@vger.kernel.org>, <daniel@iogearbox.net>, <ast@kernel.org>,
	<sdf@fomichev.me>, <yury.norov@gmail.com>, <pavan.chebbi@broadcom.com>
Subject: Re: [PATCH net-next v11 0/2] net: mana: add ethtool private flag for
 full-page RX buffers
Message-ID: <akUn+nMBrjbUts2N@boxer>
References: <20260701141808.461554-1-dipayanroy@linux.microsoft.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260701141808.461554-1-dipayanroy@linux.microsoft.com>
X-ClientProxiedBy: VIZP296CA0019.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:2a8::6) To IA1PR11MB6097.namprd11.prod.outlook.com
 (2603:10b6:208:3d7::17)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4SPRMB0045:EE_|DM4PR11MB7279:EE_
X-MS-Office365-Filtering-Correlation-Id: 29291be7-87a4-4cf9-7921-08ded77f61a6
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|7416014|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: OKLIS+uHtQwp8WRAkGBW4sa7P4iO/5CHvQDmcbViacDVRpAr1mvxUFiZxAu8NqFIMZtsgwXBgiQWvMOpLlgy6UsslQq5VF1Jrg9ML+NZkuftUH/TDofTC5LqAupuCJjqcPA+/AfoJPzZ3AYCusAxHh2OhvKS8ok4KAnTaEsjluJC5eWC/M4gZ38/AMw95BP6KXnP4EgwOmXn+MnKU8+8uyr7uNCzipInl2UEizen49I7qLpq4+ZyAH8C8XkxQrNEy4jgBKmfzm3DLV77h/R3J+rHq4PZ2hbSjiXiJ6t9Crju4OA87dM8r4OrFeHyQWBF7ot8eR/BJqzCUeApWAyMLwmO2qrlH9yYvRFvfoiSjyfgr5kcSQxOYTfqu8Y3zvA/WnXeVmi49+p5PuIK806YZ9boU+76Rtp+6peW7boG17fWclMFyiR3rmpQBXfVUMQcMe4K/nMPMqgH0KOi2NVDrBNDU5ZwZx/3SwAphcBj67kZqJIq1Jdh+w4fb+NvhXY11tgXC7NPetNw51ATnFlyfTX+b7mn5i3SnhvXf7JV8mNm6skw4aIjQZDkmCVytg7vqrm7F01yxXEhdEG0lHdJ5cdjchulI3HwKJ4D5Bc7oZGkT6kY+DzJdvEmEck8OFwhVt8gBSbtMsMuOIKAGR2/lZqQmOQZOmKlwv+7TWAF+og=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4SPRMB0045.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(7416014)(22082099003)(18002099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?aPnjF8ryTPz79zYr5vvUioetr/Q0RB/q9AXiq3l1UI8ccnAQf3LHNbnRSVyF?=
 =?us-ascii?Q?dCJxFIzvQGDms8AS4u4Wev1VYjv9HtHh0foCG33KwlcMcEJ8f8iPceRVAJPC?=
 =?us-ascii?Q?H6x/I+8Gc81wr1BOi6qKg5is8Ujkly1ttSG0FJk5VrVCmvyEmY+7LWAQzwCo?=
 =?us-ascii?Q?NBX9L1P9xVKEiS+2AxkJeZjoXCJdghtuvdXWMWolQc4fLwBf9u7pfwj41b4l?=
 =?us-ascii?Q?+z9EvkM0AtNKcFISkdnQXRQqz7r/7WM0i9LtUJxrVxs0URhszIT3H6IV+neh?=
 =?us-ascii?Q?6gkObekSPboeOWzGEV83RPf7TvVaThiRzK3d55sMQVE/uF6coV4uHK0Puyhi?=
 =?us-ascii?Q?YOl6FK/zpkIVyWSOxnVwgdC5n+E5E1WkyiMHoyhkZsTkzd1tpsr2DEIo0NMt?=
 =?us-ascii?Q?YOL/Cs+Rm0goEVH4CVFab5LuqfrpCXD7oTsi6GE2XySVzIOG8vQMvaE4WD4j?=
 =?us-ascii?Q?rGna1jRS8EiKrd7Gx3hu+e6k5vvbpi3GE6G/7WLaboQPMZVv+0jIHacHi36C?=
 =?us-ascii?Q?YHlyss4DBL0DQex9O85tUoe3KKaSFVvOBmC0972IA1qJgwZ+JiFDigMTyYit?=
 =?us-ascii?Q?0sChj80MmVS7wTZoeNgL209Kwjpfg+3fhbec3XEqKxmzwqZbkPe9/7L4dDga?=
 =?us-ascii?Q?fvNxQYnv9mnt3mqxdxJh4toVteUFf6oWtWkoHaBSkeLvqnnCuDSTeVR9Zsly?=
 =?us-ascii?Q?sczoHDEz2zDqRf9jvnbTLlQC75cab8+p8KnOc9fd/V9In0wq1pA/xgBjIWeX?=
 =?us-ascii?Q?KiHrrQHqnns4uEGhskkKOd2/NEkzwj6o5jHCVzTlXDYNXPe7Rlwb32NJhNhT?=
 =?us-ascii?Q?wYT8djmNi8ZRODvVDWwKzTicTbwk/+D7HmK1MJgK5s0VCxzItTLysIAYtP6i?=
 =?us-ascii?Q?k/zPUQNvO7ntFJEXR0DbfNdA4LLZKnBw9k+TsxmuJ4CYfqr6O9Ut5Djf1oD0?=
 =?us-ascii?Q?2t5sbjhwOrvR0RVG8cgiCEOu83aQ5VoB0Q4A+Dt+9ZmEr3YPD1PbkX+t1jEo?=
 =?us-ascii?Q?7JmqbtGlnm3LgYlUFGHKT0EzbjDP6OhGqOh/MQ/O5sV1BhzPvwyrcYnPGIYM?=
 =?us-ascii?Q?1UZoHxcmI7oMBF/bUGDp9PFhHTE8ZQ2YDk7k/BkTlPut0+ML274g5MrMPxpy?=
 =?us-ascii?Q?J6zWt8wZyGyqb7Tmt2VwIrGd7z+/m1mDCOV2L/v+cYiDZ7QOk3pQiNfxKaoe?=
 =?us-ascii?Q?mvVbxz6ZCjG8Tm9InWwsjphdqsaL0kF0nVACzcCLydG1cZVVHTHNjFZ6wLi8?=
 =?us-ascii?Q?iC29P2U9vJSpoayI87i4Njjj8WJ0JiZrp8leJwxkuVwaVlOxjTokAEWMI9Sx?=
 =?us-ascii?Q?66+Qu2wAMdb8NuCnlS/zsTYpbhXNYsPHnmdZ7578Osk32MvwRWIlISVr0bJ1?=
 =?us-ascii?Q?TemkGskFcpaMIPrtGQbGAiMsKMeQaDi2nujfgbjGraJlVbynCe+1uj2p01XP?=
 =?us-ascii?Q?MZzT0s5ToOo8ul80dsxCQPQHfFIQpyRZbfjMQh16Gsc782UzExmWjfm40hqd?=
 =?us-ascii?Q?izp3UT4YtbRn+gYJXalivRntSwR+zBqKJsi/BG+HM3OxJs4JnRSQHzkFo+Ec?=
 =?us-ascii?Q?lIihb1STXbEebEp9BpGKSZGFCjXBkl3XbCeiDuZ5xD7amja2gvGe2om3HPUS?=
 =?us-ascii?Q?/AYAODwtJDAUsoWmdH7VJcxRWGg56MsORR+xub3Q4OssvuCyzqcsQ8E1VEX3?=
 =?us-ascii?Q?sUSehV9qE9siq+2sbK4ZXBvA7PwbaC1Ivvhh0JPOa37z+ReYO2glbV2wGHT9?=
 =?us-ascii?Q?+ErUlW7q49pusMMkJZyf1i2/wRau0f8=3D?=
X-Exchange-RoutingPolicyChecked: BRcDoaP+7i4AVyaB9FigAl7jwDQGcBOHxS5WT4TxEDu5fWZ1O1igM5GO2NasaHghZPaEOYv9y+jW85BLY6rNYk1m24jFxbZ1rc1ZszWgQJgIa28hD1tvZkJ4sSVxMbYemIBEsokob3BVI0sXpiPoiIn5d1KUCLQ6401jkiQNyfEwZFm0afQgpPDUdv2R7WJ8zx+F7VuDcanK7yf35IDMRNW3U4FceZj0bbaHadp32X47Hya7cTjvukZhvRslALpWekRJ3P35PEG2a1YaOAalnEyVemC1NiqaGGkZHV1Jc+e8FpTsdyTzJzB24ZLa/MFSQl5iuJK+Ucen8Dj4/My1JQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 29291be7-87a4-4cf9-7921-08ded77f61a6
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6097.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2026 14:45:24.4259
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +3x90GBVy6uMx9KqQhK7xFCenwTWQwhGmRJ85fXhvMH4FKmL9dcnMkxZwNPDdHkJcgW6Ic0bkBA5q77+iatHlnyGg+6WFtvcMboUVQgc+ow=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7279
X-OriginatorOrg: intel.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:dipayanroy@linux.microsoft.com,m:kys@microsoft.com,m:haiyangz@microsoft.com,m:wei.liu@kernel.org,m:decui@microsoft.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:leon@kernel.org,m:longli@microsoft.com,m:kotaranov@microsoft.com,m:horms@kernel.org,m:shradhagupta@linux.microsoft.com,m:ssengar@linux.microsoft.com,m:ernis@linux.microsoft.com,m:shirazsaleem@microsoft.com,m:linux-hyperv@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:stephen@networkplumber.org,m:jacob.e.keller@intel.com,m:dipayanroy@microsoft.com,m:leitao@debian.org,m:kees@kernel.org,m:john.fastabend@gmail.com,m:hawk@kernel.org,m:bpf@vger.kernel.org,m:daniel@iogearbox.net,m:ast@kernel.org,m:sdf@fomichev.me,m:yury.norov@gmail.com,m:pavan.chebbi@broadcom.com,m:andrew@lunn.ch,m:johnfastabend@gmail.com,m:yurynorov@gmail.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11719-lists,linux-hyperv=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[35];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[maciej.fijalkowski@intel.com,linux-hyperv@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,boxer:mid];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maciej.fijalkowski@intel.com,linux-hyperv@vger.kernel.org];
	FREEMAIL_CC(0.00)[microsoft.com,kernel.org,lunn.ch,davemloft.net,google.com,redhat.com,linux.microsoft.com,vger.kernel.org,networkplumber.org,intel.com,debian.org,gmail.com,iogearbox.net,fomichev.me,broadcom.com];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DKIM_TRACE(0.00)[intel.com:+];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 219AE6EF010

On Wed, Jul 01, 2026 at 07:15:44AM -0700, Dipayaan Roy wrote:
> On some ARM64 platforms with 4K PAGE_SIZE, utilizing page_pool
> fragments for allocation in the RX refill path (~2kB buffer per fragment)
> causes 15-20% throughput regression under high connection counts
> (>16 TCP streams at 180+ Gbps). Using full-page buffers on these
> platforms shows no regression and restores line-rate performance.
> 
> This behavior is observed on a single platform; other platforms
> perform better with page_pool fragments, indicating this is not a
> page_pool issue but platform-specific.
> 
> This series adds an ethtool private flag "full-page-rx" to let the
> user opt in to one RX buffer per page:
> 
>   ethtool --set-priv-flags eth0 full-page-rx on
> 
> There is no behavioral change by default. The flag can be persisted
> via udev rule for affected platforms.

Were you able to track down what is the actual bottleneck on the 'broken'
platform? What is the performance of full-page approach on healthy
platforms? On changelog below you mention the frag approach 'outperforms'
the full-page one.

> 
> This series depends on the following fixes now merged in net-next:
>   commit 17bfe0a8c014 ("net: mana: Add NULL guards in teardown path to prevent panic on attach failure")
>   commit 5b05aa36ee24 ("net: mana: Skip redundant detach on already-detached port")
> 
> Changes in v11:
>   - Rebased on net-next
> Changes in v10:
>   - Rebased on net-next which now includes the prerequisite fixes.
>   - Recovery logic in mana_set_priv_flags() leverages the idempotent
>     mana_detach() from the merged fixes.
> Changes in v9:
>   - Added correct tree.
> Changes in v8:
>   - Fixed queue_reset_work recovery by restoring port_is_up before
>     scheduling reset so the handler can properly re-attach.
>   - Simplified "err && schedule_port_reset" to "schedule_port_reset".
> Changes in v7:
>   - Rebased onto net-next.
>   - Retained private flag approach after David Wei's testing on
>     Grace (ARM64) confirmed that fragment mode outperforms
>     full-page mode on other platforms, validating this is a
>     single-platform workaround rather than a generic issue.
> Changes in v6:
>   - Added missed maintainers.
> Changes in v5:
>   - Split prep refactor into separate patch (patch 1/2)
> Changes in v4:
>   - Dropping the smbios string parsing and add ethtool priv flag
>     to reconfigure the queues with full page rx buffers.
> Changes in v3:
>   - changed u8* to char*
> Changes in v2:
>   - separate reading string index and the string, remove inline.
> 
> Dipayaan Roy (2):
>   net: mana: refactor mana_get_strings() and mana_get_sset_count() to
>     use switch
>   net: mana: force full-page RX buffers via ethtool private flag
> 
>  drivers/net/ethernet/microsoft/mana/mana_en.c |  22 ++-
>  .../ethernet/microsoft/mana/mana_ethtool.c    | 178 +++++++++++++++---
>  include/net/mana/mana.h                       |   8 +
>  3 files changed, 177 insertions(+), 31 deletions(-)
> 
> -- 
> 2.43.0
> 
> 

