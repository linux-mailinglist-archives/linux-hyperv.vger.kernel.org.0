Return-Path: <linux-hyperv+bounces-5483-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAA78AB493C
	for <lists+linux-hyperv@lfdr.de>; Tue, 13 May 2025 04:08:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6DD35861F29
	for <lists+linux-hyperv@lfdr.de>; Tue, 13 May 2025 02:07:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B2F31A072C;
	Tue, 13 May 2025 02:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="SDNbHFVp"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazolkn19010003.outbound.protection.outlook.com [52.103.11.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D76663D984;
	Tue, 13 May 2025 02:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.11.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747102070; cv=fail; b=in0LgqBNgq79hENvkX9NTWG+iDvrE2uSyDuWINcs4Uig/u8tKZ+wOTq8EZXM9jNvbW3GNwN59kniTZW8RsbG5PnvyJ5pY6uAU4g+IkNtrurE1KjV4ZIz0nuJE7vmeLAoviQIIoSm+LWEmxq3kjfeUEG+n2KbsAysoMjTTWYs7aI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747102070; c=relaxed/simple;
	bh=/oyw7Hy1h12/a14FfwK+NX4TDgFMlav+WGNCGoo9hiE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=AG6SrX8C94CP0phKAjtuEF086YHuwkHioHmuARaLQzSK/plBNHgglhJnHl6s6rTzmX2THLyQd7kfp37/GcNetbzzLCKtUuk2i2m1iA3bNU5FIwL87bk8P76rmoE2Ehu58KD0ND1+7k9YMqAbnjsecct1OcE2rHii4r0bPdLo6kU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=SDNbHFVp; arc=fail smtp.client-ip=52.103.11.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bn+sxmIQJypjyT119HcgeryuAbVjXd3k68Dplmmy7YtolVa4Z95u9Qib7zLxQQfFBBFovfh1M4T13nciAdaS7FIS1uZqIYKLF8KNn868tvcRZJ5j0UYzEP41LAaQEZat1PHWd381ey5zRMP6RPo9+A7Distqn8q2CgmJxdlTPujRmo40e5UhQKuMVtQJ4nLIeQ344xqFcgSBFF/4+k9K9CK5SVry0PodMjMpYF8qDNHYFfYmk9NFKy4wb5JT2y/9dAhgongjUb/FldzYqCadEmIEb42QFXRDOQHto7tLWy0/LxIlKkD71F3W9D75I2upjp4SwK2ovdqDXRfImt/iaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i1vI6pSbYM1m4HEOmKLKQrCTJCH6NFIFMHQM/Pyi3Mo=;
 b=T6iglQ/RFZCE43szyeKGvrYWIUboWlsmzoFrC/jc7VToyscKyW+HzpWNsN8PMxphVpqpmr3oMpwvtG4/HC9W8SEW8D26wVbYLXffZaXtw2/2Pd3M/DKR3Z0BV0wZh0T/Q1AjVINzEqskdm9MEj9ny7OoJNErWxn6M6Ggt1vnGheE71ayhaB78kd3oni+yrjK9zCbj3yrwUSKr8r+oLj1k63Zv+C2bA5rm2d+oxTfpA0JoXtp0FQXT/a59hJqA+O1YReP2dCQPY/2p/D/seXKAlgQ/8UroQwYn7G+9+4IvXxyIMNJFiHDDPdbsWOi/30NT44jBhOZgJpNZ366B3pZwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i1vI6pSbYM1m4HEOmKLKQrCTJCH6NFIFMHQM/Pyi3Mo=;
 b=SDNbHFVpqzuldJVwBQ8tR8heGScvLuARNqshNQVApSHumhvB61DBAHqo++/5CLADdKlMk0yEr1LifNIFJY26uSyysjD4a/LrQAbIug8mIJzNSY1b6gGj0AOpVCmruN6cHwIHPPxjQIhxk8kYFCPgJubQxVTmsXzYzbGSo43KevGNonWoHZnSPs0HK/3z3Nooob+90yYOW+x+prwINVva/MIzWqMcwCYf9rDL6D5rC12zWPLz2BESPi5XEn+mfBvus4sy9NOYCh0Oe8EfjVnNiVfMzbfuCXP3Z9fazM46eBtda9gfVDhB4O9ZiYK8sM2oO8BFveplEt5LhY+5JjVxxw==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by BL3PR02MB8068.namprd02.prod.outlook.com (2603:10b6:208:35b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.23; Tue, 13 May
 2025 02:07:46 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%3]) with mapi id 15.20.8722.027; Tue, 13 May 2025
 02:07:45 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Michael Kelley <mhklinux@outlook.com>, "Gustavo A. R. Silva"
	<gustavoars@kernel.org>, "K. Y. Srinivasan" <kys@microsoft.com>, Haiyang
 Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan Cui
	<decui@microsoft.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?iso-8859-2?Q?Krzysztof_Wilczy=F1ski?= <kw@linux.com>, Manivannan Sadhasivam
	<manivannan.sadhasivam@linaro.org>, Rob Herring <robh@kernel.org>, Bjorn
 Helgaas <bhelgaas@google.com>
CC: "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>
Subject: RE: [PATCH][next] PCI: hv: Avoid multiple
 -Wflex-array-member-not-at-end warnings
Thread-Topic: [PATCH][next] PCI: hv: Avoid multiple
 -Wflex-array-member-not-at-end warnings
Thread-Index: AQHbtgJUCHBVQ2nlJkec17kVDKNMEbO3nz/ggBhLkbA=
Date: Tue, 13 May 2025 02:07:45 +0000
Message-ID:
 <SN6PR02MB4157E7C91785BEA1E597B0EAD496A@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <aAu8qsMQlbgH82iN@kspp>
 <SN6PR02MB41574AAF7B468757A9F9ED79D4862@SN6PR02MB4157.namprd02.prod.outlook.com>
In-Reply-To:
 <SN6PR02MB41574AAF7B468757A9F9ED79D4862@SN6PR02MB4157.namprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|BL3PR02MB8068:EE_
x-ms-office365-filtering-correlation-id: 09d1bf6a-bfa2-495b-cf0f-08dd91c2f3d0
x-ms-exchange-slblob-mailprops:
 7J/vb0KDx3hRy7lV+CYJkolW21Iq60BX2lyfHPZCa+dnx6EyElhP95jFjRk8buPLL81FzSCXkO7eYK4vIOxNWgfx0/V+XsSmF5uL+kKD8ZNfnSyxvBok0QYzYkdFDEzbTnIqeyftlpXs1a5fdKPhRhT7VGqCAveJmReGSAUsSISbqDtHqDwiGVopwRR7yzfW4Oo100MKSJ1wMkHwxzd1JhLYfdtA6Q7tdeEFSZb9C/KyKV4uoGOTviBB0cbqHE9N0lpNLLzkz5rxwJJHwnp/tMmbmt2yQjECmlcEIVv3fEJlKZHZoIO8QAPBPNgghPbpNZkEUdw3n1IMovwZ0fn7avszxnnbh7HRK6QRdyHBwbmkDHWrfpsPOgyly5bNQ2OCjyAGRaJfG8RXM1UTOSALOQDoGPFWSsIyL3L7S3P98GmUkVc5h+BsVhLPsNcOuGTNgJah0Zky0VVvJKhJEA0uG96Rs/EEdvExSCLHyw8kZofne8diCYHLbIzg2vq66vjtzjJ/lT0toexJpnfvC0IONTXsTtkmiv+Bo/51U43t6OZros5fkOIuq6DcVSjmne/Othexrh8SDKpImizYIKnLbVCncigijdqhJwpFQIKYIeuaiZhXQqU4jUpHeEC1nY3uzmOl1tkqEIlDvsfgy/376W0vTdTIfT3uL0HTn7HKuzvS1su5wtubV8B0jjPEGhG4W68fSxPI32jlUCpDzrX8Zcq99ek6XMFMfjEt9kGvnC9sbrA70ccOQAYQUWbNUJmDq/CpupC2wBLb7XuH8IaVeayQmKL2KM4zpwweJErvGL4=
x-microsoft-antispam:
 BCL:0;ARA:14566002|19110799006|461199028|15080799009|8060799009|8062599006|440099028|3412199025|102099032|1710799026;
x-microsoft-antispam-message-info:
 =?iso-8859-2?Q?7rP78nA0xlBZ1/LWV8csnfeMyLTBx1E6Kr5PSJ8EHyfu2Kcz+a+mr2gOVp?=
 =?iso-8859-2?Q?0txMpmSLXZJLXLrpcPYieWBa8FTV6u73cFE5scC11FHOpKb9vO0NyHajer?=
 =?iso-8859-2?Q?pgr37NB6YmSRIMy/e6QNwENFXIRsjHu8EDGpiAso8se98OV+WRhBu2du+S?=
 =?iso-8859-2?Q?DUMJIYdlgF3RhjrRk1Fit9r4En1XlJA7xQ0kmWaLbQs61I2hDeKwKmaRIZ?=
 =?iso-8859-2?Q?nLrdN8nXPxcs3qTlA8uwEI4NZENCY0lXEg0m3N8x4ZkebOGr3/wEk8Ic02?=
 =?iso-8859-2?Q?4C+Yqs2Vkrp2d49i0ANF9SgPWAs6SjmRS0bj8JJ9N6434BI3IkIKh1pftx?=
 =?iso-8859-2?Q?yMGDTDKZK00KHPCB6d0UZWk9aSZ2vp0oRMiAy+CZ+MrKEsTKX37410f+S3?=
 =?iso-8859-2?Q?9lkC1VIjlk97PF4WJ18wiIIvw5EABT9donZTu0xDk5rIsBP6zINlVMNo1u?=
 =?iso-8859-2?Q?38PPQ7/aw1ZTKj2E3ahQpTjlv8S8dG1btE9EyzbVSqgC7ucF1KF7sBp952?=
 =?iso-8859-2?Q?CyMzlfrADQedQ4bBqPkqFDjv1kuL5kqt9gDy7ZGAjtQkLC8RpB/tjtCAdq?=
 =?iso-8859-2?Q?cebSMTEQ6GYynEOmzxs4f6scZE5QDXhpATETmrb77g/FuxTNn3hp/6bUnf?=
 =?iso-8859-2?Q?sZu1LBCtdv72ES4GEaZ5u1DoS/5q3oCDVv4rg/tnfmKuF9UWUIZ2/9XE8o?=
 =?iso-8859-2?Q?YaAzg2d177TtiXEBev1yi8uuvjSq5FeHH86v5TlNO8h//DZqzskhD4oVwt?=
 =?iso-8859-2?Q?CExHtUM8et6M/ZGyU4+MU8VXCnehw/RTuhbF9FmziktjBAcoIx4dl51AiA?=
 =?iso-8859-2?Q?NCK46rfB98/2aaasQKMF4/XMSa5rN3Mugm4BtfhCOT2L/mxdNm7/IQ0kvM?=
 =?iso-8859-2?Q?EKCLMvMhfzj4SDc+QonEG/4M4vSakVJ0Yx3bnRl9X+WEs4hBgpSRDywQqU?=
 =?iso-8859-2?Q?jxq+QukG7l7WUeuGotY/GeNJaieKHB9d0zFjKCRRjTptc5zHmDMSmWlleW?=
 =?iso-8859-2?Q?g9gKT5jOp2/0qF6nPkHDSEzFxf+mKRl9wWLt3+yEx7Tzz3M5DKr6Yp1Vbr?=
 =?iso-8859-2?Q?xsfQzmcPROCUzTTGzXzMX7TImofN5BRjNvDGihSZ1HkXOSBo20pXbiPYpL?=
 =?iso-8859-2?Q?X5sMR+kdAyE1aFj2uIgfrGVpiQhE8=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-2?Q?JS732sDHY53hcIswiEfzxrzS7KECya0HnVWXzFCJ2qip4OYr9HH0tODBOq?=
 =?iso-8859-2?Q?8q+dK59geE9nkfIinnS9Vkt3RUm8WuxDdxBmpTnsH0iQMWv4voDx3MnELq?=
 =?iso-8859-2?Q?8ggtBsDAMDarA9ITw4WgYXdA3q5p2D/QwpDYGFdx2uhZmgYxsl/2ci7Ogc?=
 =?iso-8859-2?Q?EBhcsz0x78rIK022534QyM5DObDnvxazHt12lCR/DlslcEMXkvuYcNchBz?=
 =?iso-8859-2?Q?sz0WVYOTgYRiMWRYGCaMysohSEPKy7sKS2Zk50OK1YFvHlmHecv7AG/5W1?=
 =?iso-8859-2?Q?LiLQHgIF9lIVSlZ1JHraQ8hgdijjqevcsMzefFgpGaBysa7KsKvNNH6huA?=
 =?iso-8859-2?Q?C0PBOejwh94TWdLVrv/KWaErzjTsRC3zGP/r8WnTyqStyBXzWFfU2CKhKe?=
 =?iso-8859-2?Q?hO+3hP5zJJpEsNJZ1rj4jTus0rEcUOfXdS8ogkA0vw1NqqolGACxRRL+2A?=
 =?iso-8859-2?Q?ExGYdeLQ2octkpCmpNxmldQI3g84ztHBcsU/iLZR0BNFwMm1qBV/JLNVJi?=
 =?iso-8859-2?Q?AEzUStKIuIBx7vVdRvt/FFByz5eHZYf2trgcdtnJzKtQEKUf/M8LrFNDVB?=
 =?iso-8859-2?Q?3iyjiqOiVlkwxZWvJ35QASOjkCY/pFp4nO3xXmnpKnyqMTuvMVQtSwHQD+?=
 =?iso-8859-2?Q?qYPkHo/J0ovhC3uMcfEU3Tde7tXV1nJa6p/433/ubo6vK0UCi24I67ZOqW?=
 =?iso-8859-2?Q?mnvYkJrCgyVrXFHGBXTuFgx6zL7F9fQNngmePG4CriOVPdax7/xhmRmKew?=
 =?iso-8859-2?Q?evI2xrwZ4ZaZ+HpOku3Vh71z4oQIvpMZ/4rD+4/wE/8KETijfHMb2PJX30?=
 =?iso-8859-2?Q?w1nbiGp2X37syjzN5FelBHixizRlumOSDAOZHzL16PDN9ikjBH2/2uJOyC?=
 =?iso-8859-2?Q?nKx54XVPMyJXCY1nyge8z02yz7DkkCIFfoc+JyPCsJcTEdG6eOqBqiO1SA?=
 =?iso-8859-2?Q?8VHaFGYRGNW2IbiMfAQgDCsd1Ny9l3dIbVfuNm4l8oi/NURm70UcqD6CNr?=
 =?iso-8859-2?Q?pMsgFY8Hb+4cYNBjdRI+i46KaJ66pUK/fyNpLJpJgJDYDj1vMsB9st8IwO?=
 =?iso-8859-2?Q?N+C76TUbeKw2w1+C9yeI8Mdrar08Z41dntVs8OlwR0oA8FHPRqp/gWykQC?=
 =?iso-8859-2?Q?ICXzIBoQ4MRDLNgJzFvmpni9hopQgW68fBv5/nB+N/NV+/9BbyUHtnZ4Eu?=
 =?iso-8859-2?Q?wrAPlJclEctHiV7vX1h6Ru3czne+4dQgpFapvcJCFbZA7fSGl3phSqNZt9?=
 =?iso-8859-2?Q?YbzBq70M2AG80nzhiP8YAIWiw8dmPfgU3CfpSCnyM=3D?=
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 09d1bf6a-bfa2-495b-cf0f-08dd91c2f3d0
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 May 2025 02:07:45.6079
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR02MB8068

From: Michael Kelley <mhklinux@outlook.com> Sent: Sunday, April 27, 2025 8:=
22 AM
>=20
> From: Gustavo A. R. Silva <gustavoars@kernel.org> Sent: Friday, April 25,=
 2025 9:48
> AM
> >
> > -Wflex-array-member-not-at-end was introduced in GCC-14, and we are
> > getting ready to enable it, globally.
> >
> > Use the `DEFINE_RAW_FLEX()` helper for a few on-stack definitions
> > of a flexible structure where the size of the flexible-array member
> > is known at compile-time, and refactor the rest of the code,
> > accordingly.
> >
> > So, with these changes, fix the following warnings:
> >
> > drivers/pci/controller/pci-hyperv.c:3809:35: warning: structure contain=
ing a flexible
> > array member is not at the end of another structure [-Wflex-array-membe=
r-not-at-end]
> > drivers/pci/controller/pci-hyperv.c:2831:35: warning: structure contain=
ing a flexible
> > array member is not at the end of another structure [-Wflex-array-membe=
r-not-at-end]
> > drivers/pci/controller/pci-hyperv.c:2468:35: warning: structure contain=
ing a flexible
> > array member is not at the end of another structure [-Wflex-array-membe=
r-not-at-end]
> > drivers/pci/controller/pci-hyperv.c:1830:35: warning: structure contain=
ing a flexible
> > array member is not at the end of another structure [-Wflex-array-membe=
r-not-at-end]
> > drivers/pci/controller/pci-hyperv.c:1593:35: warning: structure contain=
ing a flexible
> > array member is not at the end of another structure [-Wflex-array-membe=
r-not-at-end]
> > drivers/pci/controller/pci-hyperv.c:1504:35: warning: structure contain=
ing a flexible
> > array member is not at the end of another structure [-Wflex-array-membe=
r-not-at-end]
> > drivers/pci/controller/pci-hyperv.c:1424:35: warning: structure contain=
ing a flexible
> > array member is not at the end of another structure [-Wflex-array-membe=
r-not-at-end]
>=20
> I'm supportive of cleaning up these warnings. I've worked with the pci-hy=
perv.c
> code a fair amount over the years, but never had looked closely at the on=
-stack
> structs that are causing the warnings. The current code is a bit unusual =
and
> perhaps unnecessarily obtuse.
>=20
> Rather than the approach you've taken below, I tried removing the flex ar=
ray
> entirely from struct pci_packet. In all cases except one, it was used onl=
y to
> locate the end of struct pci_packet, which is the beginning of the follow=
-on
> message. Locating that follow-on message can easily be done by just refer=
encing
> the "buf" field in the on-stack structs, or as (pkt + 1) in the dynamical=
ly allocated
> case. In both cases, there's no need for the flex array. In the one excep=
tion, a
> couple of minor tweaks avoids the need for the flex array as well.
>=20
> So here's an alternate approach to solving the problem. This approach is
> 14 insertions and 15 deletions, so it's a lot less change than your appro=
ach.
> I still don't understand why the on-stack struct are declared as (for exa=
mple):
>=20
> 	struct {
> 		struct pci_packet pkt;
> 		char buf[sizeof(struct pci_read_block)];
> 	} pkt;
>=20
> instead of just:
>=20
> 	struct {
> 		struct pci_packet pkt;
> 		struct pci_read_block msg;
> 	} pkt;
>=20
> but that's a topic for another time.  Anyway, here's my proposed diff, wh=
ich I've
> compiled and smoke-tested in a VM in the Azure cloud:
>=20

Gustavo -- Are you waiting for me to submit a patch with my alternate propo=
sal?
I had not seen any follow up, so wanted to make sure we have clarity on who
has the next action. Thx.

Michael

