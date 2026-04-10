Return-Path: <linux-hyperv+bounces-10106-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SKhGGVJp2GkhdAgAu9opvQ
	(envelope-from <linux-hyperv+bounces-10106-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 10 Apr 2026 05:06:58 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C7F543D1AF5
	for <lists+linux-hyperv@lfdr.de>; Fri, 10 Apr 2026 05:06:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 49EE33003E80
	for <lists+linux-hyperv@lfdr.de>; Fri, 10 Apr 2026 03:06:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D12602DF13F;
	Fri, 10 Apr 2026 03:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="d+9MFXiH"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from SY5PR01CU010.outbound.protection.outlook.com (mail-australiaeastazolkn19012069.outbound.protection.outlook.com [52.103.72.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 800CC175A75;
	Fri, 10 Apr 2026 03:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.72.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775790410; cv=fail; b=G8UoVB8twuUi2q3J0Vh7LeiYfRASNndcNTP6mLiwVRrbYxeKSpt4Hsa+PA3to/eRfqcmR0pHYXVysB/+vTnGYgsqgOnvNTwYW1zsBe/HIp7dME39M4O44Br+qkIdOSRfoC/D8/ojFPATka5IDrhlQfVXI/upR3K5z3uGAHdD+Lc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775790410; c=relaxed/simple;
	bh=mBs+ZLFRZUJLNouDXu4byFomqKjPgzVZ5rKt+gpIj9M=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Lz+f3LEwKsazGt/BB7iEi0XzPIEpQbKbJneCd0evVTndFWYuKhlvNaruHeDE1ySsHcjqnsmpVJwkxajMIaRzZ/ibMTxlJG5RPurEpIbxsBlSIwR2LfukZX926qdwKcNnA7R60poAE31167yyZ26zC2VynWJ0CZtLthagLpeYE9U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=d+9MFXiH; arc=fail smtp.client-ip=52.103.72.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PG4jMA93T9ed8t49F11h41aT4A1B9w9MU74gCaSNqOjwKvyGdB1XfDmNGjJOD2DjWyQircoihMX3UsFD0r6TtIwOFiu522E6ROpKhp5thifl/eQSHwqrp7ohimFa4Ksdrwq2666UyZ4eC2vPdwPQ8vnRT25wBzPpS1moteTrAxusNKjr7GeN32uekpV7QEWZco74wLvcS/BKHA+jJ4AloLFVF9JiBFVImM2ckF69HWI2kUikHlsghMekvRWjVokME964vZ8h7Vr8vKGPWYuQBieAIDskypM6GbB3VI0HDHXYyLataBLZBVsUl/An2MUXq/NAT9OLJ2MTWzGOlq7XOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mBs+ZLFRZUJLNouDXu4byFomqKjPgzVZ5rKt+gpIj9M=;
 b=zGiZDMEHzN/1T0Emql4pMapI2avpIyMf+NccaoMORxxhmQakkE1sOXtP651W1oI6gsY2BeL8j7tDkY1Mq9q0+XSGz5RxkzjjeNgzc6JrPzdfSB5IyPu+CNcVMrm+5PJpj4ypgYCBoPFvuciPR5xkIqgTlSReyn+0nLU9ImTGP0+WZvm8ev6X3eoc7xxeY9UemYvNqFTBobpSA62p5tc3d3yfvsz9RDcJvC+8H5EuwNw5WBkypdLM5UhOtSb4GVXzk3+OllLWeEIiRzi6AMQN7D22oiJdlL0nZSFc44Xmrh0LbLrFzq93v305Lnrmuy3WLbjt1A0Be3rZZABfAjBDEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mBs+ZLFRZUJLNouDXu4byFomqKjPgzVZ5rKt+gpIj9M=;
 b=d+9MFXiHcYPAe+3AdGE312ZYigqILKRC0lWty2IxNxzTbJYHwmZcUYqDLb7RuDs93CZ4PdSIphHGCDhFButY1EfZak1D1BxMb8xZ8+SypHEKSzbqKcfiBTrEMkGbFYr5m8mrs+FWUG+lgVC0XMr0+UlomY9fmO3pO6hBCMBUVYTEUR28Iw40Ryfb7pWKyPRyTBWFg0jaB6xH9eclB3ClThoAGP8o1uA4nm40I6vtcV30oB3VWLg7uUD2vNnl/q8a2z9SZtBkI6u9ziQv17M1KAvdMYhL+RVf8CyMSUtfPdPhfgAuLF4Hc+X3IxwCTT9VE/9xwCt/XYTmUyp4+KBx5g==
Received: from SYBPR01MB7881.ausprd01.prod.outlook.com (2603:10c6:10:1b0::5)
 by SYBPR01MB6431.ausprd01.prod.outlook.com (2603:10c6:10:106::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.18; Fri, 10 Apr
 2026 03:06:43 +0000
Received: from SYBPR01MB7881.ausprd01.prod.outlook.com
 ([fe80::7cd2:d6e8:3fa0:5f0c]) by SYBPR01MB7881.ausprd01.prod.outlook.com
 ([fe80::7cd2:d6e8:3fa0:5f0c%5]) with mapi id 15.20.9769.017; Fri, 10 Apr 2026
 03:06:43 +0000
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
Thread-Index: AQHcvpRNbg/7iVrB0UyyX/rVQKTUD7XMcrMAgAs+NQA=
Date: Fri, 10 Apr 2026 03:06:43 +0000
Message-ID: <89730D18-D9A3-4A18-87DD-E7A51625FF69@outlook.com>
References:
 <SYBPR01MB788138A30BC69B0F5C3316E5AF54A@SYBPR01MB7881.ausprd01.prod.outlook.com>
 <ac76zlXjXhPVkA6f@skinsburskii.localdomain>
In-Reply-To: <ac76zlXjXhPVkA6f@skinsburskii.localdomain>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SYBPR01MB7881:EE_|SYBPR01MB6431:EE_
x-ms-office365-filtering-correlation-id: dbd401b3-191d-4a3a-7650-08de96ae31dc
x-microsoft-antispam:
 BCL:0;ARA:14566002|31061999003|12121999013|22091999003|24121999003|51005399006|8060799015|41001999006|8062599012|15080799012|461199028|19110799012|40105399003|102099032|3412199025|440099028|26121999003;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?Ec2Gg62+QCfMa+kc47+S3uFEOaX6DZpt9pQ40VsA8wHWtkrD528nGeoEtsZe?=
 =?us-ascii?Q?1qCldv+3NwLlHPlRhxGLOoJ6A4PXJmjtOILei735Zlf9LIUYBonH5w1bMqw7?=
 =?us-ascii?Q?USbygAPlWDSbzK3FKl8tHGK4pE1F2OZ19YhkIvNaFf0DWr4qjVveYCya0C9J?=
 =?us-ascii?Q?CvB31HURW9X3YDJNmE33Aj5kYAJF1MmGqp+NkZiioePx2X4yk/WYPKSLOEO7?=
 =?us-ascii?Q?uFGxyQjISJuRLRDiYN0lbNYGhxiyI6W3XNbLxaQBVsz2IrYrSbml4MGqIy+j?=
 =?us-ascii?Q?YhGa1efMTLvTiAwHy/HcUoNYQeU1Zxt2k82dk3oUqIro8WsWlwi7AnP0/Ncm?=
 =?us-ascii?Q?kTAwljsxo3AIMNEUYt3PUdqUqNWg7Fd3ImDizoxeXg1XCzHzoYSOLju3zs5S?=
 =?us-ascii?Q?ETMoChw3WLpM6wVsNrFyQXg3rrVIAT7ydUMUqgHCNLwIRSJLgCviy4aD5FAk?=
 =?us-ascii?Q?Z4+1ULnePKqbFIzklF2Z5OnNQhGg7Q/9K1i/RwhEOrXav1tDV9lZvMqR+qIm?=
 =?us-ascii?Q?Eqs+QoPqLo4W/kchx3WV1sM59xDBooVJuGht6pxa5RZwMBLOAPaDf0L3se8Q?=
 =?us-ascii?Q?uS2WBKXgzPimuY6MAGGgNrMSv2snjetaVuapzLt6F3ielVf7r/Gk8GvUY9i8?=
 =?us-ascii?Q?GUyVoVVKJGO/wBMJ9iMP63biZAyWiMJywuk+LY2lue8+23l/uhpIJt62USF7?=
 =?us-ascii?Q?wH6WgMJq6xomCcmoz8mG7QFMCVvOvL1qBGTTfFx6smry+LDaI0eZsNxf3u7D?=
 =?us-ascii?Q?yNmWl9R0Do00R7aECMzW+/8YZYm64+3OAmFF3uRPatsZ2jJwb+Y4I5bC9DyO?=
 =?us-ascii?Q?IA9hCFdOONihbb6pMIwxSF61pmXqTko58GncydDzMebS3qmzomoy5VOyaRR1?=
 =?us-ascii?Q?kJjacjiUEbxlP1FzKc10CSKTUJ+NaUU1XVVYZJqP9Ut24blmxXWAyqlK8qiG?=
 =?us-ascii?Q?a4Mp4bhoARVVBbQv1z5YRMiIXNRAh64SHrrFhA29acdxE8LbveUnTls6GNX2?=
 =?us-ascii?Q?NrVT8cDvlqzK4zvoEUvKjqEcLflX/ISlxdt6bLNYBm0dMTx9C37AKg5t8c3k?=
 =?us-ascii?Q?FqEEmxvV?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?UqHsxFazvCWJOoxNlz6Th7Lpqef+NYEj4X6CIeTO9rzcn31Xjut6Wca4SsZc?=
 =?us-ascii?Q?iiVQ2dMtd3WfJxd0vzmmdA8sIV+oAJrViOx+aRWo0ykkwMO0vrGX86kW/UY8?=
 =?us-ascii?Q?n/rdx+ccaSrRzcOlXha716LZtOqd61D8PFEOuEcL7Pt3VSILa4DkhgpUB3p7?=
 =?us-ascii?Q?X0ox2VDwS3SG7kz9oUEJxUgHVX8FC2juU3cVNcL1fw9fPu1lQ1uDUQqWXcjG?=
 =?us-ascii?Q?oac7LAtEJKP92VuYtLyvmtKIWQQt0VYMYk5rs7dMp+3q1W0jjyQV5Yv5VkgL?=
 =?us-ascii?Q?Oi2ta8DZrQJe1kj6q8WXdOX4H/1uwixRofzu/IPzG5ZRoav9JJy7Mmq0PFHo?=
 =?us-ascii?Q?hvMv/7NRiUZlyHDqqDcf8SBrlE1G9/wRXwTSYcSsZarHlYeL3a7upcuXgUpC?=
 =?us-ascii?Q?gZRPSrs+hGF8tvoXqrydaTTg0EicdA5Bh4vNin3yZfnEW/iSnno57SajV0VV?=
 =?us-ascii?Q?PCYYhfl8GcCTHCJ9CRAqGkV9ObcpGBjAaghmQQO908MLRLX16crgKyQdjZpm?=
 =?us-ascii?Q?QB78dkeTrQdOfr9kkj5T7fNO8LmiDSC1W1toUUVyCr0E6+OEgecJ4BLNZcUS?=
 =?us-ascii?Q?HX8j7fCQpDopjhiWMGQ15TIaJsQk4klxsD66XSTtxP0pq2LHkG6Y8661b2yk?=
 =?us-ascii?Q?xO24FNd7RRhXEyiwpSNHyzqc9BEGP8QZAaeejfmXvUQlEt+106IBun07IVnJ?=
 =?us-ascii?Q?WJiLjH6SzDMoNLihzPhOHz98WOubiqyocPh6LIxRV4CLihlvLQcuOeO7bkac?=
 =?us-ascii?Q?o2GlX/Ja6K7DzLJsBGCYLD72z/9cnzlo3kJyS9ufcrKQHwjWSiyxk/+viP3f?=
 =?us-ascii?Q?3CpSWmCDcVZYdWM1hfKneGZ/OFv/Ybf2D87fL0Ig3hwbG1tMOCOroN0GtGe/?=
 =?us-ascii?Q?D9SJDUYQHuRmDjIPFtBSpEe6UX6QrJf9GM7AcqdRgdLnZ+B3gvRb6lidyJfV?=
 =?us-ascii?Q?AEcjCQ1R+dVJpCeirdLVTMupiYOULlCOmJ7mtWbiX+Le81vw+QSOhiUphxd1?=
 =?us-ascii?Q?VnM6a+6Kd4MOgy3gRgJCPrccOobbewDieoU8K9kVVI+VwOmg/U1GO3k05Rz9?=
 =?us-ascii?Q?m4JSBYje4tWP1mWpU9azqS9Ud34AVUica83V/pdJhOYRc8Gitd3s76ScG9zz?=
 =?us-ascii?Q?R2TUnANg3rPsdxts8zowWlGaG2GnI/XPAOxoOzfdtQh9WgcMeEb3P6vxq1Eu?=
 =?us-ascii?Q?gBmmIpazYdFCjyngY0REQLXDcVE01ia9W6oDkwhrlSyyLRncRB8O3JRfGSxj?=
 =?us-ascii?Q?WNQZlzIsDXuMy7vkv8M1aoX2+iZaZaKJf6v3EsINONgXZa3tiX+XmYvhjDep?=
 =?us-ascii?Q?QFrJ/Tl/qz65vlWOlJkINgTqzgAhex/LwLs/k4oNsgKuy/SmdJLL6H8i8GYw?=
 =?us-ascii?Q?SeMaxXmK4fqwMAiFjIc110GBBP4AfnJ7IZbglyfP6T9nlIhfpg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <4FC424689F173B4FA278D87212FAC2BC@ausprd01.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
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
X-MS-Exchange-CrossTenant-Network-Message-Id: dbd401b3-191d-4a3a-7650-08de96ae31dc
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Apr 2026 03:06:43.7912
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SYBPR01MB6431
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[outlook.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[outlook.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10106-lists,linux-hyperv=lfdr.de];
	FREEMAIL_CC(0.00)[microsoft.com,kernel.org,linux.microsoft.com,vger.kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_FROM(0.00)[outlook.com];
	RCPT_COUNT_TWELVE(0.00)[17];
	DKIM_TRACE(0.00)[outlook.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[moonafterrain@outlook.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-hyperv];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,outlook.com:dkim,outlook.com:mid]
X-Rspamd-Queue-Id: C7F543D1AF5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Apr 02, 2026 at 04:25:02PM -0700, Stanislav Kinsburskii wrote:
> nit: both comments are redundant - the meaning is clear from the code
> itself.

I will drop them in v3.

> This maximum value check bugs me a bit.
>=20
> First of all, why does it matter what is the region end? Potentially, the=
re can be
> regions not backed by host address space (leave alone host RAM), so why
> intropducing this limitation?
>=20
> Second, this check takes a host-specific constant (MAX_PHYSMEM_BITS) and =
rounds it down
> to hypervisor-specific units which may not be aligned with the host page
> size. Should this be host pages instead?
=20
This check was suggested by Roman in v1 review. Roman, could you
share your thoughts on Stanislav's concerns? I'd like to align on whether a=
n upper
bound check is needed here.

Thanks,
Junrui Luo=

