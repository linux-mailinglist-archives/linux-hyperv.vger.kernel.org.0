Return-Path: <linux-hyperv+bounces-7386-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0091AC243EA
	for <lists+linux-hyperv@lfdr.de>; Fri, 31 Oct 2025 10:49:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31D133BAB7D
	for <lists+linux-hyperv@lfdr.de>; Fri, 31 Oct 2025 09:45:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B6642F60DB;
	Fri, 31 Oct 2025 09:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="c6TtPA17"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE84A1E9B3D;
	Fri, 31 Oct 2025 09:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761903931; cv=none; b=f+QPHZT4zK82tmgG0EWh+YCvYaQiTAf8NqIlabY7tLZLBS/u0axlzv4mX6GTsTocSdVNbdYu36mq52LfaO0xDtfYR/ep32wmj13cVl1Xv0tR1pIwpKc0ShaiVK//0g1nNzEGARDI/jEwmyjDCMpE/znvGTOaZ0FpkoDcDtcZT9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761903931; c=relaxed/simple;
	bh=IOdR3+c56ekLvPD+O7na7pKp+QVkjqiWd/8fTLTIqLg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=auTQeaJA7Z9VDOGWw1LH0dvisRRVuX+7NTCNRXzmoqR+VUjefYPP3UAOc6TggHBLF+kGpDRlsw54HK1JqD1donr1zEDY++VpG1fMT/SVZQy6O07bc0gTjZuitEURZOyfbI96hCtY8MIaNpExH/aPH1ddte8A8ic8XeWho3ylKwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=c6TtPA17; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1761903879; x=1762508679; i=markus.elfring@web.de;
	bh=IOdR3+c56ekLvPD+O7na7pKp+QVkjqiWd/8fTLTIqLg=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=c6TtPA17BIArRM4YZRpVfXV1yAHo0cATBW0a0kC9tEFRV3m4m0gauhvGR7cbCBgY
	 tS4jJr/+nfK+9/oW9FviZIkpsDDbj4KU9sCx7I4uYmwrg4HBUzBOlAMw3l0PBPRSc
	 XO3O7rVXKdDiEhvcttB3Gv7TQSsnwbMyv7zyy3KK72dB+yGBq+jJ81HAjSUMGSUcQ
	 KuNgMR8dLSUquIG/LKCopqh3fwlrBK1WHH/AJqYmgWHyzOGraEciU9Qgj6OD47r6Z
	 DVo0TBkaTn3s3xgQtmFBm72ZjmCaob9D4e9fwjPwkkDY7HsLqt66FHLXW0bEmFjZF
	 w3Q9I0muyx+RsKgYXA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.206]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MZjET-1vjPOq1aC7-00QCpG; Fri, 31
 Oct 2025 10:44:39 +0100
Message-ID: <17da2cdc-7fdd-43d1-91d5-36425615588a@web.de>
Date: Fri, 31 Oct 2025 10:44:37 +0100
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/hyperv: Use pointer from memcpy() call for assignment
 in hv_crash_setup_trampdata()
To: Naman Jain <namjain@linux.microsoft.com>, linux-hyperv@vger.kernel.org,
 x86@kernel.org, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, Dexuan Cui <decui@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, "H. Peter Anvin" <hpa@zytor.com>,
 Ingo Molnar <mingo@redhat.com>, "K. Y. Srinivasan" <kys@microsoft.com>,
 Long Li <longli@microsoft.com>, Mukesh Rathor <mrathor@linux.microsoft.com>,
 Thomas Gleixner <tglx@linutronix.de>, Wei Liu <wei.liu@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org,
 Miaoqian Lin <linmq006@gmail.com>
References: <d209991b-5aee-4222-aec3-cb662ccb7433@web.de>
 <cea9d987-0231-4131-82ac-9ba8c852f963@linux.microsoft.com>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <cea9d987-0231-4131-82ac-9ba8c852f963@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:KzxJQteaEctk6yOnhraDgQzg0uF1eHmyCzeHP2oDKDFuPDrvFeH
 lv6FnCjBAZlziJC/Uvh2PvEI2lai7PdxJz1KjXzpylxvfB/GoE7+hlw++6YvdTOY5CH0SxA
 GH2EhnphH1b0kVWd/pv5glgxcXgCFio/vFTAQMULAPco9WSyLsGfcYdOlZGToo0EQp7hhAb
 exew/y6EbF+l4SMpaWGDw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:FMGHCKfhJgE=;1KypKMeDr/QnvbikHvPZD7AlvGP
 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

=E2=80=A6>> +++ b/arch/x86/hyperv/hv_crash.c
>> @@ -464,9 +464,7 @@ static int hv_crash_setup_trampdata(u64 trampoline_=
va)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -1;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> =C2=A0 -=C2=A0=C2=A0=C2=A0 dest =3D (void *)trampoline_va;
>> -=C2=A0=C2=A0=C2=A0 memcpy(dest, &hv_crash_asm32, size);
>> -
>> +=C2=A0=C2=A0=C2=A0 dest =3D memcpy((void *)trampoline_va, &hv_crash_as=
m32, size);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dest +=3D size;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dest =3D (void *)round_up((ulong)dest, 1=
6);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tramp =3D (struct hv_crash_tramp_data *)=
dest;
>=20
>=20
> I tried running spatch Coccinelle checks on this file, but could not get=
 it to flag this improvement.

The proposed source code transformation is not supported by a coccicheck s=
cript so far.


> Do you mind sharing more details on the issue reproduction please.

Would you like to take another look at corresponding development discussio=
ns?

Example:
[RFC] Increasing usage of direct pointer assignments from memcpy() calls w=
ith SmPL?
https://lore.kernel.org/cocci/ddc8654a-9505-451f-87ad-075bfa646381@web.de/
https://sympa.inria.fr/sympa/arc/cocci/2025-10/msg00049.html


> I am OK with this change,

Thanks for a bit of positive feedback.


> though it may cost code readability a little bit.

Would you complain about other variable assignments in such a direction?

Regards,
Markus

