Return-Path: <linux-hyperv+bounces-8235-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D140D15C4D
	for <lists+linux-hyperv@lfdr.de>; Tue, 13 Jan 2026 00:19:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3D2433016EDA
	for <lists+linux-hyperv@lfdr.de>; Mon, 12 Jan 2026 23:19:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40A131FDE31;
	Mon, 12 Jan 2026 23:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OHTJv0Ef"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE8C319992C
	for <linux-hyperv@vger.kernel.org>; Mon, 12 Jan 2026 23:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768259968; cv=none; b=OVCqc7X/XFEMK0xo3Wi0BgabyBYEctJQNR6dbLMgV6Ver8oNVuclRI8Em31AUKlcL4seT5MeoCH5JAriBX8ofWkl+97+PpIre9USsD+s6E3MM5cN7wQAraKp/2askbTIkccDiI1FIYts6M1z7TI6+B8Syk+Yl8cMQfRw7yvRH1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768259968; c=relaxed/simple;
	bh=D/QOV+PvgeGDhnZ/ix6Fp2phNTxa9gFGlVxWZXZmAqE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J7ZWHLIXTHgOLiLXXYL4KzTmCAWkvWDXvzEGXFdnGMuMid6tBjAdgK1lsGm3qwRRcv1ZkyGZt5FawxIZjHQV+tC4v7c08pCloMiKxEA3Xpd4PLPPNiIo+ESJwkOUg345ICUgD1xaaFgIdWfzLiAmT7gfDQccmoGDiUGcjj7hnDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OHTJv0Ef; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-88a35a00502so65925876d6.0
        for <linux-hyperv@vger.kernel.org>; Mon, 12 Jan 2026 15:19:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768259966; x=1768864766; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VrgEBLHMQ7w7z7OSk0+LmFxB5np8c3y6da/CYllo/d4=;
        b=OHTJv0EfjdNx6Z3Vl9dWL+2LEBe6Nmrp4V88b5vaaAj++P6ge7gp1rGoIIKW2rGY0N
         +8IG1OyWQ5hf8S5dMlLxsf513maTNgvBuZ5ZRsfdRleEzFUImDz+6I4gEJ+JgLILeRYl
         ctNZNgLN4/u/fqJw6EWgTbkCtzxbklxhidPwRdy5t4V3rUcffTeMEo2bW0WdDBoCa1jf
         U3B1Whsjl2YmxKaObqQ14r4i5GJj9s4qMt+8B5dqqAyvg2+iGdgzq1x/ncwKFzxHsZvM
         AlrxCl3DjLAq9qTFeYxF34qYsbvqqPlIj4RJoTLIkCyLSmQIqA3HsnjTtMX2u4rjWQJq
         Is2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768259966; x=1768864766;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VrgEBLHMQ7w7z7OSk0+LmFxB5np8c3y6da/CYllo/d4=;
        b=LzLDHGnzYl9L1lsVqZEH1okEVm2qqTJGO82+e35mDBx3zfdmW9HLAq35b+ovhYJx1m
         lIFlM2gv84RroqRBuJCXE33SeU+ND0Zx9lI7LfFrdfxJJIrHG5y0VN29ugdXVRJKNo7j
         5H0+A8JXb5xa8AKSnfzuhowM10vZP+q9Y2/0s5DNYRZj+0gzzhNIS9Vi78w2V0I3m8TV
         Qg4ZCdEXs5GBIoznO37VHpzTusgb8DABmODXTxyDtoJU6Jf655Oych+Wg/+aDOofTHwd
         ti0zwNFzXUcElgexLctRMkmRfaIXrXndqegNlWH27Jd3ooIXG9gQISoLfDfCaOKorgUj
         03IA==
X-Forwarded-Encrypted: i=1; AJvYcCW3+6bEFeshZyxABvjs/gcfeYAyC/k6aNdAjbC4OuftduPFbsLaAnqS+gigq7Z7nugmL8OTU1ypgyX5x14=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTpZlmnVljXUr861ogHjE3MHLyjq6sTYEEcT08fFquX97SXpxu
	fzREX7PL67/YyxMi92tpsSWuobw5wV8zKiNELLCLNSNbPclcBd3R2Mi/sc6I3w==
X-Gm-Gg: AY/fxX6EfyqAhl2azQRJcOk4sz9V51WjFL0box7METjy4g2PYprDr+8GOGMVugbxhF+
	wl1fqj2z7cPRRiPR06z4fNAnEOwzQBxq6zh0vs0CEdq3NFzbchayPC0evtYg9yG5mZQmWlXa21+
	qno5IcWVqk1gZ6kwrreQPuyKygIRE3bG/OGO/uAI+z4XJqLfur7pCO4umCjfZ7E5pPUkyW7m7Oj
	GIfLUOt4GKYRO/EbAbwidzHvTVHm5eysd2VS5e+rVhQxjMqcxOyIre3qnzqbnRS9QjyGe/2SRUj
	nENsdrgrbFMuWQAOwXLwpj02yo/C1YNA8t57/cnhsuHGMFIIo8I1Jx3GqYif1n773O3op2qUEPo
	snk/XDjo1KcCZqvIdfkbWLTCRTafck1e3XW/mxakcCPX9uyOMdyAgS4rcbtD9tvxBj+95XmEH3p
	Pb8P3KD4hXq8zw9mhTVImW7wTCrdSx6P3RZg==
X-Google-Smtp-Source: AGHT+IEEIChW46EWJZZzmGq0dv1aKbX23y4OJcSbpVgI4A7CpdyG+MDzyxvMqujhAfbDeFoADMp1dQ==
X-Received: by 2002:a53:e303:0:b0:63f:a727:8403 with SMTP id 956f58d0204a3-64716bd78d9mr12404043d50.38.1768254541320;
        Mon, 12 Jan 2026 13:49:01 -0800 (PST)
Received: from devvm11784.nha0.facebook.com ([2a03:2880:25ff:8::])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6470d7f7c04sm8530959d50.2.2026.01.12.13.49.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 13:49:00 -0800 (PST)
Date: Mon, 12 Jan 2026 13:48:58 -0800
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Bryan Tan <bryan-bt.tan@broadcom.com>,
	Vishnu Dasa <vishnu.dasa@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Shuah Khan <shuah@kernel.org>, Long Li <longli@microsoft.com>,
	linux-kernel@vger.kernel.org, virtualization@lists.linux.dev,
	netdev@vger.kernel.org, kvm@vger.kernel.org,
	linux-hyperv@vger.kernel.org, linux-kselftest@vger.kernel.org,
	berrange@redhat.com, Sargun Dhillon <sargun@sargun.me>,
	Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH RFC net-next v13 00/13] vsock: add namespace support to
 vhost-vsock and loopback
Message-ID: <aWVsSq7lORhM+prM@devvm11784.nha0.facebook.com>
References: <20251223-vsock-vmtest-v13-0-9d6db8e7c80b@meta.com>
 <aWGZILlNWzIbRNuO@devvm11784.nha0.facebook.com>
 <20260110191107-mutt-send-email-mst@kernel.org>
 <aWUnqbDlBmjfnC_Q@sgarzare-redhat>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aWUnqbDlBmjfnC_Q@sgarzare-redhat>

On Mon, Jan 12, 2026 at 06:26:18PM +0100, Stefano Garzarella wrote:
> On Sat, Jan 10, 2026 at 07:12:07PM -0500, Michael S. Tsirkin wrote:
> > On Fri, Jan 09, 2026 at 04:11:12PM -0800, Bobby Eshleman wrote:
> > > On Tue, Dec 23, 2025 at 04:28:34PM -0800, Bobby Eshleman wrote:
> > > > This series adds namespace support to vhost-vsock and loopback. It does
> > > > not add namespaces to any of the other guest transports (virtio-vsock,
> > > > hyperv, or vmci).
> > > >
> > > > The current revision supports two modes: local and global. Local
> > > > mode is complete isolation of namespaces, while global mode is complete
> > > > sharing between namespaces of CIDs (the original behavior).
> > > >
> > > > The mode is set using the parent namespace's
> > > > /proc/sys/net/vsock/child_ns_mode and inherited when a new namespace is
> > > > created. The mode of the current namespace can be queried by reading
> > > > /proc/sys/net/vsock/ns_mode. The mode can not change after the namespace
> > > > has been created.
> > > >
> > > > Modes are per-netns. This allows a system to configure namespaces
> > > > independently (some may share CIDs, others are completely isolated).
> > > > This also supports future possible mixed use cases, where there may be
> > > > namespaces in global mode spinning up VMs while there are mixed mode
> > > > namespaces that provide services to the VMs, but are not allowed to
> > > > allocate from the global CID pool (this mode is not implemented in this
> > > > series).
> > > 
> > > Stefano, would like me to resend this without the RFC tag, or should I
> > > just leave as is for review? I don't have any planned changes at the
> > > moment.
> > > 
> > > Best,
> > > Bobby
> > 
> > i couldn't apply it on top of net-next so pls do.
> > 
> 
> Yeah, some difficulties to apply also here.
> I tried `base-commit: 962ac5ca99a5c3e7469215bf47572440402dfd59` as mentioned
> in the cover, but didn't apply. After several tries I successfully applied
> on top of commit bc69ed975203 ("Merge tag 'for_linus' of
> git://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost")
> 
> So, I agree, better to resend and you can remove RFC.
> 
> BTW I'll do my best to start to review tomorrow!
> 
> Thanks,
> Stefano
> 

Sounds good to me. Sorry about that, I must have done something weird
with b4 to pin the base commit because it has been
962ac5ca99a5c3e7469215bf47572440402dfd59 for the last several revisions.

Looks like my local of this is actually based on:

7b8e9264f55a ("Merge tag 'net-6.19-rc2' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net")

I'll re-apply to head and resend today!

While I'm at it I will try to address Michael's feedback and bump a
version.

Best,
Bobby

