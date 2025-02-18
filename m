Return-Path: <linux-hyperv+bounces-3965-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B42A0A3AC49
	for <lists+linux-hyperv@lfdr.de>; Wed, 19 Feb 2025 00:01:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 913F31891B40
	for <lists+linux-hyperv@lfdr.de>; Tue, 18 Feb 2025 23:01:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5208818C933;
	Tue, 18 Feb 2025 23:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cG8Wd8xX"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EA1628629C;
	Tue, 18 Feb 2025 23:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739919700; cv=none; b=fJ0oolwyhFTpdBTgvOo/3x/UelwYay1xqpIkOTQLvMJYmSxqCzHXi8h295uwD7VR8fZSjmlxmWCANqAgI77Ggg/HfVIveYEavayKJ509KikgVIL2G4lLqz7f8usO0VgZ63JyCAGFWCqWu3zjTnTA5DSf4bUuLUxIJDxpEJR6RtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739919700; c=relaxed/simple;
	bh=kYm/TECOAFLLe+/4q7oqkkzVttxOa/hK1AFu4MroBXk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Ct1cphjmHPd+3Y0OrFfNYUcSvmsm6YxfoJY2xopHM7JoXrtF6PjPY6Mv98WxcDW111hxKX62P4PKEHEY2JoHJml5E0PJkkKoaAtEIH62UWgbgWQ5T7ld1fVGmSZe0Rrc/trIdjyT0qRbO7dfuF7Hd8l6LFDHaYhbhDvX0BijevY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cG8Wd8xX; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-220ca204d04so83541945ad.0;
        Tue, 18 Feb 2025 15:01:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739919698; x=1740524498; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Rgkklgzg+KC89vfZ7sk39jLYW+8YEoMcWjrCaBYDcUw=;
        b=cG8Wd8xXaUHnHD4EyhAVGCwbWsrBNCfpwbACvN1wNlAzUKCZ8AhtbfGlPPjiHwmNAQ
         xpx32FRpjkoR12haA66T/peLPKNK5QJ7u+sJHZD2oP+lOq/c2XHLzrNeOKiAiLqhYO9Z
         nm87yU1MztNYhT63t4ObGtVztQ5bOy8qK9M5jemmgMUmxsDgijuYCJCifWsrPA/Rws67
         ej4aYjCTLSv+1WRp/ij+1uKt2cXe7XNtGIaxnIq3nxV/4ShRFL52Lozkr8KHOVL6Lhpz
         I55OxPJ9nL+BgT1Bl6JO0pdvqPZtZK/lz0YFjbbHbmykNR6sCoqLZfZdqVZlkkHnWDn7
         mjMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739919698; x=1740524498;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rgkklgzg+KC89vfZ7sk39jLYW+8YEoMcWjrCaBYDcUw=;
        b=LW6Hhwbv2FAvE/xtCAEfKBPaP0rK86HjXZHuXXnbH87tKOX8ijynd7sqZ+Awjoo62w
         mp7TvsWToKumtsCDnltG6Bz63644V4qU6bFcBS8FmDU+uUlmaacoYIrgKExiesSHKUgG
         V1CJZETRbrRKvl8XuL6pX7Z/3TmkKFPCNsw2rXk2CNoE7fGF/gHcKiIV5ZsXE5mWGmrc
         hncdV+s2gYIj+rP0pBarU+ejo6EqP/fwroyokXsbATBQhSC1W0TN7Bl8bZdIIuMmqFk+
         u8uSahVE4Gs5e89lL7r+5HChH6ms85qunF9MH2GKsRGm8MtGR142P4BnzPEktt5GVvV2
         9piA==
X-Forwarded-Encrypted: i=1; AJvYcCUADlJ25fqnAPB2E3aPThYkYo8xRp5ac6Vu0t2frDgre39wKDU4zMph/9CufDsqc2ShXZpCmvSKR9VkTPgs@vger.kernel.org, AJvYcCVJOleRA9lKEzcSVcuR4Jaus1+MmtkoAhfEc2B/drYOWdih85OyfWAhQFVwt9Dq/UWvuVnxmBS6wgA0xg==@vger.kernel.org, AJvYcCVp1vymItA/1jnEOpCMJ0nup5c+XLduCmFGPhNbCBLJCPNkSwI5R+AMxBc6ezX8XL0tGZKYcvaEna5MOswa@vger.kernel.org
X-Gm-Message-State: AOJu0Ywvo5xfVAakZaPMfj/pv3fA2gmWjJ59SgOhiNPaiB44GoCKdFuD
	OY8CRy0hXYBaObwpDToU9/gYl9Y1pSq/ytuBhqWcqutyP+yrOEIV
X-Gm-Gg: ASbGnctDDZAksmYgxeQswJ0s2rcks0a6J2LnnfQIkcwWkoO/lPw2AtPQbBuARsVaA4f
	/4HX+g8Xa/Q/Ebxuvk40c4V2Lhw3vrAxouo7bYMfeFEUngPn/x1Vppn9YA+KiwOZ00vHA2/q3NJ
	Ml+KHargd90MS7zayrFMIHpxnnkvEdw7m1vFlO89W69nzb7Iq3/4dF6gr2IOFE+Bq2GtET+Qrtv
	+mL57bFkR4be2adL6Cq2zB5jjTBSPAaIPUWs/R+WaTILIeBZA45iQvnPiEAjANZDlBXnUNIgOj/
	eoHQ7ngCYc1+AhleeyCUNzZAkG5QiaDbE/cJdyfNFeE2kMWWE507UEssHZIPihNWj5AZ
X-Google-Smtp-Source: AGHT+IEPS7VYLlllIEiqS7YMOU6jOcQEdPxDfRkeVHwuIMaMZhr6hscMXiB84+csU1GyapYRQGW9kg==
X-Received: by 2002:a05:6a00:148c:b0:728:9d19:d2ea with SMTP id d2e1a72fcca58-7329de81202mr1616355b3a.13.1739919697683;
        Tue, 18 Feb 2025 15:01:37 -0800 (PST)
Received: from localhost.localdomain (syn-076-173-166-017.res.spectrum.com. [76.173.166.17])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73265678abasm6906047b3a.27.2025.02.18.15.01.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 15:01:37 -0800 (PST)
From: mhkelley58@gmail.com
X-Google-Original-From: mhklinux@outlook.com
To: haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	deller@gmx.de,
	javierm@redhat.com,
	thomas.tai@oracle.com
Cc: tzimmermann@suse.de,
	kasong@redhat.com,
	dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hyperv@vger.kernel.org
Subject: [PATCH 1/1] fbdev: hyperv_fb: Fix hang in kdump kernel when on Hyper-V Gen 2 VMs
Date: Tue, 18 Feb 2025 15:01:30 -0800
Message-Id: <20250218230130.3207-1-mhklinux@outlook.com>
X-Mailer: git-send-email 2.25.1
Reply-To: mhklinux@outlook.com
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Michael Kelley <mhklinux@outlook.com>

Gen 2 Hyper-V VMs boot via EFI and have a standard EFI framebuffer
device. When the kdump kernel runs in such a VM, loading the efifb
driver may hang because of accessing the framebuffer at the wrong
memory address.

The scenario occurs when the hyperv_fb driver in the original kernel
moves the framebuffer to a different MMIO address because of conflicts
with an already-running efifb or simplefb driver. The hyperv_fb driver
then informs Hyper-V of the change, which is allowed by the Hyper-V FB
VMBus device protocol. However, when the kexec command loads the kdump
kernel into crash memory via the kexec_file_load() system call, the
system call doesn't know the framebuffer has moved, and it sets up the
kdump screen_info using the original framebuffer address. The transition
to the kdump kernel does not go through the Hyper-V host, so Hyper-V
does not reset the framebuffer address like it would do on a reboot.
When efifb tries to run, it accesses a non-existent framebuffer
address, which traps to the Hyper-V host. After many such accesses,
the Hyper-V host thinks the guest is being malicious, and throttles
the guest to the point that it runs very slowly or appears to have hung.

When the kdump kernel is loaded into crash memory via the kexec_load()
system call, the problem does not occur. In this case, the kexec command
builds the screen_info table itself in user space from data returned
by the FBIOGET_FSCREENINFO ioctl against /dev/fb0, which gives it the
new framebuffer location.

This problem was originally reported in 2020 [1], resulting in commit
3cb73bc3fa2a ("hyperv_fb: Update screen_info after removing old
framebuffer"). This commit solved the problem by setting orig_video_isVGA
to 0, so the kdump kernel was unaware of the EFI framebuffer. The efifb
driver did not try to load, and no hang occurred. But in 2024, commit
c25a19afb81c ("fbdev/hyperv_fb: Do not clear global screen_info")
effectively reverted 3cb73bc3fa2a. Commit c25a19afb81c has no reference
to 3cb73bc3fa2a, so perhaps it was done without knowing the implications
that were reported with 3cb73bc3fa2a. In any case, as of commit
c25a19afb81c, the original problem came back again.

Interestingly, the hyperv_drm driver does not have this problem because
it never moves the framebuffer. The difference is that the hyperv_drm
driver removes any conflicting framebuffers *before* allocating an MMIO
address, while the hyperv_fb drivers removes conflicting framebuffers
*after* allocating an MMIO address. With the "after" ordering, hyperv_fb
may encounter a conflict and move the framebuffer to a different MMIO
address. But the conflict is essentially bogus because it is removed
a few lines of code later.

Rather than fix the problem with the approach from 2020 in commit
3cb73bc3fa2a, instead slightly reorder the steps in hyperv_fb so
conflicting framebuffers are removed before allocating an MMIO address.
Then the default framebuffer MMIO address should always be available, and
there's never any confusion about which framebuffer address the kdump
kernel should use -- it's always the original address provided by
the Hyper-V host. This approach is already used by the hyperv_drm
driver, and is consistent with the usage guidelines at the head of
the module with the function aperture_remove_conflicting_devices().

This approach also solves a related minor problem when kexec_load()
is used to load the kdump kernel. With current code, unbinding and
rebinding the hyperv_fb driver could result in the framebuffer moving
back to the default framebuffer address, because on the rebind there
are no conflicts. If such a move is done after the kdump kernel is
loaded with the new framebuffer address, at kdump time it could again
have the wrong address.

This problem and fix are described in terms of the kdump kernel, but
it can also occur with any kernel started via kexec.

See extensive discussion of the problem and solution at [2].

[1] https://lore.kernel.org/linux-hyperv/20201014092429.1415040-1-kasong@redhat.com/
[2] https://lore.kernel.org/linux-hyperv/BLAPR10MB521793485093FDB448F7B2E5FDE92@BLAPR10MB5217.namprd10.prod.outlook.com/

Reported-by: Thomas Tai <thomas.tai@oracle.com>
Fixes: c25a19afb81c ("fbdev/hyperv_fb: Do not clear global screen_info")
Signed-off-by: Michael Kelley <mhklinux@outlook.com>
---
The "Fixes" tag uses commit c25a19afb81c because that's where the problem
was re-exposed, and how far back a stable backport is needed. But I've
taken a completely different, and hopefully better, approach in the
solution that isn't related to the code changes in c25a19afb81c.

 drivers/video/fbdev/hyperv_fb.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/drivers/video/fbdev/hyperv_fb.c b/drivers/video/fbdev/hyperv_fb.c
index 363e4ccfcdb7..ce23d0ef5702 100644
--- a/drivers/video/fbdev/hyperv_fb.c
+++ b/drivers/video/fbdev/hyperv_fb.c
@@ -989,6 +989,7 @@ static int hvfb_getmem(struct hv_device *hdev, struct fb_info *info)
 
 		base = pci_resource_start(pdev, 0);
 		size = pci_resource_len(pdev, 0);
+		aperture_remove_conflicting_devices(base, size, KBUILD_MODNAME);
 
 		/*
 		 * For Gen 1 VM, we can directly use the contiguous memory
@@ -1010,11 +1011,21 @@ static int hvfb_getmem(struct hv_device *hdev, struct fb_info *info)
 			goto getmem_done;
 		}
 		pr_info("Unable to allocate enough contiguous physical memory on Gen 1 VM. Using MMIO instead.\n");
+	} else {
+		aperture_remove_all_conflicting_devices(KBUILD_MODNAME);
 	}
 
 	/*
-	 * Cannot use the contiguous physical memory.
-	 * Allocate mmio space for framebuffer.
+	 * Cannot use contiguous physical memory, so allocate MMIO space for
+	 * the framebuffer. At this point in the function, conflicting devices
+	 * that might have claimed the framebuffer MMIO space based on
+	 * screen_info.lfb_base must have already been removed so that
+	 * vmbus_allocate_mmio() does not allocate different MMIO space. If the
+	 * kdump image were to be loaded using kexec_file_load(), the
+	 * framebuffer location in the kdump image would be set from
+	 * screen_info.lfb_base at the time that kdump is enabled. If the
+	 * framebuffer has moved elsewhere, this could be the wrong location,
+	 * causing kdump to hang when efifb (for example) loads.
 	 */
 	dio_fb_size =
 		screen_width * screen_height * screen_depth / 8;
@@ -1051,11 +1062,6 @@ static int hvfb_getmem(struct hv_device *hdev, struct fb_info *info)
 	info->screen_size = dio_fb_size;
 
 getmem_done:
-	if (base && size)
-		aperture_remove_conflicting_devices(base, size, KBUILD_MODNAME);
-	else
-		aperture_remove_all_conflicting_devices(KBUILD_MODNAME);
-
 	if (!gen2vm)
 		pci_dev_put(pdev);
 
-- 
2.25.1


