Return-Path: <linux-hyperv+bounces-172-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 870FF7AB863
	for <lists+linux-hyperv@lfdr.de>; Fri, 22 Sep 2023 19:53:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 3939E282481
	for <lists+linux-hyperv@lfdr.de>; Fri, 22 Sep 2023 17:53:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 955454447E;
	Fri, 22 Sep 2023 17:53:21 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EB9F44479
	for <linux-hyperv@vger.kernel.org>; Fri, 22 Sep 2023 17:53:20 +0000 (UTC)
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C05826A5
	for <linux-hyperv@vger.kernel.org>; Fri, 22 Sep 2023 10:52:59 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id 98e67ed59e1d1-2746ab05409so1792963a91.0
        for <linux-hyperv@vger.kernel.org>; Fri, 22 Sep 2023 10:52:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1695405179; x=1696009979; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=R6n/dIamPeUMVNuFW4cdEBQ5hVxUiI5G+G4L0zhGFPQ=;
        b=Zkx7sA+8UIosoEu+ylBRpTK1i5PtoHGq8oXWeXSVq53apmr+B5J8IFiq2l0HEfOIEq
         v9z2KT99HS0eHYprPyDrzzDuvEH8FUi9DkX/eTSmqj7BuGefJ/sdHzlohxqvQ3C1YA5Y
         a7l0wPZTnJFtMwLVEUMqf7Pr7c/Rc0veVi/v4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695405179; x=1696009979;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R6n/dIamPeUMVNuFW4cdEBQ5hVxUiI5G+G4L0zhGFPQ=;
        b=UjJATLe6C/p7In9/y27l46LLs1hJ1PNmZx8lVbddlfYDGRpvCn9zb4bzmrTaIEZrnw
         dIOHI+yt8GSQ5rb5cYhBoWIB6zwGVcaZJaJPFXU9Qc7OfPiuVsNlcW4Gzg/yD+HI6zvx
         5ZIrxNSVSdhz7TmxePIxDnPHniBM8lWhmoN1IZYTlcY9T1wExClFVKmXaDv/rQIbP2Wq
         5wt26m/pvHpJr6kiEgwM0Sdc7e1yjzEDiKgNmNrPRd+P8NCAMBxQppo4zpb4bASl6jhj
         eRv6wMBvdPa26xCSmsYGF6EU4xVjw9lRwtZzU/QWdMvZBQmRiFfp3d2JYaJ7vsmNV8Le
         0xkg==
X-Gm-Message-State: AOJu0YxPQ7cl6RcE/rTMXGjpfGIjRCaI0lvSoZZ3w/ArxYWdClMUaTUi
	XUD9XDfAAHC8G4yVwplTBgeXng==
X-Google-Smtp-Source: AGHT+IHs/kWRYrx0882mgjeumpR6xf+dWnB3lwAWwCO7lNvryszSCtcH04kTeCrZkbhmP/XPZZVTRg==
X-Received: by 2002:a17:90b:fca:b0:273:f848:7da2 with SMTP id gd10-20020a17090b0fca00b00273f8487da2mr391578pjb.45.1695405179414;
        Fri, 22 Sep 2023 10:52:59 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id lt22-20020a17090b355600b00276d039aecasm3613376pjb.13.2023.09.22.10.52.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Sep 2023 10:52:58 -0700 (PDT)
From: Kees Cook <keescook@chromium.org>
To: "K. Y. Srinivasan" <kys@microsoft.com>
Cc: Kees Cook <keescook@chromium.org>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-hyperv@vger.kernel.org,
	linux-pci@vger.kernel.org,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Tom Rix <trix@redhat.com>,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev,
	linux-hardening@vger.kernel.org
Subject: [PATCH] PCI: hv: Annotate struct hv_dr_state with __counted_by
Date: Fri, 22 Sep 2023 10:52:57 -0700
Message-Id: <20230922175257.work.900-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1513; i=keescook@chromium.org;
 h=from:subject:message-id; bh=HwvhrIzwS1OngYd5h25a5+mvpp+30OatzAtcoVNIjeY=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlDdR5RsFIE1XK7abVppH8HIyRHCNnXLkIt/UkZ
 OCZ2BX0XXmJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZQ3UeQAKCRCJcvTf3G3A
 JncDD/46utmowUFXG6KoCyjTSlzv++ojxe1IcbrO+gufqTuw+Zx9r3xXs4QIoyKi0eoj4jJJ2+/
 3G3V1RQtSXyo2+80fzGYwvGjiAxWZFUqpdWP89olIkZkeSRr4BZb3gPdRtaf3z5yqnYeFB7Ziw1
 7zEQEML3k5dIZKlwVoX6voveJFbeZA18/d7KXyr/+YM2bpBa4rhYjLYPc5zqZKU0pMUgRK18NyM
 sXIRpCsfnMA7Pv5Wpl/MfhbaUYg8DL6+1Lc1nyv2pcoXpAj6UDyOsPbVS2oISWnG0syC/qeiz3y
 6fhUJJv1t5jR2Fy4i25bMMqUIROm3k9XEmdslvlFRhVi5pejG2ExMka2HTOsamwrf2ckt+FLkDG
 66GyvAsPqpuOsIpO8IlKusDoYNyHAcN3PJZ/dQJHjyEwClZUOC8XxxJrmdT8PZqsU5pzBxzXfun
 fTkpKGSLKCXIidLcdyXyKD2bZtgS9DiKYIdZ+Pdis2gpsl7RS/cCOMdfmHUeddFhXkNtca9K7Od
 4/maxSa3KshNdnfJ0J1lxw+j3JMSjksAybCVgcQujf2TFW4p3cuG4n2P+9b4FfsyqCFgV2Fm6aH
 YQa8Y6HUI5fH7IAPonRww1YpCuZugNBdNzDh24gdEPiNlYqOl5sTEs9jIEtOcLrrd+NZFj2CmuD
 mOQAEY6 dJELRjrw==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Prepare for the coming implementation by GCC and Clang of the __counted_by
attribute. Flexible array members annotated with __counted_by can have
their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
(for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
functions).

As found with Coccinelle[1], add __counted_by for struct hv_dr_state.

[1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci

Cc: "K. Y. Srinivasan" <kys@microsoft.com>
Cc: Haiyang Zhang <haiyangz@microsoft.com>
Cc: Wei Liu <wei.liu@kernel.org>
Cc: Dexuan Cui <decui@microsoft.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: "Krzysztof Wilczyński" <kw@linux.com>
Cc: Rob Herring <robh@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-hyperv@vger.kernel.org
Cc: linux-pci@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/pci/controller/pci-hyperv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
index bed3cefdaf19..30c7dfeccb16 100644
--- a/drivers/pci/controller/pci-hyperv.c
+++ b/drivers/pci/controller/pci-hyperv.c
@@ -545,7 +545,7 @@ struct hv_pcidev_description {
 struct hv_dr_state {
 	struct list_head list_entry;
 	u32 device_count;
-	struct hv_pcidev_description func[];
+	struct hv_pcidev_description func[] __counted_by(device_count);
 };
 
 struct hv_pci_dev {
-- 
2.34.1


