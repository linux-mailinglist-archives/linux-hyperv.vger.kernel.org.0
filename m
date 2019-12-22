Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 23D91129048
	for <lists+linux-hyperv@lfdr.de>; Mon, 23 Dec 2019 00:34:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726139AbfLVXeK (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sun, 22 Dec 2019 18:34:10 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34968 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726057AbfLVXeK (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Sun, 22 Dec 2019 18:34:10 -0500
Received: by mail-wr1-f66.google.com with SMTP id g17so14894606wro.2;
        Sun, 22 Dec 2019 15:34:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CmAdU1+t0rrC9yhPW4EHpZghbRMZgiJzFFYu/Pk/EW8=;
        b=CJuMk4rPKQBkEwO5uqKc0dsL4LCN8+kQm3mvnpOsEpjhulp7afic8cfXKbnhoxRKCI
         3P4IOc08TGyVTm2jk+JSWGJKqhDsuLIEPq1NcW/VaoI9VCuxIQUk3itNcoEpBtu6rPM3
         Tqt9AUPdT+6dBvjzwB17WyRwITujiMdxp72ZY/EHnO5oE0J+BW5b975tC+NBJEmkKp7V
         9hcSTus3s+MAkEEI9gTXmWDGKC955mEVJya/5cH71wpIYt05HwcHBh1PQARD4/NLULio
         hR8abIrt+TdSUtJMYIoS71nOa3SoH358kekqAUxiZSjBIYyh0WFPzYp4F09n1bHelm1F
         IiPA==
X-Gm-Message-State: APjAAAVmJ6rSF+QYuq4U9ZymBhbjVLHGOLAovrdNLSBDQ4ha0Ywfb6II
        TDiYXwRxJw2Bn0qXL+lb+zk19P0d
X-Google-Smtp-Source: APXvYqzZJo8d8swBtgmxqYXFx0pHAZLmiJO4/3AHvVP3SqUQdqDmF6fgvCQzKeptgSzR05bwrXqmIQ==
X-Received: by 2002:a05:6000:50:: with SMTP id k16mr26440468wrx.145.1577057647790;
        Sun, 22 Dec 2019 15:34:07 -0800 (PST)
Received: from debian.mshome.net (38.163.200.146.dyn.plus.net. [146.200.163.38])
        by smtp.gmail.com with ESMTPSA id p7sm17555395wmp.31.2019.12.22.15.34.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Dec 2019 15:34:07 -0800 (PST)
From:   Wei Liu <wei.liu@kernel.org>
To:     linux-hyperv@vger.kernel.org
Cc:     sashal@kernel.org, kys@microsoft.com, haiyangz@microsoft.com,
        sthemmin@microsoft.com, x86@kernel.org, mikelley@microsoft.com,
        linux-kernel@vger.kernel.org, Wei Liu <wei.liu@kernel.org>
Subject: [PATCH] x86/hyper-v: add "polling" bit to hv_synic_sint
Date:   Sun, 22 Dec 2019 23:34:04 +0000
Message-Id: <20191222233404.1629-1-wei.liu@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

That bit is documented in TLFS 5.0c as follows:

  Setting the polling bit will have the effect of unmasking an
  interrupt source, except that an actual interrupt is not generated.

Signed-off-by: Wei Liu <wei.liu@kernel.org>
---
 arch/x86/include/asm/hyperv-tlfs.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/hyperv-tlfs.h b/arch/x86/include/asm/hyperv-tlfs.h
index 5f10f7f2098d..92abc1e42bfc 100644
--- a/arch/x86/include/asm/hyperv-tlfs.h
+++ b/arch/x86/include/asm/hyperv-tlfs.h
@@ -809,7 +809,8 @@ union hv_synic_sint {
 		u64 reserved1:8;
 		u64 masked:1;
 		u64 auto_eoi:1;
-		u64 reserved2:46;
+		u64 polling:1;
+		u64 reserved2:45;
 	} __packed;
 };
 
-- 
2.20.1

