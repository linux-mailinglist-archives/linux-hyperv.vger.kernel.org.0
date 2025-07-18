Return-Path: <linux-hyperv+bounces-6299-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A114B0AA99
	for <lists+linux-hyperv@lfdr.de>; Fri, 18 Jul 2025 21:17:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9D203B2F09
	for <lists+linux-hyperv@lfdr.de>; Fri, 18 Jul 2025 19:17:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72A392E3701;
	Fri, 18 Jul 2025 19:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Nn+DuwBQ"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B5CE4689;
	Fri, 18 Jul 2025 19:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752866263; cv=fail; b=iS2fzVqdMDLmSjxBVSe13DZf/S/rvaAYBDIqFR/ClX7UpZOxn67cpST5UMC4wvv3SHjH75KiuV/lA+BsgeWfCStonY/T2060wm6JMykPf00Hc10NZt959znNbHzhcg0MJ3TcbuUNy3ApOHwVG5TMavdStoK/h9NQcDtfJW9GehA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752866263; c=relaxed/simple;
	bh=ctOx4VeFgN4K0hFseRryZSD1O/vCFmg7/kDtcd7OxSw=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=Fo7aFPQMnp2yB3rfylc2vGc+c42CUtyWPg+4o1mr1GZOaVXg2JTDe9p8nVRW/MHAs4PIrIG2zGHP6Am8CMzp1Jagg9I3nIE5vM6rb791rsqrDk9RNly4mGhb/KYhasRPfXwQ7pe0nbz1L/vC/oaCkiGPkrwpdbixtGhOrdFoHGk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Nn+DuwBQ; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752866262; x=1784402262;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=ctOx4VeFgN4K0hFseRryZSD1O/vCFmg7/kDtcd7OxSw=;
  b=Nn+DuwBQgRG9ZNJkx/zsBZUInQA1EeWtJ9a9oncVqyx+Nc8GJiS/Rjfd
   QCHTlVwkyCZNxM1HoHC12Anoa6nU1AcqVWMTGlxpcvG79ED3FNP4u+l7m
   pbVdqxcqEp8kqLBos8ETx3nBBtgtBwSHnd/3ke97aBd0Lr3U9vx1RAEiK
   fLqBQu8T3Lj58/cUjl9dC2jFdWGdZmA3teUosO5wgYJCizmDODdmme6Oi
   GBe7pmZWuCVwDhpk90tHrY7covT8xiXqgBEqEC1bjzmls3opziC2C7kR/
   TmFsSBKjymSnm5QDJ54OQyRyLTb7f3ASNWES9WsxAVfeLo/HiAlk4RE6I
   A==;
X-CSE-ConnectionGUID: vZZsBfdVQkyWfWVrjk49bA==
X-CSE-MsgGUID: z1sriGx4Rt+6KQmgeg1yIA==
X-IronPort-AV: E=McAfee;i="6800,10657,11496"; a="57782134"
X-IronPort-AV: E=Sophos;i="6.16,322,1744095600"; 
   d="scan'208";a="57782134"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2025 12:17:39 -0700
X-CSE-ConnectionGUID: gQatHdFsSUy0Mv2ENW5Y8Q==
X-CSE-MsgGUID: 2I8KCJWGQVqusAZZayRROg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,322,1744095600"; 
   d="scan'208";a="158688983"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2025 12:17:38 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Fri, 18 Jul 2025 12:17:37 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Fri, 18 Jul 2025 12:17:37 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (40.107.243.75)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Fri, 18 Jul 2025 12:17:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=malq4uwrU1nDMf0ut9/7bg3eMkObxYN8H1KqTeCzRiFhJvrUK1XjZ9Igwv20ooxI9+jA6JfmYEvhL1Uld5NmxcRJ31ouNFll5FxtQQaWpxG5ddX2J6wte3xW1WqDqWkh9j044H4bLbjlp8SDwbVwfrtFafhcZALla12VEzhqE0S4gruTHeZ8yLH1U1Wh3EQOWLZBVt5GJIrUBWeOJxd5Mi43SxFi8Z6k1bjS8jApGZW8wNZejqAAZTuA+ETuVN1xv6oSJ0FlymNNQ+AYtfTcSlqTtJge0zUZijvPhwN4mODt8F6PWrEefcvc8pLB98chuW3Ip6l/4gW6No7VJxZtiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TF2NcvUtsjhF0dV4VItjVFoKb0lbza5vl+kutxZrOnU=;
 b=AP9nRPObHKnouNowRXS6LZcro6tpw4jfXkygCxDduNhEtUomrmW1KZ4P7TCxpVGYBBYuroDvFkBu0VtUYgd+uI1GgjkMv8hBf7+UMo9GqBV5Kv9TaN86uTN74iwRC/eQGVR5u1MKPuBeVlJchm4A/Uosu89/TARK+u+kXWVxSxSowtfUY/Ne+JVBTsrmGxpTpxKG0Ai7wEXQAWd/Y56hevBJA/VMiXzs/dWNPAbk+2m3Rg06N7fPAXUJBdxA5ToARA0qYyEI/ydrmByYEZAms2pudmpIWJZvUistpoI6EpGWisx8jnof++x69uNk9NXHUWwdKYpJ/GB/BGrJU8QI1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SA1PR11MB8811.namprd11.prod.outlook.com (2603:10b6:806:467::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.35; Fri, 18 Jul
 2025 19:17:06 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%6]) with mapi id 15.20.8922.037; Fri, 18 Jul 2025
 19:17:06 +0000
From: <dan.j.williams@intel.com>
Date: Fri, 18 Jul 2025 12:17:04 -0700
To: Michael Kelley <mhklinux@outlook.com>, "dan.j.williams@intel.com"
	<dan.j.williams@intel.com>, "bhelgaas@google.com" <bhelgaas@google.com>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "lukas@wunner.de"
	<lukas@wunner.de>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Jonathan.Cameron@huawei.com"
	<Jonathan.Cameron@huawei.com>, Suzuki K Poulose <suzuki.poulose@arm.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Rob Herring <robh@kernel.org>, "K.
 Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, "open
 list:Hyper-V/Azure CORE AND DRIVERS" <linux-hyperv@vger.kernel.org>
Message-ID: <687a9db02207e_137e6b10063@dwillia2-xfh.jf.intel.com.notmuch>
In-Reply-To: <SN6PR02MB4157A7F41F299608E605E0C5D450A@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20250716160835.680486-1-dan.j.williams@intel.com>
 <20250716160835.680486-3-dan.j.williams@intel.com>
 <SN6PR02MB4157ADD06608EFE00B86A3F7D451A@SN6PR02MB4157.namprd02.prod.outlook.com>
 <68795609847f7_137e6b100d8@dwillia2-xfh.jf.intel.com.notmuch>
 <SN6PR02MB4157E31D8448CD9D81D518C5D451A@SN6PR02MB4157.namprd02.prod.outlook.com>
 <687993e03bb4c_14c3561008c@dwillia2-xfh.jf.intel.com.notmuch>
 <SN6PR02MB4157A7F41F299608E605E0C5D450A@SN6PR02MB4157.namprd02.prod.outlook.com>
Subject: RE: [PATCH 2/3] PCI: Enable host bridge emulation for
 PCI_DOMAINS_GENERIC platforms
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR20CA0013.namprd20.prod.outlook.com
 (2603:10b6:a03:1f4::26) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SA1PR11MB8811:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a062811-3238-4c6d-304f-08ddc62faf0b
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NFR4YVNhdTBvRzRwYVg0VzJMR2ppblZPVkhheC9PenV1ekJheFRTSm5hbWlY?=
 =?utf-8?B?UWpsOHRrdjVoc3NDZ0xlSWVFb1p5WWZERTNmbm9CR0N5V0hxQXNGaVNXd3lw?=
 =?utf-8?B?YU44L2xuS1lGc0M5SVd0NzRWOFU0RGx4UUpNWDlFZlllQmsvamhYTXA4NkFO?=
 =?utf-8?B?SUdhQS83STY5ai9qbXVOVUl4b0Uvd3pKazgvRk5GaTBPN2pGMU9kR254VEtr?=
 =?utf-8?B?UFBQa0wwa0lnaUZqQWg5R0tmb1B3OTdNc2N3ajYzTHpJMjc2SXExZnN4UExG?=
 =?utf-8?B?Q1dGZ0g3czFkNzlIV01pQmxJeS9uVkJpTWpKdk15Uy9EZ1hhTHkrMVFzWmY5?=
 =?utf-8?B?REFtb2dabWlCWnpLOFIzTzlacktaRmFWais0ZFF5OXViWkR0NCs1RnFiTTFv?=
 =?utf-8?B?LzhmWStkWFBYY05qVHJjY1d2OWtaMUJnUFBndnYvWXhIVXVJbENTTFJXNnR0?=
 =?utf-8?B?TUN4STh6cFZxdVhQaHpHV0V1ekpTdyt4SXppYVhtaE5iTE10WDE1YTNZZnFK?=
 =?utf-8?B?cWxZOGhiT1pDQWpjVWxYUjdsVEVwQ3hJeGE4TzJSY29IZGc0alhhVy8xSUY2?=
 =?utf-8?B?a3RkcW4xQ09JMlRLUWhwM2pMZmxpUWJHSDBkUXVFcUMzT3R0c1BpT1RiOXR3?=
 =?utf-8?B?cXM5bmFCanpOaURkUC82dlA3UDlrbVNOQWZ6RUdqQ0Rrc2FFUERVYWV5RnZV?=
 =?utf-8?B?SVQrcnlkcnBEbFdHNnhnclNxQ1dscU8veG1yZi8xZ25ZcE5VUU9ycnVLL0Ew?=
 =?utf-8?B?NVJiUUg1WW9iNkx1RWtvU1ZKa011R0RPeFBCaERiN1dHQjBNbGhGdzRla04w?=
 =?utf-8?B?cnNYaTA0SnZWNUxuZFlIYi9PRDVRdGdyODZqeXBJRmZxa1pBcVYxSWpWdlJW?=
 =?utf-8?B?STA4dm9RVXNVc1FPck15My8xTnN2WWpMcEdCNmdPRGMrbitIYktvWWhIMGpu?=
 =?utf-8?B?TXlqZnVjSk1wbmtiQ2hRV0xqN210RnE4S1dvWnBRaFBHU0tsanFZY2FIdEw0?=
 =?utf-8?B?L2lpb1RrTTVJVWxNTitJNDRYYmhCMTVMMEw5UUYvRlRDcUlMQ0dneUcybjFS?=
 =?utf-8?B?aTV5dldNY1FmNXNoS3hqZ2VXVk1iU05QSGdnODZpSmFBbDE0eWVmVi9od2h1?=
 =?utf-8?B?RXdNUmt4Y3dER0JwZ1EyTHk2cDNkZGZkTHRKVUpQTFZ2RExwMGhoRWRSY1c5?=
 =?utf-8?B?NVJ3ZjY3SjlranVMNE5tczV2dE9PNGFqRDUrMkhsQW9nMVhXQjQvenE0NVNR?=
 =?utf-8?B?aDdkaXVMTWhXekN3QmtkdE9EOTRlNThuSzFxa3duVzQvYTRRY1M5bHpaWHh6?=
 =?utf-8?B?elhabTJ2Wm9SWjVVU1lZZjQwQnF6YXNWN1p5c3RDTzBkV1huanBabzJaazBl?=
 =?utf-8?B?N0IrNlczaUNtdFNZWktSUUVET2FFUnZNZkRHVk1pd0htd2d4dDVTNFIxNWVF?=
 =?utf-8?B?b05PNDdiR1M4Wlg1T3BEL1VOeDRpM0huYzhMeEZtaGRrdmJ0QWZQUy9TbFdB?=
 =?utf-8?B?bGVEV1d3YXAxZTliblZ6dUt5RDJNL1FmckhjajZ0YkVEWjZaRzNUZS9ISlh0?=
 =?utf-8?B?VThxSkFMZ1JVY1dTb20yUnc5aWFjVGRlY1RQdHFpWWJBdVNGZndPQTBYa1Bz?=
 =?utf-8?B?VGY1UWpvdHF5bFBWM0R4aUZ6VDlYaW95MkxBeHd6Sk1sQlVERExhbkVkSklU?=
 =?utf-8?B?cEcrMHVYQ1doTDZXK0lJbkxVMlJXMThkeWRqY1RhdTNZN0xSQ3hHNlNsS21q?=
 =?utf-8?B?bjVDdEhob1FvUnZHTU92dEV3WUVwOC9TK0ZDblhTWW9sWnd5ejdlZTBXQ2Ey?=
 =?utf-8?B?N0hhek4yYm1aU2hhaitidUFPcFFOa0ZnZDU2SFFkUy93cmhOaitDT2gvWUk2?=
 =?utf-8?B?QjJiU2tMOVpmbDdFNGVOdFNDeWIzS000UVBqN2VxdDZVQnc9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aDFrUUpuTi9GWXkvYmxCZ2JYemdrMjRFNGd4ei9NTEJMdzZQb0xKcHJmclpY?=
 =?utf-8?B?ZTMrUXNUZHYxU3BmU3JONHcrMy8xRW5yKzhuQzZsL2w1Qm1NblJhMmRtRVhK?=
 =?utf-8?B?Mk1IaHkwYUtCM2pMQlYyYWx5UDkvUHFibDc3OTgwTDNkcC91TzlOeW9tVTR5?=
 =?utf-8?B?T0ZGZTFMdXE2Nkxnby9TZStXOGVEcVpNak44TGlpckZRN1hBZ1FDZ2NmeWFw?=
 =?utf-8?B?VC90c01BbUZoYmN4VVBlcURnbzg1NkFmbkJwUVE5WG5ZMDRoY1d4SC9HUE5B?=
 =?utf-8?B?RGNlM1BGUEgvZU4rVlFFdjhSWXpGN1NxSHFiakhkRElJalJXQy9hVGlpbFRr?=
 =?utf-8?B?NzdqYnBmOGJZbkYvN2N1WTI3NVl2cDlqRG9QZ2lWZm9PNGVwWGkxQW0vSlVP?=
 =?utf-8?B?dnB3QVRJQmZ1VHR6QjE0d3A5dGFwY1AxQS9FanpNTFRhUHB2a25xenA0dENj?=
 =?utf-8?B?VE4vQlFYL0tzNUtnZlFrck9GbmcvTVh6Nng0Ty8xRlNZeDI5dm1tMEJlT09C?=
 =?utf-8?B?S2FDUUVIMThOL0pncXowUHl6U1pyWHJqVkJET2NOMUZCc1N0djVHSFVMQ0Ex?=
 =?utf-8?B?dFgxM0h1UXd6d241ckZTZ05xT2NlUUZKUXZTeXNFZ3M0b0ZnWlhiQ3A2eW9s?=
 =?utf-8?B?RWdFc3NWWTdLR0Q1MldPS1VRNXNXOEJzNDhBQ094WHUwem9mWkpVTjR0MmpN?=
 =?utf-8?B?YS9qN0JicEpOdkVXOFdSbkFCKzE1djZ1Qm0rZHRTZjB0RkNUQzlmTWVVREhE?=
 =?utf-8?B?b2N2N0JyZHkxU2dtTnozQ0w2a0ppT3BHY0JwWklGcWs2UFJwd2c4VWE3VlFU?=
 =?utf-8?B?a1VUaGEwMWp4TzR1UDVranRoOFNxTnJxSkdKSTR4bTdLay8rYUxob3JVRmFC?=
 =?utf-8?B?amtrMy9sTGVBMG1Wc2orcWZ2OE1SNEYveURDM1pSc0RUczdBc215am84R3hi?=
 =?utf-8?B?SEVDKzlvcWN1TVVqZ2pIL25pWWN5VkZaNUg0Q1JSUDlIUHVNL0g5dExuc3RN?=
 =?utf-8?B?bWQzci80ZmFHWjNneXBrT1hxeXhBV2pkLzlRK2dRRWxDaGRNTnUxRVo4NVNn?=
 =?utf-8?B?cjdnaHRMRXZKbEx0K1ZMVWExU01EMzBpRURiNXhnckFzWFkrRVNUVlAwMUhl?=
 =?utf-8?B?T256UlhVMWsybXQ1dkJSUDhQOE5tcWtnb3VNbGhTc1R5U1JncUhIZGt6VytK?=
 =?utf-8?B?MDgyMGtYNklNUmRibWprWHpTL2xDVVRLUUhQUHlEcnpnRmVhYjZNS0l4TWth?=
 =?utf-8?B?TzcrelV6K0NiOXNaY2U1NWJOcVg2ekg3Z2I5VGhXRnc4TTF5SDd2QmVrcVBO?=
 =?utf-8?B?c3BTMnFZbk1RSG5zT292SGU5QjV0eU1yTVRhbHc0d1htaEhVVDZuSzNSbWRD?=
 =?utf-8?B?dHZrYS8wZi8rWndvTnhDT3MvNjNJMnRjSytHYkduTzEyancvQzI2K1RHQVBJ?=
 =?utf-8?B?MDcyTVErQTBKT3I0VUhITTF4dm01VjJmZkpEOGFTOU5xalJ1T2t2VldFU3da?=
 =?utf-8?B?c1k3bHpxL0szRGthSnNSWnVGWU1ocGNiZWhaMkVRMjc2MVdWNHlRdXMxclM0?=
 =?utf-8?B?Uk0xMEgxallSSGZJdmJBNzE2L0x5WkVwOW9MV2FtcGROaFN4UThuRlZMT05t?=
 =?utf-8?B?WkFuWW94N2N2YkltLzl0aytFV1hDeWFaUVF1SEozaDl5VE9PZ2tMUFVBK3VD?=
 =?utf-8?B?eVhkUDlzNENtVVVNbWthejUyRHphNlRDYlQwdGI0VXdDSjllNnV5VjJrWDUy?=
 =?utf-8?B?YnNESnhobVBGb2daeWk3SlJpQ01oMys3RHkvL0UvN3YybXpoRk03UGRoTXFV?=
 =?utf-8?B?K1l1VEtnQVlGanFURUpSeEhwQTd1TEJkUHhhK09NMDJDQjNNamdhOWo3Rmo0?=
 =?utf-8?B?OXJQY0hvb011L3NyZEJlWmpLbFV0bCs4RzF0QmF0OUR6Q1VoM05ZL0dVVWI0?=
 =?utf-8?B?ejE1UjJCZmE2em1PcG13LzZRWnJPaWhUTXdHSExtUFdIVmM1RmpZQzV0aWZQ?=
 =?utf-8?B?WEVxWVJoNGpzeWFmeWtjd0N5QkkwZk5WK3NHanlXenJGZXFFdnJjZlgxR1pu?=
 =?utf-8?B?R1ByZ3hxTktMYm4ySVZFR0RtbmtPMzNvY0g5UHNwV1VIQ0E3TDBrOElBa1hi?=
 =?utf-8?B?Wmc5K2hVSVE0MGhtSlVJbFFxM1UwQzJYYzRrMW5uM0puZnZtMklZVUlCUGhw?=
 =?utf-8?B?QWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a062811-3238-4c6d-304f-08ddc62faf0b
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2025 19:17:06.0921
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +IYcvBcd80d3lyFctUM32s8jZwP3cyJwkLNN7JZupZYtcNv8TxXzdbrIdhWDXSuiWKb8BGOhpdAXBfP0pIL49Q8Cdye8dKGEDsc5WaFLmgE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8811
X-OriginatorOrg: intel.com

Michael Kelley wrote:
[..]
> > Here is the replacement fixup that I will fold in if it looks good to
> > you:
> > 
> > -- 8< --
> > diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
> > index cfe9806bdbe4..f1079a438bff 100644
> > --- a/drivers/pci/controller/pci-hyperv.c
> > +++ b/drivers/pci/controller/pci-hyperv.c
> > @@ -3642,9 +3642,9 @@ static int hv_pci_probe(struct hv_device *hdev,
> >  {
> >  	struct pci_host_bridge *bridge;
> >  	struct hv_pcibus_device *hbus;
> > -	u16 dom_req, dom;
> > +	int ret, dom;
> > +	u16 dom_req;
> >  	char *name;
> > -	int ret;
> > 
> >  	bridge = devm_pci_alloc_host_bridge(&hdev->device, 0);
> >  	if (!bridge)
> > @@ -3673,8 +3673,7 @@ static int hv_pci_probe(struct hv_device *hdev,
> >  	 * collisions) in the same VM.
> >  	 */
> >  	dom_req = hdev->dev_instance.b[5] << 8 | hdev->dev_instance.b[4];
> > -	dom = pci_bus_find_emul_domain_nr(dom_req);
> > -
> 
> As an additional paragraph the larger comment block above, let's include a
> massaged version of the comment associated with HVPCI_DOM_INVALID.
> Perhaps:
> 
>  *
>  * Because Gen1 VMs use domain 0, don't allow picking domain 0 here, even
>  * if bytes 4 and 5 of the instance GUID are both zero.
>  */

That looks good to me.

> 
> > +	dom = pci_bus_find_emul_domain_nr(dom_req, 1, U16_MAX);
> >  	if (dom < 0) {
> >  		dev_err(&hdev->device,
> >  			"Unable to use dom# 0x%x or other numbers", dom_req);
> > diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
> > index f60244ff9ef8..30935fe85af9 100644
> > --- a/drivers/pci/controller/vmd.c
> > +++ b/drivers/pci/controller/vmd.c
> > @@ -881,7 +881,14 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
> >  	pci_add_resource_offset(&resources, &vmd->resources[2], offset[1]);
> > 
> >  	sd->vmd_dev = vmd->dev;
> > -	sd->domain = pci_bus_find_emul_domain_nr(PCI_DOMAIN_NR_NOT_SET);
> > +
> > +	/*
> > +	 * Emulated domains start at 0x10000 to not clash with ACPI _SEG
> > +	 * domains.  Per ACPI r6.0, sec 6.5.6,  _SEG returns an integer, of
> > +	 * which the lower 16 bits are the PCI Segment Group (domain) number.
> > +	 * Other bits are currently reserved.
> > +	 */
> > +	sd->domain = pci_bus_find_emul_domain_nr(0, 0x10000, INT_MAX);
> >  	if (sd->domain < 0)
> >  		return sd->domain;
> > 
> > diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> > index 833ebf2d5213..de42e53f07d0 100644
> > --- a/drivers/pci/pci.c
> > +++ b/drivers/pci/pci.c
> > @@ -6695,34 +6695,15 @@ static void pci_no_domains(void)
> >  #ifdef CONFIG_PCI_DOMAINS
> >  static DEFINE_IDA(pci_domain_nr_dynamic_ida);
> > 
> > -/*
> > - * Find a free domain_nr either allocated by pci_domain_nr_dynamic_ida or
> > - * fallback to the first free domain number above the last ACPI segment number.
> > - * Caller may have a specific domain number in mind, in which case try to
> > - * reserve it.
> > - *
> > - * Note that this allocation is freed by pci_release_host_bridge_dev().
> > +/**
> > + * pci_bus_find_emul_domain_nr() - allocate a PCI domain number per constraints
> > + * @hint: desired domain, 0 if any id in the range of @min to @max is acceptable
> > + * @min: minimum allowable domain
> > + * @max: maximum allowable domain, no ids higher than INT_MAX will be returned
> >   */
> > -int pci_bus_find_emul_domain_nr(int hint)
> > +u32 pci_bus_find_emul_domain_nr(u32 hint, u32 min, u32 max)
> 
> Shouldn't the return type here still be "int"?  ida_alloc_range() can return a negative
> errno if it fails. And the call sites in hv_pci_probe() and vmd_enable_domain()
> store the return value into an "int".

Yup, good catch.

> Other than that, and my suggested added comment, this looks good.

Thanks!

