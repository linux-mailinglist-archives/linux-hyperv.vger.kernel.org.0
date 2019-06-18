Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 16C0D49A2C
	for <lists+linux-hyperv@lfdr.de>; Tue, 18 Jun 2019 09:16:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726676AbfFRHQX (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 18 Jun 2019 03:16:23 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:42778 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725955AbfFRHQX (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 18 Jun 2019 03:16:23 -0400
Received: by mail-pl1-f196.google.com with SMTP id ay6so3083807plb.9;
        Tue, 18 Jun 2019 00:16:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=HNJi6hiuYdfL3u8IXlFr2ptQbwtW7ZdNyo5Hq+iVFb0=;
        b=Y+ThJ5pCj+BAiwHO4j2p2nYITjKlpl+FSuLSTNOe+TBAgWSMDCYqb8cPLlvg0F1dth
         HnhM5kNjqYivCUy7GrQd16xPch7qNWQX18sl65tAEEtv2Df2RwLmv2I0D+LUcee1jdVX
         KGaclhr/o20kE66rX6k4zqkjW2TIjWOUzINkK/LYswE9neLxBEuDN+PAnIUsgXtgSBgx
         AQPuhtt8NnsINJQNjvoNXPgmbajWFp9UtDyJ2kZSvPNkmyi+964tUXmqTiwhy21ZhtPT
         AvgX+EE4PPKYe1X/jfll6qk8oltbqEu4yW3hADikabGGGThnwh0+BNCoQXmNd2V37UEi
         aorg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=HNJi6hiuYdfL3u8IXlFr2ptQbwtW7ZdNyo5Hq+iVFb0=;
        b=NAdxBpHrDzKwyjsqWUqBvfN78Soq1paImQTbXMniFZ7uDQVL5obhxofqHM+w5VakJz
         UgssxdH7goOMeaCwQkZkwNn3uZrAZzquh5KV0TBfmT8x6HcBX66brZoT/UV+hT7jA2B9
         BSR68vjXg5+H53+qqXPYVNNaXZi9h0wN9q/0Dc6mlyu190SDNUaVUKbpEO9gtWKtZ+7H
         g85D7W/ZfgtEXxhE+ues1iR7trCP2CQ7MTbL2g9f+sY4dEqs5C85UvU169S8Riiqv0l7
         ZgPwbNfRpMhnOgAV/d9jLGVN+vhCaASCpChk7CnFVSEEpXTdWuj/UX84WLPDdA6zEbDl
         CWpQ==
X-Gm-Message-State: APjAAAUQ3rhkujsWpTPHtfs/hsfKua0ISM9swD7/520xKAhH7OEMxsbE
        q/AVNiC6ofEWrSecF5PVvRFUeMSxm8Y=
X-Google-Smtp-Source: APXvYqzQY3y9xEauwLFI59PlhTMcKf6K26shYUvaumGkoTV5SyH8/M3fZ5Z05bsG0ptz3yCTmUM1sg==
X-Received: by 2002:a17:902:d715:: with SMTP id w21mr112846469ply.234.1560838478885;
        Mon, 17 Jun 2019 23:14:38 -0700 (PDT)
Received: from maya190131 ([13.66.160.195])
        by smtp.gmail.com with ESMTPSA id a7sm13038951pgj.42.2019.06.17.23.14.38
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 17 Jun 2019 23:14:38 -0700 (PDT)
Date:   Tue, 18 Jun 2019 06:14:38 +0000
From:   Maya Nakamura <m.maya.nakamura@gmail.com>
To:     mikelley@microsoft.com, kys@microsoft.com, haiyangz@microsoft.com,
        sthemmin@microsoft.com, sashal@kernel.org
Cc:     x86@kernel.org, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/5] hv: vmbus: Replace page definition with Hyper-V
 specific one
Message-ID: <aef1958c0b0a5d005899620d205a55b2c91f7f78.1560837096.git.m.maya.nakamura@gmail.com>
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

