Return-Path: <linux-hyperv+bounces-8090-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C7D4CCE843D
	for <lists+linux-hyperv@lfdr.de>; Mon, 29 Dec 2025 23:04:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9A2EF300452D
	for <lists+linux-hyperv@lfdr.de>; Mon, 29 Dec 2025 22:04:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F9DB33122F;
	Mon, 29 Dec 2025 22:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="aDpGp5/d"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pf1-f226.google.com (mail-pf1-f226.google.com [209.85.210.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EAC933122D
	for <linux-hyperv@vger.kernel.org>; Mon, 29 Dec 2025 22:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767045864; cv=none; b=VC+1nWmxiMXT1istN8DmN9oq0zwxW1RnMHAk1iUX6oJWye8j4VUBDnCMZgxjA61DTeub6dVRE9MCHKfzTpGgawghDpiXRywOlCasA/nPcyjkgSTdfipFlpeJYFAFCd2Tnp+lerw3pLeBlYiZnom7T2tou1Mz3wqzIgTQ/WdSjpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767045864; c=relaxed/simple;
	bh=y5YIqKVzOgea1hEskvVJXNFijZ0oP6nkRby64GmSm8c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=XOE27Xl5QNjQp3ltM1RIAhlCaQ+8cO8MzHwFtxtX9eXWnDbZWK3imNKvAMMa7PiMLH9yPNXTU9FiNTlQlyRXbwgh4i3yalfE30ao3SdpnjlVeLjPk4gW7TNY5aB3OOkzwqZITKogQ34M4XGa2lFDldLBm8r/MGkmQUyc4+GPMx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=aDpGp5/d; arc=none smtp.client-ip=209.85.210.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f226.google.com with SMTP id d2e1a72fcca58-8035e31d834so6882499b3a.2
        for <linux-hyperv@vger.kernel.org>; Mon, 29 Dec 2025 14:04:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767045860; x=1767650660;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UwzcNp2HYOV4Z1mSXVXCsNd5TObEfxUddJJZvW7JJZk=;
        b=v+EYhYTnCQMUkS6Glyv6HlaS3Z676MdrUDR7+7IKlNT7nqdIWlARV/m+bbjv54lvU+
         nXKljYKNOyQjWepRiIHJ9khwa0qLQl31v8YzXMwm/+7SfMhYgqTZRPiv86Uh/XhAzuVB
         sxb/R7N+UAvVvFyV2fN/P7cvN9IM1Gxnys5BpeQ1jdxc8KagUFHyZkTPPJJhhpAd/QFw
         NTV7caV6oD+RVVSNJVFdYmKkJmURCVxgrj7fIpXHfjSxPpPQ9WLfzPEfrA7niF3qoBDQ
         bF0whkaq0uOIPof9yk2UH6q2VYPq11VDqOmZKN7/ZjJpDO6R1qq+mwoAnW6PTU3C/IKJ
         9kUQ==
X-Forwarded-Encrypted: i=1; AJvYcCVOnDFJihSIh4TKk48pExbYIPJvXB5DmET3wiPAOSKN0/BdoCBFQgIZnfxGpwlbcQPEpaAwMg8+WZJNiEQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYMXj7Bf2ZsAUJqOT5cIDWMdr0Luv/tMhy+U6uTVWdvF72rlvD
	/1UqsSPbewUmXB+s5QE5Crc1Yipslf6R4zAg5ubP4becH7CkwEA7XnBjW4ByAywIKx8PfmTTgBY
	8pF8sqAv6tOA7HJUUCFDzGRYj0rJbd+jh/SsDIkqUkhuvdE/o9XX55aphP5oWxZYgt7eOcq2O72
	mFfK1Hv3VW3dFc8qQ24QKdhgAxTV+hV7VLGJH1HyS3wWpTIUroR7/0g1FRnMjCHOrEMzdjY9Ja3
	X9pCuMHT8Qd5gmh
X-Gm-Gg: AY/fxX6dkWGNvte5f8eqpne1/i41e+UwU0C8qMsY/9FsN3HJ2FOg3zS9uZotC4412CO
	uF4ADZVjEbF2d2TUNmt5++LPj0F/He6Yx8bErJe6JGP1jwrWcLJRjKn5eqGuSR9lexAMCU8kRlh
	GlR/DjXgGzJ9mVjPj9FIcMV+nl4HJ75I+OE/dq9WSzYZH+TMJJ9zocs2+7OwJTJfWyXN/QVUMP1
	osLgZ29r6QKv8JCypKduorlxCIxpxsH8bqVecK+BSuFHLlX+SSoxGqy7GPTOCiZGrKEhdWWbgV5
	zQ1wyf1AIRD5dyP4F8wkAmKcvIPPphg1k6s+U7otYg60No97WT3TkY1tc4VShICD+4uCUJc5x4X
	6YT9dHsGQ/a6QM7BF7rp8uHoXMrPWYnQHk54fbZLrj5E693gaVaDk0cnaQVUSk6s4k5tRqlEtOv
	keBg42YcCF1oVQhcFXkSWVEC1Epr7+4YxU8PNVRw18r7p6
X-Google-Smtp-Source: AGHT+IENEj/p36+YPT8arFbuRReo5crOGd0NZyWNQJJN8VzT6O9LbXk3NPsOcda6DFE8QDLzAp1KsSpKwKmz
X-Received: by 2002:a05:7022:2520:b0:11d:c04a:dc5b with SMTP id a92af1059eb24-121722e03camr28482112c88.30.1767045859854;
        Mon, 29 Dec 2025 14:04:19 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-101.dlp.protect.broadcom.com. [144.49.247.101])
        by smtp-relay.gmail.com with ESMTPS id a92af1059eb24-12172537b5dsm6000907c88.5.2025.12.29.14.04.19
        for <linux-hyperv@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Dec 2025 14:04:19 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-88233d526baso291706626d6.1
        for <linux-hyperv@vger.kernel.org>; Mon, 29 Dec 2025 14:04:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1767045858; x=1767650658; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UwzcNp2HYOV4Z1mSXVXCsNd5TObEfxUddJJZvW7JJZk=;
        b=aDpGp5/dS9WEN9245HFgYzBA4lga59qJl0blBT0UnfufzCNnb1qtacHWHwKnrQzq9f
         N6vkZQfpSpEc5h3NbVHx4mwxckPtc7EfhxF2AofsapzWRv3yu5TOi5YjHqqLvnXSjMqp
         duLtEMex1k+rFZPB5IQ9uSH08GXjBvJWvuNOI=
X-Forwarded-Encrypted: i=1; AJvYcCW/i61LswjBysPKuJkgoleeJAHeXGFf3XLWYeQQazrdi8qmWp4IK9Ezq9eliWfvZXD4lMbelJhx//zmMGk=@vger.kernel.org
X-Received: by 2002:a05:6214:428e:b0:88a:3681:1d96 with SMTP id 6a1803df08f44-88d881b984fmr478635896d6.63.1767045551431;
        Mon, 29 Dec 2025 13:59:11 -0800 (PST)
X-Received: by 2002:a05:6214:428e:b0:88a:3681:1d96 with SMTP id 6a1803df08f44-88d881b984fmr478635666d6.63.1767045550918;
        Mon, 29 Dec 2025 13:59:10 -0800 (PST)
Received: from localhost.localdomain (pool-173-49-113-140.phlapa.fios.verizon.net. [173.49.113.140])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-88d9759f164sm231530026d6.24.2025.12.29.13.59.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Dec 2025 13:59:10 -0800 (PST)
From: Zack Rusin <zack.rusin@broadcom.com>
To: dri-devel@lists.freedesktop.org
Cc: Alex Deucher <alexander.deucher@amd.com>,
	amd-gfx@lists.freedesktop.org,
	Ard Biesheuvel <ardb@kernel.org>,
	Ce Sun <cesun102@amd.com>,
	Chia-I Wu <olvaffe@gmail.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Danilo Krummrich <dakr@kernel.org>,
	Dave Airlie <airlied@redhat.com>,
	Deepak Rawat <drawat.floss@gmail.com>,
	Dmitry Osipenko <dmitry.osipenko@collabora.com>,
	Gerd Hoffmann <kraxel@redhat.com>,
	Gurchetan Singh <gurchetansingh@chromium.org>,
	Hans de Goede <hansg@kernel.org>,
	Hawking Zhang <Hawking.Zhang@amd.com>,
	Helge Deller <deller@gmx.de>,
	intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Javier Martinez Canillas <javierm@redhat.com>,
	Jocelyn Falempe <jfalempe@redhat.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Lijo Lazar <lijo.lazar@amd.com>,
	linux-efi@vger.kernel.org,
	linux-fbdev@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lucas De Marchi <lucas.demarchi@intel.com>,
	Lyude Paul <lyude@redhat.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	"Mario Limonciello (AMD)" <superm1@kernel.org>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Maxime Ripard <mripard@kernel.org>,
	nouveau@lists.freedesktop.org,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Simona Vetter <simona@ffwll.ch>,
	spice-devel@lists.freedesktop.org,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	=?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	virtualization@lists.linux.dev,
	Vitaly Prosyak <vitaly.prosyak@amd.com>
Subject: [PATCH 00/12] Recover sysfb after DRM probe failure
Date: Mon, 29 Dec 2025 16:58:06 -0500
Message-ID: <20251229215906.3688205-1-zack.rusin@broadcom.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

Almost a rite of passage for every DRM developer and most Linux users
is upgrading your DRM driver/updating boot flags/changing some config
and having DRM driver fail at probe resulting in a blank screen.

Currently there's no way to recover from DRM driver probe failure. PCI
DRM driver explicitly throw out the existing sysfb to get exclusive
access to PCI resources so if the probe fails the system is left without
a functioning display driver.

Add code to sysfb to recever system framebuffer when DRM driver's probe
fails. This means that a DRM driver that fails to load reloads the system
framebuffer driver.

This works best with simpledrm. Without it Xorg won't recover because
it still tries to load the vendor specific driver which ends up usually
not working at all. With simpledrm the system recovers really nicely
ending up with a working console and not a blank screen.

There's a caveat in that some hardware might require some special magic
register write to recover EFI display. I'd appreciate it a lot if
maintainers could introduce a temporary failure in their drivers
probe to validate that the sysfb recovers and they get a working console.
The easiest way to double check it is by adding:
 /* XXX: Temporary failure to test sysfb restore - REMOVE BEFORE COMMIT */
 dev_info(&pdev->dev, "Testing sysfb restore: forcing probe failure\n");
 ret = -EINVAL;
 goto out_error;
or such right after the devm_aperture_remove_conflicting_pci_devices .

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: Ce Sun <cesun102@amd.com>
Cc: Chia-I Wu <olvaffe@gmail.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: Danilo Krummrich <dakr@kernel.org>
Cc: Dave Airlie <airlied@redhat.com>
Cc: Deepak Rawat <drawat.floss@gmail.com>
Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc: dri-devel@lists.freedesktop.org
Cc: Gerd Hoffmann <kraxel@redhat.com>
Cc: Gurchetan Singh <gurchetansingh@chromium.org>
Cc: Hans de Goede <hansg@kernel.org>
Cc: Hawking Zhang <Hawking.Zhang@amd.com>
Cc: Helge Deller <deller@gmx.de>
Cc: intel-gfx@lists.freedesktop.org
Cc: intel-xe@lists.freedesktop.org
Cc: Jani Nikula <jani.nikula@linux.intel.com>
Cc: Javier Martinez Canillas <javierm@redhat.com>
Cc: Jocelyn Falempe <jfalempe@redhat.com>
Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Cc: Lijo Lazar <lijo.lazar@amd.com>
Cc: linux-efi@vger.kernel.org
Cc: linux-fbdev@vger.kernel.org
Cc: linux-hyperv@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: Lucas De Marchi <lucas.demarchi@intel.com>
Cc: Lyude Paul <lyude@redhat.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: "Mario Limonciello (AMD)" <superm1@kernel.org>
Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Maxime Ripard <mripard@kernel.org>
Cc: nouveau@lists.freedesktop.org
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: Simona Vetter <simona@ffwll.ch>
Cc: spice-devel@lists.freedesktop.org
Cc: "Thomas Hellström" <thomas.hellstrom@linux.intel.com>
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: "Timur Kristóf" <timur.kristof@gmail.com>
Cc: Tvrtko Ursulin <tursulin@ursulin.net>
Cc: virtualization@lists.linux.dev
Cc: Vitaly Prosyak <vitaly.prosyak@amd.com>

Zack Rusin (12):
  video/aperture: Add sysfb restore on DRM probe failure
  drm/vmwgfx: Use devm aperture helpers for sysfb restore on probe
    failure
  drm/xe: Use devm aperture helpers for sysfb restore on probe failure
  drm/amdgpu: Use devm aperture helpers for sysfb restore on probe
    failure
  drm/virtio: Add sysfb restore on probe failure
  drm/nouveau: Use devm aperture helpers for sysfb restore on probe
    failure
  drm/qxl: Use devm aperture helpers for sysfb restore on probe failure
  drm/vboxvideo: Use devm aperture helpers for sysfb restore on probe
    failure
  drm/hyperv: Add sysfb restore on probe failure
  drm/ast: Use devm aperture helpers for sysfb restore on probe failure
  drm/radeon: Use devm aperture helpers for sysfb restore on probe
    failure
  drm/i915: Use devm aperture helpers for sysfb restore on probe failure

 drivers/firmware/efi/sysfb_efi.c           |   2 +-
 drivers/firmware/sysfb.c                   | 191 +++++++++++++--------
 drivers/firmware/sysfb_simplefb.c          |  10 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |   9 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    |   7 +
 drivers/gpu/drm/ast/ast_drv.c              |  13 +-
 drivers/gpu/drm/hyperv/hyperv_drm_drv.c    |  23 +++
 drivers/gpu/drm/i915/i915_driver.c         |  13 +-
 drivers/gpu/drm/nouveau/nouveau_drm.c      |  16 +-
 drivers/gpu/drm/qxl/qxl_drv.c              |  14 +-
 drivers/gpu/drm/radeon/radeon_drv.c        |  15 +-
 drivers/gpu/drm/vboxvideo/vbox_drv.c       |  13 +-
 drivers/gpu/drm/virtio/virtgpu_drv.c       |  29 ++++
 drivers/gpu/drm/vmwgfx/vmwgfx_drv.c        |  13 +-
 drivers/gpu/drm/xe/xe_device.c             |   7 +-
 drivers/gpu/drm/xe/xe_pci.c                |   7 +
 drivers/video/aperture.c                   |  54 ++++++
 include/linux/aperture.h                   |  14 ++
 include/linux/sysfb.h                      |   6 +
 19 files changed, 368 insertions(+), 88 deletions(-)

-- 
2.48.1


