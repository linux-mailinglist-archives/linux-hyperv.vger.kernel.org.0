Return-Path: <linux-hyperv+bounces-1109-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AE5D7FC3E1
	for <lists+linux-hyperv@lfdr.de>; Tue, 28 Nov 2023 19:59:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AAC6DB21371
	for <lists+linux-hyperv@lfdr.de>; Tue, 28 Nov 2023 18:59:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97D823529B;
	Tue, 28 Nov 2023 18:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AR41OsS2"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5A7D131;
	Tue, 28 Nov 2023 10:59:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701197975; x=1732733975;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=ET9PG4CKpoX1gdcryX+E6dg/rV1xrWLxYxO1uwmTuSU=;
  b=AR41OsS2p9MOwITnbf7xizuDsffdIrT8cm6Bn4hnPSTgYkFPr5SBohNp
   fk7eGzk33keiJ8mcdrHD6KxrrG8jl5PaWj5ubrly/PbSEUe0fyMfNQZ+k
   dWQrbfPaXgMxFVk0oMd3q4KWhVp11+eRDAnk3ZOQbQqmpm0XRM1UoDhFm
   5AQv6Y224XzEYRfaUtlW7cp/IbdZF+AaFYti18MDOpDm5rVAOfwYQS4oI
   byRzT7YIxx4uPR9GKmMhaj7qPqjK6jeJKRTbLAxnGxE+RRoo2J1TRFq1G
   A/ct2rT2dX4cmBoaYgd1OORgBqDypjvQEmD/IPkVSSg2q+Fh/Yafy1GS1
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10908"; a="11700430"
X-IronPort-AV: E=Sophos;i="6.04,234,1695711600"; 
   d="scan'208";a="11700430"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2023 10:59:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,234,1695711600"; 
   d="scan'208";a="16698835"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 28 Nov 2023 10:59:34 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Tue, 28 Nov 2023 10:59:33 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Tue, 28 Nov 2023 10:59:33 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Tue, 28 Nov 2023 10:59:33 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EtbSwyl1Ozllxk7wxMQUWRZpRkt8ni1/TBNIbf4rh4xzFE0bEiv/npJIGTtS3h/D7KMBARG1LGZP1Rx9XEPt0dbpvyecmuD0uQnLLWLKNTilkJOlWDyEFskmvZx1JIMtk+klTZVSL6zws0E2YjP/OJJnyRkY3fgXylsssEgDyRK819vq1VZCYTZDKZ4CIpLsvlxKNWHTwvHXo9L4z2dTnlrQ/zqFddEeVQ35c/K9FCecTP6wGPBA0QJJfvVDFWGexjGGav1qs4FxYVSPI2YUepizmMuUOdyxLM7FYBx9mbVAKD3rRWjgmgCHJ3kk0iibWtcgIOr6xIIKFZzuZ9dgfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ET9PG4CKpoX1gdcryX+E6dg/rV1xrWLxYxO1uwmTuSU=;
 b=bYOcC2TfCJwpExQHK1VqHAloJheejaBETB+p+t5un7PvBbex9sc1tVUI2lN7p+v1qGwOZOwrjZr86kd3uNFqLD6QDEW/jS1LnEdiMlYF0048florrza//15iTdfbklnH8IwLXc7uWapuOTlm9Wl4Dd3Polt3aGgLl+ql+atgaI4Mk2cREdlku6C7WbjFdCQ3wM5XVStQ/IQ5Rqb5KKs9i9cXFFryAKlNyHebrVSFtowgJjMYBBvYEgzZlrKcCJuWQcWWzLii3NgZKlsM0slWZ7L5vhKwTe2AcjGlKY9PByYRniIpmXvGrTtLd+cALCPL1V95JkYKzNYOgu/PiFX6Zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by DS0PR11MB7335.namprd11.prod.outlook.com (2603:10b6:8:11e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.22; Tue, 28 Nov
 2023 18:59:30 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::5260:13db:a6e:35e9]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::5260:13db:a6e:35e9%6]) with mapi id 15.20.7025.022; Tue, 28 Nov 2023
 18:59:30 +0000
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
	<linux-kernel@vger.kernel.org>, "kys@microsoft.com" <kys@microsoft.com>,
	"Cui, Dexuan" <decui@microsoft.com>, "linux-mm@kvack.org"
	<linux-mm@kvack.org>, "urezki@gmail.com" <urezki@gmail.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "peterz@infradead.org"
	<peterz@infradead.org>, "hpa@zytor.com" <hpa@zytor.com>, "bp@alien8.de"
	<bp@alien8.de>, "wei.liu@kernel.org" <wei.liu@kernel.org>, "Rodel, Jorg"
	<jroedel@suse.de>, "sathyanarayanan.kuppuswamy@linux.intel.com"
	<sathyanarayanan.kuppuswamy@linux.intel.com>, "lstoakes@gmail.com"
	<lstoakes@gmail.com>, "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH v2 4/8] x86/sev: Enable PVALIDATE for PFNs without a valid
 virtual address
Thread-Topic: [PATCH v2 4/8] x86/sev: Enable PVALIDATE for PFNs without a
 valid virtual address
Thread-Index: AQHaHMCWxDaQ2OOq0UaKl0u/qG7/4LCOur0AgAFXcACAAA5WgA==
Date: Tue, 28 Nov 2023 18:59:29 +0000
Message-ID: <00222b634b4ce443f8d1a793c4f8fe69b7ad39d0.camel@intel.com>
References: <20231121212016.1154303-1-mhklinux@outlook.com>
	 <20231121212016.1154303-5-mhklinux@outlook.com>
	 <3ddcad72637dece4bd3ecb7c49b8ad0e5bd233c0.camel@intel.com>
	 <SN6PR02MB4157A935C8B8F9DBB30F9512D4BCA@SN6PR02MB4157.namprd02.prod.outlook.com>
In-Reply-To: <SN6PR02MB4157A935C8B8F9DBB30F9512D4BCA@SN6PR02MB4157.namprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|DS0PR11MB7335:EE_
x-ms-office365-filtering-correlation-id: 3493b3c9-b270-49fa-84e8-08dbf044263e
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xKfffLSlppNJVjvjAzrqTr+UEyRY6SEHgIy56+UAuBPdUnGDt8dXICM0Lrj1PSIbCNLLmUEY0MTxfIFYf4bdfoHpyCdJhvr1BLUhGMtk/r9TgOFrJNwt3cXrKxAjqKnXbb0+22hR+LLAicXki9uQbGggSPhOFfmTx+mB5H2O21cV1dBwVPMXcRAlP0hzMMx50tWuzamsqRDYW93EqKLweYif5E72ZTcGQKBAX4r2WLGymfQg8EnDMeHyY5raVtA8eCD/ke50pL5OvlDfZlk12vkLasUp0NkDGg3eQH9CWM463KhjjtN4kPrlfkJjNfcBiBT71m+k9vYwQHw2y9o5+/bcPnXZlRV6e4+uTM2UgV8Veta6VIkkM50rQE9gD31C0SyBBXBp/X+rDqrPj8QwMoFMl3vavln/23EPKdtUZ3fjppqNFS2GVDJLuMqOaqtXoIlztwD67klMrHyPTosCin0ZUyTJH3lKpChwZ+XCvMUu5SX3MN/40s7KdZEZR/I1PIa5xqUS/TyMglwrdg01sI9aQmZvbxLHAE8kVIxJcBQO4BdtkoQjKwRGiPhz1kdYCGv/EpM8MwNFhW0Jjxiv84H50DaUVPgzpHZoQTSSVjtmoCarV+XltH+s+5HMgzPx4alB/Y5cisAdGknjlspB+Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(39860400002)(136003)(376002)(396003)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(83380400001)(2616005)(6506007)(71200400001)(86362001)(66946007)(66476007)(66446008)(110136005)(64756008)(66556008)(26005)(76116006)(91956017)(316002)(8936002)(8676002)(478600001)(6486002)(6512007)(7416002)(38100700002)(5660300002)(82960400001)(122000001)(921008)(41300700001)(2906002)(4001150100001)(38070700009)(36756003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S2krZzY3REFJc3R3c29MdGdDZFJZcmFFT0xTa2wyQUtPcUIrU0g4VndIL2RU?=
 =?utf-8?B?bW5YK25zZTFYZmVvSHZtNGdqaWswS3ZlUHZhQiswSnNXb1VpZ2xkZmFiaksv?=
 =?utf-8?B?UlMyL3pacjI0NWV4MXR2V0ZLSmdLY2lXTXVKQnpKYmFSWGpaaEpJaTV1TjEy?=
 =?utf-8?B?M0tyK1BiSGF0azdPellKT3ZRWFMxZVJublNRU2RtZUhWaWRsdjlSRHd1TWxv?=
 =?utf-8?B?Sm0zMWtrNk9CZG5pUWJVMHRrZFVxR1pWeUR1bEEwUm1QN05CMjd3eWdEWDJ5?=
 =?utf-8?B?MjJoRWY0K1ZuSC9jeVJOcWdvSTlwL0VIN29abUljak05MzRYWnZYQ2dtckV3?=
 =?utf-8?B?QW5scThDQjVkS1lhZGFvcHNLek1ybzRaKy9tc2UxR3lRbm1MS0tnSVU3MnM1?=
 =?utf-8?B?YXFrRlM3d0xvTjg5aG1MTWRIclg0MWpCd2o0NWU0Vm10MTdKSlhhc084MklW?=
 =?utf-8?B?dG0zQW5QYnVwVkZacTZETTE5OE9HbzhHZTdFbnVNNWhNZ2pxZzU0QU1sRU9F?=
 =?utf-8?B?VVB1U2sxN2FEczF1b0hPV1pYMUF2R1NLR092UVBOUFF0VlJxbWpkWjZ2amhF?=
 =?utf-8?B?Y3laenBzdm03aFNmZHE5WHBjaEFZcUtBYm5zcFYxVDlNSGlYVTNFeW1Da1Mz?=
 =?utf-8?B?bUdyK1lWLy9CMkVlUXYrRFJFZG5TTUZEWXhPK1dCVHA3c2lLdjA1K3ArWUlT?=
 =?utf-8?B?VFFDOG9yM3gvR2QzdzNua0VnbWRWRldIRWdJZzRmTVZOaU4xM1Q2OTBhMlFy?=
 =?utf-8?B?TVlTU2ZOZnNoRWY1UFhLbTErWGZTNk9HRWwzRXlKZTFYVUlWVSt1Q1VwNDM5?=
 =?utf-8?B?NXJFK1ZhZFJVejBjT2k5RmN5VGp1SnhUakx4cXAra0tocGJDN1hpU0w4alBI?=
 =?utf-8?B?ZFVXWHMwOXN3dWNOSno5NnRBdStnclluKzNhQStUM28weFBUc3BtejZMWFRC?=
 =?utf-8?B?Vlpsc3NLOUxWd1MrWkNSdnZnUDNuTTdoQk9nRG9WbjdNKy9PWVkrRG5GYXg3?=
 =?utf-8?B?emxKTUlNeUYvR0Z5bWxsWHN3aVhkaFV2SjRnNU4wQTg0QjN0UitadGJXMHk2?=
 =?utf-8?B?YWtZeFpOd3hsWC92TGVwNnYyb1pZNzBrZDJYaGZyVnJLME1kYXZydXJmNzRH?=
 =?utf-8?B?bHUvVTdmb2pPWXR1dk5qY1lhcXRuTGtjSGZ0dE91NFNNU2EyVjVDdVB6cU1R?=
 =?utf-8?B?YWZ3TjNWNGpPOVJiTkVwalRHOVA5SjUyM2c0OWpsU2hKWFRZRHNDZWN3NGxG?=
 =?utf-8?B?a2o3NjE2R3JSQWluV080S3JFb3lZU0J6WmR0eGNuNkhVNDRKWmUvSW8xQS9C?=
 =?utf-8?B?V0pDcmpyamFOeHJqOWd1azY4Nzkxd3hlS1J2SWpaV0gySW5WZTNub3k2NnNE?=
 =?utf-8?B?OTJHTnRmbUVXTjBnKzI3WGVTLzk0Zk9zSTFYQk05U1RXV2ZvL0g1MlZWT2kr?=
 =?utf-8?B?eGtzK3AremJyOFh5cVBRRjZ0RmFGcjFINkRjenY5bnBWUWczQmF3dXM5NWVv?=
 =?utf-8?B?Wk5KaE95SkNIMnZCV3lYcWxLd0RuVEhPYmF6OXJndVcwcVlETktsdWd4UEh2?=
 =?utf-8?B?OTlYSDFvOXdXUG9Jd0U3aWViYmh4SnpBZ2daSUpvSmw1UlNHN0tSVElNV0hO?=
 =?utf-8?B?VSttT2xDREF6WkVjZTVralRDNWtrYmVySWNJZHFWbGZ2R2VvK0xickJuOHJw?=
 =?utf-8?B?dXE1b1RnbFpRandhU0RqUTkySEp4OCthKzJLaXlQRVhSMTlubTZFQmQ5TkNJ?=
 =?utf-8?B?aStsUVhtd0tORUdHckU3TnljQktDN3hGdEI0TC9NNEdMQlo2clZnQnJoZDJN?=
 =?utf-8?B?L2RYTDBzd21pbW1UUjJEWGN4T1N3YjFQOGpqdmxSaExSVkVLd1NPc2cwQzRI?=
 =?utf-8?B?Um5GUXB1NDZJa05nUitnUEV6VXRPNDR3RlRrVnZsOENTYkVkM3kzcW45OVFN?=
 =?utf-8?B?OGJrU0tBRkoxQTVFNmx4c1lwaWowOGVOZ213TWNnSTJsT2tBMXcxNW9CZ1RY?=
 =?utf-8?B?TXh5RkhnSjlOem5saDRiTzN0MW1ZdW9UNzJmTklBYTBDcXdMaFQwaTVMVi9I?=
 =?utf-8?B?M1piT1JyUzFzZm1LRzVXQTljZXZyM05najgzVlgvYzU2cFFVYUptV2ppU1dI?=
 =?utf-8?B?RFhyY29QYWNJU2d0ZmZIWWxCbHkxVzIycDNFSHpNUEdCMlhFakxYTnFhOEYw?=
 =?utf-8?Q?2BjZNMWYmMvqNIJ7CLBHiY4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E70E6C2F5772F644862DA9C874CB0141@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3493b3c9-b270-49fa-84e8-08dbf044263e
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Nov 2023 18:59:29.2655
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LohINehjEufcbSHN2cB7ZVC/7dzEwSzbZ80jQysztGLe/aOvH+js3sVvycUn/enTuN0k0aE58xmtUq29yJVcdxeEWX9xQKBnX7YzKALA3Ow=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7335
X-OriginatorOrg: intel.com

T24gVHVlLCAyMDIzLTExLTI4IGF0IDE4OjA4ICswMDAwLCBNaWNoYWVsIEtlbGxleSB3cm90ZToN
Cj4gPiANCj4gPiBTb3J0IG9mIHNlcGFyYXRlbHksIGlmIHRob3NlIHZtYWxsb2Mgb2JqZWN0aW9u
cyBjYW4ndCBiZSB3b3JrZWQNCj4gPiB0aHJvdWdoLCBkaWQgeW91IGNvbnNpZGVyIGRvaW5nIHNv
bWV0aGluZyBsaWtlIHRleHRfcG9rZSgpIGRvZXMNCj4gPiAoY3JlYXRlDQo+ID4gdGhlIHRlbXBv
cmFyeSBtYXBwaW5nIGluIGEgdGVtcG9yYXJ5IE1NKSBmb3IgcHZhbGlkYXRlIHB1cnBvc2VzPyBJ
DQo+ID4gZG9uJ3Qga25vdyBlbm91Z2ggYWJvdXQgd2hhdCBraW5kIG9mIHNwZWNpYWwgZXhjZXB0
aW9ucyBtaWdodCBwb3B1cA0KPiA+IGR1cmluZyB0aGF0IG9wZXJhdGlvbiB0aG91Z2gsIG1pZ2h0
IGJlIHBsYXlpbmcgd2l0aCBmaXJlLi4uDQo+IA0KPiBJbnRlcmVzdGluZyBpZGVhLsKgIEJ1dCBm
cm9tIGEgcXVpY2sgZ2xhbmNlIGF0IHRoZSB0ZXh0X3Bva2UoKSBjb2RlLA0KPiBzdWNoIGFuIGFw
cHJvYWNoIHNlZW1zIHNvbWV3aGF0IGNvbXBsZXgsIGFuZCBJIHN1c3BlY3QgaXQgd2lsbCBoYXZl
IA0KPiB0aGUgc2FtZSBwZXJmIGlzc3VlcyAob3Igd29yc2UpIGFzIGNyZWF0aW5nIGEgbmV3IHZt
YWxsb2MgYXJlYSBmb3INCj4gZWFjaCBQVkFMSURBVEUgaW52b2NhdGlvbi4NCg0KVXNpbmcgbmV3
IHZtYWxsb2MgYXJlYSdzIHdpbGwgZXZlbnR1YWxseSByZXN1bHQgaW4gYSBrZXJuZWwgc2hvb3Rk
b3duLA0KYnV0IHVzdWFsbHkgaGF2ZSBubyBmbHVzaGVzLiB0ZXh0X3Bva2Ugd2lsbCBhbHdheXMg
cmVzdWx0IGluIGEgbG9jYWwtDQpvbmx5IGZsdXNoLiBTbyBhdCBsZWFzdCB3aGF0ZXZlciBzbG93
ZG93biB0aGVyZSBpcyB3b3VsZCBvbmx5IGFmZmVjdA0KdGhlIGNhbGxpbmcgdGhyZWFkLg0KDQpB
cyBmb3IgY29tcGxleGl0eSwgSSB0aGluayBpdCBtaWdodCBiZSBzaW1wbGUgdG8gaW1wbGVtZW50
IGFjdHVhbGx5Lg0KV2hhdCBraW5kIG9mIHNwZWNpYWwgZXhjZXB0aW9ucyBjb3VsZCBjb21lIG91
dCBvZiBwdmFsaWRhdGUsIEknbSBub3Qgc28NCnN1cmUuIEJ1dCB0aGUga2VybmVsIHRlcm1pbmF0
ZXMgdGhlIFZNIG9uIGZhaWx1cmUgYW55d2F5LCBzbyBtYXliZSBpdCdzDQpub3QgYW4gaXNzdWU/
DQogDQpkaWZmIC0tZ2l0IGEvYXJjaC94ODYva2VybmVsL2FsdGVybmF0aXZlLmMNCmIvYXJjaC94
ODYva2VybmVsL2FsdGVybmF0aXZlLmMNCmluZGV4IDczYmUzOTMxZTRmMC4uYTEzMjkzNTY0ZWVi
IDEwMDY0NA0KLS0tIGEvYXJjaC94ODYva2VybmVsL2FsdGVybmF0aXZlLmMNCisrKyBiL2FyY2gv
eDg2L2tlcm5lbC9hbHRlcm5hdGl2ZS5jDQpAQCAtMTkwNSw2ICsxOTA1LDE2IEBAIHZvaWQgKnRl
eHRfcG9rZSh2b2lkICphZGRyLCBjb25zdCB2b2lkICpvcGNvZGUsDQpzaXplX3QgbGVuKQ0KICAg
ICAgICByZXR1cm4gX190ZXh0X3Bva2UodGV4dF9wb2tlX21lbWNweSwgYWRkciwgb3Bjb2RlLCBs
ZW4pOw0KIH0NCiANCitzdGF0aWMgdm9pZCB0ZXh0X3Bva2VfcHZhbGlkYXRlKHZvaWQgKmRzdCwg
Y29uc3Qgdm9pZCAqc3JjLCBzaXplX3QNCmxlbikNCit7DQorICAgICAgIHB2YWxpZGF0ZShkc3Qs
IGxlbiwgdHJ1ZSk7IC8vIGlmIGZhaWwsIHRlcm1pbmF0ZQ0KK30NCisNCit2b2lkICpwdmFsaWRh
dGVkX3Bva2Uodm9pZCAqYWRkcikNCit7DQorICAgICAgIHJldHVybiBfX3RleHRfcG9rZSh0ZXh0
X3Bva2VfcHZhbGlkYXRlLCBhZGRyLCBOVUxMLCBQQUdFX1NJWkUpOw0KK30NCisNCiAvKioNCiAg
KiB0ZXh0X3Bva2Vfa2dkYiAtIFVwZGF0ZSBpbnN0cnVjdGlvbnMgb24gYSBsaXZlIGtlcm5lbCBi
eSBrZ2RiDQogICogQGFkZHI6IGFkZHJlc3MgdG8gbW9kaWZ5DQoNCg0KDQo+IA0KPiBBdCB0aGlz
IHBvaW50LCB0aGUgY29tcGxleGl0eSBvZiBjcmVhdGluZyB0aGUgdGVtcCBtYXBwaW5nIGZvcg0K
PiBQVkFMSURBVEUgaXMgc2VlbWluZyBleGNlc3NpdmUuwqAgT24gYmFsYW5jZSBpdCBzZWVtcyBz
aW1wbGVyIHRvDQo+IHJldmVydCB0byBhbiBhcHByb2FjaCB3aGVyZSB0aGUgdXNlIG9mIHNldF9t
ZW1vcnlfbnAoKSBhbmQNCj4gc2V0X21lbW9yeV9wKCkgaXMgY29uZGl0aW9uYWwuwqAgSXQgd291
bGQgYmUgbmVjZXNzYXJ5IHdoZW4gI1ZDDQo+IGFuZCAjVkUgZXhjZXB0aW9ucyBhcmUgZGlyZWN0
ZWQgdG8gYSBwYXJhdmlzb3IuwqAgKFRoaXMgYXNzdW1lcyB0aGUNCj4gcGFyYXZpc29yIGludGVy
ZmFjZSBpbiB0aGUgaHlwZXJ2aXNvciBjYWxsYmFja3MgZG9lcyB0aGUgbmF0dXJhbA0KPiB0aGlu
Zw0KPiBvZiB3b3JraW5nIHdpdGggcGh5c2ljYWwgYWRkcmVzc2VzLCBzbyB0aGVyZSdzIG5vIG5l
ZWQgZm9yIGEgdGVtcA0KPiBtYXBwaW5nLikNCj4gDQo+IE9wdGlvbmFsbHksIHRoZSBzZXRfbWVt
b3J5X25wKCkvc2V0X21lbW9yeV9wKCkgYXBwcm9hY2ggY291bGQNCj4gYmUgdXNlZCBpbiBvdGhl
ciBjYXNlcyB3aGVyZSB0aGUgaHlwZXJ2aXNvciBjYWxsYmFja3Mgd29yayB3aXRoDQo+IHBoeXNp
Y2FsIGFkZHJlc3Nlcy7CoCBCdXQgaXQgY2FuJ3QgYmUgdXNlZCB3aXRoIGNhc2VzIHdoZXJlIHRo
ZQ0KPiBoeXBlcnZpc29yDQo+IGNhbGxiYWNrcyBuZWVkIHZhbGlkIHZpcnR1YWwgYWRkcmVzc2Vz
Lg0KPiANCj4gU28gb24gbmV0LCBzZXRfbWVtb3J5X25wKCkvc2V0X21lbW9yeV9wKCkgd291bGQg
YmUgdXNlZCBpbg0KPiB0aGUgSHlwZXItViBjYXNlcyBvZiBURFggYW5kIFNFVi1TTlAgd2l0aCBh
IHBhcmF2aXNvci7CoMKgIEl0IGNvdWxkDQo+IG9wdGlvbmFsbHkgYmUgdXNlZCB3aXRoIFREWCB3
aXRoIG5vIHBhcmF2aXNvciwgYnV0IG15IHNlbnNlIGlzDQo+IHRoYXQgS2lyaWxsIHdhbnRzIHRv
IGtlZXAgVERYICJhcyBpcyIgYW5kIGxldCB0aGUgZXhjZXB0aW9uIGhhbmRsZXJzDQo+IGRvIHRo
ZSBsb2FkX3VuYWxpZ25lZF96ZXJvcGFkKCkgZml4dXAuDQo+IA0KPiBJdCBjb3VsZCBub3QgYmUg
dXNlZCB3aXRoIFNFVi1TTlAgd2l0aCBubyBwYXJhdmlzb3IuwqDCoCBBZGRpdGlvbmFsDQo+IGZp
eGVzDQo+IG1heSBiZSBuZWVkZWQgb24gdGhlIFNFVi1TTlAgc2lkZSB0byBwcm9wZXJseSBmaXh1
cA0KPiBsb2FkX3VuYWxpZ25lZF96ZXJvcGFkKCkgYWNjZXNzZXMgdG8gYSBwYWdlIHRoYXQncyBp
biB0cmFuc2l0aW9uDQo+IGJldHdlZW4gZW5jcnlwdGVkIGFuZCBkZWNyeXB0ZWQuDQo+IA0KDQpZ
ZWEsIEkgZG9uJ3Qga25vdyBhYm91dCB0aGlzIHBhcmF2aXNvci9leGNlcHRpb24gc3R1ZmYuDQo=

