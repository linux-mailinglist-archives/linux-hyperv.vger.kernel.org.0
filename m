Return-Path: <linux-hyperv+bounces-8748-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OP1mLJrnhGlf6QMAu9opvQ
	(envelope-from <linux-hyperv+bounces-8748-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 05 Feb 2026 19:55:22 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 11A10F69BE
	for <lists+linux-hyperv@lfdr.de>; Thu, 05 Feb 2026 19:55:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C5954300DF70
	for <lists+linux-hyperv@lfdr.de>; Thu,  5 Feb 2026 18:55:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 626853090E6;
	Thu,  5 Feb 2026 18:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="uD+f/4wQ"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazolkn19012053.outbound.protection.outlook.com [52.103.2.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C1E63090C6;
	Thu,  5 Feb 2026 18:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.2.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770317720; cv=fail; b=fxLrBmFvdQNf486ysmb4l5ZIuhpSi8jrk+2Hh/ycJfTVNiQmBgx/czzfq4uIWcfC23711nfLk44b4RjxzpzqAMUUcBQHWwQ5dNmxFHPYmciMhOpYh3EjoAfnbbmBHR9BqxYzoqMBrY9q7Q0pwiN/SPyezGcpw/VzHYYCQ4M3jD8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770317720; c=relaxed/simple;
	bh=kKlOCVp3snqIhX1acx19WmyjszYOaXzcwINK8Maa1cA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Wrmp/absR0zCUjATcN1ZfEokFkxrEFMBOB/aXNe706P6WHjlDNACkPLRSgZaU5mpSk9WFOR35LsmGAsQOnt93ksHpaJ3u5/7BHHV17eP0+NtBIVAORPTN8naMkmfDZvbeD2Jdl81qd27nH9kW4Zl6zsR8MHy1tadR6wth2RywFg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=uD+f/4wQ; arc=fail smtp.client-ip=52.103.2.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m8xY7cBQaVVcr9UUtMlV1qcKwoYj1Bsmv5kBQTHNTf32Vmz9h5o8CQJem2YSJCBeooDX4XfegB7yAddhfXky00KxWSykjU5LkOVtfHeVbWV6cEygKzRAVOH9WHQRlRZaWaNK2hFBsKuCNK5zT+pyYEAAL/zu6XMUAkczNPfQrN1iOyGmDIkA/huOfJ6q/EmExzMciKqKpJzQf2B/irK2sBYQrO1RxUQDWAVyKq0BGRQBLYYTum4ZWVJfy1zDaNLui1sapKR0fLawnoTDVno0JryG2jC2mMCmW0SP/wx1FAQqrldj55pr8HYncRr7FV2kU9srpiS8oVrcnPMyrAOqiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XafKFLhARPyqCJy9r+o//y1wXENk/CezLtPzxsKdaaQ=;
 b=YJiGX2p2dvIT+Bies3p4YU+GIIe7XAqZLWuSvxmkaGxgkNEwne8jXCUko926GH/rHxjMePQV2lWWth70Ktoj51x01YlJY0K1wGmgQCeNTXvkUdtJ9tVeRtY5uvw7Dsh/uyRrITIB/2QFxOPiKeh5ikPupBDJKvtjVqcK+M78ONacnRVoq4csnMLNuEhi6Kvumt18zGzgzRv4sf15Vsvtz6EMjyuSfKkrxdpckDmOLYgihB43msdLluYr2zvDVSdBVG2VK+iSD+WxBzhba3QysCIGp2bFPQ6vpFIYerYCqydup/Ri/JwfRTREt0Bj0JgmJFERlUgq2tiey9sUxFBw+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XafKFLhARPyqCJy9r+o//y1wXENk/CezLtPzxsKdaaQ=;
 b=uD+f/4wQ80g2b4hweXSt1ozwZyw9mRD8QvO3yhZQOrJxfrlSa4H3erXVasPSX9cJ3mM0lQzN/YksDlTDwhM+Z8jKvXoajUgNKKFoFTUlaWBGqc/EP1CiXO80kdunz6c+tRg5HCVrlnoln72yy1lpNt6Tix3z9hXWbn/7wFaFSlGdAF258T1U9q6K5Pp6F2APYDLYLvP7WEJvxzOyycKpsbm0PykQUcDcJAj0y1bu/PRPrmrcLbgSTp5HhuDLbvl2njk6YPuzzQpSyBFvEn7WVDZ44z9yrvNEAtEn01jvHL3CVo/o2K6w8TZInylyNNH1APAmWVSSf3p5eiPf+tpcuQ==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by DS0PR02MB8999.namprd02.prod.outlook.com (2603:10b6:8:c7::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Thu, 5 Feb
 2026 18:55:17 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6%6]) with mapi id 15.20.9587.010; Thu, 5 Feb 2026
 18:55:17 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Jan Kiszka <jan.kiszka@siemens.com>, "K. Y. Srinivasan"
	<kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu
	<wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, Long Li
	<longli@microsoft.com>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar
	<mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
	<dave.hansen@linux.intel.com>, "x86@kernel.org" <x86@kernel.org>
CC: "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Florian
 Bezdeka <florian.bezdeka@siemens.com>, RT <linux-rt-users@vger.kernel.org>,
	Mitchell Levy <levymitchell0@gmail.com>, "skinsburskii@linux.microsoft.com"
	<skinsburskii@linux.microsoft.com>, "mrathor@linux.microsoft.com"
	<mrathor@linux.microsoft.com>, "anirudh@anirudhrb.com"
	<anirudh@anirudhrb.com>, "schakrabarti@linux.microsoft.com"
	<schakrabarti@linux.microsoft.com>, "ssengar@linux.microsoft.com"
	<ssengar@linux.microsoft.com>
Subject: RE: [PATCH] x86: mshyperv: Use kthread for vmbus interrupts on
 PREEMPT_RT
Thread-Topic: [PATCH] x86: mshyperv: Use kthread for vmbus interrupts on
 PREEMPT_RT
Thread-Index: AQHclScm1YuvygUhI0+fe3CZOPBAobVzKaaQ
Date: Thu, 5 Feb 2026 18:55:17 +0000
Message-ID:
 <SN6PR02MB4157B6A9C8BEFA312F0D9D68D499A@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <133a95d9-8148-40ea-9acc-edfd8e3ceef4@siemens.com>
In-Reply-To: <133a95d9-8148-40ea-9acc-edfd8e3ceef4@siemens.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|DS0PR02MB8999:EE_
x-ms-office365-filtering-correlation-id: 8dba5be1-7cb6-44c1-cfb6-08de64e81ac3
x-ms-exchange-slblob-mailprops:
 Om8TgR6f4EAEdu9ieeuz9D5SeZesE0h2i114BELvF6K6TwygOsTM8a6uFzOIPoP+aMxEBpqJqKimN/dNK4qD3oPy6l0+JFl3jfL2voG0T+9SKAlKiePAPtoej6Q0QpYvNDqLIxM5vs7kAIIwe9aGkhZZnEVWCQDsRC8yIu2VpJ2SgP5prS0XJw0ZQAXxGpbYArxcPNzlHJ0GMD4ZSApLgvLqgSi7R1EjBu8k/+EzAZbvJlxTKxwRKFLjq/YTHXILh3rBPxS6rarq10d0Xe3jDnZBB44BrAsZVmBEzAiHIdD+kOc5vyw/HK378sgs3zX2qrqt2yWQYhInmY/ofXS9PLmYpj9SW7h45P4KsPzi2+95/ITyVRe5AQgDvb6rPXZX0xIEUCGeW1us+tqYpuz+QLPOzX9J3uUn6q0uBz1sFoK6kA2u+hwMRgtTePtSUj+S+zs292s4lhj7Nh60fvve45kziF8e1FvfMWEQoxZkP2ljUUguJkQf+u8QyMCDIIxuVimttq2Gk5bFmUIvyRe8aIg9BKCXHaeDXcw39nTd3a9CIgXlClF7Ch4+DgMo14VBMnO3ITXevIj67y5PU3UOZLf3UELrVttkGgA6ZAexOnItuhcKaCloQZeNGMk9JERG8djYdGEYTK6qo/Lk4JyqKsOb4WOoLJBo+4P7/QnqGpW7rnsmRmR9Dfe36let5vPBGuNy6yIp3DadVS3ISp1dCIgz1LyiMDxvdlCeWtq0nV0z5cU4nZcdkw+T5zVVkxaFNkgnpLmJN34Er5YAwm4ah/bb32E/rMInKtCwuQxe2XfCte4KRkwZ6ImrD5Bw1souaDMDPem2P8Jv7uHGUaFwkuitq3Ip31Xx
x-microsoft-antispam:
 BCL:0;ARA:14566002|19110799012|15080799012|12121999013|41001999006|8060799015|8062599012|13091999003|51005399006|461199028|31061999003|1602099012|40105399003|56899033|4302099013|440099028|3412199025|10035399007|102099032;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?dfGVx5r1b4NYFIrlPFFLP5U3042D5a+ya1qgzQnAKrRaneACMwjFeio65g+N?=
 =?us-ascii?Q?67qlElhvvO0OAtMJHuQGwQ/aQyaUnNXWp0sH7RViVMdb3nNBI0XNUG+5mnyF?=
 =?us-ascii?Q?9R4qVnsctghiBmpykD4vP75Q16n3o6nWDhwbWsWfou2IobpaX4Gj30xkDmiL?=
 =?us-ascii?Q?8xi/NoB/r2TsaYTQaBT3ckd0/Fl7ttstPk+7P9OtYF85mIJgP+K2CIF43/g2?=
 =?us-ascii?Q?XwRzjar0lJG1bAL5CBiFKh653ddIJuukQYh9zPit1B0PTinkQZY/HYn3YqPO?=
 =?us-ascii?Q?FntlVFJrkRDxEpqQ6wLPSBRqtbTjQfZAQdNlPAfMpTZwafBWykyUHulf9Uy2?=
 =?us-ascii?Q?3hy4GWQjPsOgjp/TmVlV7qwTqalkRsX2Hqs/CkrMTKAPBnwnLX2KtwUrHyZT?=
 =?us-ascii?Q?Sk46T/5WahFOkuhxVr4T2qg6oUs6bZSySswAN1T6vdmO4sT5DDTFRdXG1pUM?=
 =?us-ascii?Q?KdgpjtyJxJGk45s5kn9K0YHR0zvTEue51Z/fzxX1kotBMVtZjBgZo+jTQcdq?=
 =?us-ascii?Q?wZz5yG/6/5Xqg7y7dYNM6kf8RoTicZeKZsMaNZPlYhZXKJ52z/Z8hmyrODdQ?=
 =?us-ascii?Q?MPlDz5z/9Og+MmhpqpoQDrJb4FYew9HZROGqj0TYHX9f2U/XF/4pls5qS01l?=
 =?us-ascii?Q?jIhWiNLGxb+8qX//peQsQDUQ0yMQnMZRKQErdsjg69ZFIWqaA8idAojAHr08?=
 =?us-ascii?Q?D4wo75nBUXb+iK3zWZDUHFvDzpYbex6HU7Lj85p+E9nlTHHJ2yVZRkMwVtdU?=
 =?us-ascii?Q?D2VbMVGx06Yg1/y514q+gx+k2OArQWeW7QypTfGZNAh4cLipWs9a0bdvkEXQ?=
 =?us-ascii?Q?sQFeD95YV62CgZVKhLmZ3Cpj/Wb/8UkgW9YNpkBzfdvJhO+fgDSf7sid8s1d?=
 =?us-ascii?Q?v1feQNdFztGd6BTrKRSIhz+jiKLIG+DvTP+Jwuvc5RLF8LdwhOuYA8sRbHTk?=
 =?us-ascii?Q?tefm2eEItMGbdK3ZQsnx5NAYR0SwMTURPl34mea87zJF3EbH/qKtJxKYYdYQ?=
 =?us-ascii?Q?FophHHIaMGUjBKY/7fD5we7EhyVMENh+Iq63kSf5aYbKaw4smdW1YIZ9aBJ+?=
 =?us-ascii?Q?OAJpcZ07YOPsg08IC5f6j+pyp80T664dflTY8Pd0qxqGPWOLBEm+bMx925oz?=
 =?us-ascii?Q?cGUYNkU5HCwY7UzVtn2bbFKZsiu+wFshlhxlPJkZj6Bf56OQsyont9fbI5/g?=
 =?us-ascii?Q?P7SzTXEroDSGfhOJQNR4bUt8FgPWCSZVXAPJdqUP1ExMeop8jwSgpi+TEUej?=
 =?us-ascii?Q?XiP2rIhsCjagCCulU7/HrcFC2gv60L6lUFMpLsG/JLwIaUGok/fMxiEAJJJb?=
 =?us-ascii?Q?NlER0LZgNfnQipLRj5dIHo6XIdDvnLka89TX8ttkX79RTjnUWZVXjHWa3kDj?=
 =?us-ascii?Q?ladltHQl1CKo7awo8X2seNc/zrQLtKU/u8TiaxL0+TlL/tCUnrORpaNM1O5R?=
 =?us-ascii?Q?8OA8mNFxGaM=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?D+ioSsxfpTXUAq8K+zeTPncnksXfID9iaEfM+GonWCLDrx7+aPbErdLKi7Yu?=
 =?us-ascii?Q?Zd+O5eiMsb8uThaS1T5vvY0WnHwllPyh2sXyHXZVk6x/PV+6dwHHhmzGPLHH?=
 =?us-ascii?Q?Bi4d5mC38GUjQAnohnBk6g6zBu91ycybhpx12AnxMgdh8Ro1d1kfiF+8TmOe?=
 =?us-ascii?Q?upsnAxP4RvQfyKTjP9u06VPPl8DpyPcc5Qn9FKTX+SoNg61d47ruQmc1+Z0U?=
 =?us-ascii?Q?xS69wjnnC7/EI97atk+OgnBBYuBKeutF+5n7ozGTLRccjPM3eo797wV8hRo4?=
 =?us-ascii?Q?AsayV97gLBlEkF9rl6XmadrYwRR/a0HyOCD1w71CKdOk1kYhyhdA7OHDCwSz?=
 =?us-ascii?Q?px5ZhkjuWNoPey3ydyuq+3vYuk7CVII9/V4Wb94YJxyLZxUNwDjgCYfum1Df?=
 =?us-ascii?Q?BVZ3CMo0mfw4m20P67Ywj/1Otv3HfmkFf6b5JCE3Ed/G8o5PsIsEpRQtlOyl?=
 =?us-ascii?Q?K1UdyaZ6Y3wGxUAKzackXTdVirWgZAQPOFICOG0fg4GVN/+mCyYRj90F2pon?=
 =?us-ascii?Q?y+g8kcCNtLBSrjJGPLKtd+T/B3CkQSGg5WUMgwYkbJ6KGHC4IhryC+CX7GKb?=
 =?us-ascii?Q?BNK676MGABkeVaK0nhkGIuBBESOr8xCR9QmyOEGSolDkGLhnE4mWUe6Q5qcY?=
 =?us-ascii?Q?hWdNcuXeBHUupRtGAir++YwK9z6gfPXm935XYuPmyVPEVZ44hh21rQ/DLqVg?=
 =?us-ascii?Q?+jsOckAuoU9qDUWGpU6MGctdXRW89NII8XLVUPunOdJPs6ML/XUCuPF/XReg?=
 =?us-ascii?Q?yjDy4ONWDK98R1yx29fjPSXaENWBC+IHQ/ZRZc6zHU03tu3lonjSnKLOlSUt?=
 =?us-ascii?Q?FSXoBXVuXbjjl99EFniidsX4Aaw7rJoJRvbhyyy3VcRpOTdamQAz1VQxi401?=
 =?us-ascii?Q?peHJLOgpghySGUeSB1Sd/EXI9bdlEegTIecoXV0l6PjvhbVgehagi+9QddGY?=
 =?us-ascii?Q?Ul0APIxn/tVQzPdzGvDaU9Jzz3H6Evcyh0y9HenP+/Pp7BV59Ifq5yw9U1hW?=
 =?us-ascii?Q?j+hDitjt7Z2em9hR8N0PpWjWpr9udYxXpVjNXJv2cizqI4QIZP4b6GcvZALg?=
 =?us-ascii?Q?kECOSMh2omMXz0xV7EwVyTg2DqfcKZ2XFrXzb0Yn/U6TWvXYEuJVP2dwVbrD?=
 =?us-ascii?Q?HbVt0Uc+ZatbPDbDXamENrv4rKAMzNdxb2vCmqpqiG4L0iOhpoCr9MfnH2/b?=
 =?us-ascii?Q?o15sIKdnSnYRtcKFBdeiiiFRKfq+IcFHhtKoysaTTYzfOi23C5rWsocCg1DG?=
 =?us-ascii?Q?e0hQsjfCpUWQnvh4ivs74P5eLqRmhMgyaubwK/rAMHrnMBd26BD4+bYa3tes?=
 =?us-ascii?Q?rZtMdzJKptQR6um+aAI59VPGoytlQHm+tEnu/WNruZIb2wMh/b6u6yIfDiDZ?=
 =?us-ascii?Q?He8QCrT5gBytcjWEGNU0j6ngjJTf3QY+sggILmv39PVANkwMhTTR/1nCyERx?=
 =?us-ascii?Q?b5rfxWZQuFgORD5pF81L3HGBOm5Pv0bK?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 8dba5be1-7cb6-44c1-cfb6-08de64e81ac3
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Feb 2026 18:55:17.7118
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR02MB8999
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[outlook.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[outlook.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8748-lists,linux-hyperv=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,siemens.com,gmail.com,linux.microsoft.com,anirudhrb.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_FROM(0.00)[outlook.com];
	RCPT_COUNT_TWELVE(0.00)[21];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,outlook.com:dkim,siemens.com:email]
X-Rspamd-Queue-Id: 11A10F69BE
X-Rspamd-Action: no action

From: Jan Kiszka <jan.kiszka@siemens.com> Sent: Tuesday, February 3, 2026 8=
:02 AM
>=20
> Resolves the following lockdep report when booting PREEMPT_RT on Hyper-V
> with related guest support enabled:
>=20
> [    1.127941] hv_vmbus: registering driver hyperv_drm
>=20
> [    1.132518] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> [    1.132519] [ BUG: Invalid wait context ]
> [    1.132521] 6.19.0-rc8+ #9 Not tainted
> [    1.132524] -----------------------------
> [    1.132525] swapper/0/0 is trying to lock:
> [    1.132526] ffff8b9381bb3c90 (&channel->sched_lock){....}-{3:3}, at: v=
mbus_chan_sched+0xc4/0x2b0
> [    1.132543] other info that might help us debug this:
> [    1.132544] context-{2:2}
> [    1.132545] 1 lock held by swapper/0/0:
> [    1.132547]  #0: ffffffffa010c4c0 (rcu_read_lock){....}-{1:3}, at: vmb=
us_chan_sched+0x31/0x2b0
> [    1.132557] stack backtrace:
> [    1.132560] CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Not tainted 6.19.0-rc=
8+ #9 PREEMPT_{RT,(lazy)}
> [    1.132565] Hardware name: Microsoft Corporation Virtual Machine/Virtu=
al Machine, BIOS Hyper-V UEFI Release v4.1 09/25/2025
> [    1.132567] Call Trace:
> [    1.132570]  <IRQ>
> [    1.132573]  dump_stack_lvl+0x6e/0xa0
> [    1.132581]  __lock_acquire+0xee0/0x21b0
> [    1.132592]  lock_acquire+0xd5/0x2d0
> [    1.132598]  ? vmbus_chan_sched+0xc4/0x2b0
> [    1.132606]  ? lock_acquire+0xd5/0x2d0
> [    1.132613]  ? vmbus_chan_sched+0x31/0x2b0
> [    1.132619]  rt_spin_lock+0x3f/0x1f0
> [    1.132623]  ? vmbus_chan_sched+0xc4/0x2b0
> [    1.132629]  ? vmbus_chan_sched+0x31/0x2b0
> [    1.132634]  vmbus_chan_sched+0xc4/0x2b0
> [    1.132641]  vmbus_isr+0x2c/0x150
> [    1.132648]  __sysvec_hyperv_callback+0x5f/0xa0
> [    1.132654]  sysvec_hyperv_callback+0x88/0xb0
> [    1.132658]  </IRQ>
> [    1.132659]  <TASK>
> [    1.132660]  asm_sysvec_hyperv_callback+0x1a/0x20
>=20
> As code paths that handle vmbus IRQs use sleepy locks under PREEMPT_RT,
> the complete vmbus_handler execution needs to be moved into thread
> context. Open-coding this allows to skip the IPI that irq_work would
> additionally bring and which we do not need, being an IRQ, never an NMI.
>=20
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
>=20
> This should resolve what was once brought forward via [1]. If it
> actually resolves all remaining compatibility issues of the hyperv
> support with RT is not yet clear, though. So far, lockdep is happy when
> using this plus [2].
>=20
> [1] https://lore.kernel.org/all/20230809-b4-rt_preempt-fix-v1-0-7283bbdc8=
b14@gmail.com/
> [2] https://lore.kernel.org/lkml/0c7fb5cd-fb21-4760-8593-e04bade84744@sie=
mens.com/
>=20
>  arch/x86/kernel/cpu/mshyperv.c | 52 ++++++++++++++++++++++++++++++++--=09

You've added this code under arch/x86. But isn't it architecture independen=
t? I
think it should also work on arm64. If that's the case, the code should pro=
bably
be added to drivers/hv/vmbus_drv.c instead.

>  1 file changed, 50 insertions(+), 2 deletions(-)
>=20
> diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyper=
v.c
> index 579fb2c64cfd..1194ca452c52 100644
> --- a/arch/x86/kernel/cpu/mshyperv.c
> +++ b/arch/x86/kernel/cpu/mshyperv.c
> @@ -17,6 +17,7 @@
>  #include <linux/irq.h>
>  #include <linux/kexec.h>
>  #include <linux/random.h>
> +#include <linux/smpboot.h>
>  #include <asm/processor.h>
>  #include <asm/hypervisor.h>
>  #include <hyperv/hvhdk.h>
> @@ -150,6 +151,43 @@ static void (*hv_stimer0_handler)(void);
>  static void (*hv_kexec_handler)(void);
>  static void (*hv_crash_handler)(struct pt_regs *regs);
>=20
> +static DEFINE_PER_CPU(bool, vmbus_irq_pending);
> +static DEFINE_PER_CPU(struct task_struct *, vmbus_irqd);
> +
> +static void vmbus_irqd_wake(void)
> +{
> +	struct task_struct *tsk =3D __this_cpu_read(vmbus_irqd);
> +
> +	__this_cpu_write(vmbus_irq_pending, true);
> +	wake_up_process(tsk);
> +}
> +
> +static void vmbus_irqd_setup(unsigned int cpu)
> +{
> +	sched_set_fifo(current);
> +}
> +
> +static int vmbus_irqd_should_run(unsigned int cpu)
> +{
> +	return __this_cpu_read(vmbus_irq_pending);
> +}
> +
> +static void run_vmbus_irqd(unsigned int cpu)
> +{
> +	vmbus_handler();
> +	__this_cpu_write(vmbus_irq_pending, false);
> +}

The two statements in this function should be swapped. This function
runs with pre-emption enabled and interrupts enabled. If a VMBus
interrupt comes in as vmbus_handler() is finishing, vmbus_irqd_wake()
will run and set vmbus_irq_pending to "true". This function will then set
vmbus_irq_pending to 'false", wiping out the "true" setting. The hotplug
thread will decide it doesn't need to run again, and whatever generated
the new interrupt doesn't get processed (at least until another interrupt
comes in).

This scenario could specifically happen because of the way VMBus messages
are processed. The vmbus_handler function calls vmbus_message_sched(),
which always processes a single message. When that message is handled,
Hyper-V sends the next message that may have been queued up, and
generates another interrupt to the guest VM. There's no looping in the Linu=
x
code to process all messages, so Linux depends on getting a new interrupt f=
or
each subsequent message in order to run vmbus_message_sched() again.

There might be a similar situation with vmbus_chan_sched() and channel
interrupts. There are three interrupt handling modes across multiple VMBus
devices, and it would take some additional sleuthing to see if any of them
depend on a similar scheme of needing a new interrupt for each channel
event.

Please double-check my thinking. The likelihood of the problem occurring
is very low, because VMBus messages generally are used only when VMBus
devices are being added (or removed), which is usually during boot, and
the timing window must be hit just right. But the fix is simple, so it shou=
ld
be done.

Michael

> +
> +static bool vmbus_irq_initialized;
> +
> +static struct smp_hotplug_thread vmbus_irq_threads =3D {
> +	.store                  =3D &vmbus_irqd,
> +	.setup			=3D vmbus_irqd_setup,
> +	.thread_should_run      =3D vmbus_irqd_should_run,
> +	.thread_fn              =3D run_vmbus_irqd,
> +	.thread_comm            =3D "vmbus_irq/%u",
> +};
> +
>  DEFINE_IDTENTRY_SYSVEC(sysvec_hyperv_callback)
>  {
>  	struct pt_regs *old_regs =3D set_irq_regs(regs);
> @@ -158,8 +196,12 @@ DEFINE_IDTENTRY_SYSVEC(sysvec_hyperv_callback)
>  	if (mshv_handler)
>  		mshv_handler();
>=20
> -	if (vmbus_handler)
> -		vmbus_handler();
> +	if (vmbus_handler) {
> +		if (IS_ENABLED(CONFIG_PREEMPT_RT))
> +			vmbus_irqd_wake();
> +		else
> +			vmbus_handler();
> +	}
>=20
>  	if (ms_hyperv.hints & HV_DEPRECATING_AEOI_RECOMMENDED)
>  		apic_eoi();
> @@ -174,6 +216,10 @@ void hv_setup_mshv_handler(void (*handler)(void))
>=20
>  void hv_setup_vmbus_handler(void (*handler)(void))
>  {
> +	if (IS_ENABLED(CONFIG_PREEMPT_RT) && !vmbus_irq_initialized) {
> +		BUG_ON(smpboot_register_percpu_thread(&vmbus_irq_threads));
> +		vmbus_irq_initialized =3D true;
> +	}
>  	vmbus_handler =3D handler;
>  }
>=20
> @@ -181,6 +227,8 @@ void hv_remove_vmbus_handler(void)
>  {
>  	/* We have no way to deallocate the interrupt gate */
>  	vmbus_handler =3D NULL;
> +	smpboot_unregister_percpu_thread(&vmbus_irq_threads);
> +	vmbus_irq_initialized =3D false;
>  }
>=20
>  /*
> --
> 2.51.0


