Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9C3D066913
	for <lists+linux-hyperv@lfdr.de>; Fri, 12 Jul 2019 10:25:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726057AbfGLIZU (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 12 Jul 2019 04:25:20 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:46204 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725877AbfGLIZT (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 12 Jul 2019 04:25:19 -0400
Received: by mail-pf1-f194.google.com with SMTP id c73so3974274pfb.13;
        Fri, 12 Jul 2019 01:25:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=HNJi6hiuYdfL3u8IXlFr2ptQbwtW7ZdNyo5Hq+iVFb0=;
        b=Fyl9TSOdi1j2XjtjDLhiWaqB0DR7tBZfgMMw50+vW0/xhDGFPXEnBIm5n0r/NH1kCW
         2ZHdnbb+zwOvkoRgSuOcLVwFZOtTo5Z0qripJEWoYTVf0C/gY/3lgjFmDA2ICnAxPa33
         QufU1HLF9B4rOLYz5QeL/SoM504liKmkClv5IHra9ZntnJ592tRlOEU6gMGLG9paHjhr
         mgdLkRN1hKYdFsoqPN9QodWAvWbjK35mKeygwo39PmDNDBmWOLS44OuQhm4lJn9TyYOa
         1rco+h38lsbWpXwQXI6nb0noKdxK+3dWK9DndsOA+Ng+6A5K5ySQlHMy43LMI/Iug9w3
         ssWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=HNJi6hiuYdfL3u8IXlFr2ptQbwtW7ZdNyo5Hq+iVFb0=;
        b=VN4UDX1w7pNMD95UfvZALG7s6eDx6uss+9aMxHJOMNNoUpLvclDMnXkMp3QVb1oAp9
         //9Zx7xb6510dRdzty3WoP39mh4qH1GMTmb4acpjMeQ22fy910Pw3a/MZ0i+s4KhienR
         RcAzWRDWXCHiEtTFC+lNaSt63Dj4TwSNFpEz9sxhdXMyziUcMGx+u9LHqYSIXRm5HZEk
         4oMsIPDIaMYm8V3HT9z75uWFk1BfeOqWhWOWnKF0q/NydSKvndPIjGkEIjq1GRRkOghx
         irIEZzsZ9q6xTqdKY81zcwoKKNQ000MW1pySt6qljQWHRiAAqpmO4/87qprDC5bdm26i
         sleQ==
X-Gm-Message-State: APjAAAUONp3grNvWB2IUm+gONnLFqE8gtp0bkG1vczn1alXq20J1NRYG
        RslZa/d0cv7Np8ZT9T6QP9F8G8p8X1XM5Q==
X-Google-Smtp-Source: APXvYqyZqz2vlQC4nbOA8cCJaC3xgKjcnepceJpYKLsSmt+PKJ7es87hhkONCLHvij6MF5XeRwPE0Q==
X-Received: by 2002:a65:6448:: with SMTP id s8mr9376254pgv.223.1562919918915;
        Fri, 12 Jul 2019 01:25:18 -0700 (PDT)
Received: from maya190711 ([52.250.118.122])
        by smtp.gmail.com with ESMTPSA id m13sm6175192pgv.89.2019.07.12.01.25.18
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 12 Jul 2019 01:25:18 -0700 (PDT)
Date:   Fri, 12 Jul 2019 08:25:18 +0000
From:   Maya Nakamura <m.maya.nakamura@gmail.com>
To:     mikelley@microsoft.com, kys@microsoft.com, haiyangz@microsoft.com,
        sthemmin@microsoft.com, sashal@kernel.org
Cc:     x86@kernel.org, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 3/5] hv: vmbus: Replace page definition with Hyper-V
 specific one
Message-ID: <0d9e80ecabcc950dc279fdd2e39bea4060123ba4.1562916939.git.m.maya.nakamura@gmail.com>
References: <cover.1562916939.git.m.maya.nakamura@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1562916939.git.m.maya.nakamura@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Replace PAGE_SIZE with HV_HYP_PAGE_SIZE because the guest page size may
not be 4096 on all architectures and Hyper-V always runs with a page
size of 4096.

Signed-off-by: Maya Nakamura <m.maya.nakamura@gmail.com>
Reviewed-by: Michael Kelley <mikelley@microsoft.com>
Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 drivers/hv/hyperv_vmbus.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/hv/hyperv_vmbus.h b/drivers/hv/hyperv_vmbus.h
index 362e70e9d145..019469c3cbca 100644
--- a/drivers/hv/hyperv_vmbus.h
+++ b/drivers/hv/hyperv_vmbus.h
@@ -192,11 +192,11 @@ int hv_ringbuffer_read(struct vmbus_channel *channel,
 		       u64 *requestid, bool raw);
 
 /*
- * Maximum channels is determined by the size of the interrupt page
- * which is PAGE_SIZE. 1/2 of PAGE_SIZE is for send endpoint interrupt
- * and the other is receive endpoint interrupt
+ * Maximum channels, 16348, is determined by the size of the interrupt page,
+ * which is HV_HYP_PAGE_SIZE. 1/2 of HV_HYP_PAGE_SIZE is to send endpoint
+ * interrupt, and the other is to receive endpoint interrupt.
  */
-#define MAX_NUM_CHANNELS	((PAGE_SIZE >> 1) << 3)	/* 16348 channels */
+#define MAX_NUM_CHANNELS	((HV_HYP_PAGE_SIZE >> 1) << 3)
 
 /* The value here must be in multiple of 32 */
 /* TODO: Need to make this configurable */
-- 
2.17.1

