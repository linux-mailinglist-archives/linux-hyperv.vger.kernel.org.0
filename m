Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 229C636E2F
	for <lists+linux-hyperv@lfdr.de>; Thu,  6 Jun 2019 10:09:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727057AbfFFIJL (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 6 Jun 2019 04:09:11 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:34144 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725267AbfFFIJL (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 6 Jun 2019 04:09:11 -0400
Received: by mail-pg1-f195.google.com with SMTP id h2so918056pgg.1;
        Thu, 06 Jun 2019 01:09:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Ky+FTpxo6a36SL4K0iIgUU/tHa/3+eYpA5PzCdmnJx4=;
        b=t4gI9njCjaOZKLyGot/fIzUaOn3Rz5FSDAHZc7kpLyfVfz63VhR/wj6Wt+pUDeONID
         hQtYhsLP1U4146+eg8kD6RuDxVUiGqvRhef6S41jo2OdVwfZIzcRkATYWUDCdCKP1/h0
         qWOOkzh+rnht3fMwENXxDNsLg2b6+00H2Q9tzrD5GOfzq0c5hX+25Ud4FnUeLiMPmbSr
         fQkY1UpwJGacCivsbqjo4H+NI+P9F91bJNPsUH7M00w3nU9TPtuDWtjD+Eh2rQdjGtYW
         Zga47v/nmbDglnpHzG2gqOjuOj/xOd13wSSFCt5dYBhZkKWHTjZ4RP1+MLKnHMDPy0yH
         1g8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Ky+FTpxo6a36SL4K0iIgUU/tHa/3+eYpA5PzCdmnJx4=;
        b=Uf8HBZ2sVqdnhBrBiegJFDg5TXZ9CAfVPNL0419eCRxJvSnvN+1Ocoj+SqpFFDAc7u
         C22wXw7+lof865MWkmqA02lR9qwOyP1Nn0iSGDJSLiwyPDp7CcScBOWL8uC+NPJ2bE5R
         p6xqobZztYOneYnPcr0+duxLc6n4MSE6+Hjw08T20Ql9r0REitdPqJJ6OftQqiPEpFOL
         KUIf9kFcgNdEJNosgycZ4CfO7fTmd75DBI5LqP58yS3x5HZHSZrn5DkYlWnn3RE206Hn
         sZ3WqdkqyfdUaovWKpIkf2CAp3EIBNSTR2c7xJJDrAaRXaoPUU8W/gvTt8SZj+qgCkF9
         od2g==
X-Gm-Message-State: APjAAAV/70v7aDEPGyj5tMU/a4RmJOIBE4r3bGItYvgsngKmN1JUDGl/
        /ozP3WZ1m1VABEV+a/pJraenV29sSYA=
X-Google-Smtp-Source: APXvYqwrbAzQkk3ogvSRciqvHC8EJIsJFylvt2mkuD3j8jx7DoH9GP/4hjDNi6RTpEHjcPF89eeCMQ==
X-Received: by 2002:a63:2ac9:: with SMTP id q192mr2229673pgq.144.1559808549768;
        Thu, 06 Jun 2019 01:09:09 -0700 (PDT)
Received: from maya190131 ([13.66.160.195])
        by smtp.gmail.com with ESMTPSA id y10sm1133287pfm.68.2019.06.06.01.09.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 06 Jun 2019 01:09:09 -0700 (PDT)
Date:   Thu, 6 Jun 2019 08:09:09 +0000
From:   Maya Nakamura <m.maya.nakamura@gmail.com>
To:     mikelley@microsoft.com, kys@microsoft.com, haiyangz@microsoft.com,
        sthemmin@microsoft.com, sashal@kernel.org
Cc:     x86@kernel.org, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/5] Input: hv: Remove dependencies on PAGE_SIZE for ring
 buffer
Message-ID: <68e9744aa7b2d4e463e48f4422f6b19c38e55bab.1559807514.git.m.maya.nakamura@gmail.com>
References: <cover.1559807514.git.m.maya.nakamura@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1559807514.git.m.maya.nakamura@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Define the ring buffer size as a constant expression because it should
not depend on the guest page size.

Signed-off-by: Maya Nakamura <m.maya.nakamura@gmail.com>
---
 drivers/input/serio/hyperv-keyboard.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/input/serio/hyperv-keyboard.c b/drivers/input/serio/hyperv-keyboard.c
index 7935e52b5435..a3480dbfadd2 100644
--- a/drivers/input/serio/hyperv-keyboard.c
+++ b/drivers/input/serio/hyperv-keyboard.c
@@ -83,8 +83,8 @@ struct synth_kbd_keystroke {
 
 #define HK_MAXIMUM_MESSAGE_SIZE 256
 
-#define KBD_VSC_SEND_RING_BUFFER_SIZE		(10 * PAGE_SIZE)
-#define KBD_VSC_RECV_RING_BUFFER_SIZE		(10 * PAGE_SIZE)
+#define KBD_VSC_SEND_RING_BUFFER_SIZE		(40 * 1024)
+#define KBD_VSC_RECV_RING_BUFFER_SIZE		(40 * 1024)
 
 #define XTKBD_EMUL0     0xe0
 #define XTKBD_EMUL1     0xe1
-- 
2.17.1

