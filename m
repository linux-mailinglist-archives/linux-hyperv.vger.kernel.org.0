Return-Path: <linux-hyperv+bounces-1279-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C9BF808EDE
	for <lists+linux-hyperv@lfdr.de>; Thu,  7 Dec 2023 18:37:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 106A52816D6
	for <lists+linux-hyperv@lfdr.de>; Thu,  7 Dec 2023 17:37:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F242A49F9B;
	Thu,  7 Dec 2023 17:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="X7bLt2/5"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D03ADD53;
	Thu,  7 Dec 2023 09:37:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701970632; x=1733506632;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ekyFTfPfGDeM8T+gbZDVn3Yolt+FCs1xmTUkRmo8VPc=;
  b=X7bLt2/5Fxqp7FcrxPCvI9tp8T9Y54NaqdO+7socK8T4WPwLUw4aw/fu
   wg5r7Atxwjr+BXeMPd+lBTvkyB2egIHJIWbMM8Nd8wEHfRlPfMOpnUx68
   hgWJMO3kZdnJoLSMJSOlpWcvw6EOeal06AxpkWCvBfk03+ps5jNlD1a8M
   KfewYbrGNGvK1pH+sk8mNe3f4d7MO83qmFqNAnRq9R7CNmciS1pNxEzxE
   39gpr86NM9K1375i9OBk7jZPGN7gwYLGFKee+UuC2bTq7RMS7/5qi9Mp5
   p/pph4a3x2cHGD2k7rLP1spWNYBba3wVq+SaQCHsUHKN8qfIzkqpcw29v
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10917"; a="384677945"
X-IronPort-AV: E=Sophos;i="6.04,258,1695711600"; 
   d="scan'208";a="384677945"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2023 09:37:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10917"; a="1019032855"
X-IronPort-AV: E=Sophos;i="6.04,258,1695711600"; 
   d="scan'208";a="1019032855"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 Dec 2023 09:36:27 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 7 Dec 2023 09:36:27 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 7 Dec 2023 09:36:26 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 7 Dec 2023 09:36:26 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 7 Dec 2023 09:36:26 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W5uClZMGnTJEnasJttlOJSAXjPRZ+HJvc9jWegou/ee3asnWfZaLWqW8SKyBSi8dLB+oPeXxUq/Dqw4JAADGveJjMbjYPK7ibu8pxyysn1+YwAfRsefIKQk+JVXI3I3M89rufVKM+5y665pdrXtKYg4KnXCX1hpz9d/fb4zy8frh7lA7Yv0EjLqQjJvzFKhowwQ5VMGAaT4O8wxzBwC/hfPGuREMzbMjL0vCaRuLNFtu+iItkcbrlTkG42dHTdlUNgJ1dpoNbdMiLz5Vq4nrzSE283+KVO5KL6gajEhC2GPq77wjnKmOoFKdxdVN/QKYKs1RrccVUF7RlyV2KQ3VBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ekyFTfPfGDeM8T+gbZDVn3Yolt+FCs1xmTUkRmo8VPc=;
 b=G5NHIBjfiDviZYQZj5ucBuR1Tq4Edw2Dzfz0Ytc4e4H3PLPAHYJ1u+ffdqZ9ddkDBrC8bkPKJhBzM9PgL2c3s+qVPEgxYa1mB2bzHoDSWJbJlAuWRzMjuxJly0p3q585J42GPVg7A/1RPT/hRVsUgz/iXGLBhWn7ggs1udqjxmp5f5HPC/VSvD660BxUgltOZSmaOkq19cvNGbINa1X0Dyq7wKXbykH0RFUoeWsdkhXr1ElIjqY2fVNDqx0Ore2edqmHAv/Ra7y/XIbGIgXhBTp108cPYTl4mg3axNnitMQ+6gfZzH6BJKShVNmfE6MKywoI88VRHajawxAyVECrqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM8PR11MB5750.namprd11.prod.outlook.com (2603:10b6:8:11::17) by
 CY5PR11MB6260.namprd11.prod.outlook.com (2603:10b6:930:23::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7068.25; Thu, 7 Dec 2023 17:36:22 +0000
Received: from DM8PR11MB5750.namprd11.prod.outlook.com
 ([fe80::f1b2:bfb1:b1b:66ed]) by DM8PR11MB5750.namprd11.prod.outlook.com
 ([fe80::f1b2:bfb1:b1b:66ed%3]) with mapi id 15.20.7068.027; Thu, 7 Dec 2023
 17:36:22 +0000
From: "Reshetova, Elena" <elena.reshetova@intel.com>
To: Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>, "Huang, Kai"
	<kai.huang@intel.com>, "kirill.shutemov@linux.intel.com"
	<kirill.shutemov@linux.intel.com>, "mhkelley58@gmail.com"
	<mhkelley58@gmail.com>, "Cui, Dexuan" <decui@microsoft.com>
CC: "cascardo@canonical.com" <cascardo@canonical.com>,
	"tim.gardner@canonical.com" <tim.gardner@canonical.com>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
	"roxana.nicolescu@canonical.com" <roxana.nicolescu@canonical.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>, "haiyangz@microsoft.com"
	<haiyangz@microsoft.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "mingo@redhat.com" <mingo@redhat.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>, "stefan.bader@canonical.com"
	<stefan.bader@canonical.com>, "nik.borisov@suse.com" <nik.borisov@suse.com>,
	"kys@microsoft.com" <kys@microsoft.com>, "hpa@zytor.com" <hpa@zytor.com>,
	"peterz@infradead.org" <peterz@infradead.org>, "wei.liu@kernel.org"
	<wei.liu@kernel.org>, "sashal@kernel.org" <sashal@kernel.org>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>, "bp@alien8.de"
	<bp@alien8.de>, "x86@kernel.org" <x86@kernel.org>
Subject: RE: [PATCH v1 1/3] x86/tdx: Check for TDX partitioning during early
 TDX init
Thread-Topic: [PATCH v1 1/3] x86/tdx: Check for TDX partitioning during early
 TDX init
Thread-Index: AQHaHWWtJXruLfiu906BueKp3+5D87CH744AgAFYfQCAAANSgIAABfUAgAApowCAAC5QgIAHFxgAgAPocgCABhmWAIAB7A4AgAF90TA=
Date: Thu, 7 Dec 2023 17:36:22 +0000
Message-ID: <DM8PR11MB57503924C64E1C79FB585496E78BA@DM8PR11MB5750.namprd11.prod.outlook.com>
References: <20231122170106.270266-1-jpiotrowski@linux.microsoft.com>
 <20231123135846.pakk44rqbbi7njmb@box.shutemov.name>
 <9f550947-9d13-479c-90c4-2e3f7674afee@linux.microsoft.com>
 <20231124104337.gjfyasjmo5pp666l@box.shutemov.name>
 <58c82110-45b2-4e23-9a82-90e1f3fa43c2@linux.microsoft.com>
 <20231124133358.sdhomfs25seki3lg@box.shutemov.name>
 <6f27610f-afc4-4356-b297-13253bb0a232@linux.microsoft.com>
 <ffcc8c550d5ba6122b201d8170b42ee581826d47.camel@intel.com>
 <02e079e8-cc72-49d8-9191-8a753526eb18@linux.microsoft.com>
 <7b725783f1f9102c176737667bfec12f75099961.camel@intel.com>
 <fa86fbd1-998b-456b-971f-a5a94daeca28@linux.microsoft.com>
In-Reply-To: <fa86fbd1-998b-456b-971f-a5a94daeca28@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR11MB5750:EE_|CY5PR11MB6260:EE_
x-ms-office365-filtering-correlation-id: 35b8340e-0e16-4049-b249-08dbf74b0793
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6h9u+7W+bHtWe2u0UfbffgNzaQpunxHR8+cv7xBsK4ctj0xrq4GxloL7uUIhnZ/c1XHPCkkjW/OSoAN1sZzokA4y+4QbjcaaYspawTkj4XhiFLjKeuRgF1t9Cf3iUnt0RRdAfLGKzBT827M7PzxtDkLIVIG6HgbXuACfezVLFHHvU9Pvq2trJfIlmiiTRi+LPq+gtKoXti4GsTCxw9n/HkRPqyVyS60EjR6Q/iEjHm6xGuc2ppqkf5tCu8NsQZpGBHyHGRgQ+rRuLRALU0Nkfk2wWRMS0Un0u18uYjO+I1vKeXuxHcXuJ9zCtnATU3g+mwoBcZVV0hOeZPlG9wWrvkJSf5uLi3MFCV2fO7s5u/jSogaVixdeRipeFoaAOq535xWukElFjmyy2p24UWYYD3NTCuLCtS3P9ZHjRpX6Wx4L5jIVL6sT8yNOHblIDCFB/UqzMheTLjJnAfIE6UoX9tZegORXdZN/daT24pdPg624OF4dsTB6KXaLKZjnNiK3/MXmhr53JvN5p774gQ5BQEcSfBAGy/7cuUc+Z8d7PobbGXjn9MSaq4ai7znt//aeml8ReYdsQCKTNxgzHp67MVd0qsAzoHQeHVOnxXAz2zU9CQRBM55MF5RlqLExpMes
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5750.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(346002)(136003)(366004)(39860400002)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(26005)(7696005)(71200400001)(6506007)(9686003)(83380400001)(82960400001)(5660300002)(52536014)(8676002)(478600001)(7416002)(8936002)(66476007)(4326008)(55016003)(54906003)(64756008)(66446008)(66556008)(86362001)(316002)(76116006)(122000001)(38100700002)(110136005)(66946007)(33656002)(2906002)(41300700001)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RXJHQlpmanF2QWw3cnpXV3htYit1bSs5dFA3cVhwUE0vbHNjRVl1Z2JPa1F1?=
 =?utf-8?B?QldxYUVhY1BHazU3K3lwMjcycXBVcWk0S05kMXFJRW1qOFdzQXlROUdKUjM5?=
 =?utf-8?B?S3ovUXZKR1h2SjZYVG8xd0ZtL1M5cnMxdTFtV3ZmSGZtemNlcjNiS3RidzlJ?=
 =?utf-8?B?Qy81c1o5cTBDdXpBZk1IZTRLb3pYaUQvVm5jU252MXY4WjArM0twNnNycmpz?=
 =?utf-8?B?ZlJEeUpLa2NxZzZmYnArS21sM2pCMllQbjd2ZVd4WlczdVg0N1pwWjFhMTRx?=
 =?utf-8?B?S2tndmZNWktOeEI5NXNyVnU0R2g5VEFBTWlINWJnWkdBSE15SXRZc0RWelZM?=
 =?utf-8?B?a2dMNGVyQVMwakh0cmdtcWxxRDZoK1pYeTBrSU43K0JxM0FVVHRjSDFzR2pu?=
 =?utf-8?B?VUhrZEFMTUhZdTUwaSsweE1MaENYUDJXd01nUU5hNGN0ZForZWVVQUNYQ0tJ?=
 =?utf-8?B?TFdaMW5aZXFiZFluS3VZU3JzRWJjQ012WVhaeTRLazdBeXZWUUdsUHFGS3lO?=
 =?utf-8?B?bnBSbnNNbTRKRlZyRzhJekV0YUdSY1lnTlNqRmJUS2xlKzZRbjNmakpMRUxq?=
 =?utf-8?B?WExVZnlaQWFTUmk0Rmo4NkJrNzhEakZSYjh3aVBHS2RMSUxxM1RqNHBSOXRI?=
 =?utf-8?B?dlRvOFhSeGxhaEc3RlpVWFhWckRZMTdoV2VSRGdxYmFOdW9GYWpQNHoraXNr?=
 =?utf-8?B?aVY2WXRNQ3djK3M3Q01sK0h4WWN0eWI1b0E2NE0zMWl3OE8wNFg3NHl0K251?=
 =?utf-8?B?SUZMN2x3RTVQbDhPZkRMSFpjOUdGNUR1ai9LbTluaWRkb3Q1dmRPYlE5cUNO?=
 =?utf-8?B?bHZwVGFLdW1PcUFQT3g0R2tKaHJ1OE90bkF0VkZwZjdwbEkwMG5tK0tRMjcw?=
 =?utf-8?B?R1d1cUcwSmdVK1A5VWJ2b3VtdkQ0Y1ZLWndKamlXSHdacG4rQ003cFBGaDJz?=
 =?utf-8?B?cURDT3NOMWlLbi9JZkhhZTZGNExUcHk5N0ZtbDVjYVNpT2hwRXd4RVdMUmY3?=
 =?utf-8?B?c0pQbDZON2xneU9GS1hBbUNhZVVDUkQ1KzVGampFZ0tlV1ZPSGYrTjF3alAr?=
 =?utf-8?B?dVFPWHFzVXF1Qk1ZU05SZ21tTUVMelN3ODRMTVBGb1RHMzFLQkZPSjNHck9r?=
 =?utf-8?B?dHE2MktLZy9TbG5yK3ZzVTlLNGhRRDV1U2Evall3NDlxZGZoc0krTnBBY2FS?=
 =?utf-8?B?Q0ZVVmdJUjY5Mkptb28zWkNVUmorY2kvVTMrQzAxWjRCY1RPdng1U0JsN3Fm?=
 =?utf-8?B?Slk3WnExRDNHdUlFYkN4ZGJyeDJpaW4vSTAzTzEwOHcycGRjVERUd1RzeGdB?=
 =?utf-8?B?V0w5ZldTQmIwd3R4UTBPNEk1Si9jaWdkR1FtNG51Ny9wVDU0ZnQ1SDBSaEt6?=
 =?utf-8?B?WTI2eTFKQmZzN0hxY3E2eHc3eHRxVThHZnQ0OHhFSUFxemNILy9xMisrRm4v?=
 =?utf-8?B?Nk1FUlEvejR0QU1HSHBneUJ6akNZUkZGdGJyTll5TW1RaGFsRGZqZjFKZWNx?=
 =?utf-8?B?ZElrWDBVNG9rMUxLTnlIZVRLdFQvUUVXT3lQU3dpZHpScEJ6UmFzdGV2aGIz?=
 =?utf-8?B?L1lqVXM4OEZ0WFZPNEM4Zm9UcitBNjY4NndLUS9lSWhzZkk4Z29XOXg1UzA3?=
 =?utf-8?B?T0hqRFY4dEN5VHRQNFRGbUI1YmR4SWZvSXhxZjkwUWJ5eTFIc3c2K05WMUFw?=
 =?utf-8?B?Y3VyWE1rZG9ud1hxUlJFWEg0ejR2eVlzcjNxMnZJSFg0VjZHeEdrWk92clhI?=
 =?utf-8?B?U0NyVTQ4blBXRjFjMi8yWFhvcnBpUmxxdlg0SUowZVJHMnptQWlFS0svTS9D?=
 =?utf-8?B?VmtPZVJMYmJYamVFZnNPbnplcnNxRlQxcW1jaDU1aE9PaUlHRGZnb0lCa1ln?=
 =?utf-8?B?cXZzNUdsUDNYK2VNUzQ2Q05tVlVmUWtUVVAzSXpLSXF0MVdUZkdTdmRJZFRi?=
 =?utf-8?B?TVVHV2lrb25TVk5QdGVkMlMra1UxNk11dFFRMDM2UjJMRURxYXhGM3AxNkJP?=
 =?utf-8?B?eVVKWlAzYnFNVkVRYTJydEdBaldmT3lma2ppZkh2a2krRkJxOENNMk5sRU1H?=
 =?utf-8?B?SEJvbmFoMklhVUxnbWpEMnd3NWF0N1NGNjZSL1Eza2d1NlBqM3JvdU5DcG1w?=
 =?utf-8?Q?YkEtNH10mbmh75j7agtqXoWIu?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 35b8340e-0e16-4049-b249-08dbf74b0793
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Dec 2023 17:36:22.4315
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FvvOTFfSOQvLBw+taX4xt+QNhjbufbuAfRfkmZqLOIA1zPHANGR6KOZ+3wL2vpDf6O/8yyl6aWeUhddxrQv1dB4qVvDAOrOagJVyf0VAyhc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6260
X-OriginatorOrg: intel.com

PiA+PiBUaGUgVERWTUNBTExzIGFyZSByZWxhdGVkIHRvIHRoZSBJL08gcGF0aCAobmV0d29ya2lu
Zy9ibG9jayBpbykgaW50byB0aGUgTDINCj4gZ3Vlc3QsIGFuZA0KPiA+PiBzbyB0aGV5IGludGVu
dGlvbmFsbHkgZ28gc3RyYWlnaHQgdG8gTDAgYW5kIGFyZSBuZXZlciBpbmplY3RlZCB0byBMMS4g
TDEgaXMgbm90DQo+ID4+IGludm9sdmVkIGluIHRoYXQgcGF0aCBhdCBhbGwuDQo+ID4+DQo+ID4+
IFVzaW5nIHNvbWV0aGluZyBkaWZmZXJlbnQgdGhhbiBURFZNQ0FMTHMgaGVyZSB3b3VsZCBsZWFk
IHRvIGFkZGl0aW9uYWwNCj4gdHJhcHMgdG8gTDEgYW5kDQo+ID4+IGp1c3QgYWRkIGxhdGVuY3kv
Y29tcGxleGl0eS4NCj4gPg0KPiA+IExvb2tzIGJ5IGRlZmF1bHQgeW91IGFzc3VtZSB3ZSBzaG91
bGQgdXNlIFREWCBwYXJ0aXRpb25pbmcgYXMgInBhcmF2aXNvciBMMSIgKw0KPiA+ICJMMCBkZXZp
Y2UgSS9PIGVtdWxhdGlvbiIuDQo+ID4NCj4gDQo+IEkgZG9uJ3QgYWN0dWFsbHkgd2FudCB0byBp
bXBvc2UgdGhpcyBtb2RlbCBvbiBhbnlvbmUsIGJ1dCB0aGlzIGlzIHRoZSBvbmUgdGhhdA0KPiBj
b3VsZCB1c2Ugc29tZSByZWZhY3RvcmluZy4gSSBpbnRlbmQgdG8gcmV3b3JrIHRoZXNlIHBhdGNo
ZXMgdG8gbm90IHVzZSBhIHNpbmdsZQ0KPiAidGRfcGFydGl0aW9uaW5nX2FjdGl2ZSIgZm9yIGRl
Y2lzaW9ucy4NCj4gDQo+ID4gSSB0aGluayB3ZSBhcmUgbGFja2luZyBiYWNrZ3JvdW5kIG9mIHRo
aXMgdXNhZ2UgbW9kZWwgYW5kIGhvdyBpdCB3b3Jrcy4gIEZvcg0KPiA+IGluc3RhbmNlLCB0eXBp
Y2FsbHkgTDIgaXMgY3JlYXRlZCBieSBMMSwgYW5kIEwxIGlzIHJlc3BvbnNpYmxlIGZvciBMMidz
IGRldmljZQ0KPiA+IEkvTyBlbXVsYXRpb24uICBJIGRvbid0IHF1aXRlIHVuZGVyc3RhbmQgaG93
IGNvdWxkIEwwIGVtdWxhdGUgTDIncyBkZXZpY2UgSS9PPw0KPiA+DQo+ID4gQ2FuIHlvdSBwcm92
aWRlIG1vcmUgaW5mb3JtYXRpb24/DQo+IA0KPiBMZXQncyBkaWZmZXJlbnRpYXRlIGJldHdlZW4g
ZmFzdCBhbmQgc2xvdyBJL08uIFRoZSB3aG9sZSBwb2ludCBvZiB0aGUgcGFyYXZpc29yIGluDQo+
IEwxIGlzIHRvIHByb3ZpZGUgZGV2aWNlIGVtdWxhdGlvbiBmb3Igc2xvdyBJL086IFRQTSwgUlRD
LCBOVlJBTSwgSU8tQVBJQywgc2VyaWFsDQo+IHBvcnRzLg0KDQpPdXQgb2YgbXkgY3VyaW9zaXR5
IGFuZCBub3QgcmVhbGx5IHJlbGF0ZWQgdG8gdGhpcyBkaXNjdXNzaW9uLCBidXQgY291bGQgeW91
IHBsZWFzZQ0KZWxhYm9yYXRlIG9uIFJUQyBwYXJ0IGhlcmU/IERvIHlvdSBhY3R1YWxseSBob3N0
IHNlY3VyZSB0aW1lIGluIEwxIHRvIGJlIHByb3ZpZGVkDQp0byB0aGUgTDI/IA0KDQpCZXN0IFJl
Z2FyZHMsDQpFbGVuYS4NCg==

