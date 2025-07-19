Return-Path: <linux-hyperv+bounces-6306-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 592FFB0B16E
	for <lists+linux-hyperv@lfdr.de>; Sat, 19 Jul 2025 20:31:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36E12563B2E
	for <lists+linux-hyperv@lfdr.de>; Sat, 19 Jul 2025 18:31:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19FC92D613;
	Sat, 19 Jul 2025 18:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="veYZiQmR"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7525C1BD9F0;
	Sat, 19 Jul 2025 18:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752949837; cv=none; b=SqXkMBEQ9ZjboPHKaQTz3PksJUWzKc3ER5iQ6urXneHIdGPqhMvpqVZYQXTbl8hUUyw3y/bjCtxTgZuTCtkgd4RztlZiTDM9vp/sOwyU2oWne3qw+haBDc/J43WVPsC99GXXKylVoV/fNTc6LUygDTN8arWXpKyR/hXDqLoRDAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752949837; c=relaxed/simple;
	bh=ZQFXN+4WzD7jKBLh5oypmTSUf1CUjiMy+b/vLiqqfkw=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=grsLhxjE4Z69hIc+c2rkPYQG51SEnyCx9nR2IdCQ5Bqa5CwjFKUfxmg775+1KxbYpFNPXVmhNd6nv/b2wL7XiJz9xS4eRGYl0uYfQkFG8+j+TuSEL5nkvfWjjQxE7crI+Vu4c0/0EkFGfHGurviux2ngrlGEt8v8GfTGbgBvYxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=veYZiQmR; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1752949817; x=1753554617; i=markus.elfring@web.de;
	bh=a3QgTRHHQ0/aoizI9UL3i6HpE7jqiS9CG675ivg5XCI=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=veYZiQmR0jzS4UVMXuOztIQ389i+lWAene+U0fUJ3zBrRFarmWnQZqD2vun3VWhf
	 z6QLIZhiiMdGJxbZtGJqo6hjLkBVqSLKcRZ+LPcGItrbdH4b4AdhkDiuqSnkYMF1i
	 ijpt/xPQ2TwMxK4KASeE3nrAtlvTR/Sk72D9xKOJNClge1tnFyT/kOZ4PCdiQLBa8
	 HqXY9Etp7efuWsGEAu+auk+yoXzt5zy+0iJ5EvXm4Qo367caQ6zDixoBWNKkn+5g6
	 zI+fjVSFSkp67X8C6Qs4KKMBvPu7H3bdOuhfmH3PbRXQnLL3PwXANGNKCEEAVRG9P
	 dg5wSql3cFNlhErYig==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.241]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Mmhnu-1v3yM23Ros-00f9sY; Sat, 19
 Jul 2025 20:30:16 +0200
Message-ID: <68120ea5-d3ba-4077-a605-50a0b5188761@web.de>
Date: Sat, 19 Jul 2025 20:30:14 +0200
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Naman Jain <namjain@linux.microsoft.com>,
 Roman Kisel <romank@linux.microsoft.com>,
 Saurabh Sengar <ssengar@linux.microsoft.com>, linux-hyperv@vger.kernel.org,
 Dexuan Cui <decui@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>,
 "K. Y. Srinivasan" <kys@microsoft.com>, Wei Liu <wei.liu@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Alok Tiwari <alok.a.tiwari@oracle.com>,
 Anirudh Rayabharam <anrayabh@linux.microsoft.com>,
 Nuno Das Neves <nunodasneves@linux.microsoft.com>,
 Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
References: <20250611072704.83199-3-namjain@linux.microsoft.com>
Subject: Re: [PATCH v5 2/2] Drivers: hv: Introduce mshv_vtl driver
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20250611072704.83199-3-namjain@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:RWAAZCsusyY+kuRSHpgvvOWppaFRVwN0gm9hpymGPer7RuqFLXG
 bu7GDVZLZngoAD1k10/gnXJNvuR3bPhrICWuBESSPIKrEqub4sPtsYL+DeasfhK+DRwiUIx
 D6YZw/NOA7Asx/AnKuoN21Q7txt+ZJVpEOVdHlM6YPOcpq8EhunpMQIJQw5bM3dDA9AZcK3
 k0+qU+nYizy0VGtEiTv3g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:mGhbJKws9D4=;vlOfzT60QoBrqkZ5b83SKH7y+jy
 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

=E2=80=A6
> +++ b/drivers/hv/mshv_vtl_main.c
> @@ -0,0 +1,1783 @@
=E2=80=A6
> +static int mshv_vtl_sint_ioctl_set_eventfd(struct mshv_vtl_set_eventfd =
__user *arg)
> +{
=E2=80=A6
> +	mutex_lock(&flag_lock);
> +	old_eventfd =3D flag_eventfds[set_eventfd.flag];
> +	WRITE_ONCE(flag_eventfds[set_eventfd.flag], eventfd);
> +	mutex_unlock(&flag_lock);
=E2=80=A6

Under which circumstances would you become interested to apply a statement
like =E2=80=9Cguard(mutex)(&flag_lock);=E2=80=9D?
https://elixir.bootlin.com/linux/v6.16-rc6/source/include/linux/mutex.h#L2=
25

Regards,
Markus

