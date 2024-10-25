Return-Path: <linux-hyperv+bounces-3192-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B91219B05E6
	for <lists+linux-hyperv@lfdr.de>; Fri, 25 Oct 2024 16:33:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A0DF1F23672
	for <lists+linux-hyperv@lfdr.de>; Fri, 25 Oct 2024 14:33:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B4E81CF7DB;
	Fri, 25 Oct 2024 14:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aepfle.de header.i=@aepfle.de header.b="SrCgi3We";
	dkim=permerror (0-bit key) header.d=aepfle.de header.i=@aepfle.de header.b="G2d4iblY"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74BBE21219A;
	Fri, 25 Oct 2024 14:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729866808; cv=pass; b=gZlX+qKLOEyMR1fUOj3siouXRY6LuFi2uTdMhnq8bMkaTWJDbFbnQjJ3GGc2c/wt0xMdAHzy3vC7S9lU9x66IqrOZcXbWy2q/kh2ESPKTJ9ktZcnW0EFcdv5nQUes309Q49NQHIHuK0taS49A2VsRNnE6hZBLIGp9UT+aiFLVfs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729866808; c=relaxed/simple;
	bh=MJG6llzNA1Ezi9Qp1EpDbMs427CVbL8entNvriXXFJU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=NCgGifopGUrAaeOKdTjNzds04U0PzK1e73TKDx7IdKr8u5Urzpw0FOdthVScsojBLEoPPUzZmVYUOfX/xl0ZlvYxv6cn2ipkUvfPNjJcHDot7ktOTsGMGC9nuyVC8UQUHrAzbeCN9g0GebzHOaPfh7Y5F7SYM7djfowfcHwvIbs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=aepfle.de; spf=pass smtp.mailfrom=aepfle.de; dkim=pass (2048-bit key) header.d=aepfle.de header.i=@aepfle.de header.b=SrCgi3We; dkim=permerror (0-bit key) header.d=aepfle.de header.i=@aepfle.de header.b=G2d4iblY; arc=pass smtp.client-ip=85.215.255.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=aepfle.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aepfle.de
ARC-Seal: i=1; a=rsa-sha256; t=1729866620; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=dzz96Ed7V1X4JOMay7KMwtzaIIkIAA9ARd/Cj5xQaUUzhpL4/sloUjvkRlTs2NY/u+
    Mazobpeoo/x4SugEd74k/k3sMKMrrgmnyPsqdBe/l3pLiU7dFkA4T1bhnf6hkAuO+HlV
    8iEWyZsD89AirUIDqpqKHjONB9LTLJVTOeIXlKMsmdo6Ez/a9uW20su0GG1J+sRG0ubr
    kTwvt3Ql0K6rwJcpuKq2r/RAmwFleik/mvv4EA+7S1SdNotx0ENYBCkmTTJhvqPSe4US
    e/2e1HezSxXwkhSzkvomA2GMn9w0EZt2eRqgsRVivPfb/Q8jN4uKfMPgaxI6QANeUU5T
    PDLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1729866620;
    s=strato-dkim-0002; d=strato.com;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=r3TwFbSRh2bryWKsoEKGGo3Mz07EwENxVAlOr4Sus7Q=;
    b=PS+KMiGSRYDfIeynvqGTfSZiCIzgqJJl0+Wf/9alghmiwPlUTWfohsAIqBOPC1/B0h
    ITNzwPIveb3XF8DjjlmSyjQ4vIEPOTm3meT5KTwIRpx0QH0mafnmx1RV8OXrCjYt26Ul
    Xgd9Rp/QF7glpZy7/l+2e7d5r/uua3qZDqK67U+Nze0Gq58lh9N/BZgFyiMQxkWIUleG
    6a7w7gl0/47GTkn66VD2k9UDGRv7rMVL/50zxBFfykQuFVqnaC6LAsm+fVTMlic5txIw
    1nRs/VzH4cITqN4kPOZ6chxsMEulzb37c44UlaxBHlzBOFJGMY2Xd+XkqSWX0s4nzlF5
    2icw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1729866620;
    s=strato-dkim-0002; d=aepfle.de;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=r3TwFbSRh2bryWKsoEKGGo3Mz07EwENxVAlOr4Sus7Q=;
    b=SrCgi3We2QKgHZWzB7peeeVO/FYOZOjJunGIhmjnDeayQ3zqfEqm8mxXxAyTKv/FE+
    LBHFTFEWc0vKcqkj+D2LaA0pWV8azy73p45iQ1i9DALrfrgplTpG7uFU9q6G3WPbmsdW
    a0/bTJW5ZZeAXkqTqxbwF99i2td27xwcrJkeks0Yu+Sw13hs1SXdHb3jj9e5P5hrLCYV
    NlDn61ze6Vjmr1Ru1/ntYmxCIs6n2lDC4D9qFpmfHaKI5XvQEp9nYdTX3Xna60Zb02NH
    3GLjTPll1izAv7d7DFN2wizK+H8PLemMxRg2wH9Ixj8anMaQXxKBJhXmpkW63AC2Y7po
    5Mgw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1729866620;
    s=strato-dkim-0003; d=aepfle.de;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=r3TwFbSRh2bryWKsoEKGGo3Mz07EwENxVAlOr4Sus7Q=;
    b=G2d4iblY+M1149OV/SWOKBmk/3k9yfhVWG1vOaVib9YGSlMvIzIr/wSgneFixmaSXw
    0C66r7NDG9zezKLGW+BQ==
X-RZG-AUTH: ":P2EQZWCpfu+qG7CngxMFH1J+3q8wa/QXkBR9MXjAuzpIG0mv9coXAg4x9Fz7RcwtehfOImJwE3/YIR5VTNLPLdtEAAwSMQ=="
Received: from sender
    by smtp.strato.de (RZmta 51.2.11 AUTH)
    with ESMTPSA id Dd652509PEUKemK
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Fri, 25 Oct 2024 16:30:20 +0200 (CEST)
From: Olaf Hering <olaf@aepfle.de>
To: linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: "K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>
Subject: [PATCH v1] tools/hv: terminate fcopy daemon if read from uio fails
Date: Fri, 25 Oct 2024 16:28:27 +0200
Message-ID: <20241025143009.4571-1-olaf@aepfle.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="us-ascii"

Terminate endless loop in reading fails, to avoid flooding syslog.

This happens if the "Guest services" integration service is
disabled at runtime in the VM settings.

Also handle an interrupted system call, and continue in this case.

Signed-off-by: Olaf Hering <olaf@aepfle.de>
---

A more complete fix is to handle this properly in the kernel,
by making the file descriptor unavailable for further operations.

 tools/hv/hv_fcopy_uio_daemon.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/hv/hv_fcopy_uio_daemon.c b/tools/hv/hv_fcopy_uio_daemon.c
index 7a00f3066a98..281fd95dc0d8 100644
--- a/tools/hv/hv_fcopy_uio_daemon.c
+++ b/tools/hv/hv_fcopy_uio_daemon.c
@@ -468,8 +468,10 @@ int main(int argc, char *argv[])
 		 */
 		ret = pread(fcopy_fd, &tmp, sizeof(int), 0);
 		if (ret < 0) {
+			if (errno == EINTR || errno == EAGAIN)
+				continue;
 			syslog(LOG_ERR, "pread failed: %s", strerror(errno));
-			continue;
+			goto close;
 		}
 
 		len = HV_RING_SIZE;

