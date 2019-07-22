Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 74E5C7010A
	for <lists+linux-hyperv@lfdr.de>; Mon, 22 Jul 2019 15:31:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728034AbfGVNb2 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 22 Jul 2019 09:31:28 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:45624 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727805AbfGVNb2 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 22 Jul 2019 09:31:28 -0400
Received: by mail-pf1-f195.google.com with SMTP id r1so17374968pfq.12;
        Mon, 22 Jul 2019 06:31:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=FtWmebQr/wwDVzYuQ8tfBuf24bqv7o93pgUzav6bNns=;
        b=SoRJLzf3jqIxFN89WUU8v0XpYDZkWyMGBpFG1xyEIfvjC77P1XVzJM8oSgRUBcREIG
         sjMuSodR/HQjIuAy1PK/4eTtd3BUTKqY+KHTtOM4lPWZ6qad/tK+mF28p8wRBG+pI4H5
         FaSTdAmsBNCAV56GlnDfOyz/QkrjR020yXeLyUVT5Zh6AgakaFNylX+1li6MHdTCVLBl
         fLSfuHgMkDCkoN4KeQlCXQN9jiBhBkVcFk4F9XwwHbZbH7pH0Zt2U3FLOaghG5ZoJKA0
         vSyH98zDL4e9/Z3GAr+pi6CSG4/OMyslesq42wPMVqQWJGgJsdTvw3F4DWHC+Q26+74j
         86JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=FtWmebQr/wwDVzYuQ8tfBuf24bqv7o93pgUzav6bNns=;
        b=tHqLhAGqg5JtpM/BCn9XrmCbAbMX0IvrTJcMLu/FABBN1NEJ8LQOJ0zOjNOs1WLv1G
         8fo5kqjqSffMmD7cHhZbYXQv26vS037cHvDBmWC2HqMUORKZ73L56F24JDgtSKzD8w+B
         oAtfEf7I6vhtN74q1CdyAiV7lb/JkB0RGKs2r8jEM+W0+9U1mGfFT8txa/rn+3fXuKeH
         xN/0nDsw58uS71IAtACE5hLmpDEF3RzqyUYiL3jBY2c7w/HrhdE8uR1aQ4rS14uC5oHP
         SmoDtGJuy3+sHXiXGUNKPjo47PRk0cK/zTiZx3RYn5OuztzyHDrNU5X0XBAWx7mICqPx
         W1Mw==
X-Gm-Message-State: APjAAAX1BlEdeSR3P+Jcx/xA26PSRh3e64YUQIdEauuE6IXI48SGGuYe
        Ea0ebVfKMJKqH/v+trysmLQ=
X-Google-Smtp-Source: APXvYqw1+KHz+tgFnb89K/ZYG+IR9nWp4KmDZ0ZzGC0vz2rI5rZ1NsiabvMNwseZQv1pp5ew8t8nRA==
X-Received: by 2002:a62:be04:: with SMTP id l4mr272893pff.77.1563802287993;
        Mon, 22 Jul 2019 06:31:27 -0700 (PDT)
Received: from nishad (p3261240-ipngn21201hodogaya.kanagawa.ocn.ne.jp. [153.202.122.240])
        by smtp.gmail.com with ESMTPSA id r15sm42601969pfh.121.2019.07.22.06.31.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 22 Jul 2019 06:31:27 -0700 (PDT)
Date:   Mon, 22 Jul 2019 19:01:17 +0530
From:   Nishad Kamdar <nishadkamdar@gmail.com>
To:     "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>
Cc:     Sasha Levin <sashal@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joe Perches <joe@perches.com>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] hv: Use the correct style for SPDX License Identifier
Message-ID: <20190722133112.GA7990@nishad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

This patch corrects the SPDX License Identifier style
in the trace header file related to Microsoft Hyper-V
client drivers.
For C header files Documentation/process/license-rules.rst
mandates C-like comments (opposed to C source files where
C++ style should be used)

Changes made by using a script provided by Joe Perches here:
https://lkml.org/lkml/2019/2/7/46

Suggested-by: Joe Perches <joe@perches.com>
Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>
---
 drivers/hv/hv_trace.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hv/hv_trace.h b/drivers/hv/hv_trace.h
index 999f80a63bff..e70783e33680 100644
--- a/drivers/hv/hv_trace.h
+++ b/drivers/hv/hv_trace.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 
 #undef TRACE_SYSTEM
 #define TRACE_SYSTEM hyperv
-- 
2.17.1

