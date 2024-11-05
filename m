Return-Path: <linux-hyperv+bounces-3257-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D40079BC7FA
	for <lists+linux-hyperv@lfdr.de>; Tue,  5 Nov 2024 09:27:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C5E91F233F3
	for <lists+linux-hyperv@lfdr.de>; Tue,  5 Nov 2024 08:27:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99B981A7AE3;
	Tue,  5 Nov 2024 08:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aepfle.de header.i=@aepfle.de header.b="gtMaSZqA";
	dkim=permerror (0-bit key) header.d=aepfle.de header.i=@aepfle.de header.b="UZpMy4A8"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D509418C93B;
	Tue,  5 Nov 2024 08:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.163
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730795226; cv=pass; b=S1nsnPa8igbq9kTJQ9xmVO5r+rTGRtxaeEBIXjdjJuvdUGVABGNlot488+HfJHL63+KHOgskbX3eNoKhAYlYnggOJmUX0vFhpw2IdQbwHr2pvrhXEk22nE9Y47j/P4jQc9ZwQ5UoVeRWtuD6yCQw38um+0FUZ3tCkq4giBk3Ekc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730795226; c=relaxed/simple;
	bh=PrRIGPA3WALXCA2BZn6WHkxhmEZQIUCFREiLj2NqGVs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=bYNnxKmZ++8PPz68LjKDAQz9oqAxWaDtNSW5vucR6mvDCZvhiVrnsuePsRJiOq8PKC7gjMC1wOBLs7Ocd3r3s3nCfnQtE2+ssmXsWT8DXSoloFhBKSxiVIaFEyVMkkglCxbGCN+vRkCqVV4Uf5L5cqgGvocWf5/HxcgsHELWidk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=aepfle.de; spf=pass smtp.mailfrom=aepfle.de; dkim=pass (2048-bit key) header.d=aepfle.de header.i=@aepfle.de header.b=gtMaSZqA; dkim=permerror (0-bit key) header.d=aepfle.de header.i=@aepfle.de header.b=UZpMy4A8; arc=pass smtp.client-ip=81.169.146.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=aepfle.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aepfle.de
ARC-Seal: i=1; a=rsa-sha256; t=1730794486; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=n3Uvj8ScrtHyUzZzt0pDD7wGwSYE4Qwf7nxaRLQYX3J7Wta0X+BxVyd4E4xi+J8HGB
    0bqTNMrlRazqqqx8jD3lTKSFS6LGfv7IJoZ2eMvMbGxDj5aUHXtVvHmoF6xt8dX9hSJq
    ori/JW7zays25oX3zjW3N1C7f8q7+c+6MQ3MbpYlHSxxCf1Nik4J5Ua2Qvdr/jiD/hQm
    Ji/JwRk4vf9u1xYqKkVODcgPz6vznllOhApUizfvSdEve0OtTDp0yRsApmefdLgErHOB
    mujnkerDlsNqkcow8IoPNlGh6X6rW4PvMbYEvkLX2AMloC2aYCOm7CeU6YUvQRr2tF67
    bBiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1730794486;
    s=strato-dkim-0002; d=strato.com;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=4VWfCa2PE343ZqD3jtQzWk6CyhebhGvWvwWT1BWLJw0=;
    b=pruBWqZVK4EQyJ4+2oL4gghdgDTa10nicYFpdKrGWKVGs+zrVy84yO8oFgrsL0S0G9
    qQey72F/s/DZVD/3Id2bwd1vtTMnCLzYnPgQ5J9X6kDMwj0W52y+Y8yj5sITDbbianYh
    7OUasueilep8/iSPTQ8PZM+dAXILZp/oF3cX6+0PDm/p2+aTCYFElJYg0KRSIu4lcx2m
    idbB2kax6ayVaRQdCeZHEqrDZ79r3PeqDlUo4/F7vnLQJTUNysE9gPYaVIiDm/l6xC9N
    QzImlkecVcMUe3QpJLFkD7Z6aVRgo+nWVa35AK4lp7yFRIkLYTZa1G4jx/brBAePCuZI
    PKTA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1730794486;
    s=strato-dkim-0002; d=aepfle.de;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=4VWfCa2PE343ZqD3jtQzWk6CyhebhGvWvwWT1BWLJw0=;
    b=gtMaSZqAnpGl2E7iNS/deneuvH6yGGPQ+TaE9/+349/FFJNx39IGTlEjSeMd/r/1Fg
    UNzgT7qmx8gOmilp6HlaVaZjTJbno6aHWj3jDkqqyoFhR1dfVPWkGe02EAJ6cNubpLcc
    gx3H+SKwA2tEq2cJbu5/mKVt3UPHOEdCSUY73d85R/dP1VLq/6Z4OBDhbZK15vVjg8Gd
    qsNX77bYePw2jpe6SQjtst5llCnBM7ZdpSJiKGE8QpUN4oBsvdfMEgJMOimEDyCEYoGC
    IbU8KMvbWq93x6l45gindYy+5292VvvhFJ4t+VL2pymtMvLYm5UTChE5A7aoc3Nb+X4d
    en8Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1730794486;
    s=strato-dkim-0003; d=aepfle.de;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=4VWfCa2PE343ZqD3jtQzWk6CyhebhGvWvwWT1BWLJw0=;
    b=UZpMy4A8qHaad/LW7fxMtMIsQu/LUgVUEdlzZRoQ9tplkA88Vn2kUIJMgWoZHlVQqQ
    ejxq5AKovHqY/Gyq7OBg==
X-RZG-AUTH: ":P2EQZWCpfu+qG7CngxMFH1J+3q8wa/QXkBR9MXjAuzpIG0mv9coXAg4x9Fz7RcwtehfOImJwE3/YIR5VTNLPLdtEAAwSMQ=="
Received: from sender
    by smtp.strato.de (RZmta 51.2.11 AUTH)
    with ESMTPSA id Dd65250A58EjCwp
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Tue, 5 Nov 2024 09:14:45 +0100 (CET)
From: Olaf Hering <olaf@aepfle.de>
To: linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: "K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>
Subject: [PATCH v2] tools/hv: terminate fcopy daemon if read from uio fails
Date: Tue,  5 Nov 2024 09:14:04 +0100
Message-ID: <20241105081437.15689-1-olaf@aepfle.de>
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

This happens if the state of "Guest services" integration service
is changed from "enabled" to "disabled" at runtime in the VM
settings. In this case pread returns EIO.

Also handle an interrupted system call, and continue in this case.

Signed-off-by: Olaf Hering <olaf@aepfle.de>
---
v2: update commit message

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

