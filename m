Return-Path: <linux-hyperv+bounces-6307-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1890B0B1D6
	for <lists+linux-hyperv@lfdr.de>; Sat, 19 Jul 2025 22:47:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 896105616FF
	for <lists+linux-hyperv@lfdr.de>; Sat, 19 Jul 2025 20:47:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A38F2219A9E;
	Sat, 19 Jul 2025 20:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uGpgoMkq"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C8EB1E9905
	for <linux-hyperv@vger.kernel.org>; Sat, 19 Jul 2025 20:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752958071; cv=none; b=mlr9BF1Ivan3WXhyje8qIoSWIVc9wCw5wHFLaJH+9JSZVQrEpd0ZkxxeG0kZ6k+CxLJac83Rqi5AhZOVW6mOgUMOlQ5kV/NkDY+5+G5E2ohWghyi3MHUzPsTWf3Zfns1W1iQZ/1XlA0BPvbuN82cFIrCbCC3C3lnbk5GJcuD1Ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752958071; c=relaxed/simple;
	bh=ZqBSMniEcaFXChwYMzdUsMBPNlZ1Idmp4wPb7MOhB8Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lfNmqpIRZrAs3pdmtGPrhKFRWNh53fpJj7zX6+xHeEjNZps6KYV4bpnsGiWrcFmDhUnp6eMnejQPzhX4aRX+lhNED456iaNww/TjnzZNe3DOPfbRpczsxqHU157Y4Wp4eq2sobRaE6QZrAQXVaYu9SAMdcc5j47cXU/gKLkYME8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uGpgoMkq; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-313cde344d4so3274479a91.0
        for <linux-hyperv@vger.kernel.org>; Sat, 19 Jul 2025 13:47:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752958069; x=1753562869; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zX28BVJ93qamSCefMG+iWdnBnQuAtUdA3vDpxETj3g0=;
        b=uGpgoMkqFHFJsYvCYRYmb0J2FoMqIJH041sPllra/8oV+9xiib3ATfrr8d4bNty/UQ
         Q6w6DFHJOZmNYzJeLdknv5V3CNFtr9JwJSXRVyyqNV+3FZcyS/reByFitG1Adh1+SeKa
         jwf1DsLWNYrzZs5uAY9156URhYqjrjDxE8Py3Cp4qzw25h++C9kNv4oeDFV6k7MDnVJ3
         2ZwoRCBsjVnLjpnJvoZPsAOFfzUX3gEXxUQIUkwSfvWZXws2quSPNp5z57YpddKmX7FJ
         txoUigYN8QayDA84/+8aAQ5i3xgCj/w0aoIP2jrVybPChCW1oS5QhBZke3U+DNtF1Oen
         RHMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752958069; x=1753562869;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zX28BVJ93qamSCefMG+iWdnBnQuAtUdA3vDpxETj3g0=;
        b=X7n3Bb+sIuB73QVq3BATIfdh4uelhGFQPgaKQO8XL6XmXM+FrV6ut81weYPftaXqIR
         ULFqrknrO57JqjpVQZMYodd3VRxSn7gyjHOiWdGI4b8wk7MW4ZGgU9QEkNvWuPML9fsd
         /Y6PagR/40JxSCGOjEuuWKpxnQ+jH9vOa24AzxLncHa+vHYIiWetxg1vzF718yvOOjkQ
         np6LE7mBgVx/IzfScJPNsRIgDxgrdHbvq8CmaIxMVz1ii5P6t0+EqazztsggFPkw/lnr
         R753BYZVMQ+K0GV/ykCVtLWcZrY6Uc0TWmFTzTIiDX11RoJ9vA7K2j7Lh0jjV72DID3I
         eNCA==
X-Forwarded-Encrypted: i=1; AJvYcCWpQ9I0H64kCPeszX+3gHK7ItrwpQxovekQR8tbqY36SV9Z/QxLMuWGQ9HCBg5AepBudoC5z7olR0FbL68=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3zGr4rVfY1Yrqi427dIm62fs40RNciK/MMzzwyocdUIFvnzsn
	mc4F806oVIC+88yvyz/e0WVafS8LOQAgBkmv738XAy4N6k+bOLoNd9Cs7GjBysZDSIHxvUptg5A
	STeYcfi+7F0ncjFUpssts1sY+HrjaYJFaVWkDVVBj
X-Gm-Gg: ASbGnctnxPgg8k8Q5ortB6n+OrbYUfONzZXm887uuoWASYNf4hGktt9ERE2dvxlTfEH
	CK/5uW39DhEtdNSMHrDPibd2GGVtz2g2XV0KKezQtsxBWB6b8kAcTqaasLfbLPr+8Z7lnb6jvGN
	uB19UUquwEdFBEDIYt1Pl0X7BCUltM2DAVFJ9EmgbBzCZrMnStKR0NL7ddXzlrI29cAVXf6gJdp
	N1ROmwexYuv/7SLPgvMeDgsieL8KmQYDS4BeBBPRz/bzr6YnWM=
X-Google-Smtp-Source: AGHT+IFsBJFrAVwoybcbClhbtkk6+q8fn0XpsL29CyxbYcZsn01RsMz0QJdas5oeFENVsTV7mWK0xrlHVrkZaylEWb4=
X-Received: by 2002:a17:90b:3f0c:b0:311:e8cc:4248 with SMTP id
 98e67ed59e1d1-31c9f44e087mr26700843a91.33.1752958069394; Sat, 19 Jul 2025
 13:47:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1752870014-28909-1-git-send-email-haiyangz@linux.microsoft.com> <20250718163723.4390bd7d@kernel.org>
In-Reply-To: <20250718163723.4390bd7d@kernel.org>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Sat, 19 Jul 2025 13:47:37 -0700
X-Gm-Features: Ac12FXy6EAOOfaaxCqmoRw0ddlTwqZX2GFu92iR5XeK54Otp2RZbW_v44V-SJDg
Message-ID: <CAAVpQUC_sH2UDdf0e5c=iPFU5EcaB7YeN=__2j6w_h6_pe8m_g@mail.gmail.com>
Subject: Re: [PATCH net] net: core: Fix the loop in default_device_exit_net()
To: Jakub Kicinski <kuba@kernel.org>
Cc: Haiyang Zhang <haiyangz@linux.microsoft.com>, linux-hyperv@vger.kernel.org, 
	netdev@vger.kernel.org, haiyangz@microsoft.com, kys@microsoft.com, 
	wei.liu@kernel.org, edumazet@google.com, pabeni@redhat.com, horms@kernel.org, 
	davem@davemloft.net, sdf@fomichev.me, ahmed.zaki@intel.com, 
	aleksander.lobakin@intel.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 18, 2025 at 4:37=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Fri, 18 Jul 2025 13:20:14 -0700 Haiyang Zhang wrote:
> > The loop in default_device_exit_net() won't be able to properly detect =
the
> > head then stop, and will hit NULL pointer, when a driver, like hv_netvs=
c,
> > automatically moves the slave device together with the master device.
> >
> > To fix this, add a helper function to return the first migratable netde=
v
> > correctly, no matter one or two devices were removed from this net's li=
st
> > in the last iteration.
>
> FTR I think that what the driver is trying to do is way too hacky, and
> it should be fixed instead. But I defer to Kuniyuki for the final word,
> maybe this change is useful for other reasons..

I agree that it should be fixed on the driver side.  I don't
think of a good reason for the change.

