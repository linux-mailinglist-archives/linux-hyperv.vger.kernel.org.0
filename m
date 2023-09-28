Return-Path: <linux-hyperv+bounces-295-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2E407B1071
	for <lists+linux-hyperv@lfdr.de>; Thu, 28 Sep 2023 03:41:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 3FCA028197F
	for <lists+linux-hyperv@lfdr.de>; Thu, 28 Sep 2023 01:41:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FFBA15C9;
	Thu, 28 Sep 2023 01:41:43 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B19C17D4
	for <linux-hyperv@vger.kernel.org>; Thu, 28 Sep 2023 01:41:41 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 362C7AC;
	Wed, 27 Sep 2023 18:41:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695865300; x=1727401300;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=6XKYA2kZM3ICmlkNgDK9WrWAu8BPi9oiI0Wd5tG5qdw=;
  b=bLq2d7LnACjcN+2Z+tia2pbdr/f8kzZK2/DmtVoUqVOcnyq/7HOKE+Mr
   4QLiMBHAhqvlXUa7jC0LAFJq2qRYgSbN9C2M1SBwKJKSIN4cz1YRK2Dh8
   ZX9xj5paOm2D2ZsQQjCS2xMkvCy5GfX3s2iX0x1/fgh9A06t2ivWwDCJc
   8Ps7B4ooJYIwMOP/cDQDMPU9tSYawZLeyArcxAvU1sy7T8szKRng1gWqZ
   qM1yP+8XPIn1ShrkKYwyPX84rZG8v41rVG166p20ol2QugwOmdltk9STg
   uif7H293VVaVvgCh8LrAS+NBFEuch25h/V8aQGOeUoAPUdJVO+KlXDFZL
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10846"; a="381871847"
X-IronPort-AV: E=Sophos;i="6.03,182,1694761200"; 
   d="scan'208";a="381871847"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2023 18:41:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10846"; a="749447199"
X-IronPort-AV: E=Sophos;i="6.03,182,1694761200"; 
   d="scan'208";a="749447199"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Sep 2023 18:41:39 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 27 Sep 2023 18:41:38 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Wed, 27 Sep 2023 18:41:38 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Wed, 27 Sep 2023 18:41:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O856KgBGqBsbd3b6Gunx7GZTHYGJtHYggkYSXvCoi6v6QYtVn70Jv+0900scNFuGGt+hR19LT3/6vsmyHP5sC48RE+r0Wl/dxQlrpqh/Bw25HaHCx+HHLHZWhz/5Wj9TSHRzyu7VEfo/ftsQ10da9BMyt76OfvTm30hG7+OVjNAJrkLTJx7qR9yHpMxOTNJoJLBfS7nkGep398SImkvG2kMeqRm1994z7LS74p0CC9rzVHB1Jmf1qLJ4OmMJl0MaQbt5kLs/VPcz15mZTOEdJoY7zOieUL3H5dVr4BVYiP5q9RfQhGzjP4qMrw8Bkdp/pYsjq0mnsbs3OudXNko0dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qB5bVAfcl4mh4cm0kehXdh/rbCBaZbblc0LkLetqt+4=;
 b=CUkzvfkpYcb+zMX48ntqpSpAyD7Ad/8vmYWJsGt0K00LCv9ICwlCaKXlK3QVU1hj2tlDhZpks6fIc12+7qVMqaXtU/NfrngAGNE5kk1+0ag5vMCazlvORDnTAc6szSbuVDk8jwjlkXDH53VCHkYGlGwBE1yCzerMEAaw04obJaO6Fcuz3IFhkjnV6PQgSqNDVq1uPjGTcfm8AoDsjrQnQSw4IJqGepnfmoAGAhxJzcy7uzRpP6EV0ZfBn2R7zPRsva4E5xm0aT6KwYbahUtxs+HCt4hJtijxOpnUTM3NQ9DkTUJOcPCenRZkCMOwZkpiAb8pL53LwoWZwahTDjH/2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6392.namprd11.prod.outlook.com (2603:10b6:930:37::15)
 by DS7PR11MB7737.namprd11.prod.outlook.com (2603:10b6:8:e1::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Thu, 28 Sep
 2023 01:41:34 +0000
Received: from CY5PR11MB6392.namprd11.prod.outlook.com
 ([fe80::d35:d16b:4ee3:77e5]) by CY5PR11MB6392.namprd11.prod.outlook.com
 ([fe80::d35:d16b:4ee3:77e5%7]) with mapi id 15.20.6792.026; Thu, 28 Sep 2023
 01:41:34 +0000
Date: Thu, 28 Sep 2023 09:36:34 +0800
From: kernel test robot <yujie.liu@intel.com>
To: Saurabh Sengar <ssengar@linux.microsoft.com>, <kys@microsoft.com>,
	<haiyangz@microsoft.com>, <wei.liu@kernel.org>, <decui@microsoft.com>,
	<tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
	<linux-hyperv@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<mikelley@microsoft.com>
CC: <oe-kbuild-all@lists.linux.dev>, <minipli@grsecurity.net>,
	<ssengar@microsoft.com>
Subject: Re: [PATCH] x86/hyperv: Remove hv_vtl_early_init initcall
Message-ID: <202309201327.J4pfXnUv-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1695185552-19910-1-git-send-email-ssengar@linux.microsoft.com>
X-ClientProxiedBy: SG2P153CA0017.APCP153.PROD.OUTLOOK.COM (2603:1096::27) To
 CY5PR11MB6392.namprd11.prod.outlook.com (2603:10b6:930:37::15)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6392:EE_|DS7PR11MB7737:EE_
X-MS-Office365-Filtering-Correlation-Id: 8deca23b-f0b6-417d-80eb-08dbbfc40c08
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Z2G7j01ubdlaVL5qwEx3VJ2jkbVtbVIWGQvRhbjHHFx+Zi37vDmKIVGR2o1zlXs98pA1amNbvOZ2062hbx/ayp9c585bjU4RBX9NozSM8wc38LmuYfK9H7eW+ZBsjkFB4OJaWkOE8Ow+ab4p6FIuzpn/8dUFj6kP/5gYy3c8CuOdqkQvUD49ivY9mm2bJFiNJKkvy/pEEL0BWTFbnJxOXSTNfLsdWB8jdKy8OJObKzB8ORR8aJeSY5WWC2cZHLDZwD2i+/tzoupWIGuqDJo56/EKZ97gElqoSXbJPcFiVILtbB4/wknT40cgkLyE2AKaodJZJThTboWeXc2mIHpKrM+zdJ/4j582gKpFUHLS+X4ZH45ie5R1Do7+T1t06K8AUifd3lFE5JwSpv6GIiYfsFon6xvSX9cVCCBaUTRSm1bkRdBffJ8rzGc+x+5+OtqLmGWCgYuDB100oClfeg6l3SRGoXw02iew6XcSzwudVjGs9cmbHMNBfa52UDlhTXuplLmFJ/cUeDGjwJuSXABj0cPqNM6rudkubVDFT/q+ytCAw+bRqjaOqOf8p2hwOEgOABiZpaJL9BU7JRKl6Or44dANk8y0hoxYw4knGS/7aDeLyXTc3wrNC8WOs4ktt4Iw
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(376002)(39860400002)(396003)(346002)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(4326008)(921005)(5660300002)(83380400001)(8936002)(41300700001)(7416002)(8676002)(36756003)(316002)(66946007)(1076003)(66476007)(2616005)(66556008)(966005)(86362001)(6506007)(6512007)(26005)(82960400001)(6486002)(2906002)(38100700002)(478600001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?okbQNURk5L7yMjn0hWyGI02uoGEdWedFHFGPXbVBr5B/9CiihYAUpDXRQZ1e?=
 =?us-ascii?Q?A6uO3e8EtW9QjAKItp34dVAT1EHTSWqAGZIXal7j26ocrc+Kx3JFi7xV/W4D?=
 =?us-ascii?Q?PiDY9WJ5DkhaykQsF2WW8JubvlFRv3tDscXAnd4Np/Asnfs3GqzMsjJtQBBV?=
 =?us-ascii?Q?WUm5G0hLrN7xlLTaYo9U5IDWHMkWOkEapLgT28IFdgvmJNRRW3Ibmss9p9Yr?=
 =?us-ascii?Q?CpAXmD+0LY4I6kA6ujtBmaH8ajCvVYaoJP4wcYh9z3g+ICHIqPUwq3y6DOPS?=
 =?us-ascii?Q?ETQUD9FKxT0g2hHdSUMXBlLmuuplysA6uCOF0UrPpcWAStosnrIQAJ4jCZQQ?=
 =?us-ascii?Q?0JpVCmoC3RXZHrV1OWHffSzfFK2NB9qRhskJA3g8RjBC2l65X1kNmASGoZxR?=
 =?us-ascii?Q?1L3Wf+1UJfy/VJgG+/oZjw3eNOh2Pf0XyNimvfdwH5M6UqhUrNGmC3fND4VI?=
 =?us-ascii?Q?nkeppVkQVNn/Z+JW2aed0a+dIhVLZJ2z5LF80RTjWwcmXsAanTLk+YlD6UDt?=
 =?us-ascii?Q?++GViTT90MeRkkRJADTnKtkO5FwG0a7JKZhQpY7Qlh2LS6zJ7fkd3sspzIYb?=
 =?us-ascii?Q?ogzDDQCF463o+T12W7jW4owyV+pXILmgvLsFtg0nUpgzShrZA3jyI0ZY1Y7p?=
 =?us-ascii?Q?p9feEM+ZIodo1tTYgipvHObEM/gx51pznTObYUsPEEpImuQ8hWG8LAAWkFqm?=
 =?us-ascii?Q?S10ufg7GfXjy7E7dTmLSanNdv887i9rTz8LoyukTtZQuZzc9Bn5qiyygIANp?=
 =?us-ascii?Q?0WRx9mqFG0SmDKqtXa5pFbVWHdYFKC7o4I9Phua2gP0Rp0K6Y75ZwseRa2jI?=
 =?us-ascii?Q?M0eOtheE3RaWGttHK2Q6h9imh+ZDFsA50bMsEu+zRlHbCFiFVfsIzQnZ/GCv?=
 =?us-ascii?Q?wn758o/D2luJAJARkMaGspqI9oVTrBWeHGYbFna9FAIzWSDUoONVi+CyVAgX?=
 =?us-ascii?Q?xfc76DvmqudVLaOYTT+/a8EnQhj+42+hw7kGn4p+nuACGtgwwwy5uJ9A9jBQ?=
 =?us-ascii?Q?sXYCQ4toxisfhqL00w1s4nj9L07KepWl32BMKM991tAohF11YDWVkLxrfeol?=
 =?us-ascii?Q?47jAWpr+0X1HZDE5EoP6k86Cpuai9UlybI+qWcfF3Ne2YWiKj5tJ0JQD8jka?=
 =?us-ascii?Q?+v0ox2LopAdOfk38LbVjulYU6FTUof5c38FajOyYK1M8OUNAA10xuVGpHGvj?=
 =?us-ascii?Q?E/KnOyuv35GHMqP+aLvlr6tV+g0au1wk5I6VQjMEp+6pcN5HTnPuCk8wTcI6?=
 =?us-ascii?Q?ottlgolypxq0YMo1OtBwfmQdoQOXMAnm8X9lquzF9xdCfxGh1CbnTrCWUpZw?=
 =?us-ascii?Q?qktPMg2TaTNsbe+OdALGR91JFY0FKIDJ7mpw68ixtsvzI1FLu3PYEnCrQZQF?=
 =?us-ascii?Q?SyCm36zUn6Z7lTCkTbvExMPJJcZn4hu4UrrWh0VAEcualVvHYnscE5S6Kjm8?=
 =?us-ascii?Q?TKMoY37ODOMQTuhmxJoeo+GtXodcZY6H26gMhmIirR6tSRWc+BSzkRPYkg8f?=
 =?us-ascii?Q?EnzZRDPf1qTWRhqiLQzzkn1My0Eb3l9jmxSKvQaNOhpgduqkN3q3KNwA94op?=
 =?us-ascii?Q?hdmhloJaZlQ1O65JGz8lBF1vSvhS4EDtHjg8CzAP?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8deca23b-f0b6-417d-80eb-08dbbfc40c08
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2023 01:41:34.1463
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fSZJBRgnjHOLlx6XolHmdAUr4WfsZ9/mIQP7qps/DnV69JXQPv7jEhh8UjfxaMOP+RoBnBhSgJ0SvesTRuJj4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB7737
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Saurabh,

kernel test robot noticed the following build warnings:

[auto build test WARNING on v6.6-rc2]
[also build test WARNING on linus/master next-20230920]
[cannot apply to tip/x86/core]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Saurabh-Sengar/x86-hyperv-Remove-hv_vtl_early_init-initcall/20230920-125357
base:   v6.6-rc2
patch link:    https://lore.kernel.org/r/1695185552-19910-1-git-send-email-ssengar%40linux.microsoft.com
patch subject: [PATCH] x86/hyperv: Remove hv_vtl_early_init initcall
config: i386-tinyconfig (https://download.01.org/0day-ci/archive/20230920/202309201327.J4pfXnUv-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230920/202309201327.J4pfXnUv-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <yujie.liu@intel.com>
| Closes: https://lore.kernel.org/r/202309201327.J4pfXnUv-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from arch/x86/mm/pat/set_memory.c:36:
   arch/x86/include/asm/mshyperv.h: In function 'hv_vtl_early_init':
   arch/x86/include/asm/mshyperv.h:346:1: error: no return statement in function returning non-void [-Werror=return-type]
     346 | static int __init hv_vtl_early_init(void) {}
         | ^~~~~~
   arch/x86/include/asm/mshyperv.h: At top level:
>> arch/x86/include/asm/mshyperv.h:346:19: warning: 'hv_vtl_early_init' defined but not used [-Wunused-function]
     346 | static int __init hv_vtl_early_init(void) {}
         |                   ^~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +/hv_vtl_early_init +346 arch/x86/include/asm/mshyperv.h

79cadff2d92bb8 Vitaly Kuznetsov 2017-08-02  339  
765e33f5211ab6 Michael Kelley   2019-05-30  340  
3be1bc2fe9d2e4 Saurabh Sengar   2023-04-10  341  #ifdef CONFIG_HYPERV_VTL_MODE
3be1bc2fe9d2e4 Saurabh Sengar   2023-04-10  342  void __init hv_vtl_init_platform(void);
9081cfc5d0e7fa Saurabh Sengar   2023-09-19  343  int __init hv_vtl_early_init(void);
3be1bc2fe9d2e4 Saurabh Sengar   2023-04-10  344  #else
3be1bc2fe9d2e4 Saurabh Sengar   2023-04-10  345  static inline void __init hv_vtl_init_platform(void) {}
9081cfc5d0e7fa Saurabh Sengar   2023-09-19 @346  static int __init hv_vtl_early_init(void) {}
3be1bc2fe9d2e4 Saurabh Sengar   2023-04-10  347  #endif
3be1bc2fe9d2e4 Saurabh Sengar   2023-04-10  348  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


