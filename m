Return-Path: <linux-hyperv+bounces-8122-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id ED956CEF24A
	for <lists+linux-hyperv@lfdr.de>; Fri, 02 Jan 2026 19:11:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4B84530049E7
	for <lists+linux-hyperv@lfdr.de>; Fri,  2 Jan 2026 18:11:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 060353128BA;
	Fri,  2 Jan 2026 18:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="gCDesX0V"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azolkn19010017.outbound.protection.outlook.com [52.103.23.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14D713128A7;
	Fri,  2 Jan 2026 18:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.23.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767377103; cv=fail; b=hcqW1XqrxTOUzKcS5idLNWHbpT21L229EyXZdBBrFoONuxkKK2jyVF9+tAjEyqYVpCZy9PC3y3JAnKXpTuuzQTaZyoZtiY0NS4+VDiUe+rHvNHgnj/uXU2IZ8roPkR9JYUypWrnGslDrQZxKHWAT2en6twWNS9b/SE4kKj0PxIo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767377103; c=relaxed/simple;
	bh=rRUiq2bmNauBiSCNQC8N0sbimPWD/z/vG/HhMsCN2b4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rOEV3z3SdA1XidG1lGONAv1B/2EtN7bFHxbML10EJCRVlLDk2W4Gl3PQLH+szGrv1Mu9WGt//QxecymDkX6pzUila9M1hos31hQBXynzazbQK6THURaMoIrl405wE9hCjC/mOXnRAEsB4/561Sw3eoZ6wyhugyczc5Wdub2uUR8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=gCDesX0V; arc=fail smtp.client-ip=52.103.23.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JrgnvOgw+FfEB9PuXCBGgBPG/LYcqi1Id6bkixOzQOx9b9GLI0gZgsTx9VlHKabnSiRfMv+7E5WuupOc8BWyer811bQwyqilpGmYOspkSJCftNBk9n5F9NlamgsXPENDvTC/9TTn2Y0jo4ogUIsaL13HCrVr7UqjO9LvEBn9hOpf8JxCYGgn97g57x0kNeXwqj2KTiUQwR6qWhjXEEtPLps50wecmlpeRO+M6uJHvITKtkD7pGsdh3vqxQ0F7X4XVdZtQTSW3kuACfLq74iAL0r0j8HKVVqkZdm0ziAGtmJYCDrOOzqjHk912rcgrUcUHqSam1SlM3E9etVS+qQ1RQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4ZATto3DgXOT7looj9KWhIlMqdTK/YF9+okgKbfulrU=;
 b=g0xi52lfYZ5bz5mQIQxbM4AwB6cU2A/IhZwZNu70XaMXqpcx/WV4RaAiwFunnrTIGdt9L5N3uX3lTJLW02jZlPz5c09zogWKliHO7zUb/ovatizdOETRDIXt48duFzcygo6/bCrqwCi/2CD8KM0j53ZUEBZ7PJeG/Nb/z8sjtVT8qu3HX+agAa5FFzswc6EIRxNQXFBr6nXYC4DOmY9cwhaK9LSMJfFp6FCWYw5tYwguiNS9QhnSDz9uox1tr5+fDs7wKSl6R9XvUh4qnBk3ErlBREM0g3wqI9yoHbZ7bIVy7pbleEFHRQ+jBX1fgPrnP0H5tX6RDcTyCMFmtMQstA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4ZATto3DgXOT7looj9KWhIlMqdTK/YF9+okgKbfulrU=;
 b=gCDesX0V6NORTtBp9Tmrm84H4ZiFKmRCOLdob9hyNUUy1x1CHSrztzcGqTp3xfZrjQ27Fl3y0dyZEN/2gKssTM760Ym56J4Pc398e9UcJJ/VrE8VddMFtHEaxyv1SkJeKt3AnfVSFWcHzV3OGogeYCQ6Lx8cxjjQhMbm7oBtMOMmPRl8Fg4RYtvVWTiTFiFx7wKJ1F03iW/QaE4HGBuJXZV3wwOKo+mj1CQRnW0VEhQF4uAvDtiWSBZ+rpqd+4UcNE721EiPCWrDu8EbT87nimepUYTcBjz4RY8JeA0xfy/qhNwHH4hpbT6rS4SOlW1Qa8DclsBE5b1r92y1g29hvg==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by CO6PR02MB8771.namprd02.prod.outlook.com (2603:10b6:303:142::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Fri, 2 Jan
 2026 18:04:57 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6%3]) with mapi id 15.20.9478.004; Fri, 2 Jan 2026
 18:04:56 +0000
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
Thread-Index:
 AQHcbu3m/1KRrXDdWE2Bee61xybnKLUnwn/AgAHUSgCAAZKpIIAEOHMAgAASAICAABt8UIAPsSwAgAABuuA=
Date: Fri, 2 Jan 2026 18:04:56 +0000
Message-ID:
 <SN6PR02MB4157288D26ECC9E69240CFECD4BBA@SN6PR02MB4157.namprd02.prod.outlook.com>
References:
 <176593206931.276257.13023250440372517478.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
 <SN6PR02MB4157D69A4C08B0A4FE01F9FED4A8A@SN6PR02MB4157.namprd02.prod.outlook.com>
 <aUXXdjMyZ5swiCI2@skinsburskii.localdomain>
 <SN6PR02MB41578A17A4DADD9276392298D4B4A@SN6PR02MB4157.namprd02.prod.outlook.com>
 <SN6PR02MB4157AAFDD8BD5BDCD2D3DB99D4B5A@SN6PR02MB4157.namprd02.prod.outlook.com>
 <aUrCr5wBSTrGm-IM@skinsburskii.localdomain>
 <SN6PR02MB41573BF52C6A4447C720CDD6D4B5A@SN6PR02MB4157.namprd02.prod.outlook.com>
 <aVgDloDX9nMH6hZH@skinsburskii.localdomain>
In-Reply-To: <aVgDloDX9nMH6hZH@skinsburskii.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|CO6PR02MB8771:EE_
x-ms-office365-filtering-correlation-id: e08c0389-4228-4556-dc7b-08de4a29700d
x-microsoft-antispam:
 BCL:0;ARA:14566002|461199028|31061999003|13091999003|8060799015|8062599012|15080799012|51005399006|41001999006|19110799012|440099028|40105399003|3412199025|102099032;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?mH5OTWHFiQHKkeeOFIlqDibwTXIeAxLCEm/AEcpKO6W8bG1naPv5AXvk4iO7?=
 =?us-ascii?Q?90UKnc3BfSiwgaq7Z+75mtd8whSvEczVBQqg+2wEVrNx9fUZQKM2sEO2+hGT?=
 =?us-ascii?Q?fUMBq2OQJGs2NnmvoSXvTrt5QtXbQ0QFBLGw8Nm4N+tfETT0bBZd0eXPKIW8?=
 =?us-ascii?Q?bICZals7dBDjGwDcU1B64Ii5+2jiH9Ai78ycKjuRrU+PNUvXcJtTmP5heHCi?=
 =?us-ascii?Q?vIDIsxLaIozTyxovlU+rc0WKIXDBoIYsD73qRfRLlS6CuxcELUb481n457N5?=
 =?us-ascii?Q?KcJlbsvjB4hiqJewnB+EzJuJ7Lf2rtrMqg9AdeK3YmJaikyOHJdUGlr++Q+v?=
 =?us-ascii?Q?cpCRgVg4eu1ud3b3SgHBoH35Cvie0NuDVrODdg/Rmc9xMM+4NHxmBMsXeD5x?=
 =?us-ascii?Q?+15duLwRUW+56nBL1++23rirev9sVpMuXr1423low42603+mTi3+K5Yw2hWF?=
 =?us-ascii?Q?mPdn29qJoCkdnj+LaIALglKQzgrxbDbUFHClvACY74Yg/Z2tYD0y4XUDxfTA?=
 =?us-ascii?Q?RoJJByBohi8SIr7VMIslVqD2sSn4/9RNRO5mrBdWLlnWtpOBECT20m5fuV9a?=
 =?us-ascii?Q?/cIHALXQKri8FNLWe66UANUryVnEhih4qUBEHxG+SAb/uVJBn42DAq+xMGgk?=
 =?us-ascii?Q?KTygoH82jzBtoHqqyPjZL85VC8Ph4EQ3B8RtXsLdDQgFjdGCXQbmbfnpZ590?=
 =?us-ascii?Q?JmbhAuvVKGxXS0+rtO/4CHgS8rmnBHJuR/d4grLDUF3ff231hoZkinQwdlrP?=
 =?us-ascii?Q?nsQU4o6jHJPfhE7s6Olx9CqwSj7REpqQhIeGD6WcIZBP/PUVwGlv7sco8axg?=
 =?us-ascii?Q?zL9KyKb1kAM25ZQYxBYdSIlYFnyZ66q37YlDjfBmL7ZjQQ0XITkDjxheHhtj?=
 =?us-ascii?Q?TXh8XXKsNKvXx3TmrgTmY1BxPHszW53BtREAWi48Np58PhnBVX3zw6FFCCVU?=
 =?us-ascii?Q?JchGeHwbkwcI/NC+lMnzKQZItL9VVHSC6Gjtk1WSYt99M5k8hcCINojC6SDs?=
 =?us-ascii?Q?KcKEH3j81m/qiat5iBPiAzj5+AzY217JeVaz2veBBymHjnQIrvaIvPe/r3kj?=
 =?us-ascii?Q?NWNgyp1+UBSenra9jmW9oFcZniteKkZhZN7U6IG3GruCaHL+kqL+yHluxHJ+?=
 =?us-ascii?Q?UGgbMVkfJJmfw0eWI0nV4jjZqTtjs4UlGU+F/j1l9IF2bmJMeut9cElpMs2V?=
 =?us-ascii?Q?3ESOjU4JKDsdzIuz06kI27TlTeNad8C5gsbIEGgqJ1Z7+ksKH0jE5Iu8IlA?=
 =?us-ascii?Q?=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?+viLWY/nOeeZnLW8/9pHFkhi4UEsmgXqXFdj542brQoUBJjdDWA0M6+6EpGs?=
 =?us-ascii?Q?QThcQyFi+/QXSwsPmM/RP/+xCSKvlPlpUCHPPduFar8shYZL83h/ilqTv1Sw?=
 =?us-ascii?Q?ebtXFuQwv4EtYrtxEvInaFtEyo+PrxUEW04ycdO2aFAgtB/KTSUmvp9UkU1Y?=
 =?us-ascii?Q?XDfY5GvMdhLXtU8APuxblFbJgZEPQ4hokHlv1y84ix2bRJC58l0ydZhFX8w3?=
 =?us-ascii?Q?mWSrEyBm2ZUUujCpDGb/2YUO9PuDFhzOk8qHqMBWW22a9bTSaSxjN7Bz4acm?=
 =?us-ascii?Q?KivNVhGT/VhXHniovMfVFn4sdtju4QdKfEWIMfE6nspVV6HU/Y4gS4c90cNT?=
 =?us-ascii?Q?TvYZHdy9TQWGp3AcZcnxMlajCHzLi+o1p7yLsXa/GSYIEk3DABm2S9pJBXKF?=
 =?us-ascii?Q?UC2QSyBJ5ndiYXXK+Vbvo5yaZeAWVGOkPETTkQUxALv16mdwlyuXk1njPOh7?=
 =?us-ascii?Q?XbkxwyIgKUPEiqQMR5jAyXYkG28It+5mQ7HskDAbImDLCGnLprVb0I42OD8l?=
 =?us-ascii?Q?k0r4lLE6xbpaCn5NEGweJR2to2+uNRttW9Yvv5nHlzpCeXbF/0wZNWIMWyvU?=
 =?us-ascii?Q?9eYqJFGSZsJbrnTxvklBt1QkKKuYZ+lK8UfQtrHuzIMYTtR5alHvU6Cg/cqd?=
 =?us-ascii?Q?jiWSm/VqxIVH50KcEzp35SNA30WCtg0XeNPGrQxMOekw/HFCcbIAnuqcuSxR?=
 =?us-ascii?Q?IZ7UWrcIncFWa0xrFfoK5czpv8UkiB//XgjGKidTzzjzF2GJBKZ/eDD8c7PL?=
 =?us-ascii?Q?ER5hISZdtr29YHKUzKr4///iw/23RqPBFgF/JPpfCG7CmEn7ImOwLe6Z/Jxy?=
 =?us-ascii?Q?6X4B0Zg+t6P0QL43+z9kzLeg5aW9cpYfeehv5hxzt6Ax3FblBCDNqGf2MFNX?=
 =?us-ascii?Q?xAzQJ2g4sf3iskBzs1TeStPSH55lwb4M4N505GeIivGoGLqkbjcYAus4cKSa?=
 =?us-ascii?Q?VJvIpywDRla95bAEWubn4wb/KyL2FxqYeD6wmFmQBrCv8zpyHPCdw0jLDVqn?=
 =?us-ascii?Q?s3+CzXUYeZjzQ+YXepeYwz8YyA1n83XOV8rJc9Zj1g8Y/cvf/ER+lmeiJaWh?=
 =?us-ascii?Q?px1G/IoaYhdgba3kDcUSp3iVSixk+z1i8FvXHrcoo4B4JTzsUw5loJavO0/x?=
 =?us-ascii?Q?wsKwmCbkIntN7/eGhjGvyi9aTjts/I0Hqhz0ZcJYKb5RtUV/v6rTJ2imeQte?=
 =?us-ascii?Q?bCefjXHBWID2L6wDCTv4HBmcjiZaLe1bgT868EniRGLN6B5JTTiD/H9sfOGP?=
 =?us-ascii?Q?FGraujYCr7q4/zQarMOpKmkYXDLDOIKXI/E5FwmEM35v11cY5qtzWFz/8o9s?=
 =?us-ascii?Q?XKafKOUCFBOmg//wfLYijyFQuhJeysNBD3T/l02Xl9WvRlSmRYeSwYsjfgvX?=
 =?us-ascii?Q?i2EXf4Y=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e08c0389-4228-4556-dc7b-08de4a29700d
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jan 2026 18:04:56.6788
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR02MB8771

From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com> Sent: Friday=
, January 2, 2026 9:43 AM
>=20
> On Tue, Dec 23, 2025 at 07:17:23PM +0000, Michael Kelley wrote:
> > From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com> Sent: Tu=
esday,
> December 23, 2025 8:26 AM
> > >
> > > On Tue, Dec 23, 2025 at 03:51:22PM +0000, Michael Kelley wrote:
> > > > From: Michael Kelley Sent: Monday, December 22, 2025 10:25 AM
> > > > >
> > > > [snip]
> > > > >
> > > > > Separately, in looking at this, I spotted another potential probl=
em with
> > > > > 2 Meg mappings that somewhat depends on hypervisor behavior that =
I'm
> > > > > not clear on. To create a new region, the user space VMM issues t=
he
> > > > > MSHV_GET_GUEST_MEMORY ioctl, specifying the userspace address, th=
e
> > > > > size, and the guest PFN. The only requirement on these values is =
that the
> > > > > userspace address and size be page aligned. But suppose a 4 Meg r=
egion is
> > > > > specified where the userspace address and the guest PFN have diff=
erent
> > > > > offsets modulo 2 Meg. The userspace address range gets populated =
first,
> > > > > and may contain a 2 Meg large page. Then when mshv_chunk_stride()
> > > > > detects a 2 Meg aligned guest PFN so HVCALL_MAP_GPA_PAGES can be =
told
> > > > > to create a 2 Meg mapping for the guest, the corresponding system=
 PFN in
> > > > > the page array may not be 2 Meg aligned. What does the hypervisor=
 do in
> > > > > this case? It can't create a 2 Meg mapping, right? So does it sil=
ently fallback
> > > > > to creating 4K mappings, or does it return an error? Returning an=
 error would
> > > > > seem to be problematic for movable pages because the error wouldn=
't
> > > > > occur until the guest VM is running and takes a range fault on th=
e region.
> > > > > Silently falling back to creating 4K mappings has performance imp=
lications,
> > > > > though I guess it would work. My question is whether the
> > > > > MSHV_GET_GUEST_MEMORY ioctl should detect this case and return an
> > > > > error immediately.
> > > > >
> > > >
> > > > In thinking about this more, I can answer my own question about the
> > > > hypervisor behavior. When HVCALL_MAP_GPA_PAGES is set, the full
> > > > list of 4K system PFNs is not provided as an input to the hypercall=
, so
> > > > the hypervisor cannot silently fall back to 4K mappings. Assuming
> > > > sequential PFNs would be wrong, so it must return an error if the
> > > > alignment of a system PFN isn't on a 2 Meg boundary.
> > > >
> > > > For a pinned region, this error happens in mshv_region_map() as
> > > > called from  mshv_prepare_pinned_region(), so will propagate back
> > > > to the ioctl. But the error happens only if pin_user_pages_fast()
> > > > allocates one or more 2 Meg pages. So creating a pinned region
> > > > where the guest PFN and userspace address have different offsets
> > > > modulo 2 Meg might or might not succeed.
> > > >
> > > > For a movable region, the error probably can't occur.
> > > > mshv_region_handle_gfn_fault() builds an aligned 2 Meg chunk
> > > > around the faulting guest PFN. mshv_region_range_fault() then
> > > > determines the corresponding userspace addr, which won't be on
> > > > a 2 Meg boundary, so the allocated memory won't contain a 2 Meg
> > > > page. With no 2 Meg pages, mshv_region_remap_pages() will
> > > > always do 4K mappings and will succeed. The downside is that a
> > > > movable region with a guest PFN and userspace address with
> > > > different offsets never gets any 2 Meg pages or mappings.
> > > >
> > > > My conclusion is the same -- such misalignment should not be
> > > > allowed when creating a region that has the potential to use 2 Meg
> > > > pages. Regions less than 2 Meg in size could be excluded from such
> > > > a requirement if there is benefit in doing so. It's possible to hav=
e
> > > > regions up to (but not including) 4 Meg where the alignment prevent=
s
> > > > having a 2 Meg page, and those could also be excluded from the
> > > > requirement.
> > > >
> > >
> > > I'm not sure I understand the problem.
> > > There are three cases to consider:
> > > 1. Guest mapping, where page sizes are controlled by the guest.
> > > 2. Host mapping, where page sizes are controlled by the host.
> >
> > And by "host", you mean specifically the Linux instance running in the
> > root partition. It hosts the VMM processes and creates the memory
> > regions for each guest.
> >
> > > 3. Hypervisor mapping, where page sizes are controlled by the hypervi=
sor.
> > >
> > > The first case is not relevant here and is included for completeness.
> >
> > Agreed.
> >
> > >
> > > The second and third cases (host and hypervisor) share the memory lay=
out,
> >
> > Right. More specifically, they are both operating on the same set of ph=
ysical
> > memory pages, and hence "share" a set of what I've referred to as
> > "system PFNs" (to distinguish from guest PFNs, or GFNs).
> >
> > > but it is up
> > > to each entity to decide which page sizes to use. For example, the ho=
st might map the
> > > proposed 4M region with only 4K pages, even if a 2M page is available=
 in the middle.
> >
> > Agreed.
> >
> > > In this case, the host will map the memory as represented by 4K pages=
, but the hypervisor
> > > can still discover the 2M page in the middle and adjust its page tabl=
es to use a 2M page.
> >
> > Yes, that's possible, but subject to significant requirements. A 2M pag=
e can be
> > used only if the underlying physical memory is a physically contiguous =
2M chunk.
> > Furthermore, that contiguous 2M chunk must start on a physical 2M bound=
ary,
> > and the virtual address to which it is being mapped must be on a 2M bou=
ndary.
> > In the case of the host, that virtual address is the user space address=
 in the
> > user space process. In the case of the hypervisor, that "virtual addres=
s" is the
> > the location in guest physical address space; i.e., the guest PFN left-=
shifted 9
> > to be a guest physical address.
> >
> > These requirements are from the physical processor and its requirements=
 on
> > page table formats as specified by the hardware architecture. Whereas t=
he
> > page table entry for a 4K page contains the entire PFN, the page table =
entry
> > for a 2M page omits the low order 9 bits of the PFN -- those bits must =
be zero,
> > which is equivalent to requiring that the PFN be on a 2M boundary. Thes=
e
> > requirements apply to both host and hypervisor mappings.
> >
> > When MSHV code in the host creates a new pinned region via the ioctl,
> > MSHV code first allocates memory for the region using pin_user_pages_fa=
st(),
> > which returns the system PFN for each page of physical memory that is
> > allocated. If the host, at its discretion, allocates a 2M page, then a =
series
> > of 512 sequential 4K PFNs is returned for that 2M page, and the first o=
f
> > the 512 sequential PFNs must have its low order 9 bits be zero.
> >
> > Then the MSHV ioctl makes the HVCALL_MAP_GPA_PAGES hypercall for
> > the hypervisor to map the allocated memory into the guest physical
> > address space at a particular guest PFN. If the allocated memory contai=
ns
> > a 2M page, mshv_chunk_stride() will see a folio order of 9 for the 2M p=
age,
> > causing the HV_MAP_GPA_LARGE_PAGE flag to be set, which requests that
> > the hypervisor do that mapping as a 2M large page. The hypercall does n=
ot
> > have the option of dropping back to 4K page mappings in this case. If
> > the 2M alignment of the system PFN is different from the 2M alignment
> > of the target guest PFN, it's not possible to create the mapping and th=
e
> > hypercall fails.
> >
> > The core problem is that the same 2M of physical memory wants to be
> > mapped by the host as a 2M page and by the hypervisor as a 2M page.
> > That can't be done unless the host alignment (in the VMM virtual addres=
s
> > space) and the guest physical address (i.e., the target guest PFN) alig=
nment
> > match and are both on 2M boundaries.
> >
>=20
> But why is it a problem? If both the host and the hypervisor can map ap
> huge page, but the guest can't, it's still a win, no?
> In other words, if VMM passes a host huge page aligned region as a guest
> unaligned, it's a VMM problem, not a hypervisor problem. And I' don't
> understand why would we want to prevent such cases.
>=20

Fair enough -- mostly. If you want to allow the misaligned case and live
with not getting the 2M mapping in the guest, that works except in the
situation that I described above, where the HVCALL_MAP_GPA_PAGES
hypercall fails when creating a pinned region.

The failure is flakey in that if the Linux in the root partition does not
map any of the region as a 2M page, the hypercall succeeds and the
MSHV_GET_GUEST_MEMORY ioctl succeeds. But if the root partition
happens to map any of the region as a 2M page, the hypercall will fail,
and the MSHV_GET_GUEST_MEMORY ioctl will fail. Presumably such
flakey behavior is bad for the VMM.

One solution is that mshv_chunk_stride() must return a stride > 1 only
if both the gfn (which it currently checks) AND the corresponding
userspace_addr are 2M aligned. Then the HVCALL_MAP_GPA_PAGES
hypercall will never have HV_MAP_GPA_LARGE_PAGE set for the
misaligned case, and the failure won't occur.

Michael

>=20
> > Movable regions behave a bit differently because the memory for the
> > region is not allocated on the host "up front" when the region is creat=
ed.
> > The memory is faulted in as the guest runs, and the vagaries of the cur=
rent
> > MSHV in Linux code are such that 2M pages are never created on the host
> > if the alignments don't match. HV_MAP_GPA_LARGE_PAGE is never passed
> > to the HVCALL_MAP_GPA_PAGES hypercall, so the hypervisor just does 4K
> > mappings, which works even with the misalignment.
> >
> > >
> > > This adjustment happens at runtime. Could this be the missing detail =
here?
> >
> > Adjustments at runtime are a different topic from the issue I'm raising=
,
> > though eventually there's some relationship. My issue occurs in the
> > creation of a new region, and the setting up of the initial hypervisor
> > mapping. I haven't thought through the details of adjustments at runtim=
e.
> >
> > My usual caveats apply -- this is all "thought experiment". If I had th=
e
> > means do some runtime testing to confirm, I would. It's possible the
> > hypervisor is playing some trick I haven't envisioned, but I'm skeptica=
l of
> > that given the basics of how physical processors work with page tables.
> >
> > Michael

