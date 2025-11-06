Return-Path: <linux-hyperv+bounces-7427-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C448EC3B93F
	for <lists+linux-hyperv@lfdr.de>; Thu, 06 Nov 2025 15:09:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 462CA18C7C65
	for <lists+linux-hyperv@lfdr.de>; Thu,  6 Nov 2025 14:08:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BD7F33CEB1;
	Thu,  6 Nov 2025 14:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Indttsee"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24F2F33C53E;
	Thu,  6 Nov 2025 14:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762438078; cv=fail; b=fJtFEPSjtcfuUbKoc/nSGO17URYBnZFZ7bggMcRQqCLw1gXz4LQRYvSENJdMhm5LjJOnfgqIvkQLc2ZX64itxoxjH4rrHB0LD6MPKnq/4XPjfhWM8Zkghff9ROD2aMeiVT2DiZzNSQTt+Ac0cTs8J7JNFtnmKfDRiciljX9ne+c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762438078; c=relaxed/simple;
	bh=g5D6J8AcT7+DU9Uh0eD1/49zwJrH1LPZgLk5DI3Nc78=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=KAE6ziSSN3HwzkmH4S4fep5QfzaybjoRT+3dg0UWy3VukUdLpVrSXqlUkdkuMWqE1hjW7ROKq9V0YmWSqX3/S9nVIOR1IE+JeQxWNX0T7D1yJwW5srR9juuLJi3gCyUMK46SwxCJ6/SF0ok0nM07sENs7eKLSClj5hsyLyuAGzk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Indttsee; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762438076; x=1793974076;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=g5D6J8AcT7+DU9Uh0eD1/49zwJrH1LPZgLk5DI3Nc78=;
  b=Indttsee+0+RhyJSBvMmixY9fQGQbO3Z7QWcA8H0lczi9PGBe0IxSLoA
   2R30TQh0+riuOo/WB6sLF/NHpIJFUWHAsqxpYwpadIuyB72sKLqR0mgZD
   93mWy0k1Hnj6w6WeBwXvLVXO+Gr3PMMpOkwc9jR6IWz3rH69tl4wuSg9E
   Ie+XxeC0kSyRAF3q/Kza1qxW1JY9OkSRupC03hhiUhz5De2e+OTGAt40k
   3mJCZPoPAWiwnPZ3eU+U4BTXQusVqe1uvfx6N0Bj1GVnMgG1JVKuBDhiR
   VSFhr68mlacx1xSXO2nWY75Gk/BlncJfa9A0LJPWVsPlFHn9P4oArFDVO
   g==;
X-CSE-ConnectionGUID: UfhAk2dHTuCyH0/Tg6DBmA==
X-CSE-MsgGUID: 28jes8rVR1GeUwdTNWNiKw==
X-IronPort-AV: E=McAfee;i="6800,10657,11604"; a="64608995"
X-IronPort-AV: E=Sophos;i="6.19,284,1754982000"; 
   d="scan'208";a="64608995"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2025 06:07:55 -0800
X-CSE-ConnectionGUID: 6e7R+e4EQdydB7XxIddBZQ==
X-CSE-MsgGUID: XVcse7FySTCHfau0eDETbw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,284,1754982000"; 
   d="scan'208";a="218427921"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2025 06:07:55 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 6 Nov 2025 06:07:54 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Thu, 6 Nov 2025 06:07:54 -0800
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.6) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 6 Nov 2025 06:07:54 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hs7+5piJeFxVSwDeIChlSiZStDnaYohttgsVTDaDAyNZFszGIrryHMS9xgjiOjY3W15FgKFd5G87v0VAxiZzqQW46TouFqf02Jq4NB+dENRUN0TZtl2Nmrij4480B/h9sAkhZH6hbIJ5iO9ebrXnzIJHhZv7ibVYN3jA76XKJDl9Zoj6Hy6/fA9fw5hJzouDaxR27o4xHOfkmJF/FFptHJtOBwznpKaPRWlGKkplhksSTwZQ6f1RtK+XtCLkduFQEWwtZbthjzeys9Fi+Woj7s/b3u0tjJRSfOOxrFnQpk3BZ4px3d+SlhhdOTCxrjEMMokU6ji18V7xuI8U94xBsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7oukOyCdogi9oEVEVai66xafxihTzEWPEnpZkKBkbYU=;
 b=H7HYUnvo7bXZgBP5TyUbnS5x32V6raQZFx38vvoxd2laVeBIAFlQBi8zCwDpp30TYEZqLE2ON4CK9XUIDUwA4OFos4u5XH5v2kryURUJewD1fViCzw/A6sxJQtbsIUe6fgEqS7Pk2eBJAMDc2UwBwNrR3GChxU0/yUvkZuJ1354k6/ZPTSMfZ8W/OFIUAVtonBJ22Nk6pHu9Wzj1MSaMhI56qkyL5eQ3tPEEGw+cKdTlEZEuGfPvQ06G8MN6bWxYbaJxP9/wrJd9628dcmC79c0wXQMOd4cRMh2lzD0cwWjlpmqTbxPGH59Lzznev0ZA+wiQhnxo56Jl15kKvNE7vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by MW5PR11MB5764.namprd11.prod.outlook.com (2603:10b6:303:197::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.15; Thu, 6 Nov
 2025 14:07:51 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%4]) with mapi id 15.20.9298.006; Thu, 6 Nov 2025
 14:07:51 +0000
Message-ID: <575bfdb1-8fc4-4147-8af7-33c40e619b66@intel.com>
Date: Thu, 6 Nov 2025 15:07:26 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH v3] net: ethernet: fix uninitialized
 pointers with free attribute
To: Ally Heev <allyheev@gmail.com>
CC: Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel
	<przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "K. Y.
 Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, "Wei
 Liu" <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, "Aleksandr
 Loktionov" <aleksandr.loktionov@intel.com>,
	<intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-hyperv@vger.kernel.org>, Dan Carpenter
	<dan.carpenter@linaro.org>
References: <20251106-aheev-uninitialized-free-attr-net-ethernet-v3-1-ef2220f4f476@gmail.com>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <20251106-aheev-uninitialized-free-attr-net-ethernet-v3-1-ef2220f4f476@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BE0P281CA0029.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:14::16) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|MW5PR11MB5764:EE_
X-MS-Office365-Filtering-Correlation-Id: 19d1bdfa-d03f-4eb7-ef71-08de1d3ddf32
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7416014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?S21zcTkvdHJPdC9tZ2xyZHRDZEp4bWZxSTVYOEM1bnVoTUlQYkY0QmhSUFdr?=
 =?utf-8?B?MFRRUU01dEpJc2V1VVlmSWsxODBJclVWdTVCcXRUVjZMOWZsYks1RzErWDhn?=
 =?utf-8?B?RVd1VGM5QzBKM0FYc0RveGh3UEhnbVpyc0xLczJFYUErNERTRlAyYXozdncw?=
 =?utf-8?B?UkxGTE5DdzVZbExvMFBJakRjZmdlc1RIc1JlNm8rQ2xOS3VwSFpTcGFMSjZZ?=
 =?utf-8?B?Kzh2Y3lsR0dPK0hSQktKcVI5MW53VTNGbWVCN3JOUGFGeVVYMTh0WGQrdXZV?=
 =?utf-8?B?MXh3RHd3WHlvbkFGRERxV1BhTjdCZ2V3ZHVtZTNQQUtjNTJTSnRZOUpEZWxJ?=
 =?utf-8?B?Sm1Ec0JpNHc1RExGQjZ3N0VESVJGUVJKUlZpRTJVWExWbUxKdDdRQytXa2R6?=
 =?utf-8?B?dTZwWUVQZE9zQU5HTmowVkMzMlhaU29vMTF0cElnWXUwdWRMUlJFNG5FMDBs?=
 =?utf-8?B?bzJIRGxseklTTzFGWHUvSjRxTm9OdGVzTHRtRlZWczhUaGM1U1hlNjhpa0Rl?=
 =?utf-8?B?enFsWXExc0lDT1VWaXpBUXJOeCtEYksyRURaY1MrTDF6RTF3SmpTSE93Rzg3?=
 =?utf-8?B?MXdHbzI2YUdaODlhTlNOYnVTVk5hUXQ3VytDZDN1bjNkdWdCeW5LTGJUeUdt?=
 =?utf-8?B?YnZ3eXM4N2VqcHllb09pOG1vTGsrS3JhU3QrZnlsL1hUdm5CZzRJQWhxZHpl?=
 =?utf-8?B?MjNNSEJkUUN1RTVJWWUxdFNOajBEaGZPeXJoTDRZUzVIVTRwR1Z2T05VaUsw?=
 =?utf-8?B?REQzZ3pwUWxGNFRUQTNPcjh2WG1RUTQ0V2V6UndOLzY5M0QrTVBmNEQ0d0I0?=
 =?utf-8?B?OTA4K251UEpwMjF2Yk1DSHh5NFoyL0Y4MGs0VUxlbjB1cG1CTWFSb1NFUVlD?=
 =?utf-8?B?RkxIRy90WGV3TitKUlltQ2YwdDVtbUNVQzhubE14MmN1MkxyR3FmMVlxVGd4?=
 =?utf-8?B?WVFmMFU3cmlZVWVqZzZISjUxSmFpTGNuZnduQituYjFXeTJMR1Nhbi9UMXJS?=
 =?utf-8?B?dHpGTjU3UXFBa0tRUmxDaVJYLzFwdm1relJ1QklqcS9NeXlVSnpTeHo3bmEv?=
 =?utf-8?B?N1d3V2dsM3dHYnZtYnB2dzRQS0VMVllCVm9QanVzZkRDcjRVeUFUYStheldt?=
 =?utf-8?B?c3lVNVJHSkZRbTdtVUN5cUFhM01iZ2cvWjdEanp1TlYydkZRWnQvei9vZ0Iz?=
 =?utf-8?B?VHErS2cwMzlSN1c1b0pDMU14N1hHQ24rcWtnQUR2UGNGcVBWUFRPeDRPcGo4?=
 =?utf-8?B?ZmxEUXpYWUpRamd6T3V1blRYaDByTVB1QjU3aUZWZXozZnYweW1WSWkrclVz?=
 =?utf-8?B?QVZWOFZuWlZuazVDOVExWk9lSXZEOFlBUmd0cXVaeGkxWVAveHEyenVFRzNq?=
 =?utf-8?B?eUF6UnNEM0ZlazB2d0U0ZkJJTWlKZU43Zm45S1BvL1VFRS9xQnowYmxJdjdE?=
 =?utf-8?B?ZHNveE5NRVJ5UlM2VDY4ajZrOWJqZFBGQ3J5QTByUytoQ0RlRHpZRXdSUDRa?=
 =?utf-8?B?cngxSFRlL0NJRHY1TU85K0E2YkUwbWl4NWlnRjd0ZkZTNlBEQjhrU1FRbkNW?=
 =?utf-8?B?V0E4WW4zL1IzQ3NMdEo5NlVDL2xQMjZFMnpWSit4Tk5oc3pxSlBxdzJXWFJa?=
 =?utf-8?B?eDltWGlPMUZOdjZKSTNNdzluTGJVSUZmZm9tZk1VbDRxQTliWVExaVdFeXhU?=
 =?utf-8?B?bkpoREE0eHRrc3dGZkEzTEQ3WnBid0d5US83OFYvWkJPUlNTZFZKVTEwejN2?=
 =?utf-8?B?aDVSRnk1SkM3SjBKQTZ2L3BZMXVtV29EMGQ0QnNjcmo4NFpRbThrbkRzU0Zr?=
 =?utf-8?B?OEdsRmdNdlNOM0V3M3dLM3Awdm5WRlNrdWQyQ3ZqaGRHY3BkQlRmcUlqb1hn?=
 =?utf-8?B?OTJSZ3crakQvcFZuYmxKWmtadTBEeDRGVjl1MGVqQ05DaFg5OVg1bm02UXNF?=
 =?utf-8?B?eHZmbUpJamVvUmhWd1Zqb0VCZ1FrWkoxSFBiRGFSNEZJcWxraWRSQzNqTHNl?=
 =?utf-8?B?SWhxbjNxQWJBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NTRNVzhaRGdaRUVUOWJYQmZ2c0xOL2QxdFVLTTdjRC9qSGx1WElFYnF1bjNI?=
 =?utf-8?B?Ymo4Z1MrNkp6Qkk4MllkYVlSMlFnYm51RTZwS05oRE5FNUNsbms2Qm1EcFBT?=
 =?utf-8?B?VnkyOXJLcGR1NXVrZ090WTNmV3dabFo1eThVRlNXOTUvaUgzVm44VTIxTGtj?=
 =?utf-8?B?blVEdThmVU9KNVlYejBBaWZJMGNKSG1EUGE0UHNXQjM0SXVwMjBMRi9lYldt?=
 =?utf-8?B?b3pXM25aM2xnamNLMmJlMnZMYUZWVWF0cjBuWDdybXhPZDRWZVVodW01ZGhv?=
 =?utf-8?B?TnRTMk1xMmxBem9QN2VmdWJPREJxK214N3lhbUlaRU1pd045UGFCOUxJNWlh?=
 =?utf-8?B?Zmhvdit6Y1lFZm5iUGlPVG9qWURrNjYyL21IODF0SFhDOFZIT3ovbzBkMkg4?=
 =?utf-8?B?Qy96SnZUVGRRZDhEeGRVaU9RRCtkMlZsUWQxL3UwamFLSGxxcDlIcGN1c0NU?=
 =?utf-8?B?bGNTN2dUQUdORmF6ZUdJTlJZekkycDMyYm9RNmhDT05Vb0srZzNOWmc4Z0hr?=
 =?utf-8?B?cG1nZnhzV3VZaEdlZ3V4Vzd3VWJlRWNTZXAvb1Npc2U2MGZURVJSYzljVXV1?=
 =?utf-8?B?bmZDY2g1cUUrRVJ3NHg1eHJSbUs3ZGlSQngwOS9Da2M0SEJkNERhaDhybEZG?=
 =?utf-8?B?ajlsNm9CTE9HL1hhQjAyOXp1M0F1VjkrL0w1eGZKOUpFK0JIenlvNEhWa05J?=
 =?utf-8?B?VXBWekoxcWdoNWtqRGhXVTZTYnpDdVRwVzBKWHZKazBTOGJPS3liUGJRd2Np?=
 =?utf-8?B?UW0vNVA1Z0pTTThrdUFZa0duQWx6aEh0SVY2dUVkd1d1QjJ0Si80WEJQSXlQ?=
 =?utf-8?B?SFlteHlMeDIzL1JuTE9xVFZwRyt3YVNnajVYMi9CTmlJVEsrK2RQcmlDODRq?=
 =?utf-8?B?eU15K25saEF5bU9HbTZxbkd0REdUd1A2QldqTTc0M1NFT3NaUU5FSmNLWStw?=
 =?utf-8?B?WlJpZDZqTkR5ZEI2dWQySS84WWpUMEpUdndZdVFzN1pMQXlrK0pzM05JOS9U?=
 =?utf-8?B?c3poTnc4SFpUdk5YWWdQcHUyeHQrY093V1lqTmdhZVhwajlCSEp0eFArMmdD?=
 =?utf-8?B?aDNiZGsycEUxKzllMzVRVHVVVXJtSURTeHpSSHlPQUVsLzlkN3pxTFM0WFJr?=
 =?utf-8?B?dnJFb0p6dUxJeGVaTHdVTWdRYnFxWXRqajFlN0d3bk05VkIyVzFpUjlkbHI3?=
 =?utf-8?B?TmEvb2piN0FKTVFJVEpRcHN4WmZ5UEZOSEhyTkhpKzJMbzFjNitSdStRNmJi?=
 =?utf-8?B?eCtEdjk1RUpya3U4RWZqNk5nbFVzVys5anJXT3JDNGJwdFEzT1pwMm9rWlEv?=
 =?utf-8?B?bUFGb3dmemExR1Z3cTVra0ZUUE1LbURHMTFkUVVBdHQybWMwZ0RmQUxrY1Z4?=
 =?utf-8?B?am1jZUVDNU5wUVpkRG11dWxKMWpzRjdMSWJDdFQycU1XZ3VBS0E1NmFWN1dv?=
 =?utf-8?B?bGhqdWRETEZCa0pWRGVFTTNtSjdkTW94YS9veHVDY21ZYkY4bG8xc0pBcVVt?=
 =?utf-8?B?TTB5V0R6QklmVFlydlZWSS9ieE1teW5YUGcrN0o4bHp6b0FOVVg3YUdxU0Nn?=
 =?utf-8?B?SEJmNzh6OFQrWE9TUlZVRFpua0hicFBHVjNvVktXVkdYaVZmSEY2UTFEcEt6?=
 =?utf-8?B?eUFZSUM1MGt2a25KVzB5Q21kalBPaVFrN0VvRVlVQko3QjdiczdCZVM3bk9v?=
 =?utf-8?B?K0VobUc1MjNweUR2VEJTMWk5MDgzVzZqSFBEcUk5NTY3TXI5cE55TnBocjRY?=
 =?utf-8?B?eHNZa3dTcmtzaGJRLy8yZG9BZ1E0eC94YmlSQ3kvSFZWVW9GVDQycnhhelpa?=
 =?utf-8?B?cjQ5amNvazk0SzhRQkhZYjN6ZlVCQ1ZGNjRxajJPdlRnR0wreFBvK0FqZmJM?=
 =?utf-8?B?M0FPTEFWVmRoamM3bk91TG1aT0JXTDhucXFLa1R6WitTS0RMaXVtOE9TRXRK?=
 =?utf-8?B?WG9QS2MrL29pVlBNVS93YlNsem5oa2xWZmlhMm9Vcy9NemNOTzFCMitHcXQ3?=
 =?utf-8?B?dXc2N3dSM2dVMEp0UTk0cmUzeU9TQ3FWWU5EbzBVUGxzZWJhQXorUHU0ZHd0?=
 =?utf-8?B?MlEwRlNTbWg2aFV6K0FKVmhxa3VWcmxVKys3aFpnT1ZZSjdZVEtCMG5XZlNE?=
 =?utf-8?B?UkYwRnFSMTFQYzFLVG5MeVAvNGg0MmxCUk1renJIa3g4R2ZLOEFQaHl0ZDVE?=
 =?utf-8?B?d2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 19d1bdfa-d03f-4eb7-ef71-08de1d3ddf32
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2025 14:07:51.1407
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Jk5JP88AUVSTM3iVfL29Nt2ZMowm/Iz0GY+dgSMixV4sC2IyFTIW9poSyT5rE/psb9gfBHMxpGhUkdqdB6opPVkWMHtsFLMRyC4qsVYaYf8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR11MB5764
X-OriginatorOrg: intel.com

From: Ally Heev <allyheev@gmail.com>
Date: Thu, 06 Nov 2025 17:25:48 +0530

> Uninitialized pointers with `__free` attribute can cause undefined
> behavior as the memory assigned randomly to the pointer is freed
> automatically when the pointer goes out of scope.
> 
> It is better to initialize and assign pointers with `__free`
> attribute in one statement to ensure proper scope-based cleanup.
> 
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Closes: https://lore.kernel.org/all/aPiG_F5EBQUjZqsl@stanley.mountain/
> Signed-off-by: Ally Heev <allyheev@gmail.com>
> ---
> Changes in v3:
> - fixed style issues
> - Link to v2: https://lore.kernel.org/r/20251106-aheev-uninitialized-free-attr-net-ethernet-v2-1-048da0c5d6b6@gmail.com
> 
> Changes in v2:
> - fixed non-pointer initialization to NULL
> - NOTE: drop v1
> - Link to v1: https://lore.kernel.org/r/20251105-aheev-uninitialized-free-attr-net-ethernet-v1-1-f6ea84bbd750@gmail.com
> ---
>  drivers/net/ethernet/intel/ice/ice_flow.c       | 5 +++--
>  drivers/net/ethernet/intel/idpf/idpf_virtchnl.c | 5 +++--
>  2 files changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_flow.c b/drivers/net/ethernet/intel/ice/ice_flow.c
> index 6d5c939dc8a515c252cd2b77d155b69fa264ee92..3590dacf3ee57879b3809d715e40bb290e40c4aa 100644
> --- a/drivers/net/ethernet/intel/ice/ice_flow.c
> +++ b/drivers/net/ethernet/intel/ice/ice_flow.c
> @@ -1573,12 +1573,13 @@ ice_flow_set_parser_prof(struct ice_hw *hw, u16 dest_vsi, u16 fdir_vsi,
>  			 struct ice_parser_profile *prof, enum ice_block blk)
>  {
>  	u64 id = find_first_bit(prof->ptypes, ICE_FLOW_PTYPE_MAX);
> -	struct ice_flow_prof_params *params __free(kfree);
>  	u8 fv_words = hw->blk[blk].es.fvw;
>  	int status;
>  	int i, idx;
>  
> -	params = kzalloc(sizeof(*params), GFP_KERNEL);
> +	struct ice_flow_prof_params *params __free(kfree) =
> +		kzalloc(sizeof(*params), GFP_KERNEL);

Please don't do it that way. It's not C++ with RAII and
declare-where-you-use.
Just leave the variable declarations where they are, but initialize them
with `= NULL`.

Variable declarations must be in one block and sorted from the longest
to the shortest.

But most important, I'm not even sure how you could trigger an
"undefined behaviour" here. Both here and below the variable tagged with
`__free` is initialized right after the declaration block, before any
return. So how to trigger an UB here?

> +
>  	if (!params)
>  		return -ENOMEM;
>  
> diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
> index cbb5fa30f5a0ec778c1ee30470da3ca21cc1af24..368138715cd55cd1dadc686931cdda51c7a5130d 100644
> --- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
> +++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
> @@ -1012,7 +1012,6 @@ static int idpf_send_get_caps_msg(struct idpf_adapter *adapter)
>   */
>  static int idpf_send_get_lan_memory_regions(struct idpf_adapter *adapter)
>  {
> -	struct virtchnl2_get_lan_memory_regions *rcvd_regions __free(kfree);
>  	struct idpf_vc_xn_params xn_params = {
>  		.vc_op = VIRTCHNL2_OP_GET_LAN_MEMORY_REGIONS,
>  		.recv_buf.iov_len = IDPF_CTLQ_MAX_BUF_LEN,
> @@ -1023,7 +1022,9 @@ static int idpf_send_get_lan_memory_regions(struct idpf_adapter *adapter)
>  	ssize_t reply_sz;
>  	int err = 0;
>  
> -	rcvd_regions = kzalloc(IDPF_CTLQ_MAX_BUF_LEN, GFP_KERNEL);
> +	struct virtchnl2_get_lan_memory_regions *rcvd_regions __free(kfree) =
> +		kzalloc(IDPF_CTLQ_MAX_BUF_LEN, GFP_KERNEL);
> +
>  	if (!rcvd_regions)
>  		return -ENOMEM;

Same here, @rcvd_regions is initialized before the very first return, no
idea how one can provoke an UB here.

>  
> 
> ---
> base-commit: c9cfc122f03711a5124b4aafab3211cf4d35a2ac
> change-id: 20251105-aheev-uninitialized-free-attr-net-ethernet-7d106e4ab3f7
> 
> Best regards,

Thanks,
Olek

