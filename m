Return-Path: <linux-hyperv+bounces-5498-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D0B0AB61B8
	for <lists+linux-hyperv@lfdr.de>; Wed, 14 May 2025 06:47:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D5B8189F32F
	for <lists+linux-hyperv@lfdr.de>; Wed, 14 May 2025 04:47:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E96F91E9B2B;
	Wed, 14 May 2025 04:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="CbzFzDH4"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazolkn19010001.outbound.protection.outlook.com [52.103.13.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6FFD4400;
	Wed, 14 May 2025 04:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.13.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747198046; cv=fail; b=Fa4NG7DrZi9T8i7wWpL9CkWkH5s+swoyRscybyVl8/X0b0Q3ppFtxvsy3lVZdfQxA41KSP8YxuB9xihQu0hxqNSmUB8B4cZ7QKgJ0wwggyF2nlIPJbXeDi78QNvVnaYmR/qoLaEcI28zxx8bQXt605N8eDB94WPyLjPfvOxARiA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747198046; c=relaxed/simple;
	bh=8U6UaKfD6fz6kXAPz70DlIohsrfZ3h15fIaZd7m1l5I=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=EcxG7NCkjcY/tsjk+mOZt18i6eARmfmAe8at3uN/jrkKvPNV/sfwlKEF6Gsn4zW7RMy9gtTI8ALpU7IXtbBFHQdc7h4NpKewlkBf2qTaSCehU7agu98aQ+dGvM+vOa+1OFnOM8YAvu6iqhy3MtIBLf/0/wmbgqk4sTs1a9SoiPY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=CbzFzDH4; arc=fail smtp.client-ip=52.103.13.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jncee3BK9bP0LGa6ou5lVw8aD9D9abJrXZgfzzAMozN6kyUcESwCgl0Lbj+8bglyTwOlRmzzT6qKrJcUmjVXTHsVP1BguiEmsGQbDiDu15UeDADlsgJJVBuw1KsQJdayPe3K5PRdvAKjmFbefY014v/8hm9j9y/WzAn2Tusjm+hfapWMpS/41b3TLCKhXaFgqhXuuddSCzUcVYdnFxdP+PXNJMlsrc4Op+GoI01XhFH/16X8VZ+sk96m8NkaDWzn7f3akueZK0pg7vSFLxF7jkF5YmBzof5qefztB3ZxY3Qa6Znr0LDepB3Yc18t+rBN7HnO9hw6T2jDkVazzm1g6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XG0afGEW7WFrOejit/9JMonLh6OfLUZxIIsZdM4v19o=;
 b=R6/UbvxCy+2xSrb5WzTuGX1LM6F80dDSaU6mUr57dp/wqt1LL0zLPfWQhgkCJ5h6RW6FqICTo2/CWFXCtpFlIut5GDGI7+fopAubUBGygapDkl5gozGW021LhZPoZIhY2LvN/w4Tcniz8WUrJzcFJQ3WPxrWU3Wc8XDfLPOh2jPODX5y//bhLmDP+CnYV90S3jgZJ+qCfPyflz96zmf8gu/HGBXxwvMrbO4FvvDluRpP6nI4nSbH7q5nJFtCwQQ8u0wAbhjhW2F/T4WWXKHFtGrfKFXXykFY0UtZ6hKN1VPR4+ckXa4dk6JxPriH1OMK55rVnY46V9Y+QZjlCsV4fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XG0afGEW7WFrOejit/9JMonLh6OfLUZxIIsZdM4v19o=;
 b=CbzFzDH42mN2TO6D2ZUrOaAsry/8SUiEV9vRK5ip6/85Jv/jdClOnC3vwT2bwYATyYoWaQ6owhrjf5ppODVSSCJTDFcmURcJLq17+OYwLK1991vt6vHYX7dhbzXAM5iJay6I4HBzs5OauKW4fmvpO/4dpxTDoHrR2A45ux/VqrVjwHd231tePih9yx8vG7lyGgwsGhbW/Tpwhl5Lw8eDGStDbHGCcyFXo4zcMeYJaICyv1OHFeel+gw3Q8PmeKUJ40LpdCxB9vmWJy0IgXDUfA4Li5eieLuXTx8PJ/RWLvCaVvtGf31CEOpM1ac3NmZoEBxQDxy/s5+VxwIjILNYEQ==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by CO6PR02MB8756.namprd02.prod.outlook.com (2603:10b6:303:140::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.28; Wed, 14 May
 2025 04:47:21 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%3]) with mapi id 15.20.8722.027; Wed, 14 May 2025
 04:47:21 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Wei Liu <wei.liu@kernel.org>
CC: "Gustavo A. R. Silva" <gustavoars@kernel.org>, "K. Y. Srinivasan"
	<kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Dexuan Cui
	<decui@microsoft.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?iso-8859-2?Q?Krzysztof_Wilczy=F1ski?= <kw@linux.com>, Manivannan Sadhasivam
	<manivannan.sadhasivam@linaro.org>, Rob Herring <robh@kernel.org>, Bjorn
 Helgaas <bhelgaas@google.com>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-hardening@vger.kernel.org"
	<linux-hardening@vger.kernel.org>
Subject: RE: [PATCH][next] PCI: hv: Avoid multiple
 -Wflex-array-member-not-at-end warnings
Thread-Topic: [PATCH][next] PCI: hv: Avoid multiple
 -Wflex-array-member-not-at-end warnings
Thread-Index: AQHbtgJUCHBVQ2nlJkec17kVDKNMEbO3nz/ggBhLkbCAAPXvgIAAyVqw
Date: Wed, 14 May 2025 04:47:19 +0000
Message-ID:
 <SN6PR02MB4157EC72378905EE97CA0934D491A@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <aAu8qsMQlbgH82iN@kspp>
 <SN6PR02MB41574AAF7B468757A9F9ED79D4862@SN6PR02MB4157.namprd02.prod.outlook.com>
 <SN6PR02MB4157E7C91785BEA1E597B0EAD496A@SN6PR02MB4157.namprd02.prod.outlook.com>
 <aCN3E7pQc5UHJ-4w@liuwe-devbox-ubuntu-v2.tail21d00.ts.net>
In-Reply-To: <aCN3E7pQc5UHJ-4w@liuwe-devbox-ubuntu-v2.tail21d00.ts.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|CO6PR02MB8756:EE_
x-ms-office365-filtering-correlation-id: 6375c053-f80f-4caf-3be6-08dd92a26897
x-ms-exchange-slblob-mailprops:
 /UmSaZDmfYCV7gMu87/GtwOd6jzNwNFlWTVG0fcdJrIkmgmUqwjFQiW+8+vA/9mCw7PnL+VwiWmriXeInJ2xFVS27UWw5yOB3Z8blMyC4giiFk30E0PZ7xEq83hl0QkZ4gHDRHHVOI8K1z25YJK+Mv79ifP9OQ26zSsHKeCKYse4BLm6Yz3uAQQpa7R6lGrTAGnbee6583A3Kof5hkrh9WRSA89OcHo2RRf8cE4wO1ta27zH+oxPXZQJ3enE56qdFSS4uCWJ+uj5jIoAYSQQJH2xKbdu6NHqkXY6XnZm6tT6REENIslPjqMfiM3xoFGMCdDDAMIrvvjqH+vV9Z7I2jxLm8170A3CzCNDEFIvF+iN600ldzPscsMRCiLmdPWQEIxhIdPrQORQ4cJ+ohnPcJM5Eh9AixIx6eM5AG/16AfLuJN6wt48kDKz3tVKReVqV4leRd0KDsJA+hatOxuuKjPVDg6tSj2pvuqwiuZEDOFgkauAzkzprIMkN1Z0IfpQaj87lrWc3iQlh8V3uwSRL1jroXQQoZHrv3Qc4ljCwP59iugyk+I1ARuzbUtXIiqq0zDUjpXVTnumSHeT0iAC7fKQJHmRTb8TfEs4NozQlgZTe7nq3sQJglPy2v1L8vzBDKHagXtjV7j4xT17mErSUevqguD6Ri/Tm03phjBXHbNsLRB/eawXmNq7NI5sNNDVwDGxkCjuh5O8G+4mn3evtG4mWHxHGv98zlLQEmJ0qW+Cmz/zSZKyWt89vPMQ3gKGplieKjKv0r7Bv6KZgb7DjLK3pBhjVq05XYpKvSUG4/QsfpgqFcRMDvpiH9CDvBjfGt+ekgWapLy9A9VekiMf8w==
x-microsoft-antispam:
 BCL:0;ARA:14566002|15080799009|8062599006|8060799009|19110799006|461199028|4302099013|3412199025|440099028|102099032|10035399007|1602099012;
x-microsoft-antispam-message-info:
 =?iso-8859-2?Q?Ml+WANZbm3a5MzE7KIH3sNzMkqu00umWDQuK4VF86ox1GkR3SixdhM6D7w?=
 =?iso-8859-2?Q?GunmpPdgzdn8zbtfawRqlQ0dqXpKPbkhPiYckEvJ98drsnOHlt5szdJ9fy?=
 =?iso-8859-2?Q?gCUIG74mBXIYDy8ceMMfljtP6kNZKALuD6Ij+y/eyMezqRsNrnYZqVepRb?=
 =?iso-8859-2?Q?wjYLky5tJQsMiCujHdjo8IA8VYSP9XjFzrOjxiSqMA7ovqQA00R447feTJ?=
 =?iso-8859-2?Q?hpB+Q3XwJ3NeMc5JuSh/Tt0gCE78PBVGfcK7EISx886Dkrtvb2pEe6RdQk?=
 =?iso-8859-2?Q?FVAQfKy5Ov6WBSHBSt61xUHLBT0zX1uq43Bc7+ANd4VgpYQF+FJw/3mVDF?=
 =?iso-8859-2?Q?0xvCa2mSrbGqs8+vVJ4iMl0KlEatZsRoPPZSIaozvGLvUNmrHcVH415WOw?=
 =?iso-8859-2?Q?PeDb5/z6TknOaryaaA0BPBVN3Te1NLhVQn8+nfTc0S3KSknhIFCD80SoTq?=
 =?iso-8859-2?Q?BZ2aXlHsNPVM8hJ910eVOdmDTx656bS+ULgB7GRr58AGwK8s9nLC66nMvO?=
 =?iso-8859-2?Q?00NskqtpSey4Pu2B7hNzjfjNGhJBo2eifDJjDgjlHxolIQZsJs/yVU5wub?=
 =?iso-8859-2?Q?i0/aa+EJE6Ccoht/UcmH+T3HUli3e36my8tS2Z56uwj+tzlEvk89eDFLzi?=
 =?iso-8859-2?Q?lc+ailBQS+Bjbik7x0uuYEIjFUgjibsjZCtGoVEOc0fN+eQWOo/4fYM3sg?=
 =?iso-8859-2?Q?eqDTO+cL+i77U/eT5zSZrDCZNp3TaA1DMquak+Jp7iAbQB7Qzkbg2wSnCH?=
 =?iso-8859-2?Q?W01xCP6h4bL0OFmH3jM5qCzTWpkG/kQemwZo1xEtWj2RX8jgQL9hSVCHYB?=
 =?iso-8859-2?Q?N/D4jS8JOWca12V/n5zTwOJGsDi6fkDOo1RnWwftVv0D2MmdpJORDRx4Gz?=
 =?iso-8859-2?Q?enOdUNgWW3igsKiVi7eUxMQjqP4PDmLpUfgVCt2CpnZIR52q5XlqPqqL1+?=
 =?iso-8859-2?Q?O16p+LHdEGLxuomew1e+CGCsuXeJEN+qlF9e34wYQsiqDvz9O5We3q4JEc?=
 =?iso-8859-2?Q?vg3V7rVLidMkBEoV1Rj9gOjHhr62i9N2121Tlcry6+8KAmek1nQOSDWlpB?=
 =?iso-8859-2?Q?jBuPGhnNRpBytio1dVVsKuPdF4ggK6W2Y+Ge76keeHkHPnTunnsQcR56X6?=
 =?iso-8859-2?Q?dziCyVeMU+0BKQ3ohz5heuyMm/1UHotCMwE+ie8Yh/A1ZfRpIXQj806aac?=
 =?iso-8859-2?Q?kcltkku3XC+00TQ5Lf2qzerLmwj3wytaijNCLt3MM07C69HcNlPYiZTc8m?=
 =?iso-8859-2?Q?MiCH2EN3mqPZFBXuS6RTrKncqqyZbpE/7ioX4e9cf//5u0gDxkNw5fd+up?=
 =?iso-8859-2?Q?PwVy?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-2?Q?lUwLPJsJJGqkLk3YDZxeQ4FlDWokD7PowU13xmYSr6oe7cqC8hQQcRg2TC?=
 =?iso-8859-2?Q?P92s+xN8nhMjuLSQG3kqV7wTT7ZK98qeCSOYQ61XOfrVSlSGuUVtef50va?=
 =?iso-8859-2?Q?TLBQEvy0J9WbQ9eVWnG8CFkx1rrCC9DuUB7iGANzrOwjD5Wic/1Z7+/vdh?=
 =?iso-8859-2?Q?50WiEjp/evacQkvwIcDGrExkNsR/cVHs+L7Rpp+/hh3eLeUcohay62hDJ5?=
 =?iso-8859-2?Q?/FiAXTUUBFjzxYtWNjOFcBoLyNShpGa/y4ZYFae1BSlDqxg2lXaT1ZSIPv?=
 =?iso-8859-2?Q?Umk76iXDVq7ZEkYf7AkLBQv3EZZxS9A839JDcCW/o9qvXwi4Z5bBwJqUPw?=
 =?iso-8859-2?Q?7MLWvC2XyLDPgUCyxovV5idnM0PHK0sPQ2Gzk7LWP+OqO8+Somfby5fFjg?=
 =?iso-8859-2?Q?ZCgkP3Hqk5D5n9QaiiawSjzFDPFV4S+lGIbR4hLBhiHIHe7b8BkgIdXw1B?=
 =?iso-8859-2?Q?0E+U9E7WjMwG7j8rOLtPyoclHj1iD0mbUfMwoUMbVqFHL73EouqAEotOBh?=
 =?iso-8859-2?Q?db6Eg/ns4mW3jJFZAQks+MMMr6FOdyc3uksdJnAXiPXTFd15oAgUdIZytB?=
 =?iso-8859-2?Q?dcxePNclM0uAOe3Z75TqfgduHNyqOHASKEZq8VjFsLooFUj9zfTZrOrH9H?=
 =?iso-8859-2?Q?B/jxa/NewcllgcNu6qZHZW0xjtWZrHWAGnbVcaopywx3apqZ8lVSfgzefx?=
 =?iso-8859-2?Q?c2TrFs807MDvQ+c4qKnWQT1hF6t0mTgM/653IDw5wS+Vl7DwSnqDo+3LRn?=
 =?iso-8859-2?Q?ZLPZp/SEgzSf+tMITBZXXbn7/UN6tRqWbzjCx/m/IvLobDLX4itquhYMhH?=
 =?iso-8859-2?Q?8byShW+Ric8oOqsAgV0WVDOxbRm/8JQjItiD1Dty/lplsQkU8iKCc4zTSC?=
 =?iso-8859-2?Q?WAHWGyiskWuqmiEdJqQnMc2fzusQJgXI/25POh+L5gOCCyMiFBchWixM9Y?=
 =?iso-8859-2?Q?oLHlqb0tF2aGuIgXji6A3KdFY1lVO+RusQewLPY4I3wIo02NdcAHI5mVer?=
 =?iso-8859-2?Q?jC0YDjmeOy/iOsu/lNqq7oxj0FhMVBDtGwGoWQpO1jKjSpNVsAIio/i50b?=
 =?iso-8859-2?Q?wHEfcju/w5Q5uX6qft4b/DByE9D6xzPWkzt/8eW3QkKdCjazGidE1QQEDB?=
 =?iso-8859-2?Q?twgcN6x0oCrd8b+0L1WyHtARGD3GyHUrh1MJaeyPZrC0xbKEDlxKX/+yoS?=
 =?iso-8859-2?Q?Q/V8rtRt+gmJlaS7XLATs/+oPvVfK82q3sVY6FpNXmBT9TsNwW1ykcAoVy?=
 =?iso-8859-2?Q?SoW4OS6mXJlv6g6UXNxMCrCozX8cqjnFRTwuN5lyQ=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 6375c053-f80f-4caf-3be6-08dd92a26897
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 May 2025 04:47:19.3112
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR02MB8756

From: Wei Liu <wei.liu@kernel.org> Sent: Tuesday, May 13, 2025 9:45 AM
>=20
> On Tue, May 13, 2025 at 02:07:45AM +0000, Michael Kelley wrote:
> > From: Michael Kelley <mhklinux@outlook.com> Sent: Sunday, April 27, 202=
5 8:22 AM
> > >
> > > From: Gustavo A. R. Silva <gustavoars@kernel.org> Sent: Friday, April=
 25, 2025 9:48 AM
> > > >
> > > > -Wflex-array-member-not-at-end was introduced in GCC-14, and we are
> > > > getting ready to enable it, globally.
> > > >
> > > > Use the `DEFINE_RAW_FLEX()` helper for a few on-stack definitions
> > > > of a flexible structure where the size of the flexible-array member
> > > > is known at compile-time, and refactor the rest of the code,
> > > > accordingly.
> > > >
> > > > So, with these changes, fix the following warnings:
> > > >
> > > > drivers/pci/controller/pci-hyperv.c:3809:35: warning: structure con=
taining a flexible
> > > > array member is not at the end of another structure [-Wflex-array-m=
ember-not-at-end]
> > > > drivers/pci/controller/pci-hyperv.c:2831:35: warning: structure con=
taining a flexible
> > > > array member is not at the end of another structure [-Wflex-array-m=
ember-not-at-end]
> > > > drivers/pci/controller/pci-hyperv.c:2468:35: warning: structure con=
taining a flexible
> > > > array member is not at the end of another structure [-Wflex-array-m=
ember-not-at-end]
> > > > drivers/pci/controller/pci-hyperv.c:1830:35: warning: structure con=
taining a flexible
> > > > array member is not at the end of another structure [-Wflex-array-m=
ember-not-at-end]
> > > > drivers/pci/controller/pci-hyperv.c:1593:35: warning: structure con=
taining a flexible
> > > > array member is not at the end of another structure [-Wflex-array-m=
ember-not-at-end]
> > > > drivers/pci/controller/pci-hyperv.c:1504:35: warning: structure con=
taining a flexible
> > > > array member is not at the end of another structure [-Wflex-array-m=
ember-not-at-end]
> > > > drivers/pci/controller/pci-hyperv.c:1424:35: warning: structure con=
taining a flexible
> > > > array member is not at the end of another structure [-Wflex-array-m=
ember-not-at-end]
> > >
> > > I'm supportive of cleaning up these warnings. I've worked with the pc=
i-hyperv.c
> > > code a fair amount over the years, but never had looked closely at th=
e on-stack
> > > structs that are causing the warnings. The current code is a bit unus=
ual and
> > > perhaps unnecessarily obtuse.
> > >
> > > Rather than the approach you've taken below, I tried removing the fle=
x array
> > > entirely from struct pci_packet. In all cases except one, it was used=
 only to
> > > locate the end of struct pci_packet, which is the beginning of the fo=
llow-on
> > > message. Locating that follow-on message can easily be done by just r=
eferencing
> > > the "buf" field in the on-stack structs, or as (pkt + 1) in the dynam=
ically allocated
> > > case. In both cases, there's no need for the flex array. In the one e=
xception, a
> > > couple of minor tweaks avoids the need for the flex array as well.
> > >
> > > So here's an alternate approach to solving the problem. This approach=
 is
> > > 14 insertions and 15 deletions, so it's a lot less change than your a=
pproach.
> > > I still don't understand why the on-stack struct are declared as (for=
 example):
> > >
> > > 	struct {
> > > 		struct pci_packet pkt;
> > > 		char buf[sizeof(struct pci_read_block)];
> > > 	} pkt;
> > >
> > > instead of just:
> > >
> > > 	struct {
> > > 		struct pci_packet pkt;
> > > 		struct pci_read_block msg;
> > > 	} pkt;
> > >
> > > but that's a topic for another time.  Anyway, here's my proposed diff=
, which I've
> > > compiled and smoke-tested in a VM in the Azure cloud:
> > >
> >
> > Gustavo -- Are you waiting for me to submit a patch with my alternate p=
roposal?
> > I had not seen any follow up, so wanted to make sure we have clarity on=
 who
> > has the next action. Thx.
>=20
> Michael, I prefer your approach. Please send a patch.
>=20

Patch posted here:  https://lore.kernel.org/linux-hyperv/20250514044440.489=
24-1-mhklinux@outlook.com/

Michael

