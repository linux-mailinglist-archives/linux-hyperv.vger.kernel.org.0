Return-Path: <linux-hyperv+bounces-9321-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MJgPABV4sWk2vgIAu9opvQ
	(envelope-from <linux-hyperv+bounces-9321-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 11 Mar 2026 15:11:33 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 535E926522B
	for <lists+linux-hyperv@lfdr.de>; Wed, 11 Mar 2026 15:11:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 15306301C3F6
	for <lists+linux-hyperv@lfdr.de>; Wed, 11 Mar 2026 14:11:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0F6531E85D;
	Wed, 11 Mar 2026 14:11:30 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75A7535F614
	for <linux-hyperv@vger.kernel.org>; Wed, 11 Mar 2026 14:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773238290; cv=none; b=VRwbm72W1JqzNovpPO00aR/OmBrjJKDItvziuSwujcNvw5fQPKzH91ICJySG6x0X/f/bitBMv/NmzHOYyuTS5RD3TmICF9mcz03Fce5VPGkIvcIV8eJsxr2JqLVxKfAXMmBtVBYK+UmuILLaHzimUqP46DGqCywBBolp2v439o4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773238290; c=relaxed/simple;
	bh=POUJjzeRhBIXfPGojdZfC417KH92loTKx1KmDpRcfoc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JLxK5/tRw/jHjWZIbR6SzjTBgcvYZL5bXQe33IJoKfWYAjZsFJeCJm2suth3VE8msKl8qPhqKqxJZ1b5SRxu4zrspc7SfsLUZwKilqsKPa7GJULyG1rz2S03yVlJDIILLSxTlJ6on0gOeUvN3z63km8BE+xWuW6zN/lFkiM18gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-66325f30570so980547a12.1
        for <linux-hyperv@vger.kernel.org>; Wed, 11 Mar 2026 07:11:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773238288; x=1773843088;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wIz9Fr5w5J45ZN4rxwvT/0kjXMGfLP1VpB2aKPOax7k=;
        b=sl/shPBPEsZ8+JQ1/ZXEhRGxZEu2rAP4WfT8k2GMxhIn98JAv6djUA/v64LSbVmlZp
         2nkLJrwUGCw1rBCVkvfGgOZgeOv5IlQa/axwV1dDyRdc1NwSiZVi+/H/+FAL32WZj7eH
         bh0qTxV6H4nNgFdus1oV8tBN5PdryXbFYMiseZPfVxATWZgxvZaeufBm3nncuhgVIpet
         vhLAk9igM7xdZOhcXiEfAe67phpkpCjRUpN9ypMs1ly3dJJvuJql2u9JzWEaImGHPG/F
         sX57bfAB2mZ8yuuRnOJuBEcJFNn7GEOzkBUusgR+o1ppjU7oVNKxSSBP06+je1PEzhok
         wkgw==
X-Forwarded-Encrypted: i=1; AJvYcCUY0+MEjGZspFtouzJC+FtusKh/Mx9h/huUKvNDkKADSpde1ghwpVOVerPnwk3LxdI2+LxhQ1z9rE+MTgg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQ6G2xWJ+E88BFqd45pXxcn8w1YVEFYakoaWJ7PU58HX7YpapV
	ueBvVY2tzQdrCkE6riMiWMceSMSe/V6ElSmpP94kjTssncqjPCxcx38P+JKSKg+ijC/L8g==
X-Gm-Gg: ATEYQzxWiB6MlNY8fd0hPB/yJ0cloOtNbD8eAUB3MXiKb/QFDdcmvEPYM8qpKCCmKUF
	2FaP44nAWrUU7dTTkWRSk1I/jDJK3YXAc69pn9DLqXbRke0/VVATJU/c/1HBjY8ZSprhjoX37Hq
	3gx5fuaGwaxwxjaln3yErbsWa/XO4qF/mTIaZAJmwyjq8geCsPsgtvMJoBvc2oSJhGrql4o/d4T
	yHc+d69ZXFxmWzlgE0qmSUfFoQJqR6tIjoeWkpDPcb3jYbTot2XKbyrp4W1rU2j0gbO9AjaKeUJ
	9xNxF2BPRYKuneYbL0+bIB/Df391SUGmLmow2GDPmBd/YozIkzLYB7ZAnSq/stfeSYrkMuqLaQz
	7D3/k7IxQVfYKV0fPfwthazek9dmTr8ZwBdknCfnDt+KIBvEOcd0oklDBAvfX9k3f7Ngtq9/9It
	fkEbBfIZ8G6gDBUGj82UWGqSGgMNrJfl02oRxbRpUpWxIKIvmzTf7BcDJA8XxJ
X-Received: by 2002:a05:6402:35c7:b0:662:e5a6:f090 with SMTP id 4fb4d7f45d1cf-66317fb3cdfmr1614999a12.15.1773238287479;
        Wed, 11 Mar 2026 07:11:27 -0700 (PDT)
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com. [209.85.208.51])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6631448605fsm558621a12.12.2026.03.11.07.11.26
        for <linux-hyperv@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Mar 2026 07:11:27 -0700 (PDT)
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-66325f30570so980474a12.1
        for <linux-hyperv@vger.kernel.org>; Wed, 11 Mar 2026 07:11:26 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVFHJRLQ9q9HglLhwnbmo4xQABTvzw82yofG+LxcPybg1k+Ftfa6+wlZM53yK89lE8GUA9QtAlAw5a/8hM=@vger.kernel.org
X-Received: by 2002:a17:907:6d16:b0:b88:4f25:81da with SMTP id
 a640c23a62f3a-b97113ff0b9mr462021166b.0.1773237981235; Wed, 11 Mar 2026
 07:06:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260310-b4-is_err_or_null-v1-0-bd63b656022d@avm.de>
 <20260310-b4-is_err_or_null-v1-15-bd63b656022d@avm.de> <20260310100750.303af303@gandalf.local.home>
 <20260311141332.b611237d36b61b2409e66cb3@kernel.org> <20260311100332.6a2ce4b1@gandalf.local.home>
In-Reply-To: <20260311100332.6a2ce4b1@gandalf.local.home>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 11 Mar 2026 15:06:07 +0100
X-Gmail-Original-Message-ID: <CAMuHMdX4kRGLaKMzPuhS1Pmxh609eiqQW-cAS_jWBBbt-vE6SA@mail.gmail.com>
X-Gm-Features: AaiRm53WEGMMLW4z34e7P-lM1qFvsCJGZ_o4JNL5NPWbhJPKmcqz6k9bJcyL--8
Message-ID: <CAMuHMdX4kRGLaKMzPuhS1Pmxh609eiqQW-cAS_jWBBbt-vE6SA@mail.gmail.com>
Subject: Re: [PATCH 15/61] trace: Prefer IS_ERR_OR_NULL over manual NULL check
To: Steven Rostedt <rostedt@goodmis.org>
Cc: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, Philipp Hahn <phahn-oss@avm.de>, amd-gfx@lists.freedesktop.org, 
	apparmor@lists.ubuntu.com, bpf@vger.kernel.org, ceph-devel@vger.kernel.org, 
	cocci@inria.fr, dm-devel@lists.linux.dev, dri-devel@lists.freedesktop.org, 
	gfs2@lists.linux.dev, intel-gfx@lists.freedesktop.org, 
	intel-wired-lan@lists.osuosl.org, iommu@lists.linux.dev, kvm@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-block@vger.kernel.org, 
	linux-bluetooth@vger.kernel.org, linux-btrfs@vger.kernel.org, 
	linux-cifs@vger.kernel.org, linux-clk@vger.kernel.org, 
	linux-erofs@lists.ozlabs.org, linux-ext4@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-hyperv@vger.kernel.org, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org, 
	linux-media@vger.kernel.org, linux-mips@vger.kernel.org, linux-mm@kvack.org, 
	linux-modules@vger.kernel.org, linux-mtd@lists.infradead.org, 
	linux-nfs@vger.kernel.org, linux-omap@vger.kernel.org, 
	linux-phy@lists.infradead.org, linux-pm@vger.kernel.org, 
	linux-rockchip@lists.infradead.org, linux-s390@vger.kernel.org, 
	linux-scsi@vger.kernel.org, linux-sctp@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-sh@vger.kernel.org, 
	linux-sound@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-trace-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org, ntfs3@lists.linux.dev, 
	samba-technical@lists.samba.org, sched-ext@lists.linux.dev, 
	target-devel@vger.kernel.org, tipc-discussion@lists.sourceforge.net, 
	v9fs@lists.linux.dev, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 535E926522B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9321-lists,linux-hyperv=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[linux-m68k.org];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[geert@linux-m68k.org,linux-hyperv@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_GT_50(0.00)[57];
	R_DKIM_NA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[goodmis.org:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mail.gmail.com:mid,linux-m68k.org:email]
X-Rspamd-Action: no action

Hi Steven,

On Wed, 11 Mar 2026 at 15:03, Steven Rostedt <rostedt@goodmis.org> wrote:
> On Wed, 11 Mar 2026 14:13:32 +0900
> Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:
>
> > Hmm, now IS_ERR_OR_NULL() is an inline function, so it is safe.
> > But if you want to use IS_ERR_OR_NULL() here, it will be better something like
> >
> > node = rhashtable_walk_next(&iter);
> > while (!IS_ERR_OR_NULL(node)) {
> >       fprobe_remove_node_in_module(mod, node, &alist);
> >       node = rhashtable_walk_next(&iter);
> > }
>
> But now you need to have a duplicate code in order to acquire "node"
>
> I think the patch just makes the code worse.

Obviously we need a new for_each_*() helper hiding all the gory internals?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

