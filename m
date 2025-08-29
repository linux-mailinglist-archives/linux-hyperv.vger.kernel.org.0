Return-Path: <linux-hyperv+bounces-6670-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B19EB3C177
	for <lists+linux-hyperv@lfdr.de>; Fri, 29 Aug 2025 19:03:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9533A60AF4
	for <lists+linux-hyperv@lfdr.de>; Fri, 29 Aug 2025 17:03:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D282A33CEAC;
	Fri, 29 Aug 2025 17:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="hWh4NwP4"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02olkn2035.outbound.protection.outlook.com [40.92.44.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA46633A02D;
	Fri, 29 Aug 2025 17:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.44.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756486998; cv=fail; b=jYaXTrdOMRmzpa7wp8wvb9zkbE05Rb4Qn/+ygI+TxGPuUXKdK+GtC8Yp25HFkXSqoqmSxqxJK7yYzmz6nGRWZiiGF/qGAIvA59JzE9Fc2ySACEuCsm/PJ3Go/FRZfhN/R3KcK5uHV0gSHUc797pvnF5briavvGbNCK5UE1o5SEQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756486998; c=relaxed/simple;
	bh=nInihGDAy1mnqNrQLNv6p5SqbSCS4JOmjShbbaoyJzg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=na6KGTtQZqIsWrxT3sWBBkaMYrNky8jpyAt2ErmhvxJTs/bx8I9Oi9FYlXOL429qTwzDm/pB6QgAzGKDGXyECkmNq1Z/yF8ffzd3XEtKnuV1g3HjYsRNzooVARGXfN/TYJs1WsDrR5csxFTuDuIrcvtByFfKu5KMbEKsGkIqWzo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=hWh4NwP4; arc=fail smtp.client-ip=40.92.44.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SEJ1IDjznGZusWv5dxXCkkDPWFWEoDpzNJsBz9IuRZqXHzPDZFkPUrrP4zAsPewl8mH5KVdwDsF98fR4R9HXbbEDkdIT7Pr4Tq6bNwUr7JFIguuNkTg+fybLY7Vj+268kAizfmV1PjrbGgj9QzraIzbwtOSKOsEEIgO9W6WQNZC24C/Xm8Y+mPudbwFpC/Vrm/tgK8/ErQDphN6wO0zKpmQgxKacN+77zBJGDR/txG4p8KKTdz5zcM3gfskNczx2SYFKSrRx1Cxm6PaxsKMFforeTPDbgBqu4adjDQpxGHqD+sxqgB9oXQciHR8EhVWtZOUsPsZyqI7HGICix/88DQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CQWwrDTMZEljISGFQo9ZMWL2XRKCtWlPhw8XUYgLUrI=;
 b=FtUkp72bUHrWsgam163hKmgA/HsLX2yx+BGZ9E2LIQvr5xPVGQ2fJA+8O7+VpC4ZfvGB5oTn1sEcS3Kouv/toT2M7sQvvHMG27/hUlOHfK/zrwuZ4T2SW9iGaWj5Ziy04V9RA0ssbYMfvY0UsKq5iUomfngUyGP57udMRHcXiLGJxOGXCJILo06K5er7rD71sww9yJkphVH7GwYdTXn+U0CRZ7iC+58v1daHR8fgDx1tUGOcMnnNzo3nD5RPdhudBAFZVkoA4Pr/v6cCVma1rVqWul24oZb648ADt/BtC+8P5G4RAb9+ugDIj6AGgFZJKbYtGHjlFle1gJD/pK3N+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CQWwrDTMZEljISGFQo9ZMWL2XRKCtWlPhw8XUYgLUrI=;
 b=hWh4NwP4FtllGQ9Kxg3C2Ft6NhzI9h/ILQg4tkxtHc4K/8Q8IzqUaFGKtwjdnF0RJBvor+6rs9C5jw2kDzg1rPsrmIhJf+0XbSi87g/3+1GV//QLVEDFUl+vjSSVfT8WoqzVGSA0LO128BDSrJBf8aNPecb2mpgsdBVRYDOfcW5cr/igvV2XhWQJmGtJzmuI5Yu52sUWCdhcsM161yCb1VreXcq3TnOwSGHVAn+GFecI6gNTQVc5nktLMBwDJ4dJuMKgS7fw83kKjHRX4UkDyfFowFCKtK8V+xn3QawT+GDnwdmnkm/1tbQdrITgGdTnVoJ+DbI9fGKdpbA5gWm9qQ==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by PH7PR02MB9340.namprd02.prod.outlook.com (2603:10b6:510:271::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.20; Fri, 29 Aug
 2025 17:03:14 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%4]) with mapi id 15.20.9052.019; Fri, 29 Aug 2025
 17:03:13 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Vitaly Kuznetsov <vkuznets@redhat.com>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>
CC: "K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang
	<haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan Cui
	<decui@microsoft.com>, "x86@kernel.org" <x86@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Nuno Das Neves
	<nunodasneves@linux.microsoft.com>, Tianyu Lan <tiala@microsoft.com>, Li Tian
	<litian@redhat.com>, Philipp Rudo <prudo@redhat.com>
Subject: RE: [PATCH v4] x86/hyperv: Fix kdump on Azure CVMs
Thread-Topic: [PATCH v4] x86/hyperv: Fix kdump on Azure CVMs
Thread-Index: AQHcF/xzlhqdNasNOEyOxxs2ytrFh7R527zQ
Date: Fri, 29 Aug 2025 17:03:13 +0000
Message-ID:
 <SN6PR02MB41571C1A6DE8756D72176E93D43AA@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20250828091618.884950-1-vkuznets@redhat.com>
In-Reply-To: <20250828091618.884950-1-vkuznets@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|PH7PR02MB9340:EE_
x-ms-office365-filtering-correlation-id: 1fa30efb-09b2-44ea-fce5-08dde71df07c
x-ms-exchange-slblob-mailprops:
 AZnQBsB9XmriMkceEMr8g4u6bPtbH41WpEt/WKUej2kzY3Hbp/K83VMAQyIfomNZ/ZA7I7dAtGdDgBlDg8rhGjQzUMIGL105qIUEtP/dfOlk6f8fgimSHfb6J+Zos4axRaM7Yu7E978o/kYPWGURMbJGo1e3UIfSE0/zkw9Tu2ceaFfHRCkwfrZ4HtaZG1cQF+UzM1PWBi0CnaHueZpzi0ib4gLfKwD5eCkO+Lfkz7+WMU8o1P0XxFM2WMk/T53N2pbBD1Gf9H7KS+C+EifcF1Jovf1D4l7W3VDPxh9j33T2uDtjV94hDJGy0aK752QY3o7KSJN4HmJ/OwAAgsxi1mZVdFXBcQkvbD+fazAemdxIi04qRt8cuY77Yd0Ijq24W3YDHQliftt7RrcI5SEbCY6mJKsvQGdCc5G+sw3dd+SbdV46TzxQrM9iisUpQFn23bd1w5fWowVAP0k1v32h3H0XAYo/FFHgAFfjRM37oYGg8Af9fJ1QkId3Ue60WQ4xrlhX8bAx+U2Hm4fI8j2ZNzY7eJosp+gZANFg1jl7WyjoEGLuF40zcsBQD56dqYT4sAMegm6PuOCN66u6RTS6PFMEjiLHkJSrpVo32yfI7o+3ch7+frLTsLiTni2FsnUgHQe79Xvhg1YW98b84QRz/EWWmFa1J/zOvl3g6oiVDviX25hqfTYZnuya55CuTvhcVki2vOQ/B5yzcGPkhAsRp3kgkUaI1qsQWJmTbBYhwz8AWOwzVJN/ExUmt6zTIDuEAkXD86s93JI=
x-microsoft-antispam:
 BCL:0;ARA:14566002|8062599012|13091999003|41001999006|8060799015|19110799012|31061999003|461199028|15080799012|40105399003|3412199025|440099028|12091999003|102099032;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?ruRrEhP7v8dV5PrA18QLRH+fW9TtXVCZizL6v7ETBp4qnJcoTAYSctP9ugp9?=
 =?us-ascii?Q?+KxYS5ngE4/klb7YmyKcDKFlGN932HTTOvT5BVrBrwwtC9swP8yR21WDGs9w?=
 =?us-ascii?Q?vujGjzpRrz+w47yC3d4zK5ac8Uy4AnjW2pehsPNw/W1ajegq2FL8iknrfN4p?=
 =?us-ascii?Q?5kqw6nluICV0Udv3lmkAfBODG88C1SnBbiwznkksaJ1LAn4aLfHVoYyKH/cF?=
 =?us-ascii?Q?bZ9TaDSFkAF9nShEEYujOINH/XAlIw43JmhMZDotzU9WH2OGlzx7QwyuYIqb?=
 =?us-ascii?Q?9WvxP0orN9dWDZ0JntB1wqj/rehxVlKS9Uht06pDLtx+awELEbQvCtc3KtzI?=
 =?us-ascii?Q?TkmafErORaeKxkvKAzLEJsYBtOVygOXLrkochqC9szOONmVJQUY41Yr4odXG?=
 =?us-ascii?Q?L8m6UTV0jhjKBoInryMQZ5fyj0akEDTwKs7dlEXsXEXNP7z4YlW/UsC5Kmv2?=
 =?us-ascii?Q?af2866r2Riud8/XJhGjiBM91wBo2SZFW32J3un9sNppp0KvlSljToRW2LS5g?=
 =?us-ascii?Q?6GbLqxgfji0qRhVeihJ43E6aP1/lbDaFIBcbIyDGj28PdmKbIOXb8I/56RN0?=
 =?us-ascii?Q?HII2/Km7oDNVuCT50dtj6MHr7lohhMwgr6L5goh09V53WKnhIkFipL8jBeeu?=
 =?us-ascii?Q?UnFqVI+DjWvN41U3cMURZSI/vbIFfoODfjsHYIfLadHk7XITENGE5biOZUFI?=
 =?us-ascii?Q?ZwBfexM0n0MA93VuvF+lUps3/qWitSPixBUjWQiOJrii2J/h/+uag03jZP2d?=
 =?us-ascii?Q?rAaZHI3X3piIE3nWOYt5D22TE/3Gjm9/8KpXtEiunDo2AWWJJqHCPuQeOlIn?=
 =?us-ascii?Q?AHL6EkD28vs1fg8/POtWTrErHaX/tNIJN/MjQu8ZPrjE0BGJvQfsg/EjdULU?=
 =?us-ascii?Q?GKi9Q3S23RVZkK5s3SHr7XYjQCFaX8sisEwHUR4Eiba7v/R+WmCDK1xp1JVy?=
 =?us-ascii?Q?2LnlXgmdqgQwtm0mOCoPndOwirv0csDLQpd7ITBwFYtDhrdeUYii3jQaDX3Q?=
 =?us-ascii?Q?1p9iTR51Xbd1JjYpaYqDwHyMbp6imBZTXb5xQehO3siMotSlyAuSrLopEmrO?=
 =?us-ascii?Q?pekg7oLZgqZRIEtpYkKptJ8Wm86Df2rXkU83v21hHLBSavCkSh9chjvHS9VJ?=
 =?us-ascii?Q?zilheG9zAQQQKDApduv5av9M/h7osOxHUSEKm9PpGVKiLFU3RHQ3C50o4kJt?=
 =?us-ascii?Q?HOFxypbu/Kj5tVgw1DTFJBvsBudfxwdXx40m6VRYyh5p8NhfcsklxdPfJGsx?=
 =?us-ascii?Q?RflqpyXYQJRhX97wbdem?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?f4BrLWY9bEMfyany9RvbjXDcTvCUlyRdHJRXKJv2nXEvhiioCDNQO+FsKm9U?=
 =?us-ascii?Q?9BuzQi+/QHkMxEP4mbDe7ByRkzVypcphYbqby5+03wjxawAIiXOaImPRJE+h?=
 =?us-ascii?Q?o5eiha3aHjeFXCGz0nohqQqDG3+oq8qbGubUiCfWW0pgxGD0DR0cvOoEleT9?=
 =?us-ascii?Q?MHwuJqgSaeiXGB18ZvwQH9YCvsBYxfFa7FYfstzr79gMyFxFxHm58quski6c?=
 =?us-ascii?Q?Z5KW4VIR2RLpUB8sqqUet/qCDeARl4DAWYEXgSoXsem5YaXObAZGjDPODNhS?=
 =?us-ascii?Q?tX4k13QAuan2/O1uoAZ1V1qdaUjhDBV7nug721XGkF1K76EnjP2+pDI5MT1J?=
 =?us-ascii?Q?j8tZESET+xv/ZBxpHLMLsAP03PDvFf/bAqAThR7Iws//rPnNAl7dgsUpvZBc?=
 =?us-ascii?Q?lWn3morsFfDNAFIIiufJnoJdiT4srKqtgH9j+W3jvw8b/J2KBwubzUAL/Mob?=
 =?us-ascii?Q?/+GdglZSOJ6OMU3i3hkLmuYTqCGooWXBeD1NziyQrIvsSmZbz9tiKXloh0up?=
 =?us-ascii?Q?nA+HT8OiGqls0NZX1qLbRS8eRCTesS0NEfKZFwzup/iwEZWGQc3utzSOLb9S?=
 =?us-ascii?Q?yI73wU8gLr0Qc+wCCD8TVpTqERT16d0K24KBm5QlOzxU3pKwaBVvWsKXkFIO?=
 =?us-ascii?Q?wvIwfnPI9Pg64qAZoIHqTBIzbofmQFp6bfQZxyxrQaxURS1/yw5xRlvRHCPL?=
 =?us-ascii?Q?DvBQHRHA6J9QaeoyiYvJci1V5H6dKLYRRJERVUDbO6pm2xAhLAtryuQfiQIb?=
 =?us-ascii?Q?02K2mq262Yp4g191zZ3TJOADvS1k14lGgtaQL/8fvvoKUX/lU4Ajp4DFKEEP?=
 =?us-ascii?Q?eVJbb6EMtDeOyZ6Gvj/Qx2Zxy7n2D2cTTVIrsGaxl3GiIzxSkFIXGh0KhPIm?=
 =?us-ascii?Q?FveBTJtA7oYZp44LI6Xp+rxIFCk7cARTmyDfMRtul2pIwXJLZKRdJsZfbJvt?=
 =?us-ascii?Q?MOPnPuKRAkuRuzJW++V1SQ/wJHn4hIg8EYDIFcjxuEQNtHSY+oECr+Ls2ucD?=
 =?us-ascii?Q?bFV2URssGhGfIdC2n2npGG/GhZoPv30qDjvs9xtxC4kTT13Rr6n0ycc/HXfs?=
 =?us-ascii?Q?Ls7x6DRTPSmiVvU2JWCYjR31MThpmfeswerhrtPJ9Vhk8u+g8ffILHqJuvYm?=
 =?us-ascii?Q?/vKiSoR7GWMppUhZOggsSvXeKzLatZ9D8Aosy5IdCUmDzUhFtHOVQt0D4vl5?=
 =?us-ascii?Q?RueFEao0ETejEoI5W77FVTUfvWgLMX3tmaZBGDkeTa5nlO5s+Ce2lcwFtsQ?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fa30efb-09b2-44ea-fce5-08dde71df07c
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Aug 2025 17:03:13.0968
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR02MB9340

From: Vitaly Kuznetsov <vkuznets@redhat.com> Sent: Thursday, August 28, 202=
5 2:16 AM
>=20
> Azure CVM instance types featuring a paravisor hang upon kdump. The
> investigation shows that makedumpfile causes a hang when it steps on a pa=
ge
> which was previously share with the host
> (HVCALL_MODIFY_SPARSE_GPA_PAGE_HOST_VISIBILITY). The new kernel has no
> knowledge of these 'special' regions (which are Vmbus connection pages,
> GPADL buffers, ...). There are several ways to approach the issue:
> - Convey the knowledge about these regions to the new kernel somehow.
> - Unshare these regions before accessing in the new kernel (it is unclear
> if there's a way to query the status for a given GPA range).
> - Unshare these regions before jumping to the new kernel (which this patc=
h
> implements).
>=20
> To make the procedure as robust as possible, store PFN ranges of shared
> regions in a linked list instead of storing GVAs and re-using
> hv_vtom_set_host_visibility(). This also allows to avoid memory allocatio=
n
> on the kdump/kexec path.
>=20
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>

Looks good!

Adding Confidential Computing mailing list (linux-coco@lists.linux.dev)
for visibility.

Reviewed-by: Michael Kelley <mhklinux@outlook.com>

> ---
> Changes since v3 [Michael Kelley]:
>  - Employ x86_platform.guest.enc_kexec_{begin,finish} hooks.
>  - Don't use spinlock in what's now hv_vtom_kexec_finish().
>  - Handle possible hypercall failures in hv_mark_gpa_visibility()
>    symmetrically; change hv_list_enc_remove() to return -ENOMEM as well.
>  - Rebase to the latest hyperv/next.
> ---
>  arch/x86/hyperv/ivm.c | 211 +++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 210 insertions(+), 1 deletion(-)
>=20
> diff --git a/arch/x86/hyperv/ivm.c b/arch/x86/hyperv/ivm.c
> index ade6c665c97e..a4615b889f3e 100644
> --- a/arch/x86/hyperv/ivm.c
> +++ b/arch/x86/hyperv/ivm.c
> @@ -462,6 +462,195 @@ void hv_ivm_msr_read(u64 msr, u64 *value)
>  		hv_ghcb_msr_read(msr, value);
>  }
>=20
> +/*
> + * Keep track of the PFN regions which were shared with the host. The ac=
cess
> + * must be revoked upon kexec/kdump (see hv_ivm_clear_host_access()).
> + */
> +struct hv_enc_pfn_region {
> +	struct list_head list;
> +	u64 pfn;
> +	int count;
> +};
> +
> +static LIST_HEAD(hv_list_enc);
> +static DEFINE_RAW_SPINLOCK(hv_list_enc_lock);
> +
> +static int hv_list_enc_add(const u64 *pfn_list, int count)
> +{
> +	struct hv_enc_pfn_region *ent;
> +	unsigned long flags;
> +	u64 pfn;
> +	int i;
> +
> +	for (i =3D 0; i < count; i++) {
> +		pfn =3D pfn_list[i];
> +
> +		raw_spin_lock_irqsave(&hv_list_enc_lock, flags);
> +		/* Check if the PFN already exists in some region first */
> +		list_for_each_entry(ent, &hv_list_enc, list) {
> +			if ((ent->pfn <=3D pfn) && (ent->pfn + ent->count - 1 >=3D pfn))
> +				/* Nothing to do - pfn is already in the list */
> +				goto unlock_done;
> +		}
> +
> +		/*
> +		 * Check if the PFN is adjacent to an existing region. Growing
> +		 * a region can make it adjacent to another one but merging is
> +		 * not (yet) implemented for simplicity. A PFN cannot be added
> +		 * to two regions to keep the logic in hv_list_enc_remove()
> +		 * correct.
> +		 */
> +		list_for_each_entry(ent, &hv_list_enc, list) {
> +			if (ent->pfn + ent->count =3D=3D pfn) {
> +				/* Grow existing region up */
> +				ent->count++;
> +				goto unlock_done;
> +			} else if (pfn + 1 =3D=3D ent->pfn) {
> +				/* Grow existing region down */
> +				ent->pfn--;
> +				ent->count++;
> +				goto unlock_done;
> +			}
> +		}
> +		raw_spin_unlock_irqrestore(&hv_list_enc_lock, flags);
> +
> +		/* No adjacent region found -- create a new one */
> +		ent =3D kzalloc(sizeof(struct hv_enc_pfn_region), GFP_KERNEL);
> +		if (!ent)
> +			return -ENOMEM;
> +
> +		ent->pfn =3D pfn;
> +		ent->count =3D 1;
> +
> +		raw_spin_lock_irqsave(&hv_list_enc_lock, flags);
> +		list_add(&ent->list, &hv_list_enc);
> +
> +unlock_done:
> +		raw_spin_unlock_irqrestore(&hv_list_enc_lock, flags);
> +	}
> +
> +	return 0;
> +}
> +
> +static int hv_list_enc_remove(const u64 *pfn_list, int count)
> +{
> +	struct hv_enc_pfn_region *ent, *t;
> +	struct hv_enc_pfn_region new_region;
> +	unsigned long flags;
> +	u64 pfn;
> +	int i;
> +
> +	for (i =3D 0; i < count; i++) {
> +		pfn =3D pfn_list[i];
> +
> +		raw_spin_lock_irqsave(&hv_list_enc_lock, flags);
> +		list_for_each_entry_safe(ent, t, &hv_list_enc, list) {
> +			if (pfn =3D=3D ent->pfn + ent->count - 1) {
> +				/* Removing tail pfn */
> +				ent->count--;
> +				if (!ent->count) {
> +					list_del(&ent->list);
> +					kfree(ent);
> +				}
> +				goto unlock_done;
> +			} else if (pfn =3D=3D ent->pfn) {
> +				/* Removing head pfn */
> +				ent->count--;
> +				ent->pfn++;
> +				if (!ent->count) {
> +					list_del(&ent->list);
> +					kfree(ent);
> +				}
> +				goto unlock_done;
> +			} else if (pfn > ent->pfn && pfn < ent->pfn + ent->count - 1) {
> +				/*
> +				 * Removing a pfn in the middle. Cut off the tail
> +				 * of the existing region and create a template for
> +				 * the new one.
> +				 */
> +				new_region.pfn =3D pfn + 1;
> +				new_region.count =3D ent->count - (pfn - ent->pfn + 1);
> +				ent->count =3D pfn - ent->pfn;
> +				goto unlock_split;
> +			}
> +
> +		}
> +unlock_done:
> +		raw_spin_unlock_irqrestore(&hv_list_enc_lock, flags);
> +		continue;
> +
> +unlock_split:
> +		raw_spin_unlock_irqrestore(&hv_list_enc_lock, flags);
> +
> +		ent =3D kzalloc(sizeof(struct hv_enc_pfn_region), GFP_KERNEL);
> +		if (!ent)
> +			return -ENOMEM;
> +
> +		ent->pfn =3D new_region.pfn;
> +		ent->count =3D new_region.count;
> +
> +		raw_spin_lock_irqsave(&hv_list_enc_lock, flags);
> +		list_add(&ent->list, &hv_list_enc);
> +		raw_spin_unlock_irqrestore(&hv_list_enc_lock, flags);
> +	}
> +
> +	return 0;
> +}
> +
> +/* Stop new private<->shared conversions */
> +static void hv_vtom_kexec_begin(void)
> +{
> +	if (!IS_ENABLED(CONFIG_KEXEC_CORE))
> +		return;
> +
> +	/*
> +	 * Crash kernel reaches here with interrupts disabled: can't wait for
> +	 * conversions to finish.
> +	 *
> +	 * If race happened, just report and proceed.
> +	 */
> +	if (!set_memory_enc_stop_conversion())
> +		pr_warn("Failed to stop shared<->private conversions\n");
> +}
> +
> +static void hv_vtom_kexec_finish(void)
> +{
> +	struct hv_gpa_range_for_visibility *input;
> +	struct hv_enc_pfn_region *ent;
> +	unsigned long flags;
> +	u64 hv_status;
> +	int cur, i;
> +
> +	local_irq_save(flags);
> +	input =3D *this_cpu_ptr(hyperv_pcpu_input_arg);
> +
> +	if (unlikely(!input))
> +		goto out;
> +
> +	list_for_each_entry(ent, &hv_list_enc, list) {
> +		for (i =3D 0, cur =3D 0; i < ent->count; i++) {
> +			input->gpa_page_list[cur] =3D ent->pfn + i;
> +			cur++;
> +
> +			if (cur =3D=3D HV_MAX_MODIFY_GPA_REP_COUNT || i =3D=3D ent->count - 1=
) {
> +				input->partition_id =3D HV_PARTITION_ID_SELF;
> +				input->host_visibility =3D VMBUS_PAGE_NOT_VISIBLE;
> +				input->reserved0 =3D 0;
> +				input->reserved1 =3D 0;
> +				hv_status =3D hv_do_rep_hypercall(
> +					HVCALL_MODIFY_SPARSE_GPA_PAGE_HOST_VISIBILITY,
> +					cur, 0, input, NULL);
> +				WARN_ON_ONCE(!hv_result_success(hv_status));
> +				cur =3D 0;
> +			}
> +		}
> +
> +	}
> +
> +out:
> +	local_irq_restore(flags);
> +}
> +
>  /*
>   * hv_mark_gpa_visibility - Set pages visible to host via hvcall.
>   *
> @@ -475,6 +664,7 @@ static int hv_mark_gpa_visibility(u16 count, const u6=
4 pfn[],
>  	struct hv_gpa_range_for_visibility *input;
>  	u64 hv_status;
>  	unsigned long flags;
> +	int ret;
>=20
>  	/* no-op if partition isolation is not enabled */
>  	if (!hv_is_isolation_supported())
> @@ -486,6 +676,13 @@ static int hv_mark_gpa_visibility(u16 count, const u=
64 pfn[],
>  		return -EINVAL;
>  	}
>=20
> +	if (visibility =3D=3D VMBUS_PAGE_NOT_VISIBLE)
> +		ret =3D hv_list_enc_remove(pfn, count);
> +	else
> +		ret =3D hv_list_enc_add(pfn, count);
> +	if (ret)
> +		return ret;
> +
>  	local_irq_save(flags);
>  	input =3D *this_cpu_ptr(hyperv_pcpu_input_arg);
>=20
> @@ -506,8 +703,18 @@ static int hv_mark_gpa_visibility(u16 count, const u=
64 pfn[],
>=20
>  	if (hv_result_success(hv_status))
>  		return 0;
> +
> +	if (visibility =3D=3D VMBUS_PAGE_NOT_VISIBLE)
> +		ret =3D hv_list_enc_add(pfn, count);
>  	else
> -		return -EFAULT;
> +		ret =3D hv_list_enc_remove(pfn, count);
> +	/*
> +	 * There's no good way to recover from -ENOMEM here, the accounting is
> +	 * wrong either way.
> +	 */
> +	WARN_ON_ONCE(ret);
> +
> +	return -EFAULT;
>  }
>=20
>  /*
> @@ -669,6 +876,8 @@ void __init hv_vtom_init(void)
>  	x86_platform.guest.enc_tlb_flush_required =3D hv_vtom_tlb_flush_require=
d;
>  	x86_platform.guest.enc_status_change_prepare =3D hv_vtom_clear_present;
>  	x86_platform.guest.enc_status_change_finish =3D hv_vtom_set_host_visibi=
lity;
> +	x86_platform.guest.enc_kexec_begin =3D hv_vtom_kexec_begin;
> +	x86_platform.guest.enc_kexec_finish =3D hv_vtom_kexec_finish;
>=20
>  	/* Set WB as the default cache mode. */
>  	guest_force_mtrr_state(NULL, 0, MTRR_TYPE_WRBACK);
> --
> 2.50.1


