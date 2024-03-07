Return-Path: <linux-hyperv+bounces-1678-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C4128756C8
	for <lists+linux-hyperv@lfdr.de>; Thu,  7 Mar 2024 20:12:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2FC831C2113B
	for <lists+linux-hyperv@lfdr.de>; Thu,  7 Mar 2024 19:12:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F25F0135A6E;
	Thu,  7 Mar 2024 19:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HP7VTMJs"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4461B13473E;
	Thu,  7 Mar 2024 19:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709838747; cv=fail; b=Xs47p4QWkhSlwEvvfrmzi1UIK0w1wDnguAXbmwG581lvdSQF//LXv7h8UTXALzxq2ej8T6L6zirH2wARdtJgAx8emDDh4/iiCwCzP8P9GpjNp/prWODLv2Yw2MGa/BCzgWgsxhd/5cYztM6ppmSoH9XhQFUlClRKzW3oy+38Y3Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709838747; c=relaxed/simple;
	bh=EPBGtHEZe//DeS3fBWSaf0PwoCj7Dun0JFHb4kZvi9o=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hjLN6sHmdJjgMrphWdmi7U4fgPLGF3AZNZRjOm0uFI4buVQ/P8Abz3D2YsUdJW0NE6nuhhccfQRlmpytYPpM/DSzrLjNTS3uKr5Bm2cIHkHR5rYOPICxFzc8MTYoa9qK7tt0eEJnr+EIXkOdsPtl2T5ju4Bp57Og7BUvh7uRUM8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HP7VTMJs; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709838746; x=1741374746;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=EPBGtHEZe//DeS3fBWSaf0PwoCj7Dun0JFHb4kZvi9o=;
  b=HP7VTMJsbMtRU0+kdSKfoVbvJUe0OyPu37EO55ooVMQ7LYE6+CRTGRq/
   DQDbJ8u7VtH6k7BSyjenGqxRZnrDunHgRVCLYDpZ7MIxGTqmTJGMjcBPm
   Wsoyj2dVr+AtiwReNlfX0I/OoRxsgvtSeuFMv6CWgJ+JnJeiPAI6ZyQAY
   CcchBB0ioez4Pk8Og/csI8P9Qb6ZZQut1b6zHSLc4PpAhSAhe4T3F7rtj
   0pOUMt2UXqyjsj8eJtTgeS7faea3VzPolscfVBmg7cbVmZYURmy954K8s
   5NwDfThcM/DSJUic5/+aVHef4tE0M4pikti+hn+tJY7tTCC+sWBybJ6T7
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11006"; a="4650265"
X-IronPort-AV: E=Sophos;i="6.07,107,1708416000"; 
   d="scan'208";a="4650265"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2024 11:12:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,107,1708416000"; 
   d="scan'208";a="10341468"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 Mar 2024 11:12:25 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 7 Mar 2024 11:12:25 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 7 Mar 2024 11:12:24 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 7 Mar 2024 11:12:23 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 7 Mar 2024 11:12:23 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eW0CmZNtDu7tOIfV1Qw/knssC9XrFQzDrlvTo4b2x/bvlEbNDkN+K9W93+X3dAECaOCYXv36CiCb8pIdahYFQgGpyuwIK87hnC3KMwe60CNAY48zgygHFAoDyDi+4XOK+a2+kDgUtbE2WDGORWY8JpO1nhwxH1xGma1oqPNTvmmy6v4Zgrz8zCHellVLHvKCns8JISSvL2xoSKxrp9OnD98HiyXwt5Dm8jPI8ICKYITcC6Fudj0dSoHeDAMrs9T8tssYeEvYTEdRVrpgXFusKDm8GIgaqdrGJvx5EGQVtnV/CouoxL3uZ1GH2G6mqN66RWf7XSAO2D0emoM+TAwk+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EPBGtHEZe//DeS3fBWSaf0PwoCj7Dun0JFHb4kZvi9o=;
 b=CfoEDfTo7QiPWwkFeQ56JgKh585FaMS0qS4VzLkyPMDhyyXGOomeE2lYSLTawpQM6gFpzjXDrTuQr8ZFg84fsXedAelI+kEqlKWSyfHXpVJI0SRQjuNAwjXmP3g0cw4LLqSFBcufMFA4iU8Nxev8bhNJB9miz3ycGhWjFa0MVCTL18WX5vs8255TX+Jx/AtDn48wz/5e+NtYzaelTKaHT3MnyPovc+f6NDrK4v0C6ukTblQDwQ1Ru46rRAVmlyNNb9EnUMnb5TtSlA15yxMiXkyH/LGWBMjS1+E4cl5lrlcbwEowauf9oibCKrfTAt3tTIHquaOKtJ02NlYDDj7qTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by PH8PR11MB8288.namprd11.prod.outlook.com (2603:10b6:510:1c8::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.24; Thu, 7 Mar
 2024 19:12:20 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::fc9e:b72f:eeb5:6c7b]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::fc9e:b72f:eeb5:6c7b%5]) with mapi id 15.20.7386.005; Thu, 7 Mar 2024
 19:12:19 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
	"mhklinux@outlook.com" <mhklinux@outlook.com>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "davem@davemloft.net" <davem@davemloft.net>,
	"haiyangz@microsoft.com" <haiyangz@microsoft.com>,
	"kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "edumazet@google.com"
	<edumazet@google.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "kys@microsoft.com" <kys@microsoft.com>,
	"Cui, Dexuan" <decui@microsoft.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>, "gregkh@linuxfoundation.org"
	<gregkh@linuxfoundation.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: "sathyanarayanan.kuppuswamy@linux.intel.com"
	<sathyanarayanan.kuppuswamy@linux.intel.com>, "Reshetova, Elena"
	<elena.reshetova@intel.com>
Subject: Re: [RFC RFT PATCH 0/4] Handle  set_memory_XXcrypted() errors in
 hyperv
Thread-Topic: [RFC RFT PATCH 0/4] Handle  set_memory_XXcrypted() errors in
 hyperv
Thread-Index: AQHaZTRfFcBcSWU6jESvF40A9Qp/W7EjSvwAgAlPpoCAACG0gA==
Date: Thu, 7 Mar 2024 19:12:19 +0000
Message-ID: <9e12c7139ab5b9b39c73a4069493d8d826b21702.camel@intel.com>
References: <20240222021006.2279329-1-rick.p.edgecombe@intel.com>
	 <SN6PR02MB41575BD90488B63426A5CAB4D45E2@SN6PR02MB4157.namprd02.prod.outlook.com>
	 <SN6PR02MB4157AFF080839DB55294F5E9D4202@SN6PR02MB4157.namprd02.prod.outlook.com>
In-Reply-To: <SN6PR02MB4157AFF080839DB55294F5E9D4202@SN6PR02MB4157.namprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|PH8PR11MB8288:EE_
x-ms-office365-filtering-correlation-id: 76a22ed0-3fa1-4b1f-9d11-08dc3eda82e3
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PhrZ9/sve+O3BNzoXUZEyhMkOcqORzzaFiP3bxWeXrIYYppvgmXqYEK1/bHy7iJhJrpdnBGhGkTihM+IF9rN9yeiNItsWD3wz4glCT0q7sskSFlLi3LM2rYJm0yyLNxG9CFqJeXIUrSp9dyY1U2xReqessXpHQD/TCnvjxxWhnbpSqbyh9RAV8hOIjY3658dwvxxSBG2YyQCaHOm1b7TF1rXb3dAloA6QcgR2z+asGisvzlEuFT1S6OpPw/USfe7aAxw7Cz76MLHf2OoPdAxxRMfzyiGlTkGov5D9b2ROql3x1ZNUh9437iiusa7SzorIqcZA8vd5hjmEdNXcRr7n+CumnjHlYVDT+pbwkGW7QTPGLRPtaipWv/bVhRV/0XdUFO+nEm3g7aS15fag1H0MUcTxKe8Xl+BwYSeF0uVwCmv4zXtbMxclyXK/dXsxtMVRmcwVx2NUiwGaYQW7or5svCKR1EREZk6NB3I87+PhzkNRGUdgde8QZ2tSPtEDmhsMi5EpZ9iExjEmJPe4TyRE3ibwJGh9tV52HIkVtO4gP2+zTP3ttLfjD0Z3p2XJWurOG+V10odeStBwplKZ4c2JEn71CfrryAeZB3Ta0ddBcEzUa6HEytgymR93PDdIOdj80ywyqfRl4+fzFTFy0p+qG6DrXa9EpiSjTDcm3HwRKLBxGV4O+3qdXtOTzsN919AhuHQ0AZ/FR9ShEIzBM+h/YZglIfu6wu7t3aLMswwKbM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(921011)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RjFMUHRoS3I2TUVIQlpoMWdxbkp5Qi8wbERJbGFmZVZXK3hpazdvRFEzbzIz?=
 =?utf-8?B?YVVLQ3U1eVp1UkVVbW0yRmgwNkV6UFJkNTJIanFDWHZIUWV2UVd3R1hDaGo2?=
 =?utf-8?B?a1N4RFVaNGdPZmtPNmYvSVV3bXlEdmFmTmQrciswRUxybThnRXprOENCNFc4?=
 =?utf-8?B?QlRjNkJQQ0JsZlVObUZ1MldmeUlzRnBhRnRNRHhpeG1sMlpNOW9xcGJ0TklF?=
 =?utf-8?B?bXdWS1Y4ZUE1QzlLajBNV0VvLzQrQmRPRGU2WXhlQ014OXkyM25KNHBnL3B5?=
 =?utf-8?B?N2VUeW5RWmhLVFZpR3BNZkxRUm9DR0IyMFR1dVdKd3JXdk1zb2JXMHROV05t?=
 =?utf-8?B?YlNaN2RuZlJzeEFRdy91VkdoMmI1enBGOHZmMXRWL2RvQlgxTnVkMDNzSHBU?=
 =?utf-8?B?K0VCMjBkSTd4T3hackxxQ1Z2VzE3SjVBNE5RWFdGeEtYNWFLQUR1NDR3OWRr?=
 =?utf-8?B?RVZUQU9mSUtiZlNwK2JVSlhBbndic2ZVaHhVdlEzd2o5OVhPRjZpNzhydDMr?=
 =?utf-8?B?SFVGMnh4N1hSNzg0V2hjL3RiU3FvcW9HbWtlck13cURCaHNQbXdiQ1BvbHUz?=
 =?utf-8?B?M3FFU1dyMGdsRlhiK0k4T29LUy9rS0lPbzNaQm5UcVZhTjl5VWVzTlpnTlhC?=
 =?utf-8?B?MnhEajhVVkxSWS9Id04zOHZIQzl0WVZTbVBzWUkweUNSb2FRdGtIZUZKRmEy?=
 =?utf-8?B?SEVXNGZVdmtNSDhBVTU0Z045aFJTUFNyVFVwOEhaZk1QbkdTVmV3RS83NVFE?=
 =?utf-8?B?alkxdlBDeWtnbUdnM1N5WmtQajd3MmQxM3I4K1JaNng3a3FMSFh3bFJyZ2lj?=
 =?utf-8?B?T2RwRGZ4aXZVck50dDgzZXc5aDRJK1haQWE3VkpHc1hlMFJOVzNZSFNXcHdR?=
 =?utf-8?B?alc3cUxDVDV3RDJUc20yUFBJcHBoMzBsUWIrUVl3SHdpbmw2UDk3b2RlVHl6?=
 =?utf-8?B?MC9qQ1NMTUNwRjhGSkRoL3VUNmUvSW9KMWhsSDdxektqOWJ1cll1VGpGTDln?=
 =?utf-8?B?Q0xCQUhoQm5KZmliSUZMd2xMQlByRFpPN2ZZLys3TFozQ29UZGdYeVl0ZFM2?=
 =?utf-8?B?akZmWjJjRFVBV25qajdhWGpVbGFhWXd1a01WMmFEQ3d3czk3ZjE3eEE5eC9S?=
 =?utf-8?B?dXoxVkRRNWZMazVPT2o3WGMwSHJGdTRJVG5oZzYwUWxKY0h6ZkhLaEJ1SXkv?=
 =?utf-8?B?dnNnUnd1dDEwSDloZTRTWjV2ZFZPSDJPbXBBVG9PVk1RTThFNDZjQmpCSUE3?=
 =?utf-8?B?V3JhNWd4eTZkbnN0dXAzYjVsZHNDV2NmVlF6ZC9zOElZd1pCVHBtckkrTElx?=
 =?utf-8?B?K2tLcnI2WkNIbnFxTHlTVERpNFE5U2E5SDBFZ2FoMkJJL1VCKzNMd29oWlJ1?=
 =?utf-8?B?WnpvSFV1Y0RHUzZjUjVVQW9lQXYwM251N0FSa2tmb2xreCt2dWhPbVVjRmlW?=
 =?utf-8?B?b0g4Yld0SVF4MEc4YlMxWU1kUUhWK1ErZXhHNnM4WXppK0NPdzBoSUZiaFJ0?=
 =?utf-8?B?RERhZ2RaeldkaHB4OW1ibVdLNDZ0RjE3Y2NHV3A3dUxrSHZUWTRtVGxIWm5s?=
 =?utf-8?B?MzRzVURMcFVxZHVEUEJhd1RIMHNtY3NyNXdJWU02dCtTc0lCa2VVRk10aERs?=
 =?utf-8?B?NG1xd0NmVnV1S3RTRU13bGxpalloRTUxTGpPbnBWUlA5dnFGR1czOGFXRFE3?=
 =?utf-8?B?WGZBanRPNEZJdFRjTHQwODZBdlRWSVFFbDdQV1lSNHFSd1hPUlN3Y09yeXdC?=
 =?utf-8?B?SktwTXJkVUU3YnVhclVmZklmWUxQL25PSklWN2srejNaSngyVi9oUUN5Ny9m?=
 =?utf-8?B?VnZjbmhhclFjVS9IM2wxVVNsK2VzL2liZ1FicVdtR0c4Y2V1TVN4bU5nemRI?=
 =?utf-8?B?K0x6S2ZCa0txZHRPY1duV0M2WENCeFdseUk2VERyVzVCMnNMb01NNFpxTGlZ?=
 =?utf-8?B?Y25zU21LYW80bjIvd1JNcFpYNVI4QzJVRVp1eE54K25IVjdTWjNGek9MSW1P?=
 =?utf-8?B?NHBDcVdMTURWMkpxT0psQ0NQVndZSm9WckVkVnZINGVlb0syYzk4UWpYems4?=
 =?utf-8?B?dE1SU3RZRFVuM1Z1OTlxcDhlYXVHMjBRU1M3OVdOTHliZkhQQTUzTmxYSlZV?=
 =?utf-8?B?TklBdXlMZHdsb2VDeW5LYVVtVWp5QVExOHZRNEh6NVBaWGtYNmlySDExOEJW?=
 =?utf-8?B?MFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C5E2BD08422430428C4222110ADAC0A8@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76a22ed0-3fa1-4b1f-9d11-08dc3eda82e3
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Mar 2024 19:12:19.9060
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fb46jmAIaRP4FlAgeI+nVZTIaZ6qJ/yy/Sq/WGcc5iJyPRKCkDvQQ3obR/bPbhoie7ytpOk1IFCk0nq9Qv0z/TWyoF5X7bHDhxbAOZYS0ew=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB8288
X-OriginatorOrg: intel.com

T24gVGh1LCAyMDI0LTAzLTA3IGF0IDE3OjExICswMDAwLCBNaWNoYWVsIEtlbGxleSB3cm90ZToN
Cj4gVXNpbmcgeW91ciBwYXRjaGVzIHBsdXMgdGhlIGNoYW5nZXMgaW4gbXkgY29tbWVudHMsIEkn
dmUNCj4gZG9uZSBtb3N0IG9mIHRoZSB0ZXN0aW5nIGRlc2NyaWJlZCBhYm92ZS4gVGhlIG5vcm1h
bA0KPiBwYXRocyB3b3JrLCBhbmQgd2hlbiBJIGhhY2sgc2V0X21lbW9yeV9lbmNyeXB0ZWQoKQ0K
PiB0byBmYWlsLCB0aGUgZXJyb3IgcGF0aHMgY29ycmVjdGx5IGRpZCBub3QgZnJlZSB0aGUgbWVt
b3J5Lg0KPiBJIGNoZWNrZWQgYm90aCB0aGUgcmluZyBidWZmZXIgbWVtb3J5IGFuZCB0aGUgYWRk
aXRpb25hbA0KPiB2bWFsbG9jIG1lbW9yeSBhbGxvY2F0ZWQgYnkgdGhlIG5ldHZzYyBkcml2ZXIg
YW5kIHRoZSB1aW8NCj4gZHJpdmVyLsKgIFRoZSBtZW1vcnkgc3RhdHVzIGNhbiBiZSBjaGVja2Vk
IGFmdGVyLXRoZS1mYWN0DQo+IHZpYSAvcHJvYy92bW1hbGxvY2luZm8gYW5kIC9wcm9jL2J1ZGR5
aW5mbyBzaW5jZSB0aGVzZQ0KPiBhcmUgbW9zdGx5IGxhcmdlIGFsbG9jYXRpb25zLiBBcyBleHBl
Y3RlZCwgdGhlIGRyaXZlcnMNCj4gb3V0cHV0IHRoZWlyIG93biBlcnJvciBtZXNzYWdlcyBhZnRl
ciB0aGUgZmFpbHVyZXMgdG8NCj4gdGVhcmRvd24gdGhlIEdQQURMcy4NCj4gDQo+IEkgZGlkIG5v
dCB0ZXN0IHRoZSB2bWJ1c19kaXNjb25uZWN0KCkgcGF0aCBzaW5jZSB0aGF0DQo+IGVmZmVjdGl2
ZWx5IGtpbGxzIHRoZSBWTS4NCj4gDQo+IEkgdGVzdGVkIGluIGEgbm9ybWFsIFZNLCBhbmQgaW4g
YW4gU0VWLVNOUCBWTS7CoCBJIGRpZG4ndA0KPiBzcGVjaWZpY2FsbHkgdGVzdCBpbiBhIFREWCBW
TSwgYnV0IGdpdmVuIHRoYXQgSHlwZXItViBDb0NvDQo+IGd1ZXN0cyBydW4gd2l0aCBhIHBhcmF2
aXNvciwgdGhlIGd1ZXN0IHNlZXMgdGhlIHNhbWUgdGhpbmcNCj4gZWl0aGVyIHdheS4NCg0KVGhh
bmtzIE1pY2hhZWwhIEhvdyB3b3VsZCB5b3UgZmVlbCBhYm91dCByZXBvc3RpbmcgdGhlIHBhdGNo
ZXMgd2l0aA0KeW91ciBjaGFuZ2VzIGFkZGVkPyBJIHRoaW5rIHlvdSBoYXZlIGEgdmVyeSBnb29k
IGhhbmRsZSBvbiB0aGUgcGFydCBvZg0KdGhlIHByb2JsZW0gSSB1bmRlcnN0YW5kLCBhbmQgYWRk
aXRpb25hbGx5IG11Y2ggbW9yZSBmYW1pbGlhcml0eSB3aXRoDQp0aGVzZSBkcml2ZXJzLg0K

