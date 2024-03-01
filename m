Return-Path: <linux-hyperv+bounces-1639-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5B8886E941
	for <lists+linux-hyperv@lfdr.de>; Fri,  1 Mar 2024 20:12:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11D8A1C253E1
	for <lists+linux-hyperv@lfdr.de>; Fri,  1 Mar 2024 19:12:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8271639AF4;
	Fri,  1 Mar 2024 19:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NyubE+/r"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88DC337160;
	Fri,  1 Mar 2024 19:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709320372; cv=fail; b=ZQHgFXbmzQ26Cy8dLGFq3Xx6TLg/Jk2ZLfeG9JyneZxUhH+pxABBr7k7bBSY1sXgYFYIrGMtbahppNqeQJi+altwHAWnQDwMjHcbQC6jY7nI4MWEdJfyacuXpJ0u6r/UDjZQNxoqMA6JbdIGpUCziNwGlQBw4tw5VbrHJC0SiyU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709320372; c=relaxed/simple;
	bh=U1uw9iRJj34v5+TCfMwZSq9NURMe2g7G9Ee6hLeW90s=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=EZbPvBtb/gUEYsMhmJqH4QB7q5qD6LM8mejLQwUDllVhg21vu/PWVXc9Q0Vunx5S9JCCOMDiKUHRDlrP80fT9+sm4rfRj8dZC+lXiIbXKnMggIoJ6NSL4K+SXIIJUrb52z8y4FcDzxMUgIZr72LlgWsJk37U6p8zfoMHtNKXAyI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NyubE+/r; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709320371; x=1740856371;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=U1uw9iRJj34v5+TCfMwZSq9NURMe2g7G9Ee6hLeW90s=;
  b=NyubE+/rFowKJCBdoHV9dhRCP8HTw0s2rUCRIHnUT647M96xw/0Uhxds
   yTkT61jF4wOaNzMGg0Mr624RB7qrl7pglhhJmS5imDU/0icC6jdwcn6E2
   c5utA6hvnGQcIFMo2ooS9FySza6McCOmuwQZL67RDd0a9BYBi65LRqarL
   VnF2gS7hYlMeZLesCsYnow/Bn2OZjOnSZuvBxCEI5iBLUSgaBnFCeUMxR
   WM3B2IVV91HAeUbhBpFJ8fYo/Z2PwpBYGn4SSE0MgROSdOgc8IeAn/+zw
   tOkBehgb3bezeBjerjoSnuOS+nleNe56645SjOnlcNJP+VzwqV29JZ/tC
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11000"; a="14451400"
X-IronPort-AV: E=Sophos;i="6.06,196,1705392000"; 
   d="scan'208";a="14451400"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2024 11:12:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,196,1705392000"; 
   d="scan'208";a="8515587"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 01 Mar 2024 11:12:49 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 1 Mar 2024 11:12:48 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 1 Mar 2024 11:12:48 -0800
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 1 Mar 2024 11:12:48 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GoL91vkJnb/mrhPDJYktRtgJahynEif5bWKm0prb8Rle2Htq57P3NsZcW6CZGzQfxxfuPyFZwn3WGD9Ihd5uN2JxH2Vub0+a4YpCG18qVDwT0FMp9EIFnrK3LmQMO9YsKPi149PRhdAs8e8fcvleYFaMpE74oLxM9yNb+bcvFGdy5HNYnoPat8lbjF7nY7j2WtYOUknGoZTaKuk+iaMW8hJd47i7xMNMeamyt2NcAeg/3+SNfa8rvv98r92y+WmfJjy/fPjW4aHXMBWbT8IONnPcnEA6b/cMkKqy+L6eXs9ZaTY1VQWS7Xi7RlWlmEMlrSpC7BgiVbXsPS/Qu/+FEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U1uw9iRJj34v5+TCfMwZSq9NURMe2g7G9Ee6hLeW90s=;
 b=hIz5t0m1/4s+B4sSbr+9zXd/shybzMCPz6vsuRe/S47Vw7gvVi8av/yLVWdge/zjB8C44c8pnpRPc5IsMLrHU83yBDKcFjYAaf1egdXaztV3Ph9jrtWCVeQ99YcWzCPckJNvDv/QQ7K2bVH4VWxLZi4ksqubPrEWzKPZYuJU3gTL3OGolNckzEI3145i3p5J1cdO/v/OsHpWKds4F0j2L0Bzg0Wntz+YOQCJOlXRdJ9Jp49xZiS0hi7kXwbQtIJ/qIIIyQRE9c4p49LIUMVAYRM9seMmNEQ2sVKliorvxhRg+lx8lVHAgqZgrgDmK1aHT+n5QylhaJBsxOyhzjfOsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by LV3PR11MB8601.namprd11.prod.outlook.com (2603:10b6:408:1b8::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.25; Fri, 1 Mar
 2024 19:12:45 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::fc9e:b72f:eeb5:6c7b]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::fc9e:b72f:eeb5:6c7b%5]) with mapi id 15.20.7339.022; Fri, 1 Mar 2024
 19:12:45 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "wei.liu@kernel.org" <wei.liu@kernel.org>
CC: "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
	"mhklinux@outlook.com" <mhklinux@outlook.com>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "davem@davemloft.net" <davem@davemloft.net>,
	"haiyangz@microsoft.com" <haiyangz@microsoft.com>, "Reshetova, Elena"
	<elena.reshetova@intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "edumazet@google.com" <edumazet@google.com>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "kirill.shutemov@linux.intel.com"
	<kirill.shutemov@linux.intel.com>, "kys@microsoft.com" <kys@microsoft.com>,
	"Cui, Dexuan" <decui@microsoft.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"sathyanarayanan.kuppuswamy@linux.intel.com"
	<sathyanarayanan.kuppuswamy@linux.intel.com>
Subject: Re: [RFC RFT PATCH 1/4] hv: Leak pages if set_memory_encrypted()
 fails
Thread-Topic: [RFC RFT PATCH 1/4] hv: Leak pages if set_memory_encrypted()
 fails
Thread-Index: AQHaZTRaOJgLUchwQE6XetZW57kOZrEiqrYAgACjw4A=
Date: Fri, 1 Mar 2024 19:12:45 +0000
Message-ID: <dc67979f1e77ee7499483ae03c37af3f0ef119eb.camel@intel.com>
References: <20240222021006.2279329-1-rick.p.edgecombe@intel.com>
	 <20240222021006.2279329-2-rick.p.edgecombe@intel.com>
	 <ZeGfTtlx0JOj9gVS@liuwe-devbox-debian-v2>
In-Reply-To: <ZeGfTtlx0JOj9gVS@liuwe-devbox-debian-v2>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|LV3PR11MB8601:EE_
x-ms-office365-filtering-correlation-id: 0d1716a0-38bf-4abd-db82-08dc3a2393d2
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4ERbgO0cSimIm1+WPYhsOw0xVUfrYNt8zFpsHvKUmRWVsxbZkaJoeQRu+LI6GqoASJtnSWGwNZ3EQmbxbRfRqPjMENR7X+rz6oQWdMxSfF8RufsnSzlPDAy7kNg4w5DGipMNKz/vrw/QhxhPc2+iJH+rs1+js8kR++xMAc/qT/knf+6dq7C8edl5/L9r5FzoS7Nje4L2PYcIMqyK1OAZE8VlaZMqrwPx7zGfWPfFJ49/TfiAPOztbURcZRyUG7NDNRXIBqIbVGnqXH4iJZcreAz1ORnmhk+50fBDInHQrJACrN5Z/Urw/rvr9WA14nPrBJ/cS1GB5YwsmsX8BsYNmM9d98QHjMMlSytg2dD10fLU80qv0z+cdCss6pP+pGfyK1klTAlyCfekZpV3Hvv59uKGCGrLHdhvdlaZK2UzOPNoHDPbt7/Qfz2SM0yWK+sx0DdcZp4AepV0hwYWOuvv4xfrqwGsHeBgbek3V5FLMAmTE8FSwOfgs/EtOimVJTk4lht4e1+qIRC3qvPyJO0JbTmGuPj39F6yWHbWuX+/IfUvrNa7231PXdi8ksOodk7/sGEBZDi9XwchFaZQJDVCjyymDsXdJK4zrr7115ByTYOr1jxyFU/LVGKYDh+VjAM4OH1mIol8+6sUhWnpzlyD55/Jg6Fh/GyrmA716LbqwbE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QXJBUUlKWHNKUmk1bjViKzNSTWdhT3c0STFnaWJvREQxeXByeUNGd01sZS85?=
 =?utf-8?B?dHFQV29DTmR5N3QyMWp3SGQ1QzVkYkZNYTRRdFcvY0F6K3VHUC9yWEovWUJM?=
 =?utf-8?B?ZzA3bE94UkZ2RXdaUU1TVWVnSHJ6NGFScFdKcFFnR3B4bTNIZXYrN3ZOMkpW?=
 =?utf-8?B?ZzU3dHp6bjRiUnJub3V4TDgyM1ZkTVdXblRyTmVDaXhCWUlPajMvdThHMjhi?=
 =?utf-8?B?WXlJclhVdXcrYUM0bjVnaFlWU3RianhwbVRkUUIzcElZYWtoNC9Qb0hZYTNm?=
 =?utf-8?B?Q3V3cEZCWUlzTXR1L0RyOE8wY2R3VENwb0RVbU4zd2JWc1RSQm5BcGdRLzFu?=
 =?utf-8?B?SHBnSStvT0VDVG9wWXZMU24rODNlcXIzNDI2UElaWHVhMjZRemhlVmNZV1hI?=
 =?utf-8?B?V0VwMS9vbE50K0Q1MTBKOFJ5M2hVM29GcXhCV3pqU1BCcXF6b2pvWWJ3bzBN?=
 =?utf-8?B?MTMzZU9hLzkvNVkrZk53cWEwa1ExTzNHWW9QQnNWOWlJWllhQ0pHeFkwSkdD?=
 =?utf-8?B?ZW9YcHFiREc5a016KytzY3hNWDlKQjFNcE91MXNjdzJGVWtXa2I0bGpXWlFS?=
 =?utf-8?B?RFkyeUpJeHNXUHM4bkMzNVhxZU9TVHZwWElNVTI3aHN2aUorbVlRc0ErSWR0?=
 =?utf-8?B?SWRxWExDNHk2L2t6SlA5WVk5RWkrVVFuRmI0YnV5OHBDTC9Kbml2V0M5UXRo?=
 =?utf-8?B?VWF2UkNiOHNjb0xKTmFJbTgzdCtMdlUxY2pYVWUvSUZkWG1YNWxCY2xKNERC?=
 =?utf-8?B?NGJMQnRMOGJrREloQlZlMFZwcGo3M1lUWEVaV21nWVdSb0ZQUU5NMDJvME9m?=
 =?utf-8?B?NThhanNHd1lna1hrWHM2bnNCM0NWR0ZTcndtUHMvUlltQTh0b0FiVTR1U2V0?=
 =?utf-8?B?SDlHTTJYQ09PQ3V4b1ZyYTAwVm9kdUE5NGU3M0JkWXJaTnUrUXJKNXNudnhF?=
 =?utf-8?B?dUxzaWMvRytEOWxDY1c3R1dkUHZZQXE5UnBleGtBZHVTR252dGxCY1NwUTJK?=
 =?utf-8?B?aUExUVZDZVdreE80RjJ6K1lJVy83bFpwUHpuVzdXNUJLRWk0V0NEZzRCYmtx?=
 =?utf-8?B?ZW5UNHdsVk43Y3MvM3NRZHRzV2d3akVlYnZqOVN3bnoxUHF0VW5zUHZFMmJV?=
 =?utf-8?B?V0VnczFDcG1HdFMzKzNoc0dkbndNS0x5MFdLZ2FQOUlQTjZkaDBWNmFFVHpP?=
 =?utf-8?B?K1BVS2tJNG5kdk9ZT0JqZEFHZDVqTFo0byszWWpZSDZHR0ZZa29pOUdpdG9P?=
 =?utf-8?B?TTBndTY0TE9RUVlHc04rTEljSE82ZmlReFVxbjRlS0U1dUNlMWNKd2pZSHlk?=
 =?utf-8?B?UzMxaFVQN0o0MnVBRUxSWlRVVS9DdXFPRWFZcmhQU25DRFpiTEl5UVN6ekZo?=
 =?utf-8?B?TkxaWURBWDhzWGJ3MGRpV1QxR3BDKzRnZjI2aGpTUHNyZzMwQU1FT0NDSUt3?=
 =?utf-8?B?YVRXeHVwWWFLOThDYnZUNG8vaFh1Z2pYVThVZXNyY0I5dHU2a0xwSXVUWGli?=
 =?utf-8?B?ck5FTThHM2dLZ2lCcGlwdUV4MmIrOVFoaUtackMyT3hMRFpqQWhqTFQ5L0VZ?=
 =?utf-8?B?OVpadXYwQS8za083Mlo1TkZ4d3d5OUxpSHhkSXhCTW5pdzEzbVloNjdadVJD?=
 =?utf-8?B?d3VKL3BvZ3FicHRwRHMwSTZndU5GRXFlaERXSEtYK2xTRmhVNkUzRHQwQUJy?=
 =?utf-8?B?MTlwZkxaRks2TnpoOENyUzA5WkVRNEgrQXhJTWs3OFc1N3g1K0dleU5uYzF6?=
 =?utf-8?B?TGdsazRxWUVxNmNaTzBiYkpWeVk4M0dFL01YK3JiRWdFVDRhVlIrcUlteXM3?=
 =?utf-8?B?c1AyQS9DMDFxcWpIRUhQbWJoSUxCNkQrRTVsQ1dSSXMwczlIRzFld0h4UWFa?=
 =?utf-8?B?TXYreDJJYXM1V1RYQkplOEJBc3ZRcG5IbW95eHlINjQ2OWZlQ2VOUk9TZDJp?=
 =?utf-8?B?bDBUdVRpbUJ2SERsM05RU3UraGxKUDkwOUdmR2JkQVRvU29oY3VBakdwdTg5?=
 =?utf-8?B?Q2pXSFVzMU5aS3YrV01vV3V3MFpLN0tzTlJJZTJMSHV4V0dtQnNWWkoweUZL?=
 =?utf-8?B?RExCQkN5YkoyQWJzaVU3ZEl2dS9TeDJSY0lpd1ZzUDRDbUM3ZEs1Uks4UVdr?=
 =?utf-8?B?R0JsT2x3RVAvTEExcWlYVzEyZ2E0R1djY0p4NElaWlBvb3pLem1TRlptZ0hZ?=
 =?utf-8?B?eUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EAE760D34B1DAC44A83326420634B916@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d1716a0-38bf-4abd-db82-08dc3a2393d2
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Mar 2024 19:12:45.7726
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pO7tJWRzNN1/mMfu9gARon2h+o1lKEH8+/Ydcg4H7ih9VPYB5HOTypfkCfJtCpQfpkDN4MSHtQh3DgneNfUsfz8SWvvnqoPeQOzS8BjPaHo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8601
X-OriginatorOrg: intel.com

T24gRnJpLCAyMDI0LTAzLTAxIGF0IDA5OjI2ICswMDAwLCBXZWkgTGl1IHdyb3RlOg0KPiA+IEh5
cGVydiBjb3VsZCBmcmVlIGRlY3J5cHRlZC9zaGFyZWQgcGFnZXMgaWYgc2V0X21lbW9yeV9lbmNy
eXB0ZWQoKQ0KPiA+IGZhaWxzLg0KPiANCj4gIkh5cGVyLVYiIHRocm91Z2hvdXQuDQoNCk9rLg0K
DQo+IA0KPiA+IExlYWsgdGhlIHBhZ2VzIGlmIHRoaXMgaGFwcGVucy4NCj4gPiANCj4gPiBPbmx5
IGNvbXBpbGUgdGVzdGVkLg0KPiA+IA0KPiA+IENjOiAiSy4gWS4gU3Jpbml2YXNhbiIgPGt5c0Bt
aWNyb3NvZnQuY29tPg0KPiA+IENjOiBIYWl5YW5nIFpoYW5nIDxoYWl5YW5nekBtaWNyb3NvZnQu
Y29tPg0KPiA+IENjOiBXZWkgTGl1IDx3ZWkubGl1QGtlcm5lbC5vcmc+DQo+ID4gQ2M6IERleHVh
biBDdWkgPGRlY3VpQG1pY3Jvc29mdC5jb20+DQo+ID4gQ2M6IGxpbnV4LWh5cGVydkB2Z2VyLmtl
cm5lbC5vcmcNCj4gPiBTaWduZWQtb2ZmLWJ5OiBSaWNrIEVkZ2Vjb21iZSA8cmljay5wLmVkZ2Vj
b21iZUBpbnRlbC5jb20+DQo+ID4gLS0tDQo+ID4gwqAgZHJpdmVycy9odi9jb25uZWN0aW9uLmMg
fCAxMSArKysrKysrLS0tLQ0KPiA+IMKgIDEgZmlsZSBjaGFuZ2VkLCA3IGluc2VydGlvbnMoKyks
IDQgZGVsZXRpb25zKC0pDQo+ID4gDQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvaHYvY29ubmVj
dGlvbi5jIGIvZHJpdmVycy9odi9jb25uZWN0aW9uLmMNCj4gPiBpbmRleCAzY2FiZWVhYmIxY2Eu
LmUzOTQ5MzQyMWJiYiAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2h2L2Nvbm5lY3Rpb24uYw0K
PiA+ICsrKyBiL2RyaXZlcnMvaHYvY29ubmVjdGlvbi5jDQo+ID4gQEAgLTMxNSw2ICszMTUsNyBA
QCBpbnQgdm1idXNfY29ubmVjdCh2b2lkKQ0KPiA+IMKgIA0KPiA+IMKgIHZvaWQgdm1idXNfZGlz
Y29ubmVjdCh2b2lkKQ0KPiA+IMKgIHsNCj4gPiArwqDCoMKgwqDCoMKgwqBpbnQgcmV0Ow0KPiA+
IMKgwqDCoMKgwqDCoMKgwqAvKg0KPiA+IMKgwqDCoMKgwqDCoMKgwqAgKiBGaXJzdCBzZW5kIHRo
ZSB1bmxvYWQgcmVxdWVzdCB0byB0aGUgaG9zdC4NCj4gPiDCoMKgwqDCoMKgwqDCoMKgICovDQo+
ID4gQEAgLTMzNywxMSArMzM4LDEzIEBAIHZvaWQgdm1idXNfZGlzY29ubmVjdCh2b2lkKQ0KPiA+
IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgdm1idXNfY29ubmVjdGlvbi5pbnRfcGFn
ZSA9IE5VTEw7DQo+ID4gwqDCoMKgwqDCoMKgwqDCoH0NCj4gPiDCoCANCj4gPiAtwqDCoMKgwqDC
oMKgwqBzZXRfbWVtb3J5X2VuY3J5cHRlZCgodW5zaWduZWQNCj4gPiBsb25nKXZtYnVzX2Nvbm5l
Y3Rpb24ubW9uaXRvcl9wYWdlc1swXSwgMSk7DQo+ID4gLcKgwqDCoMKgwqDCoMKgc2V0X21lbW9y
eV9lbmNyeXB0ZWQoKHVuc2lnbmVkDQo+ID4gbG9uZyl2bWJ1c19jb25uZWN0aW9uLm1vbml0b3Jf
cGFnZXNbMV0sIDEpOw0KPiA+ICvCoMKgwqDCoMKgwqDCoHJldCA9IHNldF9tZW1vcnlfZW5jcnlw
dGVkKCh1bnNpZ25lZA0KPiA+IGxvbmcpdm1idXNfY29ubmVjdGlvbi5tb25pdG9yX3BhZ2VzWzBd
LCAxKTsNCj4gPiArwqDCoMKgwqDCoMKgwqByZXQgfD0gc2V0X21lbW9yeV9lbmNyeXB0ZWQoKHVu
c2lnbmVkDQo+ID4gbG9uZyl2bWJ1c19jb25uZWN0aW9uLm1vbml0b3JfcGFnZXNbMV0sIDEpOw0K
PiA+IMKgIA0KPiA+IC3CoMKgwqDCoMKgwqDCoGh2X2ZyZWVfaHlwZXJ2X3BhZ2Uodm1idXNfY29u
bmVjdGlvbi5tb25pdG9yX3BhZ2VzWzBdKTsNCj4gPiAtwqDCoMKgwqDCoMKgwqBodl9mcmVlX2h5
cGVydl9wYWdlKHZtYnVzX2Nvbm5lY3Rpb24ubW9uaXRvcl9wYWdlc1sxXSk7DQo+ID4gK8KgwqDC
oMKgwqDCoMKgaWYgKCFyZXQpIHsNCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
aHZfZnJlZV9oeXBlcnZfcGFnZSh2bWJ1c19jb25uZWN0aW9uLm1vbml0b3JfcGFnZXNbDQo+ID4g
MF0pOw0KPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBodl9mcmVlX2h5cGVydl9w
YWdlKHZtYnVzX2Nvbm5lY3Rpb24ubW9uaXRvcl9wYWdlc1sNCj4gPiAxXSk7DQo+ID4gK8KgwqDC
oMKgwqDCoMKgfQ0KPiANCj4gVGhpcyBzaWxlbnRseSBsZWFrcyB0aGUgcGFnZXMgaWYgc2V0X21l
bW9yeV9lbmNyeXB0ZWQoKSBmYWlscy7CoCBJDQo+IHRoaW5rDQo+IHRoZXJlIHNob3VsZCBwcmlu
dCBzb21lIHdhcm5pbmcgb3IgZXJyb3IgbWVzc2FnZXMgaGVyZS4NCg0KQW5vdGhlciBwYXRjaCB3
aWxsIHdhcm4gaW4gQ1BBIGZvciB0aGUgcGFydGljdWxhciBjYXNlOg0KaHR0cHM6Ly9naXQua2Vy
bmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvdGlwL3RpcC5naXQvY29tbWl0Lz9oPXg4
Ni9tbQ0KDQpEbyB3ZSB3YW50IGEgd2FybmluZyBpbiB0aGUgY2FsbGVyIHRvbz8gSXQgaXMgbW9y
ZSByb2J1c3QgdG8gb3RoZXINCnR5cGVzIG9mIGZhaWx1cmVzIGluIHRoZSBmdXR1cmUgSSBndWVz
cy4NCg==

