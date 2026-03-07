Return-Path: <linux-hyperv+bounces-9191-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kFVPFhGaq2nYegEAu9opvQ
	(envelope-from <linux-hyperv+bounces-9191-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Sat, 07 Mar 2026 04:22:57 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 43286229D68
	for <lists+linux-hyperv@lfdr.de>; Sat, 07 Mar 2026 04:22:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C8F8F3018E2C
	for <lists+linux-hyperv@lfdr.de>; Sat,  7 Mar 2026 03:22:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A8E13019C3;
	Sat,  7 Mar 2026 03:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XQI/Ew1Q"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 357E22EF67A;
	Sat,  7 Mar 2026 03:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772853751; cv=none; b=sj/DAUSqO2vUYLipDHH//XQAs6tI6V1KbPndIjS30+hLQDdVLfp/vxk7JYq/K3QkO0KrE/WcUZYzFfLdQCYphykofj1wn/ZoakCnPymHZy5eiq7rd+rM2z7Y5P/o6ok1GLePet9k0Hs/uALdJsGJIjnwCvdVJ5vYyw1OF5UVRLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772853751; c=relaxed/simple;
	bh=f7vsilBDwEzuk1bMRooPqG0F25UkXjIOv3nKksiKV4Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HMqYIit037LTDavM844tD7kVIrhYAbz8bV7GhRmRSvwJq3EAKNAouPzY2sMC+xCBJMnhT4X9yUZ3mpRFSoIf6iQH878m2+bCDzHQ2PKbhW9gOsKr1muE4kRFZab87YyLthnCCFC79wACpqZB0JgkqHpFcChPXSUjlvuHknoXhRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XQI/Ew1Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFAA4C19422;
	Sat,  7 Mar 2026 03:22:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772853750;
	bh=f7vsilBDwEzuk1bMRooPqG0F25UkXjIOv3nKksiKV4Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XQI/Ew1QbJ3TWlRy3ljDCaea11ic1tkjQETXwWqVHHsO4ANtHEi5T2qNJckE2AvwW
	 DrmtokVMviwjXCyIP1ycb4mn8PQt6VyNmzuJYv0L5UpND3376yaTH9ZFT7EBfeB76c
	 1ml4CXHPIL67lpuy+0vAA+2SLnckYwyvOsNcQBV7l8vRq1BsX3puluEXoZRELhd15E
	 14lK3FXq8qVse/Hy4s6O878I8zFWenzPQJpKa9yzp9oX+HPCn6uqaeIfQJN2Zkf/Af
	 7T/d9jBOVs5hCOIJ5gxJqSMr3zxa5eZyAkw1r7aU+ytZKrRa0djXcGI5DOW8N5sR7J
	 /FXMhPghoScvQ==
From: Jakub Kicinski <kuba@kernel.org>
To: ernis@linux.microsoft.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	yury.norov@gmail.com,
	kys@microsoft.com,
	decui@microsoft.com,
	kees@kernel.org,
	longli@microsoft.com,
	dipayanroy@linux.microsoft.com,
	davem@davemloft.net,
	netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	kotaranov@microsoft.com,
	andrew+netdev@lunn.ch,
	linux-hyperv@vger.kernel.org,
	edumazet@google.com,
	haiyangz@microsoft.com,
	ssengar@linux.microsoft.com,
	shradhagupta@linux.microsoft.com,
	horms@kernel.org,
	shirazsaleem@microsoft.com,
	wei.liu@kernel.org
Subject: Re: [net-next] net: mana: Expose hardware diagnostic info via debugfs
Date: Fri,  6 Mar 2026 19:22:28 -0800
Message-ID: <20260307032228.1379456-1-kuba@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260305205252.470089-1-ernis@linux.microsoft.com>
References: <20260305205252.470089-1-ernis@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 43286229D68
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,redhat.com,vger.kernel.org,gmail.com,microsoft.com,linux.microsoft.com,davemloft.net,lunn.ch,google.com];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[23];
	TAGGED_FROM(0.00)[bounces-9191-lists,linux-hyperv=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.997];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:url,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Action: no action

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
net: mana: Expose hardware diagnostic info via debugfs

This commit adds debugfs entries to expose hardware configuration and
diagnostic information for the MANA driver. It creates device-level and
port-level debugfs entries to aid in debugging initialization and runtime
operations.

> diff --git a/drivers/net/ethernet/microsoft/mana/gdma_main.c b/drivers/net/ethernet/microsoft/mana/gdma_main.c
> index aef8612b73cb..fb513d7802cb 100644
> --- a/drivers/net/ethernet/microsoft/mana/gdma_main.c
> +++ b/drivers/net/ethernet/microsoft/mana/gdma_main.c
> @@ -152,6 +152,11 @@ static int mana_gd_query_max_resources(struct pci_dev *pdev)
>  	if (gc->max_num_queues > gc->num_msix_usable - 1)
>  		gc->max_num_queues = gc->num_msix_usable - 1;
>
> +	debugfs_create_u32("num_msix_usable", 0400, gc->mana_pci_debugfs,
> +			   &gc->num_msix_usable);
> +	debugfs_create_u32("max_num_queues", 0400, gc->mana_pci_debugfs,
> +			   &gc->max_num_queues);
> +
>  	return 0;
>  }
>
> @@ -1222,6 +1227,13 @@ int mana_gd_verify_vf_version(struct pci_dev *pdev)
>  		return err ? err : -EPROTO;
>  	}
>  	gc->pf_cap_flags1 = resp.pf_cap_flags1;
> +	gc->gdma_protocol_ver = resp.gdma_protocol_ver;
> +
> +	debugfs_create_x64("gdma_protocol_ver", 0400, gc->mana_pci_debugfs,
> +			   &gc->gdma_protocol_ver);
> +	debugfs_create_x64("pf_cap_flags1", 0400, gc->mana_pci_debugfs,
> +			   &gc->pf_cap_flags1);
> +

Do these debugfs entries get recreated on every suspend/resume cycle?

Both mana_gd_query_max_resources() and mana_gd_verify_vf_version() are
called from mana_gd_setup() during device initialization. On suspend,
mana_gd_suspend() calls mana_gd_cleanup() which doesn't remove these
debugfs entries. When mana_gd_resume() calls mana_gd_setup() again, it
attempts to create the same debugfs entries a second time.

This means debugfs_start_creating() in fs/debugfs/inode.c will print an
error for each duplicate file:

    "'num_msix_usable' already exists in 'mana/<slot>/'"
    "'max_num_queues' already exists in 'mana/<slot>/'"
    "'gdma_protocol_ver' already exists in 'mana/<slot>/'"
    "'pf_cap_flags1' already exists in 'mana/<slot>/'"

This produces 4 error messages in dmesg on every suspend/resume cycle,
contradicting the commit message's goal of operating "without adding
noise to dmesg."

Should these device-level entries be removed during suspend (in
mana_gd_cleanup or mana_gd_suspend), or should their creation be moved
to mana_gd_probe where they're only created once?

[ ... ]
-- 
pw-bot: cr

