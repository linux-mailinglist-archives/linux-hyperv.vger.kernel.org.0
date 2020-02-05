Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 33AF8153A44
	for <lists+linux-hyperv@lfdr.de>; Wed,  5 Feb 2020 22:33:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727106AbgBEVcy (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 5 Feb 2020 16:32:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:40694 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727085AbgBEVcy (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 5 Feb 2020 16:32:54 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1BFF82072B;
        Wed,  5 Feb 2020 21:32:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580938373;
        bh=5pX9Wz45X6jX7QtLlhhgzmhVrZWZIX3BDnNmDXbWHek=;
        h=From:To:Cc:Subject:Date:From;
        b=yCV/cVbXj3QOXFUrwJcZGmv2Ee5JhlnZW21u/58P6MfbGKGzojrC7Ip+3UHHJzpLj
         Ejr1UY48Zc8/5aiZ5fVGoE5gQMRsPCs2M0UEQxce0hweT3ogE9zPaMxcPIhpL0mfqf
         EjBur5RSDuY3WxgjRKp+Kd1iE+fLR/9Jyd9mX2Lo=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-hyperv@vger.kernel.org
Cc:     sthemmin@microsoft.com, haiyangz@microsoft.com, kys@microsoft.com,
        mikelley@microsoft.com, jamorris@microsoft.com,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH] Hyper-V: Drop Sasha Levin from the Hyper-V maintainers
Date:   Wed,  5 Feb 2020 16:32:42 -0500
Message-Id: <20200205213242.31343-1-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 9ed8bb8a1f5f..92cd55dfabe5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7732,7 +7732,6 @@ Hyper-V CORE AND DRIVERS
 M:	"K. Y. Srinivasan" <kys@microsoft.com>
 M:	Haiyang Zhang <haiyangz@microsoft.com>
 M:	Stephen Hemminger <sthemmin@microsoft.com>
-M:	Sasha Levin <sashal@kernel.org>
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git
 L:	linux-hyperv@vger.kernel.org
 S:	Supported
-- 
2.20.1

