Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4687C4273C0
	for <lists+linux-hyperv@lfdr.de>; Sat,  9 Oct 2021 00:27:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243664AbhJHW3c (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 8 Oct 2021 18:29:32 -0400
Received: from mail-wr1-f53.google.com ([209.85.221.53]:45632 "EHLO
        mail-wr1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243647AbhJHW3c (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 8 Oct 2021 18:29:32 -0400
Received: by mail-wr1-f53.google.com with SMTP id r10so33891422wra.12;
        Fri, 08 Oct 2021 15:27:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=G46wgdVxBxnvmODzCOrsOtpCPNJX7A0vCQdGPPqp6WI=;
        b=JWeS3eaIyI6g1zcR3aMPSv5SLc+aQTiSguxzq8kdW/72ozaLZ6/jsfLuD9PFwDcVea
         wGNb1p47YX5pZzMuhiobT5lSgDHRhlWI17TyDg5XOsrFgcGsspKMN5bry5jJYB5gc41k
         SKgKpTYg5Ndr7Q2mgzBkedRN5aSqFC5pXvhnH8FvfRsNG9CWQYemlh3wgr9+M9R66G/6
         W3CuxoUORbbe9GDVTkXru07wMzB167xrgrTyQHke+Ol4oweRIVgCq9d2spmaFr7JSP5Y
         9ShfmZrDuVMuz0qbQUfQvQ/kspNcwbYEKs4OOyLsFWg0f/INP9Zw/6vBwRKwQd/pD4nB
         59rg==
X-Gm-Message-State: AOAM530Qu1k4VHWbbiWbaX0vJvSl53oj9iGRNxIsBnquCv/2JSIL8wL/
        Ez95+VCm2Mq6QLazEL4Pp8HOyKMlfO/3Sw==
X-Google-Smtp-Source: ABdhPJxpgThc3Xp7Vgr8G3M9wX/3xUTWaomBe3zJZNM5TCllVi/yrKbzEv5hfH5BQ3kbnJ5mgHOpFw==
X-Received: by 2002:a05:600c:230f:: with SMTP id 15mr6370470wmo.19.1633732055688;
        Fri, 08 Oct 2021 15:27:35 -0700 (PDT)
Received: from workstation.lan ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id b15sm549577wrr.90.2021.10.08.15.27.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Oct 2021 15:27:35 -0700 (PDT)
From:   =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Long Li <longli@microsoft.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        linux-hyperv@vger.kernel.org, linux-pci@vger.kernel.org
Subject: [PATCH 2/3] PCI: iov: Update format string type to match variable type
Date:   Fri,  8 Oct 2021 22:27:31 +0000
Message-Id: <20211008222732.2868493-2-kw@linux.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211008222732.2868493-1-kw@linux.com>
References: <20211008222732.2868493-1-kw@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Functions pci_iov_sysfs_link() and pci_iov_remove_virtfn() take
a Virtual Function (VF) ID as an integer value and then use it to
assemble the desired name for the corresponding sysfs attribute (a
symbolic link in this case).

Internally, both functions use sprintf() to create the desired attribute
name, and leverage the "%u" modifier as part of the format string used
to do so.  However, the VF ID is passed to both functions as a signed
integer type variable, which makes the variable type and format string
modifier somewhat incompatible.

Thus, change the modifier used in the format string to "%d" to better
match the variable type.

No change to functionality intended.

Signed-off-by: Krzysztof Wilczyński <kw@linux.com>
---
 drivers/pci/iov.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
index dafdc652fcd0..056bba3b4236 100644
--- a/drivers/pci/iov.c
+++ b/drivers/pci/iov.c
@@ -140,7 +140,7 @@ int pci_iov_sysfs_link(struct pci_dev *dev,
 	char buf[VIRTFN_ID_LEN];
 	int rc;
 
-	sprintf(buf, "virtfn%u", id);
+	sprintf(buf, "virtfn%d", id);
 	rc = sysfs_create_link(&dev->dev.kobj, &virtfn->dev.kobj, buf);
 	if (rc)
 		goto failed;
@@ -322,7 +322,7 @@ void pci_iov_remove_virtfn(struct pci_dev *dev, int id)
 	if (!virtfn)
 		return;
 
-	sprintf(buf, "virtfn%u", id);
+	sprintf(buf, "virtfn%d", id);
 	sysfs_remove_link(&dev->dev.kobj, buf);
 	/*
 	 * pci_stop_dev() could have been called for this virtfn already,
-- 
2.33.0

