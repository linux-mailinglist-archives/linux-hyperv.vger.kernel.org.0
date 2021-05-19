Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8815A3893EA
	for <lists+linux-hyperv@lfdr.de>; Wed, 19 May 2021 18:38:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355274AbhESQj0 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 19 May 2021 12:39:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230239AbhESQjY (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 19 May 2021 12:39:24 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2F5DC06175F
        for <linux-hyperv@vger.kernel.org>; Wed, 19 May 2021 09:38:04 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id n6-20020a17090ac686b029015d2f7aeea8so3830474pjt.1
        for <linux-hyperv@vger.kernel.org>; Wed, 19 May 2021 09:38:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=v+2QREdqW2HXIwZy26xgUhGlmKXeoRbwSm4QcONeIpU=;
        b=pHUUvOpLxOsB9gtmQbg684yPP+rRIWe0/r/Ncbzz4fu7JNy3d5QMGVq42G+3AEAkSo
         6vc7oKhxqvTRZ7ViOa34GHKWwI/xWro1rWaWiMcsj1eoWOaxTOU6oKed95XASr+o6A20
         1SVk/ud52YHiDEarh8WdIwT/nPzVf9MAwei0wKmdEavIyDRdbXDGehsxI7p7ElsXzJ3O
         aj+LcnwDdmz3a3gBhJ+t84FCltWv7ED9NQss75E/o5cN5gVd1A5cGxv1x0bA8zXKlu7i
         FW8gw30hLc7TsERPCjAegD7/Hagetz9hwzsxiHOMXxn9YKGF0u+nMRXvQ4L+K7cuLyj3
         Cdmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=v+2QREdqW2HXIwZy26xgUhGlmKXeoRbwSm4QcONeIpU=;
        b=iHS5oDkRPDxcUnpyQN9/kaD7euCy79om+OzQNxqBSz3SKNku1uH9KJsU8Xp1mfTjpi
         47gr8VXMFTXtvO1IDLuIREFEEziZF2unw9OswnQMUleolAPa3lsZ+XRjhwkjHgHvCKgw
         JH9J9EtvoXev87gVi7ncfPjGneZn9f4tgKo9hA1c7AZx7bz9bkmmm55PI0up15geMQ9P
         /ngZlulrWHMLv+mfelhlMOBEVUBzuSjL90Sfnfoqo6D1wXj9rHP1jaLNLJWdO4LV2k2a
         Wjx42bGUuQzPooJApI64Aa3vJOoklV7ldAAVop3RbZmWTrk+8LgXgySpcRUvMxpz0uqi
         wbog==
X-Gm-Message-State: AOAM530RjeyDb2j/LarFvq1oLwA6GAYeztQeoeGOrHkLWGZUEbFRp9P7
        bJkFuDOKUE+mn544aCcj8F0=
X-Google-Smtp-Source: ABdhPJxnB/0xdDQwHlxTqGn1NC7r4k7Qfc9yYV97bbmsiNLU9A7Z8xr/P/iKC6w4Um8yS3gR753qhA==
X-Received: by 2002:a17:902:dacf:b029:ee:ac0e:d0fe with SMTP id q15-20020a170902dacfb02900eeac0ed0femr465178plx.30.1621442284613;
        Wed, 19 May 2021 09:38:04 -0700 (PDT)
Received: from arch2.localdomain ([182.68.112.122])
        by smtp.gmail.com with ESMTPSA id y1sm1442606pfn.13.2021.05.19.09.38.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 May 2021 09:38:04 -0700 (PDT)
From:   Deepak Rawat <drawat.floss@gmail.com>
To:     dri-devel@lists.freedesktop.org, linux-hyperv@vger.kernel.org
Cc:     Dexuan Cui <decui@microsoft.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Michael Kelley <mikelley@microsoft.com>,
        Deepak Rawat <drawat.floss@gmail.com>
Subject: [PATCH v5 3/3] MAINTAINERS: Add maintainer for hyperv video device
Date:   Wed, 19 May 2021 09:37:39 -0700
Message-Id: <20210519163739.1312-3-drawat.floss@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210519163739.1312-1-drawat.floss@gmail.com>
References: <20210519163739.1312-1-drawat.floss@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Maintainer for hyperv synthetic video device.

Signed-off-by: Deepak Rawat <drawat.floss@gmail.com>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 41f2b2b85b6d..dbe4ed540e11 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6084,6 +6084,14 @@ T:	git git://anongit.freedesktop.org/drm/drm-misc
 F:	Documentation/devicetree/bindings/display/hisilicon/
 F:	drivers/gpu/drm/hisilicon/
 
+DRM DRIVER FOR HYPERV SYNTHETIC VIDEO DEVICE
+M:	Deepak Rawat <drawat.floss@gmail.com>
+L:	linux-hyperv@vger.kernel.org
+L:	dri-devel@lists.freedesktop.org
+S:	Maintained
+T:	git git://anongit.freedesktop.org/drm/drm-misc
+F:	drivers/gpu/drm/hyperv
+
 DRM DRIVERS FOR LIMA
 M:	Qiang Yu <yuq825@gmail.com>
 L:	dri-devel@lists.freedesktop.org
-- 
2.31.1

