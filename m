Return-Path: <linux-hyperv+bounces-3324-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 93CAB9C5B66
	for <lists+linux-hyperv@lfdr.de>; Tue, 12 Nov 2024 16:07:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A8331F26080
	for <lists+linux-hyperv@lfdr.de>; Tue, 12 Nov 2024 15:07:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA83C1FCF40;
	Tue, 12 Nov 2024 15:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aEuqZMdG"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2508C1FF043
	for <linux-hyperv@vger.kernel.org>; Tue, 12 Nov 2024 15:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731423852; cv=none; b=GhKDQljyjUY5AbdyazOddqdIQQNTCgpGvxT9Ea3bgFZL5/D2APVIakgk7YKNiK1lIc5q7hpuiI5NczP83vpvnRK5YAgLTKUrXm0v44CnFOSTyIxYrts32M74cqVgektKm40g+zAX5niggj8fOxHJji53YM/LV3hsNGH2v9TgPVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731423852; c=relaxed/simple;
	bh=6h5pADxNne9d8m//9uJHWM1499lvxVfSbKp4qax5VKM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=afWBnl37UNXP5/c5cyeSCGiOQR20fyEoj7FeDRjkvcHSavYwNoJRppQSuivBHOIKBwPEqoMegMTlHVJm+qnZLvBAuDuX9ZGb9JfCsaUazu9r28s6l3kMGOVj1CTSB8waYEvSobpXV9eGX9WOv/EpF4C9BVdqZdWmhxZd6sR4OlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aEuqZMdG; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731423849;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=j0W+PnPsRwyZd3T+tjupo+6i4tCF4pLBt+SKLFRqZtg=;
	b=aEuqZMdGqXTmM0XO2YiaJFablolvqtBvAAN67RcDKFYmwjn4dv9ylhbO+xzh50iJwqUKmP
	Kr1VG2JoAa+vj9LnIzGvPZnUHGahhINxHAt7OiBHAoAupLzufV679hA2cUQ59Hlv6Z778P
	WlwwdkKIxIJMUzzIjCVDHylEAsZUaNw=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-306-2Qg6Dtf2NSSXIBkdg5BxEQ-1; Tue,
 12 Nov 2024 10:04:06 -0500
X-MC-Unique: 2Qg6Dtf2NSSXIBkdg5BxEQ-1
X-Mimecast-MFC-AGG-ID: 2Qg6Dtf2NSSXIBkdg5BxEQ
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0A8EE1955F09;
	Tue, 12 Nov 2024 15:04:05 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.225.225])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7BCDF1955F40;
	Tue, 12 Nov 2024 15:04:02 +0000 (UTC)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: linux-hyperv@vger.kernel.org
Cc: mhklinux@outlook.com,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] hv/hv_kvp_daemon: Pass NIC name to hv_get_dns_info as well
Date: Tue, 12 Nov 2024 16:04:01 +0100
Message-ID: <20241112150401.217094-1-vkuznets@redhat.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

The reference implementation of hv_get_dns_info which is in the tree uses
/etc/resolv.conf to get DNS servers and this does not require to know which
NIC is queried. Distro specific implementations, however, may want to
provide per-NIC, fine grained information. E.g. NetworkManager keeps track
of DNS servers per connection.

Similar to hv_get_dhcp_info, pass NIC name as a parameter to
hv_get_dns_info script.

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 tools/hv/hv_kvp_daemon.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/hv/hv_kvp_daemon.c b/tools/hv/hv_kvp_daemon.c
index ae57bf69ad4a..296a7a62c54d 100644
--- a/tools/hv/hv_kvp_daemon.c
+++ b/tools/hv/hv_kvp_daemon.c
@@ -725,7 +725,7 @@ static void kvp_get_ipconfig_info(char *if_name,
 	 * .
 	 */
 
-	sprintf(cmd, KVP_SCRIPTS_PATH "%s",  "hv_get_dns_info");
+	sprintf(cmd, KVP_SCRIPTS_PATH "%s %s", "hv_get_dns_info", if_name);
 
 	/*
 	 * Execute the command to gather DNS info.
-- 
2.47.0


