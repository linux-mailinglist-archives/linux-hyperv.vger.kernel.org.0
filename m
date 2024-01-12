Return-Path: <linux-hyperv+bounces-1427-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C945182C494
	for <lists+linux-hyperv@lfdr.de>; Fri, 12 Jan 2024 18:17:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3E093B21037
	for <lists+linux-hyperv@lfdr.de>; Fri, 12 Jan 2024 17:17:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E67232260D;
	Fri, 12 Jan 2024 17:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Qu1j0TNO"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15EF62260A;
	Fri, 12 Jan 2024 17:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705079861; x=1736615861;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=sKHEMVPAnOZOQyfW6ugIPSX2I6opAOlMvjZp0Vi00sE=;
  b=Qu1j0TNO2PUSIA3f420wjniGOnm9HnuG08Qja1jQKa8VhhBQQvxm4k2o
   YsspjMI0NDJYI6T7B6oS2FfqcV3cNS3ZZwMudsVFFM9PBFnp0R8WFTfv3
   cbyZwXuGfdB9duTG4Skxpq9cxgKpuJnlXrWV/lh6oUBc01k9rZS4/WKmz
   lI7Dia0Rnb6XD4evFIHVIY39Jkh07Sidh2dYQOXpppHCoqp2Kx4cbKBdc
   Y3ZS0yFFe4xnA5WFko++I6kMqybC1BN+p6Q9THu0jP/ToSraHBqDHMOsk
   srZ3c+Ycdwf5yayWTb7ajZnQl3199nIjqqUOLk45g+7EWc0wpekEXQVF6
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10951"; a="402995277"
X-IronPort-AV: E=Sophos;i="6.04,190,1695711600"; 
   d="scan'208";a="402995277"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2024 09:17:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10951"; a="956162758"
X-IronPort-AV: E=Sophos;i="6.04,190,1695711600"; 
   d="scan'208";a="956162758"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Jan 2024 09:17:20 -0800
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 12 Jan 2024 09:17:20 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 12 Jan 2024 09:17:20 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 12 Jan 2024 09:17:20 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eGQGX7NUszcAZrNNF4r2NR7HVh1YYp0GF7Izzg7DiOZoN50eqLSqIIpEN4nJ7fIQlNmv+reKYLyllGXzDATADdFPNSaMw+Mqqbuw5wZ8xYIE1dRagdOmnJfo2N7p7R0CcsRukUU3ZHcxY9weLELPTyz0N/DrEzsHZFM6AXf0fVKpbDBu/T3lC9gOtkA2lK40TA9BxCWbKXPj8LrmKo5P4YVv12PsTcMIpr0otIVDx6QJ6lWzUBlH07lkSPyUsusdOAk9eXT5JmHfXe/6DGXvXC9GUmrlGVBOANzgVdYExlIG0XcW2xYBo3j4c8BrqX6dZ1Kmj0Tsnsc6Cu/Aanyo6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sKHEMVPAnOZOQyfW6ugIPSX2I6opAOlMvjZp0Vi00sE=;
 b=LG34usaA9SBmGg1USxDzuT9S0p04IaJdnCOYf9+2OAm5vYWKy2z0d3cHOLQvumG1uTct4OC3ZQ1pLlC2Ip5VOqRmNM2F3dCpx1WkpKhUqunqi3z7loyY5KSDpI5UnqBVDb46x3IqlUG5kM5t8b66sFRhbI9w43Qa3d0o17XSUknRonuolM8flkE5V+SVzuzo/+iI+KN94Q+9nKW9i70LJiLSiw6Ninb1SJ0UXaPxiDT3lcivqaCmatJUFDZ7p53MgH1JpM7POsiZG7bTHAyluyMztfKhnoX41ydC3OtDlvbuwhqOgWKlUfaOXujEnIl2pKhOcskWPkyDmOFkkkeXxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by DS7PR11MB6294.namprd11.prod.outlook.com (2603:10b6:8:96::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Fri, 12 Jan
 2024 17:17:16 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::6dc:cee5:b26b:7d93]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::6dc:cee5:b26b:7d93%4]) with mapi id 15.20.7181.022; Fri, 12 Jan 2024
 17:17:16 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
	"ardb@kernel.org" <ardb@kernel.org>, "Lutomirski, Andy" <luto@kernel.org>,
	"mhklinux@outlook.com" <mhklinux@outlook.com>, "hch@infradead.org"
	<hch@infradead.org>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "thomas.lendacky@amd.com"
	<thomas.lendacky@amd.com>, "haiyangz@microsoft.com" <haiyangz@microsoft.com>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
	"mingo@redhat.com" <mingo@redhat.com>, "seanjc@google.com"
	<seanjc@google.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "tglx@linutronix.de" <tglx@linutronix.de>,
	"Cui, Dexuan" <decui@microsoft.com>, "urezki@gmail.com" <urezki@gmail.com>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "peterz@infradead.org"
	<peterz@infradead.org>, "hpa@zytor.com" <hpa@zytor.com>, "bp@alien8.de"
	<bp@alien8.de>, "wei.liu@kernel.org" <wei.liu@kernel.org>, "Rodel, Jorg"
	<jroedel@suse.de>, "sathyanarayanan.kuppuswamy@linux.intel.com"
	<sathyanarayanan.kuppuswamy@linux.intel.com>, "lstoakes@gmail.com"
	<lstoakes@gmail.com>, "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH v3 1/3] x86/hyperv: Use slow_virt_to_phys() in page
 transition hypervisor callback
Thread-Topic: [PATCH v3 1/3] x86/hyperv: Use slow_virt_to_phys() in page
 transition hypervisor callback
Thread-Index: AQHaQAVkxs0+X3Nw7Eax/DPEZFIdBbDVauMAgADnSoCAACQogA==
Date: Fri, 12 Jan 2024 17:17:16 +0000
Message-ID: <3ddc237d9fbbe0aa8838babf0df790076017e9f7.camel@intel.com>
References: <20240105183025.225972-1-mhklinux@outlook.com>
	 <20240105183025.225972-2-mhklinux@outlook.com>
	 <9dcdd088494b3fa285781cccfd35cd47a70d69c3.camel@intel.com>
	 <SN6PR02MB4157B123128F6C2F6C3600D9D46F2@SN6PR02MB4157.namprd02.prod.outlook.com>
In-Reply-To: <SN6PR02MB4157B123128F6C2F6C3600D9D46F2@SN6PR02MB4157.namprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|DS7PR11MB6294:EE_
x-ms-office365-filtering-correlation-id: eb1bca1b-29d6-46bd-2c63-08dc13925384
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mxk6RaOMVqGNi7I+iBNSKjc5ezTqmwkS7FG3Gdh2933nOF26gMpOaM1WM6I6U0IWviZwtkmYjoWG+Srs/bimHubjt5fPTQBfGLGVkOfdGyb5QSOI9kT7uvgaK1sSf21g17/eksdAHiKaDHEVIbulB65XHFQsWYHq5DoALtgjoZCgxr4fCNMgwDGNVGC3TtDP0lQxdhYXe1AjRb1qdd47I+abwQ9kjTKwi8/q2qUrDTT/AmXKlhgoKD4UnnaW4/8+qHUV0QSv+CQicdyYv2Oa0W2AQnXMYNzxsh1rR+Fj6dNoSpLU67FE9o8QHPlJN5zw2DsgWFNZmbUHKJK2fiYB0yGiDkpeAwPVEAAzOm/beVFxRihp43TLmGi01/M2UCAKA7PTrwtXvw11a8pX6L5Ep7vLC9VOOeuwJ7hwGx1iJavS03uY/kRZoTsblVUn0lrGu8TG+drp5U/M/QVWVkZCVEHITf3teD02vb2AmgCZdlW5EveowtahbRnu7MeA/MlQOrhlXq0fdgjdsTgJcQ9vO2dpztcZyX0uM7h1q0PNYs94qGseA8NdoT7uZwVMMIdm5ySrzCTr1MMqhtRZ4Owj3Kt0qvnR0yW/5mvZT7zx8tajzJncpL1mRpXShHlcVDXpN+ZVPDXAVb/x5NLEuuve6A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(346002)(366004)(136003)(396003)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(38100700002)(6486002)(71200400001)(122000001)(64756008)(66446008)(8676002)(66556008)(66476007)(2616005)(8936002)(76116006)(91956017)(316002)(36756003)(66946007)(110136005)(82960400001)(26005)(6512007)(6506007)(478600001)(86362001)(2906002)(7416002)(921011)(38070700009)(5660300002)(41300700001)(66899024);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cXhDZ1BhRVc5MjNRWkJkQkZqWWtGd3NtMXdCVDFXdFZkaFJXYUpjWWFFZGx6?=
 =?utf-8?B?NWs3OFl3TVpkZEd5Z2RjUDRzdUR3OHh2c0NoY2krR2s2TFZFWVV2dkVUMUZN?=
 =?utf-8?B?ZUtoNXREZXR0MzRRNXNnSnRYWGtqL2RKQUhtc0NHM3ptYXVaV0FpRkFoaFAr?=
 =?utf-8?B?Zm1ZTWJoS09xRnFDQ051UG1icGhxZkkxb05LQ1ZOOXVHMGZDTkVOQll5dCtL?=
 =?utf-8?B?ZS9pa3JQK0NaaDUrWGt2ZFRGSnB0TEVEd2tybm00VjI4TEtSdzdpOE5CY3Qz?=
 =?utf-8?B?SHdkM2hwdjJIYkI1ZENFdDBUN2tybXU2cnp5Tm1aUXpaKzUweldVN21uYU42?=
 =?utf-8?B?NUIxQ3RyRzZUaiswWmdxKzYvY2xBT0FmQVFuZnNXaEY0dGppRTQwT2Y3cEtC?=
 =?utf-8?B?SnBXTDdLeFZBSzViakdSaGQ3YzMwYng4V2h5Sk4yZEsxWXFEcUtHL2J5cFFO?=
 =?utf-8?B?eTcxVjJDR29CUnBWZVBhWUtoUTA3MFdmZ0dkeVZ0eHN2d3d2VTdaZmhSaFZM?=
 =?utf-8?B?ek8yWGRDR0I3bm50bkt6VTNHMHBvVkNTZGZoQTI2Ynl2Um8wR0RPOVp4MmJk?=
 =?utf-8?B?ZzRuREgvMFloZnRZOGluamRtK1UzMnFYY2FBcDVyRlBVSmZaU3lQT2Z2SnF1?=
 =?utf-8?B?UWhuVEhvVnlPMk5FQzRlTkorYWJIQTJYbjRlUEJrQ0J4eGdZa2JpL3hRNjU1?=
 =?utf-8?B?T1BYTW1yakJWL2NudmRTR1IraU13d09PdVF5YmFVRWtBbHhrZ2FzZWNrMkk2?=
 =?utf-8?B?dTNSdHgzZVg4YlNVdWVRMXZOUG9MT2UzWlBWMXlqSENEVldEalREMURCM2dt?=
 =?utf-8?B?cm05Zm10clpMczVsbFU3bzUwQVFzWWpGTHdVNlA4Qnl6M2pSOUVvbGYwczdm?=
 =?utf-8?B?QTZEU0daamdJRWVCdlJYSDJrYUJ3VzFGUGQxdEcwbVdxUVVOTDJtbHQzTjk4?=
 =?utf-8?B?N1p1aHFBUmxuc0IyUUNNbDBvVzNmdEVicVlsMStXMGtYZ2d5TjhNOTFETDBv?=
 =?utf-8?B?cVViZXlUOFdRYTdXalR3NzBmR0ZhVWhJaHhiaHowUUtmSDdKTEJaa08vMGQ5?=
 =?utf-8?B?RFRxZzJ5Z3pUdnQwZkZaZ0lLY1I3OFlic2x5Uk9JNmxIY09ueWQ1c0xYaTZK?=
 =?utf-8?B?TWdpYzA0V1pDWWtlVzhBQ0sxd3RqYXJGRWxoZWs2ZkpCMzN6VUp6VkkzRjly?=
 =?utf-8?B?MEd4T1Jka2pocjIzR09mcHdTRksyNERCQ3JMRHRPMm9LR2Rmei95R3FHQklI?=
 =?utf-8?B?Qmdyc0p5aHMwRWF1YitEZGhUR1I4MnNHeXBtRENuTFcvLytDZW1XUUJOZ1dH?=
 =?utf-8?B?cTNyaHZmL3dHQTBURU9JemZVT0MzRmJxU3A4Y1hyeERwT1ZWRTlkdjRnbzZS?=
 =?utf-8?B?cmxDKzZYUHdDM3RzVTgvWTcvQk91TEw0MEV2bm9rV05XQjRXVERERUxkcXlr?=
 =?utf-8?B?RE9iNzJRTjJUa2RDcnNJNGFxU3hBVW00em82bTZEN1liNzhLeFdML1dRRnpT?=
 =?utf-8?B?UjlCaDY3YXpiazVTSGIzNTduRnJIMEtaMWhGaDZzOEs2S0ZiaWt1ajN1RXZC?=
 =?utf-8?B?bzhQMlB0YmM4UFlTMGFGZFhMZElBT1dzcGlQbDFIT2VMTmtld1RYcnZlMk8x?=
 =?utf-8?B?amljbCtva0JMRnZIUEVyZ2l4cHVScVRCd1kzVDc5SkRJOG9ldDd4cWNqVzBz?=
 =?utf-8?B?dklOTWFpZ2R4aDZHVFBjd3dCWVJHY3RuNThLWVlya1pIU2NxL0plbHozZTYr?=
 =?utf-8?B?MDVGajZSazBxUnBGNUVmeGhueUpmOW5RMklSRThibE1JNTZIS2ZDZlRvQUR4?=
 =?utf-8?B?YU5LRkpBSkRBa2w4OWVJYTh6TUExQ0Jia2FPcW9jdEF1MWpuZTJnQ1o1RVJv?=
 =?utf-8?B?ZElUR0RsVERBOThTRTl6ZmRlY2dYRDNkMzZkUnBQU1dXRlB6aHVDQmlON1hF?=
 =?utf-8?B?STRzQUZqeFkrKzlKWXdMeURubmxlQVdoZ0VOL3RGQVZ5YWNtdW44OEY4UHc1?=
 =?utf-8?B?SGhKcExUS21Ray90ejJ0MEhERTRUVHdjdEExaDRTMEtOZkJtTEROR24xbGNy?=
 =?utf-8?B?RmIrc0d2RWhCVjlhbmtReHkrcUtlenJaUEtzVTdxdGZrT1MzcjJtMDBwbkNm?=
 =?utf-8?B?S0dMdGVBSWJpWjhrd2EreUZnTk9YeUVDazlHN0F2UmlHMXRzNlNTaDgwOERS?=
 =?utf-8?B?cnc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7CF120147CD50142B5646485B04AD811@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb1bca1b-29d6-46bd-2c63-08dc13925384
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jan 2024 17:17:16.6676
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: f9QuAkx64kOYUzpwx4kPvb71wwP++tJmfGhtgUfZ9QxNFyTseT4XO0BpVo60XRPKbszDmvmwuSfgii7EQWg8tfuaC8LpTaJt5X0iQkufsnw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6294
X-OriginatorOrg: intel.com

T24gRnJpLCAyMDI0LTAxLTEyIGF0IDE1OjA3ICswMDAwLCBNaWNoYWVsIEtlbGxleSB3cm90ZToN
Cj4gVGhlIGNvbW1lbnQgaXMgS2lyaWxsIFNodXRlbW92J3Mgc3VnZ2VzdGlvbiBiYXNlZCBvbiBj
b21tZW50cyBpbg0KPiBhbiBlYXJsaWVyIHZlcnNpb24gb2YgdGhlIHBhdGNoIHNlcmllcy7CoCBT
ZWUgWzFdLsKgwqAgVGhlIGludGVudCBpcyB0bw0KPiBwcmV2ZW50DQo+IHNvbWUgbGF0ZXIgcmV2
aXNpb24gdG8gc2xvd192aXJ0X3RvX3BoeXMoKSBmcm9tIGFkZGluZyBhIGNoZWNrIGZvcg0KPiB0
aGUNCj4gcHJlc2VudCBiaXQgYW5kIGJyZWFraW5nIHRoZSBDb0NvIFZNIGh5cGVydmlzb3IgY2Fs
bGJhY2suwqAgWWVzLCB0aGUNCj4gY29tbWVudCBjb3VsZCBnZXQgc3RhbGUsIGJ1dCBJJ20gbm90
IHN1cmUgaG93IGVsc2UgdG8gY2FsbCBvdXQgdGhlDQo+IGltcGxpY2l0IGRlcGVuZGVuY3kuwqAg
VGhlIGlkZWEgb2YgY3JlYXRpbmcgYSBwcml2YXRlIHZlcnNpb24gb2YNCj4gc2xvd192aXJ0X3Rv
X3BoeXMoKSBmb3IgdXNlIG9ubHkgaW4gdGhlIENvQ28gVk0gaHlwZXJ2aXNvciBjYWxsYmFjaw0K
PiBpcyBhbHNvIGRpc2N1c3NlZCBpbiB0aGUgdGhyZWFkLCBidXQgdGhhdCBzZWVtcyB3b3JzZSBv
dmVyYWxsLg0KDQpXZWxsLCBpdCdzIG5vdCBhIGh1Z2UgZGVhbCwgYnV0IEkgd291bGQgaGF2ZSBq
dXN0IHB1dCBhIGNvbW1lbnQgYXQgdGhlDQpjYWxsZXIgbGlrZToNCg0KLyoNCiAqIFVzZSBzbG93
X3ZpcnRfdG9fcGh5cygpIGluc3RlYWQgb2Ygdm1hbGxvY190b19wYWdlKCksIGJlY2F1c2UgaXQN
CiAqIHJldHVybnMgdGhlIFBGTiBldmVuIGZvciBOUCBQVEVzLg0KICovDQoNCklmIHNvbWVvbmUg
aXMgY2hhbmdpbmcgc2xvd192aXJ0X3RvX3BoeXMoKSB0aGV5IHNob3VsZCBjaGVjayB0aGUNCmNh
bGxlcnMgdG8gbWFrZSBzdXJlIHRoZXkgd29uJ3QgYnJlYWsgYW55dGhpbmcuIFRoZXkgY2FuIHNl
ZSB0aGUNCmNvbW1lbnQgdGhlbiBhbmQgaGF2ZSBhbiBlYXN5IHRpbWUuDQoNCkFuIG9wdGlvbmFs
IGNvbW1lbnQgYXQgc2xvd192aXJ0X3RvX3BoeXMoKSBjb3VsZCBleHBsYWluIGhvdyB0aGUNCmZ1
bmN0aW9uIHdvcmtzIGluIHJlZ2FyZHMgdG8gdGhlIHByZXNlbnQgYml0LCBidXQgbm90IGluY2x1
ZGUgZGV0YWlscw0KYWJvdXQgQ29Db08gVk0gcGFnZSB0cmFuc2l0aW9uJ3MgdXNhZ2Ugb2YgdGhl
IHByZXNlbnQgYml0LiBUaGUgcHJvcG9zZWQNCmNvbW1lbnQgdGV4dCBsb29rcyBsaWtlIHNvbWV0
aGluZyBtb3JlIGFwcHJvcHJpYXRlIGZvciBhIGNvbW1pdCBsb2cuDQo=

