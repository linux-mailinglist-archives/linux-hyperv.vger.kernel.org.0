Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A76D370DDC
	for <lists+linux-hyperv@lfdr.de>; Sun,  2 May 2021 18:18:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232230AbhEBQSz (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sun, 2 May 2021 12:18:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230110AbhEBQSz (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Sun, 2 May 2021 12:18:55 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 217AAC06174A;
        Sun,  2 May 2021 09:18:04 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id d10so1992289pgf.12;
        Sun, 02 May 2021 09:18:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=G8PwBdGIDFXi8DL6S5B96fgDJSf68cMbk9MM93GuLb8=;
        b=NGjgfhgP5Kz/zIBjKbDdRk08XqS6IRvcM3TgBu0WbQtbvXwNMJGqH71VKiS3Bg0Sp6
         u9MwBxE8XD2W5V866Axa4yIzXNPVTMHzxuhZU/UgtGaXwtMnX4+MLE4e4K4u2PhGqG6y
         Qmdht1wqh9MRMiskgpAvIM/lTenfxdV5dUxgWU67M3wl5KgxOs73LbCt32dyT8mV1EvJ
         rc0R8MiyBWIeXuhfME4GF29b6kFPIFgjjBLqZzNwjh/8AdyXi/WlqxcIlY5DOWBEXzrJ
         FG6IJCXVxMmI23wYlr72o/7IGtwSn1emo6EhVf2UueKW2CrbB8nNJgU62xJ/AQHsaekd
         zFfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=G8PwBdGIDFXi8DL6S5B96fgDJSf68cMbk9MM93GuLb8=;
        b=Gs7Wu12lbEe9YBV1whD1q4QinPtoUsGceGFKUEXbMNrVzVVCyJQXCAT8pBNcWFU8Dk
         6HY5g6E3nzYm31Fjh+zX/JEALO1y2bevrsYSPWpKF3mPpy+31YPMqR3K0ygi9F6qh+Uj
         zJd3BjmU0W4m/6hGUSL/j4nqbopf3p2S7Sgt7+J86tbrq5kGiT3TjRa3WAM/XbS3+5ho
         M84rfL69e85LmblfSp/neutKq2/kpMhfDsk58trxPSG9LGIyi5T19yIZQ3Y0x0DiJZhX
         pOohlyHHAqI9VbzYsUbXdu70V/qkf8Waj/U+bFNYX1sQtFFVCNvdfKxV5oXcO630WjdT
         540A==
X-Gm-Message-State: AOAM533KcGxYIBC8txh7J5W9Yi9839Q5wgUhrPbbBj3HRkjs9HG7k7LY
        MEOcrdiawV72Q1ansmJ+15nv7zv4yI3RTH9r4pwdj3JG
X-Google-Smtp-Source: ABdhPJw7TeIfztwe4iXqg3z+DF0jLO9LrSX7vnK2rcSilC0eNWhzSUUYfebfYb134+S6so67J7mvuA==
X-Received: by 2002:a63:f258:: with SMTP id d24mr14197280pgk.174.1619972283685;
        Sun, 02 May 2021 09:18:03 -0700 (PDT)
Received: from fedora ([103.125.235.29])
        by smtp.gmail.com with ESMTPSA id n8sm6688050pfu.111.2021.05.02.09.17.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 May 2021 09:18:03 -0700 (PDT)
Date:   Sun, 2 May 2021 11:17:52 -0500
From:   Nigel Christian <nigel.l.christian@gmail.com>
To:     "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>
Cc:     linux-hyperv@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] hv_balloon: remove redundant assignment
Message-ID: <YI7QsN9cY/Z9NgW4@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

The variable region_start is being assigned a value that is
not read. Remove it.

Addresses-Coverity: ("Unused value")
Signed-off-by: Nigel Christian <nigel.l.christian@gmail.com>
---
 drivers/hv/hv_balloon.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/hv/hv_balloon.c b/drivers/hv/hv_balloon.c
index 58af84e30144..7f11ea07d698 100644
--- a/drivers/hv/hv_balloon.c
+++ b/drivers/hv/hv_balloon.c
@@ -1010,7 +1010,6 @@ static void hot_add_req(struct work_struct *dummy)
 		 * that need to be hot-added while ensuring the alignment
 		 * and size requirements of Linux as it relates to hot-add.
 		 */
-		region_start = pg_start;
 		region_size = (pfn_cnt / HA_CHUNK) * HA_CHUNK;
 		if (pfn_cnt % HA_CHUNK)
 			region_size += HA_CHUNK;
-- 
2.31.1

