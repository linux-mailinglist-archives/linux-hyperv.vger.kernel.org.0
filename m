Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35AA827950B
	for <lists+linux-hyperv@lfdr.de>; Sat, 26 Sep 2020 01:48:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729710AbgIYXsJ (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 25 Sep 2020 19:48:09 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:41800 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729549AbgIYXr5 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 25 Sep 2020 19:47:57 -0400
Received: by mail-lf1-f65.google.com with SMTP id y17so4599099lfa.8;
        Fri, 25 Sep 2020 16:47:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=66bypUmih1JiEGjHtw9M23S4MfR794g05kwseF1xQyY=;
        b=B2DFMiCSECF7MHk46ssboGP5N/WrApJhs3ioXV3EMy3nKXTwSTbVPZ5/cmyBbUSKZc
         TNnqoKWdaG2gDZRu3z0u4ZXLW6GQUf5/GPnkxb49dWsLPa84ry/XUrah9h4Eu67CWCYj
         0K98kIK92+gCGqu9brX3qJeeV0UG/qlxGV4Q5eYHjEWrTCEo4e0uT91WgrkTL5/h8iz3
         kEfL+ytofopQhFEpB1rFR+i72qC26LB9j6npyv66LQdakdYvrmuEV8b0vkOSTh84jbeB
         XfTmGvlNIHzbwzJmZEadFsmJqsBVJcK2g+ef32r/kSZ4Nn1P/mlioscYYbqadVT18Qq9
         KCgQ==
X-Gm-Message-State: AOAM533EpFJEvcZvzgGJVR52uJ5LcK0vklWnMRSQiukGW925EYEOduU0
        NZ3q1Ukytp0GY9vUXIzVIWQ=
X-Google-Smtp-Source: ABdhPJyWeqBa3lvDurrhgEYjjcDV2F1CFpmMBZ1kf2SE3EX9twMQP9mphmB36AfqmNWqEI//JBWNNQ==
X-Received: by 2002:a19:614b:: with SMTP id m11mr433037lfk.6.1601077675489;
        Fri, 25 Sep 2020 16:47:55 -0700 (PDT)
Received: from workstation.lan ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id l188sm420751lfd.127.2020.09.25.16.47.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2020 16:47:54 -0700 (PDT)
From:   =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>
To:     "K. Y. Srinivasan" <kys@microsoft.com>
Cc:     Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-hyperv@vger.kernel.org, linux-pci@vger.kernel.org
Subject: [PATCH] PCI: hv: Document missing hv_pci_protocol_negotiation() parameter
Date:   Fri, 25 Sep 2020 23:47:53 +0000
Message-Id: <20200925234753.1767227-1-kw@linux.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Add missing documentation for the parameter "version" and "num_version"
of the hv_pci_protocol_negotiation() function and resolve build time
kernel-doc warnings:

  drivers/pci/controller/pci-hyperv.c:2535: warning: Function parameter
  or member 'version' not described in 'hv_pci_protocol_negotiation'

  drivers/pci/controller/pci-hyperv.c:2535: warning: Function parameter
  or member 'num_version' not described in 'hv_pci_protocol_negotiation'

No change to functionality intended.

Signed-off-by: Krzysztof Wilczyński <kw@linux.com>
---
 drivers/pci/controller/pci-hyperv.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
index fc4c3a15e570..6102330e27e1 100644
--- a/drivers/pci/controller/pci-hyperv.c
+++ b/drivers/pci/controller/pci-hyperv.c
@@ -2515,7 +2515,10 @@ static void hv_pci_onchannelcallback(void *context)
 
 /**
  * hv_pci_protocol_negotiation() - Set up protocol
- * @hdev:	VMBus's tracking struct for this root PCI bus
+ * @hdev:		VMBus's tracking struct for this root PCI bus.
+ * @version:		Array of supported channel protocol versions in
+ *			the order of probing - highest go first.
+ * @num_version:	Number of elements in the version array.
  *
  * This driver is intended to support running on Windows 10
  * (server) and later versions. It will not run on earlier
-- 
2.28.0

