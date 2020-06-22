Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E264203557
	for <lists+linux-hyperv@lfdr.de>; Mon, 22 Jun 2020 13:07:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728004AbgFVLHQ (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 22 Jun 2020 07:07:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727022AbgFVLHN (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 22 Jun 2020 07:07:13 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A6C7C061795
        for <linux-hyperv@vger.kernel.org>; Mon, 22 Jun 2020 04:07:12 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id b5so8249078pfp.9
        for <linux-hyperv@vger.kernel.org>; Mon, 22 Jun 2020 04:07:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ab8o2nPGdE8bnf0LA3qbabJWv4jn3emYdoE+fNSfqxw=;
        b=IoB0ZEdX/hknjXqdON8/n4h8CPhLBxYL5QvUfvcElIEieMPw2zn85+JnDD7JD/jtKM
         KqnqllJQdOk70ia7DrF5RNALrigLThNMWpQYZBHVFCft7ZdstokVmwucJItbyQyU5lgo
         wKO/gnDE+yFn+31zkdTc+zSCRZnDzcEY3hLKqiIUGeTVJKAml4SRl22YlNZrUsokkWAu
         HyRxm7BdMRwhN0Qnu3/NLZv5WPKNB4VQ4Y7onPov8CzYwq6+w2X3QNMm3bejXrwru/IG
         3W4vspkuQRYSBCHz3L3+6kqniqES65phLG/DCNKaEG6IN2hllmEZdjDwtFoc+UO0DKvf
         camw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ab8o2nPGdE8bnf0LA3qbabJWv4jn3emYdoE+fNSfqxw=;
        b=NgXky5reSR0P5/AVpnCLiiwV3d5y6O0u5fr3OXpyqZdJt3Vkq7x/+C2MCU9C/GvmMA
         5LNPXyHMbycBn5bolvaq+7VbpiL4xvBd7PKzVPvKjAkzs/LpKkT+BokmBmgi7CRItboI
         ZXUD3/A8hLhKhW2HJJMYJ951l+igppO9TevSmZql4azE5/aUaVXL5HdARQdNwg4/DBTl
         +Yudndh71LYcjMdt3trpGaqnl6oGyIy48lOTv6DN1LWio93jRm/LAvj3lRH5PxbMk4yU
         2wY5VVfwLJ5xCOZEGYEfZPiJs8U+bnlins/dUjnGicEMVZnao0Q1l0SwW8lw/Kc3ABrk
         ivDg==
X-Gm-Message-State: AOAM531QtdNG94PzECGwifS4lhDJQQq6sv4bVJV/rTIzIE1ehC4b1GDx
        chLIvOyxb3OTQsz6OQlTJT2gT4TqkmM=
X-Google-Smtp-Source: ABdhPJxaLahvrHInINhZhV1gz/6cVSkEzOnlNKTuFwDiM+46Y7pPCLa/5J777pXM/zPY2RFPZWGGAQ==
X-Received: by 2002:aa7:8ecd:: with SMTP id b13mr20806974pfr.297.1592824031518;
        Mon, 22 Jun 2020 04:07:11 -0700 (PDT)
Received: from arch.hsd1.wa.comcast.net ([2601:600:9500:4390::d3ee])
        by smtp.gmail.com with ESMTPSA id j10sm6284217pgh.28.2020.06.22.04.07.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2020 04:07:11 -0700 (PDT)
From:   Deepak Rawat <drawat.floss@gmail.com>
To:     linux-hyperv@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        K Y Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Wei Hu <weh@microsoft.com>,
        Jork Loeser <jloeser@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Deepak Rawat <drawat.floss@gmail.com>
Subject: [RFC PATCH 2/2] MAINTAINERS: Add maintainer for hyperv video device
Date:   Mon, 22 Jun 2020 04:06:23 -0700
Message-Id: <20200622110623.113546-3-drawat.floss@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200622110623.113546-1-drawat.floss@gmail.com>
References: <20200622110623.113546-1-drawat.floss@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Maintainer for hyperv synthetic video device.

Signed-off-by: Deepak Rawat <drawat.floss@gmail.com>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index f437f42b73ad..102f734b99bd 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5316,6 +5316,14 @@ T:	git git://anongit.freedesktop.org/drm/drm-misc
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
2.27.0

