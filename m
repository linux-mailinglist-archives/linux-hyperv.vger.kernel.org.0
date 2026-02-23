Return-Path: <linux-hyperv+bounces-8957-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wHHGFrKUnGnRJQQAu9opvQ
	(envelope-from <linux-hyperv+bounces-8957-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Mon, 23 Feb 2026 18:56:02 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B427817B2A6
	for <lists+linux-hyperv@lfdr.de>; Mon, 23 Feb 2026 18:56:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 50A403019811
	for <lists+linux-hyperv@lfdr.de>; Mon, 23 Feb 2026 17:52:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14D2433970F;
	Mon, 23 Feb 2026 17:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="dT+hK8ia"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazolkn19010018.outbound.protection.outlook.com [52.103.20.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6121830AABE;
	Mon, 23 Feb 2026 17:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.20.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771869164; cv=fail; b=tySDIDJAKgoo+MTGrKHrKEr64lYwSRJheEb033E7kbhpT9yP0XC3byH84TUZyQ8a2QeejhvUH6UWG66DA4Bvp7QgIXAhoAS5fyk0w3mHmzQBtuYbGXLiOscgiQF/jwKpkf8wLYMCwCLjHoEzMrJ/k89Gi0lOL3d7dOuxV6LAHvE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771869164; c=relaxed/simple;
	bh=P0UE/JyWO2bnrryzVEzqYG9EGcQvJcdrJ4JZuqmwYBk=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bRNxJQDy+DiwBpJWB2y4F/vOEKTx5n7lPHrWmi3GOf2vaUbIVQMnn7lyIrNXnKYn9OlzkSiynhZKhq/qmdAFASdwLSAroLWitpA76Tub1G7jo0tHDtuvy6VWPGl4xKInSD4RNb+TLBIoZbovkylTNT64DUZWvgfSxvL/Te3GM7M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=dT+hK8ia; arc=fail smtp.client-ip=52.103.20.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pd6rMb9R2nTREro9pOSHndB5rOuokpzm3ozNpOA8ULF51gfd0D1KKWF+vEJoDWVuod3cI6gCL9W5c2Zo5wj2ztXENBCkqTKpdKXuZbNwWB0von15v2rUbFXSjkFViof94S1Ss0cyPozyLAyuEWHaDQ0HuYnbAYx4O3yR7ybCOW3OMeM7GXGSrqaW3SIz3XWk9FdXKeTYhb0Tb7R2JQUQwKC8DGTFIY7aWeu2r5ZdBx/TSLw0GtmEhZ48hUl7dE/3tGSuSCkKHdQVgNT/Za4cqJmXKWpl+64sBnB58uv74OhhLAY8mTar7nVCgYob9u15/2XraH3Iy3BOIiRne9XFnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GJrxwwcibOEbi4ygWlJ85b5FcjByYZETXsVQlzPuDog=;
 b=subuAwSsh/vtQXiDtt+uDCTjZLpPWS0W9JDx9rAWIspREPaXYCnk4DRciyn8lYxNgiQi3kwikMJLomd0nrG6f+8CpWc7nfN4e+qbkJJHKpyfytAFCskcivHxmeTgs8Pnk4odaWpAczTisseYcPCi8uLu3WcZYuEzTqaWgRXexrs5j2t1isozQBAOg1GVA/FNpwWyNHLbE8ATUwvNaRfQbe4gmswSRU2A48jEXl/Ca/ApHdn983MJzCWk17ZnfO/CR6KJIMwXvzsXQUzAGZCNvdNJGpOiG7nH7BOrl90Q7OP8ik3VKIDJkZHZyVibzjxFVMEJduNTv2n04q7xh+5k4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GJrxwwcibOEbi4ygWlJ85b5FcjByYZETXsVQlzPuDog=;
 b=dT+hK8iaf32dvvskczr98gge6bjiZaXldKIBNmKVO48tW52ET8iDBxggpoGB8lQWVJrVyjOqHgzLwKW46tnpArcpJle3TtFVZ5t27DhAo1S6ylA4XihC/B5J4xarLQbEECMzNiAIewmD3c6aEP5p8DRZtz9X5AfxzJSQB393od1IhNEpsGh+B+4viYLQ62ZvGfsS50nLriuv2oqZo/8TwFoEGDVMytV3bRG1jbgS32rlRm85v+ty/sYgxP1+cfyRwnj7lm4VXlQxXyqhbOH4nfw19sjmMeRkTT/f6a3LfzUMhvOdCh6NbqHhMPqtA4FT3/SQg7L+A0WT0qtQ3Sda5g==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by BN0PR02MB8222.namprd02.prod.outlook.com (2603:10b6:408:154::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Mon, 23 Feb
 2026 17:52:39 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6%6]) with mapi id 15.20.9632.017; Mon, 23 Feb 2026
 17:52:39 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Anirudh Rayabharam <anirudh@anirudhrb.com>, "kys@microsoft.com"
	<kys@microsoft.com>, "haiyangz@microsoft.com" <haiyangz@microsoft.com>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>, "decui@microsoft.com"
	<decui@microsoft.com>, "longli@microsoft.com" <longli@microsoft.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v5 1/2] mshv: refactor synic init and cleanup
Thread-Topic: [PATCH v5 1/2] mshv: refactor synic init and cleanup
Thread-Index: AQJTDlaDOFo3gBQj34wHN+dR2dNA6QIrSh9qtJJfMsA=
Date: Mon, 23 Feb 2026 17:52:39 +0000
Message-ID:
 <SN6PR02MB41574320BE9999D027389CCAD477A@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20260223140159.1627229-1-anirudh@anirudhrb.com>
 <20260223140159.1627229-2-anirudh@anirudhrb.com>
In-Reply-To: <20260223140159.1627229-2-anirudh@anirudhrb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|BN0PR02MB8222:EE_
x-ms-office365-filtering-correlation-id: 251bea1e-3a7a-4a89-9b5d-08de73045610
x-ms-exchange-slblob-mailprops:
 5fu/r660v9OFyJ+CxyO6ueseEO2yHaMVkWVlmUeY6VfLcQhAXi1DZlMLMUIqZZZO2CPl/rR3MVkfTyX9u1uLRRP5hmg0sXGZdmZglRQTAXIMgCYlx7cdxxOzWxceoHe4UVYtWP8LY2sZrDuvr2tnlm6QCz9yBPe4yptBvXZBuzEuRSvXJctr+lYrcXy5NEXPiDYQQCUd4wVTbCFAxRdcJgbscenfR8qtmWLG2I1kjehsSWkoyESqqnHZ6yN8sSUkLgi9rPjbPE7/7QzFdvHfy8dBnW3wpDKmm3RAFHVgDBmZaqIl0crH/FRJSYpjfYzWUWkMABvb28dJKE3Olhv4wW45xph+gJU7nqnEdzQ0s+NGuvKJSZFp50ShyUFZdVhGdajPihFXucXPgrVNPgRv2J/4jVUYZWQJn1SaS6LFWnK3mUwdrMDyAIGPFP4k+3KfCzNs2C/MS+aA9iC9Sl14m+n8EGcpMS+dUTKz5BKm/6hw0ZxYkH3OX3c5uYpzTTnEIL5PMbVmWnfOt+58bOcFngGPi5U5w+BdugRurkLWTxejVjlbsKIP5/0kW4Yge/7EZVhqhg185YB5HpJs9+nR8MiaZ+GZVEAtzEoGe2jICbN0eOOvV4TCJCwbqhZwodA9xXmY8GfqokFo6hcxXvmDsaXeWXJxKuddk8OwdARkwx9RhQkVLfHkvOF65vYOxV2KT+ZKqcCgKbwt2JZkujzqNPBqxMCL6e1yMtYuEb/lE3c=
x-microsoft-antispam:
 BCL:0;ARA:14566002|13091999003|19110799012|15080799012|51005399006|31061999003|461199028|41001999006|8060799015|8062599012|440099028|3412199025|12091999003|102099032|40105399003;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?s3hPxopUN+kduHYAYzONnNG2bCRGWhOI1G3v9zorw9NmZbnMhTbWRRVqhRRU?=
 =?us-ascii?Q?pRIRS8F1EFTmjbbhtjPW+NkEVdmveFXAfpd0+2LCo4phDjUhLoN682aAGZjP?=
 =?us-ascii?Q?krcQeuX3HPWYLpdU0cbdGxHox60haiHMk6OQUpfV2S0PyUDOcNixVNoh3t4l?=
 =?us-ascii?Q?TQJykC2lOV7JPJNto9biDo5TschrIhHbLQof6gxIZggcfmbITL21tTioEi9p?=
 =?us-ascii?Q?51x4dE2xPM07gkJQsFwNDQ/Shy0Vo9fyVeEuEBo8AOAfC4L2CyuMaQl/arHq?=
 =?us-ascii?Q?+lwPrSncFTQ/4yA2Al0wL2hbrzPMw5L916fKHnfLHx6DqLtt2W+EcS2pVGQi?=
 =?us-ascii?Q?a2dZlvWDfvSyjyToEU5U9jATl+qh7GbjIrWwZ+fT0FArO9ufNGlRsrWViAkk?=
 =?us-ascii?Q?m2jnyMg3wUVH3NxnnvzaEu0O7WkwP4KxCXRmtWphCT7Fnbrv+NDDkJl2l5zo?=
 =?us-ascii?Q?wsulAW33EBUg+SWuxE7w3f4I3Ffc9wNCftuZhvnCOJJlydKCrWTeVTSkWyl4?=
 =?us-ascii?Q?H4c1TCo6s4PKIilnQ7DNt+xyHNishVAUsulWIPRyQ2SPGJ56Mk9zbOyDm6qB?=
 =?us-ascii?Q?B0CJfp1507ZtIDbTNNwQz/TxLl7aQz6TPghVeL41RZzo5CABMhwu9ERrLPFM?=
 =?us-ascii?Q?4OZ9586h3w7bSmYw9Yo3cN2VlzqsoylZyQSgU5iTBrVUk2Q+f21bv/fP2XeU?=
 =?us-ascii?Q?YCs7qZSUxa47zyRqWvV31IQc3erhGOOwDUVeXq+lbvzdRA1TXpgRdO3EewSG?=
 =?us-ascii?Q?TaRhdvwqqrYG6c6GvFiZOB7WaIb7WAX/lZdg6SjHtkInprfC6OLxpqOAvRU2?=
 =?us-ascii?Q?5TS4l2rndaPu2AnFhNfNoF9FoVL0yQ+mQqCHNpbjYhBa2kYpHpew0OqdMfyH?=
 =?us-ascii?Q?f4RRwqrW/hm39WAgIuVZY2zrs19pEg8abr2WVqz9pFcCI9oBkTV4F6auxLTV?=
 =?us-ascii?Q?8dgEdsFyRKwjya02/PXqq7F3B08VH6ALQQOGwag2+pBrkxQ4QIgVplKEknDO?=
 =?us-ascii?Q?E2xdUIy7JC6+Geh1cv44Mw9jvxlhWuZfS4fVskQfv8nspXcH7HVrSdyLFGS5?=
 =?us-ascii?Q?BECk3hRsjlffhRwzb/KDhdFuKAbuBUyAIkb0ymi++ndEXGManpsB8FlnTpOC?=
 =?us-ascii?Q?12shS6sqvPdUpje9uNK160IhvQx30mTBx7i0wDUaDbwUpHWtrv70+/rEgkNZ?=
 =?us-ascii?Q?6lZM8YWfQ4j1XlhqYJH4M8iJG3U5vzMd0nLKHsVy0cNM5xnxoFm/RYMQ7sjC?=
 =?us-ascii?Q?3t7fQxJ9VdirWOkO9b6/q3rAS0nFHtPXHLppEtUGZA=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?M3nNUmwkAuJvQiTasmkSSE+usNS0n3Y44j8ZkUser6xKn2EOj1d13WhGg6IB?=
 =?us-ascii?Q?yalql/EB2IcsH20XlerzIYwksiE9+/H2tET+4QOMDMpNIeA5/7KR9y7sI8Zw?=
 =?us-ascii?Q?gALuXG6NYniXPAVNqQ6KP+HdtQzf57wH3ALdFNsdwc3JHB648gLna8PaMvfT?=
 =?us-ascii?Q?O9Wmb4MxwiwdtKXSZmeC9H5iU3bdc4WevnNALIGMMeDHZNUFbkzRGPm970Uk?=
 =?us-ascii?Q?yqL8HqOJH15VCZX23uLtfp4ILzrLhz4xi8y4MKBXLKEpKlx5S2daX7qZEkSj?=
 =?us-ascii?Q?U1+elczhfyPksX1RHJ7yojE64FB96akOGbpabXktLZZEBxpLE476wktJEbAW?=
 =?us-ascii?Q?oJygdNIrk8hFGgic87H9kTaZWr3UAHAIU5/G0+O1f3gRxIul4mcWiDAuGldY?=
 =?us-ascii?Q?4kNzK6jCzT+BNFSI9/C7BM4/b/xo4YeGG7goxhEps7GQyZiUUpnbFS9fi828?=
 =?us-ascii?Q?4Zcxr/+pNPxPvVv6btrGnSqlkQ50DyIvq6OdN3Csv2ojYdhyRJiulaViEj6Z?=
 =?us-ascii?Q?AOT/QDDRLMbmADMvo5PWwZk4i9BDprsnHfIQLeGXx49Dj7gorCfqSmpfT/2Q?=
 =?us-ascii?Q?Gs2G40rd526Wqs24aXUMq6jb2fIB4nPMIJKEfE7MYHSRWx76Fzy1YH+nKdXz?=
 =?us-ascii?Q?ahda++q6yqOh0NYsdsOK2yUbZxRqYfRpD46foQB8Qpb6WENYOIo7amDuP2Ry?=
 =?us-ascii?Q?7KobKqQt3tTS7AEqF/KdujQORJWhcn+RXBAtJPbw+REFNcHLVYKbOcejOep+?=
 =?us-ascii?Q?MkbhZQ+1oCqqusz6+JjjEwnETbRertHgILILQ7XHTB4yYKN1qq/6jJM8WoSR?=
 =?us-ascii?Q?se6dTlH3HP9AhtvAETKoyA15U84bSdJGtI2p+SbmvLpCnrQxDJvO1TPeGqZ1?=
 =?us-ascii?Q?mjG0GnkbS2cRGQdYRriVm/pCW45xr916UVENqf9unse25LiiVC5uiCfsrnV+?=
 =?us-ascii?Q?9ODcS3SYAjHaDaDfFvjgl/PkIYaXMNc+cNMOVnHis12KQr93HsvuZHteVnq1?=
 =?us-ascii?Q?45TQdSmgGKkdXDLdOQKLMB8KjAjPEoVuKGramjOT+qNyXEKF07ZQjkmd771m?=
 =?us-ascii?Q?1k9SFu0PfcP5OaRGMSA85fZ4GEhV/wmDSK1GevxfJ2SlF4T07wdylnymgzSj?=
 =?us-ascii?Q?Bbl4b/DrkTShtkPfXdU1jzDVQQxTxd7OBRWvIx9TQOq4YXZPwKu5g1Df2Khq?=
 =?us-ascii?Q?gH7XUCtcFVSVSDCJw5o+yScRouRfL4fpCX+glrUCL/afAUgfrrJ4ew/Scs1T?=
 =?us-ascii?Q?X247y+Vj4WI9hUeEAsplaMo3WAGwI1dNxXePTsF8xTeiYC15G8PyVX/H+AhU?=
 =?us-ascii?Q?4kxz//VZuCojY401pKamHB16gXg0PpTFKrPVhkwc+3FGs9WijET5owwKp32W?=
 =?us-ascii?Q?5K7qIX8=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 251bea1e-3a7a-4a89-9b5d-08de73045610
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Feb 2026 17:52:39.4047
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR02MB8222
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[outlook.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[outlook.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-8957-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[outlook.com];
	DKIM_TRACE(0.00)[outlook.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mhklinux@outlook.com,linux-hyperv@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-hyperv];
	DBL_BLOCKED_OPENRESOLVER(0.00)[SN6PR02MB4157.namprd02.prod.outlook.com:mid,outlook.com:email,outlook.com:dkim,anirudhrb.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B427817B2A6
X-Rspamd-Action: no action

From: Anirudh Rayabharam <anirudh@anirudhrb.com> Sent: Monday, February 23,=
 2026 6:02 AM
>=20
> Rename mshv_synic_init() to mshv_synic_cpu_init() and
> mshv_synic_cleanup() to mshv_synic_cpu_exit() to better reflect that
> these functions handle per-cpu synic setup and teardown.
>=20
> Use mshv_synic_init/cleanup() to perform init/cleanup that is not per-cpu=
.
> Move all the synic related setup from mshv_parent_partition_init.
>=20
> Move the reboot notifier to mshv_synic.c because it currently only
> operates on the synic cpuhp state.
>=20
> Move out synic_pages from the global mshv_root since its use is now
> completely local to mshv_synic.c.
>=20
> This is in preparation for the next patch which will add more stuff to
> mshv_synic_init().
>=20
> No functional change.
>=20
> Signed-off-by: Anirudh Rayabharam (Microsoft) <anirudh@anirudhrb.com>

This patch needs to be rebased on the latest linux-next. It doesn't
apply cleanly on linux-next20260219 and resolving the conflicts is
a bit messy. But other than that,

Reviewed-by: Michael Kelley <mhklinux@outlook.com>

> ---
>  drivers/hv/mshv_root.h      |  5 ++-
>  drivers/hv/mshv_root_main.c | 59 +++++-------------------------
>  drivers/hv/mshv_synic.c     | 71 +++++++++++++++++++++++++++++++++----
>  3 files changed, 75 insertions(+), 60 deletions(-)
>=20
> diff --git a/drivers/hv/mshv_root.h b/drivers/hv/mshv_root.h
> index 3c1d88b36741..26e0320c8097 100644
> --- a/drivers/hv/mshv_root.h
> +++ b/drivers/hv/mshv_root.h
> @@ -183,7 +183,6 @@ struct hv_synic_pages {
>  };
>=20
>  struct mshv_root {
> -	struct hv_synic_pages __percpu *synic_pages;
>  	spinlock_t pt_ht_lock;
>  	DECLARE_HASHTABLE(pt_htable, MSHV_PARTITIONS_HASH_BITS);
>  	struct hv_partition_property_vmm_capabilities vmm_caps;
> @@ -242,8 +241,8 @@ int mshv_register_doorbell(u64 partition_id, doorbell=
_cb_t
> doorbell_cb,
>  void mshv_unregister_doorbell(u64 partition_id, int doorbell_portid);
>=20
>  void mshv_isr(void);
> -int mshv_synic_init(unsigned int cpu);
> -int mshv_synic_cleanup(unsigned int cpu);
> +int mshv_synic_init(struct device *dev);
> +void mshv_synic_cleanup(void);
>=20
>  static inline bool mshv_partition_encrypted(struct mshv_partition *parti=
tion)
>  {
> diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
> index 681b58154d5e..7c1666456e78 100644
> --- a/drivers/hv/mshv_root_main.c
> +++ b/drivers/hv/mshv_root_main.c
> @@ -2035,7 +2035,6 @@ mshv_dev_release(struct inode *inode, struct file *=
filp)
>  	return 0;
>  }
>=20
> -static int mshv_cpuhp_online;
>  static int mshv_root_sched_online;
>=20
>  static const char *scheduler_type_to_string(enum hv_scheduler_type type)
> @@ -2198,40 +2197,14 @@ root_scheduler_deinit(void)
>  	free_percpu(root_scheduler_output);
>  }
>=20
> -static int mshv_reboot_notify(struct notifier_block *nb,
> -			      unsigned long code, void *unused)
> -{
> -	cpuhp_remove_state(mshv_cpuhp_online);
> -	return 0;
> -}
> -
> -struct notifier_block mshv_reboot_nb =3D {
> -	.notifier_call =3D mshv_reboot_notify,
> -};
> -
>  static void mshv_root_partition_exit(void)
>  {
> -	unregister_reboot_notifier(&mshv_reboot_nb);
>  	root_scheduler_deinit();
>  }
>=20
>  static int __init mshv_root_partition_init(struct device *dev)
>  {
> -	int err;
> -
> -	err =3D root_scheduler_init(dev);
> -	if (err)
> -		return err;
> -
> -	err =3D register_reboot_notifier(&mshv_reboot_nb);
> -	if (err)
> -		goto root_sched_deinit;
> -
> -	return 0;
> -
> -root_sched_deinit:
> -	root_scheduler_deinit();
> -	return err;
> +	return root_scheduler_init(dev);
>  }
>=20
>  static void mshv_init_vmm_caps(struct device *dev)
> @@ -2276,31 +2249,18 @@ static int __init mshv_parent_partition_init(void=
)
>  			MSHV_HV_MAX_VERSION);
>  	}
>=20
> -	mshv_root.synic_pages =3D alloc_percpu(struct hv_synic_pages);
> -	if (!mshv_root.synic_pages) {
> -		dev_err(dev, "Failed to allocate percpu synic page\n");
> -		ret =3D -ENOMEM;
> +	ret =3D mshv_synic_init(dev);
> +	if (ret)
>  		goto device_deregister;
> -	}
> -
> -	ret =3D cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "mshv_synic",
> -				mshv_synic_init,
> -				mshv_synic_cleanup);
> -	if (ret < 0) {
> -		dev_err(dev, "Failed to setup cpu hotplug state: %i\n", ret);
> -		goto free_synic_pages;
> -	}
> -
> -	mshv_cpuhp_online =3D ret;
>=20
>  	ret =3D mshv_retrieve_scheduler_type(dev);
>  	if (ret)
> -		goto remove_cpu_state;
> +		goto synic_cleanup;
>=20
>  	if (hv_root_partition())
>  		ret =3D mshv_root_partition_init(dev);
>  	if (ret)
> -		goto remove_cpu_state;
> +		goto synic_cleanup;
>=20
>  	mshv_init_vmm_caps(dev);
>=20
> @@ -2318,10 +2278,8 @@ static int __init mshv_parent_partition_init(void)
>  exit_partition:
>  	if (hv_root_partition())
>  		mshv_root_partition_exit();
> -remove_cpu_state:
> -	cpuhp_remove_state(mshv_cpuhp_online);
> -free_synic_pages:
> -	free_percpu(mshv_root.synic_pages);
> +synic_cleanup:
> +	mshv_synic_cleanup();
>  device_deregister:
>  	misc_deregister(&mshv_dev);
>  	return ret;
> @@ -2335,8 +2293,7 @@ static void __exit mshv_parent_partition_exit(void)
>  	mshv_irqfd_wq_cleanup();
>  	if (hv_root_partition())
>  		mshv_root_partition_exit();
> -	cpuhp_remove_state(mshv_cpuhp_online);
> -	free_percpu(mshv_root.synic_pages);
> +	mshv_synic_cleanup();
>  }
>=20
>  module_init(mshv_parent_partition_init);
> diff --git a/drivers/hv/mshv_synic.c b/drivers/hv/mshv_synic.c
> index f8b0337cdc82..074e37c48876 100644
> --- a/drivers/hv/mshv_synic.c
> +++ b/drivers/hv/mshv_synic.c
> @@ -12,11 +12,16 @@
>  #include <linux/mm.h>
>  #include <linux/io.h>
>  #include <linux/random.h>
> +#include <linux/cpuhotplug.h>
> +#include <linux/reboot.h>
>  #include <asm/mshyperv.h>
>=20
>  #include "mshv_eventfd.h"
>  #include "mshv.h"
>=20
> +static int synic_cpuhp_online;
> +static struct hv_synic_pages __percpu *synic_pages;
> +
>  static u32 synic_event_ring_get_queued_port(u32 sint_index)
>  {
>  	struct hv_synic_event_ring_page **event_ring_page;
> @@ -26,7 +31,7 @@ static u32 synic_event_ring_get_queued_port(u32 sint_in=
dex)
>  	u32 message;
>  	u8 tail;
>=20
> -	spages =3D this_cpu_ptr(mshv_root.synic_pages);
> +	spages =3D this_cpu_ptr(synic_pages);
>  	event_ring_page =3D &spages->synic_event_ring_page;
>  	synic_eventring_tail =3D (u8 **)this_cpu_ptr(hv_synic_eventring_tail);
>=20
> @@ -393,7 +398,7 @@ mshv_intercept_isr(struct hv_message *msg)
>=20
>  void mshv_isr(void)
>  {
> -	struct hv_synic_pages *spages =3D this_cpu_ptr(mshv_root.synic_pages);
> +	struct hv_synic_pages *spages =3D this_cpu_ptr(synic_pages);
>  	struct hv_message_page **msg_page =3D &spages->hyp_synic_message_page;
>  	struct hv_message *msg;
>  	bool handled;
> @@ -446,7 +451,7 @@ void mshv_isr(void)
>  	}
>  }
>=20
> -int mshv_synic_init(unsigned int cpu)
> +static int mshv_synic_cpu_init(unsigned int cpu)
>  {
>  	union hv_synic_simp simp;
>  	union hv_synic_siefp siefp;
> @@ -455,7 +460,7 @@ int mshv_synic_init(unsigned int cpu)
>  	union hv_synic_sint sint;
>  #endif
>  	union hv_synic_scontrol sctrl;
> -	struct hv_synic_pages *spages =3D this_cpu_ptr(mshv_root.synic_pages);
> +	struct hv_synic_pages *spages =3D this_cpu_ptr(synic_pages);
>  	struct hv_message_page **msg_page =3D &spages->hyp_synic_message_page;
>  	struct hv_synic_event_flags_page **event_flags_page =3D
>  			&spages->synic_event_flags_page;
> @@ -542,14 +547,14 @@ int mshv_synic_init(unsigned int cpu)
>  	return -EFAULT;
>  }
>=20
> -int mshv_synic_cleanup(unsigned int cpu)
> +static int mshv_synic_cpu_exit(unsigned int cpu)
>  {
>  	union hv_synic_sint sint;
>  	union hv_synic_simp simp;
>  	union hv_synic_siefp siefp;
>  	union hv_synic_sirbp sirbp;
>  	union hv_synic_scontrol sctrl;
> -	struct hv_synic_pages *spages =3D this_cpu_ptr(mshv_root.synic_pages);
> +	struct hv_synic_pages *spages =3D this_cpu_ptr(synic_pages);
>  	struct hv_message_page **msg_page =3D &spages->hyp_synic_message_page;
>  	struct hv_synic_event_flags_page **event_flags_page =3D
>  		&spages->synic_event_flags_page;
> @@ -663,3 +668,57 @@ mshv_unregister_doorbell(u64 partition_id, int
> doorbell_portid)
>=20
>  	mshv_portid_free(doorbell_portid);
>  }
> +
> +static int mshv_synic_reboot_notify(struct notifier_block *nb,
> +			      unsigned long code, void *unused)
> +{
> +	if (!hv_root_partition())
> +		return 0;
> +
> +	cpuhp_remove_state(synic_cpuhp_online);
> +	return 0;
> +}
> +
> +static struct notifier_block mshv_synic_reboot_nb =3D {
> +	.notifier_call =3D mshv_synic_reboot_notify,
> +};
> +
> +int __init mshv_synic_init(struct device *dev)
> +{
> +	int ret =3D 0;
> +
> +	synic_pages =3D alloc_percpu(struct hv_synic_pages);
> +	if (!synic_pages) {
> +		dev_err(dev, "Failed to allocate percpu synic page\n");
> +		return -ENOMEM;
> +	}
> +
> +	ret =3D cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "mshv_synic",
> +				mshv_synic_cpu_init,
> +				mshv_synic_cpu_exit);
> +	if (ret < 0) {
> +		dev_err(dev, "Failed to setup cpu hotplug state: %i\n", ret);
> +		goto free_synic_pages;
> +	}
> +
> +	synic_cpuhp_online =3D ret;
> +
> +	ret =3D register_reboot_notifier(&mshv_synic_reboot_nb);
> +	if (ret)
> +		goto remove_cpuhp_state;
> +
> +	return 0;
> +
> +remove_cpuhp_state:
> +	cpuhp_remove_state(synic_cpuhp_online);
> +free_synic_pages:
> +	free_percpu(synic_pages);
> +	return ret;
> +}
> +
> +void mshv_synic_cleanup(void)
> +{
> +	unregister_reboot_notifier(&mshv_synic_reboot_nb);
> +	cpuhp_remove_state(synic_cpuhp_online);
> +	free_percpu(synic_pages);
> +}
> --
> 2.34.1
>=20


