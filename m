Return-Path: <linux-hyperv+bounces-3068-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E347985BD2
	for <lists+linux-hyperv@lfdr.de>; Wed, 25 Sep 2024 14:32:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AD637B2572D
	for <lists+linux-hyperv@lfdr.de>; Wed, 25 Sep 2024 12:32:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C5041C6883;
	Wed, 25 Sep 2024 11:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ptC1zd7U"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54AE51C6888;
	Wed, 25 Sep 2024 11:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727265183; cv=none; b=GJqOrPaR8H/2gzjAUAWhSKAnV/bQi4Ojsdb6QVyaCZXNF4OLXikuLzEAq0BEeMyOOoH42cA+vXDK1Sz9mOsW8YVvbRKefSIiEViPJ2lrNc8sRpS24M68vGgTnRd740Bc6irvtyCoB54QPcHcMIXloDdXJ6XMQ+66tsowVV+X4Bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727265183; c=relaxed/simple;
	bh=KB3Voe/r7loVzo9RGmFLp4l75KPEDvcU1yHXNRnnrq8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s8XI40+cKXvgM7wpT9ZwKo2eIct3BCqUHEszPbiIbbIyb2v4SUEjyyts0sBy3JTzfStacoy3M1TRrzkULm3cqjdfKz0g4CYOgt2YpYf/ZnjnVtxJ6KlPPWfykfSZFzwh7zA401lMsoKSZKnOs+8AM2i596bOZnd13B67JtiSpM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ptC1zd7U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB34CC4CEC3;
	Wed, 25 Sep 2024 11:53:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727265183;
	bh=KB3Voe/r7loVzo9RGmFLp4l75KPEDvcU1yHXNRnnrq8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ptC1zd7UVxid/tZyTZlON2KpI+uLEF6/n0dzIsNxT4VOhXR7vJE6RjkF72Sx6s48D
	 a/nhLYiTcd2FANJwKzfTTqnhgL4JbaR6LL+2v7tLYR8TGZOXFfERp6YpbyC9qbilhV
	 9iH5RX2Y3hCdmtY/gnjiIxuCpvd1+H/iYjuChfy6RyTx74j0Ic3qraoEqgccgKYq37
	 Y06qCS/SWWNCTvfLZyLDZpnlyXK65dc/7783YzZMO87fmXV2/X6YRjG1tISsFKQEfh
	 35EZmDoV4CNBaHDHKwgieWNU6JwnPB36kUw5xKdABHFF4/ZKobkJTl5MiHv9gz5LDr
	 NvCBvFOr1cUDQ==
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
Subject: [PATCH AUTOSEL 6.11 227/244] tools/hv: Add memory allocation check in hv_fcopy_start
Date: Wed, 25 Sep 2024 07:27:28 -0400
Message-ID: <20240925113641.1297102-227-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240925113641.1297102-1-sashal@kernel.org>
References: <20240925113641.1297102-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11
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


