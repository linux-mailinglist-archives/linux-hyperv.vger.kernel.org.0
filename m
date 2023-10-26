Return-Path: <linux-hyperv+bounces-589-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 742467D7F7C
	for <lists+linux-hyperv@lfdr.de>; Thu, 26 Oct 2023 11:24:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D9B0281EF2
	for <lists+linux-hyperv@lfdr.de>; Thu, 26 Oct 2023 09:24:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BF6827721;
	Thu, 26 Oct 2023 09:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ENL16+0M"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BED6D262B1;
	Thu, 26 Oct 2023 09:24:07 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB5C0184;
	Thu, 26 Oct 2023 02:24:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698312244; x=1729848244;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=j/qoh28ffMbNcn18I0pIw6Jl/53038WpsntnbXDaoHc=;
  b=ENL16+0MzSv636CHy4pvtLBmRJmmGyrcUprvoa7joxqBxVQm2+Mb0Nik
   IT67BRFwYqcy3oiQGmznVTyIa7AOqShoEOTZp6f0ye/nFNR0uyy3HgW81
   0I4bZKxzwaETmz+Z6O9WU85BOh+geGcWPhkRwVzJ2LmSPlJ25oH0bdIp7
   8OsYL7OVtEPYoyIpbx1kXbBx2wxN7rBnuK3XTgbogMmJNDObItUcmDqZw
   I/c9OAix6HY/IY2Qf6jhK/pKCNj1DQH8Fs+vag4RocJbAkNb43F20fhj8
   AMqqKzk6oikz0Zu1wm60IcaBXuJpWPXYQr55NZnKcNmXPbq6gQcI9CvQb
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10874"; a="366846096"
X-IronPort-AV: E=Sophos;i="6.03,253,1694761200"; 
   d="scan'208";a="366846096"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2023 02:24:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10874"; a="902830668"
X-IronPort-AV: E=Sophos;i="6.03,253,1694761200"; 
   d="scan'208";a="902830668"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Oct 2023 02:21:36 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 26 Oct 2023 02:24:01 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Thu, 26 Oct 2023 02:24:01 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Thu, 26 Oct 2023 02:24:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iv+sytiLCcrPU2WC6ALZfPlEECSjibQGqJeZ/NnqiUw9qOALTAfR+pvkagz4+bCq6mdBdnUFl4dVfnXqhswnYdsu0pyf1P9I22Itk0TZEw4QTRKLe10DZzU1WoDwohf5Si9JTNQtlrpVHjrYZxikWq2dQwN+5wa/jrszm6fb8EH0uqH7y1bN/58AZLQeeliJEaZYkBkOvm3/H8zGIRV3qY269Zy/rmLb38nAFXUAcedX8xTAAoUdSbL1E0vJmuBvZVGlMO4goOubW/4+Q3olLeE57pyqvnUdlVlwoe3yYlrXXPF+3InwVIwciwj+0OGnl+Bv0CnStf09yOGKDJrMdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rFvpD4y17mge50BuT5Df6auypMeLDQRfQ/MqhgXb2pw=;
 b=KA9xbvDIQoqu+ICYUyURqX5Ec8k0pCmEYkOxC3YxkXxTGrDoBu0oB4jfVIiiOo+x7ylE3zqhLz6R2RrRvM6ytjQq5+Mqgfu7W31p+xdWO+tQp4v16Xo3qbwPqcXJ0zwo7oyJ3FAvgyUYGQ7D2pSqzYsH42Gp2OxlJnBKXUC4KEyPQvYcQ7Tw3gt6r5xA2TsFfHC65L9EMH2GKELnBmBqAQVyl/kdhJkzOR46kR9/Wd8knM5wni694d+1S5I3sagdJKKHvNPswINLjVmQb7Kn6j9B8hW7ZAva+I3Ai00p1mmEwf46FESWZXKGJpofEqi+J7Z7g+iRntkhHVyHLb1JSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3672.namprd11.prod.outlook.com (2603:10b6:a03:fa::30)
 by PH8PR11MB6880.namprd11.prod.outlook.com (2603:10b6:510:228::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Thu, 26 Oct
 2023 09:23:57 +0000
Received: from BYAPR11MB3672.namprd11.prod.outlook.com
 ([fe80::7666:c666:e6b6:6e48]) by BYAPR11MB3672.namprd11.prod.outlook.com
 ([fe80::7666:c666:e6b6:6e48%4]) with mapi id 15.20.6907.021; Thu, 26 Oct 2023
 09:23:57 +0000
Message-ID: <f4b69b9d-2294-e0bf-a12a-9622eb70bd99@intel.com>
Date: Thu, 26 Oct 2023 11:23:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH 2/3] treewide: Convert some ethtool_sprintf() to
 ethtool_puts()
Content-Language: en-US
To: Justin Stitt <justinstitt@google.com>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Shay Agroskin
	<shayagr@amazon.com>, Arthur Kiyanovski <akiyano@amazon.com>, David Arinzon
	<darinzon@amazon.com>, Noam Dagan <ndagan@amazon.com>, Saeed Bishara
	<saeedb@amazon.com>, Rasesh Mody <rmody@marvell.com>, Sudarsana Kalluru
	<skalluru@marvell.com>, <GR-Linux-NIC-Dev@marvell.com>, Dimitris Michailidis
	<dmichail@fungible.com>, Yisen Zhuang <yisen.zhuang@huawei.com>, Salil Mehta
	<salil.mehta@huawei.com>, Jesse Brandeburg <jesse.brandeburg@intel.com>,
	"Tony Nguyen" <anthony.l.nguyen@intel.com>, Louis Peens
	<louis.peens@corigine.com>, Shannon Nelson <shannon.nelson@amd.com>, Brett
 Creeley <brett.creeley@amd.com>, <drivers@pensando.io>, "K. Y. Srinivasan"
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
 <20231025-ethtool_puts_impl-v1-2-6a53a93d3b72@google.com>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
In-Reply-To: <20231025-ethtool_puts_impl-v1-2-6a53a93d3b72@google.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: OL1P279CA0029.NORP279.PROD.OUTLOOK.COM
 (2603:10a6:e10:13::16) To BYAPR11MB3672.namprd11.prod.outlook.com
 (2603:10b6:a03:fa::30)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3672:EE_|PH8PR11MB6880:EE_
X-MS-Office365-Filtering-Correlation-Id: 378a953e-dfe5-4702-ff9b-08dbd60547b1
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: d9059MTw4YpRtSJtqVDqNDIIBv6dVdyt7I2dd1maKchBM8bWp5xHpBXE93wruhKUk3/DKTE4uMPssrmR3qd2D5k+RTQVoNgLwXb8NC3FYbrkTeckyVJyHZrSTW+TwRzgQjljlBrlfXk+GwncvSlPoFq3jUWHAk7J6MicbhMnDDgaQNI8Ekm3BUQe9eBtLBwKi1dSXmGXP3NLijoKLL4OarDwOB4XywWRKh1L2sHXC6kwYSAFcX0aneH+5ssUES3AdFNMBpQDdtexb8jb9xG4SgDqrA3tPbRKnnI6s/JtXPZvn6Txyx41zCcSyt8kyZay8T7rb901xRt557j9d1ivDhEFB6Wvc2TY4Li4EmAK2StpwSwLHrcpIBL5u4KZ1DNH7td8H896X22+7T4JNayBAUPJ8m5cWlz1adWcZlelPQCn8HJrC05E00Cp7VPTRT3vnVgDI+B1DF55but5RbvVo0DSjbaRIytJpX6h1xki/hIQmPX+f4FDcMcmDF4rn2AZS2f2bWvv5Mo/0BwRf8I/c60xEDsBYS0luQ/N8AAXZlYyiG7HaUvPsr9AzSDtCHjt4afGFxBuM1WjfBzzRk5xj0K/kr26vTfv3C8EfISU1XUCAKWGcOcLxvxqa6HnID8XSXEzpTGjDwgIwkMPeaI5Z3NrPaGupp0YITQkZo7z45k=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3672.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(366004)(39860400002)(346002)(376002)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(31686004)(921008)(4326008)(2906002)(26005)(7416002)(5660300002)(7406005)(83380400001)(30864003)(8936002)(53546011)(38100700002)(6506007)(6512007)(8676002)(2616005)(6666004)(66946007)(316002)(86362001)(110136005)(31696002)(36756003)(54906003)(966005)(66556008)(41300700001)(478600001)(66476007)(6486002)(82960400001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RTFZRERhMHJsU3BRRzlhMWhpN2xnd2pVd3Q5T1J6b3ZvRUpDZnFUby9FcnFh?=
 =?utf-8?B?czFlYklBdjVyT0F6YU5BN3dOTEZUays4cW9xL0Zlb2VVbEp1YjN6T3ZVTHZ6?=
 =?utf-8?B?UDZUd2hzRFdSTXNIa296WitJVlFCL1d3NVhaVWVzNVh5aSs2azhoQ2htTk1R?=
 =?utf-8?B?T2wvYmljdGRpOVZzU1RhVVJPaTNWNmFLcWNjMTMxbmsxS1dlOSt5VkdjMUZ2?=
 =?utf-8?B?c01PMktaSlFORlQ1RGJXbC9FRHdDU1VqU3N4RjByOTBhWnArWEU2bTl1TDBJ?=
 =?utf-8?B?STBJM290WmlPQS9CRWZEa2xWdEhYbmUybk5WM0RISkcvL01RRTlGZTBia2t6?=
 =?utf-8?B?VFVSQ01FK1lEaThuR2lvVUZ3emlsNkg4bWp5dzNvUXNTYUVVWHFoa0pIV25V?=
 =?utf-8?B?MWRaZWcwY0phckRuaFFvMWdqdnhNa0JDd2VYUDhMbVpTZHJZTjZIMzVXZEZE?=
 =?utf-8?B?VEYvZnZhbVYxS3BFQmdwQkdrWVFSM1lMWlBZeXpjY1dRdEdhbHVIUmlGbjRq?=
 =?utf-8?B?MkJkWGtYTjJHTytIRW13cUR3R3pNeVI1U2pDeDJTUXF1UzVyTHhsanhKc0ZL?=
 =?utf-8?B?Yy9OY0JiSkVQUUdmclNSUGpOTkNBQW95dGZBYllpUUZwTk9MQTRZQXZLM2lR?=
 =?utf-8?B?c1NINEpsczVWTHd0ell6aHg5SlV6cDAwaEJyRHlZT1FjLzVsYXhETHJ4L3ha?=
 =?utf-8?B?UFozTHVTWklkeUIyRFFBNzRHWkI0N1dXN3RsaStueFlpbGpSZzBNTFZSdUVV?=
 =?utf-8?B?ZVZDTTUrb3ErekQ4SXZUays1Sm80WnpJQzlJdWFTanhIZnQ5RFh1YUtVTGlw?=
 =?utf-8?B?V0lOWHlnQ0lUWFF2OHRmdjg0OUxmL20rNWo0S05KVHBlQ3FReTludlBDb1JJ?=
 =?utf-8?B?dFBtNkZtMm5FQ081MC9RdUpPU0xOZ3ZNNS8vZHdUZnVhYk1hQ2dIdWpWa0NX?=
 =?utf-8?B?TllCQi9USFdkOXNNc2ptVUpnaEI1VE5lM055LzZCSlJsZ0MxcTVLMVVsU1Z1?=
 =?utf-8?B?ZnNGNWM4d1lQNmNEbHBIVkJhTzNoZko2cFA1TFkvTjJvalBBOVRMR2ZtazhH?=
 =?utf-8?B?V29QMkRCZFVrRDRmQXdxeWExa01QKzM1bkQ3ajNUUnIzMmRZd0s0a0Z6UnIv?=
 =?utf-8?B?WTZlRW56cFhOWEdTY1hSaUhYem5rZzFTYzVORU9BRmMrRjByQ2dnNmdwbUsr?=
 =?utf-8?B?ZVd5Vy9PVnI3SFhKTmNpTmw5YnhvZ1lYVGRsVGhrem5pd2kvZnFJdC91NE9N?=
 =?utf-8?B?QVZoT0ZUU2VvdkZqTVZWZkhZcUNsUUczOTIyNWR0RTNDeGc2dXk1QzM5dUo2?=
 =?utf-8?B?QTZUaHNHQ0x4dmJmcWhCdlE1aVRKYjFxNklZT0h3cDY4RlRYenlZQ2ROQXMz?=
 =?utf-8?B?LzlLMXVLRUp2NHpxM3lpcjNHNWV3bzFxem5oRGZJVWc0R21GVElNaWExTHcy?=
 =?utf-8?B?SlMrSWNuV1ZWRE1sMEM2dWtZL2xrTG9lbW5kUTJrTnBuOHpuQWtlRXI2cmJ4?=
 =?utf-8?B?ZnV5ZjRFYWl4RzJldC9NVjlyTmw5YlluNWNVL2NNei9tME94RmpYN2VoYit5?=
 =?utf-8?B?ZGVZbmF4WUJmQlhPYTdoQjJmYUdrUEFjNXV6cUVyM2dPM0FrUWV0VkhJNkRw?=
 =?utf-8?B?TW9JSUZkbkxrRTBBRjZIRDhxY1RyR2NjWTVIdnBxQndoMUVPUWNDLzV6a1Zj?=
 =?utf-8?B?VWNLaTVJNG9jcjlDYitRZjFCbldBTFpxUnZ5TVZNSmZrWU9jZnUralZTUFZD?=
 =?utf-8?B?cTV2MGJja2o4N1lVOENSbldlWW8yTUozd2IxSjBubkVvNUlWSzdGeFJ0UXhK?=
 =?utf-8?B?dkNwTEZwcldHOXd3MlhndExkVVMyRFZlV2lHa21NWEN0dFlOanFpWkJaVlQ5?=
 =?utf-8?B?N1ZhWkwxOGNPb0xOYTdxQkxnZzA1dlBOSHVWczRKWGowZ1loYk5HT3lCa1Zn?=
 =?utf-8?B?R0NhRyszUldiWmpLNjBwQ0FDNjNLYzZEcDIxKzZnZGFWekhqVm56akFadnBw?=
 =?utf-8?B?V0tlK0xHOWxRR2NJWS93YkZyc3lOT1U4SHBHRzJ1V0p0aTVMeUpEaU05OFp2?=
 =?utf-8?B?TGliczgrRHgzNWx3WlNXRGpZSVBjYnU0b1BVT05ISmVqcWdjK0hseHh5ZVVq?=
 =?utf-8?B?c1RTODdpdzl4ZXQ5cTdKb3BvQzgrSW9GR0tHamM3a1VpZFhTNGJ2Q1pXbDNr?=
 =?utf-8?B?VEE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 378a953e-dfe5-4702-ff9b-08dbd60547b1
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3672.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2023 09:23:57.0384
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +ce3Q2bppaeluFyxAHyCDPL7fga8sEihOywyyBEngblhQlHNK+yY0AcSCLrrtrDhSDrYtyJa706Fdd8BxGQ9x6fobzuon1BeBbEl8n/RnBA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6880
X-OriginatorOrg: intel.com

On 10/26/23 01:40, Justin Stitt wrote:
> This patch converts some basic cases of ethtool_sprintf() to
> ethtool_puts().
> 
> The conversions are used in cases where ethtool_sprintf() was being used
> with just two arguments:
> |       ethtool_sprintf(&data, buffer[i].name);
> or when it's used with format string: "%s"
> |       ethtool_sprintf(&data, "%s", buffer[i].name);
> which both now become:
> |       ethtool_puts(&data, buffer[i].name);
> 
> There are some outstanding patches [1] that I've sent using plain "%s"
> with ethtool_sprintf() that should be ethtool_puts() now. Some have been
> picked up as-is but I will send new versions for the others.
> 
> [1]: https://lore.kernel.org/all/?q=dfb%3Aethtool_sprintf+AND+f%3Ajustinstitt
> 
> Signed-off-by: Justin Stitt <justinstitt@google.com>
> ---
>   drivers/net/ethernet/amazon/ena/ena_ethtool.c      |  4 +-
>   drivers/net/ethernet/brocade/bna/bnad_ethtool.c    |  2 +-
>   .../net/ethernet/fungible/funeth/funeth_ethtool.c  |  8 +--
>   drivers/net/ethernet/hisilicon/hns/hns_dsaf_gmac.c |  2 +-
>   .../net/ethernet/hisilicon/hns/hns_dsaf_xgmac.c    |  2 +-
>   drivers/net/ethernet/hisilicon/hns/hns_ethtool.c   | 66 +++++++++++-----------
>   drivers/net/ethernet/intel/i40e/i40e_ethtool.c     |  4 +-
>   drivers/net/ethernet/intel/ice/ice_ethtool.c       | 10 ++--
>   drivers/net/ethernet/intel/igb/igb_ethtool.c       |  6 +-
>   drivers/net/ethernet/intel/igc/igc_ethtool.c       |  6 +-
>   drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c   |  5 +-
>   .../net/ethernet/netronome/nfp/nfp_net_ethtool.c   | 44 +++++++--------
>   drivers/net/ethernet/pensando/ionic/ionic_stats.c  |  4 +-
>   drivers/net/hyperv/netvsc_drv.c                    |  4 +-
>   drivers/net/vmxnet3/vmxnet3_ethtool.c              | 10 ++--
>   15 files changed, 87 insertions(+), 90 deletions(-)
> 
> diff --git a/drivers/net/ethernet/amazon/ena/ena_ethtool.c b/drivers/net/ethernet/amazon/ena/ena_ethtool.c
> index d671df4b76bc..e3ef081aa42b 100644
> --- a/drivers/net/ethernet/amazon/ena/ena_ethtool.c
> +++ b/drivers/net/ethernet/amazon/ena/ena_ethtool.c
> @@ -299,13 +299,13 @@ static void ena_get_strings(struct ena_adapter *adapter,
>   
>   	for (i = 0; i < ENA_STATS_ARRAY_GLOBAL; i++) {
>   		ena_stats = &ena_stats_global_strings[i];
> -		ethtool_sprintf(&data, ena_stats->name);
> +		ethtool_puts(&data, ena_stats->name);
>   	}
>   
>   	if (eni_stats_needed) {
>   		for (i = 0; i < ENA_STATS_ARRAY_ENI(adapter); i++) {
>   			ena_stats = &ena_stats_eni_strings[i];
> -			ethtool_sprintf(&data, ena_stats->name);
> +			ethtool_puts(&data, ena_stats->name);
>   		}
>   	}
>   
> diff --git a/drivers/net/ethernet/brocade/bna/bnad_ethtool.c b/drivers/net/ethernet/brocade/bna/bnad_ethtool.c
> index df10edff5603..d1ad6c9f8140 100644
> --- a/drivers/net/ethernet/brocade/bna/bnad_ethtool.c
> +++ b/drivers/net/ethernet/brocade/bna/bnad_ethtool.c
> @@ -608,7 +608,7 @@ bnad_get_strings(struct net_device *netdev, u32 stringset, u8 *string)
>   
>   	for (i = 0; i < BNAD_ETHTOOL_STATS_NUM; i++) {
>   		BUG_ON(!(strlen(bnad_net_stats_strings[i]) < ETH_GSTRING_LEN));
> -		ethtool_sprintf(&string, bnad_net_stats_strings[i]);
> +		ethtool_puts(&string, bnad_net_stats_strings[i]);
>   	}
>   
>   	bmap = bna_tx_rid_mask(&bnad->bna);
> diff --git a/drivers/net/ethernet/fungible/funeth/funeth_ethtool.c b/drivers/net/ethernet/fungible/funeth/funeth_ethtool.c
> index 31aa185f4d17..091c93bd7587 100644
> --- a/drivers/net/ethernet/fungible/funeth/funeth_ethtool.c
> +++ b/drivers/net/ethernet/fungible/funeth/funeth_ethtool.c
> @@ -655,7 +655,7 @@ static void fun_get_strings(struct net_device *netdev, u32 sset, u8 *data)
>   						i);
>   		}
>   		for (j = 0; j < ARRAY_SIZE(txq_stat_names); j++)
> -			ethtool_sprintf(&p, txq_stat_names[j]);
> +			ethtool_puts(&p, txq_stat_names[j]);
>   
>   		for (i = 0; i < fp->num_xdpqs; i++) {
>   			for (j = 0; j < ARRAY_SIZE(xdpq_stat_names); j++)
> @@ -663,7 +663,7 @@ static void fun_get_strings(struct net_device *netdev, u32 sset, u8 *data)
>   						xdpq_stat_names[j], i);
>   		}
>   		for (j = 0; j < ARRAY_SIZE(xdpq_stat_names); j++)
> -			ethtool_sprintf(&p, xdpq_stat_names[j]);
> +			ethtool_puts(&p, xdpq_stat_names[j]);
>   
>   		for (i = 0; i < netdev->real_num_rx_queues; i++) {
>   			for (j = 0; j < ARRAY_SIZE(rxq_stat_names); j++)
> @@ -671,10 +671,10 @@ static void fun_get_strings(struct net_device *netdev, u32 sset, u8 *data)
>   						i);
>   		}
>   		for (j = 0; j < ARRAY_SIZE(rxq_stat_names); j++)
> -			ethtool_sprintf(&p, rxq_stat_names[j]);
> +			ethtool_puts(&p, rxq_stat_names[j]);
>   
>   		for (j = 0; j < ARRAY_SIZE(tls_stat_names); j++)
> -			ethtool_sprintf(&p, tls_stat_names[j]);
> +			ethtool_puts(&p, tls_stat_names[j]);
>   		break;
>   	default:
>   		break;
> diff --git a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_gmac.c b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_gmac.c
> index 8f391e2adcc0..bdb7afaabdd0 100644
> --- a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_gmac.c
> +++ b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_gmac.c
> @@ -678,7 +678,7 @@ static void hns_gmac_get_strings(u32 stringset, u8 *data)
>   		return;
>   
>   	for (i = 0; i < ARRAY_SIZE(g_gmac_stats_string); i++)
> -		ethtool_sprintf(&buff, g_gmac_stats_string[i].desc);
> +		ethtool_puts(&buff, g_gmac_stats_string[i].desc);
>   }
>   
>   static int hns_gmac_get_sset_count(int stringset)
> diff --git a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_xgmac.c b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_xgmac.c
> index fc26ffaae620..c58833eb4830 100644
> --- a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_xgmac.c
> +++ b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_xgmac.c
> @@ -752,7 +752,7 @@ static void hns_xgmac_get_strings(u32 stringset, u8 *data)
>   		return;
>   
>   	for (i = 0; i < ARRAY_SIZE(g_xgmac_stats_string); i++)
> -		ethtool_sprintf(&buff, g_xgmac_stats_string[i].desc);
> +		ethtool_puts(&buff, g_xgmac_stats_string[i].desc);
>   }
>   
>   /**
> diff --git a/drivers/net/ethernet/hisilicon/hns/hns_ethtool.c b/drivers/net/ethernet/hisilicon/hns/hns_ethtool.c
> index b54f3706fb97..b40415910e57 100644
> --- a/drivers/net/ethernet/hisilicon/hns/hns_ethtool.c
> +++ b/drivers/net/ethernet/hisilicon/hns/hns_ethtool.c
> @@ -912,42 +912,42 @@ static void hns_get_strings(struct net_device *netdev, u32 stringset, u8 *data)
>   
>   	if (stringset == ETH_SS_TEST) {
>   		if (priv->ae_handle->phy_if != PHY_INTERFACE_MODE_XGMII)
> -			ethtool_sprintf(&buff,
> -					hns_nic_test_strs[MAC_INTERNALLOOP_MAC]);
> -		ethtool_sprintf(&buff,
> -				hns_nic_test_strs[MAC_INTERNALLOOP_SERDES]);
> +			ethtool_puts(&buff,
> +				     hns_nic_test_strs[MAC_INTERNALLOOP_MAC]);
> +		ethtool_puts(&buff,
> +			     hns_nic_test_strs[MAC_INTERNALLOOP_SERDES]);
>   		if ((netdev->phydev) && (!netdev->phydev->is_c45))
> -			ethtool_sprintf(&buff,
> -					hns_nic_test_strs[MAC_INTERNALLOOP_PHY]);
> +			ethtool_puts(&buff,
> +				     hns_nic_test_strs[MAC_INTERNALLOOP_PHY]);
>   
>   	} else {
> -		ethtool_sprintf(&buff, "rx_packets");
> -		ethtool_sprintf(&buff, "tx_packets");
> -		ethtool_sprintf(&buff, "rx_bytes");
> -		ethtool_sprintf(&buff, "tx_bytes");
> -		ethtool_sprintf(&buff, "rx_errors");
> -		ethtool_sprintf(&buff, "tx_errors");
> -		ethtool_sprintf(&buff, "rx_dropped");
> -		ethtool_sprintf(&buff, "tx_dropped");
> -		ethtool_sprintf(&buff, "multicast");
> -		ethtool_sprintf(&buff, "collisions");
> -		ethtool_sprintf(&buff, "rx_over_errors");
> -		ethtool_sprintf(&buff, "rx_crc_errors");
> -		ethtool_sprintf(&buff, "rx_frame_errors");
> -		ethtool_sprintf(&buff, "rx_fifo_errors");
> -		ethtool_sprintf(&buff, "rx_missed_errors");
> -		ethtool_sprintf(&buff, "tx_aborted_errors");
> -		ethtool_sprintf(&buff, "tx_carrier_errors");
> -		ethtool_sprintf(&buff, "tx_fifo_errors");
> -		ethtool_sprintf(&buff, "tx_heartbeat_errors");
> -		ethtool_sprintf(&buff, "rx_length_errors");
> -		ethtool_sprintf(&buff, "tx_window_errors");
> -		ethtool_sprintf(&buff, "rx_compressed");
> -		ethtool_sprintf(&buff, "tx_compressed");
> -		ethtool_sprintf(&buff, "netdev_rx_dropped");
> -		ethtool_sprintf(&buff, "netdev_tx_dropped");
> -
> -		ethtool_sprintf(&buff, "netdev_tx_timeout");
> +		ethtool_puts(&buff, "rx_packets");
> +		ethtool_puts(&buff, "tx_packets");
> +		ethtool_puts(&buff, "rx_bytes");
> +		ethtool_puts(&buff, "tx_bytes");
> +		ethtool_puts(&buff, "rx_errors");
> +		ethtool_puts(&buff, "tx_errors");
> +		ethtool_puts(&buff, "rx_dropped");
> +		ethtool_puts(&buff, "tx_dropped");
> +		ethtool_puts(&buff, "multicast");
> +		ethtool_puts(&buff, "collisions");
> +		ethtool_puts(&buff, "rx_over_errors");
> +		ethtool_puts(&buff, "rx_crc_errors");
> +		ethtool_puts(&buff, "rx_frame_errors");
> +		ethtool_puts(&buff, "rx_fifo_errors");
> +		ethtool_puts(&buff, "rx_missed_errors");
> +		ethtool_puts(&buff, "tx_aborted_errors");
> +		ethtool_puts(&buff, "tx_carrier_errors");
> +		ethtool_puts(&buff, "tx_fifo_errors");
> +		ethtool_puts(&buff, "tx_heartbeat_errors");
> +		ethtool_puts(&buff, "rx_length_errors");
> +		ethtool_puts(&buff, "tx_window_errors");
> +		ethtool_puts(&buff, "rx_compressed");
> +		ethtool_puts(&buff, "tx_compressed");
> +		ethtool_puts(&buff, "netdev_rx_dropped");
> +		ethtool_puts(&buff, "netdev_tx_dropped");
> +
> +		ethtool_puts(&buff, "netdev_tx_timeout");
>   
>   		h->dev->ops->get_strings(h, stringset, buff);
>   	}
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
> index bd1321bf7e26..2641b2a4fcb0 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
> @@ -2512,11 +2512,11 @@ static void i40e_get_priv_flag_strings(struct net_device *netdev, u8 *data)
>   	u8 *p = data;
>   
>   	for (i = 0; i < I40E_PRIV_FLAGS_STR_LEN; i++)
> -		ethtool_sprintf(&p, i40e_gstrings_priv_flags[i].flag_string);
> +		ethtool_puts(&p, i40e_gstrings_priv_flags[i].flag_string);
>   	if (pf->hw.pf_id != 0)
>   		return;
>   	for (i = 0; i < I40E_GL_PRIV_FLAGS_STR_LEN; i++)
> -		ethtool_sprintf(&p, i40e_gl_gstrings_priv_flags[i].flag_string);
> +		ethtool_puts(&p, i40e_gl_gstrings_priv_flags[i].flag_string);
>   }
>   
>   static void i40e_get_strings(struct net_device *netdev, u32 stringset,
> diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c b/drivers/net/ethernet/intel/ice/ice_ethtool.c
> index ad4d4702129f..7871bba4b099 100644
> --- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
> +++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
> @@ -1060,8 +1060,8 @@ __ice_get_strings(struct net_device *netdev, u32 stringset, u8 *data,
>   	switch (stringset) {
>   	case ETH_SS_STATS:
>   		for (i = 0; i < ICE_VSI_STATS_LEN; i++)
> -			ethtool_sprintf(&p,
> -					ice_gstrings_vsi_stats[i].stat_string);
> +			ethtool_puts(&p,
> +				     ice_gstrings_vsi_stats[i].stat_string);

this would now fit into one line
(perhaps it's the same in other cases, I just checked this one manually)

>   
>   		if (ice_is_port_repr_netdev(netdev))
>   			return;
> @@ -1080,8 +1080,8 @@ __ice_get_strings(struct net_device *netdev, u32 stringset, u8 *data,
>   			return;
>   
>   		for (i = 0; i < ICE_PF_STATS_LEN; i++)
> -			ethtool_sprintf(&p,
> -					ice_gstrings_pf_stats[i].stat_string);
> +			ethtool_puts(&p,
> +				     ice_gstrings_pf_stats[i].stat_string);
>   
>   		for (i = 0; i < ICE_MAX_USER_PRIORITY; i++) {
>   			ethtool_sprintf(&p, "tx_priority_%u_xon.nic", i);
> @@ -1097,7 +1097,7 @@ __ice_get_strings(struct net_device *netdev, u32 stringset, u8 *data,
>   		break;
>   	case ETH_SS_PRIV_FLAGS:
>   		for (i = 0; i < ICE_PRIV_FLAG_ARRAY_SIZE; i++)
> -			ethtool_sprintf(&p, ice_gstrings_priv_flags[i].name);
> +			ethtool_puts(&p, ice_gstrings_priv_flags[i].name);
>   		break;
>   	default:
>   		break;
> diff --git a/drivers/net/ethernet/intel/igb/igb_ethtool.c b/drivers/net/ethernet/intel/igb/igb_ethtool.c
> index 319ed601eaa1..e0a24c7c37f9 100644
> --- a/drivers/net/ethernet/intel/igb/igb_ethtool.c
> +++ b/drivers/net/ethernet/intel/igb/igb_ethtool.c
> @@ -2356,11 +2356,9 @@ static void igb_get_strings(struct net_device *netdev, u32 stringset, u8 *data)
>   		break;
>   	case ETH_SS_STATS:
>   		for (i = 0; i < IGB_GLOBAL_STATS_LEN; i++)
> -			ethtool_sprintf(&p,
> -					igb_gstrings_stats[i].stat_string);
> +			ethtool_puts(&p, igb_gstrings_stats[i].stat_string);
>   		for (i = 0; i < IGB_NETDEV_STATS_LEN; i++)
> -			ethtool_sprintf(&p,
> -					igb_gstrings_net_stats[i].stat_string);
> +			ethtool_puts(&p, igb_gstrings_net_stats[i].stat_string);
>   		for (i = 0; i < adapter->num_tx_queues; i++) {
>   			ethtool_sprintf(&p, "tx_queue_%u_packets", i);
>   			ethtool_sprintf(&p, "tx_queue_%u_bytes", i);
> diff --git a/drivers/net/ethernet/intel/igc/igc_ethtool.c b/drivers/net/ethernet/intel/igc/igc_ethtool.c
> index 7ab6dd58e400..2aac55ebdf5a 100644
> --- a/drivers/net/ethernet/intel/igc/igc_ethtool.c
> +++ b/drivers/net/ethernet/intel/igc/igc_ethtool.c
> @@ -773,10 +773,10 @@ static void igc_ethtool_get_strings(struct net_device *netdev, u32 stringset,
>   		break;
>   	case ETH_SS_STATS:
>   		for (i = 0; i < IGC_GLOBAL_STATS_LEN; i++)
> -			ethtool_sprintf(&p, igc_gstrings_stats[i].stat_string);
> +			ethtool_puts(&p, igc_gstrings_stats[i].stat_string);
>   		for (i = 0; i < IGC_NETDEV_STATS_LEN; i++)
> -			ethtool_sprintf(&p,
> -					igc_gstrings_net_stats[i].stat_string);
> +			ethtool_puts(&p,
> +				     igc_gstrings_net_stats[i].stat_string);
>   		for (i = 0; i < adapter->num_tx_queues; i++) {
>   			ethtool_sprintf(&p, "tx_queue_%u_packets", i);
>   			ethtool_sprintf(&p, "tx_queue_%u_bytes", i);
> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
> index 0bbad4a5cc2f..dd722b0381e0 100644
> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
> @@ -1413,12 +1413,11 @@ static void ixgbe_get_strings(struct net_device *netdev, u32 stringset,
>   	switch (stringset) {
>   	case ETH_SS_TEST:
>   		for (i = 0; i < IXGBE_TEST_LEN; i++)
> -			ethtool_sprintf(&p, ixgbe_gstrings_test[i]);
> +			ethtool_puts(&p, ixgbe_gstrings_test[i]);
>   		break;
>   	case ETH_SS_STATS:
>   		for (i = 0; i < IXGBE_GLOBAL_STATS_LEN; i++)
> -			ethtool_sprintf(&p,
> -					ixgbe_gstrings_stats[i].stat_string);
> +			ethtool_puts(&p, ixgbe_gstrings_stats[i].stat_string);
>   		for (i = 0; i < netdev->num_tx_queues; i++) {
>   			ethtool_sprintf(&p, "tx_queue_%u_packets", i);
>   			ethtool_sprintf(&p, "tx_queue_%u_bytes", i);
> diff --git a/drivers/net/ethernet/netronome/nfp/nfp_net_ethtool.c b/drivers/net/ethernet/netronome/nfp/nfp_net_ethtool.c
> index e75cbb287625..1636ce61a3c0 100644
> --- a/drivers/net/ethernet/netronome/nfp/nfp_net_ethtool.c
> +++ b/drivers/net/ethernet/netronome/nfp/nfp_net_ethtool.c
> @@ -800,7 +800,7 @@ static void nfp_get_self_test_strings(struct net_device *netdev, u8 *data)
>   
>   	for (i = 0; i < NFP_TEST_TOTAL_NUM; i++)
>   		if (nfp_self_test[i].is_supported(netdev))
> -			ethtool_sprintf(&data, nfp_self_test[i].name);
> +			ethtool_puts(&data, nfp_self_test[i].name);
>   }
>   
>   static int nfp_get_self_test_count(struct net_device *netdev)
> @@ -852,24 +852,24 @@ static u8 *nfp_vnic_get_sw_stats_strings(struct net_device *netdev, u8 *data)
>   		ethtool_sprintf(&data, "rvec_%u_tx_busy", i);
>   	}
>   
> -	ethtool_sprintf(&data, "hw_rx_csum_ok");
> -	ethtool_sprintf(&data, "hw_rx_csum_inner_ok");
> -	ethtool_sprintf(&data, "hw_rx_csum_complete");
> -	ethtool_sprintf(&data, "hw_rx_csum_err");
> -	ethtool_sprintf(&data, "rx_replace_buf_alloc_fail");
> -	ethtool_sprintf(&data, "rx_tls_decrypted_packets");
> -	ethtool_sprintf(&data, "hw_tx_csum");
> -	ethtool_sprintf(&data, "hw_tx_inner_csum");
> -	ethtool_sprintf(&data, "tx_gather");
> -	ethtool_sprintf(&data, "tx_lso");
> -	ethtool_sprintf(&data, "tx_tls_encrypted_packets");
> -	ethtool_sprintf(&data, "tx_tls_ooo");
> -	ethtool_sprintf(&data, "tx_tls_drop_no_sync_data");
> -
> -	ethtool_sprintf(&data, "hw_tls_no_space");
> -	ethtool_sprintf(&data, "rx_tls_resync_req_ok");
> -	ethtool_sprintf(&data, "rx_tls_resync_req_ign");
> -	ethtool_sprintf(&data, "rx_tls_resync_sent");
> +	ethtool_puts(&data, "hw_rx_csum_ok");
> +	ethtool_puts(&data, "hw_rx_csum_inner_ok");
> +	ethtool_puts(&data, "hw_rx_csum_complete");
> +	ethtool_puts(&data, "hw_rx_csum_err");
> +	ethtool_puts(&data, "rx_replace_buf_alloc_fail");
> +	ethtool_puts(&data, "rx_tls_decrypted_packets");
> +	ethtool_puts(&data, "hw_tx_csum");
> +	ethtool_puts(&data, "hw_tx_inner_csum");
> +	ethtool_puts(&data, "tx_gather");
> +	ethtool_puts(&data, "tx_lso");
> +	ethtool_puts(&data, "tx_tls_encrypted_packets");
> +	ethtool_puts(&data, "tx_tls_ooo");
> +	ethtool_puts(&data, "tx_tls_drop_no_sync_data");
> +
> +	ethtool_puts(&data, "hw_tls_no_space");
> +	ethtool_puts(&data, "rx_tls_resync_req_ok");
> +	ethtool_puts(&data, "rx_tls_resync_req_ign");
> +	ethtool_puts(&data, "rx_tls_resync_sent");
>   
>   	return data;
>   }
> @@ -943,13 +943,13 @@ nfp_vnic_get_hw_stats_strings(u8 *data, unsigned int num_vecs, bool repr)
>   	swap_off = repr * NN_ET_SWITCH_STATS_LEN;
>   
>   	for (i = 0; i < NN_ET_SWITCH_STATS_LEN; i++)
> -		ethtool_sprintf(&data, nfp_net_et_stats[i + swap_off].name);
> +		ethtool_puts(&data, nfp_net_et_stats[i + swap_off].name);
>   
>   	for (i = NN_ET_SWITCH_STATS_LEN; i < NN_ET_SWITCH_STATS_LEN * 2; i++)
> -		ethtool_sprintf(&data, nfp_net_et_stats[i - swap_off].name);
> +		ethtool_puts(&data, nfp_net_et_stats[i - swap_off].name);
>   
>   	for (i = NN_ET_SWITCH_STATS_LEN * 2; i < NN_ET_GLOBAL_STATS_LEN; i++)
> -		ethtool_sprintf(&data, nfp_net_et_stats[i].name);
> +		ethtool_puts(&data, nfp_net_et_stats[i].name);
>   
>   	for (i = 0; i < num_vecs; i++) {
>   		ethtool_sprintf(&data, "rxq_%u_pkts", i);
> diff --git a/drivers/net/ethernet/pensando/ionic/ionic_stats.c b/drivers/net/ethernet/pensando/ionic/ionic_stats.c
> index 9859a4432985..1f6022fb7679 100644
> --- a/drivers/net/ethernet/pensando/ionic/ionic_stats.c
> +++ b/drivers/net/ethernet/pensando/ionic/ionic_stats.c
> @@ -258,10 +258,10 @@ static void ionic_sw_stats_get_strings(struct ionic_lif *lif, u8 **buf)
>   	int i, q_num;
>   
>   	for (i = 0; i < IONIC_NUM_LIF_STATS; i++)
> -		ethtool_sprintf(buf, ionic_lif_stats_desc[i].name);
> +		ethtool_puts(buf, ionic_lif_stats_desc[i].name);
>   
>   	for (i = 0; i < IONIC_NUM_PORT_STATS; i++)
> -		ethtool_sprintf(buf, ionic_port_stats_desc[i].name);
> +		ethtool_puts(buf, ionic_port_stats_desc[i].name);
>   
>   	for (q_num = 0; q_num < MAX_Q(lif); q_num++)
>   		ionic_sw_stats_get_tx_strings(lif, buf, q_num);
> diff --git a/drivers/net/hyperv/netvsc_drv.c b/drivers/net/hyperv/netvsc_drv.c
> index 3ba3c8fb28a5..cbd9405fc2f3 100644
> --- a/drivers/net/hyperv/netvsc_drv.c
> +++ b/drivers/net/hyperv/netvsc_drv.c
> @@ -1582,10 +1582,10 @@ static void netvsc_get_strings(struct net_device *dev, u32 stringset, u8 *data)
>   	switch (stringset) {
>   	case ETH_SS_STATS:
>   		for (i = 0; i < ARRAY_SIZE(netvsc_stats); i++)
> -			ethtool_sprintf(&p, netvsc_stats[i].name);
> +			ethtool_puts(&p, netvsc_stats[i].name);
>   
>   		for (i = 0; i < ARRAY_SIZE(vf_stats); i++)
> -			ethtool_sprintf(&p, vf_stats[i].name);
> +			ethtool_puts(&p, vf_stats[i].name);
>   
>   		for (i = 0; i < nvdev->num_chn; i++) {
>   			ethtool_sprintf(&p, "tx_queue_%u_packets", i);
> diff --git a/drivers/net/vmxnet3/vmxnet3_ethtool.c b/drivers/net/vmxnet3/vmxnet3_ethtool.c
> index 98c22d7d87a2..8f5f202cde39 100644
> --- a/drivers/net/vmxnet3/vmxnet3_ethtool.c
> +++ b/drivers/net/vmxnet3/vmxnet3_ethtool.c
> @@ -245,20 +245,20 @@ vmxnet3_get_strings(struct net_device *netdev, u32 stringset, u8 *buf)
>   
>   	for (j = 0; j < adapter->num_tx_queues; j++) {
>   		for (i = 0; i < ARRAY_SIZE(vmxnet3_tq_dev_stats); i++)
> -			ethtool_sprintf(&buf, vmxnet3_tq_dev_stats[i].desc);
> +			ethtool_puts(&buf, vmxnet3_tq_dev_stats[i].desc);
>   		for (i = 0; i < ARRAY_SIZE(vmxnet3_tq_driver_stats); i++)
> -			ethtool_sprintf(&buf, vmxnet3_tq_driver_stats[i].desc);
> +			ethtool_puts(&buf, vmxnet3_tq_driver_stats[i].desc);
>   	}
>   
>   	for (j = 0; j < adapter->num_rx_queues; j++) {
>   		for (i = 0; i < ARRAY_SIZE(vmxnet3_rq_dev_stats); i++)
> -			ethtool_sprintf(&buf, vmxnet3_rq_dev_stats[i].desc);
> +			ethtool_puts(&buf, vmxnet3_rq_dev_stats[i].desc);
>   		for (i = 0; i < ARRAY_SIZE(vmxnet3_rq_driver_stats); i++)
> -			ethtool_sprintf(&buf, vmxnet3_rq_driver_stats[i].desc);
> +			ethtool_puts(&buf, vmxnet3_rq_driver_stats[i].desc);
>   	}
>   
>   	for (i = 0; i < ARRAY_SIZE(vmxnet3_global_stats); i++)
> -		ethtool_sprintf(&buf, vmxnet3_global_stats[i].desc);
> +		ethtool_puts(&buf, vmxnet3_global_stats[i].desc);
>   }
>   
>   netdev_features_t vmxnet3_fix_features(struct net_device *netdev,
> 


