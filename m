Return-Path: <linux-hyperv+bounces-8224-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 995AFD13D55
	for <lists+linux-hyperv@lfdr.de>; Mon, 12 Jan 2026 16:56:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 77D7D300C0E0
	for <lists+linux-hyperv@lfdr.de>; Mon, 12 Jan 2026 15:54:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4D81362156;
	Mon, 12 Jan 2026 15:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="Ro2wa3Hu"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazolkn19012051.outbound.protection.outlook.com [52.103.2.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56BCB36165F;
	Mon, 12 Jan 2026 15:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.2.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768233294; cv=fail; b=ly13nT5+YkhjjEaPO6WLWxLNNCEtfIdfaukAzWBML4u8Yj3CzukeR+z3H9YFzi4SUCmQaAIi0nxVAS82cXyP1dHQa4hYWYaWCziDlmmDhm2iKURpCrZ75KyAEB5d16IDNdNnioza5IuiPcWXfXSgGX0U61g/c7i9/NWkpD2Jvrs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768233294; c=relaxed/simple;
	bh=6hQ5e0L/60ZWa6472CDMQBnzvi/gGJoXsBHIKRkWrKs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GqHoyI+He5IsRv+ifWakYUE1HYtKKQek0qMpSQBKlbMoQhO4DKiS/9LBsZuPKmfLu810lIHZEMxuuZ9DkaTDFKBoxbZI28zO/1TnDttvEgDT5iIasZDFLTOQoGd4LmIcYHGZgR6irwSIKVogmB6F0ScJ51OE7smp+TM1Sp/mos8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=Ro2wa3Hu; arc=fail smtp.client-ip=52.103.2.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NdZjdDn45PqlSPzeUkvNoGHrYAWPMyzs9ToTGb3PZPqGsZDDgfojJ3eYlJVliNyni/REzlUgFI1rDvtHpnCC69cCS6KniNukwFijcF+vh0oB5vT0oPrmyDt/cvUMQ/2vcx5W7fVdR88+YRP3FxgtAs1n+Am4iJURb2zqqKEPoY8DQLpdKmhuvPADBSKPwDoZguQvNqPSKMzzBdYm2JbAzKfYA9MsevOb2c+L+HubMJgLCiSITOF+EfKNjJ5J+UX3BTuRLLF6/WehWknVUbaFKUUcjGVKlg6yefTzrBD/gr5e792fEnnb7o/GXTuvtiyU+xH6SW6EVJFGAmW1HCmsPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F1S7HXyrnnBDfLnxyhm4/ID9LNtEdNNWZkn08qiD9RI=;
 b=Q/VzDd11noaCK/Uwjho8jafNeULKPxSpCASpQlB4gEe5TAWabnDckEs/TYWbEgIxwY2okbkhUkuRopnbvs1u65REvKkR+PBV1jbUtghMxHQ+5gU116miVd2JzYfOB8hBm+YFC2MAVRPTbmVn6PMLUCwA8b/QerFbxR5HU8NxmxbRSwyx5IqvRUaEIdQA9q1mgYHjBaua8f0Lts1jSxWxUv1R7LKgAxOQrIdIGXR2M7rbncbJLj0pNh/fsOTxpFvsIyitwujFauJ+pBip/0T9J2PYepI/RFEo0Ron2FriGOV1x1llI3PUVhsIRiL8pN21UT8+ffB2UdGxgI3Zj/L2ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F1S7HXyrnnBDfLnxyhm4/ID9LNtEdNNWZkn08qiD9RI=;
 b=Ro2wa3HuoM2uVQdjxEwQ7hJdiXs6sjkenHZVEHY3HXmHFdHge9fDGrCSiafPUaiQgT4bX5VektfefSocCDhUyCvXRrOlZOY44gibHUdc0PfDIjvI2MvtL+qM9rHMpfzaRrkg5KDo2JEKrLqKY6ffG+w3YUAtFr8e2XitvhgPE6nKYqyWMVMlhd7EXmZxkVysGodIQK4nm7X0Fz9yqK1ZFlfcMtGpO9IGF5vrh6GFDC1UrX6Dbay/iOgBANxov46W2lpR5Jd3X2sMAyd8BKgNXkl9hZFe7rfl86upd2i3H7TEkyjxmEL+l5N7w74jqLE1H2d7aJaDhzlMVf/UqnJwzg==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by SJ0PR02MB7165.namprd02.prod.outlook.com (2603:10b6:a03:298::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Mon, 12 Jan
 2026 15:54:51 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6%6]) with mapi id 15.20.9499.005; Mon, 12 Jan 2026
 15:54:51 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>
CC: "kys@microsoft.com" <kys@microsoft.com>, "haiyangz@microsoft.com"
	<haiyangz@microsoft.com>, "wei.liu@kernel.org" <wei.liu@kernel.org>,
	"decui@microsoft.com" <decui@microsoft.com>, "longli@microsoft.com"
	<longli@microsoft.com>, "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
	"kwilczynski@kernel.org" <kwilczynski@kernel.org>, "mani@kernel.org"
	<mani@kernel.org>, "robh@kernel.org" <robh@kernel.org>, "bhelgaas@google.com"
	<bhelgaas@google.com>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>
Subject: RE: [PATCH 1/1] PCI: hv: Remove unused field pci_bus in struct
 hv_pcibus_device
Thread-Topic: [PATCH 1/1] PCI: hv: Remove unused field pci_bus in struct
 hv_pcibus_device
Thread-Index: AQHcgxvbxTpq11Tjn06iuwMa8TiYF7VOmXKAgAAWCHA=
Date: Mon, 12 Jan 2026 15:54:51 +0000
Message-ID:
 <SN6PR02MB4157BFB422607900AC1EBD82D481A@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20260111170034.67558-1-mhklinux@outlook.com>
 <aWUFPUxrMkM32zDD@csail.mit.edu>
In-Reply-To: <aWUFPUxrMkM32zDD@csail.mit.edu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|SJ0PR02MB7165:EE_
x-ms-office365-filtering-correlation-id: 3c584ee9-5ba2-4b4e-7b4b-08de51f2ebbf
x-microsoft-antispam:
 BCL:0;ARA:14566002|461199028|15080799012|31061999003|51005399006|13091999003|19110799012|8062599012|8060799015|3412199025|440099028|40105399003|102099032;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?CXGzVGzZTXCql2JiVYiGzdIb23fhf/GN/GwoXm/HOifWK5rpXmBOYwMc1FjH?=
 =?us-ascii?Q?ruhAjsa7Qf7MPaAQwBqfu8yvQma3NA4kTLlU90jg7tVTbVr4oC2qs6P6ou8R?=
 =?us-ascii?Q?/LUchrphCnY/7kQ7YtmqnOx84GrgpOgySFQhUTvoA2QNL5jv+H0RYylV6G+R?=
 =?us-ascii?Q?hauicNngXxx018XjgCYYQFwkjLdzjFb/vNV7MP0p3EZSuDVj4JCKlYbF3EyA?=
 =?us-ascii?Q?Qm/oS0tEAdk4MjQkFri/ERH8NuG39OqyX0Bpl/pnpzvpg+Y8ggGkaud9KvGS?=
 =?us-ascii?Q?Wd9XsC5bNkqnduhg98Z1H1CF4t2iCbaarrvy8pLVP9VHVyDjB3sF7c5w1GKJ?=
 =?us-ascii?Q?l9jThVw7STrYjHpLvytLiNCevJ6cOWI1NzHnwu97LmIdXr/dpaXZyLQqF3Nx?=
 =?us-ascii?Q?WPMkTE2jgEPwnKARtRQ5UjU4g9AXq1ugX9pXeTY0HEMtEw4c6faOLf+07SFR?=
 =?us-ascii?Q?VXdIxBnrGRmrk+4Tl4ZxW2EjJYnd5jjl3zpVzU4OrYCVQnECx3CKkent2yGf?=
 =?us-ascii?Q?9bGNVi4AK9YY/mSr9CR6kRKmLXz/kZVLE8XdrP1TZTkO2LCtMcwtPLoEs9dW?=
 =?us-ascii?Q?ASq8OqB3KETnU1dhLPRb2KTXwWiVEKMi74fU9yRhSEOpXAaeUPMIFYfg7uFn?=
 =?us-ascii?Q?y8YFvGFRlKgbSXKskPTOMDRkEhpeTRBPm7ecZosvakW5sUwbifaFMXrlPzHG?=
 =?us-ascii?Q?OqKHuKA4NKFktVdpipnOkNFskc81Dqt0a1sPCn8NxksVfyCChrN/bLNXx1qF?=
 =?us-ascii?Q?fCg7YDPmM8r49D4V0HNVzN3wAiomZCBDx2hjXq5Qp45z1WaMHccIz35JGVZb?=
 =?us-ascii?Q?q6KDOy+jqBcwjg/9ZMO+NKcCjv0MN74Pm2fpU/QAVqC9UbGl2X6ZO/CYrnIA?=
 =?us-ascii?Q?y7zD7mYWPrKxcNjsQBilKVDaNcICz72+gHExMFT8oyGPqJAlSMfmZbKoL6F4?=
 =?us-ascii?Q?8+EW6WSGYmoDIH7Avpb3CgLBDsa/9P2sfqCvYIqN0eygVZSpFL5t6uMSVcaU?=
 =?us-ascii?Q?ZhdgjwYvDKNkMr2AgnVHylfAAHWC1Lja1fM81+MbTXLSZVqA48chqXc3sCCJ?=
 =?us-ascii?Q?Mvf4errut7++Kz+Uu5xUT7ElRZmi9reKYjhYXszUaJQGFV/g7eQO5c9AXudI?=
 =?us-ascii?Q?+YtgtFUWxIKwwJDdvarJBYqqLFDpVAHJyqWR1gv8gUdiXHrM2Z52eEfNvS5H?=
 =?us-ascii?Q?GzZ/ghRbctX7lIuIXRFXmOTRFgMllxfZypd7oA=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?wkIb0belKodLyRdXI9pCn+cTnWueiYKn6EgdsPV1Bo9iXzdWoZEgYjABFtxf?=
 =?us-ascii?Q?YDkNEi8+Pc6s3spCZzyK1hLtfzYhyMqGXpbUi90/9sk1VMXLWOwPHZrkLqOs?=
 =?us-ascii?Q?aRUVFlWmRgL3R5XLbHIGO/Hs0G+FFih+j2ex7qC75TRMpRoaq9qwwD64Iu3E?=
 =?us-ascii?Q?DWtlGe+oFcGyKlNEtW4TaeIIF724FfeO5EQUPhv5xKh1DqjoRWGQYx4Ofqw1?=
 =?us-ascii?Q?ssS1InKAGiztuNbCCnyTe/fLETGpD+97pWFrOg17o96dku45IAg9PtF391St?=
 =?us-ascii?Q?6oa/NZpYV14xo60jS9n7Uvrwff1NNbn9DJ5nypaz5Ht0UEZzBqonQt515MLo?=
 =?us-ascii?Q?+adw53tUVVnepmJdpwts2qBbgJJ9fXLhLw/YTilwlk6URXEHo0BozUiH9CM5?=
 =?us-ascii?Q?iTuDGdb+F0bB9liF3vlL4V3hfFQBShFioAnmk7+u3nwI9z6IvS7AwWMLaccb?=
 =?us-ascii?Q?xFpJquiUtW1FF/Xa2skcdDR72peGNrIlQlQWmiMp5jIwDaoKNnMpmRu7gQzO?=
 =?us-ascii?Q?pI1k4hrtD4QeywnCu1gEB4/4vh626DgsTKdM8nhiHu5PB2D+X/MtSI86fWQK?=
 =?us-ascii?Q?RczlI/AeNyfV6L6POEJ+DCEo3/jCjQ2XWwLmPJr+vvpKELV8rL6wibG39Rou?=
 =?us-ascii?Q?JmF2mldTToRL30UswB1tT5MuAAchTiD440kMsj7+pP4CL94yVX/5HT6zWAwZ?=
 =?us-ascii?Q?tEWUcJz7qixlkVvgCQkC8BwnLPlSac5hzBqcCY1CZ9PfAJwho3XH0qeakmUM?=
 =?us-ascii?Q?uu+kIxzIUo1w0kH0kAl5VjhfCYExtMz57DRWIleZsMMcWMRWAaWAfFbptzaH?=
 =?us-ascii?Q?2MHkHRQ/oSJ1sC6Mvqr076UjQ93IHLMvijDuHjJMuqH6dZCrUi9JJKOrXOjJ?=
 =?us-ascii?Q?5LLZ/2hHxm56mKqqsrqNTna/wbMYQcFgiGR8u3tHQI7bv0W8YR7fS/5Ufkww?=
 =?us-ascii?Q?LHrhVzY2dUvz8Kw0ELb+WAGCx0AXiBTedkEbnjgwtRamvn1Sgsqx7wjvHL/a?=
 =?us-ascii?Q?OC+1CwxAHP4ZQiajTAfmMd+ofHMxKM4L+GHQkDSfKFn+A20PuNdQKBUJIflE?=
 =?us-ascii?Q?tY/K5VQRKSCNVtPjEhUIUEQlYPD6LUra62LrYmAcfBT9gTfWLTKuM22QuCPj?=
 =?us-ascii?Q?epUC7Uw6hTCv0HDsenuP9kC34Y+fHRAtewea5PB8lmfIcauLb22wWDlRetUT?=
 =?us-ascii?Q?YbxRTwUnHY8i6Boj+lAaTZcE+ejEyMUCfwuTLXDlhb0eWIzR8GgNbT7VAKo0?=
 =?us-ascii?Q?wdYCWezHtvT0uQHCi519mALaQRnAMzDbUZsH9u4xMyugZNlEua4fWFJT0T2z?=
 =?us-ascii?Q?JF20j7OxxX7zAW525c19idk3kM6TGU0tfGuvl6r2PkD3vack7scFc2s+PTjN?=
 =?us-ascii?Q?QYM30mQ=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c584ee9-5ba2-4b4e-7b4b-08de51f2ebbf
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jan 2026 15:54:51.1994
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB7165

From: Srivatsa S. Bhat <srivatsa@csail.mit.edu> Sent: Monday, January 12, 2=
026 6:29 AM
> Hi Michael,
>=20
> On Sun, Jan 11, 2026 at 09:00:34AM -0800, mhkelley58@gmail.com wrote:
> > From: Michael Kelley <mhklinux@outlook.com>
> >
> > Field pci_bus in struct hv_pcibus_device is unused since
> > commit 418cb6c8e051 ("PCI: hv: Generify PCI probing"). Remove it.
> >
>=20
> Since that commit is several years old (2021), I was curious if this was =
found by
> manual inspection or if the compiler was able to flag the unused
> variable as well.

Code inspection. I was brushing up on how the structs defined
in pci-hyperv.c relate to the standard Linux PCI struct pci_bus and
struct pci_dev. Having a pointer to struct pci_bus in struct
hv_pcibus_device makes sense, and I was a bit surprised to find
it's not set or used. Instead, the PCI bus is always found through
the PCI bridge.

Michael

>=20
> > No functional change.
> >
> > Signed-off-by: Michael Kelley <mhklinux@outlook.com>
>=20
> Reviewed-by: Srivatsa S. Bhat (Microsoft) <srivatsa@csail.mit.edu>
>=20
> Regards,
> Srivatsa
> Microsoft Linux Systems Group
>=20
> > ---
> >  drivers/pci/controller/pci-hyperv.c | 1 -
> >  1 file changed, 1 deletion(-)
> >
> > diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controll=
er/pci-hyperv.c
> > index 1e237d3538f9..7fcba05cec30 100644
> > --- a/drivers/pci/controller/pci-hyperv.c
> > +++ b/drivers/pci/controller/pci-hyperv.c
> > @@ -501,7 +501,6 @@ struct hv_pcibus_device {
> >  	struct resource *low_mmio_res;
> >  	struct resource *high_mmio_res;
> >  	struct completion *survey_event;
> > -	struct pci_bus *pci_bus;
> >  	spinlock_t config_lock;	/* Avoid two threads writing index page */
> >  	spinlock_t device_list_lock;	/* Protect lists below */
> >  	void __iomem *cfg_addr;
> > --
> > 2.25.1
> >
> >

