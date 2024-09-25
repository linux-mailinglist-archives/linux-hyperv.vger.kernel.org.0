Return-Path: <linux-hyperv+bounces-3069-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34CFE985E1D
	for <lists+linux-hyperv@lfdr.de>; Wed, 25 Sep 2024 15:28:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A89728D3CE
	for <lists+linux-hyperv@lfdr.de>; Wed, 25 Sep 2024 13:28:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F21D220C172;
	Wed, 25 Sep 2024 12:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E8El7sKu"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C174020C16D;
	Wed, 25 Sep 2024 12:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727266132; cv=none; b=UA0Flm6G462G0ciwagY0hbn+wvmdm0nGlgwlmct4/DjtqMWcsSP4YiI+qEvFtE3ZVaXkNeZ/Mea/yFJhb2gdF//HeZ6v4jhv9m8pEr8a2n9Ec8AzyAS1PkrRRd1asZ0dX8HlbRpiKz5a2r1t9eHXl8UosuLbeljzra+CYkf6dgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727266132; c=relaxed/simple;
	bh=KB3Voe/r7loVzo9RGmFLp4l75KPEDvcU1yHXNRnnrq8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Nt4JSD/aidW4NB2RSM2BaZN6vTdXODn40kU6KghFkwgZQOsnwL0mupLLQL9rX5Lplo4v3S+ghJ/ZgpnXRjEElIKt5I9gpXi0ZmXmNNzchrnXpDWTIhGS+jaOynG5H8Yxnlqu2UH3lpAi/dGcvFzdTLshyUGjnZ38ssuYiHZ2qIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E8El7sKu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D051C4CEC3;
	Wed, 25 Sep 2024 12:08:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727266132;
	bh=KB3Voe/r7loVzo9RGmFLp4l75KPEDvcU1yHXNRnnrq8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=E8El7sKucuKoVfEAp6L8p16ZoF4xRZu/uCrEozleq0PwXia7ydb9kDYpetAOxhw0v
	 5H2qX1OtDlf5KZ+SOqHHWiLs/mEAjejXMBvcVfxTUwvOHn3PkaXq3HSu+E5FBxra0i
	 VNwmUN/Pp9kjuymTo0aOcei2v0KlK+9oGfp4HDoIzlIqrmAkUp6bp1tqKSYHZgIm3I
	 EfqIpORQf83ZLnDzqg/OOi9MUPfJfpa33vJ3vABE1qQKv/C85isw7XW7kqQ+UzdE/6
	 RuKx+M7hNrJiJRdSnDQA09CtgrDBZixf0jSr2J+2KnBWtGGAGdqz0NwYDUhV3C72/l
	 MxUPjRnwMfdDA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Zhu Jun <zhujun2@cmss.chinamobile.com>,
	Dexuan Cui <decui@microsoft.com>,
	Saurabh Sengar <ssengar@linux.microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	kys@microsoft.com,
	haiyangz@microsoft.com,
	linux-hyperv@vger.kernel.org
Subject: [PATCH AUTOSEL 6.10 183/197] tools/hv: Add memory allocation check in hv_fcopy_start
Date: Wed, 25 Sep 2024 07:53:22 -0400
Message-ID: <20240925115823.1303019-183-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240925115823.1303019-1-sashal@kernel.org>
References: <20240925115823.1303019-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.10.11
Content-Transfer-Encoding: 8bit

From: Zhu Jun <zhujun2@cmss.chinamobile.com>

[ Upstream commit 94e86b174d103d941b4afc4f016af8af9e5352fa ]

Added error handling for memory allocation failures
of file_name and path_name.

Signed-off-by: Zhu Jun <zhujun2@cmss.chinamobile.com>
Reviewed-by: Dexuan Cui <decui@microsoft.com>
Tested-by: Saurabh Sengar <ssengar@linux.microsoft.com>
Link: https://lore.kernel.org/r/20240906091333.11419-1-zhujun2@cmss.chinamobile.com
Signed-off-by: Wei Liu <wei.liu@kernel.org>
Message-ID: <20240906091333.11419-1-zhujun2@cmss.chinamobile.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/hv/hv_fcopy_uio_daemon.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tools/hv/hv_fcopy_uio_daemon.c b/tools/hv/hv_fcopy_uio_daemon.c
index 3ce316cc9f970..7a00f3066a980 100644
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
2.43.0


