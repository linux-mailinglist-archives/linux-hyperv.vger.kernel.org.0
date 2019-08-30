Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6A99FA2F92
	for <lists+linux-hyperv@lfdr.de>; Fri, 30 Aug 2019 08:15:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726716AbfH3GPu (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 30 Aug 2019 02:15:50 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:46690 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726452AbfH3GPu (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 30 Aug 2019 02:15:50 -0400
Received: by mail-pg1-f196.google.com with SMTP id m3so2968695pgv.13;
        Thu, 29 Aug 2019 23:15:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=YekfysBZuovI4KweYbSp+YMJszBxYODg0IxHNTmJQ8E=;
        b=Kr+M4nQOtok8bD8+12TPilMjdoBJsFwAsp+b015vBrQIkrHgWTuAfGUfGHqhNiWeqJ
         pz43SDnYa7KQKzpSTeuTbJEP/EbeDlMZ+sKxIzrdFZQNyKQ2MYGRHSZHo23DWscKbRiC
         0Ip9sxzljSjj3ET6dEINHOdYMZLgrQ/bIDRLT5wi/62jlumgwyzKIkJNPZH+eTaS8BxK
         ra9KGpVzDdAJHeqBbADm5KDZhQzz4WcLqwdWVQeNW9RbiHD3cyUX362exKYIVP8YYvUT
         rORqS2xvu1ZCcJgeU70+tkMaK6zJTfq/Eo+3oYs2ASqHG9+HMfZD6y6hMpEbcP1AlT7g
         iDFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=YekfysBZuovI4KweYbSp+YMJszBxYODg0IxHNTmJQ8E=;
        b=DNsMWgh/d69y6M8MkTGWW8gGD+zPTa/P/c4xcYJJiaESiyYqq4hbgZc6GA3VVJXwld
         xHSrBjI4pwr1VRxLHp6CvheBTZ7AMEDfkeOTs5D/lk9cYJvPOSWqJdUyyWky3S7CjkUm
         QTTqxSeg1eEh2beUReTqfqvPeCoMG/xYm5626rCTgKZ829glNGjwNyoLvlHr7zvBZn7H
         2efYY9bfUZn8+jbREYgUah5wSZRtcbfiKR/wL8E7l4wipTBMBNvSWSZSD1Fa5M8kcWH6
         FPqaco44c0frwJC8gRI2epundWRB+K5MZC78d1AbOh99dFTndxcmWwS6LQbKB3Oy0ujS
         qXBA==
X-Gm-Message-State: APjAAAXqoQwKwHZQdazhMQnGMtRXl5aeqADmfwTaPQinUsf/GVJd0Pr4
        9aF8o0RyVlnoXm2/epZnkryL/FH6uoA=
X-Google-Smtp-Source: APXvYqwy2fIk8aReh79zAPMFA3zqOX/2l3fVr7CgROjNe57pxsafRfxrGYWtiD4cacLhiz1E8k0eLw==
X-Received: by 2002:a63:3fc9:: with SMTP id m192mr11884742pga.429.1567145749714;
        Thu, 29 Aug 2019 23:15:49 -0700 (PDT)
Received: from localhost.corp.microsoft.com ([167.220.255.52])
        by smtp.googlemail.com with ESMTPSA id h70sm4291506pgc.36.2019.08.29.23.15.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 29 Aug 2019 23:15:49 -0700 (PDT)
From:   lantianyu1986@gmail.com
X-Google-Original-From: Tianyu.Lan@microsoft.com
To:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        sashal@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, hpa@zytor.com, x86@kernel.org,
        gregkh@linuxfoundation.org, alex.williamson@redhat.com,
        cohuck@redhat.com, michael.h.kelley@microsoft.com
Cc:     Tianyu Lan <Tianyu.Lan@microsoft.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Subject: [PATCH] x86/Hyper-V: Fix overflow issue in the fill_gva_list()
Date:   Fri, 30 Aug 2019 14:15:40 +0800
Message-Id: <20190830061540.211072-1-Tianyu.Lan@microsoft.com>
X-Mailer: git-send-email 2.14.5
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Tianyu Lan <Tianyu.Lan@microsoft.com>

fill_gva_list() populates gva list and adds offset
HV_TLB_FLUSH_UNIT(0x1000000) to variable "cur"
in the each loop. When diff between "end" and "cur" is
less than HV_TLB_FLUSH_UNIT, the gva entry should
be the last one and the loop should be end.

If cur is equal or greater than 0xFF000000 on 32-bit
mode, "cur" will be overflow after adding HV_TLB_FLUSH_UNIT.
Its value will be wrapped and less than "end". fill_gva_list()
falls into an infinite loop and fill gva list out of
border finally.

Set "cur" to be "end" to make loop end when diff is
less than HV_TLB_FLUSH_UNIT and add HV_TLB_FLUSH_UNIT to
"cur" when diff is equal or greater than HV_TLB_FLUSH_UNIT.
Fix the overflow issue.

Reported-by: Jong Hyun Park <park.jonghyun@yonsei.ac.kr>
Signed-off-by: Tianyu Lan <Tianyu.Lan@microsoft.com>
Fixes: 2ffd9e33ce4a ("x86/hyper-v: Use hypercall for remote
TLB flush")
---
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

