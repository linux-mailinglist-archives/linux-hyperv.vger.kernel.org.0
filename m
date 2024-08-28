Return-Path: <linux-hyperv+bounces-2890-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7940296242E
	for <lists+linux-hyperv@lfdr.de>; Wed, 28 Aug 2024 12:00:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC4891C23FB5
	for <lists+linux-hyperv@lfdr.de>; Wed, 28 Aug 2024 10:00:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3259C1684B9;
	Wed, 28 Aug 2024 10:00:44 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from cmccmta2.chinamobile.com (cmccmta2.chinamobile.com [111.22.67.135])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 456CF158DB9;
	Wed, 28 Aug 2024 10:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724839244; cv=none; b=bjo6YDoe6Y+UL+MZYd6vJyKaQ9RWJQvTa2E1nsi3wl/e/Ia4g2Ia3D9c7KVLkHXbEP7olVHA44A6AHlynt4LS+8NekX13u0Jh4erjbLMkoQvuxQmHhb8SRKOUDwvyATMy8Bu42WpgsM691mHYubE/jMd56A+yF5Owc4p8IOnN9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724839244; c=relaxed/simple;
	bh=nbTnW3mbEq7uhqfWHhAJB1BJBT9A6r3uVygz/pecpP0=;
	h=From:To:Cc:Subject:Date:Message-Id; b=blMWRmVRy0dEk1rpIJlcF3ISFQomeFfwy6SoHRWTij9N28CftC1JsBoNWwg29ChsDHTKDGxE3KCis96orA11go4lEHLX5zu0X+9Dkuu36azbrbcfA4OhgqZZZKG2hsuvUGbHekBUUpNQBOgacvkoBviXWNJLKsM6raElNG5Vk1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app07-12007 (RichMail) with SMTP id 2ee766cef53eb14-acb18;
	Wed, 28 Aug 2024 18:00:32 +0800 (CST)
X-RM-TRANSID:2ee766cef53eb14-acb18
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from ubuntu.localdomain (unknown[223.108.79.99])
	by rmsmtp-syy-appsvr03-12003 (RichMail) with SMTP id 2ee366cef5405fa-5edf9;
	Wed, 28 Aug 2024 18:00:32 +0800 (CST)
X-RM-TRANSID:2ee366cef5405fa-5edf9
From: Zhu Jun <zhujun2@cmss.chinamobile.com>
To: kys@microsoft.com
Cc: haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	zhujun2@cmss.chinamobile.com
Subject: [PATCH] tools/hv: Add memory allocation check in hv_fcopy_start
Date: Wed, 28 Aug 2024 03:00:31 -0700
Message-Id: <20240828100031.3833-1-zhujun2@cmss.chinamobile.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Added checks for `file_name` and `path_name` memory allocation failures,
with error logging and process exit on failure.

Signed-off-by: Zhu Jun <zhujun2@cmss.chinamobile.com>
---
 tools/hv/hv_fcopy_uio_daemon.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/hv/hv_fcopy_uio_daemon.c b/tools/hv/hv_fcopy_uio_daemon.c
index 3ce316cc9f97..2efdf8d28e9c 100644
--- a/tools/hv/hv_fcopy_uio_daemon.c
+++ b/tools/hv/hv_fcopy_uio_daemon.c
@@ -295,6 +295,10 @@ static int hv_fcopy_start(struct hv_start_fcopy *smsg_in)
 
 	file_name = (char *)malloc(file_size * sizeof(char));
 	path_name = (char *)malloc(path_size * sizeof(char));
+	if (!file_name || !path_name) {
+		syslog(LOG_ERR, "Can't allocate memory!");
+		exit(EXIT_FAILURE);
+	}
 
 	wcstoutf8(file_name, (__u16 *)in_file_name, file_size);
 	wcstoutf8(path_name, (__u16 *)in_path_name, path_size);
-- 
2.17.1




