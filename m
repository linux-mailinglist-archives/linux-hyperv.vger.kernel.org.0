Return-Path: <linux-hyperv+bounces-2933-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 39D28968ED6
	for <lists+linux-hyperv@lfdr.de>; Mon,  2 Sep 2024 22:25:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D1111C21EFC
	for <lists+linux-hyperv@lfdr.de>; Mon,  2 Sep 2024 20:25:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B00091AB6D2;
	Mon,  2 Sep 2024 20:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="ruhrkvZZ"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazolkn19011038.outbound.protection.outlook.com [52.103.13.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF98D1A4E71;
	Mon,  2 Sep 2024 20:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.13.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725308700; cv=fail; b=JzkBWTbo5Kjnb2hUslmiaDEKwbJaqCO1YNzfiNzfhuusyJMY+NnPRFoYQFenEV6EFHhZmELWPF6+LqczYazroQBCDtBtqvhUmDZM6I8skJO4qxeLKSFYPmIKnTLTBG97h2DoCSFC2+wNspBz6hVXNJYV44yV367Fc8qTb5MCbFc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725308700; c=relaxed/simple;
	bh=P4CZcLnuwZeEHNKiSBE8FgFcwT9q9QfIsX4F8cr48ew=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=IuTRf4gKE5YACisGTpt15ZS1whvk3V6zNLDjMXicFyFh4AnlHbQDFhgJ/yflZhZMgEIML55UwxS2RE1nvMrG+YzgWnFOZgSj0Q+h2khJYymVE/ERLcdLOEgfYBV8VST37/6b8hsPfhR7wouVRLfGhLFrKm1C/UnW8Dst4tkjvU0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=ruhrkvZZ; arc=fail smtp.client-ip=52.103.13.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O+HiDj6HsuSzru/6jW4BW5NVCHbbUvdpE08sv5B09+AdF+WhpS1FYS8aNTE6U8iV/bJtk9YEMRHQlGBxtx9wbdk0hXpj5XhkCu4bSxMGhHtc4YChQlMPmEGL9JVvl0rnko7/bTjshIk31OUMKuOAXEsXcscpNssC0dauuhXXaLgW1deLurJ6YGEmyVbc0jFNijy/8a5+uRIWE8SXzzmH0S+xassEuyt3ivOdZWUwl+SGVwbVrgi+LDVT/2mETQPzkVdKGlZwCPcyhJXcIboYknojrXS4SrXNh/aXNDYxHWQZP/OKOXNcml53pjQRS6osmIbs+4aHftFRCHZZqDLRSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RNa4blclpoZjG9/Qm3BSBhGFVMnY6N6CGvkJI6DLlao=;
 b=skq2KTIGDCVTWpbl3f3bCiB/ak8cNpceC9gbG78MALhgQI4bI0VCzE7cNfvGK+Pg7SiSZzlpuffRzI+OuRS+EctTriPX74CRIKlB8rL2rDh3U+6PG30yLUkKzZgK9JQ6Tdda9zhEr8NWZ4xhyRwcR/tREvHKgrv0sjBLCh9bPlv/QsVy4akKJGnyTFddZvSNfZJ6dTj+GB6ffOJZs7nEWzeqpcAX8DR8EcFsD7t2Y8i++DkJV4X8cqXpv7RqRxduWneS5yX7NMgGULGiDUoi0DE/k/Bv/4j6AVDegsowCNsuT08JGaRebuyazZV+CmU9ulnFm9pwjEssHktd45qXpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RNa4blclpoZjG9/Qm3BSBhGFVMnY6N6CGvkJI6DLlao=;
 b=ruhrkvZZ+dEZ55cbr27aO8IHd4QLdrTleDk36gzm7ASVvca5NDn4gXgB2wYBi30TeROh2eyZoZ7yvgkUGurPlYg0fvB4RqRTYkqXNJ9zfb5lMilQty84dioIaj/ogNgG+IzhGxMxumpvoK0CQwfsof0Q6XIVYJ77pmDP6qjLYu+hIE7rr1CTD/9eRTi+L7KDYieBa7V0cJ4QMWOMQ97XKrs7h8+rjVI+5myySPipwV7zU35BRo1Ea5Bsy3Ct8GbJ59V8vNEkdV95GIHKipbum6WSzBa2H6DmKIerrzjYAFIdu5XulqriazrBVXYQwJsK+iR4HwLIoPMj4qV2JQ2aMw==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by DS0PR02MB9482.namprd02.prod.outlook.com (2603:10b6:8:df::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.24; Mon, 2 Sep
 2024 20:24:56 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%3]) with mapi id 15.20.7918.024; Mon, 2 Sep 2024
 20:24:53 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Saurabh Singh Sengar <ssengar@linux.microsoft.com>
CC: Yunhong Jiang <yunhong.jiang@linux.intel.com>, "tglx@linutronix.de"
	<tglx@linutronix.de>, "mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de"
	<bp@alien8.de>, "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
	"robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"kys@microsoft.com" <kys@microsoft.com>, "haiyangz@microsoft.com"
	<haiyangz@microsoft.com>, "wei.liu@kernel.org" <wei.liu@kernel.org>,
	"decui@microsoft.com" <decui@microsoft.com>, "rafael@kernel.org"
	<rafael@kernel.org>, "lenb@kernel.org" <lenb@kernel.org>,
	"kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Subject: RE: [PATCH v2 5/9] x86/hyperv: Mark ACPI wakeup mailbox page as
 private
Thread-Topic: [PATCH v2 5/9] x86/hyperv: Mark ACPI wakeup mailbox page as
 private
Thread-Index: AQHa9bO/8V6yP8NKL0Kh7Jr/YhMZqbJDIAOwgAHDUoCAAB0okA==
Date: Mon, 2 Sep 2024 20:24:53 +0000
Message-ID:
 <SN6PR02MB415766430F8CF3D51EED5648D4922@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20240823232327.2408869-1-yunhong.jiang@linux.intel.com>
 <20240823232327.2408869-6-yunhong.jiang@linux.intel.com>
 <BN7PR02MB4148A328FA019239196CFB15D4922@BN7PR02MB4148.namprd02.prod.outlook.com>
 <20240902183857.GA11785@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
In-Reply-To:
 <20240902183857.GA11785@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-tmn: [CD8lVUqI+mamkvEQPNO0iiY8hdjwQjH6]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|DS0PR02MB9482:EE_
x-ms-office365-filtering-correlation-id: 1862d4dc-e2f6-4aa1-5b55-08dccb8d4de7
x-microsoft-antispam:
 BCL:0;ARA:14566002|461199028|15080799006|19110799003|8060799006|440099028|3412199025|102099032;
x-microsoft-antispam-message-info:
 j9Keak9QIgnLwJ6puhDHeAOPOo/Ogzq3ssK6uYa1uRWS4sFZHZ3mFtmH4nKlBXUhHzbspK6U1rlbDXX9sf0K4LxcsCAdXJTN39y6rDZ4IDesAacXecXNH5vt0GMm4/Ur6ndZW8AD2vo8lIPZhvrsgIkQJX9BM0NsEHFyE4yPnYJYi9dg8ZNa8CYiN0njDCrKnAzuUrjGAH292VKdJjQRrwdvAoFp1wlUYTiB3H4iXHpPTNbuQbJblCJPICSymLHNnNM9Jj+/XIf7plvErKg04poiNWKrgUOpg29yN/uh0uzirsWaIgsmj83GSxpU5eh3A7uWWE6bLPRnjFv/FWFQBRsJsfOZ1x1jFfA+ws8f7JvKpoq6nskD6RdF558IF1sLNLLTxz/m7MW2C/wlrFnsOEcan8Ms5gb9x9kitOoXxovNey/796weZQA6F7P4/HKAE7XrQxlSLp0U6yzRI8HLdTbg4bjuLPEtgeBOENIqqvPl+Ou9V3yZJkr/SDLinxM3s8LP4edD6qqKqV6HL4w4aGtA4txMrSGoHV0lZ1MqBncoFcPdofogv/+Bw/hK4ltUCa9Uo17FbmyLozIxKMAU+1xa3+NfpKqOzkhNtVgr4MTdhfyAUYycof7fBi3umfXuvSvFVlxWSfAnYM/k+8+y/iBmin49u/P6X/r7jR4nfx4fE1AbwkQZkBPTlgjcpV0g
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?8ZiEq+5ojZRNHiVbjHkkKrxTDxXvn4qMPOf/ySDLQe0enfviKOwHLrIokRnA?=
 =?us-ascii?Q?y4ZYN4LPBkYkoXgBa4TttvtSrWeHjKfBbTzCvIuO7dJOkblLeHaXdeCu27El?=
 =?us-ascii?Q?rqOZR8aKFGqzsxCGK3SbBWG8Gzn95nzcDzGDfywqbxYv9PiUnGsriEzsA7/R?=
 =?us-ascii?Q?ejqexPUTyZMZgCahJeHfl4LGy7fwKLH9FnaPkpSbIqCeJDVl286bSWaPaYzM?=
 =?us-ascii?Q?tJtasvRjnbckZsUgrLm2MxlCZ7Wl7OnJROAzch70C0zPXaIdT34YGYcYx5+Z?=
 =?us-ascii?Q?cfHdPrstFzoe4YEmc6njFRbvsEQooSncb8NdTfMx99t2XdjunRmu+uAoOamB?=
 =?us-ascii?Q?8ofpm7fcRWV8vWGqheqkYqz44oTkV7PiHKYDj04O+ty3j/M5d1FrflVhkmdj?=
 =?us-ascii?Q?qG/qp910EjuC+cktYtcnXIDarMgeKblo8D9CEV+wypZ7gW8SqtWxfi8TH1JF?=
 =?us-ascii?Q?Pq1C2PZ8vkG7XCu0JgArrfR/iKEtSOTawS4097dGHiEioKW+d6tf2XetgFn0?=
 =?us-ascii?Q?Sf28w7JsSA3jAI2XhxO3EPTb0gTUREaM9/LfWgJHJfF43BcDH7/VulOX5kvh?=
 =?us-ascii?Q?z5vXgoy2suKrBpXcIdw5T0HEOMfFe+3fl89b3iNHjF+tJpXk6BQk9CuqM1d+?=
 =?us-ascii?Q?cDyATy7v8izxex4Y8ZFYgyJ7mLd9kjutFMJqklq51ZjK210nyZD0u1eFmMvH?=
 =?us-ascii?Q?idz0yM0lI5JaQC1Afu7JmJwV1F+Z0+DUx9Zvl1Xii7EUlPVxgLakoV9RipZN?=
 =?us-ascii?Q?QrS6bPQIL1mw0ZqwMnUNf/LwUWF9xHyIdfhXEdza7KyAwUcIcZvWCwLmvR8s?=
 =?us-ascii?Q?Ng+ffQBQewRp0GBj73Put36ZaFi8agWQfff30cepASP1h2HbZxnWFVm+a4b/?=
 =?us-ascii?Q?DuIoCjj5T3RRFTrWfNu62h3OQO2K8dYQcB3r4iMBPSja5I0cRSPRIM7uJDFR?=
 =?us-ascii?Q?5iQ+AYkAFJrObhqnZyWR/MgKnJBv4YS+lgiuqdZcbEZbnSJtyFxQd604hTnN?=
 =?us-ascii?Q?zV1zFROE0WOoTMxLcA8hfXbyoCfIQqbx5dxj0rR1UnJnFr0ekzQFGohsVPnK?=
 =?us-ascii?Q?P4MpbRS8UTjR+MRVaFvjCIBz4lLk2+CSiojg+Ml6hQqgM0DmNo3NxNtLObia?=
 =?us-ascii?Q?vQ9A5z6MzlXElBB5FcPOSmU2EW7dvHR805n2doa2ay3yS0hL/1/iA40y4B9j?=
 =?us-ascii?Q?OsgjVr5e6I0jDHkUzkHc7N0ZVDbRl0gTDfwsn9Bo59JegKW3ckKiF+epPJU?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 1862d4dc-e2f6-4aa1-5b55-08dccb8d4de7
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2024 20:24:53.7276
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR02MB9482

From: Saurabh Singh Sengar <ssengar@linux.microsoft.com> Sent: Monday, Sept=
ember 2, 2024 11:39 AM
>=20
> On Mon, Sep 02, 2024 at 03:35:18AM +0000, Michael Kelley wrote:
> > From: Yunhong Jiang <yunhong.jiang@linux.intel.com> Sent: Friday, Augus=
t 23, 2024
> 4:23 PM
> > >
> > > Current code maps MMIO devices as shared (decrypted) by default in a
> > > confidential computing VM. However, the wakeup mailbox must be access=
ed
> > > as private (encrypted) because it's accessed by the OS and the firmwa=
re,
> > > both are in the guest's context and encrypted. Set the wakeup mailbox
> > > range as private explicitly.
> > >
> > > Signed-off-by: Yunhong Jiang <yunhong.jiang@linux.intel.com>
> > > ---
> > >  arch/x86/hyperv/hv_vtl.c | 16 ++++++++++++++++
> > >  1 file changed, 16 insertions(+)
> > >
> > > diff --git a/arch/x86/hyperv/hv_vtl.c b/arch/x86/hyperv/hv_vtl.c
> > > index 04775346369c..987a6a1200b0 100644
> > > --- a/arch/x86/hyperv/hv_vtl.c
> > > +++ b/arch/x86/hyperv/hv_vtl.c
> > > @@ -22,10 +22,26 @@ static bool __init hv_vtl_msi_ext_dest_id(void)
> > >  	return true;
> > >  }
> > >
> > > +static inline bool within_page(u64 addr, u64 start)
> > > +{
> > > +	return addr >=3D start && addr < (start + PAGE_SIZE);
> > > +}
> > > +
> > > +/*
> > > + * The ACPI wakeup mailbox are accessed by the OS and the BIOS, both=
 are in the
> > > + * guest's context, instead of the hypervisor/VMM context.
> > > + */
> > > +static bool hv_is_private_mmio_tdx(u64 addr)
> > > +{
> > > +	return wakeup_mailbox_addr && within_page(addr, wakeup_mailbox_addr=
);
> > > +}
> > > +
> > >  void __init hv_vtl_init_platform(void)
> > >  {
> > >  	pr_info("Linux runs in Hyper-V Virtual Trust Level\n");
> > >
> > > +	if (hv_isolation_type_tdx())
> > > +		x86_platform.hyper.is_private_mmio =3D hv_is_private_mmio_tdx;
> >
> > hv_vtl_init_platform() is unconditionally called in
> > ms_hyperv_init_platform(). So in the case of a normal TDX guest
> > running with a paravisor on Hyper-V, the above code will overwrite
> > the is_private_mmio function that was set in hv_vtom_init(). Then
> > the mapping of the emulated IOAPIC and TPM provided by the
> > paravisor won't be correct.
> >
> > Michael
>=20
> non-VTL Hyper-V platforms are expected to disable CONFIG_HYPERV_VTL_MODE,
> that means for a normal TDX guest hv_vtl_init_platform will be an empty
> stub. Have I missed anything ?
>=20

Ah, you are right. My concern is misplaced and can be ignored. :-)

Michael

