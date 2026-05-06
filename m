Return-Path: <linux-hyperv+bounces-10650-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UMuqG6tb+2mUaAMAu9opvQ
	(envelope-from <linux-hyperv+bounces-10650-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 06 May 2026 17:18:03 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B346A4DD030
	for <lists+linux-hyperv@lfdr.de>; Wed, 06 May 2026 17:18:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D7EDA301E3C2
	for <lists+linux-hyperv@lfdr.de>; Wed,  6 May 2026 15:13:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0794947CC80;
	Wed,  6 May 2026 15:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="ecodGwgv"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azolkn19010028.outbound.protection.outlook.com [52.103.23.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58DA42D63F8;
	Wed,  6 May 2026 15:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.23.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778080419; cv=fail; b=LH0JK0mexnmOBJei+zlspu2cNGqjlORmZ0/i037MWdV1ytNHpmYuQ0cXqcE7A/9QUrCzdUwY2ls3/3XWvmdnPJz+8pLu17vYlyRzpKNOpCDgagUUIOqeVBfsUeqA3zxGSLW0DZQidazdWCN4DmiKFt2V1XMUFs2PiE7L0vL4N40=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778080419; c=relaxed/simple;
	bh=orqzW0Lyja0B9FOhMdo1Yk96iuD5MGIiFVHFFBUx1aE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=puGDrQHMHKLuPiOUb8a2XYVvP56u9/1Bdy83W1uaFCn1ZaiVMac0VsOj8k4NukFxhlbsjRD5jzDej2nJosq9PufLvw+nXuJbYrHaPwRd4F0JG1oK4yUoX01ImPeWdZSG1tcMapAN2nkwleETYVNubVLGf41e1ZN2pb8+Y5iB3YE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=ecodGwgv; arc=fail smtp.client-ip=52.103.23.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P+bQeuVQPJ/b5qPLr2F0iUYdhelR0MsgAZxI6H6VGOrHtf7jilU64CVth3ReTUjIFozIx4khwHr18xoKar9e+whV3DQKJWv4LEIDPyJaBtzOq8VBL9jJFu3/nOiqBugEZ1XXr9XKioFxGhcSNvx0pk+whHdbLztwZ/OYChwEkSuuMNhV/jLVugRQYZSVzMbaYPyBA0q4T/Q8T/T/HiY5ZkH+MTq2Nm20toMKxi1ezma1ceiUQy2Bjy5IadSg05qQvePCpVy+oj8gp82aLbnZgSRgX8JBzAcljRl9VP7oXAjhKE2gabyJ5j2FoElzjFuQn3dTp4t/+k89qOjLZjEOwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p/v/HEQyT8019YoFXauMSB+Iv7VOGBxSjl1hfm62kKc=;
 b=Q/p76CjxU+3LnAhW6O3wNiicAS+Syog8yXHdxiMNvjzfOfzijTQkj+S/miuB4zxaA5cKhbZtq5Y/coPPAHWka1y5+ijwtjpk8da4L/4BBXkwa2jFyQBRQ1AD7NTPPkuAzSJAoLPs//OEKeW6gcKHOXM+JMY+szfWoVDjKARr192ddBqYHV0mxTfLfucwgihyWwnPalFmnnlUYBHmYE0I5Bj43sCaG2tlT8g7A86/vuPyV23bGP2PeyATMkwjFblAd/SSUHhTVyjUFt4NilIF9aw8AtXyJW9spgJvsXwNfZ07Gl1YNdUpmtu9TLwb3Sk8mi+Hr1s611vNQD0h16VYYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p/v/HEQyT8019YoFXauMSB+Iv7VOGBxSjl1hfm62kKc=;
 b=ecodGwgvRZVSneN9649b0Why+LghauvV3p/rJGEw524QYzmht1sWEQjmbzkMT6BbpsBhIpJjWZdi2V9/8LsVgE4fH6v9Nb8Bns5eMgx5reOOh98mQKpI0cpXGtjARebbbl+AVoiGrgCFjxeI1/FDu3158QawzxzjIZOK9K3TJZcRSCnS0fk9HNha8HVdJfsszDuXwFcrSd+cpHsuhbbwTes2nSx5NcksUgvxiJg6eRikaJZU5tIV2NMFJdhkjLFTPHxWxukjp8vEz2QN1DdYV+Ksfl0QNqRiyOh1flUTdU57YYeu1FsX5ti6pQf1RpIUhSOVaMmPFUnoR6wtbA5yfg==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by PH7PR02MB10105.namprd02.prod.outlook.com (2603:10b6:510:2e8::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.27; Wed, 6 May
 2026 15:13:35 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6%6]) with mapi id 15.20.9891.008; Wed, 6 May 2026
 15:13:35 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Dexuan Cui <decui@microsoft.com>, "kys@microsoft.com" <kys@microsoft.com>,
	"haiyangz@microsoft.com" <haiyangz@microsoft.com>, "wei.liu@kernel.org"
	<wei.liu@kernel.org>, "longli@microsoft.com" <longli@microsoft.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Michael Kelley
	<mhklinux@outlook.com>, "matthew.ruffell@canonical.com"
	<matthew.ruffell@canonical.com>, "johansen@templeofstupid.com"
	<johansen@templeofstupid.com>, "hargar@linux.microsoft.com"
	<hargar@linux.microsoft.com>
CC: "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH v2] Drivers: hv: vmbus: Improve the logic of reserving
 fb_mmio on Gen2 VMs
Thread-Topic: [PATCH v2] Drivers: hv: vmbus: Improve the logic of reserving
 fb_mmio on Gen2 VMs
Thread-Index: AQHc3Cj4JcyIp9ismUWd/PbowQcX/bYBHXtA
Date: Wed, 6 May 2026 15:13:35 +0000
Message-ID:
 <SN6PR02MB4157A5A68BDBC87995FCE85FD43F2@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20260505004846.193441-1-decui@microsoft.com>
In-Reply-To: <20260505004846.193441-1-decui@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|PH7PR02MB10105:EE_
x-ms-office365-filtering-correlation-id: 7b26f5a5-85b6-4822-7082-08deab820b05
x-microsoft-antispam:
 BCL:0;ARA:14566002|8060799015|41001999006|19110799012|8062599012|13091999003|461199028|55001999006|19101099003|12121999013|31061999003|37011999003|51005399006|15080799012|1602099012|40105399003|4302099013|440099028|3412199025|10035399007|102099032|1710799026;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?2dkmDZxfS7B/FS+na9vaRxyRkSV70YnUGUHHfyQ55JYpjPI7yPl5M/upvXtZ?=
 =?us-ascii?Q?CAzpiwl0lZITS0iZY6OismABPOwYJySM2inHYjg8agiEdHODFg7/MouFpEwB?=
 =?us-ascii?Q?4Ewd1BObcs6kj8P8NGjZfj76fNLMKl/uRoqkXFnCK9SCj4Fb34AFiM+CVjGZ?=
 =?us-ascii?Q?P6Qh0T3uMRDxelPTBr2fhbS9Lrzeh8pd4qPTix2sN7L5Cf9JEgJ7W9I4bJMu?=
 =?us-ascii?Q?67oe8yVe2Bb3nWMp1XytAWZOaAJopPl9Jd60Nkp5yhTgPsDC2BdIj4KX4tIX?=
 =?us-ascii?Q?LHHs+oDOmcfBQuQrsMmsZ3tcg5Ea3NmCJJpW+Nv2Z7WbIwp18w4HI7BzR4eH?=
 =?us-ascii?Q?iZL3SJ+poWDGJ+MP7ySUbtmHodcS2cy7d9elQ256NjMQ3JZaS5XkxEnO6cLZ?=
 =?us-ascii?Q?I3WLQ622+4aXwg3Swlf4AOtoSf11iviKY/SWqSr4KX2tR9FOVc8w2ugXCO+R?=
 =?us-ascii?Q?glbBpuLcChuzSk0t2RhHXEKwxec2zt0yLL4ZSDJHMJr0o31igGLq14+2ClG+?=
 =?us-ascii?Q?yE6UigRntss5no0HbDquCJpkXFuZz5Mppo/dLixJww4Lf1g8b41tn6zG43OH?=
 =?us-ascii?Q?F78g/dtnngOia6mcHeNvHMVab/xFN+z1pAOwF7+0sXvXP9jE9yFwwkIlTMgN?=
 =?us-ascii?Q?QSIe5xLyy4s6E1Dft1gh7uB+GO3we5swv1xIHCk+vjzRF6+mM4r+g7sPaP2P?=
 =?us-ascii?Q?dyKbiHckKFrwk6ZaiFcKomrYhXxtN8cmZ//Aql2Hp2j0EiS+aYAn7XydWcLM?=
 =?us-ascii?Q?o3vFxxCi3HTqWK+kXBFLblF1uWHu3mE+hm0uYRl4leJlv+ntr0hhDSFLd+p+?=
 =?us-ascii?Q?MTO822EiANe5yXtcNGwC4EYxL5Zn0f1Ms3BzaPQxizcgRmXwuiFP3RsJckWH?=
 =?us-ascii?Q?QSq/eS0uo/rdKG8s0pu6jOR2rdA41axCpk6ib93JC8XQhQ2uDTUDYhBzOkqA?=
 =?us-ascii?Q?tlGzrxJL9SEnuajrCM+j+qLy30O88voK5EtOwdYVzvRFZInjbgpYrodSiMY9?=
 =?us-ascii?Q?8X/zYBGLZRYE9LSrY0qa7v586ZxTq4P6dwll3IDu6ozN9VWv+UmKAQ/ru4+K?=
 =?us-ascii?Q?KIHWvB3vHFsGyRcMLdRvlhMoUvOjQfzrNkjKP7+UP2PSFaWvdrhT6ruVriRP?=
 =?us-ascii?Q?YBc1hE+jyHnuD8BQQ3bb11AEq0Jf71kD5JP3P5jAu5gZpZhYX+v34BTQL+iD?=
 =?us-ascii?Q?9ZPEQ1ThERyaQPYzmpdMqz0yRB6NP8+Z8fRpkzrbpvmFry5SV7Yk+rJDeA0?=
 =?us-ascii?Q?=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?2lofkE6jzMBq66cIP0TNrv9aeH8SYIa+lXWSL8TjjcoxFxechuMzCC+LF7NK?=
 =?us-ascii?Q?TBRekrMBxMFdkLrcp8EzRsxUH4pTWpbl1EoF87Uzo5iioevl23VPWwAK7Rwo?=
 =?us-ascii?Q?5JwQA9tIA5LOkS6ILvyRXoy3wCjqisl+hxrw+yvTvLeXTCvfyXd/qsV+wMLD?=
 =?us-ascii?Q?hDYgJBeZQ6YO4rvsUZ/kBe+dxM0muZcubkSc5GSWYuQDPzBfkzmqL0jkvXJz?=
 =?us-ascii?Q?928A9eLpzLs7CKWsD3+C5UOnTFUXWYdPz6czLmxw1Mcw1ybGF2efmEJIdfgR?=
 =?us-ascii?Q?SHGM8dwOLMuNFow+GMR3UZDtjIrbvvPQDy0htbRtSFClP6YRiIhI29T+ZGhE?=
 =?us-ascii?Q?h9p71VgiYznmybB2j+Zst4oS1hIAVvBmKs3hLZNSLzZcgqTgjbFp3W2FIzYd?=
 =?us-ascii?Q?sy+3wg8dGa3fUdrlb07arJlGybI/ZIH//09iwHmnDTigr2a36/g/IpovIdvM?=
 =?us-ascii?Q?DPhYQ+/Ma36Syvtf6wpmgfhO4u20P4ISU5EKESg6PXxxlCz7GIA38Py1JgDI?=
 =?us-ascii?Q?kN+gAexJkFU+fCCDqBa469xbu3ZSlkymGNrtD1NOZK+r1tSm4L68a98Rrm59?=
 =?us-ascii?Q?R8hGh4iWwob7c1TYdNwBp4YZGtuvQszAZv/bPHrcrFyQ6ZmjNuJ5szOAhcq4?=
 =?us-ascii?Q?sLS6retXdzIKC8vwHy7ioZuYdwGMbrs3uaoICRf2O3p4X2RSgzGAZlUqzkw4?=
 =?us-ascii?Q?8TrkERWJUjb6YhxS0Es+6a67OoqLwmR/0zYW2pTTG1e5KWszPEFCvVQvYph4?=
 =?us-ascii?Q?8ZAFtGTIh1NvLU8lC5jEKLgk6wFMWFwXq58ksr3LwhjptG4ZZjnv/sVCfu2T?=
 =?us-ascii?Q?9TgbljxxX0DO+B5Q284oicz6pWAUYS5QMoGhTvcKkz62is6lbvLVbcf+qJHn?=
 =?us-ascii?Q?jXmpINJYEH4IDjjs/aqDN+Js/A1FefJXq3M8sD6wn9IIASdng+J3uID5CgTF?=
 =?us-ascii?Q?TCnIMIlaC56V4XsjOLIJDKrGxtdIPSsWrwfXQQRopn52/SDWVg+YNWtI3VA0?=
 =?us-ascii?Q?KZqBomemrHYmSSgnoTmGf/wSFrFjowvgbZE1fBPZJUd7UkO1JfIro7+LQ0/R?=
 =?us-ascii?Q?o+wVjU4T+ixydvzjEn4Zb4FQ9Er9xbpJkCedQw41qDoSa8YQpVzifXn6T707?=
 =?us-ascii?Q?acW6InW5Sx6yBEWGCKrUw+RYRx7QMiKXO+3u3pJlPdVezi4GJg/LSGpMw606?=
 =?us-ascii?Q?XSHWr8K4EjEaW9kDlUcBqNt67Ga59prcoxsJnqICLvSZQN8mDfOxMi7iJUqm?=
 =?us-ascii?Q?UJsZpxzR0BLrUfQecSYWtYcBkebxgCyIW1qOoJy/W+No3MMWSSoRvIdd7ncP?=
 =?us-ascii?Q?dJNsKINPisfnSjbU+5tp6DY3XMMqacGEnX+R7BSo/l42Cr6Hn2OCVD80k5OM?=
 =?us-ascii?Q?biLJEbo=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b26f5a5-85b6-4822-7082-08deab820b05
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 May 2026 15:13:35.1895
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR02MB10105
X-Rspamd-Queue-Id: B346A4DD030
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
	TAGGED_FROM(0.00)[bounces-10650-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_FROM(0.00)[outlook.com];
	FREEMAIL_TO(0.00)[microsoft.com,kernel.org,vger.kernel.org,outlook.com,canonical.com,templeofstupid.com,linux.microsoft.com];
	RCPT_COUNT_TWELVE(0.00)[12];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,outlook.com:email,outlook.com:dkim,outlook.com:url,SN6PR02MB4157.namprd02.prod.outlook.com:mid]

From: Dexuan Cui <decui@microsoft.com> Sent: Monday, May 4, 2026 5:49 PM
>=20
> If vmbus_reserve_fb() in the kdump/kexec kernel fails to properly reserve
> the framebuffer MMIO range (which is below 4GB) due to a Gen2 VM's
> screen.lfb_base being zero [1], there is an MMIO conflict between the
> drivers hyperv-drm and pci-hyperv: when the driver pci-hyperv's
> hv_pci_allocate_bridge_windows() calls vmbus_allocate_mmio() to get a
> 32-bit MMIO range, it may get an MMIO range that overlaps with the
> framebuffer MMIO range, and later hv_pci_enter_d0() fails with an
> error message "PCI Pass-through VSP failed D0 Entry with status" since
> the host thinks that PCI devices must not use MMIO space that the
> host has assigned to the framebuffer.
>=20
> This is especially an issue if pci-hyperv is built-in and hyperv-drm is
> built as a module. Consequently, the kdump/kexec kernel fails to detect
> PCI devices via pci-hyperv, and may fail to mount the root file system,
> which may reside in a NVMe disk. The issue described here has existed
> for SR-IOV VF NICs since day one of the pci-hyperv driver, and has been
> worked around on x64 when possible. With the recent introduction of
> ARM64 VMs that boot from NVMe, there is no workaround, so we need a
> formal fix.
>=20
> On Gen2 VMs, if the screen.lfb_base is 0 in the kdump/kexec kernel [1],
> fall back to the low MMIO base, which should be equal to the framebuffer
> MMIO base [2] (the statement is true according to my testing on x64
> Windows Server 2016, and on x64 and ARM64 Windows Server 2025 and on
> Azure. I checked with the Hyper-V team and they said the statement should
> continue to be true for Gen2 VMs). In the first kernel, screen.lfb_base
> is not 0; if the user specifies a very high resolution, it's not enough
> to only reserve 8MB: in this case, reserve half of the space below 4GB,
> but cap the reservation to 128MB, which is the required framebuffer size
> of the highest resolution 7680*4320 supported by Hyper-V.
>=20
> While at it, fix the comparison "end > VTPM_BASE_ADDRESS" by changing
> the > to >=3D. Here the 'end' is an inclusive end (typically, it's
> 0xFFFF_FFFF for the low MMIO range).
>=20
> Note: vmbus_reserve_fb() now also reserves an MMIO range at the beginning
> of the low MMIO range on CVMs, which have no framebuffers (the
> 'screen.lfb_base' in vmbus_reserve_fb() is 0 for CVMs), just in case the
> host might treat the beginning of the low MMIO range specially [4]. BTW,
> the OpenHCL kernel is not affected by the change, because that kernel
> boots with DeviceTree rather than ACPI (so vmbus_reserve_fb() won't run
> there), and there is no framebuffer device for that kernel.
>=20
> Note: normally Gen1 VMs don't have the MMIO conflict issue because the
> framebuffer MMIO range (which is hardcoded to base=3D4GB-128MB and
> size=3D64MB for Gen1 VMs by the host) is always reported via the legacy P=
CI
> graphics device's BAR, so the kdump/kexec kernel can reserve the 64MB
> MMIO range; however, if the VM is configured to use a very high resolutio=
n
> and the required framebuffer size exceeds 64MB (AFAIK, in practice, this
> isn't a typical configuration by users), the hyperv-drm driver may need t=
o
> allocate an MMIO range above 4GB and change the framebuffer MMIO location
> to the allocated MMIO range -- in this case, there can still be issues [3=
]
> which can't be easily fixed: any possible affected Gen1 users would have
> to use a resolution whose framebuffer size is <=3D 64MB, or switch to Gen=
2
> VMs.
>=20
> [1]
> https://lore.kernel.org/all/SA1PR21MB692176C1BC53BFC9EAE5CF8EBF51A@SA1PR2
> 1MB6921.namprd21.prod.outlook.com/
> [2]
> https://lore.kernel.org/all/SA1PR21MB69218F955B62DFF62E3E88D2BF222@SA1PR2
> 1MB6921.namprd21.prod.outlook.com/
> [3]
> https://lore.kernel.org/all/SA1PR21MB69213486F821CA5A2C793C81BF342@SA1PR
> 21MB6921.namprd21.prod.outlook.com/
> [4]
> https://lore.kernel.org/all/SN6PR02MB415726B17D5A6027CD1717E8D4342@SN6P
> R02MB4157.namprd02.prod.outlook.com/
>=20
> Fixes: 4daace0d8ce8 ("PCI: hv: Add paravirtual PCI front-end for Microsof=
t Hyper-V VMs")
> CC: stable@vger.kernel.org
> Signed-off-by: Dexuan Cui <decui@microsoft.com>
> ---
>=20
> Changes since v1 (https://lore.kernel.org/all/20260416183529.838321-1-dec=
ui@microsoft.com/):
>   Fixed a typo in the subject: s/logc/logic/.
>=20
>   In the commit message, better explained fb_mmio_base is equal to
>   low_mmio_base for Gen2 VMs.
>=20
>   Addressed Michael Kelley's comments:
>=20
>     In the commit message:
>          Changed the "kdump" to "kdump/kexec" since the described
>          issue is applicable to both kdump and kexec.
>=20
>          Provided more detail about the MMIO conflict.
>=20
>          Described an scenario where Gen1 VMs can also be affected.
>=20
>     Added a pr_warn() in vmbus_reserve_fb() in case the 'start' is 0.
>=20
>     Dropped the CVM check in vmbus_reserve(), meaning vmbus_reserve_fb()
>     also reserves MMIO for CVMs.
>=20
>   Changed "low_mmio_base >=3D SZ_4G" to "upper_32_bits(low_mmio_base)"
>   to avoid a compilation warning for the i386 build.
>=20
>   Changed "0x%pa" to "%pa", because %pa already adds a "0x" prefix.
>=20
>=20
> Hi Krister, Matthew, sorry -- I'm not adding your Tested-by's since
> the code changed, though the change is small. If the v2 looks good
> to Michael, please test the patch again.
>=20
> Hi Hardik, I'm not adding your Reviewed-by since the patch changed.
> Please review the v2.
>=20
>  drivers/hv/vmbus_drv.c | 29 ++++++++++++++++++++++++++---
>  1 file changed, 26 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
> index f0d0803d1e16..d73ac5c8dd04 100644
> --- a/drivers/hv/vmbus_drv.c
> +++ b/drivers/hv/vmbus_drv.c
> @@ -2327,8 +2327,8 @@ static acpi_status vmbus_walk_resources(struct acpi=
_resource *res, void *ctx)
>  		return AE_NO_MEMORY;
>=20
>  	/* If this range overlaps the virtual TPM, truncate it. */
> -	if (end > VTPM_BASE_ADDRESS && start < VTPM_BASE_ADDRESS)
> -		end =3D VTPM_BASE_ADDRESS;
> +	if (end >=3D VTPM_BASE_ADDRESS && start < VTPM_BASE_ADDRESS)
> +		end =3D VTPM_BASE_ADDRESS - 1;
>=20
>  	new_res->name =3D "hyperv mmio";
>  	new_res->flags =3D IORESOURCE_MEM;
> @@ -2395,6 +2395,7 @@ static void vmbus_mmio_remove(void)
>  static void __maybe_unused vmbus_reserve_fb(void)
>  {
>  	resource_size_t start =3D 0, size;
> +	resource_size_t low_mmio_base;
>  	struct pci_dev *pdev;
>=20
>  	if (efi_enabled(EFI_BOOT)) {
> @@ -2402,6 +2403,24 @@ static void __maybe_unused vmbus_reserve_fb(void)
>  		if (IS_ENABLED(CONFIG_SYSFB)) {
>  			start =3D sysfb_primary_display.screen.lfb_base;
>  			size =3D max_t(__u32, sysfb_primary_display.screen.lfb_size, 0x800000=
);
> +
> +			low_mmio_base =3D hyperv_mmio->start;
> +			if (!low_mmio_base || upper_32_bits(low_mmio_base) ||
> +			    (start && start < low_mmio_base)) {
> +				pr_warn("Unexpected low mmio base %pa\n", &low_mmio_base);
> +			} else {
> +				/*
> +				 * If the kdump kernel's lfb_base is 0,

Nit:  The case of lfb_base is 0 applies to kexec and kdump kernels, and als=
o to
CVMs.

> +				 * fall back to the low mmio base.
> +				 */
> +				if (!start)
> +					start =3D low_mmio_base;
> +				/*
> +				 * Reserve half of the space below 4GB for high
> +				 * resolutions, but cap the reservation to 128MB.
> +				 */
> +				size =3D min((SZ_4G - start) / 2, SZ_128M);
> +			}
>  		}
>  	} else {
>  		/* Gen1 VM: get FB base from PCI */
> @@ -2422,8 +2441,10 @@ static void __maybe_unused vmbus_reserve_fb(void)
>  		pci_dev_put(pdev);
>  	}
>=20
> -	if (!start)
> +	if (!start) {
> +		pr_warn("Unexpected framebuffer mmio base of zero\n");
>  		return;
> +	}
>=20
>  	/*
>  	 * Make a claim for the frame buffer in the resource tree under the
> @@ -2433,6 +2454,8 @@ static void __maybe_unused vmbus_reserve_fb(void)
>  	 */
>  	for (; !fb_mmio && (size >=3D 0x100000); size >>=3D 1)
>  		fb_mmio =3D __request_region(hyperv_mmio, start, size, fb_mmio_name, 0=
);
> +
> +	pr_info("hv_mmio=3D%pR,%pR fb=3D%pR\n", hyperv_mmio, hyperv_mmio->sibli=
ng, fb_mmio);
>  }

Modulo my nit about the comment,

Reviewed-by: Michael Kelley <mhklinux@outlook.com>

