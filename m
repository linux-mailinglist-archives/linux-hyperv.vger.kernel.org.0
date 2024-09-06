Return-Path: <linux-hyperv+bounces-2983-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B7F396EEDC
	for <lists+linux-hyperv@lfdr.de>; Fri,  6 Sep 2024 11:13:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4841B288446
	for <lists+linux-hyperv@lfdr.de>; Fri,  6 Sep 2024 09:13:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCAEF1C7B7C;
	Fri,  6 Sep 2024 09:13:52 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from cmccmta2.chinamobile.com (cmccmta6.chinamobile.com [111.22.67.139])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33BC114E2C2;
	Fri,  6 Sep 2024 09:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725614032; cv=none; b=C4faHQhV6gnuxYj1Wco+PpcRlpSynT8RPlICLBIxJuuXcpuNWTOk6CQ3vekWcRCLzn/6fmPHtvSZMQbxKZ6gFtzu0Ar7ZmuE+GcMZhWyIHcOf7EfKRvW0coCs9Xgl8YCZgVTsBDOUEEerIjNjiou5LOF1GptyRSVPbT/S7gjh3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725614032; c=relaxed/simple;
	bh=QGdXnRwcQOxSLyNlriXbSs16Ux1V1fZQ2F+Y4q0j0jU=;
	h=From:To:Cc:Subject:Date:Message-Id; b=PNFDgJ30Utx7XRpBrk2lsCBGKCJE1KAuUjDU+bjiTVI3clZJHWy2jUZIRz0Y+3HRhR6sI7iL+D/r9NWCPmmBXIS1oQu5865LfTXVm7lx6WuWGVG60d4u4DQ6hjvuMG7ULdbfOaUFKf14fRsH8iGUtpLNGMrxLT9NvnzMJESxRLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app05-12005 (RichMail) with SMTP id 2ee566dac7bf8ad-f78b0;
	Fri, 06 Sep 2024 17:13:36 +0800 (CST)
X-RM-TRANSID:2ee566dac7bf8ad-f78b0
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from ubuntu.localdomain (unknown[10.54.5.255])
	by rmsmtp-syy-appsvr02-12002 (RichMail) with SMTP id 2ee266dac7be09a-a8e08;
	Fri, 06 Sep 2024 17:13:36 +0800 (CST)
X-RM-TRANSID:2ee266dac7be09a-a8e08
From: Zhu Jun <zhujun2@cmss.chinamobile.com>
To: decui@microsoft.com
Cc: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	zhujun2@cmss.chinamobile.com
Subject: [PATCH v3] tools/hv: Add memory allocation check in hv_fcopy_start
Date: Fri,  6 Sep 2024 02:13:33 -0700
Message-Id: <20240906091333.11419-1-zhujun2@cmss.chinamobile.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Added error handling for memory allocation failures
of file_name and path_name.

Signed-off-by: Zhu Jun <zhujun2@cmss.chinamobile.com>
---
v1->v2:
    Add cleanup memory
v2->v3:
	If we're calling exit() just 2 lines later, it doesn't make a lot of sense
	to call free().
	free(NULL) is valid (refer to "man 3 free").

 tools/hv/hv_fcopy_uio_daemon.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tools/hv/hv_fcopy_uio_daemon.c b/tools/hv/hv_fcopy_uio_daemon.c
index 3ce316cc9f97..7a00f3066a98 100644
--- a/tools/hv/hv_fcopy_uio_daemon.c
+++ b/tools/hv/hv_fcopy_uio_daemon.c
@@ -296,6 +296,13 @@ static int hv_fcopy_start(struct hv_start_fcopy *smsg_in)
 	file_name = (char *)malloc(file_size * sizeof(char));
 	path_name = (char *)malloc(path_size * sizeof(char));
 
+	if (!file_name || !path_name) {
+		free(file_name);
+		free(path_name);
+		syslog(LOG_ERR, "Can't allocate memory for file name and/or path name");
+		return HV_E_FAIL;
+	}
+
 	wcstoutf8(file_name, (__u16 *)in_file_name, file_size);
 	wcstoutf8(path_name, (__u16 *)in_path_name, path_size);
 
-- 
2.17.1




