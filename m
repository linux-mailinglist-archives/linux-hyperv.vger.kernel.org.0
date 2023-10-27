Return-Path: <linux-hyperv+bounces-623-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A49E97D9520
	for <lists+linux-hyperv@lfdr.de>; Fri, 27 Oct 2023 12:22:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 965E81C2100B
	for <lists+linux-hyperv@lfdr.de>; Fri, 27 Oct 2023 10:22:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 502DC18031;
	Fri, 27 Oct 2023 10:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FpDJ6hM7"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8AD9179AE;
	Fri, 27 Oct 2023 10:22:39 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04A49DC;
	Fri, 27 Oct 2023 03:22:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698402156; x=1729938156;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=yOHq12nOlsyCy+iSr3O2V+EnN+9CYniMqTBYox+Ruuo=;
  b=FpDJ6hM7H0IqKMnybhRqjYu+Dlbws8RMgoYwTCOx9wvYAaOZZTLK+oWl
   okkMRNnRfIB+0rKEi7rS09RjaDlGM8oELkXUHiRlTjT/fvK7fbD1T+q8K
   Q8nlJeQCRDMC6vsUy7xBxcmfD2Mxq14ySGjUJE2Z7Dek8B/CP69WuH6sV
   Jfy0egirWtDTZBJSaQKJvuIUUXiUuMLcmlSwHhq9fkrU98kpe00VS2eEx
   I3h27Dti0WfYTO6Lrg4dYUi+oqFVTkGzfzkA6PU5Y38I57nvgHJXZtb9e
   I3+2gDnlVWLp457IyHuynvVX6bA9aC6cvs84ggaR39t+RUYlT6G0tLE5O
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10875"; a="391623985"
X-IronPort-AV: E=Sophos;i="6.03,255,1694761200"; 
   d="scan'208";a="391623985"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2023 03:22:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,255,1694761200"; 
   d="scan'208";a="758773"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Oct 2023 03:22:00 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Fri, 27 Oct 2023 03:22:35 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Fri, 27 Oct 2023 03:22:34 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Fri, 27 Oct 2023 03:22:34 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Fri, 27 Oct 2023 03:22:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h9ykvvgSjW6rXKoDDNfG9ibm80gLR3JLjgc363p1JUiuqoTRKGlRpnPGqr+WwxVB2Q2WjkY13+k+r8Wo1VnHTFhOUkbXc9/vGqyeJdYfwsrTBgoYPpxOpXw0s5tRZ56zafgXq3ftstFhqwUVPBJAoG6RVq4C7l00k68HgmO5x0UCvb6/9QUPsGwiH0w1kOKrXXUFHJWhE6fEZfKYCFyUAEcFHwGQ86zDqb3O3DzIofD18Oifsfk9l8/b/fFBxXGWO6ewIoJqOaC9z/Jnz94manImgyPOgSE4JlXCaYN/dUCu+ZN6iYPE2ehRPQfxV+gD0G6FKCu5nCsYvDJCtNG++g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JSiiY1hsI7rE+8w8PHV/zJ6cN+g95+1grS2Ui6NPepg=;
 b=RrQK2o8lfXQLQZJeiTk3UDR9IO678aCa/4srgli4klwLOIOPbH+jImucsm+y1vZDNOGPDn1ajByIlgtr8sC1AcNuR5YcSTOw5rbiTYDkDyO1yrSDAj4WIthQopmEWHFWOWiEjoJevUl2MncpHF4JbBJv26dmmLRGvBo2CVjERRIndAEn2uMwc1tHo6V/bXmQL2gmZ64ogrtSxZElZkDjV6oWYKliHyvgyhFJzChXMULx6ihJSNyUD4S/Q97LZ8XDZp3nHv/KTdkLyhcAttwIJkvAVKDhUqR5wdbtrNSg6Q52BFHPlIvPzHy3qjhGHXKuaec3XJs5cLEvdrEhYh+jFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW4PR11MB5776.namprd11.prod.outlook.com (2603:10b6:303:183::9)
 by SA1PR11MB8318.namprd11.prod.outlook.com (2603:10b6:806:373::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Fri, 27 Oct
 2023 10:21:32 +0000
Received: from MW4PR11MB5776.namprd11.prod.outlook.com
 ([fe80::71a7:70c4:9046:9b8a]) by MW4PR11MB5776.namprd11.prod.outlook.com
 ([fe80::71a7:70c4:9046:9b8a%4]) with mapi id 15.20.6907.032; Fri, 27 Oct 2023
 10:21:32 +0000
Message-ID: <ce888f7b-70c2-4139-8f18-1cbb3fede9cd@intel.com>
Date: Fri, 27 Oct 2023 12:21:25 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net,v2] hv_netvsc: fix race of netvsc and VF
 register_netdevice
Content-Language: en-US
To: Haiyang Zhang <haiyangz@microsoft.com>, <linux-hyperv@vger.kernel.org>,
	<netdev@vger.kernel.org>
CC: <kys@microsoft.com>, <wei.liu@kernel.org>, <decui@microsoft.com>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<davem@davemloft.net>, <linux-kernel@vger.kernel.org>,
	<stable@vger.kernel.org>
References: <1698355354-12869-1-git-send-email-haiyangz@microsoft.com>
From: Wojciech Drewek <wojciech.drewek@intel.com>
In-Reply-To: <1698355354-12869-1-git-send-email-haiyangz@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0430.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:d1::20) To MW4PR11MB5776.namprd11.prod.outlook.com
 (2603:10b6:303:183::9)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR11MB5776:EE_|SA1PR11MB8318:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d8fca6c-1333-46e8-1822-08dbd6d67d75
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Q3VEt3Nmkw1mpwss7dNo+de2w21r/ZTGSQGXM5gGVXhyb08RIQJpdX+zXvAYz1+24R4Uo4AydppN9KwIqAc5CWAZh8ofd0JLPD8GnUIjdxXUsTa6kyLrIoEyPF/u3xs4/IyRsrIKz3N+/TkeCfec5TNhZJDBuf+B13PPFH+Mm9F10OfvIf4SGJLeBzBztdFdD9FNAyMz6PwLSUbwxywZD6g477+5p2uH+yK+69cg5AXzJhHesNQOyIjUENvRymnarsn4Mb07wpcm5qEW7ACa2nLRxpgPhFG9iCLxDj6P7clcrU8gwYdHE7z2PllBcJsjwprf4HFVxzI3I3wMI5y/tC4SfqB9SA+A0uVjhaSfuJAsQ8Rcr4iRi5H22sQlQT8DGpWKRuHviNAx3mM0gGOb/96X+fBmS4LSTfJ0UAO1pL4OF6EJLMo1DgDwE/SQDZ9HiTrxq7WQNCjplEX4B+MxHuRiBW/VGp33uqd+BKFThx4DQhUB60OYn0b7HzTU5JzLC6xCBpyJef7qoV/Myuopyo0ri89zyuEtUUWkoYSZTvoF76AnNURewTGovwXMQJ3QWJWpQ4/U4Pm9Q8zZixhJyLsvvjx7Ou/ocLuUHNRYRH1K5h14jqsCmHt6PXw0aITqPlXx29XwS/ox/KiPafUrcA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5776.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(39860400002)(396003)(346002)(366004)(230922051799003)(64100799003)(186009)(451199024)(1800799009)(26005)(31686004)(66899024)(38100700002)(5660300002)(36756003)(2906002)(44832011)(41300700001)(31696002)(86362001)(316002)(82960400001)(8936002)(4326008)(7416002)(8676002)(6506007)(478600001)(53546011)(66476007)(2616005)(66556008)(66946007)(45080400002)(83380400001)(6486002)(6666004)(6512007)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dENtT2kzUHdSOXErd1Q1YVFNSkVvQUk5YzVBTWpKaFZVMmM1UEg4SjdXY1I4?=
 =?utf-8?B?cGdYMmdIa292a0RwR280SlNCa2o1WkcyVjIzWVg4MzVyMk1YR01yZG9DS00z?=
 =?utf-8?B?TUF3SXFxRGhFbmYzWjZXRkZnZDNvS21YaWQ5MjM4QmtLN1J2YnRraG1sbnla?=
 =?utf-8?B?NGloWjdwUFZaTnkzSWhjYXh5NXJORTZmVWpSMk4zOTdlQlR3amtiSVVCVDZK?=
 =?utf-8?B?SHJyN25vUVBVV1JkQWxMOGk0RVpFdXNSTGF4TDNVenlDREhYZDFTbS92MUNB?=
 =?utf-8?B?SnErRUxaZm5FeEltV1Q4ZFVFY2IyUG5vL0NKVWpGODArQ0QyeEZGOTNKd0xE?=
 =?utf-8?B?ZzFnaGtkNzhFNFEyeUJxREIvRHZhT2xSb21OTEdxaDZaZDN3YTdKdjRiMDJP?=
 =?utf-8?B?d0hGZHpuV21jL1U0STZuVWllZXVjYzZYMVJDSnVqNGhFbGZnMkxFV3NPTWlB?=
 =?utf-8?B?SlkrcnRNK2cvbzBRMFRyakVVWGh1Nm8wK3hoOEtkdHI0YVFGVjlvZjhGREdt?=
 =?utf-8?B?OU9iUldud2Q0ZWVUdkk3MHl2dEdJZ1JOMnpwK05vak1tUENVWDNRUjR3dnZ1?=
 =?utf-8?B?Smh2MGx2M0IyL0E4Z3Y0OU51dVg3QW03MUxEQldENFRjOVIzKzlRTjJUL2NF?=
 =?utf-8?B?UkNyMURGa1JiSkYwNlJkeGY0N0RnSU5GeHl6SkI4OWpkS2FmR2p0ZVZ4Zmlv?=
 =?utf-8?B?bXRQSHQrMWJFN2kwRUZJVXcvY01wQmNTNzhGYWRHQzJUdXVzY05KbURucHhK?=
 =?utf-8?B?Nk8wUGZWVFhZUDEycjJ6bjNQczFrUy9nSXhWVUpUczZkd1JLYkxWanRDQTd6?=
 =?utf-8?B?Qk5CcnVkZWZBK2VhMmRabnBkdmc0S2xXdG51NHlqNjJQZHg2c0xSb2ljRkVm?=
 =?utf-8?B?dmIzNEluTzlRbUUyMGdWdnBrNjdTWTd6MHBXYmZCb05RZmJBeThISE5MUXB5?=
 =?utf-8?B?Sk12VXRSTmVMYXVhQW9ZQmUwOWtqRG5vS2o0SGJDc3NCOTJzVEdBdDRaYnFE?=
 =?utf-8?B?Y25LbUY4WHZ2bXZiZ3cwUkNHM2lsU25GT05NZEdsUWVLWEVCcGN6KzRRRjhn?=
 =?utf-8?B?ZVBaUVRXTU1EMS9VUE1Za0F1UmRUMi9wdVZNcEdsczVYZ2NoZlk2eDVvczdB?=
 =?utf-8?B?b2xDU05DbEpRRG0rcXY1RG85YWlGUmM0aWRCS2NZNjJ3U2ZabStPL1lZWUw5?=
 =?utf-8?B?UE1SZWwxby8rRzhrbkxHSk5UN2VXOVNPNDF2VnZMbnZOaWQ1OEIyNllacHlY?=
 =?utf-8?B?cmx5eWtwbkJ4bDZQaXV2OXZQdURMMUphVGsvVVJidkJGTVRZZ2p4d0RuM05Q?=
 =?utf-8?B?RmhiMjQzQVBpOFJVdUVWSWRjb292OHFXV0I5QWR4a0R0a0NFMGtJeldXWUpn?=
 =?utf-8?B?dW4zNTBISFR2SVJ5RHZ2eWRzd3RlOG5hUExEWk54bHlQSmkwcWZ5MTYzdlZ1?=
 =?utf-8?B?T3pLQ1pYdlBERUM2dGlOMXMzLy9iQ0FxaVV5RnlzcFNQNlkxYmVhVVlZUXAw?=
 =?utf-8?B?VWg2b0l2a1ZnQTlXbHZhcm40SDlYMWk4dGNHbHIyWVE4NTQwTmNoaW5ObEZB?=
 =?utf-8?B?WFhZYzA2U3VBUkszdkM4U013Sy82RWd5bEQyWnJ6TFpQcmJVSjl6eHE4bkdQ?=
 =?utf-8?B?dDJEM0VveTJaZm5oQm5RTXVhZHBlNXpvTW5CU2g2OEFscFIyajhVQlFQL1c3?=
 =?utf-8?B?eGZhbmhzYmFwbTlrM0R6TFUrVElVMVhXVFdmS2lrbm1oTFllOEQ1Q0ZrNE9u?=
 =?utf-8?B?eTRzdFJleDdkQ1ZxL0lUaXlvcnZKemQxSDlmaTAybUZOWiswNUtGcnZPTDZs?=
 =?utf-8?B?TWdiUjVDaWl5NDdzSnBDaVUwNTRmTmxMeWE2MitjY2N1R2k2WnFsaCtRakNj?=
 =?utf-8?B?RHgvNExaL0pSMzFXbHhxa1JOZWhUTEZub0ZUUmc0d3FnR3hETm9TNWpRK3Ur?=
 =?utf-8?B?ekkvNDl0RGxteGVWQnVyamJSZXo5a0tWQU9ZSDcrWHBWUWMxVmd4dCtvVWxr?=
 =?utf-8?B?VHY5TnNIdDhCVFdhSDlLcmdqL0NtNEVEdTFINGNMR2FGMEV2d21WSStueUtC?=
 =?utf-8?B?ak9SODFjTWRkMmx2U1dRVmNXRGRpcE5yaFVrT0p6QVVWT1c1bFJYYURZc3lV?=
 =?utf-8?B?VDRKY0VPVVlObG16Z1NTdDR0dWhMdXJaR0NrRlhBUUZtOFRITTJyaEVHVFFj?=
 =?utf-8?B?Q2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d8fca6c-1333-46e8-1822-08dbd6d67d75
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5776.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2023 10:21:32.1457
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GdpSvyUVB8Vle7rsBDrL4K6CwqUEFGO2QCepLSpliuhm2tRzmuwWYrJFtMBvdK/r4SiFw+RnLZNJlM7iXB0vIvurAE97Cj9i0hGcICZC2DA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8318
X-OriginatorOrg: intel.com



On 26.10.2023 23:22, Haiyang Zhang wrote:
> The rtnl lock also needs to be held before rndis_filter_device_add()
> which advertises nvsp_2_vsc_capability / sriov bit, and triggers
> VF NIC offering and registering. If VF NIC finished register_netdev()
> earlier it may cause name based config failure.
> 
> To fix this issue, move the call to rtnl_lock() before
> rndis_filter_device_add(), so VF will be registered later than netvsc
> / synthetic NIC, and gets a name numbered (ethX) after netvsc.
> 
> And, move register_netdevice_notifier() earlier, so the call back
> function is set before probing.
> 
> Cc: stable@vger.kernel.org
> Fixes: e04e7a7bbd4b ("hv_netvsc: Fix a deadlock by getting rtnl lock earlier in netvsc_probe()")
> Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>

Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>

> 
> ---
> v2:
>   Fix rtnl_unlock() in error handling as found by Wojciech Drewek.
> ---
>  drivers/net/hyperv/netvsc_drv.c | 32 ++++++++++++++++++++------------
>  1 file changed, 20 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/net/hyperv/netvsc_drv.c b/drivers/net/hyperv/netvsc_drv.c
> index 3ba3c8fb28a5..1d1491da303b 100644
> --- a/drivers/net/hyperv/netvsc_drv.c
> +++ b/drivers/net/hyperv/netvsc_drv.c
> @@ -2531,15 +2531,6 @@ static int netvsc_probe(struct hv_device *dev,
>  		goto devinfo_failed;
>  	}
>  
> -	nvdev = rndis_filter_device_add(dev, device_info);
> -	if (IS_ERR(nvdev)) {
> -		ret = PTR_ERR(nvdev);
> -		netdev_err(net, "unable to add netvsc device (ret %d)\n", ret);
> -		goto rndis_failed;
> -	}
> -
> -	eth_hw_addr_set(net, device_info->mac_adr);
> -
>  	/* We must get rtnl lock before scheduling nvdev->subchan_work,
>  	 * otherwise netvsc_subchan_work() can get rtnl lock first and wait
>  	 * all subchannels to show up, but that may not happen because
> @@ -2547,9 +2538,23 @@ static int netvsc_probe(struct hv_device *dev,
>  	 * -> ... -> device_add() -> ... -> __device_attach() can't get
>  	 * the device lock, so all the subchannels can't be processed --
>  	 * finally netvsc_subchan_work() hangs forever.
> +	 *
> +	 * The rtnl lock also needs to be held before rndis_filter_device_add()
> +	 * which advertises nvsp_2_vsc_capability / sriov bit, and triggers
> +	 * VF NIC offering and registering. If VF NIC finished register_netdev()
> +	 * earlier it may cause name based config failure.
>  	 */
>  	rtnl_lock();
>  
> +	nvdev = rndis_filter_device_add(dev, device_info);
> +	if (IS_ERR(nvdev)) {
> +		ret = PTR_ERR(nvdev);
> +		netdev_err(net, "unable to add netvsc device (ret %d)\n", ret);
> +		goto rndis_failed;
> +	}
> +
> +	eth_hw_addr_set(net, device_info->mac_adr);
> +
>  	if (nvdev->num_chn > 1)
>  		schedule_work(&nvdev->subchan_work);
>  
> @@ -2586,9 +2591,9 @@ static int netvsc_probe(struct hv_device *dev,
>  	return 0;
>  
>  register_failed:
> -	rtnl_unlock();
>  	rndis_filter_device_remove(dev, nvdev);
>  rndis_failed:
> +	rtnl_unlock();
>  	netvsc_devinfo_put(device_info);
>  devinfo_failed:
>  	free_percpu(net_device_ctx->vf_stats);
> @@ -2788,11 +2793,14 @@ static int __init netvsc_drv_init(void)
>  	}
>  	netvsc_ring_bytes = ring_size * PAGE_SIZE;
>  
> +	register_netdevice_notifier(&netvsc_netdev_notifier);
> +
>  	ret = vmbus_driver_register(&netvsc_drv);
> -	if (ret)
> +	if (ret) {
> +		unregister_netdevice_notifier(&netvsc_netdev_notifier);
>  		return ret;
> +	}
>  
> -	register_netdevice_notifier(&netvsc_netdev_notifier);
>  	return 0;
>  }
>  

