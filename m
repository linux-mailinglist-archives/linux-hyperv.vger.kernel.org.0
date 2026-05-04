Return-Path: <linux-hyperv+bounces-10616-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oO/TI90Y+Wlc5gIAu9opvQ
	(envelope-from <linux-hyperv+bounces-10616-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 05 May 2026 00:08:29 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F1C864C44B8
	for <lists+linux-hyperv@lfdr.de>; Tue, 05 May 2026 00:08:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B9B5E301A717
	for <lists+linux-hyperv@lfdr.de>; Mon,  4 May 2026 22:07:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 641BA37BE80;
	Mon,  4 May 2026 22:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="abdAyxIh"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11021086.outbound.protection.outlook.com [40.93.194.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 724FF37B02B;
	Mon,  4 May 2026 22:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777932477; cv=fail; b=CyPsrD6TgMu20QqBdvYtanO0Ijld4yA4o5+v/zGptiZD9NXdFvuM66B3zRTPX2iwLAJ4CR5fDtrr+UEMLsYvaw0RKsDYWsJarHoSNIzM0dzTXCuVUmkYDOMtUJufvKGVjxALrhYubAs7yR+uEozGNdQgN62yRZdwf3+51Su7NY0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777932477; c=relaxed/simple;
	bh=DbXFcCMoFUwXG/SlEWK/2IytPPiVc/6BDYCZbGSkTJk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lNOBPdZP/RapmTr35dQFpK2t25AVlWtuWc1XLSRtCvgiBZ5xgxS8vORk4b1P20YFH8TcBFEN2hZdfusghU46FpNyugZ+at2rPcQSvZOLNu1CFAK6TvM2Q4IUacgclr3oRtWXApowES8I7FLcsNf5pcZa/3j2dIixfI36C/HE59o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=abdAyxIh; arc=fail smtp.client-ip=40.93.194.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LeIG5Kyibx6bNgMQhdRWk5l/Pzqtv9Ct6kXRhsgvcUaPnOpOHjZgbENXkdD+L4XEvtOn/+ehCsIZBQ4IbSlushnWum7ownYl+PwmqbYEGJIPn4sLOcg2t17oMKDsokw6pHjRejPiLeUuZ7aWSlG+FbP5BGPRHn53JSyWLcl15kkoVjSAHEj5fpOOtr0a8ZXvgR1AxcV9DFGHxiHSWsDO1eXZGTjHQB6lHQKe8ORnq+g9BDlE10Iwdy5uALCrBBkE/qae+nUPYL2U8Gdm2yUAEMwVIcBsamVnPffXQiF5vpD9XX/r2oypkEkBa5zL9U8qr2ItCnfM/vbST45sL/6h9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OHFwSX0El89HFRhkVFsG8j9W80SA7ef+XtWHC7rg5as=;
 b=PMqU2FV1kGz/QYVW9C0wvFWNftSPrX/ICz4SCc0FUZ4nhXLlqRvTfe+RdnyRRazJS0Xzai5i+23JDjR1HvGhPsE5v3hZWNMnWtlkXYt4fOukAgjNpJnRbQXDg6udqX/lqqRGHxET/vaGuIbl0KuzODuyCbJhzRKW3h9Eg0Qcm40W6Ol7e0/Zn04a/M9DGUBL5su5BzNxL+VpkyanEoyRWblZw+TS/RMoHiclEqEWl+U0sUTpCjzbz+rkElnvML8j6YLlIuWDNcKD1N9M7gQEvbv6flxFjom0t/jmFbOJy8X2Y45xspldIR48k3bLVKVWPWQat0yx4jOrIPftfQuJ9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OHFwSX0El89HFRhkVFsG8j9W80SA7ef+XtWHC7rg5as=;
 b=abdAyxIhwGuH3Yt/vamw0TAgusd65bLPtN1cuHkboCfwmWJ4GlWvpcBmL/NPnb0jsqjQiOWsJeo6v+TI78Gc7rmffblK6F/dIhE3oLazHo7GlMKYwHQqizd9KR3rf0nsoFDmUwWakEVXWcQK45VTa3iviaGJOki6qk+U3iOajgY=
Received: from SA1PR21MB6683.namprd21.prod.outlook.com (2603:10b6:806:4a4::6)
 by SA1PR21MB6368.namprd21.prod.outlook.com (2603:10b6:806:4a9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.3; Mon, 4 May
 2026 22:07:52 +0000
Received: from SA1PR21MB6683.namprd21.prod.outlook.com
 ([fe80::879f:eec1:ca0e:d219]) by SA1PR21MB6683.namprd21.prod.outlook.com
 ([fe80::879f:eec1:ca0e:d219%6]) with mapi id 15.20.9891.008; Mon, 4 May 2026
 22:07:52 +0000
From: Long Li <longli@microsoft.com>
To: Simon Horman <horms@kernel.org>
CC: Konstantin Taranov <kotaranov@microsoft.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "davem@davemloft.net" <davem@davemloft.net>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "edumazet@google.com"
	<edumazet@google.com>, "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"jgg@ziepe.ca" <jgg@ziepe.ca>, "leon@kernel.org" <leon@kernel.org>, Haiyang
 Zhang <haiyangz@microsoft.com>, KY Srinivasan <kys@microsoft.com>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>, Dexuan Cui <DECUI@microsoft.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [EXTERNAL] Re: [PATCH net-next v6 1/6] net: mana: Create separate
 EQs for each vPort
Thread-Topic: [EXTERNAL] Re: [PATCH net-next v6 1/6] net: mana: Create
 separate EQs for each vPort
Thread-Index: AQHc2CXaUSKEUxi2tEiQPQU00CBaQrX63xSAgAOR6OA=
Date: Mon, 4 May 2026 22:07:52 +0000
Message-ID:
 <SA1PR21MB66837C76219C1F37B09B3307CE312@SA1PR21MB6683.namprd21.prod.outlook.com>
References: <20260429221625.1841150-2-longli@microsoft.com>
 <20260502152354.289044-2-horms@kernel.org>
In-Reply-To: <20260502152354.289044-2-horms@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=4e0ef6e9-eaf3-4626-9007-39023a958768;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2026-05-04T21:54:54Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR21MB6683:EE_|SA1PR21MB6368:EE_
x-ms-office365-filtering-correlation-id: a7d90584-6eb8-4b23-38d4-08deaa29962d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700021|56012099003|22082099003|18002099003;
x-microsoft-antispam-message-info:
 GWNqUvwV02f47DIbWGFk8w7NnFj/99E0GwTifyhHEjnksGx4xE5/GlsvrBD312Y+vWFnCA0zRHDRm//45EysnjjoRFmfdUl+Y/25Kolqw0X1QoEvecSTrs/EDWitbH5il9Zgo0I91N9HolGTZLN3Vx32QxV8mnsC4sgTT9N+U9VF7HuoNSYJF1wf7cFTX5PlUwzgeUMTJ3np4Y5tsBqTg2+++qR+QDc6NJ/g7sbgHujUpnhyK7gCsX295lZrBjm7Ht8HEFhWDgfXZ4kFP7B9OSZeuhJjSkW+bAiIIqvAa+HsY9VRGdZQkRpoDP/8kYUROfWwYu45weJZISaqh6/GB2TKe33KYAIO5Kh91BFbKcwU5DPFIA2MNeGm+GLexIN9cg1ECSFPE/BFt8z0ssmUaZZMeJgWBDfOQ8Clmm+dxwofv3YGRySX6I9wDvZ5tqW8ySIJxIQo2ce6vHf+F04vVifqSc8OsSIQPjLEAmBdUkB9dJYscF7HAlNPzqDzA6mCvCnQjR6ctJKG2cS+hGDaGiDt5nQQkZXAA1CWogzt30wK/pO0lYZhnQQmRqqwTbWSodhvhr7Wx55lVfrWqSV3qfpdf4bdJzSlPpklw50VqIv37NGVjZJ00L/mpfQKtCCMnKpTk36scHT+J0fDdjt08UoZWKD6sZoeXvoa7PD2oEz+dX/X3B6VMoUiyy46KAtr
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR21MB6683.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700021)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-2022-jp?B?ZkU0OVlXT2RqOXppRjAzVkIzWEcwSmIzc2hWbDN3cm1xVnNjaXR5c3d4?=
 =?iso-2022-jp?B?WmUzaFBQVjVXZjJucTZ3YnN3S1VNSlJVSlBmM3ltdmNVRG1kR2wzYjAx?=
 =?iso-2022-jp?B?NkRCS0NJdm53ZXpsMUptUWFVUVE2bUQwdUFnWC9VSnJvcU9BQjZCYTE3?=
 =?iso-2022-jp?B?aUlEc0g4QXpHUWxWRVp0eVArdzV1VXhtOUxDZWppd0Q3TWN4Y3c1YTVQ?=
 =?iso-2022-jp?B?UGZxMzlISDc1SzZwSnd4YWlIdEFUODBoay94Yk51djlWdXNIdE52SExo?=
 =?iso-2022-jp?B?UjhQS1MvTTNOK2VYelhFbmZlWWNJMnJsZnZqTzN4aHlLdXVMdlhhelhq?=
 =?iso-2022-jp?B?ck5idXJHczgxbVVaZGtkbERMMEo3dk52UnFKN0w4Um1tejIwL1J1akNm?=
 =?iso-2022-jp?B?Mld1ODhSVlN1Sk83aEdUMlB1TnhBSTQvRGcvVFZNeVVSVm1TSENKQTJq?=
 =?iso-2022-jp?B?RURKMHR6c1JjV0oxamJ4MHl1WmZZclgwaW5mRXFWaXNueURYazdUaHNx?=
 =?iso-2022-jp?B?QUNVc1VIbm1mazMwTkhjQnhFTkRaOWN3QU43cmYxMXg0STdVU050MjJ5?=
 =?iso-2022-jp?B?YjlmbzJqZi9MdHdpa0J2TGlabUJmM2tJbEIxY0VZV21VZmtncGw4Q2xH?=
 =?iso-2022-jp?B?a0l2aE9ZcGJCSlF1c0UvOGNLOWpWTURDeGttbVYrZm82NFJ4YkhhUmdR?=
 =?iso-2022-jp?B?R2NsLzRJeW15Tm1EUG56V0UxYTFzbUM3V2d3YXVodFFSTnFITUZWQnVR?=
 =?iso-2022-jp?B?czg5Z3RPV0RORlNXcTZFa004bC9GbVF5Qmc4ajhTckVWU3J4MkdxTGha?=
 =?iso-2022-jp?B?UUVCd3p5MVpwT0h5S0pVNzB3MG5Ed0l5eTRjZ0U3c21RYi8wcStubm1i?=
 =?iso-2022-jp?B?bGhra3R2dWVONzBUWWhwRnV6M051VGxuTEFDWkN0UnNiVGg1czNnbEp4?=
 =?iso-2022-jp?B?cFRNVzFSS1VkWmVjbVJza1BBYWc1cm5QNlJnSlpnSjlPZkU1czRYbkx0?=
 =?iso-2022-jp?B?V0w0MW5LVDR2RXU5YmJTM0VaZGZXaGI1ZTZwTktzRUg0ckdMODBkaHph?=
 =?iso-2022-jp?B?MEo1OTFvKzdhY2N0SnZZUmdkK214QkdOckdGdGZhWTU3NFZXSFdpaDZs?=
 =?iso-2022-jp?B?d0ZxekhyMUdvZ3ZBSW5YT1h3ajRvNUc2SFYyekQxcGgrS3h1OXJpS28x?=
 =?iso-2022-jp?B?UENDSFNaL3VxMzNZZCtHQ3M5bHBscTRaNHltTFJDQlgxMWtyUXl1bTl4?=
 =?iso-2022-jp?B?aEhDNHVBbktQdnFTenlrdzZHb3gyRHQ2UUx4OHY2Z0tBdTNXalV5QTlu?=
 =?iso-2022-jp?B?blAyMVZrK0NsZ0pVeXBLTXZ1dHk0akhHT2l2S0dWMjRLR3JSWUJmN0Jn?=
 =?iso-2022-jp?B?Qzg1V01tK090Kzc2dkhLNFBnSjhTOEl3NXp4Vit4TzNYZUwzaTllQStx?=
 =?iso-2022-jp?B?RWNxRnJnWmMrNUh5Ry9wcHI2RkdPUDJaenZic0ZaeWtVajVsUWFPdW9R?=
 =?iso-2022-jp?B?WGlJSHdzMlFJMUp4MTZWSTZ5ZlljNnNhRFYyYWcvVmlnalRPaXhhTFdv?=
 =?iso-2022-jp?B?UnpsUXhDOU5ucitZazFndVZzRUFiL3AwZjFGWFVkVksrK1ZxSW95Z1JM?=
 =?iso-2022-jp?B?UnVVNCsvQ0d4L1BGY2x0Y0d4TjVXMngvTlM5OU1JWXlFb2gzZTZTcFo3?=
 =?iso-2022-jp?B?RE9IamFnSlgyeU1jbnhvdWhaUzlqS08rY3duOVhqU1JnUXhLU2xHeHdG?=
 =?iso-2022-jp?B?OE5WMjFVVWZSRmliT0d0b2hGRWcvSjhxQ2grbHU3Q2VZTDhYeTQzY3RU?=
 =?iso-2022-jp?B?V3Babm5qcENQbkE2TUYxaEl5QmJnS09NMDdzNk1QTmNzTzR5VTFjcG9E?=
 =?iso-2022-jp?B?Zmtwb0NwNFkrMEllUkZucklnSjBCa2lkVHJ3WDRLcU14VHJtSUx4S2Rj?=
 =?iso-2022-jp?B?cENWREs1eTZlUkV1WGVTRUN0ak55UzBQNXVyK1lJZ1NTNDl5YkdiVXpW?=
 =?iso-2022-jp?B?bkI0d0ppNEUyRVhCZzFNcWxzZ2lQZEsxM1U2YXlRUWF1UXNEVCt3Sit5?=
 =?iso-2022-jp?B?S1dWUmJhRmFzb2g4cy8zZjVKdVRLMitBUVV1SWEyTUdhK1lkSGgraGFS?=
 =?iso-2022-jp?B?WTlaWUhnYzdJRVI4OVhKVEJsODN4bHBjdjRwUFNVMHZ6WFBqUG1YcEdo?=
 =?iso-2022-jp?B?eWtaVEpWQkY5NXZqMUN6aE1rZVMrY2VaQVVtZTN5dExDaWR3NUd0dFNK?=
 =?iso-2022-jp?B?RnpFdGNsNWl1KzlDSkRPcHVCTnRraFY5V003S2gvUWZPNVQvcWlrZUw4?=
 =?iso-2022-jp?B?aWFtTEZBQUZZcXAzMDg4UHNvaWdHVVczU0xCd2VlNFNiY1pTVk5VblNZ?=
 =?iso-2022-jp?B?VVhXSUt4S3hVbWtyOSsxM3JFdi9jQ1FFU0drL2x3SnJ0a0hVaE9mQzVr?=
 =?iso-2022-jp?B?S3FFKzZyOVhHQlhLcHJURmo3WTJPeDhoRTVuYjlIWG1MaWxoU0pBOEVM?=
 =?iso-2022-jp?B?YmlEbkw0?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR21MB6683.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7d90584-6eb8-4b23-38d4-08deaa29962d
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 May 2026 22:07:52.3056
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ch1DYf0SdHg2URVY30eFN9xjivsep5EEHtYUj7f94jeMUO99TIILbBi+Co7kGXbfzw3dXxLrkk4vZa9dg0CWng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR21MB6368
X-Rspamd-Queue-Id: F1C864C44B8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[microsoft.com,reject];
	R_DKIM_ALLOW(-0.20)[microsoft.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10616-lists,linux-hyperv=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[longli@microsoft.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[microsoft.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,SA1PR21MB6683.namprd21.prod.outlook.com:mid]

> From: 'Simon Horman' <horms@kernel.org>
>
> This is an AI-generated review of your patch. The human sending this emai=
l has
> considered the AI review valid, or at least plausible.
> Full review at:
> https://sashiko.d/
> ev%2F&data=3D05%7C02%7Clongli%40microsoft.com%7C36b10107f9774abb6894
> 08dea85f3721%7C72f988bf86f141af91ab2d7cd011db47%7C1%7C0%7C6391333
> 24077887564%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYi
> OiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0
> %7C%7C%7C&sdata=3DcS3FmP7jK6ftjo74XWvtBHNXYa7YKlthqLgzEudcmb4%3D&re
> served=3D0
> ---
> net: mana: Create separate EQs for each vPort
>
> This change moves EQ ownership from struct mana_context to struct
> mana_port_context so each vPort can have dedicated EQs, and exports
> mana_create_eq()/mana_destroy_eq() for use by the MANA RDMA driver.
>
> > diff --git a/drivers/infiniband/hw/mana/main.c
> > b/drivers/infiniband/hw/mana/main.c
> > index ac5e75dd3494..60cc02e4ad10 100644
> > --- a/drivers/infiniband/hw/mana/main.c
> > +++ b/drivers/infiniband/hw/mana/main.c
> > @@ -20,8 +20,10 @@ void mana_ib_uncfg_vport(struct mana_ib_dev *dev,
> struct mana_ib_pd *pd,
> >     pd->vport_use_count--;
> >     WARN_ON(pd->vport_use_count < 0);
> >
> > -   if (!pd->vport_use_count)
> > +   if (!pd->vport_use_count) {
> > +           mana_destroy_eq(mpc);
> >             mana_uncfg_vport(mpc);
> > +   }
> >
> >     mutex_unlock(&pd->vport_mutex);
> >  }
> > @@ -55,15 +57,21 @@ int mana_ib_cfg_vport(struct mana_ib_dev *dev, u32
> port, struct mana_ib_pd *pd,
> >             return err;
> >     }
> >
> > -   mutex_unlock(&pd->vport_mutex);
> >
> >     pd->tx_shortform_allowed =3D mpc->tx_shortform_allowed;
> >     pd->tx_vp_offset =3D mpc->tx_vp_offset;
> > +   err =3D mana_create_eq(mpc);
> > +   if (err) {
> > +           mana_uncfg_vport(mpc);
> > +           pd->vport_use_count--;
> > +   }
> > +
> > +   mutex_unlock(&pd->vport_mutex);
> >
> >     ibdev_dbg(&dev->ib_dev, "vport handle %llx pdid %x doorbell_id %x\n=
",
> >               mpc->port_handle, pd->pdn, doorbell_id);
>
> On the failure path, mana_uncfg_vport() is called and pd->vport_use_count=
 is
> decremented, but execution falls through to the ibdev_dbg() line that pri=
nts the
> vport handle as if it were a success. Should this debug print be skipped =
on the
> error path so logs are not ambiguous?

  This is fair point. The ibdev_dbg could be guarded with if (!err) for cla=
rity. That said, ibdev_dbg is compiled out in non-debug builds and the erro=
r itself is returned to the caller, so this is
  cosmetic. Happy to add the guard if you feel strongly.

>
> Also, pd->tx_shortform_allowed and pd->tx_vp_offset are assigned from mpc
> before the mana_create_eq() attempt and are not cleared when that call fa=
ils.
> Callers are expected to gate on pd->vport_use_count, but is it worth rese=
tting
> these fields on failure so the state matches the pre-patch behavior?

  These fields are only consumed when pd->vport_use_count > 0. On failure t=
he count is decremented back to 0, so the stale values are never read. The =
next successful mana_ib_cfg_vport() call will
  overwrite them. This matches pre-patch behavior - pre-patch also assigned=
 these fields unconditionally and relied on the use count to gate access.

>
> The mutex_unlock(&pd->vport_mutex) has moved from before the field
> assignments to after mana_create_eq(). That now holds pd->vport_mutex acr=
oss
> GFP_KERNEL allocations, debugfs directory creation, and multiple
> mana_gd_create_mana_eq() firmware RPCs, and establishes the lock order
> pd->vport_mutex -> apc->vport_mutex via mana_uncfg_vport() on the error
> path. Is the extended critical section intentional?

  Yes, this is intentional. Pre-patch, pd->vport_mutex was released before =
assigning pd->tx_shortform_allowed and pd->tx_vp_offset, which was a data r=
ace - a concurrent raw
  QP creation on the same PD could read partially-initialized state. The ex=
tended critical section ensures the vport is fully configured (including EQ=
s) before any concurrent user can observe
  vport_use_count > 0.

>
> >
> > -   return 0;
> > +   return err;
> >  }
> >
> >  int mana_ib_alloc_pd(struct ib_pd *ibpd, struct ib_udata *udata) diff
> > --git a/drivers/infiniband/hw/mana/qp.c
> > b/drivers/infiniband/hw/mana/qp.c index 645581359cee..6f1043383e8c
> > 100644
> > --- a/drivers/infiniband/hw/mana/qp.c
> > +++ b/drivers/infiniband/hw/mana/qp.c
> > @@ -168,7 +168,15 @@ static int mana_ib_create_qp_rss(struct ib_qp *ibq=
p,
> struct ib_pd *pd,
> >             cq_spec.gdma_region =3D cq->queue.gdma_region;
> >             cq_spec.queue_size =3D cq->cqe * COMP_ENTRY_SIZE;
> >             cq_spec.modr_ctx_id =3D 0;
> > -           eq =3D &mpc->ac->eqs[cq->comp_vector];
> > +           /* EQs are created when a raw QP configures the vport.
> > +            * A raw QP must be created before creating rwq_ind_tbl.
> > +            */
> > +           if (!mpc->eqs) {
> > +                   ret =3D -EINVAL;
> > +                   i--;
> > +                   goto fail;
> > +           }
> > +           eq =3D &mpc->eqs[cq->comp_vector % mpc->num_queues];
>
> Can the mpc->eqs read race with a concurrent free? mana_ib_create_qp_rss(=
)
> runs without pd->vport_mutex or RTNL, but mpc->eqs is freed by
> mana_destroy_eq() from two paths:
>
>   mana_ib_uncfg_vport()   (under pd->vport_mutex, on last raw-QP destroy)
>   mana_dealloc_queues()   (under RTNL, on netdev down)
>
> both of which do:
>
>   kfree(apc->eqs);
>   apc->eqs =3D NULL;
>
> with no RCU grace period or reader-visible synchronization. If CPU-A pass=
es
> the !mpc->eqs check after CPU-B begins ip link set dev X down, does CPU-A=
 then
> dereference freed memory via mpc->eqs[...].eq->id?

  These two paths cannot run concurrently with RDMA QP creation on the same=
 port. mana_cfg_vport() enforces mutual exclusion between Ethernet and RDMA=
 via apc->vport_use_count:

       mutex_lock(&apc->vport_mutex);
       if (apc->vport_use_count > 0) {
               mutex_unlock(&apc->vport_mutex);
               return -EBUSY;
       }
       apc->vport_use_count++;

  If RDMA holds the vport (created a raw QP), Ethernet cannot bring the int=
erface up, so mana_dealloc_queues() cannot run. If Ethernet holds the vport=
, mana_ib_cfg_vport() =1B$B"*=1B(B mana_cfg_vport()
  returns -EBUSY and no RDMA raw QP is created, so mpc->eqs belongs exclusi=
vely to Ethernet.

  The mana_ib_uncfg_vport() path requires destroying the last raw QP on the=
 PD, which means no new RDMA QPs should be in flight on that PD. The IB cor=
e serializes QP creation/destruction on the
  same device context.

>
> Separately, what populates mpc->eqs for an RDMA-only RSS QP user on a pro=
bed-
> but-idle Ethernet port? Pre-patch mana_probe() called
> mana_create_eq(ac) unconditionally, so ac->eqs existed for the device lif=
etime.
> After this patch the only creators are mana_alloc_queues() (Ethernet up) =
and
> mana_ib_cfg_vport() (raw QP). An RDMA application that uses only RSS QPs =
and
> never creates a raw QP will now get -EINVAL here where it used to succeed=
. Is
> this intended, and should the commit log mention it?

  This is intentional. An RSS-only RDMA application (no raw QP) could never=
 have worked in practice: mana_ib_create_qp_rss() calls mana_create_wq_obj(=
mpc, mpc->port_handle, ...) which requires the
  vport to be configured. Without a raw QP calling mana_ib_cfg_vport() =1B$=
B"*=1B(B mana_cfg_vport(), mpc->port_handle is INVALID_MANA_HANDLE and the =
firmware call would fail. The -EINVAL is a cleaner early
  error for a path that was already broken.

>
> The adjacent comment:
>
>    /* EQs are created when a raw QP configures the vport.
>     * A raw QP must be created before creating rwq_ind_tbl.
>     */
>
> omits the Ethernet-up path that also populates mpc->eqs. Would it be clea=
rer to
> describe both creators?

  The comment is in the RDMA code path. Due to the mana_cfg_vport() mutual =
exclusion described above, when RDMA is executing this code, it owns the vp=
ort - so the EQs were created by the raw QP,
  not by Ethernet. The Ethernet path is not reachable when RDMA holds the p=
ort. The comment is accurate for the context it appears in.

>
> There is also a behavior change in the index expression:
>
>    eq =3D &mpc->eqs[cq->comp_vector % mpc->num_queues];
>
> Pre-patch this was ac->eqs[cq->comp_vector] sized by gc->max_num_queues.
> Now comp_vector is folded modulo mpc->num_queues, which is tunable via
> ethtool -L. Userspace that used distinct comp_vector values to hit distin=
ct EQs
> will silently alias when comp_vector >=3D num_queues. Should this be docu=
mented
> or rejected with -EINVAL rather than silently wrapped?

  The modulo wrap is the correct behavior. The EQ array is now sized to mpc=
->num_queues (the actual configured queue count), not the hardware maximum.=
 Rejecting with -EINVAL would break
  applications that set comp_vector based on the device's total num_comp_ve=
ctors - which is the standard RDMA practice. Wrapping is what other drivers=
 do in this situation (e.g., mlx5). Pre-patch
  the wrap just happened to be unnecessary because the array was oversized =
to the hardware max.

>
> Can mpc->num_queues be 0 at this point? mana_set_channels() does not reje=
ct
> new_count=3D=3D0, and kzalloc_objs(struct mana_eq, 0) returns ZERO_SIZE_P=
TR,
> which passes the !mpc->eqs check. During the window between
> mana_create_eq() and the subsequent netif_set_real_num_tx_queues() failin=
g, a
> concurrent RDMA QP create would compute
> cq->comp_vector % 0 here. Should mpc->num_queues be validated alongside
> mpc->eqs?

  num_queues cannot be 0. The ethtool core validates this before calling th=
e driver - ethnl_set_channels() rejects the request if combined_count is 0 =
and there are no separate rx/tx channels
  (which MANA doesn't use). Additionally, num_queues is initialized at prob=
e time to min(gc->max_num_queues_vport, MANA_DEF_NUM_QUEUES) where MANA_DEF=
_NUM_QUEUES is 16 and the hardware always
  reports at least 1 queue.

>
> The placement of the !mpc->eqs check is inside the per-iteration loop ove=
r
> ind_tbl_size, but mpc->eqs cannot change across iterations, so the check =
is only
> meaningful at i=3D=3D0. It works today because i-- then makes i =3D -1 an=
d the cleanup
> while (i-- > 0) skips. Would hoisting the check above the loop be clearer=
 and less
> fragile against refactoring?
>
> >             cq_spec.attached_eq =3D eq->eq->id;
> >
> >             ret =3D mana_create_wq_obj(mpc, mpc->port_handle, GDMA_RQ,
> @@ -317,7
> > +325,11 @@ static int mana_ib_create_qp_raw(struct ib_qp *ibqp, struct =
ib_pd
> *ibpd,
> >     cq_spec.queue_size =3D send_cq->cqe * COMP_ENTRY_SIZE;
> >     cq_spec.modr_ctx_id =3D 0;
> >     eq_vec =3D send_cq->comp_vector;
> > -   eq =3D &mpc->ac->eqs[eq_vec];
> > +   if (!mpc->eqs) {
> > +           err =3D -EINVAL;
> > +           goto err_destroy_queue;
> > +   }
> > +   eq =3D &mpc->eqs[eq_vec % mpc->num_queues];
>
> The same mpc->eqs TOCTOU concern applies here: the check and subsequent
> dereference occur without pd->vport_mutex or RTNL held, so a concurrent
> mana_dealloc_queues() on the Ethernet side can free mpc->eqs between the
> check and the index access. Is there synchronization that prevents this?

  Same answer as above: mana_cfg_vport() mutual exclusion prevents this. In=
 mana_ib_create_qp_raw(), mana_ib_cfg_vport() is called just before this co=
de, which calls mana_cfg_vport(). If Ethernet
  holds the port, that call returns -EBUSY and we never reach the mpc->eqs =
access. If we reach it, RDMA owns the vport and Ethernet cannot tear it dow=
n.

>
> The same comp_vector % num_queues aliasing and num_queues=3D=3D0 divide
> concerns apply here as well.
>
> >     cq_spec.attached_eq =3D eq->eq->id;
> >
> >     err =3D mana_create_wq_obj(mpc, mpc->port_handle, GDMA_SQ,
> &wq_spec,
> > diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c
> > b/drivers/net/ethernet/microsoft/mana/mana_en.c
> > index a654b3699c4c..6c709f8b875d 100644
> > --- a/drivers/net/ethernet/microsoft/mana/mana_en.c
> > +++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
>
> [ ... ]
>
> > -static int mana_create_eq(struct mana_context *ac)
> > +int mana_create_eq(struct mana_port_context *apc)
> >  {
> > -   struct gdma_dev *gd =3D ac->gdma_dev;
> > +   struct gdma_dev *gd =3D apc->ac->gdma_dev;
> >     struct gdma_context *gc =3D gd->gdma_context;
> >     struct gdma_queue_spec spec =3D {};
> >     int err;
> >     int i;
> >
> > -   ac->eqs =3D kzalloc_objs(struct mana_eq, gc->max_num_queues);
> > -   if (!ac->eqs)
> > +   WARN_ON(apc->eqs);
> > +   apc->eqs =3D kzalloc_objs(struct mana_eq, apc->num_queues);
> > +   if (!apc->eqs)
> >             return -ENOMEM;
>
> WARN_ON(apc->eqs) is used as a defensive assertion but execution proceeds=
 to
> overwrite apc->eqs unconditionally. If the invariant is violated, the pre=
vious array
> and all HW EQs it referenced are leaked.
> Should this instead bail out with an error or call mana_destroy_eq() firs=
t to keep
> the function idempotent against future callers?


  The WARN_ON is a development assertion to catch double-init bugs. If it f=
ires, there is already a logic error in the caller. Silently cleaning up an=
d proceeding would mask the root cause. The
  standard kernel pattern for "this must never happen" is WARN_ON + continu=
e, not silent recovery. If we wanted to be stricter, returning -EBUSY would=
 be reasonable, but the current approach is
  consistent with kernel convention for invariant checks.

>
> [ ... ]
>
> > @@ -3326,6 +3349,9 @@ static int mana_dealloc_queues(struct net_device
> *ndev)
> >     mana_fence_rqs(apc);
> >
> >     /* Even in err case, still need to cleanup the vPort */
> > +   mana_destroy_rxqs(apc);
> > +   mana_destroy_txq(apc);
> > +   mana_destroy_eq(apc);
> >     mana_destroy_vport(apc);
>
> What is the intended interaction with outstanding RDMA QPs here? An RDMA
> user that created an RSS QP while the Ethernet netdev was up sees
> mpc->eqs populated by mana_alloc_queues(). When the admin issues
> ip link set dev N down, mana_dealloc_queues() -> mana_destroy_eq() destro=
ys
> those EQs and frees mpc->eqs while the RDMA QPs are still alive, leaving =
the QPs
> with dangling attached_eq IDs at the hardware level and stale kernel refe=
rences.

  This scenario cannot occur. As described above, mana_cfg_vport() enforces=
 mutual exclusion - Ethernet and RDMA cannot hold the same port simultaneou=
sly. If Ethernet is up, RDMA raw QP creation
  on that port returns -EBUSY. If RDMA holds the port, mana_alloc_queues() =
=1B$B"*=1B(B mana_create_vport() =1B$B"*=1B(B mana_cfg_vport() returns -EBU=
SY and the interface fails to come up. There is no state where both
  have created EQs on the same mpc.

>
> Pre-patch ac->eqs lived for the full mana_context lifetime and was torn d=
own
> only in mana_remove(). Is unconditionally destroying the EQs on netdev-do=
wn
> the intended new behavior, and if so how are concurrent RDMA consumers
> expected to recover?

Yes, destroying EQs on netdev-down is the intended new behavior, and no RDM=
A recovery path is needed because the scenario has no concurrent RDMA consu=
mers.

mana_cfg_vport() enforces mutual exclusion at the hardware port level via a=
pc->vport_use_count - it returns -EBUSY if the port is already held. Ethern=
et and RDMA cannot hold the same port
simultaneously:

- If Ethernet is up =1B$B"*=1B(B RDMA raw QP creation fails at mana_cfg_vpo=
rt() with -EBUSY =1B$B"*=1B(B no RDMA EQs or QPs exist on that port =1B$B"*=
=1B(B netdev-down destroys only Ethernet's own EQs.
- If RDMA holds the port =1B$B"*=1B(B mana_alloc_queues() =1B$B"*=1B(B mana=
_create_vport() =1B$B"*=1B(B mana_cfg_vport() returns -EBUSY =1B$B"*=1B(B i=
nterface never comes up =1B$B"*=1B(B mana_dealloc_queues() never runs.

Pre-patch, the device-lifetime EQs in ac->eqs were shared across all ports =
and both subsystems, which masked this exclusivity - the EQs were always pr=
esent regardless of who owned the port.
Post-patch, each port owns its EQs, and they follow the lifecycle of whoeve=
r holds the port. The exclusion guarantee means there is nothing to recover=
 from.

