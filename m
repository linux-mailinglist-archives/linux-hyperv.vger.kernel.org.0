Return-Path: <linux-hyperv+bounces-8128-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A257BCEF56F
	for <lists+linux-hyperv@lfdr.de>; Fri, 02 Jan 2026 22:13:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 541EA3010FC3
	for <lists+linux-hyperv@lfdr.de>; Fri,  2 Jan 2026 21:13:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C77A9221723;
	Fri,  2 Jan 2026 21:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="E6LRlCJV"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazolkn19010017.outbound.protection.outlook.com [52.103.2.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCE681A08BC;
	Fri,  2 Jan 2026 21:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.2.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767388415; cv=fail; b=jT9HlyeGZffJHRSuDhucOF+tk5+XK2TJntn4VxZforeYtbaQEqCfOdwEYPn5cRhiLywyqOZEJLRM58hgGahMZFf2U3jY2dDbEzL+wy2VqRniITlGtR+tEvYWzbLIz2G6t1LNF/ctSiR5Q64PpE0cX8Od34TVwpd/qf0fW2t1k/U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767388415; c=relaxed/simple;
	bh=YgRyhenMHcSYaKnq5Up2jzyZI1Zhm+pfrKOsuOKW7Lc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=pRDbt7MziEYEY52TB6CvnZbT5teZOZLEClGDNg027ogERP8GHMv7u11FxDgY5praZPV6rR7cnj99DZJkYH3Z+EZaenCCLjAWgmPzy7blg29yFCEmOv2b+e4603ApCI6kVAj6qUkoPW6cwhhCKADnKrAl5lkGRzaIA8rL2z+7KjE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=E6LRlCJV; arc=fail smtp.client-ip=52.103.2.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ehQaeD1/s4T4jiJ8XMPh9H2VuGJOWmAX9SaqV5SXkeTwhpjk643UJY3WgUius9/N/lMBn+x1HUlRnxrPOxiMiZym7wJNzIQxZ2XidMHYjLxWRpRt5Ic7HS4t+x8G+7dcqKVSjPQlRXnfrpvcVh+JX4MJY5tb6rYQ1F6D/FXYibEUDF5gqjzS5p9IgZmVjBQbXpy4KOf89o1bgDYsQ2xaC9FsbTHfciCWg4GKJJXLbDx6M24k3AB2TqYwhRbeGuP/PecBIfWB1arYMPsuv8qGKa0schKQabQjIkRtY12sZZCC8abOFnoGFWtHtuU+DQDBJKK4CJB0OPbUC0g8Cf2ntA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9g7RrEUk73z+Ch3TOdi6vbJFwDB4jb8c6a3YAA993Wk=;
 b=lBntNYDGRPzKyVFZGY4pa/2HWIHb2OzD9Tqzu5RDvYofZRz2TzYcP7znEOiBSy5Es2H2F0syliaSuV7YJkjqro3VCwU5D553ek+Ca26Qy8Xa7oAb9qveHjyhtxB0v6hq53c+Jevb5ooF14KY1OgvArfUn4V21PbZa+WW6B+Ker0K5A49XocOZHL9Aj4L8iFHxLxb8J+2CmuaBaVsZvp+lNjZrzimTfAhit737gGK4T2CyIkVnWn2hRhFdeLQmi7ImoT4NfibH2AgaXl5fZNiJq38hscVBG0zVMr1R2h8uVma6Z7xTyNMrUci/0tZ0g8jbQO48R3JeSuDwm9q7rB1Yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9g7RrEUk73z+Ch3TOdi6vbJFwDB4jb8c6a3YAA993Wk=;
 b=E6LRlCJV3Fz71sftt9wXJiLa8UIg9H+NsczuKQgNjOPpsJ1DGjBxqv5vO6crClJCoRwLkeAwqLoS4K/VmnYV3mTOZvrI0CPIFuTZsE+HlstZ5TbXeg6SZVGZokudDsz79X3Fc3VjkRBr0Lw4gBMU+V680a9OwIPsexCi/uk2Dme7thk5/yognuFW414TP4XSx+9jN6n7uBiCIZ5jBOg1KmWmjFiu7c3iMi/Pa1m+lTLgOTW+RFroklUMZt6IfqrgG9ZlOkaC/k85n654SNa20AnuTd+PwAwZTxqMd02sog5JMgdSvByBGqQhimZKmLjtsYV0zCtgSXSvSvmrAvhfoA==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by CH3PR02MB10153.namprd02.prod.outlook.com (2603:10b6:610:195::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9456.14; Fri, 2 Jan
 2026 21:13:31 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6%3]) with mapi id 15.20.9478.004; Fri, 2 Jan 2026
 21:13:31 +0000
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
 AQHcbu3m/1KRrXDdWE2Bee61xybnKLUnwn/AgAHUSgCAAZKpIIAEOHMAgAASAICAABt8UIAPsSwAgAABuuCAACWUgIAAAVcw
Date: Fri, 2 Jan 2026 21:13:31 +0000
Message-ID:
 <SN6PR02MB415724D13B2751F8FAA1053BD4BBA@SN6PR02MB4157.namprd02.prod.outlook.com>
References:
 <176593206931.276257.13023250440372517478.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
 <SN6PR02MB4157D69A4C08B0A4FE01F9FED4A8A@SN6PR02MB4157.namprd02.prod.outlook.com>
 <aUXXdjMyZ5swiCI2@skinsburskii.localdomain>
 <SN6PR02MB41578A17A4DADD9276392298D4B4A@SN6PR02MB4157.namprd02.prod.outlook.com>
 <SN6PR02MB4157AAFDD8BD5BDCD2D3DB99D4B5A@SN6PR02MB4157.namprd02.prod.outlook.com>
 <aUrCr5wBSTrGm-IM@skinsburskii.localdomain>
 <SN6PR02MB41573BF52C6A4447C720CDD6D4B5A@SN6PR02MB4157.namprd02.prod.outlook.com>
 <aVgDloDX9nMH6hZH@skinsburskii.localdomain>
 <SN6PR02MB4157288D26ECC9E69240CFECD4BBA@SN6PR02MB4157.namprd02.prod.outlook.com>
 <aVgkj4V60kddKk4o@skinsburskii.localdomain>
In-Reply-To: <aVgkj4V60kddKk4o@skinsburskii.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|CH3PR02MB10153:EE_
x-ms-office365-filtering-correlation-id: 6409d432-ad4e-4636-602a-08de4a43c860
x-microsoft-antispam:
 BCL:0;ARA:14566002|13091999003|31061999003|8062599012|19110799012|51005399006|8060799015|41001999006|461199028|15080799012|440099028|3412199025|40105399003|102099032;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?LtH7Pcd/ZLoQ8dwR4qQxUazTtFBgIcfs728zquxGKlJK9Dd1brH3Fb/Btfht?=
 =?us-ascii?Q?P8UThzIJ0drMlu/i9yo3eSAh7IcldDu5uFP55yr1w1Mf5Xu/wjaLfqAovAkc?=
 =?us-ascii?Q?c3CZywn79D3rdb9RVKZzvN5Ubb9nvswDHuZcmPRoSI5AgVubQcrbTKtTXy19?=
 =?us-ascii?Q?EzZy+PP7ZnbIMqjkUFHbsDCzjGNf91smLjv5cuhGcsTduOuAuuEQcWRaHXxB?=
 =?us-ascii?Q?ajOzi3g9kFVsPuWR1fNrpj0Lif1uKR0iL9CLzWoha8xOTPscbfoa4JH1YqOA?=
 =?us-ascii?Q?6MUN4yRXFOBVOkwNFEbmPD8eMeFz0Aa7JCyk3YqILPms3SGiswPzlfRrNZMe?=
 =?us-ascii?Q?AoGWNIhgMa3q21ndUEj4XG/ZwLwxM8n9UNTXIo4T10dEquK1Y96fzTIChmvj?=
 =?us-ascii?Q?q/PQO+dAEL9G/eVsvuZ1H3HojToHk/oCT4L+ol4W3hsrct9ab/Fg9SvJVRhd?=
 =?us-ascii?Q?Q7kxthD4Ezy9aQvyXiq3AAdHk1f+5UjLGVxXYGf2aqsXzsBGcrOJNFNl7cGT?=
 =?us-ascii?Q?t++fn+Esu4ASzB7x5DLQkEJ6bG+8Z6OXTJtQD8v/EF8AW96RxrLxOrqO3Nrf?=
 =?us-ascii?Q?nAMZnDzsxkfdiK9sNsrgkl7pEsNXPpazgAgmcUeofWPRgEVmkPlKjPLs9plW?=
 =?us-ascii?Q?A0yQT7fPZfbiyvLspw5SeDGkm4J8P7PIuRlFDaj0n3VklvJNjWS2cOW/73SV?=
 =?us-ascii?Q?BA4I2IbRyzZSuoOdSMr7yjclkJYpBVTv2MgpDSXaFr/1up4CScHenoHoDAyH?=
 =?us-ascii?Q?86lAxfMCxzg8EeRtfON2mWNv5W9Pg2N3xxXnRcRW7SofXGHhf6lfj/W1+u3h?=
 =?us-ascii?Q?MT+kP8c+vwpTz3j350qvxpC1k4CCQuYBvqGkUvxQbvFcxVPwMRiVdLGAqqMK?=
 =?us-ascii?Q?feAldwkjwjZkqzGQDlpAUYj2uUUX2ESbkN7YGZLkUq195cG9CVTtgaK1++2t?=
 =?us-ascii?Q?hRNx8DDv3OJOP6tFpy/pqvggIRZxlxe/mWR3plMHaOfzFl7wzD/tLqwmUAJz?=
 =?us-ascii?Q?EXZ942oBCMw6rLxyeRIa389tUYM78YZuwf+XB1j9gjIqNjMu0e4lwWW7SUrO?=
 =?us-ascii?Q?DEs05Pd7HbAFc/ZrZR3Hi1bEnmJTdSfb4qI6cTqFtgWcZxp92MFScSeyqIEA?=
 =?us-ascii?Q?J1qtCw0h73z1QKhwQy/F1Uli8r7KDbIpjxV7UCmBxVYHXUcB2+8NdmhWnT9S?=
 =?us-ascii?Q?CkLRWUeWdZ5aB5gsmARA3Ms2ym/FPQ+CjmVyg7d5WuHp+w6l8wACM2iYPFQ?=
 =?us-ascii?Q?=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?efiojQaUznyU/Hg/AqfDXvWVXXFajy/AsbQk4oWiSrc91PGwxFHM9fbVzWQp?=
 =?us-ascii?Q?VhxWOP1YvvFplsKSZ5GYMZbHOKzRBo0etjllrkb/v5nmK1n1lHpET7ehd/PK?=
 =?us-ascii?Q?nPRsbqjIafVwwbX8bp4kBTLo9MAX7N/8U8oM8jHsTPE7ibEWMIDo1TAS9vLq?=
 =?us-ascii?Q?Q/YOwx/utNrBZCqkeqCehZZtvtX+MpUYAT7nfvboTugF4EnDUOzbq+LLY9fz?=
 =?us-ascii?Q?j/Vd8nWgD/NXz04rps1PVHjjWkAyxj41VzudJbPLpcXINuPviNLIwzHhxA+0?=
 =?us-ascii?Q?jiyCT4lRSVyjqPdbiaglX31V4IjtRwpO8PYKFHAWRkGawaTeikrMQ5VA6G2U?=
 =?us-ascii?Q?e1RXq41IeGbg7z60SZiNl2BCQtbW6UNwjUpjONv3u6IeDyPViEIQsVa65DEJ?=
 =?us-ascii?Q?KKuVMaORNn5TzXDVFAY2XwXywqkh2lndvjqPkmOAiEop5CuzGBQyB9k+0YN/?=
 =?us-ascii?Q?s+9Cz7htrlKevVjXdQlv308Tu+nEac+WFlxmVlFNDM8mikanppcn1u/1wTe0?=
 =?us-ascii?Q?O+yNhrM2tDeqBObCxWNsXx5QYF5mE8lOZpQXdrHRyjSKvTI9bO4WWbg94s9F?=
 =?us-ascii?Q?IhEwtLG8J/MAZL/nGZ8UgVhrYOhHC7FdeAbW01iPpZv5HDuUsOyxqLSLilQf?=
 =?us-ascii?Q?XQKHfJuF9WrwQDvntscXucTkrEauJeYBxVo3LznpkSmM3l4h8241eGwPl+MF?=
 =?us-ascii?Q?wfzJjxHcQSWV/X6d8bHev/xQLj9ZR4Cq64HyNxlLMh4lIUtfJ0Y+pD8IMCK2?=
 =?us-ascii?Q?4fm9UwN+Sd+HWPAIqZixUHQw46uGgi4/TuV3mtRvNew8pF8vdwvhHEOQjWwj?=
 =?us-ascii?Q?DaY0H7x6Df4Kx9aTgRUMlGOzBe3v9zjMN2mcTtun2xq1va2h6FupV1+vbad4?=
 =?us-ascii?Q?Xs5ngZCgUoRVQPJZJMcHBH/c14/HO4jA/94aI9QNjx7eN3wUoZXOqzwbLs1k?=
 =?us-ascii?Q?AMvRKgc3tKzUBu+q+Yn31kIQi16o81KOfEsx1dlqiMxBSHmFp4EdDLpp93pm?=
 =?us-ascii?Q?3LbdXCe7IOm02C0JfJscd8VbYANEovXT0awVvlsn0IEBplcDvuiMlysAPjc9?=
 =?us-ascii?Q?a1WnFD2FQn5OYN3mZAZLtfcb8zI4LxrUV7W1/eYiJi5Hqccwc3Xti6/W5sew?=
 =?us-ascii?Q?olb+PFrOK2YWdo14HKf+lu9i8+TNyzqqQZ01VXL2i8qtd4YrM8xJQZEncEwl?=
 =?us-ascii?Q?FsXn7ElDBYL3sRsLPxsd1eX6c15okpt0OUQBRlQq2DmmqIqG+jAMp9yH8jgb?=
 =?us-ascii?Q?mfJ/BQ91WRE/83mobUx/kmG6fwt7WTYzNfCmqirtM1gepV556JmaUEhif6li?=
 =?us-ascii?Q?nXvI3q3ONy5lETYSqZySoUALflhg+r3BblgHZoOIomEOuDco9HNlIE7LcfxF?=
 =?us-ascii?Q?FEn1FQs=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 6409d432-ad4e-4636-602a-08de4a43c860
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jan 2026 21:13:31.7931
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR02MB10153

From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com> Sent: Friday=
, January 2, 2026 12:03 PM
>=20
> On Fri, Jan 02, 2026 at 06:04:56PM +0000, Michael Kelley wrote:
> > From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com> Sent: Fr=
iday, January 2, 2026 9:43 AM
> > >
> > > On Tue, Dec 23, 2025 at 07:17:23PM +0000, Michael Kelley wrote:
> > > > From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com> Sent=
: Tuesday, December 23, 2025 8:26 AM
> > > > >
> > > > > On Tue, Dec 23, 2025 at 03:51:22PM +0000, Michael Kelley wrote:
> > > > > > From: Michael Kelley Sent: Monday, December 22, 2025 10:25 AM
> > > > > > >
> > > > > > [snip]
> > > > > > >
> > > > > > > Separately, in looking at this, I spotted another potential p=
roblem with
> > > > > > > 2 Meg mappings that somewhat depends on hypervisor behavior t=
hat I'm
> > > > > > > not clear on. To create a new region, the user space VMM issu=
es the
> > > > > > > MSHV_GET_GUEST_MEMORY ioctl, specifying the userspace address=
, the
> > > > > > > size, and the guest PFN. The only requirement on these values=
 is that the
> > > > > > > userspace address and size be page aligned. But suppose a 4 M=
eg region is
> > > > > > > specified where the userspace address and the guest PFN have =
different
> > > > > > > offsets modulo 2 Meg. The userspace address range gets popula=
ted first,
> > > > > > > and may contain a 2 Meg large page. Then when mshv_chunk_stri=
de()
> > > > > > > detects a 2 Meg aligned guest PFN so HVCALL_MAP_GPA_PAGES can=
 be told
> > > > > > > to create a 2 Meg mapping for the guest, the corresponding sy=
stem PFN in
> > > > > > > the page array may not be 2 Meg aligned. What does the hyperv=
isor do in
> > > > > > > this case? It can't create a 2 Meg mapping, right? So does it=
 silently fallback
> > > > > > > to creating 4K mappings, or does it return an error? Returnin=
g an error would
> > > > > > > seem to be problematic for movable pages because the error wo=
uldn't
> > > > > > > occur until the guest VM is running and takes a range fault o=
n the region.
> > > > > > > Silently falling back to creating 4K mappings has performance=
 implications,
> > > > > > > though I guess it would work. My question is whether the
> > > > > > > MSHV_GET_GUEST_MEMORY ioctl should detect this case and retur=
n an
> > > > > > > error immediately.
> > > > > > >
> > > > > >
> > > > > > In thinking about this more, I can answer my own question about=
 the
> > > > > > hypervisor behavior. When HVCALL_MAP_GPA_PAGES is set, the full
> > > > > > list of 4K system PFNs is not provided as an input to the hyper=
call, so
> > > > > > the hypervisor cannot silently fall back to 4K mappings. Assumi=
ng
> > > > > > sequential PFNs would be wrong, so it must return an error if t=
he
> > > > > > alignment of a system PFN isn't on a 2 Meg boundary.
> > > > > >
> > > > > > For a pinned region, this error happens in mshv_region_map() as
> > > > > > called from  mshv_prepare_pinned_region(), so will propagate ba=
ck
> > > > > > to the ioctl. But the error happens only if pin_user_pages_fast=
()
> > > > > > allocates one or more 2 Meg pages. So creating a pinned region
> > > > > > where the guest PFN and userspace address have different offset=
s
> > > > > > modulo 2 Meg might or might not succeed.
> > > > > >
> > > > > > For a movable region, the error probably can't occur.
> > > > > > mshv_region_handle_gfn_fault() builds an aligned 2 Meg chunk
> > > > > > around the faulting guest PFN. mshv_region_range_fault() then
> > > > > > determines the corresponding userspace addr, which won't be on
> > > > > > a 2 Meg boundary, so the allocated memory won't contain a 2 Meg
> > > > > > page. With no 2 Meg pages, mshv_region_remap_pages() will
> > > > > > always do 4K mappings and will succeed. The downside is that a
> > > > > > movable region with a guest PFN and userspace address with
> > > > > > different offsets never gets any 2 Meg pages or mappings.
> > > > > >
> > > > > > My conclusion is the same -- such misalignment should not be
> > > > > > allowed when creating a region that has the potential to use 2 =
Meg
> > > > > > pages. Regions less than 2 Meg in size could be excluded from s=
uch
> > > > > > a requirement if there is benefit in doing so. It's possible to=
 have
> > > > > > regions up to (but not including) 4 Meg where the alignment pre=
vents
> > > > > > having a 2 Meg page, and those could also be excluded from the
> > > > > > requirement.
> > > > > >
> > > > >
> > > > > I'm not sure I understand the problem.
> > > > > There are three cases to consider:
> > > > > 1. Guest mapping, where page sizes are controlled by the guest.
> > > > > 2. Host mapping, where page sizes are controlled by the host.
> > > >
> > > > And by "host", you mean specifically the Linux instance running in =
the
> > > > root partition. It hosts the VMM processes and creates the memory
> > > > regions for each guest.
> > > >
> > > > > 3. Hypervisor mapping, where page sizes are controlled by the hyp=
ervisor.
> > > > >
> > > > > The first case is not relevant here and is included for completen=
ess.
> > > >
> > > > Agreed.
> > > >
> > > > >
> > > > > The second and third cases (host and hypervisor) share the memory=
 layout,
> > > >
> > > > Right. More specifically, they are both operating on the same set o=
f physical
> > > > memory pages, and hence "share" a set of what I've referred to as
> > > > "system PFNs" (to distinguish from guest PFNs, or GFNs).
> > > >
> > > > > but it is up
> > > > > to each entity to decide which page sizes to use. For example, th=
e host might map the
> > > > > proposed 4M region with only 4K pages, even if a 2M page is avail=
able in the middle.
> > > >
> > > > Agreed.
> > > >
> > > > > In this case, the host will map the memory as represented by 4K p=
ages, but the hypervisor
> > > > > can still discover the 2M page in the middle and adjust its page =
tables to use a 2M page.
> > > >
> > > > Yes, that's possible, but subject to significant requirements. A 2M=
 page can be
> > > > used only if the underlying physical memory is a physically contigu=
ous 2M chunk.
> > > > Furthermore, that contiguous 2M chunk must start on a physical 2M b=
oundary,
> > > > and the virtual address to which it is being mapped must be on a 2M=
 boundary.
> > > > In the case of the host, that virtual address is the user space add=
ress in the
> > > > user space process. In the case of the hypervisor, that "virtual ad=
dress" is the
> > > > the location in guest physical address space; i.e., the guest PFN l=
eft-shifted 9
> > > > to be a guest physical address.
> > > >
> > > > These requirements are from the physical processor and its requirem=
ents on
> > > > page table formats as specified by the hardware architecture. Where=
as the
> > > > page table entry for a 4K page contains the entire PFN, the page ta=
ble entry
> > > > for a 2M page omits the low order 9 bits of the PFN -- those bits m=
ust be zero,
> > > > which is equivalent to requiring that the PFN be on a 2M boundary. =
These
> > > > requirements apply to both host and hypervisor mappings.
> > > >
> > > > When MSHV code in the host creates a new pinned region via the ioct=
l,
> > > > MSHV code first allocates memory for the region using pin_user_page=
s_fast(),
> > > > which returns the system PFN for each page of physical memory that =
is
> > > > allocated. If the host, at its discretion, allocates a 2M page, the=
n a series
> > > > of 512 sequential 4K PFNs is returned for that 2M page, and the fir=
st of
> > > > the 512 sequential PFNs must have its low order 9 bits be zero.
> > > >
> > > > Then the MSHV ioctl makes the HVCALL_MAP_GPA_PAGES hypercall for
> > > > the hypervisor to map the allocated memory into the guest physical
> > > > address space at a particular guest PFN. If the allocated memory co=
ntains
> > > > a 2M page, mshv_chunk_stride() will see a folio order of 9 for the =
2M page,
> > > > causing the HV_MAP_GPA_LARGE_PAGE flag to be set, which requests th=
at
> > > > the hypervisor do that mapping as a 2M large page. The hypercall do=
es not
> > > > have the option of dropping back to 4K page mappings in this case. =
If
> > > > the 2M alignment of the system PFN is different from the 2M alignme=
nt
> > > > of the target guest PFN, it's not possible to create the mapping an=
d the
> > > > hypercall fails.
> > > >
> > > > The core problem is that the same 2M of physical memory wants to be
> > > > mapped by the host as a 2M page and by the hypervisor as a 2M page.
> > > > That can't be done unless the host alignment (in the VMM virtual ad=
dress
> > > > space) and the guest physical address (i.e., the target guest PFN) =
alignment
> > > > match and are both on 2M boundaries.
> > > >
> > >
> > > But why is it a problem? If both the host and the hypervisor can map =
ap
> > > huge page, but the guest can't, it's still a win, no?
> > > In other words, if VMM passes a host huge page aligned region as a gu=
est
> > > unaligned, it's a VMM problem, not a hypervisor problem. And I' don't
> > > understand why would we want to prevent such cases.
> > >
> >
> > Fair enough -- mostly. If you want to allow the misaligned case and liv=
e
> > with not getting the 2M mapping in the guest, that works except in the
> > situation that I described above, where the HVCALL_MAP_GPA_PAGES
> > hypercall fails when creating a pinned region.
> >
> > The failure is flakey in that if the Linux in the root partition does n=
ot
> > map any of the region as a 2M page, the hypercall succeeds and the
> > MSHV_GET_GUEST_MEMORY ioctl succeeds. But if the root partition
> > happens to map any of the region as a 2M page, the hypercall will fail,
> > and the MSHV_GET_GUEST_MEMORY ioctl will fail. Presumably such
> > flakey behavior is bad for the VMM.
> >
> > One solution is that mshv_chunk_stride() must return a stride > 1 only
> > if both the gfn (which it currently checks) AND the corresponding
> > userspace_addr are 2M aligned. Then the HVCALL_MAP_GPA_PAGES
> > hypercall will never have HV_MAP_GPA_LARGE_PAGE set for the
> > misaligned case, and the failure won't occur.
> >
>=20
> I think see your point, but I also think this issue doesn't exist,
> because map_chunk_stride() returns huge page stride iff page if:
> 1. the folio order is PMD_ORDER and
> 2. GFN is huge page aligned and
> 3. number of 4K pages is huge pages aligned.
>=20
> On other words, a host huge page won't be mapped as huge if the page
> can't be mapped as huge in the guest.

OK, I'm missing how what you say is true. For pinned regions,
the memory is allocated and mapped into the host userspace address
first, as done by mshv_prepare_pinned_region() calling mshv_region_pin(),
which calls pin_user_pages_fast(). This is all done without considering
the GFN or GFN alignment. So one or more 2M pages might be allocated
and mapped in the host before any guest mapping is looked at. Agreed?

Then mshv_prepare_pinned_region() calls mshv_region_map() to do the
guest mapping. This eventually gets down to mshv_chunk_stride(). In
mshv_chunk_stride() when your conditions #2 and #3 are met, the
corresponding struct page argument to mshv_chunk_stride() may be a
4K page that is in the middle of a 2M page instead of at the beginning
(if the region is mis-aligned). But the key point is that the 4K page in
the middle is part of a folio that will return a folio order of PMD_ORDER.
I.e., a folio order of PMD_ORDER is not sufficient to ensure that the
struct page arg is at the *start* of a 2M-aligned physical memory range
that can be mapped into the guest as a 2M page.

The problem does *not* happen with a movable region, but the reasoning
is different. hmm_range_fault() is always called with a 2M range aligned
to the GFN, which in a mis-aligned region means that the host userspace
address is never 2M aligned. So hmm_range_fault() is never able to allocate
and map a 2M page. mshv_chunk_stride() will never get a folio order > 1,
and the hypercall is never asked to do a 2M mapping. Both host and guest
mappings will always be 4K and everything works.

Michael

> And this function is called for
> both movable and pinned region, so the hypercal should never fail due to
> huge page alignment issue.
>=20
> What do I miss here?
>=20
> Thanks,
> Stanislav
>=20
>=20
> > Michael
> >
> > >
> > > > Movable regions behave a bit differently because the memory for the
> > > > region is not allocated on the host "up front" when the region is c=
reated.
> > > > The memory is faulted in as the guest runs, and the vagaries of the=
 current
> > > > MSHV in Linux code are such that 2M pages are never created on the =
host
> > > > if the alignments don't match. HV_MAP_GPA_LARGE_PAGE is never passe=
d
> > > > to the HVCALL_MAP_GPA_PAGES hypercall, so the hypervisor just does =
4K
> > > > mappings, which works even with the misalignment.
> > > >
> > > > >
> > > > > This adjustment happens at runtime. Could this be the missing det=
ail here?
> > > >
> > > > Adjustments at runtime are a different topic from the issue I'm rai=
sing,
> > > > though eventually there's some relationship. My issue occurs in the
> > > > creation of a new region, and the setting up of the initial hypervi=
sor
> > > > mapping. I haven't thought through the details of adjustments at ru=
ntime.
> > > >
> > > > My usual caveats apply -- this is all "thought experiment". If I ha=
d the
> > > > means do some runtime testing to confirm, I would. It's possible th=
e
> > > > hypervisor is playing some trick I haven't envisioned, but I'm skep=
tical of
> > > > that given the basics of how physical processors work with page tab=
les.
> > > >
> > > > Michael

