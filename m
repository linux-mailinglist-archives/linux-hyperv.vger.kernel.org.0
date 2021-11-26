Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEF2C45E5D1
	for <lists+linux-hyperv@lfdr.de>; Fri, 26 Nov 2021 04:00:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358667AbhKZCpZ (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 25 Nov 2021 21:45:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358672AbhKZCnY (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 25 Nov 2021 21:43:24 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0ECDC06137B;
        Thu, 25 Nov 2021 18:33:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=JLO8pQd3dWbfDB47JY6jJOriLrL+UkwgnSoi8Q/Wrxo=; b=cplvTOdpkBzO9776SQk31S3TKQ
        yK+w0VqpS8oDw5a87MCcaH6HGR38PeRcVYgGa064xzNQJUjA73CdSn74+rWvbbvrNbyjDi1+zkafl
        GA6DU6d5570UCOnNn0xed73VRD6P+78PssqjjLZf8A4shylcwPMTKWcIi8MZV+dAbZJ0IjnSHrqs5
        1N2IE4o0Ayg00C6GrY2thGlG6dzzJwjxrdLGiE5mhnLk7XWaxR0MIwlrIoCgT9JQOoa2jPsIUilN8
        4nlfI5UjYknHn4DiTgB/r3dJizRtnnLoQvJAhruGLNVpECaI/CcZ1puXvgK7GaMnynQIhPnqmCPYX
        bPlO8H2w==;
Received: from [2601:1c0:6280:3f0::aa0b] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mqR36-0091PI-W5; Fri, 26 Nov 2021 02:33:17 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        kernel test robot <lkp@intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        linux-hyperv@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH] hv: utils: add PTP_1588_CLOCK to Kconfig to fix build
Date:   Thu, 25 Nov 2021 18:33:16 -0800
Message-Id: <20211126023316.25184-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

The hyperv utilities use PTP clock interfaces and should depend a
a kconfig symbol such that they will be built as a loadable module or
builtin so that linker errors do not happen.

Prevents these build errors:

ld: drivers/hv/hv_util.o: in function `hv_timesync_deinit':
hv_util.c:(.text+0x37d): undefined reference to `ptp_clock_unregister'
ld: drivers/hv/hv_util.o: in function `hv_timesync_init':
hv_util.c:(.text+0x738): undefined reference to `ptp_clock_register'

Fixes: 46a971913611a ("Staging: hv: move hyperv code out of staging directory")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Reported-by: kernel test robot <lkp@intel.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: "K. Y. Srinivasan" <kys@microsoft.com>
Cc: Haiyang Zhang <haiyangz@microsoft.com>
Cc: Stephen Hemminger <sthemmin@microsoft.com>
Cc: Wei Liu <wei.liu@kernel.org>
Cc: Dexuan Cui <decui@microsoft.com>
Cc: linux-hyperv@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/hv/Kconfig |    1 +
 1 file changed, 1 insertion(+)

--- linux-next-20211125.orig/drivers/hv/Kconfig
+++ linux-next-20211125/drivers/hv/Kconfig
@@ -19,6 +19,7 @@ config HYPERV_TIMER
 config HYPERV_UTILS
 	tristate "Microsoft Hyper-V Utilities driver"
 	depends on HYPERV && CONNECTOR && NLS
+	depends on PTP_1588_CLOCK_OPTIONAL
 	help
 	  Select this option to enable the Hyper-V Utilities.
 
