Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B2FC382BA7
	for <lists+linux-hyperv@lfdr.de>; Mon, 17 May 2021 13:59:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236862AbhEQMBK (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 17 May 2021 08:01:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236882AbhEQMBJ (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 17 May 2021 08:01:09 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD078C061573
        for <linux-hyperv@vger.kernel.org>; Mon, 17 May 2021 04:59:52 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id t30so4475707pgl.8
        for <linux-hyperv@vger.kernel.org>; Mon, 17 May 2021 04:59:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zN06llUlMhgh2rrA6m0mH/DsFqC/Ju8EsbQhE5gaebU=;
        b=bc1eZvrcp5Q0pCIPtBTmXraES1s3m8Ci1ZlkcLhu6uFCHT3jpr47XcrXQSUsPSF2aw
         Hk553TvIjMdp6wS2pJBK091sG6xLCOCs/Rhri5DrJ8nxPmh/1uT+74P3RRtg442QFxrH
         t92Y6V9dOA3bMGPjrEuZ/HTtSByRzt9wnifFa89tkqY++mf/hmXzJA23syUfmVbPAjbx
         RQMpJ37Zt+gYwq1VMhTuBdb5XNOzq6rmC8e2YGRB4kjNy8cie8ZDbM2OD/D48kvejspD
         e3GJowbow6cS3EVTV9EvzCumjzn/SqfR++NvNKX0IWZ3omS6xPPFl77PXcFcid2gqEmx
         A+cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zN06llUlMhgh2rrA6m0mH/DsFqC/Ju8EsbQhE5gaebU=;
        b=oPjjLB5aWPK1WT1zPolkp3l1YNSa2xEwv/l/T0s7KpFevQPn84noWsSTQmfC1drrbs
         Zf5p59pcsEQtHg1XTa7YMRnZABXULsKOzZ6o9b6tSWbypdfWxEsnSuxVh7MHdgfDCnyP
         1xDL++FkT6g/Qcye1hYuJCJjNhaeAirOS5JY2lOMJ0WSkbkjK10jpLmyg5arZTON//Eo
         oxT+d35DsAwZ+n/u344tAB2VLeLhQ4g6v8nm7cl5bjTBm7vMR0LxT0hiOXtg4OROI5KI
         MFwoFbULKBYUexv9fR0N8QTEbKu0dw8scVsgMfoUWLsbZ0w2V+Edh0bkf0PxFmZ/qWfd
         o5FA==
X-Gm-Message-State: AOAM532MxVt0yjPp2XWPDp2tbvL7apiWn7AwQraaGlb2L5hP8+HevjEo
        xpKAFex3pyJp6JqSVyLjrRw=
X-Google-Smtp-Source: ABdhPJzjlCx9Ov7Dli8nSqMVLntRFKwzsLtifCSbVnH7g0XzdhEhcDTjyQ+STpVFOYsUNtt7cMRXjw==
X-Received: by 2002:a65:4689:: with SMTP id h9mr23777058pgr.347.1621252792427;
        Mon, 17 May 2021 04:59:52 -0700 (PDT)
Received: from arch2.localdomain ([106.212.13.216])
        by smtp.gmail.com with ESMTPSA id q24sm10211393pgb.19.2021.05.17.04.59.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 May 2021 04:59:52 -0700 (PDT)
From:   Deepak Rawat <drawat.floss@gmail.com>
To:     dri-devel@lists.freedesktop.org, linux-hyperv@vger.kernel.org
Cc:     Dexuan Cui <decui@microsoft.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Michael Kelley <mikelley@microsoft.com>,
        Deepak Rawat <drawat.floss@gmail.com>
Subject: [PATCH v4 3/3] MAINTAINERS: Add maintainer for hyperv video device
Date:   Mon, 17 May 2021 04:59:22 -0700
Message-Id: <20210517115922.8033-3-drawat.floss@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210517115922.8033-1-drawat.floss@gmail.com>
References: <20210517115922.8033-1-drawat.floss@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Maintainer for hyperv synthetic video device.

Signed-off-by: Deepak Rawat <drawat.floss@gmail.com>
---
 MAINTAINERS | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index bd7aff0c120f..261342551406 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6077,6 +6077,14 @@ T:	git git://anongit.freedesktop.org/drm/drm-misc
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
@@ -6223,6 +6231,14 @@ T:	git git://anongit.freedesktop.org/drm/drm-misc
 F:	Documentation/devicetree/bindings/display/xlnx/
 F:	drivers/gpu/drm/xlnx/
 
+DRM DRIVERS FOR ZTE ZX
+M:	Shawn Guo <shawnguo@kernel.org>
+L:	dri-devel@lists.freedesktop.org
+S:	Maintained
+T:	git git://anongit.freedesktop.org/drm/drm-misc
+F:	Documentation/devicetree/bindings/display/zte,vou.txt
+F:	drivers/gpu/drm/zte/
+
 DRM PANEL DRIVERS
 M:	Thierry Reding <thierry.reding@gmail.com>
 R:	Sam Ravnborg <sam@ravnborg.org>
-- 
2.31.1

