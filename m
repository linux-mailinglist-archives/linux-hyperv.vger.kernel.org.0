Return-Path: <linux-hyperv+bounces-7094-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A68D4BB8F59
	for <lists+linux-hyperv@lfdr.de>; Sat, 04 Oct 2025 17:25:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1B1AD4E05DC
	for <lists+linux-hyperv@lfdr.de>; Sat,  4 Oct 2025 15:25:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 237DB26CE2D;
	Sat,  4 Oct 2025 15:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="nPbrLm5T"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazolkn19012067.outbound.protection.outlook.com [52.103.14.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05F6F1BCA07;
	Sat,  4 Oct 2025 15:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.14.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759591515; cv=fail; b=lLoj92wCrXh3d8Gejs+oj7GFh0gICBRcfBmbksJwQqIPRkP48kgWul27PDPDzIBI+ehl2jMOqAkna7ve+wuAcvR4QouzyOEGqaI1LqxqplBG9o+10ASd/V6ihXLqSxscg1+LcnzCHScn6BRXG/ankeC5Xk+BLbusQ6eIRK+DxPc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759591515; c=relaxed/simple;
	bh=wIOIyXPEUPN5IyDGrq0lIigmWT7RsLdxaEQJKDo+QCI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YGA6KnAO9DnCLvberTjW038k1UsgVDfFU9S81IJSYlOIs6XCdpyFCNlL83PjN4lbQMyMtd0XwcVh2rqTBnWpIcV/Gqyq7xeG0mHTeVdvqQwgJ72krNCs4OanPWXqP4z6EPXGLKrJwDX36k3rkC56h4fTBVS+X4sbz0UU3JG/A1M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=nPbrLm5T; arc=fail smtp.client-ip=52.103.14.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IlYm+N2qXUjbN6I7AMO9/pmkuljuUHHYs622KgCrnAVPsCGoIItTcA6hmsRnQ+5e75YLZwfvyDZQlJ4khnWuSBsorsJiJp1nc7CQaOumVQ6uGYUvgKqen5z+hGt+0510s0CrT/YCBpMTZqrOAXHAMc+gmUfurIT79gT1e9YpCXNgWzjvFiz/OceqQdeG/a1EjoIDS7dDCJ5BgqnVLuv9JT23ubnl2JIdjPZVSVcY/QIbaBhT6/C2L7YuXgSGmqrqN0coGqkiI37mWgy5WTVRkunrqT3uZjvO+3J1utS0839tUItabCCFwnUPgGDo3uR6V3M+scp95nmQyRYYpmexKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HjBNvH6bcTajzNHSxYd8sWeSbTCb48p92DmOaozq2IA=;
 b=FK4+f5+NwGkDc98mA1TGFCBxk/N3UlYgPclUewjBe0h3u4qbOq0rj/dyWL0ZDFsJdiLDuFEEyzML40S4ZFmlQev5low+51nGXrC9BJ+HV36/NLfwyzRzRPXEaBG1emcy1hr1Hx9+4aRc+nYwJ4CgQrX/W8F/RYu3nC9l+llDJhGwycqIQ9umd3KwlOLOE0E0B78Laj4brzq9ppCp3n+1ZutkFGTC7RsTtmQyZ5au2TQdGQB5KRhNxtTxiM11jjuuwpc0fIxArPtHNdLFHTcc81sH1iLbSNbdzqoFwX7G/BbhOWjV8cTiLdGH5SbKJGnofsnBIQLhehOF6CWykP6h+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HjBNvH6bcTajzNHSxYd8sWeSbTCb48p92DmOaozq2IA=;
 b=nPbrLm5T/4KTSxKojcwmw53jKU3cFmezDGJ7WEdO10OlgqXvmJ1XFzfXn76HqMwc2l++MSsRwOwaH2GoGtlfVIXPFA7ZzObnVJnFjcNvUaJBMt6HXcSwWAy8L6uofSNbbaHHr1eJarwx5xm586zcGQiTwWcs4lW4XCrg5/9h5m/28cyykBFBPCil/vroTzhy6/1vEMLqb9AsSGMLxZyBNSW7xJPpihRT9NXvMcSUNQSdlwxl6v6cX9yJQFHB62uli7I4W8wef8qpG5LBSmeIruuc1uCiAJZaD2eDs1zj4jF6mPyvHu7yM3nQ1v9csXq0STJVl9ueduTuq4IG4edSvA==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by MN2PR02MB6655.namprd02.prod.outlook.com (2603:10b6:208:19a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.19; Sat, 4 Oct
 2025 15:25:10 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%3]) with mapi id 15.20.9182.017; Sat, 4 Oct 2025
 15:25:10 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Michael Kelley <mhklinux@outlook.com>, Nuno Das Neves
	<nunodasneves@linux.microsoft.com>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "prapal@linux.microsoft.com"
	<prapal@linux.microsoft.com>, "easwar.hariharan@linux.microsoft.com"
	<easwar.hariharan@linux.microsoft.com>, "tiala@microsoft.com"
	<tiala@microsoft.com>, "anirudh@anirudhrb.com" <anirudh@anirudhrb.com>,
	"paekkaladevi@linux.microsoft.com" <paekkaladevi@linux.microsoft.com>,
	"skinsburskii@linux.microsoft.com" <skinsburskii@linux.microsoft.com>
CC: "kys@microsoft.com" <kys@microsoft.com>, "haiyangz@microsoft.com"
	<haiyangz@microsoft.com>, "wei.liu@kernel.org" <wei.liu@kernel.org>,
	"decui@microsoft.com" <decui@microsoft.com>, Jinank Jain
	<jinankjain@linux.microsoft.com>
Subject: RE: [PATCH v4 4/5] mshv: Allocate vp state page for
 HVCALL_MAP_VP_STATE_PAGE on L1VH
Thread-Topic: [PATCH v4 4/5] mshv: Allocate vp state page for
 HVCALL_MAP_VP_STATE_PAGE on L1VH
Thread-Index: AQHcLwIJ67Rvwcf9OU+03OvTNyRllLSqZUqQgAOJ8ICAAAQZoIAEKLow
Date: Sat, 4 Oct 2025 15:25:09 +0000
Message-ID:
 <SN6PR02MB4157F9804CC7F22A22E01682D4E5A@SN6PR02MB4157.namprd02.prod.outlook.com>
References:
 <1758903795-18636-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1758903795-18636-5-git-send-email-nunodasneves@linux.microsoft.com>
 <SN6PR02MB4157E95BDC70A1F91228DAF7D41BA@SN6PR02MB4157.namprd02.prod.outlook.com>
 <8bacde85-6406-4b47-b11d-ed5054b270f2@linux.microsoft.com>
 <SN6PR02MB4157BB0D3B4B8A616C8B2E29D4E7A@SN6PR02MB4157.namprd02.prod.outlook.com>
In-Reply-To:
 <SN6PR02MB4157BB0D3B4B8A616C8B2E29D4E7A@SN6PR02MB4157.namprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|MN2PR02MB6655:EE_
x-ms-office365-filtering-correlation-id: e63437ee-cef5-4bae-92e2-08de035a34a7
x-microsoft-antispam:
 BCL:0;ARA:14566002|8060799015|13091999003|8062599012|19110799012|31061999003|461199028|8022599003|15080799012|41001999006|12121999013|440099028|3412199025|102099032|1710799026;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?Z42NGmFttJEBkC39w1phVidLm/G9r11vY2Y75KVqo9YkNRwTtsSdF3c/Uyry?=
 =?us-ascii?Q?OYCtQOPMZwCOZ8ieatayyqDku6eTGPz2bSacvGyS422UT1ZmpmmCgsLi/RH7?=
 =?us-ascii?Q?nsx0moJJFJegqIRvAd2xoMbE+gSbkgirdGJ3xy/LaWMR7dfa2EQ5E47RmAL1?=
 =?us-ascii?Q?MV7Vq0w8isoiiOckiWkkn17YgMhNA7Z6dvT5vYGmTcLYqkMH9qfjSpjvzJBV?=
 =?us-ascii?Q?8TVdKgMWHFzwFc18OFndiWaigDoT+0qOWSGKHvgeIRMqTrjaMqrwCsG1cZPI?=
 =?us-ascii?Q?4223DRgf9+RDgWQBXRW3b7RMNPPQWRZzTCNrNRKHaB4bZl5SJHqmGqeeVi4G?=
 =?us-ascii?Q?LEQxFabM1meQDLbRf7iKZ3XKOgvE3Ud5/yZ6O6hbpQuPF73hFDoPGdMmvyzy?=
 =?us-ascii?Q?az2o14QdoQN0+dKYobQOQAiPMlBSOMcrNISXIsbxyL98d3zKtCG7Sy1nWi82?=
 =?us-ascii?Q?1GV3YgfsqhyN/aJugEwSKmvT4H18H93D+7cXEinbqgcI4/wuV2wUyDaSBlDO?=
 =?us-ascii?Q?pgKp/p2l2MCanxUMRH1nLurzIpLh9yEPRNYeew2MUpyR0XqkHd8gqYTLv7CS?=
 =?us-ascii?Q?pZSZpX5Z2VMuK7a4UWpmx9kMktLFvCL/2a8+jmklvmg2Htk6jlN7ljaIOU6D?=
 =?us-ascii?Q?77ERBJz0dAA7/WawFeGvlNXYHJC2sAGX+moaRMFcJNbosmu5yqdxAzpCju7x?=
 =?us-ascii?Q?7SjF+BB+gJbkUIQdkBYi4NnQArix6NZrL0ToXBh1t/KDZ9ylCgE1NvhLHVfQ?=
 =?us-ascii?Q?r/F2rMBoVwL3XWLXrzdxgYGqc5b8wwzSes5RNpMIz43TmaI8t8v+K7PRPfap?=
 =?us-ascii?Q?wXA5jkt0101TeOahbIXkLVuE79bIoNPQti/+gtUIMUofLq2T2gSdA6EDJIuf?=
 =?us-ascii?Q?Iggfd3SIzSY3/vBJghvP3mef9ustVIIP9G8liKRmDtBODPigFcyQfbD2vqSp?=
 =?us-ascii?Q?FwFKmLzu/J6jjJgCq0O1kKmZnoxj0NIelz+G3MxuLnfZjZED5o7PHyjtoemT?=
 =?us-ascii?Q?3UMR8YA/tQ8/KteltcWeyEl2J/w4pbRJHawlB9UJ1tPKc6FsyXFPqjGpK/MX?=
 =?us-ascii?Q?0BNWkQcThw74wlZpG7R5S8RogXNjAiKOt72DES+7Qva4kjeyBS6/YmDFRwge?=
 =?us-ascii?Q?EIiOYVs+xS6SK85p8A+9IoQf4JlZ4FWXLKQdIeUw1hN5vAUO67I+/xuk3e26?=
 =?us-ascii?Q?1fDbisjD+K6rhLuLLEX+8aHOWdT5R0oaIckX9J2vsmAi8FlX+TR5PTp3Che7?=
 =?us-ascii?Q?+oEGSuBy3WzCsJzoZvRicvqoHx1ZMEH7TCSBT2wtdg=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?GIhuZ9WmSvTRc+spXX+y6Km0Op38vMGif+2FFjJq6GxtBWHVjetpR16AO4b0?=
 =?us-ascii?Q?JaegzSHpKIFGH2NwM/fDG6cD6pggZcyeLknoxN5kx0m4WN/SIalR67CxSeNS?=
 =?us-ascii?Q?VBCgzaREn+YYdCOuQAJjU1Q9dLGSeTVEirEmstMnxpStHsKLCb8vL+DYk6pz?=
 =?us-ascii?Q?N7gq2uTDvCRhNMbNWgcPkMnkJA7o4M0GAjgLsGUp/S71nml1HuMenpZAkmGs?=
 =?us-ascii?Q?LfO54jwr9O0zy7SaInkaolRzdPkNCSAa9t41zxuu13PI7KiIn45ICAqDbhrs?=
 =?us-ascii?Q?p97FMHbdyinEVhiGv1ivB1ptwD7jgkMADwFx1gHyrXpNM67QCFBcsMLiUANh?=
 =?us-ascii?Q?dE0kKwbP80UQb/uEFjj4WSyPc/8GDnGuGo2sdR12oV+Nq9xX3ryiIhU4u7X9?=
 =?us-ascii?Q?1jhoasIMJ+i/U4gapDUJ0xkh99f+13vYXc0l+fGF60AH0Cqaw65XVexN5/Uh?=
 =?us-ascii?Q?AM0f+E15e2n7BpW3VU8LLNn0ck1Rn4jeRqtfXF2IjZWe/5bdOzTrMZyKuRrG?=
 =?us-ascii?Q?zrNiqG1YDN2uMkzVcicNy/i/kw2NuJL+Wu/OuIK245D/nseS2OiL20JCExbx?=
 =?us-ascii?Q?by/1fjbsOCll1baiYjpU26Wyqg5d3O0oMMsl+ETjnM7WfoIXffHzAXB/SXiz?=
 =?us-ascii?Q?+US7fIU9GMxfLUUdBz0zsf/yykYVXbK5joq2LxZrPIGplQMPeGFhgdCi3+WX?=
 =?us-ascii?Q?4TIwmqpmM8xiAMyauBADTt/wywxDaVdIwKoqoSV18q/Nvg7Ho0eJMpricYuS?=
 =?us-ascii?Q?02VLvzE5zVoVQjjOACRu5qErYCQJr6vdzied3eobaFO8r7Xr/r7C/yqwIus2?=
 =?us-ascii?Q?9HaT1vti75RYzPXl9PKMQzpAqqNNxrS1cbnRbr7rIM3CHLSJk13lxMDHmV6b?=
 =?us-ascii?Q?tNVZrQcncKgrHq0YbhnpZ7P0/8OybjMPOGP9L/6+I9BM1C1kx4EPHy/+fVlD?=
 =?us-ascii?Q?/ngh/O6nLMja+rDpILct4Mv+sbRQ2UCgwGlpUSD08dPCA2zowZPHr0d3v28c?=
 =?us-ascii?Q?z+aDQ7UOt9FQ5sxv160SLr0YyYmz914EPqcJ9ZTqO/tVUwdOg1C/VxdtrnXe?=
 =?us-ascii?Q?u0oYbmgqb9rNrn9pfvtnv305F5zHb5ss9YXO3Eqf0ucqf9OfhkjYAxSAO2gT?=
 =?us-ascii?Q?UMN+xBCDVXRBXLcaGLtw4WVlj5AzAt/pZcW7pazA2PU3DUxS0/hqpN+gTTiO?=
 =?us-ascii?Q?7ABq7G4gEZuGA0OMMAQgdDKtchC2qvt5WuivyP7v767lLSN0G2KWPpiQZLw?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e63437ee-cef5-4bae-92e2-08de035a34a7
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Oct 2025 15:25:09.8078
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB6655

From: Michael Kelley <mhklinux@outlook.com> Sent: Wednesday, October 1, 202=
5 5:03 PM
>=20
> From: Nuno Das Neves <nunodasneves@linux.microsoft.com> Sent: Wednesday, =
October 1, 2025 3:56 PM
> >
> > On 9/29/2025 10:56 AM, Michael Kelley wrote:
> > > From: Nuno Das Neves <nunodasneves@linux.microsoft.com> Sent: Friday,=
 September 26, 2025 9:23 AM
> > >>
> > >> From: Jinank Jain <jinankjain@linux.microsoft.com>
> > >>
> > >> Introduce mshv_use_overlay_gpfn() to check if a page needs to be
> > >> allocated and passed to the hypervisor to map VP state pages. This i=
s
> > >> only needed on L1VH, and only on some (newer) versions of the
> > >> hypervisor, hence the need to check vmm_capabilities.
> > >>
> > >> Introduce functions hv_map/unmap_vp_state_page() to handle the
> > >> allocation and freeing.
> > >>
> > >> Signed-off-by: Jinank Jain <jinankjain@linux.microsoft.com>
> > >> Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
> > >> Reviewed-by: Praveen K Paladugu <prapal@linux.microsoft.com>
> > >> Reviewed-by: Easwar Hariharan <easwar.hariharan@linux.microsoft.com>
> > >> Reviewed-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com=
>
> > >> Reviewed-by: Anirudh Rayabharam <anirudh@anirudhrb.com>
> > >> ---
> > >>  drivers/hv/mshv_root.h         | 11 ++---
> > >>  drivers/hv/mshv_root_hv_call.c | 61 ++++++++++++++++++++++++---
> > >>  drivers/hv/mshv_root_main.c    | 76 +++++++++++++++++--------------=
---
> > >>  3 files changed, 98 insertions(+), 50 deletions(-)
> > >>
> > >> diff --git a/drivers/hv/mshv_root.h b/drivers/hv/mshv_root.h
> > >> index 0cb1e2589fe1..dbe2d1d0b22f 100644
> > >> --- a/drivers/hv/mshv_root.h
> > >> +++ b/drivers/hv/mshv_root.h
> > >> @@ -279,11 +279,12 @@ int hv_call_set_vp_state(u32 vp_index, u64 par=
tition_id,
> > >>  			 /* Choose between pages and bytes */
> > >>  			 struct hv_vp_state_data state_data, u64 page_count,
> > >>  			 struct page **pages, u32 num_bytes, u8 *bytes);
> > >> -int hv_call_map_vp_state_page(u64 partition_id, u32 vp_index, u32 t=
ype,
> > >> -			      union hv_input_vtl input_vtl,
> > >> -			      struct page **state_page);
> > >> -int hv_call_unmap_vp_state_page(u64 partition_id, u32 vp_index, u32=
 type,
> > >> -				union hv_input_vtl input_vtl);
> > >> +int hv_map_vp_state_page(u64 partition_id, u32 vp_index, u32 type,
> > >> +			 union hv_input_vtl input_vtl,
> > >> +			 struct page **state_page);
> > >> +int hv_unmap_vp_state_page(u64 partition_id, u32 vp_index, u32 type=
,
> > >> +			   struct page *state_page,
> > >> +			   union hv_input_vtl input_vtl);
> > >>  int hv_call_create_port(u64 port_partition_id, union hv_port_id por=
t_id,
> > >>  			u64 connection_partition_id, struct hv_port_info *port_info,
> > >>  			u8 port_vtl, u8 min_connection_vtl, int node);
> > >> diff --git a/drivers/hv/mshv_root_hv_call.c b/drivers/hv/mshv_root_h=
v_call.c
> > >> index 3fd3cce23f69..98c6278ff151 100644
> > >> --- a/drivers/hv/mshv_root_hv_call.c
> > >> +++ b/drivers/hv/mshv_root_hv_call.c
> > >> @@ -526,9 +526,9 @@ int hv_call_set_vp_state(u32 vp_index, u64 parti=
tion_id,
> > >>  	return ret;
> > >>  }
> > >>
> > >> -int hv_call_map_vp_state_page(u64 partition_id, u32 vp_index, u32 t=
ype,
> > >> -			      union hv_input_vtl input_vtl,
> > >> -			      struct page **state_page)
> > >> +static int hv_call_map_vp_state_page(u64 partition_id, u32 vp_index=
, u32 type,
> > >> +				     union hv_input_vtl input_vtl,
> > >> +				     struct page **state_page)
> > >>  {
> > >>  	struct hv_input_map_vp_state_page *input;
> > >>  	struct hv_output_map_vp_state_page *output;
> > >> @@ -547,7 +547,14 @@ int hv_call_map_vp_state_page(u64 partition_id,=
 u32 vp_index, u32 type,
> > >>  		input->type =3D type;
> > >>  		input->input_vtl =3D input_vtl;
> > >>
> > >> -		status =3D hv_do_hypercall(HVCALL_MAP_VP_STATE_PAGE, input, outpu=
t);
> > >
> > > This function must zero the input area before using it. Otherwise,
> > > flags.map_location_provided is uninitialized when *state_page is NULL=
. It will
> > > have whatever value was left by the previous user of hyperv_pcpu_inpu=
t_arg,
> > > potentially producing bizarre results. And there's a reserved field t=
hat won't be
> > > set to zero.
> > >
> > Good catch, will add a memset().
> >
> > >> +		if (*state_page) {
> > >> +			input->flags.map_location_provided =3D 1;
> > >> +			input->requested_map_location =3D
> > >> +				page_to_pfn(*state_page);
> > >
> > > Technically, this should be page_to_hvpfn() since the PFN value is be=
ing sent to
> > > Hyper-V. I know root (and L1VH?) partitions must run with the same pa=
ge size
> > > as the Hyper-V host, but it's better to not leave code buried here th=
at will blow
> > > up if the "same page size requirement" should ever change.
> > >
> > Good point...I could change these calls, but the other way doesn't work=
, see below.
> >
> > > And after making the hypercall, there's an invocation of pfn_to_page(=
), which
> > > should account for the same. Unfortunately, there's not an existing h=
vpfn_to_page()
> > > function.
> > >
> > This seems like a tricky scenario to get right. In the root partition c=
ase, the
> > hypervisor allocates the page. That pfn could be some page within a lar=
ger Linux page.
> > Converting that to a Linux pfn (naively) means losing the original hvpf=
n since it gets
> > truncated, which is no good if we want to unmap it later. Also page_add=
ress() would
> > give the wrong virtual address.
> >
> > In other words, we'd have to completely change how we track these pages=
 in order to
> > support this scenario, and the same goes for various other hypervisor A=
PIs where the
> > hypervisor does the allocating. I think it's out of scope to try and ad=
dress that
> > here, even in part, especially since we will be making assumptions abou=
t something
> > that may never happen.
>=20
> OK, yes the hypervisor allocating the page is a problem when Linux tracks=
 it
> as a struct page. I'll agree it's out of current scope to change this.
>=20
> It makes me think about hv_synic_enable_regs() where the paravisor or hyp=
ervisor
> allocates the synic_message_page and synic_event_page. But that case shou=
ld work
> OK with a regular guest with page size greater than 4K because the pages =
are tracked
> based on the guest kernel virtual address, not the PFN. So hv_synic_enabl=
e_regs()
> should work on ARM64 Linux guests with 64K page size and a paravisor, as =
well as
> for my postulated root partition with page size greater than 4K.
>=20
> When it matters, cases where the hypervisor or paravisor allocate pages t=
o give
> to the guest will require careful handling to ensure they work for guest =
page sizes
> greater than 4K. That's useful information for future consideration. Than=
ks for the
> discussion.
>=20

Upon further reflection, I think there's a subtle bug in the case where the
hypervisor supplies the state page. This bug is present in the existing cod=
e, and
persists after these patches.

I'm assuming that the hypervisor supplied page is *not* part of the memory
assigned to the root partition when it was created. I.e., the supplied page=
 is part
of the hypervisor's private memory.  Or does the root partition Linux "give=
"
the hypervisor some memory for it to later return as one of these state pag=
es?

Assuming the page did *not* originate in Linux, then the page provided by t=
he
hypervisor doesn't actually have a "struct page" entry in the root partitio=
n Linux
instance. Doing pfn_to_page() works because it just does some address
arithmetic, but the resulting "struct page *" value points somewhere off th=
e
end of the root partition's "struct page" array.

Then page_to_virt() is done on this somewhat bogus "struct page *" value.
page_to_virt() also just does some address arithmetic, so it "works". But i=
t
assumes that the "struct page *" input value is good, and that Linux has a =
valid
virtual-to-physical direct mapping for the physical memory represented by
that input value. Unfortunately, that assumption might not always be true. =
I
think it works most of the time because Linux uses huge page mappings for
the direct map, and they may extend far enough beyond the root partition's
actual memory to cover this hypervisor page. Or maybe there's something
else going on that I'm not aware of and that allows the current code to wor=
k.
So please check my thinking.

The robust fix is to do like hv_synic_enable_regs(), where a page returned
by the hypervisor/paravisor is explicitly mapped in order to have a valid
virtual address in the root partition Linux.

Note that on ARM64, when CONFIG_DEBUG_VIRTUAL is set to catch errors
like this, page_to_virt() does additional checks on its input value, and wo=
uld
generate a WARN_ON() in this case. x86/x64 does not do the additional check=
s.

Michael

>=20
> >
> > >> +		}
> > >> +
> > >> +		status =3D hv_do_hypercall(HVCALL_MAP_VP_STATE_PAGE, input,
> > >> +					 output);
> > >>
> > >>  		if (hv_result(status) !=3D HV_STATUS_INSUFFICIENT_MEMORY) {
> > >>  			if (hv_result_success(status))

