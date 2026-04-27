Return-Path: <linux-hyperv+bounces-10385-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +DvWCe327mnS2AAAu9opvQ
	(envelope-from <linux-hyperv+bounces-10385-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Mon, 27 Apr 2026 07:41:01 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C41F46D482
	for <lists+linux-hyperv@lfdr.de>; Mon, 27 Apr 2026 07:40:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 577D43002B34
	for <lists+linux-hyperv@lfdr.de>; Mon, 27 Apr 2026 05:40:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A198034F241;
	Mon, 27 Apr 2026 05:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="cuUIpWIH"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazolkn19011008.outbound.protection.outlook.com [52.103.1.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFCC431AAAA;
	Mon, 27 Apr 2026 05:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.1.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777268457; cv=fail; b=M2nE4I9THzD4XjzrilHjA2XBzAOSXdSXoGoARTAgSOvh3gg4n9DllDORapYAvzuoq/Ioe6ERXUWjBf7X0ryKU93ZKv2jpMx7orJC+mj7YEaCT4y19xslWJyLqFKSWqy6QczdQj9m5Urtd39MgRVzIC7x4tMv16OPfbYRJvDSF/4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777268457; c=relaxed/simple;
	bh=hENXaIKAj7JUwz4/RSXRU1vyxsfWfcd2p4WIhfubHLY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=D9Ua+57780SmH9dPnCB1Sow73/D/CJLhcfPn5BasW4gJ9LhGysW/K7oZ6G/vT/wYdKtsToeCnYdWiNiUQdhGQOHzyqp4SVKLoXKmrrRlnbXl9hdPkqBh1BAMRExtKZHwIeGxxYV+4kyIwNiamuHH/SYqivJa6G+nGlfH+L0jqYg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=cuUIpWIH; arc=fail smtp.client-ip=52.103.1.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Veu21Ec1ksh5PnRMniiAjIjUfe5VNLwXgkA2mU2TCUS6cjkxNL7mjB/xgv6uv6pyYP7HVmNV6fT7/fSxkkILge8ykbvZsvKSzy9w5s2JCXV2H4FjeykIxFbJFfCoDbtAbNhzSDgdWRf43OnUvdzJ0esI4o63VBbBhfR34edqAal20MnZI3gJI90bfYI9iLVeMYWoKeY4B8wF0TwkKS8GabXdZFt/oIB7idirMKWn2PNfkRoLHBF5zcrNu98nzDf5kXNGLtqHSPnkh5iexbPT6V6DfArXbO36Lkj1+X2KhZEPLfinYWqAskZl7VyzAYPVHYKnldhvld6/lfuP8JJIzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lAWuHYP5PjwxCYpcv50N32lDLH65mOubH0uDSpPgD90=;
 b=WXjWqljH4jPGG8beCrN3rRGaN7ePs0zMB7vZaxHnPVE0w5fXwspXnlVS6YsYi5A8fUlhvWWk51zsaA6/96DqljDZaSIcVXeZBqvulhd3DoowpgLqDGI3Sydb4tNLd7Cdzplmel/Q/LTiJBCCnEKTTM6Z6NQSScERnS7bibbiFJsyCZsh8jWeAxj8Ip+EfoW6LkRqT8u1wTyBmp9cEkD/hmq4JYoOHuT4TD9Pm4ettk0728S/PO7eGmvNWFnuFHJEI3OeY5G1JcdsvxlvNDfFosZ6u/B7Kw2zun+1tCadDw/sOyZ9IPCAXx0dUy2bH1dX+P0n3rVzT8APIOlNk10i7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lAWuHYP5PjwxCYpcv50N32lDLH65mOubH0uDSpPgD90=;
 b=cuUIpWIHHYmiMLrRvj2nkCL8e8lS7Zu2+uynJWe/Xdvu/MK11kS+Lk9UPEaF9i4stTv2w1PoAA1GUFYyzAy/p4ZWaNTEFhtLQhOI/sliVpdmOkVt4+JusDU8BRRagjDQ8WsjIkfzBlxdVIphDN0jOBcWhpHgsOApsltCwU3l8wBuYBWjEOJE11kGad7+0N+lPat6UiSS6VRIDkBIRq4ROyMZgNeYsOidOKg0S4/Yns/TeUA+1FlosCCEVz7CMoV6NSvKrVZZndzxQ0qFNKtjb8BjN8dCLcNRofy/LRLs+fh/fDF+AIUfb7DDMTZUk4TvyhRSqMn2g+DAsERhmwbllQ==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by CO6PR02MB7809.namprd02.prod.outlook.com (2603:10b6:303:a2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Mon, 27 Apr
 2026 05:40:52 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6%6]) with mapi id 15.20.9846.025; Mon, 27 Apr 2026
 05:40:52 +0000
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
Subject: RE: [PATCH v2 12/15] mshv_vtl: Move VSM code page offset logic to x86
 files
Thread-Topic: [PATCH v2 12/15] mshv_vtl: Move VSM code page offset logic to
 x86 files
Thread-Index: AQHc0x7dvoxTT1xj6U+jCn0YEoiRorXyapGw
Date: Mon, 27 Apr 2026 05:40:52 +0000
Message-ID:
 <SN6PR02MB4157E0525DDDD153888F5AFBD4362@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20260423124206.2410879-1-namjain@linux.microsoft.com>
 <20260423124206.2410879-13-namjain@linux.microsoft.com>
In-Reply-To: <20260423124206.2410879-13-namjain@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|CO6PR02MB7809:EE_
x-ms-office365-filtering-correlation-id: f0cb2edb-9040-438f-696c-08dea41f8b42
x-microsoft-antispam:
 BCL:0;ARA:14566002|2604032031799003|704163111799003|51005399006|55001999006|16051099003|37011999003|13091999003|19101099003|461199028|41001999006|31061999003|19110799012|15080799012|8062599012|8060799015|40105399003|440099028|3412199025|102099032|12091999003|1710799026;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?MvvVeg8fXOA63QZFLtb2auJdqql//zfHx5rk55KGa8Hc32fuZe1AzaZpJYP5?=
 =?us-ascii?Q?eJ+xEsLdTg8Varg+14aUGfCpYwV+NQKi7N1DNBepAq/XUkld138vL3/a3UDg?=
 =?us-ascii?Q?fCK03zC2IrqW5l+UIOzszsGIxOaDePtql2A0mNV8G8jZxuVbmdBPW5e9wI6P?=
 =?us-ascii?Q?j7y5UAno5y1mPFN4IyNghTbdXiXNqzUfSEK/3aXBFmqVVqJbHtHpPyOWjwQH?=
 =?us-ascii?Q?6bvMDXBvEQoZQ5RbYzLjM4GapXEWH+gG9AguJ30qBT6dmJCTXDBnVfWBdIo/?=
 =?us-ascii?Q?sT1DimPymh/mgWEOc4BuXJ3bsHZuK2SvyjRJMbPM4dbV4ELZyLTE+13daebv?=
 =?us-ascii?Q?nFIYtSG3D8vgIJiCZnyChsEWM7C37j2m268kDHh8CIj2EIU138Ohe656yBZv?=
 =?us-ascii?Q?pZaSlrSsLBHNlzN73/xifzROqlfBt1Of+CzzQfPrp3MItaK+B/UQCOE9MXKb?=
 =?us-ascii?Q?0K+oVJNJrWQJGC9KzvU0Yrq33uCZmPozPaUfmcGQqvGQPxl5JN4vDVSpy/Tq?=
 =?us-ascii?Q?Kvs9dbM084Yq1ocMEepCmDR9fweFqVO/nLqN+wQzft4FCw+mLHQXnpud+2J9?=
 =?us-ascii?Q?8UcuRVuC7XoXwsyM18YHOJxC33NJ6dqRuzYJhTbSASmVPtyWbB5hKz7NmaQR?=
 =?us-ascii?Q?pVhsyEtp81D6/x8k59dhAunwB3xA5LjZpFTU/8LPY+r9WnHcJnlRUL0VPkfN?=
 =?us-ascii?Q?9AwHV0eAUSUfAHZYt2Valut5CkznyL8A6TpxS/eeWSQN4jIHu2R3rTkoabmJ?=
 =?us-ascii?Q?JfMAQNGrVAqKZtUDRYS9oFSqULV+1JoW1s+qHtijfHa4+ZEVD8e4vXe97K7p?=
 =?us-ascii?Q?Dmz1eegU5hremRHTtteRtj2PKvOqmdhRucN1KEbS7ljxZ10QmQ7cpJp9p5D3?=
 =?us-ascii?Q?wHPH2uDmMZcJdgj69nUUh1fkk+ANRiUqB21djv49KWinAPQki3CWAbz4n/jh?=
 =?us-ascii?Q?zZSNmNs+umu8j+tue/tpF/3NRWqYDkvgToH0iqfuyQck/X7skd36OjtPMh6Q?=
 =?us-ascii?Q?RTVESkGDs2ccaVDlMJLoOCIam7FlxNpgdxLwnG/aZzDqLlDBwZmhrNhYsDzL?=
 =?us-ascii?Q?xYYHm588aXi1QlvSiL6c88OvgujFcKEjXOneENc5Cgt0u8jPA/jV6t9bOWwI?=
 =?us-ascii?Q?AS2tCrtHg0rASRS5IVZZG5Ajj0lCFj2y3grtbwibGTkJxz/RHCBardV1jzba?=
 =?us-ascii?Q?ECX7QtOEgYOO9RzhySh8556/GBRLz7xFF547Hahonoxvv3CNKNDuk/kFNrM?=
 =?us-ascii?Q?=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?FSPrHNDWBeXk48Y5c1xCbr+s16Z5DhDdq7vHNvN4sTarryI7tPZzPzJxp3eQ?=
 =?us-ascii?Q?7Clnv/pNyoKzu75aQScUkhOr4ygmYikCLTV50grzV6rSN+d++6sQvMuJ1bCo?=
 =?us-ascii?Q?BL5bvvzYijE9MDlagnoS4+VT1VEB0yY9zZqZRApzU+3drZ9ELCu1s845vdux?=
 =?us-ascii?Q?oA67NNXvV79mfWweFt5XIs5tqUEbVQ6ErlDoxUuDcV0KLTmqwhaEDgANckuZ?=
 =?us-ascii?Q?b/MleIamJhEoSWbmIpVFYqeBBhn+EG+0+Ez+j78ZtStPMhIgXPPCC++RJOq+?=
 =?us-ascii?Q?xikua/Lzskd94mSEd5cupBRYudETIhn3KbPNTcieetwNLXHaXDfnbt+9cyIe?=
 =?us-ascii?Q?MYxOZFG1zXxuYxCtOkDHf8KSMGoAbtAx4kS71fCnAOhbUPQ+pDpNmPNn5vRL?=
 =?us-ascii?Q?6dV9JF/r5aXdbJauon/pUOIewaYmQjUKfR4VntgjucyO1QgdFMjwGoLwBUtl?=
 =?us-ascii?Q?bg/J9cs72eNGx0fcg5TSjFebzrnAaFkAABbxJcd85nyUMCl37UngkRAZxOSv?=
 =?us-ascii?Q?9n2YJjRlRrJtEt6OjG+gEkUTVKSFUAfcz/qvneXQwjO5nfwAwY4Dq2kMPGxR?=
 =?us-ascii?Q?a6um63f3xSYi7Y2x2yqDPl/8A7+VwX9THb3Q4abR55+0RnrITP5TXQYcNQjA?=
 =?us-ascii?Q?4WszQCa82JOiiEm0ydkUUQuEAR9frWZIWEKH0Y6g+/qtC/Foe7lBjD4MXvmz?=
 =?us-ascii?Q?hgeeyIxRDyI5a8aDqFB4cRZovttB1NYve1wAdMdP1Qf4rEQjaYUqmL5pFDv4?=
 =?us-ascii?Q?6GcNgLZB0+XU5wpYow6LcGVcA49LbD/bJtWdrfj/7XTUGKS2jnu8cZnwozyj?=
 =?us-ascii?Q?8bmrpzIQX+U0p/VLzbRGWrzB2OdAD5mKC4BaerpHTzEhUUt/YiEpYUVm2Zav?=
 =?us-ascii?Q?M+915+ajkO+VAkxKnfVmPxSznv9b9AuNO9nGsghPVhnyCwkCb5b7UcBvZXoG?=
 =?us-ascii?Q?5ZqIajoJz8W4mP72Jy+Xtjn7EhvKyX/JadLkbU5GXbOjhD5EMQ5HvFSuwJvr?=
 =?us-ascii?Q?EsFhlkLoWuVbUN6ePmrTPLFHqccQqy/qHZNaZvzQYBBsgq61eWWYQ9ktKgon?=
 =?us-ascii?Q?N+qXvSPhKov3g9vtmW5sgYuqeuyea9Z8WBA4e1QOxX6ts7E7c2YmxMMdh5Fz?=
 =?us-ascii?Q?yNiEhkMZXh2+ygsjNp/1BBvcOX5Hhw7ummGy1+fQCkm2ZNflDEaEgUC0OqgY?=
 =?us-ascii?Q?mrmsHkP1iKvCvhWFcpsL5Qo3aAz0MErHLdCylfSrGVmpsPY7WigWcb/CSJ/2?=
 =?us-ascii?Q?Yu0M/h6Fe9Q5yVigfK8rqSYOK2WZXmZZDwb7mfJXH+8aYif5md/PAAuHm/vH?=
 =?us-ascii?Q?sarzSjfJE9iGzwtGltQ7onbljckNSpNaOAEuBtxOBI/j/mGwL6WdDzya+uzY?=
 =?us-ascii?Q?BwxMi4Q=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: f0cb2edb-9040-438f-696c-08dea41f8b42
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Apr 2026 05:40:52.0419
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR02MB7809
X-Rspamd-Queue-Id: 4C41F46D482
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[outlook.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[outlook.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10385-lists,linux-hyperv=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,outlook.com:dkim,SN6PR02MB4157.namprd02.prod.outlook.com:mid,vsm_pg_offset_reg.name:url]

From: Naman Jain <namjain@linux.microsoft.com> Sent: Thursday, April 23, 20=
26 5:42 AM
>=20
> The VSM code page offset register (HV_REGISTER_VSM_CODE_PAGE_OFFSETS)
> is x86 specific, its value configures the static call used to return
> to VTL0 via the hypercall page. Move the register read from the common
> mshv_vtl_get_vsm_regs() into the x86 mshv_vtl_return_call_init(),
> which is the sole consumer of the offset.
>=20
> Change mshv_vtl_return_call_init() from taking a u64 parameter
> to taking no arguments, and rename mshv_vtl_get_vsm_regs() to
> mshv_vtl_get_vsm_cap_reg() since it now only fetches
> HV_REGISTER_VSM_CAPABILITIES.
>=20
> No functional change on x86. This prepares the common driver code for
> ARM64 where VSM code page offsets do not apply.
>=20
> Signed-off-by: Naman Jain <namjain@linux.microsoft.com>
> ---
>  arch/x86/hyperv/hv_vtl.c        | 19 +++++++++++++++++--
>  arch/x86/include/asm/mshyperv.h |  4 ++--
>  drivers/hv/mshv_vtl_main.c      | 24 +++++++++++++-----------
>  3 files changed, 32 insertions(+), 15 deletions(-)
>=20
> diff --git a/arch/x86/hyperv/hv_vtl.c b/arch/x86/hyperv/hv_vtl.c
> index f3ffb6a7cb2d..7c10b34cf8a4 100644
> --- a/arch/x86/hyperv/hv_vtl.c
> +++ b/arch/x86/hyperv/hv_vtl.c
> @@ -293,10 +293,25 @@ EXPORT_SYMBOL_GPL(hv_vtl_configure_reg_page);
>=20
>  DEFINE_STATIC_CALL_NULL(__mshv_vtl_return_hypercall, void (*)(void));
>=20
> -void mshv_vtl_return_call_init(u64 vtl_return_offset)
> +int mshv_vtl_return_call_init(void)
>  {
> +	struct hv_register_assoc vsm_pg_offset_reg;
> +	union hv_register_vsm_page_offsets offsets;
> +	int ret;
> +
> +	vsm_pg_offset_reg.name =3D HV_REGISTER_VSM_CODE_PAGE_OFFSETS;
> +
> +	ret =3D hv_call_get_vp_registers(HV_VP_INDEX_SELF, HV_PARTITION_ID_SELF=
,
> +				       1, input_vtl_zero, &vsm_pg_offset_reg);
> +	if (ret)
> +		return ret;
> +
> +	offsets.as_uint64 =3D vsm_pg_offset_reg.value.reg64;
> +
>  	static_call_update(__mshv_vtl_return_hypercall,
> -			   (void *)((u8 *)hv_hypercall_pg + vtl_return_offset));
> +			   (void *)((u8 *)hv_hypercall_pg + offsets.vtl_return_offset));
> +
> +	return 0;
>  }
>  EXPORT_SYMBOL(mshv_vtl_return_call_init);
>=20
> diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyp=
erv.h
> index b4d80c9a673a..b48f115c1292 100644
> --- a/arch/x86/include/asm/mshyperv.h
> +++ b/arch/x86/include/asm/mshyperv.h
> @@ -286,14 +286,14 @@ struct mshv_vtl_cpu_context {
>  #ifdef CONFIG_HYPERV_VTL_MODE
>  void __init hv_vtl_init_platform(void);
>  int __init hv_vtl_early_init(void);
> -void mshv_vtl_return_call_init(u64 vtl_return_offset);
> +int mshv_vtl_return_call_init(void);
>  void mshv_vtl_return_hypercall(void);
>  void __mshv_vtl_return_call(struct mshv_vtl_cpu_context *vtl0);
>  int hv_vtl_get_set_reg(struct hv_register_assoc *regs, bool set, bool sh=
ared);
>  #else
>  static inline void __init hv_vtl_init_platform(void) {}
>  static inline int __init hv_vtl_early_init(void) { return 0; }
> -static inline void mshv_vtl_return_call_init(u64 vtl_return_offset) {}
> +static inline int mshv_vtl_return_call_init(void) { return 0; }
>  static inline void mshv_vtl_return_hypercall(void) {}
>  static inline void __mshv_vtl_return_call(struct mshv_vtl_cpu_context *v=
tl0) {}
>  #endif
> diff --git a/drivers/hv/mshv_vtl_main.c b/drivers/hv/mshv_vtl_main.c
> index 4c9ae65ad3e8..be498c9234fd 100644
> --- a/drivers/hv/mshv_vtl_main.c
> +++ b/drivers/hv/mshv_vtl_main.c
> @@ -79,7 +79,6 @@ struct mshv_vtl {
>  };
>=20
>  static struct mutex mshv_vtl_poll_file_lock;
> -static union hv_register_vsm_page_offsets mshv_vsm_page_offsets;
>  static union hv_register_vsm_capabilities mshv_vsm_capabilities;
>=20
>  static DEFINE_PER_CPU(struct mshv_vtl_poll_file, mshv_vtl_poll_file);
> @@ -203,21 +202,19 @@ static void mshv_vtl_synic_enable_regs(unsigned int=
 cpu)
>  	/* VTL2 Host VSP SINT is (un)masked when the user mode requests that */
>  }
>=20
> -static int mshv_vtl_get_vsm_regs(void)
> +static int mshv_vtl_get_vsm_cap_reg(void)
>  {
> -	struct hv_register_assoc registers[2];
> -	int ret, count =3D 2;
> +	struct hv_register_assoc vsm_capability_reg;
> +	int ret;
>=20
> -	registers[0].name =3D HV_REGISTER_VSM_CODE_PAGE_OFFSETS;
> -	registers[1].name =3D HV_REGISTER_VSM_CAPABILITIES;
> +	vsm_capability_reg.name =3D HV_REGISTER_VSM_CAPABILITIES;
>=20
>  	ret =3D hv_call_get_vp_registers(HV_VP_INDEX_SELF, HV_PARTITION_ID_SELF=
,
> -				       count, input_vtl_zero, registers);
> +				       1, input_vtl_zero, &vsm_capability_reg);
>  	if (ret)
>  		return ret;
>=20
> -	mshv_vsm_page_offsets.as_uint64 =3D registers[0].value.reg64;
> -	mshv_vsm_capabilities.as_uint64 =3D registers[1].value.reg64;
> +	mshv_vsm_capabilities.as_uint64 =3D vsm_capability_reg.value.reg64;
>=20
>  	return ret;

Nit: This could be just "return 0".

>  }
> @@ -1139,13 +1136,18 @@ static int __init mshv_vtl_init(void)
>  	tasklet_init(&msg_dpc, mshv_vtl_sint_on_msg_dpc, 0);
>  	init_waitqueue_head(&fd_wait_queue);
>=20
> -	if (mshv_vtl_get_vsm_regs()) {
> +	if (mshv_vtl_get_vsm_cap_reg()) {
>  		dev_emerg(dev, "Unable to get VSM capabilities !!\n");

Why is this failure an emergency message, while the other failures
here in mshv_vtl_init() are just error messages? When there's lack
of consistency, I always wonder if there is a reason ..... :-)

>  		ret =3D -ENODEV;
>  		goto free_dev;
>  	}
>=20
> -	mshv_vtl_return_call_init(mshv_vsm_page_offsets.vtl_return_offset);
> +	ret =3D mshv_vtl_return_call_init();
> +	if (ret) {
> +		dev_err(dev, "mshv_vtl_return_call_init failed: %d\n", ret);
> +		goto free_dev;
> +	}
> +
>  	ret =3D hv_vtl_setup_synic();
>  	if (ret)
>  		goto free_dev;
> --
> 2.43.0
>=20


