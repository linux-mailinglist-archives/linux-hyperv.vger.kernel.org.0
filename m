Return-Path: <linux-hyperv+bounces-5662-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B1A3AC3C4A
	for <lists+linux-hyperv@lfdr.de>; Mon, 26 May 2025 11:02:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14CF41891987
	for <lists+linux-hyperv@lfdr.de>; Mon, 26 May 2025 09:02:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A92B31DFE12;
	Mon, 26 May 2025 09:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GWiLm0J5"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1390C1F03DE
	for <linux-hyperv@vger.kernel.org>; Mon, 26 May 2025 09:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748250130; cv=none; b=t3Qvs1dLfEZhH2W3eLcWr2qILS2FPPY4F9lBKmCboa2e1Y7RKZ7wYxF3kkj4jY/VjM4VjLRXhbu1nP2hmURprR7p+motF9EO8iMwmn6OyftjjynLfPBkzwbrTJimKHvBXnQjSER4erPHkP1crcCI/FwIahgXSRh7H/znazgEAIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748250130; c=relaxed/simple;
	bh=ZWoEjjeEptPnbRRuBqE27xtL0VYN5ov9J5JNbJVkCuY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=la+WTfJTzecA+/7cOfjB96Urc0GGBJrZOYV+Jr2fvj2+/xFzHy18ZCS0Mf/x/j7OTMufecZA3O9ieOHyOi7vczmKIt1ISXjJemrvGPc5H+DcfkY0PbGyZfP0qXcUSqWV9U1jc0JtFyKeN7vVYAksg6hFkwybTHEdlxsGldjSsAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GWiLm0J5; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748250125;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+BhiDXyikhO1cftzHYfIEafnStrf4kEMf7dwcV0MPQY=;
	b=GWiLm0J5Sj+4n3GlVl4zgTHrXeeXiZ/yXA6X9Zp1qYR3Hi8AhMQf3a/2xAfQvnoji1f9EX
	f4dvJc4aZE+vgLbHl18qOy8FUYlWGwpuZD0UG91v9O1YRraGKOfFVGoLFMsMC2XWS5C/OB
	IOnxewo5N0oXW4jU5Nxkzi6dLHO3ixE=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-397-m4GlXuQTPcCnBJoyzqzT2w-1; Mon, 26 May 2025 05:01:58 -0400
X-MC-Unique: m4GlXuQTPcCnBJoyzqzT2w-1
X-Mimecast-MFC-AGG-ID: m4GlXuQTPcCnBJoyzqzT2w_1748250117
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-73e0094706bso2778052b3a.3
        for <linux-hyperv@vger.kernel.org>; Mon, 26 May 2025 02:01:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748250117; x=1748854917;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+BhiDXyikhO1cftzHYfIEafnStrf4kEMf7dwcV0MPQY=;
        b=W1GH8lGIGy+UfcNqLHeHRVFzWZ2IDmP3ROPoMu6BsJuNW9Lv6CLBH3jpFimah2YSCx
         wkq9nb8ENWvnRovnyeDva7KgS+mIErwYyqQpKGrZEwiPWx2NGYPaJBvldyUEBIQl5rj8
         vqiVzmSXf7R120X9JqIjR1KBkgYsCjBqzqB0qY2eHlwZBRrYHbXeakBjs8txTOWh4DvT
         b4FD6btf0xY7KeJTECo4oS5ZbTU0zAThLiLa8f7oz2JLnOTVmsjGOI4J7r5OFnRkC2Zo
         l/9d6E20kh/iJktJc9E/dm9i69Tldp5hl7gvFgSBzrydKJgqff96rMpCk8PR4eRr33nC
         ShxA==
X-Forwarded-Encrypted: i=1; AJvYcCX4EQZ7Q01QaE/ZdLMikTIsy42sY+nywqrZpuETYCZlv9Y1SrR9WRPNyVXL+u2SbJ4Xk6R2F70ULuqNvB8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMbVhkPKg32LCXDsDQnFqj+xvktXl3DBX50WZvTs6383KCtisq
	AN9ylOq4lzRyFxa+GN7yZs08RFzb0WrG5FmInL0qUh4LqCU+q7owNpFKZ1TZyHNV8f4y4S96Vt4
	8bAOZivPti51lcj+baHdtNlkZjlDiGMas/g/SbBy2z/2ftbsD6HhWDrY45sISRXXDYA==
X-Gm-Gg: ASbGncv10//av3ToL5Mh07WoBBmpVssaUez2X1MtrzpOUAdrN3By0YY6fawRcbwbVs5
	oK6CLz7qPeEyzs8aLhoBM0vifTJhUTnrPkh5lo1mdQkhauMan3n+IPtYCgEmFJlycRJPAaGWFrd
	npZJI6Jml2Bx61vMPNjqy5Di2uzAYepcU2KUI+wvgoTIfo6acaNBk5ZMxgoXttkw/U2E81VF4d6
	XelCathgU/YrEWL8R75RWdesDOe1/KmqsT5t+9N0Ab9tQ9Z7aEzYw1pfvzVl4b5BZEiGO51nYvv
	7kWpldEqawr+
X-Received: by 2002:a05:6a00:21c2:b0:73e:5aa:4f64 with SMTP id d2e1a72fcca58-745fde9f3b7mr12076480b3a.10.1748250117049;
        Mon, 26 May 2025 02:01:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFODFO9ppwsV5E+FFuQuGGeBW483IYeVBee2OXT2Zb9+eI8FLSHDED6cuwUZJgQFPu/emkBcQ==
X-Received: by 2002:a05:6a00:21c2:b0:73e:5aa:4f64 with SMTP id d2e1a72fcca58-745fde9f3b7mr12076460b3a.10.1748250116707;
        Mon, 26 May 2025 02:01:56 -0700 (PDT)
Received: from zeus.elecom ([240b:10:83a2:bd00:6e35:f2f5:2e21:ae3a])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-742a9878b53sm16575092b3a.152.2025.05.26.02.01.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 May 2025 02:01:56 -0700 (PDT)
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
Subject: [PATCH RFC drm-misc-next v2 1/1] drm/hyperv: Add support for drm_panic
Date: Mon, 26 May 2025 18:01:05 +0900
Message-ID: <20250526090117.80593-2-ryasuoka@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250526090117.80593-1-ryasuoka@redhat.com>
References: <20250526090117.80593-1-ryasuoka@redhat.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add drm_panic module for hyperv drm so that panic screen can be
displayed on panic.

Signed-off-by: Ryosuke Yasuoka <ryasuoka@redhat.com>
---
 drivers/gpu/drm/hyperv/hyperv_drm_modeset.c | 36 +++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/drivers/gpu/drm/hyperv/hyperv_drm_modeset.c b/drivers/gpu/drm/hyperv/hyperv_drm_modeset.c
index f7d2e973f79e..945b9482bcb3 100644
--- a/drivers/gpu/drm/hyperv/hyperv_drm_modeset.c
+++ b/drivers/gpu/drm/hyperv/hyperv_drm_modeset.c
@@ -17,6 +17,7 @@
 #include <drm/drm_gem_framebuffer_helper.h>
 #include <drm/drm_gem_shmem_helper.h>
 #include <drm/drm_probe_helper.h>
+#include <drm/drm_panic.h>
 #include <drm/drm_plane.h>
 
 #include "hyperv_drm.h"
@@ -181,10 +182,45 @@ static void hyperv_plane_atomic_update(struct drm_plane *plane,
 	}
 }
 
+static int hyperv_plane_get_scanout_buffer(struct drm_plane *plane,
+					   struct drm_scanout_buffer *sb)
+{
+	struct hyperv_drm_device *hv = to_hv(plane->dev);
+	struct iosys_map map = IOSYS_MAP_INIT_VADDR_IOMEM(hv->vram);
+
+	if (plane->state && plane->state->fb) {
+		sb->format = plane->state->fb->format;
+		sb->width = plane->state->fb->width;
+		sb->height = plane->state->fb->height;
+		sb->pitch[0] = plane->state->fb->pitches[0];
+		sb->map[0] = map;
+		return 0;
+	}
+	return -ENODEV;
+}
+
+static void hyperv_plane_panic_flush(struct drm_plane *plane)
+{
+	struct hyperv_drm_device *hv = to_hv(plane->dev);
+	struct drm_rect rect;
+
+	if (!plane->state || !plane->state->fb)
+		return;
+
+	rect.x1 = 0;
+	rect.y1 = 0;
+	rect.x2 = plane->state->fb->width;
+	rect.y2 = plane->state->fb->height;
+
+	hyperv_update_dirt(hv->hdev, &rect);
+}
+
 static const struct drm_plane_helper_funcs hyperv_plane_helper_funcs = {
 	DRM_GEM_SHADOW_PLANE_HELPER_FUNCS,
 	.atomic_check = hyperv_plane_atomic_check,
 	.atomic_update = hyperv_plane_atomic_update,
+	.get_scanout_buffer = hyperv_plane_get_scanout_buffer,
+	.panic_flush = hyperv_plane_panic_flush,
 };
 
 static const struct drm_plane_funcs hyperv_plane_funcs = {
-- 
2.49.0


