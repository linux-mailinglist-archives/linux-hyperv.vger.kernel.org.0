Return-Path: <linux-hyperv+bounces-7588-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 75D2AC5CF3E
	for <lists+linux-hyperv@lfdr.de>; Fri, 14 Nov 2025 12:55:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id ED51D4E6586
	for <lists+linux-hyperv@lfdr.de>; Fri, 14 Nov 2025 11:49:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACC4F3148A7;
	Fri, 14 Nov 2025 11:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aaCuEjuT"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E03E30E854
	for <linux-hyperv@vger.kernel.org>; Fri, 14 Nov 2025 11:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763120976; cv=none; b=D9KGv7xo/K+Jsh6sJcy5RVttet7Py4B5Of1smhMmtfbzeTzwikZuuEmvGRVi6o1JmXWpB24xD1KtpVBAVKCUkFc8SIswd+gcOgHJKENEB29MSN8Nxr+cA7EdMFPAfJBd9RXyOIFB7Kzxwz0crWLK2ZN17V/i477sk3FkzFll10A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763120976; c=relaxed/simple;
	bh=vwahUSp5YQTJyYca3f9QlLDPSMAEJf7JQP6DChDyn/c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bOVG6FCm+h5XZQewdUhifrzeYXU3Y9b7LmqzEJmrqKYe9FS+/LSNxRw/0+Hwy3a8I8Ku9XqW1MKhNg/ijNSqN/vbkBfTN+P/XuQq9wglxARiIQISpIy2Y1wiuy5vWrsQd2A2+KwddEsOy3Mk1I/RyYRPmbX/N1KgHmZIF1MgQ9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aaCuEjuT; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-787c9f90eccso20913887b3.3
        for <linux-hyperv@vger.kernel.org>; Fri, 14 Nov 2025 03:49:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763120973; x=1763725773; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KCP0fq9NrHtq04u5AKlbZ6NekY0qgPfss4jXoTspXHc=;
        b=aaCuEjuTPjI3INZ7KYZYCighaDWn+zPRB8905P9mjQWWNX/Hwm2XaFb8Gmt9QF/phY
         K5+JW7bPDpsC9JGaGs/Q1tfwo5EP7WcbwS7dY11WAFmjJukrim6mDi7AMumTDuaTKNkP
         l9PjEgytfe6J8UaIIotcUWOVKYg7dZy9Ua5Z0sDv18VAvaMnxZ7VYgL0sCwdzQVYGAHl
         sWUZAyFIZs5ugPGvlcCqiey2JC+sZGtrgM6eplvyI2Q3RfPmOI6h/CtaCMNRDLcypi77
         rToc0btfawCjXPh+w6SE7nlG4NkcT+veK99NPWQPW5HjFGqYGvpqI4XBXZ3lflQEC6Qg
         RLCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763120973; x=1763725773;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KCP0fq9NrHtq04u5AKlbZ6NekY0qgPfss4jXoTspXHc=;
        b=WtmLAUeJUdxDlmr8soy3doEQhWRtt9o3WKfNG6bLO5dABL6dIAsqvil8BMKSOEbB2z
         pnk6iyzfWQxVNeymISyX30+fnrHtXNtUl4O08M/SYPW3UV2c6M7gfwVA3o58QxiITPSi
         Phl4FPfOpnXjV4Vj5RNgWksxP4yh8E3fOMLe3Lq8+fiYV9fIOR5TDly0oQZT+8qKRAOk
         tkHjXZgvhLkZQ8b/rH7j89FZeo7hTEl9FRhM6CmrbkT5lHbDCNX3o1IU+I03KM6L9roM
         PKFPjSeGSqDQP4yAod/uMhDeH9ba5WMmdaoAuE1gWdgutp/8ZdcYTVhzGyUcOKUudzEx
         tOhA==
X-Forwarded-Encrypted: i=1; AJvYcCXDk4vEV6e/XOeqhqDQ3+Z3WFv0gyRQ2B/to4YouiOWljn/kCvBJmaSu1mLbyj9AYnYDYpM4oLJkxB87e8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyswqUPrK9VAZJ73DIanH4u7OkosEc/bXBiMbFpkjjhWRIGzDE
	g3TNlr1bTXw8KvFn/9KlH4KfVOAmMAfBt4UadrA5BBEax4FvE/IXcX2DZ2WQVvVv+2TM68JmoK5
	TS7Lqk1RVrBa/joP6UHbAMODIw/Ltgok=
X-Gm-Gg: ASbGncvNTVPabkeKNu2Fl2Y8XqvZuAbP2jeFtL8tfhALDaSVAJnCueymYXqziAn5fOS
	e8HEv4JIbBfo3uk4eia8usJYtBvjQEM8WG5QO3JXFHfX4wGkG9dNn65FNTxu0iwcHimhw+OzhZ3
	nCyxUyo+oy+o9p0qzzvJpvfbD67Bsk/LSmNr62ptYdOfn28Dn+Q4Dmp3plQLbp3vSElynqe4dE6
	tU52psBkou7j1hg/TMsw1vzXMtp3Rdt3CS9CR9Kq+9j5scgcUz5sPJeIUi0Q4hUbK7W4CePBK9d
	up0ewV4SawwmH21IwqSdmMvMCjn83/GHLdoeMSk=
X-Google-Smtp-Source: AGHT+IGgY0RCMrdDYWEgvk991hUiHklUkEjuB1nLEaSEWhi7uSWGUVc3JHjOAg1leKscNYyi/kK07roSx2cyp7IpsMI=
X-Received: by 2002:a05:690c:7342:b0:786:57f5:b49a with SMTP id
 00721157ae682-78929e5341emr24663787b3.29.1763120973150; Fri, 14 Nov 2025
 03:49:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aRYjk4JBqHvVl-wN@eldamar.lan> <7a38c04d-4e54-4f1a-96fd-43f0f11ab97b@linux.microsoft.com>
In-Reply-To: <7a38c04d-4e54-4f1a-96fd-43f0f11ab97b@linux.microsoft.com>
From: Peter Morrow <pdmorrow@gmail.com>
Date: Fri, 14 Nov 2025 11:49:22 +0000
X-Gm-Features: AWmQ_bl0SBJOFSgqRHSj1LuxiEDat2xdPPqrhSzSzQnn92HbNlDYJQ1byHb3M2M
Message-ID: <CAFcZKTwQgd9hrTaXnThML=+WG82TH3DK90FT1-WWsBSoRj7dRw@mail.gmail.com>
Subject: Re: [REGRESSION 6.12.y] hyper-v: BUG: kernel NULL pointer
 dereference, address: 00000000000000a0: RIP: 0010:hv_uio_channel_cb+0xd/0x20 [uio_hv_generic]
To: Naman Jain <namjain@linux.microsoft.com>
Cc: Salvatore Bonaccorso <carnil@debian.org>, Long Li <longli@microsoft.com>, 1120602@bugs.debian.org, 
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org, 
	regressions@lists.linux.dev, stable@vger.kernel.org, 
	John Starks <jostarks@microsoft.com>, Michael Kelley <mhklinux@outlook.com>, 
	Tianyu Lan <tiala@microsoft.com>, "K. Y. Srinivasan" <kys@microsoft.com>, 
	Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
	Dexuan Cui <decui@microsoft.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Naman,

On Fri, 14 Nov 2025 at 06:03, Naman Jain <namjain@linux.microsoft.com> wrot=
e:
>
>
>
> On 11/13/2025 11:59 PM, Salvatore Bonaccorso wrote:
> > Peter Morrow reported in Debian a regression, reported in
> > https://bugs.debian.org/1120602 . The regression was seen after
> > updating, to 6.12.57-1 in Debian, but details on the offending commit
> > follows.
> >
> > His report was as follows:
> >
> >> Dear Maintainer,
> >>
> >> I'm seeing a kernel crash quite soon after boot on a debian trixie bas=
ed
> >> system running 6.12.57+deb13-amd64, unfortunately the kernel panics be=
fore
> >> I can access the system to gather more information. Thus I'll provide =
details
> >> of the system using a previously known good version. The panic is happ=
ening
> >> 100% of the time unfortunately. I have access to the serial console ho=
wever
> >> so can enable any required verbose logging during boot if necessary.
> >>
> >> Crucially the crash is not seen with kernel version 6.12.41+deb13-amd6=
4 with the
> >> same userspace. We had pinned to that version until very recently to i=
n order
> >> to work around https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D110=
9676
> >>
> >> I'm running a dpdk application here (VPP) on Azure, VM form factor is =
a
> >> "Standard DS3 v2 (4 vcpus, 14 GiB memory)".
> >>
> >> The only relevant upstream commit in this area (as far as I can see) i=
s:
> >>
> >> https://lore.kernel.org/linux-hyperv/1bb599ee-fe28-409d-b430-2fc086268=
936@linux.microsoft.com/
> >>
> >> The comment regarding avoiding races at start adds a bit more weight b=
ehind this
> >> hunch, though it's only a hunch as I am most definitely nowhere near a=
n expert
> >> in this area.
> >>
> >> -- Package-specific info:
> >>
> >> [   19.625535] BUG: kernel NULL pointer dereference, address: 00000000=
000000a0
> >> [   19.628874] #PF: supervisor read access in kernel mode
> >> [   19.630841] #PF: error_code(0x0000) - not-present page
> >> [   19.632788] PGD 0 P4D 0
> >> [   19.633905] Oops: Oops: 0000 [#1] PREEMPT SMP PTI
> >> [   19.635586] CPU: 3 UID: 0 PID: 0 Comm: swapper/3 Not tainted 6.12.5=
7+deb13-amd64 #1  Debian 6.12.57-1
> >> [   19.640216] Hardware name: Microsoft Corporation Virtual Machine/Vi=
rtual Machine, BIOS Hyper-V UEFI Release v4.1 09/28/2024
> >> [   19.644514] RIP: 0010:hv_uio_channel_cb+0xd/0x20 [uio_hv_generic]
> >> [   19.646994] Code: 02 00 00 5b 5d e9 53 98 69 e9 0f 1f 00 90 90 90 9=
0 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 0f 1f 44 00 00 48 8b 47 1=
0 <48> 8b b8 a0 00 00 00 f0 83 44 24 fc 00 e9 51 6f fa ff 90 90 90 90
> >> [   19.654377] RSP: 0018:ffffb15ac01a4fa8 EFLAGS: 00010046
> >> [   19.656385] RAX: 0000000000000000 RBX: 0000000000000015 RCX: 000000=
0000000015
> >> [   19.659240] RDX: 0000000000000001 RSI: ffffffffffffffff RDI: ffff8f=
f69c759400
> >> [   19.662168] RBP: ffff8ff548790200 R08: ffff8ff548790200 R09: 00fca7=
5150b080e9
> >> [   19.665239] R10: 0000000000000000 R11: ffffb15ac01a4ff8 R12: ffff8f=
f871dc1480
> >> [   19.668193] R13: ffff8ff69c759400 R14: ffff8ff69c7596a0 R15: ffffff=
ffc106e160
> >> [   19.671106] FS:  0000000000000000(0000) GS:ffff8ff871d80000(0000) k=
nlGS:0000000000000000
> >> [   19.674281] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> >> [   19.676533] CR2: 00000000000000a0 CR3: 0000000100ba6003 CR4: 000000=
00003706f0
> >> [   19.679385] Call Trace:
> >> [   19.680361]  <IRQ>
> >> [   19.681181]  vmbus_isr+0x1a5/0x210 [hv_vmbus]
> >> [   19.682916]  __sysvec_hyperv_callback+0x32/0x60
> >> [   19.684991]  sysvec_hyperv_callback+0x6c/0x90
> >> [   19.686665]  </IRQ>
> >> [   19.687509]  <TASK>
> >> [   19.688366]  asm_sysvec_hyperv_callback+0x1a/0x20
> >> [   19.690262] RIP: 0010:pv_native_safe_halt+0xf/0x20
> >> [   19.692067] Code: 09 e9 c5 08 01 00 0f 1f 44 00 00 90 90 90 90 90 9=
0 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 66 90 0f 00 2d e5 3b 31 00 fb f=
4 <c3> cc cc cc cc 66 66 2e 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90
> >> [   19.699119] RSP: 0018:ffffb15ac0103ed8 EFLAGS: 00000246
> >> [   19.701412] RAX: 0000000000000003 RBX: ffff8ff5403b1fc0 RCX: ffff8f=
f54c64ce30
> >> [   19.704328] RDX: 0000000000000000 RSI: 0000000000000003 RDI: 000000=
000001f894
> >> [   19.706910] RBP: 0000000000000003 R08: 000000000bb760d9 R09: 00fca7=
5150b080e9
> >> [   19.709762] R10: 0000000000000003 R11: 0000000000000001 R12: 000000=
0000000000
> >> [   19.712510] R13: 0000000000000000 R14: 0000000000000000 R15: 000000=
0000000000
> >> [   19.715173]  default_idle+0x9/0x20
> >> [   19.716846]  default_idle_call+0x29/0x100
> >> [   19.718623]  do_idle+0x1fe/0x240
> >> [   19.720045]  cpu_startup_entry+0x29/0x30
> >> [   19.721595]  start_secondary+0x11e/0x140
> >> [   19.723080]  common_startup_64+0x13e/0x141
> >> [   19.725222]  </TASK>
> >> [   19.726387] Modules linked in: isofs cdrom uio_hv_generic uio binfm=
t_misc intel_rapl_msr intel_rapl_common intel_uncore_frequency_common isst_=
if_mbox_msr isst_if_common rpcrdma skx_edac_common nfit sunrpc libnvdimm cr=
ct10dif_pclmul ghash_clmulni_intel sha512_ssse3 sha256_ssse3 rdma_ucm ib_is=
er sha1_ssse3 rdma_cm aesni_intel iw_cm gf128mul crypto_simd libiscsi crypt=
d ib_umad ib_ipoib scsi_transport_iscsi ib_cm rapl sg hv_utils hv_balloon e=
vdev pcspkr joydev mpls_router ip_tunnel ramoops configfs pstore_blk efi_ps=
tore pstore_zone nfnetlink vsock_loopback vmw_vsock_virtio_transport_common=
 hv_sock vmw_vsock_vmci_transport vsock vmw_vmci efivarfs ip_tables x_table=
s autofs4 overlay squashfs dm_verity dm_bufio reed_solomon dm_mod loop ext4=
 crc16 mbcache jbd2 crc32c_generic mlx5_ib ib_uverbs ib_core mlx5_core mlxf=
w pci_hyperv pci_hyperv_intf hyperv_drm drm_shmem_helper sd_mod drm_kms_hel=
per hv_storvsc scsi_transport_fc drm scsi_mod hid_generic hid_hyperv hid se=
rio_raw hv_netvsc hyperv_keyboard scsi_common hv_vmbus
> >> [   19.726466]  crc32_pclmul crc32c_intel
> >> [   19.765771] CR2: 00000000000000a0
> >> [   19.767524] ---[ end trace 0000000000000000 ]---
> >> [   19.800433] RIP: 0010:hv_uio_channel_cb+0xd/0x20 [uio_hv_generic]
> >> [   19.803170] Code: 02 00 00 5b 5d e9 53 98 69 e9 0f 1f 00 90 90 90 9=
0 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 0f 1f 44 00 00 48 8b 47 1=
0 <48> 8b b8 a0 00 00 00 f0 83 44 24 fc 00 e9 51 6f fa ff 90 90 90 90
> >> [   19.811041] RSP: 0018:ffffb15ac01a4fa8 EFLAGS: 00010046
> >> [   19.813466] RAX: 0000000000000000 RBX: 0000000000000015 RCX: 000000=
0000000015
> >> [   19.816504] RDX: 0000000000000001 RSI: ffffffffffffffff RDI: ffff8f=
f69c759400
> >> [   19.819484] RBP: ffff8ff548790200 R08: ffff8ff548790200 R09: 00fca7=
5150b080e9
> >> [   19.822625] R10: 0000000000000000 R11: ffffb15ac01a4ff8 R12: ffff8f=
f871dc1480
> >> [   19.825569] R13: ffff8ff69c759400 R14: ffff8ff69c7596a0 R15: ffffff=
ffc106e160
> >> [   19.828804] FS:  0000000000000000(0000) GS:ffff8ff871d80000(0000) k=
nlGS:0000000000000000
> >> [   19.832214] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> >> [   19.834709] CR2: 00000000000000a0 CR3: 0000000100ba6003 CR4: 000000=
00003706f0
> >> [   19.837976] Kernel panic - not syncing: Fatal exception in interrup=
t
> >> [   19.841825] Kernel Offset: 0x28a00000 from 0xffffffff81000000 (relo=
cation range: 0xffffffff80000000-0xffffffffbfffffff)
> >> [   19.896620] ---[ end Kernel panic - not syncing: Fatal exception in=
 interrupt ]---
> >>
>
> <snip>
>
> > The offending commit appers to be the backport of b15b7d2a1b09
> > ("uio_hv_generic: Let userspace take care of interrupt mask") for
> > 6.12.y.
> >
> > Peter confirmed that reverting this commit on top of 6.12.57-1 as
> > packaged in Debian resolves indeed the issue. Interestingly the issue
> > is *not* seen with 6.17.7 based kernel in Debian.
> >
> > #regzbot introduced: 37bd91f22794dc05436130d6983302cb90ecfe7e
> > #regzbot monitor: https://bugs.debian.org/1120602
> >
> > Thank you already!
> >
> > Regards,
> > Salvatore
>
> Hi Peter, Salvatore,
> Thanks for reporting this crash, and sorry for the trouble. Here is my
> analysis.
>
> On 6.17.7, where commit d062463edf17 ("uio_hv_generic: Set event for all
> channels on the device") is present, hv_uio_irqcontrol() supports
> setting of interrupt mask from userspace for sub-channels as well.
>
> This aligns with commit e29587c07537 ("uio_hv_generic: Let userspace
> take care of interrupt mask") which relies on userspace to manage
> interrupt mask, so it safely removes the interrupt mask management logic
> in the driver.
>
> However, in 6.12.57, the first commit is not present, but the second one
> is, so there is no way to disable interrupt mask for sub-channels and
> interrupt_mask stays 0, which means interrupts are not masked. So we may
> be having an interrupt callback being handled for a sub-channel, where
> we do not expect it to come. This may be causing this issue.
>
> This would have led to a crash in hv_uio_channel_cb() for sub-channels:
> struct hv_device *hv_dev =3D chan->device_obj;
>
>
> I have ported commit d062463edf17 ("uio_hv_generic: Set event for all
> channels on the device") on 6.12.57, and resolved some merge conflicts.
> Could you please help with testing this, if it works for you.

Applying the patch against the debian 6.12.57 kernel worked, I am no
longer seeing that panic on boot:

gnos@vEdge:~$ uname -a
Linux vEdge 6.12+unreleased-amd64 #1 SMP PREEMPT_DYNAMIC Debian
6.12.57-1a~test (2025-11-14) x86_64 GNU/Linux
gnos@vEdge:~$ uptime
 11:46:33 up 4 min,  1 user,  load average: 3.31, 2.07, 0.89
gnos@vEdge:~$ sudo dmidecode -t system
# dmidecode 3.6
Getting SMBIOS data from sysfs.
SMBIOS 3.1.0 present.

Handle 0x0001, DMI type 1, 27 bytes
System Information
        Manufacturer: Microsoft Corporation
        Product Name: Virtual Machine
        Version: Hyper-V UEFI Release v4.1
        Serial Number: 0000-0002-8036-1108-7588-3134-50
        UUID: 26e86d6e-140c-496a-862c-a3b3bbcd16ad
        Wake-up Type: Power Switch
        SKU Number: None
        Family: Virtual Machine

Handle 0x0010, DMI type 32, 11 bytes
System Boot Information
        Status: No errors detected

gnos@vEdge:~$

Thanks a lot for the quick analysis!

Peter.

>
> Hi Long,
> If this works, do you see any concerns if I back-port your patch on
> older kernels (6.12 and prior)?
>
> Regards,
> Naman
>
> --------------
> Patch:
>
>  From 2f14d48d2bde3f86b153b9f756a9cd688cda3453 Mon Sep 17 00:00:00 2001
> From: Long Li <longli@microsoft.com>
> Date: Mon, 10 Mar 2025 15:12:01 -0700
> Subject: [PATCH] uio_hv_generic: Set event for all channels on the device
>
> Hyper-V may offer a non latency sensitive device with subchannels without
> monitor bit enabled. The decision is entirely on the Hyper-V host not
> configurable within guest.
>
> When a device has subchannels, also signal events for the subchannel
> if its monitor bit is disabled.
>
> This patch also removes the memory barrier when monitor bit is enabled
> as it is not necessary. The memory barrier is only needed between
> setting up interrupt mask and calling vmbus_set_event() when monitor
> bit is disabled.
>
> Signed-off-by: Long Li <longli@microsoft.com>
> Reviewed-by: Michael Kelley <mhklinux@outlook.com>
> Reviewed-by: Saurabh Sengar <ssengar@linux.microsoft.com>
> Signed-off-by: Naman Jain <namjain@linux.microsoft.com>
> ---
>   drivers/uio/uio_hv_generic.c | 32 ++++++++++++++++++++++++++------
>   1 file changed, 26 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/uio/uio_hv_generic.c b/drivers/uio/uio_hv_generic.c
> index 0b414d1168dd..9f3b124a5e09 100644
> --- a/drivers/uio/uio_hv_generic.c
> +++ b/drivers/uio/uio_hv_generic.c
> @@ -65,6 +65,16 @@ struct hv_uio_private_data {
>          char    send_name[32];
>   };
>
> +static void set_event(struct vmbus_channel *channel, s32 irq_state)
> +{
> +       channel->inbound.ring_buffer->interrupt_mask =3D !irq_state;
> +       if (!channel->offermsg.monitor_allocated && irq_state) {
> +               /* MB is needed for host to see the interrupt mask first =
*/
> +               virt_mb();
> +               vmbus_set_event(channel);
> +       }
> +}
> +
>   /*
>    * This is the irqcontrol callback to be registered to uio_info.
>    * It can be used to disable/enable interrupt from user space processes=
.
> @@ -79,12 +89,15 @@ hv_uio_irqcontrol(struct uio_info *info, s32 irq_stat=
e)
>   {
>          struct hv_uio_private_data *pdata =3D info->priv;
>          struct hv_device *dev =3D pdata->device;
> +       struct vmbus_channel *primary, *sc;
>
> -       dev->channel->inbound.ring_buffer->interrupt_mask =3D !irq_state;
> -       virt_mb();
> +       primary =3D dev->channel;
> +       set_event(primary, irq_state);
>
> -       if (!dev->channel->offermsg.monitor_allocated && irq_state)
> -               vmbus_setevent(dev->channel);
> +       mutex_lock(&vmbus_connection.channel_mutex);
> +       list_for_each_entry(sc, &primary->sc_list, sc_list)
> +               set_event(sc, irq_state);
> +       mutex_unlock(&vmbus_connection.channel_mutex);
>
>          return 0;
>   }
> @@ -95,11 +108,18 @@ hv_uio_irqcontrol(struct uio_info *info, s32 irq_sta=
te)
>   static void hv_uio_channel_cb(void *context)
>   {
>          struct vmbus_channel *chan =3D context;
> -       struct hv_device *hv_dev =3D chan->device_obj;
> -       struct hv_uio_private_data *pdata =3D hv_get_drvdata(hv_dev);
> +       struct hv_device *hv_dev;
> +       struct hv_uio_private_data *pdata;
>
>          virt_mb();
>
> +       /*
> +       * The callback may come from a subchannel, in which case look
> +       * for the hv device in the primary channel
> +       */
> +       hv_dev =3D chan->primary_channel ?
> +       chan->primary_channel->device_obj : chan->device_obj;
> +       pdata =3D hv_get_drvdata(hv_dev);
>          uio_event_notify(&pdata->info);
>   }
>
> --
> 2.43.0

