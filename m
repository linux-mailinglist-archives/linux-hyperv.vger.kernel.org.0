Return-Path: <linux-hyperv+bounces-1131-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BC3A97FCDF2
	for <lists+linux-hyperv@lfdr.de>; Wed, 29 Nov 2023 05:36:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DCFE11C20BBB
	for <lists+linux-hyperv@lfdr.de>; Wed, 29 Nov 2023 04:36:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B3DC1C37;
	Wed, 29 Nov 2023 04:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nmfY8Dot"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56BDC19AE;
	Tue, 28 Nov 2023 20:36:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701232584; x=1732768584;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=GkoOo67TmdySgcl7pGU22so/rUDc2k115pvacna1ob4=;
  b=nmfY8DotYCWoVVZ3tCPhw9Pp5JZM9nxKX14Ej3rBLmf+XqFYFgYhpjbR
   +vJy6xEW2iLaMH7urcrtk8oO1Ktf2dGr6XHIBdn3Z2UO5yom5OFzThlht
   sF8z66f/+oNRJv+I7WdSCFA93Cd/mywUJzTaOiEjY5navAKf8ByATF8Uz
   CBKp4dZI9wzrqgcMcc8SseHwf5+3TFt/3Wxrf/o3E7vR9R6l3jP8WkAz/
   AzGY7cWkG+wbJjIwjPs1xcRmnlHyFC8I+bF++uHSbbe2XVWilx1Hgjabb
   25ONi6XuVoCx37YW8jFoNhBPLAjJsCVRmlBxxNWLELKzaUcF2g91PIKnC
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10908"; a="395909654"
X-IronPort-AV: E=Sophos;i="6.04,234,1695711600"; 
   d="scan'208";a="395909654"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2023 20:36:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10908"; a="797790210"
X-IronPort-AV: E=Sophos;i="6.04,234,1695711600"; 
   d="scan'208";a="797790210"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 28 Nov 2023 20:36:23 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Tue, 28 Nov 2023 20:36:22 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Tue, 28 Nov 2023 20:36:21 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Tue, 28 Nov 2023 20:36:16 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Tue, 28 Nov 2023 20:36:16 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VqtW67SS1t2hWEbn8r50OXv+fl1jtGDUnpbVbfMAaPgnVZR80ADFAW2ueg3b3mP0GDc0JjKMOJHFIpJTn0w1priUTYs60aMpGUNoVGjbS+9MZ5W/uwyi8j1kctsBk79fzsfsdJS46/I5aMCOMff+/lR17mMwJKNcQoOtxH7JivvqhEFYs8a6HbB+st46ksyRS6P+wEqTmvLlX93vL40ogHc67PI3GPNOKqn8/55MzehmaOUcWdn/i1UBP7S92WFxa2Qh2rkMJpaZbnS+SbK3WluJQq5GEFf5x6md6g5rlt21c21/ePKo26w2eThrV8jWOXmvJsFvUVJ+03fGk9uINg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GkoOo67TmdySgcl7pGU22so/rUDc2k115pvacna1ob4=;
 b=ng1CcEV8wd+A5RNGvldnKAPIFl2Ipf58arqNqwcFLdGxsOGH6H4frLP5vd15J8slZF80IIOWMNMEwvbPpJMYuu/Xy/MN3ERYoS1A+ighKryLPYpZPDSzK3cOXpXQm4PN78e6NMdtjML4LoSq07RoPtMTmgOWK8K8oMMXVE6Se0SHondDyEUGpwbXmFpdz1gnMcQqnfdDQQts+MocU6sRvHqn0Zln/LgkCGkI/xsYPU6eeM8ELiddFxQsc2WeBdWz2YkXq1wmlcY9W3vsRVI2xXM/k0in4MMfhYWm0kUaX1oT6pvFNbyjZixLXN3IBBClCMEvynXTb7eGhBSeHhRi5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by PH8PR11MB6732.namprd11.prod.outlook.com (2603:10b6:510:1c8::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.27; Wed, 29 Nov
 2023 04:36:13 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::5d1:aa22:7c98:f3c6]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::5d1:aa22:7c98:f3c6%7]) with mapi id 15.20.7025.022; Wed, 29 Nov 2023
 04:36:13 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
	"jpiotrowski@linux.microsoft.com" <jpiotrowski@linux.microsoft.com>
CC: "tim.gardner@canonical.com" <tim.gardner@canonical.com>,
	"cascardo@canonical.com" <cascardo@canonical.com>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
	"roxana.nicolescu@canonical.com" <roxana.nicolescu@canonical.com>,
	"haiyangz@microsoft.com" <haiyangz@microsoft.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"mingo@redhat.com" <mingo@redhat.com>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>, "tglx@linutronix.de" <tglx@linutronix.de>,
	"stefan.bader@canonical.com" <stefan.bader@canonical.com>, "Cui, Dexuan"
	<decui@microsoft.com>, "nik.borisov@suse.com" <nik.borisov@suse.com>,
	"mhkelley58@gmail.com" <mhkelley58@gmail.com>, "hpa@zytor.com"
	<hpa@zytor.com>, "peterz@infradead.org" <peterz@infradead.org>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>, "bp@alien8.de" <bp@alien8.de>,
	"sashal@kernel.org" <sashal@kernel.org>, "kys@microsoft.com"
	<kys@microsoft.com>, "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH v1 1/3] x86/tdx: Check for TDX partitioning during early
 TDX init
Thread-Topic: [PATCH v1 1/3] x86/tdx: Check for TDX partitioning during early
 TDX init
Thread-Index: AQHaHWWtv7u0f2izB0aVCuwkdix+ibCH744AgAFYfQCAAANSgIAABfUAgAApowCAAC5QgIAHFxKA
Date: Wed, 29 Nov 2023 04:36:12 +0000
Message-ID: <ffcc8c550d5ba6122b201d8170b42ee581826d47.camel@intel.com>
References: <20231122170106.270266-1-jpiotrowski@linux.microsoft.com>
	 <20231123135846.pakk44rqbbi7njmb@box.shutemov.name>
	 <9f550947-9d13-479c-90c4-2e3f7674afee@linux.microsoft.com>
	 <20231124104337.gjfyasjmo5pp666l@box.shutemov.name>
	 <58c82110-45b2-4e23-9a82-90e1f3fa43c2@linux.microsoft.com>
	 <20231124133358.sdhomfs25seki3lg@box.shutemov.name>
	 <6f27610f-afc4-4356-b297-13253bb0a232@linux.microsoft.com>
In-Reply-To: <6f27610f-afc4-4356-b297-13253bb0a232@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.48.4 (3.48.4-1.fc38) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|PH8PR11MB6732:EE_
x-ms-office365-filtering-correlation-id: 938888f6-34e0-4310-abe6-08dbf094b78e
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ExscYe1y3mFhXl/m00cwqqKfHSlDwKnOwfKkfuytoDVEFAq5+fdVIaplhg1kJGtVbwlWo7AU2Ghz3IwzroE7pXpV1tgTumHOTn3sLtl+tId1mlfqofbJWGrzVi+uaZhS6lYLiuFjUh4M3OtrkGIXb4IgSPDQvygl0YqLVDWKPvVKHSid++kGtMQMSacxcHN7ZaIrVVljLtohUdNz3TXMe1tihZVbdXJLPsXdgvoTrKq31AHvpU9xqQqWV1n28u6kPI/MP7ux99NTZYCPAX5bX+2x2UvJXcyqPqbn4yFGfP3/z3WTcBikMfFPCa8vYZokFefwpYXWfbzbT9BAsysIb57n01YrqoQPoOLJi+Exn3OZoU7m/C9TMynpgSxJX9XcUJY3V0CEJrAemlzFEeAWAAQXlT5/gpwgMKjGP+0Kx2uUxruNTaY3nA6uUcpwMu7T3YCwq/v96+n2zmzMqyfMk0LvIxU+aeuvI7XkADJGf42SMRYp518LIRJjnll6aNEjmMHT3x88CR1dmmGPeUCFEVaefSl7ngymKdxEHN1lCuUS1NcXPKJjHMcd5wVXbx6cO6NcP7bOH+vcRXZ0vJ492FK6ocCnWtYk0+pvwHu71kU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(136003)(396003)(346002)(39860400002)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(478600001)(966005)(6486002)(6506007)(53546011)(6512007)(71200400001)(86362001)(316002)(54906003)(64756008)(66446008)(66476007)(8936002)(8676002)(91956017)(110136005)(66556008)(66946007)(76116006)(4326008)(38070700009)(4001150100001)(122000001)(82960400001)(2906002)(83380400001)(41300700001)(2616005)(5660300002)(7416002)(38100700002)(26005)(36756003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?d01sejRSZVhpbHJwM09uUTYzZ0ZYUnZkRFVsalFJZXF3OEk1Q3poOUhmbXYx?=
 =?utf-8?B?ejAxcmdyWVlJeWVmM0QrTSsrMk5PUUNGMmlwUE9IUmNyYUJ1REhTU1Q0ZXI4?=
 =?utf-8?B?R0doVVRHU0ZjeFl4a3NTbnR6VEppeDY4U3UwYkdGN1BhM3h5ZDhXRzdEdmdk?=
 =?utf-8?B?eElHdTVtc0dDNElCV2Z6bVUrZWhwdmlmZ3RSZ3pFMkV1eVdYeXdQUXlxYlFS?=
 =?utf-8?B?Slp0Wk5zY1pNL0d6RGVSWGoxNkd4MC9zMUZ1TTh0emo5RlFTQVp5WnNMMGkr?=
 =?utf-8?B?aUlKNGFPOHFZQ3EvaTI3cFB0TzVyeFQvUkFVWGVZWGg1Wi9lbVNtTG9wdTBr?=
 =?utf-8?B?YXZKODV6eExLdEwxcHh5YzNNV2gzUzU1bE1TY2d0MitDcmdzNEFwcXNacGY5?=
 =?utf-8?B?Zjhjc1piSmtscmlMUmJKRERuZGx0YU1TT3NiSGtySkhmWXFBU2hENW9FMUw4?=
 =?utf-8?B?RC9BS1V1Vm9SMlBWT1FKTlpmSmtuN3lCeXVPc01zbXdYN1I5MjFIMG4vOW5M?=
 =?utf-8?B?OE5xem1zRm5QWW9UTmhmaE42cVg1aXByRWJXQW13cVFmSVBMOW5VMUxXT0hS?=
 =?utf-8?B?RkI5eVhxTTFwcDBacFNqcWxMcTB3aytIU3RnalVkK0ozZ1doRVZQSnc4dHZY?=
 =?utf-8?B?aDc2dXN1alFzK2VHelhsOUJMZnRqeXQrTFJrditSNTBFTTU3bXNDdEZidzVB?=
 =?utf-8?B?bnE2Y1JjNlN3Mk1RU1pqcWVscFRtVzFOd3RVR1hiTEdXeExaWXNWeVZwZWV6?=
 =?utf-8?B?dEh2Qmxha0NxRmxHWXkyWGxvYU41bTgvNVd6cEk0R04rcC83UnZEcGJRQVJF?=
 =?utf-8?B?Q2ozZmpkR1VFZXg0QWp1OCs0VFdPV1ltN09nT1REaGNKaUJ3Ti90TVhIMG9z?=
 =?utf-8?B?L1hFMGJVOHVPVHF5QjcvYWxIOTJlb1ByaTVudUxEb0kyU2ZpakNuNDl6Rk1K?=
 =?utf-8?B?UTRDMS9xNTNWMFo5dVR5Qit6azIwNDlpeEdBOGlYRk1uWENyb2ZacGdLUndz?=
 =?utf-8?B?SWlTSlY1VnJmOW93eEZ5MXlxdkFvbzVSYTBuOG9IeldhVzc4YXUycWlZbWdC?=
 =?utf-8?B?b3JlQ0NzSjlUV3NXZFlFRHdaZWxmOWZVam8zR3A4MVZTOTQzcWg5dk8yZlhy?=
 =?utf-8?B?ZjU5ZThsQlh2ZG82WnMxWE9XS0VicXUxemwyTjdKRE02eTdKckhydVZnc091?=
 =?utf-8?B?S1ZIZUFXQTR2eEMva0Z2V3NNazZ0MHBzQnVMQnBucWtpM0dhNk1DalJyVVho?=
 =?utf-8?B?WWJOM0tVd2h4TG4wd0paYnJjTTN2TUhpZk9TcmorY3Fid0hMSVlWRHZlVHNQ?=
 =?utf-8?B?WkFOakdHTzh0a3Jxa0MwY0NMMndoMVR1c3Ezdm82UXFYRnVaeEhHdm1LU3Yy?=
 =?utf-8?B?WUt4UXhpWG1USFRqb0o4bjArNFgwaUZyTDA1NXhMeW1UQ1NHYjVQZ3FZT0JE?=
 =?utf-8?B?QTdvc0dXejdrd0doQkNBeklnb0hxam40OHJjYWlMR1ZvZ1Z2dUJWRjZpZisv?=
 =?utf-8?B?RTNjMzdycjJRTmZZaDlsZktDNGdtaUNTcWVvOVVEbS9YS0pBTUhhcHc4MUhp?=
 =?utf-8?B?b1BiWjlCSExkZmJ4ekFhNXVzSTJ0cnZBVTFBS1dtWnFyNm51Um0zNVlXSmkv?=
 =?utf-8?B?cDkyVGV6bHJidDRiaWVMQWx2M2E3Ny8zemJJOXBucGNSS1lhZjZ4M3Y4dTlu?=
 =?utf-8?B?Z3M5enRqZzVxeFhLY1pkUG5kaC9oa3BpVDc5Z2pOUVlQVXArR0lVSUFoQXda?=
 =?utf-8?B?MkI5UEZZY2pRYXQ0VHpaV1dEdXRRSmRuVE9RSkgzNk84SngydUlSTURZbHQx?=
 =?utf-8?B?cGVFRk5SRkEwdW8xeWhvSW40VGw3bDhFS0thS0hyYXpZNWs0c080UFpGRFhS?=
 =?utf-8?B?czFoc25KWmQvUHRsWDVxRGVpNlRwLzY2dTI4bVRqdWdYSTBYdTJSR29PczZt?=
 =?utf-8?B?OTFXSnhKVWtIS094Nmdvb203ekdYaVdkZWVYem5qUFdWQ3lmN1dJaTR2OWFw?=
 =?utf-8?B?SmlTZWpUTGtCTm9TOVRMeks2ekFIRXVzb1BDSXZ5T0pMNHlYRGpXOXVOcGNm?=
 =?utf-8?B?U2o3SndPZmprUFVaQmV3c1dnMUlocDYyTHcxOWZxMXkyTWJnMHlvdFlNa0h5?=
 =?utf-8?B?bE05TGFCeFpIY1Z4U2pwRmtGNVV1V2U0TVlmNWxTWDhwTXdDQjBZcFlzY1Bs?=
 =?utf-8?B?c2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F4778DCD0EB08441B43D9D48A636B00E@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 938888f6-34e0-4310-abe6-08dbf094b78e
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Nov 2023 04:36:12.8244
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: T4cnaGvZa6QoCB+cx010UXwNven1ALalJzDE4EKFVx+nN6EaCs34iB5MXF8j9xy39wEGEkY+dKNFRrazpldN/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6732
X-OriginatorOrg: intel.com

T24gRnJpLCAyMDIzLTExLTI0IGF0IDE3OjE5ICswMTAwLCBKZXJlbWkgUGlvdHJvd3NraSB3cm90
ZToNCj4gT24gMjQvMTEvMjAyMyAxNDozMywgS2lyaWxsIEEuIFNodXRlbW92IHdyb3RlOg0KPiA+
IE9uIEZyaSwgTm92IDI0LCAyMDIzIGF0IDEyOjA0OjU2UE0gKzAxMDAsIEplcmVtaSBQaW90cm93
c2tpIHdyb3RlOg0KPiA+ID4gT24gMjQvMTEvMjAyMyAxMTo0MywgS2lyaWxsIEEuIFNodXRlbW92
IHdyb3RlOg0KPiA+ID4gPiBPbiBGcmksIE5vdiAyNCwgMjAyMyBhdCAxMTozMTo0NEFNICswMTAw
LCBKZXJlbWkgUGlvdHJvd3NraSB3cm90ZToNCj4gPiA+ID4gPiBPbiAyMy8xMS8yMDIzIDE0OjU4
LCBLaXJpbGwgQS4gU2h1dGVtb3Ygd3JvdGU6DQo+ID4gPiA+ID4gPiBPbiBXZWQsIE5vdiAyMiwg
MjAyMyBhdCAwNjowMTowNFBNICswMTAwLCBKZXJlbWkgUGlvdHJvd3NraSB3cm90ZToNCj4gPiA+
ID4gPiA+ID4gQ2hlY2sgZm9yIGFkZGl0aW9uYWwgQ1BVSUQgYml0cyB0byBpZGVudGlmeSBURFgg
Z3Vlc3RzIHJ1bm5pbmcgd2l0aCBUcnVzdA0KPiA+ID4gPiA+ID4gPiBEb21haW4gKFREKSBwYXJ0
aXRpb25pbmcgZW5hYmxlZC4gVEQgcGFydGl0aW9uaW5nIGlzIGxpa2UgbmVzdGVkIHZpcnR1YWxp
emF0aW9uDQo+ID4gPiA+ID4gPiA+IGluc2lkZSB0aGUgVHJ1c3QgRG9tYWluIHNvIHRoZXJlIGlz
IGEgTDEgVEQgVk0oTSkgYW5kIHRoZXJlIGNhbiBiZSBMMiBURCBWTShzKS4NCj4gPiA+ID4gPiA+
ID4gDQo+ID4gPiA+ID4gPiA+IEluIHRoaXMgYXJyYW5nZW1lbnQgd2UgYXJlIG5vdCBndWFyYW50
ZWVkIHRoYXQgdGhlIFREWF9DUFVJRF9MRUFGX0lEIGlzIHZpc2libGUNCj4gPiA+ID4gPiA+ID4g
dG8gTGludXggcnVubmluZyBhcyBhbiBMMiBURCBWTS4gVGhpcyBpcyBiZWNhdXNlIGEgbWFqb3Jp
dHkgb2YgVERYIGZhY2lsaXRpZXMNCj4gPiA+ID4gPiA+ID4gYXJlIGNvbnRyb2xsZWQgYnkgdGhl
IEwxIFZNTSBhbmQgdGhlIEwyIFREWCBndWVzdCBuZWVkcyB0byB1c2UgVEQgcGFydGl0aW9uaW5n
DQo+ID4gPiA+ID4gPiA+IGF3YXJlIG1lY2hhbmlzbXMgZm9yIHdoYXQncyBsZWZ0LiBTbyBjdXJy
ZW50bHkgc3VjaCBndWVzdHMgZG8gbm90IGhhdmUNCj4gPiA+ID4gPiA+ID4gWDg2X0ZFQVRVUkVf
VERYX0dVRVNUIHNldC4NCj4gPiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiA+IFdlIHdhbnQgdGhl
IGtlcm5lbCB0byBoYXZlIFg4Nl9GRUFUVVJFX1REWF9HVUVTVCBzZXQgZm9yIGFsbCBURFggZ3Vl
c3RzIHNvIHdlDQo+ID4gPiA+ID4gPiA+IG5lZWQgdG8gY2hlY2sgdGhlc2UgYWRkaXRpb25hbCBD
UFVJRCBiaXRzLCBidXQgd2Ugc2tpcCBmdXJ0aGVyIGluaXRpYWxpemF0aW9uDQo+ID4gPiA+ID4g
PiA+IGluIHRoZSBmdW5jdGlvbiBhcyB3ZSBhcmVuJ3QgZ3VhcmFudGVlZCBhY2Nlc3MgdG8gVERY
IG1vZHVsZSBjYWxscy4NCj4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gSSBkb24ndCBmb2xsb3cu
IFRoZSBpZGVhIG9mIHBhcnRpdGlvbmluZyBpcyB0aGF0IEwyIE9TIGNhbiBiZQ0KPiA+ID4gPiA+
ID4gdW5lbmxpZ2h0ZW5lZCBhbmQgaGF2ZSBubyBpZGVhIGlmIGl0IHJ1bnMgaW5kaWRlIG9mIFRE
LiBCdXQgdGhpcyBwYXRjaA0KPiA+ID4gPiA+ID4gdHJpZXMgdG8gZW51bWVyYXRlIFREWCBhbnl3
YXkuDQo+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+IFdoeT8NCj4gPiA+ID4gPiA+IA0KPiA+ID4g
PiA+IA0KPiA+ID4gPiA+IFRoYXQncyBub3QgdGhlIG9ubHkgaWRlYSBvZiBwYXJ0aXRpb25pbmcu
IFBhcnRpdGlvbmluZyBwcm92aWRlcyBkaWZmZXJlbnQgcHJpdmlsZWdlDQo+ID4gPiA+ID4gbGV2
ZWxzIHdpdGhpbiB0aGUgVEQsIGFuZCB1bmVubGlnaHRlbmVkIEwyIE9TIGNhbiBiZSBtYWRlIHRv
IHdvcmsgYnV0IGFyZSBpbmVmZmljaWVudC4NCj4gPiA+ID4gPiBJbiBvdXIgY2FzZSBMaW51eCBh
bHdheXMgcnVucyBlbmxpZ2h0ZW5lZCAoYm90aCB3aXRoIGFuZCB3aXRob3V0IFREIHBhcnRpdGlv
bmluZyksIGFuZA0KPiA+ID4gPiA+IHVzZXMgVERYIGZ1bmN0aW9uYWxpdHkgd2hlcmUgYXBwbGlj
YWJsZSAoVERYIHZtY2FsbHMsIFBURSBlbmNyeXB0aW9uIGJpdCkuDQo+ID4gPiA+IA0KPiA+ID4g
PiBXaGF0IHZhbHVlIEwxIGFkZHMgaW4gdGhpcyBjYXNlPyBJZiBMMiBoYXMgdG8gYmUgZW5saWdo
dGVuZWQganVzdCBydW4gdGhlDQo+ID4gPiA+IGVubGlnaHRlbmVkIE9TIGRpcmVjdGx5IGFzIEwx
IGFuZCBkaXRjaCBoYWxmLW1lYXN1cmVzLiBJIHRoaW5rIHlvdSBjYW4NCj4gPiA+ID4gZ2FpbiBz
b21lIHBlcmZvcm1hbmNlIHRoaXMgd2F5Lg0KPiA+ID4gPiANCj4gPiA+IA0KPiA+ID4gSXQncyBw
cmltYXJpbHkgYWJvdXQgdGhlIHByaXZpbGVnZSBzZXBhcmF0aW9uLCBwZXJmb3JtYW5jZSBpcyBh
IHJlYXNvbg0KPiA+ID4gb25lIGRvZXNuJ3Qgd2FudCB0byBydW4gdW5lbmxpZ2h0ZW5lZC4gVGhl
IEwxIG1ha2VzIHRoZSBmb2xsb3dpbmcgcG9zc2libGU6DQo+ID4gPiAtIFRQTSBlbXVsYXRpb24g
d2l0aGluIHRoZSB0cnVzdCBkb21haW4gYnV0IGlzb2xhdGVkIGZyb20gdGhlIE9TDQo+ID4gPiAt
IGluZnJhc3RydWN0dXJlIGludGVyZmFjZXMgZm9yIHRoaW5ncyBsaWtlIFZNIGxpdmUgbWlncmF0
aW9uDQo+ID4gPiAtIHN1cHBvcnQgZm9yIFZpcnR1YWwgVHJ1c3QgTGV2ZWxzWzFdLCBWaXJ0dWFs
IFNlY3VyZSBNb2RlWzJdDQo+ID4gPiANCj4gPiA+IFRoZXNlIHByb3ZpZGUgYSBsb3Qgb2YgdmFs
dWUgdG8gdXNlcnMsIGl0J3Mgbm90IGF0IGFsbCBhYm91dCBoYWxmLW1lYXN1cmVzLg0KDQpJdCdz
IG5vdCBvYnZpb3VzIHdoeSB0aGUgbGlzdGVkIHRoaW5ncyBhYm92ZSBhcmUgcmVsYXRlZCB0byBU
RFggZ3Vlc3QuICBUaGV5DQpsb29rIG1vcmUgbGlrZSBoeXBlcnYgc3BlY2lmaWMgZW5saWdodGVu
bWVudCB3aGljaCBkb24ndCBoYXZlIGRlcGVuZGVuY3kgb2YgVERYDQpndWVzdC4NCg0KRm9yIGlu
c3RhbmNlLCB0aGUgIkVtdWxhdGluZyBIeXBlci1WIFZTTSB3aXRoIEtWTSIgZGVzaWduIGluIHlv
dXIgYWJvdmUgWzJdIHNheXMNCm5vdGhpbmcgYWJvdXQgVERYIChvciBTRVYpOg0KDQpodHRwczov
L2xvcmUua2VybmVsLm9yZy9sa21sLzIwMjMxMTA4MTExODA2LjkyNjA0LTM0LW5zYWVuekBhbWF6
b24uY29tLw0KDQo+ID4gDQo+ID4gSG0uIE9rYXkuDQo+ID4gDQo+ID4gQ2FuIHdlIHRha2UgYSBz
dGVwIGJhY2s/IFdoYXQgaXMgYmlnZ2VyIHBpY3R1cmUgaGVyZT8gV2hhdCBlbmxpZ2h0ZW5tZW50
DQo+ID4gZG8geW91IGV4cGVjdCBmcm9tIHRoZSBndWVzdCB3aGVuIGV2ZXJ5dGhpbmcgaXMgaW4t
cGxhY2U/DQo+ID4gDQo+IA0KPiBBbGwgdGhlIGZ1bmN0aW9uYWwgZW5saWdodGVubWVudCBhcmUg
YWxyZWFkeSBpbiBwbGFjZSBpbiB0aGUga2VybmVsIGFuZA0KPiBldmVyeXRoaW5nIHdvcmtzIChj
b3JyZWN0IG1lIGlmIEknbSB3cm9uZyBEZXh1YW4vTWljaGFlbCkuIFRoZSBlbmxpZ2h0ZW5tZW50
cw0KPiBhcmUgdGhhdCBURFggVk1DQUxMcyBhcmUgbmVlZGVkIGZvciBNU1IgbWFuaXB1bGF0aW9u
IGFuZCB2bWJ1cyBvcGVyYXRpb25zLA0KPiBlbmNyeXB0ZWQgYml0IG5lZWRzIHRvIGJlIG1hbmlw
dWxhdGVkIGluIHRoZSBwYWdlIHRhYmxlcyBhbmQgcGFnZQ0KPiB2aXNpYmlsaXR5IHByb3BhZ2F0
ZWQgdG8gVk1NLg0KDQpOb3QgcXVpdGUgZmFtaWx5IHdpdGggaHlwZXJ2IGVubGlnaHRlbm1lbnRz
LCBidXQgYXJlIHRoZXNlIGVubGlnaHRlbm1lbnRzIFREWA0KZ3Vlc3Qgc3BlY2lmaWM/ICBCZWNh
dXNlIGlmIHRoZXkgYXJlIG5vdCwgdGhlbiB0aGV5IHNob3VsZCBiZSBhYmxlIHRvIGJlDQplbXVs
YXRlZCBieSB0aGUgbm9ybWFsIGh5cGVydiwgdGh1cyB0aGUgaHlwZXJ2IGFzIEwxICh3aGljaCBp
cyBURFggZ3Vlc3QpIGNhbg0KZW11bGF0ZSB0aGVtIHcvbyBsZXR0aW5nIHRoZSBMMiBrbm93IHRo
ZSBoeXBlcnZpc29yIGl0IHJ1bnMgb24gaXMgYWN0dWFsbHkgYSBURFgNCmd1ZXN0Lg0KDQpCdHcs
IGV2ZW4gaWYgdGhlcmUncyBwZXJmb3JtYW5jZSBjb25jZXJuIGhlcmUsIGFzIHlvdSBtZW50aW9u
ZWQgdGhlIFREVk1DQUxMIGlzDQphY3R1YWxseSBtYWRlIHRvIHRoZSBMMCB3aGljaCBtZWFucyBM
MCBtdXN0IGJlIGF3YXJlIHN1Y2ggVk1DQUxMIGlzIGZyb20gTDIgYW5kDQpuZWVkcyB0byBiZSBp
bmplY3RlZCB0byBMMSB0byBoYW5kbGUsIHdoaWNoIElNSE8gbm90IG9ubHkgY29tcGxpY2F0ZXMg
dGhlIEwwIGJ1dA0KYWxzbyBtYXkgbm90IGhhdmUgYW55IHBlcmZvcm1hbmNlIGJlbmVmaXRzLg0K
DQo+IA0KPiBXaGF0cyBtaXNzaW5nIGlzIHRoZSB0ZHhfZ3Vlc3QgZmxhZyBpcyBub3QgZXhwb3Nl
ZCB0byB1c2Vyc3BhY2UgaW4gL3Byb2MvY3B1aW5mbywNCj4gYW5kIGFzIGEgcmVzdWx0IGRtZXNn
IGRvZXMgbm90IGN1cnJlbnRseSBkaXNwbGF5Og0KPiAiTWVtb3J5IEVuY3J5cHRpb24gRmVhdHVy
ZXMgYWN0aXZlOiBJbnRlbCBURFgiLg0KPiANCj4gVGhhdCdzIHdoYXQgSSBzZXQgb3V0IHRvIGNv
cnJlY3QuDQo+IA0KPiA+IFNvIGZhciBJIHNlZSB0aGF0IHlvdSB0cnkgdG8gZ2V0IGtlcm5lbCB0
aGluayB0aGF0IGl0IHJ1bnMgYXMgVERYIGd1ZXN0LA0KPiA+IGJ1dCBub3QgcmVhbGx5LiBUaGlz
IGlzIG5vdCB2ZXJ5IGNvbnZpbmNpbmcgbW9kZWwuDQo+ID4gDQo+IA0KPiBObyB0aGF0J3Mgbm90
IGFjY3VyYXRlIGF0IGFsbC4gVGhlIGtlcm5lbCBpcyBydW5uaW5nIGFzIGEgVERYIGd1ZXN0IHNv
IEkNCj4gd2FudCB0aGUga2VybmVsIHRvIGtub3cgdGhhdC7CoA0KPiANCg0KQnV0IGl0IGlzbid0
LiAgSXQgcnVucyBvbiBhIGh5cGVydmlzb3Igd2hpY2ggaXMgYSBURFggZ3Vlc3QsIGJ1dCB0aGlz
IGRvZXNuJ3QNCm1ha2UgaXRzZWxmIGEgVERYIGd1ZXN0Lg0KDQo+IFREWCBpcyBub3QgYSBtb25v
bGl0aGljIHRoaW5nLCBpdCBoYXMgZGlmZmVyZW50DQo+IGZlYXR1cmVzIHRoYXQgY2FuIGJlIGlu
LXVzZSBhbmQgaXQgaGFzIGRpZmZlcmVuY2VzIGluIGJlaGF2aW9yIHdoZW4gcnVubmluZw0KPiB3
aXRoIFREIHBhcnRpdGlvbmluZyAoZXhhbXBsZTogbm8gI1ZFL1REWCBtb2R1bGUgY2FsbHMpLiBT
byB0aG9zZSBkaWZmZXJlbmNlcw0KPiBuZWVkIHRvIGJlIGNsZWFybHkgbW9kZWxlZCBpbiBjb2Rl
Lg0KDQpXZWxsIElNSE8gdGhpcyBpcyBhIGRlc2lnbiBjaG9pY2UgYnV0IG5vdCBhIGZhY3QuICBF
LmcuLCBpZiB3ZSBuZXZlciBzZXRzDQpURFhfR1VFU1QgZmxhZyBmb3IgTDIgdGhlbiBpdCBuYXR1
cmFsbHkgZG9lc24ndCB1c2UgVERYIGd1ZXN0IHJlbGF0ZWQgc3RhZmYuIA0KT3RoZXJ3aXNlIHdl
IG5lZWQgYWRkaXRpb25hbCBwYXRjaGVzIGxpa2UgeW91ciBwYXRjaCAyLzMgaW4gdGhpcyBzZXJp
ZXMgdG8gc3RvcA0KdGhlIEwyIHRvIHVzZSBjZXJ0YWluIFREWCBmdW5jdGlvbmFsaXR5Lg0KDQpB
bmQgSSBndWVzcyB3ZSB3aWxsIG5lZWQgbW9yZSBwYXRjaGVzIHRvIHN0b3AgTDIgZnJvbSBkb2lu
ZyBURFggZ3Vlc3QgdGhpbmdzLiANCkUuZy4sIHdlIG1pZ2h0IHdhbnQgdG8gZGlzYWJsZSBURFgg
YXR0ZXN0YXRpb24gaW50ZXJmYWNlIHN1cHBvcnQgaW4gdGhlIEwyDQpndWVzdCwgYmVjYXVzZSB0
aGUgTDIgaXMgaW5kZWVkIG5vdCBhIFREWCBndWVzdC4uDQoNClNvIHRvIG1lIGV2ZW4gdGhlcmUn
cyB2YWx1ZSB0byBhZHZlcnRpc2UgTDIgYXMgVERYIGd1ZXN0LCB0aGUgcHJvcy9jb25zIG5lZWQg
dG8NCmJlIGV2YWx1YXRlZCB0byBzZWUgd2hldGhlciBpdCBpcyB3b3J0aC4NCg0KPiANCj4gPiBX
aHkgZG9lcyBMMiBuZWVkIHRvIGtub3cgaWYgaXQgcnVucyB1bmRlciBURFggb3IgU0VWPyBDYW4n
dCBpdCBqdXN0IHRoaW5rDQo+ID4gaXQgcnVucyBhcyBIeXBlci1WIGd1ZXN0IGFuZCBhbGwgZGlm
ZmVyZW5jZSBiZXR3ZWVuIFREWCBhbmQgU0VWIGFic3RyYWN0ZWQNCj4gPiBieSBMMT8NCj4gPiAN
Cj4gDQo+IElmIHlvdSBsb29rIGludG8gdGhlIGdpdCBoaXN0b3J5IHlvdSdsbCBmaW5kIHRoaXMg
d2FzIGF0dGVtcHRlZCB3aXRoDQo+IENDX1ZFTkRPUl9IWVBFUlYuIFRoYXQgcHJvdmVkIHRvIGJl
IGEgZGVhZCBlbmQgYXMgc29tZSB0aGluZ3MganVzdCBjYW4ndCBiZQ0KPiBhYnN0cmFjdGVkIChH
SENJIHZzIEdIQ0I7IHRoZSBlbmNyeXB0ZWQgYml0IHdvcmtzIGRpZmZlcmVudGx5KS4gV2hhdCBy
ZXN1bHRlZA0KPiB3YXMgYSB0b24gb2YgY29uZGl0aW9uYWxzIGFuZCBkdXBsaWNhdGlvbi4gQWZ0
ZXIgbG9uZyBkaXNjdXNzaW9ucyB3aXRoIEJvcmlzbGF2DQo+IHdlIGNvbnZlcmdlZCBvbiBjbGVh
cmx5IGlkZW50aWZ5aW5nIHdpdGggdGhlIHVuZGVybHlpbmcgdGVjaG5vbG9neSAoU0VWL1REWCkN
Cj4gYW5kIGJlaW5nIGV4cGxpY2l0IGFib3V0IHN1cHBvcnQgZm9yIG9wdGlvbmFsIHBhcnRzIGlu
IGVhY2ggc2NoZW1lIChsaWtlIHZUT00pLg0KDQpDYW4geW91IHByb3ZpZGUgbW9yZSBiYWNrZ3Jv
dW5kPyAgRm9yIGluc3RhbmNlLCB3aHkgZG9lcyB0aGUgTDIgbmVlZHMgdG8ga25vdw0KdGhlIGVu
Y3J5cHRlZCBiaXQgdGhhdCBpcyBpbiAqTDEqPw0KDQoNCg==

