Return-Path: <linux-hyperv+bounces-11493-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id P4mRCYLHIWqPNQEAu9opvQ
	(envelope-from <linux-hyperv+bounces-11493-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 04 Jun 2026 20:44:18 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 756A2642A38
	for <lists+linux-hyperv@lfdr.de>; Thu, 04 Jun 2026 20:44:17 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=GYz1+Ui4;
	spf=pass (mail.lfdr.de: domain of "linux-hyperv+bounces-11493-lists+linux-hyperv=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-hyperv+bounces-11493-lists+linux-hyperv=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 90A38301C159
	for <lists+linux-hyperv@lfdr.de>; Thu,  4 Jun 2026 18:40:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE12639EF3D;
	Thu,  4 Jun 2026 18:40:56 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26E5A72627;
	Thu,  4 Jun 2026 18:40:53 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780598456; cv=fail; b=BCkPyIw0+pDv6Q5NRXuPHKAscMhq32nabRyxNguunaIL0De6Hst4oOBRHvEWXmw0aCJ1Aht0b8fT8lOZeZP24rmfgJDj0ZDAxY1d+pElSoLnLbc7l4FIoHdxPqGM3xX5dzgGlVBp6YPa3QvLvCSaWJfB9qJGvqf2qZIjfKzNPDI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780598456; c=relaxed/simple;
	bh=IN61uVAbd7VIObYHJLiZfVg0E6+W+ySpuCDtxdUMP+M=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dcZugVl0asmlAAcXkjc2qAIHXuzXz4SSYo8g7IwsaYgl0ItJCfpTM9hJA3a/eeXqBV9tkwjiInNFRBl1RkC6eDh6ayRxeZEqYDwqZVhc7kcaPTsF5rwyZpjIeiQoEzJsJbi8gRCVHxK5RmwVZX66kxoqGk+Jc3T/g+KUCfm1wKA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GYz1+Ui4; arc=fail smtp.client-ip=192.198.163.8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780598454; x=1812134454;
  h=message-id:date:subject:to:references:from:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=IN61uVAbd7VIObYHJLiZfVg0E6+W+ySpuCDtxdUMP+M=;
  b=GYz1+Ui4c6WYDJYNI3lVu+xhiF8yxSENv3aWqcB4MgyBQywaGxPWCnEP
   Tfr51BTDtPeAUhdDw8mMSWqkZSvC+ZYcOstMZ0T2cC2Du7zdFfcqf6Nb3
   2o7D2eTWaeuLLU/C8z3KlR10HIyknsx7+DWaA5IxgLs97Dn5F0qHy2sHF
   HsYLLJtxpwt8BfkHlUqH0wJ2O0iAu5aMZgoQX470vIWWGr1CfLFt36V+B
   73ROpAnZrB3WVX9UpbTY5FsfMzitAqOnzPRoxgiaA9UPUEZF9/kPJJSWC
   4vxhvQN5fWTMBE4GxA57HskhVfTTSY6ItZdI0kd8hppJszBNuf9EH0Saz
   g==;
X-CSE-ConnectionGUID: fN30APAqRqi60HMg55NLyw==
X-CSE-MsgGUID: pQ0wO5itRq63WPEZXLiV3A==
X-IronPort-AV: E=McAfee;i="6800,10657,11807"; a="99005470"
X-IronPort-AV: E=Sophos;i="6.24,187,1774335600"; 
   d="scan'208";a="99005470"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2026 11:40:44 -0700
X-CSE-ConnectionGUID: AwjPgEj/TDqxOiPzCN94BQ==
X-CSE-MsgGUID: EUqfU9mjSUaBwlj4R7hLEw==
X-ExtLoop1: 1
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2026 11:40:44 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 4 Jun 2026 11:40:43 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 4 Jun 2026 11:40:43 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.9) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 4 Jun 2026 11:40:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oknUoGAPVqMG2StE60NCxXPLJn/HLRfqODVJjO5CrZsws0Q8KhG7075Oju+hpnauRrHeJkUvbmtvIChNz/r58eSrH/RfVKbh9GrBdxyAlLiK0eHtooyURORjOrVwo13W5wbsrg7lObNG9DjSgl3Psi8Mg5ilqZ4KdvTeiO4f0xFCRTrJhpPuynV/t1h8ZHh0zr/GnskmCkezA5XTWD7655quBuh85yXrqeHFjepZxaTBtO2TN4+g5+SdgWTZ+jwFK4nW/w4WfYpb8UHX9hAp0qgYduULFa76Fh+P8GeBR1Pjshel7CDL3b4NVWHPG/BDMtZJIrPT/xOCM6PcTTc50w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VRl7+kXEBbNyYwE04n1ewpZ3PXTvjIV75oLyW4Gsjds=;
 b=EhuIKd1XhUWcO2vq065mEPfr5JNh+d+5R0rqwrwObc9qNvNOWWI3gWXBFkDtooVGtRlKgo+8Z3YYY5hfZrK4evJRDeusA6+Nzd2mmxEVtvCMQy68Q+s6Dxk95uG0ZVztihiACkDiUytmrJv9ttuhXcE+LKPkZS1FuC/wjlxcXZpRsRoJDwCyHoactCxp/NVPpNZEaNO9x8+r269xp3maJWYUJfXzm0lARiexvSFof8tAP/LTPqfoBWng8R7LAnyd40QI/VVgo+Ei+fCkFVJ4LYYr0jXKHHc6pc/ER2MZdFEnqVXkXaoOXhXvIcVVH0UIoKnmLvOS3ib+0/vVNT0bWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB7381.namprd11.prod.outlook.com (2603:10b6:8:134::14)
 by SJ2PR11MB8403.namprd11.prod.outlook.com (2603:10b6:a03:53c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Thu, 4 Jun 2026
 18:40:34 +0000
Received: from DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58]) by DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58%5]) with mapi id 15.21.0092.007; Thu, 4 Jun 2026
 18:40:34 +0000
Message-ID: <c3b2ab74-754d-4d09-b7a2-d274343d0936@intel.com>
Date: Thu, 4 Jun 2026 11:40:30 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v10 2/2] net: mana: force full-page RX buffers
 via ethtool private flag
To: Dipayaan Roy <dipayanroy@linux.microsoft.com>, <kys@microsoft.com>,
	<haiyangz@microsoft.com>, <wei.liu@kernel.org>, <decui@microsoft.com>,
	<andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <leon@kernel.org>,
	<longli@microsoft.com>, <kotaranov@microsoft.com>, <horms@kernel.org>,
	<shradhagupta@linux.microsoft.com>, <ssengar@linux.microsoft.com>,
	<ernis@linux.microsoft.com>, <shirazsaleem@microsoft.com>,
	<linux-hyperv@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<stephen@networkplumber.org>, <dipayanroy@microsoft.com>,
	<leitao@debian.org>, <kees@kernel.org>, <john.fastabend@gmail.com>,
	<hawk@kernel.org>, <bpf@vger.kernel.org>, <daniel@iogearbox.net>,
	<ast@kernel.org>, <sdf@fomichev.me>, <yury.norov@gmail.com>,
	<pavan.chebbi@broadcom.com>
References: <20260602202801.1873742-1-dipayanroy@linux.microsoft.com>
 <20260602202801.1873742-3-dipayanroy@linux.microsoft.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20260602202801.1873742-3-dipayanroy@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0321.namprd03.prod.outlook.com
 (2603:10b6:303:dd::26) To DS0PR11MB7381.namprd11.prod.outlook.com
 (2603:10b6:8:134::14)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7381:EE_|SJ2PR11MB8403:EE_
X-MS-Office365-Filtering-Correlation-Id: a7135c55-e603-45ba-97e8-08dec268c353
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024|921020|22082099003|4143699003|11063799006|18002099003|5023799004|56012099006;
X-Microsoft-Antispam-Message-Info: SMvwsxwri5mxDh0/msRi+HUZ9rL9zOrVmxrbLUsas50qAOrW8OAUTnCEOjwZLhfgqPS0RWDVmrfBu2MytVITKpmngHCVmB4+cKrrEBwCVAwWJLtGVApsPmAFWlVKTzAv4CLvuK2t2sycXRZ36jixOhs401nDvy5IoJ1n2ZJ118OOLGJ4JKjsnjsYRi6M/sj5LdPiNOmgZs6D2L2zB1ZGqo3gZ5rLxL5FIbqQlz0+Gj3htuS09HUJkjNu0F8FkWR7K4Y0smBD/pAS3U88ASDDeFyApGlblblrMqV7zbSntGMnN4HQx4XpAc4/N1kcS44nmSBI2M917kbTEvv/Vzezuv0POfTwp4alyTIS7R6MU0Frt0i3QfuIW4Saws4JGNBVcy1DTJChgqZ01uusPvX/YsgTF2C+7QTb56T2UDZ64MeawQACJ0tKU9mQo0jwCNTjo8tu7zQAX5ikVHKvlWBb+2/B0HwVAwyRF/xguXZ/enPerMtxvxdn1WbUN4G0Zt4F7agUpKoWxMby0s7dIcyavVAAr7XA/5de8lbzxPgW2DOVXw4K5ylqflbFaM++knlTVYdMmkfSp9ttoGjct1UUPpiCebOM6aJaRE/Jjo5XDsda+ETD7wusRfxBIBlwsDhjV/q3qwdQzbF7OGjdobGmy4fV27zc8mTNezN1BCieT1uqIXQt9a3vwvrfZaIWU0Z/Id7hIAucbQO479gdx6xVV9Q1doDrJIob5wLL847k6FA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7381.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(921020)(22082099003)(4143699003)(11063799006)(18002099003)(5023799004)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UFl2YUNVUk95d2FRSFRmbTA1L3hEOGFzdHVWT1ljVFhUMHViYkV4bkpCbzBH?=
 =?utf-8?B?T1UycU5SdXBicmExTGxCcy85RThBUTJvTEQ0d3NzMDIzb3dGWkpBT1NwelJO?=
 =?utf-8?B?dUtUUC9CdDJJbkdGL1hrT0xmY0lwaGxScjZieGFWVDl0OWZic0JYUkpnR1hF?=
 =?utf-8?B?WGJVeEpuSWlZYjA4NzV0bTVwQy9EajZrSFBoTU5kSmVSWUd2YWNzSlI4MWo5?=
 =?utf-8?B?RUF3czVWZ1JyQ3dVQmxYRmhJcmZYcjNMc1UvSzVBNitZSXFvbXNDc2g4NC9t?=
 =?utf-8?B?bWRKdkh2Rlk0dTRkdXpGN2pFTWo3eEFjOGJzRUF4eVVoUFpGWVBqN3BwWnFF?=
 =?utf-8?B?QWFkeEFYT210THlRN1BucWFyV2wyK1VoNnpVbU1IMDNJS2l3dDdQYUZIQU1Z?=
 =?utf-8?B?ZG9QRnMxQlJaT0VvL2ZNbFZXenhNYkdsUWtJTk10b3l0dWVoKzRIbUx6VEZU?=
 =?utf-8?B?VktvWFlrYnhLZ20xdkQzU2FodGxVZ0pXWTE1Rzh4RUpWK0JDTW40TmZSZmJ0?=
 =?utf-8?B?SXRRRDc3dEdYUkZrbmt3dFdQaW56WFdibk05Z1pQWHpDU2NXZVhhcHJpR1Rw?=
 =?utf-8?B?Qlk2Vm9BazdKMXdhRlRDYi9FOVFSTGhXMUlJWlZXZnVSZ2RpZktBS3NYMTFN?=
 =?utf-8?B?d24xNnVBSWt3Z3JBbnZxbWxYSVYzd3BhbzJSa1Y3VU9WSENwUVlod0IxSUw1?=
 =?utf-8?B?TEpYQ3cyb1RGTituWC8xQ2VTendrRDFuVFZ1RUsvOGE2VzdNaFUvZG5sZU02?=
 =?utf-8?B?Q3FBQzZ2TzRDazh5ZEtobUEySXVUTDIzZnZkVDE4VkRRbDNPckErdTBUL0RJ?=
 =?utf-8?B?OFV2K1R4dktYczFrZWN0ZW41SXg0Ym94ZmVDWHczTzlxRkhaT3ZiZ29nLzYy?=
 =?utf-8?B?VzU2ajJqUS8rSjkwaDJDczROZ2tvRWQzcytxK3BQakdwZmlvYXdhblgyYWtu?=
 =?utf-8?B?YTk4bnBJNTBJajVzNENxV2lPM1BQbk5GUjJQK3VBRlZDQ3p5Ym53Z1ZFQ1Nq?=
 =?utf-8?B?RnZTZExpZzRBMndHZW9UWUVxTUxCNnU3bXkvaE83eUkvc0dzSjhUeG1vSlNj?=
 =?utf-8?B?VkhpZDdSdUVmMUZhcnhZVnhqRllTajY4bkVpampoazZnS2krYXdYM2kzNDkz?=
 =?utf-8?B?dlJ5S2lDbGFCejRTcjdKL1ovT2V0bjloNXVzNmVoeEtLRWFERkRpOStvVzFv?=
 =?utf-8?B?TnZTZCthQ2M5YnNDVEh6S0JsWHVXZ0dsei9CcW5RaXYrRjRFVFAyWDV4YUt6?=
 =?utf-8?B?SHZXRDdONjdXdklidGJhWE9SUy9aQTZTRW5BZ0lycnh1bWpybldwdDRtcldS?=
 =?utf-8?B?VWZSZHpxc2ZCbW1HNW80UHptWHZranNmSW9VWDc1RTdONDJmTXhCK1lyQmkw?=
 =?utf-8?B?K21jQnZ1ZTZvTnNHZDRaY05TS3VlQVFVWnBBY09iL0ZhNHdydGt5SGd0OFBu?=
 =?utf-8?B?VGh2eGUxcTMvSElUaFVpVzBqUFEyVi83bFV3NU9ud1FkRStsdVp6bWF4VUN4?=
 =?utf-8?B?RThmeUwvaWkyYWMwTnhZWCttbmxXL01CdThFNDNJYzVqczZzL1FaRXR3em9M?=
 =?utf-8?B?emZveTRHVitVV3M4WHFVbEROOU1ZMWdETFVCLzRQUTYrY0tia1hKcEZSNk9U?=
 =?utf-8?B?TmNuVmg1MGlGZmJiT1hCZTZtYXBDRzBTcnR6bjh4NzZHSVlrUFFYamtONitX?=
 =?utf-8?B?bUhLS2hGMmpoUjdQSytxaVE1dmhHemVZRU1ydGxqOWcreFpjUEFxTWFVQkNQ?=
 =?utf-8?B?QXl0Y3ZXQVBqSU5tSkFQaFdrY09nY3dUeDdqb3pvVGQ3VGk2S2xuVFdhakdQ?=
 =?utf-8?B?QVlBNlR5bG1hOVZQRHJuSCtGVW1LV3E3Z2c3eldaaTJmdzZOMWtmN0pqUTha?=
 =?utf-8?B?WmQxWE96bGREMzRLNHFPZHZSNkNpdGR4c0tTMUFRR05tMTlpbUN1TFJDdFZB?=
 =?utf-8?B?TUpDS2FKVlRwcDZLbmpJSlR0TGxFczBucG1PRUlHWkt3ZjUxZWErTGFjbTk3?=
 =?utf-8?B?NXV3Zktodi9QTnEwWms1RVd5clpXU0pYRGdKZFhZZ0REZ1l4TzF0bGcydGpK?=
 =?utf-8?B?Y29VbDZWVUplbThMV29YUkx1VkEzUTU5bGE1QTd6SHpFenNLUG9DSVdnQmF2?=
 =?utf-8?B?VmNOdmZQM04rbkFObUxPRjlPYjF6VURXRkRHdml1a2NXMWQ2NlZUL0RHZWh0?=
 =?utf-8?B?M2hJMW1DOEdHSTdZclFDcEMzUCtLUGRTRE5qUG9pRDVyWk1MMVErbmNuT09J?=
 =?utf-8?B?RzdwZVZGNTZINzdPazZISXZLS1JhUUZpaGRLalR0TzdKVk05cDdmZ0l0TlBv?=
 =?utf-8?B?eFR4d0RsV0tTQVp4Nm5SWWRpTVZUb1RMbDFLS3d2MU1vQjFXelcyK1JQZzJk?=
 =?utf-8?Q?9SuThJsu4UM18cJs=3D?=
X-Exchange-RoutingPolicyChecked: M7qAkXLQjZYpUp5lmjypBQYr3a5JPFdj3DlliSNxqs9FNCT2KnWti9OoMjUpB1cV0Vpvb/X7g2ehfdU/j8FlySVGqJQccYkngg6eJoaj7QJToAebjSf10+Bp466R6iqOBin7J4gNgS3BbGojliSL5cC/DzTvxA3bcSX8CNWm9A6BrxA+Jlux7IDDU0btWb03EGOjQN2zNceRQgPCHEShveYRsk/jIofomwiZlTKn77q6KhpNxtn+3Y42vf8FQOHT0rUFAvu02N5ABEapZiIqrwmGW7Y72DOXfVMgpOIoXV9U1XROZLp9BSaQJP77RAdG82Zx6LSqcpWC8zPsIJ0Pfg==
X-MS-Exchange-CrossTenant-Network-Message-Id: a7135c55-e603-45ba-97e8-08dec268c353
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7381.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2026 18:40:34.4330
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q3oe+ciJ6C3k+T6q+FeuIDhQZH93uvWIBRFYhsmXqDAiz0lyD75xCmhi9+cMJvaT0YNpy3g5jmqsNKas/fNwbT3O1Ab9QVJDiFRLNSP+Xag=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8403
X-OriginatorOrg: intel.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[34];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11493-lists,linux-hyperv=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[linux.microsoft.com,microsoft.com,kernel.org,lunn.ch,davemloft.net,google.com,redhat.com,vger.kernel.org,networkplumber.org,debian.org,gmail.com,iogearbox.net,fomichev.me,broadcom.com];
	FORGED_RECIPIENTS(0.00)[m:dipayanroy@linux.microsoft.com,m:kys@microsoft.com,m:haiyangz@microsoft.com,m:wei.liu@kernel.org,m:decui@microsoft.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:leon@kernel.org,m:longli@microsoft.com,m:kotaranov@microsoft.com,m:horms@kernel.org,m:shradhagupta@linux.microsoft.com,m:ssengar@linux.microsoft.com,m:ernis@linux.microsoft.com,m:shirazsaleem@microsoft.com,m:linux-hyperv@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:stephen@networkplumber.org,m:dipayanroy@microsoft.com,m:leitao@debian.org,m:kees@kernel.org,m:john.fastabend@gmail.com,m:hawk@kernel.org,m:bpf@vger.kernel.org,m:daniel@iogearbox.net,m:ast@kernel.org,m:sdf@fomichev.me,m:yury.norov@gmail.com,m:pavan.chebbi@broadcom.com,m:andrew@lunn.ch,m:johnfastabend@gmail.com,m:yurynorov@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[jacob.e.keller@intel.com,linux-hyperv@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,intel.com:mid,intel.com:dkim,intel.com:from_mime,intel.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 756A2642A38

On 6/2/2026 1:24 PM, Dipayaan Roy wrote:
> On some ARM64 platforms with 4K PAGE_SIZE, page_pool fragment
> allocation in the RX refill path can cause 15-20% throughput
> regression under high connection counts (>16 TCP streams).
> 
> Add an ethtool private flag "full-page-rx" that allows the user to
> force one RX buffer per page, bypassing the page_pool fragment path.
> This restores line-rate (180+ Gbps) performance on affected platforms.
> 
> Usage:
>   ethtool --set-priv-flags eth0 full-page-rx on
> 
> There is no behavioral change by default. The flag must be explicitly
> enabled by the user or udev rule.
> 
> The existing single-buffer-per-page logic for XDP and jumbo frames is
> consolidated into a new helper mana_use_single_rxbuf_per_page() which
> is now the single decision point for both the automatic and
> user-controlled paths.
> 
> Signed-off-by: Dipayaan Roy <dipayanroy@linux.microsoft.com>
> ---

I had one or two minor nits, but nothing that I think really deserves a
v11. The only real comment is a future "gotcha" that could happen if you
ever added a second private flag, which seems unlikely and maybe not
worth dealing with until it matters.

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

>  drivers/net/ethernet/microsoft/mana/mana_en.c |  22 +++-
>  .../ethernet/microsoft/mana/mana_ethtool.c    | 103 ++++++++++++++++++
>  include/net/mana/mana.h                       |   8 ++
>  3 files changed, 131 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
> index db14357d3732..447cecfd3f67 100644
> --- a/drivers/net/ethernet/microsoft/mana/mana_en.c
> +++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
> @@ -744,6 +744,25 @@ static void *mana_get_rxbuf_pre(struct mana_rxq *rxq, dma_addr_t *da)
>  	return va;
>  }
>  
> +static bool
> +mana_use_single_rxbuf_per_page(struct mana_port_context *apc, u32 mtu)
> +{
> +	/* On some platforms with 4K PAGE_SIZE, page_pool fragment allocation
> +	 * in the RX refill path (~2kB buffer) can cause significant throughput
> +	 * regression under high connection counts. Allow user to force one RX
> +	 * buffer per page via ethtool private flag to bypass the fragment
> +	 * path.
> +	 */
> +	if (apc->priv_flags & BIT(MANA_PRIV_FLAG_USE_FULL_PAGE_RXBUF))
> +		return true;
> +
> +	/* For xdp and jumbo frames make sure only one packet fits per page. */
> +	if (mtu + MANA_RXBUF_PAD > PAGE_SIZE / 2 || mana_xdp_get(apc))
> +		return true;

Technically you could combine all three into one if, but I agree that
clarity and space for the comment about why the private flag exists
makes sense.

> +
> +	return false;
> +}
> +
>  /* Get RX buffer's data size, alloc size, XDP headroom based on MTU */
>  static void mana_get_rxbuf_cfg(struct mana_port_context *apc,
>  			       int mtu, u32 *datasize, u32 *alloc_size,
> @@ -754,8 +773,7 @@ static void mana_get_rxbuf_cfg(struct mana_port_context *apc,
>  	/* Calculate datasize first (consistent across all cases) */
>  	*datasize = mtu + ETH_HLEN;
>  
> -	/* For xdp and jumbo frames make sure only one packet fits per page */
> -	if (mtu + MANA_RXBUF_PAD > PAGE_SIZE / 2 || mana_xdp_get(apc)) {
> +	if (mana_use_single_rxbuf_per_page(apc, mtu)) {
>  		if (mana_xdp_get(apc)) {
>  			*headroom = XDP_PACKET_HEADROOM;
>  			*alloc_size = PAGE_SIZE;
> diff --git a/drivers/net/ethernet/microsoft/mana/mana_ethtool.c b/drivers/net/ethernet/microsoft/mana/mana_ethtool.c
> index 7e79681634db..f22bbb325948 100644
> --- a/drivers/net/ethernet/microsoft/mana/mana_ethtool.c
> +++ b/drivers/net/ethernet/microsoft/mana/mana_ethtool.c
> @@ -133,6 +133,10 @@ static const struct mana_stats_desc mana_phy_stats[] = {
>  	{ "hc_tc7_tx_pause_phy", offsetof(struct mana_ethtool_phy_stats, tx_pause_tc7_phy) },
>  };
>  
> +static const char mana_priv_flags[MANA_PRIV_FLAG_MAX][ETH_GSTRING_LEN] = {
> +	[MANA_PRIV_FLAG_USE_FULL_PAGE_RXBUF] = "full-page-rx"
> +};
> +
>  static int mana_get_sset_count(struct net_device *ndev, int stringset)
>  {
>  	struct mana_port_context *apc = netdev_priv(ndev);
> @@ -144,6 +148,10 @@ static int mana_get_sset_count(struct net_device *ndev, int stringset)
>  		       ARRAY_SIZE(mana_phy_stats) +
>  		       ARRAY_SIZE(mana_hc_stats)  +
>  		       num_queues * (MANA_STATS_RX_COUNT + MANA_STATS_TX_COUNT);
> +
> +	case ETH_SS_PRIV_FLAGS:
> +		return MANA_PRIV_FLAG_MAX;
> +
>  	default:
>  		return -EINVAL;
>  	}
> @@ -192,6 +200,14 @@ static void mana_get_strings_stats(struct mana_port_context *apc, u8 **data)
>  	}
>  }
>  
> +static void mana_get_strings_priv_flags(u8 **data)
> +{
> +	int i;
> +
> +	for (i = 0; i < MANA_PRIV_FLAG_MAX; i++)
> +		ethtool_puts(data, mana_priv_flags[i]);
> +}
> +
>  static void mana_get_strings(struct net_device *ndev, u32 stringset, u8 *data)
>  {
>  	struct mana_port_context *apc = netdev_priv(ndev);
> @@ -200,6 +216,9 @@ static void mana_get_strings(struct net_device *ndev, u32 stringset, u8 *data)
>  	case ETH_SS_STATS:
>  		mana_get_strings_stats(apc, &data);
>  		break;
> +	case ETH_SS_PRIV_FLAGS:
> +		mana_get_strings_priv_flags(&data);
> +		break;
>  	default:
>  		break;
>  	}
> @@ -590,6 +609,88 @@ static int mana_get_link_ksettings(struct net_device *ndev,
>  	return 0;
>  }
>  
> +static u32 mana_get_priv_flags(struct net_device *ndev)
> +{
> +	struct mana_port_context *apc = netdev_priv(ndev);
> +
> +	return apc->priv_flags;
> +}
> +
> +static int mana_set_priv_flags(struct net_device *ndev, u32 priv_flags)
> +{
> +	struct mana_port_context *apc = netdev_priv(ndev);
> +	u32 changed = apc->priv_flags ^ priv_flags;
> +	u32 old_priv_flags = apc->priv_flags;
> +	bool schedule_port_reset = false;
> +	int err = 0;
> +
> +	if (!changed)
> +		return 0;
> +
> +	/* Reject unknown bits */
> +	if (priv_flags & ~GENMASK(MANA_PRIV_FLAG_MAX - 1, 0))
> +		return -EINVAL;

Good. Explicit rejection ensures that there's no risk of bad value. I
think this is only required for the legacy ioctl interface, and won't be
able to have a bit set that isn't in your accepted list. However the
legacy ioctl interface looks like it doesn't do that double checking, so
its good to have this.

> +
> +	if (changed & BIT(MANA_PRIV_FLAG_USE_FULL_PAGE_RXBUF)) {
> +		apc->priv_flags = priv_flags;
> +

In the (unlikely) event that you need another private flag in the
future, this bit seems like it shouldn't be inside the if block here. It
seems like you'd want to either do this at the end or up front. Of
course it doesn't matter as long as this is the only private flag you have.

> +		if (!apc->port_is_up) {
> +			/* Port is down, flag updated to apply on next up
> +			 * so just return.
> +			 */
> +			return 0;
> +		}
> +
> +		/* Pre-allocate buffers to prevent failure in mana_attach
> +		 * later
> +		 */
> +		err = mana_pre_alloc_rxbufs(apc, ndev->mtu, apc->num_queues);
> +		if (err) {
> +			netdev_err(ndev,
> +				   "Insufficient memory for new allocations\n");
> +			apc->priv_flags = old_priv_flags;
> +			return err;
> +		}
> +
> +		err = mana_detach(ndev, false);
> +		if (err) {
> +			netdev_err(ndev, "mana_detach failed: %d\n", err);
> +			apc->priv_flags = old_priv_flags;
> +
> +			/* Port is in an inconsistent state. Restore
> +			 * 'port_is_up' so that queue reset work handler
> +			 * can properly detach and re-attach.
> +			 */
> +			apc->port_is_up = true;
> +			schedule_port_reset = true;
> +			goto out;
> +		}
> +
> +		err = mana_attach(ndev);
> +		if (err) {
> +			netdev_err(ndev, "mana_attach failed: %d\n", err);
> +			apc->priv_flags = old_priv_flags;
> +
> +			/* Restore 'port_is_up' so the reset work handler
> +			 * can properly detach/attach. Without this,
> +			 * the handler sees port_is_up=false and skips
> +			 * queue allocation, leaving the port dead.
> +			 */
> +			apc->port_is_up = true;
> +			schedule_port_reset = true;
> +		}

I might have made this bit a separate function, but that comes from
history of working with older drivers which accumulated a larger number
of private flags. Given that we frown on adding new ones except in more
rare cases these days, this is probably fine.

> +	}
> +
> +out:
> +	mana_pre_dealloc_rxbufs(apc);
> +
> +	if (schedule_port_reset)
> +		queue_work(apc->ac->per_port_queue_reset_wq,
> +			   &apc->queue_reset_work);
> +
> +	return err;
> +}
> +
>  const struct ethtool_ops mana_ethtool_ops = {
>  	.supported_coalesce_params = ETHTOOL_COALESCE_RX_CQE_FRAMES,
>  	.get_ethtool_stats	= mana_get_ethtool_stats,
> @@ -608,4 +709,6 @@ const struct ethtool_ops mana_ethtool_ops = {
>  	.set_ringparam          = mana_set_ringparam,
>  	.get_link_ksettings	= mana_get_link_ksettings,
>  	.get_link		= ethtool_op_get_link,
> +	.get_priv_flags		= mana_get_priv_flags,
> +	.set_priv_flags		= mana_set_priv_flags,
>  };
> diff --git a/include/net/mana/mana.h b/include/net/mana/mana.h
> index d9c27310fd04..26fd5e041a47 100644
> --- a/include/net/mana/mana.h
> +++ b/include/net/mana/mana.h
> @@ -30,6 +30,12 @@ enum TRI_STATE {
>  	TRI_STATE_TRUE = 1
>  };
>  
> +/* MANA ethtool private flag bit positions */
> +enum mana_priv_flag_bits {
> +	MANA_PRIV_FLAG_USE_FULL_PAGE_RXBUF = 0,
> +	MANA_PRIV_FLAG_MAX,

For cases like this, I find it helpful to add a comment indicating this
must be the last entry. (and in that case, drop the trailing comma).

> +};
> +
>  /* Number of entries for hardware indirection table must be in power of 2 */
>  #define MANA_INDIRECT_TABLE_MAX_SIZE 512
>  #define MANA_INDIRECT_TABLE_DEF_SIZE 64
> @@ -531,6 +537,8 @@ struct mana_port_context {
>  	u32 rxbpre_headroom;
>  	u32 rxbpre_frag_count;
>  
> +	u32 priv_flags;
> +
>  	struct bpf_prog *bpf_prog;
>  
>  	/* Create num_queues EQs, SQs, SQ-CQs, RQs and RQ-CQs, respectively. */


