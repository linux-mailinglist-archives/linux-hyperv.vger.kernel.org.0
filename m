Return-Path: <linux-hyperv+bounces-10479-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MJiWKKVH8mmTpQEAu9opvQ
	(envelope-from <linux-hyperv+bounces-10479-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 29 Apr 2026 20:02:13 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 478924987F8
	for <lists+linux-hyperv@lfdr.de>; Wed, 29 Apr 2026 20:02:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7C27E301B907
	for <lists+linux-hyperv@lfdr.de>; Wed, 29 Apr 2026 18:01:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FBF83FE357;
	Wed, 29 Apr 2026 18:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="tM4xCKil"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazolkn19010072.outbound.protection.outlook.com [52.103.2.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4327334EEF1;
	Wed, 29 Apr 2026 18:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.2.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777485714; cv=fail; b=NLYAUpTJ4dOFXftrweEgINHqbGArKTwNUX+c9DRclMAYAiBfuD7ihaINxCvpv+W0J+crrdbgmu3B1dyyF+IBIqc6tuv33YiUJtGmUijVU6qeqLxMdkdqqqe/zBS7XGDoZLWbNi+zLw76QKjK9BhzSFXj9aFmAxao1C6/3wwG1Sw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777485714; c=relaxed/simple;
	bh=Yi7MOQdwTs9NKtOkX74QYFq3quzFmztTKQuHOaSNIu8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=AeRdaqpvt0R+6KODFKwYC0y6oGgpCo7BxWJay44LgvWigwtG8/uIITXYEMBvlTuAWopH6DcqiibpyNB16fcpn3QexI+Rd9iEE4jJ52mSFRnyeWpgrVMNIqH34b0eL2UJRtEU00I+rDUvsLZ0j3FroPfHi9l/WZLYzf09RmzPE9Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=tM4xCKil; arc=fail smtp.client-ip=52.103.2.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DxfsPGO9Jt5MTEgMKnB6yjpmJrZcOVD3oOF6jrTHKsJ0NFTBtHcEJBrirVqIdlMQ31DuZLySc4iN8CT34pMZxgd9m+BcTI/QZvWoXqy10EcUrVNHDdP8MUHC6rlLdOOLjB+yoZczghrKJ/TuWEU9LBs9tFEXRLpCGSjl7Ya6Cy9rlgneHFWChjNOTU1jCKylgYOL/lek084UztYInarVtWp+uBLFYJWDvtYvz9B8eotqNnVM4F3+3pHPUyzKnibUAHHxQ1w9am/b/+aZtWvPMKYXaFnnIVogUfbSEfFbwMmNca/mMm3MU9fUEcqXU1v9emYm0Kz47gLr5TcTXitrbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WvW1EoQtel0Z4Kbz3JQKUlZ1IfZwy/Pard2prmBWiFw=;
 b=kWFuO+wJL2NTV4zFu5gXUvVyHos+e6qZ+sL9HqY37eGbv7JaTjD0vU+ZaESvWagthY6JxVTKx8ak68vV29tx20pNov99UILEUAwI9Lm/EO9R1wYQNpMKGuQhiRlXDUwdWd7Dgtb3JcgBHLgjSoGIVxXRy9OMuMvMJUuf6XFbLfzifY8E+jB/XxsDhdfaMMoj/wW3+u3c1GTFxJna+HKS0hbzcwX0I78IGa34QNZU9K1Kw0RQ55k2Vpq0CqX74QSqG9OLt6RN2BMiuVKLSL+YykZe5DLglOPfTEpn2wTrtF0AyzdzS+1CJ2/Ywhe+DjO3I0WEeziwYiXGg8xcPGTZsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WvW1EoQtel0Z4Kbz3JQKUlZ1IfZwy/Pard2prmBWiFw=;
 b=tM4xCKil+Yc7Y9Xnk0bVD0zxMZoOezFNuTBYWisdbitXwxkfHWa2UBjY8Wr9oeQhFJwuW1J0F7/UHWGJS83noO9vZfLcqUKbrzy2e3jzSRgLpEKy4Cy3SHo0MZgjoN8atLJfYyRoOx/30fA0WzG0lRkLPAN0f4Ozu1D+vns9XQ1lkaCCvZca6gtIPnTW7k8jOtlcvBIWg5wysvzmnCI0BnjVcZK1sFDDMEiUXVj0l4WrSYLy8KdDvk1SfTUa29Qbq/pdMtk8NDAhRQWk9yHPx8stuQ0ta50fIGKZM+2qXkef2c2sJqIFq8Pu1QnUYvB11w4QoXb4VrjGgjriDt0lmg==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by DM4PR02MB9008.namprd02.prod.outlook.com (2603:10b6:8:b7::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.28; Wed, 29 Apr
 2026 18:01:50 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6%6]) with mapi id 15.20.9870.016; Wed, 29 Apr 2026
 18:01:50 +0000
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
Thread-Index:
 AQHcwvqZ7/kLR2JkdUmudlv9HY41bLXRHh0QgAOgeDCAAHmtkIAKqeRQgA0oSLCACEewkIABLGxw
Date: Wed, 29 Apr 2026 18:01:50 +0000
Message-ID:
 <SN6PR02MB415736AB356EE347B9B5C7DDD4342@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20260402234313.2490779-1-decui@microsoft.com>
 <SN6PR02MB415794E53D2B621F6A8BA382D45CA@SN6PR02MB4157.namprd02.prod.outlook.com>
 <SA1PR21MB69215C164B06109C6682984EBF5BA@SA1PR21MB6921.namprd21.prod.outlook.com>
 <SN6PR02MB4157D5C8EE35A221B130FC5AD45BA@SN6PR02MB4157.namprd02.prod.outlook.com>
 <SA1PR21MB69218F955B62DFF62E3E88D2BF222@SA1PR21MB6921.namprd21.prod.outlook.com>
 <SN6PR02MB4157D5BAFAE2134276241FFED42A2@SN6PR02MB4157.namprd02.prod.outlook.com>
 <SA1PR21MB69213486F821CA5A2C793C81BF342@SA1PR21MB6921.namprd21.prod.outlook.com>
In-Reply-To:
 <SA1PR21MB69213486F821CA5A2C793C81BF342@SA1PR21MB6921.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|DM4PR02MB9008:EE_
x-ms-office365-filtering-correlation-id: c0c7733b-c93a-4874-8806-08dea6196336
x-microsoft-antispam:
 BCL:0;ARA:14566002|461199028|8062599012|15080799012|19110799012|8060799015|37011999003|19101099003|31061999003|51005399006|55001999006|13091999003|440099028|3412199025|102099032|40105399003|1710799026;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?3zJnCou/5EkPCu8+k/2D36Ch0AX3J+IIFxIM6xKAl1AIPdvG+sD1ogmVNAp6?=
 =?us-ascii?Q?bg0n2Opdl7ro4c79qpGeBqtE1graFOB/fWptCVWoH8UBt6P4HlnoCI7vk2d8?=
 =?us-ascii?Q?aWMeqE8CY05QKHNk5LBDxbKJyiwwLl8HVz1la6hpsrCSZQ4e9uM0iQtAhxoL?=
 =?us-ascii?Q?CCaJURxOhgPRDrpqegMVeL+pI1D0J5E6c1DbNnc4KUx3AKnp6m83y9fqBCE8?=
 =?us-ascii?Q?ouq9uU3iDeg688I9jf9CUpzeRjr7VbM4erGPH9Mjx69/SAXroqR19cXtmyaq?=
 =?us-ascii?Q?6ltJZgrxIi5fx972St8B/p8LYWA5/mSF8nSc9/Me974uuVLlseMe0e4Gzzbd?=
 =?us-ascii?Q?8MtDa38qldud/ovIiHrosIQkyX3KbgQInC7vVpvhC26Ezeko3FqLapmBNBr6?=
 =?us-ascii?Q?unDM1p05Sd+PWT3sQT1ss1jiA/FIEiXdIvSeR2lcLZYfFfblexcAgHHMey6k?=
 =?us-ascii?Q?1UDF3P2OtqL03C2MFrhNmKN4RQ9uCZ1fABzyzSzxmm58DnuAzsqTOWdYlXdo?=
 =?us-ascii?Q?eoVbSbhzJj9O7Q0V6cMly15sojRcwhh1PI4DKoKO92mC9B0Y5vx3DWWOmOx2?=
 =?us-ascii?Q?nVw9azf2y8uBLb+SPsv+AeEyB7Ir0CvTyhriIPL5MIV/+tjRbPZUykXtbqZt?=
 =?us-ascii?Q?9f0yppqHVOFBrABeGkTdqBhZNwD7EBSl0sbNxgkqk2cCAazn1H8KMQgEYMVI?=
 =?us-ascii?Q?zPhh38xgACGoNTONiLtofMR+F8NqM8KIQvQ2rHfjpYH/4yVJkHhmwLFDAHvG?=
 =?us-ascii?Q?o2yuJuUSGOL6ZQTQMVRzjSKCu9oTHU/u7D9NfuDpUJiTUSFBsLFMjkLftXub?=
 =?us-ascii?Q?vdtD4XAc0BRjl+rtxftni7a6n6QCWPamZJz16CpzC2fBL2Y7BvrrBd0+ewLY?=
 =?us-ascii?Q?+PpkbSAaQscuAFveiBdPHr8JqGZD445lhqHzcdNrnB7wcaJSIV3Oy/T05Mu/?=
 =?us-ascii?Q?cpd51UJWJqZHrJDiHFtBDkdn39A9Qdcwwak7dg4YPQnu52VAHMR1BQno9Be9?=
 =?us-ascii?Q?J9V2Hw2VvCMZQPd05OWYLsploXy1vt2uvWTZ6WzBf9QkucLxEPlwLf7Miig0?=
 =?us-ascii?Q?RNwKDcSv?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?yw15FWD/6wGUr1OdMlj4E8r+qBlPvvM4KpUcTMpEbKwJWNvbreOy9dNTdk/v?=
 =?us-ascii?Q?Lr6RGhZaMaESPA0R2pRMDUURm0xA3qovo/al5LV8vI9nFKNxqRFecmVtfWBQ?=
 =?us-ascii?Q?07fkMNwGryf2US4mIwSjQj6o243qzp9mSaxH4vkPn7SltS6osP0VeGjFoB2X?=
 =?us-ascii?Q?sKD7WBMFSCMw9rhcqDa0Lfy+yaly9Uc4ko9sJbJV7fsFC4mv+xSX3u6jXKNt?=
 =?us-ascii?Q?kNdYohmsYR+bd6xU/n2Z2Myo3up3bJ52DQMxS0t5KpM5YKrCYDQBz84M+5cy?=
 =?us-ascii?Q?+GKFh+SJpWgdQDTJUwYrRWXeLhL54AxIWm59fZoKRviycxs4IUat1ZJfQDA9?=
 =?us-ascii?Q?MU2eva+HmW7DEidh4iBlFFpf8iBmlYnDQIoB/UpAU8Sj1YoF61GB+1weU+jz?=
 =?us-ascii?Q?SwiADZlo2fcFL1X42P5NND2Hex2mqWJeubavG2nKyMJZFcZU2XBG9LjLZGke?=
 =?us-ascii?Q?vvZkVRyP1fbPhMNWZ4NDcu5wMl7Mqc0fxhwWeJDEDDvpbeSdESxTcOKV63m5?=
 =?us-ascii?Q?hkEO1CAv2eBAevPjrsV2mJDQw+acQVH8s3SKQPQ71b4uug+mFWxeZja2eCSx?=
 =?us-ascii?Q?29XpebIFKL90pnrdRAH0z4COpjt+cP6xU8UimR2OyBXKujBozQs4zuOeeAeZ?=
 =?us-ascii?Q?3C/U9ejzLlaXFNnhFftpUK8W7UVTWA+kRvYqprjhQ/kMKnNMxmu4U+gfaxUt?=
 =?us-ascii?Q?qOzehp/VtBsoyXW9utQJpwB1I4DfOSsCaFiLCQQZiCidSHCJ6FzNUaRjPkaY?=
 =?us-ascii?Q?O4vNhprjQqPuDBSuG62TOAWiYnxBgVRjXxNv7spzwK+q+weLVALLFx2Y4+gw?=
 =?us-ascii?Q?hj+QusdvU4a3QdOdCMPD7q4jzlq28LyR7LHKAPlBNKYx5jmom6Fc4NbKwIVd?=
 =?us-ascii?Q?rw39iN9MbEVVIyDdYJLixdlZwIvJg/TZs4w67HSV8VubY7jUl2jJmB3uzfYF?=
 =?us-ascii?Q?IBcF/lvlgRPvcmceBN+MKMDbXRbuEW8mZb2lPT/m4g5+GcgDQPRrpUhW7hOH?=
 =?us-ascii?Q?EE392WaHn1LGBKfFU10/r4LFXst9tqP9NtezE4qFSW8CcSmBa+94QtIifSIm?=
 =?us-ascii?Q?JHBmLO96Z4RkK5JVfOrfNWZtBTDWVy/Stk3KBC3Uag1U7NhJCBRcIB2kOhcH?=
 =?us-ascii?Q?7kveJEFe2qu80RCwDMPFxaLlO/7DzXat2XX19ou7e50w5BRJyU9iwD6Wlr/R?=
 =?us-ascii?Q?VRvvSU8749Mm7UrSBBKG/GDSJEnslVPtgNm1gaLntcYC5SqXODIP53Fc/59+?=
 =?us-ascii?Q?4NvhMaXA7fE1v6CAN/WrQnQ4xOfJWoZwtGyIf8yZj1ynDN/g9AAYJ55k9pgr?=
 =?us-ascii?Q?vW7AvespeHGgzFy2En4OK0gHBCHgpfV6BKk1e3zyvf0dHNt7FcVJvAdFxiTw?=
 =?us-ascii?Q?k653ReU=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: c0c7733b-c93a-4874-8806-08dea6196336
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Apr 2026 18:01:50.1494
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR02MB9008
X-Rspamd-Queue-Id: 478924987F8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[outlook.com,none];
	R_DKIM_ALLOW(-0.20)[outlook.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10479-lists,linux-hyperv=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-hyperv];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,outlook.com:dkim,outlook.com:email,SN6PR02MB4157.namprd02.prod.outlook.com:mid]

From: Dexuan Cui <DECUI@microsoft.com> Sent: Tuesday, April 28, 2026 6:58 P=
M
> > From: Michael Kelley <mhklinux@outlook.com> Sent: Thursday, April 23, 2=
026 10:40 AM

[snip]

>=20
> > Question about Gen 1 VMs: If the Linux frame buffer driver moves
> > the frame buffer somewhere other than the default location, and
> > then the VM does a kexec/kdump, what does the legacy PCI graphic
> > device BAR report as the frame buffer location? Does it *always*
> > report 4G-128MB, or does it report the new location? I can run
>=20
> It always reports 4G-128MB.

OK, good to know. I was hoping it might report the new location. :-(

> BTW,  I suspect a Gen2 VM may have the same issue, i.e.
> currently we only reserve 8MB below 4GB; if hyperv_drm uses
> high MMIO, I suspect the UEFI firmware would still report the
> same original low MMIO framebuffer base/size to the kdump kernel,
> but there is no easy way to verify this for Gen2 VMs...
>=20

[snip]

>=20
> However,  when the kdump kernel starts to run, and I print the
> pci_resource_start(pdev, 0) and pci_resource_len(pdev, 0)
> from vmbus_reserve_fb(), I still see 4G-128MB:
> [   12.506159] Gen1 VM: start=3D0xf8000000, size=3D0x4000000
>=20
> In this case, we can't really fix the MMIO conflict, e.g.
> if both hv_pci and hyperv_drm are built as modules, then
> the order of loading them can be nondeterministic:if the order
> in the first kernel is different from the order in
> the kdump kernel, we run into trouble.

Yep.

>=20
> If the order is deterministic (e.g. hv_pci is
> built-in, and hyperv_drm is built as a module),
> we should be good since both allocates MMIO from
> the high MMIO range in a deterministic way.
>=20

Yep.

Thanks,

Michael

