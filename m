Return-Path: <linux-hyperv+bounces-1421-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB90882B90D
	for <lists+linux-hyperv@lfdr.de>; Fri, 12 Jan 2024 02:20:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF8091C23EC3
	for <lists+linux-hyperv@lfdr.de>; Fri, 12 Jan 2024 01:20:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E49C5EC5;
	Fri, 12 Jan 2024 01:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KE2AJTwl"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73FB0A4C;
	Fri, 12 Jan 2024 01:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705022411; x=1736558411;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=JK58cNB42rEYmw5AIvTsftZ+5GrUrDGnInR9ZYgiI6A=;
  b=KE2AJTwlTSt/A3hvZGl8acOneILjn5eCLZb3hslnJyOXLonnyiuw231Z
   gLu4Plc43ATYKMnAP5zd6tjEzAdION4nQJNdlz4y7kzWn0ZZHlsftrsQI
   4qGul91R600AJMaJZxTrEwDinkLAO2/Y6UIh18GZCgRbHhK0LnMiPtQMy
   tUjOAmhBgsVyMRl+f1mvdbw4CImvRbyU26FapewKOGjoHpM7p066abzVl
   5SWWDYmNgigwVRGcI+ISoZdEgd5NgrgvazKoEE+7yoM+DdnpImn22zHhq
   YaxAS9JLmTmZTMtc4S69JcjL166923hgUHsNV50uB5TCsNIMMaEOahdW0
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10950"; a="402824323"
X-IronPort-AV: E=Sophos;i="6.04,188,1695711600"; 
   d="scan'208";a="402824323"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2024 17:20:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10950"; a="1114045533"
X-IronPort-AV: E=Sophos;i="6.04,188,1695711600"; 
   d="scan'208";a="1114045533"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Jan 2024 17:20:09 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 11 Jan 2024 17:20:08 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 11 Jan 2024 17:20:08 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 11 Jan 2024 17:20:08 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RF4Td/kGEZjW+YgUiLR8Un5piCimFUQfGSk/1FCd3SvILRiF57HUcBaxQtwXiJ0Vrad2MBfFi+D8tlp1bfxsgFc59Au/dRmjbk9qId52atDx/6BmFFcmUU1TGXSwNm2oTXv6G9HVj3/5sBNmVMuQFOJEXQwvzod6ZsgJJ54YThV62x4quy4zvksEaJjysNjoPnL5TE2vekvXi2fDJUxWsjutLwXEA9m88GMRlsjav7gYgFQG3CILixDhEdnsp9Hr31BH9f8dSOYEBgaaGQ+zXMT35WnZ5IQBNUeG+CuPO31aY9kqDIy29Npze+JQNxPwmIWBvNpatxTBNGGCAuU20g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JK58cNB42rEYmw5AIvTsftZ+5GrUrDGnInR9ZYgiI6A=;
 b=YNNQPN/Q/TGKkRwZk1tSVnWk3TeII1tRlQQa/BoOfxBOAa5MEtZUw8kwsP6AruGyGlWmQhQZL5JXM3B+tHmi67UmK4ZXjueomgWolPr39tlEJpLFbMUqiVz4FCeWuC6NbaMQFPABFbr7z7ZFm7Q71ycrYRGxFaooylCKvPkRNis2s5PKKKwNRS+C4Lis3qcu/vKsjaALK0BvPtPKy81+UmVuGJuwu/Epv0wzGAtyO/YLSuzWK3eYUsyjbS8v/e2MiVy0nNcAOO0IUQ/pGnn610EqjaTUUmheyMikMSK95E7W0DbYS3k+Tcz+SaxASD7vcvecdXoLrI7Dv/vX1fwUKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by DS7PR11MB7951.namprd11.prod.outlook.com (2603:10b6:8:eb::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.19; Fri, 12 Jan
 2024 01:20:03 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::6dc:cee5:b26b:7d93]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::6dc:cee5:b26b:7d93%4]) with mapi id 15.20.7181.018; Fri, 12 Jan 2024
 01:20:03 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"ardb@kernel.org" <ardb@kernel.org>, "hch@infradead.org" <hch@infradead.org>,
	"Lutomirski, Andy" <luto@kernel.org>, "mhklinux@outlook.com"
	<mhklinux@outlook.com>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "thomas.lendacky@amd.com"
	<thomas.lendacky@amd.com>, "haiyangz@microsoft.com" <haiyangz@microsoft.com>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
	"mingo@redhat.com" <mingo@redhat.com>, "seanjc@google.com"
	<seanjc@google.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "tglx@linutronix.de" <tglx@linutronix.de>,
	"Cui, Dexuan" <decui@microsoft.com>, "urezki@gmail.com" <urezki@gmail.com>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>, "hpa@zytor.com" <hpa@zytor.com>,
	"peterz@infradead.org" <peterz@infradead.org>, "wei.liu@kernel.org"
	<wei.liu@kernel.org>, "bp@alien8.de" <bp@alien8.de>, "Rodel, Jorg"
	<jroedel@suse.de>, "sathyanarayanan.kuppuswamy@linux.intel.com"
	<sathyanarayanan.kuppuswamy@linux.intel.com>, "lstoakes@gmail.com"
	<lstoakes@gmail.com>, "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH v3 1/3] x86/hyperv: Use slow_virt_to_phys() in page
 transition hypervisor callback
Thread-Topic: [PATCH v3 1/3] x86/hyperv: Use slow_virt_to_phys() in page
 transition hypervisor callback
Thread-Index: AQHaQAVkxs0+X3Nw7Eax/DPEZFIdBbDVauMA
Date: Fri, 12 Jan 2024 01:20:03 +0000
Message-ID: <9dcdd088494b3fa285781cccfd35cd47a70d69c3.camel@intel.com>
References: <20240105183025.225972-1-mhklinux@outlook.com>
	 <20240105183025.225972-2-mhklinux@outlook.com>
In-Reply-To: <20240105183025.225972-2-mhklinux@outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|DS7PR11MB7951:EE_
x-ms-office365-filtering-correlation-id: 9f5f2017-94f0-4e06-f348-08dc130c9a99
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QZXFBUBARbRzEutWU+QerwnsZcstsrQcjCT3bleZ6cWkWjDnowksZslSN55uBRD5owOf9rDJBMgMa5Q32xey//SQzuSLGvxCkHr5S/GBdCFXNs6JYtKNevCFu2e0tKEpQlfmDqRaOJD+qzrGdxsBEKBWTrP4xbPD3vVGnpDk0MdUSn58PwQBWOXg01XZu4ZXQDvWOvpqVs5tdTL34dhq2fj5ljEEGq+lK0r2LYqw9s9OCOOQyPfZY2JgPuUml13IFvFlkfeh1ScuJ0JNTPIcZxwi1AW9ze7x25LKUuRiOer0nBDym+YhdWkbucbvX6dpVFMgcRtuVxw1Yx3M9ZrchbvJmFq0Btp5bKl2ux9SiQDdPK24+1hYwi0/vcw+DPNj3/UG9kb01xoB55joOuLyIkJNsuVGfXhf5oSZGQ5NBId4l+Bp+PRoBbOMOXR1ubRo56EcFHaPftvv9Fz5jRbpLQX6x8aFrpF6rbhll2ljaqcwkkB+FPDtnPnRwnzyOOZNNOCmZh0t5tukmfQvMHHzXCxwdVJjTLQ4ZsncwfTOv0WJdflg1BBBU7c//fYcn+PW7hBqSHykNug2c+2qoAuJQCjMygcFT7yZABsijx548vdZ6u7uPDiTDp/k+yD8fJPA6zS9ctgeVGzTza2gdk4XLw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(376002)(396003)(136003)(39860400002)(230922051799003)(451199024)(64100799003)(1800799012)(186009)(122000001)(83380400001)(2616005)(26005)(71200400001)(38100700002)(316002)(66446008)(110136005)(5660300002)(76116006)(66476007)(66946007)(6506007)(91956017)(66556008)(8936002)(8676002)(64756008)(6512007)(7416002)(2906002)(41300700001)(478600001)(6486002)(921011)(82960400001)(86362001)(36756003)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NURxWTNaZUswRCtjRHZMejc3YkphTjdBcUFsdTFzS093eEJNRytRRllETmFv?=
 =?utf-8?B?UVpURWVKelFvdGhUWXhtWWJJY3k3L05vTWxWcElsa0tnSUVmYmhYT0lPOW1p?=
 =?utf-8?B?aFJaUG9RVjlsREhmVVhkcHBhM1dGalBoTFZXTjMwMnRnTE9vZHhDTFJhUFp0?=
 =?utf-8?B?SHNzWEN2aHgrK01ReXdQc1FGZmE3L3B2N2FMYkJzdE1sT3ltc0tWOWhpOC8x?=
 =?utf-8?B?dy95akxUNHVFRVFlMzdad0phUVorY2gxQ1RUT2hYQ05manVCUy9IMDBNOW55?=
 =?utf-8?B?VzlmSW1xaGNRZTlsSEpxOWlQWm5JblBkNzZUTGdWMWZ5bjZTTjdLSzBqSXJv?=
 =?utf-8?B?RnU2TllnWFRDZGFEbjJuYW5pcUFjOTdROG1ZSUdGYlVGNEM2YVBCVEZRVjFK?=
 =?utf-8?B?d2tCK2xlSEVzVXhqTUE1Rzg4bWtsNGRmNjBDcEJtdWNrWFZCV0J1Rm42WHJD?=
 =?utf-8?B?WDZzN0RWZWZCajczVmlQWXhNdkQ1czZyMjViVGZrMFQyQkJyeHBJSUtTTnVw?=
 =?utf-8?B?THBTdXg1UXZBWEZXbm9WVDlrK3Q0ZXN4WkhVOFZaTFpkTm5HL2xGeWdPaXhz?=
 =?utf-8?B?NmFGaTV2UDlLazd3REhwc0dtREVIcWJUQWhFZFdFQzA1TTl3N0lzZkNTcm9o?=
 =?utf-8?B?Nk9SQmZoZmt5MFFFTG55MTdhb1BNNjUxMk9ENlhsanpVaStKZlQ1V0x2eEVO?=
 =?utf-8?B?bU1selNSUjZGSmJ2VXhZSDJFeC9xM3gxWnhMVEJxalN0ZzUxT0xJc3RpYVl5?=
 =?utf-8?B?VmNNYzEvQm5kQTF4Y3hKcm5oaWJNeEFuS0NMYkdkQVgxWmxIVE1BNVpXeGcx?=
 =?utf-8?B?R0dZMUsvTExiMjRVN1p2Zk0zV3VSRlA0SVkranY0WWdjcldJR2N0RVBWeFI1?=
 =?utf-8?B?NDIyTURjZEZTbzEvNHZ4YkthS0ROaWlqWjZBMGhma1ZSejFTbUtvY0drTVM0?=
 =?utf-8?B?ZGtHZEtORlFybWdhZGZPNEtXZWlVOHZ1M0duNGxQMWFJMTVMU1VmZmdxbGtP?=
 =?utf-8?B?enRTQ2xqaU1hcHM3YUE4bk5rUk5VaEN4dVJPUy85aFlSdFhsSGVpSTYrcEtN?=
 =?utf-8?B?blZDOEdXVU56S0s2Q1ZJUEkzejlld0ZQcFFWU2w4cXZ2NVg1N0xJS0s2RlY3?=
 =?utf-8?B?WUprSldqbFQrM0VGdTU1NHVURDVkYmE0QzZxOElHTEoyRGZBZ1ZFRVB5NnVD?=
 =?utf-8?B?TUhSRjZKMHNyM0RsUDVaTXZkNmY5UENaSnhJcVBqc0l0MmRmVnFtOEFiaWJ4?=
 =?utf-8?B?NGJrdFZycFNBeUVMRUs5aXBEOHZ6NlN4b2JObWQzODJuTmdSUkZ6WktOaW1T?=
 =?utf-8?B?Q2hLVStNeXU4bUtObGZMY3kyQVZ6ZWNidGN1ZmhsYnFWYncrR0taQ1ZFWkNj?=
 =?utf-8?B?YVI0U2xPMHZVcUplcHNUaWF5OHZZazJTUll4bEN1YkZ0L3FSUjJlZ2lnWlBJ?=
 =?utf-8?B?ZDFPVFhkdnJDMy9qOUJDMUkwS0hSdDI4TytGMjlCR0owV0VETm9oY3Ricmht?=
 =?utf-8?B?NTJqd1NCc25NL201YWRjSmNoaUFWbmNnR0Z1WCtqdEgzeTJRUUt1MDcyWG14?=
 =?utf-8?B?U1ZrNXpQdFA0a0gwN2ZqRlA2d2JFeEQ4czNBQW5zUEhzL0VOa2xsZWFOcm5X?=
 =?utf-8?B?SlY5U3MxbmMyQ01QaWRFL0k5N2NCNmJhNndmL3d1cFFiblpuTnovc3pOZjNS?=
 =?utf-8?B?UFJEdEhVZldPMGYvV3lOS1h6dWt0dmdmY0UrTVRhaWdaZGY3VXlyLzlFRlNq?=
 =?utf-8?B?cGNsM0dyWHI3RjZmb0xhWXZ6b200ckV5ZTNjZWNYM0V6OWNuU0h6bHg2U3JL?=
 =?utf-8?B?NExtZkRvSjd4YXpGRmd5QjFkdXBBaFNreWJBaHp5Sk1EVVlkRm9mODJQZHBr?=
 =?utf-8?B?NmFZdEpUbmxuZG9qR2lqcHI5ZDB1Tkc3WFpGMlpjZXkvVGJFSUhqWlh2ZlZn?=
 =?utf-8?B?NzJjNG5teDFDeE1hMjM3ckJHUmtCTmRuaTdiMm5kSVNwblBLY2dsK0FDcjJT?=
 =?utf-8?B?aXVoQ2pXTGJTQjEzZXlFU1J5Zzh1Z0E2R25UbkZJdUhGYTV5b1M5elNXZ29j?=
 =?utf-8?B?TGdwUE9PWkJZcFlsU2YvQkwwNHdTeEw3b2hsZVpXdmVLQ2FiTDBsRW1hMFhQ?=
 =?utf-8?B?N0N0MTRjZFRoUW54b0hjY3J6S1RNM3JPSjhRSU5tWTVja3BuOVh5UkE2UWFT?=
 =?utf-8?B?Y2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B28943EF8793C24DA8A8390EC874E07E@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f5f2017-94f0-4e06-f348-08dc130c9a99
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jan 2024 01:20:03.3804
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3tt4OU55ozXHKSeKAwmKgVbhOrKQ00R2h/tlc06uDTeOtFKif8YErwhLU6RVrso8Kfp0EqDN8jD9KnnmklAc+PEdUBc239HumNdeOulHvRU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB7951
X-OriginatorOrg: intel.com

T24gRnJpLCAyMDI0LTAxLTA1IGF0IDEwOjMwIC0wODAwLCBtaGtlbGxleTU4QGdtYWlsLmNvbSB3
cm90ZToNCj4gKyAqIEl0IGlzIGFsc28gdXNlZCBpbiBjYWxsYmFja3MgZm9yIENvQ28gVk0gcGFn
ZSB0cmFuc2l0aW9ucyBiZXR3ZWVuDQo+IHByaXZhdGUNCj4gKyAqIGFuZCBzaGFyZWQgYmVjYXVz
ZSBpdCB3b3JrcyB3aGVuIHRoZSBQUkVTRU5UIGJpdCBpcyBub3Qgc2V0IGluDQo+IHRoZSBsZWFm
DQo+ICsgKiBQVEUuIEluIHN1Y2ggY2FzZXMsIHRoZSBzdGF0ZSBvZiB0aGUgUFRFcywgaW5jbHVk
aW5nIHRoZSBQRk4sIGlzDQo+IG90aGVyd2lzZQ0KPiArICoga25vd24gdG8gYmUgdmFsaWQsIHNv
IHRoZSByZXR1cm5lZCBwaHlzaWNhbCBhZGRyZXNzIGlzIGNvcnJlY3QuDQo+IFRoZSBzaW1pbGFy
DQo+ICsgKiBmdW5jdGlvbiB2bWFsbG9jX3RvX3BmbigpIGNhbid0IGJlIHVzZWQgYmVjYXVzZSBp
dCByZXF1aXJlcyB0aGUNCj4gUFJFU0VOVCBiaXQuDQoNCkknbSBub3Qgc3VyZSBhYm91dCB0aGlz
IGNvbW1lbnQuIEl0IGlzIG1vc3RseSBhYm91dCBjYWxsZXJzIGZhciBhd2F5DQphbmQgb3RoZXIg
ZnVuY3Rpb25zIGluIHZtYWxsb2MuIFByb2JhYmx5IGEgZGVjZW50IGNoYW5jZSB0byBnZXQgc3Rh
bGUuDQpJdCBhbHNvIGtpbmQgb2YgYmVncyB0aGUgcXVlc3Rpb24gb2Ygd2h5IHZtYWxsb2NfdG9f
cGZuKCkgcmVxdWlyZXMgdGhlDQpwcmVzZW50IGJpdCBpbiB0aGUgbGVhZi4NCg0KSXQgc2VlbXMg
dGhlIGZpcnN0IHBhcnQgb2YgdGhlIGNvbW1lbnQgaXMgYWJvdXQgd2h5IHRoaXMgaXMgbmVlZGVk
IHdoZW4NCl9fcGEoKSBleGlzdHMuIE9uZSByZWFzb24gZ2l2ZW4gaXMgdGhhdCBfX3BhKCkgZG9l
c24ndCB3b3JrIHdpdGgNCnZtYWxsb2MgbWVtb3J5LiBUaGVuIHRoZSBuZXh0IGJpdCB0YWxrcyBh
Ym91dCBhbm90aGVyIHNpbWlsYXIgZnVuY3Rpb24NCnRoYXQgd29ya3Mgd2l0aCB2bWFsbG9jIG1l
bW9yeS4NCg0KU28gdGhlIGNvbW1lbnQgaXMgYSByaXNrIHRvIGdldCBzdGFsZSwgYW5kIGxlYXZl
cyBtZSBhIGxpdHRsZSBjb25mdXNlZA0Kd2h5IHRoaXMgZnVuY3Rpb24gZXhpc3RzLg0KDQpJIHRo
aW5rIHRoZSByZWFzb24gaXMgYmVjYXVzZSB2bWFsbG9jX3RvX3BmbigpICpvbmx5KiB3b3JrcyB3
aXRoDQp2bWFsbG9jIG1lbW9yeSBhbmQgdGhpcyBpcyBuZWVkZWQgdG8gd29yayBvbiBvdGhlciBh
bGlhcyBtYXBwaW5ncy4NCg==

