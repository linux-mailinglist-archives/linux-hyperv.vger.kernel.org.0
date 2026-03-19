Return-Path: <linux-hyperv+bounces-9535-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ML9XJy1hu2lujQIAu9opvQ
	(envelope-from <linux-hyperv+bounces-9535-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 19 Mar 2026 03:36:29 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B4B52C509A
	for <lists+linux-hyperv@lfdr.de>; Thu, 19 Mar 2026 03:36:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DA6AF302AD2B
	for <lists+linux-hyperv@lfdr.de>; Thu, 19 Mar 2026 02:36:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7485386558;
	Thu, 19 Mar 2026 02:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bVStI2Um"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 828DF330328;
	Thu, 19 Mar 2026 02:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773887776; cv=none; b=UfgGVh0iTvhX+MUItRJeQzI/oIR5mNskDL9u4QR3xx5ITj9sovXqGZ9q0kphkMQ4VD+OwJ/jjy7qRQKx7OPqkr5G3gSOwna+8vdLrF46fp1ZJgQ9gj42xogbXEhNhbLITWiBHiQOwvc+un/k215Ksl0yronW14jKaqmq5hdV2PA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773887776; c=relaxed/simple;
	bh=bdi1RhJlIvIY3nRJ/Axr7Nfhl+z7qVjPxc3jaJHOOeU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d+F2CWVohaj0/QYDTIH9x7ly6zO4sKlFYezujAtVJall05oCfQT+uLCLKMtOvYXA5quDO6++Vxh8lkZKKmbNQfojnAeSkR1gh0gcpXtp8PAa7xYDv/oghXfnCjOt2u8cuS8AZ247CSaAPOSfDN8Hz731DowTyf4QhW2+iLHRAqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bVStI2Um; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24E86C19421;
	Thu, 19 Mar 2026 02:36:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773887776;
	bh=bdi1RhJlIvIY3nRJ/Axr7Nfhl+z7qVjPxc3jaJHOOeU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bVStI2Umn7+FBYjYFa0IYkGcQb+0Gw3w/1EMEOXi0PCxqPJenVOw29a1jmw6IEoVR
	 09wn0sbDQqKrK5HIicR/enLSIN2KRBQ0DkWIJlIj9xKKaXEULoNhCQv/RIsaNcD018
	 g+gTMEBaI0BMCNsZ0VxsQ3UTZjPHxxUYDdpHdSporrU8G/obcqM3zIiy3kPXoum76b
	 bBL6Jw3+2Vc7FYWg8kcvr4kAU+hFhQhfO+ZC+DmoRh3lNPbHSy+G+XsVgcDXT+9p9i
	 W0j0IWxemVzmRSkmePIzTdbrNQB490ZvX/J4CjbGz8+RtMwXdbYVa6/YOB7G6vZGMI
	 FAdAGEDsr0WEA==
Date: Wed, 18 Mar 2026 19:36:14 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, longli@microsoft.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 kotaranov@microsoft.com, horms@kernel.org,
 shradhagupta@linux.microsoft.com, dipayanroy@linux.microsoft.com,
 yury.norov@gmail.com, kees@kernel.org, ssengar@linux.microsoft.com,
 gargaditya@linux.microsoft.com, shirazsaleem@microsoft.com,
 linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org
Subject: Re: [PATCH net-next v3] net: mana: Expose hardware diagnostic info
 via debugfs
Message-ID: <20260318193614.22328bc8@kernel.org>
In-Reply-To: <20260316112339.1208155-1-ernis@linux.microsoft.com>
References: <20260316112339.1208155-1-ernis@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9535-lists,linux-hyperv=lfdr.de];
	FREEMAIL_CC(0.00)[microsoft.com,kernel.org,lunn.ch,davemloft.net,google.com,redhat.com,linux.microsoft.com,gmail.com,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	NEURAL_HAM(-0.00)[-0.900];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,linux-hyperv@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 2B4B52C509A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, 16 Mar 2026 04:23:27 -0700 Erni Sri Satya Vennela wrote:
> Add debugfs entries to expose hardware configuration and diagnostic
> information that aids in debugging driver initialization and runtime
> operations without adding noise to dmesg.
> 
> The debugfs directory creation and removal for each PCI device is
> integrated into mana_gd_setup() and mana_gd_cleanup_device()
> respectively, so that all callers (probe, remove, suspend, resume,
> shutdown) share a single code path.

Does not apply:

Failed to apply patch:
Applying: net: mana: Expose hardware diagnostic info via debugfs
Using index info to reconstruct a base tree...
M	drivers/net/ethernet/microsoft/mana/gdma_main.c
Falling back to patching base and 3-way merge...
Auto-merging drivers/net/ethernet/microsoft/mana/gdma_main.c
CONFLICT (content): Merge conflict in drivers/net/ethernet/microsoft/mana/gdma_main.c
Recorded preimage for 'drivers/net/ethernet/microsoft/mana/gdma_main.c'
error: Failed to merge in the changes.
hint: Use 'git am --show-current-patch=diff' to see the failed patch
hint: When you have resolved this problem, run "git am --continue".
hint: If you prefer to skip this patch, run "git am --skip" instead.
hint: To restore the original branch and stop patching, run "git am --abort".
hint: Disable this message with "git config set advice.mergeConflict false"
Patch failed at 0001 net: mana: Expose hardware diagnostic info via debugfs
-- 
pw-bot: cr

