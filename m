Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED5C243651D
	for <lists+linux-hyperv@lfdr.de>; Thu, 21 Oct 2021 17:09:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230072AbhJUPL0 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 21 Oct 2021 11:11:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231207AbhJUPLZ (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 21 Oct 2021 11:11:25 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2A28C0613B9;
        Thu, 21 Oct 2021 08:09:09 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id nn3-20020a17090b38c300b001a03bb6c4ebso779067pjb.1;
        Thu, 21 Oct 2021 08:09:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CCqTrKqg8AEEY1fy94bWXb9atpHsOzrSvfmsYcP1Hi4=;
        b=Me2ms/bTDiHgSLBr6tSZnSGK57Xq0PodMkigjQOxBqKFSTP+S6Ys0c1z1cgwhGRzMq
         dD61uaB62U1bO0yyIAfAlye2MhW4Xb6U3f1ifwy1tiGQ5Li+LQFTluq4WPm1SzJAA/Co
         i6USRU558XPIJjQTcsE+KgIJOgcbw+05/L7J2UmMshSYeUp0D7qGGyY19TKpkvepf99M
         qKvLJ/8dCZsuaslmM7TpJXRdRFEfgA57CfrtFR+iToFz5FQ8Br1TUIR43iayrks4OUUh
         WctytAcN5Y8WaMGzxbsbtr5gt6lzr1z6E+AuwgB/M+xYSeNi2uzA3U+TvUDD8R6lKBJR
         lYXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CCqTrKqg8AEEY1fy94bWXb9atpHsOzrSvfmsYcP1Hi4=;
        b=EK/FgOjdBG0hfrVtlvjkEOXOWKq4QWbsph1abfgjE4PhVrc82ZZlZD14hrwKH4rayF
         G6SWBy4CCmMtHkuIsMxXGollfQuQ+XzU5qPdggdb+XDRWiNI141IxftAk0+K0HrzHwsn
         HfIhsGrbCEI7GbqgCM5+S92SIocN3q8PTJcrECm49kym1VfB7LwqtaU5HfgVnl64+nn4
         doUxP7xAWBKPM8MgHBdaM90XOlOwOWuNZOq/4tWCtC/D9QZiYQzwDDIBIPNJxvgEPRwp
         23Apjr51xYXHHM9AI4W5tHAZpqpgWimXEOcFDZcm3G1gNQtupCMCLdBav9nC2U0SqUYU
         Tg9Q==
X-Gm-Message-State: AOAM5338V9xfQIoHy/OCdzCC5iqPmIH8dKCkkA5vofiBI+kTuneVwjuR
        F2OW+t7+2RoN0FlH9HTtewo=
X-Google-Smtp-Source: ABdhPJxnxqjsJSTu0VewveiQokmLiOhsbRmw+PWUQcLpIM+kXijEvkWeAPZfgzTDW/T9CfexzBf24w==
X-Received: by 2002:a17:90b:4d88:: with SMTP id oj8mr5111859pjb.175.1634828949353;
        Thu, 21 Oct 2021 08:09:09 -0700 (PDT)
Received: from localhost.localdomain ([2406:7400:63:29a4:d874:a949:6890:f95f])
        by smtp.gmail.com with ESMTPSA id c9sm5508027pgq.58.2021.10.21.08.08.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Oct 2021 08:09:08 -0700 (PDT)
From:   Naveen Naidu <naveennaidu479@gmail.com>
To:     bhelgaas@google.com
Cc:     Naveen Naidu <naveennaidu479@gmail.com>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-hyperv@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
        linux-renesas-soc@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        skhan@linuxfoundation.org, Robert Richter <rric@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com (maintainer:BROADCOM IPROC ARM
        ARCHITECTURE), Ryder Lee <ryder.lee@mediatek.com>,
        Jianjun Wang <jianjun.wang@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Shawn Guo <shawn.guo@linaro.org>,
        Xiaowei Song <songxiaowei@hisilicon.com>,
        Binghui Wang <wangbinghui@hisilicon.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Joyce Ooi <joyce.ooi@intel.com>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Nirmal Patel <nirmal.patel@linux.intel.com>,
        Jonathan Derrick <jonathan.derrick@linux.dev>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Lukas Wunner <lukas@wunner.de>,
        Amey Narkhede <ameynarkhede03@gmail.com>,
        Russell Currey <ruscur@russell.cc>,
        "Oliver O'Halloran" <oohall@gmail.com>,
        Sean V Kelley <sean.v.kelley@intel.com>,
        Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
        Marc Zyngier <maz@kernel.org>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Toan Le <toan@os.amperecomputing.com>
Subject: [PATCH v3 01/25] PCI: Add PCI_ERROR_RESPONSE and it's related definitions
Date:   Thu, 21 Oct 2021 20:37:26 +0530
Message-Id: <f7960a4dee0e417eedd7d2e031d04ac9016c6686.1634825082.git.naveennaidu479@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1634825082.git.naveennaidu479@gmail.com>
References: <cover.1634825082.git.naveennaidu479@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

An MMIO read from a PCI device that doesn't exist or doesn't respond
causes a PCI error.  There's no real data to return to satisfy the
CPU read, so most hardware fabricates ~0 data.

Add a PCI_ERROR_RESPONSE definition for that and use it where
appropriate to make these checks consistent and easier to find.

Also add helper definitions SET_PCI_ERROR_RESPONSE and
RESPONSE_IS_PCI_ERROR to make the code more readable.

Suggested-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Naveen Naidu <naveennaidu479@gmail.com>
---
 include/linux/pci.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/include/linux/pci.h b/include/linux/pci.h
index cd8aa6fce204..689c8277c584 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -154,6 +154,15 @@ enum pci_interrupt_pin {
 /* The number of legacy PCI INTx interrupts */
 #define PCI_NUM_INTX	4
 
+/*
+ * Reading from a device that doesn't respond typically returns ~0.  A
+ * successful read from a device may also return ~0, so you need additional
+ * information to reliably identify errors.
+ */
+#define PCI_ERROR_RESPONSE     (~0ULL)
+#define SET_PCI_ERROR_RESPONSE(val)    (*(val) = ((typeof(*(val))) PCI_ERROR_RESPONSE))
+#define RESPONSE_IS_PCI_ERROR(val) ((val) == ((typeof(val)) PCI_ERROR_RESPONSE))
+
 /*
  * pci_power_t values must match the bits in the Capabilities PME_Support
  * and Control/Status PowerState fields in the Power Management capability.
-- 
2.25.1

