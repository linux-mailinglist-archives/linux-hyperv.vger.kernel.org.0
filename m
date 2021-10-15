Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B765642F629
	for <lists+linux-hyperv@lfdr.de>; Fri, 15 Oct 2021 16:47:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240808AbhJOOtp (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 15 Oct 2021 10:49:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240775AbhJOOtV (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 15 Oct 2021 10:49:21 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02F11C061772;
        Fri, 15 Oct 2021 07:46:59 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id c4so1773864pgv.11;
        Fri, 15 Oct 2021 07:46:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8H47ocDcATCEcdvQX+LbcVgPZyzX/fIx4WAwDOmGCq4=;
        b=Eux3ZNBeFFId+XHdQkRmLauqE8OAFj38AteET+UOhB3y9JaX2mZ7iVNlfIRKDRY1aP
         Sp6zIyqe0Ud1BseDpkT60FafTSrwY/J9mVtI9j6Pk1rVWEoMjamuFbMeteGMPDAKudik
         KArKNn2zwwdCjIBZxpW+uWOakhRB/U92FAHfnx0pAl51m7jn0v3JUQIo9+fDoLeLyZKS
         q0hJnBIuY49zyJLy2wo5UiUb6ZZzxCY797QfKS3vghg+AJsL7XwnTQgVY1AndynWaiH9
         9oOFzKwhP8B7SoA28FaVuvv5gwLhB9aFLGJY09bJemOUk4tbqCKVAHfYulxYfufqA4Sj
         LRXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8H47ocDcATCEcdvQX+LbcVgPZyzX/fIx4WAwDOmGCq4=;
        b=Z8EUUSJA4FOCZpUGkHdzjnus+12FB2QDHdeYFfsFJKRsi+ZrufJ3yuNb6o/ANrGycq
         5TAZB18VkEqYOmvwZG0LpOe0H6sp+OYkr8CarlBAl7IfWKCAiNDkA3IQdpGKdbWXS8Wy
         BszdP8NypWW82jNSi/zZlM5UmhmYPlV3EDeJ3tGnqxVZVYyBdgJuu2JSjmnokfAOZY7l
         t/+xeogqwcRaXqxdULSdBpmjZaZeOcIEiXAwCu4ExN/B669Jp2k561KABGbYf995z6vV
         MLOUpW+BlVoj4Izm52eQ2eb6Zd4ONBlsaRV8IwTxd7/KgwSyQFUXxj3UgDu4vwgXfSs+
         b3wA==
X-Gm-Message-State: AOAM533w6CKI//XWSPTSdw4zbMKKgRI37uud1jhiPDrC3i050vlRT8bH
        woUk4j/mJb8mokix6fXgTk2r0M0YCqhsajd7
X-Google-Smtp-Source: ABdhPJzGttIeZ/ecyBn9FSKHW/aoF+vyF/yYttrHn5sYxfqT3TXKV4dkEub6bv1LydtAneYLLoxtPQ==
X-Received: by 2002:a63:f155:: with SMTP id o21mr9408255pgk.218.1634309218506;
        Fri, 15 Oct 2021 07:46:58 -0700 (PDT)
Received: from localhost.localdomain ([2406:7400:63:4806:9a51:7f4b:9b5c:337a])
        by smtp.gmail.com with ESMTPSA id f18sm5293491pfa.60.2021.10.15.07.46.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Oct 2021 07:46:58 -0700 (PDT)
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
Subject: [PATCH v2 23/24] PCI: hv: Use PCI_ERROR_RESPONSE to specify hardware read error
Date:   Fri, 15 Oct 2021 20:09:04 +0530
Message-Id: <9b72268025063f0094880f32f391e2f626f62487.1634306198.git.naveennaidu479@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1634306198.git.naveennaidu479@gmail.com>
References: <cover.1634306198.git.naveennaidu479@gmail.com>
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

