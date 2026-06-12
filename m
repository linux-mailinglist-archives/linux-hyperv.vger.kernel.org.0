Return-Path: <linux-hyperv+bounces-11612-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id CFkyH76gK2qrAgQAu9opvQ
	(envelope-from <linux-hyperv+bounces-11612-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 12 Jun 2026 08:01:34 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F1FB676D6C
	for <lists+linux-hyperv@lfdr.de>; Fri, 12 Jun 2026 08:01:33 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=iStm6Zz9;
	spf=pass (mail.lfdr.de: domain of "linux-hyperv+bounces-11612-lists+linux-hyperv=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-hyperv+bounces-11612-lists+linux-hyperv=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 07F3E30DA842
	for <lists+linux-hyperv@lfdr.de>; Fri, 12 Jun 2026 06:00:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F75736309C;
	Fri, 12 Jun 2026 06:00:58 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FC441DA60D;
	Fri, 12 Jun 2026 06:00:55 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781244058; cv=fail; b=fmg31WLi32rP8ATsSu2m/J9zufbhYEdhwMYss/fayE4xXREnmkOnCzPHdU2VkwP7AgCI3owJSLLrndPV3jwLaC+5Zre/2hs09CJM45nprupHwkw10X+CxLrC0hJhOAQ0UZJ1L65izkKIhUArli9c4YknNZNuYqE+IgT8I1qYt9s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781244058; c=relaxed/simple;
	bh=dXOxR4ijc/NsObkBbhOn9bAZoyECT2/85YxXHngYXzA=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=MljwXe3ReTHyA/i8x5Z/fJJqohC+heKzgAss3LLIVnP9g6CdcsTev1ZiDC+Y37MTHJV91U6PFaTULqoRamJtTSu4ykskBQJqEaoeWferjPsOmrSDF4RA8aSPPYEHf0h/sKH2aPus0eGkB87LJLDm+I32uN8O7TIZtMJVY1gKab8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iStm6Zz9; arc=fail smtp.client-ip=198.175.65.17
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781244056; x=1812780056;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=dXOxR4ijc/NsObkBbhOn9bAZoyECT2/85YxXHngYXzA=;
  b=iStm6Zz9yaptshE4YpIFUPxfq2oUjaLBNjegLidrzVonvVuUNWWP9waV
   DHKhYwaDDJ3OakKUnxJtxSIiq3i2oN/KDhC4n5/booAunZqTEWYWjYzBO
   Cvq4+5+xeu0HUZgv8KZLi88DH7OPYmEGeQal+dRuvR3xQsex4lWkJO9P8
   z00vAVQGwJvr11d8UB4ubD+DvdXdozF0FQR0VRzb6ycRaoYcaRwTKNWtz
   tlKqH6Dubsetna6iZjWK2aEs4YzvruBtVsBz8k0KcVgO/OU5tnZCSnR5p
   BWTUWCRNiN6BCvD8KsaWiFOmVZMsnVREeK2DTqCs/wb8VtJQs8DgfIhQx
   Q==;
X-CSE-ConnectionGUID: cj2r0cFeR2mFiEHfsWCjJQ==
X-CSE-MsgGUID: wHp+kdo0Rg6soUagQ+UCiA==
X-IronPort-AV: E=McAfee;i="6800,10657,11813"; a="82077025"
X-IronPort-AV: E=Sophos;i="6.24,200,1774335600"; 
   d="scan'208";a="82077025"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2026 23:00:55 -0700
X-CSE-ConnectionGUID: kovWFWvnQS2bWXbQroeznQ==
X-CSE-MsgGUID: 9WF6MeTnQUCEiLuc8JBdSQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,200,1774335600"; 
   d="scan'208";a="242602709"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2026 23:00:54 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 11 Jun 2026 23:00:54 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 11 Jun 2026 23:00:54 -0700
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.17) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 11 Jun 2026 23:00:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J1MJvtS2Lg+uRhghw01/yzBDU9mRQ777nxaVL4+HB+s6CbPMJQKABqK2U1bNvsvSzr7snMGA/I9slEvaNXooRNVgTNURve0zVXVtDz7RHPFuK/+FhWglWxDkA3egKKBshSyHB4FWx3u2w7G1ufhub51ub9MUlNBEtKnZ95YBzbmHsKvR5pW0kE80n94w8lTZwkuRIp/3aJH4PKKb/oS/ILeSCQCYDHJf2NU9LBb+gy56oIsnwkcUx7Cevw1aydfEPla9W3FhqT/wwexAiUYV8gX5Rl0/n+NlUpu2BV21wAHZKYfMq9TjVJnRa7RztuGF8bmcqDsMca9nMOj+uqroBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HkGhTXsPVJpbYXK8iN6N9ZJWNSb3tIKDqmbH6yviAqw=;
 b=E/zfa1m18EWOIROoPMxafJkg+3mijI/yM1FF+sYP3/CG1CJqH1vrZFhs+syOQTSz7c+iLiEXO5VvacOniyiEc5ofwo03C3zPhdaVXLNVLZRLpKXC8gCWrJcMzWFuMOI/i1nhHVuwDiWqN/QKqyCZvYpLq0a590r1ly2E+NVZ9qg0Yl85jtLviO/7MLpbDMjfwc+STKpUSKUDAf9ReS834aSBkAxTWTbflM4GsxKBqLyK/vOeWo0TvygBRHK07xFtXLli4Sx9iy9R25abTQICm2j8q7FrPIpGgA747SwrjeBnjyqArgeJrq6AxXePpnYTvREk31MrMas3g6gFlWWKzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5832.namprd11.prod.outlook.com (2603:10b6:510:141::7)
 by PH7PR11MB6772.namprd11.prod.outlook.com (2603:10b6:510:1b6::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.14; Fri, 12 Jun
 2026 06:00:49 +0000
Received: from PH0PR11MB5832.namprd11.prod.outlook.com
 ([fe80::106e:78dd:4c96:d707]) by PH0PR11MB5832.namprd11.prod.outlook.com
 ([fe80::106e:78dd:4c96:d707%5]) with mapi id 15.21.0113.013; Fri, 12 Jun 2026
 06:00:49 +0000
Date: Fri, 12 Jun 2026 14:00:39 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Thomas Gleixner <tglx@kernel.org>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	<x86@kernel.org>, Michael Kelley <mhklinux@outlook.com>, Radu Rendec
	<radu@rendec.net>, <linux-perf-users@vger.kernel.org>,
	<linux-hyperv@vger.kernel.org>, <linux-edac@vger.kernel.org>,
	<kvm@vger.kernel.org>, <xen-devel@lists.xenproject.org>,
	<oliver.sang@intel.com>
Subject: [tip:irq/core] [x86/irq]  2b57c69917:
 lkvs.thermal_test.sh_-t_check_pkg_interrupts.fail
Message-ID: <202606121325.97b29701-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
User-Agent: s-nail v14.9.25
X-ClientProxiedBy: SI2PR01CA0041.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::15) To PH0PR11MB5832.namprd11.prod.outlook.com
 (2603:10b6:510:141::7)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB5832:EE_|PH7PR11MB6772:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b5c27c8-68b8-4cf4-7b9f-08dec847f3d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014|23010399003|18002099003|3023799007|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: gkICd+ioPGUqdYTqehXlP0giMg7kewVKczEJe0ERMpSQfSiVyQi6qCewiHd4QTwEkDuf082Zix+BFMK0oDMzE1NXvfitTJF4/hd9z9dSFfic9PZI9thFLf3XPyc8iBPLuMlarmtaO0/eWexuljDRtLL5pwwv6AjannQ7+Khxdb0IWuNjfQFZzfYndOy27VkpyCUFfW15FcB8oxEHeGYWfStrQsHAKcb6ROnoS+KlIL6/+A2a07TSfM5AKr3vbt8TMoB7ElOjZKcvS1s13nrqG6KOPvL0eyrsBbsrygJUlBQR3l/oGoLf7rkLR1W93iTzJr0J7RSZ/ePhMSXvIyYbiq+WWdwEysGwXSFHr9fT0RsqJM1hYnHta0IVQdzJtzn+CDDa9PHo9SlbKmN1lC8Y8AuD/becNofCLgGbAt4awXE2kcD6wfn3L/ew3mlV3F0IH5BmJB3gFQCmaC1nurJ2Wu2iojnX+RZ4QLt3eZvAuS/JIVJDcvv92+00XjXPsy/NvMTBuiT7SRljmihgAsoMXB+D4eJge3f9a8J+QtW/4LFu/jfSE94wfo9Z235r9WTC1l0TC8t/vFJJYT4fpItQLikRvkQQwq8H9WPhOFXAlR+WT8fDT5z/GPHUaNJmCj88/0ujasbfSXR2fFKnvyeQVAAdl3WEYuITJSaCscIlsov4yP8M4t5vMHXIR6Hrte425GM8oXrr9Z3zkCX6LDErsA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5832.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(23010399003)(18002099003)(3023799007)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dgZ7CG7VOAcusUztYCTY3o9WUMnMch8TCh+tdFzI6P8teQ7cZUtTAakuD99C?=
 =?us-ascii?Q?y2G0D6+XBws0sFoeyGypc5cOLIjlCObmvDeCuhqLUe/PhqCZfVlwfr3EREKN?=
 =?us-ascii?Q?N7NacnWroetqBZ4kne8uUu/KnPn5JtAzcveut1LtB7QwsTJuLVI+n46dA9dq?=
 =?us-ascii?Q?8ayZOpbMY38738CHdL5zLlsph6kpnb6cpV5+OPEDsJZ9uC7MpPCSDIF5KO4V?=
 =?us-ascii?Q?l5rLdbXkq8CtvMPnRMyZl6tR9cQ8kul+nRNZgGPUt5t/pasPiYYbISEnpWcR?=
 =?us-ascii?Q?nOMajLrIDT/ed7Boadv0MQR2yeKSu9yVf/uLQhX+dbPcMMJ4apb+eVD/A+H7?=
 =?us-ascii?Q?AmffFcP+OCxF38ZJ9tB25nymTZ8qM2/QYnE2Jvvb087Dg7c5stPbjDJS2mcZ?=
 =?us-ascii?Q?2QQqZ/IBhB1VX1VmgaYg25v9GI2FxZQ958Do7hEANa1Oc0aoPgOHCMz4Q2Hk?=
 =?us-ascii?Q?oRmw4q5HyD2eOwJZgMHCGpq7ZvRp6/DJFoBsBxlyvQjy8RfZ58PprsihnKMU?=
 =?us-ascii?Q?ir4K1isqdgpyBV5jMfFYvzsQVKc9pA4kDZdXX6Nd0PuykWZym8cHpmCLoGl8?=
 =?us-ascii?Q?HA87+MeNVMkK6Jtir7phd36DQuJCRKsza6821ndtQjMuOlcBGwlQlzxX620d?=
 =?us-ascii?Q?FoAe0Vut0IlfWejm3Ng6uoVyfiYDXPZV5hf2aSt4hxLzcax/4Ai9Xouylmth?=
 =?us-ascii?Q?aNCCKrgm8XPbBIHKbpw7teVkkDgu/U9mpXd7+BkSbgvvZaSBz6FvGeh03XcG?=
 =?us-ascii?Q?Jvx1jk52Akf4RtVwysGc71daOUkZkJh+JUSyrIyun7qhVVR0AO2HKl4BdpzQ?=
 =?us-ascii?Q?ZXxzRbKEhW6d+IpdevZ+gpIMi4AlwdS06F0G+ax6IxdUZQn07vFjm0tZwiSP?=
 =?us-ascii?Q?hmzodF4g0nKtzaMRqeHLSgOGplVNUT0eDJDYNMTFcGhyXhMKAF+Sxjj2aCjp?=
 =?us-ascii?Q?olxygTfN+p7dAmqKKVJ1RtkQtytZcyV3NcQ6wkBjQtTt9WC5kAYmF5sqnhRe?=
 =?us-ascii?Q?L/oSIfnU81TaEVB5SCACgC75QZIu1Kcn0Kh5mXXEB59ftXevjY1/bID6lTxc?=
 =?us-ascii?Q?IhpgfrTnCXak42vEepF9ZJwdgnW8PsA1a03OHVz3jBzmEfEmejnLwRtm5Ae2?=
 =?us-ascii?Q?7uNhVIiK1V3QT4EfF9J8P74XNd/lpKZyluUo7xQIfRxNMg0OoyNyhIiW+hE4?=
 =?us-ascii?Q?bbBu8iQoQxCQ/Ym7tvT8yAFo6t9XbotF4tqeKpeQEHL8AYnKxNc7oSu9PX+q?=
 =?us-ascii?Q?Jd/ybJgzSOrwx1KX5hM03Tccj2zfnMiKmxCKVUT1SB8WgJMVH0SaEFo/9nJT?=
 =?us-ascii?Q?iO8dtchWC3l7bSmAs5CaIX0eiMgmZsMeO++lnXzzucaf8HjEpwthPW960Q25?=
 =?us-ascii?Q?SwBWAfjzlPNxQTmVe4xX61TxQ5usDrVuJMLnh1+lsRVVfnwQpi45+Sqa4LaS?=
 =?us-ascii?Q?s/Xk8JJ04IBLPHg+qmUPYqHKgoRC3HSTH6Prct77EsViHxOPvop//5C/kAOT?=
 =?us-ascii?Q?JL795aIvKvj2F5BetlgC85D4DAwM1KEb2Eeer7DAJwXkD1yPRodknZNCa+h+?=
 =?us-ascii?Q?vMWCNKdZFnH7acQyYYWgKvjMbbUuH0pCMsVUx/cBmgoZjHO3IRqtlpQHCqGn?=
 =?us-ascii?Q?py7QhcCVjmdcrlrFXL0ckaT3dWJ6SZ2Pht0a7pho4O97rKbOZzGVem2ZEJ6N?=
 =?us-ascii?Q?4PoXSqBdwD+ZSwsxABM4FoJh5mEgKR0/wrEE5TshNs7J7Xl53ZRmSkFt8KjJ?=
 =?us-ascii?Q?a5wAsmY7Ig=3D=3D?=
X-Exchange-RoutingPolicyChecked: qAP9X6vN40Tnr0Nvx5573pbtEi6WbcBp1kXxp3y9hqRjOy7nA+N7XHHeTkl6PjclfIXOfjR/0lphlJAafsqWbD2zSOxQ/Vrnel3tc2gpC/3S5+CAya2i/1lUbwuWB88k+v/JDWmSdI+YnR7B/h7Cwo0tMLRe9YOfYCN2DrWYBTy//RQ3CAWr/3TePk4CV3LvWVhXzLfDIXpVXhXZH0hFR6jCsjOSroWhKWnmCLJ9snBfHQCBxmiU266jMtmbnt14EBsnzLsgGtFg8whf2tanu67A0Un6cRMPcSqMzZo3evVo6ZtCDoBtL8u17jYGLByPKzfPuTpeXvWKgbaOFVl3+w==
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b5c27c8-68b8-4cf4-7b9f-08dec847f3d0
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5832.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2026 06:00:49.3861
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4jhU4hUVB+5S1nU6lDyGY0ErDSPXOtyDwfidmHubdros6F2+nR9Hs62j0GmzowaekIWVM2waSZ/UE24ef4IQsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6772
X-OriginatorOrg: intel.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11612-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:tglx@kernel.org,m:oe-lkp@lists.linux.dev,m:lkp@intel.com,m:linux-kernel@vger.kernel.org,m:x86@kernel.org,m:mhklinux@outlook.com,m:radu@rendec.net,m:linux-perf-users@vger.kernel.org,m:linux-hyperv@vger.kernel.org,m:linux-edac@vger.kernel.org,m:kvm@vger.kernel.org,m:xen-devel@lists.xenproject.org,m:oliver.sang@intel.com,s:lists@lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,01.org:url,thermal_test.sh:url];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_SENDER(0.00)[oliver.sang@intel.com,linux-hyperv@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[lists.linux.dev,intel.com,vger.kernel.org,kernel.org,outlook.com,rendec.net,lists.xenproject.org];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[oliver.sang@intel.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-hyperv];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3F1FB676D6C



Hello,

kernel test robot noticed "lkvs.thermal_test.sh_-t_check_pkg_interrupts.fail" on:

commit: 2b57c69917eeba3ee657f252257e37f31916ba2a ("x86/irq: Make irqstats array based")
https://git.kernel.org/cgit/linux/kernel/git/tip/tip.git irq/core


in testcase: lkvs
version: lkvs-x86_64-388e0c1-1_20260521
with following parameters:

	test: thermal


config: x86_64-rhel-9.4-func
compiler: gcc-14
test machine: 512 threads 4 sockets Intel(R) Xeon(R) 6768P  CPU @ 2.4GHz (Granite Rapids) with 128G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202606121325.97b29701-lkp@intel.com


2026-06-10 15:11:39 cd /lkp/benchmarks/lkvs/lkvs/BM
2026-06-10 15:11:39 ./runtests -f thermal/tests
Next run cases from thermal/tests
<<<test start - 'thermal_test.sh -t check_thermal_throttling'>>

...

/lkp/benchmarks/lkvs/lkvs/BM/thermal/thermal_test.sh: line 177: 15994 Killed                  taskset -c 0-"$NUM_CPUS" stress -c "$cpus" -t 20
<<<test end, result: PASS, duration: 41.108s>>

<<<test start - 'thermal_test.sh -t check_pkg_interrupts'>>
|0610_151221.580|ERROR| common.sh:142:die() - FATAL: die() is called by thermal_test.sh:93:pkg_interrupts()|
|0610_151221.584|ERROR| common.sh:143:die() - FATAL: Thermal event interrupts is not detected.|
<<<test end, result: FAIL, duration: 0.786s>>

Test Start Time: 2026-06-10_15-11-39
--------------------------------------------------------
Testcase                                                                     Result    Exit Value  Duration
--------                                                                     ------    ----------  --------
[RESULT][thermal_test.sh -t check_thermal_throttling]                        [PASS]    [0]         [41.108s]
[RESULT][thermal_test.sh -t check_pkg_interrupts]                            [FAIL]    [1]         [0.786s]
--------------------------------------------------------



The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20260612/202606121325.97b29701-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


