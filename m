Return-Path: <linux-hyperv+bounces-1137-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E91437FD460
	for <lists+linux-hyperv@lfdr.de>; Wed, 29 Nov 2023 11:37:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17BFD1C21154
	for <lists+linux-hyperv@lfdr.de>; Wed, 29 Nov 2023 10:37:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49E521945A;
	Wed, 29 Nov 2023 10:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T+0Z1Cyu"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E08B01BD4;
	Wed, 29 Nov 2023 02:37:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701254232; x=1732790232;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=i4l4KRa/iBFFh5gBuB1fXxkuY1R3AKXUZeY/lm1nGmI=;
  b=T+0Z1Cyuae9cuVZH3SR+Mvk/Te/VSajyEf+XPR/Z2ZL6E59fesuLbfdw
   EvFbcoQNIm1mJ0HdKO5JLwVTfkoCxPhK0sRmtOfV0QVdJTx0Ck5umh7rx
   CD5cVrMJhvfaJegRmnfgRynn2Bhc6bchg6Nr+4t7doxISMrSAHY3z6zY0
   6XjZl3MYx+ldiobDoPkS10HwGDXImCOqYmoE/3dzLfxRZyaYg30gvq2uk
   5dzBtu3hj3mISMiuOO21M1uVfUFSsEl9Vkfoh6VEU1L7wRYsSIFUWoj0A
   bG0M81YMaqe2wlRW3ol6F1OK6jrA25g09mohSj7fcXeMRyHhlSI709KvE
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10908"; a="373327241"
X-IronPort-AV: E=Sophos;i="6.04,235,1695711600"; 
   d="scan'208";a="373327241"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2023 02:37:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10908"; a="1016225012"
X-IronPort-AV: E=Sophos;i="6.04,235,1695711600"; 
   d="scan'208";a="1016225012"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 Nov 2023 02:37:12 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 29 Nov 2023 02:37:11 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 29 Nov 2023 02:37:11 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Wed, 29 Nov 2023 02:37:11 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Wed, 29 Nov 2023 02:37:11 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k6iKC00lEsCgAANCpXR4FbRiHPMPo+3/FBei0gqinkIZ9l/0C4MKLGhIPMmm7RGNgtCNbZQDmD+wFou3nXE22pXIW8CkmqGzGLS9cVQ9/lq6vxD4VswqTzqVR2K2SPWoMOn5iX7uIDBHeAjvNjCOsQlVS7PBpf/TwhvmeY3HCSRr+Mqym74710CeMCXH5asYiGNnyldl9OjUebyb7xaOjY2hn3ZhGfpmwxrm6nghJT4NyH7xRrHGPsTmN0NxXBgqfRRiy076yLECvXLyxS6nf/k1iUqHmAvAIUjqsS0XlD63wsp33Ve4GHAlrX6rOdIlVUnoJklsS7LCT40lqvSbJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i4l4KRa/iBFFh5gBuB1fXxkuY1R3AKXUZeY/lm1nGmI=;
 b=c2JjfuT/A8kV9de+82iAsAF0GHYWnx4Czfg1IUriXOkSrgKK2BTTUIMN/qwUgntbsquD5oe6ZYfFrxLxRxHETGb9M3gZ3WkDlF+JdltBXy0a407MH38ckx2tKOLPwDeThedGipSDkjII0GRkHrJEtyL+UvGwK28Nv1fh1UGEtGA5BFghtKmjQ1vDPWXR9d1CI3aLR9Al4yQXuoJhxWN8xeseprB9VPcUaLIqWR42hAqFde9rrbHX812/dEwWre4Gbp2qsQ7WWXrj9OkyJtK3Wh6H2rvSoZNTETjmfZPg6LqooC2oh+RNVzzYiTR1gMDuishExjDxY3hRvfnJ2Au9Zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by CY8PR11MB7876.namprd11.prod.outlook.com (2603:10b6:930:7d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.22; Wed, 29 Nov
 2023 10:37:03 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::5d1:aa22:7c98:f3c6]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::5d1:aa22:7c98:f3c6%7]) with mapi id 15.20.7025.022; Wed, 29 Nov 2023
 10:37:03 +0000
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
Subject: Re: [PATCH v1 2/3] x86/coco: Disable TDX module calls when TD
 partitioning is active
Thread-Topic: [PATCH v1 2/3] x86/coco: Disable TDX module calls when TD
 partitioning is active
Thread-Index: AQHaHWWid2FwGMDquEi3iQ4qhfNzPrCH854AgAFWWACAB9szAA==
Date: Wed, 29 Nov 2023 10:37:02 +0000
Message-ID: <ab1a3575ac66cf2f7cc05a21e5a20fbe415e834b.camel@intel.com>
References: <20231122170106.270266-1-jpiotrowski@linux.microsoft.com>
	 <20231122170106.270266-2-jpiotrowski@linux.microsoft.com>
	 <20231123141318.rmskhl3scc2a6muw@box.shutemov.name>
	 <837fb5e9-4a35-4e49-8ec6-1fcfd5a0da30@linux.microsoft.com>
In-Reply-To: <837fb5e9-4a35-4e49-8ec6-1fcfd5a0da30@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.48.4 (3.48.4-1.fc38) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|CY8PR11MB7876:EE_
x-ms-office365-filtering-correlation-id: 1eacce64-8d01-4a48-8eea-08dbf0c71fdf
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9fbS+Jral1HpgK6uu+lgb18GrcOVTMZtx3Cb8RtlOt12R7HXlmqV/lbVs9ddLTAH140tvFpnpjqP5lgydmTZET7fdJA6pbV+l67MerqPOt7DzCSu/4njBgZYzJF1pZR7Jc4DR59mC5ZTcCP/qrlGFxcYG6grVOxS6WTU5YBs3jYc6rOPhPPQn0Sf/mP0peLw4m5aV34z7d8eiL2YuzphR3ulKdPDTI10hJ7mgA7/jSW1aoT4S5I7IeM7DCzgbTMbDbgbd2y8j2bwAXQv0ZEIFhtKEBnnPJAiYy1bTLlVfIRQ6zkcvheqof6XZZ/Km0xzJeAYEiGLQVcox+tC70FaAGIjV/sHoFWzwGhKolsjw0H3/j73mRWoqK1YapQsV/txe7ZShjY0OUEkR/Ze39g9yWlRcdJprDwJwSe5whJurliAjNQZmpyMM14tWAvfFB1giAFXJbyyrAEkHW2B0X1UuZ+s3ZdKp4xziMpzdzJRttFudmT3jZBHH2YiYHUcyKms8qc+szGueEANjcysQ3AmZm6fjrTJ9UM5AK4i7GLI0YvK93nhQfh6LRUoQEr/SldamnnRz/ya2UbOj/tavwfTiUPZhIP7DxRSyDZ3lCQCgHAVUV1ZsKTLp+Q2re+d5JD6
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(366004)(376002)(39860400002)(346002)(230922051799003)(186009)(1800799012)(64100799003)(451199024)(6512007)(2616005)(26005)(478600001)(36756003)(82960400001)(122000001)(86362001)(38100700002)(38070700009)(83380400001)(7416002)(4001150100001)(5660300002)(6506007)(71200400001)(66556008)(54906003)(64756008)(66476007)(4326008)(316002)(66446008)(53546011)(8936002)(2906002)(6486002)(41300700001)(110136005)(91956017)(66946007)(8676002)(76116006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TE9uTWMrMXFKbko1ck9wRUhwSlFCNWUwNHVVUko0KzBmaXpBUVVtWnVkVEFk?=
 =?utf-8?B?RU9VbUtFZDQ0cWFaZzQ4dzRrbExlYVdNWWlJeDFlYXp6RlZkUm9HeGFlLzdW?=
 =?utf-8?B?YkhxanVrZWxQcitVd1VicndOSnVWaTduZkRqeGlCMERLbXZ4SWRDbysrYUNX?=
 =?utf-8?B?ZGFXRElrQ2hBNmx1TjZ4QWp5cUdrcFBuRXRRcGduZ3k4cWNsVDZYTy80Um81?=
 =?utf-8?B?ekNKcUFkU0MweW9qWTNubnJ1UHNoekpTUGNoK0E3NFNNdG41R2J1MmZvSHZ5?=
 =?utf-8?B?QWQ5T09HWm95WVM3S0tpQzI0Z1NqM1QxT3dhT3Z1NUF4NHFDRkllKzUxbElC?=
 =?utf-8?B?dFE5VnYxYXNpSWg3RTZ1Nm1Ed3J3S1BaQUhWNnh1K3VQdkkzSitIQjV0ZmpE?=
 =?utf-8?B?eURDTUh6RVhBZWc0RTMwa0hwREt5K0JkcXhPZnZId0RtM2hRRVFNTnVEL0dw?=
 =?utf-8?B?b01ORERGc05nQ1Q1SHhLaUlram9YTVJPMnEvZkFMb0djLzY5LzRla1pVUG1V?=
 =?utf-8?B?TFkyWS8vcVYxeUpSNkVCRGRSQWRYcno3RDgyRGgwZFhDZjJJNVpsKzJsSUI1?=
 =?utf-8?B?N1MxdEd5RFByOGMzVXRObFBabWtLK2ZrZEd5aVJKR0Y1V3BURXhUVXh5R1kw?=
 =?utf-8?B?RC9UWHIrSEJTU0ZzMmlTT3haanoxWjg2dGdaNnBsYnBkSlVLRlEvVHREN3NL?=
 =?utf-8?B?SXFxZERjZTR6SDZ2Z0ZVQXhqN3Q5TEpXL09JQ0V6L1d0VHFHTlZyYW9aNXJY?=
 =?utf-8?B?QWxKNHV2dDJPNW1QaHJaelE0MHNyazNrbktZSEdTVE5oQi9rOVdqaTU2Y215?=
 =?utf-8?B?cUZkTncyZTN3RXRENGpIeHp2d2haQ25lVkV5UW9TbTBtUndsMHZiVTQ5b3Vz?=
 =?utf-8?B?OCs3eWxGRUNlY2xKdHlEZzFQaWNpRUxmWDRWaEpaMS96bFNCVllkM1I3MG0y?=
 =?utf-8?B?U1NOU3FCVmdSY1REK0UvcjJRMnZPd0FNRUpFMmlNSG9vRWMxRzM3VExKRzhQ?=
 =?utf-8?B?Nk8ycitNc0swYlJ4OFM0c2d3c0tMR3JxTVNTUStYZS9iUWM1QUYyR3U5V2pl?=
 =?utf-8?B?ejNNQ21QeVVRWEZnRUpTNWwrSFN6T05QNytHSlZDN3FTcS9CZlhOMmZxeGEx?=
 =?utf-8?B?YkV3bjN1SGFHM2IxMi9IeXp1UG9jUFdlUTZvZ1h3TVo0SE5LbXBiZDd0YzlD?=
 =?utf-8?B?TnF4dW9SLzdZYXM2SnAvb2FNR2xVZHU0WWY2QWxmeHN3VXZkZk5XbVhOcE9U?=
 =?utf-8?B?WTdha0wzOEVvNVhlTmxUb3dSdFlZdlNqdUxOWXdEU0pvTnFET1hJdEJOR3Ey?=
 =?utf-8?B?aVRFRlZwOFlvTCtXNWJDT0ZvME9ud1BnTEp5RVlHNm03NmllMThnRnNkVjg4?=
 =?utf-8?B?LzdTcXZ4WG5NNHNaUkUrSWNIM0FvRWhac2V1UTRDQTFzeEZLNkNKL3pDWWp0?=
 =?utf-8?B?WHc1em9RN0Z4S1cxdXVwZGNmVHAxUDFDbmNYU0J1bmE0VlZFT3p4c0ZnLzgx?=
 =?utf-8?B?eWNPM2pXcjZEOXVnZERxOG1wQ0pRN3ljQ0F0NUdkR1ZDTlR6Z1JOeHlpRmhq?=
 =?utf-8?B?T1BHb0JPK0tsM1p2cGtxaGVuVGdtZDJWUnRZREIzQ3pJdk1DTE12SkM2MW5E?=
 =?utf-8?B?NTJzTTBydm0xdE5HVHRUU0RaMGIwV0ZhZ280YU5qdUFXU1BSWkFCbXc4bU5B?=
 =?utf-8?B?bkFKZy84bmpVZFVHaFk4OEpCTlJGSFNEQkdteDkwQnF6REMvQnowVWpIK01z?=
 =?utf-8?B?MHpMYTdad043bkRDL3F6Rzl6MElNNlUxdzM3NlUrNzh0aFpGYW5SeGgvaHRv?=
 =?utf-8?B?bUliZUFmaSswNXdkMldlYXNLdC85OW9IeDBZZ1R6SXZlc2VBcDJOZVJDcXAz?=
 =?utf-8?B?NFZDZTNnOUtmU3hBYVMrZEtKeDBibWpDTTlNWkptM0V0UnlsZlM3NjNreVdI?=
 =?utf-8?B?cGM0VTU5WGlNc0FzU2FoN0JrSzBnalRvajZ2QU1sc3RhWS9pSFkwSDdRUlRr?=
 =?utf-8?B?WGZxVEcvTTB1bHpoTlUzMnFkbk90TDMwK3lsM3JaL25TVzFTUHhxbDk0b3Ix?=
 =?utf-8?B?ZG9OVGpvMndRWVdXMjBWUG9mQWFIVUc4cTh2V1VMODYzTC9vMi9wYnJmVW8z?=
 =?utf-8?B?cThMdW5qVzJRUDV4SG9ZZ25ReHpjUFRCTEFpTUF0WUU0WHpMejdia1B2cXlQ?=
 =?utf-8?B?bXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B42DCD6FD521C44985414F5219A78E17@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1eacce64-8d01-4a48-8eea-08dbf0c71fdf
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Nov 2023 10:37:02.6446
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1nio0sktUegsn3//R4rin4gG4yMU++5ESc0XYX7OdYf3UcsDkutJdM2mWQKqTWbD5ddWLx6UOs0+hGRD+K0/pw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7876
X-OriginatorOrg: intel.com

T24gRnJpLCAyMDIzLTExLTI0IGF0IDExOjM4ICswMTAwLCBKZXJlbWkgUGlvdHJvd3NraSB3cm90
ZToNCj4gT24gMjMvMTEvMjAyMyAxNToxMywgS2lyaWxsIEEuIFNodXRlbW92IHdyb3RlOg0KPiA+
IE9uIFdlZCwgTm92IDIyLCAyMDIzIGF0IDA2OjAxOjA1UE0gKzAxMDAsIEplcmVtaSBQaW90cm93
c2tpIHdyb3RlOg0KPiA+ID4gSW50cm9kdWNlIENDX0FUVFJfVERYX01PRFVMRV9DQUxMUyB0byBh
bGxvdyBjb2RlIHRvIGNoZWNrIHdoZXRoZXIgVERYIG1vZHVsZQ0KPiA+ID4gY2FsbHMgYXJlIGF2
YWlsYWJsZS4gV2hlbiBURCBwYXJ0aXRpb25pbmcgaXMgZW5hYmxlZCwgYSBMMSBURCBWTU0gaGFu
ZGxlcyBtb3N0DQo+ID4gPiBURFggZmFjaWxpdGllcyBhbmQgdGhlIGtlcm5lbCBydW5uaW5nIGFz
IGFuIEwyIFREIFZNIGRvZXMgbm90IGhhdmUgYWNjZXNzIHRvDQo+ID4gPiBURFggbW9kdWxlIGNh
bGxzLiBUaGUga2VybmVsIHN0aWxsIGhhcyBhY2Nlc3MgdG8gVERWTUNBTEwoMCkgd2hpY2ggaXMg
Zm9yd2FyZGVkDQo+ID4gPiB0byB0aGUgVk1NIGZvciBwcm9jZXNzaW5nLCB3aGljaCBpcyB0aGUg
TDEgVEQgVk0gaW4gdGhpcyBjYXNlLg0KPiA+IA0KPiANCj4gQ29ycmVjdGlvbjogaXQgdHVybnMg
b3V0IFREVk1DQUxMKDApIGlzIGhhbmRsZWQgYnkgTDAgVk1NLg0KPiA+IA0KDQpTb21lIHRob3Vn
aHRzIGFmdGVyIGNoZWNraW5nIHRoZSBzcGVjIG1vcmUgdG8gbWFrZSBzdXJlIHdlIGRvbid0IGhh
dmUNCm1pc3VuZGVyc3RhbmRpbmcgb24gZWFjaCBvdGhlcjoNCg0KVGhlIFREWCBtb2R1bGUgd2ls
bCB1bmNvbmRpdGlvbmFsbHkgZXhpdCB0byBMMSBmb3IgYW55IFREQ0FMTCAoZXhjZXB0IHRoZQ0K
VERWTUNBTEwpIGZyb20gdGhlIEwyLiAgVGhpcyBpcyBleHBlY3RlZCBiZWhhdmlvdXIuICBCZWNh
dXNlIHRoZSBMMiBpc24ndCBhIHRydWUNClREWCBndWVzdCwgTDEgaXMgZXhwZWN0ZWQgdG8gaW5q
ZWN0IGEgI1VEIG9yICNHUCBvciB3aGF0ZXZlciBlcnJvciB0byBMMiBiYXNlZA0Kb24gdGhlIGhh
cmR3YXJlIHNwZWMgdG8gbWFrZSBzdXJlIEwyIGdldHMgYW4gY29ycmVjdCBhcmNoaXRlY3R1cmFs
IGJlaGF2aW91ciBmb3INCnRoZSBURENBTEwgaW5zdHJ1Y3Rpb24uDQoNCkkgYmVsaWV2ZSB0aGlz
IGlzIGFsc28gdGhlIHJlYXNvbiB5b3UgbWVudGlvbmVkICJMMiBURCBWTSBkb2VzIG5vdCBoYXZl
IGFjY2Vzcw0KdG8gVERYIG1vZHVsZSBjYWxscyIuDQoNCkhvd2V2ZXIgVERYIG1vZHVsZSBhY3R1
YWxseSBhbGxvd3MgdGhlIEwxIHRvIGNvbnRyb2wgd2hldGhlciB0aGUgTDIgaXMgYWxsb3dlZA0K
dG8gZXhlY3V0ZSBURFZNQ0FMTCBieSBjb250cm9sbGluZyB3aGV0aGVyIHRoZSBURFZNQ0FMTCBm
cm9tIEwyIHdpbGwgZXhpdCB0byBMMA0Kb3IgTDEuDQoNCkkgYmVsaWV2ZSB5b3UgbWVudGlvbmVk
ICJURFZNQ0FMTCgwKSBpcyBoYW5kbGVkIGJ5IEwwIFZNTSIgaXMgYmVjYXVzZSB0aGUgTDENCmh5
cGVydmlzb3IgLS0gc3BlY2lmaWNhbGx5LCBoeXBlcnYgLS0gY2hvb3NlcyB0byBsZXQgdGhlIFRE
Vk1DQUxMIGZyb20gTDIgZXhpdA0KdG8gTDA/DQoNCkJ1dCBJTUhPIHRoaXMgaXMgcHVyZWx5IHRo
ZSBoeXBlcnYncyBpbXBsZW1lbnRhdGlvbiwgaS5lLiwgS1ZNIGNhbiBjaG9vc2Ugbm90IHRvDQpk
byBzbywgYW5kIHNpbXBseSBoYW5kbGUgVERWTUNBTEwgaW4gdGhlIHNhbWUgd2F5IGFzIGl0IGhh
bmRsZXMgbm9ybWFsIFREQ0FMTCAtLQ0KaW5qZWN0IHRoZSBhcmNoaXRlY3R1cmUgZGVmaW5lZCBl
cnJvciB0byBMMi4NCg0KQWxzbyBBRkFJQ1QgdGhlcmUncyBubyBhcmNoaXRlY3R1cmFsIHRoaW5n
IHRoYXQgY29udHJvbGxlZCBieSBMMiB0byBhbGxvdyB0aGUgTDENCmtub3cgd2hldGhlciBMMiBp
cyBleHBlY3RpbmcgdG8gdXNlIFREVk1DQUxMIG9yIG5vdC4gIEluIG90aGVyIHdvcmRzLCB3aGV0
aGVyIHRvDQpzdXBwb3J0IFREVk1DQUxMIGlzIHB1cmVseSBMMSBoeXBlcnZpc29yIGltcGxlbWVu
dGF0aW9uIHNwZWNpZmljLg0KDQpTbyB0byBtZSB0aGlzIHdob2xlIHNlcmllcyBpcyBoeXBlcnYg
c3BlY2lmaWMgZW5saWdodGVubWVudCBmb3IgdGhlIEwyIHJ1bm5pbmcNCm9uIFREWCBndWVzdCBo
eXBlcnYgTDEuICBBbmQgYmVjYXVzZSBvZiB0aGF0LCBwZXJoYXBzIGEgYmV0dGVyIHdheSB0byBk
byBpczoNCg0KMSkgVGhlIGRlZmF1bHQgTDIgc2hvdWxkIGp1c3QgYmUgYSBub3JtYWwgVk0gdGhh
dCBhbnkgVERYIGd1ZXN0IEwxIGh5cGVydmlzb3INCnNob3VsZCBiZSBhYmxlIHRvIGhhbmRsZSAo
Z3VhcmFudGVlZCBieSB0aGUgVERYIHBhcnRpdGlvbmluZyBhcmNoaXRlY3R1cmUpLg0KDQoyKSBE
aWZmZXJlbnQgTDIvTDEgaHlwZXJ2aXNvciBjYW4gaGF2ZSBpdCdzIG93biBlbmxpZ2h0ZW5tZW50
cy4gIFdlIGNhbiBldmVuDQpoYXZlIGNvbW1vbiBlbmxpZ2h0ZW5tZW50cyBhY3Jvc3MgZGlmZmVy
ZW50IGltcGxlbWVudGF0aW9uIG9mIEwxIGh5cGVydmlzb3JzLA0KYnV0IHRoYXQgcmVxdWlyZXMg
Y3Jvc3MtaHlwZXJ2aXNvciBjb29wZXJhdGlvbi4NCg0KQnV0IElNSE8gaXQncyBub3QgYSBnb29k
IGlkZWEgdG8gc2F5Og0KDQoJTDIgaXMgcnVubmluZyBvbiBhIFREWCBwYXJ0aXRpb25pbmcgZW5h
YmxlZCBlbnZpcm9ubWVudCwgbGV0IHVzIG1hcmsgaXQNCglhcyBhIFREWCBndWVzdCBidXQgbWFy
ayBpdCBhcyAiVERYIHBhcnRpdGlvbmluZyIgdG8gZGlzYWJsZSBjb3VwbGUgb2bCoA0KCVREWCBm
dW5jdGlvbmFsaXRpZXMuDQoNCkluc3RlYWQsIHBlcmhhcHMgaXQncyBiZXR0ZXIgdG8gbGV0IEwy
IGV4cGxpY2l0bHkgb3B0LWluIFREWCBmYWNpbGl0aWVzIHRoYXQgdGhlDQp1bmRlcm5lYXRoIGh5
cGVydmlzb3Igc3VwcG9ydHMuDQoNClREVk1DQUxMIGNhbiBiZSB0aGUgZmlyc3QgZmFjaWxpdHkg
dG8gYmVnaW4gd2l0aC4NCg0KQXQgbGFzdCwgZXZlbiBURFZNQ0FMTCBoYXMgYnVuY2ggb2YgbGVh
ZnMsIGFuZCBoeXBlcnZpc29yIGNhbiBjaG9vc2UgdG8gc3VwcG9ydA0KdGhlbSBvciBub3QuICBV
c2UgYSBzaW5nbGUgInRkeF9wYXJ0aXRpb25pbmdfYWN0aXZlIiB0byBzZWxlY3Qgd2hhdCBURFgN
CmZhY2lsaXRpZXMgYXJlIHN1cHBvcnRlZCBkb2Vzbid0IHNlZW0gYSBnb29kIGlkZWEuDQoNClRo
YXQncyBteSAyY2VudHMgdy9vIGtub3dpbmcgZGV0YWlscyBvZiBoeXBlcnYgZW5saWdodGVubWVu
dHMuDQoNCg==

