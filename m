Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB6D763313D
	for <lists+linux-hyperv@lfdr.de>; Tue, 22 Nov 2022 01:18:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231960AbiKVASZ (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 21 Nov 2022 19:18:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232125AbiKVAR7 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 21 Nov 2022 19:17:59 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E804162CB
        for <linux-hyperv@vger.kernel.org>; Mon, 21 Nov 2022 16:17:44 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id l39-20020a05600c1d2700b003cf93c8156dso10196814wms.4
        for <linux-hyperv@vger.kernel.org>; Mon, 21 Nov 2022 16:17:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DBm0aO6njd97POq/wB+tXVeMvSXktCMEQLJvOVvVo9k=;
        b=QkipcoTWJAojUZRK0iV6eTlABUK2HI9BibMryGJllSBzqvmFpz08OyrMH5zOoB9SBQ
         PFiGDs53J2wytqAwfl1esGqvt8IjPKM+/PUsMh7KkFkZdkSiEoJ7NsFZH7L9w63To3sw
         ZvMTak8+tIJni4RWh0jl0Bqn10ebvwRWTuRsZo3FqfW5tV83BcjK62IpRY2jfM8Ym0BA
         2RILBKhilPAcu/yqze/6nwMpsZA4xOlbfzyCT9K1kZ4Rkf9N2Om+MsL2kj7pZNURPOT0
         jFEn59tQU90qQgSkx9gsAoeH0QyQ8VRZCP1pJFn7mDiVAZ96zbMda71LfMstMzviQAcd
         ThPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DBm0aO6njd97POq/wB+tXVeMvSXktCMEQLJvOVvVo9k=;
        b=PbfnXJfgRlP+ks2cJe+DH14OP/LctOebtmNdZRjkSIntBpwKw33wkOhlW9xrInytUF
         sTw4fM9z/n8xYz3+Rjwuz6FkxQccR1d+NygzLQUEJAJskN+/xgVYNmNsZ6fD5d5MyQqK
         M7h6RIfA5GdOoCqlC9J/q9cEJRLxRHpu34/gnKEh/YAuV9OFSrk+M/a7b/dOj4QyRjIN
         e7JwXQka9hisXDXtIUXIaRnkuTFE86nvvJZaTk30k2R2S3FGuqoTj4A/Js5Y9WBypyU9
         crsxL27a2wHVKXr+Fm0BzGQttQlMNdM2jfzeIixCIuo9+8+mDWIzElT4MKyrbLhivUdD
         4QqA==
X-Gm-Message-State: ANoB5pl12QQ6ZeVfQJ1s3R+xxgsL8bxMGeQa/Wx771W8X47n2H3i9BCP
        T8I0ndR8o4YGRcVF0Mka77BQli6N+O7OvfnQ
X-Google-Smtp-Source: AA0mqf4nspS5htT218yiWPzchRclixqg0BC9As3WAjmCiR63dr4A5gxtMy2/AU3l5kEer4EeW7D2JQ==
X-Received: by 2002:a7b:c008:0:b0:3cf:a85d:2ab2 with SMTP id c8-20020a7bc008000000b003cfa85d2ab2mr4279101wmb.43.1669076262729;
        Mon, 21 Nov 2022 16:17:42 -0800 (PST)
Received: from niros.localdomain ([176.231.147.83])
        by smtp.gmail.com with ESMTPSA id t11-20020adff60b000000b0022e035a4e93sm12645078wrp.87.2022.11.21.16.17.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Nov 2022 16:17:42 -0800 (PST)
From:   Nir Levy <bhr166@gmail.com>
To:     linux-hyperv@vger.kernel.org, kys@microsoft.com,
        haiyangz@microsoft.com, sthemmin@microsoft.com,
        mikelley@microsoft.com
Cc:     bhr166@gmail.com
Subject: [PATCH] drivers: hv: vmbus: Fix possible memory leak when device_register() failed
Date:   Tue, 22 Nov 2022 02:17:24 +0200
Message-Id: <20221122001724.218299-1-bhr166@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

The reference must be released when device_register(&child_device_obj->device) failed.
Fix this by adding 'put_device()' in the error handling path.
---
 drivers/hv/vmbus_drv.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index 8b2e413bf19c..e592c481f7ae 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -2082,6 +2082,7 @@ int vmbus_device_register(struct hv_device *child_device_obj)
 	ret = device_register(&child_device_obj->device);
 	if (ret) {
 		pr_err("Unable to register child device\n");
+		put_device(&child_device_obj->device);
 		return ret;
 	}
 
-- 
2.34.1

