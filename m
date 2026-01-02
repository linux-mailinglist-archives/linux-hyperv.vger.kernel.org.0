Return-Path: <linux-hyperv+bounces-8115-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DFA62CEEF72
	for <lists+linux-hyperv@lfdr.de>; Fri, 02 Jan 2026 17:27:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A1F3A3011193
	for <lists+linux-hyperv@lfdr.de>; Fri,  2 Jan 2026 16:27:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E7402BE7CB;
	Fri,  2 Jan 2026 16:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="B+KCg7C5"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazolkn19012049.outbound.protection.outlook.com [52.103.2.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EF182BE7B6;
	Fri,  2 Jan 2026 16:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.2.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767371246; cv=fail; b=NadjeHFUzt/p0rs2o0r7MI4y9d1BI+9WzsWNVuihmI5IIFWhpphWJ0ERj5HTeVbM0WndlTb2xpE2K9pgBjjfl3HpemcUPU/aejSX8jjv4eNtA+QABw1hhM8ZGoHkQq0E+W4hUEw9N876xsulIoFDOSlURiJ6vKcF9bQFijwzH/k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767371246; c=relaxed/simple;
	bh=B9IYJyuozUVeEWrPhfbyPV4+W+5IsyxinKDI3tmnB2I=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CDUlng6vik+tlm4XbD6GQnceCycBX6qU/pPTNc6Ab9jl8nN+VITEAloyj6m+parJdP1/QHZOpdxRxdb8Myw8+hnpUW5DItdVrT3xBAlbby2r+GK211jI3lYZurzzkOBNA5faMpqP79Sa/TSmhAP2gzwBZ9JrAeTwaBpw5OnWLeM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=B+KCg7C5; arc=fail smtp.client-ip=52.103.2.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V+rkFrtkFLD36tFLrnABueSqf05S24QsckWvQvy4HfhkoHze+h+2oFWdWLP54g39+z/cFIZ6PkWNERAoC/AZBxWOvI8qdpgoCYZSi4P/8EorNNuoyxgkrMVIFEwFhYThmL8ab33TiKrqbPUXlxgByWyvLzIruyuj9iiFkMWGPt08Zdk8cltk96lHUGfio2YCNvDtn45pCo9bjlucBCRcgH6KODa6lHOkADYVZwXX69Gim98SH+g9usaRq9a6A/1Vwc1q6o2zM0xBeq1caitSKKk5gFVsJpJGbQsfn88m2XEjao2Xr8IHoAqIuIK0VbKgFh5yHspAg0PE5YO8hfY9lQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CKAYp5uxMYZDrNSaTe5QA2XmkSU5kN8Z0dgvlB54BZU=;
 b=PQp+8IaF2sfqUAjCXZZzo0MxSdmgEfdWw+qwZGTA0WJc4xcvJWXzRLaOZzGT6OsRP2RnTO5xZD675xlQtXBJV+bu5Ngm+ulT0FVhjlidF/5wFGxMG12dAQ+osSjN7RUYq+krIGZ3clwIpnFGsykyZ4puWAIZvQY3Rh+w6TAwFyAlmHikYbxNXROVcKOp7OfJ7MJ16RFqwvC8zA4Jo1k+F1L4eZP27UbgkO8TCH6sj4CzQSnfR303ew6IhphR8Ie+0pC/8/59Eup+dR9pb0YQukT/nB8RK7ZJJHCIFPsBt+jRemsG29V3J0G2FbIQQME5mVOQdJQJuEK+DNllb9WEqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CKAYp5uxMYZDrNSaTe5QA2XmkSU5kN8Z0dgvlB54BZU=;
 b=B+KCg7C5eTibFg+HDo11pxBejwanFX9PdfvxiRQia4O+g6yLmuZVY17jHXriDiS8ZQue5RYsRbfD/qXtCRxK4YN+gJSxYhL3UIPlSA6/zfsEQ0TxmoGP2SkM+1TPmPBWdpbBcBwVD1nw0pwplwQdj5mfimDZ7W2ZIX1EPNYNYy/+oOejeaC+wxQI6SB2ITq9H+crzp54zESHiKxEh7nuQK8xVdolj+e8Vu2ZJJsEgzb7GwskUEfPbqFlEOZ5Dulei4XX3ohpkfExZ5BDjUznHSKmRs84Yo+LoMiguDj2Mup1tSMAPDF7AH0g+a6P4MVnVVDzJg1yyGT7q/dCDXJe3w==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by LV9PR02MB10829.namprd02.prod.outlook.com (2603:10b6:408:2e8::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Fri, 2 Jan
 2026 16:27:20 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6%3]) with mapi id 15.20.9478.004; Fri, 2 Jan 2026
 16:27:20 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Nuno Das Neves <nunodasneves@linux.microsoft.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"skinsburskii@linux.microsoft.com" <skinsburskii@linux.microsoft.com>
CC: "kys@microsoft.com" <kys@microsoft.com>, "haiyangz@microsoft.com"
	<haiyangz@microsoft.com>, "wei.liu@kernel.org" <wei.liu@kernel.org>,
	"decui@microsoft.com" <decui@microsoft.com>, "longli@microsoft.com"
	<longli@microsoft.com>, "prapal@linux.microsoft.com"
	<prapal@linux.microsoft.com>, "mrathor@linux.microsoft.com"
	<mrathor@linux.microsoft.com>, "paekkaladevi@linux.microsoft.com"
	<paekkaladevi@linux.microsoft.com>
Subject: RE: [PATCH v2 1/3] mshv: Ignore second stats page map result failure
Thread-Topic: [PATCH v2 1/3] mshv: Ignore second stats page map result failure
Thread-Index: AQHcZhkveM6Wdb5Qy0aycTcpRguOfLUXNUnQgCJEsICABa5VAA==
Date: Fri, 2 Jan 2026 16:27:20 +0000
Message-ID:
 <SN6PR02MB415774DC14AA213C47C443ABD4BBA@SN6PR02MB4157.namprd02.prod.outlook.com>
References:
 <1764961122-31679-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1764961122-31679-2-git-send-email-nunodasneves@linux.microsoft.com>
 <SN6PR02MB41578C85BD5C114340677F84D4A2A@SN6PR02MB4157.namprd02.prod.outlook.com>
 <9a997f03-f1be-411b-b4b2-c28069b2a3ce@linux.microsoft.com>
In-Reply-To: <9a997f03-f1be-411b-b4b2-c28069b2a3ce@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|LV9PR02MB10829:EE_
x-ms-office365-filtering-correlation-id: 19286cf6-b6e9-44a6-75fe-08de4a1bcda1
x-microsoft-antispam:
 BCL:0;ARA:14566002|41001999006|461199028|51005399006|15080799012|19110799012|13091999003|31061999003|8060799015|8062599012|12121999013|440099028|3412199025|40105399003|12091999003|102099032;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?mTl24kOp/UI0iECzd2wIbTnjBpPmVULkVBrB2NoBrdBHP9TYm5FKS8exFHNS?=
 =?us-ascii?Q?kBGuDWrzp3T+qjDKCdE3aHgqyU26Oi7Hl1OeZ01Mg8KD3mnYzQ+R5aEvRW1S?=
 =?us-ascii?Q?pI2M+pN6wqYUPVucyWeRCCijtQPv6g1Ulc4bdW8YcmhFc4dRVvjpH9iw1tEg?=
 =?us-ascii?Q?HlnSkQCjhebb/XSuoWLe86TBuG8X2bVxCErU349eYP+6Ng9J9xgCv9qR5Z+a?=
 =?us-ascii?Q?1wvuW45UcPfI1yTu+v/TurcJbAao8tnQjsRA/LUwBBu+xn5kC4nyeFZpwde1?=
 =?us-ascii?Q?aqFocjtvH/RmVxHDcILQk5RZfWKMPDcqA+E2aCtkGTVgscr5QGc30zo+G9cC?=
 =?us-ascii?Q?NYFEDthJpL+IufSactf0y8PjR06YCZWjeRHoXZCuhbO/9HO6Fh+mVK/y6D+v?=
 =?us-ascii?Q?RQgAa23Zpuni4WqRDgd5yLJsOp7rRgvxLPgfCuRcyf57wd1sooqQkBIH5QXG?=
 =?us-ascii?Q?sm+m/aMCT0r7Vgd2mt79O762dapwTp7bHD3isqLrpCeX8sifoksQvdLxwo36?=
 =?us-ascii?Q?7xCfGg6dFNxdz0Z3xDb9vHss7caVaD7fqApLbEDxubY7vCWqBZTGIiNJ1t9l?=
 =?us-ascii?Q?q5vggIMexA+hY5DMAZm0mQZM1GjMPDZk/LTqgqifzLuwDDZupi5ubQxLMfA0?=
 =?us-ascii?Q?Yg3gvaxxnm7OjR1sNehXD8eLBdH4qGn+xC/RCqWJ3LB9zYBlKVH5eAc1pKsg?=
 =?us-ascii?Q?aPCSEYmXNqJpLqnYa4eXoKIaLtEvRDzn7T4fZO9zLHCY0J/bYU5Gvz2roTka?=
 =?us-ascii?Q?vZRXMVO7GU5+PSAan4Ozxwy5lWBYjDAPfDYNO+66PErWvmB7eC35R00bcdIC?=
 =?us-ascii?Q?1P6TO0b+wOI0EzNiEShxg01eeEEilWg8wRtIzIlxf86DjYZILmmyCLh7iwfQ?=
 =?us-ascii?Q?/gcb1jbMufHLjfwMk5Mn5nsYo4AU2X+hyw0FJIucJayIIMZt9u0j+fZz2p9y?=
 =?us-ascii?Q?q26PsfVuqMM6wBP3U2x80Fpy34dfrLNH0j2CsCxuZrmSjqDX69maeNwurbIF?=
 =?us-ascii?Q?xqF5f4z9LPmbrfL+ta0fas8LoLlV1cBhO4h50fzxEv0h8Zp26iZRpd9lUm6o?=
 =?us-ascii?Q?iHoBszFBJtL+tKk1SXi4K5QXcZ7CbVCuUR5NrmuqLduSk6t8FLVz3sYTRmuS?=
 =?us-ascii?Q?240qXYK4dKg62uohwHYqbN8DeVLcC0jMumspO+Y8VAsuQygyHxhhdkNEsz8L?=
 =?us-ascii?Q?uo2Ct2FmH3JK5GVL8Ymb/rujzV4Om/thJqDIX4Qo80lhj02UDdyqm+mSS/rL?=
 =?us-ascii?Q?BvlU9TttZHDtXRiYlwOS3H8OIPAPP3pmdDFeoa+CrkOCGT+xk1uDCS2vbt2I?=
 =?us-ascii?Q?6yhyBfrocmTcpnDciZ/+bFDS?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Z3n84X2abxImBtIjMJPUBDTWEHA5KTENxpf+Wp+EKjZYmfjtj3uVkUmm50cO?=
 =?us-ascii?Q?xOBEg5PNlBPtg24IXT1MGyHtJDhz0Mrjkc5aPeJqUpy8oKnnas1W/mjfonAb?=
 =?us-ascii?Q?hC+rGjrOCvjMVS9Hw8AcE9uY9InqqMYeb+ML9xtACR8AZ7Uhq5dzlu1ptF0T?=
 =?us-ascii?Q?WaZgUV83x63LBqvUi3/6cLad9HAr4xCVotKiXRiCPNvgDKhs7rPUBV4qgBEz?=
 =?us-ascii?Q?mpnS/6Xe1vliLY5lLaNxWdop47jIH6oxPj2Q6H5d775Mu6mwyjdtLO2b0z2p?=
 =?us-ascii?Q?+F+Fd8xWnzBAZ21AofYRAMCvLwM53Q9pw8gagqEj6EBhTMjZFzrTBvXp28EI?=
 =?us-ascii?Q?hQfKo/vDrWGL3XcbtNcY68sdGCXbmtiOPLcpY1yeHbJtCrckvY6nm83dbR/r?=
 =?us-ascii?Q?AKSQ6QIC2S9Y8VkI4AFj8GBokQolEWEwXKxq4lkWnSb3JLGbCNZZ3ph2ohIS?=
 =?us-ascii?Q?E/RB7flP7PEcvfbbxJCFbnastGdd9r47vJ2mQEYN7BgkgmH53VFRFkez9KGK?=
 =?us-ascii?Q?r/sVHpTAAkpT0y5hKkZ9lHZbplklbR2nnHpmxmgxETq+IGhRnyAO4925JDF0?=
 =?us-ascii?Q?evcvfiDzyDXbYPyBnON8erBaeh7B8/88xh3dnwbxzOjbe7V8VwQskoThcclq?=
 =?us-ascii?Q?wVTprcK7bhGzajpNrJmQjzTfh83yU05jyAR/BcvYNQ80D9h4BXkLDcky0p/E?=
 =?us-ascii?Q?7XRkYyyUM9apAEbLE5XvKUEYXcStU01hA3orRCxfFcWb/RqMeq8r2QI/CGGg?=
 =?us-ascii?Q?h+w5AINV2QjsbNFbaaFqjzjM/FSGpCJxNjNc2+P73SpArb9Dw06aMxTrX2cI?=
 =?us-ascii?Q?XbWczvuul5emCCTPXfKgZFXp2ITk8LCAQX26WPbRkReDGQQ/kkq4OwXASpnd?=
 =?us-ascii?Q?Ii3bZRpKQfeJCC+n7tvgEK74mxcmPz4e+3+vk8btCoefBnfS9DtO7QrRnFgb?=
 =?us-ascii?Q?w/5dfwexb20D0af7Al58oezYHKS/ruLlPppqX+w836KP+FloQ7gt/tWehCEk?=
 =?us-ascii?Q?b7xsuPXlTuXKCYaPDXpEiv10dvuEPakvdXwYLChsVdWKcv18/47vwvnA/Smn?=
 =?us-ascii?Q?aOz0FQfTgR/H9w3ZKlEyNCLeIuGhZ0TU2h7y7Ducivpjs7xXdBVXSg9S6xDZ?=
 =?us-ascii?Q?57IPd/gxBf4o7oOEnyeFne/Jq8/PPZHTmTBKsBP+my7W8LTUMEgH4AJd779a?=
 =?us-ascii?Q?yTx5R5mmIHxfaOzOxdwheReR+4XNM1sW5gPSYIpyn/qe8DSwADVyJIdIdAqd?=
 =?us-ascii?Q?3nEwYlUDA0qTcgiAW4JvcWIrIDqHa50MVr4Q8ci7Q/eHnRYcQdsYkMjFxcJN?=
 =?us-ascii?Q?pnOxmVQNZoSNs0QvDBSM7v/WqM0Q74Llta+8Kj/BC5TdWuakTV8CLzUAJuqT?=
 =?us-ascii?Q?IJJqB1A=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 19286cf6-b6e9-44a6-75fe-08de4a1bcda1
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jan 2026 16:27:20.7376
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV9PR02MB10829

From: Nuno Das Neves <nunodasneves@linux.microsoft.com> Sent: Monday, Decem=
ber 29, 2025 4:28 PM
>=20
> On 12/8/2025 7:12 AM, Michael Kelley wrote:
> > From: Nuno Das Neves <nunodasneves@linux.microsoft.com> Sent: Friday, D=
ecember 5, 2025 10:59 AM
> >>
> >> From: Purna Pavan Chandra Aekkaladevi <paekkaladevi@linux.microsoft.co=
m>
> >>
> >> Older versions of the hypervisor do not support HV_STATS_AREA_PARENT
> >> and return HV_STATUS_INVALID_PARAMETER for the second stats page
> >> mapping request.
> >>
> >> This results a failure in module init. Instead of failing, gracefully
> >> fall back to populating stats_pages[HV_STATS_AREA_PARENT] with the
> >> already-mapped stats_pages[HV_STATS_AREA_SELF].
> >
> > This explains "what" this patch does. But could you add an explanation =
of "why"
> > substituting SELF for the unavailable PARENT is the right thing to do? =
As a somewhat
> > outside reviewer, I don't know enough about SELF vs. PARENT to immediat=
ely know
> > why this substitution makes sense.
> >
> I'll attempt to explain. I'm a little hindered by the fact that like many=
 of the
> root interfaces this is not well-documented, but this is my understanding=
:
>=20
> The stats areas HV_STATS_AREA_SELF and HV_STATS_AREA_PARENT indicate the
> privilege level of the data in the mapped stats page.

OK. But evidently that difference in "privilege level" (whatever that means=
) doesn't
affect what the root partition can do to read and display the data in debug=
fs, right?

>=20
> Both SELF and PARENT contain the same fields, but some fields that are 0 =
in the
> SELF page may be nonzero in PARENT page, and vice-versa. So, to read all =
the fields
> we need to map both pages if possible, and prioritize reading non-zero da=
ta from
> each field, by checking both the SELF and PARENT pages.

Overall, this mostly makes sense. Each VP and each partition has associated=
 SELF and
PARENT stats pages. For the SELF page, the stats are presumably for the sin=
gle
associated VP or partition. But "PARENT" terminology usually implies some k=
ind of
hierarchy, as in a parent has one or more children. Parent-level stats woul=
d typically
be an aggregate of all its children's stats. But if that's the case here, c=
hoosing at runtime
on a per-field stat basis between SELF and PARENT would produce weird resul=
ts. So
maybe that typical model of "parent" isn't correct here. If SELF and PARENT=
 are only
indicating some kind of privilege level, maybe the PARENT page for each VP =
and each
partition is like the SELF page -- it contains stats only for the associate=
d VP or partition.

>=20
> I don't know if it's possible for a given field to have a different (nonz=
ero) value
> in both SELF and PARENT pages. I imagine in that case we'd want to priori=
tize the
> PARENT value, but it may simply not be possible.

It would be nice to confirm that this can't happen. If it can happen, that =
messes
up trying to construct a sensible model of how this all works. :-)

And a somewhat related question: Assuming that a particular stat appears in
either the SELF or the PARENT page, under what circumstances might that sta=
t
move from one to the other, if ever? I would guess that for a given version=
 of the
hypervisor, the split is always the same, across all VPs and all partitions=
 running
on hypervisors of that version. But a different hypervisor version might sp=
lit the
stats differently between SELF and PARENT. Of course, this stuff is overall=
 a bit
unusual, so my guess might not be right.=20

I ask because making a runtime decision between SELF and PARENT for every
individual stat, every time it is read, is conceptually a lot of wasted mot=
ion if the
split is static and know-able ahead of time. But I say "conceptually" becau=
se I
can't immediately come up with a way to make things faster or more compact =
if
the split were to be static and know-able ahead of time. So it may be moot =
point
from an implementation standpoint, but I'm still interested in the answer f=
rom
the standpoint of being able to document the overall model of how this work=
s.

>=20
> The API is designed in this way to be backward-compatible with older hype=
rvisors
> that didn't have a concept of SELF and PARENT. Hence on older hypervisors=
 (detectable
> via the error code), all we can do is map SELF and use it for everything.

In cases where PARENT can't be mapped by the root partition, does that mean
some of the stats just aren't available? Or does the hypervisor provide all=
 the
stats in the SELF page?

>=20
> > Also, does this patch affect the logic in mshv_vp_dispatch_thread_block=
ed() where
> > a zero value for the SELF version of VpRootDispatchThreadBlocked is rep=
laced by
> > the PARENT value? But that logic seems to be in the reverse direction -=
- replacing
> > a missing SELF value with the PARENT value -- whereas this patch is abo=
ut replacing
> > missing PARENT values with SELF values. So are there two separate PAREN=
T vs. SELF
> > issues overall? And after this patch is in place and PARENT values are =
replaced with
> > SELF on older hypervisor versions, the logic in mshv_vp_dispatch_thread=
_blocked()
> > then effectively becomes a no-op if the SELF value is zero, and the ret=
urn value will
> > be zero. Is that problem?
> >
> This is the same issue, because we only care about any nonzero value in
> mshv_vp_dispatch_thread_blocked(). It doesn't matter which page we check =
first in that
> code, just that any nonzero value is returned as a boolean to indicate a =
blocked state.
>=20
> The code in question could be rewritten:
>=20
> return self_vp_cntrs[VpRootDispatchThreadBlocked] ||
> parent_vp_cntrs[VpRootDispatchThreadBlocked];

OK. It would be more consistent to apply the same logic (check SELF then PA=
RENT,
or vice versa) in both mshv_vp_dispatch_thread_blocked() and in this new de=
bugfs
code. As you know, for me inconsistencies always beg the question of "why"?=
 :-)
But that's a minor point.

>=20
> >>
> >> Signed-off-by: Purna Pavan Chandra Aekkaladevi <paekkaladevi@linux.mic=
rosoft.com>
> >> Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
> >> Reviewed-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
> >> ---
> >>  drivers/hv/mshv_root_hv_call.c | 41 ++++++++++++++++++++++++++++++---=
-
> >>  drivers/hv/mshv_root_main.c    |  3 +++
> >>  2 files changed, 40 insertions(+), 4 deletions(-)
> >>
> >> diff --git a/drivers/hv/mshv_root_hv_call.c b/drivers/hv/mshv_root_hv_=
call.c
> >> index 598eaff4ff29..b1770c7b500c 100644
> >> --- a/drivers/hv/mshv_root_hv_call.c
> >> +++ b/drivers/hv/mshv_root_hv_call.c
> >> @@ -855,6 +855,24 @@ static int hv_call_map_stats_page2(enum hv_stats_=
object_type type,
> >>  	return ret;
> >>  }
> >>
> >> +static int
> >> +hv_stats_get_area_type(enum hv_stats_object_type type,
> >> +		       const union hv_stats_object_identity *identity)
> >> +{
> >> +	switch (type) {
> >> +	case HV_STATS_OBJECT_HYPERVISOR:
> >> +		return identity->hv.stats_area_type;
> >> +	case HV_STATS_OBJECT_LOGICAL_PROCESSOR:
> >> +		return identity->lp.stats_area_type;
> >> +	case HV_STATS_OBJECT_PARTITION:
> >> +		return identity->partition.stats_area_type;
> >> +	case HV_STATS_OBJECT_VP:
> >> +		return identity->vp.stats_area_type;
> >> +	}
> >> +
> >> +	return -EINVAL;
> >> +}
> >> +
> >>  static int hv_call_map_stats_page(enum hv_stats_object_type type,
> >>  				  const union hv_stats_object_identity *identity,
> >>  				  void **addr)
> >> @@ -863,7 +881,7 @@ static int hv_call_map_stats_page(enum hv_stats_ob=
ject_type type,
> >>  	struct hv_input_map_stats_page *input;
> >>  	struct hv_output_map_stats_page *output;
> >>  	u64 status, pfn;
> >> -	int ret =3D 0;
> >> +	int hv_status, ret =3D 0;
> >>
> >>  	do {
> >>  		local_irq_save(flags);
> >> @@ -878,11 +896,26 @@ static int hv_call_map_stats_page(enum hv_stats_=
object_type type,
> >>  		pfn =3D output->map_location;
> >>
> >>  		local_irq_restore(flags);
> >> -		if (hv_result(status) !=3D HV_STATUS_INSUFFICIENT_MEMORY) {
> >> -			ret =3D hv_result_to_errno(status);
> >> +
> >> +		hv_status =3D hv_result(status);
> >> +		if (hv_status !=3D HV_STATUS_INSUFFICIENT_MEMORY) {
> >>  			if (hv_result_success(status))
> >>  				break;
> >> -			return ret;
> >> +
> >> +			/*
> >> +			 * Older versions of the hypervisor do not support the
> >> +			 * PARENT stats area. In this case return "success" but
> >> +			 * set the page to NULL. The caller should check for
> >> +			 * this case and instead just use the SELF area.
> >> +			 */
> >> +			if (hv_stats_get_area_type(type, identity) =3D=3D HV_STATS_AREA_PA=
RENT &&
> >> +			    hv_status =3D=3D HV_STATUS_INVALID_PARAMETER) {
> >> +				*addr =3D NULL;
> >> +				return 0;
> >> +			}
> >> +
> >> +			hv_status_debug(status, "\n");
> >> +			return hv_result_to_errno(status);
> >
> > Does the hv_call_map_stats_page2() function need a similar fix? Or is t=
here a linkage
> > in hypervisor functionality where any hypervisor version that supports =
an overlay GPFN
> > also supports the PARENT stats? If such a linkage is why hv_call_map_st=
ats_page2()
> > doesn't need a similar fix, please add a code comment to that effect in
> > hv_call_map_stats_page2().
> >
> Exactly; hv_call_map_stats_page2() is only available on hypervisors where=
 the PARENT
> page is also available. I'll add a comment.

Thanks.

>=20
> >>  		}
> >>
> >>  		ret =3D hv_call_deposit_pages(NUMA_NO_NODE,
> >> diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
> >> index bc15d6f6922f..f59a4ab47685 100644
> >> --- a/drivers/hv/mshv_root_main.c
> >> +++ b/drivers/hv/mshv_root_main.c
> >> @@ -905,6 +905,9 @@ static int mshv_vp_stats_map(u64 partition_id, u32=
 vp_index,
> >>  	if (err)
> >>  		goto unmap_self;
> >>
> >> +	if (!stats_pages[HV_STATS_AREA_PARENT])
> >> +		stats_pages[HV_STATS_AREA_PARENT] =3D stats_pages[HV_STATS_AREA_SEL=
F];
> >> +
> >>  	return 0;
> >>
> >>  unmap_self:
> >> --
> >> 2.34.1


