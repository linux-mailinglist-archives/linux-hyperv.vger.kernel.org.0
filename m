Return-Path: <linux-hyperv+bounces-3492-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 751399F5E95
	for <lists+linux-hyperv@lfdr.de>; Wed, 18 Dec 2024 07:27:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F3C01891E3E
	for <lists+linux-hyperv@lfdr.de>; Wed, 18 Dec 2024 06:27:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1598C1552ED;
	Wed, 18 Dec 2024 06:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="Cb/sEpE9"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazolkn19010014.outbound.protection.outlook.com [52.103.13.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D8CF14D430;
	Wed, 18 Dec 2024 06:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.13.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734503244; cv=fail; b=WSkzf14h57evpRKP7EOyb9cV7xCjSwFUOcwtRt25SdwkrtxSLlZR5mnCR0eRCNNxEK1e9pGYOMyNWGM+77if7/j6LjFq+VBryoeeFLTbVPhhYqG7+hpJ0hbyvp6Cm719WWn3jeCiY6HvoAeT+dYspbs8oSaH7c+aSDnwY64L0bU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734503244; c=relaxed/simple;
	bh=1Xyjau8VVZIHAx2nPedphUSkYWadpaYuCT2j14z5PTU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Q0KErXkRXboYp4uryBlokwgp4daBn1b3uBW8wNoZkWYskppFQOFPpUj0Z9mCdecyCY7LKb9Axyus9YMYSJdvzNq26b0Y0kBtf6veg3Q4Gh+4xtkKlxJ0oRkxwZBIjgXcikti68muJC36ibtq+W6yZtTfZyyjcV3UexhWyZ5RchA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=Cb/sEpE9; arc=fail smtp.client-ip=52.103.13.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k1KWf1EMLIiVNUlCuhvWSwjXsucdVcKrgD6chLmNzHY1MWUmMm8HS0xUIcG1b4vFCrWfenYXgFCMKE9ivQreK6uGOrCLfAZurJkNJZ/UiA1Y3MYFKCm9vr1dkSm42cFJ07ZZcKmHMYSJBmlZvVmWfobzQjfLZoZc9q7z1bpY9bda+ZcXC3miFRnKi8PWQTZvOi3t1OhzyRbKAkt7EUCx23vt1sjVTPIYTj/vT2Uis3yc+FX6XEYab98EoXwyQ6+FD9DDO9wCQGfkedqh86V65sYmajV98HlWrE/zvAQZUaKr5p/dhFjmSztyCfvFrfM5U3gjWbWefHNhAx+0G/dgZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ubXkfxHX/jZAWyqtNDzIdiy4WT486EBW3Zm4Zn3VmAk=;
 b=JGzrAfW8gr2Ij1KiXuGD1BnywQ04TqXp9Cn/tcvqtpZudA09xnPJNzqhXZwkd8OPMGDCOLwtJxcNiEXXD7p7XQFmc605QJdrvRvq1+P3xCJVmIUamsgy7gNS0kbyvwHKM/YpeiLksFDZW1a4hY7N9STcZNWsqAIxobZNP4qbmm2uulNPefOmNfTsWhIHYbypH7LXLWI/XGm5P70lXzdzvjRCAIl3I7VckSxlJ2SrjqwLJaAK9vYtygr03YPmHRmBEV511awXh6P7RV49Rz6sCkS+uw1Skko0U0LjmmxUdkWwrEe1RR5AhKAcirkhyoHhl1pTKxYPEm9R8fnCq0zNRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ubXkfxHX/jZAWyqtNDzIdiy4WT486EBW3Zm4Zn3VmAk=;
 b=Cb/sEpE99+1qZ3FA8wIIyFHbErCLAHam9778OkAxqIdbqoUAeFCpjWhuEvEGt7Nn/JbMGTk9f01nLl3nfvRA1Sjo7rWDknsx8PuGhMw7PJ/v/SqGGILn6cpABfssJd3PcMqCSyzHhYYd7bX6+/1lhWguxsU7BcU+6u+mDbFBR0arY1ETPaLTFghVQ5uqH9ARnFglogSNuxdD+HsTnLFadEdJC37K5ZgF02g87ljY2O2ug4Ug7mfJv0qo+9qSO/gntOXHpumiVn430Urvbn+9nbbMR6evwFdxDQNhalsInP8TBaJFkhtp3mpIXetgkuLYNtmq7Q+vBJpN0giOIHqF3w==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by SJ0PR02MB8481.namprd02.prod.outlook.com (2603:10b6:a03:3f9::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.22; Wed, 18 Dec
 2024 06:27:18 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%4]) with mapi id 15.20.8251.015; Wed, 18 Dec 2024
 06:27:18 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Erni Sri Satya Vennela <ernis@linux.microsoft.com>, "kys@microsoft.com"
	<kys@microsoft.com>, "haiyangz@microsoft.com" <haiyangz@microsoft.com>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>, "decui@microsoft.com"
	<decui@microsoft.com>, "jikos@kernel.org" <jikos@kernel.org>,
	"bentiss@kernel.org" <bentiss@kernel.org>, "dmitry.torokhov@gmail.com"
	<dmitry.torokhov@gmail.com>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "linux-input@vger.kernel.org"
	<linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: "stable@vger.kernel.org" <stable@vger.kernel.org>, Saurabh Sengar
	<ssengar@linux.microsoft.com>
Subject: RE: [PATCH v4 1/3] Drivers: hv: vmbus: Disable Suspend-to-Idle for
 VMBus
Thread-Topic: [PATCH v4 1/3] Drivers: hv: vmbus: Disable Suspend-to-Idle for
 VMBus
Thread-Index: AQHbUDqhVPd1QUiasUqKhUjUDep3ZbLrgVSw
Date: Wed, 18 Dec 2024 06:27:18 +0000
Message-ID:
 <SN6PR02MB4157123D8C5C35C2B169A1E0D4052@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <1734409029-10419-1-git-send-email-ernis@linux.microsoft.com>
 <1734409029-10419-2-git-send-email-ernis@linux.microsoft.com>
In-Reply-To: <1734409029-10419-2-git-send-email-ernis@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|SJ0PR02MB8481:EE_
x-ms-office365-filtering-correlation-id: b1ce7b1a-5c59-406e-3785-08dd1f2d057d
x-microsoft-antispam:
 BCL:0;ARA:14566002|8062599003|15080799006|19110799003|461199028|8060799006|10035399004|440099028|4302099013|3412199025|102099032|1602099012;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?Bk8SmDbDi5UieLvGCKjsjEzyQcw4spymdHT/Bw0lrBoPhm9aygI5m7r68dfE?=
 =?us-ascii?Q?7l+bf0hIoZPy+oPbZOGRIaVc2oo6uO3LVmH38rlcFWSS6x/oLRwA1W8AR7i9?=
 =?us-ascii?Q?TYwNbJtOg9seKcECbFbQRfcFDVRwnaZ0/RAonTnqF9FR9ifMoItgbjunwr1U?=
 =?us-ascii?Q?xFpnhlurbmZ+SXjhbIjFx+/jvWXq8bGGrd+rn3fDH6JkzuL3hc2OmIsLZSco?=
 =?us-ascii?Q?7U05BSiQiq0BlHTbdw+7fKnDa0ZUzgUF8kO++9DeVDDk1IixUH6+sbAEC9pH?=
 =?us-ascii?Q?I8KfYfusKeX5rUi6TWJHvGL3qM8PLkyVayRzln0II5F53DNX0o2sheZs/Gpc?=
 =?us-ascii?Q?wTM0FZDFM8iXGRPjvpoxXOFi3da1jz6h67sXqTCxRMvqkdPNW/DNAt06OX05?=
 =?us-ascii?Q?oP1LMl+87BW/ucDoucxrFiBwiqBTiP2BEKGOOai+bnIbgnGSvITuUPuSuk9O?=
 =?us-ascii?Q?F++o9blzltQP6X+937WSWpnYy4kjkiKkV4xCUDhNptBh1FDiUHL8r+mubetV?=
 =?us-ascii?Q?RPjz15rKHwH7Nf+Ys+XwtwyP0fSOyKE3DccTo/B61gJHNjhSxnlKsF9I6efF?=
 =?us-ascii?Q?5QwoU5Zg+svkOiiNVgxfR4hF1J2VSstTwM8KzE/EKchYgNpDiT0FriMO17Yf?=
 =?us-ascii?Q?7i2Phi2e8tu49HXlwL/OQbHGWeklrESyOQfci3qNw+0aKjUICQ8y6FdvRC0g?=
 =?us-ascii?Q?AZqE+exBnSbpQjgoudqUefjnPC3gi31Usze2EYn/DoQWqrffL5sSsDByyGJR?=
 =?us-ascii?Q?5cuInIz6RKsxdjTkPwlmpjWkJLpICfSrQltwQ+N5cKuzOVFMfeHb7Wf6/7aJ?=
 =?us-ascii?Q?YyKbKQSopaEUFTsmCfn7BpRBn2PJryfc0XbgKAwYM8tgZdIo7gx3FJn84ZSI?=
 =?us-ascii?Q?vTRO/M9oNtGClkn6aF/zRDAuWa+bILhrPP5nVKfAE9QYiT7SY1diOW+k5xbX?=
 =?us-ascii?Q?0flzVmVp2e9h63ubRddAKie/yGe/SINI5wpzUCA+uWgzLp1ED/2ePxe6prln?=
 =?us-ascii?Q?OlqBDYa61nQJpHkmd17PJBAQytBADJFsTZK688z7dfcyCSsLpbLYMdpBrRxn?=
 =?us-ascii?Q?FAb4+PUZOLt/48OScGVYGu0vPA7gePZr23j8/vP+9ChV7r3waDV5m8hN8v/i?=
 =?us-ascii?Q?GKD3DYww8TOoeOF/1amhg/EPH/sGgi78e2sFtT0NiOnuiSFxcxJcKoQ=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?psvinjfZoYXaQnotvsdX4abtxhWNyOofYdFcrCmU5KwQpSZxiB11CevrGHhz?=
 =?us-ascii?Q?hEkQSr3VdsolLtbnTW3mlGDUuLPH9GNcMw7F9z2Pr0Y9hLV23tlng2jrkTrn?=
 =?us-ascii?Q?hG4iRWxcS8fNBmBRb+v/mOOVNk4lfq2b7vwXPdA7w/bCVWi6c7AoR6jnSRjk?=
 =?us-ascii?Q?JKtifHP+lnRGu9zuqrw20V4aNqvCoyfRMcAIJ1IbuTi18RggEnV3X8uACcEV?=
 =?us-ascii?Q?fJQJNvanaGzQj2XjSJy0gc8gVZlq3a4Z8YlvDHtFdovY7YnLFGiPC+zH+r8B?=
 =?us-ascii?Q?ThfNYyR3oCFK4KBjzPFc1ln0H7FEuISJagzodIzi+tJebOsghguIXVO5OZ2A?=
 =?us-ascii?Q?u7aqzddp4Pq7BJpvZCKCxh+SAGYOmz44ZMRJsa5U+VK4r4XlcriIXs0sbKQJ?=
 =?us-ascii?Q?zLOUtXEa+CJaB+ItZsrDRygIi7XeXhY1rmnalYOkxaPoXghyNEM45zLJ4d8f?=
 =?us-ascii?Q?RYB/BIZ/d93LVXNZojhpzQF+C1BmChclPWK0H4SZ26/Lfvokv9JUQNwfRXza?=
 =?us-ascii?Q?/ZOz2R2IjR6IZNqAVur9xa0vhU/aMKOTIhPKMK7QMyJVa6IL8Ku0ovSbgrFm?=
 =?us-ascii?Q?TNIi7v2+GZovaNUl1nwUdghDmxkc1pW2KYP6VgOYkT1Cm5ZkKbAcNhCrH3CA?=
 =?us-ascii?Q?g7ZUTVDkJNgzKpE2dHjQmYyBwiMIhiu1/zJUWe0fypuYcFEVO8iP5KNaGHup?=
 =?us-ascii?Q?JRBFd3xq/QuubAZeIMH57KHWvT4mV/0Mtcp+4cxfBaI9EH5/YBMn1sLS6H+4?=
 =?us-ascii?Q?ebasDKiQN6NThg5h7GXl6ULlv1ph+OHYzfURriGouuTO7uhVrqdHuM3GraMm?=
 =?us-ascii?Q?d7lVtskx/lYQCB8JK7Yd3uSJK48pgqyxVmvxbvv7r74zCLDQTh6RhcItQrhV?=
 =?us-ascii?Q?Y0RTIbCHC74/DmO6PL0gDKsmiySzt35LF2N0V8MvcV3RlSim7Kyl/+udwyep?=
 =?us-ascii?Q?sisVRr1u92Lq7dG0s74n+DVjnx988hnhZtDUfL6QnTa5mI2clA9CJzFR6Flm?=
 =?us-ascii?Q?EOSE8743yPw2CveSl0tknp1TRUylMiNfR1YFjpzezOO7LpZFsZFjDZYblC9u?=
 =?us-ascii?Q?qprx2xhG086zpaogMOlPCUMDAHFtthsnjUamZ9lKSdMu/hXOGb4glrxHHfe8?=
 =?us-ascii?Q?dJxOggumU3iLORJQ4M1jCmH5GbSuCdZVGcAXhtZw+aJf86gi95pwSJ2Qlyy8?=
 =?us-ascii?Q?j4x18+j3sgrgAiDI6iX65AFfUEvyemoP1qcWd8zEJhyXLjhvIDYIHBMaWgA?=
 =?us-ascii?Q?=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: b1ce7b1a-5c59-406e-3785-08dd1f2d057d
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Dec 2024 06:27:18.2400
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB8481

From: Erni Sri Satya Vennela <ernis@linux.microsoft.com> Sent: Monday, Dece=
mber 16, 2024 8:17 PM
>=20
> This change is specific to Hyper-V VM user.
> If the Virtual Machine Connection window is focused,
> a Hyper-V VM user can unintentionally touch the keyboard/mouse
> when the VM is hibernating or resuming, and consequently the
> hibernation or resume operation can be aborted unexpectedly.
> Fix the issue by no longer registering the keyboard/mouse as
> wakeup devices (see the other two patches for the
> changes to drivers/input/serio/hyperv-keyboard.c and
> drivers/hid/hid-hyperv.c).

One question: For the keyboard and mouse patches, it looks like the
code change has the effect of changing the default value of
"power/wakeup" for the keyboard and mouse device under /sys to
be "disabled". But if a customer *wants* to enable keyboard and
mouse wakeups, he still has the option of just writing "enabled"
to "power/wakeup", and the wakeup behavior will be back like it
was before these patches. So in other words, the patches only
change the default enablement setting, and don't mess with the
ability to generate wakeups. Or does disabling the "freeze" option
for /sys/power/state mean that there's no scenario where wakeups
are useful, so the enabling vs. disabling of wakeups is moot?

As you may have noticed, I've posted a patch with documentation
about how hibernation works for Hyper-V VMs [1], and I probably
should add a paragraph about wakeups. So I want to make sure
I'm understanding correctly.

[1] https://lore.kernel.org/linux-hyperv/20241212231700.6977-1-mhklinux@out=
look.com/

>=20
> The keyboard/mouse were registered as wakeup devices because the
> VM needs to be woken up from the Suspend-to-Idle state after
> a user runs "echo freeze > /sys/power/state". It seems like
> the Suspend-to-Idle feature has no real users in practice, so
> let's no longer support that by returning -EOPNOTSUPP if a
> user tries to use that.
>=20
> Fixes: 1a06d017fb3f ("Drivers: hv: vmbus: Fix Suspend-to-Idle for Generat=
ion-2 VM")
> Cc: stable@vger.kernel.org
> Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
> Signed-off-by: Erni Sri Satya Vennela <ernis@linux.microsoft.com>>
> ---
> Changes in v4:
> * No change
>=20
> Changes in v3:
> * Add "Cc: stable@vger.kernel.org" in sign-off area.
>=20
> Changes in v2:
> * Add "#define vmbus_freeze NULL" when CONFIG_PM_SLEEP is not
>   enabled.
> ---
>  drivers/hv/vmbus_drv.c | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
> index 6d89d37b069a..4df6b12bf6a1 100644
> --- a/drivers/hv/vmbus_drv.c
> +++ b/drivers/hv/vmbus_drv.c
> @@ -900,6 +900,19 @@ static void vmbus_shutdown(struct device *child_devi=
ce)
>  }
>=20
>  #ifdef CONFIG_PM_SLEEP
> +/*
> + * vmbus_freeze - Suspend-to-Idle
> + */
> +static int vmbus_freeze(struct device *child_device)
> +{
> +/*
> + * Do not support Suspend-to-Idle ("echo freeze > /sys/power/state") as
> + * that would require registering the Hyper-V synthetic mouse/keyboard
> + * devices as wakeup devices, which can abort hibernation/resume unexpec=
tedly.
> + */
> +	return -EOPNOTSUPP;
> +}
> +
>  /*
>   * vmbus_suspend - Suspend a vmbus device
>   */
> @@ -938,6 +951,7 @@ static int vmbus_resume(struct device *child_device)
>  	return drv->resume(dev);
>  }
>  #else
> +#define vmbus_freeze NULL
>  #define vmbus_suspend NULL
>  #define vmbus_resume NULL
>  #endif /* CONFIG_PM_SLEEP */
> @@ -969,7 +983,7 @@ static void vmbus_device_release(struct device *devic=
e)
>   */
>=20
>  static const struct dev_pm_ops vmbus_pm =3D {
> -	.suspend_noirq	=3D NULL,
> +	.suspend_noirq  =3D vmbus_freeze,
>  	.resume_noirq	=3D NULL,
>  	.freeze_noirq	=3D vmbus_suspend,
>  	.thaw_noirq	=3D vmbus_resume,

Immediately preceding this definition and initialization of
the vmbus_pm structure, there's a comment that talks
about supporting Suspend-To-Idle. Since the intent here is
to *not* support Suspend-To-Idle, that comment really
needs to be updated so it accurately reflects this change.

I can't help but also notice the bizarre situation with the
function names. The "freeze_noirq" function is named
"vmbus_suspend", and the "suspend_noirq" function is
named "vmbus_freeze". It certainly looks exactly backwards!

The "suspend_noirq" function should probably be named
"vmbus_suspend", but that name is already taken for use
in the hibernation path. I don't have a great suggestion on
how to fix this, other than to rename vmbus_suspend() to
vmbus_freeze(). That change wouldn't be that hard to do,
though then vmbus_freeze() ends up calling the "suspend"
function in struct hv_driver. Fixing the name in struct
hv_driver is harder because most VMBus drivers would need
to be updated. Sigh.

But it might be worth fixing the top-level function names
of both vmbus_suspend() and vmbus_resume() so they
don't look misused as the freeze/thaw and poweroff/restore
functions. And then the suspend_noirq function could be
named vmbus_suspend() so it makes sense.

Michael


