Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A5B1736E25
	for <lists+linux-hyperv@lfdr.de>; Thu,  6 Jun 2019 10:08:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726092AbfFFIIA (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 6 Jun 2019 04:08:00 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:34201 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726066AbfFFIH7 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 6 Jun 2019 04:07:59 -0400
Received: by mail-pf1-f194.google.com with SMTP id c85so1033365pfc.1;
        Thu, 06 Jun 2019 01:07:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=XCO3qo9+TquCRGCErGjH7wLbJcwWMhAPFzVepnTCaPU=;
        b=pWaZPsCxIx9Yl7/C7lmmLYjfFUTv3Jh1PNoQTRZVfh7k0k3RtLy8RaZgLDbsmrNBMx
         BwudOvAaWGXZIqTlwwMjoGr0/n8vCH7WsTIB9iaoc4yO0rp6N3S1mQRrsLzj5/hC7XAj
         d3ASjSrOUX0yTj1joHp5HtbXrfio1DzFK+787cbHdbCHMbOzLBbNjyZZKZwCTHLwjZXx
         HgiaBL18zqInYpAfGRNYeOhkUxhYyXXW/qekfiGFh6EjcIQRVt4ecRjyqr3zQpa031eI
         O8vAVjm1Yr8jhJ5ld86tkatpRiKAvJUcm0QH/LBEbhLTNC/r5UadSyShMUl3wGBUMck9
         DQFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XCO3qo9+TquCRGCErGjH7wLbJcwWMhAPFzVepnTCaPU=;
        b=k7NDsAaBD25nw60RnPR2JmZTOSEF1rW/2svKeLu+1e1ahe1UhF6eie4483xZ5iuBCS
         3VE/lOoawGNzvuHWGznW0W5wMKq45aK2qr6z1fuxC0YlgU8wsxIN/D8E+jrZi9Cz54Qf
         HH0HiTyfjxeWXtysQ3fnIb5P3EO9nPOXsfK3RnSIBsahRUxVhT7oRMP4oiNvH5gHOKv7
         LilqEoEVdieFn9HMiHE8H4jCeXbvmJRRh/2DIrvebQiBao1Jn794sspTOhLPvL8wWXPz
         uSSOlMpDufex6qbtxwcJjeGVzAu/KW5Y2de3hUB8RSEOCKM8fmw+E2N3HaT58a88QF+B
         siQA==
X-Gm-Message-State: APjAAAWcHJrLlS0YkjGvhuDQU58Odrp0wnqt/fwczkzOsrC0kBLRgjeq
        n4PyYDqGe0FnTw20VNrLsu9H4szksTE=
X-Google-Smtp-Source: APXvYqzUrccvA6IYn5V4dvuCAX0GiFhIE/oQ5lJgZc6joE2IyYwJSmbmjXl9EL07C+0liogvz9TItw==
X-Received: by 2002:a17:90a:5d15:: with SMTP id s21mr49092505pji.125.1559808479011;
        Thu, 06 Jun 2019 01:07:59 -0700 (PDT)
Received: from maya190131 ([13.66.160.195])
        by smtp.gmail.com with ESMTPSA id a25sm1343998pfo.112.2019.06.06.01.07.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 06 Jun 2019 01:07:58 -0700 (PDT)
Date:   Thu, 6 Jun 2019 08:07:58 +0000
From:   Maya Nakamura <m.maya.nakamura@gmail.com>
To:     mikelley@microsoft.com, kys@microsoft.com, haiyangz@microsoft.com,
        sthemmin@microsoft.com, sashal@kernel.org
Cc:     x86@kernel.org, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/5] HID: hv: Remove dependencies on PAGE_SIZE for ring
 buffer
Message-ID: <0e9385a241dc7c26445eb7e104d08e2e2c5d30de.1559807514.git.m.maya.nakamura@gmail.com>
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
 drivers/hid/hid-hyperv.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/hid-hyperv.c b/drivers/hid/hid-hyperv.c
index d3311d714d35..e8b154fa38e2 100644
--- a/drivers/hid/hid-hyperv.c
+++ b/drivers/hid/hid-hyperv.c
@@ -112,8 +112,8 @@ struct synthhid_input_report {
 
 #pragma pack(pop)
 
-#define INPUTVSC_SEND_RING_BUFFER_SIZE		(10*PAGE_SIZE)
-#define INPUTVSC_RECV_RING_BUFFER_SIZE		(10*PAGE_SIZE)
+#define INPUTVSC_SEND_RING_BUFFER_SIZE		(40 * 1024)
+#define INPUTVSC_RECV_RING_BUFFER_SIZE		(40 * 1024)
 
 
 enum pipe_prot_msg_type {
-- 
2.17.1

