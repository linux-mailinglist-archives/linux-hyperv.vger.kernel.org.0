Return-Path: <linux-hyperv+bounces-9444-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UGveFQ46uGmpagEAu9opvQ
	(envelope-from <linux-hyperv+bounces-9444-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Mon, 16 Mar 2026 18:12:46 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CC6729DE5D
	for <lists+linux-hyperv@lfdr.de>; Mon, 16 Mar 2026 18:12:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 77772300B297
	for <lists+linux-hyperv@lfdr.de>; Mon, 16 Mar 2026 17:11:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8CBB3BA253;
	Mon, 16 Mar 2026 17:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="af4qjm0K"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azolkn19010022.outbound.protection.outlook.com [52.103.12.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EAFD396B8B;
	Mon, 16 Mar 2026 17:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.12.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773681090; cv=fail; b=XwfuVh0oczdN8dV6p8O8eIx08faYgjnZmugMc1+3OubTWtcuVBNfke4fpXOgrr9Z5/uEMmY96d2FjWJeAY3tpj79J4UO+84czhwTFL+LwdLTU3/WsCwEhZ/p+va5kccj/8GmD2Cji3+/MI5VyIouIM1VC3ITvBGBZmYLehb8rvA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773681090; c=relaxed/simple;
	bh=W4GXS2iyIl6VjtQtBDPG3xLl+uSunGvgi7Fc30lwBLE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Sa/lXNBoGlXBmyixE6Nw+D9oeUNAVHJZndWhm1pZoRs9/H2Hqr8i/VHaRdTNS4jv8z8ViaxBRu0KZdT3Q42xeUNRg/EnAODAgRGy7lTrZArxmF7HDS3NIjWKOovBZ2kqfN3SIZExXhrT4PU7drvU32waDCPHFlInptsRQRVa2sA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=af4qjm0K; arc=fail smtp.client-ip=52.103.12.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WhDR//ecNyj8A1LK3m4CK+E/oO1+heMxXvzKyEBRxwhlDobWPFrkNiT02cSASD4iwzPh9uq/8Xr2IMOYtS97LZTokNYgUWbXlH1+ijXWUJviROoDBci5sIyJIvGhF3GmeySuQQPrcCizPkWEVSgi49xz/7CW40OMT3Uj7u91LlQs8Nccv4tKATVJXvScbj51bNMmWqkmFlMmRmUaqfMh4Vpa/Ul4SxUK/b3XUeE+iHgZWJjnvIaQ0DnyubY1Vv90hFLWJp8dOLiUppj+yUAzvM4dLHReAAQZcNG/QfE1j07Z90USQXCgsBAPhRWRNZxdq+Gauv/OdFJ6PKhAGEUsQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nh+VA5QPjE5rvvitGutArzgAk3hxAKTQO7hcORQNAro=;
 b=LXTx1VDeqvZ+YeGIg9oo9c90NXnZkWWGFzK+KF65N/QphnCxoP/YSst6+OxzAiunAL02R4s+7tWhWkvyVjqdKo97TkHQCmGqgId2GIv5z9CLE33SLIcARavzeVknBEzQpZsOZpTN8O0aNVqtARfB6ENksDqbRIC1IT4k4VmEv9ZktvGEZU3Wyu8AUdJIFu/AvMzqY/w0ec635tfgD+cg9ANIXLnTCtVR6jVyBxlphlSLrAygpl1cN8MBTYDn7e8j+cYmv2cwWouRuHCuI+KIsk/9U65el4A5vSqPpH5qH+3q1gFLmkGvmsNbx7h4erdc8ZKAEPMppptcGHNRrpwQow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nh+VA5QPjE5rvvitGutArzgAk3hxAKTQO7hcORQNAro=;
 b=af4qjm0KyIO9F24ZZJKW0hRVg7um/DxzqfL0nSXl/SSVbGGDUyrK6r8q4qJrYMgvH3g1A8Jv7kwyQDL+gvMQdsH0PxjAQe+IBN0pu5vnp6DzAeI6/gVO1VBCSIpP3CHLGFuID6tp61BeeVoCxXRvZCpnuMt1HVMzWJ75I3/jIvkxKrUz7n/LCtvuMRM7sM/BmYvJXLMC1nySN/2qEzxcE8ZZidRbyRsv3s2BzTxor6A+qsmlMbrTy9ANeqrb0T9aBoa2v+0HmU79nLHyl7yrCRf45jS0mGyc5BAQgIdy+NSwCdQwhEss/0jkVOf545e9bsKj4o8aBY2FNWAjsMp8Jw==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by CH4PR02MB10681.namprd02.prod.outlook.com (2603:10b6:610:246::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.24; Mon, 16 Mar
 2026 17:11:26 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6%6]) with mapi id 15.20.9700.024; Mon, 16 Mar 2026
 17:11:26 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Long Li <longli@microsoft.com>, "K . Y . Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan
 Cui <decui@microsoft.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?iso-8859-2?Q?Krzysztof_Wilczy=F1ski?= <kwilczynski@kernel.org>, Manivannan
 Sadhasivam <mani@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
CC: Rob Herring <robh@kernel.org>, Michael Kelley <mikelley@microsoft.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] PCI: hv: Set default NUMA node to 0 for devices without
 affinity info
Thread-Topic: [PATCH] PCI: hv: Set default NUMA node to 0 for devices without
 affinity info
Thread-Index: AQGzcdRLNO2QZSbCibyDMDhroeyPibYBl7IA
Date: Mon, 16 Mar 2026 17:11:25 +0000
Message-ID:
 <SN6PR02MB415748A42DCBDD8AB635838DD440A@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20260312223244.1006305-1-longli@microsoft.com>
In-Reply-To: <20260312223244.1006305-1-longli@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|CH4PR02MB10681:EE_
x-ms-office365-filtering-correlation-id: 57e6e6b6-11f2-422d-e9b8-08de837f0e92
x-microsoft-antispam:
 BCL:0;ARA:14566002|15080799012|31061999003|12121999013|461199028|13091999003|37011999003|8060799015|19110799012|8062599012|41001999006|440099028|3412199025|102099032|52005399003|40105399003;
x-microsoft-antispam-message-info:
 =?iso-8859-2?Q?tLR6U4KDThXixiqoqaV5a86UDXRjfL1W0AHHhQ397SPgIZtvlitdxdXawB?=
 =?iso-8859-2?Q?yX3fG+tdHAm++m1YDxVPDweBcs7qiEGAPzbpZl0VhlvIXi5L+fRaj1CJoH?=
 =?iso-8859-2?Q?odp9jM2vP6V6PgSHhApj1A6iOkV6h3mTBVliLA8wCl4/YtMBBAEX2MLWif?=
 =?iso-8859-2?Q?OTouCudL+kjsWHUX+moUkj8RFCaAZlBIapxdDupbkou138j33VS/Gs11eZ?=
 =?iso-8859-2?Q?rnTemkC5CYP57XJ9pzpw9rzQPor32WCBMC3F7F2xTntTlQBA+6Ew+UgNoS?=
 =?iso-8859-2?Q?65o1vd9ZVJSNS/M33XM1yHSy5aKS8G0owXLf68Shz64Ze+fJYrHDZ/vlSP?=
 =?iso-8859-2?Q?EQmnClvrYohr35qFkrb9PBnhvSeSSpZyRZXufv2MQ8SJ13BN/uQIHisy++?=
 =?iso-8859-2?Q?xLAZiWqdmLU2kyg+WmWPn+hAHgPzWmIASmoOH5uiWsq02ncMeAz3/zYDpt?=
 =?iso-8859-2?Q?klHsajQjsIILQqbY9Z3ssz9v3nPY8M2OW7V37lS3yEndzZ2/tsi8TOJk+c?=
 =?iso-8859-2?Q?m99Oo6vYrz9IrKORQ/ZS5CZ55f9BpnXP2W2j6xScDab1AgTrYR1R1JyKxu?=
 =?iso-8859-2?Q?61ZsVQ01qANvRd4YD+WB04HMuGt3NCnpmWwNITltMnoqpHCjH0G12dbzAy?=
 =?iso-8859-2?Q?RntkI8Sudaq5OUcc6SZUEXDKGlGTmMcsuaronxklj48SMvS9/pP3Kh6r1a?=
 =?iso-8859-2?Q?gdehkZAlpvoPeb8G7naVfQwMGzYrRee8Vj2KeQ2VfF4D0vCzF/KgM1qcTD?=
 =?iso-8859-2?Q?1BrZjDj7NOj5ZYRahWWPa/MjStHt7NkopGJrs2hqecLS+EQsln7iFcGq/5?=
 =?iso-8859-2?Q?0mJ6JqcH6vW1nT823k++ldghtVfLZTd8JPeY6o5pMpSEP0tHAI8kFOwHbf?=
 =?iso-8859-2?Q?TmSUiwJw1KjqORtSjj2SJiqoOmq3rnN7a4Pr1fKcUJMqeb86f/c3TrZT4e?=
 =?iso-8859-2?Q?GhXbi1Q0c3N8r52VnoMVUKK78mUUcs69ur2aR2gDL5zt18W/6Bbe/Mp2Cy?=
 =?iso-8859-2?Q?y6vHaJS0iAcRxpDZ7CesREbW6TFMhb5SaBYi9t7SSt1Uc/QNoJHDYoHn6w?=
 =?iso-8859-2?Q?ObjNKSHgPBUty3uc6WwA3Lw=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-2?Q?9X8ElHHs1qdcT09EqsxyhGOZLMWZcfN9RxYGws8vBlbbZGItnbgGD+yhWt?=
 =?iso-8859-2?Q?bXuiil48iSlgT/tuueodbkYyon2vG++11btsve5kMx1XqDSSc+EQ4VmvEJ?=
 =?iso-8859-2?Q?GO7bqLtZY5bdQ8wn8VdFGzOvwfnhS1lZLb4dMWyyS2602T5wtmq8KFwqN7?=
 =?iso-8859-2?Q?v/NQDGtjw+2yjIoT5htuKO2r7ONECe69mjEBooAHg0o1JpL3IJ9ZvJf+87?=
 =?iso-8859-2?Q?LkK3tEhoS2gSltL6+CZGSt+4K0BYBlvO5xtlFoYI2FYANVXz40OcHcYMGc?=
 =?iso-8859-2?Q?eClr4jsfKK+dLXY57GQ9JndxhVbMRIOtiyw9lL38u/EUR+PKZ05BaOzVTc?=
 =?iso-8859-2?Q?W9/Z6V0D9Kc0QBIAzVyvt+6Xxskjl9rYiPQEoLRAa9r2kGM48bXPklHDnJ?=
 =?iso-8859-2?Q?Ri0ALsiqIiO6BO7d5GYPCNZjwyq2IT5Xy68jeCM0n3bdA0nir8WeMEtzVW?=
 =?iso-8859-2?Q?81Fptfg0DvDnJesBDo6SEYTyfztgvJ26+uXXIwjk53Lvt2j3kheeWqFyLM?=
 =?iso-8859-2?Q?9UxpnyjSn0hFCNS5GTkX3WZNVlsA3UMKk77oQ9H1xEczk8j9mj3aARGAxA?=
 =?iso-8859-2?Q?+Ith7cFzhS/YKAfqZ2PvOQsSqEDc5DzXP0CFWshYTzGzssJgHODEfgCWOa?=
 =?iso-8859-2?Q?rzKDNZJQiZAjM20+XV17myKF11Qf6je54sONPjGgLAtVSrHaGtqzRltGtn?=
 =?iso-8859-2?Q?OikDPADbVtzXqSk59VYCgKfWFCUOrVEDo8O20AQeZsto3Q3IiL4HbLg2bi?=
 =?iso-8859-2?Q?gKbCCR0BSZ/fq2pCWQGFfmOvEruP2PxG58BCrd9panem3n7OtZQbgo4Ti3?=
 =?iso-8859-2?Q?lgQIq9y4d3SKzDo7Itda49NUp8HDdE2GN+ctGJUeC421zFUwiZbnNdQ0LW?=
 =?iso-8859-2?Q?cq52exW+xUXlWbkIKCqsM8ZOVwhV+u6oAdSKvKaCwKo9Dv35EDq/eH0ZrV?=
 =?iso-8859-2?Q?WT30oeaQNmOdfmGLQUa0Bx3DNvzyXyQ5vrVzhp+FD9/478SE6RORDnQ78K?=
 =?iso-8859-2?Q?CemVO5vhiU4k9yKdFDqBJEJUdIZzk0QI6LNFMs581hNT8o08bgnX67vMg4?=
 =?iso-8859-2?Q?CaUOoTgSWwF8uOSB7pi3DLLZU+RXI/KuQF2bkrhOMuGVqfsndH+tz2mEqR?=
 =?iso-8859-2?Q?hoZsHLiURXv8k7RMFOocTu/tVqrtqwSMjTr1WwY8YZh7Tf4REMVU6r0YUh?=
 =?iso-8859-2?Q?DuRv1cdIgdKymsOMp283+iBwdbZsjK5Jo69Oi/KFq9FItZrOHh6nrYR27c?=
 =?iso-8859-2?Q?F4n18DRaszGx8g43qmQoYPKdrpHvfwamHs6EbyP2RToYmCoJpsq7mySqVS?=
 =?iso-8859-2?Q?1ZHjettxz5FqVA481ERqpoHSjklMj+43/lvCNM+eurrcMtMOFoXUWxGwYb?=
 =?iso-8859-2?Q?uNmQXeBQy06JtpMll9u+a+2UzcluBVHQ3ODmLvE+MKKC0TlaYl/Fk=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 57e6e6b6-11f2-422d-e9b8-08de837f0e92
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Mar 2026 17:11:26.1695
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH4PR02MB10681
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[outlook.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[outlook.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9444-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_FROM(0.00)[outlook.com];
	RCPT_COUNT_TWELVE(0.00)[14];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-hyperv];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,outlook.com:dkim,SN6PR02MB4157.namprd02.prod.outlook.com:mid]
X-Rspamd-Queue-Id: 5CC6729DE5D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Long Li <longli@microsoft.com> Sent: Thursday, March 12, 2026 3:33 PM
>=20
> When a Hyper-V PCI device does not have
> HV_PCI_DEVICE_FLAG_NUMA_AFFINITY set or has an out-of-range
> virtual_numa_node, hv_pci_assign_numa_node() leaves the device
> NUMA node unset. On x86_64, the default NUMA node happens to be
> 0, but on ARM64 it is NUMA_NO_NODE (-1), leading to inconsistent
> behavior across architectures.
>=20
> In Azure, when no NUMA information is available from the host,
> devices perform best when assigned to node 0. Set the device NUMA
> node to 0 unconditionally before the conditional NUMA affinity
> check, so that devices always get a valid default and behavior is
> consistent on both x86_64 and ARM64.

I'm wondering if this is the right overall approach to the inconsistency.
Arguably, the arm64 value of NUMA_NO_NODE is more correct when the
Hyper-V host has not provided any NUMA information to the guest. Maybe
the x86/x64 side should be changed to default to NUMA_NO_NODE when
there's no NUMA information provided.

The observed x86/x64 default of NUMA node 0 does not come from x86/x64
architecture specific PCI code. It's a Hyper-V specific behavior due to how
hv_pci_probe() allocates the struct hv_pcibus_device, with its embedded
struct pci_sysdata. That struct pci_sysdata has a "node" field that the x86=
/x64
__pcibus_to_node() function accesses when called from pci_device_add().
If hv_pci_probe() were to initialize that "node" field to NUMA_NO_NODE at
the same time that it sets the "domain" field, x86/x64 guests on Hyper-V
would see the PCI device NUMA node default to NUMA_NO_NODE like on
arm64. The current behavior of letting the sysdata "node" field stay zero
as allocated might just be an historical oversight that no one noticed.

Are there any observed problems on arm64 with the default being
NUMA_NO_NODE? If there are such problems, they should be fixed
separately since that case needs to work for a kernel built with
CONFIG_NUMA=3Dn. pcibus_to_node() will return NUMA_NO_NODE,
making the default on x86/x64 be NUMA_NO_NODE as well.

I've tested setting sysdata->node to NUMA_NO_NODE in hv_pci_probe(),
and didn't see any obviously problems in an x86/x64 Azure VM with a
MANA VF and multiple NVMe pass-thru devices. The NUMA node
reported in /sys for these PCI devices is indeed NUMA_NO_NODE.
But maybe there's some other issue that I'm not aware of.

Michael

>=20
> Fixes: 999dd956d838 ("PCI: hv: Add support for protocol 1.3 and support P=
CI_BUS_RELATIONS2")
> Signed-off-by: Long Li <longli@microsoft.com>
> ---
>  drivers/pci/controller/pci-hyperv.c | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller=
/pci-hyperv.c
> index 2c7a406b4ba8..5c03b6e4cdab 100644
> --- a/drivers/pci/controller/pci-hyperv.c
> +++ b/drivers/pci/controller/pci-hyperv.c
> @@ -2485,6 +2485,9 @@ static void hv_pci_assign_numa_node(struct hv_pcibu=
s_device *hbus)
>  		if (!hv_dev)
>  			continue;
>=20
> +		/* Default to node 0 for consistent behavior across architectures */
> +		set_dev_node(&dev->dev, 0);
> +
>  		if (hv_dev->desc.flags & HV_PCI_DEVICE_FLAG_NUMA_AFFINITY &&
>  		    hv_dev->desc.virtual_numa_node < num_possible_nodes())
>  			/*
> --
> 2.43.0
>=20


