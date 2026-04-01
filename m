Return-Path: <linux-hyperv+bounces-9869-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iL9BIcc7zWn5awYAu9opvQ
	(envelope-from <linux-hyperv+bounces-9869-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 01 Apr 2026 17:37:43 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 44B9637D413
	for <lists+linux-hyperv@lfdr.de>; Wed, 01 Apr 2026 17:37:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EBF5A3005172
	for <lists+linux-hyperv@lfdr.de>; Wed,  1 Apr 2026 15:23:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B62F329B78F;
	Wed,  1 Apr 2026 15:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="Yw4RC5NV"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from SY2PR01CU004.outbound.protection.outlook.com (mail-australiaeastazolkn19011062.outbound.protection.outlook.com [52.103.72.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 657DD337688;
	Wed,  1 Apr 2026 15:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.72.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775056996; cv=fail; b=N6fLaJU0qxXk99CZuJKh7D/quNMFJCI8skRZQdS8dHeXym4XMI1Rcr1Jqa8SUx02qqA3wd+r6LuuTcMK51xO8BfF8zTTrZcwbmH61tnLCcKsVjFfYUlkOwC+CGRfrZqppEGCRRrptjGxPQFlwiV8eI0uDZyct/r8PQyhg3FB9jM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775056996; c=relaxed/simple;
	bh=wTXNLxDe+QqdanQlrDJHB0slkJSPCeVup26Bdr34VKQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Kjf3ZfB6O8eFV8uGvyUUrFn5m2G7Ba1doBDu4ezB+nqHZ9BtE2BOAmQgknw1UOVUXbk4fHChNpr+qvbLCEvWeVMS82fJrblxcj2+THYm3WsjKaPHekNM+Oc6Y1B1JWaoY2LJU/usQxbCI1MDcxyuZXIdnpAOpoKPpUBQoBATonE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=Yw4RC5NV; arc=fail smtp.client-ip=52.103.72.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ENYylQuGgL58Rk80Stuh2nP06rEDxP2/n3d12W5nJlMCIDdwgnuOpiFprV+B9Pw+IeuqyWVxkKf5UvSk9wwSYxdccmD+gU0rZozhjtz8EcOrs6c4iu+oAXqJwDNaBOQKKT2mEYVLrJtXRPs9g4sJauxIalV2WUBQubwkMW3/ssCbYj/nwwBPw74QO0pwkkx0qpbCEloe59UqFjG/2/W0SPKP3LkpeQssTjfj6Bmx7BgAttn7G8LXyiqfV8N4GA9k+FWOUADIXvvAdbkpDSvGOo9CPTtmPdwOo2zJTZBYElMrZQctk3L1a0/eigff7uau6IWYzWO/RTSkoKY4uKS4gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wTXNLxDe+QqdanQlrDJHB0slkJSPCeVup26Bdr34VKQ=;
 b=c+FJZNf61xG6XIPmdEVa0dGGmQZ6lCXm5/Lr+i+Bnu00/NCXZWRjbkMeG1Uq69NHgt/TZoJ5n1cLWjJPkqQbZnC+M57A/xdV8EVCXfOxgCFwwBxOU8TFKH3Y/zJjvuMdh93Qcb92cwl0uE81Ep3p3vPXY4wjopQ4XneNr37jqyCwjEMDXA/feRltJjbKKD9SBlJgp0/5jbk6tjyechkzWSiAFBlTofmsW9EI7TlC1c7oYmrOXZHTJmK2l4KTqGNY53POY/8dIUZR2iGi727KtV1TidvqIxDmsBGPCCn4a/RpDV1+pG21kuYEBWMtCo/7ptf9f5ze8ONzJPAqrAwWcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wTXNLxDe+QqdanQlrDJHB0slkJSPCeVup26Bdr34VKQ=;
 b=Yw4RC5NVIOEKNAayVgSwPPvfaulqg09hGA0xtXY9engN5rixIeykaCeIax/ceSS73SXu1WTuvbtwMzDnXRleA3UDYeRqFyGsnwbPr76XeGh+FCCk0oceyE46Odtpap1MdvZi+fgUpRsK+GdUR/yETkPXHplH1I8qHdZO4WSHbUGDPfx/IbJrmuL3LeAwENYv9jTUVBPariJdnOE+bTQ2a45VwufX2xTyxzq50UZr2nEZeS8qvsA0M+tb3ZeTSVFTYWvM+z4aN3va2njighs5gt+TQjHVh9KyGOmTppqN9C+HmHq9eDE7yCRH23sJYpVVYbaprm75ymOb529NF1ob5Q==
Received: from SYBPR01MB7881.ausprd01.prod.outlook.com (2603:10c6:10:1b0::5)
 by ME3PR01MB7761.ausprd01.prod.outlook.com (2603:10c6:220:130::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.20; Wed, 1 Apr
 2026 15:23:09 +0000
Received: from SYBPR01MB7881.ausprd01.prod.outlook.com
 ([fe80::7cd2:d6e8:3fa0:5f0c]) by SYBPR01MB7881.ausprd01.prod.outlook.com
 ([fe80::7cd2:d6e8:3fa0:5f0c%5]) with mapi id 15.20.9769.017; Wed, 1 Apr 2026
 15:23:08 +0000
From: Junrui Luo <moonafterrain@outlook.com>
To: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
CC: "K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang
	<haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan Cui
	<decui@microsoft.com>, Long Li <longli@microsoft.com>, Nuno Das Neves
	<nunodasneves@linux.microsoft.com>, Anirudh Rayabharam
	<anrayabh@linux.microsoft.com>, Mukesh Rathor <mrathor@linux.microsoft.com>,
	Muminul Islam <muislam@microsoft.com>, Praveen K Paladugu
	<prapal@linux.microsoft.com>, Jinank Jain <jinankjain@microsoft.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Yuhao Jiang
	<danisjiang@gmail.com>, Roman Kisel <romank@linux.microsoft.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH v2] Drivers: hv: mshv: fix integer overflow in memory
 region overlap check
Thread-Topic: [PATCH v2] Drivers: hv: mshv: fix integer overflow in memory
 region overlap check
Thread-Index: AQHcvpRNbg/7iVrB0UyyX/rVQKTUD7XHlxCAgALCnAA=
Date: Wed, 1 Apr 2026 15:23:08 +0000
Message-ID: <06E66507-832A-4DCC-A410-60676B31EEAE@outlook.com>
References:
 <SYBPR01MB788138A30BC69B0F5C3316E5AF54A@SYBPR01MB7881.ausprd01.prod.outlook.com>
 <acrnkcG5_u0RCydx@skinsburskii.localdomain>
In-Reply-To: <acrnkcG5_u0RCydx@skinsburskii.localdomain>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SYBPR01MB7881:EE_|ME3PR01MB7761:EE_
x-ms-office365-filtering-correlation-id: cb8a1bcc-8df8-4deb-a154-08de90029427
x-microsoft-antispam:
 BCL:0;ARA:14566002|461199028|51005399006|19110799012|24121999003|22091999003|12121999013|8062599012|15080799012|8060799015|31061999003|40105399003|3412199025|440099028|102099032|26121999003;
x-microsoft-antispam-message-info:
 =?utf-8?B?OEk2OFdWYWx5T0p5ZTRDMkNaRVIrOHFlL05VVGo2R3pDZk5NaDNleDMvK1BN?=
 =?utf-8?B?VFFlcUF0bDhsY2lQZWozYzhjd3F1S2ZDeVhic1NHQ0p4SVpESEdrdm9yZ25q?=
 =?utf-8?B?bjN1a2ExeE1Ib3VYcmIzUE8yYTlFT1k3N0w4Tk1MakptTkZadVJJTlU2dk1i?=
 =?utf-8?B?UCtIdHFXWWdrQ3lOSml1TlVzOSthRXpFcU1YcGNKNHVxNlhMS1NYdVZnRnoy?=
 =?utf-8?B?TkduSFY4Mnl4NnVHdFJOdXViM2pTMkFVWFAySU12dHZTODRRSXRGbFRiMjhi?=
 =?utf-8?B?NGZUQSsyQzhCS2M5a0ZpRVNHb3RFUEovcHRJU3hYbVE5Nm1xWWxhQnBmVTJz?=
 =?utf-8?B?TldTeTE2RXhBMkVnemluZGwvS1JzdTh4cVJadzlTbDdOVjdlNld4T08vdmJn?=
 =?utf-8?B?WnBSbldFajJqSHRpa2o0OG1FdmlkbkJZMXMremlBWWd2N3VqNGpaTE94VVo0?=
 =?utf-8?B?cThXK21lN2QwbDVIcXpMUzE0MFVyY0U2dzVwV3U5TnB1TXR2UzdhZlFyZmxD?=
 =?utf-8?B?WDk4Vlc2YVFCVmVzSTBSdUhFYitnS2g4WFpLSjR5MGgvRmVRTWdVSVl2blpO?=
 =?utf-8?B?Y1dIY25vQXZxQUM4VW9tZ2I2dStuQ3lhM0JHWFlmL2tYUjlXSm9wWEg1ZFpw?=
 =?utf-8?B?R0dDVkxLaW5La1dWS1JNWGN1bFJzVUhacEwzYWJLZjNZUW1IWlpTN3oxMGw2?=
 =?utf-8?B?Wks0cE50eG10eWRmdkFPY2tONDVkcnk1QXBETjN4Y1UwUTFVb0k5YmV3amwz?=
 =?utf-8?B?Nzg2clJEN3loSlZnSlU2TlFZaFhnZUJkMVVmNHlHb1pwUy9lVU1lSTMyVnVO?=
 =?utf-8?B?YmRrYWVyaDhja29rR09SeTAwS0pJM3BpejJ4VWhmR3lGblpNbi8vQXJXOTYx?=
 =?utf-8?B?MG9GZldYVk9Oc3g1N1RuUzVvZFFjTVhaWU54SVUyVEJIR25kWmRKQzdOdTRU?=
 =?utf-8?B?TUVXTHl2cXJkQVlNTlBSQSt0ZDFNdjVydHd1M1o0aVg5WmMvRjhDbWc1WnBP?=
 =?utf-8?B?TFkxNXBLWVkrQW92WEhPSkFER3V0ZmRUbEFYOVBGMUJuZk5Gb2M2WDZLQTZW?=
 =?utf-8?B?TUpRaGNGbklKVmNMYUlVeHFYSlV4R2FFL1NFQzVQL0F3Y1N1ak5xRnJmeW9s?=
 =?utf-8?B?M2UvRWY2OUMwdE5hdEFSaVRZdENPajJEdm00SDAwRnVYQlM2VVVUeEo1ejl4?=
 =?utf-8?B?M3QxMDlJSTM5WTNPWmhrWHJsU3AyUkJicktGY1U4bTlHU2ZKVGlGdlpIRHV5?=
 =?utf-8?B?UWtEYW9RZXlWMjMzci9seHIxMmJFbkRvN3VYWTVLeEFsOWpBb2JzZG80akZC?=
 =?utf-8?B?NDluL0tyTXh3cW5ycjYyM2lWZk9RcHBHTjhvenNablQ1SGRhMmh5SlBsdCtB?=
 =?utf-8?Q?1/CkdqliLWM/sJgdxnfkdC68Muqn86H0=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SHdUWEo3TUp5WmxNM0lkT1JFcGhXU21uRUYxL3g1TGt6MS8zY0xZT0g0Q0Vv?=
 =?utf-8?B?THNNU1FUYWVXaHRuZXYzendqY3c5aFdEdi9JTTBpbzlCSHhhRi94RlVZQklh?=
 =?utf-8?B?dW5raTZrUXNsQ0VnZlREVXFDYThqSGZ3U2cvVS9nOE9EeC9EL0R0eWZGakU3?=
 =?utf-8?B?cmdBVkUvQkkwT3hqQ0xlZmVPTm1jUGorWmhCNlN5WUJ2V0h0dmlkRnZiZGd1?=
 =?utf-8?B?UzVIdVVnVGQvMnRpRXVKVU9uR2pncVJxK0JGUUJiRkhUTU1odkhrR1pJTEY0?=
 =?utf-8?B?SVlPb3JQdnB4NzVISEhoakQrdVkzK2FJWWJKYW5uNmdwY0p0RVBDeDYrTUF4?=
 =?utf-8?B?R1dZcWg0MEtVMHB4R3ZGb0UvQmZFKyt0amw0cFBSaGhST0pUN1ZuWmtDN2lq?=
 =?utf-8?B?NnkzUWswUW1hWXBEb0dGWTkvWTJCQ2N3REUxbmgxYytobFprYXlzQzgvakNL?=
 =?utf-8?B?UmhCY2NTbXZqWWVmdnlONGE3M0VOSTVSU1FiWU0yZ21zWCtScDhqM2s0WVc4?=
 =?utf-8?B?aHJVTmZSQlhWL2VOZWJEZzl4czVCK1NZUXBmYXhiT056N2pNTTJpS016N1hF?=
 =?utf-8?B?bXpmbEpCRTc1UkVqVmlpTGdZakJzOXBBd1VVek1GT3NTR01yTHBySHQyQy9l?=
 =?utf-8?B?RmJ1V0dhbVl6dWFPZGdNc2pLZVhCb2lOVzNVWjAvTnZKODMrNE5ieFVrTTVy?=
 =?utf-8?B?NW1qQ29tdDhja1VYUmJBQ1JFT1BhYnBuenh0Z2pFaWNpbWdvUGJ2SEJzRHhO?=
 =?utf-8?B?bVM3aFFDUE9YblNoUWVDcVVYdFNMYlNFTENlSFNVaTR3amlJVzBsbGFzNVps?=
 =?utf-8?B?SmZqdW9iMnlSWUxQMGY2dmhFMnRsUmpQR2hSWExMUWpBQkJRcm11enZUOFRr?=
 =?utf-8?B?bnpBeVhUbXpMckFOblRWV2VweVRTZlkxc2FCV3JFbVRRamNWQ3F1ZzY5Z1da?=
 =?utf-8?B?YTRYMVJyL2VqcVJ5eVlYcTJvVG1OVm9YRTdxZk85MlFkRVIwVURaZmw5Y2Qv?=
 =?utf-8?B?MTZoMmx0RUpid0JFTGI2OEo1WTNBS2JTN0o1THFEdHJCalhDRDFOT2gzQ1Zu?=
 =?utf-8?B?Q0tTNjVpeHF0ZEhzMUw5cTR5MGhVZkI1N1padU1KUHl4bmMyeEdldmRMeERa?=
 =?utf-8?B?Y25hdzdKOGw2WVFpaGEwSzNRYXo4N2FMdTNlYmRjM1pIa05vejA2Z05jcEth?=
 =?utf-8?B?U2lxbU9xUFFqejhxQjdPL2xsS21hUXhmbzBqeGg1SGwzZThQWll1b3pSNVE4?=
 =?utf-8?B?emxFUzV4QXVVT054Z1AxYlhOUzJweHZqVFZWMVNyRE5vdU5wTUk1T1FXWGNv?=
 =?utf-8?B?Ui81cTZINlZqR1B4Ymg5eWRORlJMUUFjOGtleXJUV2JudWJHU21BU3VmYmE0?=
 =?utf-8?B?VnhQVzdNTzBJTmNkYmhyMFBnV01kbnpOWmpmUy9FNUhrQk8yc0JLbnplRUVB?=
 =?utf-8?B?OHFxNnhqQnNib0ZGdEtkbE5FeXQ1MUpPMEVBYnM4ZUlURmVHSFM3UjVhWkZP?=
 =?utf-8?B?a2Jmc01Jd0NSbEQ4LzRUdUxGUXNaTHpFZnk0Q0piREdxY2lwVHNTN05MOEt5?=
 =?utf-8?B?WEF2L1dmZVpnUWpIR3JWcWRyNXNPTklhR041cnNXY2dqelE0bENQdHhBQlJP?=
 =?utf-8?B?TEYwWXpMNWFkNllIQmlZcGNVZDRCcEhwemUvcjNkcngrWXpBeUVIVWVHWWUy?=
 =?utf-8?B?dlZDdU1ydVZoQTdwdGVWVWMyb3o0QmhyTDR3YXRhdmZBdjNXUm9odjlnUDhx?=
 =?utf-8?B?OW1kbjRlbFU3cmdjY1JrWm85dVpDem1HUnN0SHJnazdIckhjcXgya2dMYVBZ?=
 =?utf-8?B?YUNuTjh4L2NyZHYrWkZSUzlTU2Jzc1BDWkVISVhMUko0a0NQWjFVV2dUSW5v?=
 =?utf-8?B?WXdIdEhjTG1MRjd0Wk9NSngvcmh1cnpHaFhBT2xiNFQ0Ync9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <04E91DB2BC0B5149BEE0F9CC8D1E609F@ausprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SYBPR01MB7881.ausprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: cb8a1bcc-8df8-4deb-a154-08de90029427
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2026 15:23:08.2976
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ME3PR01MB7761
X-Spamd-Result: default: False [-0.06 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[outlook.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[outlook.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[outlook.com];
	TAGGED_FROM(0.00)[bounces-9869-lists,linux-hyperv=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[17];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_CC(0.00)[microsoft.com,kernel.org,linux.microsoft.com,vger.kernel.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[moonafterrain@outlook.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[outlook.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-hyperv];
	MID_RHS_MATCH_FROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,outlook.com:dkim,outlook.com:mid]
X-Rspamd-Queue-Id: 44B9637D413
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

SGkgU3RhbmlzbGF2LA0KDQpUaGFua3MgZm9yIHRoZSByZXZpZXcuDQoNCk9uIE1vbiwgTWFyIDMw
LCAyMDI2IGF0IDAyOjEzOjUzUE0gLTA3MDAsIFN0YW5pc2xhdiBLaW5zYnVyc2tpaSB3cm90ZToN
Cj4gTWlub3Igbml0OiBqdXN0ICJlbmQiIG9yIGV2ZW4gInRtcCIgd291bGQgYmUgc3VmZmljaWVu
dCwgc2luY2UgaXQncyBvbmx5DQo+IHVzZWQgZm9yIHRoZSBvdmVyZmxvdyBjaGVja3MuICJuZXdf
cmVnaW9uX2VuZCIgaXMgYSBiaXQgdmVyYm9zZSBhbmQgaXQncw0KPiBub3QgcmVhbGx5ICJuZXci
IHBlciBzZS4NCg0KSSB3aWxsIHJlbmFtZSBpdCB0byDigJxyZWdpb25fZW5kIiBpbiB2My4NCg0K
PiBUaGlzIGlzIGEgUEZOLCBzbyB0aGUgY2hlY2sgc2hvdWxkIGJlIGFnYWluc3QgTUFYX1BIWVNN
RU1fQklUUyAtDQo+IFBBR0VfU0hJRlQsIHJpZ2h0Pw0KDQpIVlBGTl9ET1dOKCkgaXMgZGVmaW5l
ZCBhcyAoeCkgPj4gSFZfSFlQX1BBR0VfU0hJRlQsIHNvDQpIVlBGTl9ET1dOKDFVTEwgPDwgTUFY
X1BIWVNNRU1fQklUUykgYWxyZWFkeSBleHBhbmRzIHRvDQoxVUxMIDw8IChNQVhfUEhZU01FTV9C
SVRTIC0gSFZfSFlQX1BBR0VfU0hJRlQpLg0KDQpUaGFua3MsDQpKdW5ydWkgTHVvDQoNCg==

