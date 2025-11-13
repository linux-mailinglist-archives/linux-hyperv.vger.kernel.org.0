Return-Path: <linux-hyperv+bounces-7549-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 74BE1C59771
	for <lists+linux-hyperv@lfdr.de>; Thu, 13 Nov 2025 19:29:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id DBA9234DA18
	for <lists+linux-hyperv@lfdr.de>; Thu, 13 Nov 2025 18:29:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2784A2FB0AD;
	Thu, 13 Nov 2025 18:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ToqsM3k8"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2B9430B50B
	for <linux-hyperv@vger.kernel.org>; Thu, 13 Nov 2025 18:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763058586; cv=none; b=eAbW6LJM37bclowEkeJoIC85GSraxVJl1gTHHUL6eb908u/NgZnrB+kIiS+sXgW+ZEqfTHFqen9bOCQfumBaeaY1FFIQYY3ISjxhbPLLOchpPlJM8IH1V60sR/03lT1fnMffjAu175EAGtiG8/Sx2AdwD/FkKFLcOPmFqM25n8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763058586; c=relaxed/simple;
	bh=gxVTe6wapHcxHJzeMHGKcV+8LlGzGQhS2ogjCiOnqdk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ditKYpL+KGb06CoR/ZzwinBzyL+nCpALURrFbqq8KhGtyggnFna9Do2tpaTquPEKsb6QfAaeBUg1reRPob8O2uErPub8EuRIMmJ7pwBNdkCuHZl/YOa0SuRCFrZJ8Fo8P3v8ZY6bBWe2iHirVI5G84nm5ZYQVe/yAnYkLG5lzYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ToqsM3k8; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4710022571cso11318255e9.3
        for <linux-hyperv@vger.kernel.org>; Thu, 13 Nov 2025 10:29:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763058582; x=1763663382; darn=vger.kernel.org;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/k263nSEDRDxaQiDUHQpujaUVS40wxd9xH4PYYY29fE=;
        b=ToqsM3k8qKxL6y6hTbH8Dl5joTU1qAmW3UrNKSerdaFSF8UpeyP20PMfKvgz/M1UtN
         wfW7R7Km/CJRyc6DDq/8WUwMd/8SayXIkD/Q9ho2GFS6xmmXQwkT9kEbXa2lMimc5Lml
         HFC3shEu9TFdrGhQbYnJ8seeao0JcsghdBA0dacrNDwwF07PG4CDCNxtbjRAWZn6GR5x
         Dxt3+1vc9ve3q36cmp7eg3wbgOO1mGq+K4GAFaeVAZ8X0xVqVWEPM3CNdO93coN2wtOB
         DfCauuuws13rnGwf7zuQ0KNSWnFZKL3IPVqO9ZzthAQBBXlXOeOOFQGMyi5vUGtsmujh
         Majw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763058582; x=1763663382;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/k263nSEDRDxaQiDUHQpujaUVS40wxd9xH4PYYY29fE=;
        b=D5h3lt4+fMSEjmA+m3tmaqx7Z0sPc3WFRBQeoco0SWGgd7g9VKnltLOSMUf3S+Hmle
         NTvJZ08mnfLs7Oh6iUQnuZXIrNThJws/ptms5vZ1urQgZ+3sq+3ZgYqK0qGQ69EOET2I
         YbPTHR0C3ir/y782ZzeSnrYJ0DjxqKEw6/ONrLaqov+YrtnSqelpCsrqVKzUc3KXxmoA
         9jXNu7r+s+oWfhSvPlh6H3CSs4NtODJm5ZbY6hael7ChPfeAngyqf4ylbfn4Nv8ejM+q
         vDNpfACPpmvCqdWVENoU2+yxgziJLAci77T/fbGurbXdrs12j+dV1f95jyBHWKDhshBS
         /E8Q==
X-Forwarded-Encrypted: i=1; AJvYcCU4yJxkJHawTLZVK675+536yNI7A+gU5MkOeUQx41Yo75itM0j83zKI4tPKoxOa1/oC15gvHhiJJmPnwhw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKF+aUNl4iaxAuxjIBxE83LwzNrIFEGQR/63CW3KyICzUUDXg8
	fXu2ImO1H7OX/zY+/KvtJcqmf6/NOwvMYaSvsW5kWP/196GttZdjLahq
X-Gm-Gg: ASbGncu/U92Upi7pyB+MUhXj03P89H5qDmrWM7vpDceUFOGe+8AenXopy1wamZsRYT/
	2gFmNK3RZGr97+uLUU2nkctFvqYzp9ICirrjPl5MwpmHbsxY2Ipo3V906Xhs+/dgAS1hm79bN28
	rF7E5oO7gp1BAeEOOujCMjjdrNIBwxBk+zaMikk6btfa2W2QVpJeAPVRarWdN0pIs6LtvOxm1pJ
	tDAKONGohxVdjFDJ6bE1sKqZm/oINY+UWlBGnlQTvoeZotzv6nR5j7Yw4+qgznErTy3/g0gfGR1
	oibQFSwltY5IC9yLBczZ9cibChWb0v3IepKPynmG+fB2V7r+kAHgoDey2CYNdT/G25OAjbTCpiV
	rse9cfz0RDAnll5GOBpRAn6x1lTbIIrO7y/vt0g7jDcb9DVjObgF9Qng8igN/+N52mMoC5ghC8w
	g5YonQz1MgQ7UJzwg0SJpRY2oQUxnAKadOL0Zuvsl2h/fV
X-Google-Smtp-Source: AGHT+IGWOwXLsXQM1cc3iFMhaERJhkH8upgtiuuKhWlUX4ZQDdGrcpVEqb9GKAEnSS+TE2dDORFYuQ==
X-Received: by 2002:a05:600c:c493:b0:477:7b9a:bb07 with SMTP id 5b1f17b1804b1-4778feabc40mr5134955e9.35.1763058581750;
        Thu, 13 Nov 2025 10:29:41 -0800 (PST)
Received: from eldamar.lan (c-82-192-244-13.customer.ggaweb.ch. [82.192.244.13])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4778c88c068sm47292975e9.9.2025.11.13.10.29.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 10:29:40 -0800 (PST)
Sender: Salvatore Bonaccorso <salvatore.bonaccorso@gmail.com>
Received: by eldamar.lan (Postfix, from userid 1000)
	id 93E03BE2EE7; Thu, 13 Nov 2025 19:29:39 +0100 (CET)
Date: Thu, 13 Nov 2025 19:29:39 +0100
From: Salvatore Bonaccorso <carnil@debian.org>
To: Naman Jain <namjain@linux.microsoft.com>,
	John Starks <jostarks@microsoft.com>,
	Michael Kelley <mhklinux@outlook.com>,
	Long Li <longli@microsoft.com>, Tianyu Lan <tiala@microsoft.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Peter Morrow <pdmorrow@gmail.com>
Cc: 1120602@bugs.debian.org, linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org, regressions@lists.linux.dev,
	stable@vger.kernel.org
Subject: [REGRESSION 6.12.y] hyper-v: BUG: kernel NULL pointer dereference,
 address: 00000000000000a0: RIP: 0010:hv_uio_channel_cb+0xd/0x20
 [uio_hv_generic]
Message-ID: <aRYjk4JBqHvVl-wN@eldamar.lan>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Peter Morrow reported in Debian a regression, reported in
https://bugs.debian.org/1120602 . The regression was seen after
updating, to 6.12.57-1 in Debian, but details on the offending commit
follows.

His report was as follows:

> Dear Maintainer,
>=20
> I'm seeing a kernel crash quite soon after boot on a debian trixie based
> system running 6.12.57+deb13-amd64, unfortunately the kernel panics before
> I can access the system to gather more information. Thus I'll provide det=
ails
> of the system using a previously known good version. The panic is happeni=
ng
> 100% of the time unfortunately. I have access to the serial console howev=
er
> so can enable any required verbose logging during boot if necessary.
>=20
> Crucially the crash is not seen with kernel version 6.12.41+deb13-amd64 w=
ith the
> same userspace. We had pinned to that version until very recently to in o=
rder
> to work around https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D1109676
>=20
> I'm running a dpdk application here (VPP) on Azure, VM form factor is a
> "Standard DS3 v2 (4 vcpus, 14 GiB memory)".
>=20
> The only relevant upstream commit in this area (as far as I can see) is:
>=20
> https://lore.kernel.org/linux-hyperv/1bb599ee-fe28-409d-b430-2fc086268936=
@linux.microsoft.com/
>=20
> The comment regarding avoiding races at start adds a bit more weight behi=
nd this
> hunch, though it's only a hunch as I am most definitely nowhere near an e=
xpert
> in this area.
>=20
> -- Package-specific info:
>=20
> [   19.625535] BUG: kernel NULL pointer dereference, address: 00000000000=
000a0
> [   19.628874] #PF: supervisor read access in kernel mode
> [   19.630841] #PF: error_code(0x0000) - not-present page
> [   19.632788] PGD 0 P4D 0=20
> [   19.633905] Oops: Oops: 0000 [#1] PREEMPT SMP PTI
> [   19.635586] CPU: 3 UID: 0 PID: 0 Comm: swapper/3 Not tainted 6.12.57+d=
eb13-amd64 #1  Debian 6.12.57-1
> [   19.640216] Hardware name: Microsoft Corporation Virtual Machine/Virtu=
al Machine, BIOS Hyper-V UEFI Release v4.1 09/28/2024
> [   19.644514] RIP: 0010:hv_uio_channel_cb+0xd/0x20 [uio_hv_generic]
> [   19.646994] Code: 02 00 00 5b 5d e9 53 98 69 e9 0f 1f 00 90 90 90 90 9=
0 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 0f 1f 44 00 00 48 8b 47 10 <=
48> 8b b8 a0 00 00 00 f0 83 44 24 fc 00 e9 51 6f fa ff 90 90 90 90
> [   19.654377] RSP: 0018:ffffb15ac01a4fa8 EFLAGS: 00010046
> [   19.656385] RAX: 0000000000000000 RBX: 0000000000000015 RCX: 000000000=
0000015
> [   19.659240] RDX: 0000000000000001 RSI: ffffffffffffffff RDI: ffff8ff69=
c759400
> [   19.662168] RBP: ffff8ff548790200 R08: ffff8ff548790200 R09: 00fca7515=
0b080e9
> [   19.665239] R10: 0000000000000000 R11: ffffb15ac01a4ff8 R12: ffff8ff87=
1dc1480
> [   19.668193] R13: ffff8ff69c759400 R14: ffff8ff69c7596a0 R15: ffffffffc=
106e160
> [   19.671106] FS:  0000000000000000(0000) GS:ffff8ff871d80000(0000) knlG=
S:0000000000000000
> [   19.674281] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   19.676533] CR2: 00000000000000a0 CR3: 0000000100ba6003 CR4: 000000000=
03706f0
> [   19.679385] Call Trace:
> [   19.680361]  <IRQ>
> [   19.681181]  vmbus_isr+0x1a5/0x210 [hv_vmbus]
> [   19.682916]  __sysvec_hyperv_callback+0x32/0x60
> [   19.684991]  sysvec_hyperv_callback+0x6c/0x90
> [   19.686665]  </IRQ>
> [   19.687509]  <TASK>
> [   19.688366]  asm_sysvec_hyperv_callback+0x1a/0x20
> [   19.690262] RIP: 0010:pv_native_safe_halt+0xf/0x20
> [   19.692067] Code: 09 e9 c5 08 01 00 0f 1f 44 00 00 90 90 90 90 90 90 9=
0 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 66 90 0f 00 2d e5 3b 31 00 fb f4 <=
c3> cc cc cc cc 66 66 2e 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90
> [   19.699119] RSP: 0018:ffffb15ac0103ed8 EFLAGS: 00000246
> [   19.701412] RAX: 0000000000000003 RBX: ffff8ff5403b1fc0 RCX: ffff8ff54=
c64ce30
> [   19.704328] RDX: 0000000000000000 RSI: 0000000000000003 RDI: 000000000=
001f894
> [   19.706910] RBP: 0000000000000003 R08: 000000000bb760d9 R09: 00fca7515=
0b080e9
> [   19.709762] R10: 0000000000000003 R11: 0000000000000001 R12: 000000000=
0000000
> [   19.712510] R13: 0000000000000000 R14: 0000000000000000 R15: 000000000=
0000000
> [   19.715173]  default_idle+0x9/0x20
> [   19.716846]  default_idle_call+0x29/0x100
> [   19.718623]  do_idle+0x1fe/0x240
> [   19.720045]  cpu_startup_entry+0x29/0x30
> [   19.721595]  start_secondary+0x11e/0x140
> [   19.723080]  common_startup_64+0x13e/0x141
> [   19.725222]  </TASK>
> [   19.726387] Modules linked in: isofs cdrom uio_hv_generic uio binfmt_m=
isc intel_rapl_msr intel_rapl_common intel_uncore_frequency_common isst_if_=
mbox_msr isst_if_common rpcrdma skx_edac_common nfit sunrpc libnvdimm crct1=
0dif_pclmul ghash_clmulni_intel sha512_ssse3 sha256_ssse3 rdma_ucm ib_iser =
sha1_ssse3 rdma_cm aesni_intel iw_cm gf128mul crypto_simd libiscsi cryptd i=
b_umad ib_ipoib scsi_transport_iscsi ib_cm rapl sg hv_utils hv_balloon evde=
v pcspkr joydev mpls_router ip_tunnel ramoops configfs pstore_blk efi_pstor=
e pstore_zone nfnetlink vsock_loopback vmw_vsock_virtio_transport_common hv=
_sock vmw_vsock_vmci_transport vsock vmw_vmci efivarfs ip_tables x_tables a=
utofs4 overlay squashfs dm_verity dm_bufio reed_solomon dm_mod loop ext4 cr=
c16 mbcache jbd2 crc32c_generic mlx5_ib ib_uverbs ib_core mlx5_core mlxfw p=
ci_hyperv pci_hyperv_intf hyperv_drm drm_shmem_helper sd_mod drm_kms_helper=
 hv_storvsc scsi_transport_fc drm scsi_mod hid_generic hid_hyperv hid serio=
_raw hv_netvsc hyperv_keyboard scsi_common hv_vmbus
> [   19.726466]  crc32_pclmul crc32c_intel
> [   19.765771] CR2: 00000000000000a0
> [   19.767524] ---[ end trace 0000000000000000 ]---
> [   19.800433] RIP: 0010:hv_uio_channel_cb+0xd/0x20 [uio_hv_generic]
> [   19.803170] Code: 02 00 00 5b 5d e9 53 98 69 e9 0f 1f 00 90 90 90 90 9=
0 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 0f 1f 44 00 00 48 8b 47 10 <=
48> 8b b8 a0 00 00 00 f0 83 44 24 fc 00 e9 51 6f fa ff 90 90 90 90
> [   19.811041] RSP: 0018:ffffb15ac01a4fa8 EFLAGS: 00010046
> [   19.813466] RAX: 0000000000000000 RBX: 0000000000000015 RCX: 000000000=
0000015
> [   19.816504] RDX: 0000000000000001 RSI: ffffffffffffffff RDI: ffff8ff69=
c759400
> [   19.819484] RBP: ffff8ff548790200 R08: ffff8ff548790200 R09: 00fca7515=
0b080e9
> [   19.822625] R10: 0000000000000000 R11: ffffb15ac01a4ff8 R12: ffff8ff87=
1dc1480
> [   19.825569] R13: ffff8ff69c759400 R14: ffff8ff69c7596a0 R15: ffffffffc=
106e160
> [   19.828804] FS:  0000000000000000(0000) GS:ffff8ff871d80000(0000) knlG=
S:0000000000000000
> [   19.832214] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   19.834709] CR2: 00000000000000a0 CR3: 0000000100ba6003 CR4: 000000000=
03706f0
> [   19.837976] Kernel panic - not syncing: Fatal exception in interrupt
> [   19.841825] Kernel Offset: 0x28a00000 from 0xffffffff81000000 (relocat=
ion range: 0xffffffff80000000-0xffffffffbfffffff)
> [   19.896620] ---[ end Kernel panic - not syncing: Fatal exception in in=
terrupt ]---
>=20
>=20
> lspci output:
>=20
> Collected from a system that is not crashing (6.12.41+deb13-amd64 #1 SMP =
PREEMPT_DYNAMIC Debian 6.12.41-1 (2025-08-12) x86_64 GNU/Linux)...
>=20
> $ sudo lspci -v
> 2f22:00:02.0 Ethernet controller: Mellanox Technologies MT27710 Family [C=
onnectX-4 Lx Virtual Function] (rev 80)
>         Subsystem: Mellanox Technologies Device 0190
>         Physical Slot: 3
>         Flags: bus master, fast devsel, latency 0, NUMA node 0
>         Memory at fe0100000 (64-bit, prefetchable) [size=3D1M]
>         Capabilities: [60] Express Endpoint, IntMsgNum 0
>         Capabilities: [9c] MSI-X: Enable+ Count=3D8 Masked-
>         Kernel driver in use: mlx5_core
>         Kernel modules: mlx5_core
>=20
> 52f7:00:02.0 Ethernet controller: Mellanox Technologies MT27710 Family [C=
onnectX-4 Lx Virtual Function] (rev 80)
>         Subsystem: Mellanox Technologies Device 0190
>         Physical Slot: 2
>         Flags: bus master, fast devsel, latency 0, NUMA node 0
>         Memory at fe0000000 (64-bit, prefetchable) [size=3D1M]
>         Capabilities: [60] Express Endpoint, IntMsgNum 0
>         Capabilities: [9c] MSI-X: Enable+ Count=3D8 Masked-
>         Kernel driver in use: mlx5_core
>         Kernel modules: mlx5_core
>=20
> 7852:00:02.0 Ethernet controller: Mellanox Technologies MT27710 Family [C=
onnectX-4 Lx Virtual Function] (rev 80)
>         Subsystem: Mellanox Technologies Device 0190
>         Physical Slot: 4
>         Flags: bus master, fast devsel, latency 0, NUMA node 0
>         Memory at fe0200000 (64-bit, prefetchable) [size=3D1M]
>         Capabilities: [60] Express Endpoint, IntMsgNum 0
>         Capabilities: [9c] MSI-X: Enable+ Count=3D8 Masked-
>         Kernel driver in use: mlx5_core
>         Kernel modules: mlx5_core
>=20
> dmidecode output:
>=20
> $ sudo dmidecode=20
> # dmidecode 3.6
> Getting SMBIOS data from sysfs.
> SMBIOS 3.1.0 present.
> Table at 0x3FF82000.
>=20
> Handle 0x0000, DMI type 0, 26 bytes
> BIOS Information
>         Vendor: Microsoft Corporation
>         Version: Hyper-V UEFI Release v4.1
>         Release Date: 05/13/2024
>         ROM Size: 64 kB
>         Characteristics:
>                 BIOS characteristics not supported
>                 ACPI is supported
>                 Targeted content distribution is supported
>                 UEFI is supported
>                 System is a virtual machine
>         BIOS Revision: 4.1
>=20
> Handle 0x0001, DMI type 1, 27 bytes
> System Information
>         Manufacturer: Microsoft Corporation
>         Product Name: Virtual Machine
>         Version: Hyper-V UEFI Release v4.1
>         Serial Number: 0000-0010-5437-9499-5225-4477-46
>         UUID: 925315af-4af4-4d42-915a-1516b5a1fe5c
>         Wake-up Type: Power Switch
>         SKU Number: None
>         Family: Virtual Machine
>=20
> Handle 0x0002, DMI type 3, 24 bytes
> Chassis Information
>         Manufacturer: Microsoft Corporation
>         Type: Desktop
>         Lock: Not Present
>         Version: Hyper-V UEFI Release v4.1
>         Serial Number: 2466-9316-1078-9783-6078-7718-80
>         Asset Tag: 7783-7084-3265-9085-8269-3286-77
>         Boot-up State: Safe
>         Power Supply State: Safe
>         Thermal State: Safe
>         Security Status: Unknown
>         OEM Information: 0x00000000
>         Height: Unspecified
>         Number Of Power Cords: Unspecified
>         Contained Elements: 0
>         SKU Number: Virtual Machine
>=20
> Handle 0x0003, DMI type 2, 17 bytes
> Base Board Information
>         Manufacturer: Microsoft Corporation
>         Product Name: Virtual Machine
>         Version: Hyper-V UEFI Release v4.1
>         Serial Number: 0000-0010-4737-0707-0684-2660-76
>         Asset Tag: None
>         Features:
>                 Board is a hosting board
>         Location In Chassis: Virtual Machine
>         Chassis Handle: 0x0002
>         Type: Motherboard
>         Contained Object Handles: 0
>=20
> Handle 0x0004, DMI type 4, 48 bytes
> Processor Information
>         Socket Designation: None
>         Type: Central Processor
>         Family: Unknown
>         Manufacturer: None
>         ID: 00 00 00 00 00 00 00 00
>         Version: None
>         Voltage: Unknown
>         External Clock: Unknown
>         Max Speed: Unknown
>         Current Speed: Unknown
>         Status: Unpopulated
>         Upgrade: Other
>         L1 Cache Handle: Not Provided
>         L2 Cache Handle: Not Provided
>         L3 Cache Handle: Not Provided
>         Serial Number: None
>         Asset Tag: None
>         Part Number: None
>         Core Count: 4
>         Core Enabled: 4
>         Thread Count: 1
>         Characteristics: None
>=20
> Handle 0x0005, DMI type 11, 5 bytes
> OEM Strings
>         String 1: [MS_VM_CERT/SHA1/9b80ca0d5dd061ec9da4e494f4c3fd1196270c=
22]
>         String 2: None
>         String 3: To be filled by OEM
>=20
> Handle 0x0006, DMI type 16, 23 bytes
> Physical Memory Array
>         Location: System Board Or Motherboard
>         Use: System Memory
>         Error Correction Type: None
>         Maximum Capacity: 0 bytes
>         Error Information Handle: Not Provided
>         Number Of Devices: 3
>=20
> Handle 0x0007, DMI type 17, 92 bytes
> Memory Device
>         Array Handle: 0x0006
>         Error Information Handle: Not Provided
>         Total Width: Unknown
>         Data Width: Unknown
>         Size: 26 MB
>         Form Factor: Unknown
>         Set: None
>         Locator: M0001
>         Bank Locator: None
>         Type: Unknown
>         Type Detail: Unknown
>         Speed: Unknown
>         Manufacturer: Microsoft Corporation
>         Serial Number: None
>         Asset Tag: None
>         Part Number: None
>         Rank: Unknown
>         Configured Memory Speed: Unknown
>         Minimum Voltage: Unknown
>         Maximum Voltage: Unknown
>         Configured Voltage: Unknown
>         Memory Technology: <OUT OF SPEC>
>         Memory Operating Mode Capability: None
>         Firmware Version: Not Specified
>         Module Manufacturer ID: Unknown
>         Module Product ID: Unknown
>         Memory Subsystem Controller Manufacturer ID: Unknown
>         Memory Subsystem Controller Product ID: Unknown
>         Non-Volatile Size: None
>         Volatile Size: None
>         Cache Size: None
>         Logical Size: None
>=20
> Handle 0x0008, DMI type 19, 31 bytes
> Memory Array Mapped Address
>         Starting Address: 0x00000000000
>         Ending Address: 0x00001A003FF
>         Range Size: 26625 kB
>         Physical Array Handle: 0x0006
>         Partition Width: 0
>=20
> Handle 0x0009, DMI type 20, 35 bytes
> Memory Device Mapped Address
>         Starting Address: 0x00000000000
>         Ending Address: 0x00001A003FF
>         Range Size: 26625 kB
>         Physical Device Handle: 0x0007
>         Memory Array Mapped Address Handle: 0x0008
>         Partition Row Position: Unknown
>=20
> Handle 0x000A, DMI type 17, 92 bytes
> Memory Device
>         Array Handle: 0x0006
>         Error Information Handle: Not Provided
>         Total Width: Unknown
>         Data Width: Unknown
>         Size: 948 MB
>         Form Factor: Unknown
>         Set: None
>         Locator: M0002
>         Bank Locator: None
>         Type: Unknown
>         Type Detail: Unknown
>         Speed: Unknown
>         Manufacturer: Microsoft Corporation
>         Serial Number: None
>         Asset Tag: None
>         Part Number: None
>         Rank: Unknown
>         Configured Memory Speed: Unknown
>         Minimum Voltage: Unknown
>         Maximum Voltage: Unknown
>         Configured Voltage: Unknown
>         Memory Technology: <OUT OF SPEC>
>         Memory Operating Mode Capability: None
>         Firmware Version: Not Specified
>         Module Manufacturer ID: Unknown
>         Module Product ID: Unknown
>         Memory Subsystem Controller Manufacturer ID: Unknown
>         Memory Subsystem Controller Product ID: Unknown
>         Non-Volatile Size: None
>         Volatile Size: None
>         Cache Size: None
>         Logical Size: None
>=20
> Handle 0x000B, DMI type 19, 31 bytes
> Memory Array Mapped Address
>         Starting Address: 0x00004C00000
>         Ending Address: 0x000400003FF
>         Range Size: 970753 kB
>         Physical Array Handle: 0x0006
>         Partition Width: 0
>=20
> Handle 0x000C, DMI type 20, 35 bytes
> Memory Device Mapped Address
>         Starting Address: 0x00004C00000
>         Ending Address: 0x000400003FF
>         Range Size: 970753 kB
>         Physical Device Handle: 0x000A
>         Memory Array Mapped Address Handle: 0x000B
>         Partition Row Position: Unknown
>=20
> Handle 0x000D, DMI type 17, 92 bytes
> Memory Device
>         Array Handle: 0x0006
>         Error Information Handle: Not Provided
>         Total Width: Unknown
>         Data Width: Unknown
>         Size: 13 GB
>         Form Factor: Unknown
>         Set: None
>         Locator: M0003
>         Bank Locator: None
>         Type: Unknown
>         Type Detail: Unknown
>         Speed: Unknown
>         Manufacturer: Microsoft Corporation
>         Serial Number: None
>         Asset Tag: None
>         Part Number: None
>         Rank: Unknown
>         Configured Memory Speed: Unknown
>         Minimum Voltage: Unknown
>         Maximum Voltage: Unknown
>         Configured Voltage: Unknown
>         Memory Technology: <OUT OF SPEC>
>         Memory Operating Mode Capability: None
>         Firmware Version: Not Specified
>         Module Manufacturer ID: Unknown
>         Module Product ID: Unknown
>         Memory Subsystem Controller Manufacturer ID: Unknown
>         Memory Subsystem Controller Product ID: Unknown
>         Non-Volatile Size: None
>         Volatile Size: None
>         Cache Size: None
>         Logical Size: None
>=20
> Handle 0x000E, DMI type 19, 31 bytes
> Memory Array Mapped Address
>         Starting Address: 0x00100000000
>         Ending Address: 0x004400003FF
>         Range Size: 13 GB
>         Physical Array Handle: 0x0006
>         Partition Width: 0
>=20
> Handle 0x000F, DMI type 20, 35 bytes
> Memory Device Mapped Address
>         Starting Address: 0x00100000000
>         Ending Address: 0x004400003FF
>         Range Size: 13 GB
>         Physical Device Handle: 0x000D
>         Memory Array Mapped Address Handle: 0x000E
>         Partition Row Position: Unknown
>=20
> Handle 0x0010, DMI type 32, 11 bytes
> System Boot Information
>         Status: No errors detected
>=20
> Handle 0xFEFF, DMI type 127, 4 bytes
> End Of Table

The offending commit appers to be the backport of b15b7d2a1b09
("uio_hv_generic: Let userspace take care of interrupt mask") for
6.12.y.

Peter confirmed that reverting this commit on top of 6.12.57-1 as
packaged in Debian resolves indeed the issue. Interestingly the issue
is *not* seen with 6.17.7 based kernel in Debian.

#regzbot introduced: 37bd91f22794dc05436130d6983302cb90ecfe7e
#regzbot monitor: https://bugs.debian.org/1120602

Thank you already!

Regards,
Salvatore

