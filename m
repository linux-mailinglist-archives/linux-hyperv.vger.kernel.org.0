Return-Path: <linux-hyperv+bounces-8581-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4D2IHZnjemn5/AEAu9opvQ
	(envelope-from <linux-hyperv+bounces-8581-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 29 Jan 2026 05:35:37 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E5E69ABB12
	for <lists+linux-hyperv@lfdr.de>; Thu, 29 Jan 2026 05:35:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D7D303013842
	for <lists+linux-hyperv@lfdr.de>; Thu, 29 Jan 2026 04:35:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 086BA2797AC;
	Thu, 29 Jan 2026 04:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="kVXURQ+d"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazolkn19013095.outbound.protection.outlook.com [52.103.20.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98D222586FE;
	Thu, 29 Jan 2026 04:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.20.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769661333; cv=fail; b=uJrefodRtFaglVFrV4U75EQU75g44NgzaaOJ9tLB3exL3xoDQQl+nFgwf+cX95DKj6YgXwPKhyQED9RdFGmxV77GBja2gPhhIy5u0rEvJzD8x/vHVVJUJ8rlwgo9PA5E1X0wycVBzEx6gVnqVXvqx9dvhrXBqKFcZZ5kp1UisRE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769661333; c=relaxed/simple;
	bh=XlEoM7m2NlSvDveCRuMu5rhp6+AFM13wtaFBB86s9WM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=chErCIoh8ZH8ySTY3TT0idoe7/y7zTRcfdrGu2CkXfsuR9KBC8jY0Vg6JlEL4QkwyaQ1UrJ1csMztAExfYtgT9xc7QHXFKP/dQrT1ysq3SOuNVHF2vPNb7x3+ZHDZJrRcQ7Ia9QtGv1hHYdjC2Z7U0BXTe5fJoaHSir3TLy32EM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=kVXURQ+d; arc=fail smtp.client-ip=52.103.20.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mKDajKvwO+bYe1hV5sqHoOaeBVWAEyTUzp7z2a/KrWusa4uFF/MicTLtLedDF0JpPJWq49Plwgvif6hGmhC+Axm87HEzfBZGjwoSZD3z/9Z1CNYUI2TD/EHZvdhs7FN7t2YSqxlidWLlDaYwhNxgjlR92x2amOxB+hRb1aohOcC+5QNacVDp4v9oq99zvAgrcRtIqdLWmkjkuIDj5AiC8HguTscpZZpIy2V4psSPW6BL3tH5OZ+x9JKaWwT7BD4T4lg911Nwq1H1bGTYCdB2xG2YGZXd15HgPtQ2Z7PaKN6nFLXiHTZzV1FYcrA7KeiqmXZCLaZNM8s6XWVfu76hxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2J0Mcds6n2nyiGLSo2/OdxoubcDtQ56U0x1MIWqNrMk=;
 b=d45Qep+/eBO/gKfT6ee6viUF8k9S1jKmjnWi2+0yVATdRMrOHxtdrN63JqcBW3KXozQ/PzcG+2ztnHUaULUJEMkdcM0XqoV6ZV9+JYyQWNJDcDSJNjwuSPY9RkZxtmdkgfWn5YK4i8utjoqnrovlVIOl1wa/umacltFMhAawq9LsEiFhg/4wK1x2Js19j5ZLSUgtbI8uWBJipISUixpx2JTjAA+nOXYKOpfw8ErdJUEpJ//WJqVs40kbzU6lzpBF14QcyQ/c13td73iHfBFswTIG/CFQXgU6C2ZZCcMQm6xqXpdUPy4I2eyXjxCkv0Dr/bYLVbfbNYF6MMogElr18Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2J0Mcds6n2nyiGLSo2/OdxoubcDtQ56U0x1MIWqNrMk=;
 b=kVXURQ+dIs9EQOLARhawwixRMMbEBU/PjXvRLOgCzEJAEPCbMKhcWkEYy2Y+9f/QIg7/8HdAsk5njuvNwmHs0VrFi6pCInRhKeaeIPIYNrZThbIsCMzUfiMKLIDdS5GPenWcjWkmoQSCuROZwkfWTarfkQxrhpPguNkRzZTGxxOzr0iDglpmKxtMv2ym9lVZdG81v0tM0fLZNwJw9lCk0YAcI90JSEDWr4zPYFeFxOX8wLsGB+qLF8EvZvhx1Pi2nvX/u3QLcaOjUgAnqcIfi8mamdu84w9wYlxXB/Mpu3ypwBWJBxPdulhhWQIsJFzkGd2hSMtrFNzEMjknVex5vQ==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by SJ0PR02MB8561.namprd02.prod.outlook.com (2603:10b6:a03:3f0::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Thu, 29 Jan
 2026 04:35:30 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6%6]) with mapi id 15.20.9564.006; Thu, 29 Jan 2026
 04:35:30 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: "lpieralisi@kernel.org" <lpieralisi@kernel.org>, "kwilczynski@kernel.org"
	<kwilczynski@kernel.org>, "mani@kernel.org" <mani@kernel.org>,
	"robh@kernel.org" <robh@kernel.org>, "bhelgaas@google.com"
	<bhelgaas@google.com>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>, Michael Kelley
	<mhklinux@outlook.com>, "kys@microsoft.com" <kys@microsoft.com>,
	"haiyangz@microsoft.com" <haiyangz@microsoft.com>, "wei.liu@kernel.org"
	<wei.liu@kernel.org>, "decui@microsoft.com" <decui@microsoft.com>,
	"longli@microsoft.com" <longli@microsoft.com>
Subject: RE: [PATCH 1/1] PCI: hv: Remove unused field pci_bus in struct
 hv_pcibus_device
Thread-Topic: [PATCH 1/1] PCI: hv: Remove unused field pci_bus in struct
 hv_pcibus_device
Thread-Index: AQHcgxvbxTpq11Tjn06iuwMa8TiYF7VoqkXQ
Date: Thu, 29 Jan 2026 04:35:29 +0000
Message-ID:
 <SN6PR02MB41575DE702FAF2BCE5FD38CFD49EA@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20260111170034.67558-1-mhklinux@outlook.com>
In-Reply-To: <20260111170034.67558-1-mhklinux@outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|SJ0PR02MB8561:EE_
x-ms-office365-filtering-correlation-id: 94c625e4-0c32-499e-1ea4-08de5eefd52b
x-ms-exchange-slblob-mailprops:
 Cq7lScuPrnr9cOglUl1urTSFBsjx1OD0huxaSd7s7v4s8+NnFQi03yyqMOHCMLlUNNJii47drNusAr1GTk81rvLxmTSSYfdTqIbWQ6jdTTf80FicyHvYZ0eEqeJGa8bSE7Rcfa8h9Ly/AHsa2PHcxHgkuRFQhpn98daJ+dJQN/7HALvIJ8Wdvt9L75aI94PrLfpeAK7298ReJsrkugPezXklT2WtGZvFC5tLmudisb8k9k9O6Fp0H7DEl9a67/w5QUBABXDTRZv3rr50QCFEBTfMTtdTgIhNT1PzhGHDRf8xSPbyRS2HLS6aIiicpyzGEaclqobxthstZ5SnfkmbN+pW/0U1rC1xJT0XEKNdEwA80Dot75sw9GMyB833dwJKkyVmOP65Ac9bYhhyrfedqzp1W1ngN0Sq/D/6UGC6HNeL3W2yK+DE5kT+Wt8471z63tVDj8/JHDaGn/UTmGmsjchmhN5oMPSxC1SbkDjEzVkjRNNhTKRgYPYBt6FvC/xZomcPjgFyLAN678XLNd5M2+oZBnZla4V2g3sgZHgdgS132F6knx72FP/CgMnJel14epf6Ek0TxfnW2vKp3Ef0W+vRXfvR1FQBq2LTtzmSikZAjNrZCtg6Ju/BxeIcEixSsV7amR1OQ9gAAS23hyDBZCBIgw2GHvzTJivXr0mZPzks4H3Mv+CJUmcoWZIeWc6IyrWizy9Ocm0iwp9w/Z7sGxkSwyZW6bZR88QftbgKULDv+b0iJ8oLIJz4+bHQAY922i8/Pkqq1NI=
x-microsoft-antispam:
 BCL:0;ARA:14566002|13091999003|19110799012|15080799012|8060799015|51005399006|8062599012|461199028|31061999003|440099028|3412199025|40105399003|102099032|1710799026;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?mzBMecDAO3X0vfJMaz7gpW0nvrdO8VvxgsCW6IFqIDs8VOLEbKIJgVfpwH+5?=
 =?us-ascii?Q?pB2CsDlN97v3Ngh0APoxTZvD6FaSw8l/fQ1cAzperghi4VfxRQYiYBy1i8GV?=
 =?us-ascii?Q?QeIGoP745WdTur1L2wzRjsULuI0ylEfsGDt3eMbqzKZH3scuR1w8Tn6Umv1j?=
 =?us-ascii?Q?9HsKC7+Rw3riDkocJftVUuP2ZuK27sDBSE2/5+ujgWTqOkXWqXAp8SEQr5ED?=
 =?us-ascii?Q?9rPLxs2HQoxQ/PnrTPfVCfAfAO/s2Ys42jIFwM9Off/S09UA5uHVpROqFYAf?=
 =?us-ascii?Q?PfOqu7dMbFxNjDp7hGOnZedk5hQL2seTmq26E0Ysmh0t5UGPem3zHHs3gs6F?=
 =?us-ascii?Q?jREaCriV2z0NYGqtG0iwajN1UHoUywSQIuBQzXz76ZnCbmWwqzlQILfVXHLE?=
 =?us-ascii?Q?SN5UHhcEdMnvoa8PfUTqrYjdQ606zRmrXGAbQosPrgJ5nlwzCj+ucRJc/9C/?=
 =?us-ascii?Q?59/FaxJj5ieob+D3nkdtoQXgfPIv0zDnRL3+SfAQZGkUZ4eBGiiP/7a0rU9G?=
 =?us-ascii?Q?g1uxpY2xUe4/zYjZ81Uz5rPrfU2ClUC0b4i127vVQIDTdeGWO3rdDFL7dXmp?=
 =?us-ascii?Q?jHdsGK/vxVDp7AEp69HNvuqqK3FrKkS/4VmujPjhhWIGYsop7fhXm2bPa+WE?=
 =?us-ascii?Q?aJcAkqHRI8undNjTSvcJkXweoJtZTVmpy51brK3WVB+ND/ePEj5b/gPNg3k7?=
 =?us-ascii?Q?ot9fe+tFF8OUluiY3bDfyvQ2Sz7cOZrlXkLC6Zd98dIH42xjV2wTNfvgKelR?=
 =?us-ascii?Q?aS/Oy42N3NDLacAjRwjkMxQ8IuA/5QxOLlFUwPtsJQ5wuIJmSmxRA6slzs89?=
 =?us-ascii?Q?SS0lIrsBuaqXPU+Wk9aHPVJxeGhzaltK9hKTfFPmq+5bk3FVJ2xO1f7ZlnOM?=
 =?us-ascii?Q?q5ctvTNEoW83mCsVI2kb8a16IU92eg/de8y11Ud7RASxPQmAyOx4kawNCwRI?=
 =?us-ascii?Q?X+hF5SNqiT+ISvxzsyTpFI1fnl7vNj1zFvNzlf5VKDpAP97TZyhxLOXLHSXC?=
 =?us-ascii?Q?dvCE2cYV7IyyGSpzZmYtSggkL0ebvuMlpEBe7tIe/rE5wMAKa/07Zdj40P80?=
 =?us-ascii?Q?W+Wz5hAfyQeR8sR5UKN74GyF6CCXyZ0cJxmVfip49RmvrQ5P3/Kf+d5bxPSz?=
 =?us-ascii?Q?w2fqLARlsIzvAz16nIRQwA9jcTEi/ex65eLrNW2gmD2iZl30yZDS6zig08D9?=
 =?us-ascii?Q?zG7QkR570NIN9t9UnvWvHKavrVvdizQG8iPnsCSqQKOITBu5z7tPeJuvpS4?=
 =?us-ascii?Q?=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?axtgk6uD+hAYN77Pv2LNVj7cTYKiwn+t1yZyz9VVj7noEf/+UvdTTfyOdKal?=
 =?us-ascii?Q?K0E1+K5kjB+hL2x55B5tdqwHANGMDU4MWER0yxr7m0Vd0XYAuekRTxh+HPJd?=
 =?us-ascii?Q?leTW3bB28gJQsPSLopMS77Knf3qqTXvSengyKRxVDKpYkcLCqXNkf2Ta6SIE?=
 =?us-ascii?Q?bQUNXPhGTg1hMOC1QMUngw4BmyQWTY6AK6hfABhHSFb1crHurRq27oQd4iJQ?=
 =?us-ascii?Q?c2DJbzlaktYhW4Uv2PugA9fX7ZiBxQj5b02rDZkMLdIVyCXgzapgQ/R7dlvl?=
 =?us-ascii?Q?c2MKh0nzjK8pLDjaopoJnZzsAASMtHFTp1bcRMDL8ntfosN6L5C+cYccAsl/?=
 =?us-ascii?Q?V0kCPGisKG/ySQvEvcjfoGgSkWvkY4jnTIjnzHiHnuJgtRgHJNsTGNtpDKZw?=
 =?us-ascii?Q?IbRJHpJjHhr7h5V2wVOkAhOh3nRHIBT03Dl1rsdfyxoS/1gdJbtOEAZnYUel?=
 =?us-ascii?Q?oXpiECo/MnaVwwgU4F3H8S1AQBL3lVAan3+NuAdfM/yxhqV5wrTFOGuilplY?=
 =?us-ascii?Q?KH82SnjQYIcSjKVvEMXntp7RbNeyMBWxt4H+O7aHvn2ErCg2CELCexXKIvAd?=
 =?us-ascii?Q?qp4DdyHr46lu4UeMEcRzkkqQyBI0SHv78NYM1a30zvxk+s9Eus7JFCW7C/J0?=
 =?us-ascii?Q?+zxS7b+/tes5JQwgBIWYe0ZuPk2ybXvl5QfZOYfIISQ0y6yo7YqwjlELGMuY?=
 =?us-ascii?Q?0eftTQp3q/qpPlH7HzJSkPk2m884vwsnev0Bx/Mb8eQg5BLVyaCBqvNwVwLB?=
 =?us-ascii?Q?WZ2SL3oxi78ZDSpAfEmzWNMGYZtK5lW7nz7XfzGjYlCLcSTbC8UNgwCgFpeF?=
 =?us-ascii?Q?e30So9zwYZxdPCWoOud4bNkdGjBaCJNC8wL9JQxJx/XqVYwoAZHgpMZycBR0?=
 =?us-ascii?Q?65MxtRW+N5a4FvYxIyzsJkJFa0ka/OC8xWG4c69K2u/U4sownyVy6mkpAjkh?=
 =?us-ascii?Q?iYkFTh614cQ+tocnTLSfDJaSqkQa7T5qw+fBHPuURb7l9tNWYJ4S2Bf/hJuP?=
 =?us-ascii?Q?qwRK+AgZF947Hkq7AD2sbjXaKGqsHatWJ3sDIHCePBoS/pnpXqFn0GdwDfVj?=
 =?us-ascii?Q?OEuErVaKniE+Pr2+2JQL37WtvLlRMoobbL+kCdjfW7Nnc9ja0AQFtn0fkY+V?=
 =?us-ascii?Q?W1o7pDVLQVZUACAYcXqqvaJhPLielQWq01QjWg8YeOCbbVl8/rI0l+PcqCax?=
 =?us-ascii?Q?RPeJ6kf98mzyntQ14kZGTkTHwROw0fVAfW8XOu6BI2joNgSA8CakjNfdMaqt?=
 =?us-ascii?Q?z+345qf3K4H+m8030l7c1Il/gR541087mM6TifMCFUDARdFZ9ZPYReNYcmM8?=
 =?us-ascii?Q?YkOOLLuZHmqfzOPZivHHOS3VIGjXsxec0WkeZsm6KL02PYKc2CIvtkTa+WEo?=
 =?us-ascii?Q?QAQjteE=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 94c625e4-0c32-499e-1ea4-08de5eefd52b
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jan 2026 04:35:29.9170
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB8561
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[outlook.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[outlook.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8581-lists,linux-hyperv=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,outlook.com,microsoft.com,kernel.org];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-hyperv];
	DBL_BLOCKED_OPENRESOLVER(0.00)[outlook.com:email,outlook.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,SN6PR02MB4157.namprd02.prod.outlook.com:mid]
X-Rspamd-Queue-Id: E5E69ABB12
X-Rspamd-Action: no action

From: mhkelley58@gmail.com <mhkelley58@gmail.com> Sent: Sunday, January 11,=
 2026 9:01 AM
>=20
> From: Michael Kelley <mhklinux@outlook.com>
>=20
> Field pci_bus in struct hv_pcibus_device is unused since
> commit 418cb6c8e051 ("PCI: hv: Generify PCI probing"). Remove it.
>=20
> No functional change.
>=20
> Signed-off-by: Michael Kelley <mhklinux@outlook.com>

Could a PCI maintainer give an Ack for this trivial patch?

Thx, Michael

> ---
>  drivers/pci/controller/pci-hyperv.c | 1 -
>  1 file changed, 1 deletion(-)
>=20
> diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller=
/pci-hyperv.c
> index 1e237d3538f9..7fcba05cec30 100644
> --- a/drivers/pci/controller/pci-hyperv.c
> +++ b/drivers/pci/controller/pci-hyperv.c
> @@ -501,7 +501,6 @@ struct hv_pcibus_device {
>  	struct resource *low_mmio_res;
>  	struct resource *high_mmio_res;
>  	struct completion *survey_event;
> -	struct pci_bus *pci_bus;
>  	spinlock_t config_lock;	/* Avoid two threads writing index page */
>  	spinlock_t device_list_lock;	/* Protect lists below */
>  	void __iomem *cfg_addr;
> --
> 2.25.1
>=20


