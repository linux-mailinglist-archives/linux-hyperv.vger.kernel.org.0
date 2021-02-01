Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D1CC30AB70
	for <lists+linux-hyperv@lfdr.de>; Mon,  1 Feb 2021 16:34:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229607AbhBAPcw (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 1 Feb 2021 10:32:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229897AbhBAOtY (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 1 Feb 2021 09:49:24 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E565C0613D6;
        Mon,  1 Feb 2021 06:48:42 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id c127so13397334wmf.5;
        Mon, 01 Feb 2021 06:48:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/o1AU4sKwp6ojXc5n/yYkhB8n8PBKaJdVBIJIel2x9U=;
        b=g4Rf+VX6mgW6H9E4S00GWDSo0bQWDcqdNUNxhRAGqdigNpaBajBJbuLWaPyeBtAQ7X
         pyUJD3SgGJOjwp8GpLPzb5JGhKvwqp4Nd1o1njhN01qQ1BOOYYnshE1pH4WgP6Cmgbb4
         DJMfBnhq3x7c6yW21xrytgGpMGb4WsrqLiiHKgD3zzKlExUGf/K8RK8nDjjiTcMAgZkp
         1QWWrDHHC/nYmPo1prf1Fb334YMa+BSsojnF4MSKg1tnSKdYTOy48hOFXqqNiQ36SuQw
         1bt5o9uylvXtWFFHNSfpjieMG+0KiiG7SBNC9Cd00XHc4Eslq8Xk8JE37AhWRbG1gp4b
         /JHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/o1AU4sKwp6ojXc5n/yYkhB8n8PBKaJdVBIJIel2x9U=;
        b=FFl+XSCkuBVr+d5yz9m3BakLiuxYTErmInJjwxYwiRMzyV2h1QDeUkUnJt8g41+BoW
         Cm45czJSQ4om1fcQ0TtlL26nMlK4O4r+5ttp6R9zzPEvand35lOLZJsFmOsfJO1pMC7p
         sYh5I7skaldDqAYY7MNrJw4pPnGJ57SmMQVHQfrqrZALrx+ub3wlwWhnlxmCeUQ9U7YA
         rOD09vhAs1kMLTa8LMWhzgCtff1wZ0qk5n/AmWC+/qnAbvgKg/rUFwlceQhamJx0VQOA
         3VO+at1syaWEQIUVnN2Kme65w9jiihHQvQV899+52RtrXaFigyIlJgpGqdTeOBzJ4qLO
         /J3g==
X-Gm-Message-State: AOAM530cDKpdFA6MrF6MkFuafX7pCitk+dNVOmbjSRHmH6iXH0uU4nDW
        yyA2LELaw2EF0R82DRLTbOWfdYa3uzI2jaqv
X-Google-Smtp-Source: ABdhPJx0jwRs8e/HbRjdnVE28fdpv8+E4t7ETrthHahyxH9f0lAp1YvxuOuozXACO4PnrLMOZqwEJA==
X-Received: by 2002:a1c:c308:: with SMTP id t8mr3539658wmf.7.1612190920878;
        Mon, 01 Feb 2021 06:48:40 -0800 (PST)
Received: from anparri.mshome.net (host-95-238-70-33.retail.telecomitalia.it. [95.238.70.33])
        by smtp.gmail.com with ESMTPSA id c11sm26106591wrs.28.2021.02.01.06.48.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Feb 2021 06:48:40 -0800 (PST)
From:   "Andrea Parri (Microsoft)" <parri.andrea@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     "K . Y . Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        linux-hyperv@vger.kernel.org,
        Saruhan Karademir <skarade@microsoft.com>,
        Juan Vazquez <juvazq@microsoft.com>,
        "Andrea Parri (Microsoft)" <parri.andrea@gmail.com>
Subject: [PATCH v3 hyperv-next 3/4] Drivers: hv: vmbus: Enforce 'VMBus version >= 5.2' on isolated guests
Date:   Mon,  1 Feb 2021 15:48:13 +0100
Message-Id: <20210201144814.2701-4-parri.andrea@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210201144814.2701-1-parri.andrea@gmail.com>
References: <20210201144814.2701-1-parri.andrea@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Restrict the protocol version(s) that will be negotiated with the host
to be 5.2 or greater if the guest is running isolated.  This reduces the
footprint of the code that will be exercised by Confidential VMs and
hence the exposure to bugs and vulnerabilities.

Signed-off-by: Andrea Parri (Microsoft) <parri.andrea@gmail.com>
---
 drivers/hv/connection.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/hv/connection.c b/drivers/hv/connection.c
index 11170d9a2e1a5..c83612cddb995 100644
--- a/drivers/hv/connection.c
+++ b/drivers/hv/connection.c
@@ -244,6 +244,13 @@ int vmbus_connect(void)
 			break;
 	}
 
+	if (hv_is_isolation_supported() && version < VERSION_WIN10_V5_2) {
+		pr_err("Invalid VMBus version %d.%d (expected >= %d.%d) from the host supporting isolation\n",
+		       version >> 16, version & 0xFFFF, VERSION_WIN10_V5_2 >> 16, VERSION_WIN10_V5_2 & 0xFFFF);
+		ret = -EINVAL;
+		goto cleanup;
+	}
+
 	vmbus_proto_version = version;
 	pr_info("Vmbus version:%d.%d\n",
 		version >> 16, version & 0xFFFF);
-- 
2.25.1

