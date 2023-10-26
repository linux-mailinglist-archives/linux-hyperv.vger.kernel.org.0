Return-Path: <linux-hyperv+bounces-592-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F30ED7D811A
	for <lists+linux-hyperv@lfdr.de>; Thu, 26 Oct 2023 12:48:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21C2E1C209C1
	for <lists+linux-hyperv@lfdr.de>; Thu, 26 Oct 2023 10:48:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65F6611C9E;
	Thu, 26 Oct 2023 10:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XnxACJwc"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD93811729;
	Thu, 26 Oct 2023 10:48:04 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3016218A;
	Thu, 26 Oct 2023 03:48:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698317283; x=1729853283;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=TnUItMMqBr3LvqcvvVMMhQVyhICw9WZQMUSyVBca+j8=;
  b=XnxACJwcHfPBF+OKmpSZAIOBW1VFX4obaQpZHdxOjkUNx38Qr770Y7+j
   lQ2eFzNOmgSp5c7QO0y+IGFA5iLHx8Cms+1n+JQq0TNcJfZtYmTtyxuXL
   EVuc+NyOkjlepvhBKE1sBzPnFb3YubHZud8iF/g2wq+cUj0DW8F9TTN8t
   PithcQ6eeupkwp8keaKa6ZAHavbZ7ddtVcWdp3NcIS7xliMbaPDJVy2qN
   rtW6b+uTnf2VC8AVUj7LqI98/ITPno9McF3xOHwAspvj1dgkf7+Fgo3EY
   RNvAycYyRiOch7l4zu03CE2+sU8Es9GrGJI3atm3GnEuLvz6nQvc63XIB
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10874"; a="453982910"
X-IronPort-AV: E=Sophos;i="6.03,253,1694761200"; 
   d="scan'208";a="453982910"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2023 03:48:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10874"; a="709031861"
X-IronPort-AV: E=Sophos;i="6.03,253,1694761200"; 
   d="scan'208";a="709031861"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Oct 2023 03:48:02 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 26 Oct 2023 03:48:02 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 26 Oct 2023 03:48:01 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Thu, 26 Oct 2023 03:48:01 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Thu, 26 Oct 2023 03:48:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cPtT1UldxS3uFd/QlNhbbXxKScrTjy4lftC5ttscYFABewYDiaadYyi8ZsLFDjnmMuZ9urBnyw7P8iTjVsHxGJAB1vITXs8R7Kn7ocYV8kvH30xvariJNcpZQTg5I5FAiqM6jwIwZHvN83ng1xA4QBxs4YzvhOQfJaaTTQEIHzcZjt+bk/5oU7sRKtSsmIaZdUYkyDa17eryf66JIqGlM9vJU9cFRNeDrc6bUnfYrEMKjlSZWeNSR6WGrqcFWO0QX/BcPPgj2ORg8O5Z6YNk7G4FaZNY80dKg+sbX/qH1kwguu6j+nW8EO5XPG7NEpl+CuEShyTZgd7NZw+fimwcuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JsjAfEjGkAgsH9CmeP9DmyhmXI7gbPJAJ1gVwHZoi/k=;
 b=SrkzcS0cIlJDhYR/MwZx+g3X18qmm+Cuxen+wP+LRoEjtSfQQYa4Xcwg5EFYqraWtkudRzIgxeuM48vQ6ZZhxGfQSMIxHhL12VrjU7l/+6yTMnckQGp7i8Zr50OjsaFE+QOofRK2oLsQCOhKk3bkKAHUuUPvL0IkpFNT7ZQtAeWxJ+jaz9EA6TxS/DKItM9W6oHvdw6oheyM610L/26ZLZFR3UCQndnh23tkEo9x4qF++kpAZZyHEmvHnxLXiCHNtTk2nUg9eD0rY05wcu7tIJ06Tp+sr+PWnlQI+yrzvXecnOx4r1pUih11m21F5rEzHYmyybkc7+RS6bDUaT6W8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW4PR11MB5776.namprd11.prod.outlook.com (2603:10b6:303:183::9)
 by DM4PR11MB7303.namprd11.prod.outlook.com (2603:10b6:8:108::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.19; Thu, 26 Oct
 2023 10:47:59 +0000
Received: from MW4PR11MB5776.namprd11.prod.outlook.com
 ([fe80::71a7:70c4:9046:9b8a]) by MW4PR11MB5776.namprd11.prod.outlook.com
 ([fe80::71a7:70c4:9046:9b8a%4]) with mapi id 15.20.6907.032; Thu, 26 Oct 2023
 10:47:59 +0000
Message-ID: <99f1f2d1-8fb0-4e56-9820-86254ce8bd02@intel.com>
Date: Thu, 26 Oct 2023 12:47:52 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] hv_netvsc: fix race of netvsc and VF
 register_netdevice
Content-Language: en-US
To: Haiyang Zhang <haiyangz@microsoft.com>, <linux-hyperv@vger.kernel.org>,
	<netdev@vger.kernel.org>
CC: <kys@microsoft.com>, <wei.liu@kernel.org>, <decui@microsoft.com>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<davem@davemloft.net>, <linux-kernel@vger.kernel.org>,
	<stable@vger.kernel.org>
References: <1698268592-20373-1-git-send-email-haiyangz@microsoft.com>
From: Wojciech Drewek <wojciech.drewek@intel.com>
In-Reply-To: <1698268592-20373-1-git-send-email-haiyangz@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR5P281CA0016.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f1::14) To MW4PR11MB5776.namprd11.prod.outlook.com
 (2603:10b6:303:183::9)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR11MB5776:EE_|DM4PR11MB7303:EE_
X-MS-Office365-Filtering-Correlation-Id: 0cc746e7-af5d-4561-e6b3-08dbd6110520
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jL1kJL50520T7Fv7zlfepXcrR44pkJiZNUVi3RNLjZVulHQFvLNG40Dn011jXfrFnpra6J7UgdzKfnnPAY7/dvEUetVv422Y7YZ1FPFRf9yl4GNSHsYyrCfBmADiyKqRClPCLU8OD9spyu66w6oHf7jbft8lLiWeSFp9ZmyuLmixTF4L92AP4PQsiq59aL4km1B2vwVUHBrUbD7+OxgURA+e+2d27oYVV6HxoAl0buv2oFJ1tS+63/iW4jMpGazoTGXYhAbah6kyMYJP7PIGp7gNYre97OhFDLZaMg5hSh5Y8M8gkNVT1JvzKuY5pVdcJBquufTUQpR05CHXlztePu2afHVfOJHTxLcBpF4DRbF4qhcfui344/wqY/FgSsU9YCtyr/glcATQttkTc9bffR/c6nnPpBE8vUOxeUjVP8veRDZTBlRr1B13+lh0pqJb8Iv//KN1DFYUDzOTWfZuSzRdWM7NbOIhtoPS+AYCQM04Dg5pra2Jo17oYg5A+Zaie0C7hBQ62AscvgoHBbuya7LOp1O/xw0RbndbDAnDTejkxhezGa3dZr3RSgEkJefHpA4UTKV6itB80uY/ZuzigZdmF7eqqhbz04UCzmedQutlwX2v1Eiy0S6c+W/fL5BU/Pg/QfNMt3eFLh/+agHP3w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5776.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(376002)(396003)(136003)(366004)(230922051799003)(186009)(64100799003)(451199024)(1800799009)(66899024)(66556008)(316002)(66946007)(66476007)(8936002)(4326008)(8676002)(45080400002)(6666004)(478600001)(6486002)(2906002)(41300700001)(7416002)(31696002)(5660300002)(86362001)(38100700002)(44832011)(83380400001)(53546011)(82960400001)(36756003)(6506007)(2616005)(26005)(6512007)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bG4yMWd6c2EyNVpIMUJ1TXR0U3VUeHB5Qldjeks1SXFFZFg0bmJEYm9xbnEy?=
 =?utf-8?B?SFdpUEp1QTlnQ0JsdmVsQ1k1T1AxdVo0dFFNVXpMaUdWMHNtV3J0eU94ZHlJ?=
 =?utf-8?B?dklzWGNHUHgxRzFnVEo5S2UxR3UwMnc4dGJyd1Qyc3hlV252U0hxa1NQL0dS?=
 =?utf-8?B?eXVKdUNTbldGOHpET09JbFFCeTlBN1Eralh0M1dwRXFRakpRTjE0VU84dGdn?=
 =?utf-8?B?SThld04rbEhFUTdKbENQT0RuVzIwRVZrZW0yS3JDUnlvMUVaZ3F3RENvSXVq?=
 =?utf-8?B?eGRVYXc5YXllZnNYVmF2cjhpdFpLZDRkVWtZUnZBdFYwUisxZFNnNUtvWVox?=
 =?utf-8?B?SFIyMGVDUGtlYmFTWmYyd0g4ckp3ZFlOS0psLzVHcmxkblh0VGZjbWV4Si9K?=
 =?utf-8?B?MVN3NU9kbVdHRFphSGdMUlM5dW9jUjFPM3dtYW00OWM4ZGlGOWNLQjdNc2F2?=
 =?utf-8?B?TDRtMUlOdTVPZEFRTzc5OXJBSThjRW9LMlhMMGJSUlVjU2tBVWIwUHd3a0lC?=
 =?utf-8?B?aWVON3Q5TVpsRHltTTNvK1pkK05MbXNteXpBM0VCSWtUOVZmbGNWMWlUcFRF?=
 =?utf-8?B?cmpvTnBJMkpHZXQ4eTQ5bzVrdkNPNHZZU0lmQlduQi9wb3pLMmw0aUl1a0JK?=
 =?utf-8?B?aDYreDJUR1FaRkxSZEszSFkyUzBOR3hVd3o5N1JCMVphb2xzYXBrV3VqNEd5?=
 =?utf-8?B?V2hZUngxenBUOVQwNmxGWVlkS0J1UWdtdmxRaWJKWXRKUmp6WjFSUTZUTlVj?=
 =?utf-8?B?Y0xtV2NBcWxhSU93T3VDeElEQlBjOXdDTmhzdllmd3FJY2xza2JlbHp1QkdM?=
 =?utf-8?B?WnNzNUcyMnpLT2hXNjBXeXJhd0huTGxzQlZhMXM2My9NbXJUQ080NE1LQ0lp?=
 =?utf-8?B?dU1lLzNlZXkyeitpNjNlam1MNW9wTmw3K2V4bUNiQ3dxYlRwcFR2Nmt1Wnls?=
 =?utf-8?B?cmFSc0VXUXBaWThXcnptY1ovRXZDQXUyVG1VbkdvUGhtYldMbEJlTjJCY2JZ?=
 =?utf-8?B?dklyS0FuNmIzQ01nQW5mMjYyODgzVWo2ekpXalltYmVuUWZ6SkpDcndUQklX?=
 =?utf-8?B?QzczY2M4N3lzSStDckR6aVN0WHlRYU41dnJxMnE0Lzl0ZnpDOFQvRE1ic3NM?=
 =?utf-8?B?dzVKZkNybnBjMnNJZEEzV0w4aHI1TGVITEhFNUk0dUpmNS9MOGpDNEdQRDFm?=
 =?utf-8?B?SGo5LzcvZXBOSDZDRmNEQVBQbU84SSs4d0pYdHVKZ0lCU0l3Nk5OVDd3OSty?=
 =?utf-8?B?c1RWWVc2bVI2cWQ3WnNrbkoxYnc2K2JnbWV4bFVySllYMUhhdy9qRHg5Vm9O?=
 =?utf-8?B?UWc3Ylh0QnlWWlk2SWFpcE5qQWNoTmhhK1VSbXY4VmcvbFJIbmtUdXhPRm9O?=
 =?utf-8?B?NGxYSmliVU5ET3ZIS0VkU0VBU3d0Q1VRcHdhSzdBN29BYmJqY20vbi9KbUI2?=
 =?utf-8?B?YkZRRjlrZ0YxR2FyRDJHZE41RWNQN1p3d2JWMVVWZlFDOE5yRUZJQjFsZk1M?=
 =?utf-8?B?d2IzdmFkL3VZRU1nQnBPczlGOGg5aFlTS2tnejFzY053cERBZERVYU5MTkU4?=
 =?utf-8?B?aHVyZlY2aWJvTTNXbHRvSGppcTNaODFsWklONTF1WXZ0Z1Y0MndTejl6UmJx?=
 =?utf-8?B?eUxjR2JLS2JtV3VoVXl0WWE2aVBTU2xmSGd0ZjZuUCtuVGQrdWc0cCtwYU1u?=
 =?utf-8?B?aDRTM3VvNXpmMTRJSmh5SnhDZUx0NmxXMGdUTXBibVBIRnVVd2NxMWMvZDlj?=
 =?utf-8?B?UVNyckpnSFJ4c3lJSFo1SUNJZ1RobzZPUFQraTEzQzgwdm1pck1VVVBlc25n?=
 =?utf-8?B?Q3ZSTHVMNDJhVW5OTkV6aHhqODNjeVZnQ2ZKZ1cvMXRockhheGQyaFgzbnZ4?=
 =?utf-8?B?WGRXZ3dPK29oY0JzWW1SdzBHc2NjZ3NrdlFJcnRjejlGdDVvVTRFbmxkTGdZ?=
 =?utf-8?B?bW1QczB2bFNnMm1PbEtsSXVQMHp2eXI3SFhva2dhcHVhbVpaVVJ3ekhZc29y?=
 =?utf-8?B?NUEwNXM4MjZxSkJaU3VwdzNhU1lSamYySzZBbnhTUXRsYTgwbUhsMzFCQ3Na?=
 =?utf-8?B?SHhvT2p3VEZCN1h3NldYZUtUcUV3dnJXOXA3M05UYnBuY0tWays2c0FZZlQ2?=
 =?utf-8?B?ZnA0WjlRVk9mMW92L0txYUJOUzVQcFJoZk5VYmIvSk9pcHBuK3FXc1EwWXRX?=
 =?utf-8?B?aUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cc746e7-af5d-4561-e6b3-08dbd6110520
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5776.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2023 10:47:59.4559
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gWDQs0hshiUpJhvsX9uLWNsvN2U5OLX2hVh0Ly78OWgoLuZHM0rRkm4BIy5h2S+k+FvbxgMChlCsb5HI2nkUCgGqs89eNVPwidkN/o/jWnM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7303
X-OriginatorOrg: intel.com



On 25.10.2023 23:16, Haiyang Zhang wrote:
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
> 
> ---
>  drivers/net/hyperv/netvsc_drv.c | 30 +++++++++++++++++++-----------
>  1 file changed, 19 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/net/hyperv/netvsc_drv.c b/drivers/net/hyperv/netvsc_drv.c
> index 3ba3c8fb28a5..feca1391f756 100644
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

In case of error rtnl won't be unlocked.

> +	}
> +
> +	eth_hw_addr_set(net, device_info->mac_adr);
> +
>  	if (nvdev->num_chn > 1)
>  		schedule_work(&nvdev->subchan_work);
>  
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

