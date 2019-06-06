Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 91C5336E17
	for <lists+linux-hyperv@lfdr.de>; Thu,  6 Jun 2019 10:05:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726593AbfFFIFW (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 6 Jun 2019 04:05:22 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:41222 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725769AbfFFIFW (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 6 Jun 2019 04:05:22 -0400
Received: by mail-pg1-f195.google.com with SMTP id 83so892603pgg.8;
        Thu, 06 Jun 2019 01:05:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ouvvf9dJU+os5Ak7rjWYZrZK3ACKmLEodaHvlTlzcEc=;
        b=ZH5VoJzSi6DSD799sd022i6+YXg7iXxAbZ7USRkscKg7Urms6QlI4mJ/URqAOeJ8qJ
         Z5IJ/vM7+6NVRNYRTsHdN1pyOYqrOF7gsNHIMeBUXVHNoOFAoxKUGSMBcZv6K4M/kWWj
         caNF7jyNypmFzh0L6U1YVHTjMmKki0Nwi5aSb9KI95MaeS2Xzl68lmgEocLGDGWj6i2X
         REE/BNWqnzXaVyJXnXv8WYcne1gDNjtxYb/01QixAAwG/+ENh1rfVQHCYU3JQq2P8A9J
         67VapW8e8fy1zLssEqI1Ded2ehuU0YiBkqNE9SzJtjG67C+gt9nHUlK3yKq07IMFLiKg
         hQ7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ouvvf9dJU+os5Ak7rjWYZrZK3ACKmLEodaHvlTlzcEc=;
        b=PuKqTzs5cBKu991WbFLK6WLQ/QBhvelUV7E41oaEaWL0tv+JL8pX4qQc6YQ66UPkrG
         kkjN8Y5RbmkWotIOsZ9FKsIQ9OiHSsFabmetsve8IZDaVQnzzcmXZV4j6i3YqSd64mBK
         Ox7ccETGwroLx2A3pTsLZTdOvHTKa82XS2npbs12cOtC5bHwiLF4kAO8+hpXmRc0Bab+
         cGJYXXtq6NFh2tq6I5b1zCxFdW99AmPzq7pX4DVUKTVgeairuFp+vJGwZ7ly7pvp2XhO
         eme+gIiox8vMscEf8942K9KaACAb8SNX0+vG4SfS/XDhIDksDjSgOlA/0licywYQ/8C9
         AOoQ==
X-Gm-Message-State: APjAAAUc++YrdoxigEZ4nJ+D/fIwOuGonBLGczr9j87y0rcgFqlQiDWu
        +BhW5ge+zl6MYF604VEE9g5nVL9JQSI=
X-Google-Smtp-Source: APXvYqxj1+DHpVWOnnaeWKG7SeN92b76OfgMqw504KhsCqTwFbSEryXEoLDgOFWQej9QqZwmxSnfmw==
X-Received: by 2002:a65:5004:: with SMTP id f4mr2253196pgo.268.1559808321065;
        Thu, 06 Jun 2019 01:05:21 -0700 (PDT)
Received: from maya190131 ([13.66.160.195])
        by smtp.gmail.com with ESMTPSA id m6sm1216015pjl.18.2019.06.06.01.05.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 06 Jun 2019 01:05:20 -0700 (PDT)
Date:   Thu, 6 Jun 2019 08:05:20 +0000
From:   Maya Nakamura <m.maya.nakamura@gmail.com>
To:     mikelley@microsoft.com, kys@microsoft.com, haiyangz@microsoft.com,
        sthemmin@microsoft.com, sashal@kernel.org
Cc:     x86@kernel.org, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/5] x86: hv: hv_init.c: Add functions to
 allocate/deallocate page for Hyper-V
Message-ID: <5cf4ad6f3fae8dec33e364b367b99cbb5b0f2ba4.1559807514.git.m.maya.nakamura@gmail.com>
References: <cover.1559807514.git.m.maya.nakamura@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1559807514.git.m.maya.nakamura@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Introduce two new functions, hv_alloc_hyperv_page() and
hv_free_hyperv_page(), to allocate/deallocate memory with the size and
alignment that Hyper-V expects as a page. Although currently they are
not used, they are ready to be used to allocate/deallocate memory on x86
when their ARM64 counterparts are implemented, keeping symmetry between
architectures with potentially different guest page sizes.

Signed-off-by: Maya Nakamura <m.maya.nakamura@gmail.com>
---
 arch/x86/hyperv/hv_init.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
index e4ba467a9fc6..84baf0e9a2d4 100644
--- a/arch/x86/hyperv/hv_init.c
+++ b/arch/x86/hyperv/hv_init.c
@@ -98,6 +98,20 @@ EXPORT_SYMBOL_GPL(hyperv_pcpu_input_arg);
 u32 hv_max_vp_index;
 EXPORT_SYMBOL_GPL(hv_max_vp_index);
 
+void *hv_alloc_hyperv_page(void)
+{
+	BUILD_BUG_ON(!(PAGE_SIZE == HV_HYP_PAGE_SIZE));
+
+	return (void *)__get_free_page(GFP_KERNEL);
+}
+EXPORT_SYMBOL_GPL(hv_alloc_hyperv_page);
+
+void hv_free_hyperv_page(unsigned long addr)
+{
+	free_page(addr);
+}
+EXPORT_SYMBOL_GPL(hv_free_hyperv_page);
+
 static int hv_cpu_init(unsigned int cpu)
 {
 	u64 msr_vp_index;
-- 
2.17.1

