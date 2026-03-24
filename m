Return-Path: <linux-hyperv+bounces-9736-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YIUkI/GnwmkyggQAu9opvQ
	(envelope-from <linux-hyperv+bounces-9736-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 24 Mar 2026 16:04:17 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E8A5317A4B
	for <lists+linux-hyperv@lfdr.de>; Tue, 24 Mar 2026 16:04:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 449C930604FB
	for <lists+linux-hyperv@lfdr.de>; Tue, 24 Mar 2026 15:03:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59EFC402BA7;
	Tue, 24 Mar 2026 15:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g9ko0FWQ"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3630A402B8B;
	Tue, 24 Mar 2026 15:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774364621; cv=none; b=QwC6h9WQ/a0rYK7IHYw/GgURtWqzIhxQt14xXgDXjGQExf4tLsl+HzEcuhEnlhtC3GWiacUhyh00hsMLhNN6zFAIU7r0M8wnIw/OL7qTGr0bHm6x/lAvQlSS9uHSm1EhgZWfLTJUICJQK2DBBzXSrC0U+bJtgJWH1MyNvqvkOL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774364621; c=relaxed/simple;
	bh=bSVMovbLuqaeoj7Ubp0zwn6i9A99iQBP0uuV/uQEZwM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e1NLTBZpvN2FHWzQjFKX4pJgWkSaumYKPqMIQaHG1iigvDMhshG8sTxaNWHwcahDJZ3hHgG5rY50IVNcqZQuuiGb0qKWTr100PcpXgEp8dRIorcPZWT2sSRrRbBvNvfiy4vBOgxuyaUeQQ+6UQZTVqLjH5RxgqcI3+YL0kZzw+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g9ko0FWQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E806C19424;
	Tue, 24 Mar 2026 15:03:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774364620;
	bh=bSVMovbLuqaeoj7Ubp0zwn6i9A99iQBP0uuV/uQEZwM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=g9ko0FWQ/ckfWTdGSV7BTtIzcTfjCXmHyo0Pe+fOud2vlEM5uvi0rkOda06uVu1qi
	 NFt5nhGQRgjb8LSo19nSx8EKCO8XPqIoHbyODKZLMdL5LBxsckX8cGRiKwcBVASTFw
	 RjzGV0irm7GKKZYNPvwCqhBBGEBWMNZ45aD20hg+wrvO7GTI+TCZZBsv83rY7rxh3R
	 nTnM/ayIcZrykrw4mpiho7NvC2RZqukHE+lJf+G3S7Nfspks2uBartwyH8tMMaanMa
	 kiGbpN+7Bn95FDkX714u84OR41IgDQEULxDal6Hv3WnaMU4BWoBICP1K5nbA17S8HV
	 6lQbg0LARa6tg==
Date: Tue, 24 Mar 2026 15:03:39 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Cc: Wei Liu <wei.liu@kernel.org>, x86@kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Rob Herring <robh@kernel.org>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Dexuan Cui <decui@microsoft.com>,
	Michael Kelley <mhklinux@outlook.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Saurabh Sengar <ssengar@linux.microsoft.com>,
	Chris Oo <cho@microsoft.com>, "Kirill A. Shutemov" <kas@kernel.org>,
	linux-hyperv@vger.kernel.org, devicetree@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	Ricardo Neri <ricardo.neri@intel.com>,
	Yunhong Jiang <yunhong.jiang@linux.intel.com>
Subject: Re: [PATCH v8 09/10] x86/hyperv/vtl: Mark the wakeup mailbox page as
 private
Message-ID: <20260324150339.GA1701749@liuwe-devbox-debian-v2.local>
References: <20260107-rneri-wakeup-mailbox-v8-0-2f5b6785f2f5@linux.intel.com>
 <20260107-rneri-wakeup-mailbox-v8-9-2f5b6785f2f5@linux.intel.com>
 <20260309175733.GA3083831@liuwe-devbox-debian-v2.local>
 <20260320230147.GA31320@ranerica-svr.sc.intel.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260320230147.GA31320@ranerica-svr.sc.intel.com>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9736-lists,linux-hyperv=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,microsoft.com,outlook.com,linux.microsoft.com,vger.kernel.org,intel.com,linux.intel.com];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wei.liu@kernel.org,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-hyperv,dt];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2E8A5317A4B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Mar 20, 2026 at 04:01:47PM -0700, Ricardo Neri wrote:
> On Mon, Mar 09, 2026 at 05:57:33PM +0000, Wei Liu wrote:
> > Dexuan, are you happy with the patch? You can also delegate to Saurabh
> > if you think it's more appropriate. Thanks!
> 
> Hi Wei,
> 
> I just realized you replied to an older version of the patch. Here is the
> most recent version:
> 
> https://lore.kernel.org/all/20260304-rneri-wakeup-mailbox-v9-9-a5c6845e6251@linux.intel.com/
> 
> The whole series:
> 
> https://lore.kernel.org/all/20260304-rneri-wakeup-mailbox-v9-0-a5c6845e6251@linux.intel.com/
> 

No worries. I saw the new series after that reply.

Wei

> Thanks and BR,
> Ricardo
> 
> 

