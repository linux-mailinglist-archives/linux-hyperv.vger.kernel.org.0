Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC84F392C97
	for <lists+linux-hyperv@lfdr.de>; Thu, 27 May 2021 13:23:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229834AbhE0LYh (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 27 May 2021 07:24:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233288AbhE0LYY (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 27 May 2021 07:24:24 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91BAFC061761
        for <linux-hyperv@vger.kernel.org>; Thu, 27 May 2021 04:22:48 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id e17so338006pfl.5
        for <linux-hyperv@vger.kernel.org>; Thu, 27 May 2021 04:22:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0S3o4TmqPj949RkfsbYV2YGOzI88SNqbU5TbO9tEHyI=;
        b=Ewvx779weTiJfXIMi9ZmWsDQf7Wppa8wKfBmQpnlGK1gYQbj5KDSbLnxSopg/5L4it
         dQGvJRIF/hZ8AIWUQCJS/91jYQPXbBgBKjW3T91ML7h5wBDr6ZSUoViY+VxKt5sELPqC
         IzQDAeEiusyysF525gytNL1LDNbk5Z68Dsa9pgyO46/54+xkQK1A6SHEJDyQ7MJdPQA5
         uJGE19pgZVDddAbSDtFGbIW+gwfk3pH6egMbt/5jsixw+VSXzzOlF1OcvPWzU/SFEtvs
         eB4zkf3bQOJ3aaDyr80HljWOhIc79KPCfOJPneQLAcckIvxh0lrHOHr7+fQD7EzWkFUm
         oDrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0S3o4TmqPj949RkfsbYV2YGOzI88SNqbU5TbO9tEHyI=;
        b=fMIn/tw71V1ppEKRvA2gjeNBZaGDToO04VFO+xUDSCZLX/gt7roZB3YE4tGLclgJ0f
         x7YG/LbYppV9OFFAN4TgjFqKYoZLIF6jNEOqwGU2ZPWY2XMxdVRTTLFYwwfTagvOO6YF
         d+Sq/RFjwFFynK2sdU8x0Gk+y7kEO+mK7LfE3wvdbE8yKN1iF2D/VsODTjkHu2YAgHRY
         T/b6+ft7qUhxS4G1Dlw3cPpSw1OiB5hDe2q2X+VLog59B80y3pNYckcUFI1ePyx1uWx/
         G7L6VAKLR6YVXddqtnSeOUCy8uAgN/EnPq1cyO4RakG2HRfSmnuyKh+xUgiWQv/2wEki
         kH5Q==
X-Gm-Message-State: AOAM531iTVE+9chV6KobRCIuWYLvLmH7sccHJAGHeri5pDkp6q0gezvY
        faDB42QlZzhs9g6GxUG4CEGcafvkYi8rLg==
X-Google-Smtp-Source: ABdhPJxJQGkbP2odIj6/7Bac4KaIs9VV0rlA86CrnvHHvaucePPTTXlbmYXd+wa4wV6FLGKk+IcYyA==
X-Received: by 2002:a62:5306:0:b029:2de:6ce0:5526 with SMTP id h6-20020a6253060000b02902de6ce05526mr2876882pfb.13.1622114568195;
        Thu, 27 May 2021 04:22:48 -0700 (PDT)
Received: from arch2.localdomain ([50.47.106.83])
        by smtp.gmail.com with ESMTPSA id c11sm1730325pjr.32.2021.05.27.04.22.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 May 2021 04:22:47 -0700 (PDT)
From:   Deepak Rawat <drawat.floss@gmail.com>
To:     dri-devel@lists.freedesktop.org, linux-hyperv@vger.kernel.org
Cc:     Dexuan Cui <decui@microsoft.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Michael Kelley <mikelley@microsoft.com>,
        Deepak Rawat <drawat.floss@gmail.com>
Subject: [PATCH v6 3/3] MAINTAINERS: Add maintainer for hyperv video device
Date:   Thu, 27 May 2021 04:22:30 -0700
Message-Id: <20210527112230.1274-3-drawat.floss@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210527112230.1274-1-drawat.floss@gmail.com>
References: <20210527112230.1274-1-drawat.floss@gmail.com>
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
index 315120c4124d..a4fdde4bb250 100644
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

