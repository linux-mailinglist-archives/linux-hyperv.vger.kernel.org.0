Return-Path: <linux-hyperv+bounces-10349-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YJF3APtZ6mmgyQIAu9opvQ
	(envelope-from <linux-hyperv+bounces-10349-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 23 Apr 2026 19:42:19 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 675AC455A87
	for <lists+linux-hyperv@lfdr.de>; Thu, 23 Apr 2026 19:42:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 59CAB302E3D3
	for <lists+linux-hyperv@lfdr.de>; Thu, 23 Apr 2026 17:40:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6064E3A7859;
	Thu, 23 Apr 2026 17:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="B3syFKNO"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazolkn19011003.outbound.protection.outlook.com [52.103.1.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF0CE42AA6;
	Thu, 23 Apr 2026 17:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.1.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776966009; cv=fail; b=YkVn0dyILYyw8oDwcxTqenXUhkVQXK1yCalH/OtzN1rqAJhyqYoYYdbdsyMgJX6g/4nQ6stAiT4Va5DwcxgbD1eBYLOZVHJYzmZnA8QyKSTn7eUJ6hMBNJ/WC6AAEusB8kv9HdrB2LMhXkTp7+B/DxrQQlDUXrH3rfr3w82if4o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776966009; c=relaxed/simple;
	bh=Ox+GJAdd05hgMhyjRF3/BXEmnGK9qblYafrvvVpv5AA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=flaf9U/VlkOO/gXNdF+0GbVmSe+g0nQD8k2zRuAiBHGEzLxtrwpMnBMl5hFtjRSrV3oTSj+7Hjj2MYb7Q/nlPe3zbHqdztoO6EEprfphgQbwYE+WSdEpq6/drsywjrCV9I2JNx3efe8z2TVzmY/kJRiifx1NYhIFwNLTjDQmsDE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=B3syFKNO; arc=fail smtp.client-ip=52.103.1.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r27NWfMwPppxTTDrcOEL5DOOJvwI1vYWAXEoSnzNkbkgl2mSsFefyppPaWKdp81rz95kCEDA42WaTs7qjtQozWiGwafWTkOV5b41cTv4u5H4pHiCRQxtuLgyLROi4ZqNV3CgyQabXUh1AGuIe5oogj66OXufGmNU/aIvr/eVTRvc8kvWKfQraZFYiP/p+HsydOhMNma+pKx4wP0rfAGCPSp0dR49v9LIzWES5Anizp0D5d4WxwASuT88gzJZh5LamNImdOUfSVpCat5R7DzG+sIWk4DQmkpC5nYb6v3zz4TKrzbPVs23mIjxO2fgEIPZbDSxJkAO4h5ZGTG4qBq0Yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oDOs8ZVTEbfPYCAKLT0KzWGkFgpZGlkzliwXrLdn7bM=;
 b=hw1fYOzm/0z0X7BOap34LgtCzarvP9Yp6BFCmXYUIXaEc9kOWYW1HnxaBueZAn/jgHhQ0lyG11/H7SxZ/g3jJuw60prKRmmLFuKethPRFeRLgfBE1u54SZ98nXLB7tTJXjHLlpRALKpucDXld0/tdy2fBBFk9nlm3nXfBTjgfCOsD+oyo78OR/QlBefOcsUdkjpgDwRZLgSG/5OZy1LwcCQ5ixFapOOTmEpXHMwMAKFOyeg+k23yX9XAajJVqYqy7r+UptBA79Q840KoXnAcMr3JCQcvp1heu/t8Qk1pVD+2Na5EDhXQ36S830WCFUxixpTgdnSogSrw1rN9dgVpMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oDOs8ZVTEbfPYCAKLT0KzWGkFgpZGlkzliwXrLdn7bM=;
 b=B3syFKNOxSGMaJrxQMfifQ8cw/NEygJmD78Sn37D4Ldy4SKAJ35bJNd3UvCboMbpHLL4kzuYsjuRCyZ2cpfSSJsYYAuxZAPyEn95P3cNpAXbLA5drmliUxr+gZ1DpW1X28Bv7vtEeBSjYHBOyzOqgTpLZQKUTsLux7QtYbq9BUgyl6L7Ussfb/ZqPaaYwJbgclZwduEuIcqWXbMob1Nk16+iY5jTGlzKSjhcZUUcqTeXyoPxsFX2P0P7bYJxef4b18bb814FwzH9b44F2ctPDsSi7/BheK1FykZC98tDzSlC3YMaHvnpYg5PBMoydooEvQt/D7zqWgbNOAF0JbV3Eg==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by BY5PR02MB6674.namprd02.prod.outlook.com (2603:10b6:a03:202::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.21; Thu, 23 Apr
 2026 17:40:04 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6%6]) with mapi id 15.20.9846.021; Thu, 23 Apr 2026
 17:40:04 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Dexuan Cui <DECUI@microsoft.com>, Michael Kelley <mhklinux@outlook.com>,
	KY Srinivasan <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>, Long Li <longli@microsoft.com>,
	"lpieralisi@kernel.org" <lpieralisi@kernel.org>, "kwilczynski@kernel.org"
	<kwilczynski@kernel.org>, "mani@kernel.org" <mani@kernel.org>,
	"robh@kernel.org" <robh@kernel.org>, "bhelgaas@google.com"
	<bhelgaas@google.com>, Jake Oshins <jakeo@microsoft.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"matthew.ruffell@canonical.com" <matthew.ruffell@canonical.com>,
	"kjlx@templeofstupid.com" <kjlx@templeofstupid.com>
CC: Krister Johansen <johansen@templeofstupid.com>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: RE: [PATCH v2] PCI: hv: Allocate MMIO from above 4GB for the config
 window
Thread-Topic: [PATCH v2] PCI: hv: Allocate MMIO from above 4GB for the config
 window
Thread-Index: AQHcwvqZ7/kLR2JkdUmudlv9HY41bLXRHh0QgAOgeDCAAHmtkIAKqeRQgA0oSLA=
Date: Thu, 23 Apr 2026 17:40:04 +0000
Message-ID:
 <SN6PR02MB4157D5BAFAE2134276241FFED42A2@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20260402234313.2490779-1-decui@microsoft.com>
 <SN6PR02MB415794E53D2B621F6A8BA382D45CA@SN6PR02MB4157.namprd02.prod.outlook.com>
 <SA1PR21MB69215C164B06109C6682984EBF5BA@SA1PR21MB6921.namprd21.prod.outlook.com>
 <SN6PR02MB4157D5C8EE35A221B130FC5AD45BA@SN6PR02MB4157.namprd02.prod.outlook.com>
 <SA1PR21MB69218F955B62DFF62E3E88D2BF222@SA1PR21MB6921.namprd21.prod.outlook.com>
In-Reply-To:
 <SA1PR21MB69218F955B62DFF62E3E88D2BF222@SA1PR21MB6921.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|BY5PR02MB6674:EE_
x-ms-office365-filtering-correlation-id: 6d65665d-df9c-412d-b56e-08dea15f5a56
x-microsoft-antispam:
 BCL:0;ARA:14566002|15080799012|19110799012|8060799015|461199028|37011999003|8062599012|31061999003|41001999006|19101099003|55001999006|51005399006|13091999003|3412199025|440099028|102099032|40105399003|1710799026;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?bSKW0Zxpl2GrnkHZqWlS4uhdezhYzJ8CTQhl1NT6zk7lpnOmfwDxraSGvq6N?=
 =?us-ascii?Q?N3MNyLgLyD3aLIpmSQq/v7stgb5tqLqdZWO5WgyW0WrHl3FjqtisrZu/aDk5?=
 =?us-ascii?Q?5CXa5gWqg1d0J0CASzRMDqKr0pCMF5HBaBnlus75tin3pzCagVcII82sBLJO?=
 =?us-ascii?Q?+tlqHYcBG1FdzaSiJfz0dTssvByeKRRg+6ZTeXUGkspPdxeAQSCqQrcVYw5E?=
 =?us-ascii?Q?+oAk4ydRvhEuPviMmdUMzTDAUebOYtdoEty+m37gdGsmpm/VGdggnABug6/s?=
 =?us-ascii?Q?XimgjPTMKLxeEcyFiz9HLQGI4AWgw6nXaU8kflboTaY/9tZORWQAsU5jtvNG?=
 =?us-ascii?Q?Z8m5rd8zuH3IABF9LGaAVSzuAOi09/mBmKdI7c8BNqrZUccxd4xg+Rm4r7ND?=
 =?us-ascii?Q?nQox0dxaMpTCncP74nz55oSqn4kT/3OVFx/IhKrx3SFNMx7h/XwLXZ6+vOxS?=
 =?us-ascii?Q?7EiIHjjR2Zoe3YHyUjwbeqf/uU+9XMy3hDh+4nhtPD/Ds7oPUjIRi0vPmYmh?=
 =?us-ascii?Q?v5JevKsyxMY92KWqRmdeOn0DXMlXoMZ6kUQ4z6ChLECSgvs5iLxkCnNwEWD0?=
 =?us-ascii?Q?Vm06CRojOymZ4gqd94zR0iRAJD2hLHhSeMbgN0cfa2MDZMnJ/pCzydwKpirP?=
 =?us-ascii?Q?nfJdHSuP7db+1i4XWyftSEI3xWwJ0JCHhPFZ2I6X4OFoRYZydyAZu7UoV4a8?=
 =?us-ascii?Q?SqNnGK/2gD8lDSOJe16OX4aAa7hD4GKFJgiwsPtmcX0EeCrwqC+ZYVTrOMBX?=
 =?us-ascii?Q?IoVkTOCCFToNC6WwXcSFixMO2zJ/0pYMBrFmG6xhaAdOiwhlRSZcl9r6UtR7?=
 =?us-ascii?Q?+IhQk6NjTpggs8TR/tdiE9++1S3uGaIjwEJKXlhtCRzQaDU74YXv/03T/0/Q?=
 =?us-ascii?Q?GzbL9ndxiDAe2koF/1k3z8PSyfkc87VahyAEN+qHSWn/TLp5fPBYqXVu9VK8?=
 =?us-ascii?Q?08F/8BzmdwyxJpwRphy5GmqL+433/slK3iKsfLltMSUXsSfMFSCINPIK+Z4W?=
 =?us-ascii?Q?wSIVIbQj6J5BVKBTCcrc0L3g1kR9RIDjCKHj1Z6/dth2/9qmVkRLpaDLHgUG?=
 =?us-ascii?Q?zM6XNlJUhxesm/y/uVUqIvHwk3KFJA=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?zVzsa8X0CGw0hfTe70F+FwkGnmk6bxrA6j+0Ip0+9xkYuP5BB6pycnf5A/Tv?=
 =?us-ascii?Q?hirFDNkAEhyhiiHH3v129e38RWMY4hNWr8iT5NJLWt5sTF+u8rLYMXBDdIaW?=
 =?us-ascii?Q?psdPnrMUm+Cq3Jy1a5zFNzBUi1s9s8g1PSl+OeiYB6IdJRDvO2e+6qDHQACO?=
 =?us-ascii?Q?RRO97sNFURTa0hCUQJJDVbf6yYOBtXYvxcYw+JM5UBmydAVb7zmX7IH5l9LG?=
 =?us-ascii?Q?UonrPXnrGvae2MlleJVGrcpDwZWccOUrRR3ZTlBXzkfGpxJCYEKlQLKH6/qb?=
 =?us-ascii?Q?vvaxvT4UkUe3T1x2jyUVNm1qvlkm6LzbbM2VRzrfcNcs0xgeVPALxQmEAcqz?=
 =?us-ascii?Q?+GuWb0hWjqC0iSM9xRnVx6ziuCp2KqA5iE8aJxPLs4YK8d9EgZS17IKv5fVB?=
 =?us-ascii?Q?tsi5nFtnlWEusBzmK/8LdikiTEf3Fro0D7WJyCIhok98Wve/FI1uayov8pYj?=
 =?us-ascii?Q?hSKW06DaldD+SnrrsvoMMZLULxvsXfs9tUdtuc2F14z4KoxxWpxupcngBvSG?=
 =?us-ascii?Q?Gbu6t9RDAoxUC3a4pskn2GZRe/3IAVrpY/8sdzssGMJG/HRmG9BaTlOZJ8jN?=
 =?us-ascii?Q?mjy+JrWBnlwnAkDcbsrDeVvTYYsD+iX9wi6YZMZfW9+uA2vXVM+U9NNbodfB?=
 =?us-ascii?Q?AYQg+7qgGv/s/RrcRPD/dWANtQZWQuq09uiqe+O74GeRJK13DwtUJPxRpXHg?=
 =?us-ascii?Q?ll80MFzpZ4wuk0YYIuod1it/mulGyfWl4D9pbl/NLBZGqeOdw6W1QQxVq9Lp?=
 =?us-ascii?Q?NIivVSL3nV/EU8jY9dta78AxCI2uhFmljvLMdRAd9A/oaIQEbOpLPeCLGKrS?=
 =?us-ascii?Q?S44Zc9duGOKsBM6TZYPnWgldVATbXiQRwDoOrzFel0PCklMIo3P2FGFacJj3?=
 =?us-ascii?Q?o1SeKIhGW4Zwp+T95UTH46ClJqXHX7HfUTP83INJ7B5h4WMiRXyAFgSKAkRn?=
 =?us-ascii?Q?UwJZni8Dd6I5UfsmcA7/1BmUkXw4vOH+6oh6Pv9JzFl+9uJW+WAxwDb+x0ad?=
 =?us-ascii?Q?NI5rUZNFcCpsGfdaYdajg99XIsfGLWphG/UJ2JOH8iEu3oUaSXed9O56hLHw?=
 =?us-ascii?Q?4yNLRQfjVHmzwxThbgECY+iKf8xNlccdDwG9Il8gi3obrshzH+XXWhsMF7q1?=
 =?us-ascii?Q?0eFAzqw04RTMuvzhckkaRXt9zuInpMSXWcxiSeEUj89ky3zpq3Wk6GujwLiU?=
 =?us-ascii?Q?75gz+XCtP3xQPnC3Vb7pJ+A5FgZZ/ojEZvY9cVzNC2Ca6521fHf0UX669swO?=
 =?us-ascii?Q?9YGEFq9/8rsgvkytLAxCGjQDnODbszEgrFsIXatZVVSjQ3D6c3cHQ0Rt5GvH?=
 =?us-ascii?Q?GvA0f42POSZmmkX52V9ehfO9zIpt0RWgFxLMpDmZEFVabalBlwc2jwlLN4ca?=
 =?us-ascii?Q?4kPh6RM=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d65665d-df9c-412d-b56e-08dea15f5a56
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2026 17:40:04.2125
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR02MB6674
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[outlook.com,none];
	R_DKIM_ALLOW(-0.20)[outlook.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10349-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_FROM(0.00)[outlook.com];
	FREEMAIL_TO(0.00)[microsoft.com,outlook.com,kernel.org,google.com,vger.kernel.org,canonical.com,templeofstupid.com];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,SN6PR02MB4157.namprd02.prod.outlook.com:mid,outlook.com:dkim,outlook.com:email]
X-Rspamd-Queue-Id: 675AC455A87
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Dexuan Cui <DECUI@microsoft.com> Sent: Wednesday, April 15, 2026 8:31=
 AM
>=20
> > From: Michael Kelley <mhklinux@outlook.com> Sent: Wednesday, April 8, 2=
026 6:54 AM

[snip]

>=20
> Another example is: for a Gen2 VM with the below commands:
>    Set-VM -LowMemoryMappedIoSpace 1GB \
>           -VMName decui-u2204-gen2-fb
>    // i.e. the default setting on Azure. Let's ignore CVMs here.

FWIW, I'm seeing that in Gen2 VMs in Azure, the low_mmio_size
is 3 GiB. I'm looking at a D16ds_v5, and a D16lds_v6. The v5 VM
is newly created, while the v6 has been around for a few months.
In a CVM, the low_mmio_size should be 1 GiB. This overall example
is still correct -- it's just the comment that I have doubts about. Or
maybe you are looking at a different VM size that has a different
default?

Some years back, I had gotten into a discussion with Azure about
this size because the swiotlb memory wants to be allocated below
the 4 GiB line, and reserving 3 GiB for low mmio limited the size
of the swiotlb. CVMs were changed to have only 1 GiB for low
mmio because they need a larger swiotlb.


>    Set-VMVideo -VMName decui-u2204-gen2-fb \
>                -HorizontalResolution 4834 \
>                -VerticalResolution 3622 \
>                -ResolutionType Single
> we have:
>     max_fb_size =3D round_up_to_2MB(4834*3622*4) =3D 68 MB
>     excess_fb_size =3D 4MB
>     low_mmio_base =3D 4GB - 128MB - 4MB * 2
>                   =3D 4GB - 136 MB =3D 0xf7800000
>     but 4GB - target_low_mmio_size =3D 4GB - 1GB, which is
>     smaller than low_mmio_base, so low_mmio_base and
>     fb_mmio_base are both set to 4GB - 1GB =3D 0xc0000000,
>     and low_mmio_size =3D 1GB.
>     In this case, we'd like to reserve
>     min(low_mmio_size/2, 128MB) =3D 128MB for the framebuffer
>     mmio, since the max possible framebuffer so far is 128MB.
>=20
> ************************************
>=20
> On an ARM64 lab host, I also tested Gen2 VMs (there is no Gen1 VM
> for ARM VMs):
>=20
> By default:
>   low_mmio_base =3D 4GB - 512MB, i.e. 0xe0000000
>   low_mmio_size =3D 512MB
>   fb_mmio_base =3D low_mmio_base
>   The default framebuffer size is 3MB
>   (i.e. screen.lfb_size =3D 3MB) but hyperv_drm:
>   mmio_megabytes =3D 8 MB, which supports up to 1920 * 1080.
>=20
> With the below commands:
>    Set-VM -LowMemoryMappedIoSpace 512MB \
>           -VMName decui-u2204-gen2-fb
>    // the command only accepts a value between 512MB and 3.5GB.
>    Set-VMVideo -VMName decui-u2204-gen2-fb \
>                -HorizontalResolution 4834 \
>                -VerticalResolution 3622 \
>                -ResolutionType Single
> I thought we would have:
>     max_fb_size =3D round_up_to_2MB(4834*3622*4) =3D 68 MB
>     excess_fb_size =3D 4MB
>     low_mmio_base =3D 4GB - 512MB - 4MB * 2
>                   =3D 4GB - 520MB
>     fb_mmio_base =3D low_mmio_base
>     low_mmio_size =3D 4GB - low_mmio_base =3D 520MB
>=20
>     Since 4GB - target_low_mmio_size =3D 4GB - 512MB, which is
>     smaller than low_mmio_base, so low_mmio_base and
>     fb_mmio_base would be both set to 4GB - 520MB, and
>     low_mmio_size would be 520MB.
>=20
>     However, the actual result is:
>     max_fb_size is indeed 68MB.
>     but fb_mmio_base =3D low_mmio_base =3D 4GB - 512MB, and
>     low_mmio_size =3D 512MB, i.e. the 'excess_fb_size' is not
>     considered on ARM64!
>=20
>     In this case, we'd like to reserve
>     min(low_mmio_size/2, 128MB) =3D 128MB for the framebuffer
>     mmio, since the max possible framebuffer so far is 128MB.
>=20
> With the below command:
>    Set-VM -LowMemoryMappedIoSpace 3GB \
>           -VMName decui-u2204-gen2-fb
>    // i.e. the default setting on Azure. Unlike x86-64, an ARM64
>    // VM on Azure has 3GB of mmio below 4GB.

See my previous comment on the same topic. I think arm64
and x86/x64 are the same.

>    Set-VMVideo -VMName decui-u2204-gen2-fb \
>                -HorizontalResolution 4834 \
>                -VerticalResolution 3622 \
>                -ResolutionType Single
> we have:
>     max_fb_size =3D round_up_to_2MB(4834*3622*4) =3D 68 MB
>     low_mmio_base =3D 4GB - 3GB =3D 1GB =3D 0x40000000
>     low_mmio_size =3D 3GB
>     fb_mmio_base =3D low_mmio_base =3D 1GB
>=20
>     In this case, we'd like to reserve
>     min(low_mmio_size/2, 128MB) =3D 128MB for the framebuffer
>     mmio, since the max possible framebuffer so far is 128MB.
>=20
> ************************************
>=20
> To recap, I think the bottom line is:
>=20
> a) For Gen2 VMs, we can safely reserve a mmio range starting at
>    sysfb_primary_display.screen.lfb_base with a size of
>    min(low_mmio_size/2, 128MB).
>=20
>    If sysfb_primary_display.screen.lfb_base is 0, i.e. in the case
>    of kdump kernel, we use low_mmio_base instead.
>    This should fix the mmio conflict in the kdump kernel.
>=20
> b) For Gen1 VMs, let's still only reserve a mmio range starting at
>    4GB - 128MB with a size of 64MB, because when we are in
>    vmbus_reserve_fb(), we still don't know the exact size of the
>    max_fb_size, and we don't want to reserve too much as we would
>    want to reserve some low mmio space for PCI devices with 32-bit
>    BARs (if any).
>=20
>    If the user runs Set-VMVideo and needs a framebuffer size
>    bigger than 64MB (IMO this is not a typical scenario in
>    practice), we have to use high mmio for hyperv_drm in the first
>    kernel, and the kdump kernel still suffers from the mmio
>    conflict between hyperv_drm and hv_pci. We encourage Gen1 VM
>    users to upgrade to Gen2 VMs to resolve the issue. Anyway, the
>    mmio conflict is inevitable for Gen1 VMs, if the max required
>    framebuffer size is bigger than 108MB (Note:
>    128MB - VTPM_BASE_ADDRESS =3D 109.25, and the required framebuffer
>    size is always rounded up to 2MB).

Question about Gen 1 VMs: If the Linux frame buffer driver moves
the frame buffer somewhere other than the default location, and
then the VM does a kexec/kdump, what does the legacy PCI graphic
device BAR report as the frame buffer location? Does it *always*
report 4G-128MB, or does it report the new location? I can run
an experiment to find out, but maybe you've already done so and
not reported that detail here.

Michael

