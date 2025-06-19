Return-Path: <linux-hyperv+bounces-5965-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CD127AE0F68
	for <lists+linux-hyperv@lfdr.de>; Fri, 20 Jun 2025 00:04:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5BE041BC6606
	for <lists+linux-hyperv@lfdr.de>; Thu, 19 Jun 2025 22:05:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FC9F29CB3C;
	Thu, 19 Jun 2025 22:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="k5p4DGSA"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10olkn2013.outbound.protection.outlook.com [40.92.41.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4CDE2951A2;
	Thu, 19 Jun 2025 22:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.41.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750370530; cv=fail; b=ogFHuLUKz7+7ST9ukQNN2WunrNOyUIc2A3qkK478kkscZ8K6GgmwISanYmkIAVcGH0CjVMhPmkL11BxrHMfDqsH+zhAFehHlc1smAuKTJ9o1lW/w3tTV6EjCLOOoVVRlxeRuZ5B8w8/hFB7GNGmmMudICUONFGwP/1EFCcdTsGk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750370530; c=relaxed/simple;
	bh=TYt7mDz05CLhX6YMNHLAvFC9DOWDc+pOFJj2NW246PI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PvemeibHFM2Br8OsZHr3IcgVRmrOozB1gQ/sYHpFHubSHCwiN2J27BFVQfHZTTwHPQBihrLZJe9BfXgJEE1ofio1fGMqYRqys6KeLpH4fIxhn3MrZ0trym4QdtUAsEIl1XCb/ufpjRzsd4ep4P3JTPNkrFNAHs0O9/BBzW3CeoQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=k5p4DGSA; arc=fail smtp.client-ip=40.92.41.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a4EB3nNW5E4oakcQ805pbm+DlkWyjXOOq8YpD7gmaamSOKmOYVaLr2+2MUqKEpPeCXTZlpBGu8i93NsKB1y4szZ4nnegyiR5Dy4zcp1JyNCI8flaxXEa6bap9HtGRvQYeBFAgfxFG+2mmJYV2WPaFCeCF734UiVkvlMvdK8gL757+j6PU1TyBaRnbP5qZ9afm8vLQcPP03nsLkfFNeAjGsd+F3HMig8KAB+PQ/2NHRIcQQeBhaWK5SEfc+u/bUhQ8wHIT3gpmgf8ywkOeGEtI+B9jfOcOTDuD5zQVUuQKNWztIJxzNKEiXYb7opRZSDoJozgRZ4NSSfgr7tq6N4SsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aamTXbWKddvjCZgM+4LP44qcUvX1ol0CRrtMaaLefoI=;
 b=ukRbZwm85d13E5YiYUryxs7OWeUyBpl69CYRmv4GC7AODdBSq3RhgcQgZs6ADuSCXkTxgSjB/Z65CSNL84rUaCvnPXVN31jVW2tsoyy3cT7JNwG/8Oh8XRayVLvWCbemHtaiKDhpP39gFQa+kIS/294qIRox7knURj7167zH9ivl4npXxJUFQQXsGI11QhZF/qEYQSuOlcLgWp/jlKrpuoBHgDyC8gGSTr2x3eqA3FB8IG50TpC7tVwOo2SrvpbpgMbhN6LLvRH7/UO2HSR0cp59mxbXUjApBJiVyBguZl/c+0fuTon0n2UIzNF71Ng/XytnN7Ec/TwlnqwkB/vRhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aamTXbWKddvjCZgM+4LP44qcUvX1ol0CRrtMaaLefoI=;
 b=k5p4DGSA0EaRkoTnCogMq0vgxwJ6yQkNEYHldoV43U1sxPBpiIY+4b2rcCasf3zoOGRzUs8OXjtxxs6UkFJSbNMZLKUr6sfvkcaYA8SytHQJ+inw1r2VCus9fM8HOYKH+JdDK6nothRUyRai+ZXiiItbkiwJ2CRosWcSp/YFZVFup2T0/b7KiMyEP6aNki0Ck4F6rxEwWtWR+TLNROukPFTEpsYrkp/02xQQdj0CwLj9o4C8DqhzBXkID2KelQbZ3rVNvoodkkvONjTYdytz1sEiXi3Q8p2u421uyA7Vnvyrv4QGvOQ5qED3PmoZexOZsjXK+goxTDLQeQZALslxqQ==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by BY1PR02MB10554.namprd02.prod.outlook.com (2603:10b6:a03:5aa::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.21; Thu, 19 Jun
 2025 22:02:03 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%4]) with mapi id 15.20.8835.027; Thu, 19 Jun 2025
 22:02:03 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Nuno Das Neves <nunodasneves@linux.microsoft.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>
CC: "kys@microsoft.com" <kys@microsoft.com>, "haiyangz@microsoft.com"
	<haiyangz@microsoft.com>, "wei.liu@kernel.org" <wei.liu@kernel.org>,
	"decui@microsoft.com" <decui@microsoft.com>, "catalin.marinas@arm.com"
	<catalin.marinas@arm.com>, "will@kernel.org" <will@kernel.org>,
	"tglx@linutronix.de" <tglx@linutronix.de>, "mingo@redhat.com"
	<mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "hpa@zytor.com"
	<hpa@zytor.com>, "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
	"kw@linux.com" <kw@linux.com>, "robh@kernel.org" <robh@kernel.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>, "jinankjain@linux.microsoft.com"
	<jinankjain@linux.microsoft.com>, "skinsburskii@linux.microsoft.com"
	<skinsburskii@linux.microsoft.com>, "mrathor@linux.microsoft.com"
	<mrathor@linux.microsoft.com>, "x86@kernel.org" <x86@kernel.org>
Subject: RE: [PATCH 3/4] x86: hyperv: Expose hv_map_msi_interrupt function
Thread-Topic: [PATCH 3/4] x86: hyperv: Expose hv_map_msi_interrupt function
Thread-Index: AQHb2mKvyYZ7kcH90E2KtA5yDTBR/7P9bWcQgAwIFwCAAZswsA==
Date: Thu, 19 Jun 2025 22:02:03 +0000
Message-ID:
 <SN6PR02MB41576BCEDD9D8239909CFA57D47DA@SN6PR02MB4157.namprd02.prod.outlook.com>
References:
 <1749599526-19963-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1749599526-19963-4-git-send-email-nunodasneves@linux.microsoft.com>
 <SN6PR02MB4157639630F8AD2D8FD8F52FD475A@SN6PR02MB4157.namprd02.prod.outlook.com>
 <8f96db3f-fc3b-44b6-ab28-26bca6e2615b@linux.microsoft.com>
In-Reply-To: <8f96db3f-fc3b-44b6-ab28-26bca6e2615b@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|BY1PR02MB10554:EE_
x-ms-office365-filtering-correlation-id: 745cf925-5744-4269-8b88-08ddaf7cec8f
x-microsoft-antispam:
 BCL:0;ARA:14566002|15080799009|461199028|19110799006|41001999006|8062599006|8060799009|3412199025|51005399003|40105399003|440099028|102099032;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?nEbysinktuJDpf0FzlGHW9ZYKzJmcuf9i44YdZbeRxwIS5PTgSck0cZ4ofOQ?=
 =?us-ascii?Q?f5gf+dk5AAN5qzHp/NqoZbyM2+vgvYlMZ/YdmXC5nbKqv0h9xhKQlDNb/ueC?=
 =?us-ascii?Q?1YP7G/mmd6bSYRI/1ICLHnj7Ue8vYj/alzyvNbwR4Lnu6Z4/HsiCxE/zXVhJ?=
 =?us-ascii?Q?SMEbI28jEZpfD5joNiNnUSUrkQvQB70x+LwwaflhZDp2wcEUc9neUMm+Yw8n?=
 =?us-ascii?Q?2K8DgGOonIL40X06njfNj36I4c4Pj/aNy1OXPpJp/l+lNzjQlL91DOBcc5tM?=
 =?us-ascii?Q?5KwRODpYBtZ/+uYfxsHY6BolvQgJNC1AZWdJLE8en+SYRdopc9PF8AZLGRfY?=
 =?us-ascii?Q?/mrMHBFwIY8IonMgtPD5MRiqiAV+Wn07INGkckBnt15fdcJQAnE+KtT8vHTh?=
 =?us-ascii?Q?DAhRw2Dh9IfjyWfNfnkmOG4asRZkh9KKPgq8i0uSXQGs9WL7Adaqqsip9foF?=
 =?us-ascii?Q?zZ4bz5tsoglCUziZPx3Iuy22diw2SjR9/Vmf7iPA0obDHayOaSNuq2FcoOwF?=
 =?us-ascii?Q?N6fqpCLI3lwLraQoAEFU/zQtINZzCJnuDPV3u6PZ47fXt6qdWe5jd1CBQfAW?=
 =?us-ascii?Q?FE3E8G6B9bfqQKR1QJJ5VfB7Bbjub1/Xi2FUHzwX8vsT5AKv6IhyQmhNb2GX?=
 =?us-ascii?Q?ddFzJRGR499tQj/Ftk8EKGkLra1lMj2YzEhxqhetbOcOANBqAhZuUTMKR5Ps?=
 =?us-ascii?Q?oezmkuB904KG01vbiMaiCIZ4yBkHB91SUAVJoFB5i+YAzs+/w9DlDmZEljn8?=
 =?us-ascii?Q?AfG09gC2UpEuUjdmdNgXeuLfyq4noQi5TGztuUjr4tmcHAzenmtZGSSC+fXc?=
 =?us-ascii?Q?jDHzxn4eK0y12T+QbEM2OButrAX5nhv01dqMlI2e4j82TGYNE4r8FpvEO823?=
 =?us-ascii?Q?T1zcQyIJ7w7m1oALLtZ6GBQlx5Dda+4suCo+ZPwBn7FU8HOZMja2qvajQJ0p?=
 =?us-ascii?Q?zZAC8Egzc6zquP+ZBwsjTuPmOM9VlJ6qpKoDFCpaoyG4splnafAjYdHU5VqC?=
 =?us-ascii?Q?C0aD2bNMkR83axoRhSzI9SNdcWkfrDWZ1XNhNFVgbzqKoX5+rctbhQfgQ2EI?=
 =?us-ascii?Q?xQycsHHGgtRNRndX0HxyuFB8oVnqzI+ztvRKnRb/baLWszz1lqAic+RtZL3i?=
 =?us-ascii?Q?LBjttPSTn76wryIdT6bXyUTeB6nqSVEUr+NeM9fqdR5PhV8Kfwj6CtPp9Jpv?=
 =?us-ascii?Q?u0zvoyvwgcDuiwQq?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?9Gx0HtZ3fw6YDzJABSlGNjaZecjckABZVSYIyf1+3KIaeiewkW7+ALV386TG?=
 =?us-ascii?Q?fLWcYT3JLe645h1B5lQKchozEl/qSOeR6mIUTptuhuIeHoz7k+SlI7h7Z90S?=
 =?us-ascii?Q?PpsubzdHtE5GQaFwUM3stIblnCYFU7JmojRjtb8/zGVMomN0qfW8uN0IekKF?=
 =?us-ascii?Q?HPjZv1cZafc1ZjB3Urr/S6RNTjpC9EGkYdacsmX6NCQd7CAHZEFhNZrugCdF?=
 =?us-ascii?Q?Lp3yTLd8NNbbfs+UirKyeHUpufe8CvUu01yP1PTFjlF9v6F6VszZt5MD5oDp?=
 =?us-ascii?Q?RNCIdCgK2nkFPBtJASksqctEg2hbjdFUZwLfWFHOt6zFexeXuisfdwN6ZdLo?=
 =?us-ascii?Q?TgBywGimivSItTGEVCiRYBP+7zaxM8Zm6b1jkMlfe5HoWXlqHLblFh2KumUt?=
 =?us-ascii?Q?nUVsHsEKsNU51rULGsYZcL3hdxGJHsZOfoQoMrCpZsPYzvIySJRvXPGn3ZcW?=
 =?us-ascii?Q?pjabnqvpCam2XHWe4/HdMdGlHiciJWF62yk1wA3NjYy3YDuNq9yaM2u5ZDx0?=
 =?us-ascii?Q?0nk97k3MCwvMjz8anGwBxs8nvQSZobr1/0Ktg9U+R0TjdCxQ06GGjMZpBK8H?=
 =?us-ascii?Q?mmdlMnpT8X95kYF2eLlKz1hInbqWWuZLT9/osgTMYV/D/Oh0u1iYcDUep5KM?=
 =?us-ascii?Q?Oeqx1j+GW7oqhl/Hhb1KaBVi1Wv9BLO56Gv0JE3jPCI2KtAlIA1gJTpnMEh4?=
 =?us-ascii?Q?mhXBKSXkGVJi5tbgB9BlVLg9XoO0TFZF9IRXKVtwqY5/ohLbRffLET1mY6f4?=
 =?us-ascii?Q?C5vs12uvhZWOaybiw+Z67hrFayV3S28KohNoU5TGzx2hr6GvHf5iPOkLixmM?=
 =?us-ascii?Q?Vjy3A6msuqTnpGD752yDx7WV0EiEAq58RAUSdML694rbkHzTUuaaJ0Sb4O8o?=
 =?us-ascii?Q?Hm7KuwCUIUx6dL5Wlg6B8uSxRjQBlZAnhmmcqDzNCmV01w7iTo5yde2qPPDv?=
 =?us-ascii?Q?8w6cfNyEGYaILdGhpY/wir/TXufKM2HVvBxBDMmt2IAbv6FlrPRzv+LRLJPM?=
 =?us-ascii?Q?uBrNckugI7uhyJgEnOyzh9zAAjSw6/3iO21JfyxFv8EW8TCkjnQBs/HfwliQ?=
 =?us-ascii?Q?yhRXb851JRewszL0LEuDrGp/Docp5Ajh4SAuC1We/K5DIingEH2B1Wd/gQ6H?=
 =?us-ascii?Q?jkqZTmB/hu/m7cqdyvOX1hTub3FavjJEt1MUyq4wNTwNlEraoWnkQZHa8sia?=
 =?us-ascii?Q?lWkr9EEMCj4mAj3VSfGK3n+fPqF0wS946vOvJ7Yrw9IvHQHDAmbVhITnJNE?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 745cf925-5744-4269-8b88-08ddaf7cec8f
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jun 2025 22:02:03.5905
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR02MB10554

From: Nuno Das Neves <nunodasneves@linux.microsoft.com> Sent: Wednesday, Ju=
ne 18, 2025 2:08 PM
>=20
> On 6/11/2025 4:07 PM, Michael Kelley wrote:
> > From: Nuno Das Neves <nunodasneves@linux.microsoft.com> Sent: Tuesday, =
June
> 10, 2025 4:52 PM
> >>
> >> From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
> >
> > The preferred patch Subject prefix is "x86/hyperv:"
> >
>=20
> Thank you for clarifying - I thought I saw some precedent for x86: hyperv=
:
> but must have been mistaken.
>=20
> >>
> >> This patch moves a part of currently internal logic into the
> >> hv_map_msi_interrupt function and makes it globally available helper
> >> function, which will be used to map PCI interrupts in case of root
> >> partition.
> >
> > Avoid "this patch" in commit messages.  Suggest:
> >
> > Create a helper function hv_map_msi_interrupt() that contains some
> > logic that is currently internal to irqdomain.c. Make the helper functi=
on
> > globally available so it can be used to map PCI interrupts when running
> > in the root partition.
> >
>=20
> Thanks, I'll rephrase.
>=20
> >>
> >> Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com=
>
> >> Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
> >> ---
> >>  arch/x86/hyperv/irqdomain.c     | 47 ++++++++++++++++++++++++--------=
-
> >>  arch/x86/include/asm/mshyperv.h |  2 ++
> >>  2 files changed, 36 insertions(+), 13 deletions(-)
> >>
> >> diff --git a/arch/x86/hyperv/irqdomain.c b/arch/x86/hyperv/irqdomain.c
> >> index 31f0d29cbc5e..82f3bafb93d6 100644
> >> --- a/arch/x86/hyperv/irqdomain.c
> >> +++ b/arch/x86/hyperv/irqdomain.c
> >> @@ -169,13 +169,40 @@ static union hv_device_id hv_build_pci_dev_id(st=
ruct pci_dev *dev)
> >>  	return dev_id;
> >>  }
> >>
> >> -static int hv_map_msi_interrupt(struct pci_dev *dev, int cpu, int vec=
tor,
> >> -				struct hv_interrupt_entry *entry)
> >> +/**
> >> + * hv_map_msi_interrupt() - "Map" the MSI IRQ in the hypervisor.
> >> + * @data:      Describes the IRQ
> >> + * @out_entry: Hypervisor (MSI) interrupt entry (can be NULL)
> >> + *
> >> + * Map the IRQ in the hypervisor by issuing a MAP_DEVICE_INTERRUPT hy=
percall.
> >> + */
> >> +int hv_map_msi_interrupt(struct irq_data *data,
> >> +			 struct hv_interrupt_entry *out_entry)
> >>  {
> >> -	union hv_device_id device_id =3D hv_build_pci_dev_id(dev);
> >> +	struct msi_desc *msidesc;
> >> +	struct pci_dev *dev;
> >> +	union hv_device_id device_id;
> >> +	struct hv_interrupt_entry dummy;
> >> +	struct irq_cfg *cfg =3D irqd_cfg(data);
> >> +	const cpumask_t *affinity;
> >> +	int cpu;
> >> +	u64 res;
> >>
> >> -	return hv_map_interrupt(device_id, false, cpu, vector, entry);
> >> +	msidesc =3D irq_data_get_msi_desc(data);
> >> +	dev =3D msi_desc_to_pci_dev(msidesc);
> >> +	device_id =3D hv_build_pci_dev_id(dev);
> >> +	affinity =3D irq_data_get_effective_affinity_mask(data);
> >> +	cpu =3D cpumask_first_and(affinity, cpu_online_mask);
> >
> > Is the cpus_read_lock held at this point? I'm not sure what the
> > overall calling sequence looks like. If it is not held, the CPU that
> > is selected could go offline before hv_map_interrupt() is called.
> > This computation of the target CPU is the same as in the code
> > before this patch, but that existing code looks like it has the
> > same problem.
> >
>=20
> Thanks for pointing it out - It *looks* like the read lock is not held
> everywhere this could be called, so it could indeed be a problem.
>=20
> I've been thinking about different ways around this but I lack the
> knowledge to have an informed opinion about it:
>=20
> - We could take the cpu read lock in this function, would that work?
>=20
> - I'm not actually sure why the code is getting the first cpu off the eff=
ective
>   affinity mask in the first place. It is possible to get the apic id (an=
d hence
>   the cpu) already associated with the irq, as per e.g. x86_vector_msi_co=
mpose_msg()
>   Maybe we could get the cpu that way, assuming that doesn't have a simil=
ar issue.
>=20
> - We could just let this race happen, maybe the outcome isn't too catastr=
ophic?
>=20
> What do you think?

I would have to study further to provide good answers to your questions as
I don't have deep knowledge of this area off the top of my head. The code
looked suspicious because AND'ing the affinity with the cpu_online_mask in
the first place is presumably to prevent assigning the interrupt to a CPU
that is offline. That's a valid intent, since such assigning would indeed b=
e
problematic.

But as written the code is inherently racy unless the cpus_read_lock() is
held. I'm on vacation all next week, and probably won't be able to look at
this again until early July. So the best I can do for now is flag the issue=
.

Michael

>=20
> >> +
> >> +	res =3D hv_map_interrupt(device_id, false, cpu, cfg->vector,
> >> +			       out_entry ? out_entry : &dummy);
> >> +	if (!hv_result_success(res))
> >> +		pr_err("%s: failed to map interrupt: %s",
> >> +		       __func__, hv_result_to_string(res));
> >
> > hv_map_interrupt() already outputs a message if the hypercall
> > fails. Is another message needed here?
> >
>=20
> It does print the function name, which gives additional context.
> Probably it can just be removed however.
>=20
> >> +
> >> +	return hv_result_to_errno(res);
> >
> > The error handling is rather messed up. First hv_map_interrupt()
> > sometimes returns a Linux errno (not negated), and sometimes a
> > hypercall result. The errno is EINVAL, which has value "22", which is
> > the same as hypercall result HV_STATUS_ACKNOWLEDGED. And
> > the hypercall result returned from hv_map_interrupt() is just
> > the result code, not the full 64-bit status, as hv_map_interrupt()
> > has already done hv_result(status). Hence the "res" input arg to
> > hv_result_to_errno() isn't really the correct input. For example,
> > if the hypercall returns U64_MAX, that won't be caught by
> > hv_result_to_errno() since the value has been truncated to
> > 32 bits. Fixing all this will require some unscrambling.
> >
>=20
> Good point, it's pretty messed up! I think in v2 I'll add a patch to
> clean this up first.
>=20
> >>  }
> >> +EXPORT_SYMBOL_GPL(hv_map_msi_interrupt);
> >>
> >>  static inline void entry_to_msi_msg(struct hv_interrupt_entry *entry,=
 struct
> msi_msg *msg)
> >>  {
> >> @@ -190,10 +217,8 @@ static void hv_irq_compose_msi_msg(struct irq_dat=
a
> *data, struct msi_msg *msg)
> >>  {
> >>  	struct msi_desc *msidesc;
> >>  	struct pci_dev *dev;
> >> -	struct hv_interrupt_entry out_entry, *stored_entry;
> >> +	struct hv_interrupt_entry *stored_entry;
> >>  	struct irq_cfg *cfg =3D irqd_cfg(data);
> >> -	const cpumask_t *affinity;
> >> -	int cpu;
> >>  	u64 status;
> >>
> >>  	msidesc =3D irq_data_get_msi_desc(data);
> >> @@ -204,9 +229,6 @@ static void hv_irq_compose_msi_msg(struct irq_data=
 *data,
> struct msi_msg *msg)
> >>  		return;
> >>  	}
> >>
> >> -	affinity =3D irq_data_get_effective_affinity_mask(data);
> >> -	cpu =3D cpumask_first_and(affinity, cpu_online_mask);
> >> -
> >>  	if (data->chip_data) {
> >>  		/*
> >>  		 * This interrupt is already mapped. Let's unmap first.
> >> @@ -235,15 +257,14 @@ static void hv_irq_compose_msi_msg(struct irq_da=
ta
> *data, struct msi_msg *msg)
> >>  		return;
> >>  	}
> >>
> >> -	status =3D hv_map_msi_interrupt(dev, cpu, cfg->vector, &out_entry);
> >> +	status =3D hv_map_msi_interrupt(data, stored_entry);
> >>  	if (status !=3D HV_STATUS_SUCCESS) {
> >
> > hv_map_msi_interrupt() returns an errno, so testing for HV_STATUS_SUCCE=
SS
> > is bogus.
> >
>=20
> Thanks, noted.
>=20
> >>  		kfree(stored_entry);
> >>  		return;
> >>  	}
> >>
> >> -	*stored_entry =3D out_entry;
> >>  	data->chip_data =3D stored_entry;
> >> -	entry_to_msi_msg(&out_entry, msg);
> >> +	entry_to_msi_msg(data->chip_data, msg);
> >>
> >>  	return;
> >>  }
> >> diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/ms=
hyperv.h
> >> index 5ec92e3e2e37..843121465ddd 100644
> >> --- a/arch/x86/include/asm/mshyperv.h
> >> +++ b/arch/x86/include/asm/mshyperv.h
> >> @@ -261,6 +261,8 @@ static inline void hv_apic_init(void) {}
> >>
> >>  struct irq_domain *hv_create_pci_msi_domain(void);
> >>
> >> +int hv_map_msi_interrupt(struct irq_data *data,
> >> +			 struct hv_interrupt_entry *out_entry);
> >>  int hv_map_ioapic_interrupt(int ioapic_id, bool level, int vcpu, int =
vector,
> >>  		struct hv_interrupt_entry *entry);
> >>  int hv_unmap_ioapic_interrupt(int ioapic_id, struct hv_interrupt_entr=
y *entry);
> >> --
> >> 2.34.1


