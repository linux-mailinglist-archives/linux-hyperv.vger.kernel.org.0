Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 89DCE66926
	for <lists+linux-hyperv@lfdr.de>; Fri, 12 Jul 2019 10:30:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726159AbfGLIa2 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 12 Jul 2019 04:30:28 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:46382 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726057AbfGLIa2 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 12 Jul 2019 04:30:28 -0400
Received: by mail-pl1-f196.google.com with SMTP id c2so4406454plz.13;
        Fri, 12 Jul 2019 01:30:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KY0hOmAa86HuZE0h9c7QHLSN/sFybZcvdeeWuBmi/OU=;
        b=M7jnMH0iq8DIlf3ir9bUBr+Gj4b9C5Xj+a403n7ozIuuZ2YLNS3x41r+BsGQFn5Qiz
         AjEXAVK2HBrYR7xead9VFlc7h/Y4pxRQzEoxthv1vxYfljsH8Maya30ITkuNu03fGUjB
         neyVbH7VV2HVtSqGmeITYA2vFWgDcYdnyHo53gqzMC1aXu+kGunl7y9qmRfjbETOrdPJ
         7r+U2YZbj1KiA0y8QUxUOa1cWXQDdrbWZ/MTJeFm+mzTGFgsY34GmmomkiD8HMxrrbaQ
         wotuRprTq8XJ5v8EdLUIIKnks8zl82vfqhmqtngn7Ma/eN4+oY5iBwvBucff5UyImo2Y
         sFTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KY0hOmAa86HuZE0h9c7QHLSN/sFybZcvdeeWuBmi/OU=;
        b=f0rJwLTlizLDYckpOO8PMw6cWgI3xH3xfAFkZkOJA6LTUCnERXklhKT8dpAZ5OzVuT
         4rBmQYSaAK6E5J99YT6LeNQocoje6Rhxif6V55CT0NNshPLNvCiRFileKfNXn9rQEb8M
         yyoSlO1LjmyElzfJdBf6mwWNv2NacB/AFxTxDKPv0YG2tYoLiwSWhKQemts8ZYhwDcvz
         HnBoNaiFngerqSOp7b70Za7m/NR8qd7VJLykWC06bxnfUmn6xPBTg0Q3nCLtmHE7EXkz
         Hihg5ZekUJKkbPaXAnLLo/t/WjHIdNv0iADuQlgN2KkYy6iXXnX1XlELK/sX8G18BkGE
         BfQw==
X-Gm-Message-State: APjAAAUKCi3N0rY78yxfQeE0LWCGKET3jW+OgG9dDEuT1TcMr0FyNDtF
        83LKsbAJwqYcp4KG1YJLMq7iK1HrGIJ1CA==
X-Google-Smtp-Source: APXvYqzEBkl/k9B0z+4k5z2fn64BG9zSVycFVEu4SIePEwbqH4gluu59cr3wuMSGoHa2itevd6aLPw==
X-Received: by 2002:a17:902:bd94:: with SMTP id q20mr9922593pls.307.1562920227968;
        Fri, 12 Jul 2019 01:30:27 -0700 (PDT)
Received: from maya190711 ([52.250.118.122])
        by smtp.gmail.com with ESMTPSA id i9sm6538419pjj.2.2019.07.12.01.30.27
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 12 Jul 2019 01:30:27 -0700 (PDT)
Date:   Fri, 12 Jul 2019 08:30:27 +0000
From:   Maya Nakamura <m.maya.nakamura@gmail.com>
To:     mikelley@microsoft.com, kys@microsoft.com, haiyangz@microsoft.com,
        sthemmin@microsoft.com, sashal@kernel.org
Cc:     x86@kernel.org, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 5/5] Input: hv: Remove dependencies on PAGE_SIZE for ring
 buffer
Message-ID: <5af419d636506d9d87ab7d2650fa800ead91a29a.1562916939.git.m.maya.nakamura@gmail.com>
References: <cover.1562916939.git.m.maya.nakamura@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1562916939.git.m.maya.nakamura@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Define the ring buffer size as a constant expression because it should
not depend on the guest page size.

Signed-off-by: Maya Nakamura <m.maya.nakamura@gmail.com>
Reviewed-by: Michael Kelley <mikelley@microsoft.com>
---
 drivers/input/serio/hyperv-keyboard.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/input/serio/hyperv-keyboard.c b/drivers/input/serio/hyperv-keyboard.c
index 8e457e50f837..88ae7c2ac3c8 100644
--- a/drivers/input/serio/hyperv-keyboard.c
+++ b/drivers/input/serio/hyperv-keyboard.c
@@ -75,8 +75,8 @@ struct synth_kbd_keystroke {
 
 #define HK_MAXIMUM_MESSAGE_SIZE 256
 
-#define KBD_VSC_SEND_RING_BUFFER_SIZE		(10 * PAGE_SIZE)
-#define KBD_VSC_RECV_RING_BUFFER_SIZE		(10 * PAGE_SIZE)
+#define KBD_VSC_SEND_RING_BUFFER_SIZE		(40 * 1024)
+#define KBD_VSC_RECV_RING_BUFFER_SIZE		(40 * 1024)
 
 #define XTKBD_EMUL0     0xe0
 #define XTKBD_EMUL1     0xe1
-- 
2.17.1

