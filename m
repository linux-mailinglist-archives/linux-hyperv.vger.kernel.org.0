Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D927429693
	for <lists+linux-hyperv@lfdr.de>; Mon, 11 Oct 2021 20:12:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234137AbhJKSOz (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 11 Oct 2021 14:14:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233422AbhJKSOz (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 11 Oct 2021 14:14:55 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11BC7C061570;
        Mon, 11 Oct 2021 11:12:55 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id g13-20020a17090a3c8d00b00196286963b9so51569pjc.3;
        Mon, 11 Oct 2021 11:12:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8H47ocDcATCEcdvQX+LbcVgPZyzX/fIx4WAwDOmGCq4=;
        b=TBkCc9pHdBDkJzoQ0FC/yWxYnR4OikqY+eKeU53n7352DiHr0vwmSh/vKXoS1wPZvR
         8bRamtKpp38BYASttA4n588uD8rIpkW+vekDneKTcyMAaTThsAWBndxbrWF3gbd+LQCe
         GFxJUpYWf9Yh67jy7WL2zHsYn5BIXyOxE1lRQo1TqAygdVW1CT0Lz1tzzmTNkRTiYeLX
         3s6ZfhpmvaYmnUQbCrZOcYVSduI7BqrlKiFVQc6LZy+6zVTaLIzlC0lNGlf9u8Pku5pB
         NwY6cYTdl0rzY+HGy+ZNdvAPPi3TAQ5RJiLYhyAP4isYIsMlZUReN/xHu/z9SlLN3TpC
         qwng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8H47ocDcATCEcdvQX+LbcVgPZyzX/fIx4WAwDOmGCq4=;
        b=qCZgYWVEl0MScxn2fGRh3Xziz9qMj/FTVWJ/IQZ8XHuBsb63yQBvNjnbSnVvzjmGB5
         6JtDnxR0YocxKWodOIhLlOi8l8Bkr5g4B2kb0rLU/7hYe2wTI/NbQKqXkZuIrAMzQ0/f
         66wGK7E86FBZUZ6Pt9qfQe07or2rQE26nHOwPAjXF0kkvAHsxdHOJGlKhyYWqarvjX9E
         HW1YHKOW3DEtmk6JDtDGzLrsqTPItBC/2FOL1NGt+Nh4g8tRDhQz3rwDdQpxcq4spABI
         AHOmfEmmOiysw35T3vH2/fIFkwcxrIACsru/rPkVEY3dLUcKmFUQn46L98AeCDg0j/tH
         DHWA==
X-Gm-Message-State: AOAM533SYrfvpmp28/YIoaq7znBMvSTm9fxUoGWL+cJD8RvagmONOcei
        7QStIifgGg45X7fmadg8VyohisunvveZ+tNF
X-Google-Smtp-Source: ABdhPJywxR2ieilLzVjEYhfnEdYP1CaWQqyEumTzsDZxlruca0FAiHVzU/6Na+NTe1aNaWscFhqH9A==
X-Received: by 2002:a17:90a:b288:: with SMTP id c8mr538215pjr.67.1633975974593;
        Mon, 11 Oct 2021 11:12:54 -0700 (PDT)
Received: from localhost.localdomain ([2406:7400:63:9f95:848b:7cc8:d852:ad42])
        by smtp.gmail.com with ESMTPSA id h12sm392554pja.1.2021.10.11.11.12.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Oct 2021 11:12:54 -0700 (PDT)
From:   Naveen Naidu <naveennaidu479@gmail.com>
To:     bhelgaas@google.com
Cc:     Naveen Naidu <naveennaidu479@gmail.com>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        linux-hyperv@vger.kernel.org (open list:Hyper-V/Azure CORE AND DRIVERS)
Subject: [PATCH 21/22] PCI: hv: Use PCI_ERROR_RESPONSE to specify hardware read error
Date:   Mon, 11 Oct 2021 23:42:39 +0530
Message-Id: <04f4c0ad634eb304b31bbbb8eed8a257712dc0f2.1633972263.git.naveennaidu479@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1633972263.git.naveennaidu479@gmail.com>
References: <cover.1633972263.git.naveennaidu479@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Include PCI_ERROR_RESPONSE along with 0xFFFFFFFF in the comment to
specify a hardware error. This helps finding where MMIO read error
occurs easier to find.

Signed-off-by: Naveen Naidu <naveennaidu479@gmail.com>
---
 drivers/pci/controller/pci-hyperv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
index 67c46e52c0dc..7e1102e3d7c6 100644
--- a/drivers/pci/controller/pci-hyperv.c
+++ b/drivers/pci/controller/pci-hyperv.c
@@ -1774,7 +1774,7 @@ static void prepopulate_bars(struct hv_pcibus_device *hbus)
 	 * If the memory enable bit is already set, Hyper-V silently ignores
 	 * the below BAR updates, and the related PCI device driver can not
 	 * work, because reading from the device register(s) always returns
-	 * 0xFFFFFFFF.
+	 * 0xFFFFFFFF (PCI_ERROR_RESPONSE).
 	 */
 	list_for_each_entry(hpdev, &hbus->children, list_entry) {
 		_hv_pcifront_read_config(hpdev, PCI_COMMAND, 2, &command);
-- 
2.25.1

