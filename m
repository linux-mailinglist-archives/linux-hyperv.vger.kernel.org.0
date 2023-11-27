Return-Path: <linux-hyperv+bounces-1070-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60D377FACA3
	for <lists+linux-hyperv@lfdr.de>; Mon, 27 Nov 2023 22:39:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 922891C20C6E
	for <lists+linux-hyperv@lfdr.de>; Mon, 27 Nov 2023 21:39:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8E8A3EA90;
	Mon, 27 Nov 2023 21:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ANT2YeXO"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 918A0C1;
	Mon, 27 Nov 2023 13:39:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701121155; x=1732657155;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=9MlOmnJ8k6w9JhmAtXosQNcmlln7Dmj8e6I7afUU+9o=;
  b=ANT2YeXOFigbyIEABNWthcu/J6mE7Qhk+0brUEg0IF5ipCvpGL1c/nyB
   O2j4n+9+QlJIMgHfeK9bhu1JdhbAYt92McVnoJagrTOXkuiDpLvnDPn22
   mE0JXq4RpBfGnKegHqYUXsMnijRdhiaauw9aNMGdRqhEnQH8nlb+ALQAd
   oSqouTYC6RmUnkUnJxy7JRAyG5d/FlLMaZE2y0lDc0ZMo9hj99p/hO23d
   1E1h3p9hkgkgdIPYyMnobJPNRO+wyYkeMz6mHAe53FQWuI7X5QxbhQ54H
   5PMrwZjA9gRZf4dmxHwacBtIcFwZZqRYww+5dHIeKK4hLjq2dmk58RbTr
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10907"; a="383178280"
X-IronPort-AV: E=Sophos;i="6.04,232,1695711600"; 
   d="scan'208";a="383178280"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2023 13:39:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10907"; a="834449687"
X-IronPort-AV: E=Sophos;i="6.04,232,1695711600"; 
   d="scan'208";a="834449687"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Nov 2023 13:39:13 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 27 Nov 2023 13:39:14 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Mon, 27 Nov 2023 13:39:14 -0800
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Mon, 27 Nov 2023 13:39:10 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NeTaW5o44gQMXApeUTCTFgXfkvn46lHxa3ih4aPAUBjXzpwqwnsCnUl8kS7CNQXA6y3X2RlA66K1gQrQ8yl4sZfXbhKv8bKCGDrmu6AQLlmTouu59mKTtoPfoDjTL/8CPzYriap15cZFDDKgvtCF4OqGHyzDpzfA6lpluz7QqFEVquVZ5w2+JV7Pdp6rCuBwvvK0ZXV25/hsnf/j1Ocn4N8P4HysTHdxpmZTr0DDJ8JQwKzVzHo+5k+pTg/Y4/OUcIDM7QNirZjetqWfZV8iZuoO3jdqrHf2LgwznNXg+CW1RDDcRpk2IEK3z9rK5NFEqKiJETjBEMGjFj7RGayUkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9MlOmnJ8k6w9JhmAtXosQNcmlln7Dmj8e6I7afUU+9o=;
 b=UGPBaf5mgPVyGXhy6LSApeZPknC52WSkoyXXyYoWWHTWEAzXkiOKLTeqmfrM7UxsXpMdvyNOC5FzvfEOlwxgkdwSU/xwvvZv13t4lPc4BRpTCnJV+zJwL7LEX0oa8O0lRvzpGkvLjAzqmwj2DysyfBdPvGyk4+aIQc3UE93/8MoDYFZuCuHBFvpnYy/cyrU1D8ZATbF2ey6M+ZxT8pgSPvILKfOZXjpZXuYAE0q/4N+9GYDG5TeTsphPjCVKyFIH1Sf21HMoEUspy+dnh6u160g3QZ0DuBtfJuVrJsdwWA4+I7Mx81uZMeiEEWnWXIWeD701Qaf4p3TrNUhYvldHkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by CY8PR11MB6889.namprd11.prod.outlook.com (2603:10b6:930:5e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.27; Mon, 27 Nov
 2023 21:38:58 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::5260:13db:a6e:35e9]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::5260:13db:a6e:35e9%6]) with mapi id 15.20.7025.022; Mon, 27 Nov 2023
 21:38:58 +0000
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
	<linux-kernel@vger.kernel.org>, "kys@microsoft.com" <kys@microsoft.com>,
	"Cui, Dexuan" <decui@microsoft.com>, "linux-mm@kvack.org"
	<linux-mm@kvack.org>, "tglx@linutronix.de" <tglx@linutronix.de>,
	"urezki@gmail.com" <urezki@gmail.com>, "hpa@zytor.com" <hpa@zytor.com>,
	"peterz@infradead.org" <peterz@infradead.org>, "wei.liu@kernel.org"
	<wei.liu@kernel.org>, "bp@alien8.de" <bp@alien8.de>, "Rodel, Jorg"
	<jroedel@suse.de>, "sathyanarayanan.kuppuswamy@linux.intel.com"
	<sathyanarayanan.kuppuswamy@linux.intel.com>, "lstoakes@gmail.com"
	<lstoakes@gmail.com>, "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH v2 4/8] x86/sev: Enable PVALIDATE for PFNs without a valid
 virtual address
Thread-Topic: [PATCH v2 4/8] x86/sev: Enable PVALIDATE for PFNs without a
 valid virtual address
Thread-Index: AQHaHMCWxDaQ2OOq0UaKl0u/qG7/4LCOur0A
Date: Mon, 27 Nov 2023 21:38:57 +0000
Message-ID: <3ddcad72637dece4bd3ecb7c49b8ad0e5bd233c0.camel@intel.com>
References: <20231121212016.1154303-1-mhklinux@outlook.com>
	 <20231121212016.1154303-5-mhklinux@outlook.com>
In-Reply-To: <20231121212016.1154303-5-mhklinux@outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|CY8PR11MB6889:EE_
x-ms-office365-filtering-correlation-id: b19fb055-cfce-41c5-66a9-08dbef9142ea
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FDLX/gTBCx6ovsqvPDnePNIfau7aEovwWOMPsXKlLtSOdw2WRd+7uAFxDRPOOD41OBsXGWvs5lJHnCdfcsCtgfJyN4lYmAFdBIZvOWOhWD6vJMxVEqGp5SXK6zfnH+PugocJ6d1cfc1NJpSwnekaHEfQAt7ih2KEKPB4T5Lx5Z8v6lg2tXdHtyDlNrqxYC1g33DwI8aEkxTaMvuZrYI06G59dzKWcMM7A58VM3g4a2jTOGiWYUlft/7GSXwEq6VOFZwyEeSN8a2Y4e1i9bQ2Y/c9C6C3GI4ieGdE6BdqQ9PNCHygoLJAu6QvDPAiu8NHzG0zSFhc20aCzlkO/NvV+fW3bC/NyrPOs91W0iUqD45342OZXiQAhp5ehvI1epeuGq0rTS4XIl5zJ7Bx3NGFI6e9l7VFenEI431oHZLEunSc3zTHWa+Zl3L3yTjApVnCBHGUWkgZ4nv6CtSxA1Ox7qWHXTVoxBPmnVD8cEn7h/neSS8E+HSsKU1gSvVp7Xzq+cum4b2qnJnT8wr+D/3ioOqswOxkaOx1wertpipB5EXVtzTbH3nBi0s61H3DaEhpQCl2CZEwutLNrEu5aekm/0cR7Gm02DOf2XS+mlTMUCFe6kXJy0y7jw5n4WNSDvSV00TGWx1B7TX8UpukGxRI4Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(39860400002)(346002)(376002)(366004)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(5660300002)(4744005)(38070700009)(7416002)(4001150100001)(2906002)(8676002)(41300700001)(8936002)(6486002)(76116006)(91956017)(110136005)(64756008)(66476007)(316002)(66556008)(66446008)(36756003)(86362001)(66946007)(38100700002)(26005)(478600001)(6506007)(6512007)(2616005)(71200400001)(921008)(83380400001)(122000001)(82960400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cU1weEEvMXJKOFBtL0NqUkhoNGVjVkU2bUppVFhnWjNTS09qbjJhYWs1Q2dq?=
 =?utf-8?B?ZFI1dE1YWCsrc1o5dEZFdkxJdnFJTmZBSEdjbThUQ09RRmZaVlBXU3NSbGpL?=
 =?utf-8?B?MFVUMnFySG9KSHIzTTRhbVptTEtRc3NJWENBSG5tRUlyNFJKS2tIejdFMjJ3?=
 =?utf-8?B?c2FSQmN0b2JKd1JpcGlSS1dnWWJ5QWhxRXhmMmRjMkxyRFVueWxjRlJrVnhh?=
 =?utf-8?B?alBzRWsvZVpnQ0NmSnhiOTB6WkcrNC9RRm81akZmckhMOHIvZCtGUkp5ajNl?=
 =?utf-8?B?QkUwTmM3bkJiWjdud1o4WkZucE5zYlJ1eXdRWU5GVHd4MFRjdFBzc3dod0l2?=
 =?utf-8?B?ZDBBd05zTlBPdG5PaUs5YTc3cW82NjRuZENPdWx1QVl1ZUxrcER4N1lSMzkv?=
 =?utf-8?B?VWZtUS9lWEViMS8rWDNFc1E2dVhMUkNhbXltYjBCamRDRGZWY0ZYdTFoV1NK?=
 =?utf-8?B?dTJWd2VTNGtYK0JSWUR0QVB4blNCb3A3anNWc3FjVEZNelFhbFZJbDVOb0pY?=
 =?utf-8?B?YWc4KzJLYmJpelMvb2pNaUoxTDFCYnJlOFpweE1NVDJEWU1GWEVaVHNkeVpQ?=
 =?utf-8?B?Q0E5bHRRa1dxK3dDeDc5Y1FFck9mTGxGZzJOdHFyUVUxcDY1OTVndGhFQUx6?=
 =?utf-8?B?Z0s0TnlOKzl3ZnJ4dE5oUzVLOG5vQ0ZtUEU4a3hUZHlJVnlySFhFclNvUVRM?=
 =?utf-8?B?U3FKbmNHTXB2OVBXWTZ6MjBldEs4TzRDVkE1Y1dyaFU0RWNVTlJndk9KaURm?=
 =?utf-8?B?M2Voa3AyY3paN0JRaGZFanhIcmxNR2l2aWNQRkVRLzNYM3VXNnZtVHdobmM3?=
 =?utf-8?B?K3YwaTJnbXliYTcvK0FTV0xQY093NVlsYUU3STBpZlg5SnR5eVJPdkF4UjNY?=
 =?utf-8?B?OW1ZajJaRjN4azNYWUg3L01FMURqaTUzRVAyNDAvUUFRRXFDVWYrOW9lbkZF?=
 =?utf-8?B?bjlKeTF1THpBTW40VHpHalZYOUVtdFVQSEdGZkNiT3ZrZkZiRFRLUCtraitk?=
 =?utf-8?B?eVRvTUhCUitvZEd0ZTJpbWdlalhoYVNGazJsNCtKVUdZa1c1dndHWHcxWWJw?=
 =?utf-8?B?M0hLbWJqVi9xT0lVY01YUGFSdE81UU1LdVRMYm5kY281NVJMSmRQY29GeWVZ?=
 =?utf-8?B?L2YwOEtGR3hxbkZrT1FqZTFzcWFLZFZpYWRhUW9MSFN1ZDd0ZDRudHB6UlMz?=
 =?utf-8?B?WHJLelZiMHN1aGZCU0tEK2FUdEM3amFxRWRGUGRoNUpFQWFjSGFlSFRaRE1Q?=
 =?utf-8?B?azg5SUlDa3VUMlZ0Z3kwUERVQTcwZkg0SSszYzN3L2V6TEluTTcyOFg5UkVT?=
 =?utf-8?B?a3AyOXYraVU4YUZYbUhaaDZmdEtCOGUrbWIvcFY2N3BDUG54dm1QQWVjVkRE?=
 =?utf-8?B?RDkzSnlDZW5Vb1VoSHZtWFZrdTRXOUNtUXdOOFBkdXIrR0tlT3VJdyswdFhx?=
 =?utf-8?B?VzdEbTU3eEZtL1RNbDdmOTJEUmFMSGJZb2o4UkxtdEZmbVZJbTVLbHhTY0xB?=
 =?utf-8?B?WEVPNG11cDFCaW1pa0dadFVJZERsVlcrNVQvb0hhZy9PcTYreE1pamZSdXpF?=
 =?utf-8?B?cVo2dGNsYkRiUnltVUhwYkl1a08wQm5DZm52NFNURDFwU0cybXpLc043a3JU?=
 =?utf-8?B?dEhrbmlnMzJNMnFuRW1qTmUycEJaUUlmd1RwMzdtSGJwcU9sb1JVbTdxb2Y0?=
 =?utf-8?B?VWJQNENwWkVPT2RmSjAybk1OK3BzbDlvaXRGTG13Y3p5VnN2Wk9YTGdqKzlU?=
 =?utf-8?B?NW9id2JndEozUUdaZmNpeVdwb29QdG1oMTErcWVmRXpUSE1xNm53N2t4ZTND?=
 =?utf-8?B?RTU5a2hyUnZUQzM1aDB5UDZDVFJDRHJBcDM3NlV1MnFFRjkwcWozLzk0Z1RW?=
 =?utf-8?B?WHQza1JWLzluZStneUFwQWo2a1R1MDFReWFORzJvQ3duU3g2REJ0cmxsQ2NP?=
 =?utf-8?B?Zi9OekIyK3IyWUxWdlJpVUxCcHd6OFdIaTRocnZuMTdBUmZIRjZmdFVZZTMv?=
 =?utf-8?B?QVorQlBmTUprSkJKaUIwd3piZk0waEEvRjFnZ3BNRzUvTHNHMVV0UFhraWJU?=
 =?utf-8?B?SnZZcjZIMHo1MTE2TXVXNFJkdzJCQzFISFNOUUdvQ2xqaTRwUExGU0VFUG0v?=
 =?utf-8?B?NHIzNndtS3dBMjdTT0RKb0FudEV4aEwyVmxxUW8rNEJweVEvc0ZBV2ppUHV1?=
 =?utf-8?B?Ymc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B67AC38D22872C49B7CE656B6C8A73CF@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b19fb055-cfce-41c5-66a9-08dbef9142ea
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Nov 2023 21:38:57.4884
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: am+o9dPuWNbmrQJ95Llw7R50uOWMY77CiAGnd0MffNqoSdzZwE9h69rbcrt/YggWMg9KW3UZEpTAqk4KfD8Xlvs0rJEK11OLQjAQpmLsR4U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB6889
X-OriginatorOrg: intel.com

T24gVHVlLCAyMDIzLTExLTIxIGF0IDEzOjIwIC0wODAwLCBtaGtlbGxleTU4QGdtYWlsLmNvbSB3
cm90ZToKPiArc3RhdGljIGludCBwdmFsaWRhdGVfcGZuKHVuc2lnbmVkIGxvbmcgdmFkZHIsIHVu
c2lnbmVkIGludCBzaXplLAo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIHVuc2lnbmVkIGxvbmcgcGZuLCBib29sIHZhbGlkYXRlLCBpbnQgKnJjMikKPiAr
ewo+ICvCoMKgwqDCoMKgwqDCoGludCByYzsKPiArwqDCoMKgwqDCoMKgwqBzdHJ1Y3QgcGFnZSAq
cGFnZSA9IHBmbl90b19wYWdlKHBmbik7Cj4gKwo+ICvCoMKgwqDCoMKgwqDCoCpyYzIgPSB2bWFw
X3BhZ2VzX3JhbmdlKHZhZGRyLCB2YWRkciArIFBBR0VfU0laRSwKPiArwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoFBBR0VfS0VSTkVMLCAmcGFnZSwgUEFHRV9T
SElGVCk7CgpDYW4ndCB0aGlzIGZhaWwgYW5kIHRoZW4gdGhlIHB2YWxpZGF0ZSBiZWxvdyB3b3Vs
ZCBlbmNvdW50ZXIgdHJvdWJsZT8KClNvcnQgb2Ygc2VwYXJhdGVseSwgaWYgdGhvc2Ugdm1hbGxv
YyBvYmplY3Rpb25zIGNhbid0IGJlIHdvcmtlZAp0aHJvdWdoLCBkaWQgeW91IGNvbnNpZGVyIGRv
aW5nIHNvbWV0aGluZyBsaWtlIHRleHRfcG9rZSgpIGRvZXMgKGNyZWF0ZQp0aGUgdGVtcG9yYXJ5
IG1hcHBpbmcgaW4gYSB0ZW1wb3JhcnkgTU0pIGZvciBwdmFsaWRhdGUgcHVycG9zZXM/IEkKZG9u
J3Qga25vdyBlbm91Z2ggYWJvdXQgd2hhdCBraW5kIG9mIHNwZWNpYWwgZXhjZXB0aW9ucyBtaWdo
dCBwb3B1cApkdXJpbmcgdGhhdCBvcGVyYXRpb24gdGhvdWdoLCBtaWdodCBiZSBwbGF5aW5nIHdp
dGggZmlyZS4uLgoKPiArwqDCoMKgwqDCoMKgwqByYyA9IHB2YWxpZGF0ZSh2YWRkciwgc2l6ZSwg
dmFsaWRhdGUpOwo+ICvCoMKgwqDCoMKgwqDCoHZ1bm1hcF9yYW5nZSh2YWRkciwgdmFkZHIgKyBQ
QUdFX1NJWkUpOwo+ICsKPiArwqDCoMKgwqDCoMKgwqByZXR1cm4gcmM7Cj4gK30KCg==

