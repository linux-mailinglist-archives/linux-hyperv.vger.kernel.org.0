Return-Path: <linux-hyperv+bounces-8580-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4FyVE2vgemnD/AEAu9opvQ
	(envelope-from <linux-hyperv+bounces-8580-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 29 Jan 2026 05:22:03 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B1DE1ABA67
	for <lists+linux-hyperv@lfdr.de>; Thu, 29 Jan 2026 05:22:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 745AA300D60F
	for <lists+linux-hyperv@lfdr.de>; Thu, 29 Jan 2026 04:22:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFDA4242D7B;
	Thu, 29 Jan 2026 04:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="kL2R6ubw"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazolkn19010003.outbound.protection.outlook.com [52.103.20.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32A01199FBA;
	Thu, 29 Jan 2026 04:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.20.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769660520; cv=fail; b=ntgf/uKMBf5tqnxgBVsPtXOaSqQZGSH/WZSdjXKncosVBSgDx5q8XA7QqNBonfksLljeqfdN15vI3v+K6DXV+ElN+A6ah/qGrXkPeXsNklt3inhxeu9DKj8OwwMpftuKXQ23l7p6WCBzJI4aoESKoK3Nf/mOQkAYi/iRUfvBUGE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769660520; c=relaxed/simple;
	bh=Vg72rODSzftz3cN01Iy6FR/6qLi/ch4YDlAW1lB8cGs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cbVxPU8jDsRTxrvGEPw30NaPBGbWnO5SBgGuKqSmgGGe6VYIVgBh7VYgvE1V05e67WZqo/DaVFAXaVBQ6PKJIOX2YXIXuCmRuveRMq4TnWfbm/UaAaqoPVM0vV+Q/7i7HHb816jRKr+8B2h4ftTqOBYEiLUPDDOp/netUUgi6mI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=kL2R6ubw; arc=fail smtp.client-ip=52.103.20.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mo70tgdJ5i7kdytmOW/kbw7bN/h6udvNOG4oopPQqhatpBece7Np0/tDcT/egTrfP9AEisSjoCynAKdzlwwl6S2liklso+GSbyzqR77BE94h3CpQHOJfeMVzEfOUUzg0nMYM9YEXIYApAFCtHLzkqwGJHnCMZQy7cDCDoofozQW384vAl6NHoGiH+W/I362Jd6eexLr7eUOXFvObZw4iF3S2SeBsv4fA/74ickmWs7Lpi6Y5Us4R/43cTzF6Seb+MIoyEFi23i/I4Z7CI6QRHThiyeYLlsncBPHAeVrKmHNjhz5bV4yr5pmgTHEjaWc/naiQ4YRGsnUYBvHLpXVW6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iw5sJVypjKmyCU82+TUKppE68sYCXrA8PnKEiauCxIM=;
 b=EEqiSO+rMQH6iolo+g72szTqxS+f48mzK0zM+XXlqNlZP9rItoB5IWgKbqYZOLpZnQjOFjRi7mxt9O8vZ6gFuOgLh3BUCMf2YL4osM9UWoBhTR9umWI3TTQt0kYIOl0fxL4zfM4Nz6ZYvUb3gvU4PZvBPDfxd8wfCWQj+QpKHL1iuEtcan4t1xzZTrwOURuG8BoxB9NL/jASy7mdv67XSCV84HPueNGJbpZnoSsk3+3sjzUrmAXu7crF4FPzKntV6EU8XKKSS/YvHcXNkYK0ldIQlKL9+SwItzWGLER/Iv4snWjZbaDGd/foj9a7m8kn+oYwJKsHLnYimlIXe1YZfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iw5sJVypjKmyCU82+TUKppE68sYCXrA8PnKEiauCxIM=;
 b=kL2R6ubw2YxvBaTyqmuCHN8iIfVNJhYfSh5kxJtZxCymjWCZ4YXsPkG9QRxuTDx9C2PYKx8jreQEgCzVmznPbIBSDO2JTsxOcJJHvdbZr1mzcCnJ/PR4hb/W9AkiPfanGbNTXzNijFRf/jJW6zRQ9lsa9UWuln7n8MzqpgNQi123eweSD3JuiYAuTc0sNG7MoFtjwqcLZxfTYt+wuWZwVS5NdWHvqt7OlYo+UHtUZ+rn0+tWu7U/ROQrdbuM9haKJqHt/gTqY5w/oS/mW8sL3KsJ/ApKuFAeD5lOoVwZ5fGfDmwFD5/rfmdwOHJSVpophblq6dIDU/q+WnlTjUWGsg==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by IA0PR02MB9808.namprd02.prod.outlook.com (2603:10b6:208:490::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Thu, 29 Jan
 2026 04:21:56 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6%6]) with mapi id 15.20.9564.006; Thu, 29 Jan 2026
 04:21:56 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Mukesh R <mrathor@linux.microsoft.com>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: "wei.liu@kernel.org" <wei.liu@kernel.org>
Subject: RE: [PATCH V0] x86/hyperv: Fix compiler warnings in hv_crash.c
Thread-Topic: [PATCH V0] x86/hyperv: Fix compiler warnings in hv_crash.c
Thread-Index: AQHcioqaeW54Ou9v50GB7tADNUOJnrVomILg
Date: Thu, 29 Jan 2026 04:21:56 +0000
Message-ID:
 <SN6PR02MB4157F7458CA9AE3F84B9B95BD49EA@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20260121024045.3834787-1-mrathor@linux.microsoft.com>
In-Reply-To: <20260121024045.3834787-1-mrathor@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|IA0PR02MB9808:EE_
x-ms-office365-filtering-correlation-id: 62835aa7-c888-48a4-105a-08de5eedf06b
x-ms-exchange-slblob-mailprops:
 P1EfU6pZOd8VPwDsmXmpSwyPl9aRR8R+GDi+H6fd4ugzEk+W70RbYs54E1NAzTf/yJAxVd6pKMWa5DoW6YaudKeFjDCma01WV2KHxZpRx6P4gMSpMAdKPJfrCzWzSEVW1irytBxm2m+euO7qchSnOY+rfaZQI9ZMykVAb0MHgKQQmvdd8PsAf/ReVMOmRp9exDqcp0owLMjmsvuvrbARqt+pmVl2pkzp6RfF6I1rii8PuVlfGLhcnE2a5ZbY8ZnRiBmcOVADZv8Fno5colbcPf6m2CYgtIJKwH+FzE+a47aYRQlG1X4VVr5t3co1O0ZHu0e8QuVWfj3hFUpLkPMi/E5hfUq0DnKcfhxZs45w6AL0mGc163/MZnLtYbLzQWoaL/JL1vdm0jVhfCJznzNgdQ6ogYAwQBfeHGogQdFgaRq5KSa5gD/X0fLrjw9wi3fCbfo3Av5jM2jIPvK54y5PlVtqe8FYa/nvMocZMavEZjWGlslnfKLVTPD/c8GL1Dpg9N1bKX7uBwWn48LRbpkrUUYYUNWT5dJnUAkduW2OyQCokbMO80jFdVn6kIgmzpkOxy+Uy1hD3m1ZIKTJYDV1ITb/579zzrb32JgqE+ZECKmaXGpFkswzHHTU10Z3xDz6d0CVkzW5/ZctfjKSYz33fxSn6GHprIO+unUgK/IQakY45X8eA09FV7FnRLh/P0Gp/HA6AXfPXQRHuj3E1r2WHmYZS23bO83vxUcDSyXIKj7XJk3YAilxr/ZwpUlumF1YRDStPtkr7zN0ygj2ec/TX73MNN1X9FOjIZxPG9sNL+7s5foPztOXSQ==
x-microsoft-antispam:
 BCL:0;ARA:14566002|19110799012|41001999006|8060799015|15080799012|13091999003|8062599012|51005399006|461199028|31061999003|1602099012|10035399007|440099028|3412199025|4302099013|40105399003|102099032;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?gKamrhDJFeQMYS4rbObMbjQkyjFMeTyRUFP2vw+Lts9k3qYQuJi6afwqSKjw?=
 =?us-ascii?Q?bkcy9+hQ+NYBBE6q/c5HjXSddNwdtdPjvGdfdZ5/sDuFpWfHclkPi5C2E9Ij?=
 =?us-ascii?Q?fyWOKvbYibuWVhHOBBekVQFlc1zFeZ04yfXEQwcHqzihvluUKtwyQNTR6by1?=
 =?us-ascii?Q?WLjBJ7xKyFlDIS73XYx00nVGl7wvkL5VTKFDjG6HTeL0YwffJTaXTtQGNzms?=
 =?us-ascii?Q?5eljZ5FK8yOqhL80aEOS4SasS+/ZTDkOGta7awtDgHmphsWrXzMXzHAmZOoN?=
 =?us-ascii?Q?mWR87FRROvA2igsB2SAmTKOSMhPoEVjPqV/o00foprxTbHi4WGcBkJeIahTY?=
 =?us-ascii?Q?JjQ4x2gdXuwbjtzp0Y5I1wokxhRPLwvd+oOcg0NH27vuEMsrnG2HOjAp8M+d?=
 =?us-ascii?Q?STVYyTekmrRPH/Pj3nQziG+rC/0/cgGnSaoc5Rq1dIy0+DgWQ1kiW8ccm+Qh?=
 =?us-ascii?Q?BMf7QccT0F3asmzzqx8cw7M4nMD6vICwwT6xo9475NYO4qWNzSeYAz6B+2KM?=
 =?us-ascii?Q?pCXD3jRm42iThvjTuvZYJMV0YL1h/GlIQ53I3jAkJeo3Bok/iS5m7qJowyhI?=
 =?us-ascii?Q?Q5Oar1+RzXDVHiI4CSvI2Oje5CrNwmvSZIegZ1gtUvaiETSToHirJwuUFEp2?=
 =?us-ascii?Q?V/XqfjqJ+/wfY00IfeDRFuVLi62Dl/lJngndawMntA8ojOgTVQF3HW5WojTH?=
 =?us-ascii?Q?LeGlw7bX17R2rnG1JncC1uPA4npzIS6vY/oshSwdyjulZ2TqYo4xjaMoS0Vo?=
 =?us-ascii?Q?E2cRHrqrJ0yV18+9FVXiexybPg+q+gNzyXTUFV81O2zI29KWZgQqNo1oPapp?=
 =?us-ascii?Q?dgyRgTDFERdd99khAqnqFDt51SeR0jbxkMLiN0WIYIOxjUTy2v+rjipqS1tI?=
 =?us-ascii?Q?LSV+E0/hu6MRvPfYClb5FjopbboTtuy3956Y2tBwPw5BmzG0h2GITXFthVCY?=
 =?us-ascii?Q?OHCfP3BOMmUTiwp9MRMgmgZp006xJfqcdSIfc64G+UdUi65u7im+qtHNgsOc?=
 =?us-ascii?Q?2lm5my1NgbhooSeB0hYRDRu9U6APfxCFgoKl9Fsria8YKjkr2BVIX/O/C8dJ?=
 =?us-ascii?Q?wP3AdI3hmmDo7sEoYSL3FS7zmd/pW9X3ZDbEj/Qhss6E5KyeWOhsy59jfZBV?=
 =?us-ascii?Q?WEKeC53tDFD8cfDv+8lEKxkLl71QSydcQyuIyHCb/Fbe+2x3l4WluvgLXMkp?=
 =?us-ascii?Q?wflRAdnu3/HDMYNklPJ+qOtojuqkuFx8WVLu7Bwl3jOgKSVDt6WOIbtVeb5h?=
 =?us-ascii?Q?lPDpbDlop0X2E0fp3lQYgCNbAlOMoUTffwScWzOkutcM/whb8onVRXYOMNFN?=
 =?us-ascii?Q?KCdXWrPhH4fSulnh/EyEUPVMzpCjtnMU3ev2eFYz1ifSukMzzlzUw2KPFojQ?=
 =?us-ascii?Q?juXThJluYcu0wqRVScoAe4m6zTp9?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?fuQ8IXsJt5pjGCD+XKGmL+x1iOTdNl/5RHD7WmORwHHUEBqssTTh42fHHook?=
 =?us-ascii?Q?6a0iuSUJKcdq5Qsjwy7zPLKjqoj+3rxmqLvBOhbUZJ1YXtdEgQxWHKcLrDqv?=
 =?us-ascii?Q?zUYsl17PfAYdGZ3g0HYdEw0JAzlXWaatkSEcxzRTAKaJbjM7FlhD7xYSsLAE?=
 =?us-ascii?Q?/eTiILxn/DyzQWa7nX2WBt5gWBZsAh/4HhaFdRtCJxR2yYlZHbpZjmoq3kep?=
 =?us-ascii?Q?RAVCcA+UnZbx0XX2axjldb1YJNmC0mxDZsAkAfyH+qwvxHv2KASJqdB5uooY?=
 =?us-ascii?Q?/JelmsXuj3d8iyeXpN+XUcNpMjnylRfcs2bEXYriPLMV1NtxB+lsTjrCz7jp?=
 =?us-ascii?Q?OofoBvXxizUvqISMjZRO9K6EPhw6iKNGJn8Hd9x/Cx2MzMpSeEuxaHbmXeBV?=
 =?us-ascii?Q?urLvTmyZReQmw7raZbvsNilNA52VL28hySQiOx8ZTyjnGxiMI7AZcIiH0BbW?=
 =?us-ascii?Q?pXLFa/R/g5DcrdBkq6YhMfRWM2yH2ZHsH7M2DaupGn2lPHSbg8AFCIlyFkrM?=
 =?us-ascii?Q?Xm2loFlOf01BUuDb3nBHldkeXF8Q6Lp1i8vw2s2X7vba7+cEPavzFBzkqBr0?=
 =?us-ascii?Q?pKYDyk/RrTXqX4CRuN+3DVZWJzYncFc+19dHwc8+Dgm3q3fHO3vojWOGtHLL?=
 =?us-ascii?Q?q1Qj2Ax/YbW7L9v7JWmCupJkrAZlmDgGjTkzet4bPKnNpwjqAv8EzI65Wy8d?=
 =?us-ascii?Q?5Uu1vH4YGyxO7XvlFlCmaiS5M2o080Z2xpSFDUrrsU5ZF44u6t1SxoFu0gi/?=
 =?us-ascii?Q?11ZdK6l1VWwePUIf6HgSfX+fuw46aWNE6M+Jj7m6oaHUUSD+G1uvpj+sy8iS?=
 =?us-ascii?Q?ARm2Pa+GIP6fD3MrW7N0y10otVMeq3L+01ociXOuQXSIH0IKh8SbR+ZBtfYh?=
 =?us-ascii?Q?UK7gMXjTWgG+OOOinS1S00Ik/qsxZdyxRPq4trpjhNVN5jcDSLDUdLmK2JjT?=
 =?us-ascii?Q?Mv5SdNbOHvYYF38w++JaM+577p8ho0I4YaYgMM9wslHLPi33V6d6AreoJVT+?=
 =?us-ascii?Q?DrGGv/l2NbSm1R80rPQgDiXhF/Q2OFKg+0/9v3oyir2Cnm9LRoaxSa1fLO2J?=
 =?us-ascii?Q?VopC6KsMXCXZPyNrcJwb3xHZPkXMc5wwtfiLDp27Vna6aEaiOX0E/zH/NfK6?=
 =?us-ascii?Q?m6+MN3ugKm1X7KlpVCkBg4ojMDdExL5++TgdD+VgvCPcL4egEbfKnVL3KNf4?=
 =?us-ascii?Q?2jdmmRibhfT4gCTbvVGgv7e8+8Mtpvm4ysqc3sUFgkh0nPD7btlOEb35xNbP?=
 =?us-ascii?Q?6KfCnUDM/VZakcg6F0LV/Z2uoiKA+9qpSB95154JngKreWemu0jcTvKAJpvw?=
 =?us-ascii?Q?pIPXzheutH4tJnzd5BsMaaxVnz4m+s+/nN9RZgsZJL12sAkH3ZnMSWcd+h0E?=
 =?us-ascii?Q?I5y3YRc=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 62835aa7-c888-48a4-105a-08de5eedf06b
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jan 2026 04:21:56.6576
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR02MB9808
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[outlook.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	R_DKIM_ALLOW(-0.20)[outlook.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8580-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[outlook.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mhklinux@outlook.com,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[outlook.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-hyperv];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[outlook.com:email,outlook.com:dkim,intel.com:email]
X-Rspamd-Queue-Id: B1DE1ABA67
X-Rspamd-Action: no action

From: Mukesh R <mrathor@linux.microsoft.com> Sent: Tuesday, January 20, 202=
6 6:41 PM
>=20
> Fix two compiler warnings:
>   o smp_ops is only defined if CONFIG_SMP
>   o status is set but not explicitly used.
>=20
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202512301641.FC6OAbGM-lkp@i=
ntel.com/
> Signed-off-by: Mukesh R <mrathor@linux.microsoft.com>
> ---
>  arch/x86/hyperv/hv_crash.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/arch/x86/hyperv/hv_crash.c b/arch/x86/hyperv/hv_crash.c
> index c0e22921ace1..82915b22ceae 100644
> --- a/arch/x86/hyperv/hv_crash.c
> +++ b/arch/x86/hyperv/hv_crash.c
> @@ -279,7 +279,6 @@ static void hv_notify_prepare_hyp(void)
>  static noinline __noclone void crash_nmi_callback(struct pt_regs *regs)
>  {
>  	struct hv_input_disable_hyp_ex *input;
> -	u64 status;
>  	int msecs =3D 1000, ccpu =3D smp_processor_id();
>=20
>  	if (ccpu =3D=3D 0) {
> @@ -313,7 +312,7 @@ static noinline __noclone void crash_nmi_callback(str=
uct
> pt_regs *regs)
>  	input->rip =3D trampoline_pa;
>  	input->arg =3D devirt_arg;
>=20
> -	status =3D hv_do_hypercall(HVCALL_DISABLE_HYP_EX, input, NULL);
> +	hv_do_hypercall(HVCALL_DISABLE_HYP_EX, input, NULL);
>=20
>  	hv_panic_timeout_reboot();
>  }
> @@ -628,8 +627,9 @@ void hv_root_crash_init(void)
>  	if (rc)
>  		goto err_out;
>=20
> +#ifdef CONFIG_SMP
>  	smp_ops.crash_stop_other_cpus =3D hv_crash_stop_other_cpus;
> -
> +#endif
>  	crash_kexec_post_notifiers =3D true;
>  	hv_crash_enabled =3D true;
>  	pr_info("Hyper-V: both linux and hypervisor kdump support enabled\n");
> --
> 2.51.2.vfs.0.1
>=20

Ingo Molnar has separately fixed the smp_ops problem in [1]. Removing
the unused "status" value looks good to me, though it's probably slightly
better to add (void) to hv_do_hypercall() as an explicit acknowledgement
that there's a return value that's not relevant and is being ignored; i.e.,

	(void)hv_do_hypercall(HVCALL_DISABLE_HYP_EX, input, NULL);

Regardless, for the unused "status" part of this patch,

Reviewed-by: Michael Kelley <mhklinux@outlook.com>

[1] https://lore.kernel.org/all/176959812223.510.4055929851272785854.tip-bo=
t2@tip-bot2/

