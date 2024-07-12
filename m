Return-Path: <linux-hyperv+bounces-2559-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CD40292FB7E
	for <lists+linux-hyperv@lfdr.de>; Fri, 12 Jul 2024 15:34:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 660521F21E7A
	for <lists+linux-hyperv@lfdr.de>; Fri, 12 Jul 2024 13:34:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DCDC16F0F9;
	Fri, 12 Jul 2024 13:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NIpY/lPl"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5963AEAC7;
	Fri, 12 Jul 2024 13:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720791274; cv=none; b=LOCOD2Jg0vZGN8m9osac7jIW1AumC6GXBNdmuDVS+LJ4ct+xz2gZUsMWGXrNfaaGlrJ8sA/2uEYPn+Zz0bUX3WRW3qpAhdowMZqSDc49sYsd4+NyumtU0K2QUrqAOD/uuzvHnRmtmzCvdk/6Pqw6V+J+njMRy1pQto1albAHvTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720791274; c=relaxed/simple;
	bh=5l82faOt0Ftj9KB/8OhC//sWOYz4iWkq9/TcEQ4beHA=;
	h=Date:From:To:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=CPf+dap1iUATsZCM+VKjT3M66Wr105WRF74lmxTx5azW2WcOwidAK5d0qJdsb5heUxR9elcIEHioF0uIyiwYB+5rsiQWnYiAXcRJatz8l6QjDIKV7CFBwEEBDtjTWKwPvmWAV709ejG77+nHKlNebWyXzzdSwRAdb49YXCkhvKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NIpY/lPl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBED9C32782;
	Fri, 12 Jul 2024 13:34:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720791274;
	bh=5l82faOt0Ftj9KB/8OhC//sWOYz4iWkq9/TcEQ4beHA=;
	h=Date:From:To:Subject:In-Reply-To:References:From;
	b=NIpY/lPlSWZI3R+9H16iJmlQjohMYFbKAnN1ICZijVCIxlgCeDDozmphS3SENp6t9
	 NaJhKqPC2L8m/HhmUn3W6QwjFQd/BxayAj7rZgH6JmROTNvSjCqWErvxVjIADxA0Jj
	 LgbR9KZgDD9ky0QfIk3xvRcWppmfvG3dVyOk8VOviNIbK5nTvzjFYb7I8uWRBNSMRu
	 d3nU3c8KR4w4tG0Xzv7Pz8rfkjFWDVpKrAc2CF3WVWE56Xl+ySb8aCouJ2iNi1EcRY
	 0JGEMFMckUZ1xp20pBOl/IX9BbWxSmIcNIpXGqtp5j++B+0GSe+alM11vUY6Dxvl2r
	 WcfbiWV3jxNxw==
Date: Fri, 12 Jul 2024 06:34:33 -0700
From: Kees Cook <kees@kernel.org>
To: Jocelyn Falempe <jfalempe@redhat.com>, Michael Ellerman <mpe@ellerman.id.au>,
 Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 "K. Y. Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>, Miquel Raynal <miquel.raynal@bootlin.com>,
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>,
 Tony Luck <tony.luck@intel.com>,
 "Guilherme G. Piccoli" <gpiccoli@igalia.com>, Petr Mladek <pmladek@suse.com>,
 Steven Rostedt <rostedt@goodmis.org>,
 John Ogness <john.ogness@linutronix.de>,
 Sergey Senozhatsky <senozhatsky@chromium.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Jani Nikula <jani.nikula@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Kefeng Wang <wangkefeng.wang@huawei.com>,
 Thomas Gleixner <tglx@linutronix.de>, Uros Bizjak <ubizjak@gmail.com>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-hyperv@vger.kernel.org,
 linux-mtd@lists.infradead.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2] printk: Add a short description string to kmsg_dump()
User-Agent: K-9 Mail for Android
In-Reply-To: <2d886ba5-950b-4dff-81ea-8748d7d67c55@redhat.com>
References: <20240702122639.248110-1-jfalempe@redhat.com> <2d886ba5-950b-4dff-81ea-8748d7d67c55@redhat.com>
Message-ID: <277007E3-48FA-482C-9EE0-FA28F470D6C4@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On July 12, 2024 2:59:30 AM PDT, Jocelyn Falempe <jfalempe@redhat=2Ecom> w=
rote:
>Gentle ping, I need reviews from powerpc, usermod linux, mtd, pstore and =
hyperv, to be able to push it in the drm-misc tree=2E

Oops, I thought I'd Acked already!

Acked-by: Kees Cook <kees@kernel=2Eorg>

And, yeah, as mpe said, you're all good to take this via drm-misc=2E

Thanks!

-Kees


--=20
Kees Cook

