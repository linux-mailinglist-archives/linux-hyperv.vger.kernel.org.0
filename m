Return-Path: <linux-hyperv+bounces-8698-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +IG4E4nlgmnNeQMAu9opvQ
	(envelope-from <linux-hyperv+bounces-8698-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 04 Feb 2026 07:22:01 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C0C10E247B
	for <lists+linux-hyperv@lfdr.de>; Wed, 04 Feb 2026 07:22:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 05EEE30406A6
	for <lists+linux-hyperv@lfdr.de>; Wed,  4 Feb 2026 06:21:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BB4037E2F0;
	Wed,  4 Feb 2026 06:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UnRclk1m"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 080CA37E2E6;
	Wed,  4 Feb 2026 06:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770186118; cv=none; b=YjyJ0tXuj9Ir/b+pMoDDgdskX/DslmO4/rzG4zOP46BZ5ukFx+el8HPeptO+uNAKyT1Tdk+2ilqRHV7JlGozaTWC1dWWAl7hFTRZycBRzsYyZYb1Nm2xPp2utWEd/mOFGyixoT9MoiBpr9jiWQcMugM/ZcOn9/uUgVqRiBFnARo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770186118; c=relaxed/simple;
	bh=bN7cTfgHxxw72Fq02SjdM8FAa9yt9kC9sbsueOnbwtw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P0oAtfJfajkHA8DrB4gKtQnHKAHbNNHsSMS/1QjN3Fy6UFiFBkC3FzLZ33UblUHG3GVdml9l/jBmF/IsDG1rgiDZZ3xVJ7hZtKDYOE4rql9rzN/gmgkwUtgGMLK05r3GMvds0PJyyl8hJrijcz9KTz/vdYeVgJLbEJlnEv5HLD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UnRclk1m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75B40C4CEF7;
	Wed,  4 Feb 2026 06:21:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770186117;
	bh=bN7cTfgHxxw72Fq02SjdM8FAa9yt9kC9sbsueOnbwtw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UnRclk1mYcEzmIsbycWUDHU6RIiBVVLORrSkYIAojBTgrZQQZcScTOvv4B+UNn7xC
	 UgVZhAl6ZzQ4teCzVZAAyWvAnNNfRmHvtorwusK0nmTx2ng4DeFr1YnhghQzvKID7P
	 LlRUxS5nOmH37J2pNV6FR83MzKktvJS9rY7eTP3ysl1fTbeR8sDqo1mKo/gm8UpVH+
	 NeMcgC3/r2rhr5w/iux0s+J99ibOAxMcXsYfAX95YOsGoBie1CQfGAGW6Up3aDQntO
	 A7LddHD/Pa+YBrBeNKJs+JmvxMlk1GsW3qoz7mCj+Q2z/Ero/oDahJ//DZzUYvRr4B
	 NUy3c+Kmshx7A==
Date: Wed, 4 Feb 2026 06:21:56 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Cc: linux-hyperv@vger.kernel.org, linux-pci@vger.kernel.org,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH] pci: pci-hyperv-intf: remove unnecessary
 module_init/exit functions
Message-ID: <20260204062156.GG79272@liuwe-devbox-debian-v2.local>
References: <20260131020017.45712-1-enelsonmoore@gmail.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260131020017.45712-1-enelsonmoore@gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8698-lists,linux-hyperv=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wei.liu@kernel.org,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-hyperv];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,liuwe-devbox-debian-v2.local:mid]
X-Rspamd-Queue-Id: C0C10E247B
X-Rspamd-Action: no action

On Fri, Jan 30, 2026 at 06:00:17PM -0800, Ethan Nelson-Moore wrote:
> The pci-hyperv-intf driver has unnecessary empty module_init and
> module_exit functions. Remove them. Note that if a module_init function
> exists, a module_exit function must also exist; otherwise, the module
> cannot be unloaded.
> 
> Signed-off-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>

Applied to hyperv-next. I modified the subject line to match our
conventions. Thanks.

Wei

