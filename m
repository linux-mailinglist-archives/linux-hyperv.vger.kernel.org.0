Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9D9AA49926
	for <lists+linux-hyperv@lfdr.de>; Tue, 18 Jun 2019 08:45:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726413AbfFRGpc (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 18 Jun 2019 02:45:32 -0400
Received: from mail-vk1-f196.google.com ([209.85.221.196]:44122 "EHLO
        mail-vk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726158AbfFRGpb (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 18 Jun 2019 02:45:31 -0400
Received: by mail-vk1-f196.google.com with SMTP id w186so2571389vkd.11;
        Mon, 17 Jun 2019 23:45:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ReyzkEJ0mqgLcwXEOt1orApmxGBjw7txCjk9AIkHxWA=;
        b=ADV+E6NpxQ50gJHp6hd6dI8C+jQrTYyObZBldrnzIVa2WLszDwucTA6CiLBcDnQN8X
         frAmZ+MA9IHvI6SgjVQ2/FWtdzYAIe694fBaqFbSgJVFAntiKq+9xDjM7s7YJB/6NYy8
         cwu/oggvpOHjdlFzfMvswb8dkQp4bEUN49s9uhxnhIu5+st3CiIlBvfi5v/36zNgVnAm
         Ju4rLyYDS9/RXQa1+R/Qy+v/HMgA4mmtdqXvBUKFj58eprQ8q6GqLAqc8hGd70x8RIc4
         hfqGJ0zshAxEBeH0exILboBmbeo/1cE14rKdd3TYx6ioCx+QVF0G9fqq819K9D0L5Py7
         YOjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ReyzkEJ0mqgLcwXEOt1orApmxGBjw7txCjk9AIkHxWA=;
        b=PBC9pdiUUlXEfP0n1f0RVRvp5KgFqYNg59alKMpldhkwfPNbH/d+K97yjPQIAct0H1
         vF8nuGm/vpsNtaOxIv2PHWEVbmHR34NmDjcsW5XSBupjfYW4OIC+9mTAZTGmPJEbphgq
         JUau1MjmcoDzz2hIIFC/B+1kJ+/8h3NKYfHwJPC4iVdrZUPpdSUXF6qV8iPahhvvhb/F
         OP23TbczqLK1YgXL7vbTrs4kyf9innKz7BYF4FOlFVRjUkA75Qt9Vn//4piJppwQ1Flw
         wS/SZbzMQyIyUTD2pTLZem2Fa5WXmQ0sc3DX/rStyQsk8YIqdsVPBhiPxPXWnv8mB7O3
         7VJQ==
X-Gm-Message-State: APjAAAWhwNdKLCj91WudWf+2KNKwf+D2v6EnS3x6+lRCtws79gIieY/7
        jxhQQsZVfqcsuclopvatG/1UZRVuFHk=
X-Google-Smtp-Source: APXvYqwlkXGD+qYFV6HV681y30CFFECs91e5IG9gbYhPtEYIiiGhdfnV9MsIND0ZgcRhLhSp6r4tDQ==
X-Received: by 2002:a63:e649:: with SMTP id p9mr1109979pgj.276.1560838389298;
        Mon, 17 Jun 2019 23:13:09 -0700 (PDT)
Received: from maya190131 ([13.66.160.195])
        by smtp.gmail.com with ESMTPSA id z74sm6415835pgz.41.2019.06.17.23.13.09
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 17 Jun 2019 23:13:09 -0700 (PDT)
Date:   Tue, 18 Jun 2019 06:13:08 +0000
From:   Maya Nakamura <m.maya.nakamura@gmail.com>
To:     mikelley@microsoft.com, kys@microsoft.com, haiyangz@microsoft.com,
        sthemmin@microsoft.com, sashal@kernel.org
Cc:     x86@kernel.org, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/5] x86: hv: hv_init.c: Add functions to
 allocate/deallocate page for Hyper-V
Message-ID: <d19c28cda88bf1706baff883380dfd321da30a68.1560837096.git.m.maya.nakamura@gmail.com>
References: <cover.1560837096.git.m.maya.nakamura@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1560837096.git.m.maya.nakamura@gmail.com>
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

Link: https://lore.kernel.org/lkml/87muindr9c.fsf@vitty.brq.redhat.com/
Signed-off-by: Maya Nakamura <m.maya.nakamura@gmail.com>
Reviewed-by: Michael Kelley <mikelley@microsoft.com>
Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 arch/x86/hyperv/hv_init.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
index 0e033ef11a9f..e8960a83add7 100644
--- a/arch/x86/hyperv/hv_init.c
+++ b/arch/x86/hyperv/hv_init.c
@@ -37,6 +37,20 @@ EXPORT_SYMBOL_GPL(hyperv_pcpu_input_arg);
 u32 hv_max_vp_index;
 EXPORT_SYMBOL_GPL(hv_max_vp_index);
 
+void *hv_alloc_hyperv_page(void)
+{
+	BUILD_BUG_ON(PAGE_SIZE != HV_HYP_PAGE_SIZE);
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

