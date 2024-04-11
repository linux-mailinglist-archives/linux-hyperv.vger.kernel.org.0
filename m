Return-Path: <linux-hyperv+bounces-1957-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 19A5E8A20A8
	for <lists+linux-hyperv@lfdr.de>; Thu, 11 Apr 2024 23:07:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B5ED1F22317
	for <lists+linux-hyperv@lfdr.de>; Thu, 11 Apr 2024 21:07:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 422222BD18;
	Thu, 11 Apr 2024 21:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fw4ho/Z6"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DBD0524C;
	Thu, 11 Apr 2024 21:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712869659; cv=fail; b=tT0dFXIeJJRpuO781Cgng85leQAvCg++R8bOY5qlL5hBn39uFW+hsl2ncGLcfIQSB6EEbUiJ/KVUB2HCdyumtvIIjpnJgRa6VlYq0X8pIoUfpkQezKCVSO3M5TROZm/s/sXpmB+ZGbYHuIEg1ypTIL4kMca58jamBD8FNKezOiM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712869659; c=relaxed/simple;
	bh=Xcj7btabx4KX7uXrhQm1m0Dg2JczB2tr8Crmhr7YwUw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=IZkWRAWMK4Wa2xPLY8fYn5Dnp+uqP3uS4eVhcUXksoQA4rSzRt84FEh+bpJJfaWbGeTJYocjRkeCu3zQ+rgTKL8MtGgQ2sDUJn5iiZRMSJ5V+3JowU5+a4dS/KWiS4eEUt6vFu1W6VwQutJSaKsP0obefoc/xs/HvQFbC0eMLIw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fw4ho/Z6; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712869658; x=1744405658;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Xcj7btabx4KX7uXrhQm1m0Dg2JczB2tr8Crmhr7YwUw=;
  b=fw4ho/Z6FNGcilIxyE0xFY6LS31VrWJwZ4Pi0IT97ohQ71R0Pib4zPAT
   ynw7ecU8zXTJlqgpA0OG/UbM4wJmvryrJpI4kp0FJZKvzyfoxKX3LSO2P
   D2xucZoCYJMz4oQoPS8n6ca4ZAEPqxdQJGTT3OoqQ7u+XFtRN6SvToZ50
   gSKf5KenMLkp0CsYCfp238NNQG0irgZj6W/rLhbtx3+BTHrs+MnFEJbwA
   riv09oqjeh+EVBUVTkRM+dg9IZodmKBXxDxNXYHMDsb7XA6JPFW17T9CC
   eGDaevlU5wYk/mhTH/Os5PXqAS9KAXuN6AzYVVEOet4vIrxwdeXx6GQpL
   g==;
X-CSE-ConnectionGUID: Jw3U8GF4TRernJMdW6kPaw==
X-CSE-MsgGUID: K06Rm/KPR4WQzYmUpLDo/A==
X-IronPort-AV: E=McAfee;i="6600,9927,11041"; a="25820369"
X-IronPort-AV: E=Sophos;i="6.07,194,1708416000"; 
   d="scan'208";a="25820369"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2024 14:07:37 -0700
X-CSE-ConnectionGUID: DeD+wBSbSOK4DplCAoIWRw==
X-CSE-MsgGUID: BqOXIogWSXmHmN9hzXIBug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,194,1708416000"; 
   d="scan'208";a="21094144"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Apr 2024 14:07:36 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 11 Apr 2024 14:07:35 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 11 Apr 2024 14:07:35 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 11 Apr 2024 14:07:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eLyodch7mBZ/yo9m1WEOLWE3csK2uR5OTGFA6uScktbdVYsKPp2TR5dX0iAoIM5BbxCAxiTnzum3IwxnmSqbetDDwmxrz/bkedpTlD7BEKvm4JXCrcli56SUlWiIVy5Ttd9YS14azQRbZ/5w8FO17McK86S4/G19N1ejG7SyDYIYE46mO5S3dxHtHqCwuzeOOlbWR8m0py7yTI6DDf0wRy2lVPuu18sK0gQQoPQOnj5GN7fCF7jZmHn5U5ZMLk4a5lj7gg7vWyJo6Z4KWnNy296J7Mxccr7ZXCQXWtB7OqXJ2U1kyzaLPndwMoCGZxbi0v5HZeI5z1Uky2urDh1csQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xcj7btabx4KX7uXrhQm1m0Dg2JczB2tr8Crmhr7YwUw=;
 b=nuYNNGLV23ylRQC5k8KdXjuzHnOm6EDpYyFWAtxLelI3GfhRqcFIo1q25cQJEMB1Z0rU2OQt2DS/pEnTih+LnjYEE7lorVUw66RVc7dc+6iFHf8DWyNEmDiV0BTwNLmbibqj6hRFe+ZWwYTxUurfGFI/4pKQ/j7ScxJYevqFqJsligONe1S6qPgvUmJ7GoYLvb4d3uM+YB6gxJIaVHO9EZOektSiRcEzneG1MJJ5qeX1fJ85Rgqk1QZ/u2gbpIyyJYHaF4gHdQJYIvKXdbVHSxdhSzJgmpPKQ6cNFyFf60y/wobiKAQEAMFs/K+U5+JTy3fO39i7pVEuuswAedHBnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by PH7PR11MB6932.namprd11.prod.outlook.com (2603:10b6:510:207::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7430.46; Thu, 11 Apr
 2024 21:07:32 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::1761:33ae:729c:a795]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::1761:33ae:729c:a795%5]) with mapi id 15.20.7452.019; Thu, 11 Apr 2024
 21:07:32 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "mhklinux@outlook.com" <mhklinux@outlook.com>, "wei.liu@kernel.org"
	<wei.liu@kernel.org>
CC: "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"davem@davemloft.net" <davem@davemloft.net>, "haiyangz@microsoft.com"
	<haiyangz@microsoft.com>, "Reshetova, Elena" <elena.reshetova@intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "edumazet@google.com"
	<edumazet@google.com>, "kirill.shutemov@linux.intel.com"
	<kirill.shutemov@linux.intel.com>, "kys@microsoft.com" <kys@microsoft.com>,
	"Cui, Dexuan" <decui@microsoft.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"sathyanarayanan.kuppuswamy@linux.intel.com"
	<sathyanarayanan.kuppuswamy@linux.intel.com>
Subject: Re: [PATCH 0/5] Handle set_memory_XXcrypted() errors in Hyper-V
Thread-Topic: [PATCH 0/5] Handle set_memory_XXcrypted() errors in Hyper-V
Thread-Index: AQHac89/N1PZD73ZukStjMBUWTyM3bFiNhqAgAGKz4A=
Date: Thu, 11 Apr 2024 21:07:32 +0000
Message-ID: <06d7a7c8163ab23937680a7d51f25306b2f758aa.camel@intel.com>
References: <20240311161558.1310-1-mhklinux@outlook.com>
	 <ZhcF44AEkKy0Z0HR@liuwe-devbox-debian-v2>
In-Reply-To: <ZhcF44AEkKy0Z0HR@liuwe-devbox-debian-v2>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|PH7PR11MB6932:EE_
x-ms-office365-filtering-correlation-id: 5b3f2abf-2a40-4d7e-451f-08dc5a6b677f
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zM1/Q1W4mUBTIURXZwU7zEmx6/86/vmUm8zcUht42F3QUfbgj2QvblC7769MOOblmwtACcnmlkoyJlR7+/b1JBQkKeC8c0kXqPid2foyU+wVVJoLR1lPeguBL+smugYkGH2BSgU+MVQ0NiyEhmWEQ1HRPQfMsufs4c+9AOiZ0i/uff9ACooXS9IELHoiuPMS1gaeRNbPUvOACQ+pPO1vWHXTYsz6b0XyqQSGMOgfx2gSGYEC44AqcRI2oygRZkGQD8ifB5Nd8DRz64gnUc/R/NPG+2hxLNJIpBjKBmcVaCbrmdk6//FXg2BLpM18TogWakDcRznTtdRrpGBCkS2/1PbJhXGvms4O28QoUso0Po7gfXxifDeOEV7Y6iR0REG3oJrx/K13HycTb+ctnWnm72xkenQ3pPSMiPs2ym3B8VtAYeaGG/A3pkhlmMkeRWJkFEgvCjpeuOy6FRbfrTnicpEtXZpU0WeSvJMcSy95kuKeZxhveqzvaTv0Pcnl3j6whz90kB1lcttulMPjNJ+rl8GRZlQRBjlJpTFCJ/CND/30eO5U7YxEF288wUHJ4J5dNI0L+mBBtMtEuTmiUeeyMXF+GJelhLFikEtQ2vGJm9eMXMiFGjGxLobCG88GArj7otgPLndyM7GWpH0z3+nJTfqaZBanmH/ULQw17PoXycz32bvUI1XAtA7JrZxLN8H/0CRInDNao3uUycI0EzXU9En2hK+RHPS3XbjS6l3M43E=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(7416005)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TzdSU0x0Znh1T29IQUU2dSt4akFFeEVjNVlYOThkMmw1OEJhZDJibHBNT2c3?=
 =?utf-8?B?MEpzd0tDMlNHZlg4czZJSW9Sdzh6SnpsN29vQTU4T2JzVnF4U1dTZDdkeHkx?=
 =?utf-8?B?U1pYUlJIU1gzd0EvSUxzRXA2cUowWEJKUFpYTkg1L1h4dFFVaGpiYTRYaSt6?=
 =?utf-8?B?WWFJbUMzay9pcWx1UW41WFRNOElOSEZWeWZQMjNTeU5aMUNtY2h0YXVqTW5H?=
 =?utf-8?B?TjFpNjlxOFZQMndEampCRzFZMzBWYzNxaVRWdzAwZ24rWkVPZ0VLb2dnbFpW?=
 =?utf-8?B?akZFN2xCdDMyWGp3T0ZDTHA4QmFtYUxtMmNEeERFTG04T08vN2w0ZnBQTENE?=
 =?utf-8?B?bWVVVXAyL3NvVDIvc21mZGZMOU1RenU3OG5nZFVxbnR2bnNTUTUraCtNc2Zv?=
 =?utf-8?B?QmJKOWY5cE15TEhnVDhwclZCR2ZPWUFTL3UrTHVORlByd21HSXh1ZC9KbVBp?=
 =?utf-8?B?ZGVYSkNCRjY3bUozelc3cnlwd29qTFI0RElTaFFtaUlON0hnY3F3VGpRN044?=
 =?utf-8?B?TnUraG01NG5CSWZuUEN1NGlVd3RTRG1VSXpGbUpXYldUY1VYb0UvS0p6dnpp?=
 =?utf-8?B?TjQxVkZCeFhTL0tFd1o1aVFPOE50cDB2SzRNM1l0NWN6TG1VNmdBYWhVMCtG?=
 =?utf-8?B?cFZza0pyZDIzRlNCdVczQ2o3T0lyT3NxMW5pK1pGbVpVeTB1R21odUlkempv?=
 =?utf-8?B?SWMrUStXRFBaYVFwc2hENXZpYW54VW9QT0tPT1hJR05aU3ZCWERuRHJoWEtY?=
 =?utf-8?B?OGQ4ZkQ1bFpBbWhZT1lPemRnQmFJWDhibGNaVkMvcUVkLzAvQWZJWmc3a2dy?=
 =?utf-8?B?REUxbmdtMzhJVXZ4eE41eWdVRms2NkZIYkN6dlF2QTFrbjVvd1BQYWhJcUVL?=
 =?utf-8?B?YWcyU2NJZERqVVJ1bTJIZGxtTi9lenplbzY4Z3BoYzdjWXdNUU5zNW1JeU81?=
 =?utf-8?B?SWlrTUxtSExBNi9UMFpZd0NMdUF5bWxDcTh4aWx0TkI4U3Z6N3haOWVlSzQy?=
 =?utf-8?B?SE5tYlUvNHE2N2dROEFhWXZGSWhiUFppNzM2WWFmWDkyM29SeXd4Y3d3UUlE?=
 =?utf-8?B?ZGdMVUJqUUxHZXZZM21acmNSNDAxNS8vbXpJaGQ1QWU2dEpOTk10ZVJVU08v?=
 =?utf-8?B?MTc4cTc2S3haOGJUVjdzaVhLVjFsZ3RZTzN5UEttdjd4ekZadkhIZGl1emRl?=
 =?utf-8?B?dkNXV0d5dDJSdW15MjByZGg1RnhzTzlXY0N2UTFBeGdoM2wveFB0dkxOMnls?=
 =?utf-8?B?eDlCOFBkWG9JUGM4dnFLRlNzdG1sM0RwSnFhQXNFOXdJVFRhUEJyUjVHajBN?=
 =?utf-8?B?MjczejNNazJqZVA1M3lndUErSUFPelgrTmdrbGFHa1FZZkFDd3ZiZ0VpVUU0?=
 =?utf-8?B?cXozVmJISk1ZTHd1WHppTHU1VUJaVUJCK1hTbmk2dnhNbzI2NTV4V0RRR1hu?=
 =?utf-8?B?TDIrRzNVN1Z3SER0RFhaRWVMeUFsSW1rWGZoQ2VYVURZeG5EcEl3U2dDMDJ3?=
 =?utf-8?B?Y1cvRWx2MXpYRElGTXlPNFhzbUozUUFpOTdjWHJMSGQwY0tubFB4M0huK2hU?=
 =?utf-8?B?dUdTY1pwZ2dtd00wajZUamhRUmxvYzMvZWRpakR6V01QbmVHbFJpM0JNaWtp?=
 =?utf-8?B?WE12OHNkSTcrQjd3bjhiRTh0bmpqeHlmK29CNkowWkRUWjd6Y0RMcStMaWFS?=
 =?utf-8?B?dXYyb1N6VkhweEZRTUErWkVoQkJUaUlxdDZWR3hkSnd0TEo0OGNmQ2owMXYw?=
 =?utf-8?B?RENlQkVEVzM5SXB4VVd4VThWZXdRWUFvaUFIUUtFdkNyVkZHYzJVRkpuQjNx?=
 =?utf-8?B?Qzl6Z3FiZW5QL2JLbXREZk5yVUVrc0x6VWV4SzQySml3L0xhYjVLTXVUUldU?=
 =?utf-8?B?NjZNTmJ5OUdiS1hMREFpRE4zaHNYMWRReHhxcHhTNDh2bDJOTVpEVzdQSUxs?=
 =?utf-8?B?d2xvdHMyVUdENkxqaldRN1JuNUhoSkxsVXRzaWZJRlllenNpbWhMR0pCancz?=
 =?utf-8?B?V2hzZThFZE1Pd1BwUTYvSWZUUWhsaDhpd0tJQWlkK0lMWVM2RTdXdzkvNVVl?=
 =?utf-8?B?RXpjb3psUDdiNXVvTWNFUFJyb0IxcVBYckZRUW1sOGtlK3RteDJwa3FnaGho?=
 =?utf-8?B?UW5rajd2aUEzUm1qWVhBYlRNR0tRZy9tUFZNOUtqNEI1TlVuRE53aHBrdnJZ?=
 =?utf-8?Q?m32cHxwlhWUoFoEe40tm3lw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <ECE95BEBD5D37548B9B4F55220DC6106@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b3f2abf-2a40-4d7e-451f-08dc5a6b677f
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Apr 2024 21:07:32.3842
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rfWDcDplmzb95PqWK+pb/RsnrwVw/iUTcNranCNB3RGjm6i3whlpkQXKtopWaUniPP7lY689tFMlytMM58kURVP2O9S86hFny7aUzZdndtc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6932
X-OriginatorOrg: intel.com

T24gV2VkLCAyMDI0LTA0LTEwIGF0IDIxOjM0ICswMDAwLCBXZWkgTGl1IHdyb3RlOg0KPiANCj4g
QXBwbGllZCB0byBoeXBlcnYtZml4ZXMuIFRoYW5rcy4NCg0KVGhhbmtzLCBhbmQgdGhhbmtzIHRv
IE1pY2hhZWwgZm9yIGdldHRpbmcgaXQgYWNyb3NzIHRoZSBmaW5pc2ggbGluZS4NCg==

