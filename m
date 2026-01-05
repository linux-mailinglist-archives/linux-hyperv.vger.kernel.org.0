Return-Path: <linux-hyperv+bounces-8151-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E8FC0CF4B17
	for <lists+linux-hyperv@lfdr.de>; Mon, 05 Jan 2026 17:31:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CF1A830E00D4
	for <lists+linux-hyperv@lfdr.de>; Mon,  5 Jan 2026 16:09:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB37433985B;
	Mon,  5 Jan 2026 16:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="NounX+yW"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0BD0334C04;
	Mon,  5 Jan 2026 16:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767629172; cv=none; b=Mx2Ta9PfygZ0ZeXDYRZQrGA5vDy4+Z4qma3hbi+YLYB8egg//QXDFT6MwMSXqo0LMF69NgkxIiarsTgvIwA41Pxv960HpQmu9Jc6O6IFijtiRGLOqEWczXmMn/87Py7LWTjTHb+MItWpgJFo0vXUPyODVr+HO/jrBoKsKLlLc4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767629172; c=relaxed/simple;
	bh=biCZObo3JZebiorOE0GFbVY7bcWtuhS7MZUtl2GgQOA=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=Uk2xYCrvIHGZhTBXYE0DObLzFJ8c9aHCuo9bMJW+SuF7cDh8Ab/Md7fH3H9QFbkN4FBHbtunUKJzkLfsr2qcld0xalnbYJ4J3Sjq/xNmdjZtTbM5JAR5P/0y35FIxvwUgYYkP32pDfRn/zTW5f7rcOk+Y20lEHKziam8oOfrb3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=NounX+yW; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4dlK0Y2jb4z9t1D;
	Mon,  5 Jan 2026 17:06:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1767629165;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=57Etuxh9c+HbHZnmxf+3eXSobbe7EERd8Ue9aW6/tRA=;
	b=NounX+yWKYUx7cpJlYZ1wnWbz43xi9J0bLQzdJmQEkuVm5jiYJYlT606grTZ+J8b69WT+K
	cldal9tGgI6flwYIf9J+aULoL/7cpDPIZcbSBKNH9BazOBNoAVp7TlVABHmaAUHz8ln3sN
	yjirM1dv7xAgxAHMgjPTNfu/fEjpkS6L2OxkeQR+utp8qgfcd5DcbWr5pT9x76wrX+F4/v
	1GoVGbRcqn4YJzNjic8T6r2tvx/xPtWvkxpogn2XS8lJpwUveOhxN+nMvTfzR5tw+cmJSO
	2xe+Kjq6lxvPso2qnn1pdXdHmfbYws0PO3lNe71/ebjQmDcUeZbyRAxS/TIG3g==
Date: Mon, 5 Jan 2026 08:06:02 -0800 (PST)
From: vdso@mailbox.org
To: Anirudh Rayabharam <anirudh@anirudhrb.com>
Cc: "kys@microsoft.com" <kys@microsoft.com>,
	"haiyangz@microsoft.com" <haiyangz@microsoft.com>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>,
	"decui@microsoft.com" <decui@microsoft.com>,
	"longli@microsoft.com" <longli@microsoft.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Message-ID: <993970797.13531.1767629162352@app.mailbox.org>
In-Reply-To: <20260105122837.1083896-2-anirudh@anirudhrb.com>
References: <20260105122837.1083896-1-anirudh@anirudhrb.com>
 <20260105122837.1083896-2-anirudh@anirudhrb.com>
Subject: Re: [PATCH v2 1/2] hyperv: add definitions for arm64 gpa intercepts
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
X-MBO-RS-META: 56kftsm3138nxmm7whdfqyezoazizexu
X-MBO-RS-ID: 2ee15ef7ea92b567a6c


> On 01/05/2026 4:28 AM  Anirudh Rayabharam <anirudh@anirudhrb.com> wrote:
> 

[...]

>  
> +#if IS_ENABLED(CONFIG_ARM64)
> +union hv_arm64_vp_execution_state {
> +	u16 as_uint16;
> +	struct {
> +		u16 cpl:2; /* Exception Level (EL) */

Anirudh,

Appreciate following up on the CPL field in that ARM64 structure
and adding the comment!

Still, using something from the x86 parlance (CPL) and adding a comment
stating that this is actually ARM64 EL certainly needs an explanation
as to _why_ using an x86 term here is beneficial, why not just call
the field "el"? As an analogy, here is a thought experiment of writing

#ffdef CONFIG_ARM64
u64 rax; /* This is X0 */
#endif

where an x86 register name would be used to refer to X0 on ARM64, and
that doen't look natural.

So far, I can't seem to find drawbacks in naming this field "el", only
benefits:
* ARM64 folks will immediately know what this field is, and
* the comment isn't required to explain the situation to the reader.

Do you foresee any drawbacks of calling the field "el" and dropping
the comment? If you do, would these drawbacks outweigh the benefits?

[...]

--
Cheers,
Roman

