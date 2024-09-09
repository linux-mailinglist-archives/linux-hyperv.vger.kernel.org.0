Return-Path: <linux-hyperv+bounces-2992-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AB65971F40
	for <lists+linux-hyperv@lfdr.de>; Mon,  9 Sep 2024 18:31:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 400B01C23878
	for <lists+linux-hyperv@lfdr.de>; Mon,  9 Sep 2024 16:31:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ECBA1537C8;
	Mon,  9 Sep 2024 16:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="POeC5Tqy"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BF69154448
	for <linux-hyperv@vger.kernel.org>; Mon,  9 Sep 2024 16:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725899449; cv=none; b=sOtZZmhrMSffpljtrBDBFjJAYWIUad7cP4GvWRY2DIJy5C06AeoRXAXOaL+Qy117KlzwWbj8fYahTAAFfxbuq11fU2gqEvOuZMcBo/LEPOukLREYcyRaguIRsCK9BvRJ9dEqE11xgBLEm5OoLarwJB41bVapjKKTU5VT2PIv7tI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725899449; c=relaxed/simple;
	bh=qmZF5q/z+/4Sbg1D0/lBcy+O6A5OX/sZPTlOzUWN6TI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xhpr5GONMldXZMH7eSnbv7OKfXBWAspD8JTRHsTk2g57CmPzjJcAn+XBErep0L+UxnjmVUorMuyxwwpFeAXmqPcJXuJrjILx4un3tLWyS8uB1rYr3HcGUIwnMr0TeF/u1ZvCv+XAAJOHZgiqjwvQe8fIdjJNJf/AGApvjniKw4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=POeC5Tqy; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-6d44b6e1aebso43162257b3.2
        for <linux-hyperv@vger.kernel.org>; Mon, 09 Sep 2024 09:30:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1725899446; x=1726504246; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=org5XcN0eyY0R87PrlIItXgTSlaL8UTedTonoT8pA7Y=;
        b=POeC5Tqye6BxuaAO/IfO1W7tIBnBTw20hMdVgkMBfXwFRCM7VUg5C3g81BstMeNoQ+
         gl/rIn5zHq22dNCQWSdI7SC/856e3z0dmqomXFqAhsFq13wscFA8Jtm71U+WOR3ys684
         Wa9DKcCzSl4Z527+7t1rm5s6OEquBYEXP7BzM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725899446; x=1726504246;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=org5XcN0eyY0R87PrlIItXgTSlaL8UTedTonoT8pA7Y=;
        b=UeK+ARhGSY/XZ8PoO/fPI+bYxyIdGW5CG+9RB9b5UK8ynPrORRfJJzmCxN7mYwb3Vl
         3/I00njoixQI4/Z1AqgOFqblbj82fUOSU8QMwslab8s/Mx+u8nOPSFLnZCq5MrJrV7JX
         Pm5Y4hbwA/TFwUuWCKMHoMT+f2d4sX2hMbsmbJhBuU3lr1vIqKQczjR65ASW7dsUBMhK
         ZHjdI1+NSR3BDbRSjXei6AVr+zUPCmYUYm+V1BFyt4SgB7tK6opfSTvspDT7SbWowqSX
         HrRHt25/xW92ssnb5PhZ/q57LLzT947zvMfjorELc2FJYdf5kcslMn8+oYEtZ3FNHLMF
         q+PA==
X-Gm-Message-State: AOJu0YybO+9H+7YizDbQKJMXdjoAF1heFD6Wf++8+dndkxX11b3wcmQO
	T3qiCjP2YaGSdqUWlwHDjA2jNNx/5wkdft6NaSfvaB61lHGPMxJvzwwaBRpuaiYZbu0sSoMdVxz
	n56vbpr9p8NsHzyW4VUjij00qlvpqe2dhKvoSFVCZL+1KpTw83CPvdA==
X-Google-Smtp-Source: AGHT+IF05GbHB10BrmKPWWe8xIouRE7yNSr7tCDGt1LvUFQXXtwAm3WxfWHAkZQ1nOXDloksP/MPxHJoVc2qW5CQA4w=
X-Received: by 2002:a05:690c:82:b0:6d3:b708:7b19 with SMTP id
 00721157ae682-6db44f2f0ccmr133431697b3.27.1725899446235; Mon, 09 Sep 2024
 09:30:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Zt5JlnHqc6ubskR3@liuwe-devbox-debian-v2>
In-Reply-To: <Zt5JlnHqc6ubskR3@liuwe-devbox-debian-v2>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 9 Sep 2024 09:30:34 -0700
Message-ID: <CAADWXX_POGFzkwntvd8qcikOsNb2Ee7cHgaeycqXUPuZkicQJQ@mail.gmail.com>
Subject: Re: [GIT PULL] Hyper-V fixes for v6.11-rc8
To: Wei Liu <wei.liu@kernel.org>
Cc: Linux on Hyper-V List <linux-hyperv@vger.kernel.org>, kys@microsoft.com, haiyangz@microsoft.com, 
	decui@microsoft.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 8, 2024 at 6:04=E2=80=AFPM Wei Liu <wei.liu@kernel.org> wrote:
>
> hyperv-fixes for 6.11-rc8
>  - [...]

Wei, this was marked as spam for me, and the reason is that DMARC fails.

And the reason  for *that* is that the kernel.org mail server is now
set up to be stricter: if you use a kernel.org "From:" address, it the
DKIM signing has to be from kernel.org too. IOW, kernel.org has to be
the SMTP server you use.

And it looks like you just use gmail directly to send the email, and
so your DKIM ends up being from google ("d=3D1e100.net"), not from
kernel.org.

So you need to change how you send email:

  https://korg.docs.kernel.org/mail.html

because while I _do_ check my spam box, and while I caught this one,
I'm not actually all that careful and only scan my spam very quickly
and I _will_ lose email marked as spam.

                Linus

