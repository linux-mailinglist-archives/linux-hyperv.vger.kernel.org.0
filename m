Return-Path: <linux-hyperv+bounces-3386-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1001A9E0285
	for <lists+linux-hyperv@lfdr.de>; Mon,  2 Dec 2024 13:53:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E92EA161B8A
	for <lists+linux-hyperv@lfdr.de>; Mon,  2 Dec 2024 12:53:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C8181FE46C;
	Mon,  2 Dec 2024 12:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aepfle.de header.i=@aepfle.de header.b="Wu5Qy8VP";
	dkim=permerror (0-bit key) header.d=aepfle.de header.i=@aepfle.de header.b="rSVEMEFO"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8F8F1FE46A;
	Mon,  2 Dec 2024 12:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.166
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733144007; cv=pass; b=KP+f7ykcWy27PEsUdLgAw6pIrQsW+JTKiNpFzX9CA05aZvkM7OksnU9Ir40xsxengi52/b9HMo0xCBpUxz0vtTx9xk0J9F8kvrE6tbSKlxk+mg0LpTDLwW/yCocyNMI+JEui/kyLO0m119eq374ykLH/OJo6KH+tShywlwUuqgc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733144007; c=relaxed/simple;
	bh=OBANWVPeEsWnWClkkd0JggQSaB4u4F88Bwc3GutZWv4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=sn/0xn+B+cPRuplWyfNaK9kHlwCSwXuPDJn8Om8sj6K1CQuNEh2D5nR18pGHBC5b8s9+loLkRktdgvIiECnXhtKrAaKHv1RAi7XceLN4/i/T2W/3UqMGh4qDN16mq8oS8AFoFMtav0TeMJIAcR8LvRqByGsBTSM3YVRZusbKZPM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=aepfle.de; spf=pass smtp.mailfrom=aepfle.de; dkim=pass (2048-bit key) header.d=aepfle.de header.i=@aepfle.de header.b=Wu5Qy8VP; dkim=permerror (0-bit key) header.d=aepfle.de header.i=@aepfle.de header.b=rSVEMEFO; arc=pass smtp.client-ip=81.169.146.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=aepfle.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aepfle.de
ARC-Seal: i=1; a=rsa-sha256; t=1733142922; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=IdUAkvWb8e+e6TQxiSdtxQDlyqOUtiTO/37qszbH9tYqlY2zTdRYrxhr1Db11ceXsN
    lWgCx8uWY2vYcvmFJYV8yF78lov7JMEx3bHWPYRqj2bD4ojbbGcQWIYh7tGhdhkcXvs6
    xqJb8g2XWflr+tTWQmXcEURC724se8+ZG1dbw/7jwrIYvS6JLLsPbbBqKvnsU1TY8wva
    nMtk7KsMJv5jPqqtxcgw6bLdZ2foKEPkbK0a7fq5+FBIl5yCQJ5AYN+HAS3dTGHdQikC
    JM0Tj8tYfbv7WajlAL5lJvxbbt3GZgBK+b5xQDANx7WmGKzkOiMg+0Vm/m4GbIeD3bw5
    Q5NA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1733142922;
    s=strato-dkim-0002; d=strato.com;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=f3KE00RZlioWlkL8NkAOor2X8ISf0S+8YF16aWBK9Ss=;
    b=B0fGp5tpOEPakUyaBraP/FhIs81px5ltZmjELhl1v1vJMnGBO14zX6SgPp0Ap3dCzc
    JAPdNNi8JFvfPsriVOk3aVV6JHWghPitscTbpH7QozLFvURRQydDH24H6Q7OdlFeGRI6
    ilEdyu2PTGQ9Rio8aGBwG5Xdi+sYGTp3cPeLxL060wgLbJatqvrCSp3W6rcIi1v+By26
    ymAYJM+rkqhuiKztJbIeGw6IFjzCRi1zzzmsf2b1PO1iw0ZZxtdUfkNUKLub+xVsNYfF
    zlI4bvFOSarDY/ScI9D1RW6Bfm/4U0O6SjMZxcRdsbgiT9ZUpuKGfidg5o1qfk3EE7jl
    2P/Q==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1733142922;
    s=strato-dkim-0002; d=aepfle.de;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=f3KE00RZlioWlkL8NkAOor2X8ISf0S+8YF16aWBK9Ss=;
    b=Wu5Qy8VPHWNVhQAQ2rWTboPdvcziU2XkMA2cmnxdXaM4k+r/CJ65AwjN2xOZ0nv5j4
    4fGymOI7vZ4tbfmcSnnix16j4ZCQ+rG89bEuTVM30hoof4HbjCHfFmbfVDc8uyUuZqUd
    uvrcJNfAL2aakcTgh9dZaGhqBXr7HW0fI7Lf9HTdW2oHcuGZnl0C5zXih8Al0tz0k1b5
    4C34sxisUHKzeLKFZWfhydhQ/VRINjfH8pq9h9SpP5Jcc6TQPpjAWDBK7cMY7a1Toy1U
    NzC54kdZXVLSMdetFP9oCczdpga5vYxFUPFhz4mi1qZxcPudNwfTTo/KAQlWRYlxXJRT
    Dtbg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1733142922;
    s=strato-dkim-0003; d=aepfle.de;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=f3KE00RZlioWlkL8NkAOor2X8ISf0S+8YF16aWBK9Ss=;
    b=rSVEMEFOZG11q5W+dvm/M6o5zyrbYLgmNPYck9ULj8uCU497QB8T4phWrWa4R5CwHi
    JtDfsKgva2Yrmw8X5FAA==
X-RZG-AUTH: ":P2EQZWCpfu+qG7CngxMFH1J+3q8wa/QXkBR9MXjAuzpIG0uv8ZofWaSUMjanMCZmxMwm2OGJkumVDfIDOsNMxne61spO"
Received: from sender
    by smtp.strato.de (RZmta 51.2.11 AUTH)
    with ESMTPSA id Dd65250B2CZMpVa
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Mon, 2 Dec 2024 13:35:22 +0100 (CET)
From: Olaf Hering <olaf@aepfle.de>
To: linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: "K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>
Subject: [PATCH v1] tools/hv: reduce resouce usage in hv_kvp_daemon
Date: Mon,  2 Dec 2024 13:35:16 +0100
Message-ID: <20241202123520.27812-1-olaf@aepfle.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="us-ascii"

hv_kvp_daemon uses popen(3) and system(3) as convinience helper to
launch external helpers. These helpers are invoked via a
temporary shell process. There is no need to keep this temporary
process around while the helper runs. Replace this temporary shell
with the actual helper process via 'exec'.

Signed-off-by: Olaf Hering <olaf@aepfle.de>
---
 tools/hv/hv_kvp_daemon.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/hv/hv_kvp_daemon.c b/tools/hv/hv_kvp_daemon.c
index ae57bf69ad4a..91b50cadfc52 100644
--- a/tools/hv/hv_kvp_daemon.c
+++ b/tools/hv/hv_kvp_daemon.c
@@ -725,7 +725,7 @@ static void kvp_get_ipconfig_info(char *if_name,
 	 * .
 	 */
 
-	sprintf(cmd, KVP_SCRIPTS_PATH "%s",  "hv_get_dns_info");
+	sprintf(cmd, "exec %s", KVP_SCRIPTS_PATH "hv_get_dns_info");
 
 	/*
 	 * Execute the command to gather DNS info.
@@ -742,7 +742,7 @@ static void kvp_get_ipconfig_info(char *if_name,
 	 * Enabled: DHCP enabled.
 	 */
 
-	sprintf(cmd, KVP_SCRIPTS_PATH "%s %s", "hv_get_dhcp_info", if_name);
+	sprintf(cmd, "exec %s %s", KVP_SCRIPTS_PATH "hv_get_dhcp_info", if_name);
 
 	file = popen(cmd, "r");
 	if (file == NULL)
@@ -1606,7 +1606,7 @@ static int kvp_set_ip_info(char *if_name, struct hv_kvp_ipaddr_value *new_val)
 	 * invoke the external script to do its magic.
 	 */
 
-	str_len = snprintf(cmd, sizeof(cmd), KVP_SCRIPTS_PATH "%s %s %s",
+	str_len = snprintf(cmd, sizeof(cmd), "exec %s %s %s", KVP_SCRIPTS_PATH
 			   "hv_set_ifconfig", if_filename, nm_filename);
 	/*
 	 * This is a little overcautious, but it's necessary to suppress some

