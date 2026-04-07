Return-Path: <linux-hyperv+bounces-10044-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GHJoHMUC1WnOzQcAu9opvQ
	(envelope-from <linux-hyperv+bounces-10044-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 07 Apr 2026 15:12:37 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DC4DE3AEE4B
	for <lists+linux-hyperv@lfdr.de>; Tue, 07 Apr 2026 15:12:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CAB733002D5E
	for <lists+linux-hyperv@lfdr.de>; Tue,  7 Apr 2026 13:12:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 701A13B6BF1;
	Tue,  7 Apr 2026 13:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OqviYFMw"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BEBC23D2A1;
	Tue,  7 Apr 2026 13:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775567554; cv=fail; b=cS45FSElH2yPhvo9lubqyA7bMvw016qbzrr0y9B8nrDuLLAND1nyjDH64agUZ2qpxYnyVd8mYLh4DFph4vizuCWe8NBYxGhdiDNCLOa1bhKVD7N3lPdmll2hx6UI+QVRoaHqcDoP7DYj3PrefkoLToAVr3eKc4os3am23cvQWX4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775567554; c=relaxed/simple;
	bh=zKAHAiLSepWPUjKkGiN1JOm0zrfzTyilaxTDTi+adCo=;
	h=Message-ID:Date:Subject:To:References:CC:From:In-Reply-To:
	 Content-Type:MIME-Version; b=lhD8mnPLjgqpfc5WbWetmXDa7bCU29V/3qFNnbeLOdYBZ9lGvchv00PsFk0p1iYEjALIfBpsz9zs/0SVQSo/q+9wCmN1NHKKppCaSNFYZfZ5cNM6VwFwLt6jpTccCDvd3MQMw0YUOcKQuhOufBhv4oWipE+3yy+XlRqbQHrrKkI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OqviYFMw; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775567552; x=1807103552;
  h=message-id:date:subject:to:references:cc:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=zKAHAiLSepWPUjKkGiN1JOm0zrfzTyilaxTDTi+adCo=;
  b=OqviYFMwBwZntT8Tp4XTLW8Bt1cq9hCWFaC8XDCKrasMcVszzuRLEzP7
   eeHJ6aIqhwBs5BxT3t7NlYb4Eo6objRYcVAC4JNWjPIG/4xbcWDcGzhUN
   NJLXE/66m4GyQfslInXV0u7nA5HIVJAXxJzQr7174/vd+dKgyd3Ua8EPl
   KukjfYgT4gy0CLLmiyCt8N1KunrVTzZzn8tgF0pxnZ9axJBaxBh3V8/Rs
   jUqKEqs1MOWzrJNu/E5pQKDeBJyMjuxdCqC5M0k/dzWQ55NB++xwSDBHo
   sl9SRTvogWlMieL4icJX2Ehp5qrx+Tnbc2EZzshlcCepZBBMuGzEmz55S
   w==;
X-CSE-ConnectionGUID: XuMVguP7RLitgJPFjqHFEA==
X-CSE-MsgGUID: LOFS6VR2TOW04TLSEo52ng==
X-IronPort-AV: E=McAfee;i="6800,10657,11752"; a="80417907"
X-IronPort-AV: E=Sophos;i="6.23,165,1770624000"; 
   d="scan'208";a="80417907"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2026 06:12:32 -0700
X-CSE-ConnectionGUID: 7hllvlFcSTywsj8bN2MSbw==
X-CSE-MsgGUID: tgPE8lLwSaebPkX3r1fw2w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,165,1770624000"; 
   d="scan'208";a="266148361"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2026 06:12:32 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 7 Apr 2026 06:12:31 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 7 Apr 2026 06:12:31 -0700
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.38) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 7 Apr 2026 06:12:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MlWVTODIIzWEX9VDBaTTJA6CnNDMjn731f8Kt1LPh8yrBH9yWOXvAPaTLmilqf0ZNFkqfljBbCYMgQpdgOaajYFVVrn/okmgh3fswur66h7hNuh/o2mmgLKtqMnBLMJebeIO0scj+Qb8zdojO5bc973QYrYAkxNGsUNAYNJEuDhoOJzuJ+2M5cHhVPPpwA+t8K+4g0kHMZLoL2tq64ZZucEttT7wSvCCHfLNg3kmv00yC7z81otSqowVIC2Umx+j1+SMyNmK37IFc8LMGwUnEAgc0hQZq1VSneFInpVh6/kKuXS0q07zMcZ3G5a5TDbLohjjZEhFdEUNBUddg9g0FA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qi7K1KBmMN1tF04MtorM5rq3EhBiHPf0jSwxPhf0Rsc=;
 b=Hg1iY62+maCBovDUn5+oaD5Td5jCLGaJjIHzcKlmdpiflRDFeRm86cqhlNeIjEyJhTqQ+OqtAB6YAgeBNKTkFgabNoT/AaduNVUyn1lAs3W+qBm5qb+rELZtixV38qroc0Xcp9TjUrqthVX3GLSiWk56cA8F/rMoKZAN4zsHVoPSxusD4IyriQ/9ncIZZ/WNMW3HFJ9DHq9mC5Bso+8MiQIHzFGv1NmjDwpp2V1rwQ+wjdb6RqQQNJHMl5MDqzsfeuPlNWGyKdwP6YTZPXcXgB3KhpPbuS7dHe+93PgbnGzGFvYizaORnLtQE4H+GIXdSeA+cO47oxIys2cC2IiP3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by DM6PR11MB4658.namprd11.prod.outlook.com (2603:10b6:5:28f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.20; Tue, 7 Apr
 2026 13:12:26 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::6aa:411d:4bfa:619c]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::6aa:411d:4bfa:619c%5]) with mapi id 15.20.9769.020; Tue, 7 Apr 2026
 13:12:26 +0000
Message-ID: <e80b603d-8be0-4aee-8a31-c9cbb4a8ab00@intel.com>
Date: Tue, 7 Apr 2026 15:10:45 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 0/2] net: mana: add ethtool private flag for
 full-page RX buffers
To: Dipayaan Roy <dipayanroy@linux.microsoft.com>
References: <adHaF6DloRthctRb@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Content-Language: en-US
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
	<kees@kernel.org>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
In-Reply-To: <adHaF6DloRthctRb@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VIYP296CA0007.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:29d::12) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|DM6PR11MB4658:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ecb6bfe-f439-42ae-e769-08de94a75012
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: VqSufgbKWS6Qvk2w7E77CV+VOwQsZIBzLRUyWIJZMwssTAQV6IBWMZjpqpau5AjbekXFDrzG/heKbJrMdrMeQp1BaUViCmrTRU35vmfmp9bXrmD+BxsAU1NOUbAigQgsX3OydvV6V6ptiuPaPOnRQrYWpQlyYi6SAvjVPsAbpyu88eNDUyO/GsCD4hqFUdsQeTDF3xZme8St34f75wciv7NKSNoP30/Dp2vJ/9WQ5PUNkvcynxb0VnqoLFNFnZpPGcyQNlfZF15keAX6rhMMvJPCvSm8eHx7JZ1YnDgEDhGy2VOnK0bYeMp3BkC4Ghdk/ahqbDksYR0592mnbM0jFX1+XlbviJ0bpZ+AJ8nmoxXGe0ZRe0WKdiQK7jQKhHbGh1ssNVPjIPDiV7RSil7RP6U4OABhD2a+BAK/NHuTRg5neFTSJlTFz+jlTxu9oA4Yi1XfqOwRTvCrGzt9sLdgACSEI+S5leF9zayH40+oTZRe4bnbX6dvGy1H/6oatE1sBmwcZnDiMiNmzQFdsjiLyqTkAUQd9rwuKWigxONtYFMQ6LAQ9XJLo1yif3O+bIsrZQkDzIa6hmq8wyiTrekHs3hkiPkGx5g7mCqdrf7w+Fy8b2eVCxznYRPwn4aMpvdniVVK4Ktwq1wtxgB8z62FRnYFodLbHClou9e7U6jBuDGXdpx+9HOQ6fw8R/T0Xe145dpgtq7ZA+LZCnZCFkkIouLl+HiOotuskN8/oloJ/H0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aWpreXhJM3Y0RVJ1blpWU2tCZzNjYzVLTVN3UTVMUDRGRnJWRitVMUR0U3FQ?=
 =?utf-8?B?dzJtWjZNTWFFLy9ocGtRL0dNODlhY1BDQUIxZTY0Rk5Uczl0TTBqbFFjVTdz?=
 =?utf-8?B?VTA3elBIbkZuMGNqTUplNHFLQnRLVmViOWluYmR2ZDkwRXdTelJiOEhPZUpI?=
 =?utf-8?B?VjdiYnRleHFTR0JvQVVCVnRKRmxXYkhzWG0xQjZYUWMzYkozbW1oQ0RYa2dU?=
 =?utf-8?B?WlVUZENXdnU1MllPVDl0eW5CdGllVmxpQVRBWDZsYjNHSVo5Ymx5KytJblJi?=
 =?utf-8?B?OXNuLy9tOU5IREEra3FPcjJ4YzdqcUFPcExZVjM5QXNFUmVnTU9sUWEvRDdv?=
 =?utf-8?B?UnZndkJQUkRLRVBEWmQ5UXcwQVFjWVNzQkl6cllvY0JaWXJLdEplS2FoVnZS?=
 =?utf-8?B?d3BIaHFCd1lUV2tKOFRKM2RXc2RtTWwrc1Y5bm53Q0pjZm9xaXJpR0tyZk9i?=
 =?utf-8?B?Um1SVVJVRXVuNitUbHZVWG9laHh3cFdnU2ZCdEduNDU0dmRmMHZiOUltMlg2?=
 =?utf-8?B?Uk9Nb28rZitURUNFYUIwVDJWTllPNjZZZjFzNkx4NWFVWWpOR1pnTkx5OU1Z?=
 =?utf-8?B?aG1FdTVRK09MaDhkU3VSZTR1c3BCSHI3aEk1MW9pNWthWUd0VHU2bTR3bjVF?=
 =?utf-8?B?NjJmNUdsNFpOTUNzK3QydWdJbjdMMEJrQU9yNXJkcnY0QnJreEJPSGdSZGpU?=
 =?utf-8?B?Ny9KK3FkUUcvVUNLMWY1cW04OVJDZUFvZ0NPTW5hb2VXZHJFTDVjL1VEdVl6?=
 =?utf-8?B?eHBhN3VWQ1A3c3RwNU43c21CZWtvMEVMTzZVczdPWmdpQ2RCa3A4VjhBWDFE?=
 =?utf-8?B?cnF1NFhQZjBLZ2FYdzF6dHdmRm9FUGQ5WmV6Q1R6bTlJc0FNNTI3TDlYYWJo?=
 =?utf-8?B?a1BuMG9JRFNnL2V0cjlZYUVMWXFuYmUrQnlQSnptVjRXaWFLcERWaTQ3RjFl?=
 =?utf-8?B?bWpMcVl5QmdRZG16bE9lN0w2L3k3dTFTd0IzUEk5VFdvU0pJSXFTakNkMTgw?=
 =?utf-8?B?alU5d2pLVFFTUW1EU3FjNWNjZEN2dk5hNHNUMitodHMvNnA2aGtVR2VaNkJq?=
 =?utf-8?B?R3I5UXpoSTI1TEVSRXQ5U1MvbVBaNjNoU283S2E3K1U2aHM5WjhTVXpXU0FI?=
 =?utf-8?B?c2NkczRRVkJ5b2ErMFFzZWVmbVMwekdzTWdkUXdqRTR0bTAzekUvUjNSNUUx?=
 =?utf-8?B?b1VEL1d0Nk5zV3JrVlFSM1RxTnFjWWZkanZ5ZTNmaFlKWVpjMTVtQ3AvMHdB?=
 =?utf-8?B?LzcwUDFWcURabnI3bzZBZkM3ekRYcnJ4R1BmWFFjVzFuV1Z5SmFNMTV4c0pw?=
 =?utf-8?B?RWJmK1Y1ZTRZWnl6TnFoYzErTDArVWU1QzZDMUltSEgrL0psc25EdEtKeDBh?=
 =?utf-8?B?Q0NiWmtQeVkrRWd4bFdvRm12L21aM3Jaa2ZZYTJRSStBMmxxOGpWTmkyUmNG?=
 =?utf-8?B?akpmU0MvRURac2hvR3Brd3B3S1FVMHN2VXpwY0xMeW5pRXhFNjFCZ2Roa0JL?=
 =?utf-8?B?ZHhLbHJ3LzRlZU5GOGw1YXVZTTJXWG91T05Pazc1Uk0yTThBQnozN0s1UUdX?=
 =?utf-8?B?aXpZL1hRcXhKK0gxcDI0YTFaNlFaR21Yejl5M0IxNU8zRUlrSVZGbHc4QW43?=
 =?utf-8?B?NjhPOWRLc3NHQmgxZWVtcGJ3Q3Z6K1c0SEMrUXpaYldzWVBjZ0Q4NDU3aUMv?=
 =?utf-8?B?V0p5eHV6U2lvYXV2ZFB1dm1DZWRROGJOVUFtVmdDTHB6c29hR0hKNVN5cDE2?=
 =?utf-8?B?T1ZTNmhxZTVDWHFqQ1Fhalp6UkZnOTJReEZnY3ZqS1lTYU0zM3AwSCs2RWR6?=
 =?utf-8?B?UGt5Ulk5RjFjZGNZbExJN0V4RkoxQ2toNDlhNXcxT25sZWkrcUFsZE91aEF5?=
 =?utf-8?B?Zkd2cm9kbmlhWE1hbnppY0s4VnVoSnExNEU5WVNkdVVKbzZGVzh6eHdPWjh4?=
 =?utf-8?B?U1Q0aGdHRDFsRldPeFI3ZUg3aFZkcWZ1dk54TzNnVmtNMnRsNFJ3M2syaDVQ?=
 =?utf-8?B?TktlRERORk92c3FkZURWTmkxQVJKcmluVGJiTnFXK2lZT1JPUzB6WUp6SWNL?=
 =?utf-8?B?Ri9YRm1yeWVqMGFzcVFXOXJLdndrZEdyUndkNmk2b2Z4OUJUT0pOaCtxZmYr?=
 =?utf-8?B?T0p2MGw1YWdOa3gwaXhuWHp3NndMRzV6SGRnYUR6WjZ6aTQxU3JhS25aMndN?=
 =?utf-8?B?a0pER0l1cUtnbk5XYmJHS29WWTZWT3BTdy9jMWErdGZpYTh5QTBYWW9veTdN?=
 =?utf-8?B?OXoxUzJ6eTdoTHlRNjI4Qm9UVmZMQWJTYWlaUVJGbXdrUXpZV1NKbjVaNHhH?=
 =?utf-8?B?SkxNbGJabDRsL2RJaWVzSjhoYUhSTU5yQ0pVT1hjazd5ODI0ZUZXd0tLWmdi?=
 =?utf-8?Q?boODmVq9A63CRsRQ=3D?=
X-Exchange-RoutingPolicyChecked: elQ+cMHXCldyNvDbWacMfZX20Qa9htzoDPH1gFNmf4xMSuLKIL4kwVpqTXdutM+mEmUsafWn7/xLqKz7Xg+/+Zi13py0wYdpC6HhJb4b6Fcnm4UaD06ozWNexsR4LqXEbvM8g1yXZA5hci7HtrWH00GRLLbh0og2QQeGL7ukrPR28OhrhA1vS9VEtxQhB7D89o2/Axb2841RRo1jfoMiC03OIedZIq3AokFu9prUfpkr1T0KVYXyV/CXGzgaQ8hPAzd4r1NnDG2nZR9xucPosGUj8nXvNJIwtTOJYPpy8J68LvcN6mjtpQf7yNYBENlyww/+0YEeaealq1B/wGAmFQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ecb6bfe-f439-42ae-e769-08de94a75012
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2026 13:12:26.5523
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CTsj5IIA+cs29FmP1ejTDhbMZzgJRHF6xpCUWZJphk7HD23HGBV81UjCGCN8C64u3RU4uJD6vzUzHm1PtYtSuGRFAeKhhBVb8Vx4CAKF6wM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4658
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[27];
	TAGGED_FROM(0.00)[bounces-10044-lists,linux-hyperv=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:dkim,intel.com:mid];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aleksander.lobakin@intel.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: DC4DE3AEE4B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Dipayaan Roy <dipayanroy@linux.microsoft.com>
Date: Sat, 4 Apr 2026 20:42:15 -0700

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

Sorry I may've missed the previous threads.

Has this approach been discussed here? Private flags are generally
discouraged.

Alternatively, you can provide Ethtool ops to change the Rx buffer size,
so that you'd be able to set it to PAGE_SIZE on affected platforms and
the result would be the same.

> 
> There is no behavioral change by default. The flag can be persisted
> via udev rule for affected platforms.
> 
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
>  .../ethernet/microsoft/mana/mana_ethtool.c    | 164 ++++++++++++++----
>  include/net/mana/mana.h                       |   8 +
>  3 files changed, 163 insertions(+), 31 deletions(-)

Thanks,
Olek

