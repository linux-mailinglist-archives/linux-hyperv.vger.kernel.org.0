Return-Path: <linux-hyperv+bounces-10179-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0KSfMT9N32mFRQAAu9opvQ
	(envelope-from <linux-hyperv+bounces-10179-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 15 Apr 2026 10:33:03 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A8C740203E
	for <lists+linux-hyperv@lfdr.de>; Wed, 15 Apr 2026 10:33:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CF6C73009CCD
	for <lists+linux-hyperv@lfdr.de>; Wed, 15 Apr 2026 08:29:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73D063CF02D;
	Wed, 15 Apr 2026 08:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p7Rvd5oX"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DD023CF03E
	for <linux-hyperv@vger.kernel.org>; Wed, 15 Apr 2026 08:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776241758; cv=pass; b=EhjXZLZ4d5gPezL3/CuxIN315xTeudD64/nAdBa7kYAAb1e2IiR/NKOzoyPc8nhA7Ak28Hq7ZEB1WurTqQ0R52o5wGJT6uhigRjZUJ23laUFaiinUjO6mkFizm+PEPemhR0/nFpW91qUSbYbw/5YeOqSME1djHMP6wYBPCwQWTg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776241758; c=relaxed/simple;
	bh=G1r6MfIjHzyvl5zE8AyhOZgxFrOazIvlHBsvr6V212Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SCdusJRZdcXpRG4qngwBT7pFNv8gJwErWcaaZil7yKLdwZCLvHcGRtSazkgCyN2cFwJJq47o8RoynmAfBnjYhpDAVKtrGgkzavragAkzjqXMNPdFIhwy0qnT4wzTbUCuou5tqhbzZoMuuSCuUsSUqeUANmbsEoMZ/7Mek3H5JUs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=p7Rvd5oX; arc=pass smtp.client-ip=74.125.82.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-2dec803f9f0so109027eec.0
        for <linux-hyperv@vger.kernel.org>; Wed, 15 Apr 2026 01:29:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776241756; cv=none;
        d=google.com; s=arc-20240605;
        b=JLgO81xyt6EZDC0TihNG0TPqQuOune1bo1mp3k03y1pVpnhYZlD6xlNi6Ml7PUPCdj
         ps65trqNYN4F0ktLMvr80fXqb0Tr8EvJE+g/CiDoxG1vHtufRMEMnrptW4YxueobJkhG
         FZzLK93huUA2p3frIzYCyL2n5gy/fLFtDELRWKKJ7SphB/3dSzEaJXWxXQWEb3e3okEA
         3r0RR5mHWblaZE/RHilpgp0TDRRmQdzcJWMIR3TFilSS3CwExuqTqnq+hBIHNXQAyGN+
         zkagrtZb4ipAFQOTYc+NahOwtHbIXEba/i+fB8EDmEA39Z7hFlYmKqX1sGI0t3bEttqm
         DIEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=G1r6MfIjHzyvl5zE8AyhOZgxFrOazIvlHBsvr6V212Q=;
        fh=bRaTtZzCzrKAjClXmRUiuaLBYJg/TCuob+Z/RHPQ/RM=;
        b=EMgXqhpoPga7kkj6tA76sVXR1sI9xTOXY3DvLhaTeAiN3ALfd2tIVcTE6+dvpNYWe3
         9RN8D9bhGZcuimLhYGHOmzMHS1CdxKUt4Vbxnju6qIN28DYJKwuO6XoFU4MlamSp2iUK
         dSJVZmr4hXcmSa7yTv8E0AexQIbyUFQMIQidb6mRmd6T4JjMYI/5kM6lHjlpDBZPXsyC
         E1xExjAJO0H/9lOuTvWxGjnSpO7cNok+bypE2u8fVZ0ZL1oT6M/WqhkCGYHg0EwHQ+iP
         Qyg3A8XXpBoLwqCDXT9WZRqrO30JpzH1SMH6HDONCVHLnV5ugjq9a18HjPfyUf0hV++Q
         Humg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776241756; x=1776846556; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G1r6MfIjHzyvl5zE8AyhOZgxFrOazIvlHBsvr6V212Q=;
        b=p7Rvd5oXx8PKZVZ5Lm932hf7nz9TQqReimR3YazDOCgcIeNn4PDEmQaKF7o/+YVdkZ
         9KgY/utrhk+2L3BDXdmqD4FxY+2ZwpbuFVKvSxERgm1wOaK45oWBCAl7cW04xqGPJGk9
         LcyhV0+iiywFReSeLhXaV74dkx8aIp5ldNuunwl1oKAlCbz2WLjNPygt0UWesOsQRRY5
         SqRlJ4Wf73puQGZ3cOeFu1cZrcD5v4DNUSoAlGeNeXl06KeHTUhnaPdlnJeXKxaqrz+E
         JQFN26Yt8VdcpddyayvoP3qc5rScz/X7l9IktxATE7Fo/yXIAhaRzAf31mDisMVZ0fdj
         US3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776241756; x=1776846556;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=G1r6MfIjHzyvl5zE8AyhOZgxFrOazIvlHBsvr6V212Q=;
        b=pxqGnGVSsXstYnzfnV4/HJE1jIs2Mscoa74lVnC83GzdDKqElPOkGTrHqy+H/zB9f3
         Iar5TBkiGJyV+QJxU7KETGHfNhMeo4xneHkVacddU38UPnosAQW685J3w8ie57jWNL2Q
         maPNQF9cZStg8RijejiFahKMX9l9mJRhhc4okQEz1EDNk6q43O4b4nu59cxULKkD7iTo
         ofzWJ9nbJdjLu2pvHwZPl2/jUxOF3YXyWpfvtVBa5Da19Rcd32u4xQDPXtQNa7qPNVU+
         Q9OpI7ztM22QE3f3jaTDUsKHNK1Z8q7hqUy40ogbf8lBzGJO4IhXkVTSuq022vcYJcNY
         7Tvg==
X-Forwarded-Encrypted: i=1; AFNElJ/3PWKtPRLnnuMJZEc+RqCXyYXNlx3z2fhdfZ6LbERxde0pKNsmqzSVRTM6xD8ce2gnFZJSffylkUsbku8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6NuwisxSx+BT8J90p/D2KL6Cl7z/kOY6eKC0L0Gsfsh9t7Dtn
	whxoV/3bBSuEcVn2Pdz52HArcwbqtNEBzwhc8OmH42v7NClzXv9Ua+RG3Z8LZE0OU5kCGutN4Lm
	0Xj5a9KdfQ2EAerft89T/FO6GTWyYz9s=
X-Gm-Gg: AeBDievHysg4cU9W/BxJcaDoPIcjRAzlzmNNkFdP3HiRIyoKyw49s9stBkhyUp1r7oD
	fU+HvVYQ9lcbmwYDkVFKK0qi/936kqFXf3o3IGt20HFLQKCI5me4WgKSE24lDfQKTB66PkHBBfV
	gZsitD3di4ycz3rPi2R1jKxve2WXrSQLtE9De+6PiY3WBTrGDqY63AHGFLvqFGPXBw0+Vyb0W5x
	fqFKFgmIIxHlQYeeQhaJ3n/rsvJikI4xhOLhYzJkSAKumNaAcmoZPxHmyuwnH5lD/9fkodUGiXA
	hsG+3jA=
X-Received: by 2002:a05:7301:6788:b0:2c0:beb1:8507 with SMTP id
 5a478bee46e88-2d40aadb93bmr11319199eec.0.1776241756211; Wed, 15 Apr 2026
 01:29:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260402202400.1707-1-mhklkml@zohomail.com> <20260402202400.1707-3-mhklkml@zohomail.com>
In-Reply-To: <20260402202400.1707-3-mhklkml@zohomail.com>
From: Tianyu Lan <ltykernel@gmail.com>
Date: Wed, 15 Apr 2026 16:28:59 +0800
X-Gm-Features: AQROBzAehp3OYEKGTuj8lGMBHecZIQc-9d-TdGF0CE5QSTeYeqZRbDb8yiFjsWk
Message-ID: <CAMvTesAsSTU4jHRGq+KGDB4ZC5cBpC9fqEpu5Cb6doYLpCWPpg@mail.gmail.com>
Subject: Re: [PATCH 2/2] Drivers: hv: Move add_interrupt_randomness() to
 hypervisor callback sysvec
To: mhklinux@outlook.com
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org, 
	decui@microsoft.com, longli@microsoft.com, tglx@linutronix.de, 
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com, 
	maz@kernel.org, bigeasy@linutronix.de, x86@kernel.org, 
	linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-10179-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[outlook.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ltykernel@gmail.com,linux-hyperv@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-hyperv];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	FREEMAIL_FROM(0.00)[gmail.com]
X-Rspamd-Queue-Id: 2A8C740203E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Apr 3, 2026 at 4:29=E2=80=AFAM Michael Kelley <mhklkml@zohomail.com=
> wrote:
>
> From: Michael Kelley <mhklinux@outlook.com>
>
> The Hyper-V ISRs, for normal guests and when running in the
> hypervisor root patition, are calling add_interrupt_randomness() as a
> primary source of entropy. The call is currently in the ISRs as a common
> place to handle both x86/x64 and arm64. On x86/x64, hypervisor interrupts
> come through a custom sysvec entry, and do not go through a generic
> interrupt handler. On arm64, hypervisor interrupts come through an
> emulated GICv3. GICv3 uses the generic handler handle_percpu_devid_irq(),
> which does not do add_interrupt_randomness() -- unlike its counterpart
> handle_percpu_irq(). But handle_percpu_devid_irq() is now updated to do
> the add_interrupt_randomness(). So add_interrupt_randomness() is now
> needed only in Hyper-V's x86/x64 custom sysvec path.
>
> Move add_interrupt_randomness() from the Hyper-V ISRs into the Hyper-V
> x86/x64 custom sysvec path, matching the existing STIMER0 sysvec path.
> With this change, add_interrupt_randomness() is no longer called from any
> device drivers, which is appropriate.
>
> Signed-off-by: Michael Kelley <mhklinux@outlook.com>
> ---

Reviewed-by: Tianyu Lan <tiala@microsoft.com>

--=20
Thanks
Tianyu Lan

