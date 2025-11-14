Return-Path: <linux-hyperv+bounces-7601-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 00ADDC5F6B9
	for <lists+linux-hyperv@lfdr.de>; Fri, 14 Nov 2025 22:47:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8643D4E80D5
	for <lists+linux-hyperv@lfdr.de>; Fri, 14 Nov 2025 21:45:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 272B335C19F;
	Fri, 14 Nov 2025 21:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="BRb7ix83"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF4D035C19E;
	Fri, 14 Nov 2025 21:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763156711; cv=none; b=RXtpzyyZ5ViGTKzceazFU8OKBjUYdzY+wGiUckojxk118K62KUb65bWquGpQAQkcJPlUA0zm24rdkYPN1Wse5ipevoy8A3VZq3IA9YENGgyYWw/gxH05cvo/BUpR/41tDxtq547vFzB8Tm+MfYQI4HTJKC06mLMalKLvF/FbsQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763156711; c=relaxed/simple;
	bh=8yV/1TtKZlz2cVJvMfiRXn2RNvg0Co3xAz5QeLG0ceI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I+bpDW0VxckL2KkgzspjHoq7V35t628Q9aTlnZTIMoHJFDORkAEQKqS5s+ULKaJ3A8ixnMnTkJBBScdrk7RNmcHT1hqEjdO4E5P7kVYYiAmaEtPRp7R2ZQHyTdHlTiGeaBMxME4Ocgbim1DMQiRIl9yKbboHj22x5mG4dwbRbDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=BRb7ix83; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Reply-To:Content-ID:Content-Description;
	bh=1qEvKdM4yVvgywk0rQSlRE1gxfNcdOB7tJ87UFkWygk=; b=BRb7ix83UX/dtzICyjNenj/D8G
	0A1VzDuDgkDDJHvcbxirb1EXiI24T6EfDceK8TICEC6O32sBtNURQ1xPp26cWKfG6NNabQj8bHy2l
	RPiYNlFYts3VopmK56KAGc0vO4zYhnQLORUhwPXmbev6GQPmQdBN38JAo+iuB9JqV+J336pxsM3uR
	aiuYfLKg8VQR481iu/tPGLnt82q6LJtvKDzzvqACRCgJXo1RTPfBMtxwjPuNcJjZVMaX5JJoHIVAG
	1WK8jbF1uFhAFuKY/vZmiu6Y8SRoO/KLMeoJscnnQCdJDeOUU23mQF5MhdNpsb9rpiDgKOuu3+/2v
	FXfqUoiw==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.94.2)
	(envelope-from <carnil@debian.org>)
	id 1vK1bC-00CIZs-65; Fri, 14 Nov 2025 21:44:54 +0000
Received: by eldamar.lan (Postfix, from userid 1000)
	id F08CEBE2EE7; Fri, 14 Nov 2025 22:44:52 +0100 (CET)
Date: Fri, 14 Nov 2025 22:44:52 +0100
From: Salvatore Bonaccorso <carnil@debian.org>
To: Naman Jain <namjain@linux.microsoft.com>, 1120602@bugs.debian.org
Cc: Peter Morrow <pdmorrow@gmail.com>, Long Li <longli@microsoft.com>,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
	regressions@lists.linux.dev, stable@vger.kernel.org,
	John Starks <jostarks@microsoft.com>,
	Michael Kelley <mhklinux@outlook.com>,
	Tianyu Lan <tiala@microsoft.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Bug#1120602: [REGRESSION 6.12.y] hyper-v: BUG: kernel NULL
 pointer dereference, address: 00000000000000a0: RIP:
 0010:hv_uio_channel_cb+0xd/0x20 [uio_hv_generic]
Message-ID: <aRei1DGOWy13GqvE@eldamar.lan>
References: <aRYjk4JBqHvVl-wN@eldamar.lan>
 <7a38c04d-4e54-4f1a-96fd-43f0f11ab97b@linux.microsoft.com>
 <CAFcZKTwQgd9hrTaXnThML=+WG82TH3DK90FT1-WWsBSoRj7dRw@mail.gmail.com>
 <176298819854.487825.11724175116974643582.reportbug@p15v.lan>
 <18bcf829-04f9-46ec-a874-7c2b9338cf3d@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <18bcf829-04f9-46ec-a874-7c2b9338cf3d@linux.microsoft.com>
X-Debian-User: carnil

Hi,

On Fri, Nov 14, 2025 at 08:05:55PM +0530, Naman Jain wrote:
>=20
>=20
> On 11/14/2025 5:19 PM, Peter Morrow wrote:
> > Hi Naman,
> >=20
> > On Fri, 14 Nov 2025 at 06:03, Naman Jain <namjain@linux.microsoft.com> =
wrote:
> > >=20
> > >=20
> > >=20
> > > On 11/13/2025 11:59 PM, Salvatore Bonaccorso wrote:
> > > > Peter Morrow reported in Debian a regression, reported in
> > > > https://bugs.debian.org/1120602 . The regression was seen after
> > > > updating, to 6.12.57-1 in Debian, but details on the offending comm=
it
> > > > follows.
> > > >=20
> > > > His report was as follows:
> > > >=20
> > > > > Dear Maintainer,
> > > > >=20
> > > > > I'm seeing a kernel crash quite soon after boot on a debian trixi=
e based
> > > > > system running 6.12.57+deb13-amd64, unfortunately the kernel pani=
cs before
> > > > > I can access the system to gather more information. Thus I'll pro=
vide details
> > > > > of the system using a previously known good version. The panic is=
 happening
> > > > > 100% of the time unfortunately. I have access to the serial conso=
le however
> > > > > so can enable any required verbose logging during boot if necessa=
ry.
> > > > >=20
> > > > > Crucially the crash is not seen with kernel version 6.12.41+deb13=
-amd64 with the
> > > > > same userspace. We had pinned to that version until very recently=
 to in order
> > > > > to work around https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=
=3D1109676
> > > > >=20
> > > > > I'm running a dpdk application here (VPP) on Azure, VM form facto=
r is a
> > > > > "Standard DS3 v2 (4 vcpus, 14 GiB memory)".
> > > > >=20
> > > > > The only relevant upstream commit in this area (as far as I can s=
ee) is:
> > > > >=20
> > > > > https://lore.kernel.org/linux-hyperv/1bb599ee-fe28-409d-b430-2fc0=
86268936@linux.microsoft.com/
> > > > >=20
> > > > > The comment regarding avoiding races at start adds a bit more wei=
ght behind this
> > > > > hunch, though it's only a hunch as I am most definitely nowhere n=
ear an expert
> > > > > in this area.
> > > > >=20
> > > > > -- Package-specific info:
> > > > >=20
> > > > > [   19.625535] BUG: kernel NULL pointer dereference, address: 000=
00000000000a0
> > > > > [   19.628874] #PF: supervisor read access in kernel mode
> > > > > [   19.630841] #PF: error_code(0x0000) - not-present page
> > > > > [   19.632788] PGD 0 P4D 0
> > > > > [   19.633905] Oops: Oops: 0000 [#1] PREEMPT SMP PTI
> > > > > [   19.635586] CPU: 3 UID: 0 PID: 0 Comm: swapper/3 Not tainted 6=
=2E12.57+deb13-amd64 #1  Debian 6.12.57-1
> > > > > [   19.640216] Hardware name: Microsoft Corporation Virtual Machi=
ne/Virtual Machine, BIOS Hyper-V UEFI Release v4.1 09/28/2024
> > > > > [   19.644514] RIP: 0010:hv_uio_channel_cb+0xd/0x20 [uio_hv_gener=
ic]
> > > > > [   19.646994] Code: 02 00 00 5b 5d e9 53 98 69 e9 0f 1f 00 90 90=
 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 0f 1f 44 00 00 48 8b=
 47 10 <48> 8b b8 a0 00 00 00 f0 83 44 24 fc 00 e9 51 6f fa ff 90 90 90 90
> > > > > [   19.654377] RSP: 0018:ffffb15ac01a4fa8 EFLAGS: 00010046
> > > > > [   19.656385] RAX: 0000000000000000 RBX: 0000000000000015 RCX: 0=
000000000000015
> > > > > [   19.659240] RDX: 0000000000000001 RSI: ffffffffffffffff RDI: f=
fff8ff69c759400
> > > > > [   19.662168] RBP: ffff8ff548790200 R08: ffff8ff548790200 R09: 0=
0fca75150b080e9
> > > > > [   19.665239] R10: 0000000000000000 R11: ffffb15ac01a4ff8 R12: f=
fff8ff871dc1480
> > > > > [   19.668193] R13: ffff8ff69c759400 R14: ffff8ff69c7596a0 R15: f=
fffffffc106e160
> > > > > [   19.671106] FS:  0000000000000000(0000) GS:ffff8ff871d80000(00=
00) knlGS:0000000000000000
> > > > > [   19.674281] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > > > [   19.676533] CR2: 00000000000000a0 CR3: 0000000100ba6003 CR4: 0=
0000000003706f0
> > > > > [   19.679385] Call Trace:
> > > > > [   19.680361]  <IRQ>
> > > > > [   19.681181]  vmbus_isr+0x1a5/0x210 [hv_vmbus]
> > > > > [   19.682916]  __sysvec_hyperv_callback+0x32/0x60
> > > > > [   19.684991]  sysvec_hyperv_callback+0x6c/0x90
> > > > > [   19.686665]  </IRQ>
> > > > > [   19.687509]  <TASK>
> > > > > [   19.688366]  asm_sysvec_hyperv_callback+0x1a/0x20
> > > > > [   19.690262] RIP: 0010:pv_native_safe_halt+0xf/0x20
> > > > > [   19.692067] Code: 09 e9 c5 08 01 00 0f 1f 44 00 00 90 90 90 90=
 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 66 90 0f 00 2d e5 3b 31 00=
 fb f4 <c3> cc cc cc cc 66 66 2e 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90
> > > > > [   19.699119] RSP: 0018:ffffb15ac0103ed8 EFLAGS: 00000246
> > > > > [   19.701412] RAX: 0000000000000003 RBX: ffff8ff5403b1fc0 RCX: f=
fff8ff54c64ce30
> > > > > [   19.704328] RDX: 0000000000000000 RSI: 0000000000000003 RDI: 0=
00000000001f894
> > > > > [   19.706910] RBP: 0000000000000003 R08: 000000000bb760d9 R09: 0=
0fca75150b080e9
> > > > > [   19.709762] R10: 0000000000000003 R11: 0000000000000001 R12: 0=
000000000000000
> > > > > [   19.712510] R13: 0000000000000000 R14: 0000000000000000 R15: 0=
000000000000000
> > > > > [   19.715173]  default_idle+0x9/0x20
> > > > > [   19.716846]  default_idle_call+0x29/0x100
> > > > > [   19.718623]  do_idle+0x1fe/0x240
> > > > > [   19.720045]  cpu_startup_entry+0x29/0x30
> > > > > [   19.721595]  start_secondary+0x11e/0x140
> > > > > [   19.723080]  common_startup_64+0x13e/0x141
> > > > > [   19.725222]  </TASK>
> > > > > [   19.726387] Modules linked in: isofs cdrom uio_hv_generic uio =
binfmt_misc intel_rapl_msr intel_rapl_common intel_uncore_frequency_common =
isst_if_mbox_msr isst_if_common rpcrdma skx_edac_common nfit sunrpc libnvdi=
mm crct10dif_pclmul ghash_clmulni_intel sha512_ssse3 sha256_ssse3 rdma_ucm =
ib_iser sha1_ssse3 rdma_cm aesni_intel iw_cm gf128mul crypto_simd libiscsi =
cryptd ib_umad ib_ipoib scsi_transport_iscsi ib_cm rapl sg hv_utils hv_ball=
oon evdev pcspkr joydev mpls_router ip_tunnel ramoops configfs pstore_blk e=
fi_pstore pstore_zone nfnetlink vsock_loopback vmw_vsock_virtio_transport_c=
ommon hv_sock vmw_vsock_vmci_transport vsock vmw_vmci efivarfs ip_tables x_=
tables autofs4 overlay squashfs dm_verity dm_bufio reed_solomon dm_mod loop=
 ext4 crc16 mbcache jbd2 crc32c_generic mlx5_ib ib_uverbs ib_core mlx5_core=
 mlxfw pci_hyperv pci_hyperv_intf hyperv_drm drm_shmem_helper sd_mod drm_km=
s_helper hv_storvsc scsi_transport_fc drm scsi_mod hid_generic hid_hyperv h=
id serio_raw hv_netvsc hyperv_keyboard scsi_common hv_vmbus
> > > > > [   19.726466]  crc32_pclmul crc32c_intel
> > > > > [   19.765771] CR2: 00000000000000a0
> > > > > [   19.767524] ---[ end trace 0000000000000000 ]---
> > > > > [   19.800433] RIP: 0010:hv_uio_channel_cb+0xd/0x20 [uio_hv_gener=
ic]
> > > > > [   19.803170] Code: 02 00 00 5b 5d e9 53 98 69 e9 0f 1f 00 90 90=
 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 0f 1f 44 00 00 48 8b=
 47 10 <48> 8b b8 a0 00 00 00 f0 83 44 24 fc 00 e9 51 6f fa ff 90 90 90 90
> > > > > [   19.811041] RSP: 0018:ffffb15ac01a4fa8 EFLAGS: 00010046
> > > > > [   19.813466] RAX: 0000000000000000 RBX: 0000000000000015 RCX: 0=
000000000000015
> > > > > [   19.816504] RDX: 0000000000000001 RSI: ffffffffffffffff RDI: f=
fff8ff69c759400
> > > > > [   19.819484] RBP: ffff8ff548790200 R08: ffff8ff548790200 R09: 0=
0fca75150b080e9
> > > > > [   19.822625] R10: 0000000000000000 R11: ffffb15ac01a4ff8 R12: f=
fff8ff871dc1480
> > > > > [   19.825569] R13: ffff8ff69c759400 R14: ffff8ff69c7596a0 R15: f=
fffffffc106e160
> > > > > [   19.828804] FS:  0000000000000000(0000) GS:ffff8ff871d80000(00=
00) knlGS:0000000000000000
> > > > > [   19.832214] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > > > [   19.834709] CR2: 00000000000000a0 CR3: 0000000100ba6003 CR4: 0=
0000000003706f0
> > > > > [   19.837976] Kernel panic - not syncing: Fatal exception in int=
errupt
> > > > > [   19.841825] Kernel Offset: 0x28a00000 from 0xffffffff81000000 =
(relocation range: 0xffffffff80000000-0xffffffffbfffffff)
> > > > > [   19.896620] ---[ end Kernel panic - not syncing: Fatal excepti=
on in interrupt ]---
> > > > >=20
> > >=20
> > > <snip>
> > >=20
> > > > The offending commit appers to be the backport of b15b7d2a1b09
> > > > ("uio_hv_generic: Let userspace take care of interrupt mask") for
> > > > 6.12.y.
> > > >=20
> > > > Peter confirmed that reverting this commit on top of 6.12.57-1 as
> > > > packaged in Debian resolves indeed the issue. Interestingly the iss=
ue
> > > > is *not* seen with 6.17.7 based kernel in Debian.
> > > >=20
> > > > #regzbot introduced: 37bd91f22794dc05436130d6983302cb90ecfe7e
> > > > #regzbot monitor: https://bugs.debian.org/1120602
> > > >=20
> > > > Thank you already!
> > > >=20
> > > > Regards,
> > > > Salvatore
> > >=20
> > > Hi Peter, Salvatore,
> > > Thanks for reporting this crash, and sorry for the trouble. Here is my
> > > analysis.
> > >=20
> > > On 6.17.7, where commit d062463edf17 ("uio_hv_generic: Set event for =
all
> > > channels on the device") is present, hv_uio_irqcontrol() supports
> > > setting of interrupt mask from userspace for sub-channels as well.
> > >=20
> > > This aligns with commit e29587c07537 ("uio_hv_generic: Let userspace
> > > take care of interrupt mask") which relies on userspace to manage
> > > interrupt mask, so it safely removes the interrupt mask management lo=
gic
> > > in the driver.
> > >=20
> > > However, in 6.12.57, the first commit is not present, but the second =
one
> > > is, so there is no way to disable interrupt mask for sub-channels and
> > > interrupt_mask stays 0, which means interrupts are not masked. So we =
may
> > > be having an interrupt callback being handled for a sub-channel, where
> > > we do not expect it to come. This may be causing this issue.
> > >=20
> > > This would have led to a crash in hv_uio_channel_cb() for sub-channel=
s:
> > > struct hv_device *hv_dev =3D chan->device_obj;
> > >=20
> > >=20
> > > I have ported commit d062463edf17 ("uio_hv_generic: Set event for all
> > > channels on the device") on 6.12.57, and resolved some merge conflict=
s.
> > > Could you please help with testing this, if it works for you.
> >=20
> > Applying the patch against the debian 6.12.57 kernel worked, I am no
> > longer seeing that panic on boot:
> >=20
> > gnos@vEdge:~$ uname -a
> > Linux vEdge 6.12+unreleased-amd64 #1 SMP PREEMPT_DYNAMIC Debian
> > 6.12.57-1a~test (2025-11-14) x86_64 GNU/Linux
> > gnos@vEdge:~$ uptime
> >   11:46:33 up 4 min,  1 user,  load average: 3.31, 2.07, 0.89
> > gnos@vEdge:~$ sudo dmidecode -t system
> > # dmidecode 3.6
> > Getting SMBIOS data from sysfs.
> > SMBIOS 3.1.0 present.
> >=20
> > Handle 0x0001, DMI type 1, 27 bytes
> > System Information
> >          Manufacturer: Microsoft Corporation
> >          Product Name: Virtual Machine
> >          Version: Hyper-V UEFI Release v4.1
> >          Serial Number: 0000-0002-8036-1108-7588-3134-50
> >          UUID: 26e86d6e-140c-496a-862c-a3b3bbcd16ad
> >          Wake-up Type: Power Switch
> >          SKU Number: None
> >          Family: Virtual Machine
> >=20
> > Handle 0x0010, DMI type 32, 11 bytes
> > System Boot Information
> >          Status: No errors detected
> >=20
> > gnos@vEdge:~$
> >=20
> > Thanks a lot for the quick analysis!
> >=20
> > Peter.
>=20
> Hi Peter,
>=20
> Thanks for confirming. I am discussing this with Long Li, to hear his
> thoughts on this, and have kept the patch ready.
> Porting the same on 6.6 and older kernels would be a little different sin=
ce
> we don't have commit 547fa4ffd799 ("uio_hv_generic: Enable interrupt for =
low
> speed VMBus devices") on these kernels and this would lead to merge
> conflicts, which needs to be handled separately.
>=20
> Meanwhile, if I should be including any tags in the fix patch for debian
> bug, please let me know.

Thank you very much for the quick analysis and fix.

If you can add a Closes: https://bugs.debian.org/1120602 that would
make our tracking for the fixes easier. But not sure if this is
allowed for proposing the backport for a stable series, as it did not
affect the upper releases.

In any case your work is much appreciated!

Regards,
Salvatore

