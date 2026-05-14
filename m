Return-Path: <linux-hyperv+bounces-10888-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mNKlA9AQBmobegIAu9opvQ
	(envelope-from <linux-hyperv+bounces-10888-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 14 May 2026 20:13:36 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D8B7545BEC
	for <lists+linux-hyperv@lfdr.de>; Thu, 14 May 2026 20:13:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2476A30131EA
	for <lists+linux-hyperv@lfdr.de>; Thu, 14 May 2026 18:13:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0F9939021F;
	Thu, 14 May 2026 18:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="ODchADkc"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazolkn19010020.outbound.protection.outlook.com [52.103.20.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE981389454;
	Thu, 14 May 2026 18:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.20.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778782412; cv=fail; b=SzUeo8yNAcfkN0AXKqdpLaJDr82sJ+b5Lrtzag8JgzUTl2UBT2qxqzOZWq/80MnmG+CYv0fW2IfhlNWr0XCBM84js/QTndzEcpn36lJVOTK55y/XGgGYjBGWE3ss0KG6P3sk25AHy1b6CzMIxOt5C8JsejD6/ekquHQFEXSjV7U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778782412; c=relaxed/simple;
	bh=cwlDe2J1riGR3Q8wo4Ags6UHDhVIM1vaycdP12wfj6Y=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WimefLSykFviVy+AUijU/WGcWm16v095wDgfG3D6I6E4qc1I9aO+IQSss6X1tHNIoIpHsxcD2BDVi9RnrmbPyk4Ej5OH+1ZTzbKMIMXdikRCeGxHAbQAtiWLQORyEnG2GjfGvWDtI7Ncl9cGRBKXUwPJUZpX/Hn0dzUHEIvet0o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=ODchADkc; arc=fail smtp.client-ip=52.103.20.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HE1oPS94q5KPSmWq6cABq4XOakaoaP8jfoYg91QIrr3lhMSt5cpGVTDbVS9vDuQX4739XvSdp3OTHYFwRooNoknadBoHW3gO5w5+SlQwONgRkWn8+qAKYk4lsrZ0BJ887t8F69SecplgMejci3aTQdi32Ywzmg2N2QG3A9xWCNERrJq9WKrCtKBAibjEq2xI9DDeakIaGaeVbV6sVR9YlWMQHPU985MuN0IUkwT4aoShxj+LlQsrFbgzTXsWDgCIHmHNWjODtgrvBfBviEgaWrh4WoTX8+BdRqdAaAO1gBx7Y+HCZ+a0NQpARiUU2bOvLqA0O3QwJwNC540I/NIR2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bjl36NEjtGa8awHFgap+uxxgyRm9rL815wVlODnD234=;
 b=M3Pb0j+2Ii56X+SBsuWg2or2GfLORPW0mOocXbJrU8YLQZbkfyU5+7jfPtrIYCMt1hlPGyuFLBo0yNulu+0HGTkfSvOdicOSMP3LxXeO/c4wD+ovHmzv/YCyLWx/fFS+5LkN76hTD6Twev4uQU/cT6uljiIrkUtjReAFe3o4TORb6CJFvz7oRC/aUGh62crt5wHpsKJxJNERDDdO7BKvGeOJDyjySe+MVdkwfTXKHaSYb7DOO6zXoF4A/clDhlKFcOJQNzrA8N0o9FOiAlRq8igtoRlnxgkWWrV3CbsHtYJTacgHGvZ/jmQkI8H7QZq3yTZtCGhsO3GDDno7HnW66Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bjl36NEjtGa8awHFgap+uxxgyRm9rL815wVlODnD234=;
 b=ODchADkckZSkQBjmma9FE29RhCMQuX2pTsBqYW96N1kqta2w0v1sAbe0GUIkUXTFLgMOakOXuT7qrZ0942y5JU8YKEVaDDQMerVx1NwYi0xySz2IvRa3FuxI/y0ozGXbV6kYG2LBjfb1cwi4y09PXJlIQbahBUdEhQhXzdkNfEJpBIarvuH+QPYfCR/m5a7aqmMqGThhS/R+9S1cGGmAxh+ALZYDvqKgImPQUx81PTT5AMYU12lnjwK6IYYQ6ytiq4ZaRnwtEzKgUXFl7pKyh5lRSDUEP9EDdQdty0h6gvSYAWU+RSGY+S/u/2Ao1V/YZW5oRqgVt8mGKAC3uyGAag==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by SN7PR02MB9284.namprd02.prod.outlook.com (2603:10b6:806:349::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.20; Thu, 14 May
 2026 18:13:25 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6%6]) with mapi id 15.20.9913.009; Thu, 14 May 2026
 18:13:25 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Yu Zhang <zhangyu1@linux.microsoft.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-arch@vger.kernel.org"
	<linux-arch@vger.kernel.org>
CC: "wei.liu@kernel.org" <wei.liu@kernel.org>, "kys@microsoft.com"
	<kys@microsoft.com>, "haiyangz@microsoft.com" <haiyangz@microsoft.com>,
	"decui@microsoft.com" <decui@microsoft.com>, "longli@microsoft.com"
	<longli@microsoft.com>, "joro@8bytes.org" <joro@8bytes.org>,
	"will@kernel.org" <will@kernel.org>, "robin.murphy@arm.com"
	<robin.murphy@arm.com>, "bhelgaas@google.com" <bhelgaas@google.com>,
	"kwilczynski@kernel.org" <kwilczynski@kernel.org>, "lpieralisi@kernel.org"
	<lpieralisi@kernel.org>, "mani@kernel.org" <mani@kernel.org>,
	"robh@kernel.org" <robh@kernel.org>, "arnd@arndb.de" <arnd@arndb.de>,
	"jgg@ziepe.ca" <jgg@ziepe.ca>, Michael Kelley <mhklinux@outlook.com>,
	"jacob.pan@linux.microsoft.com" <jacob.pan@linux.microsoft.com>,
	"tgopinath@linux.microsoft.com" <tgopinath@linux.microsoft.com>,
	"easwar.hariharan@linux.microsoft.com" <easwar.hariharan@linux.microsoft.com>
Subject: RE: [PATCH v1 3/4] iommu/hyperv: Add para-virtualized IOMMU support
 for Hyper-V guest
Thread-Topic: [PATCH v1 3/4] iommu/hyperv: Add para-virtualized IOMMU support
 for Hyper-V guest
Thread-Index: AQHc4WKng45scVRbCkamiCGsElTD+rYN1+PQ
Date: Thu, 14 May 2026 18:13:24 +0000
Message-ID:
 <SN6PR02MB4157FB81CC9B6347DCCC8C56D4072@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20260511162408.1180069-1-zhangyu1@linux.microsoft.com>
 <20260511162408.1180069-4-zhangyu1@linux.microsoft.com>
In-Reply-To: <20260511162408.1180069-4-zhangyu1@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|SN7PR02MB9284:EE_
x-ms-office365-filtering-correlation-id: 8e4a2e77-b6c4-4f96-87d1-08deb1e47d80
x-microsoft-antispam:
 BCL:0;ARA:14566002|41001999006|8062599012|31061999003|19110799012|8060799015|15080799012|51005399006|19101099003|13091999003|12121999013|55001999006|37011999003|440099028|12091999003|102099032|56899033|3412199025|40105399003|1710799026;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?HHouupBEybe7qHuj5Dv9xXdNnDRKf4a5neFbelImsIFurJkrPqDLEvp6H2JB?=
 =?us-ascii?Q?/2sFTnKX3MZOdQbRo1oog4gplBs+ToZ0+xK+VGO4/rqfJewnTPi2lyRZjjbv?=
 =?us-ascii?Q?RFP7I2NE3tD/uZd8ghDxfbNDH+HxsNIx+ys6BN9Os4hpAldQEmmAfk7Ufnmj?=
 =?us-ascii?Q?BOx4E9hoJ/72WA03YmM6EWInK6mDvt37FQJsxiRAn64yi/437N/l+IUP9FNA?=
 =?us-ascii?Q?IlisdKaVETR1/wOii5DR23jtMS06TpjkxpHA+zcIJNerAavVTSsyo/XUibUR?=
 =?us-ascii?Q?ivpJq3hyrVQ3HP0Q6KiW3kzS8pr9ojckt1ih7c8rhuydI/mmAkJKnVMvvZ9V?=
 =?us-ascii?Q?7NwqJyRV7MJSkzvAqLJ7qOV5uNYNjNReQGP2dLcKwmMp756L58uZSEcWMv8d?=
 =?us-ascii?Q?8D4n2lXLhMwqe/ufxiGUfhR72Is+2V3Oj+ESnFfQqSXxJxCIhWgZ5xvOXkS8?=
 =?us-ascii?Q?ceAxSlxswTtoivi3PzXVhnxaJBKIzEcKL8WVMa86qauWaXx/QEF02pQBgigW?=
 =?us-ascii?Q?oWeBMbsP9vbqDYQ1NXprIfaQYddUgflAnH+MmOF3YFxJ4nXpjabl0b7Ps1JS?=
 =?us-ascii?Q?960PZ5FWmQlmQoE/qVkIH8pjUV2w1OMkJRKDrZ/RYv0peVzMfNmObkb75h7b?=
 =?us-ascii?Q?1p2TtSGVW39dvnsr+RkKU2nOdfSkl0GVqHtaBwEESAQtG2flWmD5nNv7b7vv?=
 =?us-ascii?Q?2ihvOQxvud6a0JaQx+fpe7/P2KXoJpVoGABTAlfxBSJ/1s9Gw8WTuXREjVLo?=
 =?us-ascii?Q?XChbvEciinljVvszn1g1D787AdHPMRj7BoliYNXFX3XBNVtbWyV2DQH+YcJu?=
 =?us-ascii?Q?LkE1s4txrWd7z23PSu/UQA7I4807YRf38SNNUr4QbV2ozrkbFqR2f0WnLb13?=
 =?us-ascii?Q?ERSYMRKSe6JWRfsDJNDeWL+EUpnRnGDzasxOZJkuk0kzHSp5tvhDdSai5IvQ?=
 =?us-ascii?Q?1WMCTAwcR2YEfvBpj6MbW5at1AIrvhVEhFxzgCqHJ4O44wjazrqwm04RZtyQ?=
 =?us-ascii?Q?ooGzEOt4LezYpcgC4FpQLqQFcLSzGHCYTYfbbH9iLbJI4APC7KtK+TrGvRVd?=
 =?us-ascii?Q?a5raiZfsjOzd+uuNRYai1K2RZUrqWZNuMcxytiPWxrVVac4gpZZay2mrzpRe?=
 =?us-ascii?Q?LAVtTwmUX3Tbh5pRrW+yuxb0C2Y2gW8RAQ=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?vVovZfk+4rNe2HIvDWZvbfQdQyF1QnOiwBhnzefcrpoheKDi7jA+KJAwHz4h?=
 =?us-ascii?Q?p0vvhlTJa1s3+Eir2YKkG1MBEimDrh+8pIyn7ME4nXAktmFsbTIWJhIM69mQ?=
 =?us-ascii?Q?+CUuvyTR+98O96Iq5t9KC1idkTPLA84n6vmZvXIjbJQ0m2CyR+G1AGjOsNh3?=
 =?us-ascii?Q?YFggIy69nFueKr6EoyfxpELKVHn7ID3OrpXnsqIjauYVt6Pg2e+B862QK/gy?=
 =?us-ascii?Q?2rv588IqsEwt3BdO14vKDnGIj2+E/dbkBFfilkvrPQ37ev+m1jBRN9OsIIFN?=
 =?us-ascii?Q?+wQFakiNn1IiHobuF6d7ZaRK82MrGdPowxfWDSwdSitWqP9fZ+h1EFuPC8jg?=
 =?us-ascii?Q?ot9hEVk+UqVqzhXYh8qNFXi7PJIVuVUnAzSL89v2UEsYGNE2W8Qc/suZquWG?=
 =?us-ascii?Q?ntfpn/NzZlHcvqgqTidL+KtQ+wURzmLXB9VloLnr8zak/E+uxRGN+eUeImBo?=
 =?us-ascii?Q?Tg2Xap8kpwcNIbIt5PUG51t5tX9pneX0SLq+879y8LwOHN2yy8fFLSRM/Clk?=
 =?us-ascii?Q?QVANi3IqJnHRvWwJwdNjwppdjEX3qwZ28SREkyhLkwyoS5fn1qqiiVDkUYar?=
 =?us-ascii?Q?Vve1cB/pox3B/COQS6zS/gmzL9qdV5V3X5N7x1oe6OlE+ZAFmK2LxajscT9o?=
 =?us-ascii?Q?+dVE/qYoMXmG68cbNc31dg+l4pBhutY2yrygFl8V05t6gOXhfg6FLbYkYT6u?=
 =?us-ascii?Q?nlHwq1GzV2QaYPHYzfpdqR5lT+TDQbtUfCKMHXMeNE8D80nqJjp+SxiRpoft?=
 =?us-ascii?Q?SiyHQG1QXqMn/iw2s1Sru2bCm832AlkCizbEQF52k4BmPw2iI38bbpZ9wQa8?=
 =?us-ascii?Q?2RLZxTidYZH1vY0JmBCIOWAbpBQpAnFdosQhx0LgfH3ghoAyYQkYmrSnWnc1?=
 =?us-ascii?Q?j63df99APBqSmwETTn6pOtuu6GwPtY2OCE8fyltAWTzjtK4nYxF00kYV6DDV?=
 =?us-ascii?Q?34bjijRcWF4GhVryY77+6WFJoWQ8aaV8oXlZ0jGPxILc/BHv0URd0sqNY0EL?=
 =?us-ascii?Q?cgX7+uq54iVW++abFy86DjasnSKm0SgH9kZGEv7Ccjw/lrRngh5wi/7cPDo8?=
 =?us-ascii?Q?ZRXvnRB4nAXUA/B4ByTZzoHlA7JgHRuafHzND0zi1COU74VwJd2RxKizamQ0?=
 =?us-ascii?Q?ibZPU+a+fuep2qo5pRxK3GZ/3i/j6lWuhkQhJcq4Wl18tt+mcwEutMcTeKxa?=
 =?us-ascii?Q?jolarUSJMDvWD5QeogLdd4IMky6DzXYviwdinI8mPPZsWEkNMTauJhD2r7mT?=
 =?us-ascii?Q?FakZuZ7KLf4nA0zXMK/0p2qdi9ueTgWusCnsGMluEZfOvr4fRxsH2YHRvmPt?=
 =?us-ascii?Q?PuvUpKJzYXN8phKr/a/6+MxIAwipUPLKJbkobofs9T0kopcyTsovVHAvBfWj?=
 =?us-ascii?Q?pPIdqyQ=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e4a2e77-b6c4-4f96-87d1-08deb1e47d80
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 May 2026 18:13:24.9026
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR02MB9284
X-Rspamd-Queue-Id: 2D8B7545BEC
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[outlook.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[outlook.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10888-lists,linux-hyperv=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,microsoft.com,8bytes.org,arm.com,google.com,arndb.de,ziepe.ca,outlook.com,linux.microsoft.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_FROM(0.00)[outlook.com];
	RCPT_COUNT_TWELVE(0.00)[25];
	DKIM_TRACE(0.00)[outlook.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mhklinux@outlook.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-hyperv];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,SN6PR02MB4157.namprd02.prod.outlook.com:mid,outlook.com:dkim]
X-Rspamd-Action: no action

From: Yu Zhang <zhangyu1@linux.microsoft.com> Sent: Monday, May 11, 2026 9:=
24 AM
>=20
> Add a para-virtualized IOMMU driver for Linux guests running on Hyper-V.
> This driver implements stage-1 IO translation within the guest OS.
> It integrates with the Linux IOMMU core, utilizing Hyper-V hypercalls
> for:
>  - Capability discovery
>  - Domain allocation, configuration, and deallocation
>  - Device attachment and detachment
>  - IOTLB invalidation
>=20
> The driver constructs x86-compatible stage-1 IO page tables in the
> guest memory using consolidated IO page table helpers. This allows
> the guest to manage stage-1 translations independently of vendor-
> specific drivers (like Intel VT-d or AMD IOMMU).
>=20
> Hyper-V consumes this stage-1 IO page table when a device domain is
> created and configured, and nests it with the host's stage-2 IO page
> tables, therefore eliminating the VM exits for guest IOMMU mapping
> operations. For unmapping operations, VM exits to perform the IOTLB
> flush are still unavoidable.
>=20
> Hyper-V identifies each PCI pass-thru device by a logical device ID
> in its hypercall interface. The vPCI driver (pci-hyperv) registers the
> per-bus portion of this ID with the pvIOMMU driver during bus probe.
> The pvIOMMU driver stores this mapping and combines it with the function
> number of the endpoint PCI device to form the complete ID for hypercalls.

As you are probably aware, Mukesh's patch series to support PCI
pass-thru devices also needs to get the logical device ID. Maybe the
registration mechanism needs to move somewhere that can be shared
with his code.

>=20
> Co-developed-by: Wei Liu <wei.liu@kernel.org>
> Signed-off-by: Wei Liu <wei.liu@kernel.org>
> Co-developed-by: Easwar Hariharan <easwar.hariharan@linux.microsoft.com>
> Signed-off-by: Easwar Hariharan <easwar.hariharan@linux.microsoft.com>
> Signed-off-by: Yu Zhang <zhangyu1@linux.microsoft.com>
> ---
>  arch/x86/hyperv/hv_init.c           |   4 +
>  arch/x86/include/asm/mshyperv.h     |   4 +
>  drivers/iommu/hyperv/Kconfig        |  17 +
>  drivers/iommu/hyperv/Makefile       |   1 +
>  drivers/iommu/hyperv/iommu.c        | 705 ++++++++++++++++++++++++++++
>  drivers/iommu/hyperv/iommu.h        |  54 +++
>  drivers/pci/controller/pci-hyperv.c |  19 +-
>  include/asm-generic/mshyperv.h      |  12 +
>  8 files changed, 815 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/iommu/hyperv/iommu.c
>  create mode 100644 drivers/iommu/hyperv/iommu.h
>=20
> diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
> index 323adc93f2dc..2c8ff8e06249 100644
> --- a/arch/x86/hyperv/hv_init.c
> +++ b/arch/x86/hyperv/hv_init.c
> @@ -578,6 +578,10 @@ void __init hyperv_init(void)
>  	old_setup_percpu_clockev =3D x86_init.timers.setup_percpu_clockev;
>  	x86_init.timers.setup_percpu_clockev =3D hv_stimer_setup_percpu_clockev=
;
>=20
> +#ifdef CONFIG_HYPERV_PVIOMMU
> +	x86_init.iommu.iommu_init =3D hv_iommu_init;
> +#endif
> +
>  	hv_apic_init();
>=20
>  	x86_init.pci.arch_init =3D hv_pci_init;
> diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyp=
erv.h
> index f64393e853ee..20d947c2c758 100644
> --- a/arch/x86/include/asm/mshyperv.h
> +++ b/arch/x86/include/asm/mshyperv.h
> @@ -313,6 +313,10 @@ static inline void mshv_vtl_return_hypercall(void) {=
}
>  static inline void __mshv_vtl_return_call(struct mshv_vtl_cpu_context *v=
tl0) {}
>  #endif
>=20
> +#ifdef CONFIG_HYPERV_PVIOMMU
> +int __init hv_iommu_init(void);
> +#endif
> +
>  #include <asm-generic/mshyperv.h>
>=20
>  #endif
> diff --git a/drivers/iommu/hyperv/Kconfig b/drivers/iommu/hyperv/Kconfig
> index 30f40d867036..9e658d5c9a77 100644
> --- a/drivers/iommu/hyperv/Kconfig
> +++ b/drivers/iommu/hyperv/Kconfig
> @@ -8,3 +8,20 @@ config HYPERV_IOMMU
>  	help
>  	  Stub IOMMU driver to handle IRQs to support Hyper-V Linux
>  	  guest and root partitions.
> +
> +if HYPERV_IOMMU
> +config HYPERV_PVIOMMU
> +	bool "Microsoft Hypervisor para-virtualized IOMMU support"
> +	depends on X86 && HYPERV

What is the intent w.r.t. 32-bit builds? Using X86 instead of X86_64
allows it. I did a 32-bit build and didn't get any build failures, which is
good. But I can't run it to see if the pvIOMMU actually works in a
32-bit build. I don't know how building X86_64 generic PT entries
would fare.

> +	select IOMMU_API
> +	select GENERIC_PT
> +	select IOMMU_PT
> +	select IOMMU_PT_X86_64
> +	select IOMMU_IOVA
> +	default HYPERV
> +	help
> +	  Para-virtualized IOMMU driver for Linux guests running on
> +	  Microsoft Hyper-V. Provides DMA remapping and IOTLB
> +	  flush support to enable DMA isolation for devices
> +	  assigned to the guest.
> +endif
> diff --git a/drivers/iommu/hyperv/Makefile b/drivers/iommu/hyperv/Makefil=
e
> index 9f557bad94ff..8669741c0a51 100644
> --- a/drivers/iommu/hyperv/Makefile
> +++ b/drivers/iommu/hyperv/Makefile
> @@ -1,2 +1,3 @@
>  # SPDX-License-Identifier: GPL-2.0
>  obj-$(CONFIG_HYPERV_IOMMU) +=3D irq_remapping.o
> +obj-$(CONFIG_HYPERV_PVIOMMU) +=3D iommu.o
> diff --git a/drivers/iommu/hyperv/iommu.c b/drivers/iommu/hyperv/iommu.c
> new file mode 100644
> index 000000000000..e5fc625314b5
> --- /dev/null
> +++ b/drivers/iommu/hyperv/iommu.c
> @@ -0,0 +1,705 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +/*
> + * Hyper-V IOMMU driver.
> + *
> + * Copyright (C) 2019, 2024-2026 Microsoft, Inc.
> + */
> +
> +#define pr_fmt(fmt) "Hyper-V pvIOMMU: " fmt
> +#define dev_fmt(fmt) pr_fmt(fmt)
> +
> +#include <linux/iommu.h>
> +#include <linux/pci.h>
> +#include <linux/dma-map-ops.h>
> +#include <linux/generic_pt/iommu.h>
> +#include <linux/pci-ats.h>
> +
> +#include <asm/iommu.h>
> +#include <asm/hypervisor.h>
> +#include <asm/mshyperv.h>
> +
> +#include "iommu.h"
> +#include "../iommu-pages.h"
> +
> +struct hv_iommu_dev *hv_iommu_device;
> +
> +/*
> + * Identity and blocking domains are static singletons: identity is a 1:=
1
> + * passthrough with no page table, blocking rejects all DMA. Neither hol=
ds
> + * per-IOMMU state, so one instance suffices even with multiple vIOMMUs.
> + */
> +static struct hv_iommu_domain hv_identity_domain;
> +static struct hv_iommu_domain hv_blocking_domain;
> +static const struct iommu_domain_ops hv_iommu_identity_domain_ops;
> +static const struct iommu_domain_ops hv_iommu_blocking_domain_ops;
> +static struct iommu_ops hv_iommu_ops;
> +static LIST_HEAD(hv_iommu_pci_bus_list);
> +static DEFINE_SPINLOCK(hv_iommu_pci_bus_lock);
> +
> +#define hv_iommu_present(iommu_cap) (iommu_cap & HV_IOMMU_CAP_PRESENT)
> +#define hv_iommu_s1_domain_supported(iommu_cap) (iommu_cap & HV_IOMMU_CA=
P_S1)
> +#define hv_iommu_5lvl_supported(iommu_cap) (iommu_cap & HV_IOMMU_CAP_S1_=
5LVL)
> +#define hv_iommu_ats_supported(iommu_cap) (iommu_cap & HV_IOMMU_CAP_ATS)
> +
> +int hv_iommu_register_pci_bus(int pci_domain_nr, u32 logical_dev_id_pref=
ix)
> +{
> +	struct hv_pci_busdata *bus, *new;
> +	int ret =3D 0;
> +
> +	if (no_iommu || !iommu_detected)
> +		return 0;
> +
> +	new =3D kzalloc_obj(*new, GFP_KERNEL);
> +	if (!new)
> +		return -ENOMEM;
> +
> +	spin_lock(&hv_iommu_pci_bus_lock);
> +	list_for_each_entry(bus, &hv_iommu_pci_bus_list, list) {
> +		if (bus->pci_domain_nr !=3D pci_domain_nr)
> +			continue;
> +
> +		if (bus->logical_dev_id_prefix !=3D logical_dev_id_prefix) {
> +			pr_err("stale registration for PCI domain %d (old prefix 0x%08x, new =
0x%08x)\n",
> +			       pci_domain_nr, bus->logical_dev_id_prefix,
> +			       logical_dev_id_prefix);
> +			ret =3D -EEXIST;
> +		}
> +
> +		goto out_free;
> +	}
> +
> +	new->pci_domain_nr =3D pci_domain_nr;
> +	new->logical_dev_id_prefix =3D logical_dev_id_prefix;
> +	list_add(&new->list, &hv_iommu_pci_bus_list);
> +	spin_unlock(&hv_iommu_pci_bus_lock);
> +	return 0;
> +
> +out_free:
> +	spin_unlock(&hv_iommu_pci_bus_lock);
> +	kfree(new);
> +	return ret;
> +}
> +EXPORT_SYMBOL_FOR_MODULES(hv_iommu_register_pci_bus, "pci-hyperv");
> +
> +void hv_iommu_unregister_pci_bus(int pci_domain_nr)
> +{
> +	struct hv_pci_busdata *bus, *tmp;
> +
> +	spin_lock(&hv_iommu_pci_bus_lock);
> +	list_for_each_entry_safe(bus, tmp, &hv_iommu_pci_bus_list, list) {
> +		if (bus->pci_domain_nr =3D=3D pci_domain_nr) {
> +			list_del(&bus->list);
> +			kfree(bus);
> +			break;
> +		}
> +	}
> +	spin_unlock(&hv_iommu_pci_bus_lock);
> +}
> +EXPORT_SYMBOL_FOR_MODULES(hv_iommu_unregister_pci_bus, "pci-hyperv");
> +
> +/*
> + * Look up the logical device ID for a vPCI device. Returns 0 on success
> + * with *logical_id filled in; -ENODEV if no entry registered for this
> + * device's vPCI bus.
> + */
> +static int hv_iommu_lookup_logical_dev_id(struct pci_dev *pdev, u64 *log=
ical_id)
> +{
> +	struct hv_pci_busdata *bus;
> +	int domain =3D pci_domain_nr(pdev->bus);
> +	int ret =3D -ENODEV;
> +
> +	spin_lock(&hv_iommu_pci_bus_lock);
> +	list_for_each_entry(bus, &hv_iommu_pci_bus_list, list) {
> +		if (bus->pci_domain_nr =3D=3D domain) {
> +			*logical_id =3D (u64)bus->logical_dev_id_prefix |
> +				      PCI_FUNC(pdev->devfn);
> +			ret =3D 0;
> +			break;
> +		}
> +	}
> +	spin_unlock(&hv_iommu_pci_bus_lock);
> +	return ret;
> +}
> +
> +static int hv_create_device_domain(struct hv_iommu_domain *hv_domain, u3=
2 domain_stage)
> +{
> +	int ret;
> +	u64 status;
> +	unsigned long flags;
> +	struct hv_input_create_device_domain *input;
> +
> +	ret =3D ida_alloc_range(&hv_iommu_device->domain_ids,
> +			hv_iommu_device->first_domain, hv_iommu_device->last_domain,
> +			GFP_KERNEL);
> +	if (ret < 0)
> +		return ret;
> +
> +	hv_domain->device_domain.partition_id =3D HV_PARTITION_ID_SELF;
> +	hv_domain->device_domain.domain_id.type =3D domain_stage;
> +	hv_domain->device_domain.domain_id.id =3D ret;
> +	hv_domain->hv_iommu =3D hv_iommu_device;
> +
> +	local_irq_save(flags);
> +
> +	input =3D *this_cpu_ptr(hyperv_pcpu_input_arg);
> +	memset(input, 0, sizeof(*input));
> +	input->device_domain =3D hv_domain->device_domain;
> +	input->create_device_domain_flags.forward_progress_required =3D 1;
> +	input->create_device_domain_flags.inherit_owning_vtl =3D 0;
> +	status =3D hv_do_hypercall(HVCALL_CREATE_DEVICE_DOMAIN, input, NULL);
> +
> +	local_irq_restore(flags);
> +
> +	if (!hv_result_success(status)) {
> +		pr_err("HVCALL_CREATE_DEVICE_DOMAIN failed, status %lld\n", status);
> +		ida_free(&hv_iommu_device->domain_ids, hv_domain->device_domain.domain=
_id.id);
> +	}
> +
> +	return hv_result_to_errno(status);
> +}
> +
> +static void hv_delete_device_domain(struct hv_iommu_domain *hv_domain)
> +{
> +	u64 status;
> +	unsigned long flags;
> +	struct hv_input_delete_device_domain *input;
> +
> +	local_irq_save(flags);
> +
> +	input =3D *this_cpu_ptr(hyperv_pcpu_input_arg);
> +	memset(input, 0, sizeof(*input));
> +	input->device_domain =3D hv_domain->device_domain;
> +	status =3D hv_do_hypercall(HVCALL_DELETE_DEVICE_DOMAIN, input, NULL);
> +
> +	local_irq_restore(flags);
> +
> +	if (!hv_result_success(status))
> +		pr_err("HVCALL_DELETE_DEVICE_DOMAIN failed, status %lld\n", status);
> +
> +	ida_free(&hv_domain->hv_iommu->domain_ids, hv_domain->device_domain.dom=
ain_id.id);
> +}
> +
> +static bool hv_iommu_capable(struct device *dev, enum iommu_cap cap)
> +{
> +	switch (cap) {
> +	case IOMMU_CAP_CACHE_COHERENCY:
> +		return true;
> +	case IOMMU_CAP_DEFERRED_FLUSH:
> +		return true;
> +	default:
> +		return false;
> +	}
> +}
> +
> +static void hv_flush_device_domain(struct hv_iommu_domain *hv_domain)
> +{
> +	u64 status;
> +	unsigned long flags;
> +	struct hv_input_flush_device_domain *input;
> +
> +	local_irq_save(flags);
> +
> +	input =3D *this_cpu_ptr(hyperv_pcpu_input_arg);
> +	memset(input, 0, sizeof(*input));
> +	input->device_domain =3D hv_domain->device_domain;

The previous version of this patch had code to set several other fields in
the input. I wanted to confirm that not setting them in this version is
intentional. Were they not needed?

> +	status =3D hv_do_hypercall(HVCALL_FLUSH_DEVICE_DOMAIN, input, NULL);
> +
> +	local_irq_restore(flags);
> +
> +	if (!hv_result_success(status))
> +		pr_err("HVCALL_FLUSH_DEVICE_DOMAIN failed, status %lld\n", status);
> +}
> +
> +static void hv_iommu_detach_dev(struct iommu_domain *domain, struct devi=
ce *dev)
> +{
> +	u64 status;
> +	unsigned long flags;
> +	struct hv_input_detach_device_domain *input;
> +	struct pci_dev *pdev;
> +	struct hv_iommu_domain *hv_domain =3D to_hv_iommu_domain(domain);
> +	struct hv_iommu_endpoint *vdev =3D dev_iommu_priv_get(dev);
> +
> +	/* See the attach function, only PCI devices for now */
> +	if (!dev_is_pci(dev) || vdev->hv_domain !=3D hv_domain)
> +		return;

Are these sanity checks necessary? The only caller is hv_iommu_attach_dev()
and it has already done the checks.

> +
> +	pdev =3D to_pci_dev(dev);
> +
> +	dev_dbg(dev, "detaching from domain %d\n", hv_domain->device_domain.dom=
ain_id.id);
> +
> +	local_irq_save(flags);
> +
> +	input =3D *this_cpu_ptr(hyperv_pcpu_input_arg);
> +	memset(input, 0, sizeof(*input));
> +	input->partition_id =3D HV_PARTITION_ID_SELF;
> +	if (hv_iommu_lookup_logical_dev_id(pdev, &input->device_id.as_uint64)) =
{

As Sashiko and Jacob Pan pointed out, doing the lookup while interrupts are=
 disabled
is problematic. My suggestion would be to just do the lookup into a local v=
ariable
before disabling interrupts (rather than using a raw spin lock as Jacob sug=
gested).

Same situation occurs in hv_iommu_attach_dev() and
hv_iommu_get_logical_device_property().

> +		local_irq_restore(flags);
> +		dev_warn(&pdev->dev, "no IOMMU registration for vPCI bus on detach\n")=
;
> +		return;
> +	}
> +	status =3D hv_do_hypercall(HVCALL_DETACH_DEVICE_DOMAIN, input, NULL);
> +
> +	local_irq_restore(flags);
> +
> +	if (!hv_result_success(status))
> +		pr_err("HVCALL_DETACH_DEVICE_DOMAIN failed, status %lld\n", status);
> +
> +	hv_flush_device_domain(hv_domain);
> +
> +	vdev->hv_domain =3D NULL;
> +}
> +
> +static int hv_iommu_attach_dev(struct iommu_domain *domain, struct devic=
e *dev,
> +			       struct iommu_domain *old)
> +{
> +	u64 status;
> +	unsigned long flags;
> +	struct pci_dev *pdev;
> +	struct hv_input_attach_device_domain *input;
> +	struct hv_iommu_endpoint *vdev =3D dev_iommu_priv_get(dev);
> +	struct hv_iommu_domain *hv_domain =3D to_hv_iommu_domain(domain);
> +	int ret;
> +
> +	/* Only allow PCI devices for now */
> +	if (!dev_is_pci(dev))
> +		return -EINVAL;
> +
> +	if (vdev->hv_domain =3D=3D hv_domain)
> +		return 0;
> +
> +	if (vdev->hv_domain)
> +		hv_iommu_detach_dev(&vdev->hv_domain->domain, dev);
> +
> +	pdev =3D to_pci_dev(dev);
> +	dev_dbg(dev, "attaching to domain %d\n",
> +		hv_domain->device_domain.domain_id.id);
> +
> +	local_irq_save(flags);
> +
> +	input =3D *this_cpu_ptr(hyperv_pcpu_input_arg);
> +	memset(input, 0, sizeof(*input));
> +	input->device_domain =3D hv_domain->device_domain;
> +	ret =3D hv_iommu_lookup_logical_dev_id(pdev, &input->device_id.as_uint6=
4);
> +	if (ret) {
> +		local_irq_restore(flags);
> +		dev_err(&pdev->dev, "no IOMMU registration for vPCI bus\n");
> +		return ret;
> +	}
> +	status =3D hv_do_hypercall(HVCALL_ATTACH_DEVICE_DOMAIN, input, NULL);
> +
> +	local_irq_restore(flags);
> +
> +	if (!hv_result_success(status))
> +		pr_err("HVCALL_ATTACH_DEVICE_DOMAIN failed, status %lld\n", status);
> +	else
> +		vdev->hv_domain =3D hv_domain;
> +
> +	return hv_result_to_errno(status);
> +}
> +
> +static int hv_iommu_get_logical_device_property(struct device *dev,
> +					u32 code,
> +					struct hv_output_get_logical_device_property *property)
> +{
> +	u64 status, lid;
> +	unsigned long flags;
> +	int ret;
> +	struct hv_input_get_logical_device_property *input;
> +	struct hv_output_get_logical_device_property *output;
> +
> +	local_irq_save(flags);
> +
> +	input =3D *this_cpu_ptr(hyperv_pcpu_input_arg);
> +	output =3D *this_cpu_ptr(hyperv_pcpu_input_arg) + sizeof(*input);

Nit: The other way to set output is:

	output =3D input + 1;

I think this produces slightly better code because of not needing to
reference the per-cpu variable hyperv_pcpu_input_arg a 2nd time.


> +	memset(input, 0, sizeof(*input));
> +	input->partition_id =3D HV_PARTITION_ID_SELF;
> +	ret =3D hv_iommu_lookup_logical_dev_id(to_pci_dev(dev), &lid);
> +	if (ret) {
> +		local_irq_restore(flags);
> +		return ret;
> +	}
> +	input->logical_device_id =3D lid;
> +	input->code =3D code;
> +	status =3D hv_do_hypercall(HVCALL_GET_LOGICAL_DEVICE_PROPERTY, input, o=
utput);
> +	*property =3D *output;
> +
> +	local_irq_restore(flags);
> +
> +	if (!hv_result_success(status))
> +		pr_err("HVCALL_GET_LOGICAL_DEVICE_PROPERTY failed, status %lld\n", sta=
tus);
> +
> +	return hv_result_to_errno(status);
> +}
> +
> +static struct iommu_device *hv_iommu_probe_device(struct device *dev)
> +{
> +	struct pci_dev *pdev;
> +	struct hv_iommu_endpoint *vdev;
> +	struct hv_output_get_logical_device_property device_iommu_property =3D =
{0};
> +
> +	if (!dev_is_pci(dev))
> +		return ERR_PTR(-ENODEV);
> +
> +	pdev =3D to_pci_dev(dev);
> +
> +	if (hv_iommu_get_logical_device_property(dev,
> +						 HV_LOGICAL_DEVICE_PROPERTY_PVIOMMU,
> +						 &device_iommu_property) ||
> +	    !(device_iommu_property.device_iommu & HV_DEVICE_IOMMU_ENABLED))
> +		return ERR_PTR(-ENODEV);
> +
> +	vdev =3D kzalloc_obj(*vdev, GFP_KERNEL);
> +	if (!vdev)
> +		return ERR_PTR(-ENOMEM);
> +
> +	vdev->dev =3D dev;
> +	vdev->hv_iommu =3D hv_iommu_device;
> +	dev_iommu_priv_set(dev, vdev);
> +
> +	if (hv_iommu_ats_supported(hv_iommu_device->cap) &&
> +	    pci_ats_supported(pdev))
> +		pci_enable_ats(pdev, __ffs(hv_iommu_device->pgsize_bitmap));
> +
> +	return &vdev->hv_iommu->iommu;
> +}
> +
> +static void hv_iommu_release_device(struct device *dev)
> +{
> +	struct hv_iommu_endpoint *vdev =3D dev_iommu_priv_get(dev);
> +	struct pci_dev *pdev =3D to_pci_dev(dev);
> +
> +	if (pdev->ats_enabled)
> +		pci_disable_ats(pdev);
> +
> +	dev_iommu_priv_set(dev, NULL);
> +	set_dma_ops(dev, NULL);

Previous versions of this function did hv_iommu_detach_dev(). With that cal=
l
removed from here, hv_iommu_detach_dev() is only called when attaching a
domain to a device that already has a domain attached. Is it the case that
Hyper-V doesn't require the detach as a cleanup step?

> +
> +	kfree(vdev);
> +}
> +
> +static struct iommu_group *hv_iommu_device_group(struct device *dev)
> +{
> +	if (dev_is_pci(dev))
> +		return pci_device_group(dev);
> +	else
> +		return generic_device_group(dev);
> +}
> +
> +static int hv_configure_device_domain(struct hv_iommu_domain *hv_domain,=
 u32 domain_type)
> +{
> +	u64 status;
> +	unsigned long flags;
> +	struct pt_iommu_x86_64_hw_info pt_info;
> +	struct hv_input_configure_device_domain *input;
> +
> +	local_irq_save(flags);
> +
> +	input =3D *this_cpu_ptr(hyperv_pcpu_input_arg);
> +	memset(input, 0, sizeof(*input));
> +	input->device_domain =3D hv_domain->device_domain;
> +	input->settings.flags.blocked =3D (domain_type =3D=3D IOMMU_DOMAIN_BLOC=
KED);
> +	input->settings.flags.translation_enabled =3D (domain_type !=3D IOMMU_D=
OMAIN_IDENTITY);
> +
> +	if (domain_type & __IOMMU_DOMAIN_PAGING) {
> +		pt_iommu_x86_64_hw_info(&hv_domain->pt_iommu_x86_64, &pt_info);
> +		input->settings.page_table_root =3D pt_info.gcr3_pt;
> +		input->settings.flags.first_stage_paging_mode =3D
> +			pt_info.levels =3D=3D 5;
> +	}
> +	status =3D hv_do_hypercall(HVCALL_CONFIGURE_DEVICE_DOMAIN, input, NULL)=
;
> +
> +	local_irq_restore(flags);
> +
> +	if (!hv_result_success(status))
> +		pr_err("HVCALL_CONFIGURE_DEVICE_DOMAIN failed, status %lld\n", status)=
;
> +
> +	return hv_result_to_errno(status);
> +}
> +
> +static int __init hv_initialize_static_domains(void)
> +{
> +	int ret;
> +	struct hv_iommu_domain *hv_domain;
> +
> +	/* Default stage-1 identity domain */
> +	hv_domain =3D &hv_identity_domain;
> +
> +	ret =3D hv_create_device_domain(hv_domain, HV_DEVICE_DOMAIN_TYPE_S1);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D hv_configure_device_domain(hv_domain, IOMMU_DOMAIN_IDENTITY);
> +	if (ret)
> +		goto delete_identity_domain;
> +
> +	hv_domain->domain.type =3D IOMMU_DOMAIN_IDENTITY;
> +	hv_domain->domain.ops =3D &hv_iommu_identity_domain_ops;
> +	hv_domain->domain.owner =3D &hv_iommu_ops;
> +	hv_domain->domain.geometry =3D hv_iommu_device->geometry;
> +	hv_domain->domain.pgsize_bitmap =3D hv_iommu_device->pgsize_bitmap;
> +
> +	/* Default stage-1 blocked domain */
> +	hv_domain =3D &hv_blocking_domain;
> +
> +	ret =3D hv_create_device_domain(hv_domain, HV_DEVICE_DOMAIN_TYPE_S1);
> +	if (ret)
> +		goto delete_identity_domain;
> +
> +	ret =3D hv_configure_device_domain(hv_domain, IOMMU_DOMAIN_BLOCKED);
> +	if (ret)
> +		goto delete_blocked_domain;
> +
> +	hv_domain->domain.type =3D IOMMU_DOMAIN_BLOCKED;
> +	hv_domain->domain.ops =3D &hv_iommu_blocking_domain_ops;
> +	hv_domain->domain.owner =3D &hv_iommu_ops;
> +	hv_domain->domain.geometry =3D hv_iommu_device->geometry;
> +	hv_domain->domain.pgsize_bitmap =3D hv_iommu_device->pgsize_bitmap;
> +
> +	return 0;
> +
> +delete_blocked_domain:
> +	hv_delete_device_domain(&hv_blocking_domain);
> +delete_identity_domain:
> +	hv_delete_device_domain(&hv_identity_domain);
> +	return ret;
> +}
> +
> +#define INTERRUPT_RANGE_START	(0xfee00000)
> +#define INTERRUPT_RANGE_END	(0xfeefffff)
> +static void hv_iommu_get_resv_regions(struct device *dev,
> +		struct list_head *head)
> +{
> +	struct iommu_resv_region *region;
> +
> +	region =3D iommu_alloc_resv_region(INTERRUPT_RANGE_START,
> +				      INTERRUPT_RANGE_END - INTERRUPT_RANGE_START + 1,
> +				      0, IOMMU_RESV_MSI, GFP_KERNEL);
> +	if (!region)
> +		return;
> +
> +	list_add_tail(&region->list, head);
> +}
> +
> +static void hv_iommu_flush_iotlb_all(struct iommu_domain *domain)
> +{
> +	hv_flush_device_domain(to_hv_iommu_domain(domain));
> +}
> +
> +static void hv_iommu_iotlb_sync(struct iommu_domain *domain,
> +				struct iommu_iotlb_gather *iotlb_gather)
> +{
> +	hv_flush_device_domain(to_hv_iommu_domain(domain));
> +
> +	iommu_put_pages_list(&iotlb_gather->freelist);
> +}
> +
> +static void hv_iommu_paging_domain_free(struct iommu_domain *domain)
> +{
> +	struct hv_iommu_domain *hv_domain =3D to_hv_iommu_domain(domain);
> +
> +	/* Free all remaining mappings */
> +	pt_iommu_deinit(&hv_domain->pt_iommu);
> +
> +	hv_delete_device_domain(hv_domain);
> +
> +	kfree(hv_domain);
> +}
> +
> +static const struct iommu_domain_ops hv_iommu_identity_domain_ops =3D {
> +	.attach_dev	=3D hv_iommu_attach_dev,
> +};
> +
> +static const struct iommu_domain_ops hv_iommu_blocking_domain_ops =3D {
> +	.attach_dev	=3D hv_iommu_attach_dev,
> +};
> +
> +static const struct iommu_domain_ops hv_iommu_paging_domain_ops =3D {
> +	.attach_dev	=3D hv_iommu_attach_dev,
> +	IOMMU_PT_DOMAIN_OPS(x86_64),
> +	.flush_iotlb_all =3D hv_iommu_flush_iotlb_all,
> +	.iotlb_sync =3D hv_iommu_iotlb_sync,
> +	.free =3D hv_iommu_paging_domain_free,
> +};
> +
> +static struct iommu_domain *hv_iommu_domain_alloc_paging(struct device *=
dev)
> +{
> +	int ret;
> +	struct hv_iommu_domain *hv_domain;
> +	struct pt_iommu_x86_64_cfg cfg =3D {};
> +
> +	hv_domain =3D kzalloc_obj(*hv_domain, GFP_KERNEL);
> +	if (!hv_domain)
> +		return ERR_PTR(-ENOMEM);
> +
> +	ret =3D hv_create_device_domain(hv_domain, HV_DEVICE_DOMAIN_TYPE_S1);
> +	if (ret) {
> +		kfree(hv_domain);
> +		return ERR_PTR(ret);
> +	}
> +
> +	hv_domain->domain.geometry =3D hv_iommu_device->geometry;
> +	hv_domain->pt_iommu.nid =3D dev_to_node(dev);
> +
> +	cfg.common.hw_max_vasz_lg2 =3D hv_iommu_device->max_iova_width;
> +	cfg.common.hw_max_oasz_lg2 =3D 52;
> +	cfg.top_level =3D (hv_iommu_device->max_iova_width > 48) ? 4 : 3;
> +
> +	ret =3D pt_iommu_x86_64_init(&hv_domain->pt_iommu_x86_64, &cfg, GFP_KER=
NEL);
> +	if (ret) {
> +		hv_delete_device_domain(hv_domain);
> +		kfree(hv_domain);
> +		return ERR_PTR(ret);
> +	}
> +
> +	/* Constrain to page sizes the hypervisor supports */
> +	hv_domain->domain.pgsize_bitmap &=3D hv_iommu_device->pgsize_bitmap;
> +
> +	hv_domain->domain.ops =3D &hv_iommu_paging_domain_ops;
> +
> +	ret =3D hv_configure_device_domain(hv_domain, __IOMMU_DOMAIN_PAGING);
> +	if (ret) {
> +		pt_iommu_deinit(&hv_domain->pt_iommu);
> +		hv_delete_device_domain(hv_domain);
> +		kfree(hv_domain);
> +		return ERR_PTR(ret);
> +	}
> +
> +	return &hv_domain->domain;

I think this function would be better if the error paths did "goto"
a cascading set of error labels. That's the typical pattern, and it's what =
you
use in hv_iommu_init(), for example.

> +}
> +
> +static struct iommu_ops hv_iommu_ops =3D {
> +	.capable		  =3D hv_iommu_capable,
> +	.domain_alloc_paging	  =3D hv_iommu_domain_alloc_paging,
> +	.probe_device		  =3D hv_iommu_probe_device,
> +	.release_device		  =3D hv_iommu_release_device,
> +	.device_group		  =3D hv_iommu_device_group,
> +	.get_resv_regions	  =3D hv_iommu_get_resv_regions,
> +	.owner			  =3D THIS_MODULE,
> +	.identity_domain	  =3D &hv_identity_domain.domain,
> +	.blocked_domain		  =3D &hv_blocking_domain.domain,
> +	.release_domain		  =3D &hv_blocking_domain.domain,
> +};
> +
> +static int hv_iommu_detect(struct hv_output_get_iommu_capabilities *hv_i=
ommu_cap)
> +{
> +	u64 status;
> +	unsigned long flags;
> +	struct hv_input_get_iommu_capabilities *input;
> +	struct hv_output_get_iommu_capabilities *output;
> +
> +	local_irq_save(flags);
> +
> +	input =3D *this_cpu_ptr(hyperv_pcpu_input_arg);
> +	output =3D *this_cpu_ptr(hyperv_pcpu_input_arg) + sizeof(*input);

Potentially use "output =3D input + 1" here as well.

> +	memset(input, 0, sizeof(*input));
> +	input->partition_id =3D HV_PARTITION_ID_SELF;
> +	status =3D hv_do_hypercall(HVCALL_GET_IOMMU_CAPABILITIES, input, output=
);
> +	*hv_iommu_cap =3D *output;
> +
> +	local_irq_restore(flags);
> +
> +	if (!hv_result_success(status))
> +		pr_err("HVCALL_GET_IOMMU_CAPABILITIES failed, status %lld\n", status);
> +
> +	return hv_result_to_errno(status);
> +}
> +
> +static void __init hv_init_iommu_device(struct hv_iommu_dev *hv_iommu,
> +			struct hv_output_get_iommu_capabilities *hv_iommu_cap)
> +{
> +	ida_init(&hv_iommu->domain_ids);
> +
> +	hv_iommu->cap =3D hv_iommu_cap->iommu_cap;
> +	hv_iommu->max_iova_width =3D hv_iommu_cap->max_iova_width;
> +	if (!hv_iommu_5lvl_supported(hv_iommu->cap) &&
> +	    hv_iommu->max_iova_width > 48) {
> +		pr_info("5-level paging not supported, limiting iova width to 48.\n");
> +		hv_iommu->max_iova_width =3D 48;
> +	}
> +
> +	hv_iommu->geometry =3D (struct iommu_domain_geometry) {
> +		.aperture_start =3D 0,
> +		.aperture_end =3D (((u64)1) << hv_iommu->max_iova_width) - 1,
> +		.force_aperture =3D true,
> +	};
> +
> +	hv_iommu->first_domain =3D HV_DEVICE_DOMAIN_ID_DEFAULT + 1;
> +	hv_iommu->last_domain =3D HV_DEVICE_DOMAIN_ID_NULL - 1;
> +	/* Only x86 page sizes (4K/2M/1G) are supported */
> +	hv_iommu->pgsize_bitmap =3D hv_iommu_cap->pgsize_bitmap &
> +				  (SZ_4K | SZ_2M | SZ_1G);
> +	if (hv_iommu->pgsize_bitmap !=3D hv_iommu_cap->pgsize_bitmap)
> +		pr_warn("unsupported page sizes masked: 0x%llx -> 0x%llx\n",
> +			hv_iommu_cap->pgsize_bitmap, hv_iommu->pgsize_bitmap);
> +	if (!hv_iommu->pgsize_bitmap) {
> +		pr_warn("no supported page sizes, defaulting to 4K\n");
> +		hv_iommu->pgsize_bitmap =3D SZ_4K;
> +	}
> +	hv_iommu_device =3D hv_iommu;
> +}
> +
> +int __init hv_iommu_init(void)
> +{
> +	int ret =3D 0;
> +	struct hv_iommu_dev *hv_iommu =3D NULL;
> +	struct hv_output_get_iommu_capabilities hv_iommu_cap =3D {0};
> +
> +	if (no_iommu || iommu_detected)
> +		return -ENODEV;
> +
> +	if (!hv_is_hyperv_initialized())
> +		return -ENODEV;
> +
> +	ret =3D hv_iommu_detect(&hv_iommu_cap);
> +	if (ret) {
> +		pr_err("HVCALL_GET_IOMMU_CAPABILITIES failed: %d\n", ret);
> +		return -ENODEV;
> +	}
> +
> +	if (!hv_iommu_present(hv_iommu_cap.iommu_cap) ||
> +	    !hv_iommu_s1_domain_supported(hv_iommu_cap.iommu_cap)) {
> +		pr_err("IOMMU capabilities not sufficient: cap=3D0x%llx\n",
> +		       hv_iommu_cap.iommu_cap);
> +		return -ENODEV;
> +	}
> +
> +	iommu_detected =3D 1;
> +	pci_request_acs();
> +
> +	hv_iommu =3D kzalloc_obj(*hv_iommu, GFP_KERNEL);
> +	if (!hv_iommu)
> +		return -ENOMEM;
> +
> +	hv_init_iommu_device(hv_iommu, &hv_iommu_cap);
> +
> +	ret =3D hv_initialize_static_domains();
> +	if (ret) {
> +		pr_err("static domains init failed: %d\n", ret);
> +		goto err_free;
> +	}
> +
> +	ret =3D iommu_device_sysfs_add(&hv_iommu->iommu, NULL, NULL, "%s", "hv-=
iommu");
> +	if (ret) {
> +		pr_err("iommu_device_sysfs_add failed: %d\n", ret);
> +		goto err_delete_static_domains;
> +	}
> +
> +	ret =3D iommu_device_register(&hv_iommu->iommu, &hv_iommu_ops, NULL);
> +	if (ret) {
> +		pr_err("iommu_device_register failed: %d\n", ret);
> +		goto err_sysfs_remove;
> +	}
> +
> +	pr_info("successfully initialized\n");
> +	return 0;
> +
> +err_sysfs_remove:
> +	iommu_device_sysfs_remove(&hv_iommu->iommu);
> +err_delete_static_domains:
> +	hv_delete_device_domain(&hv_blocking_domain);
> +	hv_delete_device_domain(&hv_identity_domain);
> +err_free:
> +	kfree(hv_iommu);
> +	return ret;
> +}
> diff --git a/drivers/iommu/hyperv/iommu.h b/drivers/iommu/hyperv/iommu.h
> new file mode 100644
> index 000000000000..43f20d371245
> --- /dev/null
> +++ b/drivers/iommu/hyperv/iommu.h
> @@ -0,0 +1,54 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +/*
> + * Hyper-V IOMMU driver.
> + *
> + * Copyright (C) 2024-2025, Microsoft, Inc.
> + *
> + */
> +
> +#ifndef _HYPERV_IOMMU_H
> +#define _HYPERV_IOMMU_H
> +
> +struct hv_iommu_dev {
> +	struct iommu_device iommu;
> +	struct ida domain_ids;
> +
> +	/* Device configuration */
> +	u8  max_iova_width;
> +	u8  max_pasid_width;
> +	u64 cap;
> +	u64 pgsize_bitmap;
> +
> +	struct iommu_domain_geometry geometry;
> +	u64 first_domain;
> +	u64 last_domain;
> +};
> +
> +struct hv_iommu_domain {
> +	union {
> +		struct iommu_domain    domain;
> +		struct pt_iommu        pt_iommu;
> +		struct pt_iommu_x86_64 pt_iommu_x86_64;
> +	};
> +	struct hv_iommu_dev *hv_iommu;
> +	struct hv_input_device_domain device_domain;
> +	u64		pgsize_bitmap;
> +};
> +
> +struct hv_pci_busdata {
> +	int               pci_domain_nr;
> +	u32               logical_dev_id_prefix;
> +	struct list_head  list;
> +};
> +
> +struct hv_iommu_endpoint {
> +	struct device *dev;
> +	struct hv_iommu_dev *hv_iommu;
> +	struct hv_iommu_domain *hv_domain;
> +};
> +
> +#define to_hv_iommu_domain(d) \
> +	container_of(d, struct hv_iommu_domain, domain)
> +
> +#endif /* _HYPERV_IOMMU_H */
> diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller=
/pci-hyperv.c
> index cfc8fa403dad..a4af9c8c2220 100644
> --- a/drivers/pci/controller/pci-hyperv.c
> +++ b/drivers/pci/controller/pci-hyperv.c
> @@ -3715,6 +3715,7 @@ static int hv_pci_probe(struct hv_device *hdev,
>  	struct hv_pcibus_device *hbus;
>  	int ret, dom;
>  	u16 dom_req;
> +	u32 prefix;
>  	char *name;
>=20
>  	bridge =3D devm_pci_alloc_host_bridge(&hdev->device, 0);
> @@ -3857,13 +3858,25 @@ static int hv_pci_probe(struct hv_device *hdev,
>=20
>  	hbus->state =3D hv_pcibus_probed;
>=20
> -	ret =3D create_root_hv_pci_bus(hbus);
> +	/* Notify pvIOMMU before any device on the bus is scanned. */
> +	prefix =3D (hdev->dev_instance.b[5] << 24) |
> +		 (hdev->dev_instance.b[4] << 16) |
> +		 (hdev->dev_instance.b[7] <<  8) |
> +		 (hdev->dev_instance.b[6] & 0xf8);

This assembling of the logical device id prefix duplicates the
code in hv_irq_retarget_interrupt(). Could this code save the
prefix in struct hv_pcibus_device, and then have
hv_irq_retarget_interrupt() use it?  Then it would be clear
that HVCALL_RETARGET_INTERRUPT is using exactly the same
logical device id as the IOMMU hypercalls.

> +
> +	ret =3D hv_iommu_register_pci_bus(dom, prefix);
>  	if (ret)
>  		goto free_windows;
>=20
> +	ret =3D create_root_hv_pci_bus(hbus);
> +	if (ret)
> +		goto unregister_pviommu;
> +
>  	mutex_unlock(&hbus->state_lock);
>  	return 0;
>=20
> +unregister_pviommu:
> +	hv_iommu_unregister_pci_bus(dom);
>  free_windows:
>  	hv_pci_free_bridge_windows(hbus);
>  exit_d0:
> @@ -3974,8 +3987,10 @@ static int hv_pci_bus_exit(struct hv_device *hdev,=
 bool
> keep_devs)
>  static void hv_pci_remove(struct hv_device *hdev)
>  {
>  	struct hv_pcibus_device *hbus;
> +	int dom;
>=20
>  	hbus =3D hv_get_drvdata(hdev);
> +	dom =3D hbus->bridge->domain_nr;

Nit: Setting "dom" here feels a little weird because the value is only need=
ed
under the "if" statement. The value must be read before the root bus is
removed, but even so moving it under the "if" statement would make more
sense to me.

>  	if (hbus->state =3D=3D hv_pcibus_installed) {
>  		tasklet_disable(&hdev->channel->callback_event);
>  		hbus->state =3D hv_pcibus_removing;
> @@ -3994,6 +4009,8 @@ static void hv_pci_remove(struct hv_device *hdev)
>  		hv_pci_remove_slots(hbus);
>  		pci_remove_root_bus(hbus->bridge->bus);
>  		pci_unlock_rescan_remove();
> +
> +		hv_iommu_unregister_pci_bus(dom);
>  	}
>=20
>  	hv_pci_bus_exit(hdev, false);
> diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyper=
v.h
> index bf601d67cecb..b71345c74568 100644
> --- a/include/asm-generic/mshyperv.h
> +++ b/include/asm-generic/mshyperv.h
> @@ -73,6 +73,18 @@ extern enum hv_partition_type hv_curr_partition_type;
>  extern void * __percpu *hyperv_pcpu_input_arg;
>  extern void * __percpu *hyperv_pcpu_output_arg;
>=20
> +#ifdef CONFIG_HYPERV_PVIOMMU
> +int  hv_iommu_register_pci_bus(int pci_domain_nr, u32 logical_dev_id_pre=
fix);
> +void hv_iommu_unregister_pci_bus(int pci_domain_nr);
> +#else
> +static inline int hv_iommu_register_pci_bus(int pci_domain_nr,
> +					    u32 logical_dev_id_prefix)
> +{
> +	return 0;
> +}
> +static inline void hv_iommu_unregister_pci_bus(int pci_domain_nr) { }
> +#endif
> +
>  u64 hv_do_hypercall(u64 control, void *inputaddr, void *outputaddr);
>  u64 hv_do_fast_hypercall8(u16 control, u64 input8);
>  u64 hv_do_fast_hypercall16(u16 control, u64 input1, u64 input2);
> --
> 2.52.0
>=20


