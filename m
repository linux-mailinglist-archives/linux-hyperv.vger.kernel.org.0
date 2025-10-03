Return-Path: <linux-hyperv+bounces-7073-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DE0DBB8395
	for <lists+linux-hyperv@lfdr.de>; Fri, 03 Oct 2025 23:41:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7661919C6859
	for <lists+linux-hyperv@lfdr.de>; Fri,  3 Oct 2025 21:42:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB1C3264A86;
	Fri,  3 Oct 2025 21:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="kD1GwwLq"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azolkn19010089.outbound.protection.outlook.com [52.103.10.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC23C2571BD;
	Fri,  3 Oct 2025 21:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.10.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759527702; cv=fail; b=i/q+sHkFczZf7dtq0bjWLst2HfftqpUDdwyIm1Q62WOdwR/cpuPvkealN0RiLBEAXw69KB7y+WJ22iqzl9Si9avB3x9arIG/Sqqyp0xHW7zaZduB84FBRMTkOkxwDTeaRpTSDg/j4jyaB0HydszrGDcZdH+Nl+tDE7Z5JMD+gVQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759527702; c=relaxed/simple;
	bh=58I+vtNPcx1uQgwCp2dbqgcGqW8ynoZ21q/zRjnnUvs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FvMHPckYrRdvdeHxxrj1MaujuhX8HTCtAojA8L8pzarA6nH25s+Bsn3z03lbkreQpCG+7/Q5lAVmrYI8EX0Lu1qRgXepVb3rfE6OmctNg3RtMTXHoa3CJ+EbaqsnxqmVuzoIrEIdJCBgnLr5Kqv+wFGJ5jSS10yEzdKz9iI+dvY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=kD1GwwLq; arc=fail smtp.client-ip=52.103.10.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Kq9/IyufpxM8iKdflPBmzJqrXy8L0ciQ8OzEamG1HIlwjTmYe+twgj2BeCiM9Eg0/U1Yz2Ytf1juJg/DhTZuJ9lO3BstAuwTeps7oLfjP9Qn97AQXl9Cpz0nLZWwOxh1W0YUdzOaTJPxIiTLfyocjf1ffX82wFQcMWDLo9ZQzLXhMsL4JCv4QsJAlozOsEvuVrKuXov0vJ9DWfCKZrDcpyZw+IjH1948LgdYRrrAXEchVC4sRTSTRRKUnD34pdRz8Uv8VJasAm7DVPexcsHA5z09njL9TgJ9HJ3/GnxA7PqdV8JYpSxCJ8980fFEV5So7nBDTnoMqfteRo4R2ogueA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=58I+vtNPcx1uQgwCp2dbqgcGqW8ynoZ21q/zRjnnUvs=;
 b=CX/Emb5NvEsWb82IBND2PFW9tujQQx8KVWIPXVJA1ya8ETyEMnF978XFGHSHTCt1ZMXvRvn14uY317uxPNbAcu6FWBFsHNtVBD5dyJX6WxsBKOKUXox6/9NDe4LmZ6DDUFRyZRjkrIrfrj2sb2DaV6SAGvQwz7L9vWPa8h1EhAb7B6GSeZPHs7pM+68+oSYC3goYcC7ObwXSoOif+4y75T0KLNtMjUlDyDOROdXbivBBjctuacFcpsEr3IhEW5eZeY5whxAZlr/cOXvxYDhhw2pOhguX4k9g9kNzSrVq0jtix6IFe2uMc3unaOJJRLfTWibaxkU6Bld4YwQyaNH2Dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=58I+vtNPcx1uQgwCp2dbqgcGqW8ynoZ21q/zRjnnUvs=;
 b=kD1GwwLqqsLmln2W6A+d1Z60SH9Ml6Pzd0xftwjjdfcBZLf+yco0Hf7ER03Kso5bsre9TrQ+5fyLHmE4RZEU+RH2j5C4ebHiiF1r30iaItA99Fi+ug3K/Q0vD+9cVdDxsftpu/dZ1mXfGErhZ+5kb2RgSkPggSD/NxYpfKzejtsa3Eybefwk7hqa8rVRGRp17lst9pA+DLC1XbN98oZeh1FX9xSfOyQWnpCg8JFqx8fc5tW/DoImLPg6SEA0wGFh+ugGRKKNj8kbyPduEbMQtnC/Z56F5/q8xDNLY9fHLbYr8GQYya+JAIu2h4PCcREiUayP9UqYEqkt1iXFrLtFRA==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by SA3PR02MB10974.namprd02.prod.outlook.com (2603:10b6:806:460::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.18; Fri, 3 Oct
 2025 21:41:38 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%3]) with mapi id 15.20.9160.017; Fri, 3 Oct 2025
 21:41:32 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
CC: "kys@microsoft.com" <kys@microsoft.com>, "haiyangz@microsoft.com"
	<haiyangz@microsoft.com>, "wei.liu@kernel.org" <wei.liu@kernel.org>,
	"decui@microsoft.com" <decui@microsoft.com>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 3/5] Drivers: hv: Batch GPA unmap operations to improve
 large region performance
Thread-Topic: [PATCH v3 3/5] Drivers: hv: Batch GPA unmap operations to
 improve large region performance
Thread-Index: AQHcM7q7gAyul66beU2lfOoL5uqdvLSvjriQgAEV+YCAAEjAEA==
Date: Fri, 3 Oct 2025 21:41:32 +0000
Message-ID:
 <SN6PR02MB415777A957EF622587C54A35D4E4A@SN6PR02MB4157.namprd02.prod.outlook.com>
References:
 <175942263069.128138.16103948906881178993.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
 <175942296162.128138.15731950243504649929.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
 <SN6PR02MB415777407333F3EC40CC05B7D4E4A@SN6PR02MB4157.namprd02.prod.outlook.com>
 <aN__QWQZkXN8k1-V@skinsburskii.localdomain>
In-Reply-To: <aN__QWQZkXN8k1-V@skinsburskii.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|SA3PR02MB10974:EE_
x-ms-office365-filtering-correlation-id: d60efe96-3ba8-45e6-76dd-08de02c59ea1
x-microsoft-antispam:
 BCL:0;ARA:14566002|461199028|13091999003|8060799015|8062599012|19110799012|12121999013|31061999003|41001999006|15080799012|40105399003|440099028|3412199025|102099032;
x-microsoft-antispam-message-info:
 =?utf-8?B?cFZmbDk4YmpvWWNJenZReGc2VFppL3lGenZrVzFPeWdTOERRaE5BdDhWKzFN?=
 =?utf-8?B?ckJtTXRnR1BiazNwTXJFRG5hSW5NbkNpdHl3NTZKb3hGWjdIOEJmU0VwcGg1?=
 =?utf-8?B?aWNLMEpCa1JKZ29uZHAzTXh4ak5aVmpHandGQUw3Y1VJY2tMRTBOZ2cxaXZP?=
 =?utf-8?B?elp4dXhLMUx6M1grRXpUMUNHM2U5dUwwVDFlSmtKTGhySUNpVWVuRDN6bDRZ?=
 =?utf-8?B?SEFYV0lNZ0dEVWxrNS8wZGlHK01wUVA0NjFLbjRJTkV6S2VsWjVFd3pHQUpx?=
 =?utf-8?B?Sm5iZE1vL0RVNC90QkNxUXV2LzJkZlN2L3Y4b3IyRDBVeitabnVjajFrYkRp?=
 =?utf-8?B?Wkl4Vkg4cDdJcUJESk10aUU0eEkvbSt4dHo4SWlqb2RaQVRWQkY3Q0pvNHJt?=
 =?utf-8?B?UVZDMDJ0ZGIxdFkxVHdmOHJXcVkxU2Z4QjhPbFdmRkdiR3lDcC91aGFLSzdP?=
 =?utf-8?B?OVVEUlgyRFJiK3BrM3Z5ZXRFbjJJaXhQNXI5SnVyVUpseTAyTVNtcE9WR2NT?=
 =?utf-8?B?NWkxWS9YWlI2S2NITU85ek5RV2JsNWpOTFB0VEYyN2QzNERISE5XNWxmWTVN?=
 =?utf-8?B?bTdIWkZTQjlUWFhEbzhoSksrZjAydUt4NlJwcHkvZG9oT1lZRDY5MGRrRlpO?=
 =?utf-8?B?WEZCb0NPSEMyVU5xZ05VVmxWaGI4a2RnQzR1WGxsaUZiR2FYYXl1RzZJdlU2?=
 =?utf-8?B?OWFyUUxSelpSWUREcHJTdnIvWlBNdUthcXhhY0VQbGlCdGJyTFFRelR5ZTlm?=
 =?utf-8?B?TjFxMW5ucG1IWjRpS3lwbVNJYlZNQ1VEc1FqeS9iSVNXUTFqVm1LM0VmRkZB?=
 =?utf-8?B?U01zZlU5WFJXVkdZWnYwMWxEWDJhQmNScXRLbThwSytWZXVRUWtVNXZlV29N?=
 =?utf-8?B?dkJWT1N3NjRpQyt3dlBHa3M3eHhWR2RFUHl3UzJ3NEVqZ0lOV2E0YWJIa091?=
 =?utf-8?B?eFpYN2FYb0o0UzBXS3J0QUVKYldRYXE4QUZPMjlBbWtaOEpPS1VNbUxKbGlu?=
 =?utf-8?B?bGN2TUordTFmRE9EckZWUk9GcHYzTGtrbk51amFYajFYaGhQMTZrcVU0ejhJ?=
 =?utf-8?B?OGRyeUFtWjJnUWpxUVJySlptano0MUE4K3ZIKzV5azNEeG04Z3lZNUs1K3FJ?=
 =?utf-8?B?S24xQWZBK2IycVJEWHNPN0I5UTlpYitwaWF2UmRyNjRBWTA0ZnNEOEtQb2Zq?=
 =?utf-8?B?dDNkaVp2R2lWdE81NUVsdXpsNU1RRElSRUhPL3VRTXB4OTA0NU1jTVV3K29k?=
 =?utf-8?B?Wjd4eSsvUDNLMFcranlSNGpZTTlPK3h0dC9JcThXc3VOM3BrL3JqeS9rOEI3?=
 =?utf-8?B?SCtGVjlhM2sycXdvZDJ4emxzbnNwV2t6QUFUTkd3Sk45UEhpRjRzdHZlOWFX?=
 =?utf-8?B?NXhUdnpsZlNWalpsVmduQkV2OUJJaCtrM3dKUzNlb20yYllKWTBrd1dYN3dj?=
 =?utf-8?B?d3ovT1NxMzJFU3dFM1R2M21ZMmJMZGpKZXlYWSszc1h3bGJqN25MclZUZ1NF?=
 =?utf-8?B?dmU5bFhOTzdxSXZiS2xhVmVENlFENVI2RGpTWXFndEsvN0c2Zk0yRVptV1U3?=
 =?utf-8?B?elhuM2R4MG9na2VWaTVJMTQybUo3eThGWEtma3dza3lwNXhUclRqQm95M29K?=
 =?utf-8?Q?Mw/A6g7GOr7QIxrZ2JyFRVqo9H+gAwBokuJOClBvQGe0=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TmtyUG94ejB6QVJ4cU5Uakg5a0wrclAyaDNwR1E2Z2NxNFNTQmJsQm5zUGJv?=
 =?utf-8?B?cFRaNUhiTHo0NDZYQTFlY3hLSE5zLzhVelVRMFdyZ3JoZmFwbnFPeVRVTTJG?=
 =?utf-8?B?WHVrS3R0VjZXS1EwS3ZQdUNBV3dabGw4TDlzRXdMb2xOY3ZxeVlOR3JIcEhU?=
 =?utf-8?B?eEc0Z21CQ3FoYzhrMmlnZzBScjlzSkxtL3VXOTUxVEhmRjZzdmlIclBDazVP?=
 =?utf-8?B?S3RNclg4YlpQUkZkQ3VkZlk2d3htWG5YUGo3dzNubEVIMGF1QTJDNy9xelQy?=
 =?utf-8?B?Mkdic3hZTStDcEpFb05hVDRvdjF4WGI2N2N2WDlSWWo4dyszK2hGWTNCeWxZ?=
 =?utf-8?B?eVVLTy9kWFpiNGg1TE14eEs4OVNkZkFpOVZDYzkzYm93ZXhMd1pHd2l6Y1VS?=
 =?utf-8?B?NlRwL0JxbUNmU1RzbTBZN3h5Z1IyQS9UTENwbExkdjNHd3hmSnkzMlBQMEg5?=
 =?utf-8?B?aEZ2SzF6VmhsS0YyL2x6MzdkalJicDVOMkhuK0g1MDhjcVB6cklNdFU3NlZt?=
 =?utf-8?B?dnU3SzdaazFUemNFRVZmUnZkMW8xcUlTZ2htWDBQK09SVzVBOGZjVXMzRTly?=
 =?utf-8?B?aTJ0RzFkT042VmJYL0UyZUJQYzN1RVB4c1dsaEF4TFhFZEwzaERlTEtYWUtY?=
 =?utf-8?B?MXFMbFZVVmRkT3lKRjRYaExtYkl0NVlzZS9jUU12b05Ia1ZVcmFZN0lFb3JG?=
 =?utf-8?B?RzBDTXlmdTNpa09FcHdjdjRoZFFydXhYd2JUajMwOThvQllLQk9XekkzWXZ4?=
 =?utf-8?B?ZFBGemo3bE1Ya3JSVWNtYnNjTjhwM0xEMFRscGpIdDNDd3phMHRNc2JrY0tq?=
 =?utf-8?B?dXc4cWc0Zkt3RjBlUDVaMXIwMmJlVG9hdXBEVm8xUnZEZ3FPaGxSZWV6elVN?=
 =?utf-8?B?S1RCc2I0WUw3RmZWbC91dkN1VVdxdjZsV3h5UkxTTHQ5Vkc0enE3a0Z1cEdk?=
 =?utf-8?B?VTFWVkpaK1N6eUo3aXE3bzNLSjZ6Q2NyVnd2eitEbGhDMjF1YnFwQ295QnFD?=
 =?utf-8?B?c1dFQ2sydkFLVFkxY2pocG9LU2dCN1daOVVLQnZmempVT1A5RDdtTmhpaU96?=
 =?utf-8?B?c1hLTlFpSlB2ZEQxVmhyNnRQTGZoNkczTTRrTCt0SHZFS0FrWlMydDNBS2lC?=
 =?utf-8?B?NWpkY3VJSU5WL0cwTzRVZVNxdTFKVmc0d1hqd3Z1ZGJTMHhFd0tLNTVJK0FL?=
 =?utf-8?B?UFlRVHc3U2wrdWNmamlHUkt3a1ZyalY3T3hkSUJlQXFzQ3JjMUJUY0hvbHlw?=
 =?utf-8?B?RFVDakxBYlc1WGFLQ0ZMZ2hDTnoxOXNMV2RGWlRvTHRKeS90YU1uNUNtNzIy?=
 =?utf-8?B?MzVUcWZiT29LVWtFb24vaEZ4aTBhcVJRQ3pjZzBLNHhZNHV5b3Bvd1Z1Vmtu?=
 =?utf-8?B?ZXBaMkdDV0NkaStUL25JOVFiNVlxNHNzRHV1dFJxU1RNeDUwSzBJdjQvRXlK?=
 =?utf-8?B?S1VodDBQNGg5Ky9oTEdQbTFDUTRrSTVEalZnRkNuTHo5NzhlV3NuYkRWcS96?=
 =?utf-8?B?MGpmR1RYVXVOU1d2WHd4NUh5YzVlRmc1Zkhvb0JyOEg4bkVBYlZFUzdZWC9H?=
 =?utf-8?B?Y2t4aTVjaTlYTmI5Q0UzeEVSYnpOUEE1T1VUcmV6Q2dqbXpDckZrV3U0R3Jl?=
 =?utf-8?Q?Zi1CmKfbDEGNiONcZOfltBUWZfUiiG56G0EKHPlT34ZI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR02MB4157.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: d60efe96-3ba8-45e6-76dd-08de02c59ea1
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Oct 2025 21:41:32.6051
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR02MB10974

RnJvbTogU3RhbmlzbGF2IEtpbnNidXJza2lpIDxza2luc2J1cnNraWlAbGludXgubWljcm9zb2Z0
LmNvbT4gU2VudDogRnJpZGF5LCBPY3RvYmVyIDMsIDIwMjUgOTo1MiBBTQ0KDQo+IA0KPiBPbiBG
cmksIE9jdCAwMywgMjAyNSBhdCAxMjoyNzoxM0FNICswMDAwLCBNaWNoYWVsIEtlbGxleSB3cm90
ZToNCj4gPiBGcm9tOiBTdGFuaXNsYXYgS2luc2J1cnNraWkgPHNraW5zYnVyc2tpaUBsaW51eC5t
aWNyb3NvZnQuY29tPiBTZW50OiBUaHVyc2RheSwgT2N0b2JlciAyLCAyMDI1IDk6MzYgQU0NCj4g
PiA+DQo+ID4gPiBSZWR1Y2Ugb3ZlcmhlYWQgd2hlbiB1bm1hcHBpbmcgbGFyZ2UgbWVtb3J5IHJl
Z2lvbnMgYnkgYmF0Y2hpbmcgR1BBIHVubWFwDQo+ID4gPiBvcGVyYXRpb25zIGluIDJNQi1hbGln
bmVkIGNodW5rcy4NCj4gPiA+DQo+ID4gPiBVc2UgYSBkZWRpY2F0ZWQgY29uc3RhbnQgZm9yIGJh
dGNoIHNpemUgdG8gaW1wcm92ZSBjb2RlIGNsYXJpdHkgYW5kDQo+ID4gPiBtYWludGFpbmFiaWxp
dHkuDQo+ID4gPg0KPiA+ID4gU2lnbmVkLW9mZi1ieTogU3RhbmlzbGF2IEtpbnNidXJza2lpIDxz
a2luc2J1cnNraWlAbGludXgubWljcm9zb2Z0LmNvbT4NCj4gPiA+IC0tLQ0KPiA+ID4gIGRyaXZl
cnMvaHYvbXNodl9yb290LmggICAgICAgICB8ICAgIDIgKysNCj4gPiA+ICBkcml2ZXJzL2h2L21z
aHZfcm9vdF9odl9jYWxsLmMgfCAgICAyICstDQo+ID4gPiAgZHJpdmVycy9odi9tc2h2X3Jvb3Rf
bWFpbi5jICAgIHwgICAxNSArKysrKysrKysrKystLS0NCj4gPiA+ICAzIGZpbGVzIGNoYW5nZWQs
IDE1IGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pDQo+ID4gPg0KPiA+ID4gZGlmZiAtLWdp
dCBhL2RyaXZlcnMvaHYvbXNodl9yb290LmggYi9kcml2ZXJzL2h2L21zaHZfcm9vdC5oDQo+ID4g
PiBpbmRleCBlMzkzMWIwZjEyNjkzLi45N2U2NGQ1MzQxYjZlIDEwMDY0NA0KPiA+ID4gLS0tIGEv
ZHJpdmVycy9odi9tc2h2X3Jvb3QuaA0KPiA+ID4gKysrIGIvZHJpdmVycy9odi9tc2h2X3Jvb3Qu
aA0KPiA+ID4gQEAgLTMyLDYgKzMyLDggQEAgc3RhdGljX2Fzc2VydChIVl9IWVBfUEFHRV9TSVpF
ID09IE1TSFZfSFZfUEFHRV9TSVpFKTsNCj4gPiA+DQo+ID4gPiAgI2RlZmluZSBNU0hWX1BJTl9Q
QUdFU19CQVRDSF9TSVpFCSgweDEwMDAwMDAwVUxMIC8gSFZfSFlQX1BBR0VfU0laRSkNCj4gPiA+
DQo+ID4gPiArI2RlZmluZSBNU0hWX01BWF9VTk1BUF9HUEFfUEFHRVMJNTEyDQo+ID4gPiArDQo+
ID4gPiAgc3RydWN0IG1zaHZfdnAgew0KPiA+ID4gIAl1MzIgdnBfaW5kZXg7DQo+ID4gPiAgCXN0
cnVjdCBtc2h2X3BhcnRpdGlvbiAqdnBfcGFydGl0aW9uOw0KPiA+ID4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvaHYvbXNodl9yb290X2h2X2NhbGwuYyBiL2RyaXZlcnMvaHYvbXNodl9yb290X2h2X2Nh
bGwuYw0KPiA+ID4gaW5kZXggYzljMjc0ZjI5YzNjNi4uMDY5NjAyNGNjZmUzMSAxMDA2NDQNCj4g
PiA+IC0tLSBhL2RyaXZlcnMvaHYvbXNodl9yb290X2h2X2NhbGwuYw0KPiA+ID4gKysrIGIvZHJp
dmVycy9odi9tc2h2X3Jvb3RfaHZfY2FsbC5jDQo+ID4gPiBAQCAtMTcsNyArMTcsNyBAQA0KPiA+
ID4gIC8qIERldGVybWluZWQgZW1waXJpY2FsbHkgKi8NCj4gPiA+ICAjZGVmaW5lIEhWX0lOSVRf
UEFSVElUSU9OX0RFUE9TSVRfUEFHRVMgMjA4DQo+ID4gPiAgI2RlZmluZSBIVl9NQVBfR1BBX0RF
UE9TSVRfUEFHRVMJMjU2DQo+ID4gPiAtI2RlZmluZSBIVl9VTUFQX0dQQV9QQUdFUwkJNTEyDQo+
ID4gPiArI2RlZmluZSBIVl9VTUFQX0dQQV9QQUdFUwkJTVNIVl9NQVhfVU5NQVBfR1BBX1BBR0VT
DQo+ID4gPg0KPiA+ID4gICNkZWZpbmUgSFZfUEFHRV9DT1VOVF8yTV9BTElHTkVEKHBnX2NvdW50
KSAoISgocGdfY291bnQpICYgKDB4MjAwIC0gMSkpKQ0KPiA+ID4NCj4gPiA+IGRpZmYgLS1naXQg
YS9kcml2ZXJzL2h2L21zaHZfcm9vdF9tYWluLmMgYi9kcml2ZXJzL2h2L21zaHZfcm9vdF9tYWlu
LmMNCj4gPiA+IGluZGV4IDdlZjY2YzQzZTE1MTUuLjhiZjBiNWFmMjU4MDIgMTAwNjQ0DQo+ID4g
PiAtLS0gYS9kcml2ZXJzL2h2L21zaHZfcm9vdF9tYWluLmMNCj4gPiA+ICsrKyBiL2RyaXZlcnMv
aHYvbXNodl9yb290X21haW4uYw0KPiA+ID4gQEAgLTEzNzgsNiArMTM3OCw3IEBAIG1zaHZfbWFw
X3VzZXJfbWVtb3J5KHN0cnVjdCBtc2h2X3BhcnRpdGlvbiAqcGFydGl0aW9uLA0KPiA+ID4gIHN0
YXRpYyB2b2lkIG1zaHZfcGFydGl0aW9uX2Rlc3Ryb3lfcmVnaW9uKHN0cnVjdCBtc2h2X21lbV9y
ZWdpb24gKnJlZ2lvbikNCj4gPiA+ICB7DQo+ID4gPiAgCXN0cnVjdCBtc2h2X3BhcnRpdGlvbiAq
cGFydGl0aW9uID0gcmVnaW9uLT5wYXJ0aXRpb247DQo+ID4gPiArCXU2NCBwYWdlX29mZnNldDsN
Cj4gPiA+ICAJdTMyIHVubWFwX2ZsYWdzID0gMDsNCj4gPiA+ICAJaW50IHJldDsNCj4gPiA+DQo+
ID4gPiBAQCAtMTM5Niw5ICsxMzk3LDE3IEBAIHN0YXRpYyB2b2lkIG1zaHZfcGFydGl0aW9uX2Rl
c3Ryb3lfcmVnaW9uKHN0cnVjdCBtc2h2X21lbV9yZWdpb24gKnJlZ2lvbikNCj4gPiA+ICAJaWYg
KHJlZ2lvbi0+ZmxhZ3MubGFyZ2VfcGFnZXMpDQo+ID4gPiAgCQl1bm1hcF9mbGFncyB8PSBIVl9V
Tk1BUF9HUEFfTEFSR0VfUEFHRTsNCj4gPiA+DQo+ID4gPiAtCS8qIGlnbm9yZSB1bm1hcCBmYWls
dXJlcyBhbmQgY29udGludWUgYXMgcHJvY2VzcyBtYXkgYmUgZXhpdGluZyAqLw0KPiA+ID4gLQlo
dl9jYWxsX3VubWFwX2dwYV9wYWdlcyhwYXJ0aXRpb24tPnB0X2lkLCByZWdpb24tPnN0YXJ0X2dm
biwNCj4gPiA+IC0JCQkJcmVnaW9uLT5ucl9wYWdlcywgdW5tYXBfZmxhZ3MpOw0KPiA+ID4gKwlm
b3IgKHBhZ2Vfb2Zmc2V0ID0gMDsgcGFnZV9vZmZzZXQgPCByZWdpb24tPm5yX3BhZ2VzOyBwYWdl
X29mZnNldCsrKSB7DQo+ID4gPiArCQlpZiAoIXJlZ2lvbi0+cGFnZXNbcGFnZV9vZmZzZXRdKQ0K
PiA+ID4gKwkJCWNvbnRpbnVlOw0KPiA+ID4gKw0KPiA+ID4gKwkJaHZfY2FsbF91bm1hcF9ncGFf
cGFnZXMocGFydGl0aW9uLT5wdF9pZCwNCj4gPiA+ICsJCQkJCUFMSUdOKHJlZ2lvbi0+c3RhcnRf
Z2ZuICsgcGFnZV9vZmZzZXQsDQo+ID4gPiArCQkJCQkgICAgICBNU0hWX01BWF9VTk1BUF9HUEFf
UEFHRVMpLA0KPiA+DQo+ID4gU2VlbXMgbGlrZSB0aGlzIHNob3VsZCBiZSBBTElHTl9ET1dOKCkg
aW5zdGVhZCBvZiBBTElHTigpLiAgQUxJR04oKSByb3VuZHMNCj4gPiB1cCB0byBnZXQgdGhlIHJl
cXVlc3RlZCBhbGlnbm1lbnQsIHdoaWNoIGNvdWxkIHNraXAgb3ZlciBzb21lIG5vbi16ZXJvDQo+
ID4gZW50cmllcyBpbiByZWdpb24tPnBhZ2VzW10uDQo+ID4NCj4gDQo+IEluZGVlZCwgdGhlIGdv
YWwgaXMgdG8gdW5tYXAgaW4gMk1CIGNodW5rcyBhcyBpdCdzIHRoZSBtYXggcGF5bG9hZCB0aGF0
DQo+IGNhbiBiZSBwYXNzZWQgdG8gaHlwZXJ2aXNvci4NCj4gSSdsbCByZXBsYWNlIGl0IHdpdGgg
QUxJR05fRE9XTiBpbiB0aGUgbmV4dCByZXZpc2lvbi4NCj4gDQo+ID4gQW5kIEknbSBhc3N1bWlu
ZyB0aGUgdW5tYXAgaHlwZXJjYWxsIGlzIGlkZW1wb3RlbnQgaW4gdGhhdCBpZiB0aGUgc3BlY2lm
aWVkDQo+ID4gcGFydGl0aW9uIFBGTiByYW5nZSBpbmNsdWRlcyBzb21lIHBhZ2VzIHRoYXQgYXJl
bid0IG1hcHBlZCwgdGhlIGh5cGVyY2FsbA0KPiA+IGp1c3Qgc2tpcHMgdGhlbSBhbmQga2VlcHMg
Z29pbmcgd2l0aG91dCByZXR1cm5pbmcgYW4gZXJyb3IuDQo+ID4NCj4gDQo+IEl0IG1pZ2h0IGJl
IHRoZSBjYXNlLCBidXQgaXQncyBub3QgcmVsaWFibGUuDQo+IElmIHRoZSByZWdpb24gc2l6ZSBp
c27igJl0IGFsaWduZWQgdG8gTVNIVl9NQVhfVU5NQVBfR1BBX1BBR0VTIChpLmUuLCBub3QNCj4g
YWxpZ25lZCB0byAyTSksIHRoZSBoeXBlcnZpc29yIGNhbiByZXR1cm4gYW4gZXJyb3IgZm9yIHRo
ZSB0cmFpbGluZw0KPiBpbnZhbGlkIChub24temVybykgUEZOcy4NCj4gSeKAmWxsIGZpeCB0aGlz
IGluIHRoZSBuZXh0IHJldmlzaW9uLg0KPiANCj4gPiA+ICsJCQkJCU1TSFZfTUFYX1VOTUFQX0dQ
QV9QQUdFUywgdW5tYXBfZmxhZ3MpOw0KPiA+ID4gKw0KPiA+ID4gKwkJcGFnZV9vZmZzZXQgKz0g
TVNIVl9NQVhfVU5NQVBfR1BBX1BBR0VTIC0gMTsNCj4gPg0KPiA+IFRoaXMgdXBkYXRlIHRvIHRo
ZSBwYWdlX29mZnNldCBkb2Vzbid0IHRha2UgaW50byBhY2NvdW50IHRoZSBlZmZlY3Qgb2YgdGhl
DQo+ID4gQUxJR04gKG9yIEFMSUdOX0RPV04pIGNhbGwuICBXaXRoIGEgY2hhbmdlIHRvIEFMSUdO
X0RPV04oKSwgaXQgbWF5DQo+ID4gaW5jcmVtZW50IHRvbyBmYXIgYW5kIHBlcmhhcHMgY2F1c2Ug
dGhlICJmb3IiIGxvb3AgdG8gYmUgZXhpdGVkIHByZW1hdHVyZWx5LA0KPiA+IHdoaWNoIHdvdWxk
IGZhaWwgdG8gdW5tYXAgc29tZSBvZiB0aGUgcGFnZXMuDQo+ID4NCj4gDQo+IEnigJltIG5vdCBz
dXJlIEkgc2VlIHRoZSBwcm9ibGVtIGhlcmUuICBJZiB3ZSBhbGlnbiB0aGUgb2Zmc2V0IGJ5DQo+
IE1TSFZfTUFYX1VOTUFQX0dQQV9QQUdFUyBhbmQgdW5tYXAgdGhlIHNhbWUgbnVtYmVyIG9mIHBh
Z2VzLCB0aGVuIHdlDQo+IHNob3VsZCBpbmNyZW1lbnQgdGhlIG9mZnNldCBieSB0aGF0IHZlcnkg
c2FtZSBudW1iZXIsIHNob3VsZG7igJl0IHdlPw0KDQpIZXJlJ3MgYW4gZXhhbXBsZSBzaG93aW5n
IHRoZSBwcm9ibGVtIEkgc2VlIChhc3N1bWluZyBBTElHTl9ET1dODQppbnN0ZWFkIG9mIEFMSUdO
KToNCg0KMSkgRm9yIHNpbXBsaWNpdHkgaW4gdGhlIGV4YW1wbGUsIGFzc3VtZSByZWdpb24tPnN0
YXJ0X2dmbiBpcyB6ZXJvLg0KMikgRW50cmllcyAwIHRocnUgMyAoaS5lLiwgNCBlbnRyaWVzKSBp
biByZWdpb24tPnBhZ2VzW10gYXJlIHplcm8uDQozKSBFbnRyaWVzIDQgdGhydSA1MTUgKHRoZSBu
ZXh0IDUxMiBlbnRyaWVzKSBhcmUgbm9uLXplcm8uDQo0KSBFbnRyaWVzIDUxNiB0aHJ1IDEwMjMg
KHRoZSBuZXh0IDUwOCBlbnRyaWVzKSBhcmUgemVyby4NCjUpIEVudHJpZXMgMTAyNCB0aHJ1IDE1
MzUgKHRoZSBsYXN0IDUxMiBlbnRyaWVzKSBhcmUgbm9uLXplcm8uDQoNClVwb24gZW50ZXJpbmcg
dGhlICJmb3IiIGxvb3AgZm9yIHRoZSBmaXJzdCB0aW1lLCBwYWdlX29mZnNldCBnZXRzDQppbmNy
ZW1lbnRlZCB0byA0IGJlY2F1c2Ugb2Ygc2tpcHBpbmcgZW50cmllcyAwIHRocnUgMyB0aGF0IGFy
ZSB6ZXJvLg0KT24gdGhlIG5leHQgaXRlcmF0aW9uIHdoZXJlIHBhZ2Vfb2Zmc2V0IGlzIDQsIHRo
ZSBoeXBlcmNhbGwgaXMgbWFkZSwNCnBhc3NpbmcgMCBmb3IgdGhlIGdmbiAoYmVjYXVzZSBvZiBB
TElHTl9ET1dOKSwgd2l0aCBhIGNvdW50IG9mDQo1MTIsIHNvIGVudHJpZXMgMCB0aHJ1IDUxMSBh
cmUgdW5tYXBwZWQuIEVudHJpZXMgMCB0aHJ1IDMgYXJlIHZhbGlkDQplbnRyaWVzLCBhbmQgdGhl
IGZhY3QgdGhhdCB0aGV5IGFyZW4ndCBtYXBwZWQgaXMgcHJlc3VtYWJseSBpZ25vcmVkDQpieSB0
aGUgaHlwZXJjYWxsLCBzbyBldmVyeXRoaW5nIHdvcmtzLg0KDQpUaGVuIHBhZ2Vfb2Zmc2V0IGlz
IGluY3JlbWVudGVkIGJ5IDUxMSwgc28gaXQgd2lsbCBiZSA1MTUuIENvbnRpbnVpbmcNCnRoZSAi
Zm9yIiBsb29wIGluY3JlbWVudHMgcGFnZV9vZmZzZXQgdG8gNTE2LiBUaGUgemVybyBlbnRyaWVz
IDUxNg0KdGhydSAxMDIzIGluY3JlbWVudCBwYWdlX29mZnNldCB0byAxMDI0LiBGaW5hbGx5IHRo
ZSBoeXBlcmNhbGwgaXMgbWFkZQ0KYWdhaW4gY292ZXJpbmcgZW50cmllcyAxMDI0IHRocnUgMTUz
NSwgbm9uZSBvZiB3aGljaCBhcmUgemVyby4NCg0KQnV0IG5vdGljZSB0aGF0IGVudHJpZXMgNTEy
IHRocnUgNTE1ICh3aGljaCBhcmUgbm9uLXplcm8pIGdvdCBza2lwcGVkLg0KVGhhdCdzIGJlY2F1
c2UgdGhlIGZpcnN0IGludm9jYXRpb24gb2YgdGhlIGh5cGVyY2FsbCBjb3ZlcmVkIG9ubHkgdGhy
b3VnaA0KZW50cnkgNTExLCB3aGlsZSBwYWdlX29mZnNldCB3YXMgaW5jcmVtZW50ZWQgdG8gNTE1
LiBwYWdlX29mZnNldA0Kc2hvdWxkIGhhdmUgYmVlbiBzZXQgdG8gNTExLCBzaW5jZSB0aGF0J3Mg
dGhlIGxhc3QgZW50cnkgcHJvY2Vzc2VkIGJ5DQp0aGUgZmlyc3QgaW52b2NhdGlvbiBvZiB0aGUg
aHlwZXJjYWxsLg0KDQpNaWNoYWVsDQo=

