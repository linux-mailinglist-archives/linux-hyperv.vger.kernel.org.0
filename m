Return-Path: <linux-hyperv+bounces-3146-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E500D9A0CCB
	for <lists+linux-hyperv@lfdr.de>; Wed, 16 Oct 2024 16:35:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9BF3D1F21FAF
	for <lists+linux-hyperv@lfdr.de>; Wed, 16 Oct 2024 14:35:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A417156225;
	Wed, 16 Oct 2024 14:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aepfle.de header.i=@aepfle.de header.b="fYujzWgt";
	dkim=permerror (0-bit key) header.d=aepfle.de header.i=@aepfle.de header.b="a9ubdfs1"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C86881D1748;
	Wed, 16 Oct 2024 14:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729089352; cv=pass; b=VdLhC/ikE+oFWtBLjU+JU4fwZFTciEomADG6s0SZKKzjYmroYQs/c9++/HjxYpZ2lQwvf66dsFfeQDV+DqjZf09rau/5vq/8yB35tYoM9TDt8QwLbzEHt88k0qI8yuJb5Hqoy8/LwDav4sJcKm6ECfjV7SfojHIpk0bAztnTEM0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729089352; c=relaxed/simple;
	bh=h419Z3V/aaon8M+3jOc/PFtlEbfPppa2NuFJJYYWug0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ttRYze1nBH4qTimCr+UuQdYI0xN4vBJgPrwjNm1SbmHWzsu49Ycmr2+hKayngcX1Dfc+qe4ceCN7BGXsYg5hOr1FO3J2GqVkLMCsnd6Dk0vK8tNsLe5hylyne+aJ+EPfnpTqU+jJDCpBsJ+UJNIBBdX7DzIzZBJVGSq2RcAZyAk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=aepfle.de; spf=pass smtp.mailfrom=aepfle.de; dkim=pass (2048-bit key) header.d=aepfle.de header.i=@aepfle.de header.b=fYujzWgt; dkim=permerror (0-bit key) header.d=aepfle.de header.i=@aepfle.de header.b=a9ubdfs1; arc=pass smtp.client-ip=85.215.255.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=aepfle.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aepfle.de
ARC-Seal: i=1; a=rsa-sha256; t=1729089329; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=rR+kvGYFCfnPj2RXfUAtlM2IOsISuYY0xe6jYO2hyzaHB0ydLzYs/fQGhk89bK3vmf
    I8Dr79XuHU8lk52rN/m0cMbmQdYfBFBFH/IuNZ31h2f130/aIFKZLblMmMLBwa8s2h8T
    gidevjjxZRaWbvvP7H9lE8YuaMThUUa43WU7VQ6ex+r3W61/3yZprT5hG0nzJqSBlQ+e
    YZULZqc7BApa8Y4DB7Qm7APu+RpMQ03iUOPOr0Bo6fcY3JBZkyOuqqa3oF2IkktISm5t
    /AWtG7PRFPxzQU/L14hlssjvMjrUk1O5lMyWvTRIE/gohKrODVdHJjcQuYxN/OnBaJR3
    zG9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1729089329;
    s=strato-dkim-0002; d=strato.com;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=Io0PU/P9fjKf7Ebpo/yC87JDg+SO2JBL1gLbqaKaO6Y=;
    b=CeLy5/Bu4cwKhe3stRc+tuve9dSWmEF+b8SEZR2PgYF+IrNFOv2Cjb8vmGoZG1zI7u
    e96QCIciHutRJHsPFLmROrfazHIPqinMllMuc230PkT50dVf+MEISIN3nvwI+XblQaYd
    K5+eOCxSc9I73LY/z8YrWgTFXB5RV8uhMjNpTJ9hCMlgAQTZ2shmOhCdQpGGjtFHOhDA
    cPjJtxLFdhUk5FiH07kDOONs9mUkmWRO1PD++CIyU5LPa1ytdnj3FtRE8JQLpGciCjT0
    YAokLl5d5YcW1auz8FQlvaZhyowRZApEzhfm0oX5P2ppFaBxqsDRDA0iWx0T2dV3fl6/
    wXQw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1729089329;
    s=strato-dkim-0002; d=aepfle.de;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=Io0PU/P9fjKf7Ebpo/yC87JDg+SO2JBL1gLbqaKaO6Y=;
    b=fYujzWgtfdf9EQBKAa9cFSI4bhM+bDccn6H2Cc40exF2qWlk9LqROGd4tXHAx0JLCa
    dIuuVwu8GtmxAffARfLVCxo+aFJr3SYWPhhDdCl4qsDZNkLqFwlmvtgRVprmv1se7k9G
    1RB/d4BekB+C/3Jt1FOZldL3CbdypAwxvm+/6uaAiedMAcGAMZpBJu/LDSxOgYVrFk2J
    sOCFPAaFg6fKevB/Lf/1vAlIPD21Es3tSOqjgthyvpX9HtSgRXeM5JXNdjkHnvVd0Uta
    OyVDKGBzlxgKM2F/VkvKcSQusCL/L3E3amfxD4Cj3acEK92lHdOQtxemvstNGGq3CjOF
    ZnCA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1729089329;
    s=strato-dkim-0003; d=aepfle.de;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=Io0PU/P9fjKf7Ebpo/yC87JDg+SO2JBL1gLbqaKaO6Y=;
    b=a9ubdfs1rte67GGEkwM78ysjxzI7og6sIds3ttzpgqy7jMspeC+UYI2Z/1K7YqQkBJ
    iDVSTNUlHcAdtZvCWgAw==
X-RZG-AUTH: ":P2EQZWCpfu+qG7CngxMFH1J+3q8wa/QXkBR9MXjAuzpIG0mv9coXAg4x9Fz7RcwtehfOImJwE3/YIR5VTNLPLdtEAAwSMQ=="
Received: from sender
    by smtp.strato.de (RZmta 51.2.11 AUTH)
    with ESMTPSA id Dd652509GEZT8oc
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Wed, 16 Oct 2024 16:35:29 +0200 (CEST)
From: Olaf Hering <olaf@aepfle.de>
To: Wei Liu <wei.liu@kernel.org>,
	Shradha Gupta <shradhagupta@linux.microsoft.com>,
	Ani Sinha <anisinha@redhat.com>,
	Saurabh Sengar <ssengar@linux.microsoft.com>,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: "K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Dexuan Cui <decui@microsoft.com>
Subject: [PATCH v1] tools: hv: change permissions of NetworkManager configuration file
Date: Wed, 16 Oct 2024 16:35:10 +0200
Message-ID: <20241016143521.3735-1-olaf@aepfle.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="us-ascii"

Align permissions of the resulting .nmconnection file, instead of
the input file from hv_kvp_daemon. To avoid the tiny time frame
where the output file is world-readable, use umask instead of chmod.

Fixes: 42999c90 ("Support for keyfile based connection profile")

Signed-off-by: Olaf Hering <olaf@aepfle.de>
---
 tools/hv/hv_set_ifconfig.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/hv/hv_set_ifconfig.sh b/tools/hv/hv_set_ifconfig.sh
index 440a91b35823..2f8baed2b8f7 100755
--- a/tools/hv/hv_set_ifconfig.sh
+++ b/tools/hv/hv_set_ifconfig.sh
@@ -81,7 +81,7 @@ echo "ONBOOT=yes" >> $1
 
 cp $1 /etc/sysconfig/network-scripts/
 
-chmod 600 $2
+umask 0177
 interface=$(echo $2 | awk -F - '{ print $2 }')
 filename="${2##*/}"
 

