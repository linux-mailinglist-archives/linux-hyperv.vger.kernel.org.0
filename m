Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BD0D4E99F9
	for <lists+linux-hyperv@lfdr.de>; Mon, 28 Mar 2022 16:43:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244003AbiC1Oo5 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 28 Mar 2022 10:44:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244001AbiC1Oox (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 28 Mar 2022 10:44:53 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C09935F4FF;
        Mon, 28 Mar 2022 07:43:11 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id yy13so29179494ejb.2;
        Mon, 28 Mar 2022 07:43:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=k6Z2QAh69D2f3QVduoGx7amlvw7Kf+1kJe9caoLYo90=;
        b=Ki4xV6FbK/Bb9MVx3DDLR9ANFfqVPIk219k3dd+EjsBILtkGxKDryZivr6PqnEpi76
         hK/NogkvQF+7BD+pjn3/0QiIaJkI9CSfSXAFQILezgs3rL5gPonOMuEDsMEpt2U6iBy0
         Fjw7hksxTES7jI8Bvz0nGgXGKSfHuS+pYJHTFP10/ZatEJ07vsNP6gqiy1+ibRgP4ibk
         ovAzkumrDJiGfDz5roq9GIdxVcQuWGoUxowlSzckHcP13HY7xbAQ9b6Z5pGuXDtYvo6Z
         d69XBwKKlCumiJi/QdW2HE30Z53PFbSzsNA8MNg9RGxi+8sUAl/Y6AEyW8/fLGJkIBnb
         YnaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=k6Z2QAh69D2f3QVduoGx7amlvw7Kf+1kJe9caoLYo90=;
        b=4mn9+CAxFKgl7/kfbCauiFVU4EKCo2G+hvXvUbVDuwLcz5mtp4obPxjg67+WKvflpC
         CUS0XHnp3oUj+K/o0L5u/VKwz8n486KrUpjHKVqAuTGCOxJNs9o6usyN4F+pr3yGhUx/
         EPkRumjh6jGj1/sNKkMeNZfCDvSwlMM54jrSIF47D2Yo8B1XV+iqsgx5dACodTtV9G3K
         nmCmoc+s1VES6h3wlADxm4CzZ1p95NRR/y36zRVgKJMjaQnIv96+8DVoglpGlsLoD0Gy
         zat7kPTwfE/dO1Cd/GYHK8FTKISQbh+if7V12EsUys/S2Jf1bckIGE5HBVRwXiug347A
         kQpg==
X-Gm-Message-State: AOAM531O5N0ixjds0yp3VgnwlKJ1XXG/8npk7Y129gdX3Mii+DI4uzCs
        UA9gE5EmiU11roSntrKt/O0=
X-Google-Smtp-Source: ABdhPJwGwFyvK6uc931lKjO3/W0EPQcKDDaKNpIRB8yfeV8wwR1+sZsLc1txexrOi7g5qj5gVPZxlw==
X-Received: by 2002:a17:906:2bd7:b0:6cd:f89d:c828 with SMTP id n23-20020a1709062bd700b006cdf89dc828mr28190599ejg.232.1648478590143;
        Mon, 28 Mar 2022 07:43:10 -0700 (PDT)
Received: from anparri.mshome.net (host-82-59-4-232.retail.telecomitalia.it. [82.59.4.232])
        by smtp.gmail.com with ESMTPSA id g2-20020aa7c842000000b0041314b98872sm7008983edt.22.2022.03.28.07.43.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Mar 2022 07:43:09 -0700 (PDT)
From:   "Andrea Parri (Microsoft)" <parri.andrea@gmail.com>
To:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Wei Hu <weh@microsoft.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Wilczynski <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-hyperv@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Andrea Parri (Microsoft)" <parri.andrea@gmail.com>
Subject: [RFC PATCH 1/4] Drivers: hv: vmbus: Remove special code for unsolicited messages
Date:   Mon, 28 Mar 2022 16:42:41 +0200
Message-Id: <20220328144244.100228-2-parri.andrea@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220328144244.100228-1-parri.andrea@gmail.com>
References: <20220328144244.100228-1-parri.andrea@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

vmbus_requestor has included code for handling unsolicited messages
since its introduction with commit e8b7db38449ac ("Drivers: hv: vmbus:
Add vmbus_requestor data structure for VMBus hardening"); such code was
motivated by the early use of vmbus_requestor from storvsc.  Since
storvsc moved to a tag-based mechanism to generate/retrieve request IDs
with commit bf5fd8cae3c8f ("scsi: storvsc: Use blk_mq_unique_tag() to
generate requestIDs"), the special handling of unsolicited messages in
vmbus_requestor is not useful and can be removed.

Signed-off-by: Andrea Parri (Microsoft) <parri.andrea@gmail.com>
---
 drivers/hv/channel.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/drivers/hv/channel.c b/drivers/hv/channel.c
index dc5c35210c16a..a253eee3aeb1a 100644
--- a/drivers/hv/channel.c
+++ b/drivers/hv/channel.c
@@ -1243,11 +1243,7 @@ u64 vmbus_next_request_id(struct vmbus_channel *channel, u64 rqst_addr)
 
 	spin_unlock_irqrestore(&rqstor->req_lock, flags);
 
-	/*
-	 * Cannot return an ID of 0, which is reserved for an unsolicited
-	 * message from Hyper-V.
-	 */
-	return current_id + 1;
+	return current_id;
 }
 EXPORT_SYMBOL_GPL(vmbus_next_request_id);
 
@@ -1268,15 +1264,8 @@ u64 vmbus_request_addr(struct vmbus_channel *channel, u64 trans_id)
 	if (!channel->rqstor_size)
 		return VMBUS_NO_RQSTOR;
 
-	/* Hyper-V can send an unsolicited message with ID of 0 */
-	if (!trans_id)
-		return trans_id;
-
 	spin_lock_irqsave(&rqstor->req_lock, flags);
 
-	/* Data corresponding to trans_id is stored at trans_id - 1 */
-	trans_id--;
-
 	/* Invalid trans_id */
 	if (trans_id >= rqstor->size || !test_bit(trans_id, rqstor->req_bitmap)) {
 		spin_unlock_irqrestore(&rqstor->req_lock, flags);
-- 
2.25.1

