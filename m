Return-Path: <linux-hyperv+bounces-7455-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 89C08C3E875
	for <lists+linux-hyperv@lfdr.de>; Fri, 07 Nov 2025 06:40:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3ACC33ABEBD
	for <lists+linux-hyperv@lfdr.de>; Fri,  7 Nov 2025 05:40:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01357212566;
	Fri,  7 Nov 2025 05:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aOrggZBg"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2061B1482E8;
	Fri,  7 Nov 2025 05:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762494009; cv=fail; b=rSg1VIHxs7b2tC16DNgHuhW8tRtwdxVksA+2wLMIt+N0hOFf4AVhGmTO4HgWNx+qvzAQh5vyhTqtpUS9evF//7ygvum1+u6FcAJ8a2RmHaFHGESQf6Gj3fpU0wu5x+hsUImeMfLu5+ajypABLKd0l5IIub3WWZ4pCvldYH7bvrU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762494009; c=relaxed/simple;
	bh=GOuJQKaWIem8N1Nq5r3hJQA6k9i24mdTAC1AXLmrgFs=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=CnuXnEXUQ+GnHQ+f1EhjLh1ypBc6hMKxbm33FDuIxdDjZMEchtObB7TWYJjWo5y2cPWb6JlSDjjBMG+KAaLxA5Kt7NnjMHxzzi3fTcS3Go+YyseRrVJevufh30CsF7qS5zcBZwIM6m4XtcLUwApO5OXPlaRUPnFTb2kFtSblelk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aOrggZBg; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762494008; x=1794030008;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=GOuJQKaWIem8N1Nq5r3hJQA6k9i24mdTAC1AXLmrgFs=;
  b=aOrggZBgbiw5Bvs2nz3NxHZRN6J3/a+Gh5721KgDLRqwW15nYbcRSs2t
   MQ2mpP46g3imwc+fA5rpzDd4GH24XDsGKLWVvOk51kfcdry67EoTd3y4D
   82ZkfyGIf0T3cU65niYQS3BzrNft15nFkTd804EluDy246CZIGTE7aABu
   gA4rgRclxpW36FEylzt37Y5bKWwQ2LEUIbKXpeiXLz+FUQCQ/eo6KhhbM
   SIqqIcEueJhyBcOLePhVKfAQTAuXmmTFJGxpGMaSuY4etlnIiYMgZ2aob
   BrWRe4Xv6m03tkPlTVq3eBWq/ZwYmhXyEIdJ0upqExrJnpfMif9RYuz2q
   Q==;
X-CSE-ConnectionGUID: qR35eUBYTmCyYnufNDgQOg==
X-CSE-MsgGUID: eFHiZk94TTKaMbe/220SAw==
X-IronPort-AV: E=McAfee;i="6800,10657,11605"; a="82045552"
X-IronPort-AV: E=Sophos;i="6.19,286,1754982000"; 
   d="scan'208";a="82045552"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2025 21:40:07 -0800
X-CSE-ConnectionGUID: 3bulHap2Q9ekUDzHPIGFUg==
X-CSE-MsgGUID: UHZ9lqOzT8GR5OlXhMmx9Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,286,1754982000"; 
   d="scan'208";a="187902101"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2025 21:40:07 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 6 Nov 2025 21:40:07 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Thu, 6 Nov 2025 21:40:07 -0800
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.62) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 6 Nov 2025 21:40:07 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uk/6MZc/YSAqjh0SyNMCISwvnrD3KVWiyXsENXQdm13NE5KrEpT9iEsSMy4BlG7q9zxKwLdBke+lExzZda9rNCW8LeiiQS3N6CKE3xgYqzBsMhOvAS9h6xCDkjDeyBgsDG3zGgNDWsEgd0JoBbJQyXYF5D6YUi010NhgvRhnK3ydaXoiAtEHErzjbp/3+doQaupDDQ3ne1EpNem5fa5hxyccVGYr+L6aDsYcUyiCnFJ84wkU2ge/G4y11x9h+NNriYjCkX+y3ahJ0Xm4XsyoyjAacPfV/V82oWuz2LuRgfGyPU1Gv2WmRa2SPoOfy00wd+nssDCJDpdMddWXcRRPcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gs6vrhaV8sEYU8HsnOgF88gaGeT9AG1Fl8usSBNN2ag=;
 b=p4/HqBmTyX1ztFqjjqJ4jM5sOraSeCOWpXcXbgV1kj5jzykMM5UcHudD6dDn+SXQulP14K0mp5ZQP35Dg4O2eqTezxXIi0fHm/y0rGLv+Pg9OFq0fFdQ48PLvR7pywvtb0MAN1gF75k52MDQ5qFjN+jbgoRp7G0Mkhu8sUWZpyZ9GFvumlVAI50hh5vZ9Vu4Ax+WKhPU1XUibnLei3+uh/QZ4w+Ip/XyXTSCGjzoTah4HN6HpWkm2F+ZiYCZNWJWlF7mUFNI45eKA7BxZr4x/huOz8yEkDLlnz3yrqk0KPxAAdxrIq3M0muSjCmOHgvtplgOG8Ufgm8CHvdjPJIGpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CH0PR11MB8086.namprd11.prod.outlook.com (2603:10b6:610:190::8)
 by DM4PR11MB7374.namprd11.prod.outlook.com (2603:10b6:8:102::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.12; Fri, 7 Nov
 2025 05:40:04 +0000
Received: from CH0PR11MB8086.namprd11.prod.outlook.com
 ([fe80::984b:141d:2923:8ae3]) by CH0PR11MB8086.namprd11.prod.outlook.com
 ([fe80::984b:141d:2923:8ae3%4]) with mapi id 15.20.9298.010; Fri, 7 Nov 2025
 05:40:01 +0000
Message-ID: <afa219b7-9ce3-4da8-a339-8f363d77824e@intel.com>
Date: Fri, 7 Nov 2025 06:39:49 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH v3] net: ethernet: fix uninitialized
 pointers with free attribute
To: ally heev <allyheev@gmail.com>, Alexander Lobakin
	<aleksander.lobakin@intel.com>
CC: Tony Nguyen <anthony.l.nguyen@intel.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, "K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang
	<haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan Cui
	<decui@microsoft.com>, Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	<intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-hyperv@vger.kernel.org>, Dan Carpenter
	<dan.carpenter@linaro.org>
References: <20251106-aheev-uninitialized-free-attr-net-ethernet-v3-1-ef2220f4f476@gmail.com>
 <575bfdb1-8fc4-4147-8af7-33c40e619b66@intel.com>
 <00748f83a8ae688b7063f36844e38073d29b5e19.camel@gmail.com>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <00748f83a8ae688b7063f36844e38073d29b5e19.camel@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU2PR04CA0355.eurprd04.prod.outlook.com
 (2603:10a6:10:2b4::34) To CH0PR11MB8086.namprd11.prod.outlook.com
 (2603:10b6:610:190::8)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR11MB8086:EE_|DM4PR11MB7374:EE_
X-MS-Office365-Filtering-Correlation-Id: c63937c6-04e9-4261-1912-08de1dc0183f
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QXFHcFRsa2tkSnY4YlBXTXRVNEhSR2grempXU3BIa0Raa2w2U09NZk9JRkRM?=
 =?utf-8?B?YWtzbzFoRW42Zmw2cFc5VXB2Mlc0YWY1blJqMHhxZlErblcxbkZWa0ZxVmVn?=
 =?utf-8?B?Y2pqVThWeDFlNHNrZk5KNU5mQ0JWcDIvYlNYS1NIWjE0VDJCTXZQMmxsYzE2?=
 =?utf-8?B?cGxPcG9UVTVCTzFKUGRlS1pEL3RESWhicUVkcitYRldtcklONFNodGwrQXQ3?=
 =?utf-8?B?dG55Q2xlQzMzZU43bm94anFHa21CekdoRjZVVjFDL0JxQ09GR2hvY0hSS0ZE?=
 =?utf-8?B?eWVtQVpCRTFSRXZ0cW5vRG9oUUppZllRMkxXQTR6RlFtaXo2cHpJaHBQTWE1?=
 =?utf-8?B?YlpCLy9SYWVoLzhhUjB0ZWh4NVBjWGx1aDR2eis3R0ErZDJaKzAvbjRHT0py?=
 =?utf-8?B?MTNrT1ZMQ3JLc1RNdjVaNW5JZ09zejhsSG9GUzM4TEtSZVpPdm4zVm1CN0dz?=
 =?utf-8?B?T2gwTC9IWkZvWm4yOStUSXA5a21sZUpWSDcyWXc1aDVqYlpsYkROeUgreFAr?=
 =?utf-8?B?M3FiY3Y3NGJPekV2dTR0bWtJaGRnVTBMZ3FPRExBbFM4UlZhM3Z3OVBDZ3JH?=
 =?utf-8?B?OFArU2I2Y2dzQlFCVnptNlBkUlYxR3pGSUZ3ZVFxRUNNNnJLdHY4Rmw2akY3?=
 =?utf-8?B?c1ZLM21xa0ROaWt4L1VHWE11c085U1Rtb09YaU1mYS82SWRKcTRmeWk3dmla?=
 =?utf-8?B?V1QweWdjbllyYk0vc2ZLLzNFc1VENVUwTEdpWURzOTF5NTVtQzhnYVdHTzVD?=
 =?utf-8?B?WExiK2ZrYjkzeVI2dmVOVzduZzlvbUhWMWJ5NlBVWlN4UjB0Tk9WZ3RJOTRl?=
 =?utf-8?B?dTZYeEtGdHdaVmQxRlpiSVZCQ1ROT0hPRThHYngvZ0IvSXFVRUZ6eFdUV0hS?=
 =?utf-8?B?cjhiZXRiU01qcTJLRWgxbXQzazNaNmh6cWdic01jaFdKUnVSVmRPaDZCZXZG?=
 =?utf-8?B?VVcyYkhTTVYyS0NLTEM1MXFLZWNDblRVSXN5aUlHT0pUS2R0MUVzcTFMbDVR?=
 =?utf-8?B?RVhidmJpbUZCZWEzYUs4YlFqWjNnb1JoWW1YZmJzUGRHbmtITnpkQmY3YWpo?=
 =?utf-8?B?S0tPUVJaOXZUOGI1ZGYzcXhLWHp3T1pjbmlwWHpHWlJHbE5uZ0JEUHZhOHMw?=
 =?utf-8?B?cEJ0amNRblhCdFhpb3hmWjhQOTJKOCt3eDZLQWErWTBYK3hJTy9vSk5VSTFo?=
 =?utf-8?B?YjlyejZxdWh3Y213Zm9RVUV0cHVpc3o1OEU4NWhVNnYxU1V3a0RZbzk3dm1H?=
 =?utf-8?B?UUE5M2ZINlo2R1A3Mmp3UVo5alZzNHBDblhNQTNqczJBS3NwcFdybkp3Tmh1?=
 =?utf-8?B?ZGF2VlpqWDBobFAwUEdiN1dQZFAvbmxVWXdkU1FIMFdmY3hRRUM2MFJabFh2?=
 =?utf-8?B?cTl2bXNDOW5mTEhLQVZiT0VOWTV4QjdVRjJ6TVJpbm9wUUltaGFWbkVBU2wy?=
 =?utf-8?B?R05QNkdSa1lCQlB0aFNERWc4cXpLR2xycWpLTHNnVlpvS1owVzBlRDJhc2F1?=
 =?utf-8?B?eXBINFBSN3krZ29MaWJHMmQrZjRwb2doaWRnQnhHNi9RdDIzcW1IWlpJU3V0?=
 =?utf-8?B?c0pXMzFybFNFZU9BMkZ2RkxCSzB4NHU1a2FqUWFNTnNjTDR2cVg5RDFGTExq?=
 =?utf-8?B?RDhLbFdFUy9Samh3UDA2OERJMnNpUkNHdVBwT3p3VUw2VjFWSS9pSDFDTnp0?=
 =?utf-8?B?K2pYT2IwTFVFYkIxVmtWRXdBRmhVRTNVbzl0cXc0dnBMU0JZcmk3bk5Gb0JD?=
 =?utf-8?B?WnpWN1dJdUR6TzZ2S1B0bjBRZE80dysvb2dZSDhhNjJoaVlzRHhkZms3cmJW?=
 =?utf-8?B?cEVmWGFhbWJYYi9ZY0tQdk5YcW9QTzV4L3h2bTV5dVB4dVJybUMyV3R5TDZR?=
 =?utf-8?B?Wjh6TmpCVEVSNG9hRm9qOUFHbXNIUVlmcFAwZGRjdHdHQmcrdENYckVBRkVD?=
 =?utf-8?Q?d6zsQPb1b1A3YGLXWZ3CZFNRe9K4/m+q?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR11MB8086.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S0VlczlZQUNIQ2YzanhLOXNTRjJIaDFCaitXdDljUXZlT0lIcXp1M05FcGM1?=
 =?utf-8?B?TElPVW9xN0NsR2hrMlErbDlPUXE2cUF5dkNzc1hyN1d5N3U5aXRjcHNRbmV4?=
 =?utf-8?B?dkpqbk9mWURqcDE4U1BqRmJoYVBxaGtuYmJub3lzais3bHVNSzJKQ0VHRVR4?=
 =?utf-8?B?akpreVpUYyt6RHFJaE04QzJOQUduZzMvbGZGVDNjSTdSSVBhT0gwbldVMXpa?=
 =?utf-8?B?aDEzNFl3UGJWU0VDbVN3dG4ybzhuZzhFWHZJUjdUVDNyL3V4SHlWSVZGTU1x?=
 =?utf-8?B?SWN0VUw5RWNzWmlzNDI3alhXTGRTaG9iQzhXckJVbTBiektPQjQ5MUFuL1Az?=
 =?utf-8?B?RmZxOC8xNkxnSUcxemlwYm41RTladGJSZ3hKK2pOdXU0QUlPVW0yUUZ1TTNu?=
 =?utf-8?B?VUVMbFU0VE44Q3doVlhLVnZQcTZZdGV0OXo5U3oxeE5mV3pZSWxNbWs2UmFC?=
 =?utf-8?B?MnhFKzNnakdjRTc5aVJRS3M5T1Axd2c1bEE0MkRKTzNZWTRrM2s5SlVlTTZJ?=
 =?utf-8?B?SFFzUUo0OW9ianFCSDJkK2VyL0xtRE9nalg1Mncvd1h2b1VKb2Zta3Y5NjZk?=
 =?utf-8?B?L1VHTTBqRlcxZzAvcGxKUFl0QS9VWXBKK1I5MW9kTVdhaWh4SXV4OEdzRVdh?=
 =?utf-8?B?SUpYKzEzMHJHaEovdXBlVkNSWVNVZnQyYVcyajV0OXM5bmhuc3N5bkpqbWhU?=
 =?utf-8?B?aFhZMEVlSHNNM3Z5cytqcUJud2Uwd2RtY0gzSlFxOXNFM1E2aGVYV05vZ1Uy?=
 =?utf-8?B?aG0zZjRzMktlYWROUmpYNFA3aTFUKyt3MUlaSEREVHduSGNDRzVSRk5uOUxR?=
 =?utf-8?B?dTk2WFBiZC9PeEwwZ3RTQ1cvVm5wQzZ4WThVMHRWa3M5RHI0Qy9BR1c0bm4v?=
 =?utf-8?B?a0JnY1pxOEthRHVhTzZYNTY3UUd2Q0p3amU1ci9aa1pBdDJyM3hobkJlbWw1?=
 =?utf-8?B?RWdhL0t6aVVQemcrM0NHUTZuMkViQkhXbjY3V2FjTDJDN0cya1psV0pUMnl4?=
 =?utf-8?B?L3dmdVc3TFNrK2NzL1preDdrSEFCYWJTaTAvWnNQT2kxbWt5d3ZWbExIejdi?=
 =?utf-8?B?VitpZFRpWnFIakxlWkxIRHJveGl3R29FSHZ0bmkwZGVRY2RMREk5WW0yR1Fu?=
 =?utf-8?B?VGNDOWtGWGlybEVmWnJhOUdhQWY1VW1FQ2JkeHlMa2ErRmxFamd2VlVib1cw?=
 =?utf-8?B?QzduQ3RCYTNmTDNRS3owWC8vVkFXQkFDSFU4S3BpakZHMXNVWGxTMlFHOXVq?=
 =?utf-8?B?clFmZDlsVDMrTzNQWkdyUTVzRHRvMFlVMWIyV3ByazMyUHM2N0xnWUorK1dN?=
 =?utf-8?B?ak9hRVl0dXVNN3VzL3JMUCtWMXZ4bEVaN0RESk9CVEhKeWs2TU85dHlLSEJw?=
 =?utf-8?B?WTBQbEswUnlOclErcmp6OVV3Mi9kUWt3VE1SNXdMeGpUUzJaUWp4OGJhTjlE?=
 =?utf-8?B?dVFqTFVxMGtWYUQ2Vnpac21oSm91dGN2QzY1WEN4WlZ6bVE3TzcvNEZENExB?=
 =?utf-8?B?aElJak1vT1lTejFyZ1RnNUx6S2xVZTBzSkRaWlIrMkF6WUVQcWg1SjhZWnBu?=
 =?utf-8?B?MGxlNXgyendYeWZZLzIxVmFBaGlSZ3ZBZC9FRDYvYzRPMnlMMnhZUHFyWWRs?=
 =?utf-8?B?b0lPUUdBbFYvNTFoM2lyYm15M2tlaDJDS2crMnBOdUlQM3VKTE4vMVg2SG9F?=
 =?utf-8?B?cjZ0MmEvcVRaaDBocnduRjVMNHEvYldxUWZocEM3SFBKQ1ljRHVOd3Q2Ymhn?=
 =?utf-8?B?aThUaGNvdFM4aHplZElBdXZUUGx1OEpVQnVvcXY2Qk5VTUI5TjdIdHRmTTNJ?=
 =?utf-8?B?NWtsOUp0MlN2V3dZSmsxZ2I5cUw3Zko3aitYdmJoeGdERWlMV25UNGNiWC9x?=
 =?utf-8?B?aGZLc2lEaFZmSUdCWmUvRGwxTC9NZjBMTmhzTkRXL2xoNmhEMUo3U3dxV1J4?=
 =?utf-8?B?TDhyaGpNb1VuV3diNG9LZHV1TFlWR2tOLzFEWmdock05ZFdvNVJVOEFPQ0RO?=
 =?utf-8?B?M09paGhBN0x0aGdUUVdTcW00ZlJkNHorUkNEVzV1TjhyUlR3MFQ1aW1pYkdG?=
 =?utf-8?B?bTlwaDVYbVpkbXVKRG9iN2ZDbGdzSGFyNjIrZ1Rrc0hFMytuYVhBRnpZZnpR?=
 =?utf-8?B?SUI0anBuUXBqeHVnMDZlRy9LaVVlZGs0bW9rLzV0cW9pV09DdHFSa05DeG02?=
 =?utf-8?B?YUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c63937c6-04e9-4261-1912-08de1dc0183f
X-MS-Exchange-CrossTenant-AuthSource: CH0PR11MB8086.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2025 05:40:01.3123
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: md/H28ClgQrosSHxuLz5Sec9dWn51CRELSvZPJkL0QpLsdPHw6IY9Pgr7MnZNa5fuFSALGs8EZSjDAtEJlqEgu1mzHRzpbCrhkb1JlR2mpI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7374
X-OriginatorOrg: intel.com

On 11/6/25 17:05, ally heev wrote:
> On Thu, 2025-11-06 at 15:07 +0100, Alexander Lobakin wrote:
> [..]
>>>
>>> diff --git a/drivers/net/ethernet/intel/ice/ice_flow.c b/drivers/net/ethernet/intel/ice/ice_flow.c
>>> index 6d5c939dc8a515c252cd2b77d155b69fa264ee92..3590dacf3ee57879b3809d715e40bb290e40c4aa 100644
>>> --- a/drivers/net/ethernet/intel/ice/ice_flow.c
>>> +++ b/drivers/net/ethernet/intel/ice/ice_flow.c
>>> @@ -1573,12 +1573,13 @@ ice_flow_set_parser_prof(struct ice_hw *hw, u16 dest_vsi, u16 fdir_vsi,
>>>   			 struct ice_parser_profile *prof, enum ice_block blk)
>>>   {
>>>   	u64 id = find_first_bit(prof->ptypes, ICE_FLOW_PTYPE_MAX);
>>> -	struct ice_flow_prof_params *params __free(kfree);
>>>   	u8 fv_words = hw->blk[blk].es.fvw;
>>>   	int status;
>>>   	int i, idx;
>>>   
>>> -	params = kzalloc(sizeof(*params), GFP_KERNEL);
>>> +	struct ice_flow_prof_params *params __free(kfree) =
>>> +		kzalloc(sizeof(*params), GFP_KERNEL);
>>
>> Please don't do it that way. It's not C++ with RAII and
>> declare-where-you-use.
>> Just leave the variable declarations where they are, but initialize them
>> with `= NULL`.

+1

>>
>> Variable declarations must be in one block and sorted from the longest
>> to the shortest.
>>
>> But most important, I'm not even sure how you could trigger an
>> "undefined behaviour" here. Both here and below the variable tagged with
>> `__free` is initialized right after the declaration block, before any
>> return. So how to trigger an UB here?
> 
> It doesn't occur here. But, many maintainers/developers consider it a
> bad practice because if the function returns before initialization or
> use of `goto` can cause such behaviors.

we were bitten by that already, scenario is as follow:
0. have a good code w/o UB and w/o redundant = NULL
1. add some early return, say:
	if (dest_vsi == fdir_vsi)
		return -EINVAL;
2. almost granted that person adding 1. will forget to add = NULL to all
declarations marked __free

> 
> Here though, the definitions are still at the top right? Maybe I could
> just sort them

we discourage putting any operations, including allocations, that may
fail into the declarations block



