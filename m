Return-Path: <linux-hyperv+bounces-5287-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 077F5AA610B
	for <lists+linux-hyperv@lfdr.de>; Thu,  1 May 2025 17:57:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B4A4C4A639F
	for <lists+linux-hyperv@lfdr.de>; Thu,  1 May 2025 15:57:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 544B7214A64;
	Thu,  1 May 2025 15:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="EiQjXGII"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazolkn19012054.outbound.protection.outlook.com [52.103.20.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B10C20C490;
	Thu,  1 May 2025 15:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.20.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746115013; cv=fail; b=dXmFroBeD5pQbrY8QcCzocfnpXWTf+mvPSfUVVrYI9ZIP6AobPqKaJ+PvPvgrCAU1utZm+S9UMvVmpTj9cNcaXScOCHM8ztjwtvAzCOdcUz0HDo2KAVDcA5Ty1XWtp4G2rhe7pLcmgRBU8+FJfzpFm21wjFzc3DksTUYKNiGOdk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746115013; c=relaxed/simple;
	bh=YoFGgGwJ7/q6ZO/iYentb517lxZ7xkE1tKk9uMvwuks=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ED5s1dipoNYqcc3v5iyY3fimIw8iYy+Spurv6iFAg95F99JjLB27d5rVtBidlC4VZuBvFXM+2H6WKklbCUt+hBwvFU8Fniu+KkFFQMkWGj06gO1hFs2MamY1Vkl0qDk3kN9no1TVAmDpWVlUX2kxEnMcAD91DmP0DGXzemTeN18=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=EiQjXGII; arc=fail smtp.client-ip=52.103.20.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xk5qNLYBtQ2G5vIBHjjRlpB2Nyf4Dg1U0bYe/CbesYOjBfZqIHHe1FUfC+1DhScW228fQmRc3ZV8cdUHNxygQSTYzplrvbcnSBLSfvAepyVuK9HQs8jbIrCi8O2Cj7CdjCcwdWW+wiQI07G2HsDfvavbs9W+pPPkDurLycYJB7QD1CklZtigt94bFAvIjBmiRWx9h9kGzAi6PvXPfa8r8XlDoc7RqevbIKwzJG+9gI+cJ2abaLsj0pLZkI+47HeQsyGJup3Gj+nDG6B3hGLR81saGvbBD1vr8Q5NHGI4KYIuf+itRlDqpDFgThw60biErMGHQH/druEZL1fiigm+Lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O/74U5nNzfit5FyjKj3I1mSEaTY/oRDXiy0YWiJKgSA=;
 b=k5B6rduCjRsgMXiHj/mp/7730m72ILOI6v6t5NKg+6nqOQz+fRsUgNfp9dfjmo9z6bdi3FTGos4hfeV3wdT6EyVqU7e50UFwJB3taED4zlNVkgjg+IOoyQQ2EGgbCEyloe62TqnfZsVJ1+PEaxcWVNgvyNfbOCOj4biCDXINLmPXg6SAZRZ7h/coy0LhxFNii5bYBhUGw6GltLgMAxqsPq3UT4Ta1kfOkTLkCdUkyTBEWRtIAsHeKRb0Pfn0viNdbX87K0D1AaBEZMWZ37gFsettSeJimh50UNXxaHQP3d+ErKC9hoKoivy72PI1W0bBfgmzhe3vymlY+Et/pXGR1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O/74U5nNzfit5FyjKj3I1mSEaTY/oRDXiy0YWiJKgSA=;
 b=EiQjXGIIEvqpz0Y9vX4hz05SSOfRlMbFNOaLFx317iej0uf+1f3tWvqoMsA6mwJ1K0a9mU3sDQEGJbk9s0aY5jIVvf+SaKywffigEPm6/Vv9Fr+Tjc00G2DUBOo9AqPnjqhgU/cTRC4F073t1zPl4Umz8cPMqeu0t8TcBf9gtKH8KWeCOhFEDfHwnBA/mQ8PpRlj2lXANgiea4QB2gEfUPze8B8hHzkODh0gSZNBqg0K7xpjSQInrwtWHIFCeOf60vu8SNmbIJc44S7keiHKwSzfcfmlGAOEUBqqX1AqCKBUu9D1KjRFLS3mWsODibcqz7B1FMdWdz//+thfdekhgg==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by DM4PR02MB9192.namprd02.prod.outlook.com (2603:10b6:8:108::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.18; Thu, 1 May
 2025 15:56:48 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%3]) with mapi id 15.20.8699.008; Thu, 1 May 2025
 15:56:48 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Shradha Gupta <shradhagupta@linux.microsoft.com>
CC: "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Nipun Gupta
	<nipun.gupta@amd.com>, Yury Norov <yury.norov@gmail.com>, Jason Gunthorpe
	<jgg@ziepe.ca>, Jonathan Cameron <Jonathan.Cameron@huwei.com>, Anna-Maria
 Behnsen <anna-maria@linutronix.de>, Kevin Tian <kevin.tian@intel.com>, Long
 Li <longli@microsoft.com>, Thomas Gleixner <tglx@linutronix.de>, Bjorn
 Helgaas <bhelgaas@google.com>, Rob Herring <robh@kernel.org>, Manivannan
 Sadhasivam <manivannan.sadhasivam@linaro.org>, Krzysztof Wilczy?ski
	<kw@linux.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, Dexuan Cui
	<decui@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Haiyang Zhang
	<haiyangz@microsoft.com>, "K. Y. Srinivasan" <kys@microsoft.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Konstantin Taranov <kotaranov@microsoft.com>, Simon
 Horman <horms@kernel.org>, Leon Romanovsky <leon@kernel.org>, Maxim Levitsky
	<mlevitsk@redhat.com>, Erni Sri Satya Vennela <ernis@linux.microsoft.com>,
	Peter Zijlstra <peterz@infradead.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-rdma@vger.kernel.org"
	<linux-rdma@vger.kernel.org>, Paul Rosswurm <paulros@microsoft.com>, Shradha
 Gupta <shradhagupta@microsoft.com>
Subject: RE: [PATCH v2 3/3] net: mana: Allocate MSI-X vectors dynamically as
 required
Thread-Topic: [PATCH v2 3/3] net: mana: Allocate MSI-X vectors dynamically as
 required
Thread-Index: AQHbtdCa+2CaoQUHl0GxlQrhegIb5rO319gQgAYF3ACAABdo8A==
Date: Thu, 1 May 2025 15:56:48 +0000
Message-ID:
 <SN6PR02MB4157EAC71A53E152EE684A4DD4822@SN6PR02MB4157.namprd02.prod.outlook.com>
References:
 <1745578407-14689-1-git-send-email-shradhagupta@linux.microsoft.com>
 <1745578478-15195-1-git-send-email-shradhagupta@linux.microsoft.com>
 <SN6PR02MB4157FF2CA8E37298FC634491D4822@SN6PR02MB4157.namprd02.prod.outlook.com>
 <20250501142354.GA6208@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
In-Reply-To:
 <20250501142354.GA6208@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|DM4PR02MB9192:EE_
x-ms-office365-filtering-correlation-id: 01dd7660-8a0a-46e2-0f9b-08dd88c8c7bb
x-microsoft-antispam:
 BCL:0;ARA:14566002|8062599003|19110799003|8060799006|461199028|15080799006|4302099013|3412199025|440099028|10035399004|41001999003|12091999003|102099032|56899033|1602099012;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?ma14D1QRAFvQqiU0Tlhwz0nXiX6hgSezMQI4Nq7ccX+zTBOg+vXcVenyZZYT?=
 =?us-ascii?Q?xDuG5jIR+gmY/z9IO2Zm+g7ovYnV7BjpMXrwbC5Kf6aa8k60vaLCT4GxT/TX?=
 =?us-ascii?Q?UN4PwqinDUJpHMPPnSaSi5GQ8aG1dZqr2iFgU7JSEb1jSZSIQQ0uNa/ZAyZR?=
 =?us-ascii?Q?VHMGklLfQ7SG+blu8m5ch/N0eqTxRWGA7q9jrA92oX8bm5R0L3kXZUQljGI5?=
 =?us-ascii?Q?5o12qO0Rcfhxn+frFqrykf8jcP2PDP4i1fGJlAW8yVYNc5SwM/+AyFUtsh6u?=
 =?us-ascii?Q?V9HM53zpeO0bVqn3NyKBCdD0GQNHYJtT8Blj/Cji7KJo5jAAaZDgcMADFz8b?=
 =?us-ascii?Q?uGKogSoSc1VFidqHuZr0EaYVZgTPlVe0835p2L83q+NGsJL6eulfPL+4/EhK?=
 =?us-ascii?Q?4W4kq2whesUiw6maycbd1K4A1oM7JOqK7IILCtVVPnPMyCIASkJfnRGqgw6y?=
 =?us-ascii?Q?ACoh67qof+/pSBj3d8xXrz9TIdgrgaZvp8FBd1QXACMK0y2gXwFdPAlCVVD7?=
 =?us-ascii?Q?3ObYwjSbiTIP9clNlM5lS8DAly/pWrlLU2a6tv5RB+5Ek5q4uK+vPf4RIqRw?=
 =?us-ascii?Q?Rab2C6xZyofgAOd18u7SH+jILc0TFowafkv5GLY/SnrM7mpXlsxRneDYMHlE?=
 =?us-ascii?Q?1GzsgZZhRh5T9xTeEyPB/fSH63T88TVt3z7vLCqXgB8B1i0AnUnYhA2nb0Z6?=
 =?us-ascii?Q?s/GG/2oQHKQEe5p52DjPGxS1B3qkfw+/j8KRDKfkVoPgHO3ljk2uaCRRXQse?=
 =?us-ascii?Q?zfh1/HKetimt/Zwr8g9JAs8JTbhCcjXdo19vLxYigJTRA+vAQaACl3v7OMS5?=
 =?us-ascii?Q?IZ7lsakv0l4INenRrO/5clQ8rp6TLG3fuiVOTH1I3a1kYy/dau9vBPhFmaQY?=
 =?us-ascii?Q?JkMI4w/SEUTLQOl9IArZASrGomWFwn2vnn/DNkjG2kvxETAl8b+/ynL6yL91?=
 =?us-ascii?Q?4RgNJ0ngN5ZoTh5U+IYCDiUmG2HHUKmooYsOnjcBS2QBWGXbOQ9jEUOqXvit?=
 =?us-ascii?Q?53iTyTiUjd4rKnKDL0elrShZkGnHdXDhZRg9hMKaP7vJoDsEAhhJ232nR7yZ?=
 =?us-ascii?Q?ZjMAL9yl4Tv3NDa1UlaT7dTf1aEAbklx2aeYn6eUHnauGBYJtsr10xfnp37n?=
 =?us-ascii?Q?UeVRM8bzeoXgj3Wha5w0immZ322NLlHyGUFkE7P7ENuNV7q4aVO0uxHbIA3M?=
 =?us-ascii?Q?LzcxTfeQ8cjJW2sKnZVzT+Lvgbsma8rph84sWt5vRBa/Cb+VGED+Y3PuITTz?=
 =?us-ascii?Q?1E9gMuNZeO3dl5bruIakE1NKVuw0txWaghkbNsIuQcsdtsbg2Ze32cuF7sKh?=
 =?us-ascii?Q?bpKh7YV48XZTYsfy6uC7ojhf?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?bNyCRUksnxxpuMdfaWDZJXT4nYHQekOftEK1eJhmIomxdX+921p3MIH1hgoV?=
 =?us-ascii?Q?93dn08k5KPxCkfcZgjhaGqYsik4R9mUlGWmfLR5G+A4yBBrr12NIVkxQ/j/7?=
 =?us-ascii?Q?gcGe0sfddiAE6c/jPWr1+Y8jiT/IUkUcgUu2ux0X/rVUF/patEB+MXHw/0vq?=
 =?us-ascii?Q?rDYspRmGoY2tFngBJy4VrgGj34ywmD6YzxcFE7BAFs+c3h8FX6fqkVNTngzF?=
 =?us-ascii?Q?yFMVza5BDVnDB5+iJy4AuW2z+GEF+AnP/H14FATqwketfcK8ruAhaKLb8jJ3?=
 =?us-ascii?Q?1CMl8qAEp+bHzxlIqK2k8v8I7mY7VJTaMkSLKXemnPeWSnr5fveFImJI6iEl?=
 =?us-ascii?Q?DDFNbWMeO4pjfZqNGRMnF4FNXc3aKHg8RFei35T1v57K1oXQQmCUojqi3I93?=
 =?us-ascii?Q?9+2vwq9nrCMfoTYQtLoBllehTQn8yAfqK6tLBZpNn47QqFSTQuwqFwHK5f/H?=
 =?us-ascii?Q?9q8JTTFQTqsvA6t30tMC7l+ldAeUn35XOLsPR1qUfLejbTUjxItXLEeqm/yM?=
 =?us-ascii?Q?kbooNwnQQAzxcZ3k1DakOKPK6XMEJefU0H88QoL5poM8ZbfpdrYWPxBfHzPt?=
 =?us-ascii?Q?YfJSgNwyqYJ1WRW0z5o1teJQ6QpkYraSyEj53XX0/I4BBlfpbcZFKjct3sMV?=
 =?us-ascii?Q?l3VYShcxiSILWQwrWJBQMcIUXo4FDNUx9/ruJoN23jNBtAHHwH5U92QR2TZo?=
 =?us-ascii?Q?c9ISpLbHg7oHZZflXNQeji6EUcTJrRLbQRH0B9x1QwhO8g6fIjhz+YqKUOdZ?=
 =?us-ascii?Q?Qx8rJp5wpzTiqHvlMrPJO+XB8gLKt2i5Lz4U1ZecBa9G/JkPcOnjolnBCAPz?=
 =?us-ascii?Q?3RQ6K8MddVMZ5rcVy9hhu7FH55+e2lY9PLEvptWRXcUfEK7CugiesSjKzhEU?=
 =?us-ascii?Q?6p3QbVmE2x/83uH9Ly+zjpYM4vVhJI/zp/pfqsBdg37Qv529bUT7PPSz+33d?=
 =?us-ascii?Q?5GJgQs+rAKIwSI3DE2gYW6CSqU1KFx0PAj2RSVqIuqLdLUVr4NVfKLV42ZYt?=
 =?us-ascii?Q?nYPJJQu53wt/gaa1SOV5whJfqOOLg2+lL44EO6dy2hW9d6qrFnHj8vOw38w/?=
 =?us-ascii?Q?J8zHR3W3rgSFRrLpH9bDDQ6xODqhxUXMkmRkA/I9gbgkKZ8z4BF2jMiGikTc?=
 =?us-ascii?Q?62OSWsnPkAMVp1d1G9nfDa+mw46s5S49tpvj7//NykwPIf9rOdjR3jVexWaW?=
 =?us-ascii?Q?Lewj2QHh2UPeglScQZ/+zau5jrKbnfQh+P0JPPpkg6gl/kzvf1R/iDE0ph8?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 01dd7660-8a0a-46e2-0f9b-08dd88c8c7bb
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 May 2025 15:56:48.1883
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR02MB9192

From: Shradha Gupta <shradhagupta@linux.microsoft.com> Sent: Thursday, May =
1, 2025 7:24 AM
>=20
> On Thu, May 01, 2025 at 05:27:49AM +0000, Michael Kelley wrote:
> > From: Shradha Gupta <shradhagupta@linux.microsoft.com> Sent: Friday, Ap=
ril 25,
> 2025 3:55 AM
> > >
> > > Currently, the MANA driver allocates MSI-X vectors statically based o=
n
> > > MANA_MAX_NUM_QUEUES and num_online_cpus() values and in some cases en=
ds
> > > up allocating more vectors than it needs. This is because, by this ti=
me
> > > we do not have a HW channel and do not know how many IRQs should be
> > > allocated.
> > >
> > > To avoid this, we allocate 1 MSI-X vector during the creation of HWC =
and
> > > after getting the value supported by hardware, dynamically add the
> > > remaining MSI-X vectors.
> >
> > I have a top-level thought about the data structures used to manage a
> > dynamic number of MSI-X vectors. The current code allocates a fixed siz=
e
> > array of struct gdma_irq_context, with one entry in the array for each
> > MSI-X vector. To find the entry for a particular msi_index, the code ca=
n
> > just index into the array, which is nice and simple.
> >
> > The new code uses a linked list of struct gdma_irq_context entries, wit=
h
> > one entry in the list for each MSI-X vector.  In the dynamic case, you =
can
> > start with one entry in the list, and then add to the list however many
> > additional entries the hardware will support.
> >
> > But this additional linked list adds significant complexity to the code
> > because it must be linearly searched to find the entry for a particular
> > msi_index, and there's the messiness of putting entries onto the list
> > and taking them off.  A spin lock is required.  Etc., etc.
> >
> > Here's an intermediate approach that would be simpler. Allocate a fixed
> > size array of pointers to struct gdma_irq_context. The fixed size is th=
e
> > maximum number of possible MSI-X vectors for the device, which I
> > think is MANA_MAX_NUM_QUEUES, or 64 (correct me if I'm wrong
> > about that). Allocate a new struct gdma_irq_context when needed,
> > but store the address in the array rather than adding it onto a list.
> > Code can then directly index into the array to access the entry.
> >
> > Some entries in the array will be unused (and "wasted") if the device
> > uses fewer MSI-X vector, but each unused entry is only 8 bytes. The
> > max space unused is fewer than 512 bytes (assuming 64 entries in
> > the array), which is neglible in the grand scheme of things. With the
> > simpler code, and not having the additional list entry embedded in
> > each struct gmda_irq_context, you'll get some of that space back
> > anyway.
> >
> > Maybe there's a reason for the list that I missed in my initial
> > review of the code. But if not, it sure seems like the code could
> > be simpler, and having some unused 8 bytes entries in the array
> > is worth the tradeoff for the simplicity.
> >
> > Michael
>=20
> Hey  Michael,
>=20
> Thanks for your inputs. We did think of this approach and in fact that
> was how this patch was implemented(fixed size array) in the v1 of our
> internal reviews.
>=20
> However, it came up in those reviews that we want to move away
> from the 64(MANA_MAX_NUM_QUEUES) as a hard limit for some new
> requirements, atleast for the dynamic IRQ allocation path. And now the
> new limit for all hardening purposes would be num_online_cpus().
>=20
> Using this limit and the fixed array size approach creates problems,
> especially in machines with high number of vCPUs. It would lead to
> quite a bit of memory/resource wastage.
>=20
> Hence, we decided to go ahead with this design.
>=20
> Regards,
> Shradha.

One other thought:  Did you look at using an xarray? See
https://www.kernel.org/doc/html/latest/core-api/xarray.html.
It has most of or all the properties you need to deal with
a variable number of entries, while handling all the locking
automatically. Entries can be accessed with just a simple
index value.

I don't have first-hand experience writing code using xarrays,
so I can't be sure that it would simplify things for MANA IRQ
allocation, but it seems to be a very appropriate abstraction
for this use case.

Michael



