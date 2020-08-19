Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44E33249913
	for <lists+linux-hyperv@lfdr.de>; Wed, 19 Aug 2020 11:11:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726970AbgHSJLe (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 19 Aug 2020 05:11:34 -0400
Received: from mo4-p00-ob.smtp.rzone.de ([85.215.255.20]:34040 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726630AbgHSJL2 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 19 Aug 2020 05:11:28 -0400
X-Greylist: delayed 358 seconds by postgrey-1.27 at vger.kernel.org; Wed, 19 Aug 2020 05:11:27 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1597828286;
        s=strato-dkim-0002; d=aepfle.de;
        h=Message-Id:Date:Subject:Cc:To:From:X-RZG-CLASS-ID:X-RZG-AUTH:From:
        Subject:Sender;
        bh=aJbBiqqEcgkxYh/T/PAcF1pQQBq2TFSlGmE/iQkN4AU=;
        b=YhDLlpk0RvsGMyC1bR29eKjke/B6YZbj2YxYyQ6AiGjI/hczq1+izba1UcgbjOykj8
        ooWA3i+3TLnYuuGJlwm5U1H/2PKWf4RCymVjbhhGiPGPzVluICqV/gxRv/A4FhXDg2qm
        GHr55Qt+qsga1i8CLW/1GrJvXE6vgaAnjPQB1HdkHm/h91gpt6uQ+xwGn13LhP/oHa+j
        oL8TqcZnPzP+oIac+20XXOwg8oxylyOEuN/5e1aIRG8z/XSBoTmrEeScIMiBfM2utbNA
        e+SktiYlFScZUp4ox+UGTSpebOsEukf8C4Yi4GYPL7BNnFgKAYiWFKBWbC9DHBSCb/Cx
        jkGw==
X-RZG-AUTH: ":P2EQZWCpfu+qG7CngxMFH1J+3q8wa/QXkBR9MXjAuzBW/OdlBZQ4AHSS3mkg"
X-RZG-CLASS-ID: mo00
Received: from sender
        by smtp.strato.de (RZmta 46.10.7 DYNA|AUTH)
        with ESMTPSA id 60ad29w7J95I0WU
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256 bits))
        (Client did not present a certificate);
        Wed, 19 Aug 2020 11:05:18 +0200 (CEST)
From:   Olaf Hering <olaf@aepfle.de>
To:     linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Olaf Hering <olaf@aepfle.de>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>
Subject: [PATCH v1] tools: hv: remove cast from hyperv_die_event
Date:   Wed, 19 Aug 2020 11:05:09 +0200
Message-Id: <20200819090510.28995-1-olaf@aepfle.de>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

No need to cast a void pointer.

Signed-off-by: Olaf Hering <olaf@aepfle.de>
---
 drivers/hv/vmbus_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index 910b6e90866c..187809977360 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -83,7 +83,7 @@ static int hyperv_panic_event(struct notifier_block *nb, unsigned long val,
 static int hyperv_die_event(struct notifier_block *nb, unsigned long val,
 			    void *args)
 {
-	struct die_args *die = (struct die_args *)args;
+	struct die_args *die = args;
 	struct pt_regs *regs = die->regs;
 
 	/* Don't notify Hyper-V if the die event is other than oops */
