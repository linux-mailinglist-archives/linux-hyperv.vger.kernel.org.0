Return-Path: <linux-hyperv+bounces-4818-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 68CCBA804FC
	for <lists+linux-hyperv@lfdr.de>; Tue,  8 Apr 2025 14:13:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81DE23B06D4
	for <lists+linux-hyperv@lfdr.de>; Tue,  8 Apr 2025 12:07:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49783269CE6;
	Tue,  8 Apr 2025 12:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b="GgwqOX9j"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3BD6269B12;
	Tue,  8 Apr 2025 12:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744113957; cv=none; b=tVLlZbkSFpLAe7cirCCGhe+txl/3QwvHaPrdseyqwrphsqnfD8KFCwa7A7jtPxAsh2w6IuGPh886NkhPnuh8kyEaPmtDf9Bw0SiMvSOcdxlUfvbPc52nxkPNR0cWit/gbaedDVE2S43klCglsgQdlDphapFlbJrlgJbr84nyWPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744113957; c=relaxed/simple;
	bh=jXMobLYx5BmQ61oS27pg9+1XfoV0FmpfKH5PTC2MAt0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UP5QmzFIzfwrOSitBzCLDjjBEUHruKiJCxOjJveZL8grldeTIv1GjxqrOPXiuB+SxOySUy7ej6HepmIj1sq/zcZ4qdjwXw8F5fnoC+FM/VIg419FmtrAyc7R/5FMcNpEyTZDJuByYAQMefMLDdcZmB2PRQ/7CgO++Uov/1ySxi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b=GgwqOX9j; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1744113892; x=1744718692; i=spasswolf@web.de;
	bh=y7pvh9NxPFXwBjh1TnyNyATj1r/o8FQr5pBVTsL3P7A=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=GgwqOX9jTsgCIwtPWoCAZSHy4i2DXyPeiV7BKmkLc88ZSwTGJ2ff7EaqwaWRsvCl
	 M74GZxxsuDZ1ABuX+qEM7S6QHpMj0F3LTt/cHCXlDBg3fjGF3DtiSaVgdOJ+61CEW
	 H254iXlBAOIQMEr5/3tdfKxWa0XLSrdPb6wtqTuB+d/fz1L0QPCawPUjyiNT9MS5r
	 08w/aSY8utpYvLLfzEuACDj3cq9rvH6zWFI0nz+7eAsZK+R5kYAUdIfO34I16VO7s
	 WU9qa/3+c/WoPbCDSSk7waa5zKyiOw8YT8Ur6eaE6oDNJBy1mwJavuqExYD/f82Pk
	 lnl/QScu4lfeB0r9XQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from localhost.localdomain ([95.223.134.88]) by smtp.web.de
 (mrweb105 [213.165.67.124]) with ESMTPSA (Nemesis) id
 1N5Ug4-1t16uf2lYI-011NmK; Tue, 08 Apr 2025 14:04:51 +0200
From: Bert Karwatzki <spasswolf@web.de>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Bert Karwatzki <spasswolf@web.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-kernel@vger.kernel.org,
	James.Bottomley@HansenPartnership.com,
	Jonathan.Cameron@huawei.com,
	allenbh@gmail.com,
	d-gole@ti.com,
	dave.jiang@intel.com,
	haiyangz@microsoft.com,
	jdmason@kudzu.us,
	kristo@kernel.org,
	linux-hyperv@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-scsi@vger.kernel.org,
	logang@deltatee.com,
	manivannan.sadhasivam@linaro.org,
	martin.petersen@oracle.com,
	maz@kernel.org,
	mhklinux@outlook.com,
	nm@ti.com,
	ntb@lists.linux.dev,
	peterz@infradead.org,
	ssantosh@kernel.org,
	wei.huang2@amd.com,
	wei.liu@kernel.org
Subject: commit 7b025f3f85ed causes NULL pointer dereference
Date: Tue,  8 Apr 2025 14:04:44 +0200
Message-ID: <20250408120446.3128-1-spasswolf@web.de>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250319105506.564105011@linutronix.de>
References: 
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:JlZYVXz2ZJ0Pn+QLXUIuvS1DoV3J9McGI6ddlWU4v2GXlT4JJAe
 BAOP8Q82D27kOP0A+cOQCg4C7eB6X+Z6Sivtg6KPxXZ+PTdxq6odcvEmiDfvS9N2PDIA+l+
 vX0Ya5wlWlUctjI5kSgDEw2UY9Mz0nQvqWLudpI+jG51h3nIOcah2dUb9uTxahoxptN1PQx
 oZDPQaKi4MsnI4ni+0KNg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:gb/9h0oVc/Q=;n3QIi49X+UiP8Rb500i0tWdronH
 4TdAN93Ct22tn3uSjZghH3dK8ZPCbN02lgunBVvk7mPyQy9An9wiHNvrK+UthB30QL3DY9gA3
 rWRPjoS5PrEYciJlj3NTw5itGVqu5G+GIz+hKjOkjgiHr+1DKO/cOI81IMqwkN3flWpldlP6k
 lQahwU561xPq9CpDF+6S4CgAlJUXVUMiXIZZarTNjbSBhJkHNH4RBYLhfp9wEda/B6YgBj9ig
 5f56CCZQabM+lGNNI92HyZ1XH9LP8doYVEr4YFPkspgxD32iDGa86f2f784fFqE22KMagO332
 4hTBSC54FsV/Nf+eU7tTEftnWcVlFg2hZe32Dof4KhFU9QrJh3AMF8QL6nEZ7Y58pItkgtPOs
 LKzZN+AXnoLMyAWEtATxYHPWXGIh+C5zcyMmEzr9iKNZmfIqSgnauPq+IACC3GApf2WvH8vkx
 SepyVs3YzIW3CCReqcJBg6zEpJELHoy/uCwUve6oiqSChr9FNdtwoQWGJoFBRT7BIEKWs7+kt
 Ppoo57c3dZhSzxGlJtiTL9/oRulRdpc9tZrdSp802CbBU3YpD1q3iTf/G66vl9wxAugo729UO
 fh/gk6t8zIni43SNhJrMzuA6p/1WP3NRxLkaszD1UR5BmSf2eL7q0MozTzd/jcDVNDWeyqvmN
 Xi+WJXjwOsKlEISfeB1G5qF5rqRDCN/qI6OH9vxy+DiZCcpERIc6GPa6ASc6qRdssHodJ1B/4
 vQZLYSTcHFBiIE9bNawlvjpipbUMwFRiAU0nF6ZEmDuA6Ecd6G4qRinx57FK7D9VN3YRZv+GC
 gyNjRNgHZiVfl4pSvu7onoYzFZKVDbOazFnmeFKg8sp5vWELPE02xXjCabqjpprTkWBSv/fet
 9Kp34yQtlhhdl/t/r1oicnAXPyzpeKkyV/mdKJxbTB0eP/9MsB60gvYSx4kbxF5/5HVzuDzW0
 NzbQ0tqBzV4HC3pphEvJBG53IQ5wLA4StdzKpBdI+SGkB5Sx4Jf6Jn+3NIRI68lGFRt3gn94d
 UanyqwvpqJ358+dXinO2oVrATH6629OVQe7RjCrzfkkb3tV1ixsmXeSANo7khS1h1tykRiOEt
 +RS73vIHClLIo3viQaqo04FFf+0VyWcvau1x5rI7WptZzioPx/hSF0Bj/QI5qlLUXozgNDFMr
 il2XTv00Z86Yk0sVfq+gLp8vlOG+R5TrrS8kDtmwMxV5v+e5i9pBNYZoEzQco37WzzRXLgOVa
 OItxJADEl2Gj+YzSq4W14gq49IQxNOYOdmJCaYwyCdUx10YN7axzwXYXZnLKbPQ1UJiK4qYaM
 PNZnwBPaIYzRNPfQ+ImvzWByKVkdVex/x/LJksKc5/XR4eRB++mpgSTUphZJ3XKDeTrsb5k9n
 K0D+cUBpVi4JTRmQZ57rSYLl4hGAUirKTD5EL12cMpQrR3PrwUtIpnfXhl5lZJcwMVwjbbNGo
 Nsb7cCw==

Since linux-next-20250408 I get a NULL pointer dereference when booting:

[  T669] BUG: kernel NULL pointer dereference, address: 0000000000000330
[  T669] #PF: supervisor read access in kernel mode
[  T669] #PF: error_code(0x0000) - not-present page
[  T669] PGD 0 P4D 0
[  T669] Oops: Oops: 0000 [#1] SMP NOPTI
[  T669] CPU: 2 UID: 0 PID: 669 Comm: (udev-worker) Not tainted 6.15.0-rc1=
-next-20250408-master #788 PREEMPT_{RT,(lazy)}
[  T669] Hardware name: Micro-Star International Co., Ltd. Alpha 15 B5EEK/=
MS-158L, BIOS E158LAMS.107 11/10/2021
[  T669] RIP: 0010:msi_domain_first_desc+0x4/0x30
[  T669] Code: e9 21 ff ff ff 0f 0b 31 c0 e9 f3 8c da ff 0f 1f 84 00 00 00=
 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa <48> 8b=
 bf 68 02 00 00 48 85 ff 74 13 85 f6 75 0f 48 c7 47 60 00 00
[  T669] RSP: 0018:ffffcec6c25cfa78 EFLAGS: 00010246
[  T669] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000008
[  T669] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 00000000000000c8
[  T669] RBP: ffff8d26cb419aec R08: 0000000000000228 R09: 0000000000000000
[  T669] R10: ffff8d26c516fdc0 R11: ffff8d26ca5a4aa0 R12: ffff8d26c1aed0c8
[  T669] R13: 0000000000000002 R14: ffffcec6c25cfa90 R15: ffff8d26c1aed000
[  T669] FS:  00007f690f71a980(0000) GS:ffff8d35e83fa000(0000) knlGS:00000=
00000000000
[  T669] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  T669] CR2: 0000000000000330 CR3: 0000000121b64000 CR4: 0000000000750ef0
[  T669] PKRU: 55555554
[  T669] Call Trace:
[  T669]  <TASK>
[  T669]  msix_setup_interrupts+0x23b/0x280
[  T669]  __pci_enable_msix_range+0x31a/0x520
[  T669]  sp_pci_probe+0xf2/0x1f0 [ccp]
[  T669]  ? rt_spin_unlock+0x12/0x40
[  T669]  pci_device_probe+0xc0/0x180
[  T669]  really_probe+0xd9/0x340
[  T669]  ? pm_runtime_barrier+0x4f/0x90
[  T669]  ? __pfx___driver_attach+0x10/0x10
[  T669]  __driver_probe_device+0x73/0x110
[  T669]  driver_probe_device+0x1a/0xa0
[  T669]  __driver_attach+0xb5/0x1c0
[  T669]  bus_for_each_dev+0x78/0xd0
[  T669]  bus_add_driver+0x110/0x1f0
[  T669]  driver_register+0x6d/0xc0
[  T669]  sp_mod_init+0x15/0xff0 [ccp]
[  T669]  ? __pfx_sp_mod_init+0x10/0x10 [ccp]
[  T669]  do_one_initcall+0x48/0x2a0
[  T669]  ? srso_alias_return_thunk+0x5/0xfbef5
[  T669]  ? __kmalloc_cache_noprof+0x7c/0x160
[  T669]  do_init_module+0x5b/0x220
[  T669]  init_module_from_file+0x83/0xd0
[  T669]  idempotent_init_module+0xf9/0x2f0
[  T669]  __x64_sys_finit_module+0x60/0xc0
[  T669]  do_syscall_64+0x5f/0xfa0
[  T669]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  T669] RIP: 0033:0x7f69101e4779
[  T669] Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8=
 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d=
 01 f0 ff ff 73 01 c3 48 8b 0d 4f 86 0d 00 f7 d8 64 89 01 48
[  T669] RSP: 002b:00007fff409a8788 EFLAGS: 00000246 ORIG_RAX: 00000000000=
00139
[  T669] RAX: ffffffffffffffda RBX: 000056296549f860 RCX: 00007f69101e4779
[  T669] RDX: 0000000000000004 RSI: 00007f691035544d RDI: 0000000000000015
[  T669] RBP: 0000000000000004 R08: 0000000000000000 R09: 00005629653acc40
[  T669] R10: 0000000000000000 R11: 0000000000000246 R12: 00007f691035544d
[  T669] R13: 0000000000020000 R14: 000056296549eea0 R15: 0000000000000000
[  T669]  </TASK>
[  T669] Modules linked in: ccp(+) snd_pci_acp3x battery soundcore ac butt=
on evdev joydev hid_sensor_accel_3d hid_sensor_prox hid_sensor_gyro_3d hid=
_sensor_magn_3d hid_sensor_als hid_sensor_trigger industrialio_triggered_b=
uffer kfifo_buf industrialio amd_pmc hid_sensor_iio_common mt7921e mt7921_=
common mt792x_lib mt76_connac_lib mt76 mac80211 libarc4 cfg80211 rfkill ms=
r fuse nvme_fabrics efi_pstore configfs efivarfs autofs4 ext4 mbcache jbd2=
 amdgpu usbhid amdxcp i2c_algo_bit drm_client_lib hid_sensor_hub drm_ttm_h=
elper mfd_core ttm drm_exec xhci_pci hid_generic gpu_sched xhci_hcd drm_su=
balloc_helper drm_panel_backlight_quirks cec drm_buddy drm_display_helper =
nvme psmouse i2c_hid_acpi usbcore serio_raw amd_sfh i2c_hid nvme_core drm_=
kms_helper hid r8169 i2c_piix4 usb_common i2c_smbus crc16 i2c_designware_p=
latform i2c_designware_core
[  T669] CR2: 0000000000000330
[  T669] ---[ end trace 0000000000000000 ]---
[  T155] ACPI: battery: Slot [BAT1] (battery present)
[  T669] RIP: 0010:msi_domain_first_desc+0x4/0x30
[  T669] Code: e9 21 ff ff ff 0f 0b 31 c0 e9 f3 8c da ff 0f 1f 84 00 00 00=
 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa <48> 8b=
 bf 68 02 00 00 48 85 ff 74 13 85 f6 75 0f 48 c7 47 60 00 00
[  T669] RSP: 0018:ffffcec6c25cfa78 EFLAGS: 00010246
[  T669] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000008
[  T669] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 00000000000000c8
[  T669] RBP: ffff8d26cb419aec R08: 0000000000000228 R09: 0000000000000000
[  T669] R10: ffff8d26c516fdc0 R11: ffff8d26ca5a4aa0 R12: ffff8d26c1aed0c8
[  T669] R13: 0000000000000002 R14: ffffcec6c25cfa90 R15: ffff8d26c1aed000
[  T669] FS:  00007f690f71a980(0000) GS:ffff8d35e83fa000(0000) knlGS:00000=
00000000000
[  T669] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  T669] CR2: 0000000000000330 CR3: 0000000121b64000 CR4: 0000000000750ef0
[  T669] PKRU: 55555554
[  T669] note: (udev-worker)[669] exited with irqs disabled

I bisected (from v6.15-rc1 to next-20250408) the first bad commit as 7b025=
f3f85ed.
To fix this in next-20250408 one needs to revert these commits:

7b025f3f85ed ("PCI/MSI: Switch msix_capability_init() to guard(msi_desc_lo=
ck)")
0ee2572d7b84 ("genirq/msi: Rename msi_[un]lock_descs()")

Bert Karwatzki

