Return-Path: <linux-hyperv+bounces-6258-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C702B062F3
	for <lists+linux-hyperv@lfdr.de>; Tue, 15 Jul 2025 17:30:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 799BF7AAEA4
	for <lists+linux-hyperv@lfdr.de>; Tue, 15 Jul 2025 15:29:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2C5C22DFB5;
	Tue, 15 Jul 2025 15:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="NXpZNI/o"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11023075.outbound.protection.outlook.com [40.107.201.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E88B685260;
	Tue, 15 Jul 2025 15:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752593451; cv=fail; b=f6Pjn3JJWPgt5mZAf3w093vMzc0rugkf7pr6UPVLEIaXxw0Wv2N2nA7md7NtkFa+XKlqMOHoWCeN1nGsZnH63JKrPfDkbsn0nt8AlSngPAyjeZZLsFWPq9wFAHpdfMTqz3FPOh72U4D43z2oOFlUOT9raFXPw5WLGqC9Zel0Edc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752593451; c=relaxed/simple;
	bh=2hLKj5f9rqAVWYAmU42kOXy+bFbFNAJwVO7/5PUyZf0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VA8ptYLaTgPEMzLB0y/hZqGbrXyfFr93nSkHa+mKee+gZhgnyNR0LgGZaRqq96n1PP3k9boMH2cF+pJihxEklDsPNqfxp5K/hzZuq+fPVZ0rr01ym4WQYFAm0HlHzlwFlji/mstmq4YqAUouxDIvvUXr4PEfpVnwdXdltEd9EZk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=NXpZNI/o; arc=fail smtp.client-ip=40.107.201.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jJFZBU151MsbcY17qZZCQfdwRQ3KTa+koatAyyXuN4l7LW2DJaDBroh3d7Co0U8v7m7xZTukDpl2RNurpDDJYPc2NyziYPiGxyXEZLYE1gNop5LYqAZP3hSb2N9YGwes5hL7xAEIGR76CcSxnsolpounxWFizmjCBPwvTWuPtrnTJ6WA02xcVnxRgJAGM1/1LOjwev/I3lqFMs3dpdRhIblslfX8d8vm3r94t4Wi69h80FV2I3J3R5Qihqk2ZUuy5hRecbfN0tBkMe+fVf6ubvLleYeTiuqfJ/tG71NxLRmR3Mk3/j84P99NfK9m60Rf92fyj7E7c4ZZrTdoPCx7IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=id+ypH+weyypGaxuH12kiJroedXXNLADsI80nq1+LMg=;
 b=Cgt9yf8tTS9ugd/glhOc0oRXp8tWeaVcjKjD1t8kK+BaEx+olnKrvA8YS3GkxKjp2FR3QJ4Ux3QhYtsk8fc66glPcUhctFlaSzv6hobkF8XVuvlpVVKV3LZLEoppIylGRSixfniPosfdz2CpUBm7PbdUFD481BRnR0ZcyUIkwto+BMqpn7zVzAoWESF9BCZo6IQAAU9fkZ9xlB1hWU+VFBYk3dcE2R71Gyc0qT0uJhJTV3YtPILPXF1tirErpxmolCVui2Z023OkC1tNVKfLI795+N9Q7JUU3oa9OGpjIsWbeUelJE6iEzjk3xHgCV9NOgL5+DW24GbeId6I48pf7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=id+ypH+weyypGaxuH12kiJroedXXNLADsI80nq1+LMg=;
 b=NXpZNI/oaaJae6vT1yxQSVNG9Qg+3C0mXPz//lrhQp/0xgDyO7UFtOZAum/JNO1y7ECRwH8jkAnrBp/ryZ8Bo2DGrTkdl2DHOJX0adfolsR6ipkEbDwLnxjJC0/dyMQiNY85KjqvOEEMlB7HvRPpkrMde06D7NR4fIjnJtE9gtM=
Received: from SN6PR2101MB0943.namprd21.prod.outlook.com (2603:10b6:805:f::12)
 by DS4PR21MB4770.namprd21.prod.outlook.com (2603:10b6:8:2a4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.12; Tue, 15 Jul
 2025 15:30:43 +0000
Received: from SN6PR2101MB0943.namprd21.prod.outlook.com
 ([fe80::c112:335:8240:6ecf]) by SN6PR2101MB0943.namprd21.prod.outlook.com
 ([fe80::c112:335:8240:6ecf%5]) with mapi id 15.20.8964.004; Tue, 15 Jul 2025
 15:30:42 +0000
From: Haiyang Zhang <haiyangz@microsoft.com>
To: Simon Horman <horms@kernel.org>, Haiyang Zhang
	<haiyangz@linux.microsoft.com>
CC: "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, KY Srinivasan
	<kys@microsoft.com>, "wei.liu@kernel.org" <wei.liu@kernel.org>, Dexuan Cui
	<decui@microsoft.com>, "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"davem@davemloft.net" <davem@davemloft.net>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>, "cavery@redhat.com" <cavery@redhat.com>
Subject: RE: [EXTERNAL] Re: [PATCH net,v2] hv_netvsc: Switch VF namespace in
 netvsc_open instead
Thread-Topic: [EXTERNAL] Re: [PATCH net,v2] hv_netvsc: Switch VF namespace in
 netvsc_open instead
Thread-Index: AQHb9N43knD0TGxECUCpKCAyzRddwbQzKJ+AgAAho6A=
Date: Tue, 15 Jul 2025 15:30:42 +0000
Message-ID:
 <SN6PR2101MB0943A212F67D779BA97B7FC4CA57A@SN6PR2101MB0943.namprd21.prod.outlook.com>
References: <1752511297-8817-1-git-send-email-haiyangz@linux.microsoft.com>
 <20250715130547.GV721198@horms.kernel.org>
In-Reply-To: <20250715130547.GV721198@horms.kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=85da4776-cebc-462c-96e1-d6d235ca4478;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2025-07-15T15:06:10Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR2101MB0943:EE_|DS4PR21MB4770:EE_
x-ms-office365-filtering-correlation-id: a6e05867-27ad-423b-ee35-08ddc3b48fa5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|7416014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?P8zSCIjDv20KB7p2sqZe+Of8fOgQsJ6Jzjg0SoNccmW0Ec+otMOF9F5iptAR?=
 =?us-ascii?Q?nl6WgDjYgFJz861ZhBjvPWAnrzjjSqOnYhDrsNIWnr3LA3Dh3H7zIRJFKnWg?=
 =?us-ascii?Q?rtf5qVZuK8NdgzFqKsqkjytssbN+ngLcZaAgHHweaY87R19lS+HzQNQTdxgK?=
 =?us-ascii?Q?JYUzsXf8VnAu3zPusgnsPg93P0FBeqfO5UCYYAE7yaxFzDMoyGP+8dwMJ6js?=
 =?us-ascii?Q?w045CJwBUFt6eHYj+sskGw9iZgdtuKiB6aVC1TxPsYIkA5cIqTL8d3wpOafc?=
 =?us-ascii?Q?C1//u/YjxrwV0dMj6+rFy/f0HsDIuWLg8y1u0y3u1YVHxgH6xYWEBnWf38oL?=
 =?us-ascii?Q?bxoobqbbZ73DpI7jdU+DR4iF14lqrnOw7XxEH5M+PF070dq3fWGd6815d/d2?=
 =?us-ascii?Q?tB6WzsMnMxwPHD0yXzZ2WrPZ04d8z2OOobH+id7IDYtYxkeFYcz7HSIrHjID?=
 =?us-ascii?Q?mvMEXAfoxhTRX7Mr88Cvoo5m6c4ss4CLauzyYv+DabcbZFIPJZtvy13Ni/6g?=
 =?us-ascii?Q?XkUNO2xheyZkU0iFPOkSF7vPowGVWM5suFjNEQXfI8f6xwygHY7H/kdZOlUt?=
 =?us-ascii?Q?7muJX1QOC5j+OSCoBKqJ/to9RL4/tyJOQEA3f4rq/Ywjkk9M25ZdMrrY8CUc?=
 =?us-ascii?Q?xmvolwWpYdpB9OJo1EEj332F3O+h2R/LQwddhwBv1uZS7xqL9mGklvnTcCaf?=
 =?us-ascii?Q?0T4ax6ziPgr+iFP0LFgWWlThRWBZR5owt8Cs4P4MuZmb6i/9u2UZ7TSwlVd+?=
 =?us-ascii?Q?aD+Y0RMfujq/7qd0wLeVwpeTIjEMeAKzL6ax6I7gHjORwJQFQW3aqxoMi94q?=
 =?us-ascii?Q?bM9hX0BP4UShplXWqOScEtzSVl7+whBHSfcDH78+YAq3ruHfPcN5c9I0eZrD?=
 =?us-ascii?Q?xyeY6SArpbbOgKQGdx3G8RoBmmTYIIWRStLjNIcG7TQdBEYauSP7Z8aXvt0K?=
 =?us-ascii?Q?FmKN+d0Z1sBGRZvjsS+LX74oaUE8yBscLR4qLAkjWiavSIKstA+KFyCXDtkg?=
 =?us-ascii?Q?gCTKDQIiiUT8346HUQxuXRALnt7c5pS/oNMbiYxEtf7+N26CEklZcPyiPU7Z?=
 =?us-ascii?Q?nkT0mKzEp0nSkrKhOTPENhYnNv6yibUGnQKr56ErFmLVwHFGNNWRl+e95Gg1?=
 =?us-ascii?Q?UHfEsNAtk0ZmpdZ3pd+Ux14vbs0FG9WQxRo0uNPvjbEdGqlxzpYxbHrHaYWJ?=
 =?us-ascii?Q?O+seGNuoHSY4dgKqyYnBdCa8ZneLmkTLy+0P703Nr8fLy3itN/f6vMmMNqv7?=
 =?us-ascii?Q?lfay1gzfWr34Oxr9Wne+uHYVB7H3HWMT9rEX5Jqf/KQbCvMYbo11ySvurgZo?=
 =?us-ascii?Q?+fQ6kffBs4VmnCUnbK/r6Ypw7erjcmJThGlT+Gvb3NuJ5Mf8qiSlvjRrMkpj?=
 =?us-ascii?Q?+4s2rqDlqnmg2kQkVR90DWVTSROiMdvSR/m8L9/DWHg25FXq+sjzraibEdVC?=
 =?us-ascii?Q?MCk32yCqjYgq6tsi7MggFaho72BS6WIeoQQMvDn9qXBCZhcRGiZfJA=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR2101MB0943.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?lsizj1+Hquphj3l6MRSMg9/AbD6T+lJ4iYPGTCs4xoPWZuFwUNTnaWjkLP49?=
 =?us-ascii?Q?HfHVQNpIHlwAYkKRNtdCVAmXfNH5N5oy2XQSZyuZhE4EroNAmyttm2wVJoP7?=
 =?us-ascii?Q?qlhNJG7nuq5J+87O6tPMYt/9VmZIkKAkaLfETL0Xw/77U7K7Cpn48rf4gpqE?=
 =?us-ascii?Q?4T6PToVI8aAo2ywwTAs7fqT5qOvyHn4BTFyVDstfH9CkNVXlIjR/lmSLfItL?=
 =?us-ascii?Q?yigFRO9Co3Nk8Dy2O0dSnR98Ud6z0Ar5jl7ng9C6cxS+4wYvhu1or1yQAvhZ?=
 =?us-ascii?Q?4tyFRTQnuzphHbvPOnHfKdEZUC4yYxBHejQVYW+hNRieCuC3cz2RGyP9kUr/?=
 =?us-ascii?Q?y5E1u0N/HY2HJTlaLXHBw2NRPWHIhypcGn91hdpbJ6LY1GT0zL+HsajHYAll?=
 =?us-ascii?Q?clTlkGAn60zmlzT6Z/z2BivifvXGeCZaLfxJzcPKa2Bl+gy1MzLT3kt8ol0I?=
 =?us-ascii?Q?49xN3BCwVx9fIkDTuuz3nce0xk6rSL2rU4bGkWMmwAoOj8PXo9KUD+3EraXK?=
 =?us-ascii?Q?Qv5SpCW8sSyHd4xdsJB32nwP8g1Dp/UnVuWBHajr22gbahfVa+OFhKHvVyhV?=
 =?us-ascii?Q?p393WMDmhdPLeNUPctxyR2BmDhtzctGcN6pCPhjM4kQMroF3Au7oaZvNoWL9?=
 =?us-ascii?Q?ft3NWWtAaeXWszT7j7ifMJx5fY3cinT4j4mnGXLz7CcIB/66llfI1L+Aqo9G?=
 =?us-ascii?Q?kbp2N7i9xE0KrghmVo6g5mHMqBqxewcHkfsXtTyCil35KPOLJE15VXHCS9lo?=
 =?us-ascii?Q?UOt+5doKSoTamYe14bnqO0biW22YrL1ol3PO9Z1O8I0zU+Dv7NItjbpqf1tl?=
 =?us-ascii?Q?c9EmFu1oyifiGW2gnIh5mfMgoOLZSpbXJ5prP5SCt6XjYoQNZshy3OBH6TjP?=
 =?us-ascii?Q?aBPWH2ttpx2NhQsur3T+WkQbLqEC/aovsiw0gKrborBOr1vqcxkseJqd72uk?=
 =?us-ascii?Q?JH4KIsYc5Z1qFS3I5URSyOhAQDru2fz/RaL5Rf2jWJyVZdPvrAdw9DK8dChJ?=
 =?us-ascii?Q?cnRERkUZdsgkSJlcC5q8p0t99allwbURwwmRkroWNlA78WAsL+860XfmAd1l?=
 =?us-ascii?Q?xRhJ5KEAB/SsLbW1ghqdoJPjrsd1IwnhwC+nvfK+ffhH4w36KETUTP9I3G1v?=
 =?us-ascii?Q?UlnB03RM8MAtWRswPe71SjBLInk9GjfWrmCEqnj/hnyQkWYQaQ5rxZOD/ZyA?=
 =?us-ascii?Q?X8iB9f89brhQzj0HTve3M4MkTKcrsd6zY0n0ZuOe7lSnRDmxnriclhbhir/j?=
 =?us-ascii?Q?cQQH5FpV/awFZ4xf5tuan9IJDfWjB7xla+yMfmKnDp1yVIAMAiETjnfuG0VU?=
 =?us-ascii?Q?HL+c0hBLury0rJ5DMU8cZ3/pb1TFJAwQDVQfpuIdL9Kns/RX48UkbKmST4PN?=
 =?us-ascii?Q?D5oCpPn7/XdR2x3Lja7Zs9ioxZBdlBeuJi/BvbiRdZj8yrhQ43EvDtT1Xb4D?=
 =?us-ascii?Q?fMaxXQ+4WFIFVV5IkxCgJ/84XFaMHMK8KtX0FSYJtyykp1tDCCGfmWWIIAPe?=
 =?us-ascii?Q?pB9mpxOReiaqj1ItmYQ77pxi+c+sYseee5z1fMH03Z2wa+sAS0AANNkHTS/e?=
 =?us-ascii?Q?db7lmQBEBWEj2jgshlGKZK0afYnYN1O87Z0eOrpg?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR2101MB0943.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6e05867-27ad-423b-ee35-08ddc3b48fa5
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jul 2025 15:30:42.7394
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QZTuroyULLxORE8L0dd/O5OO2wVVmccn+mEcWOUNgfS3fN4Kdsm1pmwA72DtNfNZfrR1KEzRDVBYufnHW4o20A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR21MB4770



> -----Original Message-----
> From: Simon Horman <horms@kernel.org>
> Sent: Tuesday, July 15, 2025 9:06 AM
> To: Haiyang Zhang <haiyangz@linux.microsoft.com>
> Cc: linux-hyperv@vger.kernel.org; netdev@vger.kernel.org; Haiyang Zhang
> <haiyangz@microsoft.com>; KY Srinivasan <kys@microsoft.com>;
> wei.liu@kernel.org; Dexuan Cui <decui@microsoft.com>;
> andrew+netdev@lunn.ch; edumazet@google.com; kuba@kernel.org;
> pabeni@redhat.com; davem@davemloft.net; linux-kernel@vger.kernel.org;
> stable@vger.kernel.org; cavery@redhat.com
> Subject: [EXTERNAL] Re: [PATCH net,v2] hv_netvsc: Switch VF namespace in
> netvsc_open instead
>=20
> On Mon, Jul 14, 2025 at 09:41:37AM -0700, Haiyang Zhang wrote:
> > From: Haiyang Zhang <haiyangz@microsoft.com>
> >
> > The existing code move the VF NIC to new namespace when NETDEV_REGISTER
> is
> > received on netvsc NIC. During deletion of the namespace,
> > default_device_exit_batch() >> default_device_exit_net() is called. Whe=
n
> > netvsc NIC is moved back and registered to the default namespace, it
> > automatically brings VF NIC back to the default namespace. This will
> cause
> > the default_device_exit_net() >> for_each_netdev_safe loop unable to
> detect
> > the list end, and hit NULL ptr:
> >
> > [  231.449420] mana 7870:00:00.0 enP30832s1: Moved VF to namespace with=
:
> eth0
> > [  231.449656] BUG: kernel NULL pointer dereference, address:
> 0000000000000010
> > [  231.450246] #PF: supervisor read access in kernel mode
> > [  231.450579] #PF: error_code(0x0000) - not-present page
> > [  231.450916] PGD 17b8a8067 P4D 0
> > [  231.451163] Oops: Oops: 0000 [#1] SMP NOPTI
> > [  231.451450] CPU: 82 UID: 0 PID: 1394 Comm: kworker/u768:1 Not tainte=
d
> 6.16.0-rc4+ #3 VOLUNTARY
> > [  231.452042] Hardware name: Microsoft Corporation Virtual
> Machine/Virtual Machine, BIOS Hyper-V UEFI Release v4.1 11/21/2024
> > [  231.452692] Workqueue: netns cleanup_net
> > [  231.452947] RIP: 0010:default_device_exit_batch+0x16c/0x3f0
> > [  231.453326] Code: c0 0c f5 b3 e8 d5 db fe ff 48 85 c0 74 15 48 c7 c2
> f8 fd ca b2 be 10 00 00 00 48 8d 7d c0 e8 7b 77 25 00 49 8b 86 28 01 00 0=
0
> <48> 8b 50 10 4c 8b 2a 4c 8d 62 f0 49 83 ed 10 4c 39 e0 0f 84 d6 00
> > [  231.454294] RSP: 0018:ff75fc7c9bf9fd00 EFLAGS: 00010246
> > [  231.454610] RAX: 0000000000000000 RBX: 0000000000000002 RCX:
> 61c8864680b583eb
> > [  231.455094] RDX: ff1fa9f71462d800 RSI: ff75fc7c9bf9fd38 RDI:
> 0000000030766564
> > [  231.455686] RBP: ff75fc7c9bf9fd78 R08: 0000000000000000 R09:
> 0000000000000000
> > [  231.456126] R10: 0000000000000001 R11: 0000000000000004 R12:
> ff1fa9f70088e340
> > [  231.456621] R13: ff1fa9f70088e340 R14: ffffffffb3f50c20 R15:
> ff1fa9f7103e6340
> > [  231.457161] FS:  0000000000000000(0000) GS:ff1faa6783a08000(0000)
> knlGS:0000000000000000
> > [  231.457707] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [  231.458031] CR2: 0000000000000010 CR3: 0000000179ab2006 CR4:
> 0000000000b73ef0
> > [  231.458434] Call Trace:
> > [  231.458600]  <TASK>
> > [  231.458777]  ops_undo_list+0x100/0x220
> > [  231.459015]  cleanup_net+0x1b8/0x300
> > [  231.459285]  process_one_work+0x184/0x340
> >
> > To fix it, move the VF namespace switching code from the NETDEV_REGISTE=
R
> > event handler to netvsc_open().
> >
> > Cc: stable@vger.kernel.org
> > Cc: cavery@redhat.com
> > Fixes: 4c262801ea60 ("hv_netvsc: Fix VF namespace also in synthetic NIC
> NETDEV_REGISTER event")
> > Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
>=20
> With this change do we go back to the situation that existed prior
> to the cited patch? Quoting the cited commit:
>=20
>     The existing code moves VF to the same namespace as the synthetic NIC
>     during netvsc_register_vf(). But, if the synthetic device is moved to
> a
>     new namespace after the VF registration, the VF won't be moved
> together.
>=20
> Or perhaps not because if synthetic device is moved then, in practice, it
> will subsequently be reopened? (Because it is closed as part of the move
> to a different netns?)

There are two cases:
1) the synthetic device is moved to a new namespace before the VF device is=
=20
offered from PCI:
During netvsc_register_vf() >> dev_change_net_namespace() will put VF to=20
the same namespace.

2) the synthetic device is moved to a new namespace after the VF device is=
=20
offered from PCI:
The commit 4c262801ea60 does the move in netvsc_event_set_vf_ns >> dev_chan=
ge_net_namespace().
But it will cause Null ptr error during namespace deletion >> default_devic=
e_exit_net().

This patch keeps the code path (1) unchanged, and fix the code path (2).
And yes, __dev_change_net_namespace() >> netif_close(dev), so in the new=20
namespace the NIC always needs to be re-opened before using.

Thanks,
- Haiyang


