Return-Path: <linux-hyperv+bounces-9087-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YNoSNY+YpWnXEgYAu9opvQ
	(envelope-from <linux-hyperv+bounces-9087-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Mon, 02 Mar 2026 15:02:55 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 77C2F1DA4BE
	for <lists+linux-hyperv@lfdr.de>; Mon, 02 Mar 2026 15:02:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A04B4301F3AB
	for <lists+linux-hyperv@lfdr.de>; Mon,  2 Mar 2026 14:02:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CF803FB05E;
	Mon,  2 Mar 2026 14:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T9hY9JNG"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 499D43D4133;
	Mon,  2 Mar 2026 14:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772460139; cv=none; b=i/tzEE2NPYWcG5OJSq1MXTyMifVG3ScWqXe46S5bdn2qROvgFEzwnUWAn6mpOCs1efjJGVPmD6kGvFbgj7h1sABa2coYHXA7/WCqyjA+XwzKoqqeszM8KwSfUsx1vCcwnhe51syzHETez+El/Edi9xtqRC9z+zZ+bd/K16kyZx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772460139; c=relaxed/simple;
	bh=vS7JKHydz7PX7gecBPBnpNdobodFV4i0rWhwWuR0+7I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C8tyQjlF1M4EmdwgB9vs2H2LwpqQA/7PtThazEfD6ugQogy2BbQSdyUP+FXyUVfrBY3ghVlHqd8xF2Tr5QDmbZo01sJpaguSiVA2FzCI5IX4yutZPFVSjtlUJnt6worot0ntAhRQJb60VfnznIb0BUU/r2n6KFVcN4EPLBg/7Uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T9hY9JNG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2966BC19423;
	Mon,  2 Mar 2026 14:02:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772460139;
	bh=vS7JKHydz7PX7gecBPBnpNdobodFV4i0rWhwWuR0+7I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=T9hY9JNGCjpkeiHDRUeo95vcKHBVptO7U/4bPCLFbsrsa+cRjITbyIiD5DaKiq/p2
	 P0xZk6qcxMAd8kebSEFQN8VL48BDN1Q5b3MR+SL9+QvtHYSzuKX9+UlDFrDhvAZfv4
	 flRiymWam0e/Iy0KDg9S7Cc/6TC10BXo8MQaJJon645Zd8PMXZVvkd2axIJnhodC11
	 TNtucIc6RAkaUzRlEdmCFLzZyje3S7IwtL8bRqsqAQwHJzx5oVfc2XiNv4VpfnkXe+
	 BOGybke+gWc22aqvKS9PyZsOAK4ZJX9UVrC5bdUWYlIXVKlgIX/3/Nu1gbWREM0doU
	 i45+wv5xrNrBQ==
Date: Mon, 2 Mar 2026 14:02:11 +0000
From: Simon Horman <horms@kernel.org>
To: Dipayaan Roy <dipayanroy@linux.microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	leon@kernel.org, longli@microsoft.com, kotaranov@microsoft.com,
	shradhagupta@linux.microsoft.com, ssengar@linux.microsoft.com,
	ernis@linux.microsoft.com, shirazsaleem@microsoft.com,
	linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
	dipayanroy@microsoft.com
Subject: Re: [PATCH net-next] net: mana: Force full-page RX buffers for 4K
 page size on specific systems.
Message-ID: <aaWYYxyJN6QqTwME@horms.kernel.org>
References: <aaFusIxdbVkUqIpd@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aaFusIxdbVkUqIpd@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-9087-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,linux-hyperv@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 77C2F1DA4BE
X-Rspamd-Action: no action

On Fri, Feb 27, 2026 at 02:15:12AM -0800, Dipayaan Roy wrote:
> On certain systems configured with 4K PAGE_SIZE, utilizing page_pool
> fragments for RX buffers results in a significant throughput regression.
> Profiling reveals that this regression correlates with high overhead in the
> fragment allocation and reference counting paths on these specific
> platforms, rendering the multi-buffer-per-page strategy counterproductive.
> 
> To mitigate this, bypass the page_pool fragment path and force a single RX
> packet per page allocation when all the following conditions are met:
>   1. The system is configured with a 4K PAGE_SIZE.
>   2. A processor-specific quirk is detected via SMBIOS Type 4 data.
> 
> This approach restores expected line-rate performance by ensuring
> predictable RX refill behavior on affected hardware.
> 
> There is no behavioral change for systems using larger page sizes
> (16K/64K), or platforms where this processor-specific quirk do not
> apply.
> 
> Signed-off-by: Dipayaan Roy <dipayanroy@linux.microsoft.com>

Reviewed-by: Simon Horman <horms@kernel.org>


