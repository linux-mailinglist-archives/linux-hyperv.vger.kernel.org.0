Return-Path: <linux-hyperv+bounces-8653-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yKI6D2vsgGleCAMAu9opvQ
	(envelope-from <linux-hyperv+bounces-8653-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Mon, 02 Feb 2026 19:26:51 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id B18EAD0259
	for <lists+linux-hyperv@lfdr.de>; Mon, 02 Feb 2026 19:26:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 133F93006825
	for <lists+linux-hyperv@lfdr.de>; Mon,  2 Feb 2026 18:26:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26A362ED843;
	Mon,  2 Feb 2026 18:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="bUhWlhat"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azolkn19010004.outbound.protection.outlook.com [52.103.12.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 664662EBB8C;
	Mon,  2 Feb 2026 18:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.12.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770056808; cv=fail; b=jyYejZ9vPRIYO7KfHSKrzUnhEgsuN+/bDxy64zBgU4qBDyI9k2uf62ijftrg+cRevR+lVNN7m6zNI45/rZ8ZPDj5rfCysYmNRC0q+VBvlG6It/W0AybVAUGciTXmHa6XqfdAoqCOU3tK07L24c2xfY+WSoKFjCRL2nMmSzY9voA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770056808; c=relaxed/simple;
	bh=ZEP2ZWAqqbndvowkL8CV6y+RMPOYb1Bq3iPZ7kMJEdU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=f4ER/QWVN8hwaBxGzz8uDafGjtElQf0PLPd+Z4Kb4mgh0ekuTmKMx/2U3hVxcpV37YSJW9LupJPUmYPnzZDDEFInGqFLGIrqfSUjKEkyfFIPqql7IrdcRw1SanvzS8L1SY5nmd7P9ch9+m0g0J406+OwRDL5IwydyWvgXSA+qoQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=bUhWlhat; arc=fail smtp.client-ip=52.103.12.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x9u8dSQrEoEUh4EyEkHE3xoLH5NNgjJ70PkXaFGJoYwW6bKfE4bPcDsg257djuoR60UKYHQqDFHnYQtqoo6mBvY7aFNM5Prjlit3H58zMMM4cKEAZg1VTw2HClbfe8MrjUFxQkyvImcKEgz6s7j/2Fy1JVwwQMt4fSg04lOusBZQn1grrRsobaUDcAyeth9QxIVp+n82YCimIyA4Pa5gOkLmRLP0V2xzW3qs7ttoAsODJjWUb4UB7SUcjGybC5TxYk/cI0Xap45WoKqGyK6yqeCC04+M3c5V/CRKZbSWUc0tXPca/e8UnSn6FANXI+nB7zTMV2KWY/vIIufuXeZm3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WL9wLOt5GSddwlCzYPlY8bc6bZyc26KhY1M4RZtSaRA=;
 b=YjcJMWYRKhOBwDEwQVhMMD2Q7DW9y5eMf8qCacXGonUOgglP7QiWr6PABqSlbkPI2YnCHlvH6YCBgRJNzdi2ZWOXiJ0pFAMsQJdR8oyXguthRQfV6ZCj2DeGvanc1ZmlWp+2ROvWS1bRGTNpEN5egCVsPr/6qQC4WtN3kiakkbP0RY26A1DmP8DdDdJbbqaTaLwUEZoc3pDxhj3knq6RUkcq2qb9I4mQlSK64f0Z2NMZ7ScF9TVrw7trXsrlSR1OtWHLvPd+pwqtf/0qudjZnPg10/De430gmAdd0SfgTUe0A9eb9n84krkQkCH5I+6B5rUeXiEyhYSf5Ek6H7Bt1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WL9wLOt5GSddwlCzYPlY8bc6bZyc26KhY1M4RZtSaRA=;
 b=bUhWlhatwe1nLotImEQo9eGSop3oiAEaE5TwCBAzA9spv9dhcqsShH4MQYxwxHckMFr2rPHN4daYy1061KKpgnfQrXavdHhkKVX8TOAtSWlnD2HaQGnAPVS5XlgAi0UQtdw0NDIg6Go47/TRmGgnK3xmbsSFsB3LZTaSWKnuZNuSGcxuwB3AhJgNu84L46jtpow8gsbT9e5YLjxc+xBu8qV4kkENlCsqu6uSL6G4hUCUZ3yUr4+WYFRd/9s4K4nutYkOsRcAa5aqCLBQ/3tClTltiopwZUMuc8xBEfeZixfWCehecb6nzK4MKfl4rRz82n7uwxjJbOJDbbrj/s8iXQ==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by IA3PR02MB10518.namprd02.prod.outlook.com (2603:10b6:208:534::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.15; Mon, 2 Feb
 2026 18:26:44 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6%6]) with mapi id 15.20.9564.016; Mon, 2 Feb 2026
 18:26:42 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>,
	"mhkelley58@gmail.com" <mhkelley58@gmail.com>
CC: "kys@microsoft.com" <kys@microsoft.com>, "haiyangz@microsoft.com"
	<haiyangz@microsoft.com>, "wei.liu@kernel.org" <wei.liu@kernel.org>,
	"decui@microsoft.com" <decui@microsoft.com>, "longli@microsoft.com"
	<longli@microsoft.com>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/1] mshv: Add comment about huge page mappings in guest
 physical address space
Thread-Topic: [PATCH 1/1] mshv: Add comment about huge page mappings in guest
 physical address space
Thread-Index: AQHclGTjfuUHRH1hI0mR1MgYgqXlO7VvptmAgAAPmDA=
Date: Mon, 2 Feb 2026 18:26:42 +0000
Message-ID:
 <SN6PR02MB41570BBE17C50675E94789FDD49AA@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20260202165101.1750-1-mhklinux@outlook.com>
 <aYDcLRhxx9wXRXBG@skinsburskii.localdomain>
In-Reply-To: <aYDcLRhxx9wXRXBG@skinsburskii.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|IA3PR02MB10518:EE_
x-ms-office365-filtering-correlation-id: 04e81d79-b73d-4da9-14a7-08de62889d30
x-ms-exchange-slblob-mailprops:
 P1EfU6pZOd8VPwDsmXmpSwyPl9aRR8R+jVr8MaVsq3hRHCmTm9UERh9Jq3AOJotJKJ82hDAPzlnyxVmxbSw9xhMSRfY8WsZeHKZJppN4iQYPtcfBZgG1x/766myQrKfF0IqjysgROMQWdZQsbc/rAwudNN0Vdv/t9ivFuYVH1/tpAaR7tWULlqbi9KmYo9nSddIKJonWhm1VWOvhzEErL8WFt+bI+VJbF8V6m2U2ohxQfXCwCseUuV6nYESdU7VfTRwOL8eNZu3Yl6d8NIBwxlr3aHHRkUsJHRrwnQsIZkhm3/NGmCEf3Rd9lHgi1JlueoRyq5LjGckGo9EsTr6sja/MnXx0Erfj5uDVsZHcaTz3GZWxC6zNKNcNrVu4jh4khsqnbmGmtwQ2QzGbHGGvJChft2xduIdxthLwP1V4Eirdtz/Rz8ak+Mj3KcnCjeV2R4+IyrVwkK62Xcdy1yHiDib0DPsCdni0RIL4WdVoOTGDJHv8Ne9gQR0g+KvJFwYRM8ZpZd+Ay70C+5e8Yi89keqBDZdoFsSdGbDTy1Vba/vgTDBcONJW0negTnvlOI0uyQaZCUdlvQ86aPPBZEta0VQzJR5Mln+rOScyMb/GF6DElrzvpY4sycrNbMoBxQksPkCWIW55FQgsHuBBoM+bmER6QD0fDKbAhQDkT5vrRc2l7vnNTVnQZxMSLWIHFzgft7QslaQRZZEX91Bc1m/rcIsBSbZpzUDWn9AqE7a9O2iPE+m9i2c7ZmWfDdn+1T9lnT+Jq44eHj/fvkcScOCK1g8pkYoQErf67i2PG6YtpW86kOisZlwiFA==
x-microsoft-antispam:
 BCL:0;ARA:14566002|461199028|8062599012|8060799015|19110799012|13091999003|51005399006|15080799012|41001999006|31061999003|1602099012|13041999003|40105399003|3412199025|440099028|4302099013|10035399007|102099032;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?i/IIbYMKUwbWO9W/nVzLMP4IRNQyVDpxvEPLSvtk+5B0DUWjeXTsRSUvdsi6?=
 =?us-ascii?Q?6UHWpCcBawHjxxPlyLLBvGCZhIADPdvBSQTcFQwqAwoTBtZbXaiTWF0qSQQY?=
 =?us-ascii?Q?j9I5yJjwjRXKOAVJPz2pNHoyJbgwzNkTOK4U4pBetozuOZOsnEbqSnEWxnj5?=
 =?us-ascii?Q?HwGk6tvBdsJTF3BoTzdqdupUmuhHZU9xxGuZeIsa50jjUBxO0mowaRfvl9WH?=
 =?us-ascii?Q?IL/+kiYC+pIFQaCvoHAYOfGKrbzd9bD1sXSi0E6ZbZxwZ/vg3AelFWRSk9y5?=
 =?us-ascii?Q?Z8i5e9/CkAMr2oRw4fzb9OMW/QBedOOH7nR3eeSxQ+gE49WEpzkT7TYu6r1t?=
 =?us-ascii?Q?CdzJD9JFMe2KhuueP+vxaLX+UX8Dj09ZkH+i2oEJaE3ko/V1atuVvpLUKd5G?=
 =?us-ascii?Q?H3pZA6//Gs/SzbLmMrLfxOeBzXDeV2gOldBer5v4aCFT31DeDWU9+GgtxJz7?=
 =?us-ascii?Q?+ZTMjoqmmugpNLpJFQRbt0Fd1XSi3N4mjNmB2vraOshNJaTnHDdRD5e81VT1?=
 =?us-ascii?Q?mgBNEFIwBsg1Wmg+GwLDGX5JeF98dp3/Zjy1DqCyvEDG4YoJD5E9lVQllWsj?=
 =?us-ascii?Q?fHGLQsembpJkpPCCEd1m+wzQ6ZtbUEnY93fNpkWhQrNlnQsy7GnKb6WfOxnD?=
 =?us-ascii?Q?XR51SAbc+XlQxezXawiebqCNtPuHfNt+xCcyXP/WiFkWWcp6eF5aNgbtDHZk?=
 =?us-ascii?Q?EfEt+uMfHuAO9mJ4bFkOUAGq5qoLdGlB1AuSe4FC7Vysx7qor74q/ckP7cIA?=
 =?us-ascii?Q?WjMn8rQ1SjbAuXRi6fttDS1B20Y5eaG6PQcwHXAdFkfQl2QW5ZlrpAvWSIF0?=
 =?us-ascii?Q?nFWCAtzBTzAICUuagLHzbdXN5JU4S32x3hkZOyHP2lCD5gg+x0dyzoRwRLuQ?=
 =?us-ascii?Q?tiLeLu2Xt0GhlYmrDSjV0/qzuvXXr3QGIDmes/pb3uoo4LLXLIIzJ5bMFKrY?=
 =?us-ascii?Q?z+ChD6TLjRZegYbODnNDSAvbsmnchvOdX8UJpGr3ZdCz3hmDR3D1a2gZ3Ood?=
 =?us-ascii?Q?phG0a2PdfRjvQriRQs3Es2Dm3dzAH5Jg54mflPJsxio9NNJpXQcGdXPAs2xA?=
 =?us-ascii?Q?HH8DbH3qwgKdJ82VCF2Na+XNBOGqgYHIUXsaIhA7h+CbEHpyUY02v5ScfuQm?=
 =?us-ascii?Q?8EDYoIJ8LCKLrXM9Qc3Dldd7pcIFaGvjCb6GaG/0NSK8FX6CZJ+PGN9UTEUS?=
 =?us-ascii?Q?Q1Pw1DnonI7o6rsGym6Wno29b1Jw5NtyL3h3l6QOnNJTm6H67E5r9WJDAIkY?=
 =?us-ascii?Q?0taQur/KPCLGYJ6c/7cthNzYa2Ax69s//sBXzWIujqlSO4rDnTMNO++urDy4?=
 =?us-ascii?Q?lHq8SRx/DMXMSw9p9rh6ybXgKBQWBbz/MANYDcoUNSLijqtBGrGqXK9jLvbD?=
 =?us-ascii?Q?kQGl2qdYqlMXV9YwvPY96dyuXR9CRdtk/nI/SSBF593mPPX4JQ=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?OIhp5NddsdGknCOOj8zvbocDko+B4nQwyAM6RtQlu3Zx+c6l4m7udTr/MsFu?=
 =?us-ascii?Q?hUEq3fNrYwyhznl7ljsXbK7nPY3xjzKQeVIiS8SGkO1aZy99MXZRCtzNZWEW?=
 =?us-ascii?Q?k812kEwYVRpsXTWGqXs46O4Ok5SaMRYHegs0Aefpi4NFIyPPSEWZMmYqBIGz?=
 =?us-ascii?Q?UTZejTkf8L4J/REuKVLpdi00Er2yucqwtAAyw3vZnyN47tcSBh2GV975uEvU?=
 =?us-ascii?Q?XPN8GamslyODPfGIl4KH5k8HFW/Zzfa4kO4IpGsHo/+Rwv6tMhHp91decm4g?=
 =?us-ascii?Q?atXF7BYs+8LSEp0lGiUzn7uFTtc7XP4+sfn3hhxVFrGeS1fbjo/IKbwPK3oj?=
 =?us-ascii?Q?yeAsDz5fGfSi7CynenzagozB+GMT5xXAFO38n5udA2OEC5SNvw/JEpYUQoQV?=
 =?us-ascii?Q?zoz5Xd33KpGyGBvrsWq/FYCwK6EmcGH40yGICI9dhunmbhc9u2W1J34EcguE?=
 =?us-ascii?Q?Np9KYzs2wb0SugbVK8+AxdgTUHBTCJ6bn87lQeJymcwulccN9ccUb10P+nmP?=
 =?us-ascii?Q?71c9PDkwhODs02hB+ycZKdhIZASf2MWY/uWouj2vFAZP713vyLQq43yAyXDO?=
 =?us-ascii?Q?i4AQaMvPHwcqWykI8QTWcsw2T//TrPZzyqURtpg6ZuP0eJcoaBQDO9bYafh/?=
 =?us-ascii?Q?lACKdf/wX7BdbP2CD/SAHg2ObDLxBNVf3zGQ52FK0fncdUIU9WiB6krJu773?=
 =?us-ascii?Q?msYr1m7tijg7Rc4hbeoF2zWxDWRWrNHoQcJkCY21Dh6PYcd/Nuoz0n9xwlCb?=
 =?us-ascii?Q?JY94/fcvB2zDCOiMzIb23JymxYbIU6gEm/U9rQItLlY0/29AhvZ8VtAr/5Cb?=
 =?us-ascii?Q?g70eqfaoyA/h++J/IxJI0nmPGiW4qr2UHfS/pvYqzUVyZ0gfVQ+NYPF5ctHc?=
 =?us-ascii?Q?M9ycczDwxg3nyBqtQbptkYaMfCIqep7o3A1vRFipACXOCCbKUKqtz2aXcnm3?=
 =?us-ascii?Q?fzK1tF0yTq1x1JGrLmlm//D+bBk/g0Uyxj9GfmVR4Ec9FMNyhRF2s9gX1j/C?=
 =?us-ascii?Q?qM2oYUzxLawNsY3dJ3InB8NTR4keZTP53JORwMfNC6nfYcAcHW8CiLQnmTRH?=
 =?us-ascii?Q?uTVKcejqU6BIREFOMewSkxN7+qRrStW3rG8jEC4gcdsgN3rxi8C8dUorTYOz?=
 =?us-ascii?Q?JCUwLxL04/yIjR3/YqVdayGUCMWVOnrTlyxZGZKznVvC8OMr1i1/TkIIOVlE?=
 =?us-ascii?Q?nBScNicYImzRdtyFBg0ZxlirMJ5qinOjVLKYPrs3OW7PkfRtdgDDeaXX3qLk?=
 =?us-ascii?Q?fkuCdyGQMdylF/aXWJHFDRSmCqVie64WRJOuF2plQtpOOi+w598iY6jqzAA6?=
 =?us-ascii?Q?t261JeFZwCVaqphNS7EEq+zpesMtmyWy0G5IP3tlMhM5DfIp9krkQU51QScS?=
 =?us-ascii?Q?waghFkw=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 04e81d79-b73d-4da9-14a7-08de62889d30
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2026 18:26:42.5204
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR02MB10518
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[outlook.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[outlook.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8653-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[linux.microsoft.com,gmail.com];
	FREEMAIL_FROM(0.00)[outlook.com];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[outlook.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mhklinux@outlook.com,linux-hyperv@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-hyperv];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,outlook.com:email,outlook.com:dkim]
X-Rspamd-Queue-Id: B18EAD0259
X-Rspamd-Action: no action

From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com> Sent: Monday=
, February 2, 2026 9:18 AM
>=20
> On Mon, Feb 02, 2026 at 08:51:01AM -0800, mhkelley58@gmail.com wrote:
> > From: Michael Kelley <mhklinux@outlook.com>
> >
> > Huge page mappings in the guest physical address space depend on having
> > matching alignment of the userspace address in the parent partition and
> > of the guest physical address. Add a comment that captures this
> > information. See the link to the mailing list thread.
> >
> > No code or functional change.
> >
> > Link: https://lore.kernel.org/linux-hyperv/aUrC94YvscoqBzh3@skinsburski=
i.localdomain/T/#m0871d2cae9b297fd397ddb8459e534981307c7dc
> > Signed-off-by: Michael Kelley <mhklinux@outlook.com>
> > ---
> >  drivers/hv/mshv_root_main.c | 14 ++++++++++++++
> >  1 file changed, 14 insertions(+)
> >
> > diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
> > index 681b58154d5e..bc738ff4508e 100644
> > --- a/drivers/hv/mshv_root_main.c
> > +++ b/drivers/hv/mshv_root_main.c
> > @@ -1389,6 +1389,20 @@ mshv_partition_ioctl_set_memory(struct mshv_part=
ition *partition,
> >  	if (mem.flags & BIT(MSHV_SET_MEM_BIT_UNMAP))
> >  		return mshv_unmap_user_memory(partition, mem);
> >
> > +	/*
> > +	 * If the userspace_addr and the guest physical address (as derived
> > +	 * from the guest_pfn) have the same alignment modulo PMD huge page
> > +	 * size, the MSHV driver can map any PMD huge pages to the guest
> > +	 * physical address space as PMD huge pages. If the alignments do
> > +	 * not match, PMD huge pages must be mapped as single pages in the
> > +	 * guest physical address space. The MSHV driver does not enforce
> > +	 * that the alignments match, and it invokes the hypervisor to set
> > +	 * up correct functional mappings either way. See mshv_chunk_stride()=
.
> > +	 * The caller of the ioctl is responsible for providing userspace_add=
r
> > +	 * and guest_pfn values with matching alignments if it wants the gues=
t
> > +	 * to get the performance benefits of PMD huge page mappings of its
> > +	 * physical address space to real system memory.
> > +	 */
>=20
> Thanks. However, I'd suggest to reduce this commet a lot and put the
> details into the commit message instead. Also, why this place? Why not a
> part of the function description instead, for example?

In general, I'm very much an advocate of putting a bit more detail into cod=
e
comments, so that someone new reading the code has a chance of figuring
out what's going on without having to search through the commit history
and read commit messages. The commit history is certainly useful for the
historical record, and especially how things have changed over time. But fo=
r
"how non-obvious things work now", I like to see that in the code comments.

As for where to put the comment, I'm flexible. I thought about placing it
outside the function as a "header" (which is what I think you mean by the
"function description"), but the function handles both "map" and "unmap"
operations, and this comment applies only to "map".  Hence I put it after
the test for whether we're doing "map" vs. "unmap".  But I wouldn't object
to it being placed as a function description, though the text would need to=
 be
enhanced to more broadly be a function description instead of just a commen=
t
about a specific aspect of "map" behavior.

Michael

>=20
> Thanks,
> Stanislav
>=20
> >  	return mshv_map_user_memory(partition, mem);
> >  }
> >
> > --
> > 2.25.1

