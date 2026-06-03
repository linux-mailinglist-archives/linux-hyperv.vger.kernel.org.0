Return-Path: <linux-hyperv+bounces-11471-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id qNeJHoOhIGoH6AAAu9opvQ
	(envelope-from <linux-hyperv+bounces-11471-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 03 Jun 2026 23:49:55 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3874663B75F
	for <lists+linux-hyperv@lfdr.de>; Wed, 03 Jun 2026 23:49:54 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=G6O2K0VW;
	spf=pass (mail.lfdr.de: domain of "linux-hyperv+bounces-11471-lists+linux-hyperv=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-hyperv+bounces-11471-lists+linux-hyperv=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 590423014A06
	for <lists+linux-hyperv@lfdr.de>; Wed,  3 Jun 2026 21:49:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FEA04C6EF8;
	Wed,  3 Jun 2026 21:49:49 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58CDA3D47D0;
	Wed,  3 Jun 2026 21:49:44 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780523388; cv=fail; b=J/+QA8z+Ayi7Nhrd7Y4YiodcvNhhgGrLGxZyxMSqH1OitHsrkyoMtKgtWaqWwJCbZY5HQezeTcVmczQpO0kykUur9ou6Y0jIxW4e5odUz4e4ibhi8WDD9YOb8yN7ExSyBrf6qFE2USOfJdEz77ForrW45k7/TLEzhXxd+PW2nd4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780523388; c=relaxed/simple;
	bh=SA9hxWvggWOnLU+3cl8hg8y9UKFpgbp19poBE8z2K0g=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=EYIy8LyZBnKhJaFyxPLOTQieQ7sa+i1raA0wA2kQM+4c5SPd9rozBhuZgoXtPiEs1KENqzPS1rdICyLUHxYj5Npj9+y2UUveWGeDIKf0vLz+C209nb3YAox+Afb/C0sizWS2iqjdMuGGuWK24njAN/6skvKlHoT12gZ4mi6fG8k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=G6O2K0VW; arc=fail smtp.client-ip=192.198.163.12
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780523385; x=1812059385;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=SA9hxWvggWOnLU+3cl8hg8y9UKFpgbp19poBE8z2K0g=;
  b=G6O2K0VWHe9euJOUtNE6RgjKwvEDiXRrk9P82AukAhCqKFifT/bcnuSf
   F/e4mk5wHDCogJYHQQMMvnqyAK6nFwtWRcHQUc0QThTPgaFdhgTo05mwn
   RDWOiK8N247oCSONj/EhIOSxaEqrHwEiMxAuIW6ewhrRXqLSry5qTfo2s
   7AsLhSEK3tv4b945F0eJ7CxKmpxZl7TEWAu2RyqgRg2uqCfP4FTdqzNet
   6PcyVkArEIdc1NoJnnTefnRCpZSyp05l7wKlGkkUwVZDPm1MM0DYXy7aD
   MRNZ3uyuZQOvqd7diGTGZN70MZJjyuaSMLa6pPg1/ZFHnfyrkXq8l3AmD
   A==;
X-CSE-ConnectionGUID: RsO9dBqLQZuB8Cn5FjtTKw==
X-CSE-MsgGUID: nLMreYcuQ3Wvbn/LrE85mQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11806"; a="85199239"
X-IronPort-AV: E=Sophos;i="6.24,185,1774335600"; 
   d="scan'208";a="85199239"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2026 14:49:43 -0700
X-CSE-ConnectionGUID: e9kP1NdcSJeVTMFKM/t7Kw==
X-CSE-MsgGUID: VmpNxNjpQBaw6z9w1kb7Fg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,185,1774335600"; 
   d="scan'208";a="249448365"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2026 14:49:37 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 3 Jun 2026 14:49:36 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 3 Jun 2026 14:49:36 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.20) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 3 Jun 2026 14:49:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fdQRW1vroKV/8kVaJsiUS0gC0dfjF8DKdUY5BZQaXybIB6ktGNwpzPbFvagNSvxjD6KCIxWP8S1Xo/BRFZtJ5CVnqbvgxVbl0zLctVzIIIHnUWSw/hDfLAsSrrY+aWD4Uz8Rx/tEY/huNG9dfbipBbhWKpTiJelygqWMlhrHW32WqmsIGvQ4Nezhyo5wkCOtKwz8RX+eX0kYiTZ1vYvtjiiUxi/e+UL0diuCZJow7c5S9GIxnYMJ1VTZIgLCohY4zZQ/Pk/EPLfWZEvsPeYrLbAzjN897ZekOnuse38RSb6jwPz6bQobszEzaeWngtJZcZVrB6MPSPF3DwNSNHxOaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bj4GrEBFmOrYrc+ypnMKDh/4jXCFmoB3vU57xW9wwoI=;
 b=to+V+G62qrlUnmS9pmeHkn9tWZfwinhxwaXlc+iR1WcqtInNQmdW8JcpibHqHCg2tz1cIImBpfn2XlmYE/Sprp5bNeKdaBUfaIcTCJ1erS7e5dQNQids2RooC9GVbji0kFjxfUNNLuyPwUCERILG0DpcyeWRbquFlgLSpl2wGJICvi1KZnDaTriXAxYcv0+q2ShYhiR2yC6oREsCLktlQZUKhr5yvefGlA3/Zl1FC4Ci6RAob3Gx6mEAdKtB89I1p1xH1GOc+tyIALPb/yXqdpHWbe+Vm9tuHzyGdz45JjcdcIEdQLeUijcODjVAYzfjlKnn25EpwJWYJv73cMEGPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB7381.namprd11.prod.outlook.com (2603:10b6:8:134::14)
 by DM4PR11MB8227.namprd11.prod.outlook.com (2603:10b6:8:184::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Wed, 3 Jun 2026
 21:49:28 +0000
Received: from DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58]) by DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58%5]) with mapi id 15.21.0092.006; Wed, 3 Jun 2026
 21:49:28 +0000
Message-ID: <10988db9-8a8d-4ad0-917e-317dd4b20253@intel.com>
Date: Wed, 3 Jun 2026 14:49:24 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3] net: mana: Optimize irq affinity for low vcpu
 configs
To: Shradha Gupta <shradhagupta@linux.microsoft.com>, Dexuan Cui
	<decui@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Haiyang Zhang
	<haiyangz@microsoft.com>, "K. Y. Srinivasan" <kys@microsoft.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Konstantin Taranov <kotaranov@microsoft.com>, "Simon
 Horman" <horms@kernel.org>, Erni Sri Satya Vennela
	<ernis@linux.microsoft.com>, Dipayaan Roy <dipayanroy@linux.microsoft.com>,
	Shiraz Saleem <shirazsaleem@microsoft.com>, Michael Kelley
	<mhklinux@outlook.com>, Long Li <longli@microsoft.com>, Yury Norov
	<yury.norov@gmail.com>
CC: <linux-hyperv@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>, Paul Rosswurm <paulros@microsoft.com>, "Shradha
 Gupta" <shradhagupta@microsoft.com>, Saurabh Singh Sengar
	<ssengar@microsoft.com>, <stable@vger.kernel.org>
References: <20260601102749.1768304-1-shradhagupta@linux.microsoft.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20260601102749.1768304-1-shradhagupta@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0094.namprd04.prod.outlook.com
 (2603:10b6:303:83::9) To DS0PR11MB7381.namprd11.prod.outlook.com
 (2603:10b6:8:134::14)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7381:EE_|DM4PR11MB8227:EE_
X-MS-Office365-Filtering-Correlation-Id: 49a55832-f4be-4590-c86c-08dec1b9fc6a
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024|921020|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: 4KBaYxA+OuRlakN/T7jfBcnHif988AbxujmgOwoNrA7pboXrLawxqW0vFRIv+3M8Mni5TZtuwuvmzFhZsCh8gaNgg2nps8P+y5MbISmxiKvSSaEDG+1QHw9tY3B0H96sHivokfZrhnIXN3B5qIZT1Sz2x+UpL5imsQvjs/VJQjre5X40ijOupBTXZW8xONJGwPyxczihQbeUgCpUL6BmGiIvmdfUrcTJ9bxpvvfCWm5IXH5IyfsFTcxFK6LU7yPa4u1irs9Weo+lgP4ZhVmcLibNab5C/TD4ydc0O2J+t/Ygs2x3lRlm2oN6UUR4NnSmFL2pGqprSDWnLIFrbCcYTaXF5moU5OpjDdxmEbnCoXkBCSRkXnWU5qXjKFd2F38/wJLQxfIXLMo5xrjq1XH/Tq1UR/Y2tBID8Jo/MjxRxXYCiO+DEwUvU1AzTEXYtgaQajdG9nHpzLlCEtVEfDnF1KYqeLAEbgc6+NG/VrgPaG2lyz8JMS5gVb9nPpA1Vefp24bGPDASqpCXDzpteRtBfmLNdid3Q03hQY0UHZK1aLyVxPhWK90NwxzrJvgyiEYPk2KfXIkcuN2j20X0UjdyHEli4tcIzNBbT7gH1h0ddyfB8Uv3FQtTVd4VxgIvO2/CP/riFMGsYyuuiLKY9H/yat2OQFPE/zxfy331nB0S/BQ1MobsxZHc4OhhaY3L5lB72xwB/pFX+CykBHyPNMB34zYXErXA9iNxxi8hiXCbp2Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7381.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(921020)(18002099003)(22082099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NWJ6WUszYkZUVjh3ZEM3RmlHTndlUllDd1d0S3RuRGVOSENLYXpWOVc3TVQz?=
 =?utf-8?B?d1E5RG9NUmtPRkNCNUlJMi9namZmb29LZFNYMGNFekZnNUg1aHhmOXVod1hQ?=
 =?utf-8?B?UGJDVk15TG5DRUFnOFVRc2NtQ3lZR291dlhja2JXek5maHFqMTZZbTA5SHhk?=
 =?utf-8?B?VE10UHhLTllCL1V3S0c5cXZGeGFWZ0dLdlZmMG0vM2VaT2hITnJJSnZXcldw?=
 =?utf-8?B?VXNTRDJtWEQ2a1pSZnhoVTFKcm9xR2swYUF2d1dORG5XSm1aaHpUME5qWldW?=
 =?utf-8?B?S1BtZmsrNENQN3JGcXN4bVNjVWRxNkR4bEQwUDZjdWNiYUJ0d1Q2ZFdUbEJn?=
 =?utf-8?B?QzgxTHA4RStkcVZacldVRmdiLzNtK0M5eUJpS1VsbGVCa1ZORzFWUzM3WWN3?=
 =?utf-8?B?cWh3cjV5Y2p0ak9BMW12MWpEc2pRZk9ORHhQVzVPVSt0VURiRUE3OFFaNzNL?=
 =?utf-8?B?aHRQVzhrYzc2Nkx1WjYyTWtpS011OUFBOFVMTmZWNm5HUzBJQXdONzhBQ3pM?=
 =?utf-8?B?a000UndhblQySHVQamxGVFFFYWxEa3I2YU1xMWhSN0RaUHZlRUp6azFxeG1l?=
 =?utf-8?B?NmdOcmpTekxIVitYVncrWnU4dHBIZW1mRUJaUTlYaXFrb0pNN2V5WThlM0JJ?=
 =?utf-8?B?MU94NFgxOGZQRWZ2aUtOZUE1RXRtQWlKOTVVV2JvQ0xmVERnTDA5Wno5MnNF?=
 =?utf-8?B?eE9aYTM1aGZ5SnpmeStwTThiZHUyR25sWWdtUlNPRGgwNElBTDZBTzhPajlM?=
 =?utf-8?B?dGFRM0pXNUp6RUFka3pKMEVXVHlTbU5hQ2hueXdteG5UK0NuWHlPVkxhWk8y?=
 =?utf-8?B?Z21MNlRFLzlKWmhnRXpiVG84NTljVVcvSXVQSVRsVWM3VWVhaEhDam4wVXdI?=
 =?utf-8?B?WTZGd0M0MysrUndsam0reHJ1a2h3Y29qRlNrdnRxakhCT2t3aHFqbmRCU3Jh?=
 =?utf-8?B?YlF4WUJac2g5eXBVS2krT0pXVVp6QTNvcmdDZmtZa2ZOcUxpVnNlRDNyOWxs?=
 =?utf-8?B?aWt4RlR3aVlYaDJBZFZRdVdiZTZqSXM0S2s4cEVhSGRoaTlrTERUV3hsczNT?=
 =?utf-8?B?QjgxY0cxbGthY1gxVzdrSFd5Z1A5citjclNCS1AxREtFUTJwVDRWZ25ZbXJI?=
 =?utf-8?B?c3Uzdi9KT2d4bzNRVkJUZldPWno2bUZOWkxZWlJRR0dST1pBMVlmYW41NkM2?=
 =?utf-8?B?UGd1UGo3ZjRhTmt6cnhkNlYrczM3cWVYMCtNNk45UnBlbzFXWGlveitqalJC?=
 =?utf-8?B?TGJpYUk1TmlGdDdDcDJDbWl4UWtRajBTbSs5UVR4QUpBdWYrZjVaV3hoeUEv?=
 =?utf-8?B?YVZHSlpTSGE2V0dxTWhmT01PVXJ2K0RIT1BwNUxHbUNMNnRQNUZWM0dFMCs2?=
 =?utf-8?B?SFdxL0RvVjJCbFVVWm1wU1U4bW9zRnBzQ05NdEpGbnhJMUtTUGMvbG5ENjFu?=
 =?utf-8?B?Q3dnNlZtMFVqS1F5cmFDWEZPQnNQZHRrdFdFYzFmdTlXS01yVW5DcHFJcGxZ?=
 =?utf-8?B?SnNrY2krbUdvK3czMmNUc1NjSk5Jc2Uyb0pvK0wxdk9aQU1SY0hFdjM4dDNP?=
 =?utf-8?B?bXpvTzdmWGY0cVVzcTdoZG9ydDNTcExvR2VJSzE2WGJuWFNiSFFkdGRwZmdv?=
 =?utf-8?B?OGlFbXpJNWVOTnRTVGRSYVAraEZyQTlGOElabGl3NC91R3BoR1V4NFZDaWhP?=
 =?utf-8?B?NFpqZ29pSFB2OVVydUpEcUZZR1A3eUZlVWxGaDlqMGE3UlpIUkh5NERrWnl5?=
 =?utf-8?B?M01jYmxDa05rMk1Zb0o1USthU0RrZHVIK3RmNTlvdWFGUVRVSnpEU0ZJclF6?=
 =?utf-8?B?ZjRscEltYUZkRnVpS2xGWTE1bXpha0MzdTZDMXo5Z1hvM29ySklhK1VvYzdG?=
 =?utf-8?B?WmxCQ1UyYXJ1bFdYZ2J1a2RCWUQ3U21wM013c2haeFRmWS9BZkJ2QXFVamND?=
 =?utf-8?B?YzRBL1VjT3BiTnBoOUc3aXROcWgxdVRBL1ZvUjMyNnRKMTUzS3JFZ2NmWDRC?=
 =?utf-8?B?ZUIxS0RieVE2cDAyZzFCcVMvZkt2aDR3cVZqWlQ3ZkdmV2pLemlGbWFRbUNn?=
 =?utf-8?B?amVPRFgwN0hzMDhVcjd1VC9xbWVidHVsZ0VuU0RGZzBlYkpYZEV4Z2N6aUFq?=
 =?utf-8?B?ejhiWkl3NkpIZUhwUStlT2J4NTVoTCtkUnN6NzN5bE1lYWR1OExkSXJIVnpM?=
 =?utf-8?B?aTBYQWlTTWg0d1BvbDNyNlh5OXFJL1BKM1NtbzJZWWMxWmxwaGlLSjJQcEpV?=
 =?utf-8?B?azhkeDc2Q3oza3Rzd1JpajJXd1FwVm9KbFZKd1NtbW9yV2ZINmNnbVFxNTZT?=
 =?utf-8?B?dXlKVlh2QXNobkFSMFBWMUxKczRnSzRldGVHUEQ3eWc2MkcvT3l2ZHdXeVhv?=
 =?utf-8?Q?8V8GrZIy9NEI1OE8=3D?=
X-Exchange-RoutingPolicyChecked: tNelRBUFY+vmA/rxi6PuRZvrIbVt4O01XB/CLRj+vVGRo/0gTxAhPJLFQQhURtziYaQvYgRtXDlQgJtwo14oSfRCcvxW+ZuVGorifNsmOstUioEDBNryubC0r4tcN96j/CabmXpiXr2lLfIDJFQi1djb9PtTX3tCZ6KV5PEbvB/vmcDLByiSVb6b6gICKm383dc6sSR6E8XNzhuRIvMOeZ+eVQrKdaLHRVq3jb3xbZS/UhGzqwgYytUHpWsZhNPfOgPf4ptoOvfR1RG4ofTe0yCmq1eQ8gX5UxYR4OYgOmE22gI9kHlfuZ8qPQz1Dgp+l6b3f1+QmJxoCZwgdT453Q==
X-MS-Exchange-CrossTenant-Network-Message-Id: 49a55832-f4be-4590-c86c-08dec1b9fc6a
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7381.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2026 21:49:28.2667
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PljLpImBrp3bbWvjd5jFL5b1aHSaOs4zmwKetSzcRqORu87WG6RoBINU74Sr4b4SqHSiofOXYKbcRvB9wEw/+tiDvyMto4ZxFjz7kazRVgA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB8227
X-OriginatorOrg: intel.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[25];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11471-lists,linux-hyperv=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[linux.microsoft.com,microsoft.com,kernel.org,lunn.ch,davemloft.net,google.com,redhat.com,outlook.com,gmail.com];
	FORGED_RECIPIENTS(0.00)[m:shradhagupta@linux.microsoft.com,m:decui@microsoft.com,m:wei.liu@kernel.org,m:haiyangz@microsoft.com,m:kys@microsoft.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:kotaranov@microsoft.com,m:horms@kernel.org,m:ernis@linux.microsoft.com,m:dipayanroy@linux.microsoft.com,m:shirazsaleem@microsoft.com,m:mhklinux@outlook.com,m:longli@microsoft.com,m:yury.norov@gmail.com,m:linux-hyperv@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:paulros@microsoft.com,m:shradhagupta@microsoft.com,m:ssengar@microsoft.com,m:stable@vger.kernel.org,m:andrew@lunn.ch,m:yurynorov@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[jacob.e.keller@intel.com,linux-hyperv@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,intel.com:mid,intel.com:from_mime,intel.com:dkim,vger.kernel.org:from_smtp];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jacob.e.keller@intel.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3874663B75F

On 6/1/2026 3:27 AM, Shradha Gupta wrote:
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
> Reviewed-by: Simon Horman <horms@kernel.org>
> ---
> Changes in v3
>  * Optimize the comments in mana_gd_setup_dyn_irqs()
>  * add more details in the dev_dbg for extra IRQs 
> ---
> Changes in v2
>  * Removed the unused skip_first_cpu variable
>  * fixed exit condition in irq_setup_linear() with len == 0
>  * changed return type of irq_setup_linear() as it will always be 0
>  * removed the unnecessary rcu_read_lock() in irq_setup_linear()
>  * added appropriate comments to indicate expected behaviour when
>    IRQs are more than or equal to num_online_cpus()
> ---
>  .../net/ethernet/microsoft/mana/gdma_main.c   | 60 ++++++++++++++++---
>  1 file changed, 53 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/net/ethernet/microsoft/mana/gdma_main.c b/drivers/net/ethernet/microsoft/mana/gdma_main.c
> index 712a0881d720..00a28b3ca0a6 100644
> --- a/drivers/net/ethernet/microsoft/mana/gdma_main.c
> +++ b/drivers/net/ethernet/microsoft/mana/gdma_main.c
> @@ -197,6 +197,8 @@ static int mana_gd_query_max_resources(struct pci_dev *pdev)
>  	} else {
>  		/* If dynamic allocation is enabled we have already allocated
>  		 * hwc msi
> +		 * Also, we make sure in this case the following is always true
> +		 * (num_msix_usable - 1 HWC) <= num_online_cpus()
>  		 */
>  		gc->num_msix_usable = min(resp.max_msix, num_online_cpus() + 1);
>  	}
> @@ -1717,11 +1719,24 @@ static int irq_setup(unsigned int *irqs, unsigned int len, int node,
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

I would find all of this a bit easier to follow if irq_setup_linear()
and irq_setup() had a mana prefix so it was more obvious these are
specific to the driver. Of course irq_setup is pre-existing, and its not
my driver so do as you will :)

> +
>  static int mana_gd_setup_dyn_irqs(struct pci_dev *pdev, int nvec)
>  {
>  	struct gdma_context *gc = pci_get_drvdata(pdev);
>  	struct gdma_irq_context *gic;
> -	bool skip_first_cpu = false;
>  	int *irqs, irq, err, i;
>  
>  	irqs = kmalloc_objs(int, nvec);
> @@ -1729,6 +1744,8 @@ static int mana_gd_setup_dyn_irqs(struct pci_dev *pdev, int nvec)
>  		return -ENOMEM;
>  
>  	/*
> +	 * In this function, num_msix_usable = HWC IRQ + Queue IRQ.
> +	 * nvec is only Queue IRQ (HWC already setup).
>  	 * While processing the next pci irq vector, we start with index 1,
>  	 * as IRQ vector at index 0 is already processed for HWC.
>  	 * However, the population of irqs array starts with index 0, to be
> @@ -1767,13 +1784,42 @@ static int mana_gd_setup_dyn_irqs(struct pci_dev *pdev, int nvec)
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
> +		}
> +	} else {
> +		/*
> +		 * When num_msix_usable are more than num_online_cpus, our
> +		 * queue IRQs should be equal to num of online vCPUs.
> +		 * We try to make sure queue IRQs spread across all vCPUs.
> +		 * In such a case NUMA or CPU core affinity does not matter.
> +		 * Note: in this case the total mana IRQ should always be
> +		 * num_online_cpus + 1. The first HWC IRQ is already handled
> +		 * in HWC setup calls
> +		 * However, if CPUs went offline since num_msix_usable was
> +		 * computed, queue IRQs will be more than num_online_cpus().
> +		 * In such cases remaining extra IRQs will retain their default
> +		 * affinity.
> +		 */
> +		int first_unassigned = num_online_cpus();
> +		if (nvec > first_unassigned) {
> +			char buf[32];
> +
> +			if (first_unassigned == nvec - 1)
> +				snprintf(buf, sizeof(buf), "%d",
> +					 first_unassigned);
> +			else
> +				snprintf(buf, sizeof(buf), "%d-%d",
> +					 first_unassigned, nvec - 1);
> +
> +			dev_dbg(&pdev->dev,
> +				"MANA IRQ indices #%s will retain the default CPU affinity\n", buf);
> +		}
>  
> -	err = irq_setup(irqs, nvec, gc->numa_node, skip_first_cpu);
> -	if (err) {
> -		cpus_read_unlock();
> -		goto free_irq;
> +		irq_setup_linear(irqs, nvec);

irq_setup() doesn't have a driver prefix, but is actually a static
function in gdma_main.c, so its implementation is specific to this
driver despite its name.

So if I understand this change correctly, if the number of usable MSI-X
vectors is smaller than the number of CPUs, you contineu to use the
current irq_setup logic.. otherwise you switch to the simpler "linear"
logic.

I guess this means the logic and heuristic used in irq_setup() breaks
down when the number of vectors is large and number of vCPU is small?

Makes sense.

>  	}
>  
>  	cpus_read_unlock();
> 
> base-commit: 8415598365503ced2e3d019491b0a2756c85c494


