Return-Path: <linux-hyperv+bounces-3883-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8819A2F8BA
	for <lists+linux-hyperv@lfdr.de>; Mon, 10 Feb 2025 20:35:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 187DA164459
	for <lists+linux-hyperv@lfdr.de>; Mon, 10 Feb 2025 19:35:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25AEA1A23A0;
	Mon, 10 Feb 2025 19:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JhOQrgIG"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAFDE25E46C;
	Mon, 10 Feb 2025 19:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739216102; cv=none; b=BXeXBxGzNxN8E5zFpNvQ5apT5z/if5hp6IoGparxkbaomtmBb6DUjLxX9qBJ+T5iGD34AR6Buve0D1hGwb9NTO9L2iOJwk3kQO9Rpskp5bD/hqsh4HhVq9ryFFc2qr50zY+W/Reac1iycJ0SerLgw3AlC9UthibVtCt2XmOBU14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739216102; c=relaxed/simple;
	bh=0OkXUw/seG2tFw7D0y45hZbQEAIgio2zeZ4kJqCRqBM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=liiim5aDpl3BeAMVmgOHOUqQHrNJbkhNPhnUEo8r9b5vDXuhFKllG8t8CRvHa7NZa7CIkZjBSsFjisikQTLFhFsDLG7UiyDMrE2mCW173ZX10EqxR5wlxbhqcKeTkV9uUfWjWNJ9ZcQYjJv+5hSP7K2ko8wedNZ5MDuqVnXuUaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JhOQrgIG; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-21f78b1fb7dso29935035ad.3;
        Mon, 10 Feb 2025 11:35:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739216100; x=1739820900; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LEnFc6ySppJhn5eOPH+ZbgqsgIN276Lx4jIjozuMzPM=;
        b=JhOQrgIGuY57Tqv0jMq3PL966fkX69Z++zisLvtG/+fVMHsSK1cgNTYTchEQ3txPJH
         v76Npcen7va7eY5zxQYZnJXlk6a+h57AZjxI/QMMw9DEQsNGvNe9pJzwhm1IknbiEvtE
         W8GOa9PugBFk6/sVMy7JO+nFC+VT0W3b7/U3gVBBBwqQxyuJ9xY/Yp1bPHwEja3ItDbf
         TLVb5DUH062MeClBt7zQ1/NkYl5owKFjfj5XpqgGrSJBODNpQClHz9o+GQWVDfd/pLOj
         LCwTKVOPeSw3H8uDGFD/Vkvb4URjEtA8SM1fpZ5FHs7VrVvVozOOHQLNWBdcJzp3HyT7
         esxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739216100; x=1739820900;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LEnFc6ySppJhn5eOPH+ZbgqsgIN276Lx4jIjozuMzPM=;
        b=qbESwTRhckVRetNi9/Z8JPdHbGe1EAm6Cs5K1vBog3D9mD6//RrMlh/4NyO99NpaSb
         5IX+8zCulvs4CfntB+Vl9PUNVqLEKcl5n+8PeZ9mlIIq469UrD1oqfsHwxTbQI/YkBGe
         tsb2NGjpYNNt923oIl9O8osXecT8lOeAOjRYFoiJmvtg9OzAsdmmF+zOITjBNXvQkipm
         EgjTPbR2Q3FE4Ay6+e/JJ4ckiuhWq+8vNJt3PMMCiXdv+peKsxHkXPwzqfTEBIigDzQH
         QCwy8vA8CFsfW/D3wAY7EmVfAdSYhWBGjgtkyyRiIP0zvtj4JF64cMpLdOqUX/iLtIA2
         mIbg==
X-Forwarded-Encrypted: i=1; AJvYcCWpcAtoeA+hiLeAhLUFUh8X4YrEz3BMUa1Jy6IKkrrGA6DmwQWrOvWWFOY/PV9PaTjCaUjZpoVyOu6q36XH@vger.kernel.org, AJvYcCXqYgvNCSRMWvp/rkUZsv66+qac/Q/oOD3oN9pWzrRc5+iy9MQflNVZWUWc7T+2usVY4nwDqVQUmKl7Acw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyDTZC2El8UwI/DfWGoTzcxRKedNlgJFACNV3WtDZ4E+K9qvLO
	h89QyAQ9YkwNqUbtHHLSPcqVUwvMtvlXTBUxSMWrDtkwMbr3H2WoXzBPQw==
X-Gm-Gg: ASbGnctlFFCG7ObHpuIQslXVLvj4OPeHbuluH4ae/PD4Rrp6VfpVItFhmnT1ZuYT+jt
	UWV9xDugvox+/nHastL9W8Sr2V37SEXsm0js/qBYt5Ecj3pB0VtgDiT/353gGUhWjfJudctU9tX
	IyJGcnVwIh450N1MsYuumMmEzXYSswJ4NojUMXdWgJZOGu7DQhtQpnnCS18i9n+WhOwkzGJY8Tw
	DOmV5JIRitpewnB9qA79WbDfl+Sua4+Wic9TUbu50ockhiZQj0/444lR7Rx096t1o9osy7NNQ3w
	4j7zIp3Y5qsZ/KdJBb5yVy79HWsaSBJqO/z5Y0iNJNMoS/H6Bjq01SLUS+ng4FOCGdZKcw==
X-Google-Smtp-Source: AGHT+IEK/KAQ9CEqjs9C9A769BPha4w2+cImXxGbjwGC2NSCBTkba7x81HpnqS4m8Nv71ZJ9+GbZiw==
X-Received: by 2002:a17:902:da8d:b0:21f:6cd4:8c32 with SMTP id d9443c01a7336-21f6cd48cfbmr204130635ad.22.1739216099621;
        Mon, 10 Feb 2025 11:34:59 -0800 (PST)
Received: from localhost.localdomain (c-67-160-120-253.hsd1.wa.comcast.net. [67.160.120.253])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21f3650e6c0sm81345045ad.22.2025.02.10.11.34.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 11:34:59 -0800 (PST)
From: mhkelley58@gmail.com
X-Google-Original-From: mhklinux@outlook.com
To: drawat.floss@gmail.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch,
	christophe.jaillet@wanadoo.fr,
	ssengar@linux.microsoft.com,
	wei.liu@kernel.org
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	linux-hyperv@vger.kernel.org
Subject: [PATCH 1/1] drm/hyperv: Fix address space leak when Hyper-V DRM device is removed
Date: Mon, 10 Feb 2025 11:34:41 -0800
Message-Id: <20250210193441.2414-1-mhklinux@outlook.com>
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

When a Hyper-V DRM device is probed, the driver allocates MMIO space for
the vram, and maps it cacheable. If the device removed, or in the error
path for device probing, the MMIO space is released but no unmap is done.
Consequently the kernel address space for the mapping is leaked.

Fix this by adding iounmap() calls in the device removal path, and in the
error path during device probing.

Fixes: f1f63cbb705d ("drm/hyperv: Fix an error handling path in hyperv_vmbus_probe()")
Fixes: a0ab5abced55 ("drm/hyperv : Removing the restruction of VRAM allocation with PCI bar size")
Signed-off-by: Michael Kelley <mhklinux@outlook.com>
---
 drivers/gpu/drm/hyperv/hyperv_drm_drv.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/hyperv/hyperv_drm_drv.c b/drivers/gpu/drm/hyperv/hyperv_drm_drv.c
index e0953777a206..b491827941f1 100644
--- a/drivers/gpu/drm/hyperv/hyperv_drm_drv.c
+++ b/drivers/gpu/drm/hyperv/hyperv_drm_drv.c
@@ -156,6 +156,7 @@ static int hyperv_vmbus_probe(struct hv_device *hdev,
 	return 0;
 
 err_free_mmio:
+	iounmap(hv->vram);
 	vmbus_free_mmio(hv->mem->start, hv->fb_size);
 err_vmbus_close:
 	vmbus_close(hdev->channel);
@@ -174,6 +175,7 @@ static void hyperv_vmbus_remove(struct hv_device *hdev)
 	vmbus_close(hdev->channel);
 	hv_set_drvdata(hdev, NULL);
 
+	iounmap(hv->vram);
 	vmbus_free_mmio(hv->mem->start, hv->fb_size);
 }
 
-- 
2.25.1


