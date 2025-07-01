Return-Path: <linux-hyperv+bounces-6065-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA892AF02E0
	for <lists+linux-hyperv@lfdr.de>; Tue,  1 Jul 2025 20:37:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 05D2B4E4F08
	for <lists+linux-hyperv@lfdr.de>; Tue,  1 Jul 2025 18:37:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54811271442;
	Tue,  1 Jul 2025 18:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="ABBoQ4B3"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11020124.outbound.protection.outlook.com [52.101.56.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0FD523B618;
	Tue,  1 Jul 2025 18:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751395026; cv=fail; b=Xb6tEAfgLF7Z/B7roEx159Dq2st5xdk6QIjQg/JICG+0ac1MtW3ZSSWKqKdN3y71iFvp9L6vNrHOOTNq9vubmAkre8vanoa3iJ4flInMUtWW7/Bw76N+VMMFI+vcd/JmOoHtEwix5tIqVdimARdc8WIyk1o37mPmRii8Nif/x8A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751395026; c=relaxed/simple;
	bh=CtGGhMGXh3KAiKuST2Y+KaVZqHANIFQai2vDLLEvWvA=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Q6tQEL+xPNG6SRrgHqqx4bfQFewaAyRd9U15QYTXKVnLA0IMLEWfTJvpf1fEpzsNYr8RiarTizl0X0LkvX9VMvsBU6UJ3a5XAwUxA35Cr3DZROc1jYBNpLG0gifwIbPD00HqDHhxMy1304+iV1HjH3wNJfU2bqlXpyIOADpSDNk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=ABBoQ4B3; arc=fail smtp.client-ip=52.101.56.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=umF+JJGHkFbFZfrETG7b86jhyivXQHwrZHWsNrHoLZimi/TaLB4DQoYCDA4cnvn2SOR4vJAVsILcbu2F8YsoI3qMM+1tWtRyqB2SuNIHGYPKLydAVrpKHb/oNcRl/dZ/mHB7ipip3f9+uI1asX2XtTsqU32Mh3cbo9fQDE+PgzUz/YNG/RRASi0MT/5p3Lq+Dk3ktGgtnkFfe2IquS06wKnbmuqj8UFSHzTcWnTHT2L7/r1iIKOAYnhe3rhcwkTnrkjioAyxEIF6jOvQfDQOskY5VHA423+esrvf+FxLheRW07tSk4tlHVdpGrhsn9zsJcHsl87SJDMM0xGA0iDANA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NxixAyFsi21344bZ3phQTbZNxHkjxkBn/tY12g6ZGyY=;
 b=dZSdu/ui7JM5gVBjzZ1WbvvwnncV+fAXl+Sd2DYdnWrKud0tfy4omTx960C276r2eRbUo7KGNKKS/BoN8I6Lr8BBJ5vYeTFAeYgXLWIDwVdj98UbedfAj0N8IcfUoDxNR/zCZXvA3KD+pnsmEjk/B8u+LNMK0QWJspvkO1wNVDnUQJEzP01aN5kaiYpTQPZedUeTW+9r0RAK0UkxGNYH2LJ0jUqdVWxRx6xpSulB75tDX2sZVSWJepKFXENIoKjna73y+kiTsRIyIR75fYIWNGg7tn5HAxK3ijDy4rZxWcklsasj/F3PyBonwv8caKTR5LmPps9cwO25mWxi4hlxBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NxixAyFsi21344bZ3phQTbZNxHkjxkBn/tY12g6ZGyY=;
 b=ABBoQ4B3QckB+B90aCjJ9K1yQSNfQ+N7PQ+cgTBAu/U5QwIVrxRm2NJBjMU9lrdpUuRjvUKDXg9iXBX+tlhZS0zjJJNgGLZZhww+8COv0FQvo6cMW2z+S2ZEM7yTe9M+B06WtYxUPtTYQOAB7Hp9IDBhGq3YJ07hFieKEl1mUig=
Received: from BL1PR21MB3115.namprd21.prod.outlook.com (2603:10b6:208:393::15)
 by IA4PR21MB4738.namprd21.prod.outlook.com (2603:10b6:208:5d0::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.11; Tue, 1 Jul
 2025 18:37:01 +0000
Received: from BL1PR21MB3115.namprd21.prod.outlook.com
 ([fe80::7a38:17a2:3054:8d79]) by BL1PR21MB3115.namprd21.prod.outlook.com
 ([fe80::7a38:17a2:3054:8d79%3]) with mapi id 15.20.8901.009; Tue, 1 Jul 2025
 18:37:01 +0000
From: Dexuan Cui <decui@microsoft.com>
To: Paolo Abeni <pabeni@redhat.com>, "niuxuewei97@gmail.com"
	<niuxuewei97@gmail.com>, KY Srinivasan <kys@microsoft.com>, Haiyang Zhang
	<haiyangz@microsoft.com>, "wei.liu@kernel.org" <wei.liu@kernel.org>,
	"sgarzare@redhat.com" <sgarzare@redhat.com>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "horms@kernel.org" <horms@kernel.org>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [EXTERNAL] Re: [PATCH] hv_sock: Return the readable bytes in
 hvs_stream_has_data()
Thread-Topic: [EXTERNAL] Re: [PATCH] hv_sock: Return the readable bytes in
 hvs_stream_has_data()
Thread-Index: AQHb6oi+hMA/ue5ibE+V/ntK7sbHS7QdmPeA
Date: Tue, 1 Jul 2025 18:37:00 +0000
Message-ID:
 <BL1PR21MB31150AFC712FD1B83F41C207BF41A@BL1PR21MB3115.namprd21.prod.outlook.com>
References: <1751013889-4951-1-git-send-email-decui@microsoft.com>
 <346e4b8a-2e62-420b-9816-6a35b8b63da1@redhat.com>
In-Reply-To: <346e4b8a-2e62-420b-9816-6a35b8b63da1@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=7cc13f30-b476-4a7a-9b3a-e56379814f75;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2025-07-01T18:36:10Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR21MB3115:EE_|IA4PR21MB4738:EE_
x-ms-office365-filtering-correlation-id: 2ec99d64-efe0-4c8b-35fe-08ddb8ce44a8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|921020|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?NJtq+16nmyLutJn3rpW/bz+mT3cIUZsQ9iY17frsIfNVO9DlaQSzix6RMi98?=
 =?us-ascii?Q?lxqGiioAlNLY53yhwLqM8+ecLJyryTxB5fCsiFJSWFgnaUJdsD8CD/9kegL3?=
 =?us-ascii?Q?f4Y690h133Iy8gsPk88/aN2V7O6pylEja+bxdlBncjEg1V2rGw3IW8+PdGjy?=
 =?us-ascii?Q?nWhi6LTs0JQL5H1yv5Mn18dWT92VsNxJsGRNFxcLifwvaWz0BoxjyEzWrDwY?=
 =?us-ascii?Q?Vu7T7WEODin73Xr0OUfCT5hptuSk6cOKBeba0jjRVpt1okm9E0HZNxTvxU01?=
 =?us-ascii?Q?ngacpdqQTB5cNQ3y82tAhBEFFaLXWZ0DjnGXYg27/juk2S0MU5FjVsw6NIc0?=
 =?us-ascii?Q?5ePeuqLCBRlcankDRIDVR5RZx2w8fpY5cioz5YYg/4xBSaFMrjGuV0JDN2Kf?=
 =?us-ascii?Q?m7x1C5yeZQmGahgMq6QV7g+vGgtlOmOdIPopD7DInvcVeb4p2yIUubaOGV/4?=
 =?us-ascii?Q?oPCTNhHzXNHNhrhgMQDzGtPRMbXHGAaMlkxxpE7DKZ4KTX5l7ZXb0jNphDEh?=
 =?us-ascii?Q?RNogqpEFCt2J57cANGUUE5VOFnjztgApkwnNiOQvEccorjvbWivtt63sGDFk?=
 =?us-ascii?Q?dv1hVwzN323Rvg2gQq0+NnmoPwdHuLZPcWcdgEq4tnBUxbl/5rwFZ+BtZCZp?=
 =?us-ascii?Q?X5yvJt2GPw2WtF5zg7n98gGZAIeDjwEBRHVIrtDwXyOR/7CrTwLYc9IZIHdM?=
 =?us-ascii?Q?N1190XFm3eL25Pp5rMZUacgS4M7iTQH0Ofzgnun7FrmS66Kiw795FjG+7WZ9?=
 =?us-ascii?Q?9ql87QDM94CcrALl6l8sTIpx8EKf3ldjOUUT4hn68n5OLVRsL5mgzp4Glagf?=
 =?us-ascii?Q?xTLS7BBZoMl3cJDnUVlPxfaRnETQC3gCWqiLk9e7DZADY2vDdo8M0qD/PRMk?=
 =?us-ascii?Q?/1zG9n6avxMC7nc9fQ/WdCipHzFt1e/o6XlLNpTLo7neYNCfUzPFDgOykYNt?=
 =?us-ascii?Q?Mef2BD2sIksam1hcf3es36oQRnuXdAUbxLKkEFv0VEazYeJyFif62yixY6NR?=
 =?us-ascii?Q?rbq636yc+OPnX0T4W6lSG5oqAkdKbn6+z+0MI4Aqn8MgEIUcvDIFt1s/zv54?=
 =?us-ascii?Q?HTYOG/aUpXDhY0bbOD/3BB3GwVFIzR30iFw90ULuG97Kea4OSaFQwCSW3B0w?=
 =?us-ascii?Q?Kf4poZ0FGY0paHGBh2DN90GZueB2hP4tzSWZxwovbNRPBlANgzsK4PAYQSBb?=
 =?us-ascii?Q?/xcd7+DPcQF+1Lv85isRv9qEgaOdqR5Beb0W/XzMquJ/ZLE6heRj3r/6t7sw?=
 =?us-ascii?Q?e8iXR3LuL9ePg9TopTRis1OcCAWoHFeoMcFId+NP1MRaCqzVr3pP4K+jhw7A?=
 =?us-ascii?Q?9LEIgnLtSCdpl8taHRBzLdks38YtDwUPfpNXmOqJYdZ/8Tnmpf/fp5WtkvkQ?=
 =?us-ascii?Q?nrWQggBDfsd81q08b9OJLkGJjZ/UxaIOZAmTksEn8A77n0kKm7VWlV4AGmIU?=
 =?us-ascii?Q?iI83ymh0Q8tOVGtcv8FVfW/UCZkccf87g6ZtWqCeJYYSCGZsAHRjDuJVknX3?=
 =?us-ascii?Q?sueVMMrNfz8now0=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR21MB3115.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(921020)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?1k5XE8Q5M6h3oiFtLp0PkCwH3EUVdhg6aEvhgofWsGoG5PvmB52fAQ0DfZ4U?=
 =?us-ascii?Q?tNoNEaeCzVagPmYaoBpQLCm3hPSilgw/RFReXRvGOjkqnt8+TACC6XiiaaEd?=
 =?us-ascii?Q?j6fGq/210rBzO6KfqkjoAqiZFowVMIYddTCXvkfMfN6Lq+59zzuM5r6jHX9x?=
 =?us-ascii?Q?HJjdIsu8RzHweHjSUTfiJGNyo4Z6FnaZIb+6PJ5ZtQJywajpq9/hKMhQSgVH?=
 =?us-ascii?Q?17OzJ/3TVMylu2QuxfFpGJmKqnjLjyoQ8njbGi9gZ8ysP5q/QGxrfhUQrXE4?=
 =?us-ascii?Q?h9XWftjAf6QAdVau83SSeCDOY04F2FuhSvSGFz+xybODgMJYbaCmAxkVh+Q0?=
 =?us-ascii?Q?SzIZ+jGwYZ/uv787yf4P93d/VbcJsECFq6pc44BSoTID9nuBdxXbHI7NFrEQ?=
 =?us-ascii?Q?acac8U4P1GWiSnpWNxdjJJeJwJqkN8y8DfRLF2KYLpLc3YkVl4jE72aIGqtn?=
 =?us-ascii?Q?Kw75R0QdgQADCjlLKa9tYaMtj7nLsGMa0QEFKHQMBvG7N/LEm1hG9TQy42Zc?=
 =?us-ascii?Q?oYqXGkVakgZiKYaJqNrTLS/HxdVoMnj9tva5HDyaRSjPOdKaoC3zimcqfKKQ?=
 =?us-ascii?Q?BONjxzEXaLX2sb8umwtQKYkZJ6Hj96QgSia0vOV1prTKlTSIvbgfFfUwhqMO?=
 =?us-ascii?Q?lEVmr/d0ZKC+jxnTDpv8jdtUBAvQfH8ooZI7WNVYyXYuwRBlt5SBNIVYiI6Z?=
 =?us-ascii?Q?P2rUohtqhmOcqWMh+eokS5ZvUBZDZhOoIsFqOWpW4UBeSaz+VmtCNCWVIVbA?=
 =?us-ascii?Q?K7Ziln55omyXAAwMnM3k7oWAFwZUwe7UxLLmhAHwEbMKRZy2H5AsxOvDSGIu?=
 =?us-ascii?Q?aMAApjhzpZCNLp6FyJvxDLh+cFWYgw2FubhNh0vTaoE/ak5tCWNVhTfnuFbn?=
 =?us-ascii?Q?JmALS8FN580Hk4LlC9tvrLHmLu23IpvoPmiclM8E9jA/3eCBiYL6OH/RzDj0?=
 =?us-ascii?Q?m4AkjgbiSxZ67ajWToplR7wE177i/L7W1SjDe1OPN8u1fLZjrffsY3qjrSNE?=
 =?us-ascii?Q?WIBefjKxpxSJSQqezj3YQPpyza+6jXNKFAM3fq0GX230T4qwiIPwOwOr84+V?=
 =?us-ascii?Q?cw2fDBAE/fWVCnEPF7TafZ2YnJd+saRBELpfGWKiBXOnH4wuyBenxtcuPeF7?=
 =?us-ascii?Q?1xRlpjdPySHt7TTKJTJ6JM1tE0jKLOl1r3quC46nDtV6QIzfuCGXEqJdd+Vi?=
 =?us-ascii?Q?kcZHk1XUpSx4XerLRjlvVLt7c6lEutJf+nfePfPLMEhL3N3cDvov7Kd+osU5?=
 =?us-ascii?Q?xAsgXs9vtoHRUf/3PSFd/tHa6/2t9lhOeSDaJ7idMLHJvpZm/ZA5dUIVKnA8?=
 =?us-ascii?Q?0PMyiO6g71USPueuHfHuCpHs/VviJ0Cd7sPZ2HLlQTWl8ZGZlvBjFq2FYB7m?=
 =?us-ascii?Q?gM4DVljxnhG96H+wzLhCYQbtAfQU2fnQ9j9TZbDb9mATNAkqBbOXxIEP0mRg?=
 =?us-ascii?Q?MI/K0AKhLWJ1ObPw/REKH2qouo8Ub9ebq9ovlA7Yo5UTJVGdiaxZpZD12/cd?=
 =?us-ascii?Q?I52qgI2DH+bT9I3eSggs7sy/nOmDvE7VvbmEmGfw/tjmTiDX2M1yvXFkicTi?=
 =?us-ascii?Q?2mYa8vaU+ypubJ5hWjOxH3K5fS3ogMJbPVIoQptw?=
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
X-MS-Exchange-CrossTenant-AuthSource: BL1PR21MB3115.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ec99d64-efe0-4c8b-35fe-08ddb8ce44a8
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jul 2025 18:37:01.0331
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VVwKrEsZcOKutFeDp0L0JRZ0ERRes3lgGpFlKi/ltHwSlwjqq8DJsVHZi0njCxj3F3yKDGLhNwKjpzyEG7RYbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR21MB4738

> From: Paolo Abeni <pabeni@redhat.com>
> Sent: Tuesday, July 1, 2025 6:05 AM
> ...
> >  static s64 hvs_stream_has_data(struct vsock_sock *vsk)
> >  {
> >  	struct hvsock *hvs =3D vsk->trans;
> > +	bool need_refill =3D !hvs->recv_desc;
> >  	s64 ret;
>=20
> Minor nit: when reposting please respect the reverse christmas tree
> order above moving 'need_refill' initialization after the following 'if'
> statement.
>=20
> /P

Thanks! Will do.

