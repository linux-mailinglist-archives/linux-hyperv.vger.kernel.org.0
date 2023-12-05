Return-Path: <linux-hyperv+bounces-1240-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E3C098055CD
	for <lists+linux-hyperv@lfdr.de>; Tue,  5 Dec 2023 14:25:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6FC2E1F214B3
	for <lists+linux-hyperv@lfdr.de>; Tue,  5 Dec 2023 13:25:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04D9B5D49A;
	Tue,  5 Dec 2023 13:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IxkuM9Zm"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8383194;
	Tue,  5 Dec 2023 05:24:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701782696; x=1733318696;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=vMuIrQFPhcYydWBQNA7UjLpQ0f+D1Bub560HrackFkg=;
  b=IxkuM9ZmpgOJGzz7LG/KHNn3Nv6jIsdokzgFOT6XXYy+5F0BUf0KANtQ
   LEMKPRlv8jKlXtRD2fXz6gfsXDovKp8ggOM77+0husk9oHahjSqh8JZKy
   zfcMl2PEReCQrtGfkUxWgfaU1q6c4KJhQZg5TLN8/QmYfKB6NNRjs5r7P
   ufxUSmw42iNzrF1ExZwsHEf/wkVNRkKaM9PB46voQ9ZmUSJ6gl7iBg4FZ
   5jDKMmkQZB2x9Wzz4YlhT6fKb4YYCR3mEfaQIt159Qu/7dm5KxGbxGtIt
   O2zeWG+oRTNdHzlrArTfkNXONJR3z0KLA6cGVApXjtmPWhZdpHAAJwmVj
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10914"; a="12608556"
X-IronPort-AV: E=Sophos;i="6.04,252,1695711600"; 
   d="scan'208";a="12608556"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2023 05:24:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10914"; a="861743096"
X-IronPort-AV: E=Sophos;i="6.04,252,1695711600"; 
   d="scan'208";a="861743096"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by FMSMGA003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Dec 2023 05:24:54 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 5 Dec 2023 05:24:52 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 5 Dec 2023 05:24:52 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Tue, 5 Dec 2023 05:24:52 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jPSZZ/b0hiOzD5ba7ZTYYQKJ7dgO/uWDlc8Ix/F5nS0EOc+XEyNvTgbEn1kZJdKvN5ziqH8g8HD9UoridYWemd7Ks+9P0JM7yfqf8qcvyCOJZNGDAWrMQGKRgbt+LH9Eco/h3mqPbJZmBZVGTTaI+tTjC99P1R14MkaBIfLeTsoLuYKi4lJjLbfuvPC46/kCMcE9ivSJNgSo7U9xbdmoEIy2vPU28tPa688pwTt3dBRZqKUOGqSGoKHPeZ16U3NPWAYsaL5n+fC/6yqTyolFSkl7SZuvdYTF4wkKmrJAr/HdFzblHoS1uk5g7grkEsrysOsXgOfnkRixl5gBMjQg/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vMuIrQFPhcYydWBQNA7UjLpQ0f+D1Bub560HrackFkg=;
 b=UZuM2yqnNim1MCcdC1MlrplSo0bnXwMmEMwmff/UgNtAD06cxL5tMtDtGRrJsgNcLcN8UgVEPVYytLyuOLpy2+o7FC+7b+9YnVFiagf0dRMzBxcWZKaMqyxlhGpzoyVeXQ8Wqafn0ASQX4MU5GT5G5Cyguqvh0UC6hJXPs3feX7kU6YRMmmq74D1l6dt7wfBN4854lp7V2YZscqjtnFayqSc/6HWFgowN16y0gFwL/xlXDefEI6f9ltkxw1i8wdITs99LLyTBfrnaKnyIeibhl2eiuAHeRw8nz4VPpm7N5Tazce+g+u48TuFYck6Kr5LzNhmp1A/CgmOMaBkTUiBZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM8PR11MB5750.namprd11.prod.outlook.com (2603:10b6:8:11::17) by
 PH7PR11MB6746.namprd11.prod.outlook.com (2603:10b6:510:1b4::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Tue, 5 Dec
 2023 13:24:50 +0000
Received: from DM8PR11MB5750.namprd11.prod.outlook.com
 ([fe80::f1b2:bfb1:b1b:66ed]) by DM8PR11MB5750.namprd11.prod.outlook.com
 ([fe80::f1b2:bfb1:b1b:66ed%3]) with mapi id 15.20.7046.034; Tue, 5 Dec 2023
 13:24:49 +0000
From: "Reshetova, Elena" <elena.reshetova@intel.com>
To: Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Borislav
 Petkov" <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter
 Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, "Kirill A. Shutemov"
	<kirill.shutemov@linux.intel.com>, Michael Kelley <mhkelley58@gmail.com>,
	Nikolay Borisov <nik.borisov@suse.com>, Peter Zijlstra
	<peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Tom Lendacky
	<thomas.lendacky@amd.com>, "x86@kernel.org" <x86@kernel.org>, "Cui, Dexuan"
	<decui@microsoft.com>
CC: "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"stefan.bader@canonical.com" <stefan.bader@canonical.com>,
	"tim.gardner@canonical.com" <tim.gardner@canonical.com>,
	"roxana.nicolescu@canonical.com" <roxana.nicolescu@canonical.com>,
	"cascardo@canonical.com" <cascardo@canonical.com>, "kys@microsoft.com"
	<kys@microsoft.com>, "haiyangz@microsoft.com" <haiyangz@microsoft.com>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>, "sashal@kernel.org"
	<sashal@kernel.org>, "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH v1 1/3] x86/tdx: Check for TDX partitioning during early
 TDX init
Thread-Topic: [PATCH v1 1/3] x86/tdx: Check for TDX partitioning during early
 TDX init
Thread-Index: AQHaHWWtJXruLfiu906BueKp3+5D87CY5kFggACpPgCAATCzMA==
Date: Tue, 5 Dec 2023 13:24:49 +0000
Message-ID: <DM8PR11MB5750713BD093B1CDC209FB4CE785A@DM8PR11MB5750.namprd11.prod.outlook.com>
References: <20231122170106.270266-1-jpiotrowski@linux.microsoft.com>
 <DM8PR11MB575090573031AD9888D4738AE786A@DM8PR11MB5750.namprd11.prod.outlook.com>
 <9ab71fee-be9f-4afc-8098-ad9d6b667d46@linux.microsoft.com>
In-Reply-To: <9ab71fee-be9f-4afc-8098-ad9d6b667d46@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR11MB5750:EE_|PH7PR11MB6746:EE_
x-ms-office365-filtering-correlation-id: 43a683af-c29f-411b-8fad-08dbf5958e84
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cYkPtL9dL1WNaAs9IXiBgIeu4t4mvh1l/GslswjEcIBkD19gpIoAMdrA+Xb+/H+z6oEbmn+PilqMSC9nNXtLuBrU+pYlEzExloUMzTzQXZAz/BVqesip/a1gJUUT52WkIEa5lmqcSwbUiyQaAh7oOkyswDjpL2iTiW7G6Vp4CYLseWY6Ecgu0NRncpYs4eApmYn5gt475+oU/7+nRuf71tkCQGFOhm1wbTuxrdnguak6Z3E4C8RNNgoGn+WP9LIeRNYIWWHQpWICFYhng8HCVovu+PNg8IfwSeCIqLSYlpR06utaGnhCxBt4UCJ6RiVFFN9kkfA6WKLKntuvGDkNzuLDkiwPttEtJ4RQXH5rIhvdYmjfAmfLXqpLOxeEk3ILfpHnEVlOUIXedmHH4tBGk6xtnqBcgaBQXj12KsT9Tz0fMBowTXOP4+kyDwD5vQnjL8d0nbIeMN2WT7CxnWHS8rVAfklKKX53TwlgJbRy8h8OfmGYiKzJQZbuWIujvMaazyZmnadyVS9h0do7+hQwYz+xHixBSFlgDtn1ZhBFcZO0cxRmX31kje89lBFv71oLHwSHMYJ8h3t2eh9CxqVsXCOdSoPip3md6Fx/bPAPd4ZOtVcyKJ5zfiuleUzrcYoob013eH6vkMVxAe3WNercRbQBk/Idy9hIfXuI4MOlJP8q9iYXMDtaclYmwJdkiDVQ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5750.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(396003)(39860400002)(346002)(136003)(230473577357003)(230922051799003)(230373577357003)(64100799003)(1800799012)(186009)(451199024)(122000001)(110136005)(76116006)(83380400001)(53546011)(71200400001)(478600001)(6506007)(7696005)(82960400001)(8676002)(8936002)(4326008)(66446008)(64756008)(54906003)(66476007)(66556008)(316002)(9686003)(55016003)(26005)(66946007)(38100700002)(86362001)(52536014)(5660300002)(7416002)(2906002)(921008)(41300700001)(38070700009)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?R1lDVDhydFZDa3FzcVRmWXRLZDFQZ2VadVFUYU9jai9OVWxQMHRDR1oyNEIw?=
 =?utf-8?B?Vi9uUVhlcUFJUHBXWnhINmE1N0J1ajFUUENrNUdkTUZmekh5MTlsbHI3T1Zx?=
 =?utf-8?B?clhwSkM1ZFlYWDJhNzBGNVFNaVR1U3pGNmxXbWxCL21KZ3NMczg3TDV4UWhw?=
 =?utf-8?B?SUgzK0pxWWlXTlhGeTF0bkRnYkU4MGpxa2M1RCt2dVE2OFE3STV5enlJWllj?=
 =?utf-8?B?MUEzZkJCMENHUHpNQjlzU2tCWEFWdVlPd2pjSERWa0FENlMwT1VNaVJ2TTlU?=
 =?utf-8?B?bUZnaGQwK3Q0QUthODBSOUFsRDRhY1hvN1RicFVNMjNhNlk2Y2x3K2FQTWV6?=
 =?utf-8?B?dkRucnFRb0hEMy9YU3pvS0p3N0J0YzB2ZWtpeTNjeTlTQ1d5OXRTWFNpNTBh?=
 =?utf-8?B?TDMyM29KYTRxcGRkbXFiaWpWdStCVzdDMFR2bm10TWFST3grSEhDN0N0ZjRX?=
 =?utf-8?B?UCt1V1JEbWNNa0t3c1hVbTdrSjBxVVdKUHoxc0pOeVZERERNQm0yWXV3cVBs?=
 =?utf-8?B?bElyQVB6ZjhIRGJpZkdEbHkrZjBzMUhkQ1ZxMlFGb1FVSkp4U2pTZStleUU4?=
 =?utf-8?B?WG9xRU9sVy96cHFrZVFsb3BOWEFualBXT2hRZTVpT0xEbk41YXNyUWErVnZs?=
 =?utf-8?B?NXozNTJBQWFUbE1xQnFJUWdFbDJaeFNHbkplS1BkSU4ySG9pUDNVdHZKSU1z?=
 =?utf-8?B?clNBcDlvZmVRWDhYK1QxNnJlRjFUTW5OaGdINDN6TUtuZW9PN01ZcjRUaUxu?=
 =?utf-8?B?S2FUTkY0MXFoS0orUm4rbWlSQVdTKzFZRG80OGZDSDdDdVo2eW1DdDBNSS9w?=
 =?utf-8?B?QmF1SkdkOUs1ZjBLWTlvQWMwcEZmUXpxUmRlUk1UNStpUU8ySU1ISTFCOXlm?=
 =?utf-8?B?SmxMdWNFaDhnT3FUZjMxQ2x0bXhCcTRkZUxBOFRidkpvZnZNNUUvMFNpODB0?=
 =?utf-8?B?Lzh1RWIvSko3Tks2VVlCUGtwTVJWNmIzKytLZ1UwbGpEWnA4ZENYVUg5VE5L?=
 =?utf-8?B?UExqay9OeXdpZm1DZHZwdDVxQW1rYmZVMEcyT2kxSk4rR1paT0MwZUtKblph?=
 =?utf-8?B?N2kwamFWcm9KdnZObHBYUXJPU1NZYlFGSnorQlJ0RjlEWk5wL3JLeWNVS0hj?=
 =?utf-8?B?ZXRqRVJvQVNRTHg3ZWdFM0YwSUdrSHdWUlN1RzZIcHJhd2k3a2hmY0tPaG1O?=
 =?utf-8?B?VklGRG9VNmE4N0xMUExkeGF4RnRLMitrdDB6RDIvQ01DNU5SeXQxNHNWamx1?=
 =?utf-8?B?dkhnWGgrTFRZVG5ySjVmQXpiM1NweWZJeHFYeTFuRkdjSUxTc2g1K3FwcWpm?=
 =?utf-8?B?N3VBd3ZEUXlaWnI1cDFjMjRvS0lhT0RDUWtFbTFpQTE5WFhKeXYzRmpSbEVS?=
 =?utf-8?B?UGtHSFZZUGNPT0U2SGZod0hFY2FXckJXNGhaRnEzaXRDNDJ5VmZMamQzcjhN?=
 =?utf-8?B?WndkVXRnN0hmS3hpd0hBNWVPQXg2SFk1T214eTFFSzBWSUJuMFFSSVNQaElq?=
 =?utf-8?B?Mng4eFhvcFB4V2lMaUEvWVJ4d1d1TlRHT0I4OW50TXpKYmtyRHQxMkJ5Rmlt?=
 =?utf-8?B?V29FdkFhSGN3TTdDOUVSUERjbUw2YTNRQW5ON2hwdis0bng2SUM4VExJdVJJ?=
 =?utf-8?B?eStneEI2Sk9rditDeThMaitndDVwTkFPeXduakdNdE02bmpOWHVoMSs2K24y?=
 =?utf-8?B?VGFQbjc1WGV6VHQ1SmlxbmdtcHZkbHdiR2tQMCtDSS9vT1ZST0JGVkxXa1NT?=
 =?utf-8?B?ZUc1Y0FiWUNUMzlyL0VzNjNib3AzM0hBN1M3SllCNHg0VDNEMUoxdCtCT2Ey?=
 =?utf-8?B?T1phVGR0WVptYnRjekN4ZzFiYkg4NmNHc25BWGZjd0hsVDJnWlFFek9JMlFa?=
 =?utf-8?B?NkhkZ3BGVC9VTWswS01HTFQrQWp3Y3BkVktrNXI4WjdSQUFsVnhPK01BWUF1?=
 =?utf-8?B?L3RuUzhkZW5yOURDUXFmRWkyQUxnSVVaQVI4bVg1cklId1V0MVRDQ1YxV2ly?=
 =?utf-8?B?cmFrMmlrcmxZRldwTHp3K1FJaVlhOEZtRHlWMVZtL2Q5VXdNL2lYUDVBR2pF?=
 =?utf-8?B?N25nQ1Qyc2pvS0Z4WHp3Z3FIMC95RnRTeWtsUGtFSFUyMmNFd2ZKT1M1RDZG?=
 =?utf-8?Q?G/wNDE94NbdlKKJ2SBhw4iGAb?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5750.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43a683af-c29f-411b-8fad-08dbf5958e84
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Dec 2023 13:24:49.2979
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OMWsb0uGH9VSna0Sfcf9/VYRENgMznc1rt2TZWOhUMV/OjVT9KK3XlE3avGeFpkBfBdPktEx3FSBdHO7ZG/fpcUgsGGPrpgHjFI9rc9GA50=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6746
X-OriginatorOrg: intel.com

PiBPbiAwNC8xMi8yMDIzIDEwOjE3LCBSZXNoZXRvdmEsIEVsZW5hIHdyb3RlOg0KPiA+PiBDaGVj
ayBmb3IgYWRkaXRpb25hbCBDUFVJRCBiaXRzIHRvIGlkZW50aWZ5IFREWCBndWVzdHMgcnVubmlu
ZyB3aXRoIFRydXN0DQo+ID4+IERvbWFpbiAoVEQpIHBhcnRpdGlvbmluZyBlbmFibGVkLiBURCBw
YXJ0aXRpb25pbmcgaXMgbGlrZSBuZXN0ZWQgdmlydHVhbGl6YXRpb24NCj4gPj4gaW5zaWRlIHRo
ZSBUcnVzdCBEb21haW4gc28gdGhlcmUgaXMgYSBMMSBURCBWTShNKSBhbmQgdGhlcmUgY2FuIGJl
IEwyIFREDQo+IFZNKHMpLg0KPiA+Pg0KPiA+PiBJbiB0aGlzIGFycmFuZ2VtZW50IHdlIGFyZSBu
b3QgZ3VhcmFudGVlZCB0aGF0IHRoZSBURFhfQ1BVSURfTEVBRl9JRCBpcw0KPiA+PiB2aXNpYmxl
DQo+ID4+IHRvIExpbnV4IHJ1bm5pbmcgYXMgYW4gTDIgVEQgVk0uIFRoaXMgaXMgYmVjYXVzZSBh
IG1ham9yaXR5IG9mIFREWCBmYWNpbGl0aWVzDQo+ID4+IGFyZSBjb250cm9sbGVkIGJ5IHRoZSBM
MSBWTU0gYW5kIHRoZSBMMiBURFggZ3Vlc3QgbmVlZHMgdG8gdXNlIFREDQo+IHBhcnRpdGlvbmlu
Zw0KPiA+PiBhd2FyZSBtZWNoYW5pc21zIGZvciB3aGF0J3MgbGVmdC4gU28gY3VycmVudGx5IHN1
Y2ggZ3Vlc3RzIGRvIG5vdCBoYXZlDQo+ID4+IFg4Nl9GRUFUVVJFX1REWF9HVUVTVCBzZXQuDQo+
ID4NCj4gPiBCYWNrIHRvIHRoaXMgY29uY3JldGUgcGF0Y2guIFdoeSBjYW5ub3QgTDEgVk1NIGVt
dWxhdGUgdGhlIGNvcnJlY3QgdmFsdWUgb2YNCj4gPiB0aGUgVERYX0NQVUlEX0xFQUZfSUQgdG8g
TDIgVk0/IEl0IGNhbiBkbyB0aGlzIHBlciBURFggcGFydGl0aW9uaW5nIGFyY2guDQo+ID4gSG93
IGRvIHlvdSBoYW5kbGUgdGhpcyBhbmQgb3RoZXIgQ1BVSUQgY2FsbHMgY2FsbCBjdXJyZW50bHkg
aW4gTDE/IFBlciBzcGVjLA0KPiA+IGFsbCBDUFVJRHMgY2FsbHMgZnJvbSBMMiB3aWxsIGNhdXNl
IEwyIC0tPiBMMSBleGl0LCBzbyB3aGF0IGRvIHlvdSBkbyBpbiBMMT8NCj4gVGhlIGRpc2NsYWlt
ZXIgaGVyZSBpcyB0aGF0IEkgZG9uJ3QgaGF2ZSBhY2Nlc3MgdG8gdGhlIHBhcmF2aXNvciAoTDEp
IGNvZGUuIEJ1dA0KPiB0byB0aGUgYmVzdCBvZiBteSBrbm93bGVkZ2UgdGhlIEwxIGhhbmRsZXMg
Q1BVSUQgY2FsbHMgYnkgY2FsbGluZyBpbnRvIHRoZSBURFgNCj4gbW9kdWxlLCBvciBzeW50aGVz
aXppbmcgYSByZXNwb25zZSBpdHNlbGYuIFREWF9DUFVJRF9MRUFGX0lEIGlzIG5vdCBwcm92aWRl
ZCB0bw0KPiB0aGUgTDIgZ3Vlc3QgaW4gb3JkZXIgdG8gZGlzY3JpbWluYXRlIGEgZ3Vlc3QgdGhh
dCBpcyBzb2xlbHkgcmVzcG9uc2libGUgZm9yIGV2ZXJ5DQo+IFREWCBtZWNoYW5pc20gKHJ1bm5p
bmcgYXQgTDEpIGZyb20gb25lIHJ1bm5pbmcgYXQgTDIgdGhhdCBoYXMgdG8gY29vcGVyYXRlDQo+
IHdpdGggTDEuDQo+IE1vcmUgYmVsb3cuDQoNCk9LLCBzbyBpbiB5b3VyIGNhc2UgaXQgaXMgYSBk
ZWNpc2lvbiBvZiBMMSBWTU0gbm90IHRvIHNldCB0aGUgVERYX0NQVUlEX0xFQUZfSUQNCnRvIHJl
ZmxlY3QgdGhhdCBpdCBpcyBhIHRkeCBndWVzdCBhbmQgaXQgaXMgb24gcHVycG9zZSBiZWNhdXNl
IHlvdSB3YW50IHRvIA0KZHJvcCBpbnRvIGEgc3BlY2lhbCB0ZHggZ3Vlc3QsIGkuZS4gcGFydGl0
aW9uZWQgZ3Vlc3QuIA0KDQo+IA0KPiA+DQo+ID4gR2l2ZW4gdGhhdCB5b3UgZG8gdGhhdCBzaW1w
bGUgZW11bGF0aW9uLCB5b3UgYWxyZWFkeSBlbmQgdXAgd2l0aCBURFggZ3Vlc3QNCj4gPiBjb2Rl
IGJlaW5nIGFjdGl2YXRlZC4gTmV4dCB5b3UgY2FuIGNoZWNrIHdoYXQgZmVhdHVyZXMgeW91IHdv
bnQgYmUgYWJsZSB0bw0KPiA+IHByb3ZpZGUgaW4gTDEgYW5kIGNyZWF0ZSBzaW1wbGUgZW11bGF0
aW9uIGNhbGxzIGZvciB0aGUgVERHIGNhbGxzIHRoYXQgbXVzdCBiZQ0KPiA+IHN1cHBvcnRlZCBh
bmQgY2Fubm90IHJldHVybiBlcnJvci4gVGhlIGJpZ2dlc3QgVERHIGNhbGwgKFREVk1DQUxMKSBp
cyBhbHJlYWR5DQo+ID4gZGlyZWN0IGNhbGwgaW50byBMMCBWTU0sIHNvIHRoaXMgcGFydCBkb2Vz
buKAmXQgcmVxdWlyZSBMMSBWTU0gc3VwcG9ydC4NCj4gDQo+IEkgZG9uJ3Qgc2VlIGFueXRoaW5n
IGluIHRoZSBURC1wYXJ0aXRpb25pbmcgc3BlYyB0aGF0IGdpdmVzIHRoZSBURFggZ3Vlc3QgYSB3
YXkNCj4gdG8gZGV0ZWN0IGlmIGl0J3MgcnVubmluZyBhdCBMMiBvciBMMSwgb3IgY2hlY2sgd2hl
dGhlciBURFZNQ0FMTHMgZ28gdG8gTDAvTDEuDQo+IFNvIGluIGFueSBjYXNlIHRoaXMgcmVxdWly
ZXMgYW4gZXh0cmEgY3B1aWQgY2FsbCB0byBlc3RhYmxpc2ggdGhlIGVudmlyb25tZW50Lg0KPiBH
aXZlbiB0aGF0LCBleHBvc2luZyBURFhfQ1BVSURfTEVBRl9JRCB0byB0aGUgZ3Vlc3QgZG9lc24n
dCBoZWxwLg0KDQpZZXMsIHRoZXJlIGlzIG5vdGhpbmcgbGlrZSB0aGlzIGluIHNwZWMgYW5kIGl0
IGlzIG9uIHB1cnBvc2UsIGJlY2F1c2UgdGhlIGlkZWEgaXMgdGhhdA0KTDEgY2FuIGZ1bGx5IGNv
bnRyb2wgdGhlIGVudmlyb25tZW50IGZvciBMMiBhbmQgdmlydHVhbGl6ZSBpdCBpbiB0aGUgd2F5
IGl0IHdhbnRzLiANCg0KPiANCj4gSSdsbCBnaXZlIHNvbWUgZXhhbXBsZXMgb2Ygd2hlcmUgdGhl
IGlkZWEgb2YgZW11bGF0aW5nIGEgVERYIGVudmlyb25tZW50DQo+IHdpdGhvdXQgYXR0ZW1wdGlu
ZyBMMS1MMiBjb29wZXJhdGlvbiBicmVha3MgZG93bi4NCj4gDQo+IGhsdDogaWYgdGhlIGd1ZXN0
IGlzc3VlcyBhIGhsdCBURFZNQ0FMTCBpdCBnb2VzIHRvIEwwLCBidXQgaWYgaXQgaXNzdWVzIGEg
Y2xhc3NpYyBobHQNCj4gaXQgdHJhcHMgdG8gTDEuIFRoZSBobHQgc2hvdWxkIGRlZmluaXRlbHkg
Z28gdG8gTDEgc28gdGhhdCBMMSBoYXMgYSBjaGFuY2UgdG8gZG8NCj4gaG91c2VrZWVwaW5nLg0K
PiANCj4gbWFwIGdwYTogc2F5IHRoZSBndWVzdCB1c2VzIE1BUF9HUEEgVERWTUNBTEwuIFRoaXMg
Z29lcyB0byBMMCwgbm90IEwxIHdoaWNoDQo+IGlzIHRoZSBhY3R1YWwNCj4gZW50aXR5IHRoYXQg
bmVlZHMgdG8gaGF2ZSBhIHNheSBpbiBwZXJmb3JtaW5nIHRoZSBjb252ZXJzaW9uLiBMMSBjYW4n
dCBhY3Qgb24gdGhlDQo+IHJlcXVlc3QNCj4gaWYgTDAgd291bGQgZm9yd2FyZCBpdCBiZWNhdXNl
IG9mIHRoZSBDb0NvIHRocmVhdCBtb2RlbC4gU28gTDEgYW5kIEwyIGdldCBvdXQgb2YNCj4gc3lu
Yy4NCj4gVGhlIG9ubHkgc2FmZSBhcHByb2FjaCBpcyBmb3IgTDIgdG8gdXNlIGEgZGlmZmVyZW50
IG1lY2hhbmlzbSB0byB0cmFwIHRvIEwxDQo+IGV4cGxpY2l0bHkuDQoNCkludGVyZXN0aW5nLCB0
aGFuayB5b3UgZm9yIHRoZSBleGFtcGxlcyEgV2hhdCBpdCBsb29rcyBsaWtlIHRvIG1lIHRoYXQg
aWYgd2UgZ2l2ZQ0KYW4gYWJpbGl0eSB0byBMMSBWTU0gdG8gc3BlY2lmeSB3aGF0IFREVk1DQUxM
IGxlYXZlcyBzaG91bGQgZ28gaW50byBMMCBhbmQNCndoaWNoIG9uZXMgc2hvdWxkIGVuZCB1cCBp
biBMMSwgd2Ugd291bGQgYWN0dWFsbHkgYWRkcmVzcyB5b3VyIHVzZWNhc2UgbW9yZQ0KY2xlYW5s
eSB3aXRob3V0IHRoZSBmcmFnbWVudGF0aW9uIG9mIHRoZSB0ZHggZ3Vlc3QgY29kZS4gDQpJcyBp
dCBhIHZpYWJsZSBvcHRpb24gZm9yIHlvdT8NCkkgZG8gdW5kZXJzdGFuZCB0aGF0IHN1Y2ggb3B0
aW9uIGRvZXNu4oCZdCBleGlzdCBhdCB0aGUgbW9tZW50LCBidXQgaWYgdGhlcmUgaXMNCmEgZ29v
ZCB1c2VjYXNlLCB3ZSBjYW4gYXJndWUgdGhhdCBpdCBpcyBuZWVkZWQuIA0KDQpCZXN0IFJlZ2Fy
ZHMsDQpFbGVuYS4NCg==

