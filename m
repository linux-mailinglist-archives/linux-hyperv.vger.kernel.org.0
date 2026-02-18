Return-Path: <linux-hyperv+bounces-8901-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8JyiJewOlmmNZQIAu9opvQ
	(envelope-from <linux-hyperv+bounces-8901-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 18 Feb 2026 20:11:40 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 115E8158F37
	for <lists+linux-hyperv@lfdr.de>; Wed, 18 Feb 2026 20:11:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0B9983010271
	for <lists+linux-hyperv@lfdr.de>; Wed, 18 Feb 2026 19:11:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33CE830C62D;
	Wed, 18 Feb 2026 19:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FIp3NMyC"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F420A2BE7DB
	for <linux-hyperv@vger.kernel.org>; Wed, 18 Feb 2026 19:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771441898; cv=none; b=P5M7ns/QwVmUW4H6FhZiaLH0F3EmyaRUJHzAMjF9csmyX+N48uk0xqWA+dUAi/7wDdY9gduurKAvxs24alH/D4+5NeZ6oEoZQNtJ4l1Y0Nr5lgqiuecxb3X1Lk61be7gQAX7Aa8SSoicU8H2FjQk6w0FLtDrMp42byTwnB8AB+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771441898; c=relaxed/simple;
	bh=2KSVdTaQYNRW24MEnIANixFMLK7gCdff6CGaesbsCeM=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=RrW9w0Eq6ktlLIsH2FCdUCkoGlNzyqedVjuxsGI/VKRXYWd6rYYbL60BrbScmjZgECaIvvjq2HuYmKWAUc3dAWT0gMhuEQ8Zr714zckpH9lETPII2QIxX/toXCm24Gr1UmhsbCON5sBFxlPuRmqsfhehEFDHSEH0huz8JhV3XGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FIp3NMyC; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-7d196a2334fso166738a34.1
        for <linux-hyperv@vger.kernel.org>; Wed, 18 Feb 2026 11:11:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771441896; x=1772046696; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2KSVdTaQYNRW24MEnIANixFMLK7gCdff6CGaesbsCeM=;
        b=FIp3NMyCqI97dDDXUoeQt634wKlWuhiPMQEjQMhrnabFiRCtC/XNMeb/llho0s/F6E
         GiOoH4qUM0Men39k/gL+F5mvZiDzNJ9YP4YAmpF6YNjQ7PnoISX1ksoXFhc8Xyndzc/K
         3qVGQR7MzSHWgpjNqcHZQXlu0nQheIQgtXUdcvnQfT0XCk5ddBO++aU1fHoppTBfAafm
         TUnJ0ZHaQ6VNDkoD7cjVWyfq8n7Bd/3H/sR2DrkVIfa7EO6TUF31HlczgGIM8IyJ3dxm
         rIQfDjrbSFpY/DPkfvDlaUrRcbTV5DdzollexqRuuPJ7xWXAFyb6H/U9a9oWRZkpAGX1
         s8Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771441896; x=1772046696;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2KSVdTaQYNRW24MEnIANixFMLK7gCdff6CGaesbsCeM=;
        b=jX4qOJFjJzMraptG+hFxidPjVkLQrlQ8/qQL+pAWrPRh+lT0QRye6HZ1D5ig/8/b1A
         Vljl3wYxgW2Wb1DqI1M+9DuqtAzHS4/W2FueKQeFqjqHso5/Tdd0ENGIkiE22Zn9d4Q5
         Ij84I8j5lSnYZQ9iLGj+rEEGo4ufJoUuAroCgB3oKjIl/O9XfBcrU3PJ9qShorj9Bwzt
         MPxN2Klml9XD7ndojdG5xITRJLa2wFHoorBhmw1wRin/DC1APCb7rIUXLiw2u0D6CCGd
         e5IlwuosmcgWRMe3qXuUL8QoUnFKtNps7LM5QT87nzcspORx/tptfjVJkKdVJQAOsdYc
         I6dw==
X-Forwarded-Encrypted: i=1; AJvYcCWj3jf46R+5PqhP5OhqNvoNIo5/6oMpPnmwus3kTtGPz5qn4JiMf0KCim4Iodwbdxv3AbvIjphrxkHzEa4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyy9KNrwnL6pq62mr6McGLuQDFThLnLF9W1dPqYm3dSEgo/QV70
	pB1Qq403+Xrn0I1w7Uddj0tDBQAp7ztHPs7hIqX4cZvyQ+pCU2k9varw
X-Gm-Gg: AZuq6aJH/0PjRSJlXwSoUUTVnwgMMqxWCOUjg0zzUW7UyN66qNxnM77SfiaC5Zjsl9G
	MG+VzMjxh4Iqeg3aBm7UL7ZImyxh0wGw8s4xUHfnA47FRO5F9VEYpS27sQVJkkFMnLMLmhEIylR
	/L0nMJQq8jAHfwiISYZOQULiA13/tt+D/aS1XLsvey2N7v4cJgDLnGLsECs+oyHo+QXRPUEuSvs
	HxdayznHdKBnHqgPTyL22YWgay1V0AkZ8u6HcBI7PQwmjsY97f0Bs9azatF6PuCgtP1lYl2oZRP
	doXtzaUjm9V57wV30MUKKcpU9ZZ9ba2m/tPi9vsox13UkNpMplhh0GcORSWI76Zm8v3ILF/rmOq
	aE5EvoTPjyUR0aQFwc2kD16ReaX4HX2ZISJzMFiH1bzYy/hcHZs/YwAxK+PwuIaEavi8NJ9VVfW
	WSLY/BldchfUvaRvDlZ3nYh2MnufrZNudYzaLHcdnJaQba2/gBx2AOW4l5pHUM1EqVAdqoYEGEh
	KQSM68DQbDQx12VYDg26mrnUYX9FGarpeNAxZ9vOHfj1iKKz8o=
X-Received: by 2002:a05:6830:270e:b0:7cf:d075:2674 with SMTP id 46e09a7af769-7d5062b100emr1737042a34.15.1771441895854;
        Wed, 18 Feb 2026 11:11:35 -0800 (PST)
Received: from localhost ([2601:7c0:c37c:4c00:e3a8:26f7:7e08:88e1])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d4a76e1e59sm18485986a34.17.2026.02.18.11.11.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Feb 2026 11:11:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 18 Feb 2026 13:11:18 -0600
Message-Id: <DGIBQKCDK1KA.1BU93405XZZ9R@gmail.com>
From: "Ethan Tidmore" <ethantidmore06@gmail.com>
To: "Ethan Tidmore" <ethantidmore06@gmail.com>, "K . Y . Srinivasan"
 <kys@microsoft.com>, "Haiyang Zhang" <haiyangz@microsoft.com>, "Wei Liu"
 <wei.liu@kernel.org>, "Dexuan Cui" <decui@microsoft.com>, "Long Li"
 <longli@microsoft.com>, "Saurabh Sengar" <ssengar@linux.microsoft.com>
Cc: "Thomas Gleixner" <tglx@kernel.org>, "Ingo Molnar" <mingo@redhat.com>,
 "Borislav Petkov" <bp@alien8.de>, "Dave Hansen"
 <dave.hansen@linux.intel.com>, "H . Peter Anvin" <hpa@zytor.com>, "Michael
 Kelley" <mhklinux@outlook.com>, <x86@kernel.org>,
 <linux-hyperv@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86/hyperv: Fix error pointer dereference
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260218190903.7874-1-ethantidmore06@gmail.com>
In-Reply-To: <20260218190903.7874-1-ethantidmore06@gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8901-lists,linux-hyperv=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,redhat.com,alien8.de,linux.intel.com,zytor.com,outlook.com,vger.kernel.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_TO(0.00)[gmail.com,microsoft.com,kernel.org,linux.microsoft.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ethantidmore06@gmail.com,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 115E8158F37
X-Rspamd-Action: no action

On Wed Feb 18, 2026 at 1:09 PM CST, Ethan Tidmore wrote:
> The function idle_thread_get() can return an error pointer and is not
> checked for it. Add check for error pointer.
>
> Detected by Smatch:
> arch/x86/hyperv/hv_vtl.c:126 hv_vtl_bringup_vcpu() error:
> 'idle' dereferencing possible ERR_PTR()
>
> Fixes: 2b4b90e053a29 ("x86/hyperv: Use per cpu initial stack for vtl cont=
ext")
> Signed-off-by: Ethan Tidmore <ethantidmore06@gmail.com>
> ---

Oops, forgot v2 header this is the v2.

Thanks,

ET

