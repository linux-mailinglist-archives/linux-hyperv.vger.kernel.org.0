Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C025431C4AE
	for <lists+linux-hyperv@lfdr.de>; Tue, 16 Feb 2021 01:43:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229497AbhBPAmK (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 15 Feb 2021 19:42:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229764AbhBPAmI (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 15 Feb 2021 19:42:08 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 212CDC061756
        for <linux-hyperv@vger.kernel.org>; Mon, 15 Feb 2021 16:41:24 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id t26so5200905pgv.3
        for <linux-hyperv@vger.kernel.org>; Mon, 15 Feb 2021 16:41:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vGczsg5KtJIx2JFpy2jBDe0bJ7D0bN5X+ltVXjZ+hqM=;
        b=ZKJ4OkFUJ7nB99ZO/zizi8ub1RMycd1WU1Yu8ghonyQ8zxyeOsMzZK9dI84DNJKgD2
         eTKDdPZoP2JV1nTF+ZSBVrAu9ub4ERSfC96jCraEw9MUs72P4qgt5HQcEyX1YICL9nug
         Cz9FbmhXsVPU+Zm+sOPuMYxq3HMDyA/r7z/Zz6fBvXF2SNbVE5xIrfAxk6J9j4f9nHXJ
         IlGiJlDtjkR5YsI0ANFzva1DKPtACxy/PCmCLQPROLYCa6Uum15NuV7VVTeqoa0wPSuY
         BPbqoF9z9XXBQvJeKenl7UJi+19TBUKAMpi41XSWKYTtR0UKuKzXB83jQ7+SxdjvL3QJ
         OSwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vGczsg5KtJIx2JFpy2jBDe0bJ7D0bN5X+ltVXjZ+hqM=;
        b=cYs/VWc5/tYCYXasr62TJJlsAdju6fbJBvhgdY7Gb9nMxjcOICsZ1wZyr/YyMca6wb
         /GFD9UtO/OSR1yynPBs1hwJaz7eMbWpoPBgYiVMsbNcTHb84GayKy4+1L+Mu+EVsu+xz
         KQEQW0GZy6t5+kwk3tSFzAjR+9hmgx8vWBZOqRsIjNPyHHjlZG96q8hF7KIH3oegYC0g
         Uiyv65aFhxDCe9Nh6H42vfnvwsLDhuqNhgGuBpXZsaIFC8YhLYUIf/nFvtyFN5c2Jp/Q
         bpLW3vkudy7tzZQGv4YbuIovowykGNWAerzJRonxyoUMydxUGa26OIbLL0EgRGkgW0d4
         5hxA==
X-Gm-Message-State: AOAM530QB/smEjhUnI1eCblXfZAjvs/pzaJ2Ua/2MB7Mcnb+nl2f+kJy
        TGaB8KT4+RsyyXcYmnMy5YtBrspho0ywuQ==
X-Google-Smtp-Source: ABdhPJw9d2Cr3M6gdB27qL7z8Roq79Ofyrullhc+gvaocdGjLkQLRGklmThZmp3k3K0Fw1aOgtikkw==
X-Received: by 2002:aa7:9d83:0:b029:1ec:b2e9:af94 with SMTP id f3-20020aa79d830000b02901ecb2e9af94mr3430697pfq.48.1613436083432;
        Mon, 15 Feb 2021 16:41:23 -0800 (PST)
Received: from localhost.localdomain ([50.47.106.83])
        by smtp.gmail.com with ESMTPSA id m23sm18145282pgv.14.2021.02.15.16.41.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Feb 2021 16:41:23 -0800 (PST)
From:   Deepak Rawat <drawat.floss@gmail.com>
To:     linux-hyperv@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     Daniel Vetter <daniel@ffwll.ch>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Dexuan Cui <decui@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Wei Hu <weh@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Deepak Rawat <drawat.floss@gmail.com>
Subject: [PATCH v3 2/2] MAINTAINERS: Add maintainer for hyperv video device
Date:   Mon, 15 Feb 2021 16:39:59 -0800
Message-Id: <20210216003959.802492-2-drawat.floss@gmail.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210216003959.802492-1-drawat.floss@gmail.com>
References: <20210216003959.802492-1-drawat.floss@gmail.com>
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
index d6dd31cb5ad1..b4aaf1810c7c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6057,6 +6057,14 @@ T:	git git://anongit.freedesktop.org/drm/drm-misc
 F:	Documentation/devicetree/bindings/display/xlnx/
 F:	drivers/gpu/drm/xlnx/
 
+DRM DRIVER FOR HYPERV SYNTHETIC VIDEO DEVICE
+M:	Deepak Rawat <drawat.floss@gmail.com>
+L:	linux-hyperv@vger.kernel.org
+L:	dri-devel@lists.freedesktop.org
+S:	Maintained
+T:	git git://anongit.freedesktop.org/drm/drm-misc
+F:	drivers/gpu/drm/tiny/hyperv_drm.c
+
 DRM DRIVERS FOR ZTE ZX
 M:	Shawn Guo <shawnguo@kernel.org>
 L:	dri-devel@lists.freedesktop.org
-- 
2.30.0

