Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2527328DD92
	for <lists+linux-hyperv@lfdr.de>; Wed, 14 Oct 2020 11:26:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728418AbgJNJ0c (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 14 Oct 2020 05:26:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:39871 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727103AbgJNJZg (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 14 Oct 2020 05:25:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602667534;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=RL5CWu6TuXC057v96r1Z8qscFfkz2NUQX6cGv1yQL/Q=;
        b=UrLVvESA4pqJbB4LdPyBnUKRia3n0nkCA8JBlY3MYPTgpaerDLrU1KrVqzeZXZbXYpw2W9
        NKANaEZSHb/QoTuWVBDB66Ucz/VWYFfd20NEBish03pvY7KRTG8CBvsLpDvsyoQ+c8EaLF
        rCTyIujLRbgKbGYGcyNOqqLG56cNI6E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-492-DCKInah0Pv2cgstJj9AiHQ-1; Wed, 14 Oct 2020 05:25:32 -0400
X-MC-Unique: DCKInah0Pv2cgstJj9AiHQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 84058802B72;
        Wed, 14 Oct 2020 09:25:30 +0000 (UTC)
Received: from kasong-rh-laptop.redhat.com (ovpn-12-25.pek2.redhat.com [10.72.12.25])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0EAB05C1BD;
        Wed, 14 Oct 2020 09:25:22 +0000 (UTC)
From:   Kairui Song <kasong@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Ard Biesheuvel <ardb@kernel.org>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Dave Young <dyoung@redhat.com>, x86@kernel.org,
        linux-hyperv@vger.kernel.org, kexec@lists.infradead.org,
        Kairui Song <kasong@redhat.com>
Subject: [PATCH 0/2] x86/hyperv: fix kexec/kdump hang on some VMs
Date:   Wed, 14 Oct 2020 17:24:27 +0800
Message-Id: <20201014092429.1415040-1-kasong@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On some HyperV machines, if kexec_file_load is used to load the kexec
kernel, second kernel could hang with following stacktrace:

[    0.591705] efifb: probing for efifb
[    0.596869] efifb: framebuffer at 0xf8000000, using 3072k, total 3072k
[    0.605894] efifb: mode is 1024x768x32, linelength=4096, pages=1
[    0.617926] efifb: scrolling: redraw
[    0.622715] efifb: Truecolor: size=8:8:8:8, shift=24:16:8:0
[   28.039046] watchdog: BUG: soft lockup - CPU#0 stuck for 23s! [swapper/0:1]
[   28.039046] Modules linked in:
[   28.039046] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.18.0-230.el8.x86_64 #1
[   28.039046] Hardware name: Microsoft Corporation Virtual Machine/Virtual Machine, BIOS Hyper-V UEFI Release v4.0 12/17/2019
[   28.039046] RIP: 0010:cfb_imageblit+0x450/0x4c0
[   28.039046] Code: 89 f8 b9 08 00 00 00 48 89 04 24 eb 2d 41 0f be 30 29 e9 4c 8d 5f 04 d3 fe 44 21 ee 41 8b 04 b6 44 21 c8 89 c6 44 31 d6 89 37 <85> c9 75 09 49 83 c0 01 b9 08 00 00 00 4c 89 df 48 39 df 75 ce 83
[   28.039046] RSP: 0018:ffffc90000087830 EFLAGS: 00010246 ORIG_RAX: ffffffffffffff12
[   28.039046] RAX: 0000000000000000 RBX: ffffc90000542000 RCX: 0000000000000003
[   28.039046] RDX: 000000000000000e RSI: 0000000000000000 RDI: ffffc90000541bf0
[   28.039046] RBP: 0000000000000001 R08: ffff8880f555c8df R09: 0000000000aaaaaa
[   28.039046] R10: 0000000000000000 R11: ffffc90000541bf4 R12: 0000000000001000
[   28.039046] R13: 0000000000000001 R14: ffffffff81e9a460 R15: ffff8880f555c880
[   28.039046] FS:  0000000000000000(0000) GS:ffff8880f1000000(0000) knlGS:0000000000000000
[   28.039046] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   28.039046] CR2: 00007f7b223b8000 CR3: 00000000f3a0a004 CR4: 00000000003606b0
[   28.039046] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   28.039046] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[   28.039046] Call Trace:
[   28.039046]  bit_putcs+0x2a1/0x550
[   28.039046]  ? fbcon_switch+0x33e/0x5b0
[   28.039046]  ? bit_clear+0x120/0x120
[   28.039046]  fbcon_putcs+0xe7/0x100
[   28.039046]  do_update_region+0x154/0x1a0
[   28.039046]  redraw_screen+0x209/0x240
[   28.039046]  ? vc_do_resize+0x5c9/0x660
[   28.039046]  fbcon_prepare_logo+0x3b3/0x430
[   28.039046]  fbcon_init+0x436/0x630
[   28.039046]  visual_init+0xce/0x130
[   28.039046]  do_bind_con_driver+0x1df/0x2d0
[   28.039046]  do_take_over_console+0x113/0x180
[   28.039046]  do_fbcon_takeover+0x58/0xb0
[   28.039046]  register_framebuffer+0x225/0x2f0
[   28.039046]  efifb_probe.cold.5+0x51a/0x55d
[   28.039046]  platform_drv_probe+0x38/0x90
[   28.039046]  really_probe+0x212/0x440
[   28.039046]  driver_probe_device+0x49/0xc0
[   28.039046]  device_driver_attach+0x50/0x60
[   28.039046]  __driver_attach+0x61/0x130
[   28.039046]  ? device_driver_attach+0x60/0x60
[   28.039046]  bus_for_each_dev+0x77/0xc0
[   28.039046]  ? klist_add_tail+0x57/0x70
[   28.039046]  bus_add_driver+0x14d/0x1e0
[   28.039046]  ? vesafb_driver_init+0x13/0x13
[   28.039046]  ? do_early_param+0x91/0x91
[   28.039046]  driver_register+0x6b/0xb0
[   28.039046]  ? vesafb_driver_init+0x13/0x13
[   28.039046]  do_one_initcall+0x46/0x1c3
[   28.039046]  ? do_early_param+0x91/0x91
[   28.039046]  kernel_init_freeable+0x1b4/0x25d
[   28.039046]  ? rest_init+0xaa/0xaa
[   28.039046]  kernel_init+0xa/0xfa
[   28.039046]  ret_from_fork+0x35/0x40

The root cause is that hyperv_fb driver will relocate the
framebuffer address in first kernel, but kexec_file_load simply reuse
the old framebuffer info from boot_params, which is now invalid, so
second kernel will write to an invalid framebuffer address.

This series fix this problem by:

1. Let kexec_file_load use the updated copy of screen_info.

  Instead of using boot_params.screen_info, use the globally available
  screen_info variable instead (which is just an copy of
  boot_params.screen_info on x86). This variable could be updated
  by arch indenpendent drivers. Just keep this variable updated should
  be a good way to keep screen_info consistent across kexec.

2. Let hyperv_fb clean the screen_info copy when the boot framebuffer
  is relocated outside the old framebuffer.

  After the relocation, the framebuffer is no longer a VGA
  framebuffer, so just clean it up should be good.

Kairui Song (2):
  x86/kexec: Use up-to-dated screen_info copy to fill boot params
  hyperv_fb: Update screen_info after removing old framebuffer

 arch/x86/kernel/kexec-bzimage64.c | 3 +--
 drivers/video/fbdev/hyperv_fb.c   | 8 ++++++++
 2 files changed, 9 insertions(+), 2 deletions(-)

-- 
2.28.0

