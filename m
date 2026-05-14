Return-Path: <linux-hyperv+bounces-10889-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SP7BEAkRBmobegIAu9opvQ
	(envelope-from <linux-hyperv+bounces-10889-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 14 May 2026 20:14:33 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A8DCA545C24
	for <lists+linux-hyperv@lfdr.de>; Thu, 14 May 2026 20:14:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B6E4230221DE
	for <lists+linux-hyperv@lfdr.de>; Thu, 14 May 2026 18:14:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80AE53932CC;
	Thu, 14 May 2026 18:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="pM9Yl7Pr"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azolkn19012021.outbound.protection.outlook.com [52.103.10.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEEAF3314C4;
	Thu, 14 May 2026 18:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.10.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778782469; cv=fail; b=b/Oi+0eWxLpH1caWzw71emkzvdi5zGCNg838jNUiev/+rTkbIyQX/EEL4So1wyPjp+OFItjtD4R7tKA2nF7nBqY53Ys7ZVtiwWzMtzsYrqC1kfUGJ+iMo9TcS+TwhChZRf19PD5vUEpdfYY0oA5NSeahVxGD3bKsdAhCuOWq55E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778782469; c=relaxed/simple;
	bh=jg67jzHh+HbmeJos/RB4PK/r7fg/cWQA7nKYNKn2+io=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=D1el1ylx/5dYW/X1YStddUnDeG17+5d1B+g9SkK0IgK1pCQj84Eg2SmQ4unpWH/JA8sUYPg2wftVVGFowzQvtt8XfF+QZuU+n9ejbwOUd4BT01l7GIqlJqimgTxC8t2xStL4NbhpEYIML9MEG8sxfvYW14hFcceYw+xxoEUxm9U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=pM9Yl7Pr; arc=fail smtp.client-ip=52.103.10.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OXgPLaCLY4rMH3Og1h7Qw9kWDdY6Yr00OFkwGJmqAtEbAVIecZx0X9gyAE7OSBbEqFzQ7IYy5Poc9swOkTyPV9MnvW+0Witx32J0s7rQ5ey4A1ClncImJyrBV0P4hWK/CErQZKqYnNZPj3MhQvad7c3Svg3f5kmOrIYWLPGxdl6oHIzW6xSzoN9kE/bURkazdKD8RIWjlSqzU2gh8zBMmzcde9zP48lnHe5jq557K3c+xiFCNoCbt5eOTErML4df+GmaupL8JCzUSiBzTHMAEtkxPaCc47DCkcxZyROnYhOSPLJ3WhcI01+OXI+3somjNanNjX+d30Y7Ct0UtjShHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l/nXmxllZKjopD4HXX4xjOuAhRarBk2K3K2207sOxks=;
 b=esqZ8mP42kglYUKqaJr8aqnuweS28QV+kN0nBOl/yBFaD0aIJe14WgaSUf01XBK4isC5TXnEqrDHpBV2gKgbU+5spyWL9TgvhhLnmHLmoM/yFdYdILNZZXV6bLQem5thFdCyC+G9ZLDrmNo9Opbv+QSsWGGfdJPOX1P6mgcDWDppe6dOPMKNAD4keIur6eMUw0ZYklCkFKdTDKz65I30/nH+lrNNsYntn3DRPUGjQQ5RuLPIQcAO5qqdao6YaLRP5iz6wXx/XdWYvG6laoWNnv2j7KEEMxrLrlLUxsIsJJik4r9BBinp5abmNS2XXFJn9olQLHVv/HGWlWunxjZDaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l/nXmxllZKjopD4HXX4xjOuAhRarBk2K3K2207sOxks=;
 b=pM9Yl7PrzsMdgPOuBCrn9PuuNIukYiVXXUysAcDdIJWRQz4X2x+BIr9Q5bV6beZhJlqYnIIaqJnob6B0RO648idfpam+v8VGJwQVnV3afs3E0sdKil4iXkYjc4KloFES4cMfhhLxo3lM++LUDbZpljNjHhLw8jb+3pUOPlrTzpUvxpT0+1bv6hs1FCBz/FviojH6UDIPWQiTx/1fuiFlraMD+IKsyaZkxezAgWAmlQIIAiGBw+8NCEdVJOSTZb0KQIUeAqFlq7KUh+2OCXUfP1FIUQJegYKOndkJIdhiwMhwYlh7uWsGexMAlEsQaPGvEw31dQzg+oTl4j5iZzw6eQ==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by SN7PR02MB9284.namprd02.prod.outlook.com (2603:10b6:806:349::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.20; Thu, 14 May
 2026 18:14:25 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6%6]) with mapi id 15.20.9913.009; Thu, 14 May 2026
 18:14:22 +0000
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
Subject: RE: [PATCH v1 4/4] iommu/hyperv: Add page-selective IOTLB flush
 support
Thread-Topic: [PATCH v1 4/4] iommu/hyperv: Add page-selective IOTLB flush
 support
Thread-Index: AQHc4WKquRiuLrUu+ESNYKKX1F+8PLYN2DNA
Date: Thu, 14 May 2026 18:14:22 +0000
Message-ID:
 <SN6PR02MB41577D5EEC884EAE8AF5E14ED4072@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20260511162408.1180069-1-zhangyu1@linux.microsoft.com>
 <20260511162408.1180069-5-zhangyu1@linux.microsoft.com>
In-Reply-To: <20260511162408.1180069-5-zhangyu1@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|SN7PR02MB9284:EE_
x-ms-office365-filtering-correlation-id: 176ee885-ef26-4254-dbe8-08deb1e49fee
x-microsoft-antispam:
 BCL:0;ARA:14566002|41001999006|8062599012|31061999003|19110799012|8060799015|15080799012|51005399006|19101099003|13091999003|55001999006|37011999003|440099028|12091999003|102099032|3412199025|40105399003|1710799026;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?Bfq63xbgmaWXMhmd3V/ohR8hFTiOKX7wYTfficjCSmuBmRgJ2atiyfoTNhBk?=
 =?us-ascii?Q?LCHTwHYof2OKY9sL4o4YUDoGkG8aZVHoDsU1b59k/277qx5XbIJ60ozFky4w?=
 =?us-ascii?Q?NBZTt+mOtct+pIfdS0nXn1FFCP/FDDLfxQiAsqRHz3d6NDsNJFTpEYx9L8fB?=
 =?us-ascii?Q?inuLThmM1l1n2qnOY1Fv4MRfxwKHwsJjbgdaYYiZPzXuYeDbticLgVEkiN7J?=
 =?us-ascii?Q?T7JNZy7x0UWf9hjyVmwm0HObbO6yhWI3Ej2AQKY+3rY1JUbxI3b3Brl5/qMF?=
 =?us-ascii?Q?frTbIRFIDEkelBJj2P3xgEoOBcnjfIoYbuJfuxqYsyksh0EptVNUHMoeEeuO?=
 =?us-ascii?Q?sKU2+ymYNxOr3Xjuq5PnMODiXSnlLYBKHRjhQvg7eEWCQdnC38j6YpW7SKC0?=
 =?us-ascii?Q?h0A7JR9CVXuHeoMaYhcp81nxmi0yUeL4P5nPH0O+UgYDf9G3ozXjfrWon1Ef?=
 =?us-ascii?Q?vtPKlVvQXuuC+H2wB3e+pZlVUeOMZHNUHnuOI148wZ0HY3nkLb2B/0W8lsVz?=
 =?us-ascii?Q?spEGeuUwGP6OV5Tn8uTOC6Jj8ETI8uwcFDXCxF9xiIAhShPQxAOD6L9mrS++?=
 =?us-ascii?Q?OAArjjsQWnnreSSLELnHXeMiOh9fgGex9+U5hlIGsTgz1H1iEYgqz5SJOMBL?=
 =?us-ascii?Q?nugv+kbyN8F6GacvgRoOx2/bW9x9TxWa5SDKG8iKpSzVA8cIdzFqMCKN9o1D?=
 =?us-ascii?Q?INNE+5YZKazIhLzr2zBOsfJJbceEqgVoLVjT3uJdeBOIhnxVquLYmawsc80z?=
 =?us-ascii?Q?/F/EJ7SLfCnaGlMuMv8cuOm/b+E3ITXi47pxyI0F/zlXpjs9EMJSazx8BLyf?=
 =?us-ascii?Q?RUt6Tb/NatW17BBPvjfvhNM/+MWOitrt2wMPwp16tAG+DaWkIPpSYY0eBEU0?=
 =?us-ascii?Q?lVWM2vYrBsCT/Dn0OvCIoSuCmnfgrHTKYHCJr2pHBoipIfZQt543QXc6SW7D?=
 =?us-ascii?Q?OugC8nQYC0GqACb5qzofnDRNpxoebDAJ7Q3r1gHe/41sZm52wPIe9IRFR+c4?=
 =?us-ascii?Q?rYwzrriZfzVjJGr9g0LraCZAPrAlcQYN1UWIy4sVFP0H3QafdiSw8NbaYGLQ?=
 =?us-ascii?Q?vuSjMKnt8rIidQDzs6qWVVdjauWDejpCcFOc18iDgKkL38egIiYsvLKNG029?=
 =?us-ascii?Q?LKlAOPytnklY?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?dEQpon4sqieqq7YaLzJNvYgpFZJxR0n8prTeQk6+x1ge7QFFcN/vPz3X0qEN?=
 =?us-ascii?Q?P2T17hAu/9RFn87ZsP/eryYvaJaovEGy+gGiO1xSVp8xUKCEYX/lCIkWdS1K?=
 =?us-ascii?Q?b/kw3j/k670pZAew31VY+loaARpKq5MF6ivsB1sLq4br49c5QR4D2HDtcSMi?=
 =?us-ascii?Q?3ZBZk3Z9ewP4q4CNIdms3lsAykYXA9nhmji1MrNV/akTCAKTqhH5W+fpzhH2?=
 =?us-ascii?Q?8zy6q45ImIraw8Zffy7VUlgvrGjJVRPeWHBmyrECHmSCJaywggq+t9NDPkmL?=
 =?us-ascii?Q?A5G48bY0z5lgRdo5U9lTcCrb0rbjYRbCur5RfEfkKKUVL5ae+URsx5wCsO04?=
 =?us-ascii?Q?X1OLZ6k0neFPeeGQbXYcgwX+SPhLn11qvlionQZSMy7wyBrsJpr26Dp2Fk/S?=
 =?us-ascii?Q?yC4APtckfzZf2qtG/LYA6totU8EXEQpDgIRJOGWgB08t+GaSiWCHShlx1RVZ?=
 =?us-ascii?Q?Ejz0G/lWMbN6gLqrIIqixfTGGKb/uCfQZNtBvh05v0j17EYMOA84sZ1j3PtK?=
 =?us-ascii?Q?+w0JPYuvLxTu8rskySTcoTavMld+vHx4/oece3gTAs4/UQheo/VSkf4fisqx?=
 =?us-ascii?Q?624n0XP7iq10g9o/jkuZRQSUYGi2zmweJIpF3aFkzgiknhDmPHsCYJTtnLZM?=
 =?us-ascii?Q?CMQAcvFm0jMUh2Ehw+ksVyiIAuWMEsC79cJKbDO80bQkWCWBr0GjuWD8yhg+?=
 =?us-ascii?Q?l5vRVIhFhWApf83fcEVccYWW7fPnQ8BN8zyQ61V4W79HmL8ohB934YWTYib1?=
 =?us-ascii?Q?/KT7bqLcQHNwf/+ELrNgEWya3YlQbGygAg7kDyZ9iJ+BZUjUNHivKGRelZE1?=
 =?us-ascii?Q?258/1KeDwXBp55RbA1so5UrQKsk29r9eFuKgv8c7WPr3VTzsRo3mfMWPEDGr?=
 =?us-ascii?Q?w+W2aW7snexulnQbmOqcRoyOEsowN48frZjiXlZBUqt2Lh7Jv9f/ZfFYzTZ1?=
 =?us-ascii?Q?yNMaDnefS/XBzk/Y+ELhlSFFJPy8Hllbyplr+CsyvG3Siv6gbZjl1tJe7NCC?=
 =?us-ascii?Q?0ig9YnSoGoZdWJskjl374Ms/+Gc9JzCAbqANO0PW5FWa3J5dTui20H97/DMN?=
 =?us-ascii?Q?2L8KnoDi1MKBZMOaA0HROPJspOqp1MyKB0obz4EvNPZ4vuX1OaryM61Q1N9E?=
 =?us-ascii?Q?YL+0Ub+dBNQFXbSNUAUY60EtE8ci1pFe42n4EB4Mlzw+37JWrf72c2obJh3P?=
 =?us-ascii?Q?XlrQny9Ilr4g7IkJle1kN9YkjIV0OWuXsnxS0TfZNUVVcASKlEDJFVVLnKVg?=
 =?us-ascii?Q?jkLY2dWtEM8l0br+uEKx+Zl6cgEDnwi3UYWr7Mejo8LqM0Cgahr4ejitDQoX?=
 =?us-ascii?Q?eY3RHSOk5lalcIFYdSXFfUbXVyt+ytYJl3vR18T1Ml39O4EmuLPv0c2hdSvh?=
 =?us-ascii?Q?nmw0u94=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 176ee885-ef26-4254-dbe8-08deb1e49fee
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 May 2026 18:14:22.7024
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR02MB9284
X-Rspamd-Queue-Id: A8DCA545C24
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[outlook.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[outlook.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10889-lists,linux-hyperv=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-hyperv];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,outlook.com:dkim,SN6PR02MB4157.namprd02.prod.outlook.com:mid]
X-Rspamd-Action: no action

From: Yu Zhang <zhangyu1@linux.microsoft.com> Sent: Monday, May 11, 2026 9:=
24 AM
>=20
> Add page-selective IOTLB flush using HVCALL_FLUSH_DEVICE_DOMAIN_LIST.
> This hypercall accepts a list of (page_number, page_mask_shift) entries,
> enabling finer-grained IOTLB invalidation compared to the domain-wide
> HVCALL_FLUSH_DEVICE_DOMAIN used by hv_iommu_flush_iotlb_all().
>=20
> hv_iommu_fill_iova_list() decomposes a contiguous IOVA range into a
> minimal set of aligned power-of-two regions that fit in a single
> hypercall input page. When the range exceeds the page capacity, the
> code falls back to a full domain flush automatically.
>=20
> Signed-off-by: Yu Zhang <zhangyu1@linux.microsoft.com>
> Signed-off-by: Easwar Hariharan <easwar.hariharan@linux.microsoft.com>
> ---
>  drivers/iommu/hyperv/iommu.c | 91 +++++++++++++++++++++++++++++++++++-
>  include/hyperv/hvgdk_mini.h  |  1 +
>  include/hyperv/hvhdk_mini.h  | 17 +++++++
>  3 files changed, 108 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/iommu/hyperv/iommu.c b/drivers/iommu/hyperv/iommu.c
> index e5fc625314b5..3bca362b7815 100644
> --- a/drivers/iommu/hyperv/iommu.c
> +++ b/drivers/iommu/hyperv/iommu.c
> @@ -486,10 +486,98 @@ static void hv_iommu_flush_iotlb_all(struct iommu_d=
omain *domain)
>  	hv_flush_device_domain(to_hv_iommu_domain(domain));
>  }
>=20
> +/* Max number of iova_list entries in a single hypercall input page. */
> +#define HV_IOMMU_MAX_FLUSH_VA_COUNT \
> +	((HV_HYP_PAGE_SIZE - sizeof(struct hv_input_flush_device_domain_list)) =
/ \
> +	 sizeof(union hv_iommu_flush_va))
> +
> +/* Returned by hv_iommu_fill_iova_list() when the range exceeds the capa=
city */
> +#define HV_IOMMU_FLUSH_VA_OVERFLOW	U16_MAX
> +
> +static inline u16 hv_iommu_fill_iova_list(union hv_iommu_flush_va *iova_=
list,
> +					  unsigned long start,
> +					  unsigned long end)
> +{
> +	unsigned long start_pfn =3D start >> PAGE_SHIFT;
> +	unsigned long end_pfn =3D PAGE_ALIGN(end) >> PAGE_SHIFT;

"end" is an inclusive end address per comment in struct iommu_iotlb_gather.
So a page aligned value would typically have 0xFFF as the low order 12 bits=
,
and PAGE_ALIGN() will do the right thing. But I don't think the value is
*required* to be page aligned.  If the value of "end" had 0x000 as the
low order 12 bits, the above calculation would fail to include the page
that has the address ending in 0x000.  I think it needs to be
PAGE_ALIGN(end + 1) in order to work correctly for this corner case.=20

> +	unsigned long nr_pages =3D end_pfn - start_pfn;
> +	u16 count =3D 0;
> +
> +	while (nr_pages > 0) {
> +		unsigned long flush_pages;
> +		int order;
> +		unsigned long pfn_align;
> +		unsigned long size_align;
> +
> +		if (count >=3D HV_IOMMU_MAX_FLUSH_VA_COUNT) {
> +			count =3D HV_IOMMU_FLUSH_VA_OVERFLOW;
> +			break;
> +		}
> +
> +		if (start_pfn)
> +			pfn_align =3D __ffs(start_pfn);

I don't understand why __ffs() is correct here. I would expect
__fls() so it is consistent with the calculation of size_align. But I
can only surmise how the hypercall works since there's no
documentation, so maybe my understanding of the hypercall is
wrong.   If __ffs really is correct, a comment explaining why
would help. :-)

> +		else
> +			pfn_align =3D BITS_PER_LONG - 1;
> +
> +		size_align =3D __fls(nr_pages);
> +		order =3D min(pfn_align, size_align);
> +		iova_list[count].page_mask_shift =3D order;
> +		iova_list[count].page_number =3D start_pfn;
> +
> +		flush_pages =3D 1UL << order;
> +		start_pfn +=3D flush_pages;
> +		nr_pages -=3D flush_pages;
> +		count++;
> +	}
> +
> +	return count;
> +}
> +
> +static void hv_flush_device_domain_list(struct hv_iommu_domain *hv_domai=
n,
> +					struct iommu_iotlb_gather *iotlb_gather)
> +{
> +	u64 status;
> +	u16 count;
> +	unsigned long flags;
> +	struct hv_input_flush_device_domain_list *input;
> +
> +	local_irq_save(flags);
> +
> +	input =3D *this_cpu_ptr(hyperv_pcpu_input_arg);
> +	memset(input, 0, sizeof(*input));
> +
> +	input->device_domain =3D hv_domain->device_domain;
> +	input->flags |=3D HV_FLUSH_DEVICE_DOMAIN_LIST_IOMMU_FORMAT;

I would suggest moving the memset() and setting the input fields down
under the "else" below so that they are parallel with the flush all case.

> +	count =3D hv_iommu_fill_iova_list(input->iova_list,
> +					iotlb_gather->start,
> +					iotlb_gather->end);
> +	if (count =3D=3D HV_IOMMU_FLUSH_VA_OVERFLOW) {
> +		/*
> +		 * Range exceeds hypercall page capacity. Fall back to a full
> +		 * domain flush.
> +		 */
> +		struct hv_input_flush_device_domain *flush_all =3D (void *)input;
> +
> +		memset(flush_all, 0, sizeof(*flush_all));
> +		flush_all->device_domain =3D hv_domain->device_domain;
> +		status =3D hv_do_hypercall(HVCALL_FLUSH_DEVICE_DOMAIN,
> +					flush_all, NULL);
> +	} else {
> +		status =3D hv_do_rep_hypercall(
> +				HVCALL_FLUSH_DEVICE_DOMAIN_LIST,
> +				count, 0, input, NULL);
> +	}
> +
> +	local_irq_restore(flags);
> +
> +	if (!hv_result_success(status))
> +		pr_err("HVCALL_FLUSH_DEVICE_DOMAIN_LIST failed, status %lld\n", status=
);

As Sashiko pointed out, a failure here can lead to all kinds of trouble bec=
ause
of leaving unflushed entries. Maybe a WARN() is more appropriate? Also, may=
be
a failure in the list flush should try a flush all as a fallback, with the =
WARN()
only if the flush all fails.

> +}
> +
>  static void hv_iommu_iotlb_sync(struct iommu_domain *domain,
>  				struct iommu_iotlb_gather *iotlb_gather)
>  {
> -	hv_flush_device_domain(to_hv_iommu_domain(domain));
> +	hv_flush_device_domain_list(to_hv_iommu_domain(domain), iotlb_gather);
>=20
>  	iommu_put_pages_list(&iotlb_gather->freelist);
>  }
> @@ -543,6 +631,7 @@ static struct iommu_domain *hv_iommu_domain_alloc_pag=
ing(struct device *dev)
>=20
>  	cfg.common.hw_max_vasz_lg2 =3D hv_iommu_device->max_iova_width;
>  	cfg.common.hw_max_oasz_lg2 =3D 52;
> +	cfg.common.features |=3D BIT(PT_FEAT_FLUSH_RANGE);
>  	cfg.top_level =3D (hv_iommu_device->max_iova_width > 48) ? 4 : 3;
>=20
>  	ret =3D pt_iommu_x86_64_init(&hv_domain->pt_iommu_x86_64, &cfg,
> GFP_KERNEL);
> diff --git a/include/hyperv/hvgdk_mini.h b/include/hyperv/hvgdk_mini.h
> index 5bdbb44da112..eaaf87171478 100644
> --- a/include/hyperv/hvgdk_mini.h
> +++ b/include/hyperv/hvgdk_mini.h
> @@ -496,6 +496,7 @@ union hv_vp_assist_msr_contents {	 /*
> HV_REGISTER_VP_ASSIST_PAGE */
>  #define HVCALL_GET_GPA_PAGES_ACCESS_STATES		0x00c9
>  #define HVCALL_CONFIGURE_DEVICE_DOMAIN			0x00ce
>  #define HVCALL_FLUSH_DEVICE_DOMAIN			0x00d0
> +#define HVCALL_FLUSH_DEVICE_DOMAIN_LIST			0x00d1
>  #define HVCALL_ACQUIRE_SPARSE_SPA_PAGE_HOST_ACCESS	0x00d7
>  #define HVCALL_RELEASE_SPARSE_SPA_PAGE_HOST_ACCESS	0x00d8
>  #define HVCALL_MODIFY_SPARSE_GPA_PAGE_HOST_VISIBILITY	0x00db
> diff --git a/include/hyperv/hvhdk_mini.h b/include/hyperv/hvhdk_mini.h
> index 493608e791b4..f51d5d9467f1 100644
> --- a/include/hyperv/hvhdk_mini.h
> +++ b/include/hyperv/hvhdk_mini.h
> @@ -671,4 +671,21 @@ struct hv_input_flush_device_domain {
>  	u32 reserved;
>  } __packed;
>=20
> +union hv_iommu_flush_va {
> +	u64 iova;
> +	struct {
> +		u64 page_mask_shift : 12;
> +		u64 page_number : 52;
> +	};
> +} __packed;
> +
> +
> +struct hv_input_flush_device_domain_list {
> +	struct hv_input_device_domain device_domain;
> +#define HV_FLUSH_DEVICE_DOMAIN_LIST_IOMMU_FORMAT (1 << 0)
> +	u32 flags;
> +	u32 reserved;
> +	union hv_iommu_flush_va iova_list[];
> +} __packed;
> +
>  #endif /* _HV_HVHDK_MINI_H */
> --
> 2.52.0
>=20


