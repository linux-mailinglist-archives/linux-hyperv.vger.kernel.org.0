Return-Path: <linux-hyperv+bounces-10157-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wLDFCm1f3mn+CQAAu9opvQ
	(envelope-from <linux-hyperv+bounces-10157-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 14 Apr 2026 17:38:21 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C20693FBFDD
	for <lists+linux-hyperv@lfdr.de>; Tue, 14 Apr 2026 17:38:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3CCBF3018621
	for <lists+linux-hyperv@lfdr.de>; Tue, 14 Apr 2026 15:38:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 856863D902A;
	Tue, 14 Apr 2026 15:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sy6+ttcO"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 624702641C6;
	Tue, 14 Apr 2026 15:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776181098; cv=none; b=nhzYqXwQkhgFuRPuNCqZ9kk4RZNNVWEELPvi/ANArY6bBNKrLEf3S2X3k72w1EP+/LZJUM8YUTmI7liEg3QhA9yxo9WKELm4yyXt3tprdZMsLPI4L0imETkgC4Vl8kGEXp6EALetNmAawz2nweqnOwHfjez3CThdEMENFdWU4fA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776181098; c=relaxed/simple;
	bh=9ClUBers0F1nwVFvE4NaICAbcqCkYAjwIb7tRc8M2k0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rGh+c+7h4XLTsjp0bv0qe23cPpiSKtwWWetC7lqm7d4zeC4toI2FInYUjFClIucJ/rEOWOCqNOKJGLOiCDt8CgslkJO2RNbDnLzZyPQ33VoeWoln4iL7inAmeu6XAiDr7JlvkfWXzZ8TKZ5ptpu/mIhgGv9zufGONhiKmRGpVqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sy6+ttcO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAE95C19425;
	Tue, 14 Apr 2026 15:38:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776181098;
	bh=9ClUBers0F1nwVFvE4NaICAbcqCkYAjwIb7tRc8M2k0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Sy6+ttcOLT6Piefv4Vi77kILsS7C2i8vlCLnBr0zrHRhckGrB0RNuhkBWc1eauIQA
	 PEsJKuZ0OlSsKcfFOsO8Xv45skfhOqPMAmRMwVOrZswZUKleDr8vw3uweNdiAB5Zbj
	 Sa/DFeipXNsZqHYRmQfHpgw0DyT1GEf1fX75bVios2zSwqaUMyJQwukDp/wRwHqKmf
	 acS7KY626tq+vQndDPwlcxuPYTO/RfwQGdB8ne0BGjdQul+UXcNAEKj7ZiZqS7jdnr
	 TeIUJXOFr/dZXfgrA4VXDOway5Ovx/FyTDa5IMLXtFwJRtirNj55Vmy4/TpBS0ZkME
	 RpRAwGfQoAXIQ==
From: Simon Horman <horms@kernel.org>
To: ernis@linux.microsoft.com
Cc: 'Simon Horman' <horms@kernel.org>,
	kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	longli@microsoft.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	ssengar@linux.microsoft.com,
	dipayanroy@linux.microsoft.com,
	gargaditya@linux.microsoft.com,
	shirazsaleem@microsoft.com,
	kees@kernel.org,
	kotaranov@microsoft.com,
	leon@kernel.org,
	shacharr@microsoft.com,
	stephen@networkplumber.org,
	linux-hyperv@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2 3/4] net: mana: Don't overwrite port probe error with add_adev result
Date: Tue, 14 Apr 2026 16:35:03 +0100
Message-ID: <20260414153503.769476-1-horms@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260413050843.605789-4-ernis@linux.microsoft.com>
References: <20260413050843.605789-4-ernis@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	TAGGED_FROM(0.00)[bounces-10157-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,sashiko.dev:url]
X-Rspamd-Queue-Id: C20693FBFDD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: 'Simon Horman' <horms@kernel.org>

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://sashiko.dev
---
net: mana: Don't overwrite port probe error with add_adev result

This commit ensures that if mana_probe_port() or mana_attach() fails, the
error is not overwritten by the result of add_adev(). By preserving the
error, it triggers mana_remove() cleanup instead of leaving ports partially
initialized.

> diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
> index 9d095a6fb56c7..4d42cbfb3f15b 100644
> --- a/drivers/net/ethernet/microsoft/mana/mana_en.c
> +++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
> @@ -3634,10 +3634,9 @@ int mana_probe(struct gdma_dev *gd, bool resuming)
>  	if (!resuming) {
>  		for (i = 0; i < ac->num_ports; i++) {
>  			err = mana_probe_port(ac, i, &ac->ports[i]);
> -			/* we log the port for which the probe failed and stop
> -			 * probes for subsequent ports.
> -			 * Note that we keep running ports, for which the probes
> -			 * were successful, unless add_adev fails too
> +			/* Log the port for which the probe failed, stop probing
> +			 * subsequent ports, and skip add_adev.
> +			 * Already-probed ports remain functional.
>  			 */

Are these comments accurate regarding ports remaining functional?

Since this patch preserves the error code, execution falls through to the end
of mana_probe() where it checks if err is set and calls mana_remove().
mana_remove() will iterate over the successfully allocated ports, completely
detach them, unregister their net_devices, and destroy event queues.

It appears no ports remain functional because the device is completely torn
down.

[ ... ]

> @@ -3651,10 +3650,9 @@ int mana_probe(struct gdma_dev *gd, bool resuming)
>  			enable_work(&apc->queue_reset_work);
>  			err = mana_attach(ac->ports[i]);
>  			rtnl_unlock();
> -			/* we log the port for which the attach failed and stop
> -			 * attach for subsequent ports
> -			 * Note that we keep running ports, for which the attach
> -			 * were successful, unless add_adev fails too
> +			/* Log the port for which the attach failed, stop
> +			 * attaching subsequent ports, and skip add_adev.
> +			 * Already-attached ports remain functional.
>  			 */
>  			if (err) {
>  				dev_err(dev, "Attach Failed for port %d\n", i);
> @@ -3663,7 +3661,8 @@ int mana_probe(struct gdma_dev *gd, bool resuming)

Does propagating this error during PM resume introduce a NULL pointer
dereference?

If PM resume fails here (resuming == true), the preserved error code causes
mana_probe() to call mana_remove(), which tears down the device and sets
gd->gdma_context = NULL.

However, a failed resume callback does not automatically unbind the driver.
When the device is eventually unbound later, mana_remove() is invoked again:

drivers/net/ethernet/microsoft/mana/mana_en.c:mana_remove() {
    struct gdma_context *gc = gd->gdma_context;
    struct device *dev = gc->dev;
    ...
}

In the second invocation, gd->gdma_context is NULL, meaning gc is NULL,
which could lead to a kernel panic when dereferencing gc->dev.

