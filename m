Return-Path: <linux-hyperv+bounces-10614-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yJ5kFoMI+Wnx4QIAu9opvQ
	(envelope-from <linux-hyperv+bounces-10614-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Mon, 04 May 2026 22:58:43 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B08D24C3D26
	for <lists+linux-hyperv@lfdr.de>; Mon, 04 May 2026 22:58:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C741C30393A0
	for <lists+linux-hyperv@lfdr.de>; Mon,  4 May 2026 20:47:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41A8931716C;
	Mon,  4 May 2026 20:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="acWmEwoF"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azolkn19010029.outbound.protection.outlook.com [52.103.23.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA919314A84;
	Mon,  4 May 2026 20:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.23.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777927675; cv=fail; b=cXNg3MRPlI1iPN2BZIyeyqSDJlV3wg964skJZYqoPiBY5vIzyV1Is5ZxEaNcKlnExDUdXiXB8zmrKTiKsP4GeDvw3VEWhIbyejoAMhi3UOmbyaJLwDRYEWhlUYOqge8YBKwzTRPGMIe+oiu+k6sXbBmejn2icJbyVW6KvVwAta4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777927675; c=relaxed/simple;
	bh=jW+JcgqHcMQS+0is+kD2kMJmwgUcTqvR2ijJ40niHXc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fPi62m0WklmZqzEuwoih7F+BrM+U+Oy2A/6eLRV2og9n2YkbfMR1JHjRy+DYVFbn1jyDsUDR8wmfwzdQeoQvl9QXWmNhS17H/rcU2tOlD7OqFvCAEpqM2xFgUSD3BLrodoXpOse4lPhXW2Pi6tkP4MQgJ/Jc4ItfEkd9cMixq/s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=acWmEwoF; arc=fail smtp.client-ip=52.103.23.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Mh+XHRdHv3dHhp6sqv2ulqYD3gMSKNAFRor2HfXPWs4qig4JVcOjCfkwlmkMGYo46rzt6VwyKqigVzsZiINzgm+zJGXeMGfqgSi+gB4c7m28mjzorXuCbNvlWoAnuKp5OXvqR94uc6v1Lh+PtVn41ffFTcHzgID0fEB+M6G7pQ1kl5U/b79Z8PT1Pp/VTl3tUXiESaXDLyWQjY3850R1MKT968EUXSB6NPgFKSSYe6BEqGAE9XzyJM79WwUeZWnmnwekekAumuj+qohuf79b4T2JfiZNoocq2f4uUrpknA6Qr5NoOj5xyf1XoZLSm+UJ4IBP/yLuxivphlUgc/8K2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0LP6SK+5/AuEhfqPrAdgnIj53zI/yHIsmpFrmORFqfk=;
 b=QAriIOQozb7+YJ+CsZCeo1FweWOTdgZIj/2YLTTI+PQ4dOeRhD3VSjJCjsutFQcsDNykq5wZhkoZ9E/gL7ozraJ7BTK4RMTqDHNUYPwXd9vODZmcSt/F/S7Agvw4cmIilSim2ksEzztPWHBuqXzWZ8S3Ba53RWlzsORwIz9yKcGxw2CtZ22/UKalkKPbPAjCEmg5zQcQjtrmv9HqpvgLwXCUoRWKV82en5ERI7dpaHDT3CADS7gaR2fmhKRJXc3+72ncco8/5IXAoRHu0ibmWkVDQHbU6PjVqpdD8vAq8JTqwCucPjRdkrZzNBzCFjdKHc2+tq59/ASpzgksfCAW9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0LP6SK+5/AuEhfqPrAdgnIj53zI/yHIsmpFrmORFqfk=;
 b=acWmEwoFbZ0JOr4wWuYbKegbU3bKc1dBpk/BiDM/yzXAYMV7EqfJCDIU38uavpxUQxs8NwfodttstzzYz9/+v/RsTCrbv94orqIaHhAkZNcQUUDQ1pkwN5Sn4D9dkgpx1PUf3b7I6XPUlrus24k2VNH9lh/lrCM34YB5TXFJkOH8veJCp5C9gRRlKFR0m+wPkfEyRj7ASXSQ4FvR5H4KiFBYt6jjaQE1i/RV4v9vq3akFtL8WxwvBOoa21gT3MGbJodcb+jV7y86JlehH+EasR1QSL8KvrC8K0wluRk3IMZUrSoErPHhC5NKZurF+spulIDuuwrF6IjwCVJt6yN1MA==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by DS0PR02MB11087.namprd02.prod.outlook.com (2603:10b6:8:296::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Mon, 4 May
 2026 20:47:51 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6%6]) with mapi id 15.20.9870.023; Mon, 4 May 2026
 20:47:50 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: "wei.liu@kernel.org" <wei.liu@kernel.org>, "tzimmermann@suse.de"
	<tzimmermann@suse.de>, "longli@microsoft.com" <longli@microsoft.com>,
	"jfalempe@redhat.com" <jfalempe@redhat.com>
CC: "drawat.floss@gmail.com" <drawat.floss@gmail.com>,
	"maarten.lankhorst@linux.intel.com" <maarten.lankhorst@linux.intel.com>,
	"mripard@kernel.org" <mripard@kernel.org>, "airlied@gmail.com"
	<airlied@gmail.com>, "simona@ffwll.ch" <simona@ffwll.ch>, "kys@microsoft.com"
	<kys@microsoft.com>, "haiyangz@microsoft.com" <haiyangz@microsoft.com>,
	"decui@microsoft.com" <decui@microsoft.com>, "ryasuoka@redhat.com"
	<ryasuoka@redhat.com>, "dri-devel@lists.freedesktop.org"
	<dri-devel@lists.freedesktop.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: RE: [PATCH v2 1/2] Drivers: hv: vmbus: Provide option to skip VMBus
 unload on panic
Thread-Topic: [PATCH v2 1/2] Drivers: hv: vmbus: Provide option to skip VMBus
 unload on panic
Thread-Index: AQHOTPk5OIur69i6iLB2lq0lHt5i57YbcNAg
Date: Mon, 4 May 2026 20:47:50 +0000
Message-ID:
 <SN6PR02MB415786A3C7D10C22FAB12E3ED4312@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20260217182335.265585-1-mhklkml@zohomail.com>
In-Reply-To: <20260217182335.265585-1-mhklkml@zohomail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|DS0PR02MB11087:EE_
x-ms-office365-filtering-correlation-id: 031378a7-eaf9-41a0-0cac-08deaa1e6831
x-microsoft-antispam:
 BCL:0;ARA:14566002|37011999003|8060799015|19110799012|8062599012|41001999006|461199028|15080799012|13091999003|51005399006|55001999006|2604032031799003|19101099003|31061999003|10035399007|440099028|3412199025|4302099013|12091999003|56899033|102099032|1602099012|40105399003;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?n+XAsjKQsUmS6RCa2DFZxLDDsuw06BTdoeno3gRI0JBpURXBImScmuBrRKB2?=
 =?us-ascii?Q?L+uRGRuVytlY9KegyW4ngWhuKjsd2hzgZB4QQzh7Xz+ZTzzHj3wvdBID0/Bc?=
 =?us-ascii?Q?0dQMqIMeAIGyYThpozH3g+5GSMY53KH0H23Z5sVmdaMpHKrahJsg761TANhJ?=
 =?us-ascii?Q?s2Q8fnmqd/9EPUJfWAgU/MWEtOnqWm18cqQufiFv0ngWJobTPkZAeJs5bUiT?=
 =?us-ascii?Q?aDJyThzzCGDUa7mpWO2UUNS0u/2kPPMgcf7mpkFg/5twEk/sJL/JzYVJMdQH?=
 =?us-ascii?Q?pwrzLfX96NCEjfLX3aBcVjvAnAEFMOXXncKS+OQ61W4AN73sVcTDKt6HcvbN?=
 =?us-ascii?Q?C2exLNIT7RMSih9/A/XBmljYFj9rYKjQ7Mr230nJAR400UDVnQB+Z+8oUm8i?=
 =?us-ascii?Q?rfY9zlEe5zPSfd8mJ/mFaRhFZm/1GMONHnqe93G9ggFxkH2DS1PHph/fd5t7?=
 =?us-ascii?Q?3vT86HW3CEs1FFy2hczEcJzwAe69rd8YAPqfnesOa5ePr6eukne91sSFpAgT?=
 =?us-ascii?Q?0SficAHm4RirUeEgBo5zvm1nOezaxKsOIgz+14EsakTMbY++5I2wrWsA/25b?=
 =?us-ascii?Q?WYWlcWXFx1jZkGm2y4LnugFi1exteyc6oNe5STnMeIFX7w86vitlLzpkCuo5?=
 =?us-ascii?Q?ptojvDkTIJxehAiL9W3msvSi7/65J/qVUYv4ggiuMdZATTraw8qcP6ClMC1e?=
 =?us-ascii?Q?KtfkO7vlmCkGeQWdcSQboOsuBYzzejisVC9HG2K1+wRz+XMHTemqiPuAMQpE?=
 =?us-ascii?Q?MMBPXNmBVeP7WxVtgnz+Uos8vJbdDnwFO1nbG9IEKKZsXEk+xQSlbM8Pw1yz?=
 =?us-ascii?Q?Rxuz+Mx5+Vgir66zJ8Z/ziHmOCbe2E445u1YkX/HeSX3WH0xmStXWsihQFb4?=
 =?us-ascii?Q?O1N2fDlAlFT2SpZ1ZTPOAex4ONhZms+xnPe45a0fS6jcYv2lD9ACEszHFMqL?=
 =?us-ascii?Q?zQIwReMWuqmNoQlospxycKLuaW4uw/tgVgMcYuHJ0senMeVgMqwydyeUY0XK?=
 =?us-ascii?Q?gppF2rfk7b0jbon7/cS3mH77mV/oSEpRJhVXtgp4xNEtSecuPOvNYKlpx9wL?=
 =?us-ascii?Q?QV2e4+6bzeP0Lu09TvdjuoF+D9iNLuM/QQOfn/2p9c25YtTaguu/ExUHsmEM?=
 =?us-ascii?Q?4CNOCG0Aj+JVAg3pLpkap1+U0jgENbRPn7g5+7MXSw5sZ/quqyQuMxtbAXgq?=
 =?us-ascii?Q?fZQOzeL7cP1Eq55JbFHjrzHWl5F3cXRkObhAJ87l8Y5Ov2wLYV5dHdvWxPM?=
 =?us-ascii?Q?=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?hZSzPDoPIAA5AzLSWoxPaldpwb7XL5awbuazSuS360gxwFlkcvsoewLL7l+8?=
 =?us-ascii?Q?Vz2upYtv99Kq5r3pX+Tv84bKKWJNs6jv13X1kxD0C+r0B4RJWfD1jyDWl0HH?=
 =?us-ascii?Q?djjBKqKa2bzHlZ5m2OZFOHUGPL4Q5er/GILp2k98N4/jPVXj8Bjcb7BhpaUS?=
 =?us-ascii?Q?g8mE3+KVEGIorDTr4fsrd2aWkv8EQWYnEISM15Y5+30TMipP7RukgUMlxivM?=
 =?us-ascii?Q?1DHlriXsdm6FHvhAlAOMr1yCfhhxf8xxtDqeB1QAacA36uSPEBdIHZq5WS6P?=
 =?us-ascii?Q?ddL0Y9QRt1sp/BVU4FHYIE1VIJYd//grWiO1b29jrH6ThulyfxkJwxliaQrt?=
 =?us-ascii?Q?1zgPcmn831jKPS0YcaJwh2TdJBWYvYRagLr2UaXZb28LLKpWRW0gx4ANcARG?=
 =?us-ascii?Q?0xvqoUSDxSulwF34unQnfrDQ7CLUmI63mSQqx45MPtIM9RhoNxcgcWRiQb0o?=
 =?us-ascii?Q?c5P3g9beBpd0p6EaLRT8QBLNDp+8lZ4R09X7z/eexwR1FMeIjJgv+B5TZ6Kq?=
 =?us-ascii?Q?3LmX//dTROabPvaN5b2Z95Sr/jWuAPE2Npw+lC25ANolcdWZyXR+n02L6Y9N?=
 =?us-ascii?Q?fX1MhgAJvf4DcLPjRiZzU1IC/XGL+HUMKXM5vKkWbe3rYzMFeEt88f0tDuXG?=
 =?us-ascii?Q?SXX3o/R9c9dt9qnMQEzMtlR7q1vdFUasJGsAbTelPn6Ov3At2YLYbGrVVHLA?=
 =?us-ascii?Q?79zEJftbGeeJjNn5UMmJy4oQditRIoAuprUGPBxPFZQzH0y6+LKr+nwD8Nan?=
 =?us-ascii?Q?8FIYGPJwoADogj52Z8hBUMgAnAeCyX1rNKQZWpcxw5N9L090MAnT3j1nfMoO?=
 =?us-ascii?Q?SOO7IDGYsiumyVv/Qv+X+Oh4cwjBugo/w33P29XdpM7+dMdalTfckSm+Sg86?=
 =?us-ascii?Q?BXlW7thrOeThNUgGK7KfF88YF7pVZFXYhxw4jpFiCDMpjOnrXCM0MmlYvk/y?=
 =?us-ascii?Q?+gpjKGocFAxsnYLatJLgi9uRkRz6jw3UzUiTwhd0aiiHwm/M99fFV/+QaIGo?=
 =?us-ascii?Q?oPRMKWmmgrV61aUxTDW/gbLszeQT6RBZY0miynLorf934TQSwPg8s9ZzrH4A?=
 =?us-ascii?Q?uTlcNHFB70ogElmsnYQfykXb0cc7Pwr450i/3yTrz5zebJYj4CVrYwMIBrLk?=
 =?us-ascii?Q?qJxSxGL3bf8A3RuWV4zHnKLGbiHhXHKpy5gzaXp9T1CdxODdOCnLIUdmzXRv?=
 =?us-ascii?Q?DrCRYiISoNLKrfRBN1ozdXwSn1P2Ruwh5KvqGKqsOT42dhJ5pfQU3uIONpkz?=
 =?us-ascii?Q?BuyNZnNWnFzXNDFOYC01Zjw3o8WCd0apwEFrlgu7HUn7YuF4DpD9sUvCt3Iz?=
 =?us-ascii?Q?ksyzBsulr2LC1ECacZyNMSPaT9vYn5QJpr6xq3t0W4pUzY+eOjf1yL8BdCdb?=
 =?us-ascii?Q?joDZ3hw=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 031378a7-eaf9-41a0-0cac-08deaa1e6831
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 May 2026 20:47:50.6462
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR02MB11087
X-Rspamd-Queue-Id: B08D24C3D26
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [5.84 / 15.00];
	SEM_URIBL(3.50)[zohomail.com:email];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MAILLIST(-0.15)[generic];
	BAD_REP_POLICIES(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10614-lists,linux-hyperv=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	GREYLIST(0.00)[pass,body];
	FREEMAIL_CC(0.00)[gmail.com,linux.intel.com,kernel.org,ffwll.ch,microsoft.com,redhat.com,lists.freedesktop.org,vger.kernel.org];
	FREEMAIL_FROM(0.00)[outlook.com];
	R_DKIM_ALLOW(0.00)[outlook.com:s=selector1];
	RCPT_COUNT_TWELVE(0.00)[17];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DMARC_POLICY_ALLOW(0.00)[outlook.com,none];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[mhklinux@outlook.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[outlook.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	R_SPF_ALLOW(0.00)[+ip4:172.234.253.10:c];
	NEURAL_SPAM(0.00)[0.795];
	TAGGED_RCPT(0.00)[linux-hyperv];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[outlook.com:dkim,outlook.com:email,SN6PR02MB4157.namprd02.prod.outlook.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,zohomail.com:email]

From: Michael Kelley <mhklkml@zohomail.com> Sent: Tuesday, February 17, 202=
6 10:24 AM
>=20

Wei and Thomas --

This small patch series has been neglected. Patch 2 of the series is here [=
1].

Long Li < longli@microsoft.com> has given a Reviewed-by on this patch,
and Jocelyn Falempe <jfalempe@redhat.com> has given a Reviewed-by
on Patch 2 of the series, modulo a comment which I have incorporated.
See [2]. But I neglected to add her R-b when I spun v2 of the series.

Any reason this can't be picked up as a bug fix for 7.1? I just checked,
and it applies cleanly to a recent linux-next (20260423). I'd suggest
going through the hyperv tree, as these two patches should be kept
together in sequence.

Michael

[1] https://lore.kernel.org/linux-hyperv/20260217182335.265585-2-mhklkml@zo=
homail.com/
[2] https://lore.kernel.org/linux-hyperv/a5372b72-8dc0-4f2d-ad5c-086f3e75ee=
81@redhat.com/

> Currently, VMBus code initiates a VMBus unload in the panic path so
> that if a kdump kernel is loaded, it can start fresh in setting up its
> own VMBus connection. However, a driver for the VMBus virtual frame
> buffer may need to flush dirty portions of the frame buffer back to
> the Hyper-V host so that panic information is visible in the graphics
> console. To support such flushing, provide exported functions for the
> frame buffer driver to specify that the VMBus unload should not be
> done by the VMBus driver, and to initiate the VMBus unload itself.
> Together these allow a frame buffer driver to delay the VMBus unload
> until after it has completed the flush.
>=20
> Ideally, the VMBus driver could use its own panic-path callback to do
> the unload after all frame buffer drivers have finished. But DRM frame
> buffer drivers use the kmsg dump callback, and there are no callbacks
> after that in the panic path. Hence this somewhat messy approach to
> properly sequencing the frame buffer flush and the VMBus unload.
>=20
> Fixes: 3671f3777758 ("drm/hyperv: Add support for drm_panic")
> Signed-off-by: Michael Kelley <mhklinux@outlook.com>
> ---
> Changes in v2: None
>=20
>  drivers/hv/channel_mgmt.c |  1 +
>  drivers/hv/hyperv_vmbus.h |  1 -
>  drivers/hv/vmbus_drv.c    | 25 ++++++++++++++++++-------
>  include/linux/hyperv.h    |  3 +++
>  4 files changed, 22 insertions(+), 8 deletions(-)
>=20
> diff --git a/drivers/hv/channel_mgmt.c b/drivers/hv/channel_mgmt.c
> index 74fed2c073d4..5de83676dbad 100644
> --- a/drivers/hv/channel_mgmt.c
> +++ b/drivers/hv/channel_mgmt.c
> @@ -944,6 +944,7 @@ void vmbus_initiate_unload(bool crash)
>  	else
>  		vmbus_wait_for_unload();
>  }
> +EXPORT_SYMBOL_GPL(vmbus_initiate_unload);
>=20
>  static void vmbus_setup_channel_state(struct vmbus_channel *channel,
>  				      struct vmbus_channel_offer_channel *offer)
> diff --git a/drivers/hv/hyperv_vmbus.h b/drivers/hv/hyperv_vmbus.h
> index cdbc5f5c3215..5d3944fc93ae 100644
> --- a/drivers/hv/hyperv_vmbus.h
> +++ b/drivers/hv/hyperv_vmbus.h
> @@ -440,7 +440,6 @@ void hv_vss_deinit(void);
>  int hv_vss_pre_suspend(void);
>  int hv_vss_pre_resume(void);
>  void hv_vss_onchannelcallback(void *context);
> -void vmbus_initiate_unload(bool crash);
>=20
>  static inline void hv_poll_channel(struct vmbus_channel *channel,
>  				   void (*cb)(void *))
> diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
> index 6785ad63a9cb..97dfa529d250 100644
> --- a/drivers/hv/vmbus_drv.c
> +++ b/drivers/hv/vmbus_drv.c
> @@ -69,19 +69,29 @@ bool vmbus_is_confidential(void)
>  }
>  EXPORT_SYMBOL_GPL(vmbus_is_confidential);
>=20
> +static bool skip_vmbus_unload;
> +
> +/*
> + * Allow a VMBus framebuffer driver to specify that in the case of a pan=
ic,
> + * it will do the VMbus unload operation once it has flushed any dirty
> + * portions of the framebuffer to the Hyper-V host.
> + */
> +void vmbus_set_skip_unload(bool skip)
> +{
> +	skip_vmbus_unload =3D skip;
> +}
> +EXPORT_SYMBOL_GPL(vmbus_set_skip_unload);
> +
>  /*
>   * The panic notifier below is responsible solely for unloading the
>   * vmbus connection, which is necessary in a panic event.
> - *
> - * Notice an intrincate relation of this notifier with Hyper-V
> - * framebuffer panic notifier exists - we need vmbus connection alive
> - * there in order to succeed, so we need to order both with each other
> - * [see hvfb_on_panic()] - this is done using notifiers' priorities.
>   */
>  static int hv_panic_vmbus_unload(struct notifier_block *nb, unsigned lon=
g val,
>  			      void *args)
>  {
> -	vmbus_initiate_unload(true);
> +	if (!skip_vmbus_unload)
> +		vmbus_initiate_unload(true);
> +
>  	return NOTIFY_DONE;
>  }
>  static struct notifier_block hyperv_panic_vmbus_unload_block =3D {
> @@ -2848,7 +2858,8 @@ static void hv_crash_handler(struct pt_regs *regs)
>  {
>  	int cpu;
>=20
> -	vmbus_initiate_unload(true);
> +	if (!skip_vmbus_unload)
> +		vmbus_initiate_unload(true);
>  	/*
>  	 * In crash handler we can't schedule synic cleanup for all CPUs,
>  	 * doing the cleanup for current CPU only. This should be sufficient
> diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
> index dfc516c1c719..b0502a336eb3 100644
> --- a/include/linux/hyperv.h
> +++ b/include/linux/hyperv.h
> @@ -1334,6 +1334,9 @@ int vmbus_allocate_mmio(struct resource **new, stru=
ct
> hv_device *device_obj,
>  			bool fb_overlap_ok);
>  void vmbus_free_mmio(resource_size_t start, resource_size_t size);
>=20
> +void vmbus_initiate_unload(bool crash);
> +void vmbus_set_skip_unload(bool skip);
> +
>  /*
>   * GUID definitions of various offer types - services offered to the gue=
st.
>   */
> --
> 2.25.1
>=20


