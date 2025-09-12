Return-Path: <linux-hyperv+bounces-6841-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A3DCB55599
	for <lists+linux-hyperv@lfdr.de>; Fri, 12 Sep 2025 19:48:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0AB616EA7A
	for <lists+linux-hyperv@lfdr.de>; Fri, 12 Sep 2025 17:48:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46C313019BD;
	Fri, 12 Sep 2025 17:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="ONH6o7Mj"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2116.outbound.protection.outlook.com [40.107.236.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AC90272802;
	Fri, 12 Sep 2025 17:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.116
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757699292; cv=fail; b=JTD4nx7qDVbHtsYxtsk+0fzaC+kOb22n1IeqCXpFHVMDU29r1yVSmIvxonFQiB4+5bQ2fWJGUkRmN1AGolx5UsV2O9mMTXOS+zRn/tvjc2t+CeH2jHSi9ECRg0hpHcFCKAxtL4uVJQXHGTTRmMwjt2kCbiigHi3/sMH6HS0QsZo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757699292; c=relaxed/simple;
	bh=bC0Iexyd8d4xy+aaj337ETAVvWRTwKDdGVaf9TZv1WE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=pM/pFvfz/ovmEl3qwyf/5ruWgDK+Sde1SVjc/BbcW0wGc64QqGI1xAN5k+HwdWwmu5w3h2yM2ddzeJh4qLgH0vgJ2KF38Lc7M+eMYbNJRnL3sLlLIxBowPsfBiUk47n2N3SbzIFtye1sa0Er8LlKSZcFMn21ktUF1+xb0+OQeUA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=ONH6o7Mj; arc=fail smtp.client-ip=40.107.236.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dOid+zoTPWJZtmzZ9T77yludt8R6Hr0q70sF5ymwaXzfjcn70LU7xQEQ7DdxwcgcbBVT2LPS/BwcZWBJgoNx9BFJtsMPD2FGP1xgrD/2zY3e1mmC4mmLjydRcA3vJQRm15ESyuJQVD21SfTCuAcXF4JTt0djW4oOLG3KrKS9kG87PllIGUJsJP/fmlTFBFjPgLLm/MQf6u1+f/kfX3gMCgBVm5f+K/RpFBOUm5KxiqULIWz0Bw8T8gtSfGhzLNNKmH/zPXVco/yLdL6maon/0GRsbqdq8p5O38PM7nFcxxKj2DzsiCCo7EsSOsyCcqJMR0pV+GnvjfXccR8SnBGJVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+HltCYFoyQEefOlgyay2a1na9XRxAfi7sRpmrGhHnWI=;
 b=v71oSu0UN84fPbw0+ewt3w4h1777hA+ls2p0h/Bsv63lCMOQGPKOkgydmaPJCFqJV9zwD/UBNuzNEv5R5kXQ023PmMcoSnMS6WK73lt+Pn4wAn6kc69IDGkWg1EEUfrSOsF2Cw8I3tYbn5Cf53UHSDWqm1DSluM5LZB8vGS9XleEPUf0DSCL9mLT2r1nXtUamD65oFtXbUuqxfBuUZsR7muFr97AW9Fo0nxlcedKVKuHK1i2+evqTg8x2Yfbt1EfwVhKH6Qop/K1XuIa7sb0jaQLc+hsvlaJPWU19HGpt3Mt5R4PSv2UDbh0jAhbCYhtVXBpx/dLGv9dXZWORabjnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+HltCYFoyQEefOlgyay2a1na9XRxAfi7sRpmrGhHnWI=;
 b=ONH6o7Mjv2j4Fw6Bnez0qtfy+FH5IXO+ETmy6NvVt7jA8KzG1HyABb1fVkeZM2z1dPnl10d2CBaBY0wiLT6EuEJUJFsFphfpHEPod1qx0Q9/mq0UBFA9noFw9fLMi6GdMJY/t/5+hpb/PZ2YGUylMw51tTH8umutznfQ1uynnkU=
Received: from SJ2PR21MB4013.namprd21.prod.outlook.com (2603:10b6:a03:546::14)
 by BL1PR21MB3328.namprd21.prod.outlook.com (2603:10b6:208:399::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.12; Fri, 12 Sep
 2025 17:48:06 +0000
Received: from SJ2PR21MB4013.namprd21.prod.outlook.com
 ([fe80::3c6d:58dc:1516:f18]) by SJ2PR21MB4013.namprd21.prod.outlook.com
 ([fe80::3c6d:58dc:1516:f18%4]) with mapi id 15.20.9137.005; Fri, 12 Sep 2025
 17:48:05 +0000
From: Haiyang Zhang <haiyangz@microsoft.com>
To: Simon Horman <horms@kernel.org>, Haiyang Zhang
	<haiyangz@linux.microsoft.com>
CC: "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, Dexuan Cui
	<decui@microsoft.com>, KY Srinivasan <kys@microsoft.com>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>, "edumazet@google.com"
	<edumazet@google.com>, "davem@davemloft.net" <davem@davemloft.net>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	Long Li <longli@microsoft.com>, "ssengar@linux.microsoft.com"
	<ssengar@linux.microsoft.com>, "ernis@linux.microsoft.com"
	<ernis@linux.microsoft.com>, "dipayanroy@linux.microsoft.com"
	<dipayanroy@linux.microsoft.com>, Konstantin Taranov
	<kotaranov@microsoft.com>, Shiraz Saleem <shirazsaleem@microsoft.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [EXTERNAL] Re: [PATCH net-next] net: mana: Reduce waiting time if
 HWC not responding
Thread-Topic: [EXTERNAL] Re: [PATCH net-next] net: mana: Reduce waiting time
 if HWC not responding
Thread-Index: AQHcIpWJOJMKhk/JEkSyLVAsW6srlLSPfGmAgABYLrA=
Date: Fri, 12 Sep 2025 17:48:05 +0000
Message-ID:
 <SJ2PR21MB40130FF8C3278A49A3A6C2D4CA08A@SJ2PR21MB4013.namprd21.prod.outlook.com>
References: <1757537841-5063-1-git-send-email-haiyangz@linux.microsoft.com>
 <20250912122849.GA30363@horms.kernel.org>
In-Reply-To: <20250912122849.GA30363@horms.kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=4cf4dce5-c42f-4d78-868a-c0a7f5b292ab;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2025-09-12T17:44:24Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ2PR21MB4013:EE_|BL1PR21MB3328:EE_
x-ms-office365-filtering-correlation-id: 3dd933cc-9b1b-4ea2-c5b5-08ddf224873e
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?IYnLrBGC7Pf9kAaMo7dSeNKGYSS/ODUKsHBbiYV2P19A7fuYVcOlFCVC9vWS?=
 =?us-ascii?Q?LaI+ufamcMxJlNOIDXu9qJt7MtrafKk6yN6WH66N4/SqJfuHaO+cbxXkCTaz?=
 =?us-ascii?Q?tN5pqpYA5dI8azldf2hBPCeqLyxeI49ontcmnQBBTOD5y4ZZUMKgXjj6ahon?=
 =?us-ascii?Q?2HL1VTAxf7dJ39RrB9rbBHrFh2htw8K1LMwHmhm893GcylqYMP3iqTgxbjaF?=
 =?us-ascii?Q?cSEzoKxcl9HkvuIMiCzdrDVpYJ1fbstYsIA5UoyVsrVDUP+jaQluh7YjOBjb?=
 =?us-ascii?Q?AkbK96xjQFI3SkpV6IZx/HEx4ZXIYPWwmn0ZtkAvsifimS7e++Pc15+yzBOq?=
 =?us-ascii?Q?DrYwUXum1Z5GYAP22MDfHtiHOtVLvEZJ/6pHoVJYjVJUXgQ42kR4HZYeFSaB?=
 =?us-ascii?Q?i4+odLqA6o6Q7WEXihMOaYgIWDnvTcFpknP3MsTgtYH+o4/qMUtxh8dV69Yi?=
 =?us-ascii?Q?TfLz2X3u37jztcV7U3lK+Vi6wJnYfZ3c4QYLatH7QtEYWiJbEt/g5lKgvT04?=
 =?us-ascii?Q?JTefLaP4GL+ND9ndumi5vHyuDAyHTCrKlZs7FWtejj9IGSkgUAcDQ2xBLl8Y?=
 =?us-ascii?Q?nGiat/KfU6IlamvKB6qIM0Gb2ifA8ek5gWEWA7QGqUr1UGrAc7GXuGKcQzMl?=
 =?us-ascii?Q?qzXAQFr0fmnEl+EqvdRhybjQ/8pG0s+yXf724bORBTWawv1FXLfKujtzkxam?=
 =?us-ascii?Q?nke6zvB3LOg+uzDjXj/VSqnbxTTUpbD1cKja2IqtXpTx4OBDcGExr/kemqCZ?=
 =?us-ascii?Q?CXR7CBk18YYedy6cUd03cGmkpZDDB258fVNq2csxqJ5jDf5GwGouATqt8xAt?=
 =?us-ascii?Q?IbVqxsuA+tKDRBw0BKACojkqbtvXiKc97EDLH29hMMjVTyp8MLWkTdNT8bVB?=
 =?us-ascii?Q?hqQcY3qUibWSIxqQIOsXjmcKZM3jDpTAGn+xeTOjSLnYWP0Ey8en4PNBQLkQ?=
 =?us-ascii?Q?eB9V75scxlo4sBaWRgJASpT9isiMouTG7/BNjIyA5GlCkVYSkKhd1jA9Elnh?=
 =?us-ascii?Q?T8k9q0cyhjrW5ORGRmlGkB+NPTAZxXgg+BEbNqBuOR7XKYqMTn8ux+NjCyiT?=
 =?us-ascii?Q?amqJyRqitzLdCussTWlsOtw/va/KWXUYjcJQ3SKHxDdPuRG7tIjMmxv56at5?=
 =?us-ascii?Q?sND8CgC6WIE5mIc9zphnUgV75SpKgCGWFwhUgcfkX5rjZe2Hfh3FUZ7XjdiQ?=
 =?us-ascii?Q?WP9g29Ykhj4BpGsk179yxwKWJq//he7CYvWjLwp5sFnSYo5ejsQGw/c/bEyI?=
 =?us-ascii?Q?cFQhmyXDfUrejeoqpFL+MB5VvLorJ3yiJRQ3mI0mHm8eU8p6/jk5aLgy2fFS?=
 =?us-ascii?Q?CZ/SsGjav3DGpjM1Zp4UTgnnsePtUGAvGVDVAs72c1Ent5VWmF+rXCgO4Rvx?=
 =?us-ascii?Q?PZw5YowpdlvEAymPnpQJ1N9DzaKFXkYa9r+uXWo4NvKn8YkhI9k5zrlgIpx8?=
 =?us-ascii?Q?Oov7MTSVnR/2rXH7MvU3AmFtavIIxydaDEj15y3S9t3vWttC71peMg=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR21MB4013.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?/VrBplZknzbYONG10/WMS00nzVU+A1cBPjBwlDnbViaBgtDsyIHgJM1Y9sAA?=
 =?us-ascii?Q?2S/5MrYts1sm0SQjvT0nZ7uLCKQhNZjUmHRUSojbLYj6H/JaogsrP66DUKgt?=
 =?us-ascii?Q?5gs31TWCsobM3bFU8m9MH3no2yrDb9RWcmQXuT43KRb7v78gZ/xTtIeTjENf?=
 =?us-ascii?Q?pD6Yi+RWgaFTnw/s1HPkfdgwNJ0UZ6OdAgx1BZO/6pns/7BQhruS4K5dsW9A?=
 =?us-ascii?Q?DFvZV+rkO08/8MY8isI1olVAzmIgyXkF8h1qwe1lmzEMYuPhQqonoHATrQlC?=
 =?us-ascii?Q?QWlyutLNdUBG5F5k7IiPcP9yviAwrj+i5r5BCEU/IeF+L3GqL0bwGShm7KR9?=
 =?us-ascii?Q?uMACpcBKLMpKrmTp69M7gBUN4MW8aVt5UW/oi4+2UZi/wkBzAcL9vgkMftde?=
 =?us-ascii?Q?jQrU5b7D5jzsopmsLvlEezPXKo9Po9BXvR4nQiMtrebEk+5Kjwtv0sgDDtwi?=
 =?us-ascii?Q?jGg+J2+9H7LVGxTn55GdtNtLE5yyB/VClLDm2JpQawRMHRseGcnNKMtK+o5n?=
 =?us-ascii?Q?jAv0lSaStUYzv1v3P51QA7B3PPx0ei3W8WDpM0pHVyVbCgaImy8LhqcbO7vv?=
 =?us-ascii?Q?NH+9SLapsWvJxljjqDDnwFiaOl7/oZB5lEI2PRfzg6ctR9ti7LBQk/PN+YNx?=
 =?us-ascii?Q?FOn94CowqQ5c0Qx+uQCb85QOeGPsYa8BP+UMrzsnmgLGpTbqN8nYSEShZMQf?=
 =?us-ascii?Q?6yIzGBPipGq2zlC2u8N6E9OyGO6J9OY7+GFhHb3PIfujgB6A/+LRlvv7ycgM?=
 =?us-ascii?Q?hL7yVQuVdpK63ZA+SVmA/SrCybWFoSCCSL9DGFgWMHEadsXvQnu3OqCwwEXZ?=
 =?us-ascii?Q?ZBLcy7xT0AOqP5QhEP59PaZpz44AsGh1C92c6Oz0yGcMt+1IKhnPU7sBza90?=
 =?us-ascii?Q?VfXOUsflbAY9YsCJ40DmACNMR7A+DKjahnK0SRFQb3YeKk5eTd4s3tyyK3/N?=
 =?us-ascii?Q?nyCzXv+AEwK1WiBFfglXgSwK5LjXYUIfpi4fZdACZphJXt3I1gX0MGOCfosO?=
 =?us-ascii?Q?lX5JIVorMoiI80xuxymcyqCDl8d/ljLvew2Ktdxf2D488hHkEwULbTdWJEry?=
 =?us-ascii?Q?63nwId2/wUDb9kuME3a6VKDTiz3hr593I+1pUo6rqcaz83sjXLNOefQ/ymEW?=
 =?us-ascii?Q?B/88U75gLeLrmSVdfYySaaGi3Bz+JsYQsbNSmZJeXKrAQGVM22G7umeArOBO?=
 =?us-ascii?Q?hNQ5gd3mtFgGip+mrhzdPSuc78mQgjhTLFvTPuEG2/RKj+BTNnRqPfbP/th9?=
 =?us-ascii?Q?L21nV/ky3yD7iAe0dvxARslIwnp8mLGRL3lJvDe+ixtM8r2T0ef5+GTfRsv5?=
 =?us-ascii?Q?+T8B0szmTnW2/3AvtWNWWK2i0P1Gi5f8S+WOBNri5Yhyc2q283FhQjRiVvRP?=
 =?us-ascii?Q?iLYVjUpEMj6e12rzBh0xZwK3ZsTC79ddgYka+3zMHJ+9XqM0PxkriTAFtU2T?=
 =?us-ascii?Q?nTznckQtze6bcCqS4oxYCG/DVyMrbzwd4Ix0t+qIsdnj/GTFjUGoFLOhc8bJ?=
 =?us-ascii?Q?YP5DDwtJ9DztfeJPEAoDNYLbKS55UV349i8S4O9RoUxO2+UUc9LE1HyPxIAi?=
 =?us-ascii?Q?bqQz6Om/6K5JmXNS/0clEsCEAUp+R7khcBI8WZ6x?=
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
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR21MB4013.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3dd933cc-9b1b-4ea2-c5b5-08ddf224873e
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Sep 2025 17:48:05.7807
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: g6Qng+vrJjryunM4arwQfCOUmD/zXnmRgJoPKzNyLPdfBaulADFX34fFcUPTw9Vs5lvVZtNMc5+mVVmCz3lkww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR21MB3328



> -----Original Message-----
> From: Simon Horman <horms@kernel.org>
> Sent: Friday, September 12, 2025 8:29 AM
> To: Haiyang Zhang <haiyangz@linux.microsoft.com>
> Cc: linux-hyperv@vger.kernel.org; netdev@vger.kernel.org; Haiyang Zhang
> <haiyangz@microsoft.com>; Dexuan Cui <decui@microsoft.com>; KY Srinivasan
> <kys@microsoft.com>; wei.liu@kernel.org; edumazet@google.com;
> davem@davemloft.net; kuba@kernel.org; pabeni@redhat.com; Long Li
> <longli@microsoft.com>; ssengar@linux.microsoft.com;
> ernis@linux.microsoft.com; dipayanroy@linux.microsoft.com; Konstantin
> Taranov <kotaranov@microsoft.com>; Shiraz Saleem
> <shirazsaleem@microsoft.com>; andrew+netdev@lunn.ch; linux-
> kernel@vger.kernel.org
> Subject: [EXTERNAL] Re: [PATCH net-next] net: mana: Reduce waiting time i=
f
> HWC not responding
>=20
> On Wed, Sep 10, 2025 at 01:57:21PM -0700, Haiyang Zhang wrote:
> > From: Haiyang Zhang <haiyangz@microsoft.com>
> >
> > If HW Channel (HWC) is not responding, reduce the waiting time, so
> further
> > steps will fail quickly.
> > This will prevent getting stuck for a long time (30 minutes or more),
> for
> > example, during unloading while HWC is not responding.
> >
> > Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
> > ---
> >  drivers/net/ethernet/microsoft/mana/hw_channel.c | 7 ++++++-
> >  1 file changed, 6 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/net/ethernet/microsoft/mana/hw_channel.c
> b/drivers/net/ethernet/microsoft/mana/hw_channel.c
> > index ef072e24c46d..ada6c78a2bef 100644
> > --- a/drivers/net/ethernet/microsoft/mana/hw_channel.c
> > +++ b/drivers/net/ethernet/microsoft/mana/hw_channel.c
> > @@ -881,7 +881,12 @@ int mana_hwc_send_request(struct hw_channel_contex=
t
> *hwc, u32 req_len,
> >  	if (!wait_for_completion_timeout(&ctx->comp_event,
> >  					 (msecs_to_jiffies(hwc->hwc_timeout)))) {
> >  		if (hwc->hwc_timeout !=3D 0)
> > -			dev_err(hwc->dev, "HWC: Request timed out!\n");
> > +			dev_err(hwc->dev, "HWC: Request timed out: %u ms\n",
> > +				hwc->hwc_timeout);
> > +
> > +		/* Reduce further waiting if HWC no response */
> > +		if (hwc->hwc_timeout > 1)
> > +			hwc->hwc_timeout =3D 1;
>=20
> Hi,
>=20
> Perhaps it is already the case, but I'm wondering if the configured
> value of hwc_timeout should be restored at some point.

Yes it's already the case: when the driver does reset/recovery, or gets
a timeout-value-message from the NIC, the time out value will be updated.

Thanks,
- Haiyang



