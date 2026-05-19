Return-Path: <linux-hyperv+bounces-11023-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iFlpMkNLDGrHdgUAu9opvQ
	(envelope-from <linux-hyperv+bounces-11023-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 19 May 2026 13:36:35 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4568957DC03
	for <lists+linux-hyperv@lfdr.de>; Tue, 19 May 2026 13:36:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6598E308742C
	for <lists+linux-hyperv@lfdr.de>; Tue, 19 May 2026 11:09:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25E5C49219B;
	Tue, 19 May 2026 11:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZfCT1tvj"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 014C7492190;
	Tue, 19 May 2026 11:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779188979; cv=none; b=JEw4qBNOsihOEVhPsYfFpnW5Pt89gDxRK3xehbSUyBf9oNRwdUaG3ZbWjzFnNKjUCrNmGlEVdZAgkyPnVkw39ty/c0XXXOhEhNszfRkN8Aq/OPu8x6ZApoNbQci4VMrtsE8x8iFR3h1yoHrMYr+mW+OCbNQk5gYqz38DgCHdWHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779188979; c=relaxed/simple;
	bh=Z6QrArGYUtSILgnE4xtownugUMTyOsOnkTPAE3UFtwA=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:From:Subject:Cc:
	 References:In-Reply-To; b=mYIAlPRxfmAogGV7hFyKFahOw1E/ti4gW8JW8IPqDNoy05s+02g2iWNNYacoYCJ8pS6vvxPWRGnBELPXhJ9rJNEkNbbyv9nby4EVEwwwprQe+W0K1IAfpZo+1XgNzFr+xg3EMPHiSTOEgxE+zkvhFKIHG415QctqBUswzuhCTu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZfCT1tvj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87442C2BCB3;
	Tue, 19 May 2026 11:09:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779188978;
	bh=Z6QrArGYUtSILgnE4xtownugUMTyOsOnkTPAE3UFtwA=;
	h=Date:To:From:Subject:Cc:References:In-Reply-To:From;
	b=ZfCT1tvj6GDRgCxaMNdA+t2S2lUl95uAfPgB/AxCf/4FdWMaQbycNyioRwE7Sapbz
	 8cfamjCYkazg0HTdxra4l/6S6TmWfyWneLLSBBYpgb+Xh08vuKR+Bz4EaUKxfyPg+h
	 n3YubeHBU8avdWjefVbCyvQnjp5rsN3e86kTi9vrzMqrDGtfLx6TarUlZUVNEsvmlM
	 wV3B43HBiZ7YArGfFc9T3J0QrAU3Bf/8tdpFh4oaIT+yZy4gEwAOtTvHbvn3H21Fhl
	 BZ/NlDcwXhq/V5BHNKkt1yAyRxfx2nCCVbkGzZZNq8qTOMvS34ncXP87dFJENK9aM/
	 yRb4gW9cmiDZg==
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 19 May 2026 13:09:33 +0200
Message-Id: <DIMLUQZZA8RT.1W2KO3RDAQM01@kernel.org>
To: <gregkh@linuxfoundation.org>, <rafael@kernel.org>,
 <linux@armlinux.org.uk>, <nipun.gupta@amd.com>, <nikhil.agarwal@amd.com>,
 <kys@microsoft.com>, <haiyangz@microsoft.com>, <wei.liu@kernel.org>,
 <decui@microsoft.com>, <longli@microsoft.com>, <andersson@kernel.org>,
 <mathieu.poirier@linaro.org>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH v2 0/5] treewide: Convert buses to use generic
 driver_override
Cc: <driver-core@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
 <linux-hyperv@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
 <linux-remoteproc@vger.kernel.org>
References: <20260505133935.3772495-1-dakr@kernel.org>
 <DIG1MUKJVLEO.YGTSSYIO5T1K@kernel.org>
In-Reply-To: <DIG1MUKJVLEO.YGTSSYIO5T1K@kernel.org>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11023-lists,linux-hyperv=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dakr@kernel.org,linux-hyperv@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	RCPT_COUNT_TWELVE(0.00)[17];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 4568957DC03
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon May 11, 2026 at 8:02 PM CEST, Danilo Krummrich wrote:
> On Tue May 5, 2026 at 3:37 PM CEST, Danilo Krummrich wrote:
>> This series is based on v7.1-rc1 with no additional dependencies, hence =
those
>> patches can be picked up by subsystems individually.
>
> Gentle ping on this one; I can alternatively also take those patches thro=
ugh the
> driver-core tree if you prefer.

Since the remaining patches of this series have been out since v7.0-rc5 wit=
hout
any objections, I'm planning to pick it up through the driver-core tree for
v7.2-rc1.

Please let me know if there are any concerns or whether you prefer to take
individual patches through your own tree.

Thanks,
Danilo

