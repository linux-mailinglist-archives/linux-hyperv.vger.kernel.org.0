Return-Path: <linux-hyperv+bounces-5541-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D76CABAA6B
	for <lists+linux-hyperv@lfdr.de>; Sat, 17 May 2025 15:34:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F1EB189A254
	for <lists+linux-hyperv@lfdr.de>; Sat, 17 May 2025 13:34:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30FEF1F462C;
	Sat, 17 May 2025 13:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="FD7pkKPo"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12olkn2093.outbound.protection.outlook.com [40.92.22.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52DBC1F180C;
	Sat, 17 May 2025 13:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.22.93
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747488865; cv=fail; b=tH95bWIfnpQkha35kp7I2uSGWupG7Nm3FKW1M4LSi8ARfQOUTBwKKcyDJsnl1dToE9UJBGUa4gd+zXHe0J4p5Q3dLmvLeMmCwJR3MYo5lefUjo26SlytW8PNLIvmdoafL3Mu5KDjXY/OpHafoFjck7cMnT3Y+gJOZDF2orRYdCo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747488865; c=relaxed/simple;
	bh=XX4yaBnCttGxpZrIDqtMf5WTMPG+wSHaFZm5Bo94HFQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FxGeG/KUrA2gKQ2W2EK4UJdsU7qP2OzDyI6GEvi7gjaS1M13Q68ppecr5h/jqUIOYiRPf+4/TCJVV6nPyBkeh9/biuZrRKzQiaUl5GOdQ+zVIVWTfeLFr2Mf3NPxqId6C7AQTZw80TR32fN0Ac4cJf/oPenY8zWwI61jzxUCbPs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=FD7pkKPo; arc=fail smtp.client-ip=40.92.22.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NujxyC/4peQ6bLa5uqCtr0PSWnmFUZ/LR3AlHyjnUhklTyXGIbcBOe4cRQhWGBUvZX0Q1z/1ggtcbqe7JYRCqmv3JRnYGi0EOKW5BMETJpkpI7M9kZALsdLNcYSERT/Pfgx1vkNiWGbbQ6UI8lyJhG6xOqX5NtgfVimtSN9mgE1o9gAnzC/4fdTYATbNokgAZFRyPi4Vr96P1bz5Dx22E6j2uzxLsdaKhRnYwoMZj+DI+D0DXEEZs93wQT8XK6zd9Wevz4a+s9vEpXnM0BuQrO7FbFszn/IRl1/et/LmSA6aahGdwo0mCDWV1hXqLku9NYIN2ptSjBohfe+4UrI0XQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XX4yaBnCttGxpZrIDqtMf5WTMPG+wSHaFZm5Bo94HFQ=;
 b=u+aAxRAWxzcEP5ADF5WGEcR1XVp3hoBtAwfSYZnppc8n/KmKllvK99wi2GGUSUSujR29n2bX/GoyyYwbStS5wT7UIe5RsXEB9zUgv8c3TPHj4PT2zbZqaGA93ZJ1HDLtO0vlA98vlGMDjLhe91Pw/cu+4XeA5U/89MliKc7uyuRzXVKgboo7R6c+f+Iw5Jt+Po77dTNa3mS1EcAC8zBSHyjiXODJszVtQe1urOmDYu1tfrEPNMHs8YJvf16o71NQ10+hOpNR40bdZjO9OcLzxbE5KizWs25BKbu6Ly5Hghd+LtnKGrggxSbrG+SrnYstErgc8tDJ9TL15Tv+faScFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XX4yaBnCttGxpZrIDqtMf5WTMPG+wSHaFZm5Bo94HFQ=;
 b=FD7pkKPox7OeR89EWdL37ph5GNtzNlYxLmHJFnrboGEeywIIhTJd44jUWb6XQiony79bVKK4scGoMqIajNnAOjHDQcQvJWcfcBJ6HdQqbyzd666w+i0wJ2iHnfaUgHrmHr6L3p/r9BAVbLuINNsD9Zl/+sjrH+SzigtBYPegUiTzqzNqCme3y/8sDoGfD8+yLC9V3P7rr5JySKgleWVztaxb7QczcLldFiBavWgSnoVJLlPzs9gXsbt8aq1sG/b5ynGlpPExDPb2+atOQlNnYwIs4/vzqKfhg53BHn11z9UndfUQPGeF4vxQ6S+eHiNjMN0/LD2x3TmOaWt0AL78CQ==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by SA1PR02MB8400.namprd02.prod.outlook.com (2603:10b6:806:1f4::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.23; Sat, 17 May
 2025 13:34:20 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%3]) with mapi id 15.20.8722.027; Sat, 17 May 2025
 13:34:20 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Saurabh Singh Sengar <ssengar@microsoft.com>, KY Srinivasan
	<kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	"deller@gmx.de" <deller@gmx.de>, "javierm@redhat.com" <javierm@redhat.com>,
	"arnd@arndb.de" <arnd@arndb.de>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [EXTERNAL] [PATCH 1/1] Drivers: hv: Always select CONFIG_SYSFB
 for Hyper-V guests
Thread-Topic: [EXTERNAL] [PATCH 1/1] Drivers: hv: Always select CONFIG_SYSFB
 for Hyper-V guests
Thread-Index: AQHbxr50JRYwwviVjkKTy5BtFNRPi7PWPWqAgACTq0A=
Date: Sat, 17 May 2025 13:34:20 +0000
Message-ID:
 <SN6PR02MB41575C18EA832E640484A02CD492A@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20250516235820.15356-1-mhklinux@outlook.com>
 <KUZP153MB144472E667B0C1A421B49285BE92A@KUZP153MB1444.APCP153.PROD.OUTLOOK.COM>
In-Reply-To:
 <KUZP153MB144472E667B0C1A421B49285BE92A@KUZP153MB1444.APCP153.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=7629be49-67cd-41df-bae8-102768aa5e60;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2025-05-17T04:33:58Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|SA1PR02MB8400:EE_
x-ms-office365-filtering-correlation-id: 10a81cac-d17a-4fdc-3fc0-08dd9547878b
x-ms-exchange-slblob-mailprops:
 dx7TrgQSB6eredufKlHx3shQhUbyqdtFW8IHWtjkRqRLhZTf/ooJa5dgsqDafpX/XT9vYI4c1NofbpenHNcsvNVQsaL0fs6l3lvbhLKbo8IaK+LMU1txW7jG/O1d/bemkPzEAwnLb7QDG8Re9QjujNbKl/HUa3FNnjmEyY7jJU5dRwF/5M9hhWyAkbMm5KO9pzN+Geo2U/Wjqep4MpWrYmyIRI7hYDqFEchULt08DzFjRVWK/MzTZgK/3AVV8ASTB+xklxuIT6mPNdujS/0s3Z9EBcgYxRWpr1BNB/XLR3nDWOMJZUcQLtf0I0obtVb/T78bmKWbOsBubsmPqvSF+apfkXLND58oqx69AKK1Hl7YlyQSyZULOVJTw2UZuzbGWkQV09extYvEf4JpS9+mvGJur8FIhdbnED6dbMoANw7Lh+vmQ5Zz4YvF1Vdi7sULcs4fWS1ti8n+M0047+XjCSPLg6IeU5+AQRb1di7zT8lPMl0+umu3MHyvZ6uHECMxxmMPrUSdakLLIPGLKu9Q/aQSrhbhGqZngCuVQ0UpGtg9Px+BJQN3IYIBLzvysiGWRT3HajvFkoo/I7IcWsZnezfivqBiBDxXzYgqmYvQ9eVhCMPUi7PdtG2Gp5NBZMdjDu8QKLH90FmyAqia6XoUrFm4fzRv7+llW2k2qeXqdHyUdfOdL8AcivN7XhnDQtpXcv1kjbGEOcAEC13DeQseIJEv0RyFJeR6DSkSq6v+89kpVgMwTwPGDtjbA9B0hg1P/D7kjlptPBE=
x-microsoft-antispam:
 BCL:0;ARA:14566002|15080799009|8060799009|19110799006|8062599006|461199028|3412199025|440099028|102099032;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?oSt+iBIJ9dCZQUI7xShQFZAPv2TLYknTeQ6E+Zi1bKXmWS8IUEYgh0fbQbVm?=
 =?us-ascii?Q?04ITITb846nGo6zybFBsoOwhXdr4KLJI7OJyEbvnOqNx4+bFKEQPl1eA7xFM?=
 =?us-ascii?Q?Ux1rYPUwm4NwqgL3hByjqgTv+r4pkjdRTRw2kglpwNc4nIPx23srYd6U3tg5?=
 =?us-ascii?Q?E70DBiC5S/Wn1LBtyO0P3EsGKnH/woFEo4MKRyw49LBjDPfaoCF+6JXSMu/g?=
 =?us-ascii?Q?91u036GIv6f8j/iwJcLbo89p6hv4pUR7o/T74tivuorVJSa4MNSy8Gi0UMpw?=
 =?us-ascii?Q?UwB4v9q7Q7zDp1TTiV+Hbi7prZ0kVQGefcIDduN0gicN3HBEBfORnCe131+z?=
 =?us-ascii?Q?o3+cWpZZObptuVcMHxpeqNrECmmmHTfCa/X5xSJqynQK8hSwrcPIf7R4eyFp?=
 =?us-ascii?Q?xz1rY/Q0Zz/UtV/oItGNvGH7sXgcRWf7P636GLt+opP+w1LZ2lSC5LLfwjBN?=
 =?us-ascii?Q?/PF+/3D9nUjNRkhpMDHB9zK1bj8A+s3pPGISH2G9zKnVhH4iwSbxxwG1RDE/?=
 =?us-ascii?Q?pnL7cX9mOIntoW/ae2vPlPAgsCG5VDiiiYzCzWVUnDoYBgC4meUwxWtPjBM4?=
 =?us-ascii?Q?sV74bP30undc0gJ5BIelpuALlqfl3WVS98/DUBEiVb45+D7ktbfOG3pd/wN7?=
 =?us-ascii?Q?cJgBhgniY0Mcf2oexdn9RYv6+/P2JXh++kBfzqJKiJx/FXa1tqy4JNjL3dCL?=
 =?us-ascii?Q?DoolYmi+SnyTNtEgO9OmYU+tixq7v9gblWgIik40G7tdeNGiQ4jVoVlxqUtj?=
 =?us-ascii?Q?S+GJtMOTBq9GyG5J6tR2b2yGqrNkcMRHMKTfNSr72pM64ErIIZgPMcGYBhkU?=
 =?us-ascii?Q?/CaJfvvdY8y6P0QK+jj9c12mFPItQY/6pghXFAgORGyFMIK4Ggb87V4pVOr6?=
 =?us-ascii?Q?R9XACygWI79ynSGlbhTDGzXvNsqloUGqEOGRB81lTCmHwbCcWqosv6uHahB0?=
 =?us-ascii?Q?y/6gETWsdwYUbI6tFkZfoUE7b/gizo4L4v91w2JVns+UYq82mLc0ojlfjLro?=
 =?us-ascii?Q?eVPQPvslAR1KTTd6qb9Od5iQag2PNuUzdM8mySzJS2MHllUdPeuqver+mMOk?=
 =?us-ascii?Q?iC9TNBfH9jGvHRJypRbi0USIaa/k9w=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?R/EpANg+UQ2MwXcsd06RyHZgRb+XOwjfMhqESy/x3FPK5cm15rcyanMG/nuO?=
 =?us-ascii?Q?Eh7hLCVQaIN6tF55XuDC2ZbFlKVjAD91zmJOBU4fWALGK9DmLrzYsuxhEz4e?=
 =?us-ascii?Q?sqPLfGS6RKSWmvPvx3mg/8zuhxfIxSlvTmnRpYFm920sITco/8wgkmy3JbjG?=
 =?us-ascii?Q?+8udmsT4TMQ8O7zGvOtMEhz/tliAnx1ZArt1GH8axzXqDDPODoZtv9ML1iUv?=
 =?us-ascii?Q?tiftqbGZ4j6mxzsaWcXmvyRJuoIkE4+QI7f1MLNPAxauQzTgsAuehWe2neWX?=
 =?us-ascii?Q?gY6KNw7F0p4V3WP5QIz3pGny+rrAMliS2z9O3ubrt2U2+LCIX0LIKlrxnTCs?=
 =?us-ascii?Q?xJHJ52lgYmCjhD4uPNJz70rmhlsTCJpTxmoQDoksaJ2trUO+8BxeXpu78DGl?=
 =?us-ascii?Q?kT3g0hWZ2Y+5UreNz2ua9XQ63+n2t/81s6OFu9joiZ/25lCreWU2zqeYnj0G?=
 =?us-ascii?Q?kVEhJJxMaZO/skFt289UN5KZZ++ZIJJAZ1FoKluIwMUt68gq6jwsT8Zqo1kD?=
 =?us-ascii?Q?oaiZ02nVU8WLMMJh45ZHQtCZwPogU45Y8mDOOIQ9CsRCV+p3HYVtjiJK9Yn1?=
 =?us-ascii?Q?qfnxDNu3f+bR2eA+er2f2nr0B1KmWI4yaWxpIMTQoGMl62WikdTCXMM7SLdW?=
 =?us-ascii?Q?sh44/wfiJHCUws418vqMRaXE+k0B/Ef/VxcKW7Kz23d1aGz//BMoiNJAwncv?=
 =?us-ascii?Q?Ri3JnCHQWa0+tXol3TB+p5ftfCC6KfPJfMoUKfQne6y8xAdYba8M40IKUqwP?=
 =?us-ascii?Q?/TR1yvaOoJiA+lbGUxbzvZLK+2ypRC5otsif4wEyhyov8VJD9F+p+ZuPZj7X?=
 =?us-ascii?Q?yyTDrYwVXBDQ4tGuhs05qfrcqIboidppHTOOEvTla7yrUdN3g+xjjNt/u+0L?=
 =?us-ascii?Q?BM0CEbdXA5StrAmydSKLVMDVxHLMyxZR8QaJe6OMPznml19abjqMFr4U3uxy?=
 =?us-ascii?Q?WSsBl71SZyd+5WyufKa5eJsLeU8XgLe/u57A6xAhX3AxV0I3GXxbJtGcMyE7?=
 =?us-ascii?Q?pACk6niU/OGQ9DKAdEcZFGnDdIj7sNSgMle4Ck5H0ShuswDqnX9shGaEqhbs?=
 =?us-ascii?Q?METfwsWXlDsVpUpft+52vPrIOGFOe/K0ieRcC5op/4Kziok5dXmuNe4pOpNQ?=
 =?us-ascii?Q?95RVyiysugMwW3Tb0xL82ULU65GjFAz7CDCG8U7F/JDYgTBhCOKi59QIl8AB?=
 =?us-ascii?Q?s4RZC+u7D6s1DG0CHDKaAbfJshafq2CaAawKJ1JkK6wPBdX1/fsIH7781M8?=
 =?us-ascii?Q?=3D?=
Content-Type: text/plain; charset="us-ascii"
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 10a81cac-d17a-4fdc-3fc0-08dd9547878b
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 May 2025 13:34:20.5167
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR02MB8400

From: Saurabh Singh Sengar <ssengar@microsoft.com> Sent: Friday, May 16, 20=
25 9:38 PM
>=20
> > From: Michael Kelley <mhklinux@outlook.com>
> >
> > The Hyper-V host provides guest VMs with a range of MMIO addresses that
> > guest VMBus drivers can use. The VMBus driver in Linux manages that MMI=
O
> > space, and allocates portions to drivers upon request. As part of manag=
ing
> > that MMIO space in a Generation 2 VM, the VMBus driver must reserve the
> > portion of the MMIO space that Hyper-V has designated for the synthetic
> > frame buffer, and not allocate this space to VMBus drivers other than g=
raphics
> > framebuffer drivers. The synthetic frame buffer MMIO area is described =
by
> > the screen_info data structure that is passed to the Linux kernel at bo=
ot time,
> > so the VMBus driver must access screen_info for Generation 2 VMs. (In
> > Generation 1 VMs, the framebuffer MMIO space is communicated to the
> > guest via a PCI pseudo-device, and access to screen_info is not needed.=
)
> >
> > In commit a07b50d80ab6 ("hyperv: avoid dependency on screen_info") the
> > VMBus driver's access to screen_info is restricted to when CONFIG_SYSFB=
 is
> > enabled. CONFIG_SYSFB is typically enabled in kernels built for Hyper-V=
 by
> > virtue of having at least one of CONFIG_FB_EFI, CONFIG_FB_VESA, or
> > CONFIG_SYSFB_SIMPLEFB enabled, so the restriction doesn't usually affec=
t
> > anything. But it's valid to have none of these enabled, in which case
> > CONFIG_SYSFB is not enabled, and the VMBus driver is unable to properly
> > reserve the framebuffer MMIO space for graphics framebuffer drivers. Th=
e
> > framebuffer MMIO space may be assigned to some other VMBus driver, with
> > undefined results. As an example, if a VM is using a PCI pass-thru NVMe
> > controller to host the OS disk, the PCI NVMe controller is probed befor=
e any
> > graphic devices, and the NVMe controller is assigned a portion of the
> > framebuffer MMIO space.
> > Hyper-V reports an error to Linux during the probe, and the OS disk fai=
ls to
> > get setup. Then Linux fails to boot in the VM.
> >
> > Fix this by having CONFIG_HYPERV always select SYSFB. Then the VMBus
> > driver in a Gen 2 VM can always reserve the MMIO space for the graphics
> > framebuffer driver, and prevent the undefined behavior.
>=20
> One question: Shouldn't the SYSFB be selected by actual graphics framebuf=
fer driver
> which is expected to use it. With this patch this option will be enabled =
irrespective
> if there is any user for it or not, wondering if we can better optimize i=
t for such systems.
>=20

That approach doesn't work. For a cloud-based server, it might make
sense to build a kernel image without either of the Hyper-V graphics
framebuffer drivers (DRM_HYPERV or HYPERV_FB) since in that case the
Linux console is the serial console. But the problem could still occur
where a PCI pass-thru NVMe controller tries to use the MMIO space
that Hyper-V intends for the framebuffer. That problem is directly tied
to CONFIG_SYSFB because it's the VMBus driver that must treat the
framebuffer MMIO space as special. The absence or presence of a
framebuffer driver isn't the key factor, though we've been (incorrectly)
relying on the presence of a framebuffer driver to set CONFIG_SYSFB.

Michael

