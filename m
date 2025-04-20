Return-Path: <linux-hyperv+bounces-4974-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14DEDA947CE
	for <lists+linux-hyperv@lfdr.de>; Sun, 20 Apr 2025 14:22:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D91D93B5709
	for <lists+linux-hyperv@lfdr.de>; Sun, 20 Apr 2025 12:22:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F11761E3793;
	Sun, 20 Apr 2025 12:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W7lBaLOL"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D5B3204F80
	for <linux-hyperv@vger.kernel.org>; Sun, 20 Apr 2025 12:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745151641; cv=none; b=sxgIINgXjyarkVuGsmjLkg68XHS1aDJxIdRXp+h4NlS0DixEhTZ2iRRmJYmuHqZlGm6rKWeWcWGoqMuK6E35KOhI9S7nqK9xk4ni6BtD3W0JOwP4oXFTcwK7Scg0ce0qd27chv/dPvPYxV668jIYNrGPmA0m2WHx/hTFVQUMTjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745151641; c=relaxed/simple;
	bh=NTzNeMUzrtOBlM8W2SdqzoSPHpuoqpGFKiJlAFUw5t4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Khe5kbhzpTSogvqs8AjgIFYWRFW+fjno2IwB+BqRwJqdm4F+wLprxLcGRSU6n6Ut3OQ7vppO1aVCA80u7TukIhXssXtBa0TGXXa1ZjoXFGZLovCc583Uz8zLAx6Ii/KW6GC2x0HyRfCjmjJGKAPOYxIX43aipMmoukHL5QB2dYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=W7lBaLOL; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745151638;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=PVA+hnFYhm0mZbXMkfXZGu1NJd1kB7+txfbwzU2JSfM=;
	b=W7lBaLOLUMLfysektXc58xVk1Y/vl20AHsUIDMmtF0kOWaXSDAaID68ICLFYkQvicc++79
	s/v5El5IFQz0eBsgoucE+Sb0adgW6sSFqcvku/i4o4dJKgmFA1Gattz6WqnLLN8sCSUrHR
	ec6448mbSEik4Z+XWVdnXfmkwGWAmn0=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-526-itYA_pBKNd20kMBYWZZ8cw-1; Sun, 20 Apr 2025 08:20:36 -0400
X-MC-Unique: itYA_pBKNd20kMBYWZZ8cw-1
X-Mimecast-MFC-AGG-ID: itYA_pBKNd20kMBYWZZ8cw_1745151636
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2242f3fd213so28046875ad.1
        for <linux-hyperv@vger.kernel.org>; Sun, 20 Apr 2025 05:20:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745151635; x=1745756435;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PVA+hnFYhm0mZbXMkfXZGu1NJd1kB7+txfbwzU2JSfM=;
        b=H1PtwZ5kjqFtPbTzblFbSURKKsjt46DBN7Q4ANQeL7QuFE4onL1IyEVndqQQ6+GK6f
         gv/tLzKoK/hCgEUyfWAp36xSxSWwfxSwJeiRWcjoPCupKXtLGsZzLBgubHIde1K7AG9Q
         SbO3bH0X7TZix9V1iEcIHnf/0efL0qgrPtq2UNDcF7pJzWGe5IyfyrIviwA1YXnrhH7S
         nQi7jK2B+I7B0AFyPvC1fVc3jwt/ZOScpfG34NjE40DvCUFFRnAnuVHo/jFMgN6RJ8ik
         0p1Qubi/Eddz/AuQ7cQ1PxpXOWW6It4EYv77HG06AM5Nvyv5LvoEBJ5wOTtx9oYBVk06
         FIPQ==
X-Forwarded-Encrypted: i=1; AJvYcCWyQ+MKnCuCJRmQbMAth5EmmzOCxD7BpiHzSYjgl4WIyKd/rVCqcyTvM01Rwk3f1aN/lCh8bbznIffHzq0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXzUclkd4VITjTRvXPy3hXHLUY/KhK9yW8dL6G83x/SR/XWl8d
	U5/56RE5grXmUSrWG0v7eUO9LNnru+yybDA2J5T67xKr71rU1T/7Ukpj3am/y9o/dOBwxjBu4O+
	OI1ImslusybIxasqDQZ/4OzkYrl1mB1I+bjsiGQw1Mnip0gjohwYJeV+m4VJ9Zg==
X-Gm-Gg: ASbGncsQjnJdJJBZpdprYwhBIBT8xFz08/znlzjoODWjHX6FQlZ9PAsn3sUs2DWIGVj
	tnzjXZjJbNx3d5EiFPtuClI+Ez1zggmMWgsflbthrIyYMn4cnoLT9ErGfa0XQAVsIOS2zz9jimQ
	bJpDjIa5HUad0Dm8/gl1nlqLGzNSmtXfrb+dG6Vl9vdlqXAB8ctbXDJ67CX1HWs1DIF8QW3kvXe
	pC150QtAoPJcAzhBIigc3fgLqV4+pqgmuQj7Ja45d/92kmoShFc61wfpL9YgHC6eUc7EocK2gee
	cz2QlepqBe5T
X-Received: by 2002:a17:902:f643:b0:21f:7880:8472 with SMTP id d9443c01a7336-22c53607720mr150489285ad.35.1745151635575;
        Sun, 20 Apr 2025 05:20:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH59HygyrR1b3g9oQn9ho711+vyY8u+CP/T6vo/KmS10uhru55tsapleIueUiYDlFrxaRTpVA==
X-Received: by 2002:a17:902:f643:b0:21f:7880:8472 with SMTP id d9443c01a7336-22c53607720mr150488965ad.35.1745151635187;
        Sun, 20 Apr 2025 05:20:35 -0700 (PDT)
Received: from zeus.elecom ([240b:10:83a2:bd00:6e35:f2f5:2e21:ae3a])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22c50ecdc9csm46929035ad.165.2025.04.20.05.20.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Apr 2025 05:20:34 -0700 (PDT)
From: Ryosuke Yasuoka <ryasuoka@redhat.com>
To: drawat.floss@gmail.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch,
	jfalempe@redhat.com
Cc: Ryosuke Yasuoka <ryasuoka@redhat.com>,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH drm-next] drm/hyperv: Replace simple-KMS with regular atomic helpers
Date: Sun, 20 Apr 2025 21:19:43 +0900
Message-ID: <20250420121945.573915-1-ryasuoka@redhat.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Drop simple-KMS in favor of regular atomic helpers to make the code more
modular. The simple-KMS helper mix up plane and CRTC state, so it is
obsolete and should go away [1]. Since it just split the simple-pipe
funtions into per-plane and per-CRTC, no functional changes is expected.

[1] https://lore.kernel.org/lkml/dae5089d-e214-4518-b927-5c4149babad8@suse.de/

Signed-off-by: Ryosuke Yasuoka <ryasuoka@redhat.com>
---
 drivers/gpu/drm/hyperv/hyperv_drm.h         |   4 +-
 drivers/gpu/drm/hyperv/hyperv_drm_modeset.c | 168 ++++++++++++++++----
 2 files changed, 139 insertions(+), 33 deletions(-)

diff --git a/drivers/gpu/drm/hyperv/hyperv_drm.h b/drivers/gpu/drm/hyperv/hyperv_drm.h
index d2d8582b36df..9e776112c03e 100644
--- a/drivers/gpu/drm/hyperv/hyperv_drm.h
+++ b/drivers/gpu/drm/hyperv/hyperv_drm.h
@@ -11,7 +11,9 @@
 struct hyperv_drm_device {
 	/* drm */
 	struct drm_device dev;
-	struct drm_simple_display_pipe pipe;
+	struct drm_plane plane;
+	struct drm_crtc crtc;
+	struct drm_encoder encoder;
 	struct drm_connector connector;
 
 	/* mode */
diff --git a/drivers/gpu/drm/hyperv/hyperv_drm_modeset.c b/drivers/gpu/drm/hyperv/hyperv_drm_modeset.c
index 6c6b57298797..c273c093b491 100644
--- a/drivers/gpu/drm/hyperv/hyperv_drm_modeset.c
+++ b/drivers/gpu/drm/hyperv/hyperv_drm_modeset.c
@@ -5,6 +5,7 @@
 
 #include <linux/hyperv.h>
 
+#include <drm/drm_atomic.h>
 #include <drm/drm_damage_helper.h>
 #include <drm/drm_drv.h>
 #include <drm/drm_edid.h>
@@ -15,7 +16,7 @@
 #include <drm/drm_gem_framebuffer_helper.h>
 #include <drm/drm_gem_shmem_helper.h>
 #include <drm/drm_probe_helper.h>
-#include <drm/drm_simple_kms_helper.h>
+#include <drm/drm_plane.h>
 
 #include "hyperv_drm.h"
 
@@ -98,12 +99,47 @@ static int hyperv_check_size(struct hyperv_drm_device *hv, int w, int h,
 	return 0;
 }
 
-static void hyperv_pipe_enable(struct drm_simple_display_pipe *pipe,
-			       struct drm_crtc_state *crtc_state,
-			       struct drm_plane_state *plane_state)
+static const uint32_t hyperv_formats[] = {
+	DRM_FORMAT_XRGB8888,
+};
+
+static const uint64_t hyperv_modifiers[] = {
+	DRM_FORMAT_MOD_LINEAR,
+	DRM_FORMAT_MOD_INVALID
+};
+
+static enum drm_mode_status
+hyperv_crtc_helper_mode_valid(struct drm_crtc *crtc,
+			      const struct drm_display_mode *mode)
+{
+	return MODE_OK;
+}
+
+static int hyperv_crtc_helper_atomic_check(struct drm_crtc *crtc,
+					   struct drm_atomic_state *state)
 {
-	struct hyperv_drm_device *hv = to_hv(pipe->crtc.dev);
+	struct drm_crtc_state *crtc_state = drm_atomic_get_new_crtc_state(state, crtc);
+	int ret;
+
+	if (!crtc_state->enable)
+		goto out;
+
+	ret = drm_atomic_helper_check_crtc_primary_plane(crtc_state);
+	if (ret)
+		return ret;
+
+out:
+	return drm_atomic_add_affected_planes(state, crtc);
+}
+
+static void hyperv_crtc_helper_atomic_enable(struct drm_crtc *crtc,
+					     struct drm_atomic_state *state)
+{
+	struct hyperv_drm_device *hv = to_hv(crtc->dev);
+	struct drm_plane *plane = &hv->plane;
+	struct drm_plane_state *plane_state = plane->state;
 	struct drm_shadow_plane_state *shadow_plane_state = to_drm_shadow_plane_state(plane_state);
+	struct drm_crtc_state *crtc_state = crtc->state;
 
 	hyperv_hide_hw_ptr(hv->hdev);
 	hyperv_update_situation(hv->hdev, 1,  hv->screen_depth,
@@ -113,12 +149,48 @@ static void hyperv_pipe_enable(struct drm_simple_display_pipe *pipe,
 	hyperv_blit_to_vram_fullscreen(plane_state->fb, &shadow_plane_state->data[0]);
 }
 
-static int hyperv_pipe_check(struct drm_simple_display_pipe *pipe,
-			     struct drm_plane_state *plane_state,
-			     struct drm_crtc_state *crtc_state)
+static void hyperv_crtc_helper_atomic_disable(struct drm_crtc *crtc,
+					      struct drm_atomic_state *state)
+{ }
+
+static const struct drm_crtc_helper_funcs hyperv_crtc_helper_funcs = {
+	.mode_valid = hyperv_crtc_helper_mode_valid,
+	.atomic_check = hyperv_crtc_helper_atomic_check,
+	.atomic_enable = hyperv_crtc_helper_atomic_enable,
+	.atomic_disable = hyperv_crtc_helper_atomic_disable,
+};
+
+static const struct drm_crtc_funcs hyperv_crtc_funcs = {
+	.reset = drm_atomic_helper_crtc_reset,
+	.destroy = drm_crtc_cleanup,
+	.set_config = drm_atomic_helper_set_config,
+	.page_flip = drm_atomic_helper_page_flip,
+	.atomic_duplicate_state = drm_atomic_helper_crtc_duplicate_state,
+	.atomic_destroy_state = drm_atomic_helper_crtc_destroy_state,
+};
+
+static int hyperv_plane_atomic_check(struct drm_plane *plane,
+				     struct drm_atomic_state *state)
 {
-	struct hyperv_drm_device *hv = to_hv(pipe->crtc.dev);
+	struct drm_plane_state *plane_state = drm_atomic_get_new_plane_state(state, plane);
+	struct hyperv_drm_device *hv = to_hv(plane->dev);
 	struct drm_framebuffer *fb = plane_state->fb;
+	struct drm_crtc *crtc = plane_state->crtc;
+	struct drm_crtc_state *crtc_state = NULL;
+	int ret;
+
+	if (crtc)
+		crtc_state = drm_atomic_get_new_crtc_state(state, crtc);
+
+	ret = drm_atomic_helper_check_plane_state(plane_state, crtc_state,
+						  DRM_PLANE_NO_SCALING,
+						  DRM_PLANE_NO_SCALING,
+						  false, false);
+	if (ret)
+		return ret;
+
+	if (!plane_state->visible)
+		return 0;
 
 	if (fb->format->format != DRM_FORMAT_XRGB8888)
 		return -EINVAL;
@@ -132,51 +204,83 @@ static int hyperv_pipe_check(struct drm_simple_display_pipe *pipe,
 	return 0;
 }
 
-static void hyperv_pipe_update(struct drm_simple_display_pipe *pipe,
-			       struct drm_plane_state *old_state)
+static void hyperv_plane_atomic_update(struct drm_plane *plane,
+						      struct drm_atomic_state *old_state)
 {
-	struct hyperv_drm_device *hv = to_hv(pipe->crtc.dev);
-	struct drm_plane_state *state = pipe->plane.state;
+	struct drm_plane_state *old_pstate = drm_atomic_get_old_plane_state(old_state, plane);
+	struct hyperv_drm_device *hv = to_hv(plane->dev);
+	struct drm_plane_state *state = plane->state;
 	struct drm_shadow_plane_state *shadow_plane_state = to_drm_shadow_plane_state(state);
 	struct drm_rect rect;
 
-	if (drm_atomic_helper_damage_merged(old_state, state, &rect)) {
+	if (drm_atomic_helper_damage_merged(old_pstate, state, &rect)) {
 		hyperv_blit_to_vram_rect(state->fb, &shadow_plane_state->data[0], &rect);
 		hyperv_update_dirt(hv->hdev, &rect);
 	}
 }
 
-static const struct drm_simple_display_pipe_funcs hyperv_pipe_funcs = {
-	.enable	= hyperv_pipe_enable,
-	.check = hyperv_pipe_check,
-	.update	= hyperv_pipe_update,
-	DRM_GEM_SIMPLE_DISPLAY_PIPE_SHADOW_PLANE_FUNCS,
+static bool hyperv_format_mod_supported(struct drm_plane *plane,
+					uint32_t format, uint64_t modifier)
+{
+	return modifier == DRM_FORMAT_MOD_LINEAR;
+}
+
+static const struct drm_plane_helper_funcs hyperv_plane_helper_funcs = {
+	DRM_GEM_SHADOW_PLANE_HELPER_FUNCS,
+	.atomic_check = hyperv_plane_atomic_check,
+	.atomic_update = hyperv_plane_atomic_update,
 };
 
-static const uint32_t hyperv_formats[] = {
-	DRM_FORMAT_XRGB8888,
+static const struct drm_plane_funcs hyperv_plane_funcs = {
+	.update_plane		= drm_atomic_helper_update_plane,
+	.disable_plane		= drm_atomic_helper_disable_plane,
+	.destroy		= drm_plane_cleanup,
+	.format_mod_supported   = hyperv_format_mod_supported,
+	DRM_GEM_SHADOW_PLANE_FUNCS,
 };
 
-static const uint64_t hyperv_modifiers[] = {
-	DRM_FORMAT_MOD_LINEAR,
-	DRM_FORMAT_MOD_INVALID
+static const struct drm_encoder_funcs hyperv_drm_simple_encoder_funcs_cleanup = {
+	.destroy = drm_encoder_cleanup,
 };
 
 static inline int hyperv_pipe_init(struct hyperv_drm_device *hv)
 {
+	struct drm_device *dev = &hv->dev;
+	struct drm_encoder *encoder = &hv->encoder;
+	struct drm_plane *plane = &hv->plane;
+	struct drm_crtc *crtc = &hv->crtc;
+	struct drm_connector *connector = &hv->connector;
 	int ret;
 
-	ret = drm_simple_display_pipe_init(&hv->dev,
-					   &hv->pipe,
-					   &hyperv_pipe_funcs,
-					   hyperv_formats,
-					   ARRAY_SIZE(hyperv_formats),
-					   hyperv_modifiers,
-					   &hv->connector);
+	drm_plane_helper_add(plane, &hyperv_plane_helper_funcs);
+	ret = drm_universal_plane_init(dev, plane, 0,
+				       &hyperv_plane_funcs,
+				       hyperv_formats, ARRAY_SIZE(hyperv_formats),
+				       hyperv_modifiers,
+				       DRM_PLANE_TYPE_PRIMARY, NULL);
+	if (ret)
+		return ret;
+
+	drm_crtc_helper_add(crtc, &hyperv_crtc_helper_funcs);
+	ret = drm_crtc_init_with_planes(dev, crtc, plane, NULL,
+					&hyperv_crtc_funcs, NULL);
+	if (ret)
+		return ret;
+
+	encoder->possible_crtcs = drm_crtc_mask(crtc);
+	ret = drm_encoder_init(dev, encoder,
+			       &hyperv_drm_simple_encoder_funcs_cleanup,
+			       DRM_MODE_ENCODER_NONE, NULL);
+
+	if (ret || !connector)
+		return ret;
+
+	ret = drm_connector_attach_encoder(connector, encoder);
+
 	if (ret)
 		return ret;
 
-	drm_plane_enable_fb_damage_clips(&hv->pipe.plane);
+	drm_plane_enable_fb_damage_clips(&hv->plane);
 
 	return 0;
 }

base-commit: b60301774a8fe6c30b14a95104ec099290a2e904
-- 
2.49.0


