Return-Path: <linux-hyperv+bounces-9513-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0CDCGvnPuWmMOAIAu9opvQ
	(envelope-from <linux-hyperv+bounces-9513-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 17 Mar 2026 23:04:41 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CA552B2EBD
	for <lists+linux-hyperv@lfdr.de>; Tue, 17 Mar 2026 23:04:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id ED6B730074F4
	for <lists+linux-hyperv@lfdr.de>; Tue, 17 Mar 2026 22:04:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 965F6342144;
	Tue, 17 Mar 2026 22:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="od7xs7F4"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazolkn19012052.outbound.protection.outlook.com [52.103.20.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 235B533F597;
	Tue, 17 Mar 2026 22:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.20.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773785074; cv=fail; b=EoTgc598JismNGlUpXT16C2dGtI4xeVGbQJInzKp+3yjfIxpRmYj52nQAqMcnTe5AeYOD8QhnDYFsDUbR0qFLFyG6VJZCqJAojMJ5ezs5vQKPN2bTJrdbM03uOaCeK1tFJLA455Hb0WqYyH9y5/xGAzIOVRVhQS9ZykjRxzZEPs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773785074; c=relaxed/simple;
	bh=1jxl8pyeyYsoEZ6vozElwMIbO6X5GCaSEITpVCUY78M=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BHqG/nj05iow7B1ebBTF9f8pdO7WKHtqGile5YOYQ31UpP5G+0Oc2Y8585PYSBJDdRcCbNm/o+4PROjuYZOlMi0PO9WGpqf83S9sLe7RgS0eGHnpa6ORmINPfLAPGRqkCP8ZkYQMQkk5dSN16/Mfr06yXFrETqrgQoJljoUWohY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=od7xs7F4; arc=fail smtp.client-ip=52.103.20.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xHHzUrmE4KEvb3zRgYEFIVnqj3pj+rHpVHTjpyc8VjnEcm6LnVbZHlATX1kEHevxqB4S2ZkkTKrhPhLheeWcfMHQjqOc3Mv5mhAEfDNxwwLH2YcGt5GXPnGm56SPzPptXfdwG2kCG2SBs3saHhk4iUv57qJlO0zqh6ToJK4UHVSikO/WVio2eznS89iZKWNtbx5qzGfCL2WmD7L4bo/kWg06e+06/06xiHIlsooYdePjcE1IF91ajXSC25MAB1ltuQeiHpPGlxIhBD0/JBIiR9rvgFaQApAwwPuUepw4TuaWQWGmFGtQHL4SbnpGoc5P7CVBUijrO7iVUYxdsnrSaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mK7AnZA5zQToFouP8HV9eUz8Dd41X4GhkYbD3cq/lFk=;
 b=umH2XP367x4nerHLFwfONWB15VT4fc64yvJojJHO+guE6xugzxhE4Adc8eUw+cvqGvjs2H4SnKA3pO29QeQBPCi0dd0n9r67zRI4ce87hYb4eKGiZ9bKf2L+HOAdn8+6/Z6XlgfPAB1BGIBDju/e5VyU7bP8ysc9MYyyYJvnE0DAt7C0IZkW3c4BP6CoX3q23FE9NI8it64YFtz5I76hKEhy/70SB7Vo7Ys5SkKcqkto1Uv32cPt7d0niCdtQC9z8hx+UfHlF02u41eD0leZ4yLJxGndkZ37KLKGvbj2OsnQT1SOgU7tRPUj8DB/Si/AVCwoOXGiIJAnQnTiHbS8BA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mK7AnZA5zQToFouP8HV9eUz8Dd41X4GhkYbD3cq/lFk=;
 b=od7xs7F4rVsCgfDkxCzNVLdHJm1eh0ZnqBtYNjGrAq7vkag+gqeaBI9Nx5ZKGGjcg2GUaZ9NJy0mRZYeEDB9j0FV6aXtl9hz31y4zJA7XJ2BbIYQn1ObrGfrOrWTLkASj4QBcz7r7cxjgyFL4imfPCxgvg3ltitK2jttWLtdjFTLocgIRFfkoH+5ZkU/Cpkc+4/cEyzmbfSqXBTrGoSo+vltnL3/xmHy7sc8gWeZQESjFCD3bGy0VCkeZ/gIRXHbN8KlgyRVYC8CXFZRFihHrQWmlEyWXksTTs7+38U5y6kJNk0WB/N37BI25T9/Q4DjAn8BqbNyIas1ZHy+MXpn4w==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by MWHPR02MB10545.namprd02.prod.outlook.com (2603:10b6:303:286::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Tue, 17 Mar
 2026 22:03:07 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6%6]) with mapi id 15.20.9700.024; Tue, 17 Mar 2026
 22:03:06 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Naman Jain <namjain@linux.microsoft.com>, "K . Y . Srinivasan"
	<kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu
	<wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, Long Li
	<longli@microsoft.com>, Catalin Marinas <catalin.marinas@arm.com>, Will
 Deacon <will@kernel.org>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar
	<mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
	<dave.hansen@linux.intel.com>, "x86@kernel.org" <x86@kernel.org>, "H . Peter
 Anvin" <hpa@zytor.com>, Arnd Bergmann <arnd@arndb.de>, Paul Walmsley
	<pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou
	<aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>
CC: Marc Zyngier <maz@kernel.org>, Timothy Hayes <timothy.hayes@arm.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>, mrigendrachaubey
	<mrigendra.chaubey@gmail.com>, "ssengar@linux.microsoft.com"
	<ssengar@linux.microsoft.com>, Michael Kelley <mhklinux@outlook.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org"
	<linux-arch@vger.kernel.org>, "linux-riscv@lists.infradead.org"
	<linux-riscv@lists.infradead.org>
Subject: RE: [PATCH 00/11] Drivers: hv: Add ARM64 support in mshv_vtl
Thread-Topic: [PATCH 00/11] Drivers: hv: Add ARM64 support in mshv_vtl
Thread-Index: AQHctT5MQUy+plR6RkKYTgy6jJBWJ7WzSSyA
Date: Tue, 17 Mar 2026 22:03:06 +0000
Message-ID:
 <SN6PR02MB4157DFC7B7CE94500C89664BD441A@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20260316121241.910764-1-namjain@linux.microsoft.com>
In-Reply-To: <20260316121241.910764-1-namjain@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|MWHPR02MB10545:EE_
x-ms-office365-filtering-correlation-id: 57c921ad-0f24-41cf-bd1b-08de8470f837
x-microsoft-antispam:
 BCL:0;ARA:14566002|19110799012|8062599012|13091999003|8060799015|461199028|15080799012|31061999003|41001999006|37011999003|1602099012|52005399003|40105399003|41105399003|4302099013|3412199025|10035399007|440099028|102099032|1710799026;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?psvLWVDbwQQUU21guAumyr7THxVqB15xrr4vDgrMAoUAGCAGos+vkHsNGg+W?=
 =?us-ascii?Q?6J76/ACvEhO8YSW2dvkFy/OE1ka2v/rudH0wsj0NqaoaFdZ4gs+tbmM8V9Tp?=
 =?us-ascii?Q?/JbwAD/pXGiQXOQryWe6geB3XFLSodwK4pmKdfPuAn8hJtyeKyFoSvZ4iXrr?=
 =?us-ascii?Q?+4TxtnZOXT3YRSLZ1UjkIY4Tgqko+CRESa3Yy0YRGYF7YHU0BTvgqxG6EcKb?=
 =?us-ascii?Q?lQFpm87SiHBVy0dyuuGTEa9NCpcz8wapFsMBeBzAuv47mDhPVmpbkrMCH36s?=
 =?us-ascii?Q?JlFnRfXULv9xR2oaLvZZHPON/bNFpE4VVzTDNO3x/YQIgRJcz5QZPYyiauMG?=
 =?us-ascii?Q?RHeQ9b2cnKW7iD2TNSY/r/FFJVWgrMDs4VQ8Q5roSbrrmN2mU6SNb1yFDOXz?=
 =?us-ascii?Q?qCB4sx1QYKy2yyukWLfQzq5nlhp3UU9JT53NyvVsyn0vbrDk30glqQFjmb0b?=
 =?us-ascii?Q?zv1oGi60OYhktQF70Wx4p9fkkRbmPz1qp9ChOotjX0LJYiZ1h4kx8JIJxs2H?=
 =?us-ascii?Q?k99AZjrNQhr95QtSYhJNRPRDcURnYehCmMQsfjy3wqRZN3kMou/E7CTH6Ht+?=
 =?us-ascii?Q?mbqrud1ZSdCTns0ZrbHAMVwVKEIX/2PwBisWGRdNaZBV7GMi0iHR8rpPqXC8?=
 =?us-ascii?Q?XEYaQ3EFC/uKUXSn9saoY5DUodtF373nuaBc6I/G1skVI+ABbpjxS6wD2UgY?=
 =?us-ascii?Q?OzMPoC4syS1zQUu+jXsj+j1C/WXu1O8r0T6F+ZRfii7iu31ThlCN6H1iXbyw?=
 =?us-ascii?Q?9s3tvMhF3Ka3ffPrr0TiaXV/lWLjhu9smVkhoACA7hqurqgl8+Scy7OIt6Nn?=
 =?us-ascii?Q?n5qtbAVYsNWKg1wxoxyFgEaBmc25peEhZLnB6tdkpriTimj2xEKbtjn1KDqw?=
 =?us-ascii?Q?NUbOVJ+kdO2ZTYYNC3x/3qBRUyib6LLJM+Kt1zTcQGfTYvClOHQkMS7pZ/Wn?=
 =?us-ascii?Q?T79DPSDIzXGrkv9AmiGIudbUo/XH7oLnQ8ed/hRz2lYaEDyInx5okMvg1UE2?=
 =?us-ascii?Q?FHO+1C07COs4+P1zY8s8xhNOqKFNCLdADoaMeagBc9e8DJD3KdaziwJca54L?=
 =?us-ascii?Q?M0TqCfDdYcXsXocaPbKJY95CsdS43YTfBueAeon2NWtuaR6fC9iaN3ka1Czh?=
 =?us-ascii?Q?blZA7UHCSjVN?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?ELk/KZTU24blekeW/DU9p3X/GzG9GArFqbaD4vjO5rkZNIOayJj8qHKX289u?=
 =?us-ascii?Q?2czFk3bTT760fGFK3xOMLq7AFCNuSBexr4tQ7Jzep5wR6642Fs+yuUBNIAAb?=
 =?us-ascii?Q?vov6lQHD9q9h7wLrgNRGR6a/E/yvcMoMnxD0comtlpsrUe6Pu9FplSAs5s4/?=
 =?us-ascii?Q?/0aTYHZ7YOfKlu1cYjtAIqBbqDJ994ATPussPHIDnE1ha4P1TeFiQMiTqmsC?=
 =?us-ascii?Q?J8CLL8BXS5pXRJDUKXeTXhzETwLzJJSFqLR0ebbJdtP/5rvTgJPqIOQiJz0x?=
 =?us-ascii?Q?Uam/3M90F57PvlgnDAOHaWupIPbHN3BA0KH5yKCT7Xj/fEwUo8YPhSbDCJWK?=
 =?us-ascii?Q?P/ju/INbWR0mqebu5tIr+zmUEWXULHwRPwr3yt27dVjGfY78UHcvwMZdkf/t?=
 =?us-ascii?Q?OK0hVhOf58Jofks5CUj/M2vUMsqRLzBiSOXAOtIPlgHt+GwrAjZH2ffgHz7X?=
 =?us-ascii?Q?0jHf/k3oNzoLlduvh3wxGck/rBLcdWKlZMFG7uQjhu1XSXj++9V4YWA1XFsD?=
 =?us-ascii?Q?yaZ1+QMwdiR5PuI425ElgZ1+8qrEugWDsnJTABEEzSX99flMlVwayT6sTnvW?=
 =?us-ascii?Q?pOUJXf7SQYJRwnbg72B7Xigi0hog87iiaq8tfkLjREkBvklVx7JJwUpU4sb8?=
 =?us-ascii?Q?EgwLXsYR9ZU8u2mXcTbZ2c5TnRsWxMUWlcpNy+dWIsbf8RCC7i6RQ+iJDCFu?=
 =?us-ascii?Q?AZdt4p8dXOcXj7T5Kbq0LrWhEhJ7DpVkKgvnMySGyT5oRPPiactmMwIRi7Mf?=
 =?us-ascii?Q?8C03C/qcLmBzpCRXVz3SMmfkJLxoiGa60HFugKmT5w0wjsByQ5VZ2ueXHMgT?=
 =?us-ascii?Q?ZUkyrBUPAU6mJ7Z/xJoHlz3niS5SierDfVbsLU33JmX/DxryNtXTpFyUgfNQ?=
 =?us-ascii?Q?u5mo14J5rT3vj2bPGarT3lWP70plrPFRBxjeeWb7v3wtKHN8rXxqku0R0a8o?=
 =?us-ascii?Q?GWU2D1o4iercrvyif8BJNK0YpNIRU5wNgh4Z83vByGujckSeS4N1zJkxGART?=
 =?us-ascii?Q?4OxGy/Vm8tSueLMPEtKUQDwkialuaEEa1d0cqYK8ZE7i7aBdp6+OQ+sEdZOd?=
 =?us-ascii?Q?lWWyLLDj553ZZS4h2z0dLXvWLTZ1wZdC7xHf0KuKKWMhAByP1Pklb0xHk/ox?=
 =?us-ascii?Q?f8O1q0TJxReAhZJtS+TZbnmalR3hcGLE/7qlaO/iESYaxgaUDFg7AZPqySv1?=
 =?us-ascii?Q?VmhkQjXa/93wqP9GQiU7hi/RDcACMt8n3DisIh1+bQEy6Rj+v9yUzbyGoRfU?=
 =?us-ascii?Q?ei4A/vCYjCYUS0F+GJGHOsxLhZ6BCl1SWm+N362twVeKH1S8oddF54LgEgMP?=
 =?us-ascii?Q?+ECATaItwa2sK2toz/ES/Kl7I/bWVvG00RSg9bb4yKDodR1rECFBz+cqInCa?=
 =?us-ascii?Q?ldCprwE=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 57c921ad-0f24-41cf-bd1b-08de8470f837
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2026 22:03:06.8517
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR02MB10545
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[outlook.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[outlook.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[outlook.com];
	RCPT_COUNT_TWELVE(0.00)[30];
	TAGGED_FROM(0.00)[bounces-9513-lists,linux-hyperv=lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,arm.com,gmail.com,linux.microsoft.com,outlook.com,vger.kernel.org,lists.infradead.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[mhklinux@outlook.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[outlook.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-hyperv];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,outlook.com:dkim,SN6PR02MB4157.namprd02.prod.outlook.com:mid]
X-Rspamd-Queue-Id: 5CA552B2EBD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Naman Jain <namjain@linux.microsoft.com> Sent: Monday, March 16, 2026=
 5:13 AM
>=20
> The series intends to add support for ARM64 to mshv_vtl driver.
> For this, common Hyper-V code is refactored, necessary support is added,
> mshv_vtl_main.c is refactored and then finally support is added in
> Kconfig.
>=20
> Based on commit 1f318b96cc84 ("Linux 7.0-rc3")

There's now an online LLM-based tool that is automatically reviewing
kernel patches. For this patch set, the results are here:

https://sashiko.dev/#/patchset/20260316121241.910764-1-namjain%40linux.micr=
osoft.com

It has flagged several things that are worth checking, but I haven't
reviewed them to see if they are actually valid.

FWIW, the announcement about sashiko.dev is here:

https://lore.kernel.org/lkml/7ia4o6kmpj5s.fsf@castle.c.googlers.com/

Michael

>=20
> Naman Jain (11):
>   arch: arm64: Export arch_smp_send_reschedule for mshv_vtl module
>   Drivers: hv: Move hv_vp_assist_page to common files
>   Drivers: hv: Add support to setup percpu vmbus handler
>   Drivers: hv: Refactor mshv_vtl for ARM64 support to be added
>   drivers: hv: Export vmbus_interrupt for mshv_vtl module
>   Drivers: hv: Make sint vector architecture neutral in MSHV_VTL
>   arch: arm64: Add support for mshv_vtl_return_call
>   Drivers: hv: mshv_vtl: Move register page config to arch-specific
>     files
>   Drivers: hv: mshv_vtl: Let userspace do VSM configuration
>   Drivers: hv: Add support for arm64 in MSHV_VTL
>   Drivers: hv: Kconfig: Add ARM64 support for MSHV_VTL
>=20
>  arch/arm64/hyperv/Makefile        |   1 +
>  arch/arm64/hyperv/hv_vtl.c        | 152 ++++++++++++++++++++++
>  arch/arm64/hyperv/mshyperv.c      |  13 ++
>  arch/arm64/include/asm/mshyperv.h |  28 ++++
>  arch/arm64/kernel/smp.c           |   1 +
>  arch/x86/hyperv/hv_init.c         |  88 +------------
>  arch/x86/hyperv/hv_vtl.c          | 130 +++++++++++++++++++
>  arch/x86/include/asm/mshyperv.h   |   8 +-
>  drivers/hv/Kconfig                |   2 +-
>  drivers/hv/hv_common.c            |  99 +++++++++++++++
>  drivers/hv/mshv.h                 |   8 --
>  drivers/hv/mshv_vtl_main.c        | 205 ++++--------------------------
>  drivers/hv/vmbus_drv.c            |   8 +-
>  include/asm-generic/mshyperv.h    |  49 +++++++
>  include/hyperv/hvgdk_mini.h       |   2 +
>  15 files changed, 505 insertions(+), 289 deletions(-)
>  create mode 100644 arch/arm64/hyperv/hv_vtl.c
>=20
>=20
> base-commit: 1f318b96cc84d7c2ab792fcc0bfd42a7ca890681
> prerequisite-patch-id: 24022ec1fb63bc20de8114eedf03c81bb1086e0e
> prerequisite-patch-id: 801f2588d5c6db4ceb9a6705a09e4649fab411b1
> prerequisite-patch-id: 581c834aa268f0c54120c6efbc1393fbd9893f49
> prerequisite-patch-id: b0b153807bab40860502c52e4a59297258ade0db
> prerequisite-patch-id: 2bff6accea80e7976c58d80d847cd33f260a3cb9
> prerequisite-patch-id: 296ffbc4f119a5b249bc9c840f84129f5c151139
> prerequisite-patch-id: 3b54d121145e743ac5184518df33a1812280ec96
> prerequisite-patch-id: 06fc5b37b23ee3f91a2c8c9b9c126fde290834f2
> prerequisite-patch-id: 6e8afed988309b03485f5538815ea29c8fa5b0a9
> prerequisite-patch-id: 4f1fb1b7e9cfa8a3b1c02fafecdbb432b74ee367
> prerequisite-patch-id: 49944347e0b2d93e72911a153979c567ebb7e66b
> prerequisite-patch-id: 6dec75498eeae6365d15ac12b5d0a3bd32e9f91c
> --
> 2.43.0
>=20


