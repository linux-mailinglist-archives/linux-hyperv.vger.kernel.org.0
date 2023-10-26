Return-Path: <linux-hyperv+bounces-590-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8650E7D7F8F
	for <lists+linux-hyperv@lfdr.de>; Thu, 26 Oct 2023 11:30:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76D021C20B6C
	for <lists+linux-hyperv@lfdr.de>; Thu, 26 Oct 2023 09:30:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C15F27EC3;
	Thu, 26 Oct 2023 09:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c/9kHKnb"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 695BB26E20;
	Thu, 26 Oct 2023 09:30:39 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89F94196;
	Thu, 26 Oct 2023 02:30:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698312636; x=1729848636;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=fKbR2cN6bXisiynmdOl6jeiqpm67HZm/3nLkvvdSHUQ=;
  b=c/9kHKnbC92orEvFEkDukb86VJv2oDwi5oGfhoR/LYW9cED9O3PQ/Tam
   GtVyNLkFA4zsmH1haSF5FBS+sMInWPAl8iLIISh82ZvvfTqnt9lDW1RYR
   /3GpPooiFLaq1QCGeP9MFRPJgMErrURPKVrXbGDaXfZl0NFwWuP7kq8HZ
   s/3yUs8MBgWJ51WJYkGEuDqSVNR0jcnkO6e43/k56BNr8kKwkLnD7t5YI
   o80tSqMNwGJ94g7ZCgjcVBSEu7GrBwNTDm+xAxbKybjDY78pYCsITvJB5
   zqrS3b8ET5u2aohFmm4IhgLibsLFoigDwA8NXZAzqxs5ADwuj1yW4UBwY
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10874"; a="451735497"
X-IronPort-AV: E=Sophos;i="6.03,253,1694761200"; 
   d="scan'208";a="451735497"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2023 02:30:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,253,1694761200"; 
   d="scan'208";a="386701"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Oct 2023 02:29:39 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 26 Oct 2023 02:30:13 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 26 Oct 2023 02:30:13 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Thu, 26 Oct 2023 02:30:13 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Thu, 26 Oct 2023 02:30:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A1lgpSHiCYrpVY0DB/VVn70XwgyKZrr+vVPff1r8ER4PMYDbvitpuoR1HrzF+d9TDLAgcePgaz60sm2MfP9FD1v03+uKn19vCcRcd5U7wNNEVRQlNKDkr06pHZd2i8ZiPj9F5VB8f3r9tyjYkK8UQYQmGipH2WKcaBnXUfpptOiT7AfJ5MiWKeKv+64UnByReo7AYaZGglVhV6IsHPP2/DEU0YrqumFYa+Te2o2WhBDLzIhk3kr8FWevhEEFMbNFBe4oIRn2ZjLm61nmp4Kilpnt/WNZnC3agc7yHgVtNGowJHjxJOaTT0ep/CjK7VvlRfoz5Zg9+Edlh7srtRXUVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9M7DLaf4IRK9hmZcQKlJwMOJX99d2lMPduawTag+NcM=;
 b=l0ChAzMInCoaqYRHy30/n11wEyP2ibOBDAajRZWgQhhl21grqA88mhTq0wJJkYjNYP50kDTQAXmzsZQTbfmeyjZ7KUxB1NlU8UPPpXo4EM12n4Kg3MBq4WBxx0bRNUgAuHVrtn8bMUC2BQc/+pmDk429Lh4rkzRMHNveoN3lshm5qpa8TKajorD5Cpu3e2zAJ3dK4xH+7zJ3IewzRsXl3Jit2w8W3ypBFTnwTRgbU8Y2+37G56uIehMBIk+jXvtlvmZUPVtElAH8Lgv0FOS8e5o04RQrsh80leLoV8UqYC0EG1Y5yvweY3DlK8PEg/D2Ep0IRS8/jhclYA1THJ20gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3672.namprd11.prod.outlook.com (2603:10b6:a03:fa::30)
 by PH8PR11MB6880.namprd11.prod.outlook.com (2603:10b6:510:228::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Thu, 26 Oct
 2023 09:30:05 +0000
Received: from BYAPR11MB3672.namprd11.prod.outlook.com
 ([fe80::7666:c666:e6b6:6e48]) by BYAPR11MB3672.namprd11.prod.outlook.com
 ([fe80::7666:c666:e6b6:6e48%4]) with mapi id 15.20.6907.021; Thu, 26 Oct 2023
 09:30:05 +0000
Message-ID: <cb83107f-f022-86c6-b463-a1eee4936967@intel.com>
Date: Thu, 26 Oct 2023 11:29:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH 3/3] checkpatch: add ethtool_sprintf rules
Content-Language: en-US
To: Justin Stitt <justinstitt@google.com>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Shay Agroskin
	<shayagr@amazon.com>, Arthur Kiyanovski <akiyano@amazon.com>, David Arinzon
	<darinzon@amazon.com>, Noam Dagan <ndagan@amazon.com>, Saeed Bishara
	<saeedb@amazon.com>, Rasesh Mody <rmody@marvell.com>, Sudarsana Kalluru
	<skalluru@marvell.com>, <GR-Linux-NIC-Dev@marvell.com>, Dimitris Michailidis
	<dmichail@fungible.com>, Yisen Zhuang <yisen.zhuang@huawei.com>, Salil Mehta
	<salil.mehta@huawei.com>, Jesse Brandeburg <jesse.brandeburg@intel.com>, Tony
 Nguyen <anthony.l.nguyen@intel.com>, Louis Peens <louis.peens@corigine.com>,
	Shannon Nelson <shannon.nelson@amd.com>, "Brett Creeley"
	<brett.creeley@amd.com>, <drivers@pensando.io>, "K. Y. Srinivasan"
	<kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu
	<wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, Ronak Doshi
	<doshir@vmware.com>, VMware PV-Drivers Reviewers <pv-drivers@vmware.com>,
	Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>, "Dwaipayan
 Ray" <dwaipayanray1@gmail.com>, Lukas Bulwahn <lukas.bulwahn@gmail.com>
CC: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>, Nick Desaulniers
	<ndesaulniers@google.com>, Nathan Chancellor <nathan@kernel.org>, Kees Cook
	<keescook@chromium.org>, <intel-wired-lan@lists.osuosl.org>,
	<oss-drivers@corigine.com>, <linux-hyperv@vger.kernel.org>
References: <20231025-ethtool_puts_impl-v1-0-6a53a93d3b72@google.com>
 <20231025-ethtool_puts_impl-v1-3-6a53a93d3b72@google.com>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
In-Reply-To: <20231025-ethtool_puts_impl-v1-3-6a53a93d3b72@google.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0102.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a1::17) To BYAPR11MB3672.namprd11.prod.outlook.com
 (2603:10b6:a03:fa::30)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3672:EE_|PH8PR11MB6880:EE_
X-MS-Office365-Filtering-Correlation-Id: 80fad5c7-95f7-422a-0096-08dbd60622fc
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FSffYEfD2r+RGox3XxhFGt7Po/zqxSSK17RUh1/qhX17QBsmvhcOFT6e/XddSjIfnFfFd/YXErosfWrcSUoGGwW+72Zn0RCdx5sBp/K/fQ26njw8jc5HMOefFWzlWWEWCE2pUqbUpCEQPs7t0OO2g+rQrZgVLkFdqvASUiHJ1fzvb2VpCDdhAqLuKpOyzfEKNKkamEDwzAEiiEn0yXxhidk0UhkA5sdaedXSB0s9IeAPzuY8+q5JSlhB9PCJROLm1kPnuQzwpfk7PLnOBUipoG/IKQ5CyUzbnEnYOiXaGaqdowX1IGN29K//2l3GSemTDs1hZgiS/PqHd6KRQZu9gvyI6TBsLkgBuDsHNAN2UvUblJRuPS/Z3k4WVjY08gXhHSR6sspw4WaU8RNgj7GimVJ4BAXcbQaG/JJPCccexhnDLcoenHSyz+/PKbYpf9xNCqO0fqVUfcAV3YqgnVPBi0FIuJKksNr3kpxR37mSc6/NWZ4XvvGyYDJYbaoQ5e35Yreq4F0b1Qa4xOC5hykBwB4zZggvYEphHwZytbZ6kXG0GOeEcczsn8vtLk1G/rA1Kv3Qu8fv0G3aVFCLZ2Zr5ON+YEDgSgjDNrsgWRlkyYTlbaUMHj8ppMmBIAGi9xsFSZk4U1tVunE7AI4GRB8oDQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3672.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(366004)(39860400002)(346002)(376002)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(31686004)(921008)(4326008)(2906002)(26005)(7416002)(5660300002)(7406005)(83380400001)(8936002)(53546011)(38100700002)(6506007)(6512007)(8676002)(2616005)(6666004)(66946007)(316002)(86362001)(110136005)(31696002)(36756003)(54906003)(966005)(66556008)(41300700001)(478600001)(66476007)(6486002)(82960400001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K1FIVk5iY2JNVWExRE0wT1JSUVlZeThFQ0xvMXFGNlFDRHgyajJqM1gyUElJ?=
 =?utf-8?B?eDI4a0tsNVhCcUlpTEpxZmNoMmFqWElCU1pwZ1RtTFY4bnVrYmc2cmw3MGRo?=
 =?utf-8?B?VnoyajdZWWttYlM4YmNyR2ZmdVc5OHpCZkhRL2U4UkJJRWloNk1ZSXJPVSt2?=
 =?utf-8?B?VTVqS3JGQTVUKzVZYkxJaVlLUi85dlFqc3N0ZmFIK1JsdVVORTJKUnJJVXZQ?=
 =?utf-8?B?N0h5T3EzbmNpVGRxTGhCcTJ4eEpmZ1I1M1daRm9KUjFvNGtGTGI2WGluVE5X?=
 =?utf-8?B?YS8zSGFvNXVJVGtBeG5wYTd1bTZ4djhkY08rbmdkRnJLYm01MXRyK1pzTm1O?=
 =?utf-8?B?WFh6MmZwOVJmS0IwZXdCSWZwOExXNzFOS3BrWHpaWCsyODl3QVdwM0pOZlA5?=
 =?utf-8?B?M3hFMVRuWEJxVTI4V3Q3Y3Y3ZFVjNGRuM0NHS0d1c05LU3AwYnRuUnRqWUVh?=
 =?utf-8?B?NDdBR05ZZlFRNHdkZ2dwTTczamh3Wkw4dG1QdnJId3JoTEZTZzdVK0lzeDhZ?=
 =?utf-8?B?R2hNY0lVMXdnV0UrUHdGWXNINE02OTdFZmF5SEt2aDJCRm1HQUhhRHptZDNs?=
 =?utf-8?B?NjVuQ1VTbEdIT1RwMkN2RGNvOVpvNVlHeFF4dmcrRzVjYXJHQVZpSnIvSnds?=
 =?utf-8?B?QytVMlJreHgvZzl6M2xYTUR6STBCMHl6UGNtN2tQaUJSOURmTVEvMDFSdTlu?=
 =?utf-8?B?WjgvMGUrcVJlOTNvY3VIT0FDTWxGbWVjR3JvMlltSVZ6TjFkb1R4dlVJSThu?=
 =?utf-8?B?L0t1OWVHcFNrV2YyMW8vZEFyOWppRjdRQ3Y4MXdxK0VrMlpJL1JQNm1IOGJH?=
 =?utf-8?B?eEZoek1VdjMyc1ozbUp4T1dnUFFLazU3VitUNzBjdDlLM3ViTVczMmZGSmVa?=
 =?utf-8?B?OXBpRGVLQ2ZGc0w5ckVOMFZnVzRQTVJXdUZUZlpvb09qSmE4U0VjMzQzTVZP?=
 =?utf-8?B?bTd0NlFQdThwY2F4bzZDQ2FrV0p6NGw3NGRaRThxRTJnYjJsVG9TMDUzS0Fr?=
 =?utf-8?B?emM2SzhvdEx6MXVFVVRabGhjSEI0bEpsemFDWm15YTNLbnZOc2JrSm16dUR2?=
 =?utf-8?B?cFNUTXZ3b2lYVWJINEVxM3Y1N29nZlVDeGhNV0JGVWcxOWhSTWFKMVNNMXNn?=
 =?utf-8?B?d1h3VjgvbEFVRkJIM2VseWtpZGpDaWpndE5yOEQvSUI1VlJqTVB4N29SYVJI?=
 =?utf-8?B?V0RMQ2xLc0hWVjV4RWRNNnhYTDY5NUtZdUFTaWpTbU1rRVhUaStLck9MNlc3?=
 =?utf-8?B?VG9YMkllUTFvNms2cysvbE5uVjYzc2RpRG1uek83SFV1aWhMRTFEVkdYalJH?=
 =?utf-8?B?UDdDeFRoNVhWZjd2Nng3VWxFMjhlbmxVOGNoRnJOWll5S1k1dUt4V2NpMlVp?=
 =?utf-8?B?aHA4d3dVbTErRis5eXJvY0JSMS9zRWc0RTh2bTJFQk5zQ25ITmtjVUFOOHpr?=
 =?utf-8?B?VEt4bjY2Z2x3VXFYaUh6UFk2UkthODhQNkFHc3oyVy85QlQwcXFiWWdWZ1NY?=
 =?utf-8?B?U0N6M2FRT0FiQnhaSjVpN2VSOXZzdElmOU5MNW1QRUNpNlhDcHd6U3U5MUIv?=
 =?utf-8?B?cjQ3cnN5MS9ZdTcrMHdIWC9yc1dzeThNbE55amxUaXFMaERRdG5EN0pxQU5k?=
 =?utf-8?B?emtiNzhob29HS1NRWk5ZVExET2pQWVJjZyszL2Q4TDdjYU9YTUhRclR3RmI5?=
 =?utf-8?B?SnFLaGpYWXhjREMwN3pwekZSQnZlM25uTU42MTBjU2ZJb0RKY3crWndTNmdr?=
 =?utf-8?B?elYvNUk3SzJFbTNZVHZ3bVhsWjhpNUdPTnVlNGdIN0RrZE9SUndyVjNKQVhH?=
 =?utf-8?B?OU5UL01RSTVweld5WGpFK1E5cHIzRVdnTXQvTzhjdk1xb1ExcTFZSEpIVEk2?=
 =?utf-8?B?Wmpyb0FvMkRSUjBqRURSVW9uZkFWc09pZVU1cWtmZEd2Zjc1QVNkUzY2Uy9S?=
 =?utf-8?B?VzNuSDIrVUVNRHJZRlNVQ1g0a0RtalhXYUo2eHNSb2VVc1ozZlQzVzVrMDZ1?=
 =?utf-8?B?VFNzWDB2T2JHNjBuWVIyTXRpVTB4MmovYWhFN1BZTjZ1VlM2VkpXUmZyZE5P?=
 =?utf-8?B?ZlZ3Q0NUa0t0Vlc3VnQzT0hTQkt4VFVpUFMyTEFWa0ZkTVd3eGUvRHovQmhV?=
 =?utf-8?B?eUFpZUVTc1lnNElSbTVqdzIrTXU5T0FkQkN6SEpBWlVXY2tHTXdOc1ZydzV6?=
 =?utf-8?B?UEE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 80fad5c7-95f7-422a-0096-08dbd60622fc
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3672.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2023 09:30:05.4387
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SuqanZeHvsNTs5ZYExbL+fjApm/rpyaw43UO8EnzIKTJc9B3h47sQerX/P1O1doBqJPgacq0rFGVTHQQdLkdf9u8qjRovGbLiHJ5bBtGKVc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6880
X-OriginatorOrg: intel.com

On 10/26/23 01:40, Justin Stitt wrote:
> Add some warnings for using ethtool_sprintf() where a simple
> ethtool_puts() would suffice.
> 
> The two cases are:
> 
> 1) Use ethtool_sprintf() with just two arguments:
> |       ethtool_sprintf(&data, driver[i].name);
> or
> 2) Use ethtool_sprintf() with a standalone "%s" fmt string:
> |       ethtool_sprintf(&data, "%s", driver[i].name);
> 
> The former may cause -Wformat-security warnings while the latter is just
> not preferred. Both are safely in the category of warnings, not errors.
> 
> Signed-off-by: Justin Stitt <justinstitt@google.com>
> ---
>   scripts/checkpatch.pl | 13 +++++++++++++
>   1 file changed, 13 insertions(+)
> 
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index 7d16f863edf1..1ba9ce778746 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -7020,6 +7020,19 @@ sub process {
>   			     "Prefer strscpy, strscpy_pad, or __nonstring over strncpy - see: https://github.com/KSPP/linux/issues/90\n" . $herecurr);
>   		}
>   
> +# ethtool_sprintf uses that should likely be ethtool_puts
> +		if (   $line =~ /\bethtool_sprintf\s*\(\s*$FuncArg\s*,\s*$FuncArg\s*\)/   ) {

no need for whitespace right after opening parenthesis, same at the end

Does it work for ethtool_sprintf(calls broken
				 into multiple lines)?

BTW, I really like this series!

> +			WARN("ETHTOOL_SPRINTF",
> +			     "Prefer ethtool_puts over ethtool_sprintf with only two arguments" . $herecurr);
> +		}
> +
> +		# use $rawline because $line loses %s via sanitization and thus we can't match against it.
> +		if (   $rawline =~ /\bethtool_sprintf\s*\(\s*$FuncArg\s*,\s*\"\%s\"\s*,\s*$FuncArg\s*\)/   ) {
> +			WARN("ETHTOOL_SPRINTF2",
> +			     "Prefer ethtool_puts over ethtool_sprintf with standalone \"%s\" specifier" . $herecurr);
> +		}
> +
> +
>   # typecasts on min/max could be min_t/max_t
>   		if ($perl_version_ok &&
>   		    defined $stat &&
> 


