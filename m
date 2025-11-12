Return-Path: <linux-hyperv+bounces-7520-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84EB3C518BD
	for <lists+linux-hyperv@lfdr.de>; Wed, 12 Nov 2025 11:05:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26D373A2596
	for <lists+linux-hyperv@lfdr.de>; Wed, 12 Nov 2025 09:44:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C5A02FD7D8;
	Wed, 12 Nov 2025 09:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="V2/Sz8c+"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazolkn19010045.outbound.protection.outlook.com [52.103.7.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3D09221282;
	Wed, 12 Nov 2025 09:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.7.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762940665; cv=fail; b=Uq0nzuFHpaPVz23F5MTyFf0LA1qqhp8eERP3hZXP9wqY/dISp5h5QaV8l5AOTc5Dn/s8sZDnYZ8loVa9mlYggkkxixJrYpIoO1wzpwodBSi2PikM96mEreBJHh1vs0Rr/vHU9eVpvoL/nKjtSaW4hJaEYTh7lwSkeNg9edkniXM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762940665; c=relaxed/simple;
	bh=4k9zsFDiu50/ug74JxDe7IFdvmwCO66ihtKm4FQMQP4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WYnsvcyqabKrzUIvcwfU5api/h46i0jC+/Pq9J3RwWp0nFof/k3I5fuK7riQCY4B9aLsebugqNT4Fhw9XYrQhDBGsC+9hiGItl2/IF3Ol15TtdD5gSUjKj0ltf5jzksrhM7jZnnfl6zjmdu7uZ7iMjaMjWWnBnau4vKoEKHWWoo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=V2/Sz8c+; arc=fail smtp.client-ip=52.103.7.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nl9fvE5woS//iNaXpYhyfnS5nDOh9qMCmAxWnCwyCFxmrqhiTZ4z8C92aHhfkkgS3LpzssCRvZbrTbkILrxkyZDfwXDDok4sw1oBpRMBrdnTAdA+Jjfms6j0brQmxEdEN5VZ5k5AYdZq2Voe9kdrGt0L+LKndeLl/SRzgidlFIoWN6eaBdMkmTBush08LkPiUBfqIfK8HFYMa5m4QskNCgc5VTDESPAZszshyJ2vYZUr7xjDqBdLqLtnGQ627ABiajPX8U2Cub/XkIuyfR6QwEOdTPmrALLXOuTQam9/NMrwm4+2J0Vwsy9qDAigveBK7Owm96sh/IvORrYrEbPYAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o2k/YCq+sI3G6OOlW0VLfnVTIunPtlnrwzN38GsyDow=;
 b=kr3pZzyO7ohtFiDDDIFp5ahY5CsXXvOfjq4z7N8PI0db44xeh0/JjDTBh1gE7e03CHMuBHxdnRuVTH+8N83Yu3/tS9AvZXCL/5lX7oji5BmNsB4+gebSNb4VRrhgcTPdTLXhOhyXhw+Wt98ReCkTz7o9y6YAHZ+9qpC7tcJkLb97h0Yppglne+nQzL3SGQHxIpJOckI8OoYKoZP6dsycI0l3B5ekJyAO1GaWAL5hOZwcs+UrhNE33bUgYDTP/hW81MgZo+1xqXd07XQEPb8EvdB4cn8GupM7NCwBKhWdNZ6GdYBLYEQiVla4nn5vJsMuQ4hB+CDXPyiij9txYTJzCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o2k/YCq+sI3G6OOlW0VLfnVTIunPtlnrwzN38GsyDow=;
 b=V2/Sz8c+H6PihIvlhKTSque547DvSuaEQyXEEbSEtljyGNa6BUVlNmQJzxhOZJXO/kkgM4eFQE0DV1Mh6IFPVlvYAOU/Ukf0ug8tCybWelA3MYGd3GJvzslX8O2ycjO6oOZS8SU7F42mvW6sBBuBlofq1mzz1Tno9igUnXBtYfITlZCroyoeQmiRcXGuQ8eyLaGHlHJhEWq+xT+4Pm2fgRquz4VpYcRZAPQzGF3D+E9ERxRIeVSLcw0mL/ZgBlyUzKf3RlGVLpDMFCPlIYE1pnk3yRfE+00FNbIsnyZie+lNIGBdpH3tplB8NesTSC1UP+AStiBF3xKc4ccz2eh5Zg==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by LV3PR02MB10149.namprd02.prod.outlook.com (2603:10b6:408:199::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.15; Wed, 12 Nov
 2025 09:44:20 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%2]) with mapi id 15.20.9320.013; Wed, 12 Nov 2025
 09:44:20 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Peter Zijlstra <peterz@infradead.org>
CC: Naman Jain <namjain@linux.microsoft.com>, Paolo Bonzini
	<pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>, "K . Y .
 Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei
 Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, Thomas Gleixner
	<tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
	<bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, "H . Peter Anvin"
	<hpa@zytor.com>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>, Mukesh
 Rathor <mrathor@linux.microsoft.com>, Stanislav Kinsburskii
	<skinsburskii@linux.microsoft.com>, Nuno Das Neves
	<nunodasneves@linux.microsoft.com>, Christoph Hellwig <hch@infradead.org>,
	Saurabh Sengar <ssengar@linux.microsoft.com>, ALOK TIWARI
	<alok.a.tiwari@oracle.com>
Subject: RE: [PATCH v11 2/2] Drivers: hv: Introduce mshv_vtl driver
Thread-Topic: [PATCH v11 2/2] Drivers: hv: Introduce mshv_vtl driver
Thread-Index:
 AQHcUgAiXalk7wQI00S6ZbuisOapqrTr+2EAgAEREQCAABXIAIABTGhAgABdLACAAAB0EA==
Date: Wed, 12 Nov 2025 09:44:20 +0000
Message-ID:
 <SN6PR02MB4157F3F565621B32AC29EC92D4CCA@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20251110050835.1603847-1-namjain@linux.microsoft.com>
 <20251110050835.1603847-3-namjain@linux.microsoft.com>
 <20251110143834.GA3245006@noisy.programming.kicks-ass.net>
 <f32292e6-b152-4d6d-b678-fc46b8e3d1ac@linux.microsoft.com>
 <20251111081352.GD278048@noisy.programming.kicks-ass.net>
 <SN6PR02MB4157C399DB7624C28D0860AAD4CCA@SN6PR02MB4157.namprd02.prod.outlook.com>
 <20251112093704.GC4067720@noisy.programming.kicks-ass.net>
In-Reply-To: <20251112093704.GC4067720@noisy.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|LV3PR02MB10149:EE_
x-ms-office365-filtering-correlation-id: c6233701-3b62-4866-7ee9-08de21d00e12
x-microsoft-antispam:
 BCL:0;ARA:14566002|8022599003|19110799012|15080799012|41001999006|8062599012|8060799015|31061999003|461199028|13091999003|440099028|3412199025|102099032;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?TBjKQo7QOb/qkXUScCH2C4cs6KkDhw0u/6j8b4+eb24aNeqqg2eHxNcea6xH?=
 =?us-ascii?Q?J7lecqLMK9mVk58AgWJKYCWjdsib+QPkrxMuLhyUujYvOcUzpzV0iMddnEbF?=
 =?us-ascii?Q?1EUL/19l8WFauKKyvpVgloy54hDzaeC+pqXoSFOr6OjGZGkS3QGTrTMuLxQQ?=
 =?us-ascii?Q?dfsdrnVGS7FsEFe84H1z9el1pWyV66JN/zMPu90oKt2OxjgZ7YkVQLFkK2ea?=
 =?us-ascii?Q?ONeI5sP8W5i0oqbms3wxRSnv6HUk6GJmTlYgHPQT7x44OddHtm83Ursvt9Mm?=
 =?us-ascii?Q?YbHUC8ZkVwHsMTYUDxC+vatG7htFLvNaB5ZEAswgnQsbdeGDacE34X2/BtWA?=
 =?us-ascii?Q?d3jtz/EnwOY01g7QfabZV42bb2qKsU54fqvKtlMPZNnecVy7QaXPeneoqBQX?=
 =?us-ascii?Q?7ZDeYhhordzhgdijZO3X3ZQYzGFEcI/0Wem+YrS+PzgHtnUGyn3of3VHNFM4?=
 =?us-ascii?Q?iinIQOCZ6TKokaGjZtqia++x+3RcXmEXEoVclSlsDQ7z0LkqzO5sxqrzQtgy?=
 =?us-ascii?Q?y6kiVfRFUkODAcjNfuK17ihTO8iugw0icoWby1hg55w/DbcR7xHWFUMkTaFl?=
 =?us-ascii?Q?Q7WB8o3MusOaSgVBN6/vTCzz/xnsVXrosRDOrQ4sm1Hac9u3hfUPtRG35UHq?=
 =?us-ascii?Q?WgeTksPcTXvjzAworXHLgKGM3kZZobHh4rnDIzyE7+PdepYS4MdwDxmkRuZh?=
 =?us-ascii?Q?/89c87gVni2U3iUwaovh7AP1PC2xXJtvc2IrGYPpBhAcdasLm/PAgUJH1orQ?=
 =?us-ascii?Q?IM+iNP+8LkL4zMX9TiSsgsAJI52HPZMvWI2JvOuy2jA/XeNAEOvMk1XzYArz?=
 =?us-ascii?Q?HmpnmYtw7qI7dDLJuL+wByyw8PQ8A7z9yXoFr7qZ/jp/uNNZ2127eXx/hnnN?=
 =?us-ascii?Q?3C6rNGpz5hNI+UJ76Yu1+myAR9vc2YY9ietywI+nbrD4XFPkCrr34ZN/l49/?=
 =?us-ascii?Q?kJ5j1Fc5VBtIEfyQIGXSXTy4flf2lJFdY2t9UlrmJoQ2FixxHbEb4G8zLVeV?=
 =?us-ascii?Q?o+e+C3hKDdqbWc/fupykkZdx0gZ8GogJGuTnhgYPHcQmr13dfdxINQ19KltK?=
 =?us-ascii?Q?f9gkw0jR3qWjrY4bPQogr/tt33fkET6gaDXDl+CqpJlIanoWlNkq+/yexu94?=
 =?us-ascii?Q?hmHsZd+1Ab4Rq1qLUvyeKiiLan2V5FQOLWYjYDt4aHZ21W33tfPLpMSshYRe?=
 =?us-ascii?Q?Ls4464CGhY084yHNuaF9+l3Ov0q8ST1DBqm9/w=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Cy/S11oPTzMT1/NKyJjFfqsdHTSrlxQYSmAP515wMBuWdoarSQWJxmoBs2DS?=
 =?us-ascii?Q?Jej3qH4g5fXPhlrafKQK1KqyZgDZE5nR9yviLEBdN60bdN7lyx54EFYuD8dA?=
 =?us-ascii?Q?GNIhI6nyCTevvDsW/bGR6OaiuIn1xJR4eZd+d/WpnPwfA5CsSsheUlRc5V67?=
 =?us-ascii?Q?9voez2dHV5s2S37YGUZ+pQ/KNqK6XHbebiLV8CH7iY+XSjQ3j7vdJjLIC42w?=
 =?us-ascii?Q?a5pYMK0RT+Ei0KoqzF4znW+P5kqH+SdC/wUldRIhva8QgT59WAe2I20n9Wg6?=
 =?us-ascii?Q?ClHvYbK+aFrw/l2n0c1QB/s64yXsKJigonmS9zM6tX5GLGgBrFcvbePl92Nv?=
 =?us-ascii?Q?FwSGg2WgZ376IJc/xxk7iAhxcsGkkB3lefe2k1iB6CMcAJ6cIkq2HOS159EJ?=
 =?us-ascii?Q?Anl6PRjCtPx8514kg4bxRevShARMlSM2+p1/sOnJlHT3q6frM6BLh6nULy7P?=
 =?us-ascii?Q?6gj2S8XKfRznGmga8khFOn1/IaC1/X9HgcQV7n8UKDJUjLT9hAhRpt5cLcdA?=
 =?us-ascii?Q?UBMHW/+PJ0yqBfWdrvUL57AMgrAtJ3e/RbnqN86zcGaXhk+QaLcCdhWF7xcA?=
 =?us-ascii?Q?iE4IjB/TMYaxxJte/XgRQUiJ9l159PrEXXIt8yM2BwWqQIhDnD1lllNwEbFj?=
 =?us-ascii?Q?iHhnMAVfuVPRmla/vm1DVt/NVJBjmpJcvrONK+rTL/BVQQcqS7fypx3qdIh1?=
 =?us-ascii?Q?94KQh9L05Bybaj4INGuwQVhVoHwtsJvnLxOaro7bE1hVcv+owlRNE4TcRxhW?=
 =?us-ascii?Q?5ZgG5k+KSZ5NUBuI5Jgs+6OW3cdtbQ33qosG+z/jP2zLIhuhP8nvfX2nW1uN?=
 =?us-ascii?Q?QufJPYPqoXfuYo6MXK4HDBtVawN5C0ZbtBZVetKO7uWYrZNBSt2zSnpqZ5mk?=
 =?us-ascii?Q?3+wRhfeiguVdsFpKIRQKCXjzHi8shSFSU/tWq/VR3Easbs64sKV+9hKNLH8N?=
 =?us-ascii?Q?LXfpRu+KDWO7SQiJvZdyKJXI0bTwiMuT5HdHj6NNbVitFhWsNJVQOwqrMdRd?=
 =?us-ascii?Q?KMWn5Ov6sEGtqF+9MSimkiVnCGeQsSiJj0QC+i3PiQ6iCur4/WijgOwTkDo/?=
 =?us-ascii?Q?KND01/jdbcMBDjTO0Cb4rwCIuT92g1uKSnyqrR7KMYDPeKmzXwmXRDOYRbmV?=
 =?us-ascii?Q?M9etgj+GDwgrLcWKWekOjWeBtHiWY0o6W1x4aEtGVTdLoo8pnGyFxfV068ab?=
 =?us-ascii?Q?82+oo25Jkzu6UoBhOMYHzhljxCJmC9yUtluLqmNtPHeAPDDvyOfEVSrrFIc?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: c6233701-3b62-4866-7ee9-08de21d00e12
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Nov 2025 09:44:20.5861
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR02MB10149

From: Peter Zijlstra <peterz@infradead.org> Sent: Wednesday, November 12, 2=
025 1:37 AM
>=20
> On Wed, Nov 12, 2025 at 04:12:08AM +0000, Michael Kelley wrote:
>=20
> > > @@ -96,3 +97,10 @@ SYM_FUNC_START(__mshv_vtl_return_call)
> > >  	pop %rbp
> > >  	RET
> > >  SYM_FUNC_END(__mshv_vtl_return_call)
> > > +
> > > +	.section	.discard.addressable,"aw"
> > > +	.align 8
> > > +	.type 	__UNIQUE_ID_addressable___SCK____mshv_vtl_return_hypercall_6=
62.0, @object
> > > +	.size 	__UNIQUE_ID_addressable___SCK____mshv_vtl_return_hypercall_6=
62.0, 8
> > > +__UNIQUE_ID_addressable___SCK____mshv_vtl_return_hypercall_662.0:
> > > +	.quad	__SCK____mshv_vtl_return_hypercall
> >
> > This is pretty yucky itself.
>=20
> Definitely doesn't win any prizes, for sure.
>=20
> > Why is it better than calling out to a C function?
>=20
> It keeps all the code in one place is a strong argument.
>=20
> > Is it because in spite of the annotations, there's no guarantee the C
> > compiler won't generate some code that messes up a register value? Or i=
s
> > there some other reason?
>=20
> There is that too, a frame pointer build would be in its right to add a
> stack frame (although they typically won't in this case). And the C ABI
> doesn't provide the guarantees your need, so calling out into C is very
> much you get to keep the pieces.
>=20
> > Does the magic "_662.0" have any significance?  Or is it just some
> > uniqueness salt on the symbol name?
>=20
> Like Paolo already said, that's just the crazy generated by our
> __ADRESSABLE() macro, this name is mostly irrelevant, all we really need
> is a reference to that __SCK____mshv_vtl_return_hypercall symbol so it
> ends up in the symbol table. (And the final link will then complain if
> the symbol doesn't end up being resolved)
>=20
> Keeping the name somewhat in line with __ADDRESSABLE() has the advantage
> that you can clearly see where it comes from, but yeah, we can strip of
> the number if you like.

Thanks. If that symbol is referenced only by these few lines, I'd
go with something even shorter and simpler. Perhaps:

.section		.discard.addressable,"aw"
.align 8
.type	vtl_return_sym, @object
.size	vtl_return_sym, 8
vtl_return_sym:
.quad	__SCK____mshv_vtl_return_hypercall

Regardless of the choice of symbol name, add a comment about
mimicking __ADDRESSABLE(). That feels less messy to me, but
it's Naman's call.

Michael

