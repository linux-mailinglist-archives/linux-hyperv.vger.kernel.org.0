Return-Path: <linux-hyperv+bounces-3708-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 463CEA14E32
	for <lists+linux-hyperv@lfdr.de>; Fri, 17 Jan 2025 12:11:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A82233A030B
	for <lists+linux-hyperv@lfdr.de>; Fri, 17 Jan 2025 11:11:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F3031FCFCE;
	Fri, 17 Jan 2025 11:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V5b9YxNu"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BB051F867D;
	Fri, 17 Jan 2025 11:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737112270; cv=fail; b=Hz+HOM0Jxk3d8yFfPdTtCXQAp0u5B26/QwIX0/Fla+AFzpXBok2e4gDhuTf8zqOaawS5J5Y8oI/0+Kt/pH0lb912A1fCA+ooNuy1JtdkGGQ17a3bfQeP7XzGwK9P1ZM4pl9h13UUerP2yOwFSq/4MQvR39eHqjyYaQ1xtxC6pxQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737112270; c=relaxed/simple;
	bh=6koupgN/HSEW8tJ59c1i+OGPvu9QZUX3zXiZNS47pgA=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=SZ6Mur4keQPoNtbJ1GNpytdAXCznWqHUAKnGA0ZM0FmnXw6yFQXg/y4bU0939FYe/8mbKQgfFWcFq4G3URhjX7XOVr0DNQTD5IePey1l3C0QBjXVVx0mMBAKOQ+BffN69BAHVQFBGZRVTVhIdrQZ4m9AzAbOeut9cJdfScUYVjQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=V5b9YxNu; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737112269; x=1768648269;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=6koupgN/HSEW8tJ59c1i+OGPvu9QZUX3zXiZNS47pgA=;
  b=V5b9YxNuJWeqp13/fjAIIb2FDbpYYqL9A6gGCMyejpL0frUY+9nWryVi
   1j3UeOLuf4Xpv2CEam/0r4CkthKwhVuwZf2jND2vZxhpC0reUL0ejifZs
   PUvkHDnlXrTgox2eSEc1hkPiFx78/8gfwYoaoFx8REjAe8r88REAP8uk6
   8DJ+RGbK+Kxif0DRjYd14LPDH7ySEB72V1CVr0NDQFR5fo/oCr4pLku84
   vbDneWSZnad/Hm2WqDxMGdy+9YS08aRsaITZUA/5RJqB/h+bMd5Zw6+6E
   LvVFMJWQbR/9f7PGhqNMT1xmB5dO1YUqmnucGZPkXo49oYLcDjezcReTB
   w==;
X-CSE-ConnectionGUID: Hic1/cDITle/jaQ1A92C1A==
X-CSE-MsgGUID: +uF8cnnURuSYngEzGtgvgQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11317"; a="55089548"
X-IronPort-AV: E=Sophos;i="6.13,212,1732608000"; 
   d="scan'208";a="55089548"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2025 03:11:08 -0800
X-CSE-ConnectionGUID: xLFy0c2WRKW/FX/qrXrD1g==
X-CSE-MsgGUID: fS0q740TR8CrLBB/0R9wKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,212,1732608000"; 
   d="scan'208";a="106371087"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 17 Jan 2025 03:11:08 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Fri, 17 Jan 2025 03:11:07 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Fri, 17 Jan 2025 03:11:07 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.176)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 17 Jan 2025 03:11:06 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SbxWyz2c0eCucbgmDkc5yyEtzs7DoiBW3xRBhCVgRJeX5xtdLEKY2A5UPSCAvGELsVOwGtm07nYEl2+NypDfOrmw6d8Rkd23bMZXUaWQktOmayzlJgLwdVSGl6ns0usEkgDi65tjsixXDU8KcthyNz4VlnWv/JYopG5x77kR9VbjylYJSOb8GPGAu3z5vWdDxgCSidxQgr0AK3lKX1wcTUKWlh3lH4dvoiA5gdgKsE/oUZQb4oES0iMfMvcwOhPFUu6SJUSw6oBP/yYBLQgt5IXxFQxz6s8vUYP4oGQn7XUHq5i6AhfR33aYMtsKy8DztsdKY5YHPYhvJtijCgwiBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jt6dvY5C0pvRkl3AJtMZCdvPqvu+mjd9KjmY8Dnf5nI=;
 b=BCbgteu2aPVKIxLEtpoDmXL0HcaOyfNMcUgRv3vSNszNkpiADBRtjSi0gyeicvLCe5/wZRA2GO1SfOfzx497M/dAVwu6oDdn9jIlHDYbhz/ueCGhAIJCJPkimkivlJb9kSPLQFZFtGYmQ/Jba5edL4GdAzhA9fJ+L9gasb+SdrQsxdPeJpGHpBUWMTdZ1Rnv/bvxDGVHpQAJKVGiumiX4tAC/OsgjQ0C/nMDHYaOCW6dW7QCWWfSWH0n1neRWgdLbVJmRxj4pJWkqwNtoTQbLTFYKB3LlZjKPxPUV999zmPCPhEKh7caVw9JjqiNQWrVV8tXtKrW2uBLYzOXymhm5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by IA0PR11MB7284.namprd11.prod.outlook.com (2603:10b6:208:438::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.14; Fri, 17 Jan
 2025 11:11:03 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6%6]) with mapi id 15.20.8356.010; Fri, 17 Jan 2025
 11:11:03 +0000
Message-ID: <4f1e37f0-d72d-4748-a5e4-0ee28d33ca38@intel.com>
Date: Fri, 17 Jan 2025 12:10:52 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] hv_netvsc: Replace one-element array with flexible
 array member
To: Jakub Kicinski <kuba@kernel.org>, Roman Kisel <romank@linux.microsoft.com>
CC: Thorsten Blum <thorsten.blum@linux.dev>, "K. Y. Srinivasan"
	<kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu
	<wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	<linux-hardening@vger.kernel.org>, <linux-hyperv@vger.kernel.org>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20250116211932.139564-2-thorsten.blum@linux.dev>
 <0927ebf9-db17-49f5-a188-e0d486ae4bda@linux.microsoft.com>
 <20250116161727.19a3bbb0@kernel.org>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <20250116161727.19a3bbb0@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MI2P293CA0003.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:45::16) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|IA0PR11MB7284:EE_
X-MS-Office365-Filtering-Correlation-Id: e3ec0d9d-52e2-491c-6c7c-08dd36e7a18d
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cGtFUnNtU1pkcmFjcVI1cjFpSkhiSVA1eERuV0JienAzckZJa2NVMUoyS3ow?=
 =?utf-8?B?RHZkS0prMnRNaStvMXFkeGlGUmFNNmJyTTZKUVQwUFh3c2dmMUN6U1B6OUZu?=
 =?utf-8?B?ZVpyWW5WWVRic2pFbUhldEFja0lmeUE5MnFyMERxTVNTN3JSZ3M2YWZnYmdv?=
 =?utf-8?B?Sldac3hxenNNbVRKZXBRcEo1VGtoNHZDVU50eUNuamFFT2NnREZvSUV6Tm5U?=
 =?utf-8?B?UUErT0pEWG5IdCt3QTlWanFLNHNZbUhFdS9YVWQ3aGtKZUh6cHRnMW5Gb3ds?=
 =?utf-8?B?cVJBajV6VVJQRnl2UDRoeVZ3SkZuR01WMHN2RDFaZWwyaDkxd2ZUVWJGM1lT?=
 =?utf-8?B?cjZjK3BaRy9nbXB4cGcxWWptR0plTVZKM1M2ZnROdE5yTWNZNzg4em5ONzBE?=
 =?utf-8?B?L0NFUkowRVF1aGp2S0gzanpNTUE3TEI2eUpmSm80bFk2R3BhM2xXM0U2bXFp?=
 =?utf-8?B?N2FSMDY1MEpPZFhkRUN0aEFjWWhESHFlQ2RYNGtoTlo3TmYzdnZ3aGpNRzNv?=
 =?utf-8?B?bURMMHkxQlNuaXNDd0xidlpMYUFDNFhlUTJGTVF6UjlpcEJtNStSamlWY1Va?=
 =?utf-8?B?ZEgwdjlRRTg3L05mSmgxeHk1aW5GUmM2SExFNXJ3UFk4QzBJc3U2eVFBalMr?=
 =?utf-8?B?NC8wZVdQNVRubU1mS21WOW04TVhsdWc5ZnBtZ3BSWC9HUGxKcFRyZUdOQmwz?=
 =?utf-8?B?Zmx2VEp1SDhlTlAybDhXVmRtbFV5ZjVSd21wUkptaThURk9Fb1o2QlBaTytB?=
 =?utf-8?B?dnI1d0wxVWxOYUY1b3VSUUJPbzUrQ01ucm9tVmxpa3ptdFMwdHZEVGtPMDFD?=
 =?utf-8?B?dUhSakRiUkZ4MXVSd3ZFTHE0RCs0OTRoeTFEemN5T2ZPb3lBd1Y2aTU0SnVJ?=
 =?utf-8?B?bzl5Z2ZEeWxvckdNOGw0WUpULzM4NjcrSWE4UlZ5M0VZdnhyUmFnM3RqakNz?=
 =?utf-8?B?Q0xYdlJWZjlRQmk2dDltOUZGb1p4K09sNXJId1duY0JrSGUxY1BqQU9JKzN1?=
 =?utf-8?B?Lzh5ZmpqUi9xbE53MTNFeUpJS3NKYlRvUXh4Yzg3M0k5K1ZGeW9vRFFXMExi?=
 =?utf-8?B?STNzYnppNHgzUXhxMjNqTVNOZ2M2STh6ZzBTbVdhODZqRGhOU1JsNzByTzVB?=
 =?utf-8?B?ODBFQy9LUFNmNEFoeVpTZzhxc0VXZWVvVE0xTHlVZ2x4dUhFaVdXcUhRdnVj?=
 =?utf-8?B?Sk1pQlJOZE9DSXQxVnN3MWNUMmRoeTV6Z2hhbXp3Ynd6SWNkbzU0eTg1RUxz?=
 =?utf-8?B?bEZDSVBDM2NGbFdSY2prZ1J6RG9WcDEwUkk1dDRlSzZRNU1kMXNkVVJwV0Nu?=
 =?utf-8?B?ajBzMEg5MTk5ZVJ6VktOOGRyKzc3NUltaDJHRDB1ZUV2THYzNlRZY0ZUMVo2?=
 =?utf-8?B?bDVMVWFsTjI1VUt3WEMyWW5NMHZZZTI0eGNmdiszSVRqNG1saHVDMEVadXJj?=
 =?utf-8?B?U2ZWS3JONmRuVmV6SEdNczlaVlBDdkNGRnFXQkZNVUVVNkE1Y3lJRG43c3lx?=
 =?utf-8?B?TUlTK2RmR3p2b2hwZ24rS0czK3A3bTl2ZkZKOTVPcFlvY1Z3V1hrSGlsckJx?=
 =?utf-8?B?MXM5WkEvN1puRDliSFlYNDUzNXhxZyswSnliODFBUk1ScVJtaFpVWnI5UnF2?=
 =?utf-8?B?RGtCVzJwTFlsWjl3UURUUnNicmtpdDdQL2pUMEVLWGhSdmQzcnhXYWF5aEtZ?=
 =?utf-8?B?MFpjclN6ek94UHZKMDhCcG5OTWh4ZmRFYUMzK0RrSzJoUGdBQmN2R2ttcWpw?=
 =?utf-8?B?TUduYXRtUmVLVTc4NnpScU0rQ2R4dXhDdEV3cTdzcnFJR0pnSm0vMENSQVlR?=
 =?utf-8?B?c1AvUEExS1FUTlNsNXYrTjNpZU1YaUg1OHF5b3pRZUVubTZEZjB0RU1zVHRR?=
 =?utf-8?Q?NNF681t8jLII1?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K1NSSU40OVJpWHBGVjdISWc0M0F6aFNtVzhNc3RZMHhMNlFQb1dZblgyaDhH?=
 =?utf-8?B?VVZCeFFsRk53ME5Fekk3RHNxT3hONWxaWDBwMEZtSGY0ZkFNeHNER0NrMUxB?=
 =?utf-8?B?SG9KbWpFRklMQ3AzVTJUa1BJSUN6VXVJZmJNYTAxaWlyN1dlckNHMEMwSUdk?=
 =?utf-8?B?cmdZWU53NklWUmJCVlpRSUd5L09rRFFHdEVDRmYvMHdwVUpDQ0FaeFFEOEtU?=
 =?utf-8?B?U1NDVVlOSGM2VVZ0TEtRTE9NeTNNWHVyZnQxcDVsYzRTenA1MDZPRkZvZTNp?=
 =?utf-8?B?L3lCbGxib3dkajd6dExEK2ViS0xjcGQ4dkEvZ2ZiN2dtTFhWMFpsRFFvZmlI?=
 =?utf-8?B?RTcwbUExbzZBSFMvSXl2RDh1UGtHdW0zVG9sRFZqb3h4aFY0akY0cHNoWVkz?=
 =?utf-8?B?YTNCV1FoempZelB3NGt2Q01Yak5jLzdGeXN5bG14NFNqSjEyazRYN1ZhUUts?=
 =?utf-8?B?aFhROWtLOFpjZDdOTW4vWFRPQXNKYXJQYitBZmZSaW54U2ZROGp1ZHE4S0NI?=
 =?utf-8?B?N1J3ZENuR0F1cnRGSGt3OENaYkVudVZwaGY5azFTY3ZISmFGcDN5WGhaS0pD?=
 =?utf-8?B?WVphbE81WTBBZXFCT1lXS3VJaFpOVThINzRKdE80YnkrcjZRa3ZSbXROZkVX?=
 =?utf-8?B?Mk81WmxBajRDNW5mQnJQVitCVTUyMXd3SkM1WnR6M3lyZlM4NHBpeGFvdnJx?=
 =?utf-8?B?Um5jdDRpWmllcll3NDVDaC9ncFhnamZ1TndpUEhMbU1wMTNJMlRITDlPK0VS?=
 =?utf-8?B?NFMvbkx2dmF2RHhpSXV5enRtc0F0UW52REhaQ0NHM0UxdnZsNEpvZE53MkhZ?=
 =?utf-8?B?ZSthRDJ2UDlBcDloZmlPNzRCQnJkQlpEeUtyQlNtczBQaUg3MUNIYkFFWVVN?=
 =?utf-8?B?VGxka0tzOUwwNlVtM3BpdnFhMnQ2N1dCTnNGUkxpbmErdWt6S0dSYlA2VlJB?=
 =?utf-8?B?S0hpZklweVVrZUdtL0x2dzcyVloxNk9tcm13WENEbVhKUDRRMW9sUmovckdv?=
 =?utf-8?B?WW95K1phSnpPT2VrNnQzMWx5SmNpNzQzMGh2dzdKMjBjMmtlT2VZYWVTSldD?=
 =?utf-8?B?cGJSdWxLRUVkYlNwYnZnUzBHRmVVcnhJTmFVdmFsRXYyMUU0MUF2Q09uZVZj?=
 =?utf-8?B?VXY4dThDNmVTUVZiQXR0ZWROaW9HWUpzOG8vYVA2cDhMNHYvbTRYVUwwT0Ra?=
 =?utf-8?B?WlV5VUp5RVh1MCt3VnRJVXRGeEpSOVZLRDgzbUFxSlNzSjJOSFI0dWZ6NWpy?=
 =?utf-8?B?NW5rbHp5RGdJNHdYdWZONjVMVnVXTUwwNk1FWHNobktKWjRwQXF6RDJaQmpl?=
 =?utf-8?B?V1YrUHYxNUhtY200dWJSMHIwejU4K2cybi80S2RSbWZXd0FhWVVSZWt0anF5?=
 =?utf-8?B?dnJVMnU1TWh4WFhYanZ5QVBDQUhkR1AwS2RhZUhlcjZaOGhheUFLS0NiRmhi?=
 =?utf-8?B?UUxuZHh5NG4vWWhiUzFYaXlEdHhBa0RlaUpaL0MyQzY1L1Bqekt2V3J0YTZ5?=
 =?utf-8?B?QkNEY05rUjFpR2x5R04yZHg1Q1pqTEdVNW90b0pnaGRnNGhNamc1emp0NFA4?=
 =?utf-8?B?Q0U2RzJFSUJxS2pjNE9JQ1RDQ2dBL3VvRWdHMFpZYkxLWm1JbnhZQTFwcHpj?=
 =?utf-8?B?bzc5L21tZTAvKzJzdHA5aWJrb25IdFY0d0xSV2JuUHZyRDl5ampjbzYvajZl?=
 =?utf-8?B?cGEvdzRRT2x5VGVIRDhXU2lpZWI2MlBQUXQvSXBYL3hMZThvZHorcDhZS1pw?=
 =?utf-8?B?R3gyVXVtendpZ3FUOWdZbncreEM5TVVaZHVSdnVVT3RyZTZBaVFtK2cyWDAy?=
 =?utf-8?B?RXUvd0VMVVNtbjhtbGxzVUJsUVZaNU1UNEpkZzNnTE9VamVEaXFHaU13Q00r?=
 =?utf-8?B?UlNJQlJXUi9vdkVxVWdTeEFCSXd3QWRXL3dsZE5SN1ZmTkFhVmdERG5YbXZw?=
 =?utf-8?B?TkxnOUVJVGErQVFrTWpJV3VCNWVXVHBtcFkwZVBodG9aMVNpWWNuUDdLK1g4?=
 =?utf-8?B?SnFpRUpNQ1d1M3lMTDhHR0NqR1FsaytobGpGaUs4QlEveFU0bkt1TmdpQWtp?=
 =?utf-8?B?ZkFqditQa0x2MWlERU5BL3BEV0M2VnVjaUgvNzFKQ2pMWjZsb0FqQUVvYVU5?=
 =?utf-8?B?TlhpN2dFaW42Tzh5YStsZ3hlQ2ZiSHlpSHNrRnVWZWR6ZkNYcjNtSHNDdlNp?=
 =?utf-8?B?aGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e3ec0d9d-52e2-491c-6c7c-08dd36e7a18d
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2025 11:11:03.4022
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0i2g8h//2w+OV1yKkdFs0Omy+6GDhlZ22Bm0LjrfE6FonFEiX9phoL0fDwlPK1MXkAUJWLRG6GWG2CnnGSO0rRKRiCmU4BVHDoz6uolPGfc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7284
X-OriginatorOrg: intel.com

On 1/17/25 01:17, Jakub Kicinski wrote:
> On Thu, 16 Jan 2025 13:39:52 -0800 Roman Kisel wrote:
>> On 1/16/2025 1:19 PM, Thorsten Blum wrote:
>>> Replace the deprecated one-element array with a modern flexible array
>>> member in the struct nvsp_1_message_send_receive_buffer_complete.
>>>
>>> Use struct_size_t(,,1) instead of sizeof() to maintain the same size.

I would add a struct-specific macro or at least put the info into this
struct' doc, that "there is legacy API requirement to allocate at least
one element for the flex array member".

>>
>> Thanks!
>>
>>>
>>> Compile-tested only.
>>
>> The code change looks good to me now. I'll build a VM with this change
>> to clear my conscience (maybe the change triggers a compiler bug,
>> however unlikely that sounds) before replying with any tags. Likely next
>> Monday, but feel free to beat me to it, or perhaps, someone else will
>> tag this as reviewed by them and/or tested by them.
> 
> Doesn't look like a real bug fix, so would be good to get some signal

If the actual usage would be with more than 1 element UBSAN will
complain.

> soon. The merge window is soon so we'll likely close the trees very
> very soon ..
> 


