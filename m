Return-Path: <linux-hyperv+bounces-3401-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E67279E6461
	for <lists+linux-hyperv@lfdr.de>; Fri,  6 Dec 2024 03:44:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1374284889
	for <lists+linux-hyperv@lfdr.de>; Fri,  6 Dec 2024 02:44:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 476AC170A11;
	Fri,  6 Dec 2024 02:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="uO8VrxOI"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azolkn19010003.outbound.protection.outlook.com [52.103.10.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80685145A18;
	Fri,  6 Dec 2024 02:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.10.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733453085; cv=fail; b=RqSF62VePWmzJwyhHt6VNAQbEpK8do/9FJxLulcztYu6SJrWY3qnUiub2Atqwq2YNJ89ALr2rBYKlxvHIKToSkBvfshkKfJ176N5hNqIpSoGtGC6LhFvbEB6Yl66eZ3ZlVialYay7msd/P71XeZo+/4fRKX0TBXsW+21ZD1ZP9c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733453085; c=relaxed/simple;
	bh=qwEznR75QuW8wax16iNtkFozshokW6XczBa6fvpgA3A=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=pdMUvuQYBtmtN0gj0AzulIokdtwOCXxhGNmN2F8FZMc6TBNUU07Mu8pUsgHPbMxRXt6mTdFiQZ9ShPEGXM84hVWxdklqrR/neD6/ddH6IpcOYzs88+pHjmpZ+Z+hLXitW7TqHaiFblGmQQlas3E884hq+W9/H6h14c8REL1JbfA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=uO8VrxOI; arc=fail smtp.client-ip=52.103.10.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l+cvjF1BAaAL1UQucpTXw+ioN+IP37JZyhXKkQUWOdHFzto1x99i6OTblGie7OA94CUGSVrWcHBNl+rLhju8Oy4dAHdzmTKzTZb7RNxDEEsmKuIzLFPLLw5y0FOhsmyDfAgO0jTrDi1VKUtgG1wvW6KnhxXiNukGWPfuDHT9huegpEwFZxE5dr508ApZq9CtWlM6gwpb0GZZApv1PznQHor1hoIOEcNAyMYsXAnqwh8Jcg0HMh1hQqKCdrUiRAdOtdE5VMOqK4Z0G3vNjhdw4/7OPJS6GsMbz1Lb0ApXJrsupaCK7I25vOoppdzePCA5/QQzFpturllp124+an5kew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=30g2gbIwNldXEC6UTXWtDFTVeLmKCcXI0g5FjqeTJME=;
 b=Wky++uwOKjmsMCrtt6cbY8d1qEYo/H9A8uP9Pr7OJWPYe1wCj6Oqsk555xmiqR/QWLMnPFGNA6aoFiuZ/38ljD8wSh3p7c31ZdpZen5C11v4ovPfKgilMOLCfSKDQ8iixEjzOmK94TAmcX54yktn0vUI+MgQmi03czODbVvgpOEL3Tl7VJ/NmQ24scfsv1ZEFHq8ZQ9OLCZxfrZASfKdLEF94SpXGssknjul999qWHzK1aRQ0dJOiR9PXaC5NSoCFpD/tyQr25zpcWJaEQCzMA0jTB8p/r7B4V/jf40XsKcGmFpDwVWB/BzrpuZEo/IHdDVlFFQNUqvjE8G0a8OkWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=30g2gbIwNldXEC6UTXWtDFTVeLmKCcXI0g5FjqeTJME=;
 b=uO8VrxOIuZFT6xGA1zdZZyigPAt8QoGVQ1lGPqSKhLY43Z95wp7wEvzwrcJgbIp09XtDS/tGwfyDc+OCGb0UpW/EKCqr9nZTqi88rZzeAh0aP6MNB0yjsbo6u8/PqzJFcL2KI+9yM25QZ6CyAAJdzD7Ytr39T2WJ1R9Lv7fQ8xE5NvNdkPuCd18c7DG8G1pjjAnBCfAS+0NNzcwh6Mh3RAjnApKCIMZte8PlBs3d3D+S6VVwDsB2dxMNcXrsc06Ep9kD8eZmFm8ki2EDKvPeyEwU0AVRR73QZOfeZqNDZwiDGLArnPDj9GnmQZLwE2YpV3aDIocYImPWtNO80dkNCg==
Received: from BN7PR02MB4148.namprd02.prod.outlook.com (2603:10b6:406:f6::17)
 by MN2PR02MB6720.namprd02.prod.outlook.com (2603:10b6:208:1db::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.12; Fri, 6 Dec
 2024 02:44:40 +0000
Received: from BN7PR02MB4148.namprd02.prod.outlook.com
 ([fe80::1c3a:f677:7a85:4911]) by BN7PR02MB4148.namprd02.prod.outlook.com
 ([fe80::1c3a:f677:7a85:4911%5]) with mapi id 15.20.8230.010; Fri, 6 Dec 2024
 02:44:40 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Michael Kelley <mhklinux@outlook.com>, "kys@microsoft.com"
	<kys@microsoft.com>, "haiyangz@microsoft.com" <haiyangz@microsoft.com>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>, "decui@microsoft.com"
	<decui@microsoft.com>, "gregkh@linuxfoundation.org"
	<gregkh@linuxfoundation.org>, "vkuznets@redhat.com" <vkuznets@redhat.com>
CC: "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 0/2] Drivers: hv: util: Two fixes in util_probe()
Thread-Topic: [PATCH v2 0/2] Drivers: hv: util: Two fixes in util_probe()
Thread-Index: AQHbMGKfD1ab64b4ake3TxwsxaOVzLLYr3Zg
Date: Fri, 6 Dec 2024 02:44:40 +0000
Message-ID:
 <BN7PR02MB41484EF2CF3F0C31BE6F4E4CD4312@BN7PR02MB4148.namprd02.prod.outlook.com>
References: <20241106154247.2271-1-mhklinux@outlook.com>
In-Reply-To: <20241106154247.2271-1-mhklinux@outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN7PR02MB4148:EE_|MN2PR02MB6720:EE_
x-ms-office365-filtering-correlation-id: 6bb5ce79-3a27-4334-1528-08dd159feedd
x-microsoft-antispam:
 BCL:0;ARA:14566002|15080799006|8060799006|461199028|8062599003|19110799003|1602099012|10035399004|102099032|3412199025|4302099013|440099028|1710799026;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?/LxYCtBAOZF9Mgaa1/13dedlIOihPO4LGfMlb9Th7EbyBzNjFymBEMtmzUtP?=
 =?us-ascii?Q?mxtzn1q7xDXNmJUNT+YSDWBKOqpKYpHPzXj4CEJld/3yWebWdEDrhoTs86+W?=
 =?us-ascii?Q?ZeOW1YWSCJIHgC9weOcK6+/+v/EbFaypDteGLb+PvNJ7rmEzN+EZrbOKi/57?=
 =?us-ascii?Q?mlRRnXbRgDvqCyww5UT4g2t++M86niWZ211m+JcTkMwC8oWGYhdrD37dqoI6?=
 =?us-ascii?Q?4SflwbyURF/pqGaa80p9wGPcJ0Iwkv1lxAjitgm+WCWj/WraFGspZi6XNBcW?=
 =?us-ascii?Q?ZSrKq0Mv902G+OAzPybtQbIjhhtNWbhgPLK3njW7Oyo4qp1JlgPkuT6PkAd8?=
 =?us-ascii?Q?ER8dVIlxQWInNZc+Mvm2s1emZLQCrGxx6IwbVSEtJX2o/OBxghCV4OIvSBtU?=
 =?us-ascii?Q?woDDYoxmNhkbBrJ6MIL4DAflWG2fi4TVwvCSEVGx1OOCiX2MoFTEHIekKUde?=
 =?us-ascii?Q?Jk+ZnRxop10Is68UQeYItmNuEFOYLZz35VA8DagNUy/tGQO+rdHN6uYJgwL7?=
 =?us-ascii?Q?W3bKj/HRxt65eKX64wKxoSxPAQiqTRl6vBbiHH3dElNd7Se3d4G65dnTtcDP?=
 =?us-ascii?Q?wEN5PXEtHsjvbygYcbjm8IOKGIx/UtBeVV/0bGgkjg5NFSBDv73io2rrw0y3?=
 =?us-ascii?Q?b3CNbdxoFSQldNp2hkeIWJdJRyZE61TLa9wl90Zp3oqgrqTE9dQZP7tXHKPS?=
 =?us-ascii?Q?PazenE20GRY0WPQuLDkCXgBqHXdNifxVJlaavfaMbPVEIRv2NwfFaLd18pZx?=
 =?us-ascii?Q?ojJyzF0r6VFD1rPB8vZEDHN2MZWzc9aD9v4y/ZE8FasXM/hum/7ARoCQAxd2?=
 =?us-ascii?Q?nca8ZwiZrOkeNMGuvNgOG8I46WN63LoDcqy8zC7LV4YImRkRvhHeVlgKRDFh?=
 =?us-ascii?Q?+PiAEIoiP4KhXHkiI0F1+r9X9BgzIR+Uf8y6qCKIhdgDGONlymyfwZGxP6o2?=
 =?us-ascii?Q?Z5EEUlF5RjGPeFGKXDHa2PXHjLm+uzZveO83ND2Od3yphycdaUbCAUB3cefK?=
 =?us-ascii?Q?KjOKSXrFCMnIOdRj9gr4KH5r8DyG1tb5bpgikzLP2jpupmevp5UaXSJISbsm?=
 =?us-ascii?Q?Bxk8RSj+u2lym4u3wzxzMpKjU31p1r1rBfZ9GnMX4XhheqTthEd4ABiJPAbT?=
 =?us-ascii?Q?JP6etgv9SZ7f1bVypLElJyBeDjqzdAA9/dBbVYpJ0WV+rixtw5RzvKvYBd94?=
 =?us-ascii?Q?eookvYm2xVOWQy+WGFr4nEFfqyIJcMw81bZ7cw=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?m86XsGYkjb6+d+hSvWp0fOjOf3tthZA3nXgSe6NRET659jv0TIkmHLvx286R?=
 =?us-ascii?Q?3KcwwtMSHAnWZfcH7z/BYabVstca/YptERdOmFkX+6l3zfLYZ9emTJNYeZvc?=
 =?us-ascii?Q?43ielB49o+W9rXA66v+jrMZXu8/vE4ZqeL069ncuxbBPL6qyALRO9kpnGfs/?=
 =?us-ascii?Q?FwoIcsNOrwmg3Djg+vgo++BqqC/j+tlhLJvsA5IS3xF1zO/h/6JEj+dHYNNg?=
 =?us-ascii?Q?5NT7+MCKW5WuuMl5/CPnT7qKi0nWMqar/j7dBf4SVX+8dLnW+wcrBQruA5IR?=
 =?us-ascii?Q?hOUJmW1ziu/cfuKsMmNZk4JEhkY8I1IQu28wxYfNx1X7isw5zkdEWQ1FZh64?=
 =?us-ascii?Q?hbfKxx1DZNDDmRtgjc96FVMoBEil6D7Eef+zRuTwYDAi4JBW1xBodwWFaUCI?=
 =?us-ascii?Q?Uns75zoCVB5RpzX5FFe29qGJtCEq/AM4/249SKcNgpVi93AYtUVM3FDm6AUf?=
 =?us-ascii?Q?h7i9EJ7cw6Fi6QsGBloKEAuj4n3/ECYZfj3dn6+s0rGfG6jLm7TO8sLrMu71?=
 =?us-ascii?Q?uNov070NJJalY12XCUzWTrYFVNwOi5O+DXiqvDfSJygfPm0cPnKEwYerzxGd?=
 =?us-ascii?Q?FsEjtBTZoscPfM8jo7qPRC1OFGR7N8wRaDcoPmg9HsxIy6gP64khQQ4s+bmo?=
 =?us-ascii?Q?l1A6mOQfaRj9biSbp8h3tIHvIimgIdctlGKXnHWp+JBTzySRXQTGpI9RzV6W?=
 =?us-ascii?Q?Oi5YcRGSVZ+v6YQz2TdppLJcnLspskX9fOIjZdAVHIC4Zto53rfc9+Eqq9Pq?=
 =?us-ascii?Q?3ul88v24dF56dkb92nLUrHhnvKKDikmVI17f0o3Bzx2ZEFrJQ5sOmH3aiw/0?=
 =?us-ascii?Q?ltBlJny6LtaIjaQa0RIAT3+oIYiod4dggI+z4QzcrWNe8rWinr7CBP/hRGFf?=
 =?us-ascii?Q?cz/FIRPr0CQfADxwhA1CubReqLkul6FWKajqvvZNNO1UMZy1SmuLVOXgGIh0?=
 =?us-ascii?Q?ma0yN7Ll4UgfrNX6QIcWfPU42F5XXoTWQfqIn6PLWablLdHledRW+TqKfRfB?=
 =?us-ascii?Q?pDnbxdxMa6aL3wDPJQDuJP2OwJUfkH50z9H2enP3fvAMre72AVI8SpsBgCIY?=
 =?us-ascii?Q?GPxExgAj95271d3osQ77IRBGAJ9BOv3aM5mvo66rsGtDt1fp9vkJDx4k+suP?=
 =?us-ascii?Q?h561lzisPafxpGRJUYEOURNP7978ryeGm4PXv86YKHx+WQ6y6NNYegTIsf8P?=
 =?us-ascii?Q?3WzIYJzzwKxDyNRYe44qDsXi+CGbY0zYD7YoPXGUuQopWM2KJFeOO+MW5Ww?=
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
X-MS-Exchange-CrossTenant-AuthSource: BN7PR02MB4148.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bb5ce79-3a27-4334-1528-08dd159feedd
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Dec 2024 02:44:40.7540
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB6720

From: mhkelley58@gmail.com <mhkelley58@gmail.com> Sent: Wednesday, November=
 6, 2024 7:43 AM
>=20
> Patch 1 fixes util_probe() to not force the error return value to
> ENODEV when the util_init function fails -- just return the error
> code from util_init so the real error code is displayed in messages.
>=20
> Patch 2 fixes a more serious race condition between initialization
> of the VMBus channel and initial operations of the user space
> daemons for KVP and VSS. The fix reorders the initialization in
> util_probe() so the race condition can't happen.
>=20
> The two fixes are functionally independent, but Patch 2 introduces
> the util_init_transport function that parallels the existing code
> for the util_init function. Doing Patch 1 first avoids an
> inconsistency in the error handling in similar code for these two
> parts of util_probe().
>=20
> This series is v2 of a single patch first posted by Dexuan Cui
> to fix the race condition.[1] I've taken over the patch per
> discussion with Dexuan.
>=20
> [1] https://lore.kernel.org/linux-hyperv/20240909164719.41000-1-decui@mic=
rosoft.com/
>=20

Gentle ping. :-)

Is anyone in the Linux-on-Hyper-V community able to review this short
patch series?  It's pretty straightforward ....

Michael

> Michael Kelley (2):
>   Drivers: hv: util: Don't force error code to ENODEV in util_probe()
>   Drivers: hv: util: Avoid accessing a ringbuffer not initialized yet
>=20
>  drivers/hv/hv_kvp.c       |  6 ++++++
>  drivers/hv/hv_snapshot.c  |  6 ++++++
>  drivers/hv/hv_util.c      | 13 ++++++++++---
>  drivers/hv/hyperv_vmbus.h |  2 ++
>  include/linux/hyperv.h    |  1 +
>  5 files changed, 25 insertions(+), 3 deletions(-)
>=20
> --
> 2.25.1
>=20


