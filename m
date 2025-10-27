Return-Path: <linux-hyperv+bounces-7348-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4CBDC116D3
	for <lists+linux-hyperv@lfdr.de>; Mon, 27 Oct 2025 21:42:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C38C942651F
	for <lists+linux-hyperv@lfdr.de>; Mon, 27 Oct 2025 20:42:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2235D31D756;
	Mon, 27 Oct 2025 20:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fDSJbhPJ"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B1EA31BCBC;
	Mon, 27 Oct 2025 20:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761597731; cv=fail; b=LgBGf1gv8vlPuTlgnZ/Ax4SKN4VpjbE+rIsDHiaRcqsm4AD/D2TYeffumIcNkK0miCUKUNEoJrBJZLOjGxd9bjqQQwk7YwX2dinM3wIUCIg1OdODG9bPJHhofISWjxm8MYph7JPLUgCbzqTEyQxKTRuOENMXrdptNaQF7tAvNjk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761597731; c=relaxed/simple;
	bh=+44ouHbk4GUZwpeNDxO3/DsdVSn/CXT5t+t8W3VaOBQ=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fVMkaANe0dAHc9WPWn+HhORL24xpvn/QszWNtJV7DIC/tEU8rK0goS93/B3+AT1xMb1kceUQy2P1STJc6N3aDb4eMZiumk5O8dHVEMQh/1NuqtPZfr5k2DrpTYJ695Wa/LmMkY3bPMfouNR4gt7BG1Q2IKlZPcv7UiDP8/HDykU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fDSJbhPJ; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761597730; x=1793133730;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=+44ouHbk4GUZwpeNDxO3/DsdVSn/CXT5t+t8W3VaOBQ=;
  b=fDSJbhPJgCTmLuP9C7S60AJFSS6s1x4d58uRUDiqI8Q73rgM6YTP63y0
   kef+9Eq18AhnDXZCw4DVqIymF8MjN45HS7zad/WnycxzlBTl4kA5WgtQ6
   1DiDN3knY3Zft4dKFtIR9oUQD71jD4fu3ZVRa+f3ONr4I0wOmGoWqAi0N
   Vyc7J4EtaZjVz6eD9xNHQ+QsvmEwnLHIBGgfeN7hm40m46tX67aOYFxPk
   udHAY6YRSIWINo9h11aSYqyF3xq3ugW93ekwAVYKVo8J0oioK+IqXQ2P3
   oRmq10/ivzfwzXqNKMhPuek4W3t//BtT2gZidc4KUZhDt/YTI9P78Nbp0
   g==;
X-CSE-ConnectionGUID: +TRTS9bpSEyt2mZxaC28Ig==
X-CSE-MsgGUID: LzAmLw/ZRVuhCNMfMWx+OA==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="73976356"
X-IronPort-AV: E=Sophos;i="6.19,259,1754982000"; 
   d="scan'208";a="73976356"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2025 13:42:09 -0700
X-CSE-ConnectionGUID: VMfaGHB/QzOLD/NiW80ccw==
X-CSE-MsgGUID: tNWl+rnFSP6J+C5xOeRe5Q==
X-ExtLoop1: 1
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2025 13:42:08 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 27 Oct 2025 13:42:07 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Mon, 27 Oct 2025 13:42:07 -0700
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.47) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 27 Oct 2025 13:42:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ajY4l9gOrf6Si5N/zxt8d1Q76gmp+s3cPDIBgQzVsaoQw/Ee11+u9x6AbJzm5rJ/ef1ZlQVUJ2jTZVlLcWrq4FpkU/WpEJL+DP6FWICzWf4uc4irVCRSaJTaAHAZqzfP478/cV86tGXaWjNLLHCDSqXeIqnuEc0b35hfdTHQoItCdWisogKAEicx3o3Ff6/tM9XPZiHm9XKHNCL9qekxak6Bo2HAlQelBMcLsLUI0a9mp72j2ns0d/Nx4pFzjMYhHY+MJ/j7FfkheiXx9u/sRSrdFhwgbQWhrm4+UrXOO1OuTvwMMK8rFd3ZCP4H78RaI02iV237A/qOWvqeF6ONPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ujfC9pJYsAb4J/6qZQxN+uE+pkTVWkuTJ3nLaPUHYSo=;
 b=A8ETQuiDdL3uEiaVyQ/DK/EkXnmhW0F4MOJjq6inReVuWfQwF2uVU/8h91ANk59aVq+QQ4UZS/Lgcn9Fq24BOWY2uBvyYbvoq8Lp2RQ4tXAs42/K0aC/dDnhCNo8+OY5F6o+Bd7P7nTypo8IHaAek/9YEhux+Dxv4fPCgpjemJxgy7U9S/trZIAwXP2u1sk+FgdLhYDQjIncwMEuFtCm3Om2ILFFd086h7a/lk6X0F1LEwhS0r4TGPNnk06G+psmuH2ME2a2u4+uBieae0PoVIfAndYZUs92Ot8DTvQvMAftmsDEANOkV6JJmiBc9BpySye71Uoehf/ZPpBCyuKn/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM3PPF63A6024A9.namprd11.prod.outlook.com
 (2603:10b6:f:fc00::f27) by SA2PR11MB5082.namprd11.prod.outlook.com
 (2603:10b6:806:115::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.15; Mon, 27 Oct
 2025 20:41:58 +0000
Received: from DM3PPF63A6024A9.namprd11.prod.outlook.com
 ([fe80::eed8:bee8:188e:b09c]) by DM3PPF63A6024A9.namprd11.prod.outlook.com
 ([fe80::eed8:bee8:188e:b09c%8]) with mapi id 15.20.9253.013; Mon, 27 Oct 2025
 20:41:58 +0000
Message-ID: <79a84889-328a-4346-b1ca-7f92bdc89d6b@intel.com>
Date: Mon, 27 Oct 2025 21:41:51 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 03/10] dt-bindings: reserved-memory: Wakeup Mailbox for
 Intel processors
To: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>, Borislav Petkov
	<bp@alien8.de>
CC: <x86@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Rob Herring <robh@kernel.org>, "K. Y. Srinivasan"
	<kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu
	<wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, Michael Kelley
	<mhklinux@outlook.com>, "Rafael J. Wysocki" <rafael@kernel.org>, "Saurabh
 Sengar" <ssengar@linux.microsoft.com>, Chris Oo <cho@microsoft.com>, "Kirill
 A. Shutemov" <kas@kernel.org>, <linux-hyperv@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Ricardo Neri <ricardo.neri@intel.com>,
	Yunhong Jiang <yunhong.jiang@linux.intel.com>
References: <20251016-rneri-wakeup-mailbox-v6-0-40435fb9305e@linux.intel.com>
 <20251016-rneri-wakeup-mailbox-v6-3-40435fb9305e@linux.intel.com>
 <20251027142244.GZaP-ANLSidOxk0R_W@fat_crate.local>
 <20251027204538.GA14161@ranerica-svr.sc.intel.com>
Content-Language: en-US
From: "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>
In-Reply-To: <20251027204538.GA14161@ranerica-svr.sc.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BE0P281CA0008.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:a::18) To DM3PPF63A6024A9.namprd11.prod.outlook.com
 (2603:10b6:f:fc00::f27)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM3PPF63A6024A9:EE_|SA2PR11MB5082:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b254e63-fdb8-43a6-bd92-08de15994607
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MUJWallVYi95ZXBPaTJ6Zm5DVlo1RVV3V1pTVm94Q0dpN0dnSmpRRXpkNTVD?=
 =?utf-8?B?aWxpVDdmSlRBQmVxTkl4Q3RYN3phMzAzaTdnMUJNS0pDTTVjTG5ydmpOQUls?=
 =?utf-8?B?akM0Y1BrQWhPZk1NNURxUmhFS2NETjdpdjNRZUh2WVBYTlYxbThKcFFSREdS?=
 =?utf-8?B?aTBObkh1TjJnV2xicFltZnFBKy84Q2h6YlFlNHRFdWo0di9ZWThwdFFOaWZS?=
 =?utf-8?B?WnM4NlVkbEUxTFRNMEZLWGxXbTZaVWVabUllMVBVbVlCNXg3NVlZMGpYZUps?=
 =?utf-8?B?SWxXd0pEVHAxZS9sK2drZnNTN2h1NnpscHZaUEpWWEdCUU51MWtoUmgvakxB?=
 =?utf-8?B?WlpqYkhLbFVTdy9iQkFJc2dOKzBEKzg5NlphUGxjaGhOWEsxQkNkVC9RRDJn?=
 =?utf-8?B?RGZwYXVLcXNwNyt4eDdDRnB0WUhvT0U4ekNrUGI1VldFbEIrK3oyMXgrc2Qv?=
 =?utf-8?B?dVl6cXloUFJGZFhlWGF2TXQvV2l2eHZOcjhOZmdoSW1mcmdTMlA5Mm9KZHM4?=
 =?utf-8?B?YTE2Y0xJa3N1am1aQmd6VlNoWGMwbTMvQmNKY0JqNlRnTnF2SW1ObVlSemdh?=
 =?utf-8?B?TDhNc3NQS0lQQ2ZVMVJyd09OeTRYOW14bkMvMFl1RVhMNHBaSzhrMU1CSVN1?=
 =?utf-8?B?bTlUU2tBSXhYTjFwM2xvTEdEVUV4MkVWNkNpc25qWno3SXp6SXczOU5jNG5u?=
 =?utf-8?B?Z01keWlCamN3N24yMGNqQ1h1UnlBQjRrbWtGMHFpRDYwaGMvTE10ZEdRUlNR?=
 =?utf-8?B?d21jYVNuN0NmYmxnT3BRd3ZiUDFNQkw2VXVudlk1ajlUeXRLeHBXdjhEanB5?=
 =?utf-8?B?ciswYXBaSkxtMDc4TEVvRGdkZXlFQjVtS3lNL3BkNGVpZE9jU2VITWVjZTA2?=
 =?utf-8?B?cnBZank0bGxZUU14R1k1cmUyZU94eE5iY05IMzY1WkFPdjdyRVY5ZjVWa3cx?=
 =?utf-8?B?eFFiQjlSM2E0dnp2ekNlZUs4dkxydEhRY2l0RmF3VFhObGZNcm1ZSVZxUi96?=
 =?utf-8?B?TUpRSWtjNlNKdVE1V3NYWEJIMUo3NHRGZWRldHlING42TTNwQkpaUFp5RWdh?=
 =?utf-8?B?TlBTY3ZYeG92UUtRQldVNk45K0c4a0lGWVBncTFpckVENDZhNmI4UVNxOWlC?=
 =?utf-8?B?eEtENUY3NGw0Vks2MTI2dzE0bzZ5M0huaUNhbW43VUloRFZFRENBMjB6amI1?=
 =?utf-8?B?c2MzdDhmdzBUNkJXU3JVQmo2MUN4NFNlNWNMdUF6WGdTa0N2aFpINTQvMkI0?=
 =?utf-8?B?aklHMUp4Q25QaTREbnA3QXRUM3MvUDA2K1o2UWRWZkUwcEpxdEZ3WktPb09F?=
 =?utf-8?B?SDBmR0s4ZGFLMWVnNHlyUEFybmJsN1ZISi9xWkFTTW5GQzhJdGRUb0NFREFw?=
 =?utf-8?B?UGVVcDBjcExFbWNIZXY5alFmby9lbGU3QXFqVU8rOVJGNmhyU2IzOWVCa24x?=
 =?utf-8?B?YlJGd1ZUbTNJdXhPUWlkcVJ0WGhCWHdFOGhPTCtJOHArYkR3cWd2bCsrOGo5?=
 =?utf-8?B?OGx1YzMvQ2Nrd0xwSlFXM1FOK2lTbmMrN2pYTnU4eEd5S29yRy9rWG15Sldn?=
 =?utf-8?B?WTJHTkNlZC9tZENaQTdYWlRmVDFtaTdlL1kvN2VCd3k1Q0trK0dyQmdHb09N?=
 =?utf-8?B?eXowQUcweFcydFo4WTZQMXYzQXlubDZmWkxFekhHQVY5UGk0M3A4K0IwUzFI?=
 =?utf-8?B?Y285OVFUaldhRUx2cnJCeTB2NWZ3dUgvdWxDK3JBVXJrNXVqYjg5TEwzNjNs?=
 =?utf-8?B?VXBoMWhYbzhJRkdCcDVsUERzRVhPUDkvRUtRUGxqdjlXbkYvcVBJRkJ3TjJY?=
 =?utf-8?B?cUYrQmRIY2k3WWNPeHBiSTJVUGorMXB5NjNxSSsrdi9iSzkzczhRTFltM0tk?=
 =?utf-8?B?TzdOK0pBRnhJQzVWbnJTV3Q3OHJKZm50L3dXQ2h3MjJ2MytIclM3SHhyaGxK?=
 =?utf-8?Q?i6xoYv4kfkCasRZ0EuRWoTn3tp7LOt6Z?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM3PPF63A6024A9.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TEpiYUd1dzNBWklMbVNZMjUxQ3NqakJWRjlYOHZvZllqNGt0V3lLRDhFMGR2?=
 =?utf-8?B?QjNOOEtUQStNRTdTRTBSbmdhZEJKYWJCN3pNK2xhRmNnS050Q0RXYlk4azJj?=
 =?utf-8?B?dGhQVFlpUmxjZjF4UmhRVTBtU2U5Njh2aDZ1NEcwblB6ZnJ3Rzg1ZmM1NkdB?=
 =?utf-8?B?UlB3Vnp2MlVra0tUZVQ2UmxYR3FwVkxpcGdGeEd6SU1WQXI2c3g0V3VHVmNM?=
 =?utf-8?B?dXVMdVZ1cTlYbWRZVDY5MUZ4ZTZ3UGJlaDFPcHBmT09RRE56YWxtTTg3bWEz?=
 =?utf-8?B?bHFDTDRpczFkWXJRVk82aU5YOFBJT0k2aWdmaFIvbElFbjFLRDJuNkowQlNh?=
 =?utf-8?B?b3JNYTM1Sm85eEkyZHdWWFlzeGh0TUtycEdra0hhUTBKSG9Dd0xMMlVYT2Qw?=
 =?utf-8?B?S0dWUzRxVkowSmR2SUI0c3RQN0wxeEtnYndwSGdSOXNlWTlIUHEvZkNrdXlC?=
 =?utf-8?B?UFovYkFiQVJKczU4S0pGMkx1UFBMeGZtUHFkaldaZ1hSMENSbWUrOXhUS0FX?=
 =?utf-8?B?MitHS1FValpWa3cwQWk0Zm9MVlhzLzZta21saWQySjcxNTJWU1FUZTZqS3Vz?=
 =?utf-8?B?eEtDM0ZCcXJjTi81ZE5PY2FiVURRUlBWZUtjcmZzTlQvRjJMeFE5Mzd4Wk9L?=
 =?utf-8?B?cWw0QVhzaW5uaGFQdEh3YnFQVTFoK0dYa1NwdXV6eHdGVzRJc01SbWljZ2hm?=
 =?utf-8?B?Rm1aQTRNejFSU3NTYytPc1dWbklRUW5rWmdrdEU3MVlyUEEydG5ETEFLZW1H?=
 =?utf-8?B?MG9tYlZ5d2o1eVY1Q29Ia2V5L2duQmpIbk9zaW5pTEt6SXpFNHFaY1E0b2Ja?=
 =?utf-8?B?c3FzNUJGWFNVdmMwMWJ0N0RUbkhiNitDanBpZDJFMElNd2w5Ym1MU3RzVmZH?=
 =?utf-8?B?NytWc01LZWJlczBlVGpJaXNPSzZDemJHY2pTR2tsYjc4cDRqNitKNUhGVTVL?=
 =?utf-8?B?SEllendTVEJJZnVGSzFoWXdyQ1lmNG5ETnIxWUpwYjk1cTNFZVBkd3hUYjAv?=
 =?utf-8?B?U2hvWTVnK3dGL2FBRWJLSkdzZ0FRZ0JPbkl0dTZWYnJxVHFGR1FvK0s3bWMv?=
 =?utf-8?B?eFUzR0Nwc05SakVHbWFyUEQ2SEhKcVBRcndhbk4xamhZbnpXbExEVEJqZUMw?=
 =?utf-8?B?MWMrVzVjTHJHbjdnWUpXWHBUcUtRR0pENzMxcFpiQlVteEZwSXE5Z21SZ09i?=
 =?utf-8?B?YVBqclJRYjlGQklFRFB3dzRlN2ptdEUxUURNbkxQZTJWdFNrRFFWaXVMbjE0?=
 =?utf-8?B?YW5sRXp5Wkd4TndCUzlhTmV0U1pnZ1l0dE1JNmFNLzVHRERpTllGdURhOHBO?=
 =?utf-8?B?cWtiSEY1eHJadzN6V21XQ2RJSDBpdWk5N1g5b0hRQy9hcTVMMzFQYUdjZWZk?=
 =?utf-8?B?ek1hQ3l5bkFEQjlLUERnWWRCSTJra3EybHlkZUwyNmEydjZ0WW1CYzc0R29s?=
 =?utf-8?B?QmtYTUdyL3NyTlZsVkc0djJ4UVhmck8xOG54S244eHR1Z0p6TXVmYVJxREN3?=
 =?utf-8?B?RUxuVUVNeEwrWmtGNFNKK01VRWZvd1VBQWsvUzlPMnl3MVJkUmxlZC9VVWov?=
 =?utf-8?B?Yitld0Q5WHVVUVhyWWd4bGxERGhaUWE2elFQcXhoaS9OMVp6VER3bEl1K2I5?=
 =?utf-8?B?MktudzlCL0kvdmxBRSszMmRnUXJkTnVGTEVWd29JcGcvN2JNQUdFdC8wWExR?=
 =?utf-8?B?V01tOW5UR0FYZ1FrZzBmdVRJYjR4VHJJUEl0MC9tVTIzc2VTZStueXRWVmI4?=
 =?utf-8?B?Q2lIbUJ4a3pPald1alRxUkorWnRkOFJnUnFrRzBsNjhjZ2U2cW1zVW9Ta0Vh?=
 =?utf-8?B?cTRITEhydSsxMjBNQjRsQVptK0w0M1Vvb0xtcTRPakpHSHo1YTRrRUk5ejNL?=
 =?utf-8?B?QU15K2l4aDBYblFoSGhPRG5oOXhsSFdIaVF1djVLRW5TYlFid1FLQjZiUmYv?=
 =?utf-8?B?UDhwb3VwWk5NVDhjSEIyQTBZQUFqZDIwNHdIeVVxU2kyUGlDbHEyMG12Yy84?=
 =?utf-8?B?SU5RTm1Cb2lPeGNPK3N5cUVOL0FaNytITEZxRk1BWFJoUlhwaWsrVFliVHRx?=
 =?utf-8?B?RXFuTFh2YWZLTDhYRUpxOHZXNFFrYk5NYm9sdkE3Z3RZMXZUdjRnTjhPMW5a?=
 =?utf-8?B?RVh1Y0hPR0d0UkIwalVFM2pkL1c1MU1uOGV4djBLa0wzamxMSWU4ajhueWdl?=
 =?utf-8?B?eWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b254e63-fdb8-43a6-bd92-08de15994607
X-MS-Exchange-CrossTenant-AuthSource: DM3PPF63A6024A9.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2025 20:41:58.5085
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F1nD7mDSKElXHAyh2U9j9ykohOJK6kxYEurBTnDr5J8L0MCEAxr3lpAGwC+JPZzU+yxYcYQxYhyfjd7LxR/y+oAfyLAQzhBSYwvHBTCVTZA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5082
X-OriginatorOrg: intel.com

On 10/27/2025 9:45 PM, Ricardo Neri wrote:
> On Mon, Oct 27, 2025 at 03:22:44PM +0100, Borislav Petkov wrote:
>> On Thu, Oct 16, 2025 at 07:57:25PM -0700, Ricardo Neri wrote:
>>> Reviewed-by: Dexuan Cui <decui@microsoft.com>
>>> Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
>>> Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>> Co-developed-by: Yunhong Jiang <yunhong.jiang@linux.intel.com>
>>> Signed-off-by: Yunhong Jiang <yunhong.jiang@linux.intel.com>
>>> Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
>> This is missing an ack from the devicetree maintainers:
>>
>> ./scripts/get_maintainer.pl -f Documentation/devicetree/
> Agreed. They are in the "To:" field of my submission. Rob has reviewed the
> patchset.

Well, is an ACK required in addition to R-by?  I thought that the latter 
would imply the former, wouldn't it?


