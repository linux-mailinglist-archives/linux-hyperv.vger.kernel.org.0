Return-Path: <linux-hyperv+bounces-2486-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E5615914605
	for <lists+linux-hyperv@lfdr.de>; Mon, 24 Jun 2024 11:16:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F2A41F23ED4
	for <lists+linux-hyperv@lfdr.de>; Mon, 24 Jun 2024 09:16:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C703713048F;
	Mon, 24 Jun 2024 09:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SAqdX7Xt"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84BF97FBA4;
	Mon, 24 Jun 2024 09:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719220590; cv=fail; b=XWEgPxBr+XRrxtVx0Rbn2HXN5RwFXlTs/GZgoKmiURUKQmo6UqAUXuduGOQqaWkkWLDv0fb1N7WCFtAUIsSH1PcYD0FYphdsMZ+16feVBrLc06ljli/ey8tPIUD2jg7SPvFc1af+l4/QyZtRZd53CDx51lWT3gxuX0rYWI4lk1o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719220590; c=relaxed/simple;
	bh=YcW7PE2yAOs6c2mZd6JwyhPt/FcbBzQS0Om1hz9QUQ0=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=TtPnwAZLQ73x+vybvZ5vkHGanxmfw4758t446ffBHw6qsY6tmLJldw3rIx9sab/hN+woSoF2ZS+roKDc8L7BYeFCRoZHKD4i17LN0Vi5hCPVHY952i6dc+/R6QUqp2DrYXdsE5ItE9jI+btaV7YFnmTxSGbRzzHTxXwAxN8onmI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SAqdX7Xt; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719220588; x=1750756588;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=YcW7PE2yAOs6c2mZd6JwyhPt/FcbBzQS0Om1hz9QUQ0=;
  b=SAqdX7XtnANPn7B8QR8aze8B1vvaPzbP3ICeooA7l2BEayoHq2mRP7Se
   ECcH/bawFEfB3QG3xEFSuWfujfLFSrh9S6ZjVGSffHTyYIYx0D2gPTNyO
   IhA3GDYtqRY2nkzuVI6JzEe7QaW/G7h5wPQrv9BmGpXc8EytW+Fz96lYE
   RGnptrM4/2KyBArqUMUuMNQhDAt2eGepfET3udAYyjfuzcvR7MKrmBcTw
   yLNaUCamAtq+5rAIT5w5IYSpDCJVambBVFmUN2ge+kWxY6tH02YL9NGcw
   RzogvNc27WPj3aQiDkpELgBLYIi47IMJjvutQ0N4I9JKoy/vIS5FEb6ea
   w==;
X-CSE-ConnectionGUID: x/6dmwVzQs6vhP8pNo2g1g==
X-CSE-MsgGUID: 0+9fmjapSRmE8oLHKWWEEw==
X-IronPort-AV: E=McAfee;i="6700,10204,11112"; a="15871440"
X-IronPort-AV: E=Sophos;i="6.08,261,1712646000"; 
   d="scan'208";a="15871440"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2024 02:16:27 -0700
X-CSE-ConnectionGUID: uVRpzMTHRvC7sGnN+mnX8Q==
X-CSE-MsgGUID: SgcPQ3lBR2u66CBcL+TAog==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,261,1712646000"; 
   d="scan'208";a="74466940"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 24 Jun 2024 02:16:27 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 24 Jun 2024 02:16:27 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 24 Jun 2024 02:16:27 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.47) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 24 Jun 2024 02:16:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Al1wIoNEA1KPMWMT15K4S6nEzOiPNew4TZL0HZXYLIQBpUiY4ACaIvNuOSMFtpMt/J1D8yQ3g0eHhDYCU3cZQqWZZnrs7iVxxPe2UYc/SUUGt0VDenhSV7FcHyFESCgWSEXxRGN5pEPXKzqK+21wBHsuFB65kSruX6YtB3ge2+zCmcfiW1QnmX3Wc7hn0cBdAUTtgamg/dTd6NlkDjSjAyew9OBEnTyC/rHfSbvzLlE/4CBqaQb1hDxUq/V0dGIu6Ypx/kI9sqrIiX4Fd55MQE3SSK4DMKrPSdtwXysRGAxavFbm1+gnWY5i7BY9JWCejTKg/GplzI406DKwpVMs9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9w6FOT+lCj3QJzhDN5cvPDPwXlLLHQdcJ/EDHEPqN1M=;
 b=dr58F3OkTZdLnDhs/FH8stIovQfiV+PHKykl4V5B4s81PWbJvlXyII+mXVizkA02AMVz3bu42Nmq1RKdBc6U88R1qhF6hbeiqkn1CdfVb4zb/2nwbIZBkzpGew2KHfKRJ6EhVsbqWzLZmzKYN0EpRaJepRnkjNytcZb5VNP7LrikFGAW66hUpZCpn/7MyFRvzPd0FZ7Ad9VyqTAg4Sn3a7A/V+NIauFNmau5/FyNmmMp80aEmPYbfhZvB0HC28a6d0ExBwoZMueRHioBTpoKgNBfIMcvT3AJfFZGS20kcBCslfKlkB22tNPfd+K4eefmHKsf3U3ymTardmzR7tGJSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by SJ1PR11MB6250.namprd11.prod.outlook.com (2603:10b6:a03:459::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.20; Mon, 24 Jun
 2024 09:16:24 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6%6]) with mapi id 15.20.7698.017; Mon, 24 Jun 2024
 09:16:24 +0000
Message-ID: <776f3d3c-dfd5-4bad-a612-97806d234d0a@intel.com>
Date: Mon, 24 Jun 2024 11:16:16 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: mana: Fix possible double free in error handling
 path
To: Ma Ke <make24@iscas.ac.cn>
CC: <linux-hyperv@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <kys@microsoft.com>,
	<haiyangz@microsoft.com>, <wei.liu@kernel.org>, <decui@microsoft.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <shradhagupta@linux.microsoft.com>, <horms@kernel.org>,
	<kotaranov@microsoft.com>, <linyunsheng@huawei.com>,
	<schakrabarti@linux.microsoft.com>, <erick.archer@outlook.com>
References: <20240624032112.2286526-1-make24@iscas.ac.cn>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <20240624032112.2286526-1-make24@iscas.ac.cn>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ZR0P278CA0117.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:20::14) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|SJ1PR11MB6250:EE_
X-MS-Office365-Filtering-Correlation-Id: 5781fbe9-b684-4198-0a70-08dc942e51c0
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|366013|376011|7416011|1800799021;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WEUxMFlvWnVxcElmWTlHdG9uSkNVSHJiZ2s3OER3Tk5VTGdQcWJLa3NtZlZh?=
 =?utf-8?B?c1RMME4rOG1zK09iYm00ZXkxa1pWL0h1bkozcEpsaENXd3JzWXJudEpUa0N4?=
 =?utf-8?B?UU83SmlCeUhYTjdjbFdreVh5d0JKVFNyYmFQVWVsUm5LSmxrQUJmSFlNSVc4?=
 =?utf-8?B?cEY3Vzk4a2kvYmdFazc1NkR2MVFVYmpWZGxRcG1VcU1rMU9LR1JjdDc1YUls?=
 =?utf-8?B?bzdUL2FqSi84TGpZU3k3MW0wRWhubHRWYngvelFtMnNwK29TbWtQdlU4V05h?=
 =?utf-8?B?TXRtR2x4eURKaVQrVkErc20zZWFLTk1xZnovSHRWMU1HeWtZS3B2Snc3RkFT?=
 =?utf-8?B?Y0JMWmhjOElWbE82ekhWNkoreUlTNzRXY2IzS3pBQkxibzFSd3d1T2lyd216?=
 =?utf-8?B?RGUxNHNvQ1lINGhqa2t0V1B5MDhYSmMwMTViVkhKbWNvbnA4MXJtU0ZHck5m?=
 =?utf-8?B?WENJRVErM3pqd2g0OG9TRTZhZFZtbVNUdDRhMWhkb04zSGdPQlNRWGdBY05p?=
 =?utf-8?B?bU02cmJrcnIwMk0yL0d1OFlEVWI4STJZZ0NiN3ErSFJTRExJUFdHMTVOa25T?=
 =?utf-8?B?Y2RscXgxeCs0TS9VUWl3RGRwZHQyQVQrc1ZlWVlIQTZEV29JOGNNcTVJYThm?=
 =?utf-8?B?ZFBSRzhPN09GZ3VQdWlycEplMWRwVDRqOHJueDlkZFNiU01vMHVodVo2RnVR?=
 =?utf-8?B?RlRVQkZqRktMbnBVT21UbERkSStCTjhxTWYyRjFHWGpRUTBnK0I4VmZIbERj?=
 =?utf-8?B?MkY0dmVjaGVlUjBDcENzdmtleUduWFZLWE0zZDZFTlVObDUrMUNvMlZVS2t0?=
 =?utf-8?B?RnFBT0p5N0JPTDhOKzVRd2YvUDBlenJ4QUFTa05MSWswd05FSkdWMFhwUk1C?=
 =?utf-8?B?ZEVaLzRCdG5abFdaS3pGSDlxR1BsMDVCU1hnWERNZVV3MEwxOUlVMFRza24x?=
 =?utf-8?B?REVQTnR1VmVhaVZhYkVQWDVNdjIzQXAxQjJuaDdiT3o5UUVseEI1cFBKY3gr?=
 =?utf-8?B?RmJqWC9Ib1VBWGIyb2l3aWRSUVdnMFdJd2k1ZjRNeTRXVk1OMGN0bElJY08y?=
 =?utf-8?B?YnB4QXVCNWdEUkRrelNIalRUdUdMRVkwamovYVd1WUE4V1lWNjFKK1NaU3c1?=
 =?utf-8?B?TWZmTHp3cThWeDJpSE9Wc25LekxDemRMcGRMbGlWVUNndy9xakdSNUtTWk1L?=
 =?utf-8?B?Y2gySTcwTmxoVFkxSFMva1NVM21XdWZ1T3FST20xSW40NlBCOENneWdTb0ZP?=
 =?utf-8?B?NnRFZTErZzl6VjJ6S3MwWEljSThsa0l4OWoxK0kwTzNiZXdSUmtXcGJkWHV6?=
 =?utf-8?B?QjJablJQd0U5RTUvMUJOM00xd3ZXamJNNyt6Q0Z0b3Yzem9PVzBaQitDVXBK?=
 =?utf-8?B?NGVrdjVYSUZjM3lTRTEremtuZFdSWFB1ckZ3SERBZWRobDA4QVRETlJhcjBZ?=
 =?utf-8?B?QmRMeXQ4a1F6TERWWU5tdmo5T3JnMW50eFVXakJsUnpPOGpLVDd2K3ZGR01X?=
 =?utf-8?B?bnI2SEF5NHlLZ3h5Z3M3aU5wTmgwWFZPNUtIcGRtYUVKajFqZUx2c2F5N0tp?=
 =?utf-8?B?L3diODA4ZGdUUjI2R25NUE9sZ000WUR1M2dFVXNvT2NibktRUzdsUHRkamJK?=
 =?utf-8?B?Qk0xN25xTktrT0Q5bnZIZmc1WmJ6MkdNdDhKMWEvRERuWENaWTE4RUNCN2Ro?=
 =?utf-8?B?NzVoMlFocDNGLzJYV01xWnZZVG9RY1ZOY1BlZG90YzV5cHVZZWlIN0JNOW9U?=
 =?utf-8?Q?Rmv+EhDzhkBZWJZIIWyrwKHlsNTEGckoKJF01Ez?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(376011)(7416011)(1800799021);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TmlYbUJ6bGxDM1Z6aVZxaGhSL0J4cXZ6RFdCSEZLeXdsMmlIRWRlZkRNMHhC?=
 =?utf-8?B?Y01QSmQ0NFlmQTQ1SlBwUU9lWFdsbDNQOVFHY1YxdVIzazhHaVp0SnArYnVV?=
 =?utf-8?B?OEZnbmZkc0FpdzJnNjFtdmIvakdqRWJNMGRBQWFHQytyNWZ6U0gxeDh1Y3dZ?=
 =?utf-8?B?U0U0SHlDdGM2Si9aRDc4OWpnS0VvRHpqT291R1cyeXJnMzR2LzQ0Z2RWS0g4?=
 =?utf-8?B?L1F3RmdvMVJHbkoydFovQ2hRSmdRYjluMkJ1TW5uM2pKMFh4V3lwU2VhMkpk?=
 =?utf-8?B?cjQ4VVdUcVVSMlRtOFY1VVhQVjg4U3YrUHhiQTMxeUFpTkx2V2tDSEZyS1JO?=
 =?utf-8?B?UzFsTkIySXp5ZE5SS3NJSkhGTEFmRWoxbFVFaDVZdFFVbzNkd25qL1dQN1RG?=
 =?utf-8?B?NGo5ekJtZDBNS082UFUzNGx3UEovcjNwN0RocXcyemNmdm9rK1lyaWlleTZJ?=
 =?utf-8?B?eWVacEhyU3lhVVJEUnR4MU5CT2hzYXpQWm9rT2xhb29HQ0d2d2orV1pMMjla?=
 =?utf-8?B?bE9zTUhNeS8zNHlVRG1EZTVENUtmUjFaR1YzUmQ5cDBtNW0xVUxOUFdTZVp1?=
 =?utf-8?B?QUhmUnBud1NVZVlzcHFXUFJ5Z3lCQXNjQzRKYnpwRGZKU3A0SHdEWHlHSjk2?=
 =?utf-8?B?bGY2Tk5UYytBSGJWZjNHbFN3aW9vVXhUUkpIaUdiL2UrL0ozSnlKYWZtSzZx?=
 =?utf-8?B?eFgyVVRzTk84cG5LSzBQNTNuanhXZUcvLzJxQkxxZ2M5YklqMnlzWVJTeEhq?=
 =?utf-8?B?Q21DdVk2Q0VmaGNJTW5IbVJkdElITEhSWmFlTElOVjRUOEdlUkdkN3pnMUtq?=
 =?utf-8?B?ZDltNDBpNWs0SkxHNndZUHBLK3RjenpLdTExTnZvUEZhczlsbTdsSFFiK3F3?=
 =?utf-8?B?dUNIYjV0bW1jbUt4SmtUQUh5RkYzRnk0YWxya28rUHIvYXlNWXh3UkNMWGJH?=
 =?utf-8?B?aDdkZ3A4c05FUlU5QVhDN3dmdGlENFp6QVNVTFVtb1BScGVpVXlpenFzdFU5?=
 =?utf-8?B?eGZTb1Qzcm9uZnFGZEQ2N3JCWXBwRXdRV2orOGR3YVl6SGhsbjlJQkErQzhm?=
 =?utf-8?B?cG80ekZFS1RIQ1NlS1JxUm1tWDg2aEI2cEpFMXJWek1KT0thN3o4MGhvTmc3?=
 =?utf-8?B?ejZCYWRoZDVMT28xRXFmaHV6eXl1WWQrWlVUQlJUTVFOd2RCbXB6SXdGSlVF?=
 =?utf-8?B?N0xubGFNSlFHeGcxV2pIL1FkZ1dFdmpibWwvZGpydnVUQ2l6cWNIRnZoRzJv?=
 =?utf-8?B?cld3VTJGM2xjbGlLMmM5QUFhYkVhTEtsVHJuNjNmcmcxV3h6V1l5dTFDZ3Zs?=
 =?utf-8?B?OXhSUXBlNkJrVTc2LzEzTWtrZUVWNUwrRC8rT3pvMnJYUXJWbXpjck8reWEx?=
 =?utf-8?B?T3hsczdzeXZjNFg0d2taSGhvOVFOaWVzWWxNUTI2LzJ2a0NkR3pZbk45Qnhy?=
 =?utf-8?B?NVkyaUl2QXhJWHY5VDdNUHVNLzFaeEN4WVBJTTdYdFlmZzU4a0hzaTJjdEhn?=
 =?utf-8?B?dFFmQUFOaDZua2FhTk5YOUw1dVRmVG1CNTE4ak02ZGVFYlFYQ3pROHNLeVFR?=
 =?utf-8?B?cWFBWUExNlNZbG00MmZXa0ZDcTRhNmorVkFTMEJIVFlGNC8xWjNZVE5kN1dv?=
 =?utf-8?B?QnVGcWZVMW8veExBOS9jcjRBV0paUjVxbmZ6dDV3Y2NmVkdxTGpURGNiV1d1?=
 =?utf-8?B?VmVXWnZWcjhFTldPOVpLZTRhbDhPd1NWbEJhY1hadHh2cEpqaW9mOEV4M1Zq?=
 =?utf-8?B?Z1hWZVpGWmhUSFMyVTF5MndZL2E3NmJzZ0VSMVBJcE1mOVhQVDMzaTJ0enhT?=
 =?utf-8?B?V3RpT2o1dk1SbFN5bDUrdW9pRXI4NktEVHNYOHg5UTAyVW5lVnpOek5vdFdC?=
 =?utf-8?B?WGc4eHd3YjdlV0Rod3lVSVM4SndDUk1UQUVHeFNVczRFL1QyQ2hXZVZ2N3Vr?=
 =?utf-8?B?cWdxOG1QSnUxYkVIYjk3WUl1S3JGUmRQYUtwaXJCcGdvYnVwNHhmbndzcjlZ?=
 =?utf-8?B?Q3diM2dmclMvOWNXZFF6LytGWVRwc3dDSzBGN1hNOCtXTlFLY0JpbDhOYnNO?=
 =?utf-8?B?OUkvcTVyUWNvS2drTHBzYUpjZnNFeHZCb042OHEzdkVwY3VKOTVMQlpKY2tq?=
 =?utf-8?B?SHNJNStPRmF1QlZETHZtN2xtdi9mUFdObVIxN1grbUhYWE1nakFsK1poeWhZ?=
 =?utf-8?B?OXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5781fbe9-b684-4198-0a70-08dc942e51c0
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2024 09:16:24.2447
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7r5mZIIzXusEvdg+IoAyYDXnBK0RU4p28MKxKI88rlleRLIBs39Ngb66cTLYhXXjgzFoDeg4MKbCIqFmuj/nZlOSnUcwD39jjqcdk30olxE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6250
X-OriginatorOrg: intel.com

On 6/24/24 05:21, Ma Ke wrote:
> When auxiliary_device_add() returns error and then calls
> auxiliary_device_uninit(), callback function adev_release

I would add () after function name

> calls kfree(madev) to free memory. We shouldn't call kfree(padev)

there is no `padev` in the patch :)
"to free memory" part sounds redundant.

> again in the error handling path.
> 
> Signed-off-by: Ma Ke <make24@iscas.ac.cn>

you need a Fixes: tag

> ---
>   drivers/net/ethernet/microsoft/mana/mana_en.c | 31 +++++++++----------
>   1 file changed, 14 insertions(+), 17 deletions(-)
> 

