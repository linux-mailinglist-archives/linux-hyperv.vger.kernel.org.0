Return-Path: <linux-hyperv+bounces-1986-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B9C18A8ADA
	for <lists+linux-hyperv@lfdr.de>; Wed, 17 Apr 2024 20:12:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB8A11F215AB
	for <lists+linux-hyperv@lfdr.de>; Wed, 17 Apr 2024 18:12:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F04D173326;
	Wed, 17 Apr 2024 18:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="W67BD2Oq"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04olkn2101.outbound.protection.outlook.com [40.92.45.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C85F146D7F;
	Wed, 17 Apr 2024 18:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.45.101
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713377559; cv=fail; b=lkSVQOs/0u0lFiyanizCcGDJTGs813g9n+QrB2A7p7F1Q2s7KwG1dE1krBqpj4dPjMbUebs/0DB6+PcgBlTHKHWVu/inOBj6hKVBKoeX6rRs3a4ZVrHWPjzHQdAm4qCKpWHazkhSbhAYYSK44s8AddTD4CLXozA4C5l7mlbIZ8g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713377559; c=relaxed/simple;
	bh=YjcqZRTMrNnBShhi5D7Zg3XRsxGfrkmGllxnr9+cfi0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Yfe/RqrCCz8PLkQpZBSwzxDh97vzrCSz37fqBctygHlKbge3gKjhG6z1391EqsofxmhMUZx/prfbZhAnS00v0KL0T/2FnIpEkY4j0BS6Vzs0L8bWipaOeqkUXKRb6vgZeAs8EgF8+rTGl1B/LHxZ86ilQLqzP5HEIBjQNc3Gg38=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=W67BD2Oq; arc=fail smtp.client-ip=40.92.45.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dj5QuQAeNYqe3F/vq6TXv4bFhoVYi+Q/Co8HvqTF+seo4rN4pXItyQZ9dH5Tmzg9qyg01EuaKVKxE2LoYvbccfWeiFjnkN/rWmnpADxGWTDaizksI+NHBwfUuoznud5PD/jMECq8IoJzrid6g0m3hy99pTxrF4b70mLH4QHec/VWOy3N0/tqWE74KJy91hNa+VojJaPe6MCEqdOPMMnmPuifzytz4y03QSB4vW9BkGO9udhbVp+o/+EWrBAo/e/PKn5gMk10JYo90GnlC1mQoM8qSlS+UV9jd4kWLeYBUHBwN+dKHPrZ3EgcpC6uFufzFX887vgzz6uf/YXVr8KqCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X3Xzfo5q4IUz2fMt2MFMu721g7PRW2AjLOvvKlSmqmA=;
 b=O2i3YyziexqCXnJ/6p45oLT/l0dMVplHMYp7YDtMAQZ+2FtR1rdVUt89aTWCPl4sKptQH+Xe3BGUkRSAFvsObB/VIz1XHH3/ZxhQeqDu1o4T0MmPmHw+tfYUNgSBcuK5nbNWKN/7SsnWBpfx8CVjV7LKDP/Fea66qj9WIwljRYWBeBJ2HuST5zPfpCqhuWLjBMikbuuc/torfsKPKTX1locPyYCoCDcyHMxYFGJvV1/sFEwPbirPb/5Htfo8YSxh+f2YZqdiPO7oiw2AzMbtvBC0KTOmriWwOKDxpmQe3txCc1Hn5CZLSGa7AmB/rdMjliG+IXs6srG0QWKUrTdtGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X3Xzfo5q4IUz2fMt2MFMu721g7PRW2AjLOvvKlSmqmA=;
 b=W67BD2OqqephrnvSuhvsU7LDLmzW0KVY2FOSnDS4Lz6QTGR2peboLXbOG53bkUh97ynNpQGNkxS+QY1qAbHBdwhtOuvVzWGpWxg+MCSFCTHf+Hq4pWe8U9YN3TVe+FNuMbhmTzlQgfPLTSJ0LJZDnsB1CGKA/DfxJ/IPlWnqkIdUnE3Q5B/nkXFnd0voLQ+3i1ncV9Y1Rd7aqVEYx3MwTa/8BRYOjURvmCTYXCzDb6AZyV1rwHzKIF4chwda4m6OyXT3rR+Q7QC9JbSqu5dhPPVWbB8aycYuP2I0wix8bRHaQSmx8Z0FR+icuheMRw0koOqzbX0kTBhriPhVt88zdw==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by DM4PR02MB8981.namprd02.prod.outlook.com (2603:10b6:8:bd::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.37; Wed, 17 Apr
 2024 18:12:35 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::1276:e87b:ae1:a596]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::1276:e87b:ae1:a596%5]) with mapi id 15.20.7452.049; Wed, 17 Apr 2024
 18:12:35 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Jean Delvare <jdelvare@suse.de>, Michael Schierl <schierlm@gmx.de>
CC: "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] firmware: dmi: Stop decoding on broken entry
Thread-Topic: [PATCH] firmware: dmi: Stop decoding on broken entry
Thread-Index: AQHakNyeQHU2XdbvxkyqvOE9tFpqPLFsmKbAgAAgboCAAAm3QA==
Date: Wed, 17 Apr 2024 18:12:34 +0000
Message-ID:
 <SN6PR02MB415762984B4CA784CA3B82D3D40F2@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <b702b36b90b63b615d41e778570707043ea81551.camel@suse.de>
	 <SN6PR02MB415755044A025D66B4BC8955D40F2@SN6PR02MB4157.namprd02.prod.outlook.com>
 <a5cc2ca32f52f3dfce90e0a7e33656e3ee3a1a2e.camel@suse.de>
In-Reply-To: <a5cc2ca32f52f3dfce90e0a7e33656e3ee3a1a2e.camel@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-tmn: [xrG6iqW1VMdTbgaIoEpcywMeiA/1P8CJ]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|DM4PR02MB8981:EE_
x-ms-office365-filtering-correlation-id: b2282fb0-6f73-4b13-6d15-08dc5f09f50b
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 U1ytlud5Y5MRUsTLUSMguLViV2fJ2VJSC9X3IJvqcQwFtnmxmzP+64b9c5mXWj+Kztz+THjBj7W7Ml5epc/kZwFIyua/LAUBDKaxg4WYTSIJH347iLcVbWWhhEwC+reiCFqD8b0Phoghg61d+DW7oa3x3rw8IEzN2hqALGMD1RBCPPtgXAUrcUn02/d7xcke9IJhQJuuy3Anm5w63K6r839Y20asl5xw3fq1tvqV0cUUYvwPR8tfcVmopEwcypRTQb54mdrurZGvt2xuq+Nf28IYYbGgA9dIEkTB+jeAvNYYcpnp8UpBYINA2ADG7oyeZseJzDN3pGNYaTOMNzNSzfKAoK/zXzgqC5A5mVC7kkxTbwd3HfFWKdcnRpbcyOPPzS4L59xplDK9PNjVPW9W6i8eaHAR+nqLm49D0XoMejciKysBowVJT9nmBegu+J87mRNb1YqqBGG8zOSGy6PGEY/KRDw91cKGJFAZU5bhoGrN7a6BhvpMvPD0oy4KrNQAy3y35A/8Sr6K5D5wgJ40FZyZabsX5YAOdxrPOVREmiuiqKiQB3QAF0YzWp+w/0QMaQdSY7HxD8mKEBzw2swv6FjriHGy04hA/XRHnm1GI1xLMVTkw3cbGIyjnaA5N+qTu9QG8v+1nVeK+LMrUYJWWiv/DM6ihoOQK4xjHJVYMYo=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?wE+0XhXD8hIc1z/h3sBBjzi2ixqK1L1GflyfOtUH817SrUsq9I2SE0QrWx?=
 =?iso-8859-1?Q?NsRQ0Tie90reVPTogELPLNQYVYQ8lJnwDGfkfA+hEB1q8RGIC1whUOVz7k?=
 =?iso-8859-1?Q?3mdB5nWJhUCRbGhphD06UtzDn/vEVboiRqIAXQUSIBPFBSr7p4wW92uLoV?=
 =?iso-8859-1?Q?ivjVB7D1dwkKcEr1SUc6jmqY83WKqVVmDqaKgVWmnqJBQ4pnAkPugyKNn7?=
 =?iso-8859-1?Q?9XdnKpwFRNslZhTsywkicgLQ6KNyaWj7vmmfE8/f2ZeBIvUP5IiNVmOtP+?=
 =?iso-8859-1?Q?qT1f98CIeNLxFqLRsgZiGYtNM+OL+gZa5YXu6aauu2JnVpCgE64rh/ftKM?=
 =?iso-8859-1?Q?SRLQ9ZO8kmPooZ6ydCy4LFE3swES/3I0efHVgTmuXQw6mRysIQkWW8ttle?=
 =?iso-8859-1?Q?ytFQzwT5rjEbEkvSUZ93CPErdUTerylPJ/4WBIvK7O6z0aiRZagvhVnJIB?=
 =?iso-8859-1?Q?4EF2wHlBamd2UOt9nSe4ljeUoe7WI2lgpvfr+PBK7Nyc8rQiI649kJHi57?=
 =?iso-8859-1?Q?/Hx/e6pfqMhwHNRBuXKZ0faI79pzBBZ0Ksj/xvu+FhyKUDhQDOy881THa9?=
 =?iso-8859-1?Q?LxPNje9EsftKIDuaVe+W/FFfhhnASwu02L9KeO+cLfjZettuHZ/ngKyBL2?=
 =?iso-8859-1?Q?0s9xalkJxJuqvWxnndesZkKguxnm3bBgURREe3gYcOfIjkyEyC3uQAPtze?=
 =?iso-8859-1?Q?2OqdpYRkfhMrkY8zUvO4MuWUJCOeBDZsmYlaYywisf4DYcQuGnEPkQmqcx?=
 =?iso-8859-1?Q?z8CWqEyQGl2oap5YSuzUR4Q56Oai7Qg8Aeqkrb8kd074/p0tteqmuJiai4?=
 =?iso-8859-1?Q?Jmj5ZXnIqFCpsagZ5AxsF9JsWaIQ/rvhO4mDqhhbemsNJ0jMD+g460mtAT?=
 =?iso-8859-1?Q?td51angddBEqBwwMLkFK/wjwqGj9A9W2kDrS+h1kwRksh1htB+fkm6o9HO?=
 =?iso-8859-1?Q?We38MuguilSoHn1MlhQCE6oNVps3fcRWgrzqGIdQU+atTfIBM8w9rXkPJ4?=
 =?iso-8859-1?Q?JGV8IgqoHlewu+HAaI6N0Fo2c89ZYvg/4/3QmKbgax2t4nrbqJJ1XCR+Tw?=
 =?iso-8859-1?Q?WfBc9hugeC2YHjZm8LdSRA4tDnHNRssjAjmCxry0OQUYZMErczu7tEY2O/?=
 =?iso-8859-1?Q?yYVjlXavBPYDN8hXaZC1jWhMdnA9fVs8wU+5dbh0nYuLgS6qhhJkKDVGqh?=
 =?iso-8859-1?Q?+6V6EBGSa4k39/Tfr9WHGYS2wjgf7Ffn0XvztQv51Ay42OcKPGl4AT4Apx?=
 =?iso-8859-1?Q?yj9DL0g84uuJrx9+Tkaw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
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
X-MS-Exchange-CrossTenant-Network-Message-Id: b2282fb0-6f73-4b13-6d15-08dc5f09f50b
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2024 18:12:34.9655
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR02MB8981

From: Jean Delvare <jdelvare@suse.de> Sent: Wednesday, April 17, 2024 10:34=
 AM
>=20
> Hi Michael,
>=20
> On Wed, 2024-04-17 at 15:43 +0000, Michael Kelley wrote:
> > From: Jean Delvare <jdelvare@suse.de> Sent: Wednesday, April 17, 2024 8=
:34 AM
> > >
> > > If a DMI table entry is shorter than 4 bytes, it is invalid. Due to
> > > how DMI table parsing works, it is impossible to safely recover from
> > > such an error, so we have to stop decoding the table.
> > >
> > > Signed-off-by: Jean Delvare <jdelvare@suse.de>
> > > Link: https://lore.kernel.org/linux-kernel/Zh2K3-HLXOesT_vZ@liuwe-dev=
box-debian-v2/T/
> > > ---
> > > Michael, can you please test this patch and confirm that it prevents
> > > the early oops?
> > >
> > > The root cause of the DMI table corruption still needs to be
> > > investigated.
> > >
> > > =A0drivers/firmware/dmi_scan.c |=A0=A0 11 +++++++++++
> > > =A01 file changed, 11 insertions(+)
> > >
> > > --- linux-6.8.orig/drivers/firmware/dmi_scan.c
> > > +++ linux-6.8/drivers/firmware/dmi_scan.c
> > > @@ -102,6 +102,17 @@ static void dmi_decode_table(u8 *buf,
> > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0const struct dmi_head=
er *dm =3D (const struct dmi_header *)data;
> > >
> > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0/*
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 * If a short entry is =
found (less than 4 bytes), not only it
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 * is invalid, but we c=
annot reliably locate the next entry.
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 */
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0if (dm->length < sizeof=
(struct dmi_header)) {
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0pr_warn(FW_BUG
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0"Corrupted DMI table (only %d entries processed)=
\n",
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0i);
> >
> > It would be useful to also output the three header fields: type, handle=
, and length,
>=20
> I object. The most likely cause for the length being wrong is memory
> corruption. We have no idea what caused it, nor what kind of data was
> written over the DMI table, so leaking the information to user-space
> doesn't sound like a good idea, even if it's only 4 bytes.
>=20
> Furthermore, the data in question is essentially useless anyway. It is
> likely to lead the person investigating the bug into the wrong
> direction by interpreting essentially random data as type, handle and
> length.
>=20
> > and perhaps also the offset of the header in the DMI blob (i.e., "data =
- buf").
>=20
> I could do that, as it isn't leaking any information, and this could be
> used to compute the memory address at which the corruption was
> detected, which is probably more useful than the number of the
> corrupted entry. Thanks for the suggestion.
>=20
> > When looking at the error reported by user space dmidecode, the first t=
hing
> > I did was add those fields to the error message.
>=20
> And this did not give you any further insight, did it?

Agreed.  The offset was probably more useful than the fields from the
header. With the offset, "hexdump /sys/firmware/dmi/tables/DMI"
shows what the bad data looks like.  So if you want to do only the offset,
I'm OK with that.

Michael

