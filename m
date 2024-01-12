Return-Path: <linux-hyperv+bounces-1419-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F3FD082B893
	for <lists+linux-hyperv@lfdr.de>; Fri, 12 Jan 2024 01:26:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71C2C1F25A9D
	for <lists+linux-hyperv@lfdr.de>; Fri, 12 Jan 2024 00:26:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8707C62A;
	Fri, 12 Jan 2024 00:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MlI6MFwa"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C90B7361;
	Fri, 12 Jan 2024 00:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705019208; x=1736555208;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=wWtcH6WYFrDRK28hFLh7sYKiAuWJEne9YA5yB4CHw+o=;
  b=MlI6MFwacUmOu2K0uxhkxqp0wD1OiNcLeizxgUT5Gcvc7EDL+/3DCnJT
   qZy9GYOiirzXF6vAukcQcNU5nWOyoqy3Gj/0LoG0j/bnMqiadgrA13J+a
   JsNxkZaIBg0ygOg6jQ8q3Jihg6bS3e0xrAqjOIh3n4j9bnpevG+P1NBhW
   OKyoJF3+RucSnvemhJzc9numpTbewjIjPMl1vNQI+9zfW7ULlusXnRxO/
   SaFIiWPsx1yEbijkVnrHcwzG6PCaqXPZFEtWkyFi/S/3Jz8S02NQ81JgK
   FkyB31NQZ+3mg3uwWdH779ob/tVwk4mewE1Dfd4ovVHQ25nrk6H16x2eQ
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10950"; a="430218246"
X-IronPort-AV: E=Sophos;i="6.04,187,1695711600"; 
   d="scan'208";a="430218246"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2024 16:26:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10950"; a="775816514"
X-IronPort-AV: E=Sophos;i="6.04,187,1695711600"; 
   d="scan'208";a="775816514"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Jan 2024 16:26:46 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 11 Jan 2024 16:26:45 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 11 Jan 2024 16:26:45 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 11 Jan 2024 16:26:45 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kPOHE3+gVxeqPz0mumg+jfCglI0H+11I/NrIZPc3pONXb5rUqINBO0+jkCO/FIQK0ZzSdpbhecCD2hPd0Hx9BJeepOq3jhq7FH24D+2N/JhVeUoc31/UD9H2JggEa0tbpg1NvcAgZTDEb5XK+Zmv8+dtoJlBc0S9SL1kUANFySVqKOgIZypVNoKis6MP1UFY0nJh/32WW4yI4EY9wOuBeyMEb4kSOGbdGVI1PZ5rxWwm7CfABNIhf/6h+BZGapZ0ZaRX8HxVyHShDG5Fsvj+lGdkrX2KUI9NXjpelu7aI8XX5F68Pjdi1dHtk8LLf45RHDEIUFxH5IsWRFbR77Pw0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wWtcH6WYFrDRK28hFLh7sYKiAuWJEne9YA5yB4CHw+o=;
 b=AF3Ypx1mGR3sYDmYB1pftlopFOC9dfentN962CgZtnEohxCoNHo0X146JpgTCxUJe1UGMRbB5DOiyNsgowR/9K2EaxxjbJIYOI00gfoEYbgi6jx82IgKLVThBFAvOIDWCBj5r7o0WfKqT5Glu7vw5kZpb51zgJ2wPjMXp+AdNPnV9ZX8d8yfmDHRupI2vWA0OOyht1l7udIhhduDxT7QjuZ3KPiJRT5CkHp7/rKc+jIcj2n2CgouhkHTBPsStmFr59qrZqnMGQze3vnGSqVbeudZU4c6TuDSamRfEizC3S0alxXLa9v66V0vbdAvtXDA9AdC/hCV+fGbnnnalQkaLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by PH7PR11MB5765.namprd11.prod.outlook.com (2603:10b6:510:139::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.18; Fri, 12 Jan
 2024 00:26:42 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::6dc:cee5:b26b:7d93]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::6dc:cee5:b26b:7d93%4]) with mapi id 15.20.7181.018; Fri, 12 Jan 2024
 00:26:42 +0000
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
Subject: Re: [PATCH v3 3/3] x86/hyperv: Make encrypted/decrypted changes safe
 for load_unaligned_zeropad()
Thread-Topic: [PATCH v3 3/3] x86/hyperv: Make encrypted/decrypted changes safe
 for load_unaligned_zeropad()
Thread-Index: AQHaQAVUxqgHxuoJlkaDzPPbYPQuurDVW/yA
Date: Fri, 12 Jan 2024 00:26:42 +0000
Message-ID: <21f41af44fcc2ce52bdb40c7560fc7c9c0d56ec4.camel@intel.com>
References: <20240105183025.225972-1-mhklinux@outlook.com>
	 <20240105183025.225972-4-mhklinux@outlook.com>
In-Reply-To: <20240105183025.225972-4-mhklinux@outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|PH7PR11MB5765:EE_
x-ms-office365-filtering-correlation-id: 4b98b119-85d3-477a-2051-08dc1305267b
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 99i/dJD4hp8SFX13k8LmsIJPdarx4PqatwKdtxTzsYmPE5qHd2dF6RCfSboiLI1ZQWCG1jXqSNNN2x3DYdN9TXj6upIIMqT8X5dW3+z849NUCvKVZsQ8sJYPgKR23QFcClBpGGweAWmC5CNlxH1ve8AqhWDEWzBwevFhtsXgnAfVYxzH1xF5yB+8L1bFPSY7rWVfqtH2E8eeIRtdBwUv41rC7RIMSWibHwnOTsmYQaBZhQLWnrZBp24oumoUIOQr3ug8mPUxj6R/pJNHDeF2Ct21AP9vM+rBfUhXLdabxfAAmW3HqdTAoDZ133k7wCM5ijfkQfw6W7fDwQj/yGj0KQsv0vHhnHIfBPHqVF9qbemUDdBJqZ2ej+kaohx/pQ7db2hxfPI2OqDmK6kFjprUNcqDx8DjDr8KGFMQTSnfccNatTO0JX+BofIIvZnAsTJbzeujEiotMwhMVRji7Qu7+V1o1QOj61Y7nmwF5J84V9oInSE33AHVpqNkkLEyDRk0s5EIUxpUchuTTsZJVCnhkfsiWHchMkWa1jtVzUlX1ooyYaeVXBvasU67QdUQpjl90OzuvwhWysgmmQmeGssiRRoKTbJoVelCutlLYxXtAUGWqCW0m7izPDM4KUrU/d+XABe27qPQXlDS2D6f6H6ejQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(376002)(346002)(136003)(39860400002)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(6506007)(8676002)(5660300002)(7416002)(4744005)(2906002)(122000001)(38100700002)(8936002)(36756003)(41300700001)(82960400001)(86362001)(26005)(66946007)(6512007)(6486002)(66446008)(2616005)(478600001)(66476007)(316002)(64756008)(76116006)(91956017)(66556008)(110136005)(38070700009)(921011)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?czN3S3oyOXpnNSttbW5uYW5hNEIrUWNOVWRMMFZ1alNMdWg1STlxVnlNUDVF?=
 =?utf-8?B?QVpBQ1pRZWxVMWhveFBKV1FRbzA3TVhCbHB5eTVydVlxZEgxVVdkRmpacDNC?=
 =?utf-8?B?b0pUY3FoMFZVU25DRklxN2FsRVF2Mkg4WjByRGJkUmljSXZtMnJLMEdoMk1V?=
 =?utf-8?B?L0dPaFMvYnlxWGNuVXVOcEFtaXQzUmRQQlN6SGRycGJ2R0w0Y2hmZVQ5WDVz?=
 =?utf-8?B?SlVWaUozeElJU0xYVG40SHRsanRLa20zVEVJMngyNzJxZG11NHpMSXNGRDZM?=
 =?utf-8?B?T3ptSzIrTTZiZTByV1BuSGdRNk5MZm41N25MWVRMK0pmQ1JGOGI4a3AzU0xj?=
 =?utf-8?B?Ui9veGhlK1BYRzExY3NYOXlGdWNJcEx3QWdRRGpFY210akJWWmpVRUdVR3Nm?=
 =?utf-8?B?VWpkN0JMWitLcC9XYi9tcWFXZDBCWWxrUTNLNll5WWZwWmphYXZrS0dlK3F4?=
 =?utf-8?B?NlVXTzJWSTBTRGFteGR6R1FQRHFRbVZmK3ZWbm9uV0g3STludm1tc0tzUng0?=
 =?utf-8?B?S1dISHJzVE8yTU5VWlJZbTRsSXUvdG9yNG1yTEJlbm4wM09KaVhKUVBCLzRZ?=
 =?utf-8?B?SGoybWRnZU9mWTEwb2lxM0NUcW94dk9uMFJYVk9mWEJzeXc5Wjlvc2Mzalpx?=
 =?utf-8?B?VW9tdFlnd3d1WlQxWFpvVUg2ekNkVDJxczRQNi9NTUR2ZHJaVDVOMFFTU2Za?=
 =?utf-8?B?b2hXUGxVWFZvb2IvbFZnanp0WlQ1d0I4WlhLdGc0VTdsaGFXWWIxRWxIekRP?=
 =?utf-8?B?ZmtlRlhyN3RER2xiZVNYZzBOOTA3dVg0RFcxenhNRmVxN3l4dWVTeWttZnVz?=
 =?utf-8?B?RTRTMG9FMkFIZGJUWFQ4UnFxL3dDYkh6Rmw0MUpZUVByeEFqREhMbXFPNFBi?=
 =?utf-8?B?LzVvczZnd2RaTHB2eEZBNkNYWUt5NVJQNFQxaU1nb0IzZWh5dUwwaGlRcWFB?=
 =?utf-8?B?bE1VL2tiNXhlaEFRMUlWdDk4TGpqT2tEVmVrUXpReng0Q1dDZktQQk9tdTU2?=
 =?utf-8?B?bW1yV2VhRmh5Y0E2U1JzYWRvUHhGMTNTeThoVGdZNFE3dFJQMUVVRXp0TE45?=
 =?utf-8?B?MWpjTW5hNlcrTnY5SUxvNHFNNTVmMjdsQUZWMW1pbnE0QTRDOVNuNlhZYVlS?=
 =?utf-8?B?NFEvSEdpRy9NZlE1cnJoT2pBQVVKL2lHWEJSM2M4blFsMit2VjlHa1pab2I1?=
 =?utf-8?B?ZDRTTFdJb3AvOURhaTZ1VnNacTNSa0VyVXZhNUdnTEhjVm04VDQ5Z1diYnl4?=
 =?utf-8?B?NStWS2h5YUUrb3VialB2QjdjMzR3MS9jbitrVGU5d2NweVZrZW1qeUZaMkFx?=
 =?utf-8?B?UnptdElkT0hVVDRvMWlaMEFRTWVSNm8xeko5VDdodTRMY3BhbituOFYzdEJp?=
 =?utf-8?B?cE9HWWk2VElaY0JXWEpNV1NKZ2sraHl1TThxZXpGQkxUT3RZcXczMGNFVEdG?=
 =?utf-8?B?R21pK29RaWhJa1NZYzZFNjdQQW5YOGwzTXk3L2R0VXNnM0w1ekNpaE5yNjNJ?=
 =?utf-8?B?ZnpFVjBOVTNvSmk1WkZFNnZsWEhaQ2lzME92YzdoRitBOGJhWnBiWng2V2dr?=
 =?utf-8?B?NnFLS25TdTZLdEx3S2ZvdjhzbWZZN3pSZm5ocnBJWlUwZE40cEpnSXNZSDdP?=
 =?utf-8?B?TG9QTDFhWllGbkpWZjc2WWNOSklsVGpuM1R5eEJSSnlkbGFFNEs5L2F1Nkdl?=
 =?utf-8?B?WTBEV0x1aFIyRURJWHAyRmdzd21GOEc5NWFsU0Y5Nmx2Y01YY1BGd0tKWjRr?=
 =?utf-8?B?WERubzJFSitCYWdZY2h4ZmIyZHN4R1lHa0ZHTGNMVHhKNFZ1MUtpUzlrTEE3?=
 =?utf-8?B?b0VQR0VUajBVeWNQdFBwOTBhTHBvZTJqRnNuQ3hBc3RMODg4UHRCSExaVG5S?=
 =?utf-8?B?ZXFuY0VXZEJLTHJ3c3BkdmRpV2pOcXVCOEExb2NteTAxc3dpdnZrcS9sVENy?=
 =?utf-8?B?bTcyT2JBd1EzeFl2ZWlITWhNOG90Q09uc3NMYmpBQlZNa1NmUXBCM1E5OGp1?=
 =?utf-8?B?T2IvS3BoTHNMMWtsWEdGOFI3blJyOXpsTDBDczh3R0NOcmZQc29zUjlld2sr?=
 =?utf-8?B?YWd1WnBUNDNWY1R3VHBLbU40SjI0a0UvY1NpUjZ1cUR3QXYwQTdPNWcydlFz?=
 =?utf-8?B?THhhQk44cW94cFNqc2ZwNEJuenBXbk1maFlPc2ZRQ2M4NVovMUZNRllDRWV0?=
 =?utf-8?B?Y1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3F43C51E914DCD48B6989FBA1094B814@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b98b119-85d3-477a-2051-08dc1305267b
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jan 2024 00:26:42.0960
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8xSBKdTGT5VIOr4yBY8xhpP7CZFw8HtcfRAFZ+L8g9x+5N/Bv2IHjilQiEeOk22sB/4uGYf3ygTLgRtmdAZzhe3CK5WoxHiB9q8poaeF82Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5765
X-OriginatorOrg: intel.com

T24gRnJpLCAyMDI0LTAxLTA1IGF0IDEwOjMwIC0wODAwLCBtaGtlbGxleTU4QGdtYWlsLmNvbSB3
cm90ZToNCj4gwqAgKiBodl92dG9tX3NldF9ob3N0X3Zpc2liaWxpdHkgLSBTZXQgc3BlY2lmaWVk
IG1lbW9yeSB2aXNpYmxlIHRvDQo+IGhvc3QuDQo+IMKgICoNCj4gQEAgLTUyMSw3ICs1NDcsNyBA
QCBzdGF0aWMgYm9vbCBodl92dG9tX3NldF9ob3N0X3Zpc2liaWxpdHkodW5zaWduZWQNCj4gbG9u
ZyBrYnVmZmVyLCBpbnQgcGFnZWNvdW50LCBibw0KPiDCoA0KPiDCoMKgwqDCoMKgwqDCoMKgcGZu
X2FycmF5ID0ga21hbGxvYyhIVl9IWVBfUEFHRV9TSVpFLCBHRlBfS0VSTkVMKTsNCj4gwqDCoMKg
wqDCoMKgwqDCoGlmICghcGZuX2FycmF5KQ0KPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgcmV0dXJuIGZhbHNlOw0KPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgZ290byBl
cnJfc2V0X21lbW9yeV9wOw0KPiDCoA0KDQpJZiBrbWFsbG9jKCkgZmFpbHMgaGVyZSwgYW5kIHNl
dF9tZW1vcnlfcCgpIHN1Y2NlZWRzIGJlbG93LCB0aGVuDQpodl92dG9tX3NldF9ob3N0X3Zpc2li
aWxpdHkoKSByZXR1cm5zIHRydWUsIGJ1dCBza2lwcyBhbGwgdGhlDQpodl9tYXJrX2dwYV92aXNp
YmlsaXR5KCkgd29yay4gU2hvdWxkbid0IGl0IHJldHVybiBmYWxzZT8NCg==

