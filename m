Return-Path: <linux-hyperv+bounces-563-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 55EB97D080E
	for <lists+linux-hyperv@lfdr.de>; Fri, 20 Oct 2023 08:02:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2627F1C20A63
	for <lists+linux-hyperv@lfdr.de>; Fri, 20 Oct 2023 06:02:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E0C49468;
	Fri, 20 Oct 2023 06:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="EHxpUXYI"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97ED163C3
	for <linux-hyperv@vger.kernel.org>; Fri, 20 Oct 2023 06:01:59 +0000 (UTC)
Received: from DM6FTOPR00CU001.outbound.protection.outlook.com (mail-centralusazon11020014.outbound.protection.outlook.com [52.101.61.14])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B618CA;
	Thu, 19 Oct 2023 23:01:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KCfyRAFpc/2E1dJ8KFPbtkCpZoBXoDL2eox0bsggoodRw4nYxXZsC9cxpGXZwqeJEaRudz/xIytQPWwVgWwezwPb7y7hjA8hyojs7pKP7m5qzXFRYjQNPLlxWMJ63H4FLA7YYsHRVdmvFQBmFyemMG11A1LgEJsyIiDU1z4hoetNT9WuEUjHymkrR4RSK6oAnMjVNaVSOTo9WzfT/n3RpXtfZ4tJcO2V/7v0QTAq87iOSKxY3teKeJjOCxR3f2B6qBPCfJg77qEPOCBeYOk0SzuYEkRl5/9smQmKhTpdPqRf0kSMJXliTZ0m8hQAJW1pXAfGULvBPA6L1ua/JH2tgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B9yjlLixfWaaoauU5HPd5IZwiBozlKJaDN6DGwp2qSs=;
 b=bzQ33THx8RhGsoexeKB89kVgUlfMzdPKbuq9nij5W1wUgBFoIrelg0niuu+/k47zNqhc5Wmhanm9YfRoCnkruZSz0jg925aEUW3mCXnVvb90Q7lissnLHZSoYPfhJwP6bytOrQMK8YZp73TKltgd9ZYSNcZSSTS9NLUC/JyoLkEXtSZHfH4tifSOYV/m1A6v9TWieDv+7iNtJvn8LP0oyc6VJGq2Fxn0e8fmdqYnNL0W+9sOI2K8SNzbnZaTM7gjNvsY2QkvHVbpSXK45XUAXCqibnrfg22ljI96j0Ky+Lk84KN3tRl2xQxty69LHd/LixAi2jc3qaUXzqhVqdk7Pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B9yjlLixfWaaoauU5HPd5IZwiBozlKJaDN6DGwp2qSs=;
 b=EHxpUXYIMXsCyRzxLWNLxWl2jguNxTHU2bLuMynK+abMUhvGr2Nh0vf3vZgBNn0A37S7rxlG1IsQ0Q5g0grPlJu3I4ruKAILw2FCC54B+t62Mpf6PAmiiovFzAiSg8+dxikodglagEe96g/H17IMwcY5OQ2XrRiViyil9IXtp1A=
Received: from SA1PR21MB1335.namprd21.prod.outlook.com (2603:10b6:806:1f2::11)
 by MN0PR21MB3170.namprd21.prod.outlook.com (2603:10b6:208:37a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.3; Fri, 20 Oct
 2023 06:01:54 +0000
Received: from SA1PR21MB1335.namprd21.prod.outlook.com
 ([fe80::8fee:5174:b3ad:4f5f]) by SA1PR21MB1335.namprd21.prod.outlook.com
 ([fe80::8fee:5174:b3ad:4f5f%2]) with mapi id 15.20.6933.002; Fri, 20 Oct 2023
 06:01:54 +0000
From: Dexuan Cui <decui@microsoft.com>
To: Dave Hansen <dave.hansen@intel.com>, KY Srinivasan <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>, "wei.liu@kernel.org"
	<wei.liu@kernel.org>, "tglx@linutronix.de" <tglx@linutronix.de>,
	"mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "x86@kernel.org"
	<x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>, "luto@kernel.org"
	<luto@kernel.org>, "peterz@infradead.org" <peterz@infradead.org>,
	"stefan.bader@canonical.com" <stefan.bader@canonical.com>, Tim Gardner
	<tim.gardner@canonical.com>, "roxana.nicolescu@canonical.com"
	<roxana.nicolescu@canonical.com>, "cascardo@canonical.com"
	<cascardo@canonical.com>, "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
	"jgross@suse.com" <jgross@suse.com>,
	"sathyanarayanan.kuppuswamy@linux.intel.com"
	<sathyanarayanan.kuppuswamy@linux.intel.com>,
	"kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
	"sashal@kernel.org" <sashal@kernel.org>,
	"matija.glavinic-pecotic.ext@nokia.com"
	<matija.glavinic-pecotic.ext@nokia.com>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] x86/mm: Print the encryption features correctly when a
 paravisor is present
Thread-Topic: [PATCH] x86/mm: Print the encryption features correctly when a
 paravisor is present
Thread-Index: AQHaAqS1lPLVbi3WBEyYYZzhrGm+7LBSE1aQ
Date: Fri, 20 Oct 2023 06:01:53 +0000
Message-ID:
 <SA1PR21MB13352433C4D72AE19F1FF56EBFDBA@SA1PR21MB1335.namprd21.prod.outlook.com>
References: <20231019062030.3206-1-decui@microsoft.com>
 <00ff2f75-e780-4e2d-bcc9-f441f5ef879c@intel.com>
In-Reply-To: <00ff2f75-e780-4e2d-bcc9-f441f5ef879c@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=910a4a3c-1f0a-4153-95bd-cf8981953d72;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-10-20T04:17:17Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR21MB1335:EE_|MN0PR21MB3170:EE_
x-ms-office365-filtering-correlation-id: 7814b80b-9ef0-4256-0eda-08dbd1320f60
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 d6G/y9fkW602ki9XJ0KtcmOmgCAAZ+w1+m8YAzEEFzJGUhSikM6D5To+hZk/saPst61/TaAOQKm9EhrumM8JTy/YST0wesVlXpXGMhBaFOA+DCwhilFBUrCxS8FBQ16XfbX8SFnLFEzoMm4obhl0nmTNHH56WXOzrkYx2uYZi8QQ4Aamj1vyA4QLzCMLxy0WTPfPQyEBb4FdXrollV/uMlMvzuWxJmpxFAhLT3jahAK0EgJ6K25Si1foLb8dril8ncY0PxgJWAARxVdiuLDipdTo/ByIJGagDLpsTa41yDmsIlu5S2kPLl6G+HF4Cig/LdVKqRNkHN6NhRfVR+yerPjKauhzgWeAudHBZdmMKyKf+d7iLdS/PQUufjup4DF73PMn4iBNGMzMBaCRWqiD/tnBHM1NgY5d3UrXYDnS89lNUq1PTosF1w3JIxPP8nu1rU9h4uPh9VWsFzkJhrQjZRbUq2WKKnhrBYigs7Pv1XuBBH9Lm9WBqdVLaRdD2vMKt2oiX5uCn8+LerVkx1e5SzR11hzQnAPZxhEOi6lm9dCvWq2xjfYecAmXeIWr/Br1IUD5cO/vEwAYs3gVZVmfpL6wMFYX+zVPQYRwz6FQDLbdgww80HdpB9TTPEUflzKIiSrGHiyKq/ttcgnMhXeFoiYQUOeqFGy3QExIR+m5cFZKWJ+KT8eakOGzlFUxaweT
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR21MB1335.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(396003)(366004)(376002)(136003)(230922051799003)(186009)(451199024)(1800799009)(64100799003)(478600001)(38070700009)(82960400001)(10290500003)(71200400001)(53546011)(6506007)(7696005)(82950400001)(122000001)(9686003)(66476007)(64756008)(66556008)(110136005)(66446008)(921008)(76116006)(316002)(66946007)(38100700002)(52536014)(4326008)(55016003)(41300700001)(2906002)(7416002)(8990500004)(5660300002)(33656002)(8676002)(8936002)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?QkVxeDgwSW9POGI4WStMc0JQYlFEVnM1bVk5WlNlKzJXOW9EMysvL3p2eVZ5?=
 =?utf-8?B?MnNZclBtRkdxajh3SDc1aTE3aGxCR1lWOFY1K2MxYnNuNmladW4yRldmV3dY?=
 =?utf-8?B?VlFqRkVCNW5zeDhiV0ZHRitPN3dUZncrbTdva3IwQUFGNXdneGNwTXNGLzF1?=
 =?utf-8?B?TjBJRE1WZkY0UTJTVDRnVzNMclNNSzJQc1k3SmVialRvTTZ1MFFqWGc0cGI4?=
 =?utf-8?B?MVhOc3lPNVRwZE5DL2l4aFV4RkJsUEtOeWFFVTZueC9Hc2Q4T1lWSlVoL2VB?=
 =?utf-8?B?aWI0VXFwcTNGNm5FOXk3ekswR3ZSM3RtK1YvQm5yZlBVVnQ1RFRYdGVnTkIw?=
 =?utf-8?B?U1g3NHlhUGJUU3B5MnpqVUZZcGdRc1pPeXk3cngwbFo4OGh2OTR4YTY5UDhH?=
 =?utf-8?B?VW4yb2N4VkNPQk5ac0lJWWF2YnRRQWtTQkJQOXFmS1lLUEE3ay9zc2k4WVFR?=
 =?utf-8?B?V21qVUhVNkI3T29LTk9ob3hVSEc5bVZac1gvTHZPWXZ0bUcxQXBaUjJPM2Q5?=
 =?utf-8?B?b1huYkpMRDU1MlJoeVNHMmxvak4vcENBL01rbFJwaFBSRlFhcGsvOXZLUDla?=
 =?utf-8?B?WW1yM0phRFlrMS9pM1NMR2FkSTdnMzIrZ3VyditJMmlrZllVajd0UksxaFg4?=
 =?utf-8?B?VGc2RXNVVEVLNElVRk1GVzEyTktKUURtd1pBV2VwYi9maUF2MjJpUDJsSDhB?=
 =?utf-8?B?MFhqQ2g2ZGhPOTVQQkFJQ3lmY0Y4OVdJZDB1Mm5wM0lsMkJwaVB1eHdmcjVx?=
 =?utf-8?B?aTdBR3gyL2xsdGNGVlAweTZ2QitrMVVjamtLbVFxVTFJU0I3RURkOVF3UGNT?=
 =?utf-8?B?ZmdFbkxhRHlKNDRGdFUvTklWV2t3bXV0dFZ6aGRld1pTb3ZuNzVXbm5LVnJ3?=
 =?utf-8?B?Z0pOWTNFdndvTlRWWDI5ZlNwYUI5MjVxWnV2LzZ0Z2xpOUFBQTRFOEZrTWhK?=
 =?utf-8?B?MFg2ZkZiV2R1eXdCZ2dTdlBvZCtoS0k0ZmpOY3VUalFLOFE4QzkrMEdzd1Ix?=
 =?utf-8?B?ZFdiWm5BTlhrZG95RFNnZnV5end5VkE4UlJPZUREL1E4SzkvSk1JdWdaQ1d5?=
 =?utf-8?B?cmJSUzZCZ1diUzVUY3haOURVeEltQkRQQThUSHc5aXlpSHdtMDNxS2ZLZ0RX?=
 =?utf-8?B?VlVoU3Q2WTgvaTFIYnpkeG9XdThYOUFLL2Q5TThIVlV0T1hPL0JjYkFxT0V0?=
 =?utf-8?B?dDVTVkpGdVlhT3ZMRTdmVUMrL0V6VEFhaElqcW1qckJKaWFzcUEvbElXcTN0?=
 =?utf-8?B?TkNoOTdEdjVzSUxOZTdPanphc2w3MVR4NVVHZlhOSDk4Slg5ZWsydnV0S2tw?=
 =?utf-8?B?cDlXdXVWODk5a2dxekVwUWcxQnFqR094NUwxcENVMlRwYUdubndIVUw5MFpW?=
 =?utf-8?B?d0Nxc1I2U3RtRHh0ekUzRjcxMHBna2dJYjBnelQxMjllQjFjK0NjbTk0MHR6?=
 =?utf-8?B?Qmh6eTB6UnhYR2k3OXR1Um1tbnJTcHhGN3hFaytWVDBDY3V5L0Zqem9mTEgv?=
 =?utf-8?B?eTJ1bGx6a0w3bHFWMkl3TXk3QkhiRnBFbVNtK3gzakZKaURhNC82NmZoTWgw?=
 =?utf-8?B?VjArWTVBMHpZMjJjcjhxOVFUZHVnT3l6L1Y3alo4ZnA4ZHk1SzFvVnFHWkth?=
 =?utf-8?B?bWEvanpIeXdpQ2xsK3JOMldnb1BvT3FVRUc3Y3NpUDRuWTJLL0hzcDZ0cmhx?=
 =?utf-8?B?M1o3MlRBclVrUVZoVEFldlBHbVYvMEFpU1lmRUdScUMxRGpsUm40eDdSS0Rp?=
 =?utf-8?B?VTErRjNOcC80ZU1zdlBkWHk0cWkwbHo3bWlSeDkvSGd3RW8vbkNWaU5GMFVt?=
 =?utf-8?B?MGYvRmdEWTZIUTM5THJydU9aZktEa3NnYm9CQncyeklXb0c5RURoNWlTU1l3?=
 =?utf-8?B?Zkd5ZWEwYWNpcHY5b1hoWVk2a0JtdXpPVnU3d05RS3NLaE5pUmpmeFVWUlZI?=
 =?utf-8?B?eGszU2dXbE9iSEc0dUxpRi9PYkNuWTMrb1RtWDNZRXk4Rno3UG5nSXdVdC9z?=
 =?utf-8?B?MHdKbUlpODcvSC9vOE5IMEtnQ0VDeExzWXIxQUtLY0VRTGlYM1B5OHFKOWsx?=
 =?utf-8?B?clFkYXd0ZHF0NmZQRjRvTWRIK21BSXVCZ0tNdGJQeGdKOWJGQWxUV3crT25T?=
 =?utf-8?B?Z2VqQWt0ZEZoV2R3eDM0Q3hYbXU4cWhZK1V0dHdKTUpKbndwOStTbGQ1ODVM?=
 =?utf-8?Q?zFczjgAMedZV5ZpqO34/GmclOWXWYJ2o74x9ZTkpEoXh?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR21MB1335.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7814b80b-9ef0-4256-0eda-08dbd1320f60
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Oct 2023 06:01:53.9463
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KRQJZtqQFcsMIT6ABrj5agzob+RPI4eoY5u2jBhcpPn4U23vrvG0UYix4DgJ+43P0VTLmraH/FYS4uDLu91FaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR21MB3170

PiBGcm9tOiBEYXZlIEhhbnNlbiA8ZGF2ZS5oYW5zZW5AaW50ZWwuY29tPg0KPiBTZW50OiBUaHVy
c2RheSwgT2N0b2JlciAxOSwgMjAyMyA4OjU0IEFNDQo+IFRvOiBEZXh1YW4gQ3VpIDxkZWN1aUBt
aWNyb3NvZnQuY29tPjsgS1kgU3Jpbml2YXNhbg0KPiBbLi4uXQ0KPiA+IC0tLSBhL2FyY2gveDg2
L2h5cGVydi9pdm0uYw0KPiA+ICsrKyBiL2FyY2gveDg2L2h5cGVydi9pdm0uYw0KPiA+IEBAIC00
NTAsNiArNDUwLDE2IEBAIHN0YXRpYyBib29sIGh2X2lzX3ByaXZhdGVfbW1pbyh1NjQgYWRkcikN
Cj4gPiAgCXJldHVybiBmYWxzZTsNCj4gPiAgfQ0KPiA+DQo+ID4gK3N0YXRpYyB2b2lkIGh2X3By
aW50X21lbV9lbmNfZmVhdHVyZV9pbmZvKHZvaWQpDQo+ID4gK3sNCj4gPiArCWVudW0gaHZfaXNv
bGF0aW9uX3R5cGUgdHlwZSA9IGh2X2dldF9pc29sYXRpb25fdHlwZSgpOw0KPiA+ICsNCj4gPiAr
CWlmICh0eXBlID09IEhWX0lTT0xBVElPTl9UWVBFX1NOUCkNCj4gPiArCQlwcl9pbmZvKCJNZW1v
cnkgRW5jcnlwdGlvbiBGZWF0dXJlcyBhY3RpdmU6IEFNRA0KPiBTRVZcbiIpOw0KPiA+ICsJZWxz
ZSBpZiAodHlwZSA9PSBIVl9JU09MQVRJT05fVFlQRV9URFgpDQo+ID4gKwkJcHJfaW5mbygiTWVt
b3J5IEVuY3J5cHRpb24gRmVhdHVyZXMgYWN0aXZlOiBJbnRlbA0KPiA+IFREWFxuIik7DQo+ID4g
K30NCj4gDQo+IElmIHdlIGRyYXcgdGhpcyB0byBpdHMgbG9naWNhbCBjb25jbHVzaW9uLCBldmVy
eSBwYXJhdmlzb3Igd2lsbCBuZWVkIGENCj4gcHJfaW5mbygpIGZvciBldmVyeSBoYXJkd2FyZSBD
b0NvIGltcGxlbWVudGF0aW9uLiAgVGhhdCBNKk4gcHJfaW5mbygpcy4NCj4gVGhhdCBzZWVtcyBu
dXRzLg0KDQpUaGlzIHBhdGNoIG9ubHkgbW9kaWZpZXMgeDg2IHJlbGF0ZWQgZmlsZXMuIEkgdGhp
bmsgaXQncyB1bmxpa2VseSB0byBzZWUNCmEgdGhpcmQgaGFyZHdhcmUgQ29jbyBpbXBsZW1lbnRh
dGlvbiBmb3IgeDg2IGluIHRoZSBmb3Jlc2VlYWJsZSBmZWF0dXJlICg/KQ0KV2hlbiB3ZSBoYXZl
IGEgdGhpcmQgaW1wbGVtZW50YXRpb24sIEkgc3VwcG9zZSBtb3JlIGNvZGUsIGUuZy4sIHRoZSBl
eGlzdGluZw0KcHJpbnRfbWVtX2VuY3J5cHRfZmVhdHVyZV9pbmZvKCksICB3aWxsIGhhdmUgdG8g
YmUgY2hhbmdlZCBhcyB3ZWxsLg0KDQpDdXJyZW50bHkgaXQgbG9va3MgbGlrZSB0aGVyZSBpcyBv
bmx5IDEgcGFyYXZpc29yIGltcGxlbWVudGF0aW9uLiANCkkgdGhpbmsgd2UnbGwga25vdyBpZiBz
b21lIGNvZGUgY2FuIGJlIHNoYXJlZCBvbmx5IHdoZW4gYSBzZWNvbmQgcGFyYXZpc29yDQppbXBs
ZW1lbnRhdGlvbiBhcHBlYXJzLg0KDQpJIGNhbiB1c2UgdGhlIGJlbG93IHZlcnNpb24gaWYgeW91
IHRoaW5rIGl0J3MgYmV0dGVyOg0KDQpzdGF0aWMgY29uc3QgY2hhciAqaHZfbWVtX2VuY19mZWF0
dXJlc1tdID0gew0KICAgICAgICBbIEhWX0lTT0xBVElPTl9UWVBFX1NOUCBdID0gIkFNRCBTRVYi
LA0KICAgICAgICBbIEhWX0lTT0xBVElPTl9UWVBFX1REWCBdID0gIkludGVsIFREWCIsDQp9Ow0K
DQpzdGF0aWMgdm9pZCBodl9wcmludF9tZW1fZW5jX2ZlYXR1cmVfaW5mbyh2b2lkKQ0Kew0KICAg
ICAgICBlbnVtIGh2X2lzb2xhdGlvbl90eXBlIHR5cGUgPSBodl9nZXRfaXNvbGF0aW9uX3R5cGUo
KTsNCg0KICAgICAgICBpZiAodHlwZSA8IEhWX0lTT0xBVElPTl9UWVBFX1NOUCB8fCB0eXBlID4g
SFZfSVNPTEFUSU9OX1RZUEVfVERYKQ0KICAgICAgICAgICAgICAgIHJldHVybjsNCg0KICAgICAg
ICBwcl9pbmZvKCJNZW1vcnkgRW5jcnlwdGlvbiBGZWF0dXJlcyBhY3RpdmU6OiAlc1xuIiwNCiAg
ICAgICAgICAgICAgICBodl9tZW1fZW5jX2ZlYXR1cmVzW3R5cGVdKTsNCn0NCg0KVGhhbmtzLA0K
RGV4dWFuDQo=

