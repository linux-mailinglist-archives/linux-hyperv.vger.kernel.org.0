Return-Path: <linux-hyperv+bounces-7049-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BBBBBB218C
	for <lists+linux-hyperv@lfdr.de>; Thu, 02 Oct 2025 02:03:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1214D19C11A1
	for <lists+linux-hyperv@lfdr.de>; Thu,  2 Oct 2025 00:03:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60306A55;
	Thu,  2 Oct 2025 00:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="IeDqkWtf"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazolkn19013064.outbound.protection.outlook.com [52.103.20.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DAFB45038;
	Thu,  2 Oct 2025 00:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.20.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759363379; cv=fail; b=EPVEJos0pa8Im0Akl29udu9ALYF1QPHWIFhY4khBT4hC11OdpB/mF+izpttIC+mnotp3poj4Q1UWIRC+lKfyDIF608tCt0mwy/JRS04FIjjBqfjuWrIVlMgjIoBUNj0BsEOvW0Opatl09pGMqbnDYHY3K/NAXib5xNVW5s7VLOA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759363379; c=relaxed/simple;
	bh=2Sz3lmH3BDaX/BGswfIuOpG3WWCogIAezEZprc02ZLI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Dnz5fyZ9ngmSbGyAxF+ZwlZKaDMTvOl/sQuYs/KHeKdGSuxi4itCrB+MnH4UFCOuhMTOY2PgUtjhl+BGPvsOMdqWtcEOb+J6Q/5SxAEKqXRG1QXPqSHx81mlce0jBvTmmQO6Ovu84fJLq0eQBi83GznP/SC9XTqR7VBJ+SdtZDs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=IeDqkWtf; arc=fail smtp.client-ip=52.103.20.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F+6zSv0LzGoL8ynboZEBFq2O/mApoJKN7Zhf/b9CwiIcNJOXQFhTLIOarFj2cI5OGKEzX42ADyWk91fMZ++tPI9z1C2CPLTOF2kL1z3gAhv5ooQQe5wuNB2g+OVnxAK/cJJ1eFO6r4t1RxqklOe1GI3msK0TEUAvzM/p6ljy9duJCdTV2G5ztISr2qAC7ANVkAxF1vp3ezCrl+faix+aXruWmvg8v/5E7/ukQizniWLxFI7BDBSLIdiHDgqiu2RmgS3exdLGUb59c997RSbWzwIAUQP7HX4sNCmg11RV9PVKZqfa5DT44P8yp1BHDmW3ENtWdjY0tY8yBko/G4jxzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yXQ9E03Ve0ICxqan8uchEhKqcE8aYqa8HWG0KGxXioA=;
 b=M86Iq7OZG2dUocKSvMbV6rQcXUGkLXrGoPceISpEKqAe6Nyy7IssNQMiLjMyCTvd0axj4haFSWxVy8YrBzpH7Q8Xdt2YzoqZKVLJ4Z3oWrJ6br34oWIuChiilixQrwKaW+9lhtq7fe+l2TQY1YBiJW3p2RDkyWIOQkoPvISLKsltNRKHPHeM4Gf0+U1msZf+H07xvgdsRdPeANDKYf7Fta5RIC2CXyhASSq9qpiiZNuSbaa7n4RtAtYfMNBQMNQsyH6KjQjV71TJbs5rwfa56F0je5adffGHAjVEOmv/DL7XU5Bh9mhJFtQkNElahAcn6KzF3QtfC6U+C8mkCOs7Qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yXQ9E03Ve0ICxqan8uchEhKqcE8aYqa8HWG0KGxXioA=;
 b=IeDqkWtfLwanZoaAlHlMVWByAEdbomdzkohW34w7O8VGiPB9pyB6TC+vZKuonTv0l+K9EWeXn1LR5ydrHGhU7yNZDoVliwJJOWrxtNeu1KpdQX8/o7lCZ4bCxDiuk9TG7LJWWfNPpy3PV16/D1Ogv0w8LQC5TI1H0KvH702m+GAmGGClYbz9XHbkKDZ/2dN5gSWIkq7O4P47SwT2ACpzthKlWOGXgzTpc+Rwt+u0ok/NArMl7H3h2f9WQf5XrETa1eedi1M+odZa9AAGassU8cJw3EmnzIBeLeiMxFDuvZPYmJtfuugm7YiJf15wTaVlWVQvpOegD8zsnEqIVNEgOQ==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by MW6PR02MB9820.namprd02.prod.outlook.com (2603:10b6:303:23c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.17; Thu, 2 Oct
 2025 00:02:53 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%3]) with mapi id 15.20.9160.017; Thu, 2 Oct 2025
 00:02:53 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Nuno Das Neves <nunodasneves@linux.microsoft.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"prapal@linux.microsoft.com" <prapal@linux.microsoft.com>,
	"easwar.hariharan@linux.microsoft.com"
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
Thread-Index: AQHcLwIJ67Rvwcf9OU+03OvTNyRllLSqZUqQgAOJ8ICAAAQZoA==
Date: Thu, 2 Oct 2025 00:02:53 +0000
Message-ID:
 <SN6PR02MB4157BB0D3B4B8A616C8B2E29D4E7A@SN6PR02MB4157.namprd02.prod.outlook.com>
References:
 <1758903795-18636-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1758903795-18636-5-git-send-email-nunodasneves@linux.microsoft.com>
 <SN6PR02MB4157E95BDC70A1F91228DAF7D41BA@SN6PR02MB4157.namprd02.prod.outlook.com>
 <8bacde85-6406-4b47-b11d-ed5054b270f2@linux.microsoft.com>
In-Reply-To: <8bacde85-6406-4b47-b11d-ed5054b270f2@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|MW6PR02MB9820:EE_
x-ms-office365-filtering-correlation-id: 9f115ef6-9788-40f8-b3d3-08de0147089a
x-microsoft-antispam:
 BCL:0;ARA:14566002|12121999013|31061999003|461199028|15080799012|41001999006|13091999003|8062599012|19110799012|8060799015|40105399003|440099028|3412199025|102099032|12091999003;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?iwxuEy0iqdCoPHgABEpQ40UGoNJfJnOiOZIWndGvM1EmwLLGi7ymtOMbCcmn?=
 =?us-ascii?Q?G72ZHtIg4w5Gz+MXXVQR4NgnocsSoJFKKdzluDz7ec2NKN2fBzlYTCSlx7xe?=
 =?us-ascii?Q?EdySQRtRtc8BzVTUSQFI/BccX7Hg/yLL3Ifh7dT65b7yvgHWBYQloqEL5+nS?=
 =?us-ascii?Q?CruZZpfWWNtYEv6e0I+caetbchaFsnmWXZ6hwl5uHjoXiJrqwxToqLo+QhxV?=
 =?us-ascii?Q?FLkWMaZo9sXuHCfBcDYtww4mohBA3fYUVWQ8cueNIDCcpuRSuca5JpNCjdO4?=
 =?us-ascii?Q?A5CEigwAmpCVOz82IoXp+m5M1gNpgQZgtUSYjH2+s+GfFkMfUin8O+8dd3eQ?=
 =?us-ascii?Q?82KLM/AkQ8/iUPkL4L9pkgExeyPwIT+uj+SjyqVEh0WdPB9QNIerhZ3dK+QQ?=
 =?us-ascii?Q?1mWAR1JmGkUl9CrqtjBEFsHu+6mfk5juyApLAt1lazBThT7X1GL2goK0/jSu?=
 =?us-ascii?Q?CASKqcmLgea+tn1ebjuZ/0Cnudr+XJba0bUsiVke7Ks8FUYx97CMA5rRJDQ/?=
 =?us-ascii?Q?4pB91s0QOClN9VIXPcfD2V0G/JSbjNqxcebaMgYLmodvsMEtmHq3INX51qmO?=
 =?us-ascii?Q?8P9FBbypWvPJ85eoeclmJ86opa2/GBewj06vlqNIroEj0mH3lbkDXCcQW8x/?=
 =?us-ascii?Q?wRPMVq6RzEmpRsq4vJARAY6eUCaay0yJhWtVftM01CXXA3Mbe+9d0UyAc6fN?=
 =?us-ascii?Q?RYzd6y/uRvOUGi6I/rx2C8zoghxLVgkE8XEH5HLXGxdo/7qDaGO1Wz+AJ7Bf?=
 =?us-ascii?Q?3eaZ7RSp2VYzrmPSi5S1hLvi+BJLq/0NEdGLFMF2JKFcKAKdGmOJXpyO8LC7?=
 =?us-ascii?Q?uQ+FxwpT6/hJSvtH2hyjwYjpswhUJSgzzVXaWlhyIz1M2xwZMNxbAjB2g5qx?=
 =?us-ascii?Q?BiOsNDb2Su5g0mEyHbeFAZugLb8bBek9lTaaibwrgE0uRxn/Hb+N1RCKnUg1?=
 =?us-ascii?Q?I0ontwA6meoyyQhbw2aQU1O1chFF978iV0TEp9PYd1Z0/z3+ONyJusx4Az1e?=
 =?us-ascii?Q?z8PnvWvx1pC7zrTwluCroYE5ie2Tdc4FYxxaMZSZnZenFfPrxrjSzoT8VxgL?=
 =?us-ascii?Q?rpZ1HnMQHvwWWnlJSbG87JqdYIpG8XAxcbCkQfzJ6keetHoEPK+90Rxxn9oe?=
 =?us-ascii?Q?IUXS0ONgP7k2dSGKXhGWPYJi9GFQXAB+gHzaV7mIIQxBOAVdYtBsGMfNCQcI?=
 =?us-ascii?Q?jwzdaP2YLFg8TbaKQE8GKAywvCwSHBRJgLr1noEpt6RMkCB7hE9n84B4z1Mc?=
 =?us-ascii?Q?0odPbJzjErWBcTSMNjzZEQT74mQCINfaTfGXkV7ZeA=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?uRMjF2ou8VnCzg5Lc45aNA0aEZaRbLW3oCo/4SVnNu3QUj6mqaBqH0SFNVdv?=
 =?us-ascii?Q?KdpA/o69tcSxXFl8CyJJmKbnWTH9VL9UO5xpdvcDunPV695znZyPMeeuNx93?=
 =?us-ascii?Q?o+0nS33Pz+mHDe1cxcqZpgnnUJ+AJjZyaMuERRpzEmZ4WMTkFB4Ofkr2rySJ?=
 =?us-ascii?Q?6e1v6FbW/o+IEYzQo/CRYXCo5XLMQoSMHKugCFPRcFojQ4mPAR+ZKE7KB2kA?=
 =?us-ascii?Q?bzv8yCu2YIJ0Wel/8drlUJoCN4Ra77peYCmmLj+reToQiH17KeW88A+3LLTR?=
 =?us-ascii?Q?c8uwfCfYq42ahsHvaVNGskCDWlKu3JFzo/xtMtRNdq8s28Mkeuko7ycG8QkB?=
 =?us-ascii?Q?xtJ/oOp4o9xdOvfrGiYVO4plaT5v7/fSe8ep8QdAZz62kkXLnU4ZlJhgjoC2?=
 =?us-ascii?Q?jpyunDC6Cgkq9JAg1/deujR3AuijbeCD4CUhK27uOxLDixHX3DHFHC9MEznW?=
 =?us-ascii?Q?ZEiBtkhEdOPcFYVz5BkA3ROm8aBnCbVxaazm9L2BAKIAvuj4MMb6WaScxiWF?=
 =?us-ascii?Q?n4uJaGthrPm9IAVB9riWi28nwNSdAxZf7xy//Xr33iuIM9FKSz45hlCdkp2I?=
 =?us-ascii?Q?at3/aj0j1bDpNIcNJV91vLOhBqZ8NByghIvMDyKB776wkmW1dmkH0y13+xlT?=
 =?us-ascii?Q?vXQp+A3cmX6myuY40Yu9CzLuP05DjyOFAVNQ4RDniteqwW2hxU1ZrJQqEB6j?=
 =?us-ascii?Q?y++yCPaJDHYpAVBwxjkQm3VQe42zwfn0oQq7+DPhPEKpOYn9dbkmQy457XZJ?=
 =?us-ascii?Q?Lyn8cd1noXLkmkXbG4m1glpqVMK6iiR/IxMgM+g9xGLqEHozY0+QcEjOlYzS?=
 =?us-ascii?Q?rgrAtD/qmXMcf2Zdg5+psh9+nMu8h6VA+VH1YkaxT7eNAC7ZZo8qrnK34fym?=
 =?us-ascii?Q?h8bPH03+akxlKT2iEdd+2XZMq7TmNMEHwDb7OjDcV1sHMf+YdQZZm/7pN5N6?=
 =?us-ascii?Q?hG9RdtbXPmbKp1MeUWEPuOWV36v+5qqIjIQhXjFnxlEW0leuUc/3DDbjO1vF?=
 =?us-ascii?Q?/LkhWbHNrVhZ/cyGcPeQRRuEm9pHQOdWtQRwrL/K82R9o2DV9GDVqmq3M2ve?=
 =?us-ascii?Q?u1fi3PhGnQBLytHDLXihB6BoP9fP0JAL2F5ARtlR9lQXvDi/385ktEB5Jb0b?=
 =?us-ascii?Q?n8O2/St+XcgEHeKwpYukax+mJL0ZOVYcV6Oworc4vr1E7TEMtNWSNgUQZ2OU?=
 =?us-ascii?Q?QF33UP6//ryHdOvb9HjAaw++dAxYkiNhhHYXc47Y0F0JVS/6I5CDdKbGgmc?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f115ef6-9788-40f8-b3d3-08de0147089a
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Oct 2025 00:02:53.1699
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR02MB9820

From: Nuno Das Neves <nunodasneves@linux.microsoft.com> Sent: Wednesday, Oc=
tober 1, 2025 3:56 PM
>=20
> On 9/29/2025 10:56 AM, Michael Kelley wrote:
> > From: Nuno Das Neves <nunodasneves@linux.microsoft.com> Sent: Friday, S=
eptember 26, 2025 9:23 AM
> >>
> >> From: Jinank Jain <jinankjain@linux.microsoft.com>
> >>
> >> Introduce mshv_use_overlay_gpfn() to check if a page needs to be
> >> allocated and passed to the hypervisor to map VP state pages. This is
> >> only needed on L1VH, and only on some (newer) versions of the
> >> hypervisor, hence the need to check vmm_capabilities.
> >>
> >> Introduce functions hv_map/unmap_vp_state_page() to handle the
> >> allocation and freeing.
> >>
> >> Signed-off-by: Jinank Jain <jinankjain@linux.microsoft.com>
> >> Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
> >> Reviewed-by: Praveen K Paladugu <prapal@linux.microsoft.com>
> >> Reviewed-by: Easwar Hariharan <easwar.hariharan@linux.microsoft.com>
> >> Reviewed-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
> >> Reviewed-by: Anirudh Rayabharam <anirudh@anirudhrb.com>
> >> ---
> >>  drivers/hv/mshv_root.h         | 11 ++---
> >>  drivers/hv/mshv_root_hv_call.c | 61 ++++++++++++++++++++++++---
> >>  drivers/hv/mshv_root_main.c    | 76 +++++++++++++++++----------------=
-
> >>  3 files changed, 98 insertions(+), 50 deletions(-)
> >>
> >> diff --git a/drivers/hv/mshv_root.h b/drivers/hv/mshv_root.h
> >> index 0cb1e2589fe1..dbe2d1d0b22f 100644
> >> --- a/drivers/hv/mshv_root.h
> >> +++ b/drivers/hv/mshv_root.h
> >> @@ -279,11 +279,12 @@ int hv_call_set_vp_state(u32 vp_index, u64 parti=
tion_id,
> >>  			 /* Choose between pages and bytes */
> >>  			 struct hv_vp_state_data state_data, u64 page_count,
> >>  			 struct page **pages, u32 num_bytes, u8 *bytes);
> >> -int hv_call_map_vp_state_page(u64 partition_id, u32 vp_index, u32 typ=
e,
> >> -			      union hv_input_vtl input_vtl,
> >> -			      struct page **state_page);
> >> -int hv_call_unmap_vp_state_page(u64 partition_id, u32 vp_index, u32 t=
ype,
> >> -				union hv_input_vtl input_vtl);
> >> +int hv_map_vp_state_page(u64 partition_id, u32 vp_index, u32 type,
> >> +			 union hv_input_vtl input_vtl,
> >> +			 struct page **state_page);
> >> +int hv_unmap_vp_state_page(u64 partition_id, u32 vp_index, u32 type,
> >> +			   struct page *state_page,
> >> +			   union hv_input_vtl input_vtl);
> >>  int hv_call_create_port(u64 port_partition_id, union hv_port_id port_=
id,
> >>  			u64 connection_partition_id, struct hv_port_info *port_info,
> >>  			u8 port_vtl, u8 min_connection_vtl, int node);
> >> diff --git a/drivers/hv/mshv_root_hv_call.c b/drivers/hv/mshv_root_hv_=
call.c
> >> index 3fd3cce23f69..98c6278ff151 100644
> >> --- a/drivers/hv/mshv_root_hv_call.c
> >> +++ b/drivers/hv/mshv_root_hv_call.c
> >> @@ -526,9 +526,9 @@ int hv_call_set_vp_state(u32 vp_index, u64 partiti=
on_id,
> >>  	return ret;
> >>  }
> >>
> >> -int hv_call_map_vp_state_page(u64 partition_id, u32 vp_index, u32 typ=
e,
> >> -			      union hv_input_vtl input_vtl,
> >> -			      struct page **state_page)
> >> +static int hv_call_map_vp_state_page(u64 partition_id, u32 vp_index, =
u32 type,
> >> +				     union hv_input_vtl input_vtl,
> >> +				     struct page **state_page)
> >>  {
> >>  	struct hv_input_map_vp_state_page *input;
> >>  	struct hv_output_map_vp_state_page *output;
> >> @@ -547,7 +547,14 @@ int hv_call_map_vp_state_page(u64 partition_id, u=
32
> vp_index, u32 type,
> >>  		input->type =3D type;
> >>  		input->input_vtl =3D input_vtl;
> >>
> >> -		status =3D hv_do_hypercall(HVCALL_MAP_VP_STATE_PAGE, input, output)=
;
> >
> > This function must zero the input area before using it. Otherwise,
> > flags.map_location_provided is uninitialized when *state_page is NULL. =
It will
> > have whatever value was left by the previous user of hyperv_pcpu_input_=
arg,
> > potentially producing bizarre results. And there's a reserved field tha=
t won't be
> > set to zero.
> >
> Good catch, will add a memset().
>=20
> >> +		if (*state_page) {
> >> +			input->flags.map_location_provided =3D 1;
> >> +			input->requested_map_location =3D
> >> +				page_to_pfn(*state_page);
> >
> > Technically, this should be page_to_hvpfn() since the PFN value is bein=
g sent to
> > Hyper-V. I know root (and L1VH?) partitions must run with the same page=
 size
> > as the Hyper-V host, but it's better to not leave code buried here that=
 will blow
> > up if the "same page size requirement" should ever change.
> >
> Good point...I could change these calls, but the other way doesn't work, =
see below.
>=20
> > And after making the hypercall, there's an invocation of pfn_to_page(),=
 which
> > should account for the same. Unfortunately, there's not an existing hvp=
fn_to_page()
> > function.
> >
> This seems like a tricky scenario to get right. In the root partition cas=
e, the
> hypervisor allocates the page. That pfn could be some page within a large=
r Linux page.
> Converting that to a Linux pfn (naively) means losing the original hvpfn =
since it gets
> truncated, which is no good if we want to unmap it later. Also page_addre=
ss() would
> give the wrong virtual address.
>=20
> In other words, we'd have to completely change how we track these pages i=
n order to
> support this scenario, and the same goes for various other hypervisor API=
s where the
> hypervisor does the allocating. I think it's out of scope to try and addr=
ess that
> here, even in part, especially since we will be making assumptions about =
something
> that may never happen.

OK, yes the hypervisor allocating the page is a problem when Linux tracks i=
t
as a struct page. I'll agree it's out of current scope to change this.

It makes me think about hv_synic_enable_regs() where the paravisor or hyper=
visor
allocates the synic_message_page and synic_event_page. But that case should=
 work
OK with a regular guest with page size greater than 4K because the pages ar=
e tracked
based on the guest kernel virtual address, not the PFN. So hv_synic_enable_=
regs()
should work on ARM64 Linux guests with 64K page size and a paravisor, as we=
ll as
for my postulated root partition with page size greater than 4K.

When it matters, cases where the hypervisor or paravisor allocate pages to =
give
to the guest will require careful handling to ensure they work for guest pa=
ge sizes
greater than 4K. That's useful information for future consideration. Thanks=
 for the
discussion.

Michael

>=20
> >> +		}
> >> +
> >> +		status =3D hv_do_hypercall(HVCALL_MAP_VP_STATE_PAGE, input,
> >> +					 output);
> >>
> >>  		if (hv_result(status) !=3D HV_STATUS_INSUFFICIENT_MEMORY) {
> >>  			if (hv_result_success(status))
> >> @@ -565,8 +572,39 @@ int hv_call_map_vp_state_page(u64 partition_id, u=
32 vp_index, u32 type,
> >>  	return ret;
> >>  }
> >>
> >> -int hv_call_unmap_vp_state_page(u64 partition_id, u32 vp_index, u32 t=
ype,
> >> -				union hv_input_vtl input_vtl)
> >> +static bool mshv_use_overlay_gpfn(void)
> >> +{
> >> +	return hv_l1vh_partition() &&
> >> +	       mshv_root.vmm_caps.vmm_can_provide_overlay_gpfn;
> >> +}
> >> +
> >> +int hv_map_vp_state_page(u64 partition_id, u32 vp_index, u32 type,
> >> +			 union hv_input_vtl input_vtl,
> >> +			 struct page **state_page)
> >> +{
> >> +	int ret =3D 0;
> >> +	struct page *allocated_page =3D NULL;
> >> +
> >> +	if (mshv_use_overlay_gpfn()) {
> >> +		allocated_page =3D alloc_page(GFP_KERNEL);
> >> +		if (!allocated_page)
> >> +			return -ENOMEM;
> >> +		*state_page =3D allocated_page;
> >> +	} else {
> >> +		*state_page =3D NULL;
> >> +	}
> >> +
> >> +	ret =3D hv_call_map_vp_state_page(partition_id, vp_index, type, inpu=
t_vtl,
> >> +					state_page);
> >> +
> >> +	if (ret && allocated_page)
> >> +		__free_page(allocated_page);
> >
> > For robustness, you might want to set *state_page =3D NULL here so the
> > caller doesn't have a reference to the page that has been freed. I didn=
't
> > see any cases where the caller incorrectly checks the returned
> > *state_page value after an error, so the current code isn't broken.
> >
> Sure, I can add it.
>=20
> >> +
> >> +	return ret;
> >> +}
> >> +
> >> +static int hv_call_unmap_vp_state_page(u64 partition_id, u32 vp_index=
, u32 type,
> >> +				       union hv_input_vtl input_vtl)
> >>  {
> >>  	unsigned long flags;
> >>  	u64 status;
> >> @@ -590,6 +628,17 @@ int hv_call_unmap_vp_state_page(u64 partition_id,=
 u32 vp_index, u32 type,
> >>  	return hv_result_to_errno(status);
> >>  }
> >>
> >> +int hv_unmap_vp_state_page(u64 partition_id, u32 vp_index, u32 type,
> >> +			   struct page *state_page, union hv_input_vtl input_vtl)
> >> +{
> >> +	int ret =3D hv_call_unmap_vp_state_page(partition_id, vp_index, type=
, input_vtl);
> >> +
> >> +	if (mshv_use_overlay_gpfn() && state_page)
> >> +		__free_page(state_page);
> >> +
> >> +	return ret;
> >> +}
> >> +
> >>  int hv_call_get_partition_property_ex(u64 partition_id, u64 property_=
code,
> >>  				      u64 arg, void *property_value,
> >>  				      size_t property_value_sz)
> >> diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
> >> index e199770ecdfa..2d0ad17acde6 100644
> >> --- a/drivers/hv/mshv_root_main.c
> >> +++ b/drivers/hv/mshv_root_main.c
> >> @@ -890,7 +890,7 @@ mshv_partition_ioctl_create_vp(struct mshv_partiti=
on
> >> *partition,
> >>  {
> >>  	struct mshv_create_vp args;
> >>  	struct mshv_vp *vp;
> >> -	struct page *intercept_message_page, *register_page, *ghcb_page;
> >> +	struct page *intercept_msg_page, *register_page, *ghcb_page;
> >>  	void *stats_pages[2];
> >>  	long ret;
> >>
> >> @@ -908,28 +908,25 @@ mshv_partition_ioctl_create_vp(struct mshv_parti=
tion *partition,
> >>  	if (ret)
> >>  		return ret;
> >>
> >> -	ret =3D hv_call_map_vp_state_page(partition->pt_id, args.vp_index,
> >> -					HV_VP_STATE_PAGE_INTERCEPT_MESSAGE,
> >> -					input_vtl_zero,
> >> -					&intercept_message_page);
> >> +	ret =3D hv_map_vp_state_page(partition->pt_id, args.vp_index,
> >> +				   HV_VP_STATE_PAGE_INTERCEPT_MESSAGE,
> >> +				   input_vtl_zero, &intercept_msg_page);
> >>  	if (ret)
> >>  		goto destroy_vp;
> >>
> >>  	if (!mshv_partition_encrypted(partition)) {
> >> -		ret =3D hv_call_map_vp_state_page(partition->pt_id, args.vp_index,
> >> -						HV_VP_STATE_PAGE_REGISTERS,
> >> -						input_vtl_zero,
> >> -						&register_page);
> >> +		ret =3D hv_map_vp_state_page(partition->pt_id, args.vp_index,
> >> +					   HV_VP_STATE_PAGE_REGISTERS,
> >> +					   input_vtl_zero, &register_page);
> >>  		if (ret)
> >>  			goto unmap_intercept_message_page;
> >>  	}
> >>
> >>  	if (mshv_partition_encrypted(partition) &&
> >>  	    is_ghcb_mapping_available()) {
> >> -		ret =3D hv_call_map_vp_state_page(partition->pt_id, args.vp_index,
> >> -						HV_VP_STATE_PAGE_GHCB,
> >> -						input_vtl_normal,
> >> -						&ghcb_page);
> >> +		ret =3D hv_map_vp_state_page(partition->pt_id, args.vp_index,
> >> +					   HV_VP_STATE_PAGE_GHCB,
> >> +					   input_vtl_normal, &ghcb_page);
> >>  		if (ret)
> >>  			goto unmap_register_page;
> >>  	}
> >> @@ -960,7 +957,7 @@ mshv_partition_ioctl_create_vp(struct mshv_partiti=
on *partition,
> >>  	atomic64_set(&vp->run.vp_signaled_count, 0);
> >>
> >>  	vp->vp_index =3D args.vp_index;
> >> -	vp->vp_intercept_msg_page =3D page_to_virt(intercept_message_page);
> >> +	vp->vp_intercept_msg_page =3D page_to_virt(intercept_msg_page);
> >>  	if (!mshv_partition_encrypted(partition))
> >>  		vp->vp_register_page =3D page_to_virt(register_page);
> >>
> >> @@ -993,21 +990,19 @@ mshv_partition_ioctl_create_vp(struct mshv_parti=
tion *partition,
> >>  	if (hv_scheduler_type =3D=3D HV_SCHEDULER_TYPE_ROOT)
> >>  		mshv_vp_stats_unmap(partition->pt_id, args.vp_index);
> >>  unmap_ghcb_page:
> >> -	if (mshv_partition_encrypted(partition) && is_ghcb_mapping_available=
()) {
> >> -		hv_call_unmap_vp_state_page(partition->pt_id, args.vp_index,
> >> -					    HV_VP_STATE_PAGE_GHCB,
> >> -					    input_vtl_normal);
> >> -	}
> >> +	if (mshv_partition_encrypted(partition) && is_ghcb_mapping_available=
())
> >> +		hv_unmap_vp_state_page(partition->pt_id, args.vp_index,
> >> +				       HV_VP_STATE_PAGE_GHCB, ghcb_page,
> >> +				       input_vtl_normal);
> >>  unmap_register_page:
> >> -	if (!mshv_partition_encrypted(partition)) {
> >> -		hv_call_unmap_vp_state_page(partition->pt_id, args.vp_index,
> >> -					    HV_VP_STATE_PAGE_REGISTERS,
> >> -					    input_vtl_zero);
> >> -	}
> >> +	if (!mshv_partition_encrypted(partition))
> >> +		hv_unmap_vp_state_page(partition->pt_id, args.vp_index,
> >> +				       HV_VP_STATE_PAGE_REGISTERS,
> >> +				       register_page, input_vtl_zero);
> >>  unmap_intercept_message_page:
> >> -	hv_call_unmap_vp_state_page(partition->pt_id, args.vp_index,
> >> -				    HV_VP_STATE_PAGE_INTERCEPT_MESSAGE,
> >> -				    input_vtl_zero);
> >> +	hv_unmap_vp_state_page(partition->pt_id, args.vp_index,
> >> +			       HV_VP_STATE_PAGE_INTERCEPT_MESSAGE,
> >> +			       intercept_msg_page, input_vtl_zero);
> >>  destroy_vp:
> >>  	hv_call_delete_vp(partition->pt_id, args.vp_index);
> >>  	return ret;
> >> @@ -1748,24 +1743,27 @@ static void destroy_partition(struct mshv_part=
ition *partition)
> >>  				mshv_vp_stats_unmap(partition->pt_id, vp->vp_index);
> >>
> >>  			if (vp->vp_register_page) {
> >> -				(void)hv_call_unmap_vp_state_page(partition->pt_id,
> >> -								  vp->vp_index,
> >> -								  HV_VP_STATE_PAGE_REGISTERS,
> >> -								  input_vtl_zero);
> >> +				(void)hv_unmap_vp_state_page(partition->pt_id,
> >> +							     vp->vp_index,
> >> +							     HV_VP_STATE_PAGE_REGISTERS,
> >> +							     virt_to_page(vp->vp_register_page),
> >> +							     input_vtl_zero);
> >>  				vp->vp_register_page =3D NULL;
> >>  			}
> >>
> >> -			(void)hv_call_unmap_vp_state_page(partition->pt_id,
> >> -							  vp->vp_index,
> >> -							  HV_VP_STATE_PAGE_INTERCEPT_MESSAGE,
> >> -							  input_vtl_zero);
> >> +			(void)hv_unmap_vp_state_page(partition->pt_id,
> >> +						     vp->vp_index,
> >> +						     HV_VP_STATE_PAGE_INTERCEPT_MESSAGE,
> >> +						     virt_to_page(vp->vp_intercept_msg_page),
> >> +						     input_vtl_zero);
> >>  			vp->vp_intercept_msg_page =3D NULL;
> >>
> >>  			if (vp->vp_ghcb_page) {
> >> -				(void)hv_call_unmap_vp_state_page(partition->pt_id,
> >> -								  vp->vp_index,
> >> -								  HV_VP_STATE_PAGE_GHCB,
> >> -								  input_vtl_normal);
> >> +				(void)hv_unmap_vp_state_page(partition->pt_id,
> >> +							     vp->vp_index,
> >> +							     HV_VP_STATE_PAGE_GHCB,
> >> +							     virt_to_page(vp->vp_ghcb_page),
> >> +							     input_vtl_normal);
> >>  				vp->vp_ghcb_page =3D NULL;
> >>  			}
> >>
> >> --
> >> 2.34.1
> >>


