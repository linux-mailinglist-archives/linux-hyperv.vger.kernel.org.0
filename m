Return-Path: <linux-hyperv+bounces-7743-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 58504C785BE
	for <lists+linux-hyperv@lfdr.de>; Fri, 21 Nov 2025 11:10:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id 995E7327EA
	for <lists+linux-hyperv@lfdr.de>; Fri, 21 Nov 2025 10:09:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EA592F28F9;
	Fri, 21 Nov 2025 10:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lQt5ND/C"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48D762D063A
	for <linux-hyperv@vger.kernel.org>; Fri, 21 Nov 2025 10:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763719504; cv=none; b=brCcXF8MQiMUK1ZEzR9TJSOSzOfqcce9+r+LILV/Eo/t6Q0UV1RuRrcQTz2Ades0YD0j1+jhqCnlq1ZdmvNU0SYNJxrVIYvqPL/P4Q1kGrvJeVc5YKnf2wzx67Dlvtx2NagGB051j1daqqletll0RsXue5DuAm5dO4TTnapZdbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763719504; c=relaxed/simple;
	bh=7Si22rh4Tf/bQ7/t0HrnYRavSCVnpqFDwfmCrQawGc8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pDkXGuYtGtdMmmTHUhwDZIuJaQ2hDZKbKgobtsHCxMuPq62FtJkQRcvJIqemvGJV/Dk7KoX25GeaY0IdCKGUe7vSM+IpvumEc7u6wg4OoFZBeRO3vUim4dsGNT9ULYHICTqe0vQsUFOX5zgEdLenV6eLeN/t6ZL35OPc1V7bTZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lQt5ND/C; arc=none smtp.client-ip=74.125.224.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-640d43060d2so1657442d50.2
        for <linux-hyperv@vger.kernel.org>; Fri, 21 Nov 2025 02:05:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763719499; x=1764324299; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OIIgIkxfHCz92I+68s+r+O0mgnsfZxyTvtLxRq9jr8w=;
        b=lQt5ND/C330CxOu1aCsboNxTw8pJnBJMLBwX832Q3Sw930ljX4D82WfAvi/ha38zog
         JtecZ4U+8NH2dexkDrUEVDgSXdxBHq+z4YTppAtAIprUzsFwsZJTocDL/iwMktEMWAMs
         kPJW4vEZhBtehNY8Q8oV7jPB5rbeP2PoHgwi2zrxmQ2RSZv8t9okVcgoCc8mnepCf5yy
         3mwu7EywzUZtGusN05oEjcjAWoC/lxFwT4SGEYwlo8nYhTSpqVA6ai5ZXInCe1a/owSA
         6bKeW198CPvO8G2/YClWZrbp0AFkTEuggdtpOvztnl4DsPAazHz69Ds7F7CS2erjuEGg
         0lIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763719499; x=1764324299;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OIIgIkxfHCz92I+68s+r+O0mgnsfZxyTvtLxRq9jr8w=;
        b=UKpuSQAWBvKqyamtYJy8TRTzlNpjVlApSiPRJZ2rzPMffpgte+pM12Rq34uK5h2OLX
         mPb9wtFIaGjGgdqwS0iNFJ1ZPS5RcY8zH7wK2gbA1OwjTjc67rzr1slnoX2T2oDGAeZp
         z/oCUxijR6bQbqGwKhTI0SVPt7Cuodah2YGOGGeQuGB/M2gopwrTsP1P+lQ6vUF8ZaB5
         cDt0oxAZfxjK0gyTOabk7+j4CKfpMLxZyXY7al2RI296EvtgFK8iO5qds6hfW5mUo1Xj
         gKUxtAHKr03yQCRcMMYnC2oi08WZD6pZzlq6GqswUMWLd7FJ9bLCaJEkpfKlGaUFq3G/
         VH8g==
X-Forwarded-Encrypted: i=1; AJvYcCXXa2+4v85kn42Fl4tqJYbkEmbj8iRkYoat12r0qx97JNdNxqy/Hear/kJfiY8JM6rs219yQ3O1dR1HIVg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhGvgMPkxFhbaZtRfb0+Z6qmOAcfQyHxS1ww790F6bTprkHevY
	9tqD4rbnqskFyNL8pwUoYjFDWngJf4sgnwQTYFOKstHqssVEhuHDsK+042Ir0gBDpJhH/RxZmvI
	nqHqcYEHcY+7muWfkmPrvg495L49+T9E=
X-Gm-Gg: ASbGncuXuLzYeixGp66bTP/Kex64UNP1eAM2YJSwPEDwGN6tmYMS1NTW5f758ZydX3C
	Ie2osGYEfRq6mJFZx0DxPfs+YL3g2SCb1wg7O0urM7LHNLqGVo1DrOJOXf32WcMF76wjjXPeV01
	etbN8cFl5oNV4QWWtRxsKjeepERc5OZxq5kXQh7tLSDksUeFRHopwiGMX3MHFlDZP/ANguCOphp
	hYeBxZGPq4gUyHjaXpOXYLU1/ZnN5whxE1/Iq67X2XwgbIysyshAve0Ctc/txNIQyV1+XUocKi6
	G7Tz0UdY0HUmTRjTWjqHttN61jBY7BQph5wIwQZaW0+StgA2hw==
X-Google-Smtp-Source: AGHT+IGajTqx5ininoheMFSj0eIdsKKhAPp8owIB8VPS/3Gx5x92AgXKkrsibqg1KttLu2r8aPJHrFxvdzJj68SXp80=
X-Received: by 2002:a05:690e:1442:b0:642:2cf:f9fb with SMTP id
 956f58d0204a3-64302a2eaadmr1092911d50.4.1763719499250; Fri, 21 Nov 2025
 02:04:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aRYjk4JBqHvVl-wN@eldamar.lan> <7a38c04d-4e54-4f1a-96fd-43f0f11ab97b@linux.microsoft.com>
 <CAFcZKTwQgd9hrTaXnThML=+WG82TH3DK90FT1-WWsBSoRj7dRw@mail.gmail.com>
 <176298819854.487825.11724175116974643582.reportbug@p15v.lan>
 <18bcf829-04f9-46ec-a874-7c2b9338cf3d@linux.microsoft.com>
 <aRei1DGOWy13GqvE@eldamar.lan> <25aff5ca-b5e1-4907-bd12-6571f8454146@linux.microsoft.com>
In-Reply-To: <25aff5ca-b5e1-4907-bd12-6571f8454146@linux.microsoft.com>
From: Peter Morrow <pdmorrow@gmail.com>
Date: Fri, 21 Nov 2025 10:04:48 +0000
X-Gm-Features: AWmQ_bml56ba4FPvLQfXiG7sOJrkgfM8uYLy9yqvr1L2535PTJhYrBej5B9nsTw
Message-ID: <CAFcZKTyOcDqDJRB4sgN7Q-dabBU0eg7KKs=yBJhB=CNDyy7scQ@mail.gmail.com>
Subject: Re: Bug#1120602: [REGRESSION 6.12.y] hyper-v: BUG: kernel NULL
 pointer dereference, address: 00000000000000a0: RIP: 0010:hv_uio_channel_cb+0xd/0x20
 [uio_hv_generic]
To: Naman Jain <namjain@linux.microsoft.com>
Cc: Salvatore Bonaccorso <carnil@debian.org>, 1120602@bugs.debian.org, 
	Long Li <longli@microsoft.com>, linux-hyperv@vger.kernel.org, 
	linux-kernel@vger.kernel.org, regressions@lists.linux.dev, 
	stable@vger.kernel.org, John Starks <jostarks@microsoft.com>, 
	Michael Kelley <mhklinux@outlook.com>, Tianyu Lan <tiala@microsoft.com>, 
	"K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
	Dexuan Cui <decui@microsoft.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Naman/Salvatore,

Is it possible to get this fixed in the 6.1 LTS series too? I just ran
into this crash when moving from bookworm based Debian kernel
6.1.153-1 to 6.1.158-1. I saw that "uio_hv_generic: Let userspace take
care of interrupt mask" appeared in 6.1.156.

Thanks,
Peter.

On Sat, 15 Nov 2025 at 09:04, Naman Jain <namjain@linux.microsoft.com> wrot=
e:
>
>
>
> On 11/15/2025 3:14 AM, Salvatore Bonaccorso wrote:
> > Hi,
> >
> > On Fri, Nov 14, 2025 at 08:05:55PM +0530, Naman Jain wrote:
> >>
> >>
> >> On 11/14/2025 5:19 PM, Peter Morrow wrote:
> >>> Hi Naman,
> >>>
> >>> On Fri, 14 Nov 2025 at 06:03, Naman Jain <namjain@linux.microsoft.com=
> wrote:
> >>>>
> >>>>
> >>>>
> >>>> On 11/13/2025 11:59 PM, Salvatore Bonaccorso wrote:
> >>>>> Peter Morrow reported in Debian a regression, reported in
> >>>>> https://bugs.debian.org/1120602 . The regression was seen after
> >>>>> updating, to 6.12.57-1 in Debian, but details on the offending comm=
it
> >>>>> follows.
> >>>>>
> >>>>> His report was as follows:
> >>>>>
> >>>>>> Dear Maintainer,
> >>>>>>
> >>>>>> I'm seeing a kernel crash quite soon after boot on a debian trixie=
 based
> >>>>>> system running 6.12.57+deb13-amd64, unfortunately the kernel panic=
s before
> >>>>>> I can access the system to gather more information. Thus I'll prov=
ide details
> >>>>>> of the system using a previously known good version. The panic is =
happening
> >>>>>> 100% of the time unfortunately. I have access to the serial consol=
e however
> >>>>>> so can enable any required verbose logging during boot if necessar=
y.
> >>>>>>
> >>>>>> Crucially the crash is not seen with kernel version 6.12.41+deb13-=
amd64 with the
> >>>>>> same userspace. We had pinned to that version until very recently =
to in order
> >>>>>> to work around https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=
=3D1109676
> >>>>>>
> >>>>>> I'm running a dpdk application here (VPP) on Azure, VM form factor=
 is a
> >>>>>> "Standard DS3 v2 (4 vcpus, 14 GiB memory)".
> >>>>>>
> >>>>>> The only relevant upstream commit in this area (as far as I can se=
e) is:
> >>>>>>
> >>>>>> https://lore.kernel.org/linux-hyperv/1bb599ee-fe28-409d-b430-2fc08=
6268936@linux.microsoft.com/
> >>>>>>
> >>>>>> The comment regarding avoiding races at start adds a bit more weig=
ht behind this
> >>>>>> hunch, though it's only a hunch as I am most definitely nowhere ne=
ar an expert
> >>>>>> in this area.
> >>>>>>
> >>>>>> -- Package-specific info:
> >>>>>>
> >>>>>> [   19.625535] BUG: kernel NULL pointer dereference, address: 0000=
0000000000a0
> >>>>>> [   19.628874] #PF: supervisor read access in kernel mode
> >>>>>> [   19.630841] #PF: error_code(0x0000) - not-present page
> >>>>>> [   19.632788] PGD 0 P4D 0
> >>>>>> [   19.633905] Oops: Oops: 0000 [#1] PREEMPT SMP PTI
> >>>>>> [   19.635586] CPU: 3 UID: 0 PID: 0 Comm: swapper/3 Not tainted 6.=
12.57+deb13-amd64 #1  Debian 6.12.57-1
> >>>>>> [   19.640216] Hardware name: Microsoft Corporation Virtual Machin=
e/Virtual Machine, BIOS Hyper-V UEFI Release v4.1 09/28/2024
> >>>>>> [   19.644514] RIP: 0010:hv_uio_channel_cb+0xd/0x20 [uio_hv_generi=
c]
> >>>>>> [   19.646994] Code: 02 00 00 5b 5d e9 53 98 69 e9 0f 1f 00 90 90 =
90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 0f 1f 44 00 00 48 8b =
47 10 <48> 8b b8 a0 00 00 00 f0 83 44 24 fc 00 e9 51 6f fa ff 90 90 90 90
> >>>>>> [   19.654377] RSP: 0018:ffffb15ac01a4fa8 EFLAGS: 00010046
> >>>>>> [   19.656385] RAX: 0000000000000000 RBX: 0000000000000015 RCX: 00=
00000000000015
> >>>>>> [   19.659240] RDX: 0000000000000001 RSI: ffffffffffffffff RDI: ff=
ff8ff69c759400
> >>>>>> [   19.662168] RBP: ffff8ff548790200 R08: ffff8ff548790200 R09: 00=
fca75150b080e9
> >>>>>> [   19.665239] R10: 0000000000000000 R11: ffffb15ac01a4ff8 R12: ff=
ff8ff871dc1480
> >>>>>> [   19.668193] R13: ffff8ff69c759400 R14: ffff8ff69c7596a0 R15: ff=
ffffffc106e160
> >>>>>> [   19.671106] FS:  0000000000000000(0000) GS:ffff8ff871d80000(000=
0) knlGS:0000000000000000
> >>>>>> [   19.674281] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> >>>>>> [   19.676533] CR2: 00000000000000a0 CR3: 0000000100ba6003 CR4: 00=
000000003706f0
> >>>>>> [   19.679385] Call Trace:
> >>>>>> [   19.680361]  <IRQ>
> >>>>>> [   19.681181]  vmbus_isr+0x1a5/0x210 [hv_vmbus]
> >>>>>> [   19.682916]  __sysvec_hyperv_callback+0x32/0x60
> >>>>>> [   19.684991]  sysvec_hyperv_callback+0x6c/0x90
> >>>>>> [   19.686665]  </IRQ>
> >>>>>> [   19.687509]  <TASK>
> >>>>>> [   19.688366]  asm_sysvec_hyperv_callback+0x1a/0x20
> >>>>>> [   19.690262] RIP: 0010:pv_native_safe_halt+0xf/0x20
> >>>>>> [   19.692067] Code: 09 e9 c5 08 01 00 0f 1f 44 00 00 90 90 90 90 =
90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 66 90 0f 00 2d e5 3b 31 00 =
fb f4 <c3> cc cc cc cc 66 66 2e 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90
> >>>>>> [   19.699119] RSP: 0018:ffffb15ac0103ed8 EFLAGS: 00000246
> >>>>>> [   19.701412] RAX: 0000000000000003 RBX: ffff8ff5403b1fc0 RCX: ff=
ff8ff54c64ce30
> >>>>>> [   19.704328] RDX: 0000000000000000 RSI: 0000000000000003 RDI: 00=
0000000001f894
> >>>>>> [   19.706910] RBP: 0000000000000003 R08: 000000000bb760d9 R09: 00=
fca75150b080e9
> >>>>>> [   19.709762] R10: 0000000000000003 R11: 0000000000000001 R12: 00=
00000000000000
> >>>>>> [   19.712510] R13: 0000000000000000 R14: 0000000000000000 R15: 00=
00000000000000
> >>>>>> [   19.715173]  default_idle+0x9/0x20
> >>>>>> [   19.716846]  default_idle_call+0x29/0x100
> >>>>>> [   19.718623]  do_idle+0x1fe/0x240
> >>>>>> [   19.720045]  cpu_startup_entry+0x29/0x30
> >>>>>> [   19.721595]  start_secondary+0x11e/0x140
> >>>>>> [   19.723080]  common_startup_64+0x13e/0x141
> >>>>>> [   19.725222]  </TASK>
> >>>>>> [   19.726387] Modules linked in: isofs cdrom uio_hv_generic uio b=
infmt_misc intel_rapl_msr intel_rapl_common intel_uncore_frequency_common i=
sst_if_mbox_msr isst_if_common rpcrdma skx_edac_common nfit sunrpc libnvdim=
m crct10dif_pclmul ghash_clmulni_intel sha512_ssse3 sha256_ssse3 rdma_ucm i=
b_iser sha1_ssse3 rdma_cm aesni_intel iw_cm gf128mul crypto_simd libiscsi c=
ryptd ib_umad ib_ipoib scsi_transport_iscsi ib_cm rapl sg hv_utils hv_ballo=
on evdev pcspkr joydev mpls_router ip_tunnel ramoops configfs pstore_blk ef=
i_pstore pstore_zone nfnetlink vsock_loopback vmw_vsock_virtio_transport_co=
mmon hv_sock vmw_vsock_vmci_transport vsock vmw_vmci efivarfs ip_tables x_t=
ables autofs4 overlay squashfs dm_verity dm_bufio reed_solomon dm_mod loop =
ext4 crc16 mbcache jbd2 crc32c_generic mlx5_ib ib_uverbs ib_core mlx5_core =
mlxfw pci_hyperv pci_hyperv_intf hyperv_drm drm_shmem_helper sd_mod drm_kms=
_helper hv_storvsc scsi_transport_fc drm scsi_mod hid_generic hid_hyperv hi=
d serio_raw hv_netvsc hyperv_keyboard scsi_common hv_vmbus
> >>>>>> [   19.726466]  crc32_pclmul crc32c_intel
> >>>>>> [   19.765771] CR2: 00000000000000a0
> >>>>>> [   19.767524] ---[ end trace 0000000000000000 ]---
> >>>>>> [   19.800433] RIP: 0010:hv_uio_channel_cb+0xd/0x20 [uio_hv_generi=
c]
> >>>>>> [   19.803170] Code: 02 00 00 5b 5d e9 53 98 69 e9 0f 1f 00 90 90 =
90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 0f 1f 44 00 00 48 8b =
47 10 <48> 8b b8 a0 00 00 00 f0 83 44 24 fc 00 e9 51 6f fa ff 90 90 90 90
> >>>>>> [   19.811041] RSP: 0018:ffffb15ac01a4fa8 EFLAGS: 00010046
> >>>>>> [   19.813466] RAX: 0000000000000000 RBX: 0000000000000015 RCX: 00=
00000000000015
> >>>>>> [   19.816504] RDX: 0000000000000001 RSI: ffffffffffffffff RDI: ff=
ff8ff69c759400
> >>>>>> [   19.819484] RBP: ffff8ff548790200 R08: ffff8ff548790200 R09: 00=
fca75150b080e9
> >>>>>> [   19.822625] R10: 0000000000000000 R11: ffffb15ac01a4ff8 R12: ff=
ff8ff871dc1480
> >>>>>> [   19.825569] R13: ffff8ff69c759400 R14: ffff8ff69c7596a0 R15: ff=
ffffffc106e160
> >>>>>> [   19.828804] FS:  0000000000000000(0000) GS:ffff8ff871d80000(000=
0) knlGS:0000000000000000
> >>>>>> [   19.832214] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> >>>>>> [   19.834709] CR2: 00000000000000a0 CR3: 0000000100ba6003 CR4: 00=
000000003706f0
> >>>>>> [   19.837976] Kernel panic - not syncing: Fatal exception in inte=
rrupt
> >>>>>> [   19.841825] Kernel Offset: 0x28a00000 from 0xffffffff81000000 (=
relocation range: 0xffffffff80000000-0xffffffffbfffffff)
> >>>>>> [   19.896620] ---[ end Kernel panic - not syncing: Fatal exceptio=
n in interrupt ]---
> >>>>>>
> >>>>
> >>>> <snip>
> >>>>
> >>>>> The offending commit appers to be the backport of b15b7d2a1b09
> >>>>> ("uio_hv_generic: Let userspace take care of interrupt mask") for
> >>>>> 6.12.y.
> >>>>>
> >>>>> Peter confirmed that reverting this commit on top of 6.12.57-1 as
> >>>>> packaged in Debian resolves indeed the issue. Interestingly the iss=
ue
> >>>>> is *not* seen with 6.17.7 based kernel in Debian.
> >>>>>
> >>>>> #regzbot introduced: 37bd91f22794dc05436130d6983302cb90ecfe7e
> >>>>> #regzbot monitor: https://bugs.debian.org/1120602
> >>>>>
> >>>>> Thank you already!
> >>>>>
> >>>>> Regards,
> >>>>> Salvatore
> >>>>
> >>>> Hi Peter, Salvatore,
> >>>> Thanks for reporting this crash, and sorry for the trouble. Here is =
my
> >>>> analysis.
> >>>>
> >>>> On 6.17.7, where commit d062463edf17 ("uio_hv_generic: Set event for=
 all
> >>>> channels on the device") is present, hv_uio_irqcontrol() supports
> >>>> setting of interrupt mask from userspace for sub-channels as well.
> >>>>
> >>>> This aligns with commit e29587c07537 ("uio_hv_generic: Let userspace
> >>>> take care of interrupt mask") which relies on userspace to manage
> >>>> interrupt mask, so it safely removes the interrupt mask management l=
ogic
> >>>> in the driver.
> >>>>
> >>>> However, in 6.12.57, the first commit is not present, but the second=
 one
> >>>> is, so there is no way to disable interrupt mask for sub-channels an=
d
> >>>> interrupt_mask stays 0, which means interrupts are not masked. So we=
 may
> >>>> be having an interrupt callback being handled for a sub-channel, whe=
re
> >>>> we do not expect it to come. This may be causing this issue.
> >>>>
> >>>> This would have led to a crash in hv_uio_channel_cb() for sub-channe=
ls:
> >>>> struct hv_device *hv_dev =3D chan->device_obj;
> >>>>
> >>>>
> >>>> I have ported commit d062463edf17 ("uio_hv_generic: Set event for al=
l
> >>>> channels on the device") on 6.12.57, and resolved some merge conflic=
ts.
> >>>> Could you please help with testing this, if it works for you.
> >>>
> >>> Applying the patch against the debian 6.12.57 kernel worked, I am no
> >>> longer seeing that panic on boot:
> >>>
> >>> gnos@vEdge:~$ uname -a
> >>> Linux vEdge 6.12+unreleased-amd64 #1 SMP PREEMPT_DYNAMIC Debian
> >>> 6.12.57-1a~test (2025-11-14) x86_64 GNU/Linux
> >>> gnos@vEdge:~$ uptime
> >>>    11:46:33 up 4 min,  1 user,  load average: 3.31, 2.07, 0.89
> >>> gnos@vEdge:~$ sudo dmidecode -t system
> >>> # dmidecode 3.6
> >>> Getting SMBIOS data from sysfs.
> >>> SMBIOS 3.1.0 present.
> >>>
> >>> Handle 0x0001, DMI type 1, 27 bytes
> >>> System Information
> >>>           Manufacturer: Microsoft Corporation
> >>>           Product Name: Virtual Machine
> >>>           Version: Hyper-V UEFI Release v4.1
> >>>           Serial Number: 0000-0002-8036-1108-7588-3134-50
> >>>           UUID: 26e86d6e-140c-496a-862c-a3b3bbcd16ad
> >>>           Wake-up Type: Power Switch
> >>>           SKU Number: None
> >>>           Family: Virtual Machine
> >>>
> >>> Handle 0x0010, DMI type 32, 11 bytes
> >>> System Boot Information
> >>>           Status: No errors detected
> >>>
> >>> gnos@vEdge:~$
> >>>
> >>> Thanks a lot for the quick analysis!
> >>>
> >>> Peter.
> >>
> >> Hi Peter,
> >>
> >> Thanks for confirming. I am discussing this with Long Li, to hear his
> >> thoughts on this, and have kept the patch ready.
> >> Porting the same on 6.6 and older kernels would be a little different =
since
> >> we don't have commit 547fa4ffd799 ("uio_hv_generic: Enable interrupt f=
or low
> >> speed VMBus devices") on these kernels and this would lead to merge
> >> conflicts, which needs to be handled separately.
> >>
> >> Meanwhile, if I should be including any tags in the fix patch for debi=
an
> >> bug, please let me know.
> >
> > Thank you very much for the quick analysis and fix.
> >
> > If you can add a Closes: https://bugs.debian.org/1120602 that would
> > make our tracking for the fixes easier. But not sure if this is
> > allowed for proposing the backport for a stable series, as it did not
> > affect the upper releases.
> >
> > In any case your work is much appreciated!
> >
> > Regards,
> > Salvatore
>
> Hi,
> I have sent the patches now to the list. Please consider adding your
> tested-by if you find it alright.
>
> Thanks.
>
> Regards,
> Naman

