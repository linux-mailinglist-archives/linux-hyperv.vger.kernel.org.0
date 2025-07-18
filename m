Return-Path: <linux-hyperv+bounces-6283-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EED6B09A0A
	for <lists+linux-hyperv@lfdr.de>; Fri, 18 Jul 2025 05:04:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F31CE189B7BF
	for <lists+linux-hyperv@lfdr.de>; Fri, 18 Jul 2025 03:04:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FB741922DD;
	Fri, 18 Jul 2025 03:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="ApRxua3G"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azolkn19010018.outbound.protection.outlook.com [52.103.12.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EF2C143756;
	Fri, 18 Jul 2025 03:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.12.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752807837; cv=fail; b=DyZLUeOgM0x83I3PgPwZzsBf41aJADdZk/tPhqBM0+uj3F7mkUpdgtVQ1nU04YIJvKicaf/SepLDz/MKdGkfKSUtKEczloT36+vvn0WygNySgVmcOmZHkgt4p/TQgfpRSzzb9SGL/miVenss1GTw2wO3Tsx8QbJEO+ER/Hk3hiw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752807837; c=relaxed/simple;
	bh=BuP8FXzSXX7TXyojF7dSpbR0DUx7CtI9t7yw1vpHfOg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ticjOxuMnAo1ZUi+z0RA7j1kiYW1iJHZYpt9RFLMLgl0KB73oY2d94NKBTmn8/mQfUFlG1iY0tdq6CIj/Ge5wzkGL1qD+esKt9K252NStRxBy/q7E82u6CaGB4k7m9qmWZ8zT0o5tBTIimuFP1gNOjIEN5k7BffYBljTp8J1W2Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=ApRxua3G; arc=fail smtp.client-ip=52.103.12.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WKd4Fh72Yitrkv6Y0PUbnfNNPZSIzpcNyw7+hFts974hkrE4utRMo9Q2aeO2i9iYZ4dEt2PSZ7hAdgz3Rqh6aseT11vqKprvl/Zk4wS6BQut7o8WzE6pVlmce7PuexbAQ0cwrzMqQhEiG2qiuOTna1WSrK7XLwBUCqOTtSNHFWUrijQdAnxOTvry0ZkWjkrJWtuyB1NROeyQV1XI3CKt5VvdkJsAhPCxEe012VP7liLJGWGvwRLrCnQK8W+nUGXAxy7ohNLtVXUXH0aABsczFekCpMRxczpLratVNzEeoacPv26zO+XWM2DYOWf+G9dss5QIVcxxdxJLG8pATYpM/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bEbjkySHJBPQ0qG9SXEwGU7DwKCaqZ01wgXVh8zQmtY=;
 b=BYv+0ijZS5EIOouWYOS1DQtLAfXZYj8aIDp5jqzmwlnqSNRQj0xy9WdZ4dhTCOlp2aV7eEsEtio/SVJPesjWprE+hA/GiY7TxKLw1LvThn5wGMoC/SP8Xemej0ve6NyFbnTj1fO4BTntHo2W5+ztrIJy3t+G6I9P15ceoxCLC5uGe08pnwbZclJl2vL3oCmWezBO3ph9soGARsXYXcN7DkjBbdpblL02/Nhh8pdUM1JXiWVZITUCXDm0FIyBf+wGKWdRcfabKhm781Rfrgn7V46u7fHIenhRUX4mj7KU5hkfnLBXGRuASbBFVHZTNu/CUtKxkHKWhVt80JZCdrh33Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bEbjkySHJBPQ0qG9SXEwGU7DwKCaqZ01wgXVh8zQmtY=;
 b=ApRxua3G0C75pYXZnmyK2LZ2Byg+36xZgD4vdj6Gd4h4u5+YS250s4fBJYXD5rmIziRN4FAZIexQ6H7URKTWKlhSVWUsbV9apwLdc8WepIl1CYe7WvgYuWVmOYtNzRiHKo+SXTLDhtbtYwlr0Ex2FloaNX/SmagtbWGVXb75t3pO4IxFz+h71+GcR8Iflf39540AYha+/0EfzkHEPzqOtx+urcQWdLIP5ne4G9KlMg+G5z2jFKbbNllH6PfR1hqKddsJGCz5Ry7yfyWytzex0klp3O0mm4axlocluI44yNGw1BtXwOb2awqkIzyi7RGPSasAQI7seD2EUdfYR2aH9g==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by SA0PR02MB7195.namprd02.prod.outlook.com (2603:10b6:806:e5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.39; Fri, 18 Jul
 2025 03:03:52 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%4]) with mapi id 15.20.8901.018; Fri, 18 Jul 2025
 03:03:52 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
	"bhelgaas@google.com" <bhelgaas@google.com>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "lukas@wunner.de"
	<lukas@wunner.de>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Jonathan.Cameron@huawei.com"
	<Jonathan.Cameron@huawei.com>, Suzuki K Poulose <suzuki.poulose@arm.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Rob Herring <robh@kernel.org>, "K.
 Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, "open
 list:Hyper-V/Azure CORE AND DRIVERS" <linux-hyperv@vger.kernel.org>
Subject: RE: [PATCH 2/3] PCI: Enable host bridge emulation for
 PCI_DOMAINS_GENERIC platforms
Thread-Topic: [PATCH 2/3] PCI: Enable host bridge emulation for
 PCI_DOMAINS_GENERIC platforms
Thread-Index: AQHb9mxHNLZ4mIcOKESVNMsMHoF1RbQ2iGhggAA1PoCAACnmIIAAH9IAgAAkusA=
Date: Fri, 18 Jul 2025 03:03:52 +0000
Message-ID:
 <SN6PR02MB4157A7F41F299608E605E0C5D450A@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20250716160835.680486-1-dan.j.williams@intel.com>
 <20250716160835.680486-3-dan.j.williams@intel.com>
 <SN6PR02MB4157ADD06608EFE00B86A3F7D451A@SN6PR02MB4157.namprd02.prod.outlook.com>
 <68795609847f7_137e6b100d8@dwillia2-xfh.jf.intel.com.notmuch>
 <SN6PR02MB4157E31D8448CD9D81D518C5D451A@SN6PR02MB4157.namprd02.prod.outlook.com>
 <687993e03bb4c_14c3561008c@dwillia2-xfh.jf.intel.com.notmuch>
In-Reply-To: <687993e03bb4c_14c3561008c@dwillia2-xfh.jf.intel.com.notmuch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|SA0PR02MB7195:EE_
x-ms-office365-filtering-correlation-id: 018bf31b-4e8b-44a8-c718-08ddc5a7b9d6
x-microsoft-antispam:
 BCL:0;ARA:14566002|41001999006|461199028|15080799012|3412199025|4302099013|440099028|40105399003|12091999003|30101999003|10035399007|102099032|56899033|1602099012;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?/TvJ3PGrJL2lxzrdDMgPuiVl9T8NsudSHECl43fX9xZyFKnpz1LDn8aLpxlk?=
 =?us-ascii?Q?S/7/vwnvojNCc0LZ7p1QRiGMYcCLJ3WDWRAtlqugYgXmFfN4AjF3DtxdRNRa?=
 =?us-ascii?Q?Xe7YUDvpDhwoL2mlHMMS6l2XbGkB5dvJ/oRxrvVN0RUJm32n7vnpPlsDUOCP?=
 =?us-ascii?Q?+Jk0PWxPt/Xq0Gin8OCqF/voFBz4iOISCFOpQSem7Jh94W20wX46/DLF4uD4?=
 =?us-ascii?Q?tzyAxNnzOuKGM+y57lAnhGdVKlBTySRRHm47HLExNuzFfbg1+umeHhYnX+8x?=
 =?us-ascii?Q?964+VVhK/2as+Ymdg0u2oWAxnOesDxjamG8EagtvKeM7BAGgn1F7a/+PJIH9?=
 =?us-ascii?Q?VJLf3iieH9TeU2Aw1K4IBKZ3tIrf8i6C+RKAnnBw7VygT5z4vVa56S8EWFjq?=
 =?us-ascii?Q?FC1leb2deLEhikGPQOtTcMgXEwKQsSW5vE8Nfkuz8nsByOmibSzNcT35jYzX?=
 =?us-ascii?Q?i7tq0q3aVKfDA6HTMqVCOgDJ6eZMwBGeb7TYK5Pb0XBc+4nel+svEAbRVjDP?=
 =?us-ascii?Q?hBLlig+hfX9DBfEdzOdYvWdhGc0z7SrV23xdUKPZtwpLzc7ZM9x3Z3kuWNrw?=
 =?us-ascii?Q?kjHdidEeSXLW39birixEQTta4yhoYs6k8FnqJoJcM9wnRhD8IBQdpdf144yl?=
 =?us-ascii?Q?iQreItWyme2JemGFpG+531Tz8sFlEKzaHZsW/0rRHm2tyHrRvvxJ4F8ouICf?=
 =?us-ascii?Q?Mt+QfSvFSD0zC3gwLsuUFAmJXyXh1wE3x6Tj4lrsezcPfLo2n95bkLs6tmU9?=
 =?us-ascii?Q?fUnNruhwJOOA4Hvq+pRMuy2aQrKRsASYgDqZjFpBsZHBBwHLdRNbOmGxD1H/?=
 =?us-ascii?Q?vcdOdt7fG+HUV4lTzjNrjq8jTa3aOPLFu85yU07TrKH4I7+lWvk8YUxJDiab?=
 =?us-ascii?Q?ggGeVas5DQyigSp1IiR+S9BCZpp3hX5kBhOlVnic8yw2cLRZvW2kelv0qCJU?=
 =?us-ascii?Q?0JldMAanf+mYuvvucQnGQAA6atuZCVcwWiU3EmYJhino/eQ9w/2R3L1skpqa?=
 =?us-ascii?Q?1a4pyjWuXHKc1dxf9dOwY0jnStvM1+lnLcDrkRroZJ8cyfbZVxF9pfjraYXf?=
 =?us-ascii?Q?IBrdmoLFcnKBnQqubEeDk9VoWE9Y+6T2Ew9TEiIgx4EArjV3QzPgfzY98apv?=
 =?us-ascii?Q?/duq0k6ICUcUz8VPAFssQ5/wAnfKMtnUeYuMLgSZ61kmrGlZoo+MmRtrEHXH?=
 =?us-ascii?Q?lTV/a7TjXpXARi4y?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?i1+dI7mCU5sSceAQp4YTIGf+CqlAWEzKUJcjHfhZjoNbqA3M5LdAlL1t1aPF?=
 =?us-ascii?Q?yqHe0RLqnSJH5yFNSBgOlIr/9T275pBEYXd13fWfKtfwpY2TxNTBUW48sRX6?=
 =?us-ascii?Q?Npp4bO/Th8vZj4vWsqOZjiF0E1OLdtpGEQkWczsVHhLvdHDm01oGntcyfkrG?=
 =?us-ascii?Q?A5vqFUMS63I8w9KRe8Iuog8wKYGS+1/GrxLTmP5vqAmHpWcemhMvHZYVjU9v?=
 =?us-ascii?Q?61CjhFAobN8KVAKq48IwWP9OTfUBFqnWWVT4M7SuWQoG1zIk788opRyqtrod?=
 =?us-ascii?Q?8EybchDG4LFX2naQrKnRSAm1Zivi6dvGWU2ArHu1Tbo8686Il4cwT5kgaqYT?=
 =?us-ascii?Q?+8F7oqDTsRggpUojKoQ/rac5A8g+0CMT+lNE2Z3uPrPAaepVoryNfMqg3xvB?=
 =?us-ascii?Q?B9UIoTU4VC8SX7hMMlQnf5XhwDd7UKVSgE+eBKD09InVxPoKV7bzB+u0RZYO?=
 =?us-ascii?Q?YDvpNDPpIkR4Bniw4Zmr14HfEcXgqS8cnBCOEphge7BHmBVVNNrXUAILlnEj?=
 =?us-ascii?Q?wygHOTSIGEzYnG6D6EjrTlYg/UfRwJ4YPtNC2oW/itsHUnLu/RZzr1GFeboU?=
 =?us-ascii?Q?/qt5Y/MuRCk7qPmCcI/jkz0iLazQCZB5V3YFGqKowND4fxiLEMXn0v8PI1Ie?=
 =?us-ascii?Q?KrZghpZ2gxqjavaa+8ohnP8T+vnu3/wL+xA50/V412XLfCb5LA+2n+pINc/F?=
 =?us-ascii?Q?BL9F2G/SlsuXVDJm3s10FvAcRYTIeHTC1lEOg0VhzTulppr5OmZhlbNMgMOw?=
 =?us-ascii?Q?cZw1eIaEJqzCxG2QG2WHdd8DCo/Cyu096tI9Uj02XCLEaKtZDsZZ9KKjwvO5?=
 =?us-ascii?Q?mTPbY9BkeDxF7jue9lKh6lYacbVm84tJptwILd4Krh2rcKW+8IQzMtTYHGpb?=
 =?us-ascii?Q?y2+r5wOP3QgrSgOEj0tLYKBhqS8m/IF1ippmaSSgKN+BJvGCY/zy3U0UrIxu?=
 =?us-ascii?Q?pJBi3yuIbIkfAX17uE4mr9jVuo1Qm4IWKQqvYpkj171pY8fh+HVqS60yF9M5?=
 =?us-ascii?Q?uI1HEHrSUYgqCpBGT+jZ2vJj7n56znfxMdyfuf3XO3qToQNDdq+0S12MMwvo?=
 =?us-ascii?Q?u34uSVRtfjSR5rQAjqGs4fJpWC53eTWHS4nykVROU29rTrV0eRLo4XpBpDbM?=
 =?us-ascii?Q?sXss6zATgCfqYCbEF0U2wHWCEG1Ksbw903xzNlri+P0xeLRBHFdd8mQ98InA?=
 =?us-ascii?Q?AXSE8PXtTDq/u2HZjjP3pIjqnpkJEz7dqiOCPGtKkLudsRnhsdcX6MT8xkQ?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 018bf31b-4e8b-44a8-c718-08ddc5a7b9d6
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jul 2025 03:03:52.4078
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR02MB7195

From: dan.j.williams@intel.com <dan.j.williams@intel.com> Sent: Thursday, J=
uly 17, 2025 5:23 PM
>=20
> Michael Kelley wrote:
> > From: dan.j.williams@intel.com <dan.j.williams@intel.com> Sent: Thursda=
y, July 17, 2025 12:59 PM
> > >
> > > Michael Kelley wrote:
> > > > From: Dan Williams <dan.j.williams@intel.com> Sent: Wednesday, July=
 16, 2025 9:09 AM
> > >
> > > Thanks for taking a look Michael!
> > >
> > > [..]
> > > > > diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> > > > > index e9448d55113b..833ebf2d5213 100644
> > > > > --- a/drivers/pci/pci.c
> > > > > +++ b/drivers/pci/pci.c
> > > > > @@ -6692,9 +6692,50 @@ static void pci_no_domains(void)
> > > > >  #endif
> > > > >  }
> > > > >
> > > > > +#ifdef CONFIG_PCI_DOMAINS
> > > > > +static DEFINE_IDA(pci_domain_nr_dynamic_ida);
> > > > > +
> > > > > +/*
> > > > > + * Find a free domain_nr either allocated by pci_domain_nr_dynam=
ic_ida or
> > > > > + * fallback to the first free domain number above the last ACPI =
segment number.
> > > > > + * Caller may have a specific domain number in mind, in which ca=
se try to
> > > > > + * reserve it.
> > > > > + *
> > > > > + * Note that this allocation is freed by pci_release_host_bridge=
_dev().
> > > > > + */
> > > > > +int pci_bus_find_emul_domain_nr(int hint)
> > > > > +{
> > > > > +	if (hint >=3D 0) {
> > > > > +		hint =3D ida_alloc_range(&pci_domain_nr_dynamic_ida, hint, hin=
t,
> > > > > +				       GFP_KERNEL);
> > > >
> > > > This almost preserves the existing functionality in pci-hyperv.c. B=
ut if the
> > > > "hint" passed in is zero, current code in pci-hyperv.c treats that =
as a
> > > > collision and allocates some other value. The special treatment of =
zero is
> > > > necessary per the comment with the definition of HVPCI_DOM_INVALID.
> > > >
> > > > I don't have an opinion on whether the code here should treat a "hi=
nt"
> > > > of zero as invalid, or whether that should be handled in pci-hyperv=
.c.
> > >
> > > Oh, I see what you are saying. I made the "hint =3D=3D 0" case start =
working
> > > where previously it should have failed. I feel like that's probably b=
est
> > > handled in pci-hyperv.c with something like the following which also
> > > fixes up a regression I caused with @dom being unsigned:
> > >
> > > diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/contro=
ller/pci-hyperv.c
> > > index cfe9806bdbe4..813757db98d1 100644
> > > --- a/drivers/pci/controller/pci-hyperv.c
> > > +++ b/drivers/pci/controller/pci-hyperv.c
> > > @@ -3642,9 +3642,9 @@ static int hv_pci_probe(struct hv_device *hdev,
> > >  {
> > >  	struct pci_host_bridge *bridge;
> > >  	struct hv_pcibus_device *hbus;
> > > -	u16 dom_req, dom;
> > > +	int ret, dom =3D -EINVAL;
> > > +	u16 dom_req;
> > >  	char *name;
> > > -	int ret;
> > >
> > >  	bridge =3D devm_pci_alloc_host_bridge(&hdev->device, 0);
> > >  	if (!bridge)
> > > @@ -3673,7 +3673,8 @@ static int hv_pci_probe(struct hv_device *hdev,
> > >  	 * collisions) in the same VM.
> > >  	 */
> > >  	dom_req =3D hdev->dev_instance.b[5] << 8 | hdev->dev_instance.b[4];
> > > -	dom =3D pci_bus_find_emul_domain_nr(dom_req);
> > > +	if (dom_req)
> > > +		dom =3D pci_bus_find_emul_domain_nr(dom_req);
> >
> > No, I don't think this is right either. If dom_req is 0, we don't want =
to
> > hv_pci_probe() to fail. We want the "collision" path to be taken so tha=
t
> > some other unused PCI domain ID is assigned. That could be done by
> > passing -1 as the hint to pci_bus_bind_emul_domain_nr(). Or PCI
> > domain ID 0 could be pre-reserved in init_hv_pci_drv() like is done
> > with HVPCI_DOM_INVALID in current code.
>=20
> Yeah, I realized that shortly after sending. I will slow down.
>=20
> > >
> > > A couple observations:
> > >
> > > - I think it would be reasonable to not fallback in the hint case wit=
h
> > >   something like this:
> >
> > We *do* need the fallback in the hint case. If the hint causes a collis=
ion
> > (i.e., another device is already using the hinted PCI domain ID), then =
we
> > need to choose some other PCI domain ID. Again, we don't want hv_pci_pr=
obe()
> > to fail for the device because the value of bytes 4 and 5 chosen from d=
evice's
> > GUID (as assigned by Hyper-V) accidently matches bytes 4 and 5 of some =
other
> > device's GUID. Hyper-V guarantees the GUIDs are unique, but not bytes 4=
 and
> > 5 standing alone. Current code behaves like the acpi_disabled case in y=
our
> > patch, and picks some other unused PCI domain ID in the 1 to 0xFFFF ran=
ge.
>=20
> Ok, that feels like "let the caller set the range in addition to the
> hint".
>=20
> >
> > >
> > > diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> > > index 833ebf2d5213..0bd2053dbe8a 100644
> > > --- a/drivers/pci/pci.c
> > > +++ b/drivers/pci/pci.c
> > > @@ -6705,14 +6705,10 @@ static DEFINE_IDA(pci_domain_nr_dynamic_ida);
> > >   */
> > >  int pci_bus_find_emul_domain_nr(int hint)
> > >  {
> > > -	if (hint >=3D 0) {
> > > -		hint =3D ida_alloc_range(&pci_domain_nr_dynamic_ida, hint, hint,
> > > +	if (hint >=3D 0)
> > > +		return ida_alloc_range(&pci_domain_nr_dynamic_ida, hint, hint,
> > >  				       GFP_KERNEL);
> > >
> > > -		if (hint >=3D 0)
> > > -			return hint;
> > > -	}
> > > -
> > >  	if (acpi_disabled)
> > >  		return ida_alloc(&pci_domain_nr_dynamic_ida, GFP_KERNEL);
> > >
> > > - The VMD driver has been allocating 32-bit PCI domain numbers since
> > >   v4.5 185a383ada2e ("x86/PCI: Add driver for Intel Volume Management
> > >   Device (VMD)"). At a minimum if it is still a problem, it is a shar=
ed
> > >   problem, but the significant deployment of VMD in the time likely
> > >   indicates it is ok. If not, the above change at least makes the
> > >   hyper-v case avoid 32-bit domain numbers.
> >
> > The problem we encountered in 2018/2019 was with graphics devices
> > and the Xorg X Server, specifically with the PCI domain ID stored in
> > xorg.conf to identify the graphics device that the X Server was to run
> > against. I don't recall ever seeing a similar problem with storage or N=
IC
> > devices, but my memory could be incomplete. It's plausible that user
> > space code accessing the VMD device correctly handled 32-bit domain
> > IDs, but that's not necessarily an indicator for user space graphics
> > software. The Xorg X Server issues would have started somewhere after
> > commit 4a9b0933bdfc in the 4.11 kernel, and were finally fixed in the 5=
.4
> > kernel with commits be700103efd10 and f73f8a504e279.
> >
> > All that said, I'm not personally averse to trying again in assigning a
> > domain ID > 0xFFFF. I do see a commit [1] to fix libpciaccess that was
> > made 7 years ago in response to the issues we were seeing on Hyper-V.
> > Assuming those fixes have propagated into using packages like X Server,
> > then we're good. But someone from Microsoft should probably sign off
> > on taking this risk. I retired from Microsoft nearly two years ago, and
> > meddle in things from time-to-time without the burden of dealing
> > with customer support issues. ;-)
>=20
> Living the dream! Extra thanks for taking a look.
>=20
> > [1] https://gitlab.freedesktop.org/xorg/lib/libpciaccess/-/commit/a167b=
d6474522a709ff3cbb00476c0e4309cb66f >=20
> Thanks for this.
>=20
> I would rather do the equivalent conversion for now because 7 years old
> is right on the cusp of "someone might still be running that with new
> kernels".

Works for me, and is a bit less risky.

>=20
> Here is the replacement fixup that I will fold in if it looks good to
> you:
>=20
> -- 8< --
> diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller=
/pci-hyperv.c
> index cfe9806bdbe4..f1079a438bff 100644
> --- a/drivers/pci/controller/pci-hyperv.c
> +++ b/drivers/pci/controller/pci-hyperv.c
> @@ -3642,9 +3642,9 @@ static int hv_pci_probe(struct hv_device *hdev,
>  {
>  	struct pci_host_bridge *bridge;
>  	struct hv_pcibus_device *hbus;
> -	u16 dom_req, dom;
> +	int ret, dom;
> +	u16 dom_req;
>  	char *name;
> -	int ret;
>=20
>  	bridge =3D devm_pci_alloc_host_bridge(&hdev->device, 0);
>  	if (!bridge)
> @@ -3673,8 +3673,7 @@ static int hv_pci_probe(struct hv_device *hdev,
>  	 * collisions) in the same VM.
>  	 */
>  	dom_req =3D hdev->dev_instance.b[5] << 8 | hdev->dev_instance.b[4];
> -	dom =3D pci_bus_find_emul_domain_nr(dom_req);
> -

As an additional paragraph the larger comment block above, let's include a
massaged version of the comment associated with HVPCI_DOM_INVALID.
Perhaps:

 *
 * Because Gen1 VMs use domain 0, don't allow picking domain 0 here, even
 * if bytes 4 and 5 of the instance GUID are both zero.
 */

> +	dom =3D pci_bus_find_emul_domain_nr(dom_req, 1, U16_MAX);
>  	if (dom < 0) {
>  		dev_err(&hdev->device,
>  			"Unable to use dom# 0x%x or other numbers", dom_req);
> diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
> index f60244ff9ef8..30935fe85af9 100644
> --- a/drivers/pci/controller/vmd.c
> +++ b/drivers/pci/controller/vmd.c
> @@ -881,7 +881,14 @@ static int vmd_enable_domain(struct vmd_dev *vmd, un=
signed long features)
>  	pci_add_resource_offset(&resources, &vmd->resources[2], offset[1]);
>=20
>  	sd->vmd_dev =3D vmd->dev;
> -	sd->domain =3D pci_bus_find_emul_domain_nr(PCI_DOMAIN_NR_NOT_SET);
> +
> +	/*
> +	 * Emulated domains start at 0x10000 to not clash with ACPI _SEG
> +	 * domains.  Per ACPI r6.0, sec 6.5.6,  _SEG returns an integer, of
> +	 * which the lower 16 bits are the PCI Segment Group (domain) number.
> +	 * Other bits are currently reserved.
> +	 */
> +	sd->domain =3D pci_bus_find_emul_domain_nr(0, 0x10000, INT_MAX);
>  	if (sd->domain < 0)
>  		return sd->domain;
>=20
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 833ebf2d5213..de42e53f07d0 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -6695,34 +6695,15 @@ static void pci_no_domains(void)
>  #ifdef CONFIG_PCI_DOMAINS
>  static DEFINE_IDA(pci_domain_nr_dynamic_ida);
>=20
> -/*
> - * Find a free domain_nr either allocated by pci_domain_nr_dynamic_ida o=
r
> - * fallback to the first free domain number above the last ACPI segment =
number.
> - * Caller may have a specific domain number in mind, in which case try t=
o
> - * reserve it.
> - *
> - * Note that this allocation is freed by pci_release_host_bridge_dev().
> +/**
> + * pci_bus_find_emul_domain_nr() - allocate a PCI domain number per cons=
traints
> + * @hint: desired domain, 0 if any id in the range of @min to @max is ac=
ceptable
> + * @min: minimum allowable domain
> + * @max: maximum allowable domain, no ids higher than INT_MAX will be re=
turned
>   */
> -int pci_bus_find_emul_domain_nr(int hint)
> +u32 pci_bus_find_emul_domain_nr(u32 hint, u32 min, u32 max)

Shouldn't the return type here still be "int"?  ida_alloc_range() can retur=
n a negative
errno if it fails. And the call sites in hv_pci_probe() and vmd_enable_doma=
in()
store the return value into an "int".

Other than that, and my suggested added comment, this looks good.

Michael

>  {
> -	if (hint >=3D 0) {
> -		hint =3D ida_alloc_range(&pci_domain_nr_dynamic_ida, hint, hint,
> -				       GFP_KERNEL);
> -
> -		if (hint >=3D 0)
> -			return hint;
> -	}
> -
> -	if (acpi_disabled)
> -		return ida_alloc(&pci_domain_nr_dynamic_ida, GFP_KERNEL);
> -
> -	/*
> -	 * Emulated domains start at 0x10000 to not clash with ACPI _SEG
> -	 * domains.  Per ACPI r6.0, sec 6.5.6,  _SEG returns an integer, of
> -	 * which the lower 16 bits are the PCI Segment Group (domain) number.
> -	 * Other bits are currently reserved.
> -	 */
> -	return ida_alloc_range(&pci_domain_nr_dynamic_ida, 0x10000, INT_MAX,
> +	return ida_alloc_range(&pci_domain_nr_dynamic_ida, max(hint, min), max,
>  			       GFP_KERNEL);
>  }
>  EXPORT_SYMBOL_GPL(pci_bus_find_emul_domain_nr);
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index f6a713da5c49..4aeabe8e2f1f 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -1934,13 +1934,16 @@ DEFINE_GUARD(pci_dev, struct pci_dev *,
> pci_dev_lock(_T), pci_dev_unlock(_T))
>   */
>  #ifdef CONFIG_PCI_DOMAINS
>  extern int pci_domains_supported;
> -int pci_bus_find_emul_domain_nr(int hint);
> +u32 pci_bus_find_emul_domain_nr(u32 hint, u32 min, u32 max);
>  void pci_bus_release_emul_domain_nr(int domain_nr);
>  #else
>  enum { pci_domains_supported =3D 0 };
>  static inline int pci_domain_nr(struct pci_bus *bus) { return 0; }
>  static inline int pci_proc_domain(struct pci_bus *bus) { return 0; }
> -static inline int pci_bus_find_emul_domain_nr(int hint) { return 0; }
> +static inline u32 pci_bus_find_emul_domain_nr(u32 hint, u32 min, u32 max=
)
> +{
> +	return 0;
> +}
>  static inline void pci_bus_release_emul_domain_nr(int domain_nr) { }
>  #endif /* CONFIG_PCI_DOMAINS */
>=20

