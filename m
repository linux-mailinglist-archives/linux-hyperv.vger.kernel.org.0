Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C0EB2E868B
	for <lists+linux-hyperv@lfdr.de>; Sat,  2 Jan 2021 07:04:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727173AbhABGEd (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sat, 2 Jan 2021 01:04:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725208AbhABGEc (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Sat, 2 Jan 2021 01:04:32 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 797B3C0613CF
        for <linux-hyperv@vger.kernel.org>; Fri,  1 Jan 2021 22:03:52 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id a188so600059pfa.11
        for <linux-hyperv@vger.kernel.org>; Fri, 01 Jan 2021 22:03:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=o0YCDQ+4gjTAOk8HBIHftWy6uaxr3xRhCzqiqfq56xc=;
        b=NkcCv9I3Hd24ecxaTKf30LYybo0NeFL87J5LzetUovb3XZ0qGJHMsYtJVG36o5cqbL
         7vWSdEKtR2nRq1DtiPzSD88gTODF3F4ttVRrFeAH6GYdfAsw1si3qdelpn1aDalQLLDD
         CuzqmBHM8nOOm6pHlBR2RTqyMAenbos9AxXOCfuvkvfXpRYKmg8bx9oqVkXrpebpKdUI
         4iTKNooeLpJtfjS5QcHLWukn3GY6agsUZkWM7ABpjL5wpRDxuaR022B7vP9oUnBqrMBM
         PiNb7DJmyfp8WXbT6Kww7mWjuhZFuFu5eoo87wJSNcubXuxYLyEYQFdUqnNCS+CM8dYR
         p/0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=o0YCDQ+4gjTAOk8HBIHftWy6uaxr3xRhCzqiqfq56xc=;
        b=jzFvwbRlj0mCDxLpkXV6SMGa4+/r9uMNdIYIJvpFwggh+5kL8Ybx6TlFAJ47sFnl4Q
         t6LzLJLplJZLOe442huwRYrcJqSjpsIXUZxkVQUv7SgJ2FqxNx6MvX48M7NC21hcsfjE
         NH6Iq2c52Mr70Pa+4W6nJvbCaGOlARAOOSejtx9/ZVJlSMoXhmdfC9dGjTo+RKkjaFX/
         InkXY2x/Egp6uFo78d3fzovbCyDXbSEgZuEASF3OQYJGd5y9Vbqp1mZfaz/BfXC054RE
         A59CqnHOO5UwvyOM4BT5+MJe0uktSXO66tpszgKYP+IDAHQjHR2IIW/5qZ4xXtUw9JKi
         059Q==
X-Gm-Message-State: AOAM530BwlICZXYQwVGjtMqJrKiWOqtajtpXjMrOpH/DdaR+pe4rmDZH
        ofFgiAfFD64KshUYUehRJTpxXwEi5mWRjg==
X-Google-Smtp-Source: ABdhPJxw6/Er9BBRXlxfuHfbkZ4b+O1rW4C7bnIkAowcsBNLP4C8Of84IFg8ye6O+6E+pQDNN1yaMA==
X-Received: by 2002:a65:6a43:: with SMTP id o3mr27740873pgu.296.1609567431473;
        Fri, 01 Jan 2021 22:03:51 -0800 (PST)
Received: from localhost.localdomain (50-47-106-83.evrt.wa.frontiernet.net. [50.47.106.83])
        by smtp.gmail.com with ESMTPSA id q23sm55412110pgm.89.2021.01.01.22.03.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Jan 2021 22:03:50 -0800 (PST)
From:   Deepak Rawat <drawat.floss@gmail.com>
To:     linux-hyperv@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     Daniel Vetter <daniel@ffwll.ch>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Dexuan Cui <decui@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Wei Hu <weh@microsoft.com>,
        Tang Shaofeng <shaofeng.tang@intel.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Deepak Rawat <drawat.floss@gmail.com>
Subject: [PATCH 2/2] MAINTAINERS: Add maintainer for hyperv video device
Date:   Fri,  1 Jan 2021 22:03:36 -0800
Message-Id: <20210102060336.832866-2-drawat.floss@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210102060336.832866-1-drawat.floss@gmail.com>
References: <20210102060336.832866-1-drawat.floss@gmail.com>
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
index 7b073c41c3a0..e483fd32a684 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5515,6 +5515,14 @@ T:	git git://anongit.freedesktop.org/drm/drm-misc
 F:	Documentation/devicetree/bindings/display/himax,hx8357d.txt
 F:	drivers/gpu/drm/tiny/hx8357d.c
 
+DRM DRIVER FOR HYPERV SYNTHETIC VIDEO DEVICE
+M:	Deepak Rawat <drawat.floss@gmail.com>
+L:	linux-hyperv@vger.kernel.org
+L:	dri-devel@lists.freedesktop.org
+S:	Maintained
+T:	git git://anongit.freedesktop.org/drm/drm-misc
+F:	drivers/gpu/drm/tiny/hyperv_drm.c
+
 DRM DRIVER FOR ILITEK ILI9225 PANELS
 M:	David Lechner <david@lechnology.com>
 S:	Maintained
-- 
2.29.2

