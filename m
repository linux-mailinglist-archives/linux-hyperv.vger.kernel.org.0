Return-Path: <linux-hyperv+bounces-8908-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wBk1AK1MlmlUdgIAu9opvQ
	(envelope-from <linux-hyperv+bounces-8908-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 19 Feb 2026 00:35:09 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A69A315AF33
	for <lists+linux-hyperv@lfdr.de>; Thu, 19 Feb 2026 00:35:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 344013006135
	for <lists+linux-hyperv@lfdr.de>; Wed, 18 Feb 2026 23:35:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 513E433B6DA;
	Wed, 18 Feb 2026 23:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LoPCYqn+"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CB2933B6C2;
	Wed, 18 Feb 2026 23:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771457706; cv=none; b=YyRIgVO59ogY7EEER0Tvui1TICegW7xXSCJz6UfdccnpyzvkiQMlJKU+zCuS4iO3A4yz8wVht1waFXGFBLVDYg3dotacifajrvnpBWwwD03XFAaVvqmER96l2+lwh05AeKPdyd7ac2BAXmSqPbuGqY8kaJQ2lYLvkaaB6Rdtm8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771457706; c=relaxed/simple;
	bh=7nOcJw8iXpNyTXv/EY0f+wOoUn/x+uXLeBRt8DqYABw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MsRFstIkWNdPyPu2ZySY4Yh1QdgmQ3N/b9QjFpGS1sh0nrZWJLMfIHpBBcXbeRi+MV1JecFA1rPQGHf57CR9zuV0DkSoDNUc+Li7n1N52zoUbE61PoEBaz/+gMWnWxjUGO5ntAovpDyv4HteuN1Oadnefx4rDuq4ZjoStfigqnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LoPCYqn+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91770C116D0;
	Wed, 18 Feb 2026 23:35:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771457705;
	bh=7nOcJw8iXpNyTXv/EY0f+wOoUn/x+uXLeBRt8DqYABw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LoPCYqn+arQwAH8kW9HZqhFO04q/4rACvjOFSyYbUeyXJ7MNE4jYdbynQ8htTxlXX
	 02J/eT67K6HXYdh7r8WmIKL2eUtUWWC50xR0VXGZEot3sEbc6eg+whqKf6r5b9sn7r
	 iuKVsbrZLLlyn1ynZ4zgr7hB4SuFX7YQe5PziZoJQ9pk9jGIdtXkELBLfa3Y/7IY+4
	 8QfD8m/ttYLcaTeCZ0m2vJBUeQDqKyytxGKf/epr8dt5SBOTYbrDX6C7Cu9B1RiJ6I
	 igWa0PV3avTj9o/fU7/SyRbydhs4c0q/razNxZv7WGp1xX3sa9s+GwUApOY8ntxYMo
	 At4HC5kGhz0JQ==
Date: Wed, 18 Feb 2026 23:35:04 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Magnus Kulke <magnuskulke@linux.microsoft.com>
Cc: wei.liu@kernel.org, haiyangz@microsoft.com, kys@microsoft.com,
	decui@microsoft.com, linux-hyperv@vger.kernel.org,
	skinsburskii@linux.microsoft.com, magnuskulke@microsoft.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mshv: expose hv_call_scrub_partition
Message-ID: <20260218233504.GM2236050@liuwe-devbox-debian-v2.local>
References: <20260218141911.555592-1-magnuskulke@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260218141911.555592-1-magnuskulke@linux.microsoft.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-8908-lists,linux-hyperv=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wei.liu@kernel.org,linux-hyperv@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-hyperv];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: A69A315AF33
X-Rspamd-Action: no action

On Wed, Feb 18, 2026 at 03:19:11PM +0100, Magnus Kulke wrote:
> This hv call needs to be exposed for VMMs to be able to soft-reboot
> guests. It will reset APIC and state of para-virtualized devices like
> SynIC.
> 
> Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>

Applied to hyperv-next. Thanks.

