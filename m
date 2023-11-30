Return-Path: <linux-hyperv+bounces-1155-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 800E87FE982
	for <lists+linux-hyperv@lfdr.de>; Thu, 30 Nov 2023 08:08:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36AB3282056
	for <lists+linux-hyperv@lfdr.de>; Thu, 30 Nov 2023 07:08:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83E81171CD;
	Thu, 30 Nov 2023 07:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bEWZ/9ri"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBCBD1A6;
	Wed, 29 Nov 2023 23:08:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701328086; x=1732864086;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=o1enX59d2AWlwlOAROjj2y6A2sof298XE0btxKV5gF8=;
  b=bEWZ/9riLhCT8YgL7rUaJC5EXvT3zilInXHUr75lfFlhsi+YhKyJB+li
   GlZ4O5wz5tPKUnGNCc3ZsSU8wFieEbFbC05u7JJKu+h6xz3EhbBTL19HK
   RBnOBGNpAHzPoH/2urqIH9nx9VuvqY9UNl3KfW1Z5RwtvXa+GoHM6wY3R
   3HcVk1bfN2NhmcDnVYtqydo+EN6Fc5u9hefSPc/gq4btOk/0maV+wzRCa
   IJDW7ZSWXKjB0JjgrSKcxLztzjQ8uy2pepYCWDABvPXgMIk/xVSpOo4Bj
   qEOuQ6jr1VQLXGUuw/S3TE+NHyZvDRvgxBVCm2H/I2jz9xpt7nv4nNmPA
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10909"; a="178733"
X-IronPort-AV: E=Sophos;i="6.04,237,1695711600"; 
   d="scan'208";a="178733"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2023 23:08:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10909"; a="772958815"
X-IronPort-AV: E=Sophos;i="6.04,237,1695711600"; 
   d="scan'208";a="772958815"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 Nov 2023 23:08:05 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 29 Nov 2023 23:08:04 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Wed, 29 Nov 2023 23:08:04 -0800
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.41) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Wed, 29 Nov 2023 23:08:04 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OZ15FoAfksk8IiMEKN6GmxeYSpZ0+j/2YfgBddFvwcEyEu83FkfJp1m1v7meSsuJfdm2mBZpQKlpH0I2EtfrwLmMFL55SfKcwGXeRoagCexJbglnxQiUxH4/XJWQxcUCvwMdCbfPeP33iNQF4V2b9n696xzQ4kYQtQAmkdigUUEUs0hWAcyDbXtR900Dyr5J6J3JqsDfIZhDCBXRlH0dHxG3Kt1K0Q8SXBEDHlz8jlHW6nO3dhHQs06ulOQIA7W16pI/Se40KOULevdrSR4AY+1v5PEIBL+9KKE/ZpHdymNgV1jybBvQqkvbpBDi+5yfpB2FboK/jhmC9KTNPYQ9pA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o1enX59d2AWlwlOAROjj2y6A2sof298XE0btxKV5gF8=;
 b=n28r5E59EnSRtAvdQNiQgCGIWEYzQX9fKH6CqR+HPnxQ3yk9j3YRjSZscK66RmUpCVh7Z2AhAllEsMhllPuraYKXQ3WfAQfOlGwqo86goa0Qj1SSEuUJgIAEPiaPKWf6ALx/XnK2yNHIAV5pRWI+GuqivYbo+m0rwNh9cZ+RlzZML5KIibCejGscwwEA2ggN/PtMMu4UjT/cYP3PpIsqg1iwVR+Su+0K1V5YuIK3sPg3Ntt1Hl6nGvNWizkTep97Bdpq1DSnW1bDwtsJ3eNBL4eXG8Nltvx/G4eLxTgAPZo98e9MlsFKk7Q6LVoIZueCuDOF6Zqhorqn9kBNBAvmhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM8PR11MB5750.namprd11.prod.outlook.com (2603:10b6:8:11::17) by
 MW4PR11MB6763.namprd11.prod.outlook.com (2603:10b6:303:20b::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7046.24; Thu, 30 Nov 2023 07:08:02 +0000
Received: from DM8PR11MB5750.namprd11.prod.outlook.com
 ([fe80::f1b2:bfb1:b1b:66ed]) by DM8PR11MB5750.namprd11.prod.outlook.com
 ([fe80::f1b2:bfb1:b1b:66ed%3]) with mapi id 15.20.7046.024; Thu, 30 Nov 2023
 07:08:01 +0000
From: "Reshetova, Elena" <elena.reshetova@intel.com>
To: Borislav Petkov <bp@alien8.de>, Jeremi Piotrowski
	<jpiotrowski@linux.microsoft.com>
CC: "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"stefan.bader@canonical.com" <stefan.bader@canonical.com>,
	"tim.gardner@canonical.com" <tim.gardner@canonical.com>,
	"roxana.nicolescu@canonical.com" <roxana.nicolescu@canonical.com>,
	"cascardo@canonical.com" <cascardo@canonical.com>, "kys@microsoft.com"
	<kys@microsoft.com>, "haiyangz@microsoft.com" <haiyangz@microsoft.com>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>, "sashal@kernel.org"
	<sashal@kernel.org>, "stable@vger.kernel.org" <stable@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "H. Peter
 Anvin" <hpa@zytor.com>, Dave Hansen <dave.hansen@linux.intel.com>, "Ingo
 Molnar" <mingo@redhat.com>, "Kirill A. Shutemov"
	<kirill.shutemov@linux.intel.com>, Michael Kelley <mhkelley58@gmail.com>,
	Nikolay Borisov <nik.borisov@suse.com>, Peter Zijlstra
	<peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Tom Lendacky
	<thomas.lendacky@amd.com>, "x86@kernel.org" <x86@kernel.org>, "Cui, Dexuan"
	<decui@microsoft.com>
Subject: RE: [PATCH v1 1/3] x86/tdx: Check for TDX partitioning during early
 TDX init
Thread-Topic: [PATCH v1 1/3] x86/tdx: Check for TDX partitioning during early
 TDX init
Thread-Index: AQHaHWWtJXruLfiu906BueKp3+5D87CGlUMAgAr1j4CAAOyO0A==
Date: Thu, 30 Nov 2023 07:08:00 +0000
Message-ID: <DM8PR11MB575085570AF48AF4690986EDE782A@DM8PR11MB5750.namprd11.prod.outlook.com>
References: <20231122170106.270266-1-jpiotrowski@linux.microsoft.com>
 <0799b692-4b26-4e00-9cec-fdc4c929ea58@linux.microsoft.com>
 <20231129164049.GVZWdpkVlc8nUvl/jx@fat_crate.local>
In-Reply-To: <20231129164049.GVZWdpkVlc8nUvl/jx@fat_crate.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR11MB5750:EE_|MW4PR11MB6763:EE_
x-ms-office365-filtering-correlation-id: edd7f8e1-b131-48be-3b84-08dbf17316de
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8U7Q7fgCD586wXjLcu8CW5GCExZ76avG+W3XcN46udg6TQHumMmUlSGKbApbv2sW6KkoQBNE431n5TaNrgNwOx1NgiCwpD6KyRlyQuBMM6OhNZSyj1XZUbRViyhe1DOzylVZ5qW5KRr/PdbSTggWVtifD0dbTTqoEmZVu171jPBRF34nbGNt23GL/77hflDfg3uXXYuPI075gbRzWphwCW2g/6Fdki5ogMEFfKhixbqt3rL9cye+N5g9ZyxrvkASN8RUSj0AdvpeJO2YNl3CB2ae2FGGXCoeUmN0S05L0qbOO7Gr6y/JXkuy3lExxhe8swO98aBXDnxbMKbAiPXjkj+AApzOPQAdrGiLZ122Eummd5LpedYi97BjQSATXQmqk2C1C+9q3WhV8mXgd8DDFCY1A9TmTjyqIUUPavdaOdwSa1I1MIFMaoBx2QMUtFe7akm68Bed2Ne3JH9Y/750zOViiSj4ew2SHafMyYQzcLLE99sr+e8+BYau1OgoEtput+bq/5URvjIIzQrBXGtFWzfh+EwRQV0Rkm2knS/0gFF54eB/T9GUXUZ8VRK3ZNr9EDiQHM3JgCATwFP4rGA+eksBK1DZuT81/4F2b1ZsXCwvMKwVOq3216PB70nE4tGIt145gPXoWKNwSW9gBqCYH4duGbSO0W8/66Fr8G6rREg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5750.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(346002)(136003)(39860400002)(366004)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(55016003)(38070700009)(202311291699003)(76116006)(66946007)(66556008)(66476007)(66446008)(64756008)(54906003)(71200400001)(38100700002)(82960400001)(33656002)(86362001)(122000001)(26005)(6506007)(9686003)(7696005)(2906002)(110136005)(316002)(478600001)(5660300002)(8676002)(4326008)(41300700001)(7416002)(52536014)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bmhsWHEzRURWVDh1b1FWRUd1SitJRUd2ZUwvRHM1ckQrSHRnRXA0YmdtZGty?=
 =?utf-8?B?LzRuY3MzZUE2RzlsYys5VzBmOXJtaUVYbEk2b0RFU1JYSTNsS2c1YWFLTitY?=
 =?utf-8?B?NXJQdDhQazZGSXZzeUFnbkJGYzBHUS9CTTRvMTlHWlM3amZRNEo4MEQ5c3lN?=
 =?utf-8?B?TE1WVi8vNENaRVdKN3JXWXJXd0IzNEgwUFl3aGZFQ1BkRGs3UWErL1dPYk9D?=
 =?utf-8?B?VlZzL0RCV283WmNBMnpBUGhTMlp1TkxzSFlRall5UjVrK09LTjJFNnV5bE82?=
 =?utf-8?B?cjhlVXB0WG4wL0lIeDVLNmRCYjMrN2MvNDYxdVFXaWF2aVZEZzZwRXMyTlln?=
 =?utf-8?B?RUhPMHpLRHBvdzB5MUlGaUU3QVRSSGdqWnIzREJKamdXNzZocGprbzRML2Vh?=
 =?utf-8?B?Nnl0ZW5CVDdsblg4OFhXamE3cGNGbHhXMEdOV2FYTE5QWFFQb2Y4d0ZndWw3?=
 =?utf-8?B?N1JtR3YxazVvNC9EeG1CSzZDWmJyMEtZT1BXOXMrYytMQUkvZVE4L3FRZ3NG?=
 =?utf-8?B?MkN0ZmJmNUVwNkE2UGYzcjQ1ZEo1c0QxUFovbXNDbjl6S1c0N2FkUnB2eVM2?=
 =?utf-8?B?dnlOOEQzalZqUEJFaE5TUFpFajdiNUlCMTFObnl1SkkrQXQyRmQ1aGZvY08v?=
 =?utf-8?B?N2VScXJ1dHlyeTJMN2Q2UEVCRWdhVVJRMkpsT0dvMElMRGRUU3dpSXhDRGpk?=
 =?utf-8?B?U3NzQmFzaTdpMEVJL2JGaW5UNHA3SEczMnBRY1doYUg2Z01pbDlNdTJ0Yi9u?=
 =?utf-8?B?NFBPclhxSGRCQktQSklZWXNBTWVDMk1BQk9ERE56cHBFZVZTWSswSTRvUmFw?=
 =?utf-8?B?ZG4rNGFrR0NBRGVtTVU0WTFaT1V5TExiSFdUcE5jaFNpVUQ1em9JNjI1UjJR?=
 =?utf-8?B?K0xnQ1oxZzJKMGd0Sk9XVEpDQUJaWVpBL3FScGViWXVqSnYzQUYvVmZIWmNM?=
 =?utf-8?B?bzJUNlgyUUwwSDE5NlBaV1lwT2t1V1FBSURydU5PZWFTZmJnaXJ5MXdHQmN2?=
 =?utf-8?B?bTdlOHZ0cGVYWVA1bzRUcFNvdTR5MFVuOVRaV2dNbmtqRVZhOXV6WnZsS2lQ?=
 =?utf-8?B?SVNuVXNnazZZVmJJNmRBTHNrWkNvMEt6Y2JiSHRhZmtac1pDRll5SDhZY1dL?=
 =?utf-8?B?UG1vaVlDNFc5dzBmakVrYlc5TEN4M0hoVzhqTGJEaVVqTUtvdEhyMzFRM095?=
 =?utf-8?B?ODlhUDZKdmdoTU1DOWhCVG5EZUgwSHhBb3lCMlJnYXJ3WEZMZTgvZmdVcVRU?=
 =?utf-8?B?QlFPMDkrdWZLQ3FLVW5kZ09zYml0cHhKRXgxL1RhSWw3b1BTNFVrcmpaRU5H?=
 =?utf-8?B?dytCeWp5SWFnRGFVQ2NwYkJmTFBXYVlwTFN4ZEdGUWhybUx5dEU3OGc0NW1x?=
 =?utf-8?B?U0dITyt1cHAvSCtKRy9XRGtyb3oyQ29zais5dTkvYkdiL3J6d0ZLTzV6TjJ1?=
 =?utf-8?B?V0NOcXlCWGhsQk5PQ1ZxZWNKNkVlQm5zb1lNZnBURnVVbUZkbW5wb25aaFpG?=
 =?utf-8?B?SVRLblBrTzRZNUpzTE9RcEhsTDErb3FmUmpLWTB5SmRoVXN1ZXRmSGVLMVhS?=
 =?utf-8?B?bklEQng4L202RVB0bWx3R1dxd0RidXB0bG1RNFBtZHpJWVhEN3hLNEVYNnJt?=
 =?utf-8?B?RUNadVo5ME1DTEc2MU9tNVB2OHg2eDZPRzMrZ29nM3dpVDV5STVyMGd3SGdt?=
 =?utf-8?B?WHZEKzREVTJUMXJpcVI3QXBqZW9pU1EraHNVRi9UclFHbURpZG9odEdmZXRG?=
 =?utf-8?B?ZktoUThvRjdQd1hIS0NGbXpPSEI2VjRQSjFmNTg4VkRIK2gwc3BMWEw1Nllr?=
 =?utf-8?B?enRkLy9zTUtpSENWdlB5YVl0YUtreUxZOXcrdys2MUlZS2lhWnROenFGbHBW?=
 =?utf-8?B?c1d0bU03Z0RzZU5JWUhIRldzVENIYjVRR2Rac3pMbEFzTHFSSmVxdWNiTHNO?=
 =?utf-8?B?ZTZKK0lhOHBxVis2cXBHbW1zMnZjMnlGdEgrTVhJZDFGSUdPUGdDbUkremF4?=
 =?utf-8?B?YVFSK2xlSEViNDNvTDk5VEhieFBUeDJjSVVYV3REK1RWcVZWS0cvcWxSaWd1?=
 =?utf-8?B?SWVlVDBCNy91UHByMWJBUTRHeDJscytUc0h3OHVxSFlNTDJwVEJrOUZvTEVv?=
 =?utf-8?Q?y8vxCr/jMfRk2ijFfo4nX8D7s?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: edd7f8e1-b131-48be-3b84-08dbf17316de
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Nov 2023 07:08:00.9821
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lvU4LZ2ubo+EXlTIyyWyPI16f9VEo2F5YsY3L/fxKEqZWx+X1Zy8gWPfNk8DRDRyHgUTrkeH6/6UjxyyFcyogCWqOV4ucqDdbZdmmeEHQa0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6763
X-OriginatorOrg: intel.com

DQo+IE9uIFdlZCwgTm92IDIyLCAyMDIzIGF0IDA2OjE5OjIwUE0gKzAxMDAsIEplcmVtaSBQaW90
cm93c2tpIHdyb3RlOg0KPiA+IFdoaWNoIGFwcHJvYWNoIGRvIHlvdSBwcmVmZXI/DQo+IA0KPiBJ
J20gdHJ5aW5nIHRvIGZpZ3VyZSBvdXQgZnJvbSB0aGUgd2hvbGUgdGhyZWFkLCB3aGF0IHRoaXMg
Z3Vlc3QgaXMuDQo+IA0KPiAqIEEgSHlwZXJWIHNlY29uZC1sZXZlbCBndWVzdA0KPiANCj4gKiBv
ZiB0eXBlIFREWA0KPiANCj4gKiBOZWVkcyB0byBkZWZlciBjY19tYXNrIGFuZCBwYWdlIHZpc2li
aWxpdHkgYmxhLi4uDQo+IA0KPiAqIG5lZWRzIHRvIGRpc2FibGUgVERYIG1vZHVsZSBjYWxscw0K
PiANCj4gKiBzdHViIG91dCB0ZHhfYWNjZXB0X21lbW9yeQ0KPiANCj4gQW55dGhpbmcgZWxzZT8N
Cj4gDQoNCkFjdHVhbGx5IEkgd2FudCB0byBjaGFsbGVuZ2UgdGhlIHdob2xlIG5vdGlvbiB0aGF0
IGEgVERYIHBhcnRpdGlvbmluZyBMMg0KZ3Vlc3QgaXMgYSBURFggZ3Vlc3QuIEJ5IHRoZSBkZWZp
bml0aW9uIG9mIHRoZSBURFggcGFydGl0aW9uaW5nIHNwZWMsIA0KTDIgZ3Vlc3QgY2FuIGJlIGFu
eXRoaW5nIGFuZCBMMSBWTU0gY2FuIGVtdWxhdGUgYW55IGVudmlyb25tZW50DQpmb3IgaXRzIEwy
IGd1ZXN0cywgaW5jbHVkaW5nIHJ1bm5pbmcgYSBmdWxseSB1bm1vZGlmaWVkIFREWCAxLjAgZ3Vl
c3QNCihhbmQgdmlydHVhbGl6aW5nIFRERyBjYWxscyBmb3IgaXQgYW5kIHdoYXRldmVyIGVsc2Ug
aXMgbmVlZGVkKS4NClNvIHdlIGFyZSByZWFsbHkgdGFsa2luZyBhYm91dCBhIGJpZyBzcGVjdHJ1
bSBvZiBwb3NzaWJsZSBMMiBndWVzdHM6DQoNCjEuIE5vcm1hbCBsZWdhY3kgZ3Vlc3Qgd2l0aG91
dCAqYW55KiBURFgga25vd2xlZGdlDQoyLiBOb3JtYWwgbGVnYWN5IGd1ZXN0IHdpdGggc29tZSBh
d2FyZW5lc3Mgb2YgVERYIHBhcnRpdGlvbmluZyAobm90ZSwgbm90IFREWCAxLjAgYXdhcmUhKSAN
CihiZWluZyBhYmxlIHRvIGRvIHRkdm1jYWxscyB0byBMMCwgYmVpbmcgYWJsZSB0byB1c2Ugc2hh
cmVkIG1lbW9yeSwgDQpiZWluZyBhYmxlIHRvIHVzZSB0ZHggcGFydGl0aW9uaW5nIHNwZWNpZmlj
IHBhcmF2aXJ0IGludGVyZmFjZSB0byBMMSBpZiBkZWZpbmVkLCBldGMpIA0KLi4uIA0KMy4gTm9y
bWFsIFREWCAxLjAgZ3Vlc3QgdGhhdCBpcyB1bmF3YXJlIHRoYXQgaXQgcnVucyBpbiBwYXJ0aXRp
b25lZCBlbnZpcm9ubWVudA0KNC4gYW5kIHNvIG9uDQoNCkkgZG9u4oCZdCBrbm93IGlmIEFNRCBh
cmNoaXRlY3R1cmUgd291bGQgc3VwcG9ydCBhbGwgdGhpcyBzcGVjdHJ1bSBvZiB0aGUgZ3Vlc3Rz
IHRocm91Z2guDQpJZiBpdCBkb2VzLCB0aGVuIHdlIGNhbiBkaXNjdXNzIHRoaXMgdmVuZG9yIGFn
bm9zdGljLCB3aGljaCBpcyBtdWNoIGJldHRlci4NCg0KR2l2ZW4gdGhhdCB0aGUgbWFueSBwb3Nz
aWJsZSBjb21iaW5hdGlvbnMgb2YgdGhlIEwyIGd1ZXN0cyAoYW5kIGFzIEthaSByaWdodGZ1bGx5
DQpwb2ludGVkIG91dCwgZWFjaCBvcHRpb24gd2lsbCBiZSBmdXJ0aGVyIGJyb2tlbiBkb3duIGJ5
IHdoYXQgZXhhY3RseSBpbnRlcmZhY2UgDQpMMSBWTU0gZGVjaWRlcyB0byBleHBvc2UgdG8gdGhl
IGd1ZXN0KSwgSSB0aGluayB3ZSBjYW5ub3QgaGFyZGNvZGUgYW55IGxvZ2ljDQphYm91dCB3aGF0
IHRoaXMgcGFydGl0aW9uZWQgZ3Vlc3QgaXMgaW4gdGhlIGd1ZXN0IGl0c2VsZi4gDQpJbnN0ZWFk
IHdlIHNob3VsZCBoYXZlIGEgZmxleGlibGUgd2F5IGZvciB0aGUgTDIgZ3Vlc3QgdG8gZGlzY292
ZXIgdGhlIHZpcnQgZW52aXJvbm1lbnQNCml0IHJ1bnMgaW4gKGFzIG1vZGVsbGVkIGJ5IEwxIFZN
TSkgYW5kIHRoZSBiYXNlbGluZSBzaG91bGQgbm90IHRvIGFzc3VtZQ0KaXQgaXMgYSBURFggb3Ig
U0VWIGd1ZXN0LCBidXQgYXNzdW1lIHRoaXMgaXMgc29tZSBzcGVjaWFsIHZpcnQgZ3Vlc3QgKG9y
IGxlZ2FjeSBndWVzdCwNCndoYXRldmVyIGFwcHJvYWNoIGlzIGNsZWFuZXIpIGFuZCBleHBvc2Ug
YWRkaXRpb25hbCBpbnRlcmZhY2VzIHRvIGl0LiANCg0KQmVzdCBSZWdhcmRzLA0KRWxlbmEuDQo=

