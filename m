Return-Path: <linux-hyperv+bounces-7622-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id E800CC64AE4
	for <lists+linux-hyperv@lfdr.de>; Mon, 17 Nov 2025 15:43:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1F945342DDF
	for <lists+linux-hyperv@lfdr.de>; Mon, 17 Nov 2025 14:39:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D22CD3321B8;
	Mon, 17 Nov 2025 14:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RG/VkB9K"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCAAB329381;
	Mon, 17 Nov 2025 14:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763390336; cv=fail; b=st598y6d5mCnq8IHnJhmnlOj0CHM/hy6IO1g7k1E/FvZDBB7GPP35JoOiai+I5C/iumtjYj9R2i35wEYX9d2OVxiRQynOW5ESjkfgcY8Z+nqVo0GFo9c0+olv/GIx9f6cM0mB71mfHSmYLHB5MQ0HSdASU6z2sdYR8oqFA9vFFg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763390336; c=relaxed/simple;
	bh=CKupKswpN3yjctiIhqjAnEuq1/78OwJpI1qiJP11fQM=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XVsZ6j4dctKkt3HJNGdNDeatyf1WGSU9lrUz/oc/LXzxxZI1nR+HbogHET2fsWAaDwrQW7HhQyrSI2pNXnXkBT04mbJVqQiIx8tnjahXdhgfkhYg3zZ01teBVcwzdLigpnDox23+3oTnXtwWjOTVcscsHC42CDqU8Y57508D3wQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RG/VkB9K; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763390335; x=1794926335;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=CKupKswpN3yjctiIhqjAnEuq1/78OwJpI1qiJP11fQM=;
  b=RG/VkB9KDbdufzLrGJrq9FKGO80UQoF3Yvn3bj4fbzbNq8pvzfwtLHhI
   25DTNVoWGO9Xji7I4JGOBTLZpLqahygBANeYhrtsmfgTGaRW/RH9Evevn
   TQjHKCZYfs4xWzsMrHOVg+bi7NSC8Yn1dIdLaw6FnCytVMRr59Z5iS8nN
   mJPqimKEi3q+Tbkg0pDVc1u9ZvAszCO+BvEIY8qsISDzHZ1WkQ0+VAdGj
   LMSKwnluu2lLfBF5+DAs9SN3iVlvUroFpb4gO3oOsECPehPtxX5ESAJUn
   hZyF7rZVlWjKzckgugYYnXag8VT6VpnsoFSMgJmtLcYDO64Zj4cOy+CdE
   w==;
X-CSE-ConnectionGUID: NxxpHMF2R+Wpv2We8KKr0Q==
X-CSE-MsgGUID: 0GVTaYLaSBKhr0nMTB5xuQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11616"; a="76740124"
X-IronPort-AV: E=Sophos;i="6.19,312,1754982000"; 
   d="scan'208";a="76740124"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2025 06:37:45 -0800
X-CSE-ConnectionGUID: wuoUdZ+aQMS5tcEidPaXTg==
X-CSE-MsgGUID: RvXx8OtBSx6+4GOvyMdYxw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,312,1754982000"; 
   d="scan'208";a="213865468"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2025 06:37:44 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 17 Nov 2025 06:37:44 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Mon, 17 Nov 2025 06:37:44 -0800
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.5) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 17 Nov 2025 06:37:43 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RoQIYD0qN81iGkm+inM5zlV+zwYNQB7nWPnjBzEftF11K/mDAbGAjzeEaFi9tQJeu5R/f3IovItuH7gRrsT0wNFjFiNtlH58ktIko3gnaKlgrtCKuEiV/vdHdbUQ5Hi3wYYohXIHE5E1l3gAvNcvlx7r9ORyh8dZQYSxxQzMAD3iTMRziDU8jUVAqZANLAn7FxKvAxD7bD2JbR6nuDWMkYgMHUdDrI1YV/K63dbvfyU1wrsHCj3ZGBRJQw1UZIHON4f3deIJgdHBc/WFL7l1UuS89Ua5YnwWVfGM9LwkBLx8wssidQz8u4xJR33OuEs/aLJp+NPKdu34m5+vNp5dVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U7dVchozfdbnm1i6CK72CWQ5lu2L9dphtcrjXhpoDO4=;
 b=hBLos4DMc5JcAuR6uCPxX2j9fh+T+arvB3cbTDZKBtsXm/E5XNovS1630/L+4LibYzQmAabHYD0ErZvRpArC82QjZK/JdUUtVB+5xXpPgZr5cF39zZm33dYUEk7Zsm8X04Vcp5pqIBzOlskuUWMu4HvLe/+D70GbbPzi1NFvkCfe/w3JsK50eu5pvHXLPjs/3aFVLUUooExkWR1qiHnjacH6E9pYL2bz01/4hK0vMN72YlP77zjXGsl8/yHdK8VpHAYS4lxo+j7xgaqH1UmFuGEOJ8OxcuT91x1hnEKByaPZEKk/qxmhsRs9NYGRCyo/oDY9rMwe1JazG1R/enD+WA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV8PR11MB8722.namprd11.prod.outlook.com (2603:10b6:408:207::12)
 by CO1PR11MB4915.namprd11.prod.outlook.com (2603:10b6:303:93::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.22; Mon, 17 Nov
 2025 14:37:39 +0000
Received: from LV8PR11MB8722.namprd11.prod.outlook.com
 ([fe80::314a:7f31:dfd4:694c]) by LV8PR11MB8722.namprd11.prod.outlook.com
 ([fe80::314a:7f31:dfd4:694c%2]) with mapi id 15.20.9320.021; Mon, 17 Nov 2025
 14:37:39 +0000
Message-ID: <dd88462f-19cb-4fde-b1f0-5caf7e6c6ce6@intel.com>
Date: Mon, 17 Nov 2025 15:37:30 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH v3] net: ethernet: fix uninitialized
 pointers with free attribute
To: Dan Carpenter <dan.carpenter@linaro.org>
CC: Ally Heev <allyheev@gmail.com>, Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, "K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang
	<haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan Cui
	<decui@microsoft.com>, Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	<intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-hyperv@vger.kernel.org>
References: <20251106-aheev-uninitialized-free-attr-net-ethernet-v3-1-ef2220f4f476@gmail.com>
 <575bfdb1-8fc4-4147-8af7-33c40e619b66@intel.com>
 <aRsfBDC3Y8OHOnOl@stanley.mountain>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <aRsfBDC3Y8OHOnOl@stanley.mountain>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL0P290CA0003.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:5::18) To LV8PR11MB8722.namprd11.prod.outlook.com
 (2603:10b6:408:207::12)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR11MB8722:EE_|CO1PR11MB4915:EE_
X-MS-Office365-Filtering-Correlation-Id: c70591a2-3625-4d66-77ba-08de25e6db79
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NnBxSG56MlJ0T0I2WXVpTWVtOWwxTzBhbGIwdW9xaUFtQjFPdFY5V3FkVTdE?=
 =?utf-8?B?Um9uKzVRb013Z3NmaDc5L0FoK0I3ZW9jcEdIa3doc2FQd1EyRmJFdDFnekU1?=
 =?utf-8?B?WDI4aURvSCtCd3hicHNMMURydHdZcnFNbHBQODFTTmxUelFlRzFhVTRERU1W?=
 =?utf-8?B?TlNNN2NNZkxkZ1RzbUxFOC9wZzJYOFI1N1ZQdm1Nb0VnUGdIYlBERUdyY3BK?=
 =?utf-8?B?blY3TVFEbHVSMGZQVUVUVmZjeS9BNmRpYU1yS2ZCQ3NhV3RJaSthaENCTlR1?=
 =?utf-8?B?dHljaWJ0QXM0V08wejlvNHVpMnBsaTgxY0ZGTUFLR0NKbUZ5dFpHR0dxRUpa?=
 =?utf-8?B?dHNjTFV0K25MMmZjM2VMY2F5STRPejZleDBwRDdJQUgvbXhLQzJNLzVyUGs0?=
 =?utf-8?B?TjFtSFRGbnovNEtHQXZoeHIzYlVmNkJha1BBK3dOcXhZSnYxV1dqOGQ3d29a?=
 =?utf-8?B?TlYvSHNMc0J1OSszYnQwUW1EODBWdnc3akEyZ1I1b3owNGdjQ25lTWNTTkZh?=
 =?utf-8?B?b0hKRHduOTBVNDZOK2x0UVpEaXR5MWpxV0tIeWRUNHh6T3NLU1orMEorWmk1?=
 =?utf-8?B?YU5leSs2WnVMeXZGUEd0ZzNTeFlHaGx4NXMyei9CNXcyQU1UelhFSFNkQmhH?=
 =?utf-8?B?ZlgxTU9XbzdqdjlUK1JLWjVDdXpNUVBJQjhYUHhiS1B3anZGTk9BdGRwV2F5?=
 =?utf-8?B?MjMyU1lvQm14cGdvTFFKTGJxL0F2Qzd1Z0c5OGNySW9YUWNqOUIrRnZKWXBP?=
 =?utf-8?B?Y2pKWCtIZHRVeWcrZHB0aFk3TGRzcE9jZThVSDJNT3pha1gyYTM0ZTE3NzJl?=
 =?utf-8?B?eWRnYnhENy9uL3FDeGdlZFEyQ0tQUERCMzV5OENSMDdpdmM2RmFYR1pSZ2xG?=
 =?utf-8?B?WmlKRTl0NFJia0xEYUgvUEw2amFVeEh5cDE3RkRKSlRlUkdhUWpOUUZ0NjB3?=
 =?utf-8?B?NU1qZW45VkNyZDVRYmRWeWpEei9PQTlmQ3VBUUlEeXpPdEVwcytwc0R0b201?=
 =?utf-8?B?RTNQdlpzOXVMdjFza3BiamJKVXNqNDltRkY5THRMOVY2dTFDaEpUcVJBbkN2?=
 =?utf-8?B?WjNXV0tSOGF2VVJ6RzNieTZzNnppbUEwY29OU0o2S1JpSGJVaHcwdU4vTjYv?=
 =?utf-8?B?VmVENXJwVXljVWdTcGNzWkVwdkk5Mmw1SFFmZjQrdS9rbTZSaXU0SlFzQXRP?=
 =?utf-8?B?ZUtsdWpuNmI2NUdEUFN1a09QS1pGelpQd2lsOUFSOFFvUlkrdGRVT2oyM0lZ?=
 =?utf-8?B?QkVKbGR5MENBN0pKdzlRZk41bFJrUkZFRzZoSm1qMFZPZnZUcUZHYTh5L3NY?=
 =?utf-8?B?aWpVRE94Qm4vLytXTHdmWVg1dmowaUJPY2FSWVlMRUkwK1pYTmx1WEg5Ti9P?=
 =?utf-8?B?ejE4bDNnM1Q1MmVzRXRoQjdCVUcyYnZ3SENkVTlPbFBIL0o3V3ExeFRLQm0z?=
 =?utf-8?B?Tk5DanNxbjNKUHVGZ1dZckFzclVWNGZFU1RXZ2Mvb2ZNOXJZTkhBMThab2FZ?=
 =?utf-8?B?Tkp3YTdhTzZLZ2JXd25FSWtzQmdqbzZXR3p5bVlQTDJGbko0WXV3alk0ZnpE?=
 =?utf-8?B?Q2JLRVVsNTh2ZElGdkt2T3hHbXhXcmloYjB6UVk2MXMrVWtRYTVrVHpJNytC?=
 =?utf-8?B?SEZJQjh3eWhzRWlEOVlzdjViTkhJcmhqRTlzYlBTSitJVmpTZUN4UTlDQXFR?=
 =?utf-8?B?MnhWQmNoYXFpWURnaCtDOGR6REp2ajFZa2kyQzRzMEkwVnlWWmUxTExPMkVs?=
 =?utf-8?B?V09sVjNtN2R5UmVQbmdaZmZ4cVphbjl0UWN6QXBGeDFKN24vRGQxUzVjcWZI?=
 =?utf-8?B?bXQxKzc2YllOUEtXQnliZkNzK2VTaGRjbHRyRng2VXJ4QlpTSVJEdnNWT1p0?=
 =?utf-8?B?RVhrYm5XbGk0dmlqQnpKMWw1RkJvZHlNb2pQVUxQTXMwTzJqL3RPYTRqOTkx?=
 =?utf-8?Q?M+L5Mts4M7Zycu6G0IvXHZ6aK+KnUd1L?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR11MB8722.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RnlqaGpLZm96Nm90OGxSVEZlbHdUWEtqMXY2ZmNBNERoeTM3OFRkdmU4dnp0?=
 =?utf-8?B?Z3l2Z1lOZGZNcU14YkcxaDYvSStkWC9vckNyN08rSWNIWGQ2Q3ZEQ3RXMGdX?=
 =?utf-8?B?ZElrT0h1L0YzcVFaaGFFeXlDbklSRHRoL2FUK1lDS01BWkx1TUNJbzRqclAz?=
 =?utf-8?B?OWdUUUE5RzNNdy9qeWtKand4MHdIWWs3UnhDdkpvZGNvaGtUeERoWGxlWmpF?=
 =?utf-8?B?eFNDZlpXSUhPelp3UkRQRmxDQ2hIZzI4MjdWNWxzZjc0eEJmWG9Eay90eTNT?=
 =?utf-8?B?Y2ZVcitQQ2UwVm4xNjhQeEF5M1NYZVB3QVMyWnNpUHJmVUpkOWVXU28vZkVW?=
 =?utf-8?B?NTB5R084bTFIbk9iTFlFNUVEcWNDNTl3b3ZDQ1Y3VE9NaE1XOUVlYk1GejZ4?=
 =?utf-8?B?czc0cjVpcjZ3TElBMXZGSmFTNkxiRy9RTzMzdlk5OXR1TFdtK2tSdVNOV0F5?=
 =?utf-8?B?dk9MSTVydGRRdkRNYjlWTXoycGhwV21VcUZ5WlFEekhPZFluRXhQSXFzdGw2?=
 =?utf-8?B?UDRxSGkrV1JFN05rZk5SOHhIMSt1VFk2Um9zNDd6SFRZVGlXcUpyZkNSM1Ro?=
 =?utf-8?B?T3NUR0tNeHoydUtKalFNVUdjRlBvaWN4Y2VTNElUdkNFbGZPNitldTFqVFdv?=
 =?utf-8?B?T0o1WTRJR2JYMWY5KzNET3pqT2k2a0ZMUTlrSTFCcGtmSWNsQldkMm9zTG1z?=
 =?utf-8?B?SEJCREJOMysyL0hLeG5jU1dFQXhkNUlya284MXJJajEzNWVSa0JqYStSSDdk?=
 =?utf-8?B?eWwwUCtKWVloOUo4RkdYNldoTGsrS21IckRaT3l1TkFBVGp4cXErcXBiT2c2?=
 =?utf-8?B?VjNUdzh6VGxIQXpSQU1pS01vaFhKVUlSa2RSV1RZSHVvdWlmZjVnYXYvVTly?=
 =?utf-8?B?dFNmOEUrZVJJUEREL1ZsYXFzQjN0TERPSkQyL1RCTSs2eVhmenhBUkExZlJV?=
 =?utf-8?B?ZWtBTnhOZDVTVUl3VUYwbC9wZUR4c3o5aFJDVlRYV2R2WXhhOWs3c2FpeEpB?=
 =?utf-8?B?ekd5WXhSMk4vRUYxNzlpazFkbXdoZXpNeG9MN1UwbW5xVG5IOER2aUhtNHFl?=
 =?utf-8?B?MTFJTlJEb0gxS0Z1Z1hUejhNQVp3aHd1dGFQWVFHb3cxak8wbCtmeWJhY05h?=
 =?utf-8?B?YjRhT2UvQnZoMWFMc0t6QllyZDg1NFZkVXRSc29BVEl6RGorZFg2YmdSNUZP?=
 =?utf-8?B?K1RScFVhcldTRXo5RlQvOUxwQUtCSVk4bW03VVRLOFdtSm1tMlpHMDMrdGlz?=
 =?utf-8?B?Mm1qMnJXR3ZRbkNBMjVudmxFVnZUaXE4ZnU0ZGJWMG1LZjQ0SjZWZWtiRmhn?=
 =?utf-8?B?RUxTdEtQNnNqQzRPNDFaOWFUL0tLSW55dzBKb2RrUWxtT0RocXVaclBkbkJm?=
 =?utf-8?B?enNRMEV2eXJEYzcyTTdLeHp3K00yNUQyM1VmaFc4ZlRpWVJ6bDYzeTE2T0hO?=
 =?utf-8?B?aFZ3SUJDK3RqZ1VjeHFHdkxGNUFBcUUyMFZMcjBNWHBXRUhSNXluNC80NGs4?=
 =?utf-8?B?Z3RUamJQYzdCQ0FYbzJiK0k4dTNCWDRVdUFheUx0cG9XZ1JqZXlxNWJRTExr?=
 =?utf-8?B?bnB3QVRYbzZlNE1QR2pnU0dZc0hLVXRjK0o4NTZjTExobUJ5QUZvYjFhK0hR?=
 =?utf-8?B?ZnJmeGhQcVc0UUhITlduUFk0K3BwSGJONmpIV0hXcG5mbGtNUGJiT0pTNG9Z?=
 =?utf-8?B?VmpqekNuRlpwNlJBZEI5Z0FlejNUQWZ5cXlPZWRJMGdwdDlhd1VtMlRGbHdB?=
 =?utf-8?B?cVVFbTRIZGJjbGdvdnF1ejg3YzViUzBaRjFMb2Y1b0FiS1VSYUljdWVmL3VX?=
 =?utf-8?B?RU80MXoyUGU2cEp2a0JscWJzaWhMM0NVckxRS1VTUXhNWEZJaTIrZmMxSEMy?=
 =?utf-8?B?ZXFySDN0QllHRDhzWmd2TFR6OFQxdmhjSTBpd1ZKSlJQdy9ubk91cTZ5c0ZH?=
 =?utf-8?B?b1g0bUtOTS9UaU5EUGpwNjFRczcwMkdzeHFiWEc0UjFiU1VYVmtKdWMyY0JB?=
 =?utf-8?B?WnlVTEJ0bzZ0VWU1RzRPbEoreWdZR213TWJzK0ZKbjRjRkdtcGxnM3YzdENq?=
 =?utf-8?B?UWFPOFU3NFVubXEwb2lwRkp3ZzA4bzhVTVU2a1lhOFpRSUMzeUpycVpjVWUx?=
 =?utf-8?B?TUdBcjBWR25sTXA3YUs4SEdmdE8xWWNpRmhZSGtXYlNhZFZyMEF6MFE3dGx0?=
 =?utf-8?B?MkE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c70591a2-3625-4d66-77ba-08de25e6db79
X-MS-Exchange-CrossTenant-AuthSource: LV8PR11MB8722.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2025 14:37:39.1274
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vpgHuqXt2aBblRml5aFQx2mVTTUtJZ5ZksKGXBBIFZNnK5JqoKJHxGlZpoZ6e9Y94aw785Or/aDH2fnqcYJJu0uGQZ+uV6DO7uxXCz0crC4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4915
X-OriginatorOrg: intel.com

From: Dan Carpenter <dan.carpenter@linaro.org>
Date: Mon, 17 Nov 2025 16:11:32 +0300

> On Thu, Nov 06, 2025 at 03:07:26PM +0100, Alexander Lobakin wrote:
>>> diff --git a/drivers/net/ethernet/intel/ice/ice_flow.c b/drivers/net/ethernet/intel/ice/ice_flow.c
>>> index 6d5c939dc8a515c252cd2b77d155b69fa264ee92..3590dacf3ee57879b3809d715e40bb290e40c4aa 100644
>>> --- a/drivers/net/ethernet/intel/ice/ice_flow.c
>>> +++ b/drivers/net/ethernet/intel/ice/ice_flow.c
>>> @@ -1573,12 +1573,13 @@ ice_flow_set_parser_prof(struct ice_hw *hw, u16 dest_vsi, u16 fdir_vsi,
>>>  			 struct ice_parser_profile *prof, enum ice_block blk)
>>>  {
>>>  	u64 id = find_first_bit(prof->ptypes, ICE_FLOW_PTYPE_MAX);
>>> -	struct ice_flow_prof_params *params __free(kfree);
>>>  	u8 fv_words = hw->blk[blk].es.fvw;
>>>  	int status;
>>>  	int i, idx;
>>>  
>>> -	params = kzalloc(sizeof(*params), GFP_KERNEL);
>>> +	struct ice_flow_prof_params *params __free(kfree) =
>>> +		kzalloc(sizeof(*params), GFP_KERNEL);
>>
>> Please don't do it that way. It's not C++ with RAII and
>> declare-where-you-use.
>> Just leave the variable declarations where they are, but initialize them
>> with `= NULL`.
>>
>> Variable declarations must be in one block and sorted from the longest
>> to the shortest.
>>
> 
> These days, with __free the trend is to say yes this is RAII and we
> should declare it where you use it.  I personally don't have a strong

Sorta, but we can't "declare it where you use it" since we don't allow
declaration-after-statement in the kernel.

> opinion on this either way, but other maintainers do and will NAK the
> `= NULL` approach.
> 
> The documentation says you should do it that way and avoid the `= NULL`
> as well.  The issue is with lock ordering.  It's a FILO ordering, so if
> we require a specific unlock order then declaring variables at the top
> could mess things up.
> 
> The counter argument is that if you declare a variable after a goto
> then that's undefined behavior as well.  Clang will detect that bug so
> it be detected before it hits actual users.
> 
> regards,
> dan carpenter

Thanks,
Olek

