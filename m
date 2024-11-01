Return-Path: <linux-hyperv+bounces-3231-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 640D39B878A
	for <lists+linux-hyperv@lfdr.de>; Fri,  1 Nov 2024 01:16:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2C7D1F218B1
	for <lists+linux-hyperv@lfdr.de>; Fri,  1 Nov 2024 00:16:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9EE7C149;
	Fri,  1 Nov 2024 00:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="H+I1nCxH"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11023133.outbound.protection.outlook.com [40.107.201.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0451ADDAD;
	Fri,  1 Nov 2024 00:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.133
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730420207; cv=fail; b=cuMhF1UaWOBdiPTSCJCbcF9cypug2XI7jwxrRx7a5kg4H5kK6LCOwy/jStdNiucXkaZxu8tJV1oDG2ZBf98l36L+7PyRhiUo6DOXEEt3lwzMZ78C9SpDlcOcZ3sCkOKFW3BsVz2NZtU9vzKtuIdzjilQR74cyhgpHn99lHJONjo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730420207; c=relaxed/simple;
	bh=SqPZh3igPk1PfAWcMOrllNGfvRUgEsuIjb3l+hPtZgU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=b4eEhwit6GjRafZsaTkLc6FoFPoF1tG662qHoM+DSuNuvBxUczL9/raJyjra/jlAq1R6woY6JY5j420TjCc0DXzpJplMOoXQuhS+UJjsIx5kPkhv0GCpThG5ZoCFq1xMr9vrT8NgIja94dg1YLkGbv0ruf1/RZKIg+lPsUnC9F8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=H+I1nCxH; arc=fail smtp.client-ip=40.107.201.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aeoA1ORtFuyPCClmn1+CZVNv4QW+fAE37xM/EopdAApnAc/mQP05qbPJ1hXM1j38UucC0o0CkJoiRpNUwrEpidoInvYSrsDDNWVQsnnZtM9Qy48G/wB+uJz6XthzJ6MTzW6cPNlEiJy4CcYwzUsSTesqYrRI7Mb+h+mWdzS1tCVjwqrdXBRaZwBtB5neE6oEBdN3mDZiN7yS4kgSg00LXU+E8y8wQ/keZT+Z3tGCDoPrYkeN3hX8pgeX8y7BUevAtFyfjqM7j8//9oGY8JH3i+ht+LigmWCYkLlsIyORHHhoBlJQ79w30mIboXcyJ1+bKZYyqXOXcfexVO+Az4wkag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DOwrIbbQvHyovGD3jmaSzOQUVNlqVvfI4oaA+zXugHE=;
 b=uZWn+/RxFMfyhS1keEaSssY6J8BAAuNlkDi86+8YtY22dcPwWB6KK+8ysx8pqufYPlc/Oo+sMcCQKFz/9waAixKL1i6HOnEw7APw8nvCYX8MRogjZqoxcLAxCsgNLJYJXa70wrszDmC6O3QDPBUSqgKA6wLbQxkaYIPMvhh+UMCqzCQNmm2ozIvohhcvtrSl7/wumPs6QEo9yQ9PU4DWovY5oNW1bXLjstGT+F9OzOeqL2SxRUCm9gDAV3H5+zYRTne0uYPesCGzYeS9tqw5KdjmnhwFSXzpJbrUmzEbxdUFrVYwFpqZcNQoHBIHrcgCAiGui1eLo65YPokA+gZn3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DOwrIbbQvHyovGD3jmaSzOQUVNlqVvfI4oaA+zXugHE=;
 b=H+I1nCxHeQryRQt5A338vgT6MacDyD2jajKwOtv+JRWMECqrGtQg7GlCYwCiqfCzEefmU0y9WRvaC8udUEgmBCqu7A+68/CRawpNDZLDCEgvcOZlBgZmjPKJMb5kZZExQtsnS73goCBkoxVO0ZVfvVM1NViYrkwD86yB4pm6FcE=
Received: from SA1PR21MB1317.namprd21.prod.outlook.com (2603:10b6:806:1f0::9)
 by SA6PR21MB4287.namprd21.prod.outlook.com (2603:10b6:806:418::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.12; Fri, 1 Nov
 2024 00:16:39 +0000
Received: from SA1PR21MB1317.namprd21.prod.outlook.com
 ([fe80::67ed:774d:42d4:f6ef]) by SA1PR21MB1317.namprd21.prod.outlook.com
 ([fe80::67ed:774d:42d4:f6ef%4]) with mapi id 15.20.8137.002; Fri, 1 Nov 2024
 00:16:39 +0000
From: Dexuan Cui <decui@microsoft.com>
To: Michael Kelley <mhklinux@outlook.com>, KY Srinivasan <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Vitaly
 Kuznetsov <vkuznets@redhat.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, "open list:Hyper-V/Azure CORE AND DRIVERS"
	<linux-hyperv@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
CC: "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH] Drivers: hv: kvp/vss: Avoid accessing a ringbuffer not
 initialized yet
Thread-Topic: [PATCH] Drivers: hv: kvp/vss: Avoid accessing a ringbuffer not
 initialized yet
Thread-Index: AQHbKlyHss5KWmFug0aMZtYQWKCj3bKfoGAQgABd3QCAAY9pkA==
Date: Fri, 1 Nov 2024 00:16:39 +0000
Message-ID:
 <SA1PR21MB1317A021B6C5D552B38C4368BF562@SA1PR21MB1317.namprd21.prod.outlook.com>
References: <20240909164719.41000-1-decui@microsoft.com>
 <SN6PR02MB4157630C523459A75C83C498D44B2@SN6PR02MB4157.namprd02.prod.outlook.com>
 <SA1PR21MB131794D6AF620CB201958EFCBF542@SA1PR21MB1317.namprd21.prod.outlook.com>
 <SN6PR02MB4157CDB89A61BA857E6FC0BFD4552@SN6PR02MB4157.namprd02.prod.outlook.com>
In-Reply-To:
 <SN6PR02MB4157CDB89A61BA857E6FC0BFD4552@SN6PR02MB4157.namprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=f2ddb8d8-b0cc-4ed7-8c4d-806213566d4b;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2024-10-30T18:35:53Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR21MB1317:EE_|SA6PR21MB4287:EE_
x-ms-office365-filtering-correlation-id: f7c42802-5284-40c3-f92c-08dcfa0a74cf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?pn4Hid5uLUkOOr8aqexAA8aF6ik75Vj0Klsmdy18J1fooHt/nBJ43IMzt9TM?=
 =?us-ascii?Q?2T55K30x8b4ktKL+ValtTN2MbrTvBav6I8AmFRGiqzkS4+2SkSbJoL9N1Wq/?=
 =?us-ascii?Q?pvNag0XPQWdGz8yS+FSwFC0rJ0Q/PrDkt9foVnAOuSEV9WTwA9Fusmxbx3hr?=
 =?us-ascii?Q?+4wxCYaplwrQ8fGGCDPkfToVTmIpc0vSk8KhkvvvJ7pZ7w5G/fYL4TSiJFJd?=
 =?us-ascii?Q?flEFkn9PeCmQYFbQf0u2F1A5LiZYP9WFl3GCSTh4VgsDtE1U8r0a7aQCcyoD?=
 =?us-ascii?Q?LBIXXrz9m8zlFJq1DSpnuTtLXcG/2O7vTccHnEoxbj9lsAGgxKGypD8q2OzM?=
 =?us-ascii?Q?BtCWfL/LB2imibYfkmhYn3g7Q8ZT//Y8dKXNnbbKPWpIMyrL4CSaenXR1wJ8?=
 =?us-ascii?Q?ZwZ1mogf+tbI0xHQjTsp2q9CYLQe4mf4MLWw2PGP8d9bPT6zyMP7sOBhaV5I?=
 =?us-ascii?Q?b+dtg2pkY9LKrBbKeRA7GcYIY95CIksTfo5yN9CyqoO2Z0nnYZ6whoZymddW?=
 =?us-ascii?Q?HowsFVyEJhSSsvTdaZva7++cDkA7w2X6uoxfFyDTLcnH3Tr4EgMz9wrxVvPt?=
 =?us-ascii?Q?YUQ9Yu8ePhBXAa0WaoZMBQCZHD8eJc8XFQliOVdAEyK5J8EfyNh+jY3k02IY?=
 =?us-ascii?Q?G69j1KkvS2CHDVng9UXLu2v6u0KGf3c3pDhnFsX9BGjJN+Sn6LVbrG2J+mBW?=
 =?us-ascii?Q?6FRUwQiPnpNUGTcXMzZ/jjT2wdIgConkFc8l34I5QrZqkfggL/cmmWyQjmaA?=
 =?us-ascii?Q?cC8n5dKfeZ+5N+IrrTdTLPnaVuCYZO6e5xkBmCvnJm9sdOM+CZPGyjfmkeV8?=
 =?us-ascii?Q?gZ4ViBZiv/pQeQMh4iNo4S0lS6zJynkZg5k9RHWuAlriwSQxR5+uM7miCvEN?=
 =?us-ascii?Q?BduOnrMn5AQHziFTciXuK4E3lHuVXgYBwIhKqms9np42E1Htircm7Q2ccC58?=
 =?us-ascii?Q?x76fuEkm2jsRPCPqNUxnvwQuK3ntlULkdSRk2C7YXvoDY8JqIcIkcNV+UUC7?=
 =?us-ascii?Q?87Q4V/y5W1cLg6dFzxlaSlCCKm2KTzm6/NZ1U3jYEoYEzV9DDHKTFEPcX4wq?=
 =?us-ascii?Q?E3uXFrnn+Fo4pT+uRYt2XUHvg7yv6PpGIj3xAO43pLVzSb9AVk3cPxQ+BsKv?=
 =?us-ascii?Q?qXQJIyIYAj13R6ffA+I/urcFn6uBLC3mojdrmWK02ajtHg8cplrM37q5RU66?=
 =?us-ascii?Q?1H7QJwgR20/IH5m7O6je5d4Mev6WLpUGLUDHKGa2clH2jelDaf/rHm8G1gHp?=
 =?us-ascii?Q?at/yptoOjHIm55PepXfKm8TT8x3gJcIdP8cZdaiu709D+cl92CX07idaq99z?=
 =?us-ascii?Q?qVz2oCwHZOPK/L9Un51AnSaQ82CrkfF1FzeHe++ivm5X/0FPFvnmCncLnMjx?=
 =?us-ascii?Q?C9WSbDs=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR21MB1317.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?5EQBjYPA1fZ8SXp5xjCQW01Z5fJN9QjqQcdDSY7g81yT8Gulk4NtMhoW0d5g?=
 =?us-ascii?Q?V9dMW8vkrSGx3eCMZrGAXzhaQ/2wLnL+mJxoxHcfdlTE3Quiv2XlYZTBxwn5?=
 =?us-ascii?Q?UrFrLGL+RQtTGcAoJNAhoqtArLeWpno8IQNsRWuVVQA8XTexIGaKPQa0OmFi?=
 =?us-ascii?Q?lJ4aVUS1+y8Z7pG+PZGFS1pRQo+zZ6p0AE6zbT25H2eHwZc/2ueDgnj3fDk4?=
 =?us-ascii?Q?Axqfe77wGlEkoeYlWsnfwfTFPvxZ/pk2ac5CdO8FmP+pHnz+oPe2ISENmoxt?=
 =?us-ascii?Q?7cVaUEFLm9CNzX9sT5VHhz+jUv+k0IxgeZFagyIUOKKg2xHGjrr2tUSqF9wN?=
 =?us-ascii?Q?0gyKjnohJzEyhmhGD5ZXJ6Jhss3t2KbOTZjk58+fPFeO6N9BIgWjLAUKgC5/?=
 =?us-ascii?Q?OzEmPa4N076Gr0bd8v+BqOpD4PWoOKQVFXpvyu6DaoNqlSmh8Z/kk4MDbdRX?=
 =?us-ascii?Q?5aHHHFlbpNwyhjOD0b1NWzjAKHVVqPgPtkzLNkhZh1+VU+x26rXTAjDnMXIh?=
 =?us-ascii?Q?INR7+S1Wlss2uej/LoqyEWo8wC8vZnRBFPrnfGNl4PntQdchx4O58BQoL6bW?=
 =?us-ascii?Q?4yTwr5yDV9zjNVnRCHnB2kUcdaR17LKiPrpFdmrDlH71sRyW51tXpaS/sTae?=
 =?us-ascii?Q?2UnjZFh/vkXNh3O3ErRuURZznkiO5UKTT5wDyv3/ACUTvVvfMDv4AG5ni9vl?=
 =?us-ascii?Q?uGIUV9FxPhE0Pa09x/bY3ygjSiGMvpgQcwiG+kJp+nnCgVy1IxFYXZdpdZW7?=
 =?us-ascii?Q?lPQXuV14Gwdf1nfGt0m6FF6bgrlb8rKyWMvsvzycTrJ9JTvu7Nx7UPFUwmKk?=
 =?us-ascii?Q?ve/2oBBTnKaDU3s7zOf7OOj2I76MyJT4eas34njgxj714IVCbp3N4RmMinMa?=
 =?us-ascii?Q?ro4arhGgshwaG97ksyEIMqafsITmWyJ5vUC21l7KlF/qoWBrlIQQTxTm14vy?=
 =?us-ascii?Q?ZWEqIbRrOn8PMhmCVLxBsBamDstV2sE87guQ5ktd1vuwFHb9yku2qf67VIIl?=
 =?us-ascii?Q?Dgxl2jNB1luNyU1aSPlejHKioNfTLB91B85o1UVhmknrMzoJNGfB3hW7MB/U?=
 =?us-ascii?Q?esi82kU0ivp667sIPHvQNSvyvu+04Xj+OHjUS8HfBsaY+SsA9lMZiQaVkFtv?=
 =?us-ascii?Q?3lTna5sA83PiNmO9QV2zK32z/G+fOiRBSx6MVNGfyXZ2SzhUZZOihi68Nbvp?=
 =?us-ascii?Q?ggEMcA3QSkflcBXKifkcbGzZbnsFZUt9FfXrOEMFjnsNDeX+V8+YNoWM9vIZ?=
 =?us-ascii?Q?MnJFnfNZXPH0/pij4SQsvW6ul/qslJvysm5FuBBPKnegAOPw8us18mtbZJ57?=
 =?us-ascii?Q?D4c43+CgD7pGHCvkfcPXvim15DV/fNiGeSDMVcbLHfDlfd+WAd47JxH6ASvx?=
 =?us-ascii?Q?0nNpgBrXGBp02ALks4pCS0ykgEUtAttC9eNZcqqwsvZ0N9fpbp4yrTBgE2zr?=
 =?us-ascii?Q?RWG4wiy7Vasy9OkkqczkOcnFjK7ofPT6oWrSubCSbhIO7U5FRVytks3TNVWW?=
 =?us-ascii?Q?TLFx1qMPuzPbauFY8rIPQn/7zBuamzf02I5ZZyBoBuNpO4G2dpI1igo4tlrl?=
 =?us-ascii?Q?B+1H8CtjeqZYaVAI2fU=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: SA1PR21MB1317.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7c42802-5284-40c3-f92c-08dcfa0a74cf
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Nov 2024 00:16:39.6003
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HmXaDfFAHs38L077KELKQQeKx8rc2KhTxLLPi9JET8PbtumuOldPj9kIsyMVxzWUQ6R/kO09AFd9c4Njs9LL5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR21MB4287

> From: Michael Kelley <mhklinux@outlook.com>
> Sent: Wednesday, October 30, 2024 5:12 PM
> [...]
> What do you think about this (compile tested only), which splits the
> "init" function into two parts for devices that have char devs? I'm
> trying to avoid adding yet another synchronization point by just
> doing the init operations in the right order -- i.e., don't create the
> user space /dev entry until the VMBus channel is ready.
>=20
> Michael

Thanks, I think this works! This is a better fix.

> +	if (srv->util_init_transport) {
> +		ret =3D srv->util_init_transport();
> +		if (ret) {
> +			ret =3D -ENODEV;
IMO we don't need the line above, since the 'ret' from=20
srv->util_init_transport()  is already a standard error code.

BTW, I noticed that the line "ret =3D -ENODEV;"
        if (srv->util_init) {
                ret =3D srv->util_init(srv);
                if (ret) {
                        ret =3D -ENODEV;
                        goto error1;
                }
        }
I think we don't really need that line, either.=20
The existing 4 .util_init callbacks also already return a
standard error code. We can make a separate patch to clean
that up.

Thanks,
Dexuan

