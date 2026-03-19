Return-Path: <linux-hyperv+bounces-9539-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0HQ8Ljacu2l0lwIAu9opvQ
	(envelope-from <linux-hyperv+bounces-9539-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 19 Mar 2026 07:48:22 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F72B2C6E85
	for <lists+linux-hyperv@lfdr.de>; Thu, 19 Mar 2026 07:48:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2CB3030571A0
	for <lists+linux-hyperv@lfdr.de>; Thu, 19 Mar 2026 06:48:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F0633624BE;
	Thu, 19 Mar 2026 06:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="DlVTgvVN"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B0A134DCC7;
	Thu, 19 Mar 2026 06:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773902897; cv=none; b=U6Bw1yjI8FwOq/yk6mYVFfwdpr59AyzVYbTfCBHkJ6X/i14Cg2og/0eQ4qG5Jk4QrKBwiLLgk6qMY98wM07IQMyluKZEhlDi272gkzqCgP3aeuCyG8NC4x3YjDMX3+/5L5d28bqf+27CXd5N9vBl7/7a/ViuPyNTA/ccODST2Yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773902897; c=relaxed/simple;
	bh=3mi0QgCuIyoh2bGO3XVTSk7dv/SXV9xHfa6tnZgO0ao=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LpQHlm3AQO5HCyxmmxdvfYnRT0ynlKqBVVFiFR+RHHqNy6UMidv7DJjBk0omwKXlm8c+NVRVFmZZqKfxO8D2mYTKY/2t3cNMp5kZTCSfRvepWcwxe8Z2vbS2eUjSB6G5At04N5qeo6a9x7qeE8AlrzA2YmScWPgqffH9vuzCcyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=DlVTgvVN; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1173)
	id 112A420B7128; Wed, 18 Mar 2026 23:48:16 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 112A420B7128
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1773902896;
	bh=F/GVftoRgWqb0x/2sm+OJx0BNn4GSq3sMf5lvz5QRP8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DlVTgvVNpgN3+X1WNT8KhxNkTnsap5iYikj//GSr3EKQT/ZCxFc1oTqA7TnYpmLSu
	 y9fA772V/C432go0k/CQ5u7EAv5qmIcJJiOfX1rEmulckXKF3NkvO5YRH5yFZ4F4kP
	 UEH1D30BNXRoWEkEoDgrf2K43O2OdQbL2XX5qcw4=
Date: Wed, 18 Mar 2026 23:48:16 -0700
From: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
To: Jakub Kicinski <kuba@kernel.org>
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
Message-ID: <abucMBD6sn7s4bw8@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20260316112339.1208155-1-ernis@linux.microsoft.com>
 <20260318193614.22328bc8@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260318193614.22328bc8@kernel.org>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9539-lists,linux-hyperv=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	FREEMAIL_CC(0.00)[microsoft.com,kernel.org,lunn.ch,davemloft.net,google.com,redhat.com,linux.microsoft.com,gmail.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ernis@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	NEURAL_HAM(-0.00)[-0.704];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net:mid]
X-Rspamd-Queue-Id: 1F72B2C6E85
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Mar 18, 2026 at 07:36:14PM -0700, Jakub Kicinski wrote:
> On Mon, 16 Mar 2026 04:23:27 -0700 Erni Sri Satya Vennela wrote:
> > Add debugfs entries to expose hardware configuration and diagnostic
> > information that aids in debugging driver initialization and runtime
> > operations without adding noise to dmesg.
> > 
> > The debugfs directory creation and removal for each PCI device is
> > integrated into mana_gd_setup() and mana_gd_cleanup_device()
> > respectively, so that all callers (probe, remove, suspend, resume,
> > shutdown) share a single code path.
> 
> Does not apply:
> 
> Failed to apply patch:
> Applying: net: mana: Expose hardware diagnostic info via debugfs
> Using index info to reconstruct a base tree...
> M	drivers/net/ethernet/microsoft/mana/gdma_main.c
> Falling back to patching base and 3-way merge...
> Auto-merging drivers/net/ethernet/microsoft/mana/gdma_main.c
> CONFLICT (content): Merge conflict in drivers/net/ethernet/microsoft/mana/gdma_main.c
> Recorded preimage for 'drivers/net/ethernet/microsoft/mana/gdma_main.c'
> error: Failed to merge in the changes.
> hint: Use 'git am --show-current-patch=diff' to see the failed patch
> hint: When you have resolved this problem, run "git am --continue".
> hint: If you prefer to skip this patch, run "git am --skip" instead.
> hint: To restore the original branch and stop patching, run "git am --abort".
> hint: Disable this message with "git config set advice.mergeConflict false"
> Patch failed at 0001 net: mana: Expose hardware diagnostic info via debugfs
> -- 
> pw-bot: cr

I will rebase and send the next version.
Thankyou.

