Return-Path: <linux-hyperv+bounces-11631-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id s8SBA8rFMmpW5QUAu9opvQ
	(envelope-from <linux-hyperv+bounces-11631-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 17 Jun 2026 18:05:30 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E33069B3E2
	for <lists+linux-hyperv@lfdr.de>; Wed, 17 Jun 2026 18:05:29 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=outlook.com header.s=selector1 header.b=ttUqnLxc;
	spf=pass (mail.lfdr.de: domain of "linux-hyperv+bounces-11631-lists+linux-hyperv=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-hyperv+bounces-11631-lists+linux-hyperv=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=outlook.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 30BBA30CE29E
	for <lists+linux-hyperv@lfdr.de>; Wed, 17 Jun 2026 16:05:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BBC34963D1;
	Wed, 17 Jun 2026 16:02:57 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazolkn19012016.outbound.protection.outlook.com [52.103.11.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B91C94A2E34;
	Wed, 17 Jun 2026 16:02:41 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781712176; cv=fail; b=nDGy7G/hqWz50nWElB4DRfpWg0POuDbGpP5aEX7e4kQUgpC9mmPqkma9tlvHA8TApQ/Kg5M9ByV391jq83Mi0KxmBd1WFSOO+UM4aTonPkb2dqavqTkWh7N0N+9GuwTGFXnI53Qg99pcch08XaA0uawOpvbPDFgoLowv9CPSMm4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781712176; c=relaxed/simple;
	bh=H+d+enUzL8kXHgqO7gG0UHu7p+iul8X9l+vtge34KYY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qXvPTCLD+g85Uk+CTiqmbmCYkTxuDV9+mcT/ebWcLg6trPPfLMUVu6fD8t3/9EatpmL52lZ2WTLicfe9LysRyph+S+OYho53cpPtI/Rch1tduL2H3N5IN+VowTIy/gyKZBcsRHNcr3ESemzI7zbsgEWyZAk6s83yM5jqazlbapo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=ttUqnLxc; arc=fail smtp.client-ip=52.103.11.16
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q+O42aHEry90m0Bmb233ZZIXifGMWn15HCucdwqiGVR7xCPZeUf+aFAUvirITFDs8TemD201OrZtGcXctpfUyA0ie78kiu+Ww8V11NgoQPe5cGCXlz5R6XPS8aHUUyGozBxeg82txTxHCRfrgoj9T83pWttHBZxItuSC22mFovLZNWK0k71w/DJwKMnQsuOyLPlXBl+vZSlnOxTNr+WYPGGq0b4v1UoqZCCCVYAA8fQ7oM7PfjWtiCxfH3oeb9dPQGWsY/7eJOLKpZJN6C0Uizv1aq9KZZx9uGND2ElkE9766zZqTjGVHu48lR+9vmMdjDPn97eLDU6N1wvK/Phy9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LX4Iw2ScPl49LKoUK2PfY4rNdCEeLgYtl1YcA+uYj9Y=;
 b=adGKQwTmMssCMJwngej/m05JsbnWgv5w6fjTke8lxGa3qr5kR44YaLJiRH8rxQupf7x08D37H9JXMJRAXzlvXkfefrsmGA3vTX1b1CgC2g4ML2Mi+5DwZHUfdMtq3G/8DjsiCpXCz6H+u2Ra/0ftjhHbywQLRY+dHxC4sloHG9lnW3ET1kOdYzCJHVgslxGQ0Rpv33pqcOwMsqh6emuAF9C4EZaqaVnCg4nYxU+xdLfxkhPjLH57gSrMWnii1LQETxzkccvqbqEbXA24IjuMk8E6ZN+clSjxn8GfiFAsiatAXGJxp7Lym76qprh5flpzt/B9Z/PBHubHRgyvoTLQPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LX4Iw2ScPl49LKoUK2PfY4rNdCEeLgYtl1YcA+uYj9Y=;
 b=ttUqnLxceB33RordtirQ2xbArKF4VRiq2e4sbeZYhoL6y5wc+wbAeI3iJ8F+V/3aQH6JS2KLt0dQ01AnsAP3Sh6y21wLs9nA3zuNt+hZbCoRRuRIb8uruVz1f5MyhyGwKSNa3dELQ/ye0rwHDOAsFAehrLfAti/vjYkIIdj749GCsboVDx1N72QkG7i2aPSBLnENnIPsDKeVITeLFj8N4nOvfoje7wkb+5x/q9vdupkpaRjCGK5delkmMS27OAak1KbnTniesQRtoG9gvfNLxxCGMAzRyHoTsiQcxz6nqX75V6muWhr7QAp7OJst0yPCGBbfCapBosrcsrJEZpK1Zw==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by CH3PR02MB10280.namprd02.prod.outlook.com (2603:10b6:610:1ce::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Wed, 17 Jun
 2026 16:02:39 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6%3]) with mapi id 15.21.0139.009; Wed, 17 Jun 2026
 16:02:39 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
CC: "K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang
	<haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan Cui
	<decui@microsoft.com>, Long Li <longli@microsoft.com>, Lorenzo Pieralisi
	<lpieralisi@kernel.org>, =?iso-8859-2?Q?Krzysztof_Wilczy=F1ski?=
	<kwilczynski@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>, Rob
 Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH] PCI: hv: add hard timeout to wait_for_response()
Thread-Topic: [PATCH] PCI: hv: add hard timeout to wait_for_response()
Thread-Index: AQHc/nDsmF4XHn0uSkWoerJoFRnNC7ZC6Isw
Date: Wed, 17 Jun 2026 16:02:38 +0000
Message-ID:
 <SN6PR02MB41575A367289AEE6293AD71BD4E42@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20260612174010.2598695-1-hamzamahfooz@linux.microsoft.com>
In-Reply-To: <20260612174010.2598695-1-hamzamahfooz@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|CH3PR02MB10280:EE_
x-ms-office365-filtering-correlation-id: d5b54193-77f1-4b7a-e65f-08decc89daf4
x-microsoft-antispam:
 BCL:0;ARA:14566002|8060799015|8062599012|13091999003|37011999003|31061999003|19110799012|19101099003|13031999006|41001999006|51005399006|15080799012|56899033|102099032|40105399003|3412199025|4302099013|440099028|1602099012|18061999006|10035399007;
x-microsoft-antispam-message-info:
 =?iso-8859-2?Q?HlaIeUPTbQYjQByfW8ZGu+5gECEgZ+gaPZg+K34Eme+kgsRe8412hyEZu7?=
 =?iso-8859-2?Q?wZvxfal09WPKSG4boFlDexeZo87MOfmIc4gBEbz7jnltt5ad0mhxefJWz+?=
 =?iso-8859-2?Q?goIfJ4sKB8+bgyZaLILgz00pqM21R/S60TAV05B8F0P7o44wFkRz8M3UeK?=
 =?iso-8859-2?Q?adcxGZJ7sjZDw6VXWEszyDQXy0g6/rxFqzQlgwW/RAUuFj2hIkuesjMXvO?=
 =?iso-8859-2?Q?u3lQoN/Um3zSUCUHroB05GC/VFitjllc70W4Png4h7nV0p0NOcISoPQDvJ?=
 =?iso-8859-2?Q?r9Lc+V6s89WWf86fhY9JY2BWehQdUt2v87ioR2gG2tUs6XEdC4DtaW9i+B?=
 =?iso-8859-2?Q?6wyJYk7JiDLeS/HXLy9YJIknFqUQDKvTUHLOVYnxJkkcrOg0WUY5woAYX+?=
 =?iso-8859-2?Q?I29PSD4VcteW92cosx+yeh9nyX9UXUbCaHgBEWWnmh+9BbkUaH3UFx/pey?=
 =?iso-8859-2?Q?U18jKxGuoa42DWluGjEi0G0Ned5QhYYQd5Jwijhp5eqNqfL+6lSm5WBy0L?=
 =?iso-8859-2?Q?/mCOnBjqwm5b8h//jEQzsYr5lCv/oCmXwFFZm62HzFYN8krerrFXshVKie?=
 =?iso-8859-2?Q?RHNpVVv/dZJP93Uqr6To0Fy1dl/qYokIltdMtwsoigk/fR0tDyjGborQbc?=
 =?iso-8859-2?Q?ClD6KQrE0nichDDvtP0iaHch0IV/OQunYhlD90HWsjR3T2r3IZj6e7mHH5?=
 =?iso-8859-2?Q?RANFjwo/3O2TLquQzE2SOd+Z+famMfO4RJNg8SUoAdeh8mTouGbs3zoftW?=
 =?iso-8859-2?Q?4N/f/mrfPcpPjuroA2KC8X4x3FtjWO6nibDtjj1DsyDi3QD+K3RnEcQOpa?=
 =?iso-8859-2?Q?iObJGufvJvCvYu3KdEKyJ0t4hva04Y3Byo7brRUBoqBvrn4tydjuYbmxgy?=
 =?iso-8859-2?Q?diJ3mog3qj/Sw9xX2lLmMgN/4uL6UjiBcLdIBDn+EvSwo7fB/OPJvf3hiU?=
 =?iso-8859-2?Q?NHmAy/XQ1gBA+EB5m7iqLBPggXJN+AX2ACt0kKL6k/KKqgNXrH1iJ5+30m?=
 =?iso-8859-2?Q?M+8Q0yEBZTNo2ElZQxKme0eX3ZzaLmg1HWfVM/6rYQgho4h28nAYRlzch0?=
 =?iso-8859-2?Q?rdFg1w7mqfY1Bpd3jEYJcv9Uc+U4Zl0pW/bDeu7JXJB/FUK1/Ue2wiaL8s?=
 =?iso-8859-2?Q?uLvHbSukXnSJsA8+NvdI4/gG0sghwm4sZxQwQNiei7fBUejth7uGYU2Lms?=
 =?iso-8859-2?Q?6l6Bt1DuJiRZnPnd24eEmgjl7/bHwolBaUSd4K4swwbnD6436BoTczji?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-2?Q?CeafQyQce35vSY+i3DRR30a5FAfeqNZGqCrdU5gLEt7yfSynZrvVPeGSmO?=
 =?iso-8859-2?Q?sJxkOc3XnTXOo/ZElNzMxGhAF0bpGgFTXeX0BtsRaiYzdorRh3Olze28Xe?=
 =?iso-8859-2?Q?jY71SHVlvl1TFjvQ6/hfPOWAc7YrNb2zSFVkvsofavnqJke5kDfDa1iJ0j?=
 =?iso-8859-2?Q?B3tlZg05GloDFevDuMjmwWwIBsqQWf7z8XKHXzicu8jlzzDzS2QEs3b1Fw?=
 =?iso-8859-2?Q?B8gXWPlZlUlVBvBU0FWh/10sRq3IgLrQy3aNSqeIUEnZjDDbj0h5F3cuFL?=
 =?iso-8859-2?Q?H2u9L6XD8QEGq7lmmhaMdV1hL7YTsg70aSGs8JvoJruXmkfedd0c6vy5nW?=
 =?iso-8859-2?Q?OEpoigFsEd5isqcPQMlHK2sP5VIYTeDbLM3FxFixeo4T3DU6lD9au/P7tu?=
 =?iso-8859-2?Q?YtLRDIGhc9DwmlSjU0PTMyealJSNfPwaJIh/e0dwkF6Vh0KoAfqFNLc/rE?=
 =?iso-8859-2?Q?PAjMJ+VFUw4Bdex11YUjLP+QaT3LrWRf/kI4JUmfgLsBCr1sRFkQl8sAGA?=
 =?iso-8859-2?Q?qmwtPzs5NEFGRpDs0l5zWQp6xiXViIdGTYSpdqXyAUt1uAgFvze7Uwb2y7?=
 =?iso-8859-2?Q?3bUSb7FLt7yzEmkRuRv+li09CdsCO0FF7sOY08Y8sjD5Iw+hWzA/D1Owvj?=
 =?iso-8859-2?Q?jE/6VPKzgL1VuOgGyQtqz86z0FKFn+9LI0yx6WXQEqrg3r1+y76ccdvdje?=
 =?iso-8859-2?Q?dJieZWHvxcP7g0ajnsh7f8SW5tw9TqY/lDsHnY7a9LKWgnNAz89CY67tZp?=
 =?iso-8859-2?Q?343vMAqWJ6kdm/6CNbpQcgW5dMW6RHrkmhmMsxTtYjw0zZAUh3rXRzxpX8?=
 =?iso-8859-2?Q?oKg7XA/lg9cXNV8GOK9o16vOkgpW3BULF3f+fXDNMiNtUdGzwVtWm9nD8n?=
 =?iso-8859-2?Q?90xGvLbd7ZFy6LBrF86X1H5xZPwlk0ziBOs0sDp6s78JgRmu09Xc87uN7z?=
 =?iso-8859-2?Q?NWUmY4yZHtKdAMmszNvqnA00XEM2h7u3UEjYLULAL5c99BriySN/j2kWgZ?=
 =?iso-8859-2?Q?VAZ7O7hxUABdYqmU+2IX/A3zWcfRAOCFbzIWbsxymyUbYcwqiYw4rOf1g9?=
 =?iso-8859-2?Q?zph3ozLbPQ6GodaO1nCBWAbsHwyZ00oM7ylAubccnwjkYQ3p3JK3dk8d8r?=
 =?iso-8859-2?Q?N0fL3guQmnBb1udX77GI9gElFNgxZdB4YCUn4qR6lqNQ9zCHkOnDe8nZmp?=
 =?iso-8859-2?Q?1B44/lHHo1M/Iaz4Q4loIqTVAedPf2YXxIPKee5Bpz2aaniEb8CbQIGoiI?=
 =?iso-8859-2?Q?npQ3+o2x2Y8WflYYrgjqXT99Ia+msV++UF5pXDRzqREqMtU5CvZNN8uGHx?=
 =?iso-8859-2?Q?WLehX4hBHa1PqRhgJOPvXYDmFCYGuOAeXUCeSgwqLz17XFHRnS+5Sxmd3v?=
 =?iso-8859-2?Q?2R7O0ZOVdLUHpW3oiu68e2eODs30fx+JZ2Xmm6sWAQFIm+QBxQPj0=3D?=
Content-Type: text/plain; charset="iso-8859-2"
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
X-MS-Exchange-CrossTenant-Network-Message-Id: d5b54193-77f1-4b7a-e65f-08decc89daf4
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jun 2026 16:02:38.8769
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR02MB10280
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[outlook.com,none];
	R_DKIM_ALLOW(-0.20)[outlook.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11631-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:hamzamahfooz@linux.microsoft.com,m:linux-hyperv@vger.kernel.org,m:kys@microsoft.com,m:haiyangz@microsoft.com,m:wei.liu@kernel.org,m:decui@microsoft.com,m:longli@microsoft.com,m:lpieralisi@kernel.org,m:kwilczynski@kernel.org,m:mani@kernel.org,m:robh@kernel.org,m:bhelgaas@google.com,m:linux-pci@vger.kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[mhklinux@outlook.com,linux-hyperv@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_FROM(0.00)[outlook.com];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[outlook.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mhklinux@outlook.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	MISSING_XM_UA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-hyperv];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,outlook.com:dkim,outlook.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6E33069B3E2

From: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com> Sent: Friday, June 1=
2, 2026 10:40 AM
>=20

The addressees for this patch include the linux-hyperv and linux-pci
mailing lists, but not the broad linux-kernel mailing list. Any reason not
to include the latter? In Documentation/process/submitting-patches.rst,
in the section "Select the recipients for your patch", it says

    linux-kernel@vger.kernel.org should be used by default for all patches

I subscribe to the broad linux-kernel list and do my own filtering, instead
of subscribing to individual subsystem lists. So I didn't see this patch
until I glanced at https://lore.kernel.org/linux-hyperv/. Following the
guidance to always include linux-kernel would help me, for one. :-)

Thx,

Michael

> It is possible that we never receive a rescind event, in which case we
> will wait indefinitely for a device that will never show up. So, assume
> a device is gone if have been polling for more than 5 seconds.
>=20
> Cc: stable@vger.kernel.org
> Fixes: c3635da2a336 ("PCI: hv: Do not wait forever on a device that has d=
isappeared")
> Signed-off-by: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
> ---
>  drivers/pci/controller/pci-hyperv.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller=
/pci-hyperv.c
> index cfc8fa403dad..bd63efc4a210 100644
> --- a/drivers/pci/controller/pci-hyperv.c
> +++ b/drivers/pci/controller/pci-hyperv.c
> @@ -52,6 +52,7 @@
>  #include <linux/acpi.h>
>  #include <linux/sizes.h>
>  #include <linux/of_irq.h>
> +#include <linux/jiffies.h>
>  #include <asm/mshyperv.h>
>=20
>  /*
> @@ -1038,6 +1039,8 @@ static void put_pcichild(struct hv_pci_dev *hpdev)
>  		kfree(hpdev);
>  }
>=20
> +#define TIMEOUT_MS 5000
> +
>  /*
>   * There is no good way to get notified from vmbus_onoffer_rescind(),
>   * so let's use polling here, since this is not a hot path.
> @@ -1045,8 +1048,13 @@ static void put_pcichild(struct hv_pci_dev *hpdev)
>  static int wait_for_response(struct hv_device *hdev,
>  			     struct completion *comp)
>  {
> +	unsigned long timeout =3D get_jiffies_64() + msecs_to_jiffies(TIMEOUT_M=
S);
> +	unsigned long now;
> +
>  	while (true) {
> -		if (hdev->channel->rescind) {
> +		now =3D get_jiffies_64();
> +		if (hdev->channel->rescind ||
> +		    time_after(now, timeout)) {
>  			dev_warn_once(&hdev->device, "The device is gone.\n");
>  			return -ENODEV;
>  		}
> --
> 2.54.0
>=20


