Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4EB0E1906E5
	for <lists+linux-hyperv@lfdr.de>; Tue, 24 Mar 2020 08:57:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725905AbgCXH5i (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 24 Mar 2020 03:57:38 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:36761 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727567AbgCXH5d (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 24 Mar 2020 03:57:33 -0400
Received: by mail-pg1-f194.google.com with SMTP id j29so1752170pgl.3;
        Tue, 24 Mar 2020 00:57:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=j4dwxmfLVQ2k0LnkKWowyUjx6teLmaMk7YyH/4Gqa+0=;
        b=HZFqxbIJe1ZxnrvnUGkkcNj01g3SZs2GWWVPY/uQSkCVlOx5rDu3hfg8VlBTlSjqSn
         3iQsdBKN7xGsF0ZRaqRDNe0mWVbB3rOV0uhrkYlM9gpKrob/RWhd4XHr2yY28pUHyv3M
         sITt+WuqnsVlch0xS1D3ArtEYv+gti5t3I9c/f9ja9RUqLYJD7O3rplU6MJrGGHgcJ5M
         uK4FwUXSAxX6DN275FItoPniUk69K+ARO4xy0zBuyNKP1uPZST1FiT/ozcpEp6hf6iQv
         6+0ljj6cYJ+o9AjpQqVevh1jn5vz7qOB1tC/cCrSe9DKL8Yf84xMEBlpfe12qBl8cU1f
         aNMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=j4dwxmfLVQ2k0LnkKWowyUjx6teLmaMk7YyH/4Gqa+0=;
        b=XnJ7cyB+Fvu3ToXmh2e5nGirlqBZP1puy6f2bA3G/2j7Qoi/npbPyyT9yMUbm0QliH
         udFWLQXZq9Eo/6MkM1F7mnuOuDwF5m7ZEQT3hTYpt+xogh8U65o/2OicL5WSFIua3Muv
         Yulv3oQI5wFpm5MCa38j1koV2IjLeVDKwmWHteYMyHeaXMFkk/i8m5j0lVdEwrjssTre
         l9lwwIX71twLlJKlLlpJL2+HHcxvY0UgQW4bGfJRT/Z7onUnZpirI06pmP/HvYvaxQGm
         5/blPk7zcrLLPa33ow2U8n2rBS1m9GlW5f6Hrhe8LPGiADARcUgAwp/jiBbPYsoGZfA8
         ZIYw==
X-Gm-Message-State: ANhLgQ3d0qCzlehlvkEmESuDdBNhkYF4VxIo2IYGzQaWHfOozeSIigD4
        Nq6lEisCX9KNJbiqcEuzCvk=
X-Google-Smtp-Source: ADFU+vvYaR/wv6YfoxqlqfDSOmHihOVIE89+NWjiVHiCXAr91EQLF4fOxzNmwPzDsAN4f0rj+Mohrw==
X-Received: by 2002:a63:9549:: with SMTP id t9mr26067024pgn.346.1585036652041;
        Tue, 24 Mar 2020 00:57:32 -0700 (PDT)
Received: from localhost.corp.microsoft.com ([167.220.2.210])
        by smtp.googlemail.com with ESMTPSA id x71sm15452076pfd.129.2020.03.24.00.57.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 24 Mar 2020 00:57:31 -0700 (PDT)
From:   ltykernel@gmail.com
X-Google-Original-From: Tianyu.Lan@microsoft.com
To:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        liuwe@microsoft.com, michael.h.kelley@microsoft.com
Cc:     Tianyu Lan <Tianyu.Lan@microsoft.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        vkuznets@redhat.com
Subject: [PATCH V3 6/6] x86/Hyper-V: Report crash data in die() when panic_on_oops is set
Date:   Tue, 24 Mar 2020 00:57:20 -0700
Message-Id: <20200324075720.9462-7-Tianyu.Lan@microsoft.com>
X-Mailer: git-send-email 2.14.5
In-Reply-To: <20200324075720.9462-1-Tianyu.Lan@microsoft.com>
References: <20200324075720.9462-1-Tianyu.Lan@microsoft.com>
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Tianyu Lan <Tianyu.Lan@microsoft.com>

When oops happens with panic_on_oops unset, the oops
thread is killed by die() and system continues to run.
In such case, guest should not report crash register
data to host since system still runs. Fix it.

Signed-off-by: Tianyu Lan <Tianyu.Lan@microsoft.com>
---
 drivers/hv/vmbus_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index 172ceae69abb..8baca2881596 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -91,7 +91,7 @@ static int hyperv_die_event(struct notifier_block *nb, unsigned long val,
 	 * doing hyperv_report_panic_msg() later with kmsg data, don't do
 	 * the notification here.
 	 */
-	if (hyperv_report_reg())
+	if (hyperv_report_reg() && panic_on_oops)
 		hyperv_report_panic(regs, val);
 	return NOTIFY_DONE;
 }
-- 
2.14.5

