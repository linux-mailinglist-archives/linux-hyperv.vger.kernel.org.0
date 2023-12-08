Return-Path: <linux-hyperv+bounces-1295-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F4DA80A175
	for <lists+linux-hyperv@lfdr.de>; Fri,  8 Dec 2023 11:51:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2BFCC1F21367
	for <lists+linux-hyperv@lfdr.de>; Fri,  8 Dec 2023 10:51:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B28712B70;
	Fri,  8 Dec 2023 10:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CZqLpZ4V"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56FB710C2;
	Fri,  8 Dec 2023 02:51:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702032690; x=1733568690;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=9RoEiuUPCHkt+1IHsoPh/jx7K0YHObOd/nZSvqx2YEs=;
  b=CZqLpZ4VIA5gqvpOzIbU9VgWVvSKXQ9/93KbCE75Qof+Rf4WW6Kua562
   d4UBleAHdZ3FSTM9rdo7RtixK+FaACQDg6nBqe4pe3V9UyNXGLxPk5/Cn
   xzsx2DyLGz6d86CXaTrYuIBE+DRuPc9hEkhp8dWPEfcU9OFxiQBanv1Uv
   OX40gG7gkzmBXX3XrXmnv2yEXTLichZ1u50K1Y6f2kt098t7fqdkYBMrk
   UcqOXKDr8r6rObbJHCHH13jXCT5iW4Jp4PRFK9C2xZ3dXwMmc5kIAQAZ0
   Ov9Tpk4gI1z6Gs4Wc/jAtX0kTAXbN5Bxr1CiWLrvxP7voqocfUkczcXrE
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10917"; a="394129650"
X-IronPort-AV: E=Sophos;i="6.04,260,1695711600"; 
   d="scan'208";a="394129650"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2023 02:51:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10917"; a="838091254"
X-IronPort-AV: E=Sophos;i="6.04,260,1695711600"; 
   d="scan'208";a="838091254"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Dec 2023 02:51:28 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 8 Dec 2023 02:51:28 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 8 Dec 2023 02:51:28 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 8 Dec 2023 02:51:28 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 8 Dec 2023 02:51:27 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jFw7+C5YEN0TTtDmhKvQPFS8qkGG0bsDyCX79UuFJOQXdUmBmD6thm9G95RUKmkiFOOtCk4IfsEmaRgi87SmsdxakiSRr9PuWTKMfjvyL7sXnGh0DYQ3outvqtUFfNkt2xN8tGZ9xdD6Lqje1YmuDsv+v/gW3St7D9VHmm4pekeE4ebzJv9qwNgvaBNdoycCLVMf/+io/hkRoIiRPGGZ0mmTAIw5q1PQnoalL4V8Ddib/5VbmOsvg7AIqeEF5S1b3HNmHqh69iX94nkOgvQMvSGU08F7GYLExd6lc7QhihK8ASTXYCE1am0tLTdq+Urjeteasoi7REMLeIJ3G8pL6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9RoEiuUPCHkt+1IHsoPh/jx7K0YHObOd/nZSvqx2YEs=;
 b=PK8B61G0seD5QbT6G6y4wQkKP8fq5XJbXeMBc73Kfpd2hu6BFy262rZpcNjEmhiQloM4soX/dL79BBGA0VTXP1sxYz15s11v42GsMNiCF6T4QaeN7GkzOjcNHtCHwSczKwlpl+rzbwkzPrZMMaE+m0OTB/fYpTcCph4gSBEllFMnBq7xAIGJukKvEeYlFWYCZWuxNrRRenlUzzsV51guonEE1Ub5srRddZs76EretmXLN8oU5xkIqqD+FySj60suSTUuwC80FL+50mF+oJTkrKhfBmdYh1L5NxGDK/ID4jsnPH4/JKE8IYpv2xqsitJtoEttLq3sBuTpzRfK0Rawmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by DM4PR11MB6456.namprd11.prod.outlook.com (2603:10b6:8:bc::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.28; Fri, 8 Dec
 2023 10:51:24 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::5d1:aa22:7c98:f3c6]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::5d1:aa22:7c98:f3c6%7]) with mapi id 15.20.7068.028; Fri, 8 Dec 2023
 10:51:24 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
	"Reshetova, Elena" <elena.reshetova@intel.com>, "mhkelley58@gmail.com"
	<mhkelley58@gmail.com>, "Cui, Dexuan" <decui@microsoft.com>,
	"jpiotrowski@linux.microsoft.com" <jpiotrowski@linux.microsoft.com>,
	"bp@alien8.de" <bp@alien8.de>
CC: "cascardo@canonical.com" <cascardo@canonical.com>,
	"tim.gardner@canonical.com" <tim.gardner@canonical.com>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
	"roxana.nicolescu@canonical.com" <roxana.nicolescu@canonical.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>, "haiyangz@microsoft.com"
	<haiyangz@microsoft.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "mingo@redhat.com" <mingo@redhat.com>,
	"kys@microsoft.com" <kys@microsoft.com>, "stefan.bader@canonical.com"
	<stefan.bader@canonical.com>, "nik.borisov@suse.com" <nik.borisov@suse.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>, "hpa@zytor.com" <hpa@zytor.com>,
	"peterz@infradead.org" <peterz@infradead.org>, "wei.liu@kernel.org"
	<wei.liu@kernel.org>, "sashal@kernel.org" <sashal@kernel.org>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH v1 1/3] x86/tdx: Check for TDX partitioning during early
 TDX init
Thread-Topic: [PATCH v1 1/3] x86/tdx: Check for TDX partitioning during early
 TDX init
Thread-Index: AQHaHWWtv7u0f2izB0aVCuwkdix+ibCH744AgAFYfQCAAANSgIAABfUAgAApowCAAC5QgIAHFxKAgAPoeACABhmPAIAB7BUAgAEw/ICAAElrgIAAJXCAgAD/3YA=
Date: Fri, 8 Dec 2023 10:51:23 +0000
Message-ID: <205012749b2f88acf39112673b3e97ee18bdcfe9.camel@intel.com>
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
	 <59bdfee24a9c0f7656f7c83e65789d72ab203edc.camel@intel.com>
	 <8362bf44-f933-4a7e-9e56-a7c425a2ba5a@linux.microsoft.com>
	 <6ec6b73e-c3f6-4952-9835-0dbc4b7c199f@linux.microsoft.com>
In-Reply-To: <6ec6b73e-c3f6-4952-9835-0dbc4b7c199f@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.48.4 (3.48.4-1.fc38) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|DM4PR11MB6456:EE_
x-ms-office365-filtering-correlation-id: 0bd0798b-56de-4627-0678-08dbf7db9eeb
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8wGNjJgBTnwNZ+8y925qBVfxOX3jDY2okmnKhbjQ8uWVqnWhCZVFAUFGviuAJU/bpTc4O2q7C4r9fB742DExSqg0oIbtqKxoFbVEYE6gLfYT1S0d9ufF20Pd1bGLWtNwIrq8mDJuEEIL1D627vRqTjv6FFAx1KmVWKY5eLlDpgGiiSJJU5WEnNmshcumb9bX/UJI12irOS54gd6HTOCRencjhFPUXcEuMmTK148JwemMQ6wXFxVIMlwG7Mw3KWytZpHlz0L8eSLZr1+qiMLtjvmsE/cTSgVTyuov4/gHvzpGja4pldy0Mwj8hWcrzZc/SlcaA1oJv4UlVyMK3uzbJVi1LuZ21aJQFdpvRDxRB573b3/69Jdqp11PnEL//NPjbeKNxqOXuDLj+hVApzkj+JtHN2lJ80xzbuZrY+1YIo8/dcAy9jlClF2QeUeNGgYZh6QzltFbTfE3UNXfBcSgfWg6LsputNa0OUNWeP2WVa89PsHRvd/7rLz6Or1lT7XCSq86UVXZgFtraH/AzOHGxoiN5Ag9BCMPMx88lr8IkU/tWqw6cN0JxwtlRQtMFH9l35ShWDpOCuHzvMGHYZROToHl4pQy2fChevAmq5GzycPUeYY69LA8yMLvjyVMMBVC
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(39860400002)(376002)(346002)(366004)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(53546011)(6512007)(2616005)(26005)(41300700001)(4326008)(8676002)(8936002)(316002)(7416002)(2906002)(5660300002)(6486002)(478600001)(6506007)(71200400001)(110136005)(91956017)(54906003)(64756008)(66446008)(66476007)(66556008)(76116006)(66946007)(36756003)(82960400001)(122000001)(38100700002)(38070700009)(86362001)(66899024);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VzNkWHVjbXQvbm5MeWR6SllZRlYrN0FPWG9PVkZXQVJBbEh6blpjVzBPeUhu?=
 =?utf-8?B?UlVtbHJYVityZ0ZJa1NHaC9IajNHcmtIQUJzaFpaN1lJK2VxbVFIR2RtclVB?=
 =?utf-8?B?R3k3ZjgyeThNQlJ0dWw0aHE4NjYzaXowbHBvaHVrUkpabGJKTC9xQzNiaTRO?=
 =?utf-8?B?VENQTVJwNzRaTHp1ZGpwdjlCblNKUzJSL1A3dWQ3Smc1d3pLeWJWL0gwWTgy?=
 =?utf-8?B?eGdVMVdlbFFQZS91T0VsMDYzRDdpOVVxUXVCcytUY3p5VEMvUk9mbTZib3dL?=
 =?utf-8?B?ZEpzRDdzYjR0SUdwVWpRWmdneVBWNTA4bmsrZTJCUGtmc0lJT3Y2bHNOMTRy?=
 =?utf-8?B?V0hPUU1LczNwUUhKTFFMWloyendwVmcvTFdpSGZ2ekR4bmVJRGhEYm5NN1RO?=
 =?utf-8?B?TkJLS3Y2VXhEcldHY2ZDaTdpVThTQitseE4zYTkxS1A2RkVWUGJGMkxhRXZL?=
 =?utf-8?B?OWx5NzNwSVkyNGhBZ3hmTERGVStzSmFmRmtONzloSXFhcjB2enE1bkp6QzB2?=
 =?utf-8?B?WFVjV2Z5RTBsZVVKUmRNNkVBY3Nmd2pDelNQTVlhc2o1YWVISkE4Mm8yaCs0?=
 =?utf-8?B?SG9hMy9ENkFBVVRUUXp2bnJjeWJTcHFCZGprbXlYMFNqV1Zpb3UxT0xDY1Bs?=
 =?utf-8?B?WlJBaHk3TDRTd2JHZWpBdEFIUWZ1T0ErQThpcjQwUGg2RW9PeW1pY0twTmlx?=
 =?utf-8?B?MjMxVDcwMXEzSHRLOEUzOW52dm56REMzOWd2VmdzYk5qdDU4SHVnbWx1amZK?=
 =?utf-8?B?UjlORmI0ZWt1RVkrNVQ0SkN1ZjVUWG5Lb2tNZHRjMUM0K1hYaHEwejB3cHZH?=
 =?utf-8?B?VkZ1U0NnYTlMYjdSb09GZVRjVUxYaWNub0FvRHM5TGUvMHdTRlQ3bjM3ckdE?=
 =?utf-8?B?MEtqbjZ4WnFQWFFMWnVjN0IrQ2hsRDA3MFhNTkE3czdYOXNCY0ZLN0FCazdL?=
 =?utf-8?B?aVZCbjlzaHd1MXNCVVc3NnF4RTlFZ29sRGVtdklCbHhMRmU1QktORXJLTFR1?=
 =?utf-8?B?a0RYbVdTOENmVDVudVVmbE5KL3pUWlZwaG9nK1V1R3ZyL0ZGVjlkSkZ1R1Fj?=
 =?utf-8?B?cnd2emNrN1YzUXh1UVRvT0t2Rm41QndxZExhdkw0Q2g0VGY3L1lwMXBLaW9l?=
 =?utf-8?B?Ulp1Y3BjdHhkSGk5Y1lCdHBxdkFjNnlnWWRuZ0o5aS9UTnFlWURRZWpoSCs5?=
 =?utf-8?B?anVNNitacUZoRWFyUnlHRytvMWFOYTgyaCtVeWxOMDdnWDhjM3o3d0xlY1JP?=
 =?utf-8?B?bS94STZiLzhEcVB1eVgreVhLSFRZRkRXckZ1aEZQNXRFRUw0U2VlREVnd1FL?=
 =?utf-8?B?d3Y0TXo3NlR6OHNHZXBTR1lPMlM3WE5DbllBVXJSSTQvOHBSUG9BUno4ZWdn?=
 =?utf-8?B?VGJSZWdEdm9Janh1Z282ckZ0a08yRFFhWEFCSnhMVmFkQlZ3MWtDRFNpbE9a?=
 =?utf-8?B?Q25sSVRpY3dtWlBQT3RaK0IyWmJrYUxRUFMybW5xeXM3cmtoWXdlSDRRRFZ6?=
 =?utf-8?B?c01GOExWRmZtajY2Wk5TakFWNkdwenpHS0Z3Y3ViV0prVzJ5SGxyS2VLZDA4?=
 =?utf-8?B?RTJpKythM3FxSTZVYWxUd2hPNDY2Mzk1V0dHRWFzMEZ2V2RUYWNDOXJ2MnEx?=
 =?utf-8?B?UG51eEhDRWJxa21vd3ozWnJpOEVsU1JqT1MzWDJoSmx3Qy9INTFHdjVVcU5h?=
 =?utf-8?B?U0tnd01hOVc5MExxY1hnTWpGUXFmcHlwd296NjZBMlVuMnpBNUFJRndMMW5H?=
 =?utf-8?B?djl2aVR4RUtCTnNzMXlxcm9XOGtESjJaS3ZzR2wwcHdPanF3ZjVIbWtnVUR2?=
 =?utf-8?B?UCswWVpoT3YzYkpnWURVaUc2S2x5OUpoKzFSMCs0cStRY2RkM3MwSDVuQXNl?=
 =?utf-8?B?eHFjRmxoM0pHSHNRL2poSFkzSWRJam16R2VPWm03bmg0TW1UenN4ZVZuYlJm?=
 =?utf-8?B?M1p2b2JhTU1Ga0VaZStCVjBNMU43dUd5aS9WVHVHQUw2UUhRbDFUV3QxbzNQ?=
 =?utf-8?B?cEozL3Z1U0JKUkQ1RmdaZkhtTGVPMlkvcXl5N1hZT1FoNzRBYXdpU3cvR2dh?=
 =?utf-8?B?QjIwK0M1WEFvYnFQdzd0WUR3ek54NnBPbnJhSCtnMWY2WXU5Mk5uWllxM3BP?=
 =?utf-8?B?bnhtNXZjNnBITENuUHB4TzZyY0dlUHhOa3prbzJKdjkwN1VyNGdKMTFRSGZX?=
 =?utf-8?B?UEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <01996673CBDAB545B4984DA150494E6F@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bd0798b-56de-4627-0678-08dbf7db9eeb
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Dec 2023 10:51:23.8831
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CT3B99nmlgDbdRkrX8mopD4LgW04BK8AMhUBlqMHA1YmcV5yI8lFnGv4SJFgNyEB8pgA0Y7Rp6Y263CezgO5Gg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6456
X-OriginatorOrg: intel.com

T24gVGh1LCAyMDIzLTEyLTA3IGF0IDIwOjM1ICswMTAwLCBKZXJlbWkgUGlvdHJvd3NraSB3cm90
ZToNCj4gT24gMDcvMTIvMjAyMyAxODoyMSwgSmVyZW1pIFBpb3Ryb3dza2kgd3JvdGU6DQo+ID4g
T24gMDcvMTIvMjAyMyAxMzo1OCwgSHVhbmcsIEthaSB3cm90ZToNCj4gPiA+ID4gDQo+ID4gPiA+
IFRoYXQncyBob3cgaXQgY3VycmVudGx5IHdvcmtzIC0gYWxsIHRoZSBlbmxpZ2h0ZW5tZW50cyBh
cmUgaW4gaHlwZXJ2aXNvci9wYXJhdmlzb3INCj4gPiA+ID4gc3BlY2lmaWMgY29kZSBpbiBhcmNo
L3g4Ni9oeXBlcnYgYW5kIGRyaXZlcnMvaHYgYW5kIHRoZSB2bSBpcyBub3QgbWFya2VkIHdpdGgN
Cj4gPiA+ID4gWDg2X0ZFQVRVUkVfVERYX0dVRVNULg0KPiA+ID4gDQo+ID4gPiBBbmQgSSBiZWxp
ZXZlIHRoZXJlJ3MgYSByZWFzb24gdGhhdCB0aGUgVk0gaXMgbm90IG1hcmtlZCBhcyBURFggZ3Vl
c3QuDQo+ID4gWWVzLCBhcyBFbGVuYSBzYWlkOg0KPiA+ICIiIg0KPiA+IE9LLCBzbyBpbiB5b3Vy
IGNhc2UgaXQgaXMgYSBkZWNpc2lvbiBvZiBMMSBWTU0gbm90IHRvIHNldCB0aGUgVERYX0NQVUlE
X0xFQUZfSUQNCj4gPiB0byByZWZsZWN0IHRoYXQgaXQgaXMgYSB0ZHggZ3Vlc3QgYW5kIGl0IGlz
IG9uIHB1cnBvc2UgYmVjYXVzZSB5b3Ugd2FudCB0byANCj4gPiBkcm9wIGludG8gYSBzcGVjaWFs
IHRkeCBndWVzdCwgaS5lLiBwYXJ0aXRpb25lZCBndWVzdC4gDQo+ID4gIiIiDQo+ID4gVERYIGRv
ZXMgbm90IHByb3ZpZGUgYSBtZWFucyB0byBsZXQgdGhlIHBhcnRpdGlvbmVkIGd1ZXN0IGtub3cg
dGhhdCBpdCBuZWVkcyB0bw0KPiA+IGNvb3BlcmF0ZSB3aXRoIHRoZSBwYXJhdmlzb3IgKGUuZy4g
YmVjYXVzZSBURFZNQ0FMTHMgYXJlIHJvdXRlZCB0byBMMCkgc28gdGhpcyBpcw0KPiA+IGV4cG9z
ZWQgaW4gYSBwYXJhdmlzb3Igc3BlY2lmaWMgd2F5IChjcHVpZHMgaW4gcGF0Y2ggMSkuDQo+ID4g
DQo+ID4gPiANCj4gPiA+ID4gDQo+ID4gPiA+IEJ1dCB3aXRob3V0IFg4Nl9GRUFUVVJFX1REWF9H
VUVTVCB1c2Vyc3BhY2UgaGFzIG5vIHVuaWZpZWQgd2F5IHRvIGRpc2NvdmVyIHRoYXQgYW4NCj4g
PiA+ID4gZW52aXJvbm1lbnQgaXMgcHJvdGVjdGVkIGJ5IFREWCBhbmQgYWxzbyB0aGUgVk0gZ2V0
cyBjbGFzc2lmaWVkIGFzICJBTUQgU0VWIiBpbiBkbWVzZy4NCj4gPiA+ID4gVGhpcyBpcyBkdWUg
dG8gQ0NfQVRUUl9HVUVTVF9NRU1fRU5DUllQVCBiZWluZyBzZXQgYnV0IFg4Nl9GRUFUVVJFX1RE
WF9HVUVTVCBub3QuDQo+ID4gPiANCj4gPiA+IENhbiB5b3UgcHJvdmlkZSBtb3JlIGluZm9ybWF0
aW9uIGFib3V0IHdoYXQgZG9lcyBfdXNlcnNwYWNlXyBkbyBoZXJlPw0KPiA+IA0KPiA+IEkgZ2F2
ZSBvbmUgdXNlY2FzZSBpbiBhIGRpZmZlcmVudCBlbWFpbC4gQSB3b3JrbG9hZCBzY2hlZHVsZXIg
bGlrZSBLdWJlcm5ldGVzIG1pZ2h0IHdhbnQgdG8NCj4gPiBwbGFjZSBhIHdvcmtsb2FkIGluIGEg
Y29uZmlkZW50aWFsIGVudmlyb25tZW50LCBhbmQgbmVlZHMgYSB3YXkgdG8gZGV0ZXJtaW5lIHRo
YXQgYSBWTSBpcw0KPiA+IFREWCBwcm90ZWN0ZWQgKG9yIFNOUCBwcm90ZWN0ZWQpIHRvIG1ha2Ug
dGhhdCBwbGFjZW1lbnQgZGVjaXNpb24uDQo+ID4gDQo+ID4gPiANCj4gPiA+IFdoYXQncyB0aGUg
ZGlmZmVyZW5jZSBpZiBpdCBzZWVzIGEgVERYIGd1ZXN0IG9yIGEgbm9ybWFsIG5vbi1jb2NvIGd1
ZXN0IGluDQo+ID4gPiAvcHJvYy9jcHVpbmZvPw0KPiA+ID4gDQo+ID4gPiBMb29rcyB0aGUgd2hv
bGUgcHVycG9zZSBvZiB0aGlzIHNlcmllcyBpcyB0byBtYWtlIHVzZXJzcGFjZSBoYXBweSBieSBh
ZHZlcnRpc2luZw0KPiA+ID4gVERYIGd1ZXN0IHRvIC9wcm9jL2NwdWluZm8uICBCdXQgaWYgd2Ug
ZG8gdGhhdCB3ZSB3aWxsIGhhdmUgYmFkIHNpZGUtZWZmZWN0IGluDQo+ID4gPiB0aGUga2VybmVs
IHNvIHRoYXQgd2UgbmVlZCB0byBkbyB0aGluZ3MgaW4geW91ciBwYXRjaCAyLzMuDQo+ID4gPiAN
Cj4gPiANCj4gPiBZZXMsIGV4YWN0bHkuIEl0J3MgdW5pZnlpbmcgdGhlIHR3byBhcHByb2FjaGVz
IHNvIHRoYXQgdXNlcnNwYWNlIGRvZXNuJ3QgaGF2ZSB0bw0KPiA+IGNhcmUuDQo+ID4gDQo+ID4g
PiBUaGF0IGRvZXNuJ3Qgc2VlbSB2ZXJ5IGNvbnZpbmNpbmcuDQo+ID4gDQo+ID4gV2h5IG5vdD8g
DQo+ID4gVGhlIHdob2xlIHBvaW50IG9mIHRoZSBrZXJuZWwgaXMgdG8gcHJvdmlkZSBhIHVuaWZp
ZWQgaW50ZXJmYWNlIHRvIHVzZXJzcGFjZSBhbmQNCj4gPiBhYnN0cmFjdCBhd2F5IHRoZXNlIHNt
YWxsIGRpZmZlcmVuY2VzLsKgDQo+ID4gDQoNCkFncmVlIGl0J3MgYmV0dGVyLg0KDQo+ID4gWWVz
IGl0IHJlcXVpcmVzIHNvbWUga2VybmVsIGNvZGUgdG8gZG8sDQo+ID4gdGhhdHMgbm90IGEgcmVh
c29uIHRvIGZvcmNlIGV2ZXJ5IHVzZXJzcGFjZSB0byBpbXBsZW1lbnQgaXRzIG93biBsb2dpYy4g
VGhpcyBpcw0KPiA+IHdoYXQgdGhlIGZsYWdzIGluIC9wcm9jL2NwdWluZm8gYXJlIGZvci4NCj4g
PiANCg0KQWdyZWUgL3Byb2MvY3B1aW5mbyBfY2FuXyBiZSBvbmUgY2hvaWNlLCBidXQgSSBhbSBu
b3Qgc3VyZSB3aGV0aGVyIGl0IGlzIHRoZQ0KYmVzdCBjaG9pY2UgKGZvciB5b3VyIGNhc2UpLg0K
DQo+IA0KPiBTbyBJIGZlZWwgbGlrZSB3ZSdyZSBmaW5hbGx5IGdldHRpbmcgdG8gdGhlIGdpc3Qg
b2YgdGhlIGRpc2FncmVlbWVudHMgaW4gdGhpcyB0aHJlYWQuDQo+IA0KPiBIZXJlJ3Mgc29tZXRo
aW5nIEkgdGhpbmsgd2Ugc2hvdWxkIGFsbCBhZ3JlZSBvbiAoYm90aCBhKSBhbmQgYikpLiBYODZf
RkVBVFVSRV9URFhfR1VFU1Q6DQo+IGEpIGlzIHZpc2libGUgdG8gdXNlcnNwYWNlIGFuZCBub3Qg
anVzdCBzb21lIGtlcm5lbC1vbmx5IGNvbnN0cnVjdA0KPiBiKSBtZWFucyAidGhpcyBpcyBhIGd1
ZXN0IHJ1bm5pbmcgaW4gYW4gSW50ZWwgVERYIFRydXN0IERvbWFpbiwgYW5kIHNhaWQgZ3Vlc3Qg
aXMgYXdhcmUNCj4gICAgb2YgVERYIg0KPiANCj4gYSkgaXMgb2J2aW91cyBidXQgSSB0aGluayBu
ZWVkcyByZXN0YXRpbmcuIGIpIGlzIHdoYXQgdXNlcnNwYWNlIGV4cGVjdHMsIGFuZCBleGNsdWRl
cyBsZWdhY3kNCj4gKC91bm1vZGlmaWVkKSBndWVzdHMgcnVubmluZyBpbiBhIFRELiBUaGF0J3Mg
YSByZWFzb25hYmxlIGRlZmluaXRpb24uDQoNCkkgZG9uJ3QgdW5kZXJzdGFuZCBiKS4gIEZpcnN0
bHksIGEgZ3Vlc3Qgd2l0aCBYODZfRkVBVFVSRV9URFhfR1VFU1QgY2FuIGp1c3QgYmUNCmEgVERY
IGd1ZXN0LiAgSG93IGNhbiB3ZSBkaXN0aW5ndWlzaCBhIG5vcm1hbCBURFggZ3Vlc3QgdnMgYW4g
ZW5saWdodGVuZWQgZ3Vlc3QNCmluc2lkZSBURFggaHlwZXJ2aXNvci9wYXJhdmlzb3IgKEwyKT8N
Cg0KRnJvbSB1c2Vyc3BhY2UgQUJJJ3MgcG9pbnQgb2YgdmlldywgYSAiVERYIGd1ZXN0IiBmbGFn
IGluIC9wcm9jL2NwdWluZm8ganVzdA0KbWVhbnMgaXQgaXMgYSBURFggZ3Vlc3QsIG5vdGhpbmcg
bW9yZS4NCg0KTWF5YmUgaW4geW91ciBjYXNlLCB0aGUgdXNlcnNwYWNlIG9ubHkgY2FyZXMgYWJv
dXQgTDIsIGJ1dCB3aGF0IGlmIGluIG90aGVyDQpjYXNlcyB1c2Vyc3BhY2Ugd2FudHMgdG8gZG8g
ZGlmZmVyZW50IHRoaW5ncyBmb3IgdGhlIGFib3ZlIHR3byBjYXNlcz8NCg0KVGhlIHBvaW50IGlz
LCBmcm9tIHVzZXJzcGFjZSBBQkkncyB2aWV3LCBJIHRoaW5rIGVhY2ggaW5kaXZpZHVhbCBmZWF0
dXJlIHRoZQ0Ka2VybmVsIHByb3ZpZGVzIHNob3VsZCBoYXZlIGl0cyBvd24gQUJJIChpZiB1c2Vy
c3BhY2UgbmVlZHMgdGhhdCkuDQoNCllvdXIgY2FzZSBpcyBtb3JlIGxpa2UgYSBub3JtYWwgTDIg
Vk0gcnVubmluZyBpbnNpZGUgVERYIEwxIGh5cGVydmlzb3IvcGFyYXZpc29yDQorIHNvbWUgTDEg
aHlwZXJ2aXNvci9wYXJhdmlzb3Igc3BlY2lmaWMgZW5saWdodGVubWVudHMuICBUaGVyZWZvcmUg
SU1ITyBpdCdzDQptb3JlIHJlYXNvbmFibGUgdG8gaW50cm9kdWNlIHNvbWUgTDEgaHlwZXJ2aXNv
ci9wYXJhdmlzb3Igc3BlY2lmaWMgZW50cmllcyBhcw0KdXNlcnNwYWNlIEFCSS4NCg0KRm9yIGV4
YW1wbGUsIGNhbiB3ZSBoYXZlIHNvbWV0aGluZyBiZWxvdyBpbiAvc3lzZnMgKGFnYWluLCBqdXN0
IGV4YW1wbGUpPw0KDQoJIyBjYXQgL3N5cy9rZXJuZWwvY29jby9oeXBlcnYvaXNvbGF0aW9uX3R5
cGUNCgkjIHRkeA0KCSMgY2F0IC9zeXMva2VybmVsL2NvY28vaHlwZXJ2L3BhcmF2aXNvcg0KCSMg
dHJ1ZQ0KDQpUaGVuIHlvdXIgdXNlcnNwYWNlIGNhbiBjZXJ0YWlubHkgZG8gdGhlIGRlc2lyZWQg
dGhpbmdzIGlmIGl0IG9ic2VydmVzIGFib3ZlLg0KDQpJIGFtIG5vdCBmYW1pbGlhciB3aXRoIHRo
ZSBTRVYvU0VWLUVTL1NFVi1TTlAgZ3Vlc3QsIGUuZy4sIGhvdyB0aGV5IGV4cG9zZSBmbGFnDQpp
biAvcHJvYy9jcHVpbmZvIG9yIHdoZXRoZXIgdGhlcmUncyBhbnkgb3RoZXIgL3N5c2ZzIGVudHJp
ZXMsIGJ1dCB0aGUgYWJvdmUNCnNob3VsZCBjb3ZlciBTRVYqIHRvbyBJIGd1ZXNzIChlLmcuLCB0
aGUgaXNvbGF0aW9uX3R5cGUgY2FuIGp1c3QgcmV0dXJuICJzZXYtDQpzbnAiKS4NCg0KPiANCj4g
Rm9yIGtlcm5lbCBvbmx5IGNoZWNrcyB3ZSBjYW4gcmVseSBvbiBwbGF0Zm9ybS1zcGVjaWZpYyBD
Q19BVFRSUyBjaGVja2VkIHRocm91Z2gNCj4gaW50ZWxfY2NfcGxhdGZvcm1faGFzLg0KDQpJTUhP
IENDX0FUVFJfVERYX01PRFVMRV9DQUxMUyBhY3R1YWxseSBkb2Vzbid0IG1ha2UgYSBsb3Qgc2Vu
c2UsIGJlY2F1c2UgIlREWA0KbW9kdWxlIGNhbGwiIG9idmlvdXNseSBpcyBURFggc3BlY2lmaWMu
ICBJdCBkb2Vzbid0IG1ha2UgYSBsb3Qgc2Vuc2UgdG8gYWJ1c2UNCmFkZGluZyB2ZW5kb3Igc3Bl
Y2lmaWMgQ0MgYXR0cmlidXRlcyB1bmxlc3MgdGhlcmUncyBubyBiZXR0ZXIgd2F5LiDCoA0KDQpC
dXQgdGhpcyBpcyBqdXN0IG15IG9waW5pb24gdGhhdCBDQyBhdHRyaWJ1dGVzIHNob3VsZCBiZSBz
b21ldGhpbmcgZ2VuZXJpYyBpZg0KcG9zc2libGUuDQoNCj4gDQo+IEBCb3Jpc2xhdjogZG9lcyB0
aGF0IHNvdW5kIHJlYXNvbmFibGUgdG8geW91Pw0KPiBAS2FpLCBAS2lyaWxsLCBARWxlbmE6IGNh
biBJIGdldCB5b3UgdG8gYWdyZWUgd2l0aCB0aGlzIGNvbXByb21pc2UsIGZvciB1c2Vyc3BhY2Un
IHNha2U/DQo+IA0KDQpBcyBzYWlkIGFib3ZlLCBJIHRvdGFsbHkgYWdyZWUgaWRlYWxseSB0aGUg
a2VybmVsIHNob3VsZCBwcm92aWRlIHNvbWUgdW5pZmllZA0Kd2F5IHRvIGFsbG93IHVzZXJzcGFj
ZSBxdWVyeSB3aGV0aGVyIGl0J3MgYSBjb25maWRlbnRpYWwgVk0gb3Igbm90LiDCoA0KDQpTdXJl
IC9wcm9jL2NwdWluZm8gY2FuIGNlcnRhaW5seSBiZSBvbmUgb2YgdGhlIEFCSSwgYnV0IG15IGNv
bmNlcm4gaXMgc29tZWhvdyBJDQpmZWVsIHlvdSBqdXN0IHdhbnQgdG8gdXNlIGl0IGZvciB5b3Vy
IGNvbnZlbmllbmNlIGF0IHRoZSBjb3N0IG9mIGFkZGluZw0Kc29tZXRoaW5nIGFyZ3VhYmxlIHRv
IGl0LCBhbmQgd2hhdCdzIHdvcnNlLCB0aGVuIG5lZWRpbmcgdG8gaGFjayB0aGUga2VybmVsIHRv
DQp3b3JrYXJvdW5kIHRoZSBwcm9ibGVtcyB0aGF0IGNhbiBiZSBhdm9pZGVkIGF0IHRoZSBmaXJz
dCBwbGFjZS4NCg0KDQoNCg0K

