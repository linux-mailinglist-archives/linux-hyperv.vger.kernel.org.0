Return-Path: <linux-hyperv+bounces-3384-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8922C9E01E6
	for <lists+linux-hyperv@lfdr.de>; Mon,  2 Dec 2024 13:18:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44C6D16DF47
	for <lists+linux-hyperv@lfdr.de>; Mon,  2 Dec 2024 12:15:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF5A71FF5E6;
	Mon,  2 Dec 2024 12:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aepfle.de header.i=@aepfle.de header.b="MEM65gzR";
	dkim=permerror (0-bit key) header.d=aepfle.de header.i=@aepfle.de header.b="YJwBR9Bx"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0B041FECA7;
	Mon,  2 Dec 2024 12:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.218
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733141278; cv=pass; b=c1UWhfGw+vqCaz909ts7V4/7ygaFT1cXrgV+W1rvaM6cSlJGlxCSk6Dwet5lK11N3VYq6+vrXgs5rbFKXRe8A88oRzaAMSH31Mv9QKHd+uh/sVx5ITXOt89IZ2r8EuEhGD/hmuXSdPrfzWauImXcJLFZCTO8NEF0ExLeI9s90Xs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733141278; c=relaxed/simple;
	bh=o7Ud+cvNPHrey1c8b1YKen0TsLIn4c3OMSNkknvUDAA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=huwmBWkFURxogtaQWjETv3L5GcLBW/vzZFTXnoVB+uhuvxn6ygf0wMfmaWeRk6d055apQkcCBlq2tSuWWjpjTG+xk5bn3T3ICL1M+I2CTbymwxIlYmDEjAWyAZdbDuYrUg6sHFH3LKQWs7wyHsRwMdslr/GagObXTE6buKmq6Rg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=aepfle.de; spf=pass smtp.mailfrom=aepfle.de; dkim=pass (2048-bit key) header.d=aepfle.de header.i=@aepfle.de header.b=MEM65gzR; dkim=permerror (0-bit key) header.d=aepfle.de header.i=@aepfle.de header.b=YJwBR9Bx; arc=pass smtp.client-ip=81.169.146.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=aepfle.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aepfle.de
ARC-Seal: i=1; a=rsa-sha256; t=1733141075; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=XdxiNT3hqmNu4SV5FmQIzXx4zpCH07NFkqsxwroJ8tnOOXSiNHnT2dKPjJgTUcJsoa
    UGFZ+KhUB+cIIDD1BPad7pKWBfkkel82X0CuNwYGds++pphGjtj6IqaUdSg3t54A1xWu
    Zqcvbx6CbHwn4AeqX8k61Mp8kIV/8971PbktJaEJdVlt0zJNfMi2sW5ZIL7b9KBRx0rK
    FYeQyqaafBC6TJaKyxg36ay/7WF6J3r/ww05wDoU0tIJ/6tVzq7P9qiSRxd7DKp5/8oD
    Osp3xvqItTpj8bWbKulIH5pvhDIfoIm4OdjNu2s5GDxluT6Wd7C1ONnKQkivoV205d82
    RcnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1733141075;
    s=strato-dkim-0002; d=strato.com;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=buCPLxYTTnHGIbnaGtY5EBfZCa2VAiJd04VS0YcqUWc=;
    b=bnontD8WtsIgeuLCcEvMrEz7OxGh5ZtbUvmHcxrdOB1eGT/rhRO/tCunmxzbTpNezo
    4iG5GDGMq/tV6iRvOPbFv4PufrYV0q5RswX6MVxodAMmgjKomqh4k1zZJiQZKtRIHxCP
    xITt2UNBHn1c+HgX+dBJ4U18MfYcQ7r72Enm95p340k/4RkO8kOWZITDNbzod4r1+7H1
    G/VhrLn9OtZnPTLHwMgxbDElsg7zGnAvK9J9Eu391+C0elIJb1JXw77FWXawws9nHpUP
    noU3x7lvZbXvIzb6xeB3Yyf2zAXUGrb4xoqPt+VUaSGGkujJiLJZomSS5DxW5G3E+2li
    C4KA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1733141075;
    s=strato-dkim-0002; d=aepfle.de;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=buCPLxYTTnHGIbnaGtY5EBfZCa2VAiJd04VS0YcqUWc=;
    b=MEM65gzRgBD11TfWqgFq8TSZe79aA0YqDOqzDlc898A9VaCbht/jLuQfx+tcf/khP8
    wAeqkge7H706oCMSPH3lMjSNtpDIpAe9z1OpWLy/9MYF/a+LUP8X1gMgaBEzC1NitzrI
    zBRC6WVVMHXl6xTbTMkDvvpLycaFezXiAhjH4XsoWDbKP/R6pMs5KggaJG55iGvdb1rt
    B4eDvHREh8iMjN0NHQinKSnzoIq1pi+q/8HqRhRonhwQeBk5bkqopVXiUsPELjqbxxCT
    bCA9dUmrEaO6sj7fwO4WnfZliSNqXdDrrXXq9psXGMNTv0km1JST1HAafJvgIOQ98XqR
    0C8Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1733141075;
    s=strato-dkim-0003; d=aepfle.de;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=buCPLxYTTnHGIbnaGtY5EBfZCa2VAiJd04VS0YcqUWc=;
    b=YJwBR9BxF0uA+i431cnA4iLhrbOtiKmfcD8yeYr+9HPpR8VdnbK4iyMuO+TbrFKuWo
    S8HPvTF25zSPkH0sF5Ag==
X-RZG-AUTH: ":P2EQZWCpfu+qG7CngxMFH1J+3q8wa/QXkBR9MXjAuzpIG0uv8ZofWaSUMjanMCZmxMwm2OGJkumVDfIDOsNMxne61spO"
Received: from sender
    by smtp.strato.de (RZmta 51.2.11 AUTH)
    with ESMTPSA id Dd65250B2C4ZpJ2
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Mon, 2 Dec 2024 13:04:35 +0100 (CET)
From: Olaf Hering <olaf@aepfle.de>
To: linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: "K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>
Subject: [PATCH v1] tools/hv: reduce resouce usage in hv_get_dns_info helper
Date: Mon,  2 Dec 2024 13:04:10 +0100
Message-ID: <20241202120432.21115-1-olaf@aepfle.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="us-ascii"

Remove the usage of cat. Replace the shell process with awk with 'exec'.
Also use a generic shell because no bash specific features will be used.

Signed-off-by: Olaf Hering <olaf@aepfle.de>
---
 tools/hv/hv_get_dns_info.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/hv/hv_get_dns_info.sh b/tools/hv/hv_get_dns_info.sh
index 058c17b46ffc..268521234d4b 100755
--- a/tools/hv/hv_get_dns_info.sh
+++ b/tools/hv/hv_get_dns_info.sh
@@ -1,4 +1,4 @@
-#!/bin/bash
+#!/bin/sh
 
 # This example script parses /etc/resolv.conf to retrive DNS information.
 # In the interest of keeping the KVP daemon code free of distro specific
@@ -10,4 +10,4 @@
 # this script can be based on the Network Manager APIs for retrieving DNS
 # entries.
 
-cat /etc/resolv.conf 2>/dev/null | awk '/^nameserver/ { print $2 }'
+exec awk '/^nameserver/ { print $2 }' /etc/resolv.conf 2>/dev/null

