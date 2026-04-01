Return-Path: <linux-hyperv+bounces-9870-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ONzCKFpOzWkWbwYAu9opvQ
	(envelope-from <linux-hyperv+bounces-9870-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 01 Apr 2026 18:56:58 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4525637E442
	for <lists+linux-hyperv@lfdr.de>; Wed, 01 Apr 2026 18:56:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DE175300F585
	for <lists+linux-hyperv@lfdr.de>; Wed,  1 Apr 2026 16:54:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 101D447A0B2;
	Wed,  1 Apr 2026 16:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="lV/Qq3CT"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azolkn19010092.outbound.protection.outlook.com [52.103.10.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAF7D478E2C;
	Wed,  1 Apr 2026 16:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.10.92
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775062486; cv=fail; b=cfdPsItwCvlM8dNNhL/YtUOIee7E4C4f9Cu4m6xG+AjH4945lQA23VFIBQc6GDUpaCiJtwpkevxnhV8pTU21sKlk1+iWcj1OO+NPBJHRUU2XGgi0lquuBkYnubCwa0hGiWNfgaZtuIGabyg8pK96hf+iKEzR6rahh2+5YgcsboI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775062486; c=relaxed/simple;
	bh=F3PeyLUN1Lz17Nfuo1F5QWugXIRIj067KB06tFnQWqs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=EBC5LjjafB1/ZNiAHY6ObDQ9mWCVTBK8lUD9oWofcKlYO8xqlWbYg5jGNoj+36W6MYt/2QY0QAioee7Rx9miTYAHB8Fcf8GOh4tjgAVmCyedAqmxxMphhl6yMeqrqCUhBkmB8me68LcLeBUDYKmfLgocX4JMP0p9RPNJUkOa0I8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=lV/Qq3CT; arc=fail smtp.client-ip=52.103.10.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ujlKI2/lFVp/KB+FQjXkwmsPsCRrWxMNlFU1qUaCDJfEccFieqlFBYWJiOZ9sCsrhtJoxaE6cCiHlxUjtczyMJ+kOBJHV4YVdRuARG54e8VwVZ9maRHdY1jzWgOUAiubn6bw2n9YfXLJu9k7f5u/0wB7qJ/tLjMJtstn80a6VCpZP4v/ijYEn7JM+MzkzJbOpibH5+9tiwfwi0E+w2ZIevSqfqtYUSWovH60jpS4bitqLergCMmA+5YI7nePfPNMDV0rgyzgngS4ZjYYKeryh/VYqHN3/U2fKQzAKGA4lPFPFgNxNSe0jhqKTZKsW5dqMIGC/XWfiK9egEdzZ8ukiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NutvBLGJY5J0hyDIdU373LHUwi9m4sK0zyAh9qj7Mo8=;
 b=Pps1sN7domdZWEwkkB5c/1SP+GXs2MbwRogKY01Zoz4GeBAI/E3iR+8FdEq4ymHkPt1cM8C2ptTLrxWBNA0b3KXR9qH/IjJNCyeUlrt1XpJdvRm41K8e4qppCgIhTwsOkvPT4lApxDH3sr9GI6LsKQmAf69Tj8EFgg0+JK9/ny7fSShil2BGbReP1TltABs+QOrBt3XB0/iaooiVRlbZef3l9k5pVIZzlzNZM+epfunX/ipQ1hCFU3D9G3+Y1UnoIdFYBiqdx4Ya2oxfPfzkGDX7tQmUpt+j6Yrdua6HRauZVUfuiVwmgzYHyN8A+bZgu+hh4i71CjSHdwTdg1FZyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NutvBLGJY5J0hyDIdU373LHUwi9m4sK0zyAh9qj7Mo8=;
 b=lV/Qq3CTFLCGOODUYVGiNvSfSkAA7fmIinZ3jAq2cI8ZZD6xflrLeQ8RxW+JAzCH0kVYKrwU+0rSDBi1EPwt4NkPlO9TAIoHFTHHSXjN4KriUPXqgkn/1KEC4LNoC3qD8vKC2/vJXxhxPofeMenYpv6OuYOG1ecikJ7NUqdhF0byh1t/u0Ud9uaj4GZsgJYBcRIeVw97W/x6Vm2sC45/CZ+gHvvr5HhEzJT8Q/ao6Zxrdi1FNnc4Vhtn0Wq0KzeV/lVVL+zl4v1nDlCJN8lZ1QE3P4pPPNRNjmv3GnxGhyH3wH+FmlcOgL1ga3Fh3owEd1q72sF0imDHT0J/9AyRcQ==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by SN4PR0201MB8808.namprd02.prod.outlook.com (2603:10b6:806:203::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.28; Wed, 1 Apr
 2026 16:54:42 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6%6]) with mapi id 15.20.9769.014; Wed, 1 Apr 2026
 16:54:42 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Naman Jain <namjain@linux.microsoft.com>, Michael Kelley
	<mhklinux@outlook.com>, "K . Y . Srinivasan" <kys@microsoft.com>, Haiyang
 Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan Cui
	<decui@microsoft.com>, Long Li <longli@microsoft.com>, Catalin Marinas
	<catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Thomas Gleixner
	<tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
	<bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, "x86@kernel.org"
	<x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>, Arnd Bergmann
	<arnd@arndb.de>, Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt
	<palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti
	<alex@ghiti.fr>
CC: Marc Zyngier <maz@kernel.org>, Timothy Hayes <timothy.hayes@arm.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>, mrigendrachaubey
	<mrigendra.chaubey@gmail.com>, "ssengar@linux.microsoft.com"
	<ssengar@linux.microsoft.com>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org"
	<linux-arch@vger.kernel.org>, "linux-riscv@lists.infradead.org"
	<linux-riscv@lists.infradead.org>
Subject: RE: [PATCH 00/11] Drivers: hv: Add ARM64 support in mshv_vtl
Thread-Topic: [PATCH 00/11] Drivers: hv: Add ARM64 support in mshv_vtl
Thread-Index: AQHctT5MQUy+plR6RkKYTgy6jJBWJ7WzSSyAgABqPgCAFtKMgA==
Date: Wed, 1 Apr 2026 16:54:41 +0000
Message-ID:
 <SN6PR02MB4157E4E088F39106979BE4EDD450A@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20260316121241.910764-1-namjain@linux.microsoft.com>
 <SN6PR02MB4157DFC7B7CE94500C89664BD441A@SN6PR02MB4157.namprd02.prod.outlook.com>
 <a8f856a0-49a8-4041-9036-4e9ade79532b@linux.microsoft.com>
In-Reply-To: <a8f856a0-49a8-4041-9036-4e9ade79532b@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|SN4PR0201MB8808:EE_
x-ms-office365-filtering-correlation-id: e548d502-4543-4392-c2df-08de900f5ed7
x-ms-exchange-slblob-mailprops:
 /UmSaZDmfYCy6WZBtXjyg4e4+qWcxdNA95Bgev0rEII1KwYQxxEhsl3B26tAzlCZYm273wN3byQ6quIEg9XCN5sIxI6Mp49x6i8jrL4WcAuytV/a9A05pgYcK8H9gNkgLzB1QhKs7obyWc0W9optx2+RFnXTl9/6ITldEhvb/SkI7kT1zH6+7BESthygGjbTQPqPcjgEeVDgDW/fyBbK9DWnWzG2uyArk135ennTqMGN5askxisvEHZDnx1d7dJVcdSyKAMQ48YfvyRphNfgNeUiBbbTe+Q/TDbQ26Nra+jk/vtjW10ZkZH4tMglcAFkIgUJKdafbRqLnWcGCiXtrtzfbnbQNDDRf7eGse/Ngx4ve1azCdJFvEkA2N7AKl9A3wqYm7yQTKpHIMnugg9+G61r2Xi2O+I8pCIF5aHlJR7qcpnVcitRQn7hnWAp2nWDQ8v1KGWNenCRb7YfnMmtuEbwKr0JxnEGha75qIrLJNQzW43jKG3afSZ+e4ClSs5cOtTFW7W9Yk7PudvnNhjNbTlOqrik9OHlwc56QAo80/CGhTIbxSbsvYRhgzdiWkjxq6T0ClW0DLZfiRIk3NwE6FQuJdOQgYzM3C0ja1JmCQV+pviOtrs6QqoQXq2v1HaAhu7CaRtupuOcVLCwgU+aCIg6ClJAlAjgeUwzVDvTnQmHSMK8UxtqlPInyRZxZCE/0UB5ygg7qskJFddjVhJ5qRHVtVIfLj36sMlt+88wvFLEsiy/n0AsDtaEzeFE6x8M+MbLN8tFaHUf9sGqlb4nTBPYh/Nl2UNj4ac1jTwa9tEDEom4dCKvsbwPKy3Dz395gCYODYzOOtdc9q+n0nF7zw==
x-microsoft-antispam:
 BCL:0;ARA:14566002|13091999003|31061999003|12121999013|37011999003|19110799012|8062599012|8060799015|15080799012|461199028|51005399006|1602099012|40105399003|4302099013|102099032|440099028|3412199025|26121999003|10035399007|1710799026;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?JX7pPG1YugHhGi9je6ClIoGBEFuyWa72SR8z8sDcWg3hLVCC0SSkqLLtviec?=
 =?us-ascii?Q?LfJoFnoohJFbJKCwuIXieKccEJ7/HbZzvWMaTzsMLnEa9KL0EMHuvwrkm+o5?=
 =?us-ascii?Q?B9rr6S+mzGW0ZF+Pv9toPtOiX8C4ggh7PIqK7/vhky5Wa7K7jdATvmeBGt9r?=
 =?us-ascii?Q?7e1BQDoPgmIvlUIdw5Y+MQYFMr+rsLWNPNUrvQS5cYtk50M/cLPgBSQ+UT0m?=
 =?us-ascii?Q?ZnqXhiAB75/KU/t94RZKMgAgncfEl+QzWvv57GNeqZT2SgsP9coQnQQMvDsA?=
 =?us-ascii?Q?KOQfH6hXY4qhcoDOo7usETUw1Q+yUtukKx2LjzXjSN0CAoB2lsjN01CzRvjk?=
 =?us-ascii?Q?S2zT6/iF+rj9bx8cAIE136VsMPJ1fMfMWjmXORcxd5ExEClKcAYzK9jZKvnD?=
 =?us-ascii?Q?AJLCS7KCgWvwp4cSyTp2jcNOdjrpbU/DQe5IQUkqzR8ZasbepvwoymfuupQk?=
 =?us-ascii?Q?tkpqRMOEmS65GC8kB3B/pcc9AIsHb+BYXk1u0r2XRwShFiVz6Bi6lnL/zicM?=
 =?us-ascii?Q?ULfZvVoSN8jHYiK2cOiNrQgAY+yg/QJ00sH/XXnrapCsh3r2Ho3ypsHoV8WY?=
 =?us-ascii?Q?O0z+Pl9IW/7A3sFmdGU4phOEnMJfwgS4MZiwT0VaeCJxEHcOs+c4608clk3P?=
 =?us-ascii?Q?c2fmTYoEXGMU+GmzJJTFWdz6EN+hYDviAlF9vPRxkDzX9mCisrcqvz5Hq8jq?=
 =?us-ascii?Q?h+jijqopx2gHSdQt7dq6xECYCpdGnwMQd3Amd28P6GbZVkjmmSQkCDdVTJOS?=
 =?us-ascii?Q?b8vk9Gn40qGL7of0ykP0rvvUjWLllmvsvJ8F+WwaCZ36ayuW8nqgwcHJ3x30?=
 =?us-ascii?Q?/5Mr9HwOHbXMGTI3h2Lq+n1/Xjmn67mK2pVeqiM3KQlYiNUcMS4TMA+ujrXZ?=
 =?us-ascii?Q?uwMndGIVHm42iWySRHZb1e4hIL+Mm4EW7VPc5ifSYDW/1MZZTNGcdr5XZHbh?=
 =?us-ascii?Q?n2sXaVWQLP88StoiGGIkFWE2vW85JD5/eNjma9EuF5BTuD/reJMo87AHhyxB?=
 =?us-ascii?Q?nENJzE/l9blWfF3F4eQezmztplFsduaaQ+DZvjfDRG8b8Pn/p/AxbAomutKW?=
 =?us-ascii?Q?78GWTwI4Gn8YgceIK41nAvNFDE7pPQYjZQhrsex2BmX1HTTSko3AXe6vu1cp?=
 =?us-ascii?Q?lR66Spw0RKod?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?X/ZZGrR7P9PCeSTgFG/AudO2BuRNJ74osmeS9Aea0IDJloHt0UGX/P3AxpCI?=
 =?us-ascii?Q?rsJdSt2AWZ1R8U7k/l08ndJcz2arXie3JAfUrdnBjhkkZYid5R+jRWJ6GXZ9?=
 =?us-ascii?Q?ssJKQHyL8d1M/G1MO7TNTnQqmZ3/6S201p6Jf1BuYrUS+eYyjaGcVUsP7c/+?=
 =?us-ascii?Q?JkMB3De+4+E5Cul8IZYRGXdGIdyNVNixX6/s4+awPbVRFEmYHpqaxDsZar5l?=
 =?us-ascii?Q?XupGgAt9LqW284fu3wW9qWYYmIkGuuZuXy1hJn/fr0rzJgFrTRXeEu9DjPer?=
 =?us-ascii?Q?MU3FRmiM03vVn6lbxfVP3f84pr3TqcdcosaMOvAnyw2Cmumz2OtyHMcdT3q7?=
 =?us-ascii?Q?4eSLD6pH0s0Kr0mz2Qj9ANYze2WjwUw6syqDzi7iLBOngJPt9yPUEVXEzxFr?=
 =?us-ascii?Q?kbheMufuHSPolzkdp+2qqxBQuoxUKNHZ/74/yCoiMk/+j4+PlS3FR83mLI6b?=
 =?us-ascii?Q?B/FWxjHcFSspsBQCWvyDtxWiue8Q2Nne6+DdQcipwpmn4xsSn/jjNNRyhH7m?=
 =?us-ascii?Q?QMIOhcABmc5I0qfPvtUGb/8FujVraaevzX3TLTnzH3iGkZWpRWXxGWYMDM4m?=
 =?us-ascii?Q?q0Hf1xnpV28PwLQPWkntPdguTRM4Ht337WzjCEKxLOg2AuPGDNSKX/p8SdjV?=
 =?us-ascii?Q?f/jaY2uwuoi04TIGCpxD94ShRzsryBP8VeHBc/tG0eV/Zkrt8rISQvKstHms?=
 =?us-ascii?Q?G550ASU3VC/hBG8AYa07dHC8cTZEVZ1ZPNZJkDwyPT/eUbTe8Xdsp3jZg4QP?=
 =?us-ascii?Q?kuo0bdIXHCntmYZ3YzKcSWKwevujLAYtS5KubDDfpXB+QM6946EMkh8C/vM4?=
 =?us-ascii?Q?5HJeh+2RYpD+V+9Ys/aVu6z4Awrqru8fiXbNpzVaxOCW+oI4DuJXabcEmNQE?=
 =?us-ascii?Q?j7UoaTlGsMR9rlBxNwAokROkU3uhLmekyFPsjhcjWpqNBCE/ZobPDSYV6Pej?=
 =?us-ascii?Q?dVks7rRzZq+T18ao4jIXdCRLkZE2M3qDrNKRUQS+06UnzaFuoE9p0yaER9n9?=
 =?us-ascii?Q?d4+sM32uFFu2Bfgr94XBjerWpzlZTWj1YvZ7Jb2sdVKIQtP6qvjEGcrHX4RK?=
 =?us-ascii?Q?w8uaRkqYxhPEpBtVL1FHU9sr6b1SwwI8ONabfcs+8zDPfZVevxlLdMTyzXoH?=
 =?us-ascii?Q?D1j/YIqHMgVKwuwWkT5yjb4Ko8v+l/Qw6SWelb005bTD/ptlX72MGuTBZciZ?=
 =?us-ascii?Q?aI3kAqqynwYnh3FhlfbQCnuUQTKKVK2HBp+piZEJ0AaQzSRFvb9woC5ubuLC?=
 =?us-ascii?Q?quYFjISo5qbGKIVC7DtPc1hsH0Twm+QCIAcXazugt8ts+M+MWFgeHTYBSs3P?=
 =?us-ascii?Q?iP2h1GkUMTpqW0yuUCb1Df+WJY+LubDHR+dfd/+P8F7HveWK9EBVRzIspgRZ?=
 =?us-ascii?Q?p1gcFA8=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e548d502-4543-4392-c2df-08de900f5ed7
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2026 16:54:42.2851
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0201MB8808
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[outlook.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[outlook.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[30];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-9870-lists,linux-hyperv=lfdr.de];
	FREEMAIL_TO(0.00)[linux.microsoft.com,outlook.com,microsoft.com,kernel.org,arm.com,redhat.com,alien8.de,linux.intel.com,zytor.com,arndb.de,dabbelt.com,eecs.berkeley.edu,ghiti.fr];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,arm.com,gmail.com,linux.microsoft.com,vger.kernel.org,lists.infradead.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[outlook.com];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[mhklinux@outlook.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[outlook.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-hyperv];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 4525637E442
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Naman Jain <namjain@linux.microsoft.com> Sent: Tuesday, March 17, 202=
6 9:23 PM
>=20
> On 3/18/2026 3:33 AM, Michael Kelley wrote:
> > From: Naman Jain <namjain@linux.microsoft.com> Sent: Monday, March 16, =
2026 5:13 AM
> >>
> >> The series intends to add support for ARM64 to mshv_vtl driver.

No need to be tentative. :-)  Just write as:

"The series adds support for ARM64 to the mshv_vtl driver."

> >> For this, common Hyper-V code is refactored, necessary support is adde=
d,
> >> mshv_vtl_main.c is refactored and then finally support is added in
> >> Kconfig.
> >>
> >> Based on commit 1f318b96cc84 ("Linux 7.0-rc3")
> >
> > There's now an online LLM-based tool that is automatically reviewing
> > kernel patches. For this patch set, the results are here:
> >
> > https://sashiko.dev/#/patchset/20260316121241.910764-1-namjain%40linux.=
microsoft.com
> >
> > It has flagged several things that are worth checking, but I haven't
> > reviewed them to see if they are actually valid.
> >
> > FWIW, the announcement about sashiko.dev is here:
> >
> > https://lore.kernel.org/lkml/7ia4o6kmpj5s.fsf@castle.c.googlers.com/
> >
> > Michael
>=20
>=20
> Thanks for sharing Michael,
> I'll check it out and do the needful.
>=20

I've done a full review of this patch set and provided comments in the
individual patches. Some of my comments reference the Sashiko AI
comments, but there are still some Sashiko AI comments to consider
that I haven't referenced.

FWIW, the Sashiko AI comments are quite good -- it found some things
here that I missed on my own, and in my earlier reviews of the original VTL
code. :-(

Michael

