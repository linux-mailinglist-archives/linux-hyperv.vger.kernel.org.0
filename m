Return-Path: <linux-hyperv+bounces-10020-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gIpGDiru02nInwcAu9opvQ
	(envelope-from <linux-hyperv+bounces-10020-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Mon, 06 Apr 2026 19:32:26 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9788D3A5B75
	for <lists+linux-hyperv@lfdr.de>; Mon, 06 Apr 2026 19:32:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 351C73001CE0
	for <lists+linux-hyperv@lfdr.de>; Mon,  6 Apr 2026 17:28:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCC3A39023B;
	Mon,  6 Apr 2026 17:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=anirudhrb.com header.i=anirudh@anirudhrb.com header.b="lcQ5ykCP"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from sender4-of-o54.zoho.com (sender4-of-o54.zoho.com [136.143.188.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F43838E5CE;
	Mon,  6 Apr 2026 17:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775496523; cv=pass; b=o/6fWFNO0V5PMZ17oI/lKAk6p9P91ono/jsxea130ELFijpdfMceHSSSRgKA/hArGUZUDdLBulEhV8o3KDqHgVYVTTf60vrvykHNfKyz4yjOwrINZqkw6rdQsXNMQX1WwywesGFu/M5GNwVa+LHmYyjpxpt3cGTglKzQQBtSaOM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775496523; c=relaxed/simple;
	bh=WJKzfiKCV8Rf4uKYqzP2dUbW95pnJQdcrXN+2WCfDMI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bH1tzZG3S0qkAhiakPAxR1jA/TXhE7UYt2QxDpquTVAHkNVlCFTlkU2+zPY6lZpYyjNS0iJsjLzqaniVulsTVtfSXBiiQahG1puuAbERJXzOC23DKB5u6sXBpsYvl4ElVwE5XbMJxA7VMtxESFyDRJ5zCm8f4ydXNpJcTiNi8N4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=anirudhrb.com; spf=pass smtp.mailfrom=anirudhrb.com; dkim=pass (1024-bit key) header.d=anirudhrb.com header.i=anirudh@anirudhrb.com header.b=lcQ5ykCP; arc=pass smtp.client-ip=136.143.188.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=anirudhrb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=anirudhrb.com
ARC-Seal: i=1; a=rsa-sha256; t=1775496497; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=bF6B6SstX7Vh086pzTJ35BtKEqIsgJhYEF8Zvczbbk5RgbjhH5PLtZ1h6sKQSEwGtvjcvjzHgHGtz+s/DetLtqAdZZ4abtIYVo859dUBw1BvTQT7Tiuo74eLe7ke12DIFa198KOCouLZYNYmDbeyitKXQJ+irJ5CYQqt3S8fJyw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1775496497; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=cGSrgvqzwwH12eMbRTgHFG6hye1j6/+n0f71EMrEpfg=; 
	b=iU+VXhw7O88hAFDKgrAGNRKcTTyWT2bV1wSOSSLXSo2FmdBYS5tSDUxu1qZsNtn3Qij5YpSfx9Y1OdijfnXuKhcAbsXF1vyZ+9rMZZ/Y+Vs4Idz0fd1hjvBmu+HqKEPJ0QKO5ojKuZcWkzbcYF1PDHcqZmD4eNDHMwOz37QP3zc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=anirudhrb.com;
	spf=pass  smtp.mailfrom=anirudh@anirudhrb.com;
	dmarc=pass header.from=<anirudh@anirudhrb.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1775496497;
	s=zoho; d=anirudhrb.com; i=anirudh@anirudhrb.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=cGSrgvqzwwH12eMbRTgHFG6hye1j6/+n0f71EMrEpfg=;
	b=lcQ5ykCPsrFoxCYlvQjO5joWuZWF8Be8WJFN5AVEBJVooggvpvts2agZZD8tbMHg
	W+UNVpiCv/ia/jND8uOqD06nkSuapOrIG8oZlZgdn8cbhlAcKmHgYsBb81wBYd9v5+Y
	TUDgomwZVbLIcx7Gw7mDzCC+dg7DL1e9V/IUiDNo=
Received: by mx.zohomail.com with SMTPS id 1775496495330896.6040337535406;
	Mon, 6 Apr 2026 10:28:15 -0700 (PDT)
Date: Mon, 6 Apr 2026 17:28:07 +0000
From: Anirudh Rayabharam <anirudh@anirudhrb.com>
To: Jork Loeser <jloeser@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org, x86@kernel.org,
	"K . Y . Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>, Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H . Peter Anvin" <hpa@zytor.com>, Arnd Bergmann <arnd@arndb.de>,
	Michael Kelley <mhklinux@outlook.com>, linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org
Subject: Re: [PATCH v2 6/6] mshv: unmap debugfs stats pages on kexec
Message-ID: <20260406-urchin-of-wonderful-support-f0aeee@anirudhrb>
References: <20260403190613.47026-1-jloeser@linux.microsoft.com>
 <20260403190613.47026-7-jloeser@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260403190613.47026-7-jloeser@linux.microsoft.com>
X-ZohoMailClient: External
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[anirudhrb.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[anirudhrb.com:s=zoho];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10020-lists,linux-hyperv=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,microsoft.com,redhat.com,alien8.de,linux.intel.com,zytor.com,arndb.de,outlook.com];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[anirudh@anirudhrb.com,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[anirudhrb.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-hyperv];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 9788D3A5B75
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Apr 03, 2026 at 12:06:12PM -0700, Jork Loeser wrote:
> On L1VH, debugfs stats pages are overlay pages: the kernel allocates
> them and registers the GPAs with the hypervisor via
> HVCALL_MAP_STATS_PAGE2. These overlay mappings persist in the
> hypervisor across kexec. If the kexec'd kernel reuses those physical
> pages, the hypervisor's overlay semantics cause a machine check
> exception.
> 
> Fix this by calling mshv_debugfs_exit() from the reboot notifier,
> which issues HVCALL_UNMAP_STATS_PAGE for each mapped stats page before
> kexec. This releases the overlay bindings so the physical pages can be
> safely reused. Guard mshv_debugfs_exit() against being called when
> init failed.
> 
> Signed-off-by: Jork Loeser <jloeser@linux.microsoft.com>
> ---
>  drivers/hv/mshv_debugfs.c   | 7 ++++++-
>  drivers/hv/mshv_root_main.c | 1 +
>  2 files changed, 7 insertions(+), 1 deletion(-)

Reviewed-by: Anirudh Rayabharam (Microsoft) <anirudh@anirudhrb.com>


