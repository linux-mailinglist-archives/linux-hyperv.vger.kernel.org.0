Return-Path: <linux-hyperv+bounces-10105-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MP1NINVT2GmqbwgAu9opvQ
	(envelope-from <linux-hyperv+bounces-10105-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 10 Apr 2026 03:35:17 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EF29E3D120E
	for <lists+linux-hyperv@lfdr.de>; Fri, 10 Apr 2026 03:35:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 71A783018405
	for <lists+linux-hyperv@lfdr.de>; Fri, 10 Apr 2026 01:35:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F2FB31B130;
	Fri, 10 Apr 2026 01:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OZ2ksg1b"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B3ED28003A;
	Fri, 10 Apr 2026 01:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775784912; cv=none; b=MEEklbIOTCL7gs2ubc8BpRzLKNoUfZ0dz4IWdaSyOUHt98WNr906MAlS2EfNUCkWcXahyv1feGVuIF3dE/nEwbX6tFAOC9rT1skfgoMwgoTikffm03R9rzsk52V+nL338izCVrDBhbd2UmrlH1Y+x4/b8S1MOQoURGhGFez+smI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775784912; c=relaxed/simple;
	bh=XJOTva4mMOagP8Rzl2OcqxIKEtJKfglxHGAZ1JQFuas=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nY3sIhNBSJ8z7KWe9Za67EC0lTxP9ASvrDvRCHQYo0QRDCJ7liZxA/kX2ApCrIHt6BED3swIAw54g2wdkOrBMfY0vzVUcn4qDMhDkphVLUxtRHpVaYM79sKBP3m6R9b5wQXQE9l5fqM4Sn0+ea3TMJ25TW+zq2sBB6q3GaS1+2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OZ2ksg1b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 998E1C4CEF7;
	Fri, 10 Apr 2026 01:35:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775784912;
	bh=XJOTva4mMOagP8Rzl2OcqxIKEtJKfglxHGAZ1JQFuas=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=OZ2ksg1b2Zyer7P05w8qvm0ZGKDRQ14IlXYAxvwA8lPtfQVCYVbTRlNY8Kab9gql1
	 hyzNNhFl1lYWj7E428NWb1sfQTzKrMQwRJo5LyKWBMfBm/wIaRi5GD6pWYoSVYYlt9
	 9QhGQ1okWNju/6hgGg6KOWOnsefSPoz3BRPQPxxJ6ezvYPaYXHfCGkhEfMeP0owLO0
	 BmLsJ4+T8O8C5sZc7GF7Sc0+RITaHVjDQTWACsjupZtjA8DKCEw/BybijwMmmxwon0
	 esIL3orMYB8sorl2PgmtaUBXjXonsm0bP2eYncC1RLnS9fUxnDEvb3aoMpqksVUtrP
	 Q7sz9zWKzVqbQ==
Date: Thu, 9 Apr 2026 18:35:09 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Dipayaan Roy <dipayanroy@linux.microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, leon@kernel.org,
 longli@microsoft.com, kotaranov@microsoft.com, horms@kernel.org,
 shradhagupta@linux.microsoft.com, ssengar@linux.microsoft.com,
 ernis@linux.microsoft.com, shirazsaleem@microsoft.com,
 linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
 stephen@networkplumber.org, jacob.e.keller@intel.com, leitao@debian.org,
 kees@kernel.org, john.fastabend@gmail.com, hawk@kernel.org,
 bpf@vger.kernel.org, daniel@iogearbox.net, ast@kernel.org, sdf@fomichev.me,
 dipayanroy@microsoft.com
Subject: Re: [PATCH net-next v6 0/2] net: mana: add ethtool private flag for
 full-page RX buffers
Message-ID: <20260409183509.0b24dea6@kernel.org>
In-Reply-To: <20260407200216.272659-1-dipayanroy@linux.microsoft.com>
References: <20260407200216.272659-1-dipayanroy@linux.microsoft.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10105-lists,linux-hyperv=lfdr.de];
	FREEMAIL_CC(0.00)[microsoft.com,kernel.org,lunn.ch,davemloft.net,google.com,redhat.com,linux.microsoft.com,vger.kernel.org,networkplumber.org,intel.com,debian.org,gmail.com,iogearbox.net,fomichev.me];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[32];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,linux-hyperv@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: EF29E3D120E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue,  7 Apr 2026 12:59:17 -0700 Dipayaan Roy wrote:
> This behavior is observed on a single platform; other platforms
> perform better with page_pool fragments, indicating this is not a
> page_pool issue but platform-specific.

Well, someone has to run some experiments and confirm other ARM
platforms are not impacted, with data. I was hoping to do it myself
but doesn't look like that will happen in time for the merge window :(

> Changes in v6:
>  - Added missed maintainers.

STOP REPOSTING PATCHES FOR NO REASON.

