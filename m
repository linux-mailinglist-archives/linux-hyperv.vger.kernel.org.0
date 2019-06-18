Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1507D49A45
	for <lists+linux-hyperv@lfdr.de>; Tue, 18 Jun 2019 09:18:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725919AbfFRHS5 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 18 Jun 2019 03:18:57 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:46526 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725900AbfFRHS5 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 18 Jun 2019 03:18:57 -0400
Received: by mail-pl1-f193.google.com with SMTP id e5so5298741pls.13;
        Tue, 18 Jun 2019 00:18:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9SP9uqBfa577y4F42b9AqTEJcR+B1XMFG1PF2pX07MA=;
        b=lb4q+R/UEvyQZ08PlnQSuDevHiuHIIzSn3Yj2DIGmGAmeFS4FEmMtMhFckfnYzUQzY
         QCHqN8k0Hw7suErE73R1n6sI7J3TAlgJYrIIgD69u89pgJFmriA8Zdas3ZVnjnXBCyyJ
         wUqDlAVj1R8nfl/Q79fu5ntbUOoReEnibFyntGAf/KQPeUTLQR8DnqZ/hRfa6LI2K5DR
         ynRXu3b5B38DE91u/jsOgfpvPEtCpeQJ4zkyd1HR5uVqaM1v6WXIrokR1E+fLUdIH/ZM
         zxNsrmj2Wy/CZXdBAZuXu/KcyPDHYIWb8bWV/VwV6b5BneJP5P2vBo/iOOntaWbeIxf3
         ET4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9SP9uqBfa577y4F42b9AqTEJcR+B1XMFG1PF2pX07MA=;
        b=AIDApinv4ZFTNVVgVkfE5yLR0ZHcEjuh0oiOmn+onLfutt24vy6aWdEgFxp218Rrpx
         HLg/991rpa+lpSSOMb6XnjKWeDN3Q97Zfv6vuXBWnBSDO6YZXSFNKXtSHAVsAE48iM3s
         P+w/kxvBh1fFxpRWJFGo5vVaRpJxoRgcqHwt5k8td/L1Pw/x3UzvkJ84g+PtmbjnuLds
         86aK7QMpHBKOqIe6niBMuZam0W0ntf1FMYXIn6z4h+5iIGosL+uvbU7uqpKVDf1k7Ryo
         hQGvJqZlU/dT8sFmOQGI6Qp+bcWVPmHAGZhs9rkiVA91OlrhAIopJ/IthBHDH1OJcPi5
         7foQ==
X-Gm-Message-State: APjAAAUcYHUVqHhCxQeAX+jYnn0NoMBsC1ckHotBYhTYDwKUdhnSLJ99
        VZZoM+S7HTWaQqnKqovnKEMvgLJvpBk=
X-Google-Smtp-Source: APXvYqz60fEoiLIuJqC3LO7Hilm9ePItQ9CaC2RXYfG74Fs73qPxiydc3yBZyWxTxPkAY/XPAuXN7A==
X-Received: by 2002:a17:902:3103:: with SMTP id w3mr2257057plb.84.1560838283094;
        Mon, 17 Jun 2019 23:11:23 -0700 (PDT)
Received: from maya190131 ([13.66.160.195])
        by smtp.gmail.com with ESMTPSA id c26sm13070476pfr.71.2019.06.17.23.11.22
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 17 Jun 2019 23:11:23 -0700 (PDT)
Date:   Tue, 18 Jun 2019 06:11:22 +0000
From:   Maya Nakamura <m.maya.nakamura@gmail.com>
To:     mikelley@microsoft.com, kys@microsoft.com, haiyangz@microsoft.com,
        sthemmin@microsoft.com, sashal@kernel.org
Cc:     x86@kernel.org, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/5] x86: hv: hyperv-tlfs.h: Create and use Hyper-V page
 definitions
Message-ID: <01d19ae7b855d72f6f4fa09bd954aeb3863d170f.1560837096.git.m.maya.nakamura@gmail.com>
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

Define HV_HYP_PAGE_SHIFT, HV_HYP_PAGE_SIZE, and HV_HYP_PAGE_MASK because
the Linux guest page size and hypervisor page size concepts are
different, even though they happen to be the same value on x86.

Also, replace PAGE_SIZE with HV_HYP_PAGE_SIZE.

Signed-off-by: Maya Nakamura <m.maya.nakamura@gmail.com>
Reviewed-by: Michael Kelley <mikelley@microsoft.com>
Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 arch/x86/include/asm/hyperv-tlfs.h | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/hyperv-tlfs.h b/arch/x86/include/asm/hyperv-tlfs.h
index af78cd72b8f3..4097edf552b3 100644
--- a/arch/x86/include/asm/hyperv-tlfs.h
+++ b/arch/x86/include/asm/hyperv-tlfs.h
@@ -12,6 +12,16 @@
 #include <linux/types.h>
 #include <asm/page.h>
 
+/*
+ * While not explicitly listed in the TLFS, Hyper-V always runs with a page size
+ * of 4096. These definitions are used when communicating with Hyper-V using
+ * guest physical pages and guest physical page addresses, since the guest page
+ * size may not be 4096 on all architectures.
+ */
+#define HV_HYP_PAGE_SHIFT	12
+#define HV_HYP_PAGE_SIZE	BIT(HV_HYP_PAGE_SHIFT)
+#define HV_HYP_PAGE_MASK	(~(HV_HYP_PAGE_SIZE - 1))
+
 /*
  * The below CPUID leaves are present if VersionAndFeatures.HypervisorPresent
  * is set by CPUID(HvCpuIdFunctionVersionAndFeatures).
@@ -847,7 +857,7 @@ union hv_gpa_page_range {
  * count is equal with how many entries of union hv_gpa_page_range can
  * be populated into the input parameter page.
  */
-#define HV_MAX_FLUSH_REP_COUNT ((PAGE_SIZE - 2 * sizeof(u64)) /	\
+#define HV_MAX_FLUSH_REP_COUNT ((HV_HYP_PAGE_SIZE - 2 * sizeof(u64)) / \
 				sizeof(union hv_gpa_page_range))
 
 struct hv_guest_mapping_flush_list {
-- 
2.17.1

