Return-Path: <linux-hyperv+bounces-8034-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 35633CC3D75
	for <lists+linux-hyperv@lfdr.de>; Tue, 16 Dec 2025 16:14:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D289830A0E62
	for <lists+linux-hyperv@lfdr.de>; Tue, 16 Dec 2025 15:08:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7706634DB6C;
	Tue, 16 Dec 2025 15:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="I86KNhKD"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9E0E34D931;
	Tue, 16 Dec 2025 15:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765897679; cv=none; b=pxYwCmiH7RM7KBxUSPGhUDWbCKXLy3oj0COvzB5JumH44lJCCr47zKhvGCc8bmKgXBpmvQLCOvSWAdOhpKpgItPfCnI0DuxWSPVSnCAmQ2JLHmThTdKJLMvphJ0M1PufF0hNLydYTt9Kzg9r0uG1IeFiCszciQ5RX6YIn1CoKfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765897679; c=relaxed/simple;
	bh=lR/GL2HFKgTC5bKIoAJOB0rpC5JOkh2gRnhwJ06FYxg=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=M3MQucN5uZfDQ/iE1GkepYjYTgMuQCAfNg6Nwg7PSR03rbXmRbAgYw0s/e8RdOC/oP72mWXOf2XVVgVuTL7NDgb8PkJ7WccXUHgK8ULq/2frIHEgv0aDTxMcdMonLxOL2dF1L0plx/5YxSnsMoP43Xgb63zQQR3fDSXLooSA5IU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=I86KNhKD; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4dW0fX10V3z9tSs;
	Tue, 16 Dec 2025 16:07:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1765897668;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KlVnehtdInMRgsxLRIJHzvhlpQJuadC06fI6W7GUBmM=;
	b=I86KNhKDMx3tnDZKQf08yac6Hn5JxPAX1uqqzOLuNlEyxiZQsbWe0vOpDHbre+weuIAVoT
	gCROwFQzEX/iHC8XCa366IopYieUluTVscKTVkUHabBXpdh4AaCQhG16ZWfyG3ac88QFmq
	WPCN8iZRCPsNr9DBNjNrTV3t1fIPvZ0p8c6CcLWq0SbdeXVXuLpo1pGYL56RlIDCte5uDy
	uKB40EzmQcBWx4m4+k6yPa1FUoaYtpYCrHvhsk91For2gDoi8HWzS49YwHU0OvvWwdWmJK
	Qi5z0fqHPXpChsyrSmkZWHCnSsuD+IBFGVNwtZIt6Y293sEvBY0zshit1Xv1Dw==
Date: Tue, 16 Dec 2025 07:07:45 -0800 (PST)
From: vdso@mailbox.org
To: Anirudh Rayabharam <anirudh@anirudhrb.com>
Cc: kys@microsoft.com, decui@microsoft.com, haiyangz@microsoft.com,
	linux-kernel@vger.kernel.org, longli@microsoft.com,
	wei.liu@kernel.org, linux-hyperv@vger.kernel.org
Message-ID: <1801063954.177813.1765897665357@app.mailbox.org>
In-Reply-To: <20251216142030.4095527-2-anirudh@anirudhrb.com>
References: <20251216142030.4095527-1-anirudh@anirudhrb.com>
 <20251216142030.4095527-2-anirudh@anirudhrb.com>
Subject: Re: [PATCH 1/3] hyperv: add definitions for arm64 gpa intercepts
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-MBO-RS-ID: c0e1280db725aab277c
X-MBO-RS-META: n88njqfk4a8dndoxtwg3q4wyibtomota


> On 12/16/2025 6:20 AM  Anirudh Rayabharam <anirudh@anirudhrb.com> wrote:

[...]

> +#if IS_ENABLED(CONFIG_ARM64)
> +union hv_arm64_vp_execution_state {
> +	u16 as_uint16;
> +	struct {
> +		u16 cpl:2;

That looks oddly x86(-64)-specific (Current Priviledge Level).

Unless I'm mistaken, CPL doesn't belong here, and the bitfield isn't
used on ARM64. Provided the layout of the struct is correct, the
bitfield can have a better name of `reserved0` or something like that.

> +		u16 debug_active:1;
> +		u16 interruption_pending:1;
> +		u16 vtl:4;
> +		u16 virtualization_fault_active:1;
> +		u16 reserved:7;
> +	} __packed;

