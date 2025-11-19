Return-Path: <linux-hyperv+bounces-7700-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id BEFDCC6E3F8
	for <lists+linux-hyperv@lfdr.de>; Wed, 19 Nov 2025 12:35:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6F202348F4D
	for <lists+linux-hyperv@lfdr.de>; Wed, 19 Nov 2025 11:25:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C7E5352925;
	Wed, 19 Nov 2025 11:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lb+xoRhL"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFAE3340DB1;
	Wed, 19 Nov 2025 11:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763551519; cv=fail; b=r4TGAIuvpIe35FZ5QEistMy9pY6h7484e4dtnJAMkwLmcdt4tRSBNjtp8myHyaGCkOajmQT88KYsRJMUpzhs4NDcfswX/r6wAeqUwXE8MlhEyK7D86BH8kPxmAi2E8amQPlRx01DiBPkP1szISjEWkbj2f8rgUT4O33GV5b05Fk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763551519; c=relaxed/simple;
	bh=PvCUm5ZPpd3RH0vOjvQETKFXZcU5lU6ErzJkYynKG+Q=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rtKlBbwhDFqs+GsVT0+cCNExot2ZcN+EgjbvFgbjWeTP/77Zujs0nSzeOPhDsjj0WjO2G/Ra92eHxYvnRy/X8pkR+ZZi/dixDEIj8GeM3BcJ7xfONoT4STevPoUfw4QDw3ISYBCtybnkH8Jkw3UfWZzE3Akmm+tZhdWqUTqq1Hs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lb+xoRhL; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763551518; x=1795087518;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=PvCUm5ZPpd3RH0vOjvQETKFXZcU5lU6ErzJkYynKG+Q=;
  b=lb+xoRhLWOoL9pASJV7VMWm2GQzml67s8x3zoFq9OiQVRMSw2jNqqnQC
   RE/Hl/SUNpgZahKncJrf2Rxr1luSBmv503EP4peHgVdUCTJhf0TI3ABjQ
   tkNJA8Zk3V5IYhypOCI1+BFNg4EmmppInEoC2IhDLSdkQlVme1ELck7sz
   vIyLlGxBHmup62TcIJyja1ilMrTKAHFMrTHN6xqkJWRfxReaesc8nUBb6
   UYSk01b82T/Zp+ynY3wo9h+PiNhl4ay+5Mx1LnBfEQMspwnjunex12ZsZ
   KhxI/lEL4JWgvBmGtAEltyBuBvd3elBqTdBZALuOX7tz+uYbgw5Mj8jup
   Q==;
X-CSE-ConnectionGUID: Hh3fGEPuShS/5oP+d9Fjvw==
X-CSE-MsgGUID: Gtb2a6DdRWCOo+zZbNhfYg==
X-IronPort-AV: E=McAfee;i="6800,10657,11617"; a="76694902"
X-IronPort-AV: E=Sophos;i="6.19,315,1754982000"; 
   d="scan'208";a="76694902"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2025 03:25:17 -0800
X-CSE-ConnectionGUID: 7i3kkQvmTwCwWXBHtsZaug==
X-CSE-MsgGUID: ql1OFiIiTdS7NA6hpwyh5g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,315,1754982000"; 
   d="scan'208";a="190688239"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2025 03:25:17 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 19 Nov 2025 03:25:16 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Wed, 19 Nov 2025 03:25:16 -0800
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.64) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 19 Nov 2025 03:25:15 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fjbkpyR0ePxL3qeS7l2toZoBZWUs2YjpOM5HiiIYTM+bD52ifzHX4H2XcrFSDh7OWOx8eqma4bKwc3oxUYtT9BmdLfkLqb5J7X8kKWiVkMWR2PrcnrRP+PmOskln3fNwhBPRdn+4AVar1kHsT00ZPFhWQ50RQZpWvDfysPC9T4LuwHLBomhK3n6wtOBprut9BDJrYQEgqZ20aApv73zUqyyYCVpi3dAWGraSx/20tZLWi65MBZGgC1lanSUROR2FMvXXnx8z38X+UQ8yjvzrU57vp6+w4bZ1A72IS5S1oNAwDmdwJI7Io3FXJokQ4l1TuNtbKr8C26x9J6JwqkGytA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wZwnMEe6UqxwMTid2Inr8um+8qd+PJzgCWFFIxarVDU=;
 b=tlAGLUHMohpCbhCvrtsRHEVzVC1YtCgTZNPPWMWvsI1JB9YvHuAriQ7MOyM1jGXcAfCrJtiv7fk+sA1+kpKYu+u+f39TDhFUlMi4++x0GRwRd3MmJsfyUmLjDEkVjw1ZAycmF+cf1Mmmgcj70CBxD5e2uioqJB/JzP1OVJqRlh9e85YaKEBsiP86c9cX3H5HpUhGs7YqLRmPR22iCETPThwr6P5dfmjVFLBAvQkiS1Ywbe9WHftV8UVj3l/64RlDyTrdXJS0bwpmZXu78y1byPtiDeoH73gOsPE0bSdJPh6H9tfBtN3o/OFSJHcYyVQXBlgi1L6jlxOY+R82+VJ4ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by MW4PR11MB8292.namprd11.prod.outlook.com (2603:10b6:303:20c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Wed, 19 Nov
 2025 11:25:12 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%4]) with mapi id 15.20.9343.009; Wed, 19 Nov 2025
 11:25:12 +0000
Message-ID: <d614bc7b-a2d9-4213-9bdb-cc43b325c36d@intel.com>
Date: Wed, 19 Nov 2025 12:25:05 +0100
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
 <dd88462f-19cb-4fde-b1f0-5caf7e6c6ce6@intel.com>
 <aRtlYIZ2XOQKMGd_@stanley.mountain>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <aRtlYIZ2XOQKMGd_@stanley.mountain>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0352.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:d::28) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|MW4PR11MB8292:EE_
X-MS-Office365-Filtering-Correlation-Id: 7499d35a-dfc8-4ab1-859f-08de275e4d77
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NUlKOUdMTk1LMnM0ckZPWjd4aVVQWVRLVUh5SnFkUUNSSHMrWEdBaXRpem1Y?=
 =?utf-8?B?VGgrWXhpRDBFTklyYS9YZlVxME1FZHZCYXNCanR1K0VaMGJucjVOZTY1Y0hO?=
 =?utf-8?B?YWNlTmozRjEzOGFSQ0lQbVlOOUFVQjhLUkpucVd3U0NDR1JDWTNuYkF1dmlD?=
 =?utf-8?B?YnRRLzZiNXZDUUFyMWZISzFnS0lPWXlhNzlNUTRKR01zeE55QXJtUHdDTUt6?=
 =?utf-8?B?NFAxNjF3cHBwT1JjUFJtcHU2ajlRZExGOEtyOE8ybUhoTmh4K2trSTdxWUl0?=
 =?utf-8?B?UndrTkFxLzczQ2tuVE9mZS9iSU0rSHdmQ2tOK21oSWl4VHExVlEwMFVOTWU4?=
 =?utf-8?B?OU1ObzNhSzVPNWtGcGc1YWV4bnV3UFlod1liT2FxTjhxaVRLbFJMSWUwU2pH?=
 =?utf-8?B?L2VBeUVEZVFsWlpVL3FxMGhwUlphWUVKNmFqeVJkQ1JpN2l6RzNRMWZRNCs0?=
 =?utf-8?B?L1AxcDgvNGluUXZxd2RMMXhyYmd2MmFDY1kyQ3pFcVdaQlAvc092SmtmaGZk?=
 =?utf-8?B?S1FMQlZCSkljREk1WTJtNkt5ajQzOG42RDYvbVZFdkhqN1JPRzl6SDlvOTll?=
 =?utf-8?B?cWZTQldIWlgwU0ttaC9GeW1kdUh1K0FwV2hGTENqQjhpaUwrNGpIRlJ1OFVX?=
 =?utf-8?B?WlkzN1R1RFgwVnp1OGsybkMwYzEyNHQvTFdYVFdVdDRiSTlBZmdvdjBmTC9N?=
 =?utf-8?B?Tmthbmg2QkZQVjZ2VlVzWVN0dWpaR25kZG5qcUh0YXBiU2o3V2w3bzJ0cWtI?=
 =?utf-8?B?aXdyRUV1U2dldnJDbUVkM0xFWW01TVNiZERPWTE0NGVZQTc0Mk1BSGZIY3ov?=
 =?utf-8?B?Q1VpQmtmdERISFRrQU1Id2VDS20xTHlXVzFNdS84S3g2SVFRVUZ4aXZhRDM0?=
 =?utf-8?B?bURpN21GVUZzR3hrSHFwaEx0R2ZjbXp0WlBULzNaMEtUMHVpVldHWFN0eUdH?=
 =?utf-8?B?M0F5TUMyMCtWNUxEYmhEOXBhMmZDS0xxWjlqdFBjb3JqajRWZU1rcGNya01Y?=
 =?utf-8?B?TS9sVnBsUDcwdWxhTmhzWDdRTXpRWmdsaXRRWTBvUjl3alJ3WU5VcFg4RkQr?=
 =?utf-8?B?QmtOS2pwWUpzbkh6c0laZVRSMVNWbnRSQW1ETW5SeUV1OXdBR0cvbkRXRUJL?=
 =?utf-8?B?SHMwdm1qZHh3d2RrdlpMa2ZYUmtaWVZGNmNpOUR1VHZDZlB6bkVoaXY5NFRY?=
 =?utf-8?B?QUkzOWRSOWxaYnBCWkhzZEE4T2o4Z2ZUbldxVDZXZXFiODFhMExNeG04azRG?=
 =?utf-8?B?YmE0a2xNanpWY0VBZlJOVlFaTWt6VElrb1dsQ1k1dFk3bXFBRkZiQm5JUCtz?=
 =?utf-8?B?L1hHWW9kbzhLSkxVbE51YUhZT2tJaUhBY3UyMGFHS29RMWpDdlFkWnlwNUti?=
 =?utf-8?B?Rkw0N2RNcStKdWtZT253bldnTG01dWljbHpCQ0d6TVE3djdEZFJhaCtCNzBF?=
 =?utf-8?B?V08vV0k4K1l1SFlSdUJmZm1KL0R5ZE4wQXEvVVdWMGQ4UFFraE9sRy9jOS9u?=
 =?utf-8?B?WUhPRXlCNHp5Q2FRcWUrNXp0MllWeDVCcVFnZkxKdkFkNFBYOW40TWxPUTYz?=
 =?utf-8?B?RExkdHBaNUVMNU5jZVpXOE54NXk4U0ZTMFVXeXJsODNRM3A4WnBVQ0lKckxr?=
 =?utf-8?B?b3BNdkNDZEREZURUclZpd212TzdJc0YvekNaY1kyNlV1QS94QTBhUTFrckk3?=
 =?utf-8?B?ZXhnRzhkbWRIMjFqRll4bWMyMUNBVjFUNW5zbXFUTTArSXNrTkZNU05WT3lu?=
 =?utf-8?B?VHJqYjRiQWZ6Y3ZIWTF0Z1VpRzA2QkkxQTJpU3NicWxQa1Q3TTJRSmluaUZn?=
 =?utf-8?B?TURwKzRobVBuYUY1b2NMTEYzc2lzYzFIZ3JxY0hZT3pIWjNaRHJBRURUNldk?=
 =?utf-8?B?MS9vV3paOSsxc3ovdUpRUkVNeWNyR1UzcFN5OWVtaE5Cd0pFUWIyZmM5M3Fo?=
 =?utf-8?Q?tqBy9oO9gbOmbUwSRc5q7Jp2DQprY428?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cVNEd2tiWVlVczR0VWJtczUxQ2Vac2VBK3MwSnMyOWIwUzBNczRDYXp0aGor?=
 =?utf-8?B?RlFkdWsrTkovYk1SQ3NxWjdHMm1ZREFVMWR0bGV0Y1Rxa1pFK0xBSkU0SCtG?=
 =?utf-8?B?SFNLSkRTbHNtbmt1S1Y3c2RNOFdObFV2KzdIbndrUlhwam1yVENDaGkwYm96?=
 =?utf-8?B?TXhiRnMvTElmSndyV3haSExObGtNTXFZSmgzNzNwOGd1RWxIeXQ0bXFXZW9M?=
 =?utf-8?B?MitWVWNnTFR3VVUwREx1TTY4eFA2V2pibHVRcnJpNXZ4cjEyaDE3U3JkbTRC?=
 =?utf-8?B?UnZkUmovQzlwN2lBNGI0SnFtNElLTEVaY09tNnJJMDVXK0g4UDNzZ1NGVUVH?=
 =?utf-8?B?bWJVWVBzTkVaMm8zeWdVeWkyd1dUSnBOZjFvYURnZmhKclpTOFk4N1R6NnFm?=
 =?utf-8?B?NmNiSWVnQUpqNHVQQktjTDRram9QS2hBVnRBdjl0aUd6UklWOU9FNTV5N1E5?=
 =?utf-8?B?WE56RCs2Tm9WcmhKb0lyclRBOXJ3Um5HZVpPa1F2OXF3OXVOUGVnN08xZU42?=
 =?utf-8?B?dGFhSkFvUkxvNEdHc2MzYUI3SlFYazlTd1Z1WGdzVWxDVFVZKzVISmswNC93?=
 =?utf-8?B?YzdHU0JhU0FMRVpPZXhvaGpZUWN5Y0FyRml5MnhqRE1DN1lmL01xSm5aUkVq?=
 =?utf-8?B?QnQxallySEhMKzhiSUlhbSs0cUVTcHE3elRFVU9qa0YzU1NuQ04rUGN6OERB?=
 =?utf-8?B?OExla0xWMEIwTmRrekRoUDdscG5TYTdwakpjSHNEdnJwOG9Ob2RpdkpYN2Q2?=
 =?utf-8?B?STZ4NkZDUFpBdVZIYmVueXViOVRVT0hSejRoNlM0V0VENlpLdHBXS1kwMHJI?=
 =?utf-8?B?cktpdHpNK0xubGs2Q2VtMGdRd3NxQWgvb290N0ZxUHFaU2I0WVN1bURDaGNL?=
 =?utf-8?B?V3B5b2JlbzNHR0R4ZlZPRjZFb1RGblUxa3U1SVRNYWJCYnhPSTY0aGhxclZS?=
 =?utf-8?B?SDFhZWpaMGdCMXR6a1ZMeW8zVGd1K1RUZXB6Mm5SUEV5a21hNDNNdzdwZ0FM?=
 =?utf-8?B?KzNsaVUxcEJnM2FmRHNzRGZqU3NKZXZEZkhTc0luWnpDUmRmQnhIa2xxYzUv?=
 =?utf-8?B?Tnc2ZS9jTWRrMit6OHQ1Yjc2cGxSYjI1VE95V0JwQ0JwVEg1S3ozbE0xcEtL?=
 =?utf-8?B?Rml2VzlzWVJCQnNTall1T0x0bkhYakowQXhaSE9LSXBtSU1LbVM1cDYvcW5l?=
 =?utf-8?B?ZE1IaDVxRXoxK05Za3ljQnNRNW0wNklHRVlydm5sWXVvNEZzYVEwRlRiaUR0?=
 =?utf-8?B?SlpUb3lsNTJsYVE4MEg5OHJpQUdKUVlwb20xYzRQZW9HUm9ScC80ak4rZzJn?=
 =?utf-8?B?M2Jsc2o1MWtGeEZNUWZvZjJXZWN5U2w2SmxMZEFIenZxNUpzd1lMOXR6OWs0?=
 =?utf-8?B?Q2c3UkRwTlllYURaUXArUnE5NXFjdHdyZXFqenFBNEZXa2I3SDJ0Y21mOEVr?=
 =?utf-8?B?NFhVc1dteVNtYnpPclNTY0g1WVQ0WjdlN09GcExGS0hNaEVhYVFTblhBYVVt?=
 =?utf-8?B?SEZCLzJseVV4MVdLVVBHY2V0THVtY0orVHkvVDJtS0NpUzBsS0VoWi9LRGZt?=
 =?utf-8?B?S1FSc1ZjdTNmOXlrUnlEWWI5V0RJR0ZJeHcrZFRZU0U2d0tEOGRnSFlkZVgw?=
 =?utf-8?B?SktCTWxBaGJZSFVMajJKdUplWGZuUzI1eFppR2IxZGRoc3F5eGVtTk5VdnNB?=
 =?utf-8?B?RDRwbEpXcUlQSVFPTlRkU2NTM2M5blVFbUQ3YVI0SlFQMStHcEJ3ajdySXdU?=
 =?utf-8?B?Tm94RU1nT0JSTlM2cER4aXZEdW44dHRxUkZ2RzlrTDNBZ0VGWXlhZXFLK28x?=
 =?utf-8?B?dDlOMlBHUG03dzQ4ZDFhbUpleXU2NEVOb3V2MFdZYzJCc2dXL1BTZEx3aW1I?=
 =?utf-8?B?YXZ5djNYT1cvcGhWbmZNendvclNhb1ZqMnJjQnk1T2lWMlQwYXJuWkRMeHZv?=
 =?utf-8?B?THFVa3JpaUkzY1M3aUg3bS82VU0yQmE3UHBpQ1RuTXhmSXJMWUZoaHo0NmRU?=
 =?utf-8?B?TDlGa1FyNTFiZXN3MjR3Y1VjMFNSYk40N3ZMSUpNc0MrTXBIREFIdEhPSjZv?=
 =?utf-8?B?MzZSTlp0R1RiZzdhY1lpTDdpYTc0MkJ5ZVNWdFZJeGNUQVE2bFhrS0xoMFB5?=
 =?utf-8?B?dlJuYytiMitIMmtGYUNqSDB6akZESDNCSHRxRzZqeFd5TUJzdmVMY2FIT3c4?=
 =?utf-8?B?VWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7499d35a-dfc8-4ab1-859f-08de275e4d77
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2025 11:25:11.9322
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nBjXAQMcaqLW+rjQySReUmOVMrJsqZUAaZo6kyIlR/0Kf1AQxKG+ToWSqfj9ghC/QtzM4jo0yMxQjvBm79e2NIiTJ5+bvjXBkv2/DhsHzqg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB8292
X-OriginatorOrg: intel.com

From: Dan Carpenter <dan.carpenter@linaro.org>
Date: Mon, 17 Nov 2025 21:11:44 +0300

> On Mon, Nov 17, 2025 at 03:37:30PM +0100, Alexander Lobakin wrote:
>> From: Dan Carpenter <dan.carpenter@linaro.org>
>> Date: Mon, 17 Nov 2025 16:11:32 +0300
>>
>>> On Thu, Nov 06, 2025 at 03:07:26PM +0100, Alexander Lobakin wrote:
>>>>> diff --git a/drivers/net/ethernet/intel/ice/ice_flow.c b/drivers/net/ethernet/intel/ice/ice_flow.c
>>>>> index 6d5c939dc8a515c252cd2b77d155b69fa264ee92..3590dacf3ee57879b3809d715e40bb290e40c4aa 100644
>>>>> --- a/drivers/net/ethernet/intel/ice/ice_flow.c
>>>>> +++ b/drivers/net/ethernet/intel/ice/ice_flow.c
>>>>> @@ -1573,12 +1573,13 @@ ice_flow_set_parser_prof(struct ice_hw *hw, u16 dest_vsi, u16 fdir_vsi,
>>>>>  			 struct ice_parser_profile *prof, enum ice_block blk)
>>>>>  {
>>>>>  	u64 id = find_first_bit(prof->ptypes, ICE_FLOW_PTYPE_MAX);
>>>>> -	struct ice_flow_prof_params *params __free(kfree);
>>>>>  	u8 fv_words = hw->blk[blk].es.fvw;
>>>>>  	int status;
>>>>>  	int i, idx;
>>>>>  
>>>>> -	params = kzalloc(sizeof(*params), GFP_KERNEL);
>>>>> +	struct ice_flow_prof_params *params __free(kfree) =
>>>>> +		kzalloc(sizeof(*params), GFP_KERNEL);
>>>>
>>>> Please don't do it that way. It's not C++ with RAII and
>>>> declare-where-you-use.
>>>> Just leave the variable declarations where they are, but initialize them
>>>> with `= NULL`.
>>>>
>>>> Variable declarations must be in one block and sorted from the longest
>>>> to the shortest.
>>>>
>>>
>>> These days, with __free the trend is to say yes this is RAII and we
>>> should declare it where you use it.  I personally don't have a strong
>>
>> Sorta, but we can't "declare it where you use it" since we don't allow
>> declaration-after-statement in the kernel.
> 
> That changed when we merged cleanup.h.  It is allowed now.  I still don't
> like to declare variables anywhere unless it's a __free() variable and I
> think almost everyone else agrees.  The only subsystem which I know that
> completely moved to declaring variables willy-nilly was bcachefs.

Oops, seems like I completely missed that.
So does it mean we're now allowed to write code in C++ style:

int a = func_a();

func_b();

int c = func_c();

?

Anyway, I have the same preferences as you: to declare everything at the
top of the function (or the scope if it's a loop/if/whatever). And
didn't plan to change this :D

> 
> regards,
> dan carpenter

Thanks,
Olek

