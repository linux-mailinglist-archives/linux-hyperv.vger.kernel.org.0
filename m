Return-Path: <linux-hyperv+bounces-1241-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C090B8055D6
	for <lists+linux-hyperv@lfdr.de>; Tue,  5 Dec 2023 14:26:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4A6F3B20D53
	for <lists+linux-hyperv@lfdr.de>; Tue,  5 Dec 2023 13:26:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD4225D49A;
	Tue,  5 Dec 2023 13:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T3Ac2b2A"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 514C01A5;
	Tue,  5 Dec 2023 05:26:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701782769; x=1733318769;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=R4/yjKCgjYoYXINZhAzVAsTmyHJC0ly9sdActSximZ0=;
  b=T3Ac2b2Ah2q+3KSSzwtOM12EaEc2zvq6hfun7JQHrJJ7Ye6tKkZmz2Ii
   dKP1V8au+SZQbmaCzq44xdzSCiuNxhIosUJWUJKCm1rQQQI9W7NpKOKao
   pmXDCW8rtL+6pCh0BwCkNXbBeEPuYJZzADMDn9k9waWd4YX5Hv2gQW0fa
   OexiSjee4zXE2VjaU24Q3gZF/eSd2W0d9jJHE/UawHimlZqIG6Hjh/i4y
   hBuDRAszXyu6q+rrjsbKwhAVmvny5TWCnCUM5kiA7Bf4JGrA8sN4pveTI
   GRdWUsmE2/8GgtWLTAWqDPPKMXr87egWtDkVJLVjQwqOpFVlI4q9UFVOV
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10914"; a="786295"
X-IronPort-AV: E=Sophos;i="6.04,252,1695711600"; 
   d="scan'208";a="786295"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2023 05:26:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10914"; a="1018219461"
X-IronPort-AV: E=Sophos;i="6.04,252,1695711600"; 
   d="scan'208";a="1018219461"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Dec 2023 05:26:08 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 5 Dec 2023 05:26:08 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 5 Dec 2023 05:26:08 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.101)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Tue, 5 Dec 2023 05:26:08 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XrpeNAAFD4qf9OhCyZ2o9cMS/ITdqep7l7b9XHjDphpoXW1dACSViucEvDLmW03cxlSRwKS1PFAk+dz5/orSuqB9aEVZZ0y5l4BMO/j9jDAvKeSY292963MZ5Tr1gNlwsPQenUjNftlzjnCCzadnhj3WhDTcueqSUDikqYT8tnY2mCoxt3f70mG6rtrvH1DuA6eyjSUW4Ts5f/Yrn4VEV3vGOrWs1n4AdbZBu8Fhub2f11FDPPIzfcWRAggKO8Bsh928KuHexsEpNZL/MK4+5H48zrCHjR5/wAbX0anSvRDxX/T1N+WW/fMg/1zAqCDnKHLN1pBUsyraranfkZY0MQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R4/yjKCgjYoYXINZhAzVAsTmyHJC0ly9sdActSximZ0=;
 b=hdiiXRXnvB27RVAEFFxS0ZLTKEyPd0GajnOKnLSvmGxygxM6QoyLBKsqNZIuZuggjOpAVXu6h8PBwWGvFgmVlWayUbxuWwmiG+gt6fiXOqG1t4diqUsNYHNJ4p9reAGJvZJjSGUq71a1Ad0RZZ+IfP4OOCrz83n2EF+qrvDtWpzrkA3Pwo0zgE18qzeaDr5W8+GnFgbLNMIV+6gU1a4UIFM0Jgm7GaAvzsTg6iabPZldqctDc2mwviULAlLNmENPHml1AeSX711RlHqdJrLo4Ltf6bc0o/iUeY+1etKP3nQ/qzxWIyDlwWovOa6p2FQUmghaQDsmrLC0//hIkv2Rjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by SA2PR11MB4988.namprd11.prod.outlook.com (2603:10b6:806:f8::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Tue, 5 Dec
 2023 13:26:05 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::5d1:aa22:7c98:f3c6]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::5d1:aa22:7c98:f3c6%7]) with mapi id 15.20.7046.033; Tue, 5 Dec 2023
 13:26:05 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
	"mhkelley58@gmail.com" <mhkelley58@gmail.com>, "Cui, Dexuan"
	<decui@microsoft.com>, "jpiotrowski@linux.microsoft.com"
	<jpiotrowski@linux.microsoft.com>
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
Subject: Re: [PATCH v1 1/3] x86/tdx: Check for TDX partitioning during early
 TDX init
Thread-Topic: [PATCH v1 1/3] x86/tdx: Check for TDX partitioning during early
 TDX init
Thread-Index: AQHaHWWtv7u0f2izB0aVCuwkdix+ibCH744AgAFYfQCAAANSgIAABfUAgAApowCAAC5QgIAHFxKAgAPoeACABhmPAA==
Date: Tue, 5 Dec 2023 13:26:04 +0000
Message-ID: <7b725783f1f9102c176737667bfec12f75099961.camel@intel.com>
References: <20231122170106.270266-1-jpiotrowski@linux.microsoft.com>
	 <20231123135846.pakk44rqbbi7njmb@box.shutemov.name>
	 <9f550947-9d13-479c-90c4-2e3f7674afee@linux.microsoft.com>
	 <20231124104337.gjfyasjmo5pp666l@box.shutemov.name>
	 <58c82110-45b2-4e23-9a82-90e1f3fa43c2@linux.microsoft.com>
	 <20231124133358.sdhomfs25seki3lg@box.shutemov.name>
	 <6f27610f-afc4-4356-b297-13253bb0a232@linux.microsoft.com>
	 <ffcc8c550d5ba6122b201d8170b42ee581826d47.camel@intel.com>
	 <02e079e8-cc72-49d8-9191-8a753526eb18@linux.microsoft.com>
In-Reply-To: <02e079e8-cc72-49d8-9191-8a753526eb18@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.48.4 (3.48.4-1.fc38) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|SA2PR11MB4988:EE_
x-ms-office365-filtering-correlation-id: d3bbe737-88b6-4ace-cbc4-08dbf595bb31
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3B20fsFInAaGuDui9r4f3oAFffLTc4FsuaQxrk3dFT7S3C1wUDFY15tk+Kjm7n3dZQMMVNq2+b3i1e+H9Mv5irkZYQkdJKDZuqBbp5oSBZ02MrM06uBMyLG8WYc9baFMOfyf4kE5W1J7A7uvrDBbemNFsAqWQLbj8wXR97h+Kn8pZhspATEg4MHxkDfIZUNx3esHT4D72JjW3XlZwH6FzGvgTuKLqD8cbngXmTFv5F6ZUE7rj50zV8ypywmNASbdyPNhX/sAHr8aDU8CG3aejSV3VsWu7G7vIV3pCGbo7bgWkERx/l17VeXdCBgFyyU41W1qY6k5qaLUDLoyrycGMYWGognc1fvY0+x9wGVGziS+izaplnPU55IUrsm2BInMImcTPNI0FgJUcNHzkI9/3BugNQ4hCMWHqt175G3iSR1qAW60Z782i8DzJX+j8qsLGeEfMYezsVVRLs5CQJQo23yP3ZmauFrl8ncxTiZmW7avr40QVje2C6XFCs0DfYEa+CfhOYobJJSb3i3Oe036cEUYqDVqQtb1Ae+ZAgb0QavVqoUINWxmbxi/99p6snU6icxVkeS/X3AM+soFPsxh23W0M8C/CXy7iKaSHGoV7hF0SQkRKn3vEM9cgfUK8Nir
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(376002)(366004)(136003)(39860400002)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(122000001)(38100700002)(26005)(38070700009)(2906002)(7416002)(5660300002)(82960400001)(83380400001)(6512007)(71200400001)(6506007)(2616005)(66946007)(478600001)(76116006)(91956017)(110136005)(6486002)(36756003)(41300700001)(66446008)(66899024)(54906003)(4326008)(8676002)(64756008)(66556008)(66476007)(316002)(86362001)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dGF0KzQ4TlhtMDA2SCtxTTRNaGR4b2lVNkJ6QXZDWjdOaE9TZk9IN3Vpc0U0?=
 =?utf-8?B?VTJrbTBBUVRtdzZYV05tbWhyS1lWV2hNNmZycnlvLzdJVHpCM3ZHWHhpV2ph?=
 =?utf-8?B?REhnc3pJTDgxa3JXZk9JR2p2TXVDZmo1bkIrSVU1UE1pUHJ1YVk0YmpMQXAx?=
 =?utf-8?B?WW9rckpqZEZOY1lOWnhsWDROVDlBU3B2N3pmTUtSQzhFS1ZOb01NSkhOMXQr?=
 =?utf-8?B?WTgzeEwxbS9VY3NTb3JrMEVkSHp1Lyt6Z2dORzhDekZJdkh2MG9ra1p6WkRw?=
 =?utf-8?B?ZzhjT2hkcGlWSWVVc1hTWmM4NTNHems5OVExRVFrRTBFWFlnYWM0Y0FtNCto?=
 =?utf-8?B?N0FjQ3ZuRFRieXUrcFFlVkFaV1B6ODFBRXFWaksveC9oSTJFM3Y3TkpleXdk?=
 =?utf-8?B?RHdLSmZESk40VjZhOFVEc09kSk45V25hcXNOS1dmU0pPZXVBVGtLR2p0MURn?=
 =?utf-8?B?US9DUUdFS2V0ZWN5UlNrcXh1c0FDMEswWlFpYlYyL3RVTVgvWUhUNjNZTkxO?=
 =?utf-8?B?SS9NUW1sS3RyVXR1N1IzTVdLcGprSHZDVStSUllaUFBITWdsUWtLeVQzR1dV?=
 =?utf-8?B?SjJPVXU2dkU1bitHMHpCWWo5VEJ6Umh5VHdPR3hIV05IemFTeDFWRnMrajJ3?=
 =?utf-8?B?Z1g2Vnl4aWpXcFNQVXNoeGc0cDQxVXFsVlF3N25RMkpTT3BxTS9hK3d0Y3Bv?=
 =?utf-8?B?ajh1bktyY0hpVkY0a3VjejNVUjBxc2JyNU10eTVwRnBkcVAwazJ2RVducEZZ?=
 =?utf-8?B?MHArelp4RCtGS0d4ZktXckFIQU4yYXhaaEdzMXV5ZzFSU3ZxRXo3Sm9IdWEr?=
 =?utf-8?B?eW4rY2xwTVlvcStNeWlnKzdHOHZvN3M4TnNucUhvRzIzMUpxV2NYc0pZNGI2?=
 =?utf-8?B?UzFtMXRDTGhBZ2FyaHBCcGtMN2tETGZLYWp5aEFPb056TWtBR0NkSVFucnlK?=
 =?utf-8?B?RXpzcTEzb2ZRS1ppRkFzZkVxVzVoQjg1TjhEbTZyeFJQa3diM2dvVFFBYjJV?=
 =?utf-8?B?a2FSRUdzaEdWMHpsd05yUVZ2WlhoNmtTaWRrSkdNcGJjRjVPRGdlYmluV3Qy?=
 =?utf-8?B?UDJ4VEsxL05WT0NzNExYTlBNYWhaamFIMjJIcVVJUU5hZWVNR3kxd2tzQTZi?=
 =?utf-8?B?U1JiTUUyR2R3QnVZajlocHMxN3NHRllqS09GMFpmSlN2cUZ6enJaZmJkdHlp?=
 =?utf-8?B?NmdwV2c4a244TEVJWUJRQWozVG9zbndkTzdCeDQ1RHAraWJOMUZLT01sOHRx?=
 =?utf-8?B?RnBrTDZCZ3ZtRXlYVklEL0txNHFnNEptMXNraDhka1llZktLdlM1RENzNHNQ?=
 =?utf-8?B?cnBDM2laUURLcU8rZS8wYXV3dG5VVWVoSTVsZU5UcVNtNWErUXpsb2JRLzFr?=
 =?utf-8?B?aUNkQ3d6MW9GVkdVeFJEUFlrdENvV09zaXdldEZHMkh3cjBrQW51UldSNkRX?=
 =?utf-8?B?WVF5TWI2WWdBZWFKenN2ZFJaenRPUEU0R2pZWFQzN0N6ZFF4QUJEYlB6amhr?=
 =?utf-8?B?TzNzUXo4OGxXei9xNlgyME1NWWtUQk1zWmJEZHhhUnlObnhsMFU5S3JGS1pw?=
 =?utf-8?B?bEdCYzFxTWZ4RXpNQ0pFZndzdUQ5SmU0TUFmb21YT201bXRENmI1SStpQjdY?=
 =?utf-8?B?Q2tqV2FaN3kzWUJwdG5JVG44U3YvaEJBMThMOXM1MXp1TnV6TGtIbXNGbm5V?=
 =?utf-8?B?QmtDV2VPVGJUdkc1dzRJVGtIcGlPak9vZW5hK3dPejlUSStTZUJoU2MvM2Ex?=
 =?utf-8?B?NnZCT1pCd1BTVytwYkV4bHh5NUtyYmdiMzZOdXl3UURkVUJpa045OFhvMGpu?=
 =?utf-8?B?VitackU1QStNM0h2QnZhU0lvVVlITHB1aFlMUUQyVFBBdjBhaVdXQ2VNRENG?=
 =?utf-8?B?SUx4dDFrQW9UTDNxMWlDU2FTMFp5ZEJaSjRNVGE4TTNROHJsVWwyKzdIdjdu?=
 =?utf-8?B?OTRHa2NBN21GR0xkcjJ4OTR0d3BEKzNvOG15WnRZOHQySGFNaXprOGpXRjZv?=
 =?utf-8?B?cVQrNXhLdEtmVXIrWTJLRk55MFhLaW9MeGFleTFaV2NMWjBrNFJ5Vk5GaGRl?=
 =?utf-8?B?Z3NuWXdYS2Y1cVJBV1NSODFWcFNnNTdaRmt5eXNkUGNyRzRURTdReUlkeDdF?=
 =?utf-8?B?ZEp1YTRRdnpNR3I2RlJqR1UwWkNiYTBKeU0zeUM3VklYcVhiM3dIL3I2QXVo?=
 =?utf-8?B?aXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7097594017277A48A29462D508484ED7@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3bbe737-88b6-4ace-cbc4-08dbf595bb31
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Dec 2023 13:26:04.2260
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: a9Dwnrf3zzRjRmATQ0WzYdzeI/3KHXMzkqrghXYsfnHcX5JhDmOAUOJOMw0mbyWxUezNZEjI6dyzanKjhE/Pqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4988
X-OriginatorOrg: intel.com

PiANCj4gPiA+ID4gDQo+ID4gPiA+IEhtLiBPa2F5Lg0KPiA+ID4gPiANCj4gPiA+ID4gQ2FuIHdl
IHRha2UgYSBzdGVwIGJhY2s/IFdoYXQgaXMgYmlnZ2VyIHBpY3R1cmUgaGVyZT8gV2hhdCBlbmxp
Z2h0ZW5tZW50DQo+ID4gPiA+IGRvIHlvdSBleHBlY3QgZnJvbSB0aGUgZ3Vlc3Qgd2hlbiBldmVy
eXRoaW5nIGlzIGluLXBsYWNlPw0KPiA+ID4gPiANCj4gPiA+IA0KPiA+ID4gQWxsIHRoZSBmdW5j
dGlvbmFsIGVubGlnaHRlbm1lbnQgYXJlIGFscmVhZHkgaW4gcGxhY2UgaW4gdGhlIGtlcm5lbCBh
bmQNCj4gPiA+IGV2ZXJ5dGhpbmcgd29ya3MgKGNvcnJlY3QgbWUgaWYgSSdtIHdyb25nIERleHVh
bi9NaWNoYWVsKS4gVGhlIGVubGlnaHRlbm1lbnRzDQo+ID4gPiBhcmUgdGhhdCBURFggVk1DQUxM
cyBhcmUgbmVlZGVkIGZvciBNU1IgbWFuaXB1bGF0aW9uIGFuZCB2bWJ1cyBvcGVyYXRpb25zLA0K
PiA+ID4gZW5jcnlwdGVkIGJpdCBuZWVkcyB0byBiZSBtYW5pcHVsYXRlZCBpbiB0aGUgcGFnZSB0
YWJsZXMgYW5kIHBhZ2UNCj4gPiA+IHZpc2liaWxpdHkgcHJvcGFnYXRlZCB0byBWTU0uDQo+ID4g
DQo+ID4gTm90IHF1aXRlIGZhbWlseSB3aXRoIGh5cGVydiBlbmxpZ2h0ZW5tZW50cywgYnV0IGFy
ZSB0aGVzZSBlbmxpZ2h0ZW5tZW50cyBURFgNCj4gPiBndWVzdCBzcGVjaWZpYz8gIEJlY2F1c2Ug
aWYgdGhleSBhcmUgbm90LCB0aGVuIHRoZXkgc2hvdWxkIGJlIGFibGUgdG8gYmUNCj4gPiBlbXVs
YXRlZCBieSB0aGUgbm9ybWFsIGh5cGVydiwgdGh1cyB0aGUgaHlwZXJ2IGFzIEwxICh3aGljaCBp
cyBURFggZ3Vlc3QpIGNhbg0KPiA+IGVtdWxhdGUgdGhlbSB3L28gbGV0dGluZyB0aGUgTDIga25v
dyB0aGUgaHlwZXJ2aXNvciBpdCBydW5zIG9uIGlzIGFjdHVhbGx5IGEgVERYDQo+ID4gZ3Vlc3Qu
DQo+IA0KPiBJIHdvdWxkIHNheSB0aGF0IHRoZXNlIGh5cGVydiBlbmxpZ2h0ZW5tZW50cyBhcmUg
Y29uZmlkZW50aWFsIGd1ZXN0IHNwZWNpZmljDQo+IChURFgvU05QKSB3aGVuIHJ1bm5pbmcgd2l0
aCBURC1wYXJ0aXRpb25pbmcvVk1QTC4gSW4gYm90aCBjYXNlcyB0aGVyZSBhcmUgVERYL1NOUA0K
PiBzcGVjaWZpYyB3YXlzIHRvIGV4aXQgZGlyZWN0bHkgdG8gTDAgKHdoZW4gbmVlZGVkKSBhbmQg
bmF0aXZlIHByaXZpbGVnZWQgaW5zdHJ1Y3Rpb25zDQo+IHRyYXAgdG8gdGhlIHBhcmF2aXNvci4N
Cj4gDQo+IEwxIGlzIG5vdCBoeXBlcnYgYW5kIG5vIG9uZSB3YW50cyB0byBlbXVsYXRlIHRoZSBJ
L08gcGF0aC4gVGhlIEwyIGd1ZXN0IGtub3dzIHRoYXQNCj4gaXQncyBjb25maWRlbnRpYWwgc28g
dGhhdCBpdCBjYW4gZXhwbGljaXRseSB1c2Ugc3dpb3RsYiwgdG9nZ2xlIHBhZ2UgdmlzaWJpbGl0
eQ0KPiBhbmQgbm90aWZ5IHRoZSBob3N0IChMMCkgb24gdGhlIEkvTyBwYXRoIHdpdGhvdXQgaW5j
dXJyaW5nIGFkZGl0aW9uYWwgZW11bGF0aW9uDQo+IG92ZXJoZWFkLg0KPiANCj4gPiANCj4gPiBC
dHcsIGV2ZW4gaWYgdGhlcmUncyBwZXJmb3JtYW5jZSBjb25jZXJuIGhlcmUsIGFzIHlvdSBtZW50
aW9uZWQgdGhlIFREVk1DQUxMIGlzDQo+ID4gYWN0dWFsbHkgbWFkZSB0byB0aGUgTDAgd2hpY2gg
bWVhbnMgTDAgbXVzdCBiZSBhd2FyZSBzdWNoIFZNQ0FMTCBpcyBmcm9tIEwyIGFuZA0KPiA+IG5l
ZWRzIHRvIGJlIGluamVjdGVkIHRvIEwxIHRvIGhhbmRsZSwgd2hpY2ggSU1ITyBub3Qgb25seSBj
b21wbGljYXRlcyB0aGUgTDAgYnV0DQo+ID4gYWxzbyBtYXkgbm90IGhhdmUgYW55IHBlcmZvcm1h
bmNlIGJlbmVmaXRzLg0KPiANCj4gVGhlIFREVk1DQUxMcyBhcmUgcmVsYXRlZCB0byB0aGUgSS9P
IHBhdGggKG5ldHdvcmtpbmcvYmxvY2sgaW8pIGludG8gdGhlIEwyIGd1ZXN0LCBhbmQNCj4gc28g
dGhleSBpbnRlbnRpb25hbGx5IGdvIHN0cmFpZ2h0IHRvIEwwIGFuZCBhcmUgbmV2ZXIgaW5qZWN0
ZWQgdG8gTDEuIEwxIGlzIG5vdA0KPiBpbnZvbHZlZCBpbiB0aGF0IHBhdGggYXQgYWxsLg0KPiAN
Cj4gVXNpbmcgc29tZXRoaW5nIGRpZmZlcmVudCB0aGFuIFREVk1DQUxMcyBoZXJlIHdvdWxkIGxl
YWQgdG8gYWRkaXRpb25hbCB0cmFwcyB0byBMMSBhbmQNCj4ganVzdCBhZGQgbGF0ZW5jeS9jb21w
bGV4aXR5Lg0KDQpMb29rcyBieSBkZWZhdWx0IHlvdSBhc3N1bWUgd2Ugc2hvdWxkIHVzZSBURFgg
cGFydGl0aW9uaW5nIGFzICJwYXJhdmlzb3IgTDEiICsNCiJMMCBkZXZpY2UgSS9PIGVtdWxhdGlv
biIuDQoNCkkgdGhpbmsgd2UgYXJlIGxhY2tpbmcgYmFja2dyb3VuZCBvZiB0aGlzIHVzYWdlIG1v
ZGVsIGFuZCBob3cgaXQgd29ya3MuICBGb3INCmluc3RhbmNlLCB0eXBpY2FsbHkgTDIgaXMgY3Jl
YXRlZCBieSBMMSwgYW5kIEwxIGlzIHJlc3BvbnNpYmxlIGZvciBMMidzIGRldmljZQ0KSS9PIGVt
dWxhdGlvbi4gIEkgZG9uJ3QgcXVpdGUgdW5kZXJzdGFuZCBob3cgY291bGQgTDAgZW11bGF0ZSBM
MidzIGRldmljZSBJL08/DQoNCkNhbiB5b3UgcHJvdmlkZSBtb3JlIGluZm9ybWF0aW9uPw0KDQo+
IA0KPiA+IA0KPiA+ID4gDQo+ID4gPiBXaGF0cyBtaXNzaW5nIGlzIHRoZSB0ZHhfZ3Vlc3QgZmxh
ZyBpcyBub3QgZXhwb3NlZCB0byB1c2Vyc3BhY2UgaW4gL3Byb2MvY3B1aW5mbywNCj4gPiA+IGFu
ZCBhcyBhIHJlc3VsdCBkbWVzZyBkb2VzIG5vdCBjdXJyZW50bHkgZGlzcGxheToNCj4gPiA+ICJN
ZW1vcnkgRW5jcnlwdGlvbiBGZWF0dXJlcyBhY3RpdmU6IEludGVsIFREWCIuDQo+ID4gPiANCj4g
PiA+IFRoYXQncyB3aGF0IEkgc2V0IG91dCB0byBjb3JyZWN0Lg0KPiA+ID4gDQo+ID4gPiA+IFNv
IGZhciBJIHNlZSB0aGF0IHlvdSB0cnkgdG8gZ2V0IGtlcm5lbCB0aGluayB0aGF0IGl0IHJ1bnMg
YXMgVERYIGd1ZXN0LA0KPiA+ID4gPiBidXQgbm90IHJlYWxseS4gVGhpcyBpcyBub3QgdmVyeSBj
b252aW5jaW5nIG1vZGVsLg0KPiA+ID4gPiANCj4gPiA+IA0KPiA+ID4gTm8gdGhhdCdzIG5vdCBh
Y2N1cmF0ZSBhdCBhbGwuIFRoZSBrZXJuZWwgaXMgcnVubmluZyBhcyBhIFREWCBndWVzdCBzbyBJ
DQo+ID4gPiB3YW50IHRoZSBrZXJuZWwgdG8ga25vdyB0aGF0LsKgDQo+ID4gPiANCj4gPiANCj4g
PiBCdXQgaXQgaXNuJ3QuICBJdCBydW5zIG9uIGEgaHlwZXJ2aXNvciB3aGljaCBpcyBhIFREWCBn
dWVzdCwgYnV0IHRoaXMgZG9lc24ndA0KPiA+IG1ha2UgaXRzZWxmIGEgVERYIGd1ZXN0Lj4gDQo+
IA0KPiBUaGF0IGRlcGVuZHMgb24geW91ciBkZWZpbml0aW9uIG9mICJURFggZ3Vlc3QiLiBUaGUg
VERYIDEuNSBURCBwYXJ0aXRpb25pbmcgc3BlYw0KPiB0YWxrcyBvZiBURFgtZW5saWdodGVuZWQg
TDEgVk1NLCAob3B0aW9uYWxseSkgVERYLWVubGlnaHRlbmVkIEwyIFZNIGFuZCBVbm1vZGlmaWVk
DQo+IExlZ2FjeSBMMiBWTS4gSGVyZSB3ZSdyZSBkZWFsaW5nIHdpdGggYSBURFgtZW5saWdodGVu
ZWQgTDIgVk0uDQo+IA0KPiBJZiBhIGd1ZXN0IHJ1bnMgaW5zaWRlIGFuIEludGVsIFREWCBwcm90
ZWN0ZWQgVEQsIGlzIGF3YXJlIG9mIG1lbW9yeSBlbmNyeXB0aW9uIGFuZA0KPiBpc3N1ZXMgVERW
TUNBTExzIC0gdG8gbWUgdGhhdCBtYWtlcyBpdCBhIFREWCBndWVzdC4NCg0KVGhlIHRoaW5nIEkg
ZG9uJ3QgcXVpdGUgdW5kZXJzdGFuZCBpcyB3aGF0IGVubGlnaHRlbm1lbnQocykgcmVxdWlyZXMg
TDIgdG8gaXNzdWUNClREVk1DQUxMIGFuZCBrbm93ICJlbmNyeXB0aW9uIGJpdCIuDQoNClRoZSBy
ZWFzb24gdGhhdCBJIGNhbiB0aGluayBvZiBpczoNCg0KSWYgZGV2aWNlIEkvTyBlbXVsYXRpb24g
b2YgTDIgaXMgZG9uZSBieSBMMCB0aGVuIEkgZ3Vlc3MgaXQncyByZWFzb25hYmxlIHRvIG1ha2UN
CkwyIGF3YXJlIG9mIHRoZSAiZW5jcnlwdGlvbiBiaXQiIGJlY2F1c2UgTDAgY2FuIG9ubHkgd3Jp
dGUgZW11bGF0ZWQgZGF0YSB0bw0Kc2hhcmVkIGJ1ZmZlci4gIFRoZSBzaGFyZWQgYnVmZmVyIG11
c3QgYmUgaW5pdGlhbGx5IGNvbnZlcnRlZCBieSB0aGUgTDIgYnkgdXNpbmcNCk1BUF9HUEEgVERW
TUNBTEwgdG8gTDAgKHRvIHphcCBwcml2YXRlIHBhZ2VzIGluIFMtRVBUIGV0YyksIGFuZCBMMiBu
ZWVkcyB0byBrbm93DQp0aGUgImVuY3J5cHRpb24gYml0IiB0byBzZXQgdXAgaXRzIHBhZ2UgdGFi
bGUgcHJvcGVybHkuICBMMSBtdXN0IGJlIGF3YXJlIG9mDQpzdWNoIHByaXZhdGUgPC0+IHNoYXJl
ZCBjb252ZXJzaW9uIHRvbyB0byBzZXR1cCBwYWdlIHRhYmxlIHByb3Blcmx5IHNvIEwxIG11c3QN
CmFsc28gYmUgbm90aWZpZWQuDQoNClRoZSBjb25jZXJuIEkgYW0gaGF2aW5nIGlzIHdoZXRoZXIg
dGhlcmUncyBvdGhlciB1c2FnZSBtb2RlbChzKSB0aGF0IHdlIG5lZWQgdG8NCmNvbnNpZGVyLiAg
Rm9yIGluc3RhbmNlLCBydW5uaW5nIGJvdGggdW5tb2RpZmllZCBMMiBhbmQgZW5saWdodGVuZWQg
TDIuICBPciBzb21lDQpMMiBvbmx5IG5lZWRzIFREVk1DQUxMIGVubGlnaHRlbm1lbnQgYnV0IG5v
ICJlbmNyeXB0aW9uIGJpdCIuDQoNCkluIG90aGVyIHdvcmRzLCB0aGF0IHNlZW1zIHByZXR0eSBt
dWNoIEwxIGh5cGVydmlzb3IvcGFyYXZpc29yIGltcGxlbWVudGF0aW9uDQpzcGVjaWZpYy4gIEkg
YW0gd29uZGVyaW5nIHdoZXRoZXIgd2UgY2FuIGNvbXBsZXRlbHkgaGlkZSB0aGUgZW5saWdodGVu
bWVudChzKQ0KbG9naWMgdG8gaHlwZXJ2aXNvci9wYXJhdmlzb3Igc3BlY2lmaWMgY29kZSBidXQg
bm90IGdlbmVyaWNhbGx5IG1hcmsgTDIgYXMgVERYDQpndWVzdCBidXQgc3RpbGwgbmVlZCB0byBk
aXNhYmxlIFREQ0FMTCBzb3J0IG9mIHRoaW5ncy4NCg0KSG9wZSB3ZSBhcmUgZ2V0dGluZyBjbG9z
ZXIgdG8gYmUgb24gdGhlIHNhbWUgcGFnZS4NCg0K

