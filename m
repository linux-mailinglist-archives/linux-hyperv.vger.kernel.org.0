Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BD714A5673
	for <lists+linux-hyperv@lfdr.de>; Mon,  2 Sep 2019 14:42:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730145AbfIBMmD (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 2 Sep 2019 08:42:03 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:37745 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729844AbfIBMmC (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 2 Sep 2019 08:42:02 -0400
Received: by mail-pl1-f194.google.com with SMTP id b10so1489648plr.4;
        Mon, 02 Sep 2019 05:42:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=6bMBJGLXpJhft8Uqn8LI3hEGKJdQ2rbX77O2fwCWI2E=;
        b=Wl35b6Q2vhQOwMbHRjRpL84HFK8WhqSwlYtxUV+0x2B3gqQ03umc3iEHozseCfzpOp
         4P3fbqiqSRS3obSnqmP9B/FpYu3hmibxC/sZwM/rhee086SZtgvQmvo9eaUg69WkVFIx
         wbdCcRK6vOsSeTMJUHgHlWXRaYojtAFYN7tduaAutWDdDrJjxTpuQ6yKda8o1YywuIxM
         r/lR41obOtSjX/jBaqKjMKP4e3RqEg7lJ4068KAycK1Zn6zf024uXHWRcDXxja0V2uOB
         Dj4XYxuH7MzniF4f/glaRRgR1xuTMqDd3i2UggJ3lKJ8MWgVOIhkCu5nHYjsmE1iZE1d
         is9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=6bMBJGLXpJhft8Uqn8LI3hEGKJdQ2rbX77O2fwCWI2E=;
        b=dtmzixKKqAQL5rLJcXzQGYEhmOQ0qfXC5SLc1bvByNiW+PbsL/4xVbea/+B+aFxf4t
         VPV6rcXkDFKW7Ft5swSJqH9zWyC37dqzv+QF4VcvyJmlb31HYrziOSwfr4AKGq+6Ry8Q
         VD5GhUfEJ9gAFy2/FImG0q2OfKK7FQ13PeOXZg1snbMwk77zA3WbgzAbFxG6wDFIAGj3
         vUVO+p80smJSxL2/oFhH7IimETKBF0eC+I/KNr0TU1cdPz/zAfpbdXUbO0qli+FsBTj1
         LNNzCYHNnXxSZ2fWLuGTt9PoytmE5cuQgACNmTELtoXqX10jIltdmIzb6Uyfv0ZtFcql
         mWSA==
X-Gm-Message-State: APjAAAXqkAywDoQMZ7oV6BkatUcIGAWQ5N1nzW956gsHGeT44POAxDxN
        f0h0xTNz0fQWy5dgG0BzxYw=
X-Google-Smtp-Source: APXvYqwL8FuvpT89PhUcwAWXg2lJsDj/gqyiSZZDDqJbgrkM/4x/NHTlG0g63mGuez68xRVcnuk+jQ==
X-Received: by 2002:a17:902:346:: with SMTP id 64mr29692851pld.151.1567428122261;
        Mon, 02 Sep 2019 05:42:02 -0700 (PDT)
Received: from localhost.corp.microsoft.com ([167.220.255.52])
        by smtp.googlemail.com with ESMTPSA id y194sm15942600pfg.116.2019.09.02.05.41.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 02 Sep 2019 05:42:01 -0700 (PDT)
From:   lantianyu1986@gmail.com
X-Google-Original-From: Tianyu.Lan@microsoft.com
To:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        sashal@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, hpa@zytor.com, x86@kernel.org,
        alex.williamson@redhat.com, cohuck@redhat.com,
        michael.h.kelley@microsoft.com
Cc:     Tianyu Lan <Tianyu.Lan@microsoft.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Subject: [PATCH V2] x86/Hyper-V: Fix overflow issue in the fill_gva_list()
Date:   Mon,  2 Sep 2019 20:41:43 +0800
Message-Id: <20190902124143.119478-1-Tianyu.Lan@microsoft.com>
X-Mailer: git-send-email 2.14.5
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Tianyu Lan <Tianyu.Lan@microsoft.com>

When the 'start' parameter is >=  0xFF000000 on 32-bit
systems, or >= 0xFFFFFFFF'FF000000 on 64-bit systems,
fill_gva_list gets into an infinite loop.  With such inputs,
'cur' overflows after adding HV_TLB_FLUSH_UNIT and always
compares as less than end.  Memory is filled with guest virtual
addresses until the system crashes

Fix this by never incrementing 'cur' to be larger than 'end'.

Reported-by: Jong Hyun Park <park.jonghyun@yonsei.ac.kr>
Signed-off-by: Tianyu Lan <Tianyu.Lan@microsoft.com>
Fixes: 2ffd9e33ce4a ("x86/hyper-v: Use hypercall for remote TLB flush")
---
Change since v1:
     - Simply the commit message 

 arch/x86/hyperv/mmu.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/x86/hyperv/mmu.c b/arch/x86/hyperv/mmu.c
index e65d7fe6489f..5208ba49c89a 100644
--- a/arch/x86/hyperv/mmu.c
+++ b/arch/x86/hyperv/mmu.c
@@ -37,12 +37,14 @@ static inline int fill_gva_list(u64 gva_list[], int offset,
 		 * Lower 12 bits encode the number of additional
 		 * pages to flush (in addition to the 'cur' page).
 		 */
-		if (diff >= HV_TLB_FLUSH_UNIT)
+		if (diff >= HV_TLB_FLUSH_UNIT) {
 			gva_list[gva_n] |= ~PAGE_MASK;
-		else if (diff)
+			cur += HV_TLB_FLUSH_UNIT;
+		}  else if (diff) {
 			gva_list[gva_n] |= (diff - 1) >> PAGE_SHIFT;
+			cur = end;
+		}
 
-		cur += HV_TLB_FLUSH_UNIT;
 		gva_n++;
 
 	} while (cur < end);
-- 
2.14.5

