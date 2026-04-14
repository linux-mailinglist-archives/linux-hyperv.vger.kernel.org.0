Return-Path: <linux-hyperv+bounces-10148-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KBgOOQDG3WlYjAkAu9opvQ
	(envelope-from <linux-hyperv+bounces-10148-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 14 Apr 2026 06:43:44 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 607F83F583E
	for <lists+linux-hyperv@lfdr.de>; Tue, 14 Apr 2026 06:43:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C4475301D313
	for <lists+linux-hyperv@lfdr.de>; Tue, 14 Apr 2026 04:43:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F07E927E049;
	Tue, 14 Apr 2026 04:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gCz4wOuN"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD89D23EA94;
	Tue, 14 Apr 2026 04:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776141819; cv=none; b=jdt7ISAmXiIcieIdztAHfqdnM49Edo1vUgo8HtehyTClF53VNt1FSjLfrDURw7N1fBcB3lVMcxkZzzWGyr3ZzdSToSEyuWtoPJbGLrvLpKU3/ULBF3jFRcl/2rEAWUaluE8aCuVuwXpkHe88y4q5EnoDyfG8fgt9mtMohoEw74Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776141819; c=relaxed/simple;
	bh=+J0wT33uWs58615RiPJliU5RApbkJLZCNH0GJDizfKI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PCVF1J4+c7tMsjd1I1o/s/xbyizlZ+Kv1Qz5k5RVPWavLzMEWQ/t0Zv6bIEx30V2Gzwdi2K/tQr/dHM1CP6p2slti7N4unwu9VivWTQ+L8dZAt0msvDG0juJpCtE7FeoQkiJ+8NbbC9xinxcVNsniNkrd65OBI3lC2dI/ED3fuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gCz4wOuN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2856EC19425;
	Tue, 14 Apr 2026 04:43:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776141819;
	bh=+J0wT33uWs58615RiPJliU5RApbkJLZCNH0GJDizfKI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gCz4wOuNujQotcRKIhE7LD3tsDQhG4lpMcQfip3aqFRFkHu3ubAEObNt+RL+5wZGt
	 9y0z228xonbvYgr2HK9gquAhfDqixCWX9sCyXBykFcKFKAyvLUh0+TVL34OEaMLWQB
	 ZXbKQzatTPG+le7kTy9cuMZTlKzYkzZgrjx+FoAsE1i6Z4uirpNYNnT28BAdMD/w0n
	 pF/wchTybidtueV8dxQdECn4nBZy9+Uvo9ZOP7u7jlNY5RNKWHBLs0Tx1/CU6+94qY
	 IMxG4MYPbHoi2eAbX+Ug1kUnHavJM7wOxe16dcoxu1L/k8tO7Vk22IYMAc3gQ49n8T
	 sxoEOlCnUhwng==
Date: Tue, 14 Apr 2026 04:43:37 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Aditya Garg <gargaditya@linux.microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, longli@microsoft.com,
	gregkh@linuxfoundation.org, ssengar@linux.microsoft.com,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
	avladu@cloudbasesolutions.com, vdso@mailbox.org,
	gargaditya@microsoft.com, Roman Kisel <romank@linux.microsoft.com>
Subject: Re: [PATCH v3] tools: hv: Fix cross-compilation
Message-ID: <20260414044337.GB2787213@liuwe-devbox-debian-v2.local>
References: <20260409103218.367589-1-gargaditya@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260409103218.367589-1-gargaditya@linux.microsoft.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10148-lists,linux-hyperv=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wei.liu@kernel.org,linux-hyperv@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,liuwe-devbox-debian-v2.local:mid,cloudbasesolutions.com:email]
X-Rspamd-Queue-Id: 607F83F583E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Apr 09, 2026 at 03:32:18AM -0700, Aditya Garg wrote:
> Use the native ARCH only in case it is not set, this will allow the
> cross-compilation where ARCH is explicitly set.
> 
> Additionally, simplify the ARCH check to build the fcopy daemon only
> for x86 and x86_64.
> 
> Fixes: 82b0945ce2c2 ("tools: hv: Add new fcopy application based on uio driver")
> Reported-by: Adrian Vladu <avladu@cloudbasesolutions.com>
> Closes: https://lore.kernel.org/linux-hyperv/PR3PR09MB54119DB2FD76977C62D8DD6AB04D2@PR3PR09MB5411.eurprd09.prod.outlook.com/
> Co-developed-by: Saurabh Sengar <ssengar@linux.microsoft.com>
> Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
> Signed-off-by: Aditya Garg <gargaditya@linux.microsoft.com>
> Reviewed-by: Roman Kisel <romank@linux.microsoft.com>

Applied. Thanks.

