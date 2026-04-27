Return-Path: <linux-hyperv+bounces-10384-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id APHqN9r27mnS2AAAu9opvQ
	(envelope-from <linux-hyperv+bounces-10384-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Mon, 27 Apr 2026 07:40:42 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 463E346D46A
	for <lists+linux-hyperv@lfdr.de>; Mon, 27 Apr 2026 07:40:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B86883009B02
	for <lists+linux-hyperv@lfdr.de>; Mon, 27 Apr 2026 05:40:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEA5734E75A;
	Mon, 27 Apr 2026 05:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="ZQ83An0s"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazolkn19010003.outbound.protection.outlook.com [52.103.20.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F0D3223708;
	Mon, 27 Apr 2026 05:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.20.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777268439; cv=fail; b=Cw9Mgzkji+PREGFBJP5dzB0NajFwJigYOhLoi9NBvBYxtJ3ZXiEtsSscO4wAjfnXDxSqVeFzV2DkEIOQ4jXDLMZ3iyjhxgYNmgKxoW+QMRlEpUPrSG5r0Mrsi/b5t8c8fqj0+GNbIOz0fPorIn5iVRrRss+4oIunXHfkyz1qRuM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777268439; c=relaxed/simple;
	bh=4+tg069iYj8T/3KGPUn3WlAfB1xTIpkXdJwvXi2ybaA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nX4WzOUSFs2YTst9Ph6utwVW0RFZet4/eFABmNEZ1V8I4vrVfjff2LJSUmoQg3BgLkATjkRytVSgbBps13YU/BQUEGiSyNnGteqbi/D6t2C6AlJZPjAzOmyoQlsGBO+wJyDxa2zBxe08Wkd5svgbO0mFE7y38T3ko4+BoKWrqsI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=ZQ83An0s; arc=fail smtp.client-ip=52.103.20.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rWDci0pO8ET0A2YlQUttamFAAiT4wjiFpZI3E6pRbwLu+7bHDGv6PZ473CP92cgCh8/n9dq/BIdhWfOiNwEFYatFIZmj619tSIfTgrnx6ArU3Ex54TO6oPfwZToon6SPpcK6VyrV/RtMSlJq25icRT9Tn2j45nZzCIbWAviHrTyrL+fkd34szJ7N+JWwkygKcFwuivFJZbut/sc/b2qUYenuyZiMkx2JdOsZ9rwk92aOfcRkULqrBmwGSHlNBDKgUiBv/lm3tmXsJkKw5pGcCf0ot+K/JtHb/pimgjKZAxdWdfqc5eiJnIt79F8quubP3+SVhaGYjuWx2WqCE4d0vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dT+z93y9Cx/sUn1qPXeDCaz74u0OsQiX9nCyVqCiBG4=;
 b=mfWYIAF3GcwBy22ewvEWt2FlTY+jCAUH0QFl4WcD9ljhn4fheHEQNcarem9gDC7yyOYIivI1VXdhfOFh1tnb8mJhhLPj8XNppQ7geael11L3V2LOMREMtjenjC8Sx3NhW0rYzRiJL26ijoGjAmK4GWxNp6X8ARw+0WDEUSvJW6CbzyXvjZEvJA5OfKjSH75nF2oe8wPkURAzz3KOPZ8AZ2KHZ7BaHpuwlURygQWFKcaIXJsZuutln+xTde3zl28FmZwPVLgs1VBqkjQNFqAqw6FjkZj+q0zeEdbA+Bk+15NARyTfqxbmNvg0USQR3A0Re23MUwsZK2SjVYGXcTysVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dT+z93y9Cx/sUn1qPXeDCaz74u0OsQiX9nCyVqCiBG4=;
 b=ZQ83An0suaQCL+37ueSyjXANctCHgOr+0Nyi3sgYREJE8/oSMiQEi4EhAXwDOW47sascVwcXaAUldJE7F1Su5xbsSgRCbuivLX4wK8baCXhmitJcWDSzY+JgZJmNsAMFG50uwta+YCpDS3sTj3jW2LnzQ50GctA8sks4sW4seA0iqCiMC3eI9a1Sl5q4q0oazDDYaT0ukMn800F2oPNBdP6KGyfX2hyvD1c2pO8u9RtBlmMErBkIzOhRDUnK9N9fOQDhP1+gCkYzazxdEIdPJdpLhBn2I3l6SVKBdyDTzx6kAGR8axDFe8jCwS+sjCph13YOjBcTvWG3gmlXDZRFtw==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by CO6PR02MB7809.namprd02.prod.outlook.com (2603:10b6:303:a2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Mon, 27 Apr
 2026 05:40:34 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6%6]) with mapi id 15.20.9846.025; Mon, 27 Apr 2026
 05:40:34 +0000
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
	<aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, Michael Kelley
	<mhklinux@outlook.com>
CC: Marc Zyngier <maz@kernel.org>, Timothy Hayes <timothy.hayes@arm.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Sascha Bischoff
	<sascha.bischoff@arm.com>, mrigendrachaubey <mrigendra.chaubey@gmail.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org"
	<linux-arch@vger.kernel.org>, "linux-riscv@lists.infradead.org"
	<linux-riscv@lists.infradead.org>, "vdso@mailbox.org" <vdso@mailbox.org>,
	"ssengar@linux.microsoft.com" <ssengar@linux.microsoft.com>
Subject: RE: [PATCH v2 09/15] Drivers: hv: mshv_vtl: Move
 hv_vtl_configure_reg_page() to x86
Thread-Topic: [PATCH v2 09/15] Drivers: hv: mshv_vtl: Move
 hv_vtl_configure_reg_page() to x86
Thread-Index: AQHc0x7PKig5dZReokG7sAarwbgXxbXyan2Q
Date: Mon, 27 Apr 2026 05:40:34 +0000
Message-ID:
 <SN6PR02MB4157467FDBC0203C67A67042D4362@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20260423124206.2410879-1-namjain@linux.microsoft.com>
 <20260423124206.2410879-10-namjain@linux.microsoft.com>
In-Reply-To: <20260423124206.2410879-10-namjain@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|CO6PR02MB7809:EE_
x-ms-office365-filtering-correlation-id: 37aeab86-ff90-4135-4a9d-08dea41f80ba
x-microsoft-antispam:
 BCL:0;ARA:14566002|2604032031799003|704163111799003|51005399006|55001999006|16051099003|37011999003|13091999003|19101099003|461199028|41001999006|31061999003|19110799012|15080799012|8062599012|8060799015|40105399003|440099028|3412199025|102099032|12091999003|1710799026;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?AKL/g+f4vGVwEPDTueqs/0pGD5sdTrnsk+5xb88LvCiK5B80QBCyULhHWD/F?=
 =?us-ascii?Q?EaoU+pVHbC96tRteibtjuceS8/bKikSY9cRxCFKZFbVMJ0BfQyGOLENKcOuP?=
 =?us-ascii?Q?nIoWdrpWT7f1Z4zHRNJ8+IQgXrX/3HM7bvkUNLttDVDK5ssL61F54smtcb/e?=
 =?us-ascii?Q?uQKw8qe81sUcYck/+3JSCmGPqmLlyu+WP2aUq+xVmBwgT8aCRWCjPKZMgolG?=
 =?us-ascii?Q?Cprgapyr0w0NA/WtcoBY5nRrDYZsfiwAj5dgdKaB+K3A7ZQ1D6V5+8Tdsa3s?=
 =?us-ascii?Q?6E5iyfoUah+lWZSblJtx58LFudW07ovP08vsPbknTq6mQPt9KMaRUQ1IWbja?=
 =?us-ascii?Q?Um5f0lUFU2Vb6GtYRFQVz6U91bIbApT55bI6dZ0CgTid1RcI9syBUhhhY839?=
 =?us-ascii?Q?nyrewVgqkaB91A2g6SyvvipVIu3tOYM99l+2/GOlEbMvCIzFeO5ABATYL5V2?=
 =?us-ascii?Q?/Ck0zqxK+jG8G8mUoOimVcC7zDBaE5hkGJqmSSS0mBbae3vYneJ3uZ7dXAbx?=
 =?us-ascii?Q?8HNJuDuRl6+5W4tpjsBfa/uj4f9xnTiiqhUviJyxqdRz51nLghuL+97Zrhkc?=
 =?us-ascii?Q?LqOnbUKMv11aAWULHIcW33UGktSXDgGXpiFwMfNcjL3on1GlRq/cV+0HnmHR?=
 =?us-ascii?Q?ghm4FSaiDgqGIGghauvISbeN+Nq42lj1N9WZqX0CzAC6QpSLOYgAPf82c1z1?=
 =?us-ascii?Q?Aa3OHmJdSvuXVk2r+W5DcCcyp8uFKMPR1QM8NYz8Tltj3uNTAcbKPE/VElDY?=
 =?us-ascii?Q?PaHAUieYeRPjrF14jpqDA+jCuX2y57Ul8vDEJcu8jpW8s0Thfg2DIvK8iopv?=
 =?us-ascii?Q?xIVPVonymyGi77PZ6CNWpDlt9E4ugq60NdSXGMr4uFGEPv8aeFfFUmxOpTbu?=
 =?us-ascii?Q?lnIO3PhpPlMVKaP0csn+c6olLfAQj31bThUf1DQKA3e8nbrZJleF756vIMkx?=
 =?us-ascii?Q?7E0RTtLCM42DYh6qydPXn3WADkJlV3d8RqfRDcISmizdJhPWrlYRFrL0btiK?=
 =?us-ascii?Q?iWD3sJMnP0CIyQIUbPbr574CKOOVH0Swkggx0dtS1mtu1HziGm6xeg8hql6u?=
 =?us-ascii?Q?rTY/z1oAwn7ENV3FYqWM27UBPC13EKxDMWevaAfcCzO9Zr6PYcbYuVc4qeCL?=
 =?us-ascii?Q?zk9T3ShH/psbYHFYY39WUQNvNlbd3GzGyVT6lUpgAHVZa42p09Sc/CTKf7CS?=
 =?us-ascii?Q?yv58L1Ho3S0IPECwZ1S1NbstydeWlpWqYUzy/MkqMDUTGtm747kN2Uugdxw?=
 =?us-ascii?Q?=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?kGQuidTo/ftXD6Na41g1hdy/k/qIgjSfw37YAvg9wq17XZRVenDh8laVwap1?=
 =?us-ascii?Q?XKS7mnidFMSIwadHSZGCoVgka+EdhuyeMrmRg7/x0iEzRa0UreCUwZCSa6P0?=
 =?us-ascii?Q?RtGzMQHn/ir7KX+vM0Pd2bCCl0Nm/7orbLcpSa96h/kRvVk5Y1DPo9U4CGx7?=
 =?us-ascii?Q?HT/6LvmIyvC5u80FIq7CBw9k6GI41QNnsHSmOGbPgd2bBj/NyG6cV+v6/epg?=
 =?us-ascii?Q?g9Wki1cmEfrn93JVeUA0V5MC/oGKYIrA3IXpMeVpxQwg/m0vYo+rWoVfmZ1c?=
 =?us-ascii?Q?KCejlCNN4gA8UvjhAFPi6V1zCL9lJ05rZwHXktW1cnL6VJEyHRWVr8xl0xY6?=
 =?us-ascii?Q?pghjFmhJ0j0qGuLLim6qgYuykP9XIcekG/XVxXhgjffzKjhHCKakWwedM49M?=
 =?us-ascii?Q?tU/fXesV3liwwPIqS2VQ1MsYTF5yqlVWEynk/9qZpygyX4OyKzMWPqS8WCpx?=
 =?us-ascii?Q?eNdhEH+m8HsaLr27uGKpO7JVinh//QB4AVvwtJIdHGKuIlPlAH+q8IrxBQVF?=
 =?us-ascii?Q?YyzUXW+lUq8VZkSKJW0EoqlxkHpiJDbKbHotMqlmmomCGNtrWFmxxsm8PpK0?=
 =?us-ascii?Q?3NeYWNQPQjYw4pgMSibpn+rkII8A4V6tcOHibAbEBCDEDGCgnWVTBMZvqlCN?=
 =?us-ascii?Q?22gm9i5mJmZWZ3m5qQOmuIM9EXThW+QBit+mxqtKEWBoiDmwK1lgcD9oboSn?=
 =?us-ascii?Q?oLuG0FqURGLE/p5LWUYKD4x+CjxEGE9FbeWop+6QQEV2BIoHlNPGcLtVQHcu?=
 =?us-ascii?Q?k7saBOzcgvtGeBWDiW9pPV/hHnqiIkf93qegnHYcwaBijD0bJsTzHEW3Eax1?=
 =?us-ascii?Q?GR8pzdW4j1Yays1GyxT6vvur6CG/99KIrH/+PZlM5E9DBYuk+AaeVV1lXRWP?=
 =?us-ascii?Q?ZuQuzSVp7B0iJ0DU7DvIk+bZhJWhgR7DNKFhqyzJqIxHlkncHKlO/l5/2pJr?=
 =?us-ascii?Q?keMU/k50bZJc5kpu/GO5fYRjRFQ5vdKZB2ZRj5SNR+U8cU8J/gHBlYG7QUDF?=
 =?us-ascii?Q?MWRjCMqiU3S/RpF05GStEWYturPj3eBMtV/Y+T5+4+/vlK/lhcuF22DU//9c?=
 =?us-ascii?Q?ehV0rFIxbFsEUGpsKlxmFssgJcVaBrn1tWvljxNrrlHh3kahbPgtEm/U+i/S?=
 =?us-ascii?Q?j5vDZK/iICnb39doDARebHXqJLVMUpD5Lb+/hCpwk1fry4ICmQ3VGFLvnmXr?=
 =?us-ascii?Q?IgL2uNSZuwEfF3b9M8USuSBO+/dD3zORU/bBb6n1xQqRCn4nn+UiPDBf9IdD?=
 =?us-ascii?Q?ggky0QU/AddpRditPrah52AAip1pgjq/261atDuSU462nvokwVNm1+HvbsjP?=
 =?us-ascii?Q?SEL7bSx3U+/FHFXudIcARsEl6X4sSbwRKmsUgYvbDqzzNRiEl+csQq31dKMK?=
 =?us-ascii?Q?07tPWRk=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 37aeab86-ff90-4135-4a9d-08dea41f80ba
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Apr 2026 05:40:34.3525
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR02MB7809
X-Rspamd-Queue-Id: 463E346D46A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[outlook.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[outlook.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10384-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[linux.microsoft.com,microsoft.com,kernel.org,arm.com,redhat.com,alien8.de,linux.intel.com,zytor.com,arndb.de,dabbelt.com,eecs.berkeley.edu,ghiti.fr,outlook.com];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_FROM(0.00)[outlook.com];
	FREEMAIL_CC(0.00)[kernel.org,arm.com,gmail.com,vger.kernel.org,lists.infradead.org,mailbox.org,linux.microsoft.com];
	RCPT_COUNT_TWELVE(0.00)[32];
	MIME_TRACE(0.00)[0:+];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[outlook.com:dkim,SN6PR02MB4157.namprd02.prod.outlook.com:mid,reg_assoc.name:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

From: Naman Jain <namjain@linux.microsoft.com> Sent: Thursday, April 23, 20=
26 5:42 AM
>=20
> Move hv_vtl_configure_reg_page() from drivers/hv/mshv_vtl_main.c to
> arch/x86/hyperv/hv_vtl.c. The register page overlay is an x86-specific
> feature that uses HV_X64_REGISTER_REG_PAGE, so its configuration belongs
> in architecture-specific code.
>=20
> Move struct mshv_vtl_per_cpu and union hv_synic_overlay_page_msr to
> include/asm-generic/mshyperv.h so they are visible to both arch and
> driver code.
>=20
> Change the return type from void to bool so the caller can determine
> whether the register page was successfully configured and set
> mshv_has_reg_page accordingly.
>=20
> Signed-off-by: Naman Jain <namjain@linux.microsoft.com>
> ---
>  arch/x86/hyperv/hv_vtl.c       | 32 ++++++++++++++++++++++
>  drivers/hv/mshv_vtl_main.c     | 49 +++-------------------------------
>  include/asm-generic/mshyperv.h | 17 ++++++++++++
>  3 files changed, 53 insertions(+), 45 deletions(-)
>=20
> diff --git a/arch/x86/hyperv/hv_vtl.c b/arch/x86/hyperv/hv_vtl.c
> index 09d81f9b853c..f3ffb6a7cb2d 100644
> --- a/arch/x86/hyperv/hv_vtl.c
> +++ b/arch/x86/hyperv/hv_vtl.c
> @@ -20,6 +20,7 @@
>  #include <uapi/asm/mtrr.h>
>  #include <asm/debugreg.h>
>  #include <linux/export.h>
> +#include <linux/hyperv.h>
>  #include <../kernel/smpboot.h>
>  #include "../../kernel/fpu/legacy.h"
>=20
> @@ -259,6 +260,37 @@ int __init hv_vtl_early_init(void)
>  	return 0;
>  }
>=20
> +static const union hv_input_vtl input_vtl_zero;
> +
> +bool hv_vtl_configure_reg_page(struct mshv_vtl_per_cpu *per_cpu)
> +{
> +	struct hv_register_assoc reg_assoc =3D {};
> +	union hv_synic_overlay_page_msr overlay =3D {};
> +	struct page *reg_page;
> +
> +	reg_page =3D alloc_page(GFP_KERNEL | __GFP_ZERO | __GFP_RETRY_MAYFAIL);
> +	if (!reg_page) {
> +		WARN(1, "failed to allocate register page\n");
> +		return false;
> +	}
> +
> +	overlay.enabled =3D 1;
> +	overlay.pfn =3D page_to_hvpfn(reg_page);
> +	reg_assoc.name =3D HV_X64_REGISTER_REG_PAGE;
> +	reg_assoc.value.reg64 =3D overlay.as_uint64;
> +
> +	if (hv_call_set_vp_registers(HV_VP_INDEX_SELF, HV_PARTITION_ID_SELF,
> +				     1, input_vtl_zero, &reg_assoc)) {
> +		WARN(1, "failed to setup register page\n");
> +		__free_page(reg_page);
> +		return false;
> +	}
> +
> +	per_cpu->reg_page =3D reg_page;
> +	return true;
> +}
> +EXPORT_SYMBOL_GPL(hv_vtl_configure_reg_page);
> +
>  DEFINE_STATIC_CALL_NULL(__mshv_vtl_return_hypercall, void (*)(void));
>=20
>  void mshv_vtl_return_call_init(u64 vtl_return_offset)
> diff --git a/drivers/hv/mshv_vtl_main.c b/drivers/hv/mshv_vtl_main.c
> index 91517b45d526..c79d24317b8e 100644
> --- a/drivers/hv/mshv_vtl_main.c
> +++ b/drivers/hv/mshv_vtl_main.c
> @@ -78,21 +78,6 @@ struct mshv_vtl {
>  	u64 id;
>  };
>=20
> -struct mshv_vtl_per_cpu {
> -	struct mshv_vtl_run *run;
> -	struct page *reg_page;
> -};
> -
> -/* SYNIC_OVERLAY_PAGE_MSR - internal, identical to hv_synic_simp */
> -union hv_synic_overlay_page_msr {
> -	u64 as_uint64;
> -	struct {
> -		u64 enabled: 1;
> -		u64 reserved: 11;
> -		u64 pfn: 52;
> -	} __packed;
> -};
> -
>  static struct mutex mshv_vtl_poll_file_lock;
>  static union hv_register_vsm_page_offsets mshv_vsm_page_offsets;
>  static union hv_register_vsm_capabilities mshv_vsm_capabilities;
> @@ -201,34 +186,6 @@ static struct page *mshv_vtl_cpu_reg_page(int cpu)
>  	return *per_cpu_ptr(&mshv_vtl_per_cpu.reg_page, cpu);
>  }
>=20
> -static void mshv_vtl_configure_reg_page(struct mshv_vtl_per_cpu *per_cpu=
)
> -{
> -	struct hv_register_assoc reg_assoc =3D {};
> -	union hv_synic_overlay_page_msr overlay =3D {};
> -	struct page *reg_page;
> -
> -	reg_page =3D alloc_page(GFP_KERNEL | __GFP_ZERO | __GFP_RETRY_MAYFAIL);
> -	if (!reg_page) {
> -		WARN(1, "failed to allocate register page\n");
> -		return;
> -	}
> -
> -	overlay.enabled =3D 1;
> -	overlay.pfn =3D page_to_hvpfn(reg_page);
> -	reg_assoc.name =3D HV_X64_REGISTER_REG_PAGE;
> -	reg_assoc.value.reg64 =3D overlay.as_uint64;
> -
> -	if (hv_call_set_vp_registers(HV_VP_INDEX_SELF, HV_PARTITION_ID_SELF,
> -				     1, input_vtl_zero, &reg_assoc)) {
> -		WARN(1, "failed to setup register page\n");
> -		__free_page(reg_page);
> -		return;
> -	}
> -
> -	per_cpu->reg_page =3D reg_page;
> -	mshv_has_reg_page =3D true;
> -}
> -
>  static void mshv_vtl_synic_enable_regs(unsigned int cpu)
>  {
>  	union hv_synic_sint sint;
> @@ -329,8 +286,10 @@ static int mshv_vtl_alloc_context(unsigned int cpu)
>  	if (!per_cpu->run)
>  		return -ENOMEM;
>=20
> -	if (mshv_vsm_capabilities.intercept_page_available)
> -		mshv_vtl_configure_reg_page(per_cpu);
> +	if (mshv_vsm_capabilities.intercept_page_available) {
> +		if (hv_vtl_configure_reg_page(per_cpu))
> +			mshv_has_reg_page =3D true;
> +	}
>=20
>  	mshv_vtl_synic_enable_regs(cpu);
>=20
> diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyper=
v.h
> index ef0b9466808c..9e86178c182e 100644
> --- a/include/asm-generic/mshyperv.h
> +++ b/include/asm-generic/mshyperv.h
> @@ -420,12 +420,29 @@ static inline int hv_call_set_vp_registers(u32 vp_i=
ndex, u64
> partition_id,
>  }
>  #endif /* CONFIG_MSHV_ROOT || CONFIG_MSHV_VTL */
>=20
> +struct mshv_vtl_per_cpu {
> +	struct mshv_vtl_run *run;
> +	struct page *reg_page;
> +};
> +
>  #if IS_ENABLED(CONFIG_HYPERV_VTL_MODE)
> +/* SYNIC_OVERLAY_PAGE_MSR - internal, identical to hv_synic_simp */

This comment pre-dates your patch, but I don't understand the point
it is trying to make. The comment is factually true, but I don't know
why calling that out is relevant. The REG_PAGE MSR seems to be
conceptually separate and distinct from the SIMP MSR, so the fact
that the layouts are the same is just a coincidence. Or is there some
relationship between the two MSRs that I'm not aware of, and the
comment is trying (and failing?) to point out?

> +union hv_synic_overlay_page_msr {
> +	u64 as_uint64;
> +	struct {
> +		u64 enabled: 1;
> +		u64 reserved: 11;
> +		u64 pfn: 52;
> +	} __packed;
> +};
> +
>  u8 __init get_vtl(void);
>  void mshv_vtl_return_call(struct mshv_vtl_cpu_context *vtl0);
> +bool hv_vtl_configure_reg_page(struct mshv_vtl_per_cpu *per_cpu);
>  #else
>  static inline u8 get_vtl(void) { return 0; }
>  static inline void mshv_vtl_return_call(struct mshv_vtl_cpu_context *vtl=
0) {}
> +static inline bool hv_vtl_configure_reg_page(struct mshv_vtl_per_cpu *pe=
r_cpu) { return false; }

As with Patch 8, if CONFIG_HYPERV_VTL_MODE caused mshv_common.o
to be built, this stub wouldn't be needed.

>  #endif
>=20
>  #endif
> --
> 2.43.0
>=20


