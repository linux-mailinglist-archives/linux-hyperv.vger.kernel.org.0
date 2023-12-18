Return-Path: <linux-hyperv+bounces-1354-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9DB5817C89
	for <lists+linux-hyperv@lfdr.de>; Mon, 18 Dec 2023 22:18:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D347D1C22BB6
	for <lists+linux-hyperv@lfdr.de>; Mon, 18 Dec 2023 21:18:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8071B740BB;
	Mon, 18 Dec 2023 21:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nnmBcXqc"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3603740BA;
	Mon, 18 Dec 2023 21:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702934324; x=1734470324;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=QQS1ZsHk92Unf/mSDKqPIzteqpX0YSiL/MJ8Wo+mrjk=;
  b=nnmBcXqc7oF8Aq5FqbxAO2n/1ZIMfUW/H8OQVZ1wil5TU4/ksqSfEOdN
   Ta7fme0/YbnEcoXe/R+giKtJXskQH4MhtLFrcFxpGl3WZwF4TyKDeUvs7
   e6ObpkkyWWtb37QNxlEnLaMiWP3HIPQ3erz6xaIbFdpJP7ku0SChnEnnN
   cgT4Na32a9KmQkhG1iBxAC+BYZjUjrt03Sib3BF5LBI4C+KODd8hw55Vv
   CGGLKaYOnzPl509BOf+0p7LHN3XcuEqA34wJv+E7Ft6mKdTTXD6/Fcmw0
   n9+nz5p8xj0X3WYoKiNUIxRvmIWL/GDVVaxRQ1AOKyO1+Q9CFQ1ro3dCq
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10928"; a="14255222"
X-IronPort-AV: E=Sophos;i="6.04,286,1695711600"; 
   d="scan'208";a="14255222"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2023 13:18:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10928"; a="809969827"
X-IronPort-AV: E=Sophos;i="6.04,286,1695711600"; 
   d="scan'208";a="809969827"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 18 Dec 2023 13:18:42 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 18 Dec 2023 13:18:41 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 18 Dec 2023 13:18:41 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 18 Dec 2023 13:18:41 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 18 Dec 2023 13:18:41 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xp3KjnyLOwsQzkA3wDh57WKNEubmp1k1eEm6n/xx3oeF/gYRGYU9PHMxquNqSsED7P+e6JJVRibPmAYGak3GNi1jvLsixwd7TLQysCF1EiJB/yWHbsDwNt7TGk8diiZdAqDFi9deHJbOf2m1VIKREyghSOVcIOFtEFWr2B2SPS9Fc1rR8Bvd+3ixEwthwqYAAeh2tUHvvEgZv5WU/La1lTha3kHyvho86/re7HEpiUciGLh9IrI4ZWsrmA5J04pCs3EctdyTapuyaXTiope4EglZSE5/3PWBH/aiVTdiRpSgoIXAssxWjsdf9bxnB1y/JZSTy3dXFOLD3zRZzPm2MQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h58GlCpX9NdAxgIjCslSLlGL5XZaH9bh3xeUQN8tXCo=;
 b=LimQ417GQsPT6seDZB8jcG6ecAGCdI6B7AE6PrYJuvoFysyE1QRqigUoagDZsY80dZtXExNltcC0DsxeShyfhjTuOtjjO6JH+rzsbUPuz4hEPIHW7+u7wdzyNmIDHKlrHEoFhOkX00JgMCPwSdrsC3NhuelntmAVITgOTlUkLUE7dawto8Bez8+OlhkS28ngGanVYnXjmMzGsbqI8V+STDrU+iF6nSw9JaVVXRdrVpTKhKE+nWfY83Wy7yAWqjFzNF0819eTmBnkX2TPWFSSmizl/InPz5XkRKfjLvieb1TcSBJUGj5MIoVUPCVMJu43acsjnx3hXbXLdKpSTOr7xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by IA1PR11MB7941.namprd11.prod.outlook.com (2603:10b6:208:3ff::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.37; Mon, 18 Dec
 2023 21:18:39 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::dbee:4787:6eeb:57f5]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::dbee:4787:6eeb:57f5%4]) with mapi id 15.20.7091.034; Mon, 18 Dec 2023
 21:18:39 +0000
Message-ID: <49d1afe4-7a62-4e2e-9327-376df932fd92@intel.com>
Date: Mon, 18 Dec 2023 13:18:38 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] net: mana: add irq_spread()
Content-Language: en-US
To: Yury Norov <yury.norov@gmail.com>, Souradeep Chakrabarti
	<schakrabarti@linux.microsoft.com>, <kys@microsoft.com>,
	<haiyangz@microsoft.com>, <wei.liu@kernel.org>, <decui@microsoft.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <longli@microsoft.com>, <leon@kernel.org>,
	<cai.huoqing@linux.dev>, <ssengar@linux.microsoft.com>,
	<vkuznets@redhat.com>, <tglx@linutronix.de>, <linux-hyperv@vger.kernel.org>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>
CC: <schakrabarti@microsoft.com>, <paulros@microsoft.com>
References: <20231217213214.1905481-1-yury.norov@gmail.com>
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20231217213214.1905481-1-yury.norov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MWH0EPF00056D11.namprd21.prod.outlook.com
 (2603:10b6:30f:fff2:0:1:0:14) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|IA1PR11MB7941:EE_
X-MS-Office365-Filtering-Correlation-Id: 056feeb3-ea12-427b-5ee1-08dc000ee758
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: G8ngF1mKwyBn725KDw0rWtPTd32HGechh1GHm9d7CF/QZOemBLec+MZEOnV6xLaYnop7ibdcPKteGgBCi239UJU0t1XTJchGDIz7GRdCxJVg3G0VgJZoT6NSH+3/zf+A7oTAcTlPs3Rp5WBZEIWHV54MY4GPkBhO1ZKl+7DhWD77ASZ8pv3NIOr8qwNwZVqmsD0+ObZdBGhvMx1vLNPpsYkeuM37qcMyxmb5MSALxn1kSodQ9c/6JRKlTpQbM/ROnrqUVNaz7NtAg4uuVfM5oqYVBrpwiVjaAJDSNbcVoIebOZWUaqKjnWXCf5FPCL+ulnOCR414eCG/HG4kvCsdus3a0LT0v1SwWQVI33sLEiUx2Fus3yLw3Uwof054HA5CetrLS7c5ir7nX1sPr/jn3V4V/jWoed6m5wpxRLO2l1IIeIUEL5/AZe40eVjH9FEUn9VyMW24NHfNpdaQBuEnWpmwwg7onjAvDKysBh8fgdkfxu5nCa4M0itTFtiuWEg0qjaqJEPNaamDf/XmR9FfXDlNlatW0dtXb2fUE76l76TkXc8T6F1xWgtidNete8y50ZmfuD6FFd555eYbFv2GAySV6Tr3l49MTz/WTdBlQuUvMJBFoYhSoF8kqMm2Bl5+HdH4zohJqh3KySzlCZjIDrtrZTaR7QVYzb2kOp3Ad8w=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(376002)(346002)(136003)(39860400002)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(31686004)(26005)(45080400002)(2616005)(53546011)(6506007)(6512007)(38100700002)(921008)(82960400001)(31696002)(36756003)(86362001)(8676002)(41300700001)(8936002)(4326008)(110136005)(5660300002)(7416002)(4744005)(2906002)(478600001)(6486002)(316002)(66946007)(66556008)(66476007)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MGJkdUVDd05FNXBGUVRVVU5BTEUxSENmeGpwczZpMU5RRDhidEdqbndkOC9C?=
 =?utf-8?B?TTJzZEdEOWVxbnduVlk4MTlsSjJXSmg1RCs0MWRPa2ZhZUwyMFFCU3RUNHlp?=
 =?utf-8?B?aTY4WElIUnhyVzhwNWRDRkJsVzBsK3ZuM2Y1T0RCSFNHSTgwR1NXbU9SbFoz?=
 =?utf-8?B?bUxsQzNjNTFVcWJaMFVab0pXaWxsQWxpcENKbXZFQkpDd3NuUTR5azBwbVdu?=
 =?utf-8?B?alhGZ2NjN0JzRndpWEZUV3BZVEpabkFoSVJDZytrMExHM0krUjdYWTJTYytn?=
 =?utf-8?B?Z1c2aWRzQ2FOMGxkWk1LNU5IelEvUVFxcFZWbCs0U3JuSjNqQzEveUtZKzZQ?=
 =?utf-8?B?NVR1bUV1MlBOOTBXcW9tV09XczlRZXB3Unhwb3dZT2l1MkJuSjM3dktMWEhj?=
 =?utf-8?B?Q3gxZ21uNXZqTWxmai9mSDZxYjZsemFVOHhkRkJGQlZ6ZWRWa0hFSDl1dk1J?=
 =?utf-8?B?RmQwUHdoNDZwMXUzb2I2bnhWZzNwZmlEVk9VVlFvNVNuZEVKaXkvVDBvVkNw?=
 =?utf-8?B?elJOaXJ4YzcxTjZkK3l5ZHJqMXBZMnoycUkrT3MwYXpRdVFWWFVjNDBWa2Np?=
 =?utf-8?B?ays4MTBYTkdaTk5lM0dTa0JmL0l4NnZCS1RzRk9MdVhXQkpIK2djdTVndmF4?=
 =?utf-8?B?aUhDNnp6WDVBSWd1bjVFbXlMSkpOazRwZlpXRnJzOXFJTWpHQjBHZVFEaWdJ?=
 =?utf-8?B?NFAyMEhkUVQ5YVpPeE05VEZEWmJUd2VxODFQTmtNdXJ0VzR4alhVYnNnWUk1?=
 =?utf-8?B?eUo1TE0ralYwS2hDK2RNQUIyZDVIejRLM0orZFRDb3pnWTlGSVYyeThncWZI?=
 =?utf-8?B?WjdySUlsa0dvdm5hNXh5ZDhyaGFVWmFSa0N6THJtRUhVRnFWNFcxK1ZXRllr?=
 =?utf-8?B?TUhkVzI4ZG1seU5NdXNJbVFEWEQ3MzNtb1V0R2huY1NxSFYyck1XOFVvaXp4?=
 =?utf-8?B?cndoV0RmS3h6c3BJYXIxWXNyTWJJeEJZak50Y0hIWTZ2ek1OUk82bkdSWWpR?=
 =?utf-8?B?Nzg4MWRqSkhxc1kzMXZOSjMrWE1zeDlxK1JoSGZQWGhSUkVmeXJmVWNXTzR5?=
 =?utf-8?B?RjFYVnJqVXB2VEpmZTNNMGZXOVM2eGIvd1RZMWtFbFZ3MFV1VTlDS2Qwd1BR?=
 =?utf-8?B?dXJMR3E5SUduQUVueXhQUkFFZldOeWJZbUYwQ3g0SXRqbkJDV2xLK29Yd2lC?=
 =?utf-8?B?SFFXSzZIWFhWWU1qRTdpVHBkS3JyT2FDci9WVDhBMlBxWlhPeUpLV3BwUDFS?=
 =?utf-8?B?NmZrQndIaEVlek4xbU41T1lLY00zbmJtekR1VzlDRGFsbGJxbllEaWxQaXZm?=
 =?utf-8?B?ZWxHU1pzUjM4dm5MZ3hDYVdpNTVnc2VyMTlKSVd2SEFQTjFXOS9tRzJiQktl?=
 =?utf-8?B?TmtRdVYzaVZ5U0l1ZENsWE83WmdBRk1ZcTVrNTRUbE43bmdKYzA0eE01M1B6?=
 =?utf-8?B?REdEcG8xelBxNjU4ak10ZTJYMWd0Ny9qSGJ0R2JWYmx4SG80NU9zRFAxWlMz?=
 =?utf-8?B?eHZwb3BzUFh2NmQxUzlDaG0vTkdNVU1Gelk0R1FCOEhjK3didlhrSnliU204?=
 =?utf-8?B?enQvWVJHRFJKSStPeG9wbkpBT3l0NEZkZFNzclBwMTVXMUxsRk5URFRWZ0tk?=
 =?utf-8?B?emNsZnBUeXZmT3BwK2pYMzRleWlBbEg2RVl0RWllSG5Vdk4vUzBSQUJVRTND?=
 =?utf-8?B?VTZKbHA5eWsrNVVwOFhmMFltc3dmUVBLNURQd01CQ0ZwQmhFdWJHd1hUZDBs?=
 =?utf-8?B?UWFocXY4TXZjYkxOL2hRUFY3VEsxdVFuS2hOdG8vdG9ZcmhJR1N2VTgzWE5o?=
 =?utf-8?B?clhpMmp2QklLVy9Uc0pYMEtQc2c2NzdqQnA1OHBzaUM5OWxzMWdzRCtCelRY?=
 =?utf-8?B?MDlWeXIxTU5EUmxBeUlxcjducWJGSmhGQm50M0NjQTFES3lwZUhCQldZYk45?=
 =?utf-8?B?OW1EYkEzVks0bjZMenJVc01IVzNUZjA3Q3NUYm4zaHF1ejNFTG50MGtqZjJq?=
 =?utf-8?B?WmdZUm9Jb1NIYlovZHRORTk0cU9ybWF3TGRyK2dVcmRlSHZWMVNCemJkZDBG?=
 =?utf-8?B?TnlOMDhUem5qMlhZOW1qUWZ2TnZlZmhmMVcrMTJ4aFQxTjRKcEovekl4b3Yr?=
 =?utf-8?B?N3RNTmsyR0hSTmhKbEsxUEVpWmRCdmE2b1BZeEhiOXhjL1k5OWZBVzFpdGlN?=
 =?utf-8?B?Qmc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 056feeb3-ea12-427b-5ee1-08dc000ee758
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2023 21:18:39.1486
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zFK66WNsf7B3Z7SycSs0dFjlZrRlV0f+3nrRr78cXy+H4ye1kbzjBTAyKErz7xJnsiEHcvrIylNkEhi5MXQvSdAOYHTMAr+Ri/UuweZ2SBc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7941
X-OriginatorOrg: intel.com



On 12/17/2023 1:32 PM, Yury Norov wrote:
> Add irq_spread() function that makes the driver working 15% faster than
> with cpumask_local_spread()
> 
> Yury Norov (3):
>   cpumask: add cpumask_weight_andnot()
>   cpumask: define cleanup function for cpumasks
>   net: mana: add a function to spread IRQs per CPUs
> 
>  .../net/ethernet/microsoft/mana/gdma_main.c   | 28 +++++++++++++++++++
>  include/linux/bitmap.h                        | 12 ++++++++
>  include/linux/cpumask.h                       | 17 +++++++++++
>  lib/bitmap.c                                  |  7 +++++
>  4 files changed, 64 insertions(+)
> 

Process would be to tag this for which tree it aims for. Since this
looks like an improvement and includes cleanup and changes to add a new
helper function that makes me think it would be net-next.

Thanks,
Jake

