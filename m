Return-Path: <linux-hyperv+bounces-8060-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id F0A98CD6E3D
	for <lists+linux-hyperv@lfdr.de>; Mon, 22 Dec 2025 19:25:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9BEA830036CD
	for <lists+linux-hyperv@lfdr.de>; Mon, 22 Dec 2025 18:25:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83CC63090CD;
	Mon, 22 Dec 2025 18:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="t4IaFfHW"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazolkn19012017.outbound.protection.outlook.com [52.103.11.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9016450276;
	Mon, 22 Dec 2025 18:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.11.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766427911; cv=fail; b=PEJZ2I2KRxmBlNTeouYwWAq5aUWBs0JxL1iQ1v6u+gCT+C1SAcrMlgztiYS2nN8lSZjt5hGxM2jQdeQ7hrLH/B9OSt/ILtnExFVtuJKxluLFXCyiyfGO7kKfjFip6FBR9xqaiPJh5tZA70sBNhJuTekZBKRADGa2LKjJkt5pOOE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766427911; c=relaxed/simple;
	bh=IdQEEvp6FJFI5o5QGJ5ZUATGUUF6koJId6cnj+3dz9o=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GSMaueem1iItHlDgCByMsdFH1vg5I5aEi+4Pypt+rzNZzrsq5dyzaydg/oteM+VjpdW3ZDi9iwyjYcaBAS4OE/gDf0g8becTvYFQcLvXdvpU8qMISW2RIQWwpuANCdb6NpH1MQYpH1pTbpQxZVr+4QAUzjku2+1wzYbule33MZs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=t4IaFfHW; arc=fail smtp.client-ip=52.103.11.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=apNIUYJXxQCxNMD6tFwnEkEZw+tKBbuL2jWUPuUGJbEzhTwlhdC63/Hh0Pcc7N/GXFmH6hzgbP8PfAVBLvSFlIYbH16/21Jbks4oJ/ja4nzBSyPWxI0k9ohJU3s6k6NUx8Ue4KtBEQL1LwyueLDuXj+/kAS03maDe8qMgTXzKhlKAavRdJ4JllYrOBWlNqH6LlFB4qbdS2sJmxRDPnH15aJIHjubG7ZJCQ7rxrRdMz1g04uzUUwr4b+2uZ3XXdnRfFQb6BrkggaaH+M9ae+2uYepExJPkncXuik56f3VGhZWIgOdengC+EVQvJjFnIm9sAUsq6rA5hCSEd6v8gCoYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ukPgIV8CE707kHwFy23b2ebNpJPorI78U11et8MhJNg=;
 b=Jm79kMXgjK5rn8WvdurZiF7qpB3I6xl01VD9OfjrWxLiNXNa40KFyyhzyu+kDS4vlFVSQSS082Z9mdsAvqWbAzncLltEI5CAa/QodI1ExP+Nzjp2qkyuU3OlFwjpoYNRH8DksvtA0114gkSyyYL9dV6PgeeKyIT0DQDvTbO+Q9Bnsf6M5Mndpm8J6zh6ww61LmWXejv5rmSrHJK3fndrjVuLPFPMg7j+lpoV3MpVljxkRiSjHGlgKwqPYahRLCCfJgNOOB+gjp651aMpdYlNjSko6qVPkg7NfhirmOENz40uLyiFDCrsK/on+JXOaVtA32Xn2xLhT/wa2gliLrIgJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ukPgIV8CE707kHwFy23b2ebNpJPorI78U11et8MhJNg=;
 b=t4IaFfHWZi+2jEg36Y10+iGmR4FtanqhuA+PM6tfPDjb1bK90ePG7lNvAGOZVJK1K3QL4/KJAbsdjizneGzY2P8YopK6X1pSicuYkAQGzyR/K67kRHUm8eu1ehabHGhS5feLAjeT2BhOzoVF8+Fd0gPZuMncls9eQC00myPSUl4JS/uaX+N9OyNY5cJDPmUXzGGslRLuxOlfZetTP3W8czuFTu5rS95Ia55peI+Hg7NIM6Hvaa/915dukLuPpnUwbPu5qi0igcItmh3JNd3nvzjsJYrUuV5KBiB1t6xDhH8yOyyeRauQSfmGWc9gFieOW/rfHNAv3V/SA/szz30mZQ==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by DM6PR02MB7017.namprd02.prod.outlook.com (2603:10b6:5:251::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.10; Mon, 22 Dec
 2025 18:25:05 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6%3]) with mapi id 15.20.9434.009; Mon, 22 Dec 2025
 18:25:02 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
CC: "kys@microsoft.com" <kys@microsoft.com>, "haiyangz@microsoft.com"
	<haiyangz@microsoft.com>, "wei.liu@kernel.org" <wei.liu@kernel.org>,
	"decui@microsoft.com" <decui@microsoft.com>, "longli@microsoft.com"
	<longli@microsoft.com>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] mshv: Align huge page stride with guest mapping
Thread-Topic: [PATCH] mshv: Align huge page stride with guest mapping
Thread-Index: AQHcbu3m/1KRrXDdWE2Bee61xybnKLUnwn/AgAHUSgCAAZKpIA==
Date: Mon, 22 Dec 2025 18:25:02 +0000
Message-ID:
 <SN6PR02MB41578A17A4DADD9276392298D4B4A@SN6PR02MB4157.namprd02.prod.outlook.com>
References:
 <176593206931.276257.13023250440372517478.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
 <SN6PR02MB4157D69A4C08B0A4FE01F9FED4A8A@SN6PR02MB4157.namprd02.prod.outlook.com>
 <aUXXdjMyZ5swiCI2@skinsburskii.localdomain>
In-Reply-To: <aUXXdjMyZ5swiCI2@skinsburskii.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|DM6PR02MB7017:EE_
x-ms-office365-filtering-correlation-id: 9a86aab3-5b86-4568-c148-08de41876c6d
x-microsoft-antispam:
 BCL:0;ARA:14566002|461199028|13091999003|8060799015|8062599012|19110799012|41001999006|15080799012|12121999013|51005399006|31061999003|1602099012|40105399003|4302099013|440099028|10035399007|3412199025|102099032;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?qvezWNn6atMB6tfdQx3VYL0XM/ocQDyYqS7U6osS4K82Bxm0WJ0H5CEg4bEq?=
 =?us-ascii?Q?Lw6d/1GIWqBtEQHMw4xrZcTWeMJxHotUDfwW5HfHqs3XXbiqDSgTv8R/oN6M?=
 =?us-ascii?Q?DORL9CuX08HKB+IT7UAGWlHY9HUhHu6CJtuQK6mmYgznZnb0d5NJUU0N4hdL?=
 =?us-ascii?Q?WYWuD4DB1aKpsJsecX8K7U8mqoTfmlq8MR0MPEKuHEfWKc3YhZ89g5LUhK0O?=
 =?us-ascii?Q?TsCwB14U9ThNSOKtsfgrb7PmqbbPSs2wA+622hYqYR/RlsRbJTCJ8WhF9zil?=
 =?us-ascii?Q?0U+1CLCHTQrcXEmsfu3w8YvL3hSXUmj9BFcKGLuKAEpX3IZBQ2iAMxyRyZWb?=
 =?us-ascii?Q?0rDLW+kRQwc/8fkMUHCaBxr3MFGSNU0M+Wif8sI8LxNX/FryrsvY11zLmdij?=
 =?us-ascii?Q?ltoGfeeknFJcvS6Ni6C0cwFl5memNFisWzQW/cbzjeOKUcv52dFAk7T1aQZX?=
 =?us-ascii?Q?2LQag7QigfkG+ajHp9PiuW1QyJ5n5A7a59tw0hun/6NhLxMzX4d+wtP2Crnl?=
 =?us-ascii?Q?2SsUeEBgydEA3Pf7fu1XkoL5jxJJBX3GTvjlQHXQVahwjQBLMRmCQaeUIIB7?=
 =?us-ascii?Q?1EkU09uZ/9hKH40Je7hkoV8BM1h1/VySkBCwASyXdqoB0uSG/FT6SShKGwlN?=
 =?us-ascii?Q?M5lafXNb5g4Ptg/etbxDXdSuwPYxSBxQ/zLWlC7D8/PJm/rBYUCcdbWWCucE?=
 =?us-ascii?Q?clBRCv809MJKEaSYidULi7LCU2pFw4SD8HdNOpUWCPdUS8T5F5hYVAuaMtJ9?=
 =?us-ascii?Q?4jztPSeYAr30CJMrLNVJcva+eaO3eBhcpYRBZ0+KDBsIlIAhd99+8KFgYWbv?=
 =?us-ascii?Q?e6r9ArRU0/DbzR/1oomvvTwYmxpT0VvJvyW2PbKQDVoNTaiLn7p9I2LuVAIB?=
 =?us-ascii?Q?s6cK9FaRntsuJ4GhKdBQE4lU+pBj/OFflsVJ1Roh/4njorHPzV2iqkN6Y1WA?=
 =?us-ascii?Q?m9YYeLmzLJRCR2zrV+XYxDY1p3C1kP4ajXH+pu9J2H2RbyG5/fvU7yDfGlZF?=
 =?us-ascii?Q?ArtOf26rdiWGkLdo5956TbzcQFuycqtHTzqvxjvuR5KNLto5QN2HFc5qAK01?=
 =?us-ascii?Q?HEvcDj8QHd+KVAGgljO5HKXH4Muhet1wli+Bf4TVHTzhYXQLahxsnEDvBePL?=
 =?us-ascii?Q?pM2GwzsXodZfdJQBGLEYtbvP47SaKnaLJpCRnusNQA60EbLQUc11XTsjqxkn?=
 =?us-ascii?Q?o9G03dD16l4Y+1MyuNSeE2F/vHhUk0g16bD0nKZA526z2QBdGpPTKWHjoISU?=
 =?us-ascii?Q?3QL8OfCPn8eANHrtxCwyOzwMUxVzX/LH+iQxXwmllBBHuXJ50ei0Jzz1UMOw?=
 =?us-ascii?Q?qAhFGWhKVjBQzxMejGe6THgYE+lhiLZGTIBgPuh5yi8+nZfLfrjCW5lK8TpN?=
 =?us-ascii?Q?J017+cpgnpRiv2X1R6IAmZB566X4xvBoUM1jnugLlcZGU8t+6g=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?qpEvat4M48Gf8rpxGq+urhhITkLehXrtEqv+fDP/vNRPMhtKtvc+0RLVf9al?=
 =?us-ascii?Q?vnu1bF9tyo+6WR+YA6D6LSsmlf5+vEcjq+k02CsdkCcSgVgTQYuc2Vt9ndwH?=
 =?us-ascii?Q?aoZFENFWOjKa6OSWjkkPeo4BRbtMhmva+UpLumyU+xmonvcUhJD7deKiMXQ4?=
 =?us-ascii?Q?IYeN3osKbG9zrIAiLZTRlgbVIBJjSoug7qpH1G4pHLjD9nrS/9R1P4LcXJ/B?=
 =?us-ascii?Q?6nu9lH7M7b4qD5xcQzUHTy1/gKf58TTWhEAta7/dlYEJCk23wsoPJScGREPr?=
 =?us-ascii?Q?2oCkXjT5yUbJC7HQ1XFgoEzUfo59ZeyOBD/hPw32iA/wnHB0E89K+9ubGlu6?=
 =?us-ascii?Q?BSYQxME8e+2bpjXYbj4Ggd60PzaLAtRAMZX1VG34vBXwULPPb45NeM6G4YMq?=
 =?us-ascii?Q?hWi39hpwHN8zhV0dyuT8uvzyimPCH/2FYgv7zONcG2m4YaKPTcPpXGYBcQrW?=
 =?us-ascii?Q?/JiXkVL0EYz1ZIvt3eWLWl9Cok87F/7ra2IDEUHDpGEBpQHGLLJupNwc5zp6?=
 =?us-ascii?Q?0wo9XdsrOLF4Hq5K8nKh0A8S+EKLEtXHTtm2QmjSm2bSnoDjMnBLq6gJluGn?=
 =?us-ascii?Q?1nLsRL8NfQrQmuNWmaRsIkAIlkQhA7+CcxukTXu1os4mBMT3TDm1zQ5RbV8o?=
 =?us-ascii?Q?coQg4XoD7Hjo51KRyQogUndE41JLXD/RH+rjeG6SSFmI7GI57l31oTSnT01z?=
 =?us-ascii?Q?fELZzVTr3to0gqc7ozAGXpIJ/deX3wwiPTJpnDNLU9Hrg1A8wcYxhIRW7itN?=
 =?us-ascii?Q?Qdv4c9MRdYdddLduBzzs5yJALIXWh5V5f/FoWzfFfsKAkPiDxlaPMWMRDyri?=
 =?us-ascii?Q?3OgmXNw1MqepE5TnsvPftm4uurxO5QXMYyJFJaH6eNv2D6kn4DoZSa6wyaYT?=
 =?us-ascii?Q?YSw18NhSD8Us7/MaU0K4ANqq6yIY/YdFk4CjFZczY6dZKqnvm+Me0CCZ3t9Y?=
 =?us-ascii?Q?dGsVA5KR0G2ev+OWLCf6RHhg74lpsCb+1iJOGxuTptCCquVnIXcWXD04Pv5m?=
 =?us-ascii?Q?hqZisF4Q7aOd/cYWyxIWFbqIFQk/o+qR0jU/Vtu+QRyvZzKlxdjYw3Yj2u4B?=
 =?us-ascii?Q?Z1/j5XgBWkI9qiPUDpRlJPZGIar/nuG2FQdA++S35BEk5x6aah+LQ3cEwTnO?=
 =?us-ascii?Q?+Wx1eggQGHFidNcuq40lr13t+6hSbYfFaSwsZBUxuBsRGTcZ8ne9M/yyIVzm?=
 =?us-ascii?Q?RDQoG82BlNCqy86S+7cmudmKlSR6diuLrU7KqFDhhnPiUQ9rNKwKNadlIpdF?=
 =?us-ascii?Q?KDvmlT3NuNtQf5B89/FMCgqDd9k+zRjEWju+lOd7wOXIgbTXXpl7UHnQ4IZU?=
 =?us-ascii?Q?fktpbdU8TPk+2Mn1vpFU37yKoqFE3ByIQMJ0V1kuKFkR+/Ot2Yh1cVkcoEDp?=
 =?us-ascii?Q?mQQIP20=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a86aab3-5b86-4568-c148-08de41876c6d
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Dec 2025 18:25:02.8528
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB7017

From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com> Sent: Friday=
, December 19, 2025 2:54 PM
>=20
> On Thu, Dec 18, 2025 at 07:41:24PM +0000, Michael Kelley wrote:
> > From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com> Sent: Tu=
esday,
> December 16, 2025 4:41 PM
> > >
> > > Ensure that a stride larger than 1 (huge page) is only used when both
> > > the guest frame number (gfn) and the operation size (page_count) are
> > > aligned to the huge page size (PTRS_PER_PMD). This matches the
> > > hypervisor requirement that map/unmap operations for huge pages must =
be
> > > guest-aligned and cover a full huge page.
> > >
> > > Add mshv_chunk_stride() to encapsulate this alignment and page-order
> > > validation, and plumb a huge_page flag into the region chunk handlers=
.
> > > This prevents issuing large-page map/unmap/share operations that the
> > > hypervisor would reject due to misaligned guest mappings.
> >
> > This code looks good to me on the surface. But I can only make an educa=
ted
> > guess as to the hypervisor behavior in certain situations, and if my gu=
ess is
> > correct there's still a flaw in one case.
> >
> > Consider the madvise() DONTNEED experiment that I previously called out=
. [1]
> > I surmise that the intent of this patch is to make that case work corre=
ctly.
> > When the .invalidate callback is made for the 32 Kbyte range embedded i=
n
> > a previously mapped 2 Meg page, this new code detects that case. It cal=
ls the
> > hypervisor to remap the 32 Kbyte range for no access, and clears the 8
> > corresponding entries in the struct page array attached to the mshv reg=
ion. The
> > call to the hypervisor is made *without* the HV_MAP_GPA_LARGE_PAGE flag=
.
> > Since the mapping was originally done *with* the HV_MAP_GPA_LARGE_PAGE
> > flag, my guess is that the hypervisor is smart enough to handle this ca=
se by
> > splitting the 2 Meg mapping it created, setting the 32 Kbyte range to n=
o access,
> > and returning "success". If my guess is correct, there's no problem her=
e.
> >
> > But then there's a second .invalidate callback for the entire 2 Meg pag=
e. Here's
> > the call stack:
> >
> > [  194.259337]  dump_stack+0x14/0x20
> > [  194.259339]  mhktest_invalidate+0x2a/0x40  [my dummy invalidate call=
back]
> > [  194.259342]  __mmu_notifier_invalidate_range_start+0x1f4/0x250
> > [  194.259347]  __split_huge_pmd+0x14f/0x170
> > [  194.259349]  unmap_page_range+0x104d/0x1a00
> > [  194.259358]  unmap_single_vma+0x7d/0xc0
> > [  194.259360]  zap_page_range_single_batched+0xe0/0x1c0
> > [  194.259363]  madvise_vma_behavior+0xb01/0xc00
> > [  194.259366]  madvise_do_behavior.part.0+0x3cd/0x4a0
> > [  194.259375]  do_madvise+0xc7/0x170
> > [  194.259380]  __x64_sys_madvise+0x2f/0x40
> > [  194.259382]  x64_sys_call+0x1d77/0x21b0
> > [  194.259385]  do_syscall_64+0x56/0x640
> > [  194.259388]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> >
> > In __split_huge_pmd(), the .invalidate callback is made *before* the 2 =
Meg
> > page is actually split by the root partition. So mshv_chunk_stride() re=
turns "9"
> > for the stride, and the hypervisor is called with HV_MAP_GPA_LARGE_PAGE
> > set. My guess is that the hypervisor returns an error because it has al=
ready
> > split the mapping. The whole point of this patch set is to avoid passin=
g
> > HV_MAP_GPA_LARGE_PAGE to the hypervisor when the hypervisor mapping
> > is not a large page mapping, but this looks like a case where it still =
happens.
> >
> > My concern is solely from looking at the code and thinking about the pr=
oblem,
> > as I don't have an environment where I can test root partition interact=
ions
> > with the hypervisor. So maybe I'm missing something. Lemme know what yo=
u
> > think .....
> >
>=20
> Yeah, I see your point: according to this stack, once a part of the page
> is invalidated, the folio order remains the same until another invocation
> of the same callback - this time for the whole huge
> page - is made. Thus, the stride is still reported as the huge page size,
> even though a part of the page has already been unmapped.
>=20
> This indeed looks like a flaw in the current approach, but it's actually
> not. The reason is that upon the invalidation callback, the driver
> simply remaps the whole huge page with no access (in this case, the PFNs
> provided to the hypervisor are zero), and it's fine as the hypervisor
> simply drops all the pages from the previous mapping and marks this page
> as inaccessible. The only check the hypervisor makes in this case is
> that both the GFN and mapping size are huge page aligned (which they are
> in this case).
>=20
> I hope this clarifies the situation. Please let me know if you have any
> other questions.

Thanks. Yes, this clarifies. My guess about the hypervisor behavior was wro=
ng.
Based on what you've said about what the hypervisor does, and further study=
ing
MSHV code, here's my recap of the HV_MAP_GPA_LARGE_PAGE flag:

1. The hypervisor uses the flag to determine the granularity (4K or 2M) of =
the
mapping HVCALL_MAP_GPA_PAGES or HVCALL_UNMAP_GPA_PAGES will
create/remove. As such, the hypercall "repcount" is in this granularity. GF=
Ns,
such as the target_gpa_base input parameter and GFNs in the pfn_array, are
always 4K GFNs, but if the flag is set, a GFN is treated as the first 4K GF=
N in
a contiguous 2M range. If the flag is set, the target_gpa_base GFN must be
2M aligned.

2. The hypervisor doesn't care whether any existing mapping is 4K or 2M. It
always removes an existing mapping, including splitting any 2M mappings if
necessary. Then if the operation is to create/re-create a mapping, it creat=
es
an appropriate new mapping.

My error was in thinking that the flag had to match any existing mapping.
But the behavior you've clarified is certainly better. It handles the vagar=
ies
of the Linux "mm" subsystem, which in one case in my original experiment
(madvise) invalidates the small range, then the 2M range, but the other
case (mprotect) invalidates the 2M range, then the small range.

Since there's no documentation for these root partition hypercalls, it sure
would be nice if this info could be captured in code comments for some
future developer to benefit from. If that's not something you want to
worry about, I could submit a patch later to add the code comments
(subject to your review, of course).

Separately, in looking at this, I spotted another potential problem with
2 Meg mappings that somewhat depends on hypervisor behavior that I'm
not clear on. To create a new region, the user space VMM issues the
MSHV_GET_GUEST_MEMORY ioctl, specifying the userspace address, the
size, and the guest PFN. The only requirement on these values is that the
userspace address and size be page aligned. But suppose a 4 Meg region is
specified where the userspace address and the guest PFN have different
offsets modulo 2 Meg. The userspace address range gets populated first,
and may contain a 2 Meg large page. Then when mshv_chunk_stride()
detects a 2 Meg aligned guest PFN so HVCALL_MAP_GPA_PAGES can be told
to create a 2 Meg mapping for the guest, the corresponding system PFN in
the page array may not be 2 Meg aligned. What does the hypervisor do in
this case? It can't create a 2 Meg mapping, right? So does it silently fall=
back
to creating 4K mappings, or does it return an error? Returning an error wou=
ld
seem to be problematic for movable pages because the error wouldn't
occur until the guest VM is running and takes a range fault on the region.
Silently falling back to creating 4K mappings has performance implications,
though I guess it would work. My question is whether the
MSHV_GET_GUEST_MEMORY ioctl should detect this case and return an
error immediately.

Michael

> >
> > [1] https://lore.kernel.org/linux-hyperv/SN6PR02MB4157978DFAA6C2584D067=
8E1D4A1A@SN6PR02MB4157.namprd02.prod.outlook.com/

