Return-Path: <linux-hyperv+bounces-4775-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A7F5A78A42
	for <lists+linux-hyperv@lfdr.de>; Wed,  2 Apr 2025 10:44:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CEC6316BA35
	for <lists+linux-hyperv@lfdr.de>; Wed,  2 Apr 2025 08:44:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C831223496B;
	Wed,  2 Apr 2025 08:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EbdWH4Oo"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0FDD2356B8
	for <linux-hyperv@vger.kernel.org>; Wed,  2 Apr 2025 08:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743583465; cv=none; b=Nbmo149tdINk0TlNjUpoosibwfIO9cB4faMwLKp4YXO3DCDtRZFR0z5FEyI4061ajxJQPXJX9QA6wDh45RlqACGQ8XBrzvuojBVwupbc6+xKcFPf358ONgbSMj4t+hh7eHS4od1DZnE8nQcNh5L1kbvKGZiKE3UUDP3bCLcIosM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743583465; c=relaxed/simple;
	bh=mlykfrFdz84+U2IDELk3Xr0EjvW0zNxL4agbG114krw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=haOnz03b8dwXQBbYm0qfCbIFcO8X9kSRHSNTfm2Vgrs2FD3nm3yln/4iemUKUwZnUJuIBVkrkefbpuT3koCww4MJq0wxxzyPGdwGMBjpCjc/IyETtwJ6eVWWo85r+TLxECzmln7N/SDISu1f2rZrM9N3HXSDBGkqjkUuEE1NBuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EbdWH4Oo; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743583462;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=H5aT4E8IjAz62HrMcPYGYOBE62zNkPJUyzC7qjAbwrQ=;
	b=EbdWH4Oo+j3/8ejAxCosveCLwHvar6tFL12FL4TUWIHnyCCaOEU5q8inDb2Y0Bpg6/j7g5
	rvN+Tl7iez2ccrel8PQ0mPlS0JaO0byz0xuABQRPO6FWLNQJJuOMx5Udf5bJAV+hO5tsJ2
	sMDn4c+k5cJ5GEiXqKK4vYQBYsX4h2g=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-694-SLNi765xMoCKd5GhP3JZFw-1; Wed, 02 Apr 2025 04:44:21 -0400
X-MC-Unique: SLNi765xMoCKd5GhP3JZFw-1
X-Mimecast-MFC-AGG-ID: SLNi765xMoCKd5GhP3JZFw_1743583460
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2240a96112fso204703415ad.2
        for <linux-hyperv@vger.kernel.org>; Wed, 02 Apr 2025 01:44:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743583460; x=1744188260;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H5aT4E8IjAz62HrMcPYGYOBE62zNkPJUyzC7qjAbwrQ=;
        b=u2pcDk0eJySJGopLysS/FmJvU/MWQl2XWQshhm/hriL7cpBjEILQWEI+o9K+tOH5z4
         g7pcXSvNoRmc2XvVDUXT9sgXWpaLU9zlwrOsfIit2PtT5u/ycEt4zcwnfa6HsBsukLiJ
         GZa5TLD5c6T9HU1y52OnXN+f1IgPRqgq56lzU3fzRmgW5xOzwPjqlaSYXcXU2nW/VBbY
         ObLFEiZ6NGzbusf2FC2057F/qobu+dj9m4mhmT4AgWlFn6Ip6EV2FndBhOv6mEg7XmyL
         p0Er3wyDcfWypgR9fGztslFYszqbQzwaIwMMIUJ4zwDBw2u3mFQj3FPVKvZVCNTfJeuc
         t6Zg==
X-Forwarded-Encrypted: i=1; AJvYcCVAEzJ8WoeIMQyLNY949axm5o/qv/myyvXLwu0TnFQFFK5pohH5SNsfoSFb6q2H42C+GZBoDZZeb9rEzJk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIs8BSxdtx5lXr1AAbcKURZsnETIFppYAcYuGK5wnoZjJb3uCQ
	cXsD3Se5/pemb9PW7ZtiKY0r611nYQ4PqTA0P2q7niGSAri68C/XHAPVGRtOUc+JHcbR4IliTqI
	CqZie/IFdoRXCVuRVNT/kBa2cuS3sC0tOt5rCi7pBAFb2+RvpXNxl7YDHKXtUgg==
X-Gm-Gg: ASbGncs5WobHqZSm6zQsafGgvAqtF3U7/Xbj7pXwckm4xmKdv4AI5AVrH3Bos9B9bmW
	7fIGJvXBGgfG3eDlS9clAIdPxun+S2/fqjWz2LC6NPLzd3cgnFwpwQph+9uJGmU9KzmVGQdd3U+
	qZKDPg1Y6l0KjsxEhY5Qb716PcjvueX2lj/z6IBER67Lg8F8FyMcTpaWCkJRh1qdn4C61ZTcmdo
	tM/VLnw1NqtcFPr3AQsf863zctA+7ocMbu4wVa8OJsrwlj5msPeVzkDTKTX+Y72curoemZRsr8U
	I+DODFvbzG7U65nQ
X-Received: by 2002:a17:902:f64f:b0:224:1ef:1e00 with SMTP id d9443c01a7336-2292f95d075mr263141305ad.19.1743583460399;
        Wed, 02 Apr 2025 01:44:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFdcCKlcH6Z7Lv0v5Z/IkIHKmjovi+4bC2OLW8bIyHLKp5/5tomDqn7sNkO1KXXa/YLokWsTA==
X-Received: by 2002:a17:902:f64f:b0:224:1ef:1e00 with SMTP id d9443c01a7336-2292f95d075mr263141085ad.19.1743583460084;
        Wed, 02 Apr 2025 01:44:20 -0700 (PDT)
Received: from zeus.elecom ([240b:10:83a2:bd00:6e35:f2f5:2e21:ae3a])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2291f1f7394sm102202645ad.225.2025.04.02.01.44.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Apr 2025 01:44:19 -0700 (PDT)
From: Ryosuke Yasuoka <ryasuoka@redhat.com>
To: maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch,
	drawat.floss@gmail.com,
	jfalempe@redhat.com
Cc: Ryosuke Yasuoka <ryasuoka@redhat.com>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	linux-hyperv@vger.kernel.org
Subject: [PATCH RFC drm-next 1/1] drm/hyperv: Add support for drm_panic
Date: Wed,  2 Apr 2025 17:43:49 +0900
Message-ID: <20250402084351.1545536-2-ryasuoka@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250402084351.1545536-1-ryasuoka@redhat.com>
References: <20250402084351.1545536-1-ryasuoka@redhat.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add drm_panic module supports for hyperv drm so that panic screen can be
displayed on panic.

Signed-off-by: Ryosuke Yasuoka <ryasuoka@redhat.com>
---
 drivers/gpu/drm/drm_simple_kms_helper.c     | 26 +++++++++++++
 drivers/gpu/drm/hyperv/hyperv_drm_modeset.c | 42 +++++++++++++++++++++
 include/drm/drm_simple_kms_helper.h         | 22 +++++++++++
 3 files changed, 90 insertions(+)

diff --git a/drivers/gpu/drm/drm_simple_kms_helper.c b/drivers/gpu/drm/drm_simple_kms_helper.c
index 250819fbc5ce..508a5961d2b0 100644
--- a/drivers/gpu/drm/drm_simple_kms_helper.c
+++ b/drivers/gpu/drm/drm_simple_kms_helper.c
@@ -14,6 +14,7 @@
 #include <drm/drm_managed.h>
 #include <drm/drm_probe_helper.h>
 #include <drm/drm_simple_kms_helper.h>
+#include <drm/drm_panic.h>
 
 /**
  * DOC: overview
@@ -316,6 +317,29 @@ static bool drm_simple_kms_format_mod_supported(struct drm_plane *plane,
 	return modifier == DRM_FORMAT_MOD_LINEAR;
 }
 
+static int drm_simple_kms_plane_get_scanout_buffer(struct drm_plane *plane,
+						   struct drm_scanout_buffer *sb)
+{
+	struct drm_simple_display_pipe *pipe;
+
+	pipe = container_of(plane, struct drm_simple_display_pipe, plane);
+	if (!pipe->funcs || !pipe->funcs->get_scanout_buffer)
+		return -EINVAL;
+
+	return pipe->funcs->get_scanout_buffer(pipe, sb);
+}
+
+static void drm_simple_kms_plane_panic_flush(struct drm_plane *plane)
+{
+	struct drm_simple_display_pipe *pipe;
+
+	pipe = container_of(plane, struct drm_simple_display_pipe, plane);
+	if (!pipe->funcs || !pipe->funcs->panic_flush)
+		return;
+
+	pipe->funcs->panic_flush(pipe);
+}
+
 static const struct drm_plane_helper_funcs drm_simple_kms_plane_helper_funcs = {
 	.prepare_fb = drm_simple_kms_plane_prepare_fb,
 	.cleanup_fb = drm_simple_kms_plane_cleanup_fb,
@@ -323,6 +347,8 @@ static const struct drm_plane_helper_funcs drm_simple_kms_plane_helper_funcs = {
 	.end_fb_access = drm_simple_kms_plane_end_fb_access,
 	.atomic_check = drm_simple_kms_plane_atomic_check,
 	.atomic_update = drm_simple_kms_plane_atomic_update,
+	.get_scanout_buffer = drm_simple_kms_plane_get_scanout_buffer,
+	.panic_flush = drm_simple_kms_plane_panic_flush,
 };
 
 static void drm_simple_kms_plane_reset(struct drm_plane *plane)
diff --git a/drivers/gpu/drm/hyperv/hyperv_drm_modeset.c b/drivers/gpu/drm/hyperv/hyperv_drm_modeset.c
index 6c6b57298797..8e8eacb0d07f 100644
--- a/drivers/gpu/drm/hyperv/hyperv_drm_modeset.c
+++ b/drivers/gpu/drm/hyperv/hyperv_drm_modeset.c
@@ -16,6 +16,7 @@
 #include <drm/drm_gem_shmem_helper.h>
 #include <drm/drm_probe_helper.h>
 #include <drm/drm_simple_kms_helper.h>
+#include <drm/drm_panic.h>
 
 #include "hyperv_drm.h"
 
@@ -146,10 +147,51 @@ static void hyperv_pipe_update(struct drm_simple_display_pipe *pipe,
 	}
 }
 
+static int hyperv_pipe_get_scanout_buffer(struct drm_simple_display_pipe *pipe,
+					  struct drm_scanout_buffer *sb)
+{
+	struct drm_plane_state *state = pipe->plane.state;
+	struct hyperv_drm_device *hv;
+	struct drm_framebuffer *fb;
+
+	if (!state || !state->fb || !state->visible)
+		return -ENODEV;
+
+	fb = state->fb;
+	hv = to_hv(fb->dev);
+
+	iosys_map_set_vaddr_iomem(&sb->map[0], hv->vram);
+	sb->format = fb->format;
+	sb->height = fb->height;
+	sb->width = fb->width;
+	sb->pitch[0] = fb->pitches[0];
+	return 0;
+}
+
+static void hyperv_pipe_panic_flush(struct drm_simple_display_pipe *pipe)
+{
+	struct drm_plane_state *state = pipe->plane.state;
+	struct hyperv_drm_device *hv;
+	struct drm_rect rect;
+
+	if (!state || !state->fb)
+		return;
+
+	rect.x1 = 0;
+	rect.y1 = 0;
+	rect.x2 = state->fb->width;
+	rect.y2 = state->fb->height;
+
+	hv = to_hv(state->fb->dev);
+	hyperv_update_dirt(hv->hdev, &rect);
+}
+
 static const struct drm_simple_display_pipe_funcs hyperv_pipe_funcs = {
 	.enable	= hyperv_pipe_enable,
 	.check = hyperv_pipe_check,
 	.update	= hyperv_pipe_update,
+	.get_scanout_buffer = hyperv_pipe_get_scanout_buffer,
+	.panic_flush = hyperv_pipe_panic_flush,
 	DRM_GEM_SIMPLE_DISPLAY_PIPE_SHADOW_PLANE_FUNCS,
 };
 
diff --git a/include/drm/drm_simple_kms_helper.h b/include/drm/drm_simple_kms_helper.h
index b2486d073763..126d0d170e81 100644
--- a/include/drm/drm_simple_kms_helper.h
+++ b/include/drm/drm_simple_kms_helper.h
@@ -10,6 +10,7 @@
 #include <drm/drm_encoder.h>
 #include <drm/drm_plane.h>
 
+struct drm_scanout_buffer;
 struct drm_simple_display_pipe;
 
 /**
@@ -226,6 +227,27 @@ struct drm_simple_display_pipe_funcs {
 	 */
 	void (*destroy_plane_state)(struct drm_simple_display_pipe *pipe,
 				    struct drm_plane_state *plane_state);
+
+	/**
+	 * @get_scanout_buffer:
+	 *
+	 * Optional, called by &drm_plane_funcs.get_scanout_buffer. Please
+	 * read the documentation for the &drm_plane_funcs.get_scanout_buffer
+	 * hook for more details.
+	 *
+	 */
+	int (*get_scanout_buffer)(struct drm_simple_display_pipe *pipe,
+				  struct drm_scanout_buffer *sb);
+
+	/**
+	 * @panic_flush:
+	 *
+	 * Optional, called by &drm_plane_funcs.panic_flush. Please read the
+	 * documentation for the &drm_plane_funcs.get_scanout_buffer hook for
+	 * more details.
+	 *
+	 */
+	void (*panic_flush)(struct drm_simple_display_pipe *pipe);
 };
 
 /**
-- 
2.48.1


