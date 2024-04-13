Return-Path: <linux-hyperv+bounces-1962-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B6D38A3CC5
	for <lists+linux-hyperv@lfdr.de>; Sat, 13 Apr 2024 15:06:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C06A1B211D1
	for <lists+linux-hyperv@lfdr.de>; Sat, 13 Apr 2024 13:06:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84F86446AF;
	Sat, 13 Apr 2024 13:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=schierlm@gmx.de header.b="O9QHXzZX"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B688D446AC;
	Sat, 13 Apr 2024 13:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713013578; cv=none; b=W4/tqeXz+wULe7H4bNnNnR7Kq7Frw2MoJNG2D9Ri0fVUDYec93ucOro1Gd14e3aIQfTf69K1eLjswg2Hj3cEtBoGcz1A4HEgEEiavBapicixQi06hClX9yoQVqWTvTp03zgGLBfCfHZ7k97Off/5ezTQGZbwNxffWAi0xUEGDFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713013578; c=relaxed/simple;
	bh=MzbVw7TG8Upbp7umydgmO+bsnapGUtlFn/xOM1E7JMk=;
	h=Message-ID:Date:MIME-Version:From:To:Cc:Subject:Content-Type; b=S6U2CoH4kMfgts6K9pQn9HFzq1FXIfcJ8WnVI1KLf+oFu1egFoJ2Ie+xGG+4Y6Vf6bOzGtr+2z8q6EhsTTUKSTcvTTYn6+DU/AVlUuCDH8W58gMNEaS+KH9U6Fv22NNRuYzjdv7AhqSg62ioIVbdqAdDIsToFeHCH1aDYueJgI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=schierlm@gmx.de header.b=O9QHXzZX; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1713013565; x=1713618365; i=schierlm@gmx.de;
	bh=Zmy6kJuf0Yp448xeLYX/7DYKynh6RAhzDjoFxgh3wP8=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject;
	b=O9QHXzZXZSR6wr2WOCIFugzkNBmySaQfVC5/Qw80jSLJgktMrh4uk9igyzpMN0Tl
	 6bg7sQbwlKK5R01yZqIllZupdrHHdir9wH1X5ih7sVkDVaXfkBMxEguF4vKhTybO1
	 vy2WYJ0WnpOfkbF72LUhCshAdytDhZ1tRYSqEwg3acS9uMYSCaNmQczeBLHcJZ7GJ
	 NPTWFi1NsnF8/BNCpyEJZLkhqR7YykK26ZSnacgtiV42aLCPsmQQx/xfC3GBbnguw
	 RkScODEFKmt+me1R/MzNuydTAhI0H/iD2O70hvY8bv/Hl0J4SpeRW74aj4/9w0Hno
	 CPRK8YeWDeyodMgy9Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.178.56] ([84.145.191.35]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MPGRp-1s86Lo0AsX-00Pgfa; Sat, 13
 Apr 2024 15:06:05 +0200
Message-ID: <2db080ae-5e59-46e8-ac4e-13cdf26067cc@gmx.de>
Date: Sat, 13 Apr 2024 15:06:05 +0200
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: de-DE
From: Michael Schierl <schierlm@gmx.de>
To: Jean Delvare <jdelvare@suse.com>, "K. Y. Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Early kernel panic in dmi_decode when running 32-bit kernel on
 Hyper-V on Windows 11
Autocrypt: addr=schierlm@gmx.de; keydata=
 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
 uxTR60TDY/d6Kz8=
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:wnxcfEPvQSVin60yHibRAREf98iazoETSilrkYIx7JMsOUo1qkn
 0zE9CCA3FG+YrC+bL62Qik1o8EOa45AtunEUpFB0J7ATf4SL1upAdNuK0vo2ii2OdpeMZzs
 nhdvyJajyhQYjnzB4Ax+8ws2IcY86q/ssCuAHweMloF1Xu0b767bXrPzUfJ4bV5ygufZJ0C
 +whvzuD0zcQIW6Oko6Dpg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:m+0TQ2x8aVQ=;2wkxSnulSUw2bmjnwoGSEX+Pkbj
 ciAu6SWgL/kAtBETGUkDUe786/8UBRA6utA6DxuQ25HxxBuRSaXSvfK/ox19dd2PPKYyPLIII
 bPCby1XqCqbkyYw7CM6yLxEr7zYN9fYx9pdCBREOozvLpJ9W8A6DiIl5dH/xH449kFLGtbhtR
 83+ITcr2Nwglm7Q4mrMay59NHQ/0yg32hcUwzYgc2VGxCoHGkVfX7xP8yU3UsYhQoMSfgk9jD
 y/PYsj5nkUNYP24tShfBOOIp/neXgN6t0554fZgfYmsJAyL8ogYow0dVnjrUExFIQrE4yaQVz
 bl4qyKjzhFA7lNJQqbiFfEIklf+cqveaJiHxsi62QWwxRz/KWMLbsd/tqSol8Xcrl+dQxWMJo
 X/uN1JIevRhB3pxjVlRhO/licZfB2P8rgAzaBhCr768eM2oofhMHXdiA3T2TCnsLU1iniZJK0
 TSMfOOep4cfugwMtZWIIIv1d0fSKE7ZghrkNuSRZSjfMQUD9i1J++d5cil1gT76aOXRA7cHpG
 hMcXry41QJF9UuCdUHJHObEG0x+CIOiUin4L3T6MEYL9I+1ZCbrwCgRsJxVuu4VJ/TeA2YTNx
 GjJTqvQ79Qysw7CGb/44WliPcXiCO2NIkoZ52PZ3fW7BG22PerHJM8cowvhlQByFdObOjLKMC
 NBlGSrezzMnWP82QROtGq72cgg3DSF4FAXApmChc7kgDByEA9wDszZ3gW8cHwhVrwcLM1GwwS
 v95gMeAnw2582Jz4TAz/d4JBXEA+9nFb++C8SAyICQVoIk2qmbe8C6duI3xkU/YlXYn5jQ7HP
 Klr3tvO1AJ3q1zNkHKo9mrddt1XpKuBBnDqpyOSXT1Ix4=

[please cc: me as I am not subscribed to either mailing list]

Hello,


I am writing to you as Jean is listed as maintainer of dmi, and the rest
are listed as maintainer for Hyper-V drivers. If I should have written
elsewhere, please kindly point me to the correct location.

I am having issues running 32-bit Debian (kernel 6.1.0) on Hyper-V on
Windows 11 (10.0.22631.3447) when the virtual machine has assigned more
than one vCPU. The kernel does not boot and no output is shown on screen.

I was able to redirect early printk to serial port and capture this panic:

> early console in setup code
> Probing EDD (edd=3Doff to disable)... ok
> [    0.000000] Linux version 6.1.0-18-686-pae (debian-kernel@lists.debia=
n.org) (gcc-12 (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian)=
 2.40) #1 SMP PREEMPT_DYNAMIC Debian 6.1.76-1 (2024-02-01)
> [    0.000000] BIOS-provided physical RAM map:
> [    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009fbff] us=
able
> [    0.000000] BIOS-e820: [mem 0x000000000009fc00-0x000000000009ffff] re=
served
> [    0.000000] BIOS-e820: [mem 0x00000000000e0000-0x00000000000fffff] re=
served
> [    0.000000] BIOS-e820: [mem 0x0000000000100000-0x000000007ffeffff] us=
able
> [    0.000000] BIOS-e820: [mem 0x000000007fff0000-0x000000007fffefff] AC=
PI data
> [    0.000000] BIOS-e820: [mem 0x000000007ffff000-0x000000007fffffff] AC=
PI NVS
> [    0.000000] printk: bootconsole [earlyser0] enabled
> [    0.000000] NX (Execute Disable) protection: active
> [    0.000000] BUG: unable to handle page fault for address: ffa45000
> [    0.000000] #PF: supervisor read access in kernel mode
> [    0.000000] #PF: error_code(0x0000) - not-present page
> [    0.000000] *pdpt =3D 000000000fe74001
> [    0.000000] Oops: 0000 [#1] PREEMPT SMP NOPTI
> [    0.000000] CPU: 0 PID: 0 Comm: swapper Not tainted 6.1.0-18-686-pae =
#1  Debian 6.1.76-1
> [    0.000000] EIP: dmi_decode+0x2e3/0x40e
> [    0.000000] Code: 10 53 e8 b8 f9 ff ff 83 c4 0c e9 3e 01 00 00 0f b6 =
7e 01 31 db 83 ef 04 d1 ef 39 df 0f 8e 2b 01 00 00 8a 4c 5e 04 84 c9 79 1e=
 <0f> b6 54 5e 05 89 f0 88 4d f0 e8 c0 f7 ff ff 8a 4d f0 89 c2 89 c8
> [    0.000000] EAX: cff6d220 EBX: 000024bd ECX: cfd2caff EDX: cf9e942c
> [    0.000000] ESI: ffa40681 EDI: 7ffffffe EBP: cfc37e90 ESP: cfc37e80
> [    0.000000] DS: 007b ES: 007b FS: 00d8 GS: 0000 SS: 0068 EFLAGS: 0021=
0086
> [    0.000000] CR0: 80050033 CR2: ffa45000 CR3: 0fe78000 CR4: 00000020
> [    0.000000] Call Trace:
> [    0.000000]  ? __die_body.cold+0x14/0x1a
> [    0.000000]  ? __die+0x21/0x26
> [    0.000000]  ? page_fault_oops+0x69/0x120
> [    0.000000]  ? uuid_string+0x157/0x1a0
> [    0.000000]  ? kernelmode_fixup_or_oops.constprop.0+0x80/0xe0
> [    0.000000]  ? __bad_area_nosemaphore.constprop.0+0xfc/0x130
> [    0.000000]  ? bad_area_nosemaphore+0xf/0x20
> [    0.000000]  ? do_kern_addr_fault+0x79/0x90
> [    0.000000]  ? exc_page_fault+0xbc/0x160
> [    0.000000]  ? paravirt_BUG+0x10/0x10
> [    0.000000]  ? handle_exception+0x133/0x133
> [    0.000000]  ? dmi_disable_osi_vista+0x1/0x37
> [    0.000000]  ? paravirt_BUG+0x10/0x10
> [    0.000000]  ? dmi_decode+0x2e3/0x40e
> [    0.000000]  ? dmi_disable_osi_vista+0x1/0x37
> [    0.000000]  ? paravirt_BUG+0x10/0x10
> [    0.000000]  ? dmi_decode+0x2e3/0x40e
> [    0.000000]  ? dmi_smbios3_present+0xd8/0xd8
> [    0.000000]  dmi_decode_table+0xa9/0xe0
> [    0.000000]  ? dmi_smbios3_present+0xd8/0xd8
> [    0.000000]  ? dmi_smbios3_present+0xd8/0xd8
> [    0.000000]  dmi_walk_early+0x34/0x58
> [    0.000000]  dmi_present+0x149/0x1b6
> [    0.000000]  dmi_setup+0x18d/0x22e
> [    0.000000]  setup_arch+0x676/0xd3f
> [    0.000000]  ? lockdown_lsm_init+0x1c/0x20
> [    0.000000]  ? initialize_lsm+0x33/0x4e
> [    0.000000]  start_kernel+0x65/0x644
> [    0.000000]  ? set_intr_gate+0x45/0x58
> [    0.000000]  ? early_idt_handler_common+0x44/0x44
> [    0.000000]  i386_start_kernel+0x48/0x4a
> [    0.000000]  startup_32_smp+0x161/0x164
> [    0.000000] Modules linked in:
> [    0.000000] CR2: 00000000ffa45000
> [    0.000000] ---[ end trace 0000000000000000 ]---
> [    0.000000] EIP: dmi_decode+0x2e3/0x40e
> [    0.000000] Code: 10 53 e8 b8 f9 ff ff 83 c4 0c e9 3e 01 00 00 0f b6 =
7e 01 31 db 83 ef 04 d1 ef 39 df 0f 8e 2b 01 00 00 8a 4c 5e 04 84 c9 79 1e=
 <0f> b6 54 5e 05 89 f0 88 4d f0 e8 c0 f7 ff ff 8a 4d f0 89 c2 89 c8
> [    0.000000] EAX: cff6d220 EBX: 000024bd ECX: cfd2caff EDX: cf9e942c
> [    0.000000] ESI: ffa40681 EDI: 7ffffffe EBP: cfc37e90 ESP: cfc37e80
> [    0.000000] DS: 007b ES: 007b FS: 00d8 GS: 0000 SS: 0068 EFLAGS: 0021=
0086
> [    0.000000] CR0: 80050033 CR2: ffa45000 CR3: 0fe78000 CR4: 00000020
> [    0.000000] Kernel panic - not syncing: Attempted to kill the idle ta=
sk!
> [    0.000000] ---[ end Kernel panic - not syncing: Attempted to kill th=
e idle task! ]---

The same panic can be reproduced with vanilla 6.8.4 kernel.

By adding some (or rather a lot of) printk into dmi_scan.c, I believe
that the issue is caused by this line:

<https://github.com/torvalds/linux/blob/13a0ac816d22aa47d6c393f14a99f39e49=
b960df/drivers/firmware/dmi_scan.c#L295>

Or rather by a dmi_header with dm->type =3D=3D 10 and dm->length =3D=3D 0.

As the length is (unsigned) zero, after subtracting the (unsigned)
header length and dividing by two, count is slightly below signed
integer max value (and stays there after being casted to signed),
resulting in the loop running "forever" until it reaches non-mapped
memory, resulting in the panic above.


I am unsure who is the culprit, whether DMI header is supposed to not
have length zero or whether Linux is supposed to parse it more gracefully.

In any case, when adding an extra if clause to this function to return
early in case dm->length is zero, the system boots fine and appears to
work fine at first glance. As I unfortunately have no idea what DMI is
used for by the kernels, I do not know if there are any other things I
should test, since the "Onboard device information" is obviously missing.


If I should perform other tests, please tell me. Otherwise I hope that
either an update of Hyper-V or the Linux kernel (or maybe some kernel
parameter I missed) can make 32-bit Linux bootable on Hyper-V again in
the future.

[Slightly off-topic: As 64-bit kernels work fine, if there are ways to
run a 32-bit userland containerized or chrooted in a 64-bit kernel so
that the userland (espeically uname and autoconf) cannot distinguish
from a 32-bit kernel, that might be another option for my use case.
Nested virtualization would of course also work, but the performance
loss due to nested virtualization negates the effect of being able to
pass more than one of the (2 physical, 4 hyperthreaded) cores of my
laptop to the VM].



Thanks for help and best regards,


Michael

