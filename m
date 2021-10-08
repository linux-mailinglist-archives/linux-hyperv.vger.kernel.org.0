Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 590D94273C3
	for <lists+linux-hyperv@lfdr.de>; Sat,  9 Oct 2021 00:27:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243674AbhJHW3e (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 8 Oct 2021 18:29:34 -0400
Received: from mail-wr1-f52.google.com ([209.85.221.52]:33512 "EHLO
        mail-wr1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243668AbhJHW3d (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 8 Oct 2021 18:29:33 -0400
Received: by mail-wr1-f52.google.com with SMTP id m22so33986901wrb.0;
        Fri, 08 Oct 2021 15:27:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tRYb2LPqEkxBD8lAFNonDclv6oFLdcwFLdTj/5b6MDk=;
        b=LyBFFZsf89P0e+LemiwYQniJYmZiCGMYuerx7adwNjIW7loaYFfsV5v5kyrFPRyNHa
         dejrjOqXbWwgGNUyqRAhJKcJLFcAIIheQmVitqs0EkJFyko0kBQ6iWGHQtiMhebAcSOx
         C5PTYPpvu6lOQvzbjc0OpsK7NeJXGs7iXl1VcrdU/FDk1duOIdmlReYYS61kZZaxAKjS
         LslgAAmIMbRHA7MKrglMtkR8MxSPklXfz437MSHj+W0kmTHOd16KkFMnOPK+3NQ5shSH
         GVX3hozar2lv3jyvDo+txEoI77Wmm5IkSyFrwUM+/2LY2rEPrh9TrkU78winVkSEEElm
         a3QA==
X-Gm-Message-State: AOAM530L0wy56+uGI1cBQavXtGBoUR4l1tU0F+Zl1i4ja2Ud/f08e5PK
        Avx7hVmdMeBNlWGmCCtunfE=
X-Google-Smtp-Source: ABdhPJykfILUWlH/p9qgCZRY8huJyNxoIwFsVOgEfc1eHeJlb/8jzAS/o+YbCbohkm4IdP2ZkhwlNg==
X-Received: by 2002:adf:bb49:: with SMTP id x9mr7243973wrg.413.1633732056696;
        Fri, 08 Oct 2021 15:27:36 -0700 (PDT)
Received: from workstation.lan ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id b15sm549577wrr.90.2021.10.08.15.27.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Oct 2021 15:27:36 -0700 (PDT)
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
Subject: [PATCH 3/3] PCI: Update variable type to match sscanf() format string
Date:   Fri,  8 Oct 2021 22:27:32 +0000
Message-Id: <20211008222732.2868493-3-kw@linux.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211008222732.2868493-1-kw@linux.com>
References: <20211008222732.2868493-1-kw@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

To test whether a string contains a valid PCI device path formatted as
the "/<device>.<function>" address (see output from "lspci -P" as an
example; such format can also be provided as part of kernel command-line
parameters), the function called pci_dev_str_match_path() can be used.

Internally, pci_dev_str_match_path() function uses sscanf() and the "%x"
format string as part of its path matching implementation where it would
parse a given value as a unsigned hexadecimal number.  This particular
format string type requires the argument to be of an unsigned int type.

Thus, to match given format string requirements and also safeguard
against a potential undefined behaviour, change type of the variables
passed to sscanf() to unsigned int accordingly.

No change to functionality intended.

Signed-off-by: Krzysztof Wilczyński <kw@linux.com>
---
 drivers/pci/pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index ce2ab62b64cf..7998b65e9ae5 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -269,7 +269,7 @@ static int pci_dev_str_match_path(struct pci_dev *dev, const char *path,
 				  const char **endptr)
 {
 	int ret;
-	int seg, bus, slot, func;
+	unsigned int seg, bus, slot, func;
 	char *wpath, *p;
 	char end;
 
-- 
2.33.0

